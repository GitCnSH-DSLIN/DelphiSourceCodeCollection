unit FormRights;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, DBCtrls, ExtCtrls;

type
  Trights = class(TForm)
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    GroupBox2: TGroupBox;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    ComboBox1: TComboBox;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    Button1: TButton;
    Label1: TLabel;
    ADOQuery3: TADOQuery;
    ADOCommand1: TADOCommand;
    Label2: TLabel;
    
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  rights: Trights;
  UserName:string;
  UserNumber,MaxNumber:string;
  order:integer;

implementation

uses FormManage;

{$R *.dfm}


//-----------�رմ���ʱͬʱ�رն�Ȩ���嵥�Ĳ�����ɹ���------------------
procedure Trights.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//�Ƚ���Ȩ���嵥��Ĳ��빦�ܹر�
adocommand1.CommandText:='SET IDENTITY_INSERT Ȩ���嵥 off';
adocommand1.Execute;
//�رմ����Ƿ�����һ������
manage.show;
end;

//------------------������ʾʱ��Ϊ�����б�������û��ʵ�------------------------
//-------------------������Թ���Աsys��Ȩ�޽�������-------------------------
procedure Trights.FormShow(Sender: TObject);
begin

 adoquery1.Close;
 adoquery1.SQL.Clear;
 adoquery1.SQL.Text:='select distinct ���� from �û��嵥 where ����!=''sys''';
 adoquery1.Open;
 combobox1.Clear;
 while not adoquery1.Eof do
begin
 combobox1.Items.Add(adoquery1.fieldbyname('����').AsString);
 adoquery1.Next;
 end
end;

//--------------�������б���ѡ�е��û�����Ӧӵ�е�Ȩ����ʾ���б����---------
procedure Trights.ComboBox1Change(Sender: TObject);
var
 str,temp:string;
begin
adoquery2.Close;
adoquery2.SQL.clear;
adoquery2.SQL.Text:='select Ȩ������ from Ȩ���嵥 where �û����=(select �û���� from �û��嵥 where ����='''+combobox1.Text+''''+')';
adoquery2.Open;
listbox1.Clear;

while not adoquery2.Eof do
 begin
  temp:=adoquery2.fieldbyname('Ȩ������').AsString;
  listbox1.Items.Add(temp);
  adoquery2.Next;
  end;

//----------------------�����û���Ȩ���޸�checkbox�е�����-----------
//--------------------�ж��û��Ƿ�ӵ����Ʒ�嵥����Ȩ��--------------
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select �û���� from Ȩ���嵥 where (�û����=(select �û���� from �û��嵥 where ����='''+combobox1.Text+'''))and(Ȩ������='''+checkbox1.Caption+''')');
adoquery2.Open;
if adoquery2.FieldByName('�û����').AsString<>'' then
 checkbox1.Checked:=true
 else
 checkbox1.Checked:=false;
//--------------------�ж��û��Ƿ�ӵ�й��������Ϲ���Ȩ��--------------
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select �û���� from Ȩ���嵥 where (�û����=(select �û���� from �û��嵥 where ����='''+combobox1.Text+'''))and(Ȩ������='''+checkbox2.Caption+''')');
adoquery2.Open;
if adoquery2.FieldByName('�û����').AsString<>'' then
 checkbox2.Checked:=true
 else
 checkbox2.Checked:=false;
//--------------------�ж��û��Ƿ�ӵ�пͻ����Ϲ���Ȩ��--------------
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select �û���� from Ȩ���嵥 where (�û����=(select �û���� from �û��嵥 where ����='''+combobox1.Text+'''))and(Ȩ������='''+checkbox3.Caption+''')');
adoquery2.Open;
if adoquery2.FieldByName('�û����').AsString<>'' then
 checkbox3.Checked:=true
 else
 checkbox3.Checked:=false;
//--------------------�ж��û��Ƿ�ӵ�н�����Ȩ��--------------
 adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select �û���� from Ȩ���嵥 where (�û����=(select �û���� from �û��嵥 where ����='''+combobox1.Text+'''))and(Ȩ������='''+checkbox4.Caption+''')');
adoquery2.Open;
if adoquery2.FieldByName('�û����').AsString<>'' then
 checkbox4.Checked:=true
 else
 checkbox4.Checked:=false;
//--------------------�ж��û��Ƿ�ӵ����Ʒ���۵�����Ȩ��--------------
 adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select �û���� from Ȩ���嵥 where (�û����=(select �û���� from �û��嵥 where ����='''+combobox1.Text+'''))and(Ȩ������='''+checkbox5.Caption+''')');
adoquery2.Open;
if adoquery2.FieldByName('�û����').AsString<>'' then
 checkbox5.Checked:=true
 else
 checkbox5.Checked:=false;
//--------------------�ж��û��Ƿ�ӵ�п���ѯȨ��--------------
 adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select �û���� from Ȩ���嵥 where (�û����=(select �û���� from �û��嵥 where ����='''+combobox1.Text+'''))and(Ȩ������='''+checkbox6.Caption+''')');
adoquery2.Open;
if adoquery2.FieldByName('�û����').AsString<>'' then
 checkbox6.Checked:=true
 else
 checkbox6.Checked:=false;
//--------------------�ж��û��Ƿ�ӵ��Ȩ�޹���Ȩ��--------------
 adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select �û���� from Ȩ���嵥 where (�û����=(select �û���� from �û��嵥 where ����='''+combobox1.Text+'''))and(Ȩ������='''+checkbox7.Caption+''')');
adoquery2.Open;
if adoquery2.FieldByName('�û����').AsString<>'' then
 checkbox7.Checked:=true
 else
 checkbox7.Checked:=false;
end;

//--------------------�޸�ѡ����û���Ȩ��---------------------------------
 procedure Trights.Button1Click(Sender: TObject);
 var str:string;
 begin
//�����ĳ���û����Ӧ���û����
UserName:=combobox1.Text;
adoquery3.Close;
adoquery3.SQL.clear;
adoquery3.SQL.Text:='select �û���� from �û��嵥 where ����='''+UserName+'''';
adoquery3.Open;
UserNumber:=adoquery3.fieldbyname('�û����').AsString;
adoquery3.Close;

//����Ȩ���嵥�е�Ȩ�����֮���ֵ��������������Ȩ����������еĳ�ͻ
adoquery3.Close;
adoquery3.SQL.clear;
adoquery3.SQL.Text:='select max(Ȩ�����) maxnum from Ȩ���嵥 as max';
adoquery3.Open;
MaxNumber:=adoquery3.fieldbyname('maxnum').AsString;
adoquery3.Close;

//ɾ�����û�������Ȩ�޼�¼�Ա���һ�����޸�
adocommand1.CommandText:='delete from Ȩ���嵥 where �û����='''+UserNumber+'''';
adocommand1.Execute;

//�򿪶��û�Ȩ�޼�¼��Ĳ���Ȩ�ޣ������ɽ������ݿ��ʱ������úõģ��������Ҫ�����ر�
adocommand1.CommandText:='SET IDENTITY_INSERT Ȩ���嵥 on';
adocommand1.Execute;

//���checkbox1״̬���ж��Ƿ�����û���Ʒ����ά��Ȩ��
if checkbox1.Checked then
begin
 order:=strtoint(MaxNumber)+1;
 str:=inttostr(order);

 adocommand1.CommandText:='insert into Ȩ���嵥([Ȩ�����],[�û����],[Ȩ������]) values('''+str+''','+''''+UserNumber+''','+''''+checkbox1.Caption+''''+')';
 adocommand1.Execute;
