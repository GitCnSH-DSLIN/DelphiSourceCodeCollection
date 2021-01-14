unit ScheduleForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, DB, ADODB, StdCtrls;

type
  TSchedule = class(TForm)
    StringGrid1: TStringGrid;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Edit3: TEdit;
    Edit2: TEdit;
    Edit1: TEdit;
    ADOQuery1: TADOQuery;
    ADOConnection1: TADOConnection;
    procedure FormShow(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    id:string;
    procedure selrecord();//��ѯѧ���Ŀγ̼�¼
  end;

var
  Schedule: TSchedule;

implementation

{$R *.dfm}
//------------------���ñ��---------------------
procedure TSchedule.FormShow(Sender: TObject);
var
i,j:integer;
begin
stringgrid1.Cells[0,0]:='����һ';
stringgrid1.Cells[1,0]:='���ڶ�';
stringgrid1.Cells[2,0]:='������';
stringgrid1.Cells[3,0]:='������';
stringgrid1.Cells[4,0]:='������';

stringgrid1.RowHeights[0]:=25;
for i:=0 to 4 do
 stringgrid1.ColWidths[i]:=120;
for i:=1 to 7 do
 stringgrid1.RowHeights[i]:=50;

end;


//-----------------------���������ѧ����ʾѧ����Ϣ�Ϳα�-------------------------
procedure TSchedule.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8,#13]) then //���ı�����ֻ����������
 begin
 key:=#0;
 exit;
 end;

//�س����룬��ѧ������Ϣ��ʾ���ı�����
if key=#13 then
 begin
  id:=trim(edit1.Text);
  //�����һ�ε�����
  edit2.Clear;
  edit3.Clear;

  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select a.����,b.�༶����,a.ѧ����� from ѧ����Ϣ a,�༶��Ϣ b');
  adoquery1.SQL.Add('where (a.ѧ��='''+id+''')and(a.�༶���=b.�༶���)and(a.ѧ�����=''1'')');
  adoquery1.Open;

  if adoquery1.RecordCount=0 then
   begin
    showmessage('ѧ���������');
    exit;
   end;
  edit2.Text:=trim(adoquery1.fieldbyname('����').AsString);
  edit3.Text:=trim(adoquery1.fieldbyname('�༶����').AsString);
  selrecord();
 end;


end;


//----------------�ڱ�����ʾ�γ���Ϣ-------------------
procedure TSchedule.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
i,j:integer;
rt:Trect;
begin

  stringgrid1.Canvas.Brush.Style:=bsClear;
  //ָ��ѧ���α�ĵ�һ����¼
  if adoquery1.SQL.Text<>'' then adoquery1.First;
  while not adoquery1.Eof do
   begin
   i:=adoquery1.fieldbyname('�Ͽ�ʱ����').AsInteger-1;
   j:=adoquery1.fieldbyname('�Ͽ�ʱ���').AsInteger;

   //stringgrid�ؼ��в��ܻ��У����Ҫ��̽�������Ҫ�����ַŵ����ʵĵط�
   rt:=stringgrid1.CellRect(i,j);
   stringgrid1.Canvas.TextOut(rt.Left+5,rt.Top+5,trim(adoquery1.fieldbyname('�γ�����').AsString));
   stringgrid1.Canvas.TextOut(rt.Left+5,rt.Top+25,trim(adoquery1.fieldbyname('�Ͽεص�').AsString));
   adoquery1.Next;
   end;

end;

//---------���������ѧ�Ų�ѯ�γ���Ϣ-----------
procedure TSchedule.selrecord;
var
i,j:integer;
begin
   //���ԭ���ı��
  for i:=0 to 4 do
   for j:=1 to 7 do
    stringgrid1.Cells[i,j]:='';
  //��ѧ���Ŀγ����ڿγ̱���
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select b.�γ�����,b.��ʦ,c.�Ͽ�ʱ����,c.�Ͽ�ʱ���,c.�Ͽεص�');
  adoquery1.SQL.Add('from ѡ�α� a,�γ���Ϣ b,�γ̱� c');
  adoquery1.SQL.Add('where (a.ѧ��='''+id+''')and(a.�����=c.�����)and(''200400000''+b.�γ̱��=a.�����)');
  adoquery1.Open;
end;

procedure TSchedule.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;

end.
