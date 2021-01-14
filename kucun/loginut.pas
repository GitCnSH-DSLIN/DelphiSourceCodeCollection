unit loginut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, DB, ADODB;

type
  Tloginfm = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    userpasedit: TLabeledEdit;
    Label1: TLabel;
    usernamebox: TComboBox;
    loginbt: TSpeedButton;
    closebt: TSpeedButton;
    ADOQuery: TADOQuery;
    procedure closebtClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure loginbtClick(Sender: TObject);
    procedure userpaseditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure usernameboxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
     
    { Public declarations }
  end;

var
  loginfm: Tloginfm;
  j:integer;
implementation

uses mainut, dataut, xyriut;

{$R *.dfm}

procedure Tloginfm.closebtClick(Sender: TObject);
begin
if messagedlg('ȷ���˳���',mtconfirmation,[mbyes,mbno],0)=mryes then
application.Terminate;
end;

procedure Tloginfm.FormCreate(Sender: TObject);
var
mypath:string;
begin
j:=0;
//mypath:=extractfilepath(paramstr(0));
//ADOquery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+mypath+'data\kcgl.mdb;Persist Security Info=False';
//ADOquery.active:=true;
with adoquery do
begin
close;
sql.Clear;
sql.Add('select * from czyb');
open;
if recordcount>0 then
begin
first;
while not eof do
begin
usernamebox.Items.Add(fieldbyname('����').AsString);
next;
end;
end
else
showmessage('��ǰû���û�');
end;
end;

procedure Tloginfm.FormActivate(Sender: TObject);
var
mypath:string;
begin
j:=0;
//mypath:=extractfilepath(paramstr(0));
//ADOquery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+mypath+'data\kcgl.mdb;Persist Security Info=False';
//ADOquery.active:=true;
end;

procedure Tloginfm.loginbtClick(Sender: TObject);
begin
if trim(usernamebox.text)='' then
begin
showmessage('��ѡ���û���!');
userpasedit.SetFocus;
exit;
end;
with adoquery do
begin
close;
sql.Clear;
sql.Add('select * from czyb where ����=:username and ����=:userpas');
Parameters.ParamByName('username').Value:=trim(usernamebox.text);
Parameters.ParamByName('userpas').Value:=userpasedit.text;
open;
if recordcount<1 then
begin
if j=3 then
application.Terminate;
messagedlg('������󣡻���'+inttostr(3-j)+'�λ���',mtconfirmation,[mbok],0);
userpasedit.Clear;
j:=j+1;
exit;
end
else
begin
if fieldbyname('������').AsBoolean=true then
 begin
 mainfm.N2.Enabled:=true;
 mainfm.N62.Enabled:=true;
  mainfm.N63.Enabled:=true;
 mainfm.ToolButton1.Enabled:=true;
 end
 else
 begin
 mainfm.N2.Enabled:=false;
  mainfm.N62.Enabled:=false;
  mainfm.N63.Enabled:=false;
 mainfm.ToolButton1.Enabled:=false;
 end;
 if fieldbyname('�������').AsBoolean=true then
 begin
 mainfm.N4.Enabled:=true ;

  mainfm.ToolButton2.Enabled:=true;
 end
 else
 begin
  mainfm.N4.Enabled:=false;

  mainfm.ToolButton2.Enabled:=false;
 end;
 if fieldbyname('����ѯ').AsBoolean=true then
 begin
 mainfm.N7.Enabled:=true;
  mainfm.N69.Enabled:=true;
  mainfm.N71.Enabled:=true;
  mainfm.ToolButton4.Enabled:=true;
 end
 else
 begin
 mainfm.N7.Enabled:=false;
  mainfm.N69.Enabled:=false;
  mainfm.N71.Enabled:=false;
   mainfm.ToolButton4.Enabled:=false;
 end;
 if fieldbyname('�����ѯ').AsBoolean=true then
 begin
 mainfm.N9.Enabled:=true ;

  mainfm.ToolButton5.Enabled:=true;
 end
 else
 begin
 mainfm.N9.Enabled:=false;

  mainfm.ToolButton5.Enabled:=false;
 end;
 if fieldbyname('����ѯ').AsBoolean=true then
 begin
 mainfm.N11.Enabled:=true;
   mainfm.ToolButton6.Enabled:=true;
 end
 else
 begin
 mainfm.N11.Enabled:=false;
   mainfm.ToolButton6.Enabled:=false;
 end;
  if fieldbyname('�����ӡ').AsBoolean=true then
  begin
   mainfm.ToolButton9.Enabled:=true;
 mainfm.N15.Enabled:=true;
 mainfm.N17.Enabled:=true;
 mainfm.N19.Enabled:=true;
 end
 else
 begin
 mainfm.N15.Enabled:=false;
 mainfm.N17.Enabled:=false;
 mainfm.N19.Enabled:=false;
  mainfm.ToolButton9.Enabled:=false;
 end;
 if fieldbyname('���ݴ���').AsBoolean=true then
 mainfm.N21.Enabled:=true
 else
 mainfm.N21.Enabled:=false;
 if fieldbyname('��ʼ������').AsBoolean=true then
 mainfm.N56.Enabled:=true
 else
 mainfm.N56.Enabled:=false;
 if fieldbyname('����Ա����').AsBoolean=true then
 mainfm.N25.Enabled:=true
 else
 mainfm.N25.Enabled:=false;
 if fieldbyname('����Ա����').AsBoolean=true then
 mainfm.N23.Enabled:=true
 else
 mainfm.N23.Enabled:=false;
 if fieldbyname('��Ź���').AsBoolean=true then
 mainfm.N27.Enabled:=true
 else
 mainfm.N27.Enabled:=false;
 //if fieldbyname('������').AsBoolean=true then
 //mainfm.N49.Enabled:=true