end;

 //���checkbox2״̬���ж��Ƿ�����û�����������ά��Ȩ��
if checkbox2.Checked then
begin
 order:=strtoint(MaxNumber)+2;
 str:=inttostr(order);

 adocommand1.CommandText:='insert into Ȩ���嵥([Ȩ�����],[�û����],[Ȩ������]) values('''+str+''','+''''+UserNumber+''','+''''+checkbox2.Caption+''''+')';
 adocommand1.Execute;
end;

 //���checkbox3״̬���ж��Ƿ�����û��ͻ�����ά��Ȩ��
if checkbox3.Checked then
begin
 order:=strtoint(MaxNumber)+3;
 str:=inttostr(order);

 adocommand1.CommandText:='insert into Ȩ���嵥([Ȩ�����],[�û����],[Ȩ������]) values('''+str+''','+''''+UserNumber+''','+''''+checkbox3.Caption+''''+')';
 adocommand1.Execute;
end;

  //���checkbox4״̬���ж��Ƿ�����û�����������Ȩ��
if checkbox4.Checked then
begin
 order:=strtoint(MaxNumber)+4;
 str:=inttostr(order);

 adocommand1.CommandText:='insert into Ȩ���嵥([Ȩ�����],[�û����],[Ȩ������]) values('''+str+''','+''''+UserNumber+''','+''''+checkbox4.Caption+''''+')';
 adocommand1.Execute;
end;

 //���checkbox5״̬���ж��Ƿ�����û����۵�����Ȩ��
if checkbox5.Checked then
begin
 order:=strtoint(MaxNumber)+5;
 str:=inttostr(order);

 adocommand1.CommandText:='insert into Ȩ���嵥([Ȩ�����],[�û����],[Ȩ������]) values('''+str+''','+''''+UserNumber+''','+''''+checkbox5.Caption+''''+')';
 adocommand1.Execute;
end;

 //���checkbox6״̬���ж��Ƿ�����û�����ѯȨ��
if checkbox6.Checked then
begin
 order:=strtoint(MaxNumber)+6;
 str:=inttostr(order);

 adocommand1.CommandText:='insert into Ȩ���嵥([Ȩ�����],[�û����],[Ȩ������]) values('''+str+''','+''''+UserNumber+''','+''''+checkbox6.Caption+''''+')';
 adocommand1.Execute;
end;

  //���checkbox7״̬���ж��Ƿ����Ȩ�޹���Ȩ��
if checkbox7.Checked then
begin
 order:=strtoint(MaxNumber)+7;
 str:=inttostr(order);

 adocommand1.CommandText:='insert into Ȩ���嵥([Ȩ�����],[�û����],[Ȩ������]) values('''+str+''','+''''+UserNumber+''','+''''+checkbox7.Caption+''''+')';
 adocommand1.Execute;
end;

//֪ͨ�û��޸ĳɹ�
  showmessage('�޸ĳɹ�!');

//----------------------�����û���Ȩ���޸�ͬ������checkbox�е�����-----------
//--------------------�жϸ��º��û��Ƿ�ӵ����Ʒ�嵥����Ȩ��--------------
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select �û���� from Ȩ���嵥 where (�û����=(select �û���� from �û��嵥 where ����='''+combobox1.Text+'''))and(Ȩ������='''+checkbox1.Caption+''')');
adoquery2.Open;
if adoquery2.FieldByName('�û����').AsString<>'' then
 checkbox1.Checked:=true
 else
 checkbox1.Checked:=false;
//--------------------�жϸ��º��û��Ƿ�ӵ�й���������ά��Ȩ��--------------
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select �û���� from Ȩ���嵥 where (�û����=(select �û���� from �û��嵥 where ����='''+combobox1.Text+'''))and(Ȩ������='''+checkbox2.Caption+''')');
adoquery2.Open;
if adoquery2.FieldByName('�û����').AsString<>'' then
 checkbox2.Checked:=true
 else
 checkbox2.Checked:=false;
//--------------------�жϸ��º��û��Ƿ�ӵ�пͻ�����ά��Ȩ��--------------
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select �û���� from Ȩ���嵥 where (�û����=(select �û���� from �û��嵥 where ����='''+combobox1.Text+'''))and(Ȩ������='''+checkbox3.Caption+''')');
adoquery2.Open;
if adoquery2.FieldByName('�û����').AsString<>'' then
 checkbox3.Checked:=true
 else
 checkbox3.Checked:=false;
//--------------------�жϸ��º��û��Ƿ�ӵ�н���������Ȩ��--------------
 adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select �û���� from Ȩ���嵥 where (�û����=(select �û���� from �û��嵥 where ����='''+combobox1.Text+'''))and(Ȩ������='''+checkbox4.Caption+''')');
adoquery2.Open;
if adoquery2.FieldByName('�û����').AsString<>'' then
 checkbox4.Checked:=true
 else
 checkbox4.Checked:=false;
//--------------------�жϸ��º��û��Ƿ�ӵ�����۵�����Ȩ��--------------
 adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select �û���� from Ȩ���嵥 where (�û����=(select �û���� from �û��嵥 where ����='''+combobox1.Text+'''))and(Ȩ������='''+checkbox5.Caption+''')');
adoquery2.Open;
if adoquery2.FieldByName('�û����').AsString<>'' then
 checkbox5.Checked:=true
 else
 checkbox5.Checked:=false;
//--------------------�жϸ��º��û��Ƿ�ӵ�п���ѯȨ��--------------
 adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select �û���� from Ȩ���嵥 where (�û����=(select �û���� from �û��嵥 where ����='''+combobox1.Text+'''))and(Ȩ������='''+checkbox6.Caption+''')');
adoquery2.Open;
if adoquery2.FieldByName('�û����').AsString<>'' then
 checkbox6.Checked:=true
 else
 checkbox6.Checked:=false;
//--------------------�жϸ��º��û��Ƿ�ӵ��Ȩ�޹���Ȩ��--------------
 adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select �û���� from Ȩ���嵥 where (�û����=(select �û���� from �û��嵥 where ����='''+combobox1.Text+'''))and(Ȩ������='''+checkbox7.Caption+''')');
adoquery2.Open;
if adoquery2.FieldByName('�û����').AsString<>'' then
 checkbox7.Checked:=true
 else
 checkbox7.Checked:=false;

//-------------ˢ�¸��º���б���е�Ȩ���嵥------------

adoquery2.Close;
adoquery2.SQL.clear;
adoquery2.SQL.Text:='select Ȩ������ from Ȩ���嵥 where �û����=(select �û���� from �û��嵥 where ����='''+combobox1.Text+''''+')';
adoquery2.Open;
listbox1.Clear;
while not adoquery2.Eof do
 begin
  listbox1.Items.Add(adoquery2.fieldbyname('Ȩ������').AsString);
  adoquery2.Next;
  end;
end;
end.
