program Counter;

{$R 'Counter.res' 'Counter.rc'}

uses Windows, Messages;

const
  IDD_COUNTER =  101; // ��ԴID..
  IDI_COUNTER =  102;
  IDC_FIBER  =  1000; // �ؼ�ID..
  IDC_ANSWER =  1001;
  IDC_COUNT  =  1002;

type
  TBkGndProcState = (
    BPS_STARTOVER,    // ���¼���
    BPS_CONTINUE,     // ���ڼ���
    BPS_DONE       ); // �������

  TFiberInfo = record
    pFiberUI: Pointer;    // �����˳�ִ�л���
    hWnd: HWND;           // ���洰�ھ��
    bps: TBkGndProcState; // ��̨����״̬
  end;

var
  g_FiberInfo: TFiberInfo;

  // �����˳��˳̺���
procedure FiberFunc(var pFiberInfo: TFiberInfo); stdcall;
var
  nCount, x: Integer;
begin
  SetDlgItemText(pFiberInfo.hWnd, IDC_FIBER, 'Recalculation');
  nCount := GetDlgItemInt(pFiberInfo.hWnd, IDC_COUNT, PBool(nil)^, FALSE);

  for x := 0 to nCount do
  begin
    // ���û������˳�ӵ�бȼ����˳̸��ߵ�����Ȩ
    // ����������κε���Ϣ, �л����û������˳�
    if (HIWORD(GetQueueStatus(QS_ALLEVENTS)) <> 0) then
    begin
      // ��ͣ����ִ��, �л����û������˳�
      SwitchToFiber(pFiberInfo.pFiberUI);

      // �����˳̴�����Ϣ���, ���л�����
      SetDlgItemText(pFiberInfo.hWnd, IDC_FIBER, 'Recalculation');
    end;

    SetDlgItemInt(pFiberInfo.hWnd, IDC_ANSWER, x, FALSE);
    Sleep(200);
  end;

  // �������, �л��������˳�
  pFiberInfo.bps := BPS_DONE;
  SwitchToFiber(pFiberInfo.pFiberUI);
end;

  // WM_INITDIALOG����
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): Bool;
begin
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_COUNTER)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_COUNTER)));

  SetDlgItemInt(hWnd, IDC_COUNT, 0, FALSE);

  Result := TRUE;
end;

  // WM_COMMAND����
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
begin
  case (id) of
    IDCANCEL: PostQuitMessage(0); // ʹ����Ϣѭ������
    IDC_COUNT: if (codeNotify = EN_CHANGE) then g_FiberInfo.bps := BPS_STARTOVER; // ���¼���
  end;
end;

  // �Ի���ص�����
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  Result := FALSE;

  case (uMsg) of
    WM_INITDIALOG:
      Result := SetWindowLong(hWnd, DWL_MSGRESULT, Longint(Dlg_OnInitDialog(hWnd, wParam, lParam))) <> 0;

    WM_COMMAND:
      Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));
  end;
end;

  // �������߳����
var
  pFiberCounter: Pointer = nil; // �����˳�ִ�л���
  fQuit: Bool = FALSE; // ֹͣ��Ϣѭ��
  Msg: TMsg;
begin
  // ת���߳�Ϊ�˳�
  g_FiberInfo.pFiberUI := Pointer(ConvertThreadToFiber(nil));

  // ��������������
  g_FiberInfo.hWnd := CreateDialog(HInstance, MakeIntResource(IDD_COUNTER), 0, @Dlg_Proc);

  // ����"�����˳�"
  SetDlgItemText(g_FiberInfo.hWnd, IDC_FIBER, 'User interface');

  // Ŀǰ���������
  g_FiberInfo.bps := BPS_DONE;

  // ��ʵ����Ϣѭ��
  while (not fQuit) do
  begin
    if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
    begin
      // ��WM_QUIT����ѭ��
      fQuit := (Msg.message = WM_QUIT);

      // ������Ϣ(�ַ�ת��)
      if (not IsDialogMessage(g_FiberInfo.hWnd, Msg)) then
      begin
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end else
    begin
      // û����Ϣ��Ҫ����

      // ����̨����״̬
      case (g_FiberInfo.bps) of
        BPS_DONE:
          begin
            WaitMessage(); // ����ȴ�, ֱ������Ϣ�������
          end;

        BPS_STARTOVER,
        BPS_CONTINUE:
          begin
            if (g_FiberInfo.bps = BPS_STARTOVER) then
            begin
              // ɾ���ϵļ����˳�
              if (pFiberCounter <> nil) then
              begin
                DeleteFiber(pFiberCounter);
                pFiberCounter := nil;
              end;

              // �����µļ����˳�
              pFiberCounter := Pointer(CreateFiber(0, @FiberFunc, @g_FiberInfo));

              // ״̬Ϊ: ���ڼ���
              g_FiberInfo.bps := BPS_CONTINUE;
            end;

            // ��ִͣ��, �л��������˳�
            SwitchToFiber(pFiberCounter);

            // ��ʱ�ѴӼ����˳��л�����
            SetDlgItemText(g_FiberInfo.hWnd, IDC_FIBER, 'User interface');

            // �������, ��ɾ�������˳�
            if (g_FiberInfo.bps = BPS_DONE) then
            begin
              DeleteFiber(pFiberCounter);
              pFiberCounter := nil;
            end;
          end;
      end; // END: case of ..
    end;
  end; // END: while do ..

  // �������������
  DestroyWindow(g_FiberInfo.hWnd);
end.
