program UseHook;

uses Windows;
               
var Msg: TMsg;

procedure HookOn();  external 'HookDLL.dll'; // ��װ����
procedure HookOff(); external 'HookDLL.dll'; // ɾ������

begin
 // ��װ����
  HookOn();

 // ��ֹ�˳�
  while GetMessage(Msg, 0, 0, 0) do ;

 // �˾�����
  HookOff();
end.

