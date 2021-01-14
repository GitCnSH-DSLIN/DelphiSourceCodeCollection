
// Module name: SEHSoft.C ->> SEHSoft.dpr
// Notices: Copyright (c) 1995-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

program SEHSoft;

{$R 'SEHSoft.res' 'SEHSoft.rc'}

uses
  Windows, Messages,
  Other in '..\Other.pas', CmnHdr in '..\CmnHdr.pas', WindowsX in '..\WindowsX.pas';

const
  g_szModName = 'SEHSoft';
  IDD_SEHSOFT     =   1;
  IDC_NUMACCESSES = 100;
  IDC_LOG         = 101;
  IDI_SEHSOFT     = 101;

  // ����ṹ
type
  PElement = ^TElement;
  TElement = record
    bReserved: array[0..4*1024-1] of Byte;
  end;
  PArray = ^TArray;
  TArray = array[0..0] of TElement;

  // ���鳤��
const
  NUMELEMENTS  = 50;
  NUMBYTESINARRAY = SizeOf(TElement) * NUMELEMENTS;

  // �Զ����쳣����
const
  SE_ZERO_ELEM =
    (ERROR_SEVERITY_ERROR) or // ������(31~30)
    (1 shl 29) or             // �ͻ�/΢��(29)
    (0 shl 28) or             // ����(28)
    (FACILITY_NULL shl 16) or // �豸����(27~16)
    (1);                      // �쳣����(15~0)

  // ��չ��SEH�ڵ�
type
  PEstablisherFrame = ^TEstablisherFrame;
  TEstablisherFrame = record
    Prev: PEstablisherFrame;
    Handler: TfnPerThreadExcptionHandler;
    case Byte of
      1: (FinallyEip, FinallyEbp: DWORD);  // LeaveException
      2: (lpbArray: PByte; hWndLog: HWND); // EXCEPTION_ACCESS_VIOLATION
      3: (ExceptEip, ExceptEbp: DWORD; PExceptRec: PExceptionRecord); // SE_ZERO_ELEM
  end;

  // ����ǰ������
function ExpFilter(var lpEP: TExceptionPointers; lpbArray: PByte; lNumBytesInArray: DWORD; hWndLog: HWND): Integer; forward;

  // �߳��쳣�ص�
function ExceptHandler(var ExceptionRecord: TExceptionRecord; var EstablisherFrame: TEstablisherFrame;
  var ContextRecord: TContext; DispatcherContext: Pointer): TExceptionDisposition; cdecl;
var
  EPs: TExceptionPointers;
begin
  case ExceptionRecord.ExceptionCode of
    EXCEPTION_ACCESS_VIOLATION:
      begin
        EPs.ExceptionRecord := @ExceptionRecord;
        EPs.ContextRecord := @ContextRecord;
        
        Result := ExpFilter(EPs, EstablisherFrame.lpbArray, NUMBYTESINARRAY, EstablisherFrame.hWndLog) + 1; // **
      end;

    SE_ZERO_ELEM:
      begin
        EstablisherFrame.PExceptRec^ := ExceptionRecord;
        ContextRecord.Ebp := EstablisherFrame.ExceptEbp;
        ContextRecord.Eip := EstablisherFrame.ExceptEip;        
        ContextRecord.Esp := DWORD(@EstablisherFrame);

        Result := ExceptionContinueExecution;
      end;

    LeaveException:
      begin
        ContextRecord.Ebp := EstablisherFrame.FinallyEbp;
        ContextRecord.Eip := EstablisherFrame.FinallyEip;
        ContextRecord.Esp := DWORD(@EstablisherFrame);

        Result := ExceptionContinueExecution;
      end;

    else Result := ExceptionContinueSearch;
  end;
end;

  // �ύ�����ڴ�
procedure CommitMemory(hWndLog: HWND; var lpEP: TExceptionPointers; lpbAttemptedAddr: PByte);
var
  fAttemptedWrite: BOOL;
  szBuf: array[0..100] of Char;
begin
  // ��/д�����쳣
  fAttemptedWrite := BOOL(lpEP.ExceptionRecord.ExceptionInformation[0]);

  // ��ʾ��ListBox
  _wvsprintf(szBuf, '---> Committing memory (%s attempted)', [DWORD(IfThen(fAttemptedWrite, 'write', 'read'))]);
  ListBox_AddString(hWndLog, szBuf);

  // ���������ڴ�
  VirtualAlloc(lpbAttemptedAddr, SizeOf(TElement), MEM_COMMIT, PAGE_READWRITE);

  // �׳��Զ��쳣
  if (fAttemptedWrite = FALSE) then RaiseException(SE_ZERO_ELEM, 0, 1, @lpbAttemptedAddr); // **
end;

  // �쳣"������"
function ExpFilter(var lpEP: TExceptionPointers; lpbArray: PByte; lNumBytesInArray: DWORD; hWndLog: HWND): Integer;
label
  FinallyDo, ExceptDo, NoExcept;
var
  lpbAttemptedAddr: PByte;
  dwExceptionCode: DWORD;
  nFilterResult: Integer;
  SavedExceptRec: TExceptionRecord;
  lpArrayElementToZero: PElement;
