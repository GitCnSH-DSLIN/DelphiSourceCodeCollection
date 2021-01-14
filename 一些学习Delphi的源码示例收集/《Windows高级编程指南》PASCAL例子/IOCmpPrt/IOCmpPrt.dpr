
// Module name: IOCmpPrt.C ->> IOCmpPrt.dpr
// Notices: Copyright (c) 1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

program IOCmpPrt;

{$R 'IOCmpPrt.res' 'IOCmpPrt.rc'}

uses
  Windows, Messages, CommDlg,
  Other in '..\Other.pas', CmnHdr in '..\CmnHdr.pas', WindowsX in '..\WindowsX.pas';

const
  g_szModName = 'IOCmpPrt';
  IDC_BROWSE      =  100;
  IDC_SRCFILE     =  101;
  IDC_SRCFILESIZE =  102;
  IDI_IOCMPPRT    =  103;
  IDD_IOCMPPRT    =  104;

  // ������ɶ˿�
function CreateNewCompletionPort(dwNumberOfConcurrentThreads: DWORD): THandle;
begin
  Result := CreateIoCompletionPort(INVALID_HANDLE_VALUE, 0, 0, dwNumberOfConcurrentThreads);
end;

  // ������ɶ˿�
function AssociateDeviceWithCompletionPort(hCompPort, hDevice: THandle; dwCompKey: DWORD): BOOL;
begin
  Result := CreateIoCompletionPort(hDevice, hCompPort, dwCompKey, 0) = hCompPort;
end;

  // ����ǰ�ڴ���
function PrepareDstFile(const pszFileSrc, pszFileDst: PChar; var phFileSrc,
  phFileDst: THandle; var pulFileSize: TULargeInteger; dwPageSize: DWORD): BOOL;
label
  ErrorLeave;
var
  ulFileSizeDst: TULargeInteger;
  dwError: DWORD;
begin
  Result := FALSE;

  // ��Դ�ļ�
  phFileSrc := CreateFile(pszFileSrc, GENERIC_READ,
    FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_FLAG_NO_BUFFERING or FILE_FLAG_OVERLAPPED, 0);
  if (phFileSrc = INVALID_HANDLE_VALUE) then goto ErrorLeave;

  // ����Ŀ���ļ�
  phFileDst := CreateFile(pszFileDst, GENERIC_WRITE, 0, nil,
    CREATE_ALWAYS, FILE_FLAG_NO_BUFFERING or FILE_FLAG_OVERLAPPED, phFileSrc);
  if (phFileDst = INVALID_HANDLE_VALUE) then goto ErrorLeave;

  // Դ�ļ��ߴ�
  pulFileSize.LowPart := GetFileSize(phFileSrc, @pulFileSize.HighPart);

  // ҳ��������
  ulFileSizeDst.QuadPart := (pulFileSize.QuadPart + dwPageSize - 1) and not(dwPageSize - 1);

  // Ԥ��Ŀ��ߴ�
  dwError := SetFilePointer(phFileDst, ulFileSizeDst.LowPart, @ulFileSizeDst.HighPart, FILE_BEGIN);
  if (dwError = $FFFFFFFF) and (GetLastError() <> NO_ERROR) then goto ErrorLeave;
  if (SetEndOfFile(phFileDst) = FALSE) then goto ErrorLeave;

  // Return(TRUE)
  Result := TRUE;
  Exit;

  // ����ʱִ��
ErrorLeave:
  if (phFileSrc <> INVALID_HANDLE_VALUE) then
  begin
    CloseHandle(phFileSrc);
    phFileSrc := INVALID_HANDLE_VALUE;
  end;

  if (phFileSrc <> INVALID_HANDLE_VALUE) then
  begin
    CloseHandle(phFileDst);
    phFileDst := INVALID_HANDLE_VALUE;
  end;
end;

  // ������������
