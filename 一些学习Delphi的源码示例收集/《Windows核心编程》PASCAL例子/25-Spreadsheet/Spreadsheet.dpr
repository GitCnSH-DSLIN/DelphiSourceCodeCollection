program Spreadsheet;

{$R 'Spreadsheet.res' 'Spreadsheet.rc'}

uses Windows, Messages, VMArray in 'VMArray.pas';

const
  IDD_SPREADSHEET = 1;
  IDI_SPREADSHEET = 102;
  IDC_LOG       = 101;
  IDC_ROW       = 1001;
  IDC_COLUMN    = 1002;
  IDC_VALUE     = 1003;
  IDC_READCELL  = 1004;
  IDC_WRITECELL = 1005;
  g_nNumRows = 256;
  g_nNumCols = 1024;

  // ���洰�ھ��
var g_hWnd: HWND;

  // ���ӱ��Ԫ
type
  PCell = ^TCell;
  TCell = packed record
    dwValue: DWORD;
    bDummy: array[1..1020] of Byte;
  end;

  // ���ӱ������
type
  PSpreadSheet = ^TSpreadSheet;
  TSpreadSheet = array[0..g_nNumRows-1] of array[0..g_nNumCols-1] of TCell;

  // ���ӱ����
type
  TVMSpreadsheet = class(TVMArray)
  public
    constructor Create();
  protected
    function OnAccessViolation(pvAddrTouched: Pointer; fAttemptedRead: BOOL; // �µ��޸�����
      var pep: TExceptionPointers; fRetryUntilSuccessful: BOOL): LongInt; override;
  end;

constructor TVMSpreadsheet.Create();
begin
  inherited Create(SizeOf(TCell), g_nNumRows * g_nNumCols);
end;

function TVMSpreadsheet.OnAccessViolation(pvAddrTouched: Pointer; fAttemptedRead: BOOL;
  var pep: TExceptionPointers; fRetryUntilSuccessful: BOOL): LongInt;
begin
  if fAttemptedRead then
  begin
    SetDlgItemText(g_hWnd, IDC_LOG, 'Violation: Attempting to Read');
    Result := EXCEPTION_EXECUTE_HANDLER;
  end else
  begin
    SetDlgItemText(g_hWnd, IDC_LOG, 'Violation: Attempting to Write');
    Result := inherited OnAccessViolation(pvAddrTouched, fAttemptedRead, pep, fRetryUntilSuccessful);
  end;
end;

var
  g_ssObject: TVMSpreadsheet; // ���ӱ�����
  g_ss: PSpreadSheet = nil; // ��������׵�ַ

  // WM_INITDIALOG
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_SPREADSHEET)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_SPREADSHEET)));

  g_hWnd := hWnd;

  SendMessage(GetDlgItem(hWnd, IDC_ROW), EM_LIMITTEXT, 3, 0);
  SendMessage(GetDlgItem(hWnd, IDC_COLUMN), EM_LIMITTEXT, 4, 0);
  SendMessage(GetDlgItem(hWnd, IDC_VALUE), EM_LIMITTEXT, 7, 0);
  SetDlgItemInt(hWnd, IDC_ROW, 100, FALSE);
  SetDlgItemInt(hWnd, IDC_COLUMN, 100, FALSE);
  SetDlgItemInt(hWnd, IDC_VALUE, 12345, FALSE);

  Result := TRUE;
end;

  // ��ֵ��Χ�ж�
function chInRange(const AMin, AValue, AMax: Integer): Boolean;
begin
  Result := (AValue >= AMin) and (AValue <= AMax);
end;

  // �߳��쳣�ص�
function ThreadExceptHandler(var ExceptionRecord: TExceptionRecord; var EstablisherFrame: TExceptionRegistration;
  var ContextRecord: TContext; DispatcherContext: Pointer): DWORD; Cdecl;
const
  ExceptionContinueExecution = 0;
  ExceptionContinueSearch = 1;
var
  ExceptionPointers: TExceptionPointers;
  FilterResult: LongInt;
begin
  ExceptionPointers.ExceptionRecord := @ExceptionRecord;
  ExceptionPointers.ContextRecord := @ContextRecord;
  FilterResult := g_ssObject.ExceptionFilter(ExceptionPointers, FALSE);

  case FilterResult of
    EXCEPTION_EXECUTE_HANDLER: // ����except���ִ��
      begin
        ContextRecord.Eip := DWORD(EstablisherFrame.ExceptionAddress);
        ContextRecord.Esp := DWORD(@EstablisherFrame);
        Result := ExceptionContinueExecution;
      end;

    EXCEPTION_CONTINUE_EXECUTION: // ����ִ�г���ָ��
      begin
        Result := ExceptionContinueExecution;
      end;

    EXCEPTION_CONTINUE_SEARCH: // δ������
      begin
        Result := ExceptionContinueSearch;
      end;

    else Result := ExceptionContinueSearch;
  end;
