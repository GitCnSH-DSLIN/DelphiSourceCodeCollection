
// Module name: DirWalk.C ->> DirWalk.dpr
// Written by: Jim Harkins and Jeffrey Richter
// Notices: Copyright (c) 1995-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

program DirWalk;

{$R 'DirWalk.res' 'DirWalk.rc'}

uses
  Windows, Messages,
  Other in '..\Other.pas', CmnHdr in '..\CmnHdr.pas', WindowsX in '..\WindowsX.pas';

const
  IDD_DIRWALK  =    1;
  IDC_TREE     =  100;
  IDI_DIRWALK  =  102;

  // �Ƿ���Ŀ¼
function IsChildDir(var lpFindData: TWin32FindData): BOOL;
begin
  Result :=
    (lpFindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <> 0) and
    (lstrcmp(lpFindData.cFileName,  '.') <> 0) and
    (lstrcmp(lpFindData.cFileName, '..') <> 0);
end;

  // ��һ����Ŀ¼
function FindNextChildDir(hFindFile: THandle; var lpFindData: TWin32FindData): BOOL;
begin
  repeat
    Result := FindNextFile(hFindFile, lpFindData);
  until (not Result) or IsChildDir(lpFindData);
end;

  // ��һ����Ŀ¼
function FindFirstChildDir(const szPath: Pchar; var lpFindData: TWin32FindData): THandle;
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

  // ��������Ŀ¼
type
  PDirWalkData = ^TDirWalkData;
  TDirWalkData = record
    hWndTreeLB: HWND;     // Handle to the output list box
    nDepth: Integer;      // Nesting depth
    fRecurse: BOOL;       // Set to TRUE to list subdirectories.
    szBuf: array[0..1000] of Char; // Output formatting buffer
    nIndent: Integer;     // Indentation character count
    fOk: BOOL;            // Loop control flag
    fIsDir: BOOL;         // Loop control flag
    FindData: TWin32FindData; // File information
  end;

  // �ݹ����Ŀ¼
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
    // �Ƿ�Ŀ¼
    pDW.fIsDir := (pDW.FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <> 0);

    // ����Ŀ¼or��չ���¼�Ŀ¼
    if (not pDW.fIsDir) or ((not pDW.fRecurse) and IsChildDir(pDW.FindData)) then
    begin
      // ǰ׺�ո�
      for nBlank := 0 to pDW.nIndent - 1 do pDW.szBuf[nBlank] := ' ';

      // ��ǰ�ļ�
      _wvsprintf(@pDW.szBuf[pDW.nIndent], IfThen(pDW.fIsDir, '[%s]', '%s'), [DWORD(@pDW.FindData.cFileName)]);
      ListBox_AddString(pDW.hWndTreeLB, pDW.szBuf);
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

  // ��μ���
  Dec(pDW.nDepth);
end;

  // Ŀ¼�ṹ -> ListBox
procedure Dir_Walk(hWndTreeLB: HWND; const pszRootPath: PChar; fRecurse: BOOL);
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

  // WM_INITDIALOG
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
var
  Rc: TRect;
begin
  chSETDLGICONS(hWnd, IDI_DIRWALK, IDI_DIRWALK);

  GetClientRect(hWnd, Rc);
  SetWindowPos(GetDlgItem(hWnd, IDC_TREE), 0, 0, 0, Rc.Right, Rc.Bottom, SWP_NOZORDER);

  Dir_Walk(GetDlgItem(hWnd, IDC_TREE), '..', TRUE);

  Result := TRUE;
end;

  // WM_SIZE
procedure Dlg_OnSize(hWnd: HWND; state: UINT; cx, cy: Integer);
begin
  SetWindowPos(GetDlgItem(hWnd, IDC_TREE), 0, 0, 0, cx, cy, SWP_NOZORDER);
end;

  // WM_COMMAND
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
begin
  case (id) of
    IDCANCEL: EndDialog(hWnd, id);
    IDOK: Dir_Walk(GetDlgItem(hWnd, IDC_TREE), '..', TRUE); // ˢ��
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

    WM_SIZE:
      begin
        Dlg_OnSize(hWnd, wParam, LOWORD(lParam), HIWORD(lParam));
        Result := TRUE;
      end;

    WM_COMMAND:
      begin
        Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));
        Result := TRUE;
      end;

    else
      Result := FALSE;
  end;
end;

  // �������
begin
  chWARNIFUNICODEUNDERWIN95();
  DialogBox(HInstance, MakeIntResource(IDD_DIRWALK), 0, @Dlg_Proc);
end.