procedure CopyCleanup(const pszFileDst: PChar; hFileSrc, hFileDst: THandle; pulFileSize: TULargeInteger);
begin
  CloseHandle(hFileDst);
  CloseHandle(hFileSrc);

  // ��ȷ�ߴ�
  hFileDst := CreateFile(pszFileDst, GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
  if (hFileDst <> INVALID_HANDLE_VALUE) then
  begin
    SetFilePointer(hFileDst, pulFileSize.LowPart, @pulFileSize.HighPart, FILE_BEGIN);
    SetEndOfFile(hFileDst);
    CloseHandle(hFileDst);
  end;
end;

  // ����״̬��Ϣ
type
  PCopyState = ^TCopyState;
  TCopyState = record
    dwPageSize: DWORD;            // ҳ��ߴ�
    hFileSrc, hFileDst: THandle;  // �ļ����
    ulFileSize: TULargeInteger;   // �ļ��ߴ�(Դ)
    ulNextReadOffset: TULargeInteger; // ��ȡƫ��
    nReadsInProgress: Integer;    // δ��������
    nWritesInProgress: Integer;
  end;

  // ��չTOverlapped
type
  PIoReq = ^TIoReq;
  TIoReq = record
    Overlapped: TOverlapped;
	  pbData: PByte;
  end;

const
  MAX_PENDING_IO_REQS = 4;
  BUFFSIZE = (64 * 1024);

  // ��ɼ�Id
const
  COMPKEY_READ  = 1;
  COMPKEY_WRITE = 2;

  // �������
function GetQueuedCompletionStatus(CompletionPort: THandle; var lpNumberOfBytesTransferred, lpCompletionKey: DWORD;
  var lpIoReq: PIoReq; dwMilliseconds: DWORD): BOOL; stdcall; external kernel32 name 'GetQueuedCompletionStatus';
function PostQueuedCompletionStatus(CompletionPort: THandle; dwNumberOfBytesTransferred: DWORD;
  dwCompletionKey: DWORD; var IoReq: TIoReq): BOOL; stdcall; external kernel32 name 'PostQueuedCompletionStatus';
function WriteFile(hFile: THandle; Buffer: Pointer; nNumberOfBytesToWrite: DWORD;
  var lpNumberOfBytesWritten: DWORD; var IoReq: TIoReq): BOOL; stdcall; external kernel32 name 'WriteFile';
function ReadFile(hFile: THandle; Buffer: Pointer; nNumberOfBytesToRead: DWORD;
  var lpNumberOfBytesRead: DWORD; var IoReq: TIoReq): BOOL; stdcall; external kernel32 name 'ReadFile';

  // �ļ�����
function FileCopy(const pszFileSrc, pszFileDst: PChar): BOOL;
var
  CS: TCopyState;
  SI: TSystemInfo;
  IoReqArray: array[0..MAX_PENDING_IO_REQS-1] of TIoReq; // = { 0 }
  nIOReq: Integer;
  hIOCompPort: THandle;
  dwNumBytesXfer, dwCompKey: DWORD;
  lpIoReq: PIoReq;
begin
  GetSystemInfo(SI);
  CS.dwPageSize := SI.dwPageSize;
  CS.ulNextReadOffset.QuadPart := 0;
  CS.nReadsInProgress := 0;
  CS.nWritesInProgress := 0;

  // ����Ԥ����
  Result := PrepareDstFile(pszFileSrc, pszFileDst,  CS.hFileSrc, CS.hFileDst, CS.ulFileSize, CS.dwPageSize);
  if (Result = FALSE) then Exit;

  // ������ɶ˿�
  hIOCompPort := CreateNewCompletionPort(0);
  if (hIOCompPort = 0) then
  begin
    chMB('CreateNewCompletionPort() failure', g_szModName);
    Exit;
  end;

  // ��Դ�ļ�
  if (AssociateDeviceWithCompletionPort(hIOCompPort, CS.hFileSrc, COMPKEY_READ) = FALSE) then
  begin
    chMB('CreateNewCompletionPort(COMPKEY_READ) failure', g_szModName);
    Exit;
  end;

  // ��Ŀ���ļ�
  if (AssociateDeviceWithCompletionPort(hIOCompPort, CS.hFileDst, COMPKEY_WRITE) = FALSE) then
  begin
    chMB('CreateNewCompletionPort(COMPKEY_WRITE) failure', g_szModName);
    Exit;
  end;

  // ģ��д�����
  for nIOReq := 0 to MAX_PENDING_IO_REQS - 1 do
  begin
    IoReqArray[nIOReq].Overlapped.Internal := 0;
    IoReqArray[nIOReq].Overlapped.InternalHigh := 0;
    IoReqArray[nIOReq].Overlapped.Offset := 0;
    IoReqArray[nIOReq].Overlapped.OffsetHigh := 0;
    IoReqArray[nIOReq].Overlapped.hEvent := 0;
    IoReqArray[nIOReq].pbData := VirtualAlloc(nil, BUFFSIZE, MEM_RESERVE or MEM_COMMIT, PAGE_READWRITE);

    Inc(cs.nWritesInProgress);
    PostQueuedCompletionStatus(hIOCompPort, 0, COMPKEY_WRITE, IoReqArray[nIOReq]);
  end;

  // ���������ж�д
  while (cs.nReadsInProgress > 0) or (cs.nWritesInProgress > 0) do
  begin
    Result := GetQueuedCompletionStatus(hIOCompPort, dwNumBytesXfer, dwCompKey, lpIoReq, INFINITE);
    if (Result = FALSE) and (GetLastError() <> NO_ERROR) then
    begin
      chMB('GetQueuedCompletionStatus() failure', g_szModName);
      Break;
    end;

    case (dwCompKey) of
      COMPKEY_READ:  // ��ȡ���
        begin
          Dec(CS.nReadsInProgress);

          dwNumBytesXfer := (dwNumBytesXfer + CS.dwPageSize - 1) and not(CS.dwPageSize - 1);
          Result := WriteFile(CS.hFileDst, lpIOReq.pbData, dwNumBytesXfer, dwNumBytesXfer, lpIoReq^);

          if (Result = FALSE) and (GetLastError() <> ERROR_IO_PENDING) then
          begin
            chMB('WriteFile() failure', g_szModName);
            Break;
          end;

          Inc(CS.nWritesInProgress);
        end;

      COMPKEY_WRITE: // д�����
        begin
          Dec(CS.nWritesInProgress);
          if (CS.ulNextReadOffset.QuadPart >= CS.ulFileSize.QuadPart) then Continue;

          lpIoReq.Overlapped.Offset := CS.ulNextReadOffset.LowPart;
          lpIoReq.Overlapped.OffsetHigh := CS.ulNextReadOffset.HighPart;
          Result := ReadFile(CS.hFileSrc, lpIoReq.pbData, BUFFSIZE, dwNumBytesXfer, lpIoReq^);

          if (Result = FALSE) and (GetLastError() <> ERROR_IO_PENDING) then
          begin
            chMB('ReadFile() failure', g_szModName);
            Break;
          end;

          Inc(CS.nReadsInProgress);
          Inc(CS.ulNextReadOffset.QuadPart, BUFFSIZE);
        end;
    end; // END: case of
  end;

  // �ر���ɶ˿�
  CloseHandle(hIOCompPort);

  // �ͷ������ڴ�
  for nIOReq := 0 to MAX_PENDING_IO_REQS - 1 do VirtualFree(IoReqArray[nIOReq].pbData, 0, MEM_RELEASE);

  // ������β����
  CopyCleanup(pszFileDst, CS.hFileSrc, CS.hFileDst, CS.ulFileSize);
end;

  // WM_INITDIALOG
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  chSETDLGICONS(hWnd, IDI_IOCMPPRT, IDI_IOCMPPRT);
  EnableWindow(GetDlgItem(hWnd, IDOK), FALSE);
  Result := TRUE;
end;

  // WM_COMMAND
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
var
  szPathname: array[0..MAX_PATH] of Char;
  ofn: TOpenFilename;
  hFile: THandle;
begin
  case (id) of
    IDOK:        // ����
      begin
        Edit_GetText(GetDlgItem(hWnd, IDC_SRCFILE), szPathname, SizeOf(szPathname));
        SetCursor(LoadCursor(0, IDC_WAIT));
        FileCopy(szPathname, 'IOCmpPrt.CPY');
      end;

    IDC_BROWSE:  // ѡ��
      begin
        chINITSTRUCT(ofn, SizeOf(ofn), TRUE);
        ofn.hWndOwner := hWnd;
        ofn.lpstrFilter := '*.*'#0;
        ofn.lpstrFile := szPathname;
        ofn.nMaxFile := SizeOf(szPathname);
        ofn.Flags := OFN_FILEMUSTEXIST;
        szPathname := '*.*';
        
        if GetOpenFileName(ofn) then
        begin
          Edit_SetText(GetDlgItem(hWnd, IDC_SRCFILE), szPathname);
          FORWARD_WM_NEXTDLGCTL(hWnd, GetDlgItem(hWnd, IDOK), TRUE);
        end;
      end;

    IDC_SRCFILE: // �仯
      begin
        if (codeNotify <> EN_CHANGE) then Exit; // ����֪ͨ

        SetDlgItemInt(hWnd, IDC_SRCFILESIZE, 0, FALSE);
        Button_Enable(GetDlgItem(hWnd, IDOK), FALSE);

        Edit_GetText(GetDlgItem(hWnd, IDC_SRCFILE), szPathname, SizeOf(szPathname));

        if (PathFileExists(szPathname) = FALSE) then Exit;
        if (GetFileAttributes(szPathname) and FILE_ATTRIBUTE_DIRECTORY <> 0) then Exit;

        hFile := CreateFile(szPathname, GENERIC_READ, 0, nil, OPEN_EXISTING, 0, 0);
        if (hFile = INVALID_HANDLE_VALUE) then Exit;

        SetDlgItemInt(hWnd, IDC_SRCFILESIZE, GetFileSize(hFile, nil), FALSE);
        CloseHandle(hFile);
        
        Button_Enable(GetDlgItem(hWnd, IDOK), TRUE);
      end;

    IDCANCEL:    // �˳�
      begin
        EndDialog(hWnd, id);
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
begin
  chWARNIFUNICODEUNDERWIN95();
  DialogBox(HInstance, MakeIntResource(IDD_IOCMPPRT), 0, @Dlg_Proc);
end.
