
// Module name: FileChng.C ->> FileChng.dpr
// Written by: Jim Harkins and Jeffrey Richter
// Notices: Copyright (c) 1995-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

program FileChng;

{$R 'FileChng.res' 'FileChng.rc'}

uses
  Windows, Messages,
  Other in '..\Other.pas', CmnHdr in '..\CmnHdr.pas', WindowsX in '..\WindowsX.pas';

const
  g_szModName = 'FileChng';
  IDD_FILECHNG   =  1;
  IDC_PATH       =  100;
  IDC_INCSUBDIRS =  101;
  IDC_NCOUNT     =  102;
  IDI_FILECHNG   =  102;
  IDC_FILENAME   =  103;
  IDC_DIRNAME    =  104;
  IDC_ATTRIBS    =  105;
  IDC_SIZEFLTR   =  106;
  IDC_LASTWRITE  =  107;
  IDC_LASTACCESS =  108;
  IDC_START      =  109;
  IDC_STOP       =  110;
  IDC_TREE       =  111;
  IDC_CREATION   =  112;
  IDC_SECURITY   =  113;

  // �Ƿ���Ŀ¼
function IsChildDir(var lpFindData: TWin32FindData): BOOL;
begin
  Result :=
    (lpFindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <> 0) and
    (lstrcmp(lpFindData.cFileName,  '.') <> 0) and
    (lstrcmp(lpFindData.cFileName, '..') <> 0);
end;

  // ��һ��Ŀ¼
function FindNextChildDir(hFindFile: THandle; var lpFindData: TWin32FindData): BOOL;
begin
  repeat
    Result := FindNextFile(hFindFile, lpFindData);
  until (not Result) or IsChildDir(lpFindData);
end;

  // ��һ��Ŀ¼
function FindFirstChildDir(const szPath: PChar; var lpFindData: TWin32FindData): THandle;
var
  fFound: BOOL;
begin
  Result := FindFirstFile(szPath, lpFindData);

  if (Result <> INVALID_HANDLE_VALUE) then
  begin
    fFound := IsChildDir(lpFindData);

    if (not fFound) then
      fFound := FindNextChildDir(Result, lpFindData);

    if (not fFound) then
    begin
      FindClose(Result);
      Result := INVALID_HANDLE_VALUE;
    end;
  end;
end;

  // ����ö��Ŀ¼��
type
  TDirWalkData = record
    hWndTreeLB: HWND; // Handle to the output list box
    nDepth: Integer;  // Nesting depth
    fRecurse: BOOL;   // Set to TRUE to list subdirectories.
    szBuf: array[0..1000] of Char; // Output formatting buffer
    nIndent: Integer; // Indentation character count
    fOk: BOOL;        // Loop control flag
    fIsDir: BOOL;     // Loop control flag
    FindData: TWin32FindData; // File information
  end;

  // ����Ŀ¼�ṹ
procedure DirWalkRecurse(var pDW: TDirWalkData);
var
  hFind: THandle;
  nBlank: Integer;
begin
  // �������
  Inc(pDW.nDepth);

  // ǰ׺�ո�
  pDW.nIndent := 3 * pDW.nDepth;
  for nBlank := 0 to pDW.nIndent - 1 do pDW.szBuf[nBlank] := ' ';

  // ��ǰĿ¼
  GetCurrentDirectory(chDIMOF(pDW.szBuf) - pDW.nIndent, @pDW.szBuf[pDW.nIndent]);
  ListBox_AddString(pDW.hWndTreeLB, pDW.szBuf);

  // ö���ļ�
  hFind := FindFirstFile('*.*', pDW.FindData);
  pDW.fOk := (hFind <> INVALID_HANDLE_VALUE);
  while (pDW.fOk) do
  begin
    pDW.fIsDir := (pDW.FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <> 0);
    if (not pDW.fIsDir) or (not pDW.fRecurse and IsChildDir(pDW.FindData)) then
    begin
      for nBlank := 0 to pDW.nIndent - 1 do pDW.szBuf[nBlank] := ' ';

      _wvsprintf(@pDW.szBuf[pDW.nIndent], IfThen(pDW.fIsDir, '[%s]', '%s'), [DWORD(@pDW.FindData.cFileName)]);
      ListBox_AddString(pDW.hwndTreeLB, pDW.szBuf);
    end;

    pDW.fOk := FindNextFile(hFind, pDW.FindData);
  end;
  if (hFind <> INVALID_HANDLE_VALUE) then FindClose(hFind);

  // ö��Ŀ¼
  if (pDW.fRecurse) then
  begin
    hFind := FindFirstChildDir('*.*', pDW.FindData);
    pDW.fOk := (hFind <> INVALID_HANDLE_VALUE);

    while (pDW.fOk) do
    begin
      if SetCurrentDirectory(pDW.FindData.cFileName) then
      begin
        DirWalkRecurse(pDW);
        SetCurrentDirectory('..');
      end;

      pDW.fOk := FindNextChildDir(hFind, pDW.FindData);
    end;

    if (hFind <> INVALID_HANDLE_VALUE) then FindClose(hFind);
  end;

  // ��ȼ���
  Inc(pDW.nDepth);
