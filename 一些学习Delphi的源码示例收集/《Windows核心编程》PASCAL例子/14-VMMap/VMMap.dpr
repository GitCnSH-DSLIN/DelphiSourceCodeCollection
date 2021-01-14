program VMMap;

{$R 'VMMap.res' 'VMMap.rc'}

uses
  Windows, Messages, TlHelp32, PsAPI,
  VMQuery in 'VMQuery.pas', Toolhelp in '..\04-ProcessInfo\Toolhelp.pas';

const
  IDD_VMMAP   =   1;
  IDI_VMMAP   = 101;
  IDC_LISTBOX = 100;

const
  ID_REFRESH         = 40001;
  ID_EXPANDREGIONS   = 40002;
  ID_COPYTOCLIPBOARD = 40003;
  
const
  PAGE_WRITECOMBINE = $400;

var
  g_dwProcessId: DWORD = 0;
  g_fExpandRegions: BOOL = FALSE;
  g_Toolhelp: TToolhelp;

  // �򵥰�װAPI
function wvsprintf(const Output, Format: PChar; const Arg_List: array of Integer): Integer;
begin
  Result := Windows.wvsprintf(Output, Format, @Arg_List[Low(Arg_List)]);
end;

  // ��λ�ַ���β
function SeachEnd(const S: PChar): PChar;
begin
  Result := S;
  while (Result^ <> #0) do Inc(Result);
end;

  // �ַ���ת����
function StrToInt(const S: string): Integer;
var
  P: PByte;
begin
  Result := 0;
  P := @S[1];
  
  while (P^ <> $00) do
  begin
    if (P^ > $39) or (P^ < $30) then
    begin
      Result := 0;
      Exit;
    end else
    begin
      Result := Result * 10 + (P^ - $30);
      Inc(P);
    end;
  end;

end;

  // ����ListBox������������
procedure CopyControlToClipboard(hWndLB: HWND);
var
  szClipData: array[0..128 * 1024] of Char;
  szLine: array[0..1000] of Char;
  nNum: Integer;
  hClipData: HGLOBAL;
  pClipData: PChar;
  fOk: BOOL;
begin
  // ��ȡListBox����
  szClipData[0] := #0;
  for nNum := 0 to SendMessage(hWndLB, LB_GETCOUNT, 0, 0) - 1 do
  begin
    SendMessage(hWndLB, LB_GETTEXT, nNum, Integer(@szLine));
    lstrcat(szClipData, szLine);
    lstrcat(szClipData, #13#10);
  end;

  // ���ü������ڴ�
  hClipData := GlobalAlloc(GMEM_MOVEABLE or GMEM_DDESHARE, lstrlen(szClipData) + 1);
  pClipData := GlobalLock(hClipData);
  lstrcpy(pClipData, szClipData);

  // ���ü���������
  OpenClipboard(0);
  EmptyClipboard();
  fOk := (SetClipboardData(CF_TEXT, hClipData) = hClipData);
  CloseClipboard();

  // ������óɹ���
  if (not fOk) then
  begin
    GlobalFree(hClipData);
    MessageBox(GetActiveWindow(), 'Error putting text on the clipboard', 'VMMap', 0);
  end;
end;

  // �ڴ�״̬��Ӧ����
function GetMemStorageText(dwStorage: DWORD): PChar;
begin
  case (dwStorage) of
    MEM_FREE:
      Result := 'Free   ';

    MEM_RESERVE:
      Result := 'Reserve';

    MEM_IMAGE:
      Result := 'Image  ';

    MEM_MAPPED:
      Result := 'Mapped ';
      
    MEM_PRIVATE:
      Result := 'Private';

    else
      Result := 'Unknown';
  end;
end;

  // �������Զ�Ӧ����
function GetProtectText(dwProtect: DWORD; const szBuf: PChar; fShowFlags: BOOL): PChar;
var
  p: PChar;
begin
  case (dwProtect and (not (PAGE_GUARD or PAGE_NOCACHE or PAGE_WRITECOMBINE)) ) of
    PAGE_READONLY:
      p := '-R--';

    PAGE_READWRITE:
      p := '-RW-';

    PAGE_WRITECOPY:
      p := '-RWC';

    PAGE_EXECUTE:
      p := 'E---';

    PAGE_EXECUTE_READ:
      p := 'ER--';

    PAGE_EXECUTE_READWRITE:
      p := 'ERW-';

    PAGE_EXECUTE_WRITECOPY:
      p := 'ERWC';

    PAGE_NOACCESS:
      p := '----';

    else
      p := 'Unknown';
  end;
  lstrcpy(szBuf, p);
  
  if (fShowFlags) then
  begin
    lstrcat(szBuf, ' ');

    if ((dwProtect and PAGE_GUARD) <> 0) then
      lstrcat(szBuf, 'G')
    else
      lstrcat(szBuf, '-');

    if ((dwProtect and PAGE_NOCACHE) <> 0) then
      lstrcat(szBuf, 'N')
    else
      lstrcat(szBuf, '-');

    if ((dwProtect and PAGE_WRITECOMBINE) <> 0) then
      lstrcat(szBuf, 'W')
    else
      lstrcat(szBuf, '-');
  end;

  Result := szBuf;
end;

  // ת��"����"��ϢΪ�ַ���
procedure ConstructRgnInfoLine(hProcess: THandle; const pVMQ: TVMQuery; const szLine: PChar; nMaxLen: Integer);
var
  nLen: Integer;
  me: TModuleEntry32;
  d: DWORD;
begin
  // ������Ϣ
  wvsprintf(szLine, '%p     %s  %16u  ',
    [ Integer(pVMQ.pvRgnBaseAddress),
      Integer(GetMemStorageText(pVMQ.dwRgnStorage)),
      pVMQ.RgnSize ]);
      
  if (pVMQ.dwRgnStorage <> MEM_FREE) then
  begin
    wvsprintf(SeachEnd(szLine), '%5u  ', [ pVMQ.dwRgnBlocks ]);
    GetProtectText(pVMQ.dwRgnProtection, SeachEnd(szLine), FALSE);
  end;

  lstrcat(szLine, '     ');

  // ȡģ����
  nLen := lstrlen(szLine);
  if (pVMQ.pvRgnBaseAddress <> nil) then
  begin
    me.dwSize := SizeOf(me);
    if g_Toolhelp.ModuleFind_BaseAddr(pVMQ.pvRgnBaseAddress, @me) then
    begin
      lstrcat(@szLine[nLen], me.szExePath);
    end else
    begin
      d := GetMappedFileName(hProcess, pVMQ.pvRgnBaseAddress, szLine + nLen, nMaxLen - nLen);
      if (d = 0) then szLine[nLen] := #0;
    end;
  end;

  // ��ջ�ռ�
  if (pVMQ.fRgnIsAStack) then lstrcat(szLine, 'Thread Stack');
end;

  // ת��"��"��ϢΪ�ַ���
procedure ConstructBlkInfoLine(const pVMQ: TVMQuery; const szLine: PChar; nMaxLen: Integer);
begin
  wvsprintf(szLine, '   %p  %s  %16u         ',
    [ Integer(pVMQ.pvBlkBaseAddress),
      Integer(GetMemStorageText(pVMQ.dwBlkStorage)),
      pVMQ.BlkSize ]);

  if (pVMQ.dwBlkStorage <> MEM_FREE) then
    GetProtectText(pVMQ.dwBlkProtection, SeachEnd(szLine), TRUE);
end;

  // ��ʾ�ڴ���Ϣ��ListBox
procedure Refresh(hWndLB: HWND; dwProcessId: DWORD; fExpandRegions: BOOL);
var
  hProcess: THandle;
  fOk: BOOL;
  pvAddress: Pointer;
  vmq: TVMQuery;
  szLine: array[0..1024] of Char;
  dwBlock: DWORD;
begin
  // ��ʼ��ListBox
  SendMessage(hWndLB, LB_RESETCONTENT, 0, 0);
  SendMessage(hWndLB, LB_SETHORIZONTALEXTENT, 300 * LOWORD(GetDialogBaseUnits()), 0);

  // ���Դ򿪽���
  hProcess := OpenProcess(PROCESS_QUERY_INFORMATION,  FALSE, dwProcessId);
  if (hProcess = 0) then
  begin
    SendMessage(hWndLB, LB_ADDSTRING, 0, Integer(PChar('')));
    SendMessage(hWndLB, LB_ADDSTRING, 0, Integer(PChar('    The process ID identifies a process that is not running')));
    Exit;
  end;

  // ץȡϵͳ����
  g_Toolhelp.CreateSnapshot(TH32CS_SNAPALL, dwProcessId);

  // ��������ռ�
  SendMessage(hWndLB, WM_SETREDRAW, 0, 0);
  pvAddress := nil;
  repeat
    fOk := VM_Query(hProcess, pvAddress, vmq);

    if (fOk) then
    begin
      // ���"����"��Ϣ
      ConstructRgnInfoLine(hProcess, vmq, szLine, SizeOf(szLine));
      SendMessage(hWndLB, LB_ADDSTRING, 0, Integer(@szLine));

      // "��"��Ϣ
      if (fExpandRegions) then
      begin
        dwBlock := 0;
        while (fOk) and (dwBlock < vmq.dwRgnBlocks) do
        begin
          // ���"��"��Ϣ
          ConstructBlkInfoLine(vmq, szLine, SizeOf(szLine));
          SendMessage(hWndLB, LB_ADDSTRING, 0, Integer(@szLine));

          // ׼����һ"��"
          pvAddress := Pointer(DWORD(pvAddress) + vmq.BlkSize);
          Inc(dwBlock);

          // δ����"����"
          if (dwBlock < vmq.dwRgnBlocks) then
            fOk := VM_Query(hProcess, pvAddress, vmq);
        end;
      end;

      // ��һ"����"
      pvAddress := Pointer(DWORD(vmq.pvRgnBaseAddress) + vmq.RgnSize);
    end;
  until (not fOk);

  SendMessage(hWndLB, WM_SETREDRAW, 1, 0);
  CloseHandle(hProcess);
end;

  // �Ի���WM_INITDIALOG����
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
var
  szCaption: array[0..MAX_PATH * 2] of Char;
  pe: TProcessEntry32;
begin
  // ����ͼ��
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_VMMAP)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_VMMAP)));

  // �޸ı���
  pe.dwSize := SizeOf(pe);
  GetWindowText(hWnd, szCaption, SizeOf(szCaption));
  g_Toolhelp.CreateSnapshot(TH32CS_SNAPALL, g_dwProcessId);
  if g_Toolhelp.ProcessFind(g_dwProcessId, @pe) then
    wvsprintf(@szCaption[lstrlen(szCaption)], ' (PID=%u "%s")', [ g_dwProcessId, Integer(@pe.szExeFile) ])
  else
    wvsprintf(@szCaption[lstrlen(szCaption)], ' (PID=%u "%s")', [ g_dwProcessId, Integer(PChar('unknown')) ]);
  SetWindowText(hWnd, szCaption);

  // ��󴰿�
  ShowWindow(hWnd, SW_MAXIMIZE);

  // �״�ˢ��
  Refresh(GetDlgItem(hWnd, IDC_LISTBOX), g_dwProcessId, g_fExpandRegions);

  Result := TRUE;
