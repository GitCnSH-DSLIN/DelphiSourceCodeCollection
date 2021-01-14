
// Module name: SEHTerm.C ->> SEHTerm.dpr
// Notices: Copyright (c) 1995-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

program SEHTerm;

{$R 'SEHTerm.res' 'SEHTerm.rc'}
{$DEFINE SIMULATION} // ģ�����
{$OPTIMIZATION OFF}  // �ر��Ż�

uses
  Windows, Messages,
  Other in '..\Other.pas', CmnHdr in '..\CmnHdr.pas', WindowsX in '..\WindowsX.pas';

const
  IDD_SEHTERM      =    1;
  IDC_OPENSUCCEEDS =  100;
  IDC_SIZESUCCEEDS =  101;
  IDI_SEHTERM      =  101;
  IDC_MEMSUCCEEDS  =  102;
  IDC_READSUCCEEDS =  103;
  IDC_LOG          =  104;

  // ��չSEH�ڵ�
type
  PEstablisherFrame = ^TEstablisherFrame;
  TEstablisherFrame = record
    Prev: PEstablisherFrame;
    Handler: Pointer;
    SafeEip: DWORD; // ������ת��ַ
    SafeEbp: DWORD; // ԭ�ȶ�ջָ��
  end;

  // �߳��쳣�ص�
function ExceptHandler(var ExceptionRecord: TExceptionRecord; var EstablisherFrame: TEstablisherFrame;
  var ContextRecord: TContext; DispatcherContext: Pointer): TExceptionDisposition; cdecl;
begin
  if (ExceptionRecord.ExceptionCode = LeaveException) then
  begin
    ContextRecord.Esp := DWORD(@EstablisherFrame); // �ָ�ջ��
    ContextRecord.Ebp := EstablisherFrame.SafeEbp; // �ָ�ָ��
    ContextRecord.Eip := EstablisherFrame.SafeEip; // ��������
    Result := ExceptionContinueExecution; // �Ѿ�����, �̰߳�ContextRecord����ִ��
  end else
    Result := ExceptionContinueSearch;    // û�д���, ϵͳ����"ѯ��"�����SEH�ڵ�
end;

  // ͳ���ļ�����
function Dlg_CountWordsInFile(hWndLog: HWND; fOpenSucceeds, fFileSizeSucceeds, fMemSucceeds, fReadSucceeds: BOOL): DWORD;
label
  FinallyDo;
var
  hFile: THandle;
  lpvFileData: Pointer;
  fFileReadOk: BOOL;
  lNumWords, dwLastError: DWORD;
begin
  // �쳣���� (_try)
  asm
    PUSH EBP                   // TEstablisherFrame.SafeEbp := EBP
    PUSH OFFSET FinallyDo      // TEstablisherFrame.SafeEip := @FinallyDo
    PUSH OFFSET ExceptHandler  // TEstablisherFrame.Handler := @ExceptHandler
    PUSH FS:[0]                // TEstablisherFrame.Prev := TEB.ExceptionList
    MOV  FS:[0], ESP           // TEB.ExceptionList := @TEstablisherFrame
  end;

  // �ó�ʼֵ
  lpvFileData := nil;
  lNumWords := UINT_MAX;

  // ��ʼִ��
  ListBox_ResetContent(hWndLog);
  ListBox_AddString(hWndLog, 'Starting execution');

  // ���ļ�
{$IFDEF SIMULATION}
  hFile := IfThen(fOpenSucceeds, not INVALID_HANDLE_VALUE, INVALID_HANDLE_VALUE);
{$ELSE}
  hFile := CreateFile(...);
{$ENDIF}
  if (hFile = INVALID_HANDLE_VALUE) then
  begin
    ListBox_AddString(hWndLog, '   File open: Fail');
    _leave;
  end else
    ListBox_AddString(hWndLog, '   File open: OK');

  // �ļ���С
{$IFDEF SIMULATION}
  dwLastError := IfThen(fFileSizeSucceeds, NO_ERROR, not NO_ERROR);
{$ELSE}
  dwFileSize := GetFileSize(hFile);
  dwLastError := GetLastError();
{$ENDIF}
  if (dwLastError <> NO_ERROR) then
  begin
    ListBox_AddString(hWndLog, '   File size: Fail');
    _leave;
  end else
    ListBox_AddString(hWndLog, '   File size: OK');

  // �����ڴ�
{$IFDEF SIMULATION}
  lpvFileData := IfThen(fMemSucceeds, Pointer(1), nil);
{$ELSE}
  lpvFileData := HeapAlloc(GetProcessHeap(), 0, dwFileSize);
{$ENDIF}
  if (lpvFileData = nil) then
  begin
    ListBox_AddString(hWndLog, '   Memory allocation: Fail');
    _leave;
  end else
    ListBox_AddString(hWndLog, '   Memory allocation: OK');

  // �����ļ�
{$IFDEF SIMULATION}
  fFileReadOk := fReadSucceeds;
{$ELSE}
  fFileReadOk := ReadFile(hFile, PChar(lpvFileData)^, dwFileSize, PDWORD(nil)^, nil);
{$ENDIF}
  if (fFileReadOk = FALSE) then
  begin
    ListBox_AddString(hWndLog, '   File read: Fail');
    _leave;
  end else
    ListBox_AddString(hWndLog, '   File read: OK');

  // ͳ�ƴ���
  ListBox_AddString(hWndLog, '   Calculating the number of words');
  lNumWords := 37;

  // ȥ������ (_finally)