begin
  asm
    MOV  nFilterResult, EXCEPTION_CONTINUE_SEARCH
  end;
  dwExceptionCode := lpEP.ExceptionRecord.ExceptionCode;

  // �쳣���� (LeaveException)
  asm
    PUSH EBP                  // TEstablisherFrame.FinallyEbp := EBP
    PUSH OFFSET FinallyDo     // TEstablisherFrame.FinallyEip := FinallyDo
    PUSH OFFSET ExceptHandler // TEstablisherFrame.Handler := @ExceptHandler
    PUSH FS:[0]               // TEstablisherFrame.Prev := TEB.ExceptionList
    MOV  FS:[0], ESP          // TEB.ExceptionList := @TEstablisherFrame
  end;

  // �쳣����
  if (dwExceptionCode <> EXCEPTION_ACCESS_VIOLATION) then _leave;

  // �����ַ
  if (lpbArray = nil) then _leave;

  // �����ַ
  lpbAttemptedAddr := Pointer(lpEP.ExceptionRecord.ExceptionInformation[1]);
  if (DWORD(lpbAttemptedAddr) < DWORD(lpbArray)) or
     (DWORD(lpbArray) + lNumBytesInArray <= DWORD(lpbAttemptedAddr))
  then _leave;

  // �쳣���� (SE_ZERO_ELEM)
  asm
    LEA  EAX, SavedExceptRec
    PUSH EAX                    // TEstablisherFrame.PExceptRec := @SavedExceptRec;
    PUSH EBP                    // TEstablisherFrame.ExceptEbp := EBP
    PUSH OFFSET ExceptDo        // TEstablisherFrame.ExceptEip := ExceptDo
    PUSH OFFSET ExceptHandler   // TEstablisherFrame.Handler := @ExceptHandler
    PUSH FS:[0]                 // TEstablisherFrame.Prev := TEB.ExceptionList
    MOV  FS:[0], ESP            // TEB.ExceptionList := @TEstablisherFrame
  end;

  // �ύ�ڴ�
  CommitMemory(hWndLog, lpEP, lpbAttemptedAddr);

  // û���쳣
  goto NoExcept;

  // �����쳣
ExceptDo:
  lpArrayElementToZero := PElement(SavedExceptRec.ExceptionInformation[0]);
  chINITSTRUCT(lpArrayElementToZero^, SizeOf(TElement), FALSE);
  ListBox_AddString(hWndLog, '---> Zeroed array element');

  // ȥ������ (SE_ZERO_ELEM)
NoExcept:
  asm
    POP  FS:[0]                 // TEB.ExceptionList := TEstablisherFrame.Prev;
    ADD  ESP, TYPE DWORD * 4    // �ָ�ջ��
  end;
  nFilterResult := EXCEPTION_CONTINUE_EXECUTION;

  // ȥ������ (LeaveException)
FinallyDo:
  asm
    POP  FS:[0]               // TEB.ExceptionList := TEstablisherFrame.Prev;
    ADD  ESP, TYPE DWORD * 3  // �ָ�ջ��
  end;

  Result := nFilterResult;
end;

  // ���ʱ����ڴ�
procedure Dlg_ReserveArrayAndAccessIt(hWndLog: HWND; nNumAccesses: Integer);
var
  lpArray: PArray;
  Element: TElement;
  szBuf: array[0..100] of Char;
  nElementNum: Integer;
begin
  // ��ʼִ��
  ListBox_ResetContent(hWndLog);
  ListBox_AddString(hWndLog, 'Execution started');

  // �����ڴ�
  lpArray := VirtualAlloc(nil, NUMBYTESINARRAY, MEM_RESERVE, PAGE_NOACCESS);

  // �쳣���� (EXCEPTION_ACCESS_VIOLATION)
  asm
    PUSH hWndLog              // TEstablisherFrame.hWndLog := hWndLog
    PUSH lpArray              // TEstablisherFrame.lpbArray := lpbArray
    PUSH OFFSET ExceptHandler // TEstablisherFrame.Handler := @ExceptHandler
    PUSH FS:[0]               // TEstablisherFrame.Prev := TEB.ExceptionList
    MOV  FS:[0], ESP          // TEB.ExceptionList := @TEstablisherFrame
  end;

  // �������
  while (nNumAccesses > 0) do
  begin
    Dec(nNumAccesses);
    nElementNum := Random(NUMELEMENTS);

    // ������д
    if (Random(2) = 0) then
    begin
      _wvsprintf(szBuf, 'Reading index: %d', [nElementNum]);
      ListBox_AddString(hWndLog, szBuf);

      Element := lpArray[nElementNum];
    end else
    begin
      _wvsprintf(szBuf, 'Writing index: %d', [nElementNum]);
      ListBox_AddString(hWndLog, szBuf);

      lpArray[nElementNum] := Element;
    end;
  end; // while

  // ȥ������ (EXCEPTION_ACCESS_VIOLATION)
  asm
    POP  FS:[0]               // TEB.ExceptionList := TEstablisherFrame.Prev;
    ADD  ESP, TYPE DWORD * 3  // �ָ�ջ��
  end;

  // �ͷ��ڴ�
  VirtualFree(lpArray, 0, MEM_RELEASE);

  // ִ�����
  ListBox_AddString(hWndLog, 'Execution ended');
end;

  // WM_INITDIALOG
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  chSETDLGICONS(hWnd, IDI_SEHSOFT, IDI_SEHSOFT);
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
          chMB('Invalid number of accesses.', g_szModName);
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
  chWARNIFUNICODEUNDERWIN95();
  DialogBox(HInstance, MakeIntResource(IDD_SEHSOFT), 0, @Dlg_Proc);
end.
