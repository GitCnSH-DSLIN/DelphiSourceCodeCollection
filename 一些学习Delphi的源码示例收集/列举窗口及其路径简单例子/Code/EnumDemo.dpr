program EnumDemo;

{$R '..\Other\LiuMazi.res' '..\Other\LiuMazi.txt'}

uses
  Windows, Enum_Unit in 'Enum_Unit.pas',
  Public_Unit in 'Public_Unit.pas',
  Window_Unit in 'Window_Unit.pas',
  Button_Unit in 'Button_Unit.pas',
  ListView_Unit in 'ListView_Unit.pas';

var
  ThreadMessage: TMsg;  
  
//----------������-------
begin
  Create_Window;  //------��������------
  Create_Button;  //------������ť------
  Create_ListView;//------����LIST------
 //--------��Ϣѭ��---------
  while GetMessage(ThreadMessage, 0, 0, 0) do
  begin
    TranslateMessage(ThreadMessage);// �������ϢΪ�ַ���Ϣ
    DispatchMessage(ThreadMessage); // �ַ���Ϣ�����崦�����
  end;
end.
