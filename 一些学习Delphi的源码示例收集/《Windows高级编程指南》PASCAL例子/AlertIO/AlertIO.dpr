
// Module name: AlertIO.C ->> AlertIO.dpr
// Notices: Copyright (c) 1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

program AlertIO;

{$R 'AlertIO.res' 'AlertIO.rc'}

uses
  Windows, Messages, CommDlg,
  Other in '..\Other.pas', CmnHdr in '..\CmnHdr.pas', WindowsX in '..\WindowsX.pas';

const
  g_szModName = 'AlertIO';
  IDD_ALERTIO     =    1;
  IDC_BROWSE      =  100;
  IDC_SRCFILE     =  101;
  IDC_SRCFILESIZE =  102;
  IDI_ALERTIO     =  102;

  // ����Ԥ����
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
  phFileSrc := CreateFile(pszFileSrc, GENERIC_READ, FILE_SHARE_READ,
     nil, OPEN_EXISTING, FILE_FLAG_NO_BUFFERING or FILE_FLAG_OVERLAPPED, 0);
  if (phFileSrc = INVALID_HANDLE_VALUE) then goto ErrorLeave;

  // ����Ŀ���ļ�
  phFileDst := CreateFile(pszFileDst, GENERIC_WRITE, 0, nil,
    CREATE_ALWAYS, FILE_FLAG_NO_BUFFERING or FILE_FLAG_OVERLAPPED, phFileSrc);
  if (phFileDst = INVALID_HANDLE_VALUE) then goto ErrorLeave;

  // Դ�ļ��ߴ�
  pulFileSize.LowPart := GetFileSize(phFileSrc, @pulFileSize.HighPart);

  // ��ҳ��Բ��
  ulFileSizeDst.QuadPart := (pulFileSize.QuadPart + dwPageSize - 1) and not (dwPageSize - 1);

  // Ŀ���ļ��ߴ�
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

  // ���������
procedure CopyCleanup(const pszFileDst: PChar; hFileSrc, hFileDst: THandle; const pulFileSize: TULargeInteger);
begin
  CloseHandle(hFileDst);
  CloseHandle(hFileSrc);

  // ��ȷ����
  hFileDst := CreateFile(pszFileDst, GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);
  if (hFileDst <> INVALID_HANDLE_VALUE) then
  begin
    SetFilePointer(hFileDst, pulFileSize.LowPart, @pulFileSize.HighPart, FILE_BEGIN);
    SetEndOfFile(hFileDst);
    CloseHandle(hFileDst);
  end;
end;

  // ����״̬��Ϣ�ṹ
type
  PCopyState = ^TCopyState;
  TCopyState = record
    dwPageSize: DWORD;           // ҳ��ߴ�
    hFileSrc, hFileDst: THandle; // �ļ����
    ulFileSize, ulNextReadOffset: TULargeInteger; // �ļ��ߴ�, ��ȡƫ��
    nReadsInProgress, nWritesInProgress: Integer; // δ������
  end;

  // ����״̬������Ϣ
var
  g_cs: TCopyState;

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

  // �������
function WriteFileEx(hFile: THandle; lpBuffer: Pointer; nNumberOfBytesToWrite: DWORD; var IoReq: TIoReq;
  lpCompletionRoutine: TPROverlappedCompletionRoutine): BOOL; stdcall; external kernel32 name 'WriteFileEx';
function ReadFileEx(hFile: THandle; lpBuffer: Pointer; nNumberOfBytesToRead: DWORD; var IoReq: TIoReq;
  lpCompletionRoutine: TPROverlappedCompletionRoutine): BOOL; stdcall; external kernel32 name 'ReadFileEx';

  // ǰ������
procedure WriteCompletionRoutine(dwErrorCode, dwNumberOfBytesTransferred: DWORD; var IoReq: TIoReq); stdcall; forward;

  // ��ȡ���
procedure ReadCompletionRoutine(dwErrorCode, dwNumberOfBytesTransferred: DWORD; var IoReq: TIoReq); stdcall;
begin
  if (dwErrorCode <> NO_ERROR) then
  begin
    chMB('dwErrorCode <> NO_ERROR', g_szModName);
    Exit;
  end;
  Dec(g_cs.nReadsInProgress);

  // Բ���ߴ�
  dwNumberOfBytesTransferred := (dwNumberOfBytesTransferred + g_cs.dwPageSize - 1) and not(g_cs.dwPageSize - 1);

  // ����д��
  if WriteFileEx(g_cs.hFileDst, IoReq.pbData, dwNumberOfBytesTransferred, IoReq, @WriteCompletionRoutine) = FALSE then
  begin
    chMB('WriteFileEx() failure', g_szModName);
    Exit;
  end;
  Inc(g_cs.nWritesInProgress);
end;

  // д�����
