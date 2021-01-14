unit Status_Unit;

interface

procedure Create_Status;

implementation

uses
  Windows, Messages, Public_Unit, Menu_Unit;

var
  Old_StatusProc  : Pointer;    // ����ָ��
  HandCursorHandle: Longword;   // �����

    // �Զ�����������ڹ���
function StatusProc(WinHanlde, MessageID, WParam, LParam: LongWord): Longint; stdcall;
begin
 //....����Ĭ�ϴ������....
  Result := CallWindowProc(Old_StatusProc, WinHanlde , MessageID, wParam, lParam);
 //....ģ�������������������....
  if (MessageID = WM_LBUTTONDOWN) then SendMessage(WindowHandle, WM_NCLBUTTONDOWN, HTCAPTION, LParam)
  else if (MessageID = WM_RBUTTONDOWN) then PopupTheMenu;
 //....�������������....
  SetCursor(HandCursorHandle);
end;

   // �����������ؼ�
procedure Create_Status;
begin
  StatusHandle := CreateWindowEx(0, 'msctls_progress32', '',
                                WS_CHILD or WS_VISIBLE,
                                -1, -1, 230, 15, WindowHandle,
                                0, hInstance, nil);
  if (StatusHandle = 0) then
  begin
    MessageBox(WindowHandle, 'Create Status error !!', nil, 0);
    PostQuitMessage(0);
  end;
  HandCursorHandle := LoadCursor(0, IDC_HAND);                   // ���ι��
  SendMessage(StatusHandle, PBM_SETBKCOLOR, 0, RGB(0, 0, 0));    // ������ɫ
  SendMessage(StatusHandle, PBM_SETBARCOLOR, 0, RGB(0, 0, 255)); // ��������ɫ
  SendMessage(StatusHandle, PBM_SETRANGE, 0, MakeLParam(0, 33)); // ���÷�Χ
  SendMessage(StatusHandle, PBM_SETSTEP, 1, 0);                  // ���ò���
  Old_StatusProc := Pointer( SetWindowLong(StatusHandle,         // �´������
                            GWL_WNDPROC, LongWord(@StatusProc)) );
end;

end.
