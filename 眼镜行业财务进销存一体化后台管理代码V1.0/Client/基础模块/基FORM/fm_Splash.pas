unit fm_Splash;
/////������ʾ����
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,  ExtCtrls, ComCtrls,WinInet;

type
  TFmSplash = class(TForm)
    Label1: TLabel;
    Animate1: TAnimate;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
     OnNet:boolean;
     procedure CheckNet;

  end;

var
  FmSplash: TFmSplash;

implementation

{$R *.dfm}
{$R Shopyuan.Res}

procedure TFmSplash.FormShow(Sender: TObject);
begin
//�˷����У���ȡ�Զ�����Դ����EXE�еķ���
//  Animate1.FileName :=ExtractFileDir(application.ExeName)+ 'MessageBox.avi';
  Animate1.ResName := 'StartAvi';
  Animate1.Active := true;
  CheckNet;
  //if date > strtodate('2004-9-30') then application.Terminate;    ///����ʹ��ʱ��
end;

procedure  TFmSplash.CheckNet;
begin
  ///�ж������Ƿ�ͨ      ///�ѷŵ�����ģ����   //�����Լ��ķ�����IP��ַ
  if not  InternetCheckConnection('http://61.53.175.253', 1, 0) then
//  if not  InternetCheckConnection('http://220.112.186.168/', 1, 0) then
  begin
   OnNet := false;
   IF application.MessageBox('��������������ã�Ŀǰ��Ļ��������������Ƿ��˳�ϵͳ��',pchar(application.Title),mb_iconwarning+Mb_yesNo)=IDyes then
   begin
     application.Terminate;
     exit;
   End;
  end
  else
  OnNet := true;

end;

end.
