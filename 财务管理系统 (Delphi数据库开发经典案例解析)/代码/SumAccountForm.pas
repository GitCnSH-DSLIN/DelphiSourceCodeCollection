unit SumAccountForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls;

type
  TSumAccount = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    ADOQuery1: TADOQuery;
    StringGrid1: TStringGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);


    procedure FormShow(Sender: TObject);


  private
    { Private declarations }
    //ͳ�Ƽ����Ƿ�ƽ��
    procedure sumtable();
  public
    { Public declarations }
    //��ʹ�ú����ʱ�����õĺ���
    procedure foruse();
    //��ʼ���ʱ�ʱʹ��
    procedure forinitial();

  end;

var
  SumAccount: TSumAccount;

implementation

uses MainForm;

{$R *.dfm}

procedure TSumAccount.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;

end;

procedure TSumAccount.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
 //���ù�������
 datasource1.DataSet.Filter:='���ڷ����跽<>0 OR ���ڷ�������<>0 OR �ڳ��跽<>0 OR �ڳ�����<>0 OR ��ĩ�跽<>0 OR ��ĩ����<>0';
 datasource1.DataSet.Filtered:=true;
 //���ñ���п�
dbgrid1.Columns[0].Width:=48;
dbgrid1.Columns[1].Width:=100;
dbgrid1.Columns[2].Width:=64;
dbgrid1.Columns[3].Width:=64;
dbgrid1.Columns[4].Width:=64;
dbgrid1.Columns[5].Width:=64;
dbgrid1.Columns[6].Width:=64;
dbgrid1.Columns[7].Width:=64;

end;

//----------------��ʼ���������------------

procedure TSumAccount.FormShow(Sender: TObject);

begin


//���ñ���ͷ��ʾ����
stringgrid1.Cells[1,0]:='�Ƿ�ƽ��';
stringgrid1.Cells[2,0]:='�ڳ��跽';
stringgrid1.Cells[3,0]:='�ڳ�����';
stringgrid1.Cells[4,0]:='���ڷ����跽';
stringgrid1.Cells[5,0]:='���ڷ�������';
stringgrid1.Cells[6,0]:='��ĩ�跽';
stringgrid1.Cells[7,0]:='��ĩ����';
stringgrid1.Cells[0,1]:='�ϼ�';
stringgrid1.ColWidths[0]:=48;
stringgrid1.ColWidths[1]:=64;
stringgrid1.ColWidths[2]:=64;
stringgrid1.ColWidths[3]:=64;
stringgrid1.ColWidths[4]:=128;
stringgrid1.ColWidths[5]:=128;
stringgrid1.ColWidths[6]:=64;
stringgrid1.ColWidths[7]:=64;
stringgrid1.RowHeights[0]:=20;
stringgrid1.RowHeights[1]:=20;

end;

//------------�ڳ�ʼ��ʱͳ�ƹ��������-----------
procedure TSumAccount.forinitial;
begin
//���ݲ�ͬ��״̬����SQL���룬�Լ��㲻ͬ��ƽ�����
 adoquery1.Close;
 adoquery1.SQL.Clear;
 adoquery1.SQL.Add('select ��Ŀ����, ��Ŀ����,');
 adoquery1.SQL.Add('(case when ����=''�跽'' then �ڳ���� else 0 end - �ۼƽ跽)');
 adoquery1.SQL.Add('as �ڳ��跽,');
 adoquery1.SQL.Add('(case when ����=''����'' then �ڳ���� else 0 end - �ۼƴ���)');
 adoquery1.SQL.Add(' as �ڳ�����,');
 adoquery1.SQL.Add('�ۼƽ跽 as ���ڷ����跽,�ۼƴ��� as ���ڷ�������,');
 adoquery1.SQL.Add('  case when ����=''�跽'' then �ڳ���� else 0 end as ��ĩ�跽,');
 adoquery1.SQL.Add('  case when ����=''����'' then �ڳ���� else 0 end as ��ĩ����');
 adoquery1.SQL.Add(' from �ʲ���ʼ���� where �ۼƽ跽<>0 or �ۼƴ���<>0 or �ڳ����<>0');
 adoquery1.Open;
 //ͳ������
 sumtable;
end;


//------------����ʽʹ��ʱͳ�ƹ��������-----------
procedure TSumAccount.foruse;
begin
//���ݲ�ͬ��״̬����SQL���룬�Լ��㲻ͬ��ƽ�����

 adoquery1.Close;
 adoquery1.SQL.Clear;
 adoquery1.SQL.Add('select a.��Ŀ����, b.��Ŀ����,');
 adoquery1.SQL.Add('(case when a.����=''�跽'' then �ڳ���� else 0 end )');
 adoquery1.SQL.Add(' as �ڳ��跽,');
 adoquery1.SQL.Add('(case when a.����=''����'' then �ڳ���� else 0 end)');
 adoquery1.SQL.Add('as �ڳ�����,');
 adoquery1.SQL.Add('���ڽ跽�ϼ� as ���ڷ����跽, ���ڴ����ϼ� as ���ڷ�������,');
 adoquery1.SQL.Add('case when a.����=''�跽'' then ��� else 0 end as ��ĩ�跽,');
 adoquery1.SQL.Add('case when a.����=''����'' then ��� else 0 end as ��ĩ����');
 adoquery1.SQL.Add(' from ���ڻ����ʲ� as a, ��Ŀ�� as b  ');
 adoquery1.SQL.Add(' where a.��Ŀ���� = b.��Ŀ���� and (���ڽ跽�ϼ�<> 0');
 adoquery1.SQL.Add(' or ���ڴ����ϼ�<>0 or �ڳ����<>0 or ���<>0)');
 adoquery1.Open;
  //ͳ������
 sumtable;
end;

//-----------------�����ݽ���ͳ��---------------
procedure TSumAccount.sumtable;
var
count,i:integer;
val1,val2,val3,val4,val5,val6:double;
begin
 //����ƽ����еļ�¼��
count:=datasource1.DataSet.RecordCount;
//ͳ����Ϣ���ж��Ƿ�����ƽ��
val1:=0;
val2:=0;
val3:=0;
val4:=0;
val5:=0;
val6:=0;
while not datasource1.DataSet.Eof do
 begin
  val1:=strtofloat(dbgrid1.Fields[2].Text)+val1;
  val2:=strtofloat(dbgrid1.Fields[3].Text)+val2;
  val3:=strtofloat(dbgrid1.Fields[4].Text)+val3;
  val4:=strtofloat(dbgrid1.Fields[5].Text)+val4;
  val5:=strtofloat(dbgrid1.Fields[6].Text)+val5;
  val6:=strtofloat(dbgrid1.Fields[7].Text)+val6;
  datasource1.DataSet.Next;
 end;
//��ʾͳ�ƽ��
stringgrid1.Cells[1,1]:='�Ƿ�ƽ��';
stringgrid1.Cells[2,1]:=floattostr(val1);
stringgrid1.Cells[3,1]:=floattostr(val2);
stringgrid1.Cells[4,1]:=floattostr(val3);
stringgrid1.Cells[5,1]:=floattostr(val4);
stringgrid1.Cells[6,1]:=floattostr(val5);
stringgrid1.Cells[7,1]:=floattostr(val6);
if (val1<>val2)or(val3<>val4)or(val5<>val6) then
 begin
 stringgrid1.Cells[1,1]:='��ƽ��';
 stringgrid1.Font.Color:=clred;
 end
 else
 stringgrid1.Cells[1,1]:='ƽ��';
end;




end.
