unit Uncount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  Tcountfrm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  countfrm: Tcountfrm;

implementation

uses Undm;

{$R *.dfm}

procedure Tcountfrm.Button1Click(Sender: TObject);
begin
 if edit1.Text='' then
  begin
   application.MessageBox('��û�������¼������������ĵ�¼������','ϵͳ����',MB_ok+MB_Iconstop);
   exit;
  end;
   if edit2.Text='' then
  begin
   application.MessageBox('��û���������,��������Ŀ����','ϵͳ����',MB_ok+MB_Iconstop);
   exit;
  end;
 if datamodule1.DSManerge.Locate('����',edit1.Text,[]) then
  begin
   if datamodule1.DSManerge.FieldByName('����').AsString=edit2.Text then
    begin

     close;
    end
   else
     application.MessageBox('������Ŀ����������������룡','ϵͳ����',mb_ok+mb_iconstop);
    end
  else
    application.MessageBox('������������������������룡','ϵͳ����',mb_ok+mb_iconstop);
end;

procedure Tcountfrm.Button2Click(Sender: TObject);
begin
application.Terminate;
end;

end.
