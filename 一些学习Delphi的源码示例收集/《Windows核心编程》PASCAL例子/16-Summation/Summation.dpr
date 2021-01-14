program Summation;

{$R 'Summation.res' 'Summation.rc'}

uses
  Windows, Messages;

const
  IDD_SUMMATION = 101; // ��ԴID
  IDI_SUMMATION = 102;
  IDC_SUMNUM = 1000;   // �ؼ�ID
  IDC_CALC   = 1001;
  IDC_ANSWER = 1002;
  UINT_MAX = DWORD(-1); // �Ƿ���ʶ

type
  // �쳣�ص�����ֵ
  TExceptionDisposition = (
    ExceptionContinueExecution = 0, // ����ִ�������쳣���߳�(�ص��Ѿ������޸�����)
    ExceptionContinueSearch = 1,    // �ص�δ������, ���������ϼ���Ѱ�������ص�
    ExceptionNestedException = 2,
    ExceptionCollidedUnwind = 3
                          );

  // ��׼�쳣�ṹ��
  PExceptionRegistration = ^TExceptionRegistration;
  TExceptionRegistration = record
    PrevStruct: PExceptionRegistration; // ��һ�ڵ�λ��
    ExceptionHandler: Pointer;          // �쳣�ص���ַ
  end;

  // ��չ�쳣�ṹ��
  PExcFrame = ^TExcFrame;
  TExcFrame = record
    PStruct: PExcFrame; // ��һ�ڵ�λ��
    Handler: Pointer;   // �쳣�ص���ַ
    SafeEip: Pointer;   // ��ȫָ���ַ
  end;

  // �ݹ����
function Sum(uNum: UINT): UINT;
begin
  if (uNum = 0) then Result := 0 else Result := uNum + Sum(uNum - 1);
end;

  // �쳣�ص�
function ExceptHandler(var ExceptionRecord: TExceptionRecord; var EstablisherFrame: TExcFrame;
  var ContextRecord: TContext; DispatcherContext: Pointer): TExceptionDisposition; Cdecl;
begin
  if (ExceptionRecord.ExceptionCode = STATUS_STACK_OVERFLOW) then
  begin
    ContextRecord.Eax := UINT_MAX; // �̺߳�������'�����ʶ'
    ContextRecord.Eip := DWORD(EstablisherFrame.SafeEip); // ����'Call Sum'ָ��֮��ִ��
    ContextRecord.Esp := DWORD(@EstablisherFrame); // �ָ�ջ��Ϊִ��'Call Sum'ǰ��λ��
    Result := ExceptionContinueExecution;
  end else
    Result := ExceptionContinueSearch;
end;

  // �̺߳���
function SumThreadFunc(uSumNum: UINT): DWORD;
asm
  // �ڶ�ջ�й����쳣�ṹ
  PUSH OFFSET  @@SafeEip     // TExcFrame.SafeEip
  PUSH OFFSET  ExceptHandler // TExcFrame.Handler
  PUSH FS:[0]                // TExcFrame.PStruct

  // ���ýṹ���������ײ�
  MOV  FS:[0], ESP           // FS:[0]��TIB.ExceptionList

  // ����/����ֵ����EAX��
  CALL Sum

  // �����쳣ʱ����תλ��
@@SafeEip:

  // ������ժ�����ǵĽṹ
  MOV  EDX   , [ESP]         // �ϸ��ڵ��ַ
  MOV  FS:[0], EDX           // ����Ϊ�׽ڵ�

  // ����쳣�ṹռ�ö�ջ
  ADD  ESP   , 12            // �޸�ջ��ָ��
end;

  // �Ի���WM_INITDIALOG��Ϣ����
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  // ���ô���ͼ��
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_SUMMATION)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_SUMMATION)));

  // �������볤��
  SendMessage(GetDlgItem(hWnd, IDC_SUMNUM), EM_LIMITTEXT, 9, 0);

  // ����Ĭ�Ͻ���
  Result := TRUE;
end;

  // �Ի���WM_COMMAND��Ϣ����
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
var
  dwThreadId: DWORD;
  uSum: UINT;
  hThread: THandle;
begin
  case (id) of
    IDCANCEL:
      begin
        EndDialog(hWnd, id);
      end;

    IDC_CALC:
      begin
        // ȡ��������ֵ
        uSum := GetDlgItemInt(hWnd, IDC_SUMNUM, PBOOL(nil)^, FALSE);

        // ���������߳�
        hThread := BeginThread(nil, 0, @SumThreadFunc, Pointer(uSum), 0, dwThreadId);

        // �ȴ��߳̽���
        WaitForSingleObject(hThread, INFINITE);

        // �߳��˳����� (�����̺߳�������ֵ)
        GetExitCodeThread(hThread, uSum);

        // �ر��ں˶���
        CloseHandle(hThread);

        // ��ջ�Ƿ����
        if (uSum = UINT_MAX) then
        begin
          SetDlgItemText(hWnd, IDC_ANSWER, 'Error');
          MessageBox(0, 'The number is too big, please enter a smaller number', 'Summation', MB_OK);
        end else
          SetDlgItemInt(hWnd, IDC_ANSWER, uSum, FALSE);
      end;
  end;
end;

  // �Ի���ص�
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  case (uMsg) of
    WM_INITDIALOG:
      begin
        Result := BOOL(SetWindowLong(hWnd,
          DWL_MSGRESULT, Longint(Dlg_OnInitDialog(hWnd, wParam, lParam))));
      end;

    WM_COMMAND:
      begin
        Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));
        Result := TRUE;
      end;

    else
      Result := FALSE; // δ������ 
  end;
end;

  // ���߳����
begin
  DialogBox(HInstance, MakeIntResource(IDD_SUMMATION), 0, @Dlg_Proc);
end.
