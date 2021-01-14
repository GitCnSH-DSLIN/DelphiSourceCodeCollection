program FileRev;

{$R 'FileRev.res' 'FileRev.rc'}

uses
  Windows, Messages, CommDlg;

const
  FILENAME = 'FileRev.Dat';
  IS_TEXT_UNICODE_SIGNATURE = $0008;

  IDD_FILEREV    =    1;
  IDI_FILEREV    =  102;

  IDC_FILESELECT =  101;
  IDC_FILENAME   = 1000;
  IDC_REVERSE    = 1001;
  IDC_TEXTTYPE   = 1002;
  

  // ��תANSI�ַ���
procedure ReverseString_Ansi(pString: PChar; iLength: Integer);
var
  SwapChar: Char;
  J: Integer;
begin
  for J := 0 to iLength div 2 - 1 do
  begin
    SwapChar := pString[J];
    pString[J] := pString[iLength - J - 1];
    pString[iLength - J - 1] := SwapChar;
  end;

  J := 0;
  while (J < iLength - 1) do
  begin
    if (pString[J] = #10) and (pString[J + 1] = #13) then // �س�����
    begin
      pString[J] := #13;
      pString[J + 1] := #10;
      Inc(J, 2);
    end else
    begin
      if IsDBCSLeadByte( Byte(pString[J]) ) then // ����ǰ��
      begin
        SwapChar := pString[J];
        pString[J] := pString[J + 1];
        pString[J + 1] := SwapChar;
        Inc(J, 2);
      end else
        Inc(J);
    end;
  end;
end;

  // ��תUNICODE�ַ���
procedure ReverseString_Unicode(pString: PWideChar; iLength: Integer);
var
  SwapChar: WideChar;
  J: Integer;
begin
  for J := 0 to iLength div 2 - 1 do
  begin
    SwapChar := pString[J];
    pString[J] := pString[iLength - J - 1];
    pString[iLength - J - 1] := SwapChar;
  end;

  J := 0;
  while (J < iLength - 1) do
  begin
    if (pString[J] = #10) and (pString[J + 1] = #13) then
    begin
      pString[J] := #13;
      pString[J + 1] := #10;
      Inc(J , 2);
    end else
      Inc(J);
  end;
end;

  // �����ı��ļ�����
function FileReverse(pszPathname: PChar; pfIsTextUnicode: PBOOL): BOOL;
var
  hFile, hFileMap: THandle;
  dwFileSize: DWORD;
  pvFile: Pointer;
  iUnicodeTestFlags: Integer;
begin
  Result := FALSE;
  pfIsTextUnicode^ := FALSE;

  // �򿪴����ļ�
  hFile := CreateFile(pszPathname, GENERIC_WRITE or GENERIC_READ, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if (hFile = INVALID_HANDLE_VALUE) then
  begin
    MessageBox(0, 'File could not be opened.', 'FileRev', MB_OK);
    Exit;
  end;

  // ��ȡ�ļ���С
  dwFileSize := GetFileSize(hFile, nil);
  if (dwFileSize and $80000000 <> 0) then
  begin
    MessageBox(0, 'The file size is too long.', 'FileRev', MB_OK);
    CloseHandle(hFile);
    Exit;
  end;

  // �����ļ�ӳ��
  hFileMap := CreateFileMapping(hFile, nil, PAGE_READWRITE, 0, dwFileSize, nil);
  if (hFileMap = 0) then
  begin
    MessageBox(0, 'File map could not be opened.', 'FileRev', MB_OK);
    CloseHandle(hFile);
    Exit;
  end;

  // ӳ�����ڴ�ռ�
  pvFile := MapViewOfFile(hFileMap, FILE_MAP_WRITE, 0, 0, 0);
  if (pvFile = nil) then
  begin
    MessageBox(0, 'Could not map view of file.', 'FileRev', MB_OK);
    CloseHandle(hFileMap);
    CloseHandle(hFile);
    Exit;
  end;

  // �ļ���������
  iUnicodeTestFlags := -1;
  pfIsTextUnicode^ := IsTextUnicode(pvFile, dwFileSize, @iUnicodeTestFlags);

  // �����ı�����
  if (pfIsTextUnicode^ = FALSE) then
  begin
    ReverseString_Ansi(pvFile, dwFileSize);
  end else
  begin
    if (iUnicodeTestFlags and IS_TEXT_UNICODE_SIGNATURE <> 0) then
    begin
      Inc(PWideChar(pvFile));
      Dec(dwFileSize, SizeOf(WideChar));
    end;
    ReverseString_Unicode(pvFile, dwFileSize div 2);
  end;

  // �ر��ڴ�ӳ��
  UnmapViewOfFile(pvFile);
  CloseHandle(hFileMap);

  // ��������ļ�
  CloseHandle(hFile);

  Result := TRUE;
end;

  // WM_INITDIALOG��Ϣ����
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_FILEREV)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_FILEREV)));

  EnableWindow(GetDlgItem(hWnd, IDC_REVERSE), FALSE);

  Result := TRUE;