procedure WriteCompletionRoutine(dwErrorCode, dwNumberOfBytesTransferred: DWORD; var IoReq: TIoReq); stdcall;
begin
  if (dwErrorCode <> NO_ERROR) then
  begin
    chMB('dwErrorCode <> NO_ERROR', g_szModName);
    Exit;
  end;
  Dec(g_cs.nWritesInProgress);

  // δ������
  if (g_cs.ulNextReadOffset.QuadPart < g_cs.ulFileSize.QuadPart) then
  begin
    IoReq.Overlapped.Offset := g_cs.ulNextReadOffset.LowPart;
    IoReq.Overlapped.OffsetHigh := g_cs.ulNextReadOffset.HighPart;

    // �����ȡ
    if ReadFileEx(g_cs.hFileSrc, IoReq.pbData, BUFFSIZE, IoReq, @ReadCompletionRoutine) = FALSE then
    begin
      chMB('ReadFileEx() failure', g_szModName);
      Exit;
    end;
    Inc(g_cs.nReadsInProgress);

    Inc(g_cs.ulNextReadOffset.QuadPart, BUFFSIZE);
  end;
end;

  // �ļ�����
function FileCopy(const pszFileSrc, pszFileDst: PChar): BOOL;
var
  IoReqArray: array[0..MAX_PENDING_IO_REQS - 1] of TIoReq; // = { 0 }
  SI: TSystemInfo;
  nIOReq: Integer;
begin
  GetSystemInfo(SI);
  g_cs.dwPageSize := SI.dwPageSize;
  g_cs.ulNextReadOffset.QuadPart := 0;
  g_cs.nReadsInProgress := 0;
  g_cs.nWritesInProgress := 0;

  // ���ļ�
  Result := PrepareDstFile(pszFileSrc, pszFileDst, g_cs.hFileSrc, g_cs.hFileDst, g_cs.ulFileSize, g_cs.dwPageSize);
  if (Result = FALSE) then Exit;

  // �����ȡ
  for nIOReq := 0 to MAX_PENDING_IO_REQS - 1 do
  begin
    IoReqArray[nIOReq].Overlapped.Internal := 0;
    IoReqArray[nIOReq].Overlapped.InternalHigh := 0;
    IoReqArray[nIOReq].Overlapped.Offset := g_cs.ulNextReadOffset.LowPart;
    IoReqArray[nIOReq].Overlapped.OffsetHigh := g_cs.ulNextReadOffset.HighPart;
    IoReqArray[nIOReq].Overlapped.hEvent := 0;
    IoReqArray[nIOReq].pbData := VirtualAlloc(nil, BUFFSIZE, MEM_RESERVE or MEM_COMMIT, PAGE_READWRITE);

    // δ��β��
    if (g_cs.ulNextReadOffset.QuadPart < g_cs.ulFileSize.QuadPart) then
    begin
      if ReadFileEx(g_cs.hFileSrc, IoReqArray[nIOReq].pbData, BUFFSIZE, IoReqArray[nIOReq], @ReadCompletionRoutine) = FALSE then
      begin
        chMB('ReadFileEx() failure', g_szModName);
        Exit;
      end;
      Inc(g_cs.nReadsInProgress);

      Inc(g_cs.ulNextReadOffset.QuadPart, BUFFSIZE);
    end;
  end;

  // �ȴ�����
  while (g_cs.nReadsInProgress > 0) or (g_cs.nWritesInProgress > 0) do SleepEx(INFINITE, TRUE);

  // �ͷ��ڴ�
  for nIOReq := 0 to MAX_PENDING_IO_REQS - 1 do VirtualFree(IoReqArray[nIOReq].pbData, 0, MEM_RELEASE);

  // ��β����
  CopyCleanup(pszFileDst, g_cs.hFileSrc, g_cs.hFileDst, g_cs.ulFileSize);

  Result := TRUE;
end;

  // WM_INITDIALOG
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  chSETDLGICONS(hWnd, IDI_ALERTIO, IDI_ALERTIO);
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
        FileCopy(szPathname, 'AlertIO.CPY');
      end;

    IDC_BROWSE:  // ѡ��
      begin
        szPathname := '*.*';

        chINITSTRUCT(ofn, SizeOf(ofn), TRUE);
        ofn.hWndOwner := hWnd;
        ofn.lpstrFilter := '*.*'#0;
        ofn.lpstrFile := szPathname;
        ofn.nMaxFile := SizeOf(szPathname);
        ofn.Flags := OFN_FILEMUSTEXIST;

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
        EnableWindow(GetDlgItem(hWnd, IDOK), FALSE);

        Edit_GetText(GetDlgItem(hWnd, IDC_SRCFILE), szPathname, SizeOf(szPathname));

        if (PathFileExists(szPathname) = FALSE) then Exit;
        if (GetFileAttributes(szPathname) and FILE_ATTRIBUTE_DIRECTORY <> 0) then Exit;

        hFile := CreateFile(szPathname, GENERIC_READ, 0, nil, OPEN_EXISTING, 0, 0);
        if (hFile = INVALID_HANDLE_VALUE) then Exit;

        SetDlgItemInt(hWnd, IDC_SRCFILESIZE, GetFileSize(hFile, nil), FALSE);
        CloseHandle(hFile);
        EnableWindow(GetDlgItem(hWnd, IDOK), TRUE);
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
  DialogBox(HInstance, MakeIntResource(IDD_ALERTIO), 0, @Dlg_Proc);
end.
