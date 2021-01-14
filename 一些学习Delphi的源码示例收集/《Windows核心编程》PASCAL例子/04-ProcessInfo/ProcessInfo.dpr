program ProcessInfo;

{$R 'ProcessInfo.res' 'ProcessInfo.rc'}

uses
  Windows, Messages, TlHelp32, Toolhelp in 'Toolhelp.pas';

const
  // ��ԴID
  IDD_PROCESSINFO = 101;
  IDI_PROCESSINFO = 103;

  // �ؼ�ID
  IDC_PROCESSMODULELIST = 1000;
  IDC_RESULTS           = 1011;
  IDC_MODULEHELP        = 1014;

  // �˵�ID
  ID_PROCESSES = 40001;
  ID_MODULES   = 40002;
  ID_VMMAP     = 40006;

  // ��λ�ַ�����ָ���ַ�
function SearchChar(const S: PChar; C: Char; Back: BOOL): PChar;
begin
  if (Back = TRUE) then
  begin // ��ǰ�������
    Result := S;
    while (Result^ <> #0) and (Result^ <> C) do Inc(Result);
  end else
  begin // �Ӻ���ǰ����
    Result := SearchChar(S, #0, TRUE);
    if (Result <> S) then
      repeat Dec(Result) until (Result = S) or (Result^ = C);
  end;

  if (Result^ <> C) then Result := nil;
end;

  // �򵥰�װ��ʽ���API
function wvsprintf(Output: PChar; Format: PChar; Arg_List: array of Integer): Integer;
begin
  Result := Windows.wvsprintf(Output, Format, @Arg_List[Low(Arg_List)]);
end;

  // ��Edit�ؼ�����ַ���
procedure AddText(hWnd: HWND; pszFormat: PChar; Arg_List: array of Integer);
var
  sz: array[0..20*1024] of Char;
begin
  GetWindowText(hWnd, sz, SizeOf(sz));
  wvsprintf(SearchChar(sz, #0, TRUE), pszFormat, Arg_List);
  SetWindowText(hWnd, sz);
end;

  // ˢ�½����б���ComboBox
procedure Dlg_PopulateProcessList(hWnd: HWND);
var
  hWndList: LongWord; // ComboBox���
  thProcesses: TToolhelp; // ����ö�ٶ���
  pe: TProcessEntry32; // ����ö�ٽṹ
  fOk: BOOL;
  pszExeFile: PChar;
  sz: array[0..1024] of Char;
  n: Integer;
begin
  pe.dwSize := SizeOf(TProcessEntry32);

  hWndList := GetDlgItem(hWnd, IDC_PROCESSMODULELIST);
  SendMessage(hWndList, WM_SETREDRAW, 0, 0);
  SendMessage(hWndList, CB_RESETCONTENT, 0, 0);

  // ö�ٽ���
  thProcesses := TToolhelp.Create(TH32CS_SNAPPROCESS);
  fOk := thProcesses.ProcessFirst(@pe);
  while fOK do
  begin
    pszExeFile := SearchChar(pe.szExeFile, '\', FALSE);
    if (pszExeFile = nil) then pszExeFile := pe.szExeFile else Inc(pszExeFile);

    // ��ӽ�����(����·��)��ID
    wvsprintf(sz, '%s      (0x%08X)', [Integer(pszExeFile), pe.th32ProcessID]);
    n := SendMessage(hWndList, CB_ADDSTRING, 0, Integer(@sz[0]));

    // �������ID��ComboBox����
    SendMessage(hWndList, CB_SETITEMDATA, n, pe.th32ProcessID);

    // ��һ����
    fOk := thProcesses.ProcessNext(@pe);
  end;
  thProcesses.Free;

  // ComboBoxѡ��'�ı�Ϊ'��һ��
  SendMessage(hWndList, CB_SETCURSEL, 0, 0);
  SendMessage(hWnd, WM_COMMAND, MakeWParam(IDC_PROCESSMODULELIST, CBN_SELCHANGE), hWndList);

  SendMessage(hWndList, WM_SETREDRAW, 1, 0);
  InvalidateRect(hWndList, nil, FALSE);
end;

  // ˢ��ģ���б���ComboBox
procedure Dlg_PopulateModuleList(hWnd: HWND);
var
  hWndModuleHelp, hWndList: LongWord; // HWND
  thProcesses, thModules: TToolhelp;
  pe: TProcessEntry32;
  me: TModuleEntry32;
  fpOk, fmOk: BOOL;
  n, j, nNumModules, nIndex: Integer;
  sz: array[0..1024] of Char;
begin
  pe.dwSize := SizeOf(TProcessEntry32);
  me.dwSize := SizeOf(TModuleEntry32);

  // ����ListBox����ģ���б�
  hWndModuleHelp := GetDlgItem(hWnd, IDC_MODULEHELP);
  SendMessage(hWndModuleHelp, LB_RESETCONTENT, 0, 0);

  // ö�ٽ���
  thProcesses := TToolhelp.Create(TH32CS_SNAPPROCESS);
  fpOk := thProcesses.ProcessFirst(@pe);
  while fpOk do
  begin
    // ö��ģ��
    thModules := TToolhelp.Create(TH32CS_SNAPMODULE, pe.th32ProcessID);
    fmOk := thModules.ModuleFirst(@me);
    while fmOk do
    begin
      // ��ģ���Ƿ��Ѵ�����ListBox, �����������
      n := SendMessage(hWndModuleHelp, LB_FINDSTRINGEXACT, -1, Integer(@me.szExePath[0]));
      if (n = LB_ERR) then
      begin
        SendMessage(hWndModuleHelp, LB_ADDSTRING, 0, Integer(@me.szExePath[0]));
      end;

      // ��һģ��
      fmOk := thModules.ModuleNext(@me);
    end;
    thModules.Free;

    // ��һ����
    fpOk := thProcesses.ProcessNext(@pe);
  end;
  thProcesses.Free;

  // ListBox -> ComboBox
  hWndList := GetDlgItem(hWnd, IDC_PROCESSMODULELIST);
  SendMessage(hWndList, WM_SETREDRAW, 0, 0);
  SendMessage(hWndList, CB_RESETCONTENT, 0, 0);
  nNumModules := SendMessage(hWndModuleHelp, LB_GETCOUNT, 0, 0);
  for j := 0 to nNumModules - 1 do
  begin
    // ListBox��j��(����·��)
    SendMessage(hWndModuleHelp, LB_GETTEXT, j, Integer(@sz[0]));

    // ���ģ������(����·��)
    nIndex := SendMessage(hWndList, CB_ADDSTRING, 0, Integer(SearchChar(sz, '\', FALSE)) + 1);

    // ����ģ���ListBox���
    SendMessage(hWndList, CB_SETITEMDATA, nIndex, j);
  end;

  // ComboBoxѡ��'�ı�Ϊ'��һ��
  SendMessage(hWndList, CB_SETCURSEL, 0, 0);
  SendMessage(hWnd, WM_COMMAND, MakeWParam(IDC_PROCESSMODULELIST, CBN_SELCHANGE), hWndList);

  SendMessage(hWndList, WM_SETREDRAW, 1, 0);
  InvalidateRect(hWndList, nil, FALSE);
end;

  // ȡ��ģ��Ĭ�ϻ���ַ
function GetModulePreferredBaseAddr(dwProcessId: DWORD; pvModuleRemote: Pointer): Pointer;
var
  idh: TImageDosHeader;
  inth: TImageNtHeaders;
begin
  Result := nil;

  // ��ȡԶ��ģ��Dosͷ
  Toolhelp32ReadProcessMemory(dwProcessId, pvModuleRemote, idh,
    SizeOf(TImageDosHeader), PDWORD(nil)^);

  // ���Dosͷ��־('MZ')
  if (idh.e_magic = IMAGE_DOS_SIGNATURE) then
  begin
    // ��ȡԶ��ģ��Ntͷ
    Inc(PByte(pvModuleRemote), idh._lfanew);
    Toolhelp32ReadProcessMemory(dwProcessId,
      pvModuleRemote, inth, SizeOf(TImageNtHeaders), PDWORD(nil)^);

    // ���Ntͷ��־('PE00')
    if (inth.Signature = IMAGE_NT_SIGNATURE) then
    begin
      Result := Pointer(inth.OptionalHeader.ImageBase);
    end;
  end;
end;

  // ��ʾָ��������Ϣ
procedure ShowProcessInfo(hWndEdit: HWND; dwProcessID: DWORD);
var
  th: TToolhelp;
  fOk: BOOL;
  pe: TProcessEntry32;
  me: TModuleEntry32;
  te: TThreadEntry32;
  pvPreferredBaseAddr: Pointer;
  nPriority: Integer;
begin
  pe.dwSize := SizeOf(TProcessEntry32);
  me.dwSize := SizeOf(TModuleEntry32);
  te.dwSize := SizeOf(TThreadEntry32);

  SetWindowText(hWndEdit, '');
  th := TToolhelp.Create(TH32CS_SNAPALL, dwProcessID);

  // ��ʾָ�����̻�����Ϣ
  fOk := th.ProcessFirst(@pe);
  while fOk do
  begin
    if (pe.th32ProcessID = dwProcessID) then
    begin
      AddText(hWndEdit, 'Filename: %s'#13#10, [Integer(@pe.szExeFile[0])]);
      AddText(hWndEdit, '   PID=%08X, ParentPID=%08X, PriorityClass=%d, Threads=%d, Heaps=%d'#13#10,
        [pe.th32ProcessID, pe.th32ParentProcessID, pe.pcPriClassBase, pe.cntThreads, th.HowManyHeaps()]);
      Break;
    end;

    fOk := th.ProcessNext(@pe);
  end;

  // ��ʾ��������ģ����Ϣ
  AddText(hWndEdit,
    #13#10'Modules Information:'#13#10'  Usage  %-8s(%-8s)  %8s  Module'#13#10,
    [Integer(PChar('BaseAddr')), Integer(PChar('ImagAddr')), Integer(PChar('Size'))]);
  fOk := th.ModuleFirst(@me);
  while fOk do
  begin
    // ���ô���
    if (me.ProccntUsage <> 65535) then
      AddText(hWndEdit, '  %5d', [me.ProccntUsage])
    else
      AddText(hWndEdit, '  Fixed', []);

    // ӳ���ַ
    pvPreferredBaseAddr := GetModulePreferredBaseAddr(pe.th32ProcessID, me.modBaseAddr);
    if (me.modBaseAddr = pvPreferredBaseAddr) then
      AddText(hWndEdit, '  %p %8s   %8u  %s'#13#10,
        [Integer(me.modBaseAddr), Integer(PChar('')), me.modBaseSize, Integer(@me.szExePath[0])])
    else
      AddText(hWndEdit, '  %p(%p)  %8u  %s'#13#10,
        [Integer(me.modBaseAddr), Integer(pvPreferredBaseAddr), me.modBaseSize, Integer(@me.szExePath)]);

    fOk := th.ModuleNext(@me);
  end;

  // ��ʾ���������߳���Ϣ
  AddText(hWndEdit, #13#10'Thread Information:'#13#10'      TID     Priority'#13#10, []);
  fOk := th.ThreadFirst(@te);
  while fOk do
  begin
    if (te.th32OwnerProcessID = dwProcessID) then
    begin
      nPriority := te.tpBasePri + te.tpDeltaPri;
      if (te.tpBasePri < 16) and (nPriority > 15) then nPriority := 15;
      if (te.tpBasePri > 15) and (nPriority > 31) then nPriority := 31;
      if (te.tpBasePri < 16) and (nPriority <  1) then nPriority :=  1;
      if (te.tpBasePri > 15) and (nPriority < 16) then nPriority := 16;

      AddText(hWndEdit, '   %08X       %2d'#13#10, [te.th32ThreadID, nPriority]);
    end;

    fOk := th.ThreadNext(@te);
  end;

  th.Free;
end;

  // ��ʾָ��ģ����Ϣ
procedure ShowModuleInfo(hWndEdit: HWND; pszModulePath: PChar);
var
  thProcesses, thModules: TToolhelp;
  pe: TProcessEntry32;
  me: TModuleEntry32;
  fpOk, fmOk: BOOL;
begin
  pe.dwSize := SizeOf(TProcessEntry32);
  me.dwSize := SizeOf(TModuleEntry32);

  SetWindowText(hWndEdit, '');
  AddText(hWndEdit, 'Pathname: %s'#13#10#13#10, [Integer(pszModulePath)]);
  AddText(hWndEdit, 'Process Information:'#13#10, []);
  AddText(hWndEdit, '     PID    BaseAddr  Process'#13#10, []);

  // �г�����ʹ�ô�ģ��Ľ���
  thProcesses := TToolhelp.Create(TH32CS_SNAPPROCESS);
  fpOk := thProcesses.ProcessFirst(@pe);
  while fpOk do
  begin
    thModules := TToolhelp.Create(TH32CS_SNAPMODULE, pe.th32ProcessID);
    fmOk := thModules.ModuleFirst(@me);
    while fmOk do
    begin
      if (lstrcmpi(me.szExePath, pszModulePath) = 0) then
      begin
        AddText(hWndEdit, '  %08X  %p  %s'#13#10,
          [pe.th32ProcessID, Integer(me.modBaseAddr), Integer(@pe.szExeFile[0])]);
      end;

      fmOk := thModules.ModuleNext(@me);
    end;
    thModules.Free;

    fpOk := thProcesses.ProcessNext(@pe);
  end;
  thProcesses.Free;
end;

  // �Ի���WM_INITDIALOG��Ϣ����
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  // ���ô���ͼ��
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_PROCESSINFO)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_PROCESSINFO)));

  // ����ListBox(�˿ؼ���������ģ���б�)
  ShowWindow(GetDlgItem(hWnd, IDC_MODULEHELP), SW_HIDE);

  // ʹ�õȿ�����
  SendMessage(GetDlgItem(hWnd, IDC_RESULTS), WM_SETFONT, GetStockObject(ANSI_FIXED_FONT), 0);

  // ö�ٵ�ǰ����
  Dlg_PopulateProcessList(hWnd);

  // ����Ĭ�Ͻ���
  Result := TRUE;
end;

  // �Ի���WM_SIZE��Ϣ����
function Dlg_OnSize(hWnd: HWND; state: UINT; cx, cy: Integer): BOOL;
var
  Rc: TRect;
  n: Integer;
  hWndCtl: LongWord; // HWND
begin
  n := LOWORD(GetDialogBaseUnits());

  hWndCtl := GetDlgItem(hWnd, IDC_PROCESSMODULELIST);
  GetClientRect(hWndCtl, rc);
  SetWindowPos(hWndCtl, 0, n, n, cx - n - n, rc.bottom, SWP_NOZORDER);

  hWndCtl := GetDlgItem(hWnd, IDC_RESULTS);
  SetWindowPos(hWndCtl, 0, n, n + rc.bottom + n, cx - n - n, cy - (n + rc.bottom + n) - n, SWP_NOZORDER);

  Result := FALSE;
end;

  // �Ի���WM_COMMAND��Ϣ����
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
const
{$J+}
  s_fProcesses: BOOL = TRUE;
{$J-}
var
  dw: DWORD;
  szModulePath: array[0..1024] of Char;
  si: TStartupInfo;
  pi: TProcessInformation;
  szCmdLine: array[0..1024] of Char;
  hWndCB: LongWord; // HWND
  dwProcessId: DWORD;
  fOk: BOOL;
begin
  case (id) of
    IDCANCEL: // Ҫ��ر�
      begin
        EndDialog(hWnd, id);
      end;

    ID_PROCESSES: // ö�ٽ���(�˵�)
      begin
        s_fProcesses := TRUE;
        EnableMenuItem(GetMenu(hWnd), ID_VMMAP, MF_BYCOMMAND or MF_ENABLED);
        DrawMenuBar(hWnd);
        Dlg_PopulateProcessList(hWnd);
      end;

    ID_MODULES:   // ö��ģ��(�˵�)
      begin
        s_fProcesses := FALSE;
        EnableMenuItem(GetMenu(hWnd), ID_VMMAP, MF_BYCOMMAND or MF_GRAYED);
        DrawMenuBar(hWnd);
        Dlg_PopulateModuleList(hWnd);
      end;

    IDC_PROCESSMODULELIST: // ComboBox�ؼ�
      begin
        if (codeNotify = CBN_SELCHANGE) then // ѡ����Ŀ�ı�
        begin
          dw := SendMessage(hWndCtl, CB_GETCURSEL, 0, 0); // ��ǰѡ����Ŀ

          if (s_fProcesses) then
          begin
            dw := SendMessage(hWndCtl, CB_GETITEMDATA, dw, 0); // ����ID
            ShowProcessInfo(GetDlgItem(hWnd, IDC_RESULTS), dw);
          end else
          begin
            dw := SendMessage(hWndCtl, CB_GETITEMDATA, dw, 0); // ListBox���
            SendMessage(GetDlgItem(hWnd, IDC_MODULEHELP), LB_GETTEXT, dw, Integer(@szModulePath[0]));
            ShowModuleInfo(GetDlgItem(hWnd, IDC_RESULTS), szModulePath);
          end;
        end;
      end;

    ID_VMMAP: // ��������
      begin
        hWndCB := GetDlgItem(hWnd, IDC_PROCESSMODULELIST);
        dwProcessId := SendMessage(hWndCB, CB_GETITEMDATA, SendMessage(hWndCB, CB_GETCURSEL, 0, 0), 0);
        wvsprintf(szCmdLine, '..\14-VMMap\VMMap.exe %d', [dwProcessId]);

        si.cb := SizeOf(TStartupInfo);
        fOk := CreateProcess(nil, szCmdLine, nil, nil, FALSE, 0, nil, nil, si, pi);
                
        if (fOk) then
        begin
          CloseHandle(pi.hProcess);
          CloseHandle(pi.hThread);
        end else
        begin
          MessageBox(GetActiveWindow(), 'Failed to execute VMMAP.EXE.', 'ProcessInfo', 0);
        end;
      end;
  end;
end;

  // �Ի�����Ϣ����ص�
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  Result := FALSE;

  case (uMsg) of
    WM_INITDIALOG:
      begin
        Result := BOOL(SetWindowLong(hWnd,
          DWL_MSGRESULT, Longint(Dlg_OnInitDialog(hWnd, wParam, lParam))));
      end;

    WM_SIZE:
      begin
        Dlg_OnSize(hWnd, wParam, LOWORD(lParam), HIWORD(lParam));
      end;

    WM_COMMAND:
      begin
        Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));
      end;
  end;
end;

  // �������߳����
begin
  TToolhelp(nil).EnableDebugPrivilege(TRUE);
  DialogBox(HInstance, MakeIntResource(IDD_PROCESSINFO), 0, @Dlg_Proc);
  TToolhelp(nil).EnableDebugPrivilege(FALSE);
end.