end;

  // WM_COMMAND��Ϣ����
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
var
  szPathname: array[0..MAX_PATH] of Char;
  fIsTextUnicode: BOOL;
  si: TStartupInfo;
  pi: TProcessInformation;
  sz: PChar;  
  ofn: TOpenFilename;
begin
  case (id) of
    IDCANCEL:
      begin
        EndDialog(hWnd, id);
      end;

    IDC_FILENAME:
      begin
        EnableWindow(GetDlgItem(hWnd, IDC_REVERSE), GetWindowTextLength(hWndCtl) > 0);
      end;

    IDC_REVERSE:
      begin
        // �����ļ���'FileRev.Dat'
        GetDlgItemText(hWnd, IDC_FILENAME, szPathname, SizeOf(szPathname));
        if (CopyFile(szPathname, FILENAME, FALSE) = FALSE) then
        begin
          MessageBox(0, 'New file could not be created.', 'FileRev', MB_OK);
          Exit;
        end;

        // ��ת'FileRev.Dat'����
        if FileReverse(FILENAME, @fIsTextUnicode) then
        begin
          if fIsTextUnicode then
            SetDlgItemText(hWnd, IDC_TEXTTYPE, 'Unicode')
          else
            SetDlgItemText(hWnd, IDC_TEXTTYPE, 'ANSI');

          // �ü��±���(���鿴)
          ZeroMemory(@si, SizeOf(TStartupInfo));
          si.cb := SizeOf(TStartupInfo);
          sz := 'Notepad ' + FILENAME;
          if CreateProcess(nil, sz, nil, nil, FALSE, 0, nil, nil, si, pi) then
          begin
            CloseHandle(pi.hThread);
            CloseHandle(pi.hProcess);
          end;
        end;
      end;

    IDC_FILESELECT:
      begin
        ZeroMemory(@ofn, SizeOf(TOpenFilename));
        ofn.lStructSize := SizeOf(TOpenFilename);
        ofn.hWndOwner := hWnd;
        ofn.lpstrFile := szPathname;
        ofn.lpstrFile[0] := #0;
        ofn.nMaxFile := SizeOf(szPathname);
        ofn.lpstrTitle := 'Select file for reversing';
        ofn.Flags := OFN_EXPLORER or OFN_FILEMUSTEXIST;
        GetOpenFileName(ofn);

        SetDlgItemText(hWnd, IDC_FILENAME, ofn.lpstrFile);
        SetFocus(GetDlgItem(hWnd, IDC_REVERSE));
      end;
  end; // END case of
end;

  // �Ի�����Ϣ�ص�
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM):BOOL; stdcall;
begin
  case (uMsg) of
    WM_INITDIALOG:
      begin
        Result := SetWindowLong(hWnd, DWL_MSGRESULT,
          Longint(Dlg_OnInitDialog(hWnd, wParam, lParam))) <> 0;
      end;

    WM_COMMAND:
      begin
        Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));
        Result := TRUE;
      end

    else Result := FALSE;
  end;
end;

  // �������
begin
  DialogBox(HInstance, MakeIntResource(IDD_FILEREV), 0, @Dlg_Proc);
end.