// else
// mainfm.N49.Enabled:=false;
// if fieldbyname('�������').AsBoolean=true then
 //mainfm.N51.Enabled:=true
 //else
// mainfm.N51.Enabled:=false;
 if fieldbyname('������').AsBoolean=true then
 mainfm.N53.Enabled:=true
 else
 mainfm.N53.Enabled:=false;
 if fieldbyname('�����̹���').AsBoolean=true then
 mainfm.N29.Enabled:=true
 else
 mainfm.N29.Enabled:=false;
 if fieldbyname('���ݱ���').AsBoolean=true then
 mainfm.N31.Enabled:=true
 else
 mainfm.N31.Enabled:=false;
 if fieldbyname('�޸�����').AsBoolean=true then
 begin
 mainfm.N33.Enabled:=true;
  mainfm.ToolButton10.Enabled:=true;
 end
 else
 begin
 mainfm.N33.Enabled:=false;
  mainfm.ToolButton10.Enabled:=false;
 end;
 if fieldbyname('�鿴��־').AsBoolean=true then
 mainfm.N58.Enabled:=true
 else
 mainfm.N58.Enabled:=false;
//if fieldbyname('Ȩ��').AsString='���������Ա' then
//mainfm.id:='���������Ա'
//else
mainfm.id:='����Ա';
mainfm.username:=fieldbyname('����').AsString;
mainfm.userpas:=fieldbyname('����').AsString;
mainfm.statusbar.Panels.Items[0].Text:='��ǰ�û���'+mainfm.username;
loginfm.close;
end;
end;
{if mainfm.id='���������Ա' then
begin
mainfm.N15.Enabled:=true;
mainfm.N17.Enabled:=true;
mainfm.N19.Enabled:=true;
mainfm.N23.Enabled:=true;
mainfm.N25.Enabled:=true;
mainfm.N27.Enabled:=true;
mainfm.N29.Enabled:=true;
mainfm.N31.Enabled:=true;
mainfm.N21.Enabled:=true;
mainfm.N49.Enabled:=true;
mainfm.N51.Enabled:=true;
mainfm.N53.Enabled:=true;
mainfm.N56.Enabled:=true;
mainfm.N58.Enabled:=true;
mainfm.N61.Enabled:=true;
mainfm.ToolButton9.Enabled:=true;
end;
if mainfm.id='����Ա' then
begin
mainfm.N15.Enabled:=false;
mainfm.N17.Enabled:=false;
mainfm.N19.Enabled:=false;
mainfm.N23.Enabled:=false;
mainfm.N25.Enabled:=false;
mainfm.N27.Enabled:=false;
mainfm.N29.Enabled:=false;
mainfm.N31.Enabled:=false;
mainfm.N21.Enabled:=false;
mainfm.N49.Enabled:=false;
mainfm.N51.Enabled:=false;
mainfm.N53.Enabled:=false;

mainfm.N56.Enabled:=false;
mainfm.N58.Enabled:=false;
mainfm.N61.Enabled:=false;
mainfm.ToolButton9.Enabled:=false;
end;  }
usernamebox.Text:='';
userpasedit.Text:='';
xtczrzfm.rzmo.Lines.Add('�������û� '+mainfm.username+'��¼�ɹ���-->>'+datetimetostr(date()+time()));
end;

procedure Tloginfm.userpaseditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then
loginbt.Click;
if key=27 then
closebt.Click;
if Shift>=[ssAlt] then
showmessage('�����Ƿ�!')
end;

procedure Tloginfm.usernameboxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Shift>=[ssAlt] then
showmessage('�����Ƿ�!');
if key=13 then
userpasedit.SetFocus;
if key=27 then
closebt.Click;
end;

end.
