
// Module name: SEHExcpt.C ->> SEHExcpt.dpr
// Notices: Copyright (c) 1995-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

program SEHExcpt;

{$R 'SEHExcpt.res' 'SEHExcpt.rc'}

uses
  Windows, Messages,
  Other in '..\Other.pas', CmnHdr in '..\CmnHdr.pas', WindowsX in '..\WindowsX.pas';

const
  g_szModName = 'SEHExcpt';
  IDD_SEHEXCPT     =    1;
  IDC_NUMACCESSES  =  100;
  IDC_LOG          =  101;
  IDI_SEHEXCPT     =  101;

  // ����ṹ
type
  TElement = record
    bReserved: array[0..4*1024-1] of Byte;
  end;
  PElement = ^TElement;
  TArray = array[0..0] of TElement;
  PArray = ^TArray;

  // ���鳤��
const
  NUMELEMENTS  =  50;
  NUMBYTESINARRAY = SizeOf(TElement) * NUMELEMENTS;

  // �ύ�����ڴ�
procedure CommitMemory(hWndLog: HWND; var lpEP: TExceptionPointers; lpbAttemptedAddr: PByte);
var
  fAttemptedWrite: BOOL;
  szBuf: array[0..100] of Char;
begin
  // ��ʾ�쳣����(��/д)
  fAttemptedWrite := BOOL(lpEP.ExceptionRecord.ExceptionInformation[0]);
  _wvsprintf(szBuf, '---> Committing memory (%s attempted)', [DWORD(IfThen(fAttemptedWrite, 'write', 'read'))]);
  ListBox_AddString(hWndLog, szBuf);

  // Ϊ�쳣��ַ�ύ�ڴ�
  VirtualAlloc(lpbAttemptedAddr, SizeOf(TElement), MEM_COMMIT, PAGE_READWRITE);
end;

  // ��չ��SEH�ڵ�
type
  PEstablisherFrame = ^TEstablisherFrame;
  TEstablisherFrame = record
    Prev: PEstablisherFrame;
    Handler: Pointer;
    SafeEip: DWORD; // ������ת��ַ
  end;

  // �߳��쳣�ص�
function PerThreadExcptionHandler(var ExceptionRecord: TExceptionRecord; var EstablisherFrame: TEstablisherFrame;
  var ContextRecord: TContext; DispatcherContext: Pointer): TExceptionDisposition; cdecl;
begin
  if (ExceptionRecord.ExceptionCode = LeaveException) then
  begin
    ContextRecord.Eip := EstablisherFrame.SafeEip; // ��������
    ContextRecord.Esp := DWORD(@EstablisherFrame); // �ָ�ջ��
    Result := ExceptionContinueExecution; // �Ѿ�����, �̰߳�ContextRecord����ִ��
  end else
    Result := ExceptionContinueSearch;    // û�д���, ϵͳ����"ѯ��"�����SEH�ڵ�
end;

  // �쳣"������"
function ExpFilter(var lpEP: TExceptionPointers; lpbArray: PByte; lNumBytesInArray: DWORD; hWndLog: HWND): Integer;
label
  FinallyDo;
var
  lpbAttemptedAddr: PByte;
  dwExceptionCode: DWORD;
  nFilterResult: Integer;
