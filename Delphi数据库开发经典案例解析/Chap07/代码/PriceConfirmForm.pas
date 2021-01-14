unit PriceConfirmForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, DB, DBGrids, ADODB, Buttons;

type
  TPriceConfirm = class(TForm)
    Panel1: TPanel;
    StringGrid1: TStringGrid;
    Panel2: TPanel;
    ADOCommand1: TADOCommand;
    ADOQuery1: TADOQuery;
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DataSource2: TDataSource;
    Edit3: TEdit;
    Edit4: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    DBGrid2: TDBGrid;
    ADODataSet1: TADODataSet;
    Edit5: TEdit;
    Label6: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    
    procedure ComboBox1DropDown(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PriceConfirm: TPriceConfirm;
  curRow,curCol:integer;
implementation

{$R *.dfm}
//------����������������б��ʱ����ʾδ�������ﲡ����Ϣ��---------
procedure TPriceConfirm.ComboBox1DropDown(Sender: TObject);
begin
  dbgrid1.Visible:=true;
  dbgrid1.SetFocus;
end;
//����ѡ������ﲡ����Ϣ
procedure TPriceConfirm.DBGrid1DblClick(Sender: TObject);
begin
 combobox1.Text:=trim(dbgrid1.Fields[0].Text);
 edit1.Text:=trim(dbgrid1.Fields[1].Text);
 edit2.Text:=trim(dbgrid1.Fields[2].Text);
 edit3.Text:=trim(dbgrid1.Fields[3].Text);
 edit4.Text:=trim(dbgrid1.Fields[7].Text);
 dbgrid1.Visible:=false;
end;

//---------�������ݱ��ֶο��-------------
procedure TPriceConfirm.DataSource1DataChange(Sender: TObject;
  Field: TField);
var
i:integer;
begin
 dbgrid1.Columns[0].Width:=96;
 for i:=1 to 9 do
  dbgrid1.Columns[i].Width:=64;
end;

//------��������ҩƷ�ı���ֶο�Ⱥͱ�ͷ----------
procedure TPriceConfirm.FormShow(Sender: TObject);
var
i:integer;
begin
 stringgrid1.ColWidths[0]:=136;
 stringgrid1.ColWidths[1]:=128;
 stringgrid1.ColWidths[2]:=80;
 stringgrid1.ColWidths[3]:=80;
 stringgrid1.ColWidths[4]:=64;
 stringgrid1.ColWidths[5]:=80;
 stringgrid1.ColWidths[6]:=64;
 for i:=0 to 49 do
  stringgrid1.RowHeights[i]:=21;
 stringgrid1.Cells[0,0]:='���(����ҩƷƴ���س�)';
 stringgrid1.Cells[1,0]:='����';
 stringgrid1.Cells[2,0]:='���';
 stringgrid1.Cells[3,0]:='��λ';
 stringgrid1.Cells[4,0]:='����';
 stringgrid1.Cells[5,0]:='����';
 stringgrid1.Cells[6,0]:='���';
end;


procedure TPriceConfirm.StringGrid1KeyPress(Sender: TObject;
  var Key: Char);
var
 rt:Trect;
begin
 if curRow=0 then curRow:=1;//��ͷһ�в�����ѡ������

 if (key=#13)and(curCol=0)and(stringgrid1.Cells[0,curRow]<>'') then
  begin
    //���������ҩƷƴ������ʾҩƷ�б����û�ѡ������
    adodataset1.Filter:='ƴ���� like ''%'+stringgrid1.Cells[0,curRow]+'%''';
    adodataset1.Filtered:=true;
    rt:=stringgrid1.CellRect(curCol,curRow);
    dbgrid2.Left:=rt.Left+stringgrid1.Left;
    dbgrid2.Top:=rt.Top+23+stringgrid1.Top;

    dbgrid2.Visible:=true;
    dbgrid2.SetFocus;

  end;
end;

//-------------ȷ��ѡ�еĵ�Ԫ�񲢽���ҩƷ���ü���-----------
procedure TPriceConfirm.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
price,num,sum:double;
i:integer;
begin
  //ֻ������ƴ���������ֶ����룬������Ϣ�������޸�
  if (ACol=0)or(ACol=5) then
   stringgrid1.Options:=stringgrid1.Options+[goEditing]
  else
   stringgrid1.Options:=stringgrid1.Options-[goEditing];
  curCol:=ACol;
  curRow:=ARow;

  //��ҩƷ��Ϣ��������Ϊ��ʱ�����ܽ��м���
  sum:=0;
  for i:=1 to 49 do
  if (stringgrid1.Cells[0,i]<>'')and(stringgrid1.Cells[5,i]<>'') then
   begin
 //����ĳҩƷ���߼��ķ���
   num:=strtofloat(stringgrid1.Cells[5,i]);
   price:=strtofloat(stringgrid1.Cells[4,i]);
   stringgrid1.Cells[6,i]:=floattostr(price*num);
   sum:=sum+price*num; //����ϼƽ��
   edit5.Text:=floattostr(sum);
   end;
 
end;

//-----��ҩƷ�б��е����س�����ҩƷ��Ϣ���뵽����ı����-----
procedure TPriceConfirm.DBGrid2DblClick(Sender: TObject);
begin
stringgrid1.Cells[0,curRow]:=dbgrid2.Fields[0].Text;
stringgrid1.Cells[1,curRow]:=dbgrid2.Fields[1].Text;
stringgrid1.Cells[2,curRow]:=dbgrid2.Fields[2].Text;
stringgrid1.Cells[3,curRow]:=dbgrid2.Fields[3].Text;
stringgrid1.Cells[4,curRow]:=dbgrid2.Fields[4].Text;
stringgrid1.Cells[5,curRow]:='1';
dbgrid2.Visible:=false;

end;

//----���滮�۵�-----
procedure TPriceConfirm.BitBtn1Click(Sender: TObject);
var
sql1,sql2,sql3,temp,maxPatient:string;
i,j,num:integer;
begin
//�������ֶ�
if (trim(combobox1.Text)='')or(edit3.Text='')or(edit4.Text='') then
 begin
  showmessage('����ţ����ң�ҽ��Ϊ�����ֶ�');
  exit;
 end;
if (trim(edit5.Text)='') then
 begin
  showmessage('û�л�����ϸ');
  exit;
 end;
 //�����µ����ﻮ�۱��
 adoquery1.Close;
 adoquery1.SQL.Clear;
 adoquery1.SQL.Add('select max(���) ����� from ���ﻮ��');
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

 //���滮����Ϣ
  sql1:='insert into ���ﻮ��([���],[����],[�Һű��],[ҽ��],[����ʱ��],[���۽��],[�Ƿ��շ�],[�Ƿ�ҩ]) ';
  sql2:='values('''+maxPatient+''','''+edit3.Text+''','''+combobox1.Text+''','''+edit4.Text;
  sql3:=''','''+datetostr(date)+' '+timetostr(time)+''',cast('''+edit5.Text+''' as money),''��'',''��'')';
  adocommand1.CommandText:=sql1+sql2+sql3;
  adocommand1.Execute;

//���滮����ϸ
 for i:=1 to 49 do
 if (stringgrid1.Cells[0,i]<>'')and(stringgrid1.Cells[6,i]<>'') then
 begin
 sql1:='insert into ���ﻮ����ϸ([���۱��], [ҩƷ���], [����], [����], [���])';
 sql2:=' values('''+maxPatient+''','''+stringgrid1.Cells[0,i]+''','''+stringgrid1.Cells[4,i];
 sql3:=''','''+stringgrid1.Cells[5,i]+''','''+stringgrid1.Cells[6,i]+''')';
 adocommand1.CommandText:=sql1+sql2+sql3;
 adocommand1.Execute;
 end;

//�޸��Ѿ����۲�������
 adocommand1.CommandText:='update ����Һ� set �Ƿ��ѻ���=''��'' where ���='''+combobox1.Text+'''';
 adocommand1.Execute;
//ˢ�¹ҺŲ�������
 adotable1.Active:=false;
 adotable1.Active:=true;

//���ԭ�����������
combobox1.Clear;
edit1.Clear;
edit2.Clear;
edit3.Clear;
edit4.Clear;
edit5.Clear;
for i:=0 to 6 do
 for j:=1 to 49 do
  stringgrid1.Cells[i,j]:='';

end;

procedure TPriceConfirm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
action:=cafree;
end;

//------------ȡ�����뱣��----------------
procedure TPriceConfirm.BitBtn2Click(Sender: TObject);
var
i,j:integer;
begin
//���ԭ�����������
combobox1.Clear;
edit1.Clear;
edit2.Clear;
edit3.Clear;
edit4.Clear;
edit5.Clear;
for i:=0 to 6 do
 for j:=1 to 49 do
  stringgrid1.Cells[i,j]:='';
end;

end.