FinallyDo:
  asm
    POP  FS:[0]                // TEB.ExceptionList := TEstablisherFrame.Prev;
    ADD  ESP, TYPE Pointer * 3 // �ָ�ջ��
  end;

  // ִ�����
  ListBox_AddString(hWndLog, '   Cleaning up');

  // �ͷ��ڴ�
  if (lpvFileData <> nil) then
  begin
    ListBox_AddString(hWndLog, '   Freeing memory');
{$IFNDEF SIMULATION}
    HeapFree(GetProcessHeap(), 0, lpvFileData);
{$ENDIF}
  end;

  // �ر��ļ�
  if (hFile <> INVALID_HANDLE_VALUE) then
  begin
    ListBox_AddString(hWndLog, '   Closing file');
{$IFNDEF SIMULATION}
   CloseHandle(hFile);
{$ENDIF}
  end;

  Result := lNumWords;
end;
 
  // WM_INITDIALOG
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  chSETDLGICONS(hWnd, IDI_SEHTERM, IDI_SEHTERM);

  Button_SetCheck(GetDlgItem(hWnd, IDC_OPENSUCCEEDS), BST_CHECKED);
  Button_SetCheck(GetDlgItem(hWnd, IDC_SIZESUCCEEDS), BST_CHECKED);
  Button_SetCheck(GetDlgItem(hWnd, IDC_MEMSUCCEEDS), BST_CHECKED);
  Button_SetCheck(GetDlgItem(hWnd, IDC_READSUCCEEDS), BST_CHECKED);

  Result := TRUE;
end;

  // WM_COMMAND
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
var
  szBuf: array[0..100] of Char;
  lNumWords: DWORD;
begin
  case (id) of
    IDOK:
      begin
        lNumWords := Dlg_CountWordsInFile(
          GetDlgItem(hWnd, IDC_LOG),
          Button_GetCheck(GetDlgItem(hWnd, IDC_OPENSUCCEEDS)) = BST_CHECKED,
          Button_GetCheck(GetDlgItem(hWnd, IDC_SIZESUCCEEDS)) = BST_CHECKED,
          Button_GetCheck(GetDlgItem(hWnd, IDC_MEMSUCCEEDS))  = BST_CHECKED,
          Button_GetCheck(GetDlgItem(hWnd, IDC_READSUCCEEDS)) = BST_CHECKED);

        if (lNumWords = UINT_MAX) then
          ListBox_AddString(GetDlgItem(hWnd, IDC_LOG), 'Error occurred in function.')
        else begin
          _wvsprintf(szBuf, 'Result: Words in file = %d', [lNumWords]);
          ListBox_AddString(GetDlgItem(hWnd, IDC_LOG), szBuf);
        end;
      end;

    IDCANCEL:
      begin
        EndDialog(hWnd, id);
      end;
  end;
end;

  // �Ի���ص�
function DlgProc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
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
  DialogBox(HInstance, MakeIntResource(IDD_SEHTERM), 0, @DlgProc);
end.
