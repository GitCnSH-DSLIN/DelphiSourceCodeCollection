unit BookDocuForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ParentForm, ADODB, DB, ImgList, Grids, DBGrids, ComCtrls,
  ToolWin, StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask;

type
  TBookDocu = class(TParent)
    DBEdit3: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit1: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label10: TLabel;
    DBEdit6: TDBEdit;
    Label11: TLabel;
    Label12: TLabel;
    DBComboBox1: TDBComboBox;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    DBComboBox2: TDBComboBox;
    Label16: TLabel;
    DBEdit10: TDBEdit;
    Label17: TLabel;
    DBComboBox3: TDBComboBox;
    Label18: TLabel;
    DBCheckBox1: TDBCheckBox;
    ADOQuery2: TADOQuery;
    DBEdit11: TDBEdit;
    Label19: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure DBEdit11KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit8KeyPress(Sender: TObject; var Key: Char);
    procedure ToolButton7Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BookDocu: TBookDocu;
  ischecked:integer;

implementation

{$R *.dfm}

procedure TBookDocu.FormActivate(Sender: TObject);
var
name:string;
begin
  inherited;
//���á������硿�����б���������б���Ŀ
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select ���������� from ������');
adoquery2.Open;
dbcombobox2.Items.Clear;
while not adoquery2.Eof do
 begin
  name:=adoquery2.fieldbyname('����������').AsString;
  dbcombobox2.Items.Add(name);
  adoquery2.Next;
 end;
//���á����͡������б���������б���Ŀ
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select �������� from ͼ������');
adoquery2.Open;
dbcombobox1.Items.Clear;
while not adoquery2.Eof do
 begin
  name:=adoquery2.fieldbyname('��������').AsString;
  dbcombobox1.Items.Add(name);
  adoquery2.Next;
end;
//���á�������ơ������б���������б���Ŀ
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select ������� from ���');
adoquery2.Open;
dbcombobox3.Items.Clear;
while not adoquery2.Eof do
 begin
  name:=adoquery2.fieldbyname('�������').AsString;
  dbcombobox3.Items.Add(name);
  adoquery2.Next;
end;


end;

procedure TBookDocu.ToolButton6Click(Sender: TObject);
var
 maxnum:integer;
 newnum:string;
begin
  inherited;
//�Զ�ȷ�����û����
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select max(���) ����� from ͼ����Ϣ');
adoquery2.Open;
maxnum:=adoquery2.FieldByName('�����').AsInteger;
maxnum:=maxnum+1;
newnum:=inttostr(maxnum);
if length(newnum)=1 then
 dbedit2.Text:='000000'+newnum;
if length(newnum)=2 then
 dbedit2.Text:='00000'+newnum;
if length(newnum)=3 then
 dbedit2.Text:='0000'+newnum;
if length(newnum)=4 then
 dbedit2.Text:='000'+newnum;
if length(newnum)=5 then
 dbedit2.Text:='00'+newnum;
if length(newnum)=6 then
 dbedit2.Text:='0'+newnum;
//ȷ��Ĭ�ϵ�����
dbcombobox2.SelText:=dbcombobox2.Items.Strings[0];
//��ʶ�û��Ƿ�ѡ���ˡ��Ƿ�ע������ѡ��
isChecked:=0;
end;

procedure TBookDocu.DBCheckBox1Click(Sender: TObject);
begin
  inherited;
 ischecked:=(ischecked)or(1);
end;

procedure TBookDocu.ToolButton10Click(Sender: TObject);
begin
 //ע����δ���һ��Ҫ����inherited֮ǰ����Ϊ�̳еĸ����еĴ�����post���������ݿ��ύ�޸�
 if isChecked=0 then
  begin
   showmessage('δѡ���Ƿ�ע����������ѡ��');
   exit;
  end;
 inherited;
 ischecked:=0;

end;
//�ж��ڡ�ҳ�롿�͡��۸��ı�����������Ƿ�������
procedure TBookDocu.DBEdit11KeyPress(Sender: TObject; var Key: Char);
var
input:char;
begin
  inherited;
  input:=key;
  if (key>=#30)and(key<=#39) then
   dbedit11.Text:=dbedit11.Text+input;

end;

procedure TBookDocu.DBEdit8KeyPress(Sender: TObject; var Key: Char);
var
input:char;
begin
  inherited;
  input:=key;
  if (key>=#30)and(key<=#39) then
  dbedit8.Text:=dbedit8.Text+input;
end;

procedure TBookDocu.ToolButton7Click(Sender: TObject);
begin
  inherited;
  //����Ҫ�ж��Ƿ�ѡ��ע��
  ischecked:=1;

end;

procedure TBookDocu.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  inherited;
    //���ñ���ֶο��
  dbgrid1.Columns[0].Width:=96;
  dbgrid1.Columns[1].Width:=48;
  dbgrid1.Columns[2].Width:=128;
  dbgrid1.Columns[3].Width:=128;
  dbgrid1.Columns[4].Width:=80;
  dbgrid1.Columns[5].Width:=80;
  dbgrid1.Columns[6].Width:=80;
  dbgrid1.Columns[7].Width:=96;
  dbgrid1.Columns[8].Width:=80;
  dbgrid1.Columns[9].Width:=80;
  dbgrid1.Columns[10].Width:=80;
  dbgrid1.Columns[11].Width:=80;
  dbgrid1.Columns[12].Width:=80;
  dbgrid1.Columns[13].Width:=64;
  dbgrid1.Columns[14].Width:=64;
  dbgrid1.Columns[15].Width:=64;

end;

end.