end;

  // Ŀ¼�ṹ -> ListBox
procedure DirWalk(hWndTreeLB: HWND; const pszRootPath: PChar; fRecurse: BOOL);
var
  szCurrDir: array[0..MAX_PATH] of Char;
  DW: TDirWalkData;
begin
  GetCurrentDirectory(chDIMOF(szCurrDir), szCurrDir);
  SetCurrentDirectory(pszRootPath);

  SetWindowRedraw(hWndTreeLB, FALSE);
  ListBox_ResetContent(hWndTreeLB);
  DW.nDepth := -1;
  DW.hWndTreeLB := hWndTreeLB;
  DW.fRecurse := fRecurse;
  DirWalkRecurse(DW);
  SetWindowRedraw(hWndTreeLB, TRUE);

  SetCurrentDirectory(szCurrDir);
end;

var
  g_hChange: THandle = INVALID_HANDLE_VALUE;
  g_nCount: Integer = 0;

  // ��ʾ�������
procedure Dlg_ErrorBox(const pszSource: PChar);
var
  szBuf: array[0..100] of Char;
begin
  _wvsprintf(szBuf, '%s reported error %lu', [DWORD(pszSource), GetLastError()]);
  chMB(szBuf, g_szModName);
end;

  // ����ѡ���־
function Dlg_GetFilter(hWnd: HWND): DWORD;
begin
  Result := 0;
  if (IsDlgButtonChecked(hWnd, IDC_FILENAME) = BST_CHECKED) then Result := Result or FILE_NOTIFY_CHANGE_FILE_NAME;
  if (IsDlgButtonChecked(hWnd, IDC_DIRNAME) = BST_CHECKED) then Result := Result or FILE_NOTIFY_CHANGE_DIR_NAME;
  if (IsDlgButtonChecked(hWnd, IDC_ATTRIBS) = BST_CHECKED) then Result := Result or FILE_NOTIFY_CHANGE_ATTRIBUTES;
  if (IsDlgButtonChecked(hWnd, IDC_SIZEFLTR) = BST_CHECKED) then Result := Result or FILE_NOTIFY_CHANGE_SIZE;
  if (IsDlgButtonChecked(hWnd, IDC_LASTWRITE) = BST_CHECKED) then Result := Result or FILE_NOTIFY_CHANGE_LAST_WRITE;
  if (IsDlgButtonChecked(hWnd, IDC_LASTACCESS) = BST_CHECKED) then Result := Result or FILE_NOTIFY_CHANGE_LAST_ACCESS;
  if (IsDlgButtonChecked(hWnd, IDC_CREATION) = BST_CHECKED) then Result := Result or FILE_NOTIFY_CHANGE_CREATION;
  if (IsDlgButtonChecked(hWnd, IDC_SECURITY) = BST_CHECKED) then Result := Result or FILE_NOTIFY_CHANGE_SECURITY;
end;

  // �Ƿ���Լ���
function Dlg_Validate(hWnd: HWND): BOOL;
var
  szPath: array[0..MAX_PATH] of Char;
begin
  Result := FALSE;

  if (Dlg_GetFilter(hWnd) <> 0) then  // ��ѡ����
  begin
    GetDlgItemText(hWnd, IDC_PATH, szPath, chDIMOF(szPath));
    Result := SetCurrentDirectory(szPath); // �Ϸ�Ŀ¼
  end;
end;

  // �رոı�֪ͨ
procedure Dlg_CloseChange(hWnd: HWND);
var
  fDisableFocus: BOOL;
begin
  fDisableFocus := GetFocus() = GetDlgItem(hWnd, IDC_STOP);
  EnableWindow(GetDlgItem(hWnd, IDC_STOP), FALSE);

  if Dlg_Validate(hWnd) then
  begin
    EnableWindow(GetDlgItem(hWnd, IDC_START), TRUE);
    if (fDisableFocus) then SetFocus(GetDlgItem(hWnd, IDC_START));
  end else
  begin
    fDisableFocus := (fDisableFocus) or (GetFocus() = GetDlgItem(hWnd, IDC_START)); // **
    EnableWindow(GetDlgItem(hWnd, IDC_START), FALSE);
    if (fDisableFocus) then SetFocus(GetDlgItem(hWnd, IDC_INCSUBDIRS));
  end;

  if (g_hChange <> INVALID_HANDLE_VALUE) then
  begin
    if (FindCloseChangeNotification(g_hChange) = FALSE) then Dlg_ErrorBox('FindCloseChangeNotification');
    g_hChange := INVALID_HANDLE_VALUE;
  end;
end;

  // �򿪸ı�֪ͨ
procedure Dlg_OpenChange(hWnd: HWND);
var
  szPath: array[0..MAX_PATH] of Char;
  fDisableFocus: BOOL;
begin
  fDisableFocus := GetFocus() = GetDlgItem(hWnd, IDC_START);
  Dlg_CloseChange(hWnd);

  g_nCount := 0;
  SetDlgItemInt(hWnd, IDC_NCOUNT, g_nCount, FALSE);

  GetDlgItemText(hWnd, IDC_PATH, szPath, chDIMOF(szPath));
  g_hChange := FindFirstChangeNotification(szPath,
    IsDlgButtonChecked(hWnd, IDC_INCSUBDIRS) = BST_CHECKED, Dlg_GetFilter(hWnd));

  if (g_hChange = INVALID_HANDLE_VALUE) then
  begin
    Dlg_ErrorBox('FindFirstChangeNotification');
  end else
  begin
    EnableWindow(GetDlgItem(hWnd, IDC_START), FALSE);
    EnableWindow(GetDlgItem(hWnd, IDC_STOP), TRUE);
    if (fDisableFocus) then SetFocus(GetDlgItem(hWnd, IDC_STOP));
    DirWalk(GetDlgItem(hWnd, IDC_TREE), szPath, IsDlgButtonChecked(hWnd, IDC_INCSUBDIRS) = BST_CHECKED);
  end;
end;

  // WM_INITDIALOG
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
var
  szPath: array[0..MAX_PATH] of Char;
begin
  chSETDLGICONS(hWnd, IDI_FILECHNG, IDI_FILECHNG);

  GetCurrentDirectory(chDIMOF(szPath), szPath);
  SetDlgItemText(hWnd, IDC_PATH, szPath);

  Dlg_CloseChange(hWnd);

  Result := TRUE;
end;

  // WM_COMMAND
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
begin
  case (id) of
    IDC_PATH:
      begin
        if (EN_CHANGE = codeNotify) then Dlg_CloseChange(hWnd);
      end;

    IDC_INCSUBDIRS, IDC_FILENAME, IDC_DIRNAME, IDC_ATTRIBS, IDC_SIZEFLTR,
    IDC_LASTWRITE, IDC_LASTACCESS, IDC_CREATION, IDC_SECURITY, IDC_STOP:
      begin
        Dlg_CloseChange(hWnd);
      end;

    IDC_START:
      begin
        Dlg_OpenChange(hWnd);
      end;

    IDCANCEL:
      begin
        Dlg_CloseChange(hWnd);
        PostQuitMessage(0);
      end;
  end;
end;

  // �Ի���ص�
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  case (uMsg) of
    WM_INITDIALOG:
      begin
        Result := SetDlgMsgResult(hWnd, LRESULT(Dlg_OnInitDialog(hWnd, wParam, lParam)));
      end;
      
    WM_COMMAND:
      begin
        Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));
        Result := TRUE;
      end;

    else Result := FALSE;
  end;
end;

  // �������
var
  hMainDialog: HWND;
  Msg: TMsg;
  dwResult: DWORD;
  fQuit: BOOL = FALSE;
  fWait4FileChanges: BOOL;
  szPath: array[0..MAX_PATH] of Char;

begin
  chWARNIFUNICODEUNDERWIN95();

  // ��������
  hMainDialog := CreateDialog(HInstance, MakeIntResource(IDD_FILECHNG), 0, @Dlg_Proc);

  // ��Ϣѭ��
  while (not fQuit) do
  begin
    // ֪ͨ�������Ƿ�Ϸ�
    fWait4FileChanges := (g_hChange <> INVALID_HANDLE_VALUE);

    // �ȴ�(��Ϣor֪ͨ����)
    dwResult :=
      MsgWaitForMultipleObjects(IfThen(fWait4FileChanges, 1, 0), g_hChange, FALSE, INFINITE, QS_ALLEVENTS);

    if (fWait4FileChanges) and (WAIT_OBJECT_0 = dwResult) then
    begin
    // ��Ŀ¼�仯���ȴ��ɹ�

      // ����֪ͨ����
      Inc(g_nCount);
      SetDlgItemInt(hMainDialog, IDC_NCOUNT, g_nCount, FALSE);

      // ˢ��Ŀ¼����
      GetDlgItemText(hMainDialog, IDC_PATH, szPath, chDIMOF(szPath));
      DirWalk(GetDlgItem(hMainDialog, IDC_TREE), szPath, IsDlgButtonChecked(hMainDialog, IDC_INCSUBDIRS) = BST_CHECKED);

      // �����ȴ�֪ͨ
      FindNextChangeNotification(g_hChange);
    end else
    begin
    // �������Ϣ���ȴ��ɹ�

      // ȡ��������Ϣ������
      while PeekMessage(Msg, 0, 0, 0, PM_REMOVE) do
      begin
        if (IsDialogMessage(hMainDialog, Msg) = FALSE) then
        begin
          if (Msg.message = WM_QUIT) then
          begin
            fQuit := TRUE; // �˳���Ϣѭ��
          end else
          begin
            TranslateMessage(Msg);
            DispatchMessage(Msg);
          end;
        end; // if (!IsDialogMessage())
      end; // while messages are still in the queue

    end; // if file change notification OR message
  end;  // while (!fQuit)

  // �������
  DestroyWindow(hMainDialog);
end.