end;

  // �Ի���WM_SIZE����
procedure Dlg_OnSize(hWnd: HWND; state: UINT; cx, cy: Integer);
begin
  SetWindowPos(GetDlgItem(hWnd, IDC_LISTBOX), 0, 0, 0, cx, cy, SWP_NOZORDER);
end;

  // �Ի���WM_COMMAND����
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
begin
  case (id) of
    IDCANCEL:
      begin
        EndDialog(hWnd, id);
      end;

    ID_REFRESH:
      begin
        Refresh(GetDlgItem(hWnd, IDC_LISTBOX), g_dwProcessId, g_fExpandRegions);
      end;

    ID_EXPANDREGIONS:
      begin
        g_fExpandRegions := not g_fExpandRegions;
        Refresh(GetDlgItem(hWnd, IDC_LISTBOX), g_dwProcessId, g_fExpandRegions);
      end;

    ID_COPYTOCLIPBOARD:
      begin
        CopyControlToClipboard(GetDlgItem(hWnd, IDC_LISTBOX));
      end;
  end;
end;

  // �Ի�����Ϣ�ص�
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  Result := FALSE;

  case (uMsg) of
    WM_INITDIALOG:
      Result := SetWindowLong(hWnd, DWL_MSGRESULT, Longint(Dlg_OnInitDialog(hWnd, wParam, lParam))) <> 0;

    WM_COMMAND:
      Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));

    WM_SIZE:
      Dlg_OnSize(hWnd, wParam, LOWORD(lParam), HIWORD(lParam));
  end;
end;

  // �������߳����
begin
  g_Toolhelp := TToolhelp.Create();
  g_Toolhelp.EnableDebugPrivilege(TRUE);

  g_dwProcessId := StrToInt( ParamStr(1) );
  if (g_dwProcessId = 0) then
    g_dwProcessId := GetCurrentProcessId();

  DialogBox(HInstance, MakeIntResource(IDD_VMMAP), 0, @Dlg_Proc);

  g_Toolhelp.EnableDebugPrivilege(FALSE);
  g_Toolhelp.Free;
end.
