
// Module name: SEHSum.C ->> SEHSum.dpr
// Notices: Copyright (c) 1995-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

program SEHSum;

{$R 'SEHSum.res' 'SEHSum.rc'}

uses
  Windows, Messages,
  Other in '..\Other.pas', CmnHdr in '..\CmnHdr.pas', WindowsX in '..\WindowsX.pas';

const
  g_szModName = 'SEHSum';
  IDD_SUMMATION =  101;
  IDI_SEHSUM    =  102;
  IDC_SUMNUM    = 1000;
  IDC_CALC      = 1001;
  IDC_ANSWER    = 1002;

  // ��չSEH�ڵ�
type
  PEstablisherFrame = ^TEstablisherFrame;
  TEstablisherFrame = record
    Prev: PEstablisherFrame;
    Handler: Pointer;
    SafeEip: DWORD; // ������ת��ַ
  end;

  // �߳��쳣�ص�
function ExceptHandler(var ExceptionRecord: TExceptionRecord; var EstablisherFrame: TEstablisherFrame;
  var ContextRecord: TContext; DispatcherContext: Pointer): TExceptionDisposition; cdecl;
begin
  if (ExceptionRecord.ExceptionCode = STATUS_STACK_OVERFLOW) then
  begin
    ContextRecord.Eip := EstablisherFrame.SafeEip; // ��������
    ContextRecord.Esp := DWORD(@EstablisherFrame); // �ָ�ջ��
    Result := ExceptionContinueExecution; // �Ѿ�����, �̰߳�ContextRecord����ִ��
  end else
    Result := ExceptionContinueSearch;    // û�д���, ϵͳ����"ѯ��"�����SEH�ڵ�
end;

  // �ݹ����
function Sum(uNum: UINT): UINT;
begin
  if (uNum = 0) then Result := 0 else Result := uNum + Sum(uNum - 1);
end;

  // �̺߳���
function SumThreadFunc(uSumNum: UINT): DWORD;
asm
  // uSum := UINT_MAX;
  MOV  EDX, UINT_MAX

  // �쳣����
  PUSH OFFSET @@SafeEip      // TEstablisherFrame.SafeEip := @@SafeEip;
  PUSH OFFSET ExceptHandler  // TEstablisherFrame.Handler := @ExceptHandler;
  PUSH FS:[0]                // TEstablisherFrame.Prev := TEB.ExceptionList;
  MOV  FS:[0], ESP           // TEB.ExceptionList := @TEstablisherFrame;

  // uSum := Sum(uSumNum);
  CALL Sum
  MOV  EDX, EAX

  // ȥ������
@@SafeEip:
  POP  FS:[0]                // TEB.ExceptionList := TEstablisherFrame.Prev;
  ADD  ESP, TYPE Pointer * 2 // �ָ�ջ��

  // Result := uSum;
  MOV  EAX, EDX
end;

  // WM_INITDIALOG
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  chSETDLGICONS(hWnd, IDI_SEHSUM, IDI_SEHSUM);
  Result := TRUE;
end;

  // WM_COMMAND
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
var
  uSumNum, uSum: UINT;
  fTranslated: BOOL;
  dwThreadId: DWORD;
  hThread: THandle;
begin
  case (id) of
    IDC_CALC: // ����
      begin
        uSumNum := GetDlgItemInt(hWnd, IDC_SUMNUM, fTranslated, FALSE);
        hThread := BeginThread(nil, 0, @SumThreadFunc, Pointer(uSumNum), 0, dwThreadId);

        WaitForSingleObject(hThread, INFINITE);
        GetExitCodeThread(hThread, uSum);
        CloseHandle(hThread);

        if (uSum = UINT_MAX) then
        begin
          SetDlgItemText(hWnd, IDC_ANSWER, 'Error');
          chMB('The number is too big, please enter a smaller number', g_szModName);
        end else
          SetDlgItemInt(hWnd, IDC_ANSWER, uSum, FALSE);
      end;

    IDCANCEL: // �˳�
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

 // ���߳����
begin
  chWARNIFUNICODEUNDERWIN95();
  DialogBox(HInstance, MakeIntResource(IDD_SUMMATION), 0, @Dlg_Proc);
end.
