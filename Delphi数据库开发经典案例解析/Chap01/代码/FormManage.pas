unit FormManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, formlogin,forminput,formoutput;

type
  Tmanage = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    StatusBar1: TStatusBar;
    Image1: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  manage: Tmanage;

implementation

uses FormInfo, FormRights, FormStore;

{$R *.dfm}
//---------------------������ر�ʱ���ص�¼����------------------
procedure Tmanage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
login.show;
end;
//---------------------�򿪽��������岢���ع�����------------------
procedure Tmanage.Button2Click(Sender: TObject);
begin
input.Visible:=true;
manage.Hide;
end;
//---------------------����Ϣ�����岢���ع�����------------------
procedure Tmanage.Button1Click(Sender: TObject);
begin
info.Visible:=true;
info.Caption:='���Ϲ���';
manage.Hide;
end;
//---------------------�򿪿���ѯ���岢���ع�����------------------
procedure Tmanage.Button4Click(Sender: TObject);
begin
manage.Hide;
store.visible:=true;
end;
//---------------------��Ȩ�޹����岢���ع�����------------------
procedure Tmanage.Button5Click(Sender: TObject);
begin
rights.visible:=true;
manage.hide;
end;
//---------------------�����۵����岢���ع�����------------------
procedure Tmanage.Button3Click(Sender: TObject);
begin
output.visible:=true;
manage.hide;
end;

end.
