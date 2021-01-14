program PreViewDlg;

{$R 'PreViewDlg.res' 'PreViewDlg.txt'}

uses Windows, CommDlg, Messages;

  // �ļ�ǰ500�ֽ�����Memo
procedure LoadFileHead(FileName: PChar; MemoHandle: HWND);
var
  TextBuffer: array[0..500] of Char;
  FileHandle: THandle;
  ReadLength: DWORD;
begin
  SetWindowText(MemoHandle, #13#10'  Ԥ��ʽ�ļ�ѡ��Ի���ʾ��      By  ����');

  FileHandle := CreateFile(FileName, GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if (FileHandle = INVALID_HANDLE_VALUE) then Exit;

  ReadFile(FileHandle, TextBuffer[0], 500, ReadLength, nil);
  CloseHandle(FileHandle);

  if (ReadLength > 500) then Exit;
  TextBuffer[ReadLength] := #0;

  SetWindowText(MemoHandle, @TextBuffer[0]);
end;

  // �ӶԻ�����Ϣ���ӻص�
function OFNHookProc(hDlg: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): UINT; stdcall;
const
{$J+}
  MainHandle: HWND = 0; // ���Ի�����
  MemoHandle: HWND = 0; // �ӱ༭����
{$J-}
var
  WndRect, ScnRect: TRect;
  FileName: array[0..MAX_PATH] of Char;
begin
  if (Msg = WM_NOTIFY) then
  begin
    if (PNMHdr(lParam).code = CDN_INITDONE) then
    begin
     // �������Ի���
      MainHandle := GetParent(hDlg);
      SendMessage(MainHandle, WM_SETICON, ICON_BIG, LoadIcon(HInstance, 'LiuMazi'));
      GetWindowRect(MainHandle, WndRect);
      WndRect.Right := WndRect.Right - WndRect.Left; // ���
      WndRect.Bottom := WndRect.Bottom - WndRect.Top + 100; // �߶�
      WndRect.Left := (GetSystemMetrics(SM_CXSCREEN) - WndRect.Right) shr 1; // ����
      SystemParametersInfo(SPI_GETWORKAREA, 0, @ScnRect, 0);
      WndRect.Top  := (ScnRect.Bottom - ScnRect.Top - WndRect.Bottom) shr 1; // ����
      MoveWindow(MainHandle, WndRect.Left, WndRect.Top, WndRect.Right, WndRect.Bottom, TRUE);

     // �����ӶԻ���
      GetClientRect(MainHandle, WndRect);
      MoveWindow(hDlg, 0, 0, WndRect.Right, WndRect.Bottom, TRUE);

     // ����Memo�ؼ�
      MemoHandle := GetDlgItem(hDlg, 66);
      MoveWindow(MemoHandle, 5, WndRect.Bottom - 100, WndRect.Right - 10, 95, TRUE);
    end else
    begin
      if (PNMHdr(lParam).code = CDN_SELCHANGE) then
      begin
        SendMessage(MainHandle, CDM_GETFILEPATH, MAX_PATH, Longint(@FileName[0]));
        LoadFileHead(@FileName[0], MemoHandle); // ��ʾѡ���ļ���������
      end;
    end;
  end else
  begin
    if (Msg = WM_SIZE) then
    begin
     // ����Memo�ؼ�
      GetClientRect(MainHandle, WndRect);
      MoveWindow(MemoHandle, 5, WndRect.Bottom - 100, WndRect.Right - 10, 95, TRUE);
    end;
  end;
  Result := 0; // Ҫ��Ĭ�϶Ի�����̴���
end;

  // ����ϵͳ�����ṹ����
function OpenStructSize(): DWORD;
var
  OSVersionInfo: TOSVersionInfo;
begin
  OSVersionInfo.dwOSVersionInfoSize := SizeOf(OSVersionInfo);
  GetVersionEx(OSVersionInfo);

  if (OSVersionInfo.dwMajorVersion >= 5) and // Windows 2000 ���ϰ汾
  (OSVersionInfo.dwPlatformId = VER_PLATFORM_WIN32_NT) then
    Result := SizeOf(TOpenFilename)
  else
    Result := SizeOf(TOpenFilename) - SizeOf(DWORD) * 3; // û��β��������
end;

  // ����'�ļ�ѡ��'�Ի���
procedure OpenFileDlg();
var
  FileName: array[0..MAX_PATH] of Char;
  OpenStruct: TOpenFilename;
begin
  FileName[0] := #0;
  with OpenStruct do
  begin
    lStructSize := OpenStructSize();
    hWndOwner := 0;
    hInstance := SysInit.HInstance; // ģ����Դ����ģ��
    lpstrFilter := 'Ansi�ļ�'#0'*.TXT'#0'�����ļ�'#0'*.*'#0#0; // ������
    lpstrCustomFilter := nil;
    nMaxCustFilter := 0;
    nFilterIndex := 0;
    lpstrFile := @FileName[0]; // �ļ���������(��ʼ&���)
    nMaxFile := MAX_PATH;
    lpstrFileTitle := nil;
    nMaxFileTitle := 0;
    lpstrInitialDir := nil;
    lpstrTitle := '  Ԥ��ʽ�ļ�ѡ��Ի���ʾ��      By  ����'; // ����
    Flags := OFN_EXPLORER or      // �µ�Explorer���
             OFN_ENABLESIZING or  // �����û��ı��С
             OFN_FILEMUSTEXIST or // ָ���ļ��������
             OFN_HIDEREADONLY or  // ����ֻ����ѡ��
             OFN_ENABLEHOOK or    // ʹ����Ϣ���Ӻ���
             OFN_ENABLETEMPLATE;  // ʹ���ӶԻ���ģ��
    nFileOffset := 0;
    nFileExtension := 0;
    lpstrDefExt := 'TXT'; // Ĭ����չ��
    lCustData := 0;
    lpfnHook := @OFNHookProc; // ��Ϣ���ӵ�ַ
    lpTemplateName := 'DlgTemplate'; // ģ����Դ��
    pvReserved := nil;
    dwReserved := 0;
    FlagsEx := 0;
  end;
  GetOpenFileName(OpenStruct); // �����Ի�����, ��������Ϣѭ��
end;

begin
  OpenFileDlg();
end.


