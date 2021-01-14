program MsnHook;

{$R '..\Icon\Icon.Res'} // ͼ����Դ

uses
  Windows, Messages, ShellAPI;

const            
  WM_OURTRAY = WM_USER + 66; // ������Ϣ

var
  WM_TaskbarCreated: UINT; // �������ؽ�֪ͨ
  RecordHook: HHOOK; // ���Ӿ��
  HPopupMenu: HMENU; // �˵����
  IconData: TNotifyIconData; // ���̽ṹ
  Timer: Integer = 0; // �ۼ�ʱ��, ��Ϊ��λ
  State: Boolean = TRUE; // �Ƿ�'����'

  // ���庯��
function WindowProc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  MousePos: TPoint; // ���λ��
begin
  case (uMsg) of
    WM_TIMER:
      if (State = TRUE) then
      begin
        Inc(Timer);
        if (Timer >= 5) then // ����5����Ϊ�뿪
        begin
          State := FALSE;
          IconData.hIcon := LoadIcon(HInstance, 'Leave');
          IconData.uFlags := NIF_ICON;
          Shell_NotifyIcon(NIM_MODIFY, @IconData);
        end;
      end;

    WM_COMMAND: // ����˵�����
      case wParam of
        1: MessageBox(0, 'http://liumazi.axdisk.cn'#13#10#13#10'http://liumazi.ys168.com',
             ' MSN�����ж��û��Ƿ��뿪', MB_OK);
             
        2: PostQuitMessage(0);
      end;

    WM_OURTRAY:
      if (lParam = WM_LBUTTONUP) then // �������ʱ�����˵�
      begin
        GetCursorPos(MousePos);
        SetForegroundWindow(hWnd);
        TrackPopupMenu(HPopupMenu, TPM_LEFTALIGN or TPM_LEFTBUTTON,
          MousePos.X, MousePos.Y, 0, hWnd, nil);
      end;

    else
      if (uMsg = WM_TaskbarCreated) then // ��ʱ��Ҫ�ؽ�����
      begin
        IconData.uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
        Shell_NotifyIcon(NIM_ADD, @IconData);
      end;
  end;

  Result := DefWindowProc(hWnd, uMsg, wParam, lParam);
end;

  // ���Ӻ���
function JournalRecordProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  Msg: LongWord;
begin
  if (nCode = HC_ACTION) then // lParam ָ����Ϣ�ṹ
  begin
    Msg := PEventMsg(lParam)^.message;
    if ( (Msg >= WM_KEYFIRST) and (Msg <= WM_KEYLAST) ) or // ������Ϣ
       ( (Msg >= WM_MOUSEFIRST) and (Msg <= WM_MOUSELAST) ) then // �����Ϣ
    begin
      Timer := 0;
      if (State = FALSE) then // '�뿪' -> '����'
      begin
        State := TRUE;
        IconData.hIcon := LoadIcon(HInstance, 'Online');
        IconData.uFlags := NIF_ICON;
        Shell_NotifyIcon(NIM_MODIFY, @IconData);
      end;
    end;
  end;
    
  Result := CallNextHookEx(RecordHook, nCode, wParam, lParam); // ��һ������
end;

 // �������
const 
  ClassName = 'MsnHook_Mazi'; // ��������
var
  Msg: TMsg;
  WndClass: TWndClass;
  HMainWnd: HWND;
begin
 // ����������֪ͨ��Ϣ
  WM_TaskbarCreated := RegisterWindowMessage('TaskbarCreated');

 // ע�����
  with WndClass do
  begin
    Style       := 0;           // ����
    lpfnWndProc := @WindowProc; // �������
    cbClsExtra  := 0;           // ������ڴ�
    cbWndExtra  := 0;           // ��������ڴ�
    hIcon   := 0;               // ����ͼ��
    hCursor := 0;               // ������
    hbrBackground := 0;         // ������ˢ
    lpszMenuName  := nil;       // ����˵�
    lpszClassName := ClassName; // ��������
    hInstance := GetModuleHandle(nil); // ģ����
  end;
  RegisterClass(WndClass);

 // ��������
  HMainWnd := CreateWindowEx(0, ClassName, nil, 0, 0, 0, 0, 0, 0, 0, HInstance, nil);

 // �����˵�
  HPopupMenu := CreatePopupMenu();
  AppendMenu(HPopupMenu, MF_ENABLED or MF_STRING, 1, '&Abort');
  AppendMenu(HPopupMenu, MF_ENABLED or MF_STRING, 2, '&Quit');

 // �������
  with IconData do
  begin
    cbSize := SizeOf(IconData);
    Wnd := HMainWnd;
    uID := 66;
    uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
    uCallBackMessage := WM_OURTRAY;
    hIcon := LoadIcon(HInstance, 'Online');
    szTip := '��MSN�����ж��û��Ƿ��뿪   by ����';
  end;
  Shell_NotifyIcon(NIM_ADD, @IconData);

 // ��װʱ��
  SetTimer(HMainWnd, 6, 1000, nil);

 // ��װ����
  RecordHook := SetWindowsHookEx(WH_JOURNALRECORD, @JournalRecordProc, HInstance, 0);

 // ��Ϣѭ��
  while GetMessage(Msg, 0, 0, 0) do
  begin
    if (Msg.message = WM_CANCELJOURNAL) then // ��ʱ��Ҫ���¹ҹ�
      RecordHook := SetWindowsHookEx(WH_JOURNALRECORD, @JournalRecordProc, HInstance, 0)
    else
      DispatchMessage(Msg);
  end;

 // ж�ع���
  UnHookWindowsHookEx(RecordHook);

 // ɾ��ʱ��
  KillTimer(HMainWnd, 6);

 // ɾ���˵�
  DestroyMenu(HPopupMenu);

 // ɾ������
  Shell_NotifyIcon(NIM_DELETE, @IconData);

 // ɾ������
  DestroyWindow(HMainWnd);
end.
