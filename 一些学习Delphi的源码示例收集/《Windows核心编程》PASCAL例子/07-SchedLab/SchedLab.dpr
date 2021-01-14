program SchedLab;

{$R 'SchedLab.res' 'SchedLab.rc'}

uses
  Windows, Messages;

const
  // �߳�Ȩ��
  THREAD_SUSPEND_RESUME = $0002;

  // ���ȼ���
  BELOW_NORMAL_PRIORITY_CLASS = $4000;
  ABOVE_NORMAL_PRIORITY_CLASS = $8000;

  // ģ��ID
  IDD_SCHEDLAB = 101;

  // ͼ��ID
  IDI_SCHEDLAB = 103;

  // �ؼ�ID
  IDC_PROCESSPRIORITYCLASS   = 1015;
  IDC_THREADRELATIVEPRIORITY = 1016;
  IDC_SLEEPTIME              = 1017;
  IDC_SUSPEND                = 1018;
  IDC_WORK                   = 1020;

  // �̺߳���
function ThreadFunc(pvParam: Pointer): Integer;
var
  hThreadPrimary: THandle;
begin
  // �������߳�
  hThreadPrimary := THandle(pvParam);
  SuspendThread(hThreadPrimary);

  // ������Ϣ��
  MessageBox(GetActiveWindow(),
    'The Primary thread is suspended.'#13#10 +
    'It no longer responds to input and produces no output.'#13#10 +
    'Press OK to resume the primary thread & exit this secondary thread.'#13#10,
    'SchedLab', 0);

  // �ָ����߳�
  ResumeThread(hThreadPrimary);
  CloseHandle(hThreadPrimary);

  // �ٻָ���ť
  EnableWindow(GetDlgItem(FindWindow(nil, 'Scheduling Lab'), IDC_SUSPEND), TRUE);
  
  Result := 0;
end;

  // �Ի���WM_INITDIALOG��Ϣ����
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
var
  hWndCtl: LongWord; // HWND
  n, nNormal: Integer;
  dwpc: DWORD;
begin
  // ���öԻ���ͼ��
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_SCHEDLAB)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_SCHEDLAB)));


  // 1.
  // �������ȼ��б�
  hWndCtl := GetDlgItem(hWnd, IDC_PROCESSPRIORITYCLASS);

  // ���'��'���ȼ�
  n := SendMessage(hWndCtl, CB_ADDSTRING, 0, Integer(PChar('High')));
  SendMessage(hWndCtl, CB_SETITEMDATA, n, HIGH_PRIORITY_CLASS);

  // ��ǰ�������ȼ�
  dwpc := GetPriorityClass(GetCurrentProcess());

  // ֧���µ����ȼ�
  if SetPriorityClass(GetCurrentProcess(), BELOW_NORMAL_PRIORITY_CLASS) then
  begin
    // �ָ��������ȼ�
    SetPriorityClass(GetCurrentProcess(), dwpc);

    // ���'��������'���ȼ�
    n := SendMessage(hWndCtl, CB_ADDSTRING, 0, Integer(PChar('Above normal')));
    SendMessage(hWndCtl, CB_SETITEMDATA, n, ABOVE_NORMAL_PRIORITY_CLASS);

    // ֧���µ����ȼ�
    dwpc := 0;
  end;

  // ���'����'���ȼ�
  n := SendMessage(hWndCtl, CB_ADDSTRING, 0, Integer(PChar('Normal')));
  SendMessage(hWndCtl, CB_SETITEMDATA, n, NORMAL_PRIORITY_CLASS);
  nNormal := n;

  // ֧���µ����ȼ�, �����'��������'���ȼ�
  if (dwpc = 0) then
  begin
    n := SendMessage(hWndCtl, CB_ADDSTRING, 0, Integer(PChar('Below normal')));
    SendMessage(hWndCtl, CB_SETITEMDATA, n, BELOW_NORMAL_PRIORITY_CLASS);
  end;

  // ���'����'���ȼ�
  n := SendMessage(hWndCtl, CB_ADDSTRING, 0, Integer(PChar('Idle')));
  SendMessage(hWndCtl, CB_SETITEMDATA, n, IDLE_PRIORITY_CLASS);

  // ѡ��'����'���ȼ�
  SendMessage(hWndCtl, CB_SETCURSEL, nNormal, 0);


  // 2.
  // �߳����ȼ��б�
  hWndCtl := GetDlgItem(hWnd, IDC_THREADRELATIVEPRIORITY);

  // ���'�ؼ�ʱ��'���ȼ�
  n := SendMessage(hWndCtl, CB_ADDSTRING, 0, Integer(PChar('Time critical')));
  SendMessage(hWndCtl, CB_SETITEMDATA, n, THREAD_PRIORITY_TIME_CRITICAL);

  // ���'���'���ȼ�
  n := SendMessage(hWndCtl, CB_ADDSTRING, 0, Integer(PChar('Highest')));
  SendMessage(hWndCtl, CB_SETITEMDATA, n, THREAD_PRIORITY_HIGHEST);

  // ���'��������'���ȼ�
  n := SendMessage(hWndCtl, CB_ADDSTRING, 0, Integer(PChar('Above normal')));
  SendMessage(hWndCtl, CB_SETITEMDATA, n, THREAD_PRIORITY_ABOVE_NORMAL);

  // ���'����'���ȼ�
  n := SendMessage(hWndCtl, CB_ADDSTRING, 0, Integer(PChar('Normal')));
  SendMessage(hWndCtl, CB_SETITEMDATA, n, THREAD_PRIORITY_NORMAL);
  nNormal := n;

  // ���'��������'���ȼ�
  n := SendMessage(hWndCtl, CB_ADDSTRING, 0, Integer(PChar('Below normal')));
  SendMessage(hWndCtl, CB_SETITEMDATA, n, THREAD_PRIORITY_BELOW_NORMAL);

  // ���'���'���ȼ�
  n := SendMessage(hWndCtl, CB_ADDSTRING, 0, Integer(PChar('Lowest')));
  SendMessage(hWndCtl, CB_SETITEMDATA, n, THREAD_PRIORITY_LOWEST);

  // ���'����'���ȼ�
  n := SendMessage(hWndCtl, CB_ADDSTRING, 0, Integer(PChar('Idle')));
  SendMessage(hWndCtl, CB_SETITEMDATA, n, THREAD_PRIORITY_IDLE);

  // ѡ��'����'���ȼ�
  SendMessage(hWndCtl, CB_SETCURSEL, nNormal, 0);


  // ����Edit����
  SendMessage(GetDlgItem(hWnd, IDC_SLEEPTIME), EM_LIMITTEXT, 4, 0);

  // ����Ĭ�Ͻ���
  Result := TRUE;
