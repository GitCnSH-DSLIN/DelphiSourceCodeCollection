library KeyHook;

uses Windows, Messages;

const
  Buffer1: PChar = '������űߣ���į�����������ǻƻ���Գ��������ꡣ';
  Buffer2: PChar = '�����������һ��Ⱥ���ʡ����������������ֻ������ʡ�';

 // �����ߵ��ֽ�
function Swap(x: Word): Word;
asm
  XCHG AH, AL;
end;

 // ��ĸ��Ӧ����
function AsciiToGB(Letter: Char): Word;
begin
  case Letter of
    'A'..'Z': Result := Swap(  PWord( @Buffer2[ (Ord(Letter) - Ord('A')) shl 1] )^  );
    'a'..'z': Result := Swap(  PWord( @Buffer1[ (Ord(Letter) - Ord('a')) shl 1] )^  );
    else Result := 0;
  end;
end;

 // ���̹��Ӿ��
var KeyboardHook: HHOOK = 0;

 // ���̹��ӻص�
function KeyHookPro(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  State: TKeyboardState;  // ����״̬
  Ascii: array[0..1] of Char; // �ַ�
  HFocus: HWND; // ����ؼ�
  GBCode: Word; // ��������
begin
 // ����һ���Ӵ���
  Result := CallNextHookEx(KeyboardHook, nCode, wParam, lParam);

  if (nCode = HC_ACTION) and // ������Ϣ���Ƴ�����
     (lParam and $80000000 = 0) and // ������������
     IsCharUpper(Char(wParam)) then // Ӣ����ĸ
  begin
   // ����״̬
    GetKeyboardState(State);

   // ת���ַ�
    if ToAscii(wParam, (lParam and $FF0000) shr 16, State, Ascii, 0) = 1 then
      GBCode := AsciiToGB(Ascii[0])
    else
      GBCode := 0;

   // ת���ɹ�
    if (GBCode <> 0) then
    begin
      HFocus := GetFocus();
      if (HFocus <> 0) then
      begin
        SendMessage(HFocus, WM_IME_CHAR, GBCode, 0); // ���ͺ���
        Result := 1; // ����TRUE, ���ΰ���
      end;
    end;
  end;
end;

 // ж�ع���
procedure HookOff();
begin
  UnHookWindowsHookEx(KeyboardHook);
  KeyboardHook := 0;
end;

 // ��װ����
procedure HookOn();
begin
  if (KeyboardHook <> 0) then HookOff();
  KeyboardHook := SetWindowsHookEx(WH_KEYBOARD, KeyHookPro, HInstance, 0);
end;

 // ��������
exports HookOn, HookOff;
  
begin
end.        