end;
  
  // WM_COMMAND
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
label
  On_Except, No_Except;
var
  nRow, nCol: Integer;
begin
  case (id) of
    IDCANCEL: // Ҫ��ر�
      begin
        EndDialog(hWnd, id);
      end;

    IDC_ROW: // �к�(�ı�֪ͨ)
      begin
        nRow := GetDlgItemInt(hWnd, IDC_ROW, PBOOL(nil)^, FALSE);
        EnableWindow(GetDlgItem(hWnd, IDC_READCELL), chInRange(0, nRow, g_nNumRows - 1));
        EnableWindow(GetDlgItem(hWnd, IDC_WRITECELL), chInRange(0, nRow, g_nNumRows - 1));
      end;

    IDC_COLUMN: // �к�(�ı�֪ͨ)
      begin
        nCol := GetDlgItemInt(hWnd, IDC_COLUMN, PBOOL(nil)^, FALSE);
        EnableWindow(GetDlgItem(hWnd, IDC_READCELL), chInRange(0, nCol, g_nNumCols - 1));
        EnableWindow(GetDlgItem(hWnd, IDC_WRITECELL), chInRange(0, nCol, g_nNumCols - 1));
      end;

    IDC_READCELL: // ������
      begin
        SetDlgItemText(g_hWnd, IDC_LOG, 'No violation raised');
        nRow := GetDlgItemInt(hWnd, IDC_ROW, PBOOL(nil)^, FALSE);
        nCol := GetDlgItemInt(hWnd, IDC_COLUMN, PBOOL(nil)^, FALSE);

        // �쳣����
        asm
          PUSH OFFSET On_Except           // TExceptionRegistration.ExceptionAddress := On_Except;
          PUSH OFFSET ThreadExceptHandler // TExceptionRegistration.ExceptionHandler := @ThreadExceptHandler;
          PUSH FS:[0]                     // TExceptionRegistration.PrevStruct := TEB.ExceptionList;
          MOV  FS:[0], ESP                // TEB.ExceptionList := @TExceptionRegistration;
        end;

        // ���ܳ���
        SetDlgItemInt(hWnd, IDC_VALUE, g_ss[nRow][nCol].dwValue, FALSE);

        // û�г���
        asm
          JMP No_Except
        end;

        // �쳣����
      On_Except:
        SetDlgItemText(hWnd, IDC_VALUE, ''); // ���Edit, ��ʾ�˴���δ���������ڴ�

        // ��β����
      No_Except:
        asm
          POP  FS:[0]                     // TEB.ExceptionList := TExceptionRegistration.PrevStruct;
          ADD  ESP, TYPE Pointer * 2      // �ָ�ջ��(��ǰ���PUSH��Ӧ)
        end;
      end;

    IDC_WRITECELL: // д����
      begin
        SetDlgItemText(g_hWnd, IDC_LOG, 'No violation raised');
        nRow := GetDlgItemInt(hWnd, IDC_ROW, PBOOL(nil)^, FALSE);
        nCol := GetDlgItemInt(hWnd, IDC_COLUMN, PBOOL(nil)^, FALSE);

        // ���õ�ַ����ҳ��δ���������ڴ�, ִ��д��ָ������쳣,
        // ���ǵĶ����쳣����ص���: 1.�ύ 2.�ӳ���ָ�����ִ��
        g_ss[nRow][nCol].dwValue := GetDlgItemInt(hWnd, IDC_VALUE, PBOOL(nil)^, FALSE);
      end;
   end;
end;

  // �Ի���ص�
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  case (uMsg) of
    WM_INITDIALOG:
      begin
        Result :=
          SetWindowLong(hWnd, DWL_MSGRESULT, Longint(Dlg_OnInitDialog(hWnd, wParam, lParam))) <> 0;
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
  g_ssObject := TVMSpreadsheet.Create();
  g_ss := g_ssObject.VMPointer;

  if (g_ss = nil) then
    MessageBox(0, 'Reserves a range failure.', 'Spreadsheet', MB_OK)
  else begin
    TVMArray.RemoveCurrentThreadOtherSEH();
    DialogBox(HInstance, MakeIntResource(IDD_SPREADSHEET), 0, @Dlg_Proc);
  end;

  g_ssObject.Free;
end.
