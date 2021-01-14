unit ClinicRegForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, StdCtrls, DB, ExtCtrls, ComCtrls, ToolWin, ImgList;

type
  TClinicReg = class(TForm)
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    ToolButton5: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton12: TToolButton;
    ToolButton4: TToolButton;
    GroupBox1: TGroupBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    ADOConnection1: TADOConnection;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    Edit3: TEdit;
    Edit4: TEdit;
    ADOCommand1: TADOCommand;
    ADOQuery1: TADOQuery;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    procedure ToolButton1Click(Sender: TObject);

    procedure ComboBox5Select(Sender: TObject);
    procedure ComboBox4Select(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ClinicReg: TClinicReg;
  maxClinic,maxPatient:string;//����Һ�����źͲ�����Ϣ�������

implementation

{$R *.dfm}

//-----�������˹Һ�------
procedure TClinicReg.ToolButton1Click(Sender: TObject);
var
temp:string;
num:integer;
begin
 //���ùҺſ��������˵�
 adoquery1.Close;
 adoquery1.SQL.Clear;
 adoquery1.SQL.Add('select distinct ���� from ��������');
 adoquery1.Open;
 combobox5.Items.Clear;
 while not adoquery1.Eof do
  begin
   combobox5.Items.Add(trim(adoquery1.FieldByName('����').AsString));
   adoquery1.Next;
  end;
  combobox5.ItemIndex:=0;
  //���ñ����ֶε�Ĭ��ѡ��
  combobox3.Text:=combobox3.Items.Strings[0];
  combobox4.Text:=combobox4.Items.Strings[0];
  combobox5.Text:=combobox5.Items.Strings[0];
  combobox6.Text:=combobox6.Items.Strings[0];
  edit3.Text:='1';
  edit4.Text:=datetostr(date)+' '+timetostr(time);

  toolbutton2.Enabled:=true;
  toolbutton3.Enabled:=true;
  toolbutton1.Enabled:=false;
  groupbox1.Enabled:=true;

  //��������Һ�����źͲ�����Ϣ�������
 adoquery1.Close;
 adoquery1.SQL.Clear;
 adoquery1.SQL.Add('select max(���) ����� from ����Һ�');
 adoquery1.Open;
 if adoquery1.RecordCount>0 then//��Ź������+7λ���ֱ��
  begin
  temp:=copy(trim(adoquery1.fieldbyname('�����').AsString),5,7);
  num:=strtoint(temp)+1;
  if num<10 then maxClinic:=copy(datetostr(date),1,4)+'000000'+inttostr(num);
  if num>9 then maxClinic:=copy(datetostr(date),1,4)+'00000'+inttostr(num);
  if num>99 then maxClinic:=copy(datetostr(date),1,4)+'0000'+inttostr(num);
  if num>999 then maxClinic:=copy(datetostr(date),1,4)+'000'+inttostr(num);
  if num>9999 then maxClinic:=copy(datetostr(date),1,4)+'00'+inttostr(num);
  if num>99999 then maxClinic:=copy(datetostr(date),1,4)+'0'+inttostr(num);
  if num>999999 then maxClinic:=copy(datetostr(date),1,4)+inttostr(num);
  end
 else
  maxClinic:=copy(datetostr(date),1,4)+'0000001';

 adoquery1.Close;
 adoquery1.SQL.Clear;
 adoquery1.SQL.Add('select max(���) ����� from ������Ϣ��');
 adoquery1.Open;
 if adoquery1.RecordCount>0 then
  begin
  temp:=copy(trim(adoquery1.fieldbyname('�����').AsString),5,7);
  num:=strtoint(temp)+1;
  if num<10 then maxPatient:=copy(datetostr(date),1,4)+'000000'+inttostr(num);
  if num>9 then maxPatient:=copy(datetostr(date),1,4)+'00000'+inttostr(num);
  if num>99 then maxPatient:=copy(datetostr(date),1,4)+'0000'+inttostr(num);
  if num>999 then maxPatient:=copy(datetostr(date),1,4)+'000'+inttostr(num);
  if num>9999 then maxPatient:=copy(datetostr(date),1,4)+'00'+inttostr(num);
  if num>99999 then maxPatient:=copy(datetostr(date),1,4)+'0'+inttostr(num);
  if num>999999 then maxPatient:=copy(datetostr(date),1,4)+inttostr(num);
  end
 else
  maxPatient:=copy(datetostr(date),1,4)+'0000001';

end;


//----����ҽ�������˵�������ʾ������ѡ�ĹҺſ��ҵ�ҽ������-------
procedure TClinicReg.ComboBox5Select(Sender: TObject);
begin

 adoquery1.Close;
 adoquery1.SQL.Clear;
 adoquery1.SQL.Add('select distinct ���� from ҽ������ where ����='''+combobox5.Text+'''');
 adoquery1.Open;
 combobox6.Clear;
 combobox6.Items.Clear;
 while not adoquery1.Eof do
  begin
   combobox6.Items.Add(trim(adoquery1.FieldByName('����').AsString));
   adoquery1.Next;
  end;
  if combobox6.Items.Count>0 then
   combobox6.ItemIndex:=0;
end;

//-----���ݲ�ͬ�Һ�������ʾ��ͬ�ĹҺŷ���------
procedure TClinicReg.ComboBox4Select(Sender: TObject);
begin
 if combobox4.ItemIndex=0 then
  edit3.Text:='1';
 if combobox4.ItemIndex=1 then
  edit3.Text:='20';
 if combobox4.ItemIndex=2 then
  edit3.Text:='5';
end;

//----------��������Ϣ���浽������Ϣ��-------------
procedure TClinicReg.ToolButton2Click(Sender: TObject);
var
sql1,sql2,sql3,sql4:string;
begin
 //�������ֶ�
 if combobox6.Text='' then //����ʱ����ѡ��ҽ��
  begin
   showmessage('��ѡ��ҽ��');
   exit;
  end;

 if edit1.Text='' then  //����ʱ�������벡������
  begin
   showmessage('�����벡������');
   exit;
  end;


  sql1:='insert into ������Ϣ�� values(''';
  sql2:=maxPatient+''','''+edit1.Text+''','''+combobox1.Text+''','''+edit2.Text;
  sql3:=''','''+combobox2.Text+''','''+combobox3.Text+''','''','''')';
  adocommand1.CommandText:=sql1+sql2+sql3;
  adocommand1.Execute;

  //���Һ���Ϣ����������Һ����ݿ�
  sql1:='insert into ����Һ� values('''+maxClinic;
  sql2:=''','''+maxPatient+''','''+edit1.Text+''','''+combobox1.Text;
  sql3:=''','''+combobox5.Text+''','''+combobox3.Text+''','''+combobox4.Text;
  sql4:=''',CAST('''+edit3.Text+''' as DECIMAL(12,2)),'''+combobox6.Text+''','''+edit4.Text+''','''+'��'')';
  adocommand1.CommandText:=sql1+sql2+sql3+sql4;

  adocommand1.Execute;

  //���ù�������ť״̬
  toolbutton1.Enabled:=true;
  toolbutton2.Enabled:=false;
  toolbutton3.Enabled:=false;
  groupbox1.Enabled:=false;

  edit1.Clear;
  edit2.Clear;
end;

//--------ȡ������-----------
procedure TClinicReg.ToolButton3Click(Sender: TObject);
begin

  toolbutton1.Enabled:=true;
  toolbutton2.Enabled:=false;
  toolbutton3.Enabled:=false;
  groupbox1.Enabled:=false;
  edit1.Clear;
  edit2.Clear;
end;
//----------�رմ���-------------
procedure TClinicReg.ToolButton4Click(Sender: TObject);
begin
close;
end;

procedure TClinicReg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;

end.
