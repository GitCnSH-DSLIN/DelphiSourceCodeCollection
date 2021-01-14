unit CourseElectForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids, ExtCtrls, Buttons;

type
  TCourseElect = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    ADOQuery1: TADOQuery;
    ADOConnection1: TADOConnection;
    DataSource1: TDataSource;
    ADOQuery2: TADOQuery;
    DBGrid1: TDBGrid;
    DataSource2: TDataSource;
    Panel1: TPanel;
    DBGrid2: TDBGrid;
    Edit4: TEdit;
    Label4: TLabel;
    Edit5: TEdit;
    Label5: TLabel;
    Edit6: TEdit;
    Label6: TLabel;
    Edit7: TEdit;
    Label7: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    ADOQuery3: TADOQuery;
    ADOCommand1: TADOCommand;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure listcourse(id:string);
  end;

var
  CourseElect: TCourseElect;
  id:string;//ѡ��ѧ����ѧ��
implementation

{$R *.dfm}
uses ScheduleForm;
//--------------����ѧ�ź�س�����ʾѧ����Ϣ���Ѿ�ѡ�Ŀγ�----------------
procedure TCourseElect.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8,#13]) then //���ı�����ֻ����������
begin
 key:=#0;
 exit;
end;
//�س����룬���ڼ�ѧ������Ϣ��ʾ���ı�����
if key=#13 then
 begin
  id:=trim(edit1.Text);
  //�����һ�ε�����
  edit2.Clear;
  edit3.Clear;
  adoquery2.Close;

  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select a.����,b.�༶����,a.ѧ����� from ѧ����Ϣ a,�༶��Ϣ b');
  adoquery1.SQL.Add('where (a.ѧ��='''+id+''')and(a.�༶���=b.�༶���)');
  adoquery1.Open;
  if trim(adoquery1.FieldByName('ѧ�����').AsString)='1' then
  begin
  edit2.Text:=trim(adoquery1.fieldbyname('����').AsString);
  edit3.Text:=trim(adoquery1.fieldbyname('�༶����').AsString);
  listcourse(id); //�г���ѡ�γ�
  //����ʼѡ��
  bitbtn2.Enabled:=true;
  bitbtn3.Enabled:=true;
  bitbtn4.Enabled:=true;
  end
  else
   begin
   //ֻ���ڼ�ѧ������ѡ��
   showmessage('�������ڼ�ѧ��������ѡ��');
   bitbtn2.Enabled:=false;
   bitbtn3.Enabled:=false;
   bitbtn4.Enabled:=false;
   id:='';
   end;
 end;

end;

//--------��ʾѧ���Ѿ�ѡ�Ŀγ�----------
procedure TCourseElect.listcourse(id: string);
begin
  //������ѡ��������ѧ���Ѿ�ѡ���Ŀγ����ڱ���
  adoquery2.Close;
  adoquery2.SQL.Clear;
  adoquery2.SQL.Add('select a.ѧ��,a.�����,b.�γ�����,b.��ʦ,b.����ϵ��,c.�Ͽ�ʱ����,c.�Ͽ�ʱ���,c.�Ͽεص�');
  adoquery2.SQL.Add('from ѡ�α� a,�γ���Ϣ b,�γ̱� c');
  adoquery2.SQL.Add('where (a.ѧ��='''+id+''')and(a.�����=c.�����)and(''200400000''+b.�γ̱��=a.�����)');
  adoquery2.Open;
end;

//---------------�γ̲�ѯ-------------------
procedure TCourseElect.BitBtn1Click(Sender: TObject);
var
sql:string;
begin
sql:='';
if trim(edit4.Text)<>'' then
 sql:=sql+'ƴ���� like ''%'+trim(edit4.Text)+'%'' AND ';
if trim(edit5.Text)<>'' then
 sql:=sql+'�γ����� like ''%'+trim(edit5.Text)+'%'' AND ';
if trim(edit6.Text)<>'' then
 sql:=sql+'�γ̱��='''+trim(edit6.Text)+''' AND ';
if trim(edit7.Text)<>'' then
 sql:=sql+'����� like ''%'+trim(edit7.Text)+'%'' AND ';

sql:=copy(sql,1,length(sql)-4);
adoquery3.Filtered:=false;
adoquery3.Active:=false;
adoquery3.Filter:=sql;
adoquery3.Active:=true;
adoquery3.Filtered:=true;

end;

//-----------��ѡ��Ŀγ���ӵ�ѧ����ѡ�α���--------------
procedure TCourseElect.BitBtn2Click(Sender: TObject);
var
num:string;
day,section:integer;
begin
//δѡ��γ�ʱ���������ύ
if adoquery3.RecordCount=0 then
 begin
  showmessage('����ѡ��һ�ſγ�');
  exit;
 end;
num:=trim(dbgrid2.Fields[0].Text);//��������

//�ж���ѡ�Ŀγ��Ƿ���ѡ���Ƿ��������Ѿ�ѡ�Ŀγ���ʱ���ͻ
adoquery1.Close;
adoquery1.SQL.Clear;
adoquery1.SQL.Add('select �Ͽ�ʱ����,�Ͽ�ʱ��� from �γ̱�');
adoquery1.SQL.Add('where �γ̱��='''+dbgrid2.Fields[1].Text+'''');
adoquery1.Open;

while not adoquery1.Eof do
 begin
  day:=adoquery1.fieldbyname('�Ͽ�ʱ����').AsInteger;
  section:=adoquery1.fieldbyname('�Ͽ�ʱ���').AsInteger;
  adoquery2.First;
  while not adoquery2.Eof do
   begin
   //�жϿγ��Ƿ���ѡ
   if (trim(adoquery2.fieldbyname('�����').AsString)=num) then
    begin
     showmessage('��ѡ�Ŀγ̣�'+trim(adoquery2.fieldbyname('�γ�����').AsString)+' ���ڿα��У���ѡ�������γ�');
     exit;
    end;
   //�жϿγ��Ƿ�����ѡ�γ���ʱ���ͻ
   if (adoquery2.fieldbyname('�Ͽ�ʱ����').AsInteger=day)and(adoquery2.fieldbyname('�Ͽ�ʱ���').AsInteger=section) then
    begin
     showmessage('��ѡ�γ̵��Ͽ�ʱ������ѡ�� '+trim(adoquery2.fieldbyname('�γ�����').AsString)+' ��ͻ!');
     exit;
    end;
   adoquery2.Next;
   end;
  adoquery1.Next;
 end;
//ѡ��
adocommand1.CommandText:='insert into ѡ�α�([ѧ��],[�����]) values('''+id+''','''+trim(dbgrid2.Fields[0].Text)+''')';
adocommand1.Execute;
listcourse(id);//ˢ�����ݱ�
end;


//-------------ɾ����ѡ�γ�-------------
procedure TCourseElect.BitBtn3Click(Sender: TObject);
begin
if application.MessageBox('ȷʵɾ����ѡ�γ̣�','ȷ��ɾ��',MB_OKCANCEL)=IDOK then
 begin
  adocommand1.CommandText:='delete from ѡ�α� where (ѧ��='''+trim(dbgrid1.Fields[0].Text)+''')and(�����='''+trim(dbgrid1.Fields[1].Text)+''')';
  adocommand1.Execute;
  listcourse(id);//ˢ���б�
 end;
end;

//--------------���á��α��ѯ�����壬��ʾѧ���α�--------------
procedure TCourseElect.BitBtn4Click(Sender: TObject);
var
newform:TSchedule;
begin
  newform:=TSchedule.Create(application);
  newform.Caption:=edit2.Text+'ͬѧ�γ̱�';
  newform.id:=id;
  //����ѧ�ţ��������༶�Ȳ���
  newform.Edit1.Text:=id;
  newform.Edit2.Text:=edit2.Text;
  newform.Edit3.Text:=edit3.Text;
  newform.GroupBox1.Enabled:=false;//��������ʾ���˵Ŀγ̱�
  //��ʾ�α�
  newform.selrecord();
end;

procedure TCourseElect.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
action:=cafree;
end;

end.
