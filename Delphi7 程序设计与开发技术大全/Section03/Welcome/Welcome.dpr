program Welcome;               //ָ����ִ���ļ���

uses                           //��ʾ�����ڹ����е��ļ�
  Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}                     //$R����Ǳ�����ָ��

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
