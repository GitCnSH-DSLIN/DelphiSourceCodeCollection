unit Window_Unit;

interface

procedure Create_Window;

implementation

uses
  Windows, Messages, Public_Unit, Menu_Unit;

     // �����崰�����
function WindowProc(WinHanlde, MessageID, WParam, LParam: Longword): Longword; stdcall;
begin
  Result := DefWindowProc(WinHanlde, MessageID, WParam, LParam);
  if (MessageID = WM_COMMAND) then MenuCommand(wParam);
end;

    // ע�������崰����
function RegWindowClass: Boolean;
var
  WindowClass: TWndClass;
begin
  WindowClass.Style := CS_HREDRAW or CS_VREDRAW;
  WindowClass.lpfnWndProc := @WindowProc;
  WindowClass.cbClsExtra := 0;
  WindowClass.cbWndExtra := 0;
  WindowClass.hInstance := hInstance;
  WindowClass.hIcon := 0;
  WindowClass.hCursor := 0;
  WindowClass.hbrBackground := 0;
  WindowClass.lpszMenuName := nil;
  WindowClass.lpszClassName := WindowClassName;
  Result := RegisterClass(WindowClass) <> 0;
end;

    // ����������
procedure Create_Window;
begin
  if (not RegWindowClass) then
  begin
    MessageBox(0, 'RegWindowClass error !!' , nil, 0);
    PostQuitMessage(0);
  end;
  WindowHandle := CreateWindowEx(WS_EX_TOPMOST or WS_EX_TOOLWINDOW,
                                 WindowClassName, 'ProgressDemo  By ����',
                                 WS_VISIBLE or WS_POPUP , 300, 300,
                                 228, 13, 0, 0, hInstance, nil);
  if (WindowHandle = 0) then
  begin
    MessageBox(0, 'Create Window Error !!', nil, 0);
    PostQuitMessage(0);
  end;
end;

end.
