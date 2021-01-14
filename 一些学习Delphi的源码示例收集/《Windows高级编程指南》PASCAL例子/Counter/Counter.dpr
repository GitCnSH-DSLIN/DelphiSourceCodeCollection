
// Module name: Counter.c ->> Counter.dpr
// Notices: Copyright (c) 1996-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

program Counter;

{$R 'Counter.res' 'Counter.rc'}

uses Windows, Messages, CmnHdr in '..\CmnHdr.pas', WindowsX in '..\WindowsX.pas';

const
  IDD_COUNTER =  101;
  IDI_COUNTER =  102;
  IDC_FIBER   = 1000;
  IDC_ANSWER  = 1001;
  IDC_COUNT   = 1002;

  // �����˳�״̬
type
  TBkgndProcState = (BPS_STARTOVER, BPS_CONTINUE, BPS_DONE);

type
  PFiberInfo = ^TFiberInfo;
  TFiberInfo = record
    pFiberUI: Pointer; // �����˳̻�����
    hWnd: DWORD;       // ����Ի�����
    bps: TBkgndProcState; // �����˳�״̬
  end;

  // �˳̹�����Ϣ
var
  g_FiberInfo: TFiberInfo;

  // �����˳̻ص�
procedure Counter_FiberFunc(var pFiberInfo: TFiberInfo); stdcall;
var
  fTranslated: BOOL;
  x, nCount: Integer;
begin
  SetDlgItemText(pFiberInfo.hWnd, IDC_FIBER, 'Recalculation');

  nCount := GetDlgItemInt(pFiberInfo.hWnd, IDC_COUNT, fTranslated, FALSE);
  for x := 0 to nCount do
  begin
    // ����Ϣ���л��������˳�
    if (HIWORD(GetQueueStatus(QS_ALLEVENTS)) <> 0) then
    begin
      SwitchToFiber(pFiberInfo.pFiberUI);
      SetDlgItemText(pFiberInfo.hWnd, IDC_FIBER, 'Recalculation');
    end;

    SetDlgItemInt(pFiberInfo.hWnd, IDC_ANSWER, x, FALSE);
    Sleep(150);
  end;

  // �������, �л��������˳�
  pFiberInfo.bps := BPS_DONE;
  SwitchToFiber(pFiberInfo.pFiberUI);
end;

  // WM_INITDIALOG
function Counter_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  chSETDLGICONS(hWnd, IDI_COUNTER, IDI_COUNTER);
{$IfDef DEBUG}
  SetWindowPos(hWnd, 0, 0, 0, 0, 0, SWP_NOZORDER or SWP_NOSIZE);
{$EndIf}
  SetDlgItemInt(hWnd, IDC_COUNT, 0, FALSE);
  Result := TRUE;
end;

  // WM_COMMAND
procedure Counter_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
begin
  case (id) of
    IDCANCEL: DestroyWindow(hWnd); // ��Ϣѭ��ֹͣ
    IDC_COUNT: if (codeNotify = EN_CHANGE) then g_FiberInfo.bps := BPS_STARTOVER; // ���¼���
  end;
end;

  // �Ի���ص�
function Counter_DlgProc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  case (uMsg) of
    WM_INITDIALOG:
      begin
        Result := SetDlgMsgResult(hWnd, LRESULT(Counter_OnInitDialog(hWnd, wParam, lParam)));
      end;

    WM_COMMAND:
      begin
        Counter_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));
        Result := TRUE;
      end;

    else Result := FALSE;
  end;
end;

  // �������
var
  pFiberCounter: Pointer = nil;
  msg: TMsg;  
begin
  chWARNIFUNICODEUNDERWIN95();

  // ת��Ϊ�˳�
  g_FiberInfo.pFiberUI := Pointer(ConvertThreadToFiber(nil));

  // �����Ի���
  g_FiberInfo.hwnd := CreateDialog(HInstance, MakeIntResource(IDD_COUNTER), 0, @Counter_DlgProc);

  SetDlgItemText(g_FiberInfo.hWnd, IDC_FIBER, 'User-interface');
  g_FiberInfo.bps := BPS_DONE;

  // �Ի������
  while IsWindow(g_FiberInfo.hWnd) do
  begin
    if PeekMessage(msg, 0, 0, 0, PM_REMOVE) then
    begin
      if (IsDialogMessage(g_FiberInfo.hWnd, msg) = FALSE) then
      begin
        TranslateMessage(msg);
        DispatchMessage(msg);
      end;
    end else
    begin
      case (g_FiberInfo.bps) of
        BPS_DONE: // �������
          begin
            WaitMessage();
          end;

        BPS_STARTOVER: // ��ͷ����
          begin
            if (pFiberCounter <> nil) then
            begin
              DeleteFiber(pFiberCounter);
              pFiberCounter := nil;
            end;

            pFiberCounter := Pointer(CreateFiber(0, @Counter_FiberFunc, @g_FiberInfo));
            g_FiberInfo.bps := BPS_CONTINUE;

            // goto BPS_CONTINUE;
          end;

        BPS_CONTINUE: // ��������
          begin
            SwitchToFiber(pFiberCounter);

            SetDlgItemText(g_FiberInfo.hWnd, IDC_FIBER, 'User-interface');
            if (g_FiberInfo.bps = BPS_DONE) then
            begin
              DeleteFiber(pFiberCounter);
              pFiberCounter := nil;
            end
          end;
      end; // END: case (g_FiberInfo.bps) of ...
    end;
  end; // END: while IsWindow(g_FiberInfo.hWnd) do ...
end.