begin
  asm
    MOV  nFilterResult, EXCEPTION_CONTINUE_SEARCH
  end;
  dwExceptionCode := lpEP.ExceptionRecord.ExceptionCode;

  // �쳣���� (_try)
  asm
    PUSH EBP                   // ���� EBP
    PUSH OFFSET FinallyDo      // TEstablisherFrame.SafeEip := @FinallyDo
    PUSH OFFSET PerThreadExcptionHandler // TEstablisherFrame.Handler := @PerThreadExcptionHandler
    PUSH FS:[0]                // TEstablisherFrame.Prev := TEB.ExceptionList
    MOV  FS:[0], ESP           // TEB.ExceptionList := @TEstablisherFrame
  end;

  // �쳣����
  if (dwExceptionCode <> EXCEPTION_ACCESS_VIOLATION) then _leave;

  // �����ַ
  if (lpbArray = nil) then _leave;

  // �쳣��ַ
  lpbAttemptedAddr := Pointer(lpEP.ExceptionRecord.ExceptionInformation[1]);

  // ��������
  if (DWORD(lpbAttemptedAddr) < DWORD(lpbArray)) or
     (DWORD(lpbArray) + lNumBytesInArray <= DWORD(lpbAttemptedAddr))
  then _leave;

  // �ύ�ڴ�
  CommitMemory(hWndLog, lpEP, lpbAttemptedAddr);

  // ����ִ��
  nFilterResult := EXCEPTION_CONTINUE_EXECUTION;

  // ȥ������ (_finally)
FinallyDo:
  asm
    POP  FS:[0]                // TEB.ExceptionList := TEstablisherFrame.Prev
    ADD  ESP, TYPE Pointer * 2 // �ָ�ջ��
    POP  EBP                   // �ָ� EBP
  end;

  Result := nFilterResult;
end;

  // �����쳣�ص�
function TopLevelExceptionHandler(var pep: TExceptionPointers): LongInt; stdcall;
begin
  Result := ExpFilter(pep, PByte(pep.ContextRecord.Ebp), NUMBYTESINARRAY, PDWORD(pep.ContextRecord.Esp)^);
  // ע: �˴�������Dlg_ReserveArrayAndAccessIt()�����Ļ��������
end;

  // ���ʱ����ڴ�
procedure Dlg_ReserveArrayAndAccessIt(hWndLog: HWND; nNumAccesses: Integer);
var
  lpArray: PArray;
  Element: TElement;
  szBuf: array[0..100] of Char;
  nElementNum: Integer;
begin
  ListBox_ResetContent(hWndLog);
  ListBox_AddString(hWndLog, 'Execution started');

  // �����ڴ�
  lpArray := VirtualAlloc(nil, NUMBYTESINARRAY, MEM_RESERVE, PAGE_NOACCESS);

  // �������
  while (nNumAccesses > 0) do
  begin
    Dec(nNumAccesses);

    // �����±�
    nElementNum := Random(NUMELEMENTS);

    // ��Ҫ����
    _wvsprintf(szBuf, 'Writing index: %d', [nElementNum]);
    ListBox_AddString(hWndLog, szBuf);

    // ����д��
    lpArray[nElementNum] := Element;
  end;

  ListBox_AddString(hWndLog, 'Execution ended');

  // �ͷ��ڴ�
  VirtualFree(lpArray, 0, MEM_RELEASE);
end;

  // WM_INITDIALOG
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  chSETDLGICONS(hWnd, IDI_SEHEXCPT, IDI_SEHEXCPT);
  SetDlgItemInt(hWnd, IDC_NUMACCESSES, 100, FALSE);
  Result := TRUE;
end;

  // WM_COMMAND
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
var
  nNumAccesses: Integer;
  fTranslated: BOOL;
begin
  case (id) of
    IDOK:
      begin
        nNumAccesses := GetDlgItemInt(hWnd, IDC_NUMACCESSES, fTranslated, FALSE);

        if (fTranslated) then
          Dlg_ReserveArrayAndAccessIt(GetDlgItem(hWnd, IDC_LOG), nNumAccesses)
        else
          chMB('Invalid number of accesses ', g_szModName);
      end;

    IDCANCEL:
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
  RemoveCurrentThreadOtherSEH(); // ȥ��SetExceptionHandler()��װ���߳��쳣����ڵ�
  SetUnhandledExceptionFilter(@TopLevelExceptionHandler); // ��װ�����쳣����ص�

  chWARNIFUNICODEUNDERWIN95();
  DialogBox(HInstance, MakeIntResource(IDD_SEHEXCPT), 0, @Dlg_Proc);
end.
