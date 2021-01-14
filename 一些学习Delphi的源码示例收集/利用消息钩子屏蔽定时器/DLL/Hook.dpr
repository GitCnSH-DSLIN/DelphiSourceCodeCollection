library Hook;

uses Windows, Messages;

var HookHandle: HHOOK;

   // ���ӻص�
function GetMsgProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  if (PMsg(lParam).message = WM_TIMER) then PMsg(lParam).message := 0;
  Result := CallNextHookEx(HookHandle, nCode, Wparam, lParam);
end;

   // �ҹ�
procedure HookOn;
begin
  HookHandle := SetWindowsHookEx(WH_GETMESSAGE, @GetMsgProc, HInstance, 0);
end;

   // �ѹ�
procedure HookOff;
begin
  UnHookWindowsHookEx(HookHandle);
end;     

  //��������
exports HookOn,HookOff;
  
begin
end.