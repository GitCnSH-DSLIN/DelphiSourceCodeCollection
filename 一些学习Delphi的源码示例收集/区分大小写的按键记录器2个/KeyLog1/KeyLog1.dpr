program KeyLog1;

uses Windows;

procedure  HookOn(); external 'KeyHook.dll';
procedure HookOff(); external 'KeyHook.dll';

var Msg: TMsg;

begin
  HookOn();  // �ҹ�
  while GetMessage(Msg, 0, 0, 0) do; // ��ֹ�����˳�
  HookOff(); // �ѹ�

  (* GetMessage()����ʵĿ��ֻ��Ϊ�������߳�, �������HookOff()���޻���ִ�е� *)
end.