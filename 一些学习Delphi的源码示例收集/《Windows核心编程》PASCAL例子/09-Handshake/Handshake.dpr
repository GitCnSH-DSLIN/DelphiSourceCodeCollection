program Handshake;

{$R 'Handshake.res' 'Handshake.rc'}

uses
  Windows, Messages;

const
  IDD_HANDSHAKE = 101; // ģ����ԴID
  IDI_HANDSHAKE = 102; // ͼ����ԴID
  IDC_REQUEST  = 1000; // �ӿؼ�ID..
  IDC_RESULT   = 1001;
  IDC_SUBMIT   = 1002;
  g_szServerShutdown = 'Server Shutdown'; // (�����߳�)������ʶ

var
  g_hevtRequestSubmitted: THandle; // �����̵߳ȴ��ͻ��߳�����(�¼�����)
  g_hevtResultReturned: THandle;   // �ͻ��̵߳ȴ������̷߳���(�¼�����)
  g_szSharedRequestAndResultBuffer: array[0..1024] of Char; // (�̼߳�)�����ڴ��

  // ��ת�ַ���
procedure ReverseString(S: PChar);
var
  T: Char;
  E: PChar;
begin
  E := S;
  while (E^ <> #0) do Inc(E);
  Dec(E);

  while (S < E) do
  begin
    T  := S^;
    S^ := E^;
    E^ := T;

    Dec(E);
    Inc(S);
  end;
end;

  // �����̻߳ص�
function ServerThread(pvParam: Pointer): Integer;
var
  fShutdown: BOOL;
begin
  fShutdown := FALSE;

  while (fShutdown = FALSE) do
  begin
    // �ȴ��ύ����
    WaitForSingleObject(g_hevtRequestSubmitted, INFINITE);

    // �Ƿ������ʶ
    fShutdown := (lstrcmpi(g_szSharedRequestAndResultBuffer, g_szServerShutdown) = 0);

    // ����ת����
    if (fShutdown = FALSE) then ReverseString(g_szSharedRequestAndResultBuffer);

    // ���ؿͻ��߳�
    SetEvent(g_hevtResultReturned);
  end;

  Result := 0;
end;

  // �Ի���WM_INITDIALOG����
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  // ���ô���ͼ��
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_HANDSHAKE)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_HANDSHAKE)));

  // ���ÿؼ�����
  SetWindowText(GetDlgItem(hWnd, IDC_REQUEST), 'Some test data');

  // ����Ĭ�Ͻ���
  Result := TRUE;
end;

  // �Ի���WM_COMMAND����
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
begin
  case (id) of
    IDCANCEL: // Ҫ��ر�
      begin
        EndDialog(hWnd, id);
      end;

    IDC_SUBMIT: // ��ť
      begin
        // ����������ַ���
        GetWindowText(GetDlgItem(hWnd, IDC_REQUEST), g_szSharedRequestAndResultBuffer, 1024);

        // ֪ͨ�����̴߳���
        SetEvent(g_hevtRequestSubmitted);

        // ����ȴ��������
        WaitForSingleObject(g_hevtResultReturned, INFINITE);

        // ��ʾ�Ѵ����ַ���
        SetWindowText(GetDlgItem(hWnd, IDC_RESULT),  g_szSharedRequestAndResultBuffer);
      end;
  end;
end;

  // �Ի�����Ϣ�ص�
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

  // ���߳�(�ͻ��߳�)���
var
  dwThreadID: DWORD;
  hThreadServer: THandle;
  h: array[0..1] of THandle;
begin
  // ���������Զ������¼�����Ԥ��Ϊ'δ֪ͨ'״̬
  g_hevtRequestSubmitted := CreateEvent(nil, FALSE, FALSE, nil);
  g_hevtResultReturned := CreateEvent(nil, FALSE, FALSE, nil);

  // ����һ�������߳�
  hThreadServer := BeginThread(nil, 0, @ServerThread, nil, 0, dwThreadID);

  // ��ʾ�ͻ��߳̽���
  DialogBox(HInstance, MakeIntResource(IDD_HANDSHAKE), 0, @Dlg_Proc);

  // ֪ͨ�����߳̽���
  lstrcpy(g_szSharedRequestAndResultBuffer, g_szServerShutdown);
  SetEvent(g_hevtRequestSubmitted);

  // �ȴ������߳̽���
  h[0] := g_hevtResultReturned;
  h[1] := hThreadServer;
  WaitForMultipleObjects(2, @h[0], TRUE, INFINITE);

  // �ر��ں˶�����
  CloseHandle(hThreadServer);
  CloseHandle(g_hevtRequestSubmitted);
  CloseHandle(g_hevtResultReturned);
end.
