program UseHook;

{$R '..\Res\Icon.Res'} // ͼ����Դ

uses
  Windows, Messages, ShellAPI;

const
  WM_TRAY = WM_USER + 66; // �Զ���������Ϣ

var
  WM_TaskbarCreated: UINT; // �������ؽ�֪ͨ
  HPopupMenu: HMENU; // ����ʽ�˵����
  IconData: TNotifyIconData; // ���̽ṹ

 // ���붯̬���ӿ⺯��
procedure  HookOn(); external '..\DLL\KeyHook.dll';
procedure HookOff(); external '..\DLL\KeyHook.dll';

 // ������̻ص�����
function WindowProc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  MousePos: TPoint; // ���λ��
begin
  case (uMsg) of
    WM_COMMAND:
      case (wParam)  of
        1: begin
             EnableMenuItem(HPopupMenu, 1, MF_GRAYED);  // ����
             EnableMenuItem(HPopupMenu, 2, MF_ENABLED); // ����

             IconData.hIcon := LoadIcon(HInstance, 'Enable');
             IconData.uFlags := NIF_ICON;
             Shell_NotifyIcon(NIM_MODIFY, @IconData);

             HookOn();
           end;

        2: begin
             EnableMenuItem(HPopupMenu, 1, MF_ENABLED); // ����
             EnableMenuItem(HPopupMenu, 2, MF_GRAYED);  // ����

             IconData.hIcon := LoadIcon(HInstance, 'Disable');
             IconData.uFlags := NIF_ICON;
             Shell_NotifyIcon(NIM_MODIFY, @IconData);

             HookOff();
             PostMessage(HWND_BROADCAST, WM_WININICHANGE, 0, 0);
           end;

        3: MessageBox(0,
             ' http://liumazi.axdisk.cn'#13#10#13#10' http://liumazi.ys168.com',
             'ģ�����뷨С����  by ����', MB_OK);

        4: PostQuitMessage(0);
      end;

    WM_TRAY:
      if (lParam = WM_LBUTTONUP) or (lParam = WM_RBUTTONUP) then
      begin
        GetCursorPos(MousePos);
        
        SetForegroundWindow(hWnd);

        TrackPopupMenu(HPopupMenu, TPM_LEFTALIGN or TPM_LEFTBUTTON,
          MousePos.X, MousePos.Y, 0, hWnd, nil);
      end;

    else
      if (uMsg = WM_TaskbarCreated) then
      begin
        IconData.uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
        Shell_NotifyIcon(NIM_ADD, @IconData);
      end;
  end;
  
  Result := DefWindowProc(hWnd, uMsg, wParam, lParam);
end;

 // �������
const
  ClassName = 'ShuRuFa_Mazi';
var
  Msg: TMsg;
  WndClass: TWndClass;
  HMainWnd: HWND;
begin
 // ��ֹ�ظ�����
  if (Findwindow(ClassName, nil) <> 0) then
  begin
    MessageBox(0, '����������.... :-)  ', '', MB_OK);
    Exit;
  end;

 // ����������
  WM_TaskbarCreated := RegisterWindowMessage('TaskbarCreated');

 // ע�ᴰ����
  with WndClass do
  begin
    Style       := 0;     // ����
    lpfnWndProc := @WindowProc; // �������
    cbClsExtra  := 0;     // �����ռ�
    cbWndExtra  := 0;     // �������ռ�
    hIcon   := 0;         // ����ͼ��
    hCursor := 0;         // ������
    hbrBackground := 0;   // ������ˢ
    lpszMenuName  := nil; // ����˵�
    lpszClassName := ClassName; // ����
    hInstance := SysInit.HInstance; // ʵ�����
  end;
  RegisterClass(WndClass);

 // ��������
  HMainWnd := CreateWindow(ClassName, nil, 0, 0, 0, 0, 0, 0, 0, HInstance, nil);

 // �����˵�
  HPopupMenu := CreatePopupMenu();
  AppendMenu(HPopupMenu, MF_GRAYED or MF_STRING, 1, '&Enable');
  AppendMenu(HPopupMenu, MF_ENABLED or MF_STRING, 2, '&Disable');
  AppendMenu(HPopupMenu, MF_ENABLED or MF_STRING, 3, '&Abort');
  AppendMenu(HPopupMenu, MF_ENABLED or MF_STRING, 4, 'E&xit');

 // �������
  with IconData do
  begin
    cbSize := SizeOf(IconData);
    Wnd := HMainWnd;
    uID := 66;
    uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
    uCallBackMessage := WM_TRAY;
    hIcon := LoadIcon(HInstance, 'Enable');
    szTip := 'ģ�����뷨С����   by ����';
  end;
  Shell_NotifyIcon(NIM_ADD, @IconData);

 // ��װ����
  HookOn();

 // ��Ϣѭ��
  while GetMessage(Msg, 0, 0, 0) do DispatchMessage(Msg);

 // ж�ع���
  HookOff();
  PostMessage(HWND_BROADCAST, WM_WININICHANGE, 0, 0);  

 // �������
  Shell_NotifyIcon(NIM_DELETE, @IconData);

 // ����˵�
  DestroyMenu(HPopupMenu);

 // �������
  DestroyWindow(HMainWnd);
end.