end;

  // �Ի���WM_COMMAND��Ϣ����
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
var
  hThreadPrimary: THandle;
  dwThreadID: DWORD;
begin
  case (id) of
    IDCANCEL: // Ҫ��ر�
      begin
        PostQuitMessage(0);
      end;

    IDC_PROCESSPRIORITYCLASS: // �������ȼ�
      if (codeNotify = CBN_SELCHANGE) then
      begin
        SetPriorityClass(GetCurrentProcess(),
          SendMessage(hWndCtl, CB_GETITEMDATA, SendMessage(hWndCtl, CB_GETCURSEL, 0, 0), 0));
      end;

    IDC_THREADRELATIVEPRIORITY: // �߳����ȼ�
      if (codeNotify = CBN_SELCHANGE) then
      begin
        SetThreadPriority(GetCurrentThread(),
          SendMessage(hWndCtl, CB_GETITEMDATA, SendMessage(hWndCtl, CB_GETCURSEL, 0, 0), 0));
      end;

    IDC_SUSPEND: // �������߳�
      begin
        // �����߳�ǰ���ð�ť
        EnableWindow(hWndCtl, FALSE);

        // ������ -> ʵ���
        DuplicateHandle(
          GetCurrentProcess(), GetCurrentThread(),
          GetCurrentProcess(), @hThreadPrimary,
          THREAD_SUSPEND_RESUME, FALSE, DUPLICATE_SAME_ACCESS);

        // �����̲߳����ټ���
        CloseHandle(BeginThread(nil, 0, @ThreadFunc, Pointer(hThreadPrimary), 0, dwThreadID));
      end;
  end;
end;

  // �Ի�����Ϣ����ص�
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
  hWnd, hWndWork: LongWord; // HWND
  Msg: TMsg;
  fQuit: BOOL = FALSE;
  s_n: Integer = -1;
  sz: array[0..20] of Char;
  nSleep: Integer;
begin
  // ��������
  hWnd := CreateDialog(HInstance, MakeIntResource(IDD_SCHEDLAB), 0, @Dlg_Proc);

  // ��Ϣѭ��
  while (not fQuit) do
  begin
    // �Ӷ���ȡ����Ϣ
    if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
    begin
      // ����'�Ի�����Ϣ'
      if (not IsDialogMessage(hWnd, Msg)) then
      begin
        if (Msg.message <> WM_QUIT) then
        begin
          TranslateMessage(Msg);
          DispatchMessage(Msg);
        end else
          fQuit := TRUE;  // ѭ��������־
      end;
    end else
    begin
      // ��������ַ�����ListBox
      Inc(s_n);
      wvsprintf(sz, '%u', @s_n);
      hWndWork := GetDlgItem(hWnd, IDC_WORK);
      SendMessage(hWndWork, LB_SETCURSEL, SendMessage(hWndWork, LB_ADDSTRING, 0, Integer(@sz[0])), 0);

      // �Ƴ�ListBox������Ŀ
      while (SendMessage(hWndWork, LB_GETCOUNT, 0, 0) > 100) do
        SendMessage(hWndWork, LB_DELETESTRING, 0, 0);

      // ����Editָ��������
      nSleep := GetDlgItemInt(hWnd, IDC_SLEEPTIME, PBOOL(nil)^, FALSE);
      if (nSleep >= 1) and (nSleep <= 9999) then Sleep(nSleep);
    end;
  end;

  // �������
  DestroyWindow(hWnd);
end.
