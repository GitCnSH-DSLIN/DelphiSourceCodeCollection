unit Unit10;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ExtCtrls, Mask, DBCtrls,DB;

type
   TForm10 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button2: TButton;
    Button3: TButton;
    DBGrid2: TDBGrid;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;
     loc:boolean;
   //locOp:TLocateOptions;
implementation

uses Unit2;

{$R *.dfm}

procedure TForm10.Button1Click(Sender: TObject);
{��ѯ���˽������}
var studno:string;
begin
studno:=edit1.Text;
datamodule2.Studenttable.open;
{�ж�ѧ��ѧ���Ƿ����}
if not datamodule2.Studenttable.Findkey([edit1.text]) then
begin
showmessage('ѧ�Ŵ���! ');
edit1.clear ;
edit1.SetFocus ;
end
else
begin
{����Q u e r y���������}
with datamodule2.query1 do
begin
close;
DatabaseName :='work';
DataSource :=datamodule2.RecordDS ;
SQL.clear; {����S Q L������Q u e r y���ָ��ָ��ѧ�ŵĽ��ļ�¼}
SQL.add( 'SELECT BookNo, Borrowdate,Returndate,Delayed');
SQL.add( 'FROM bRecord ');
SQL.add ('WHERE StuNo =+'''+studno+'''');
open;
end;
{����B o o k Ta b l e���������,��������Q u e r y���֮�����ϵ}
with datamodule2.BookTable do
begin
close;
DatabaseName := 'work';
IndexFieldNames := 'BookNo';
MasterFields := 'BookNo';
MasterSource := datamodule2.QueryDS ;
TableName := 'BookTable.db';
Active:=True ;
end ;
{����D B E d i t 1����,ʹ֮��ʾָ��ͼ���¼������}
with DBEdit1 do
begin
DataSource :=DataModule2.BookDS;
DataField :='BookName';
end ;
{����D B E d i t 2����,ʹ֮��ʾָ��ͼ���¼��������}
with DBEdit2 do
begin
DataSource := DataModule2.BookDS;
DataField := 'Author';
end ;
{����D B E d i t 3����,ʹ֮��ʾָ��ͼ���¼�ĳ�����}
with DBEdit3 do
begin
DataSource := DataModule2.BookDS;
DataField := 'Publish';
end ;
{����D B E d i t 4����,ʹ֮��ʾ��Ҫ�黹ͼ���¼�����}
with DBEdit4 do
begin
DataSource := DataModule2.QueryDS;
DataField :='BookNo';
end ;
end ;
datamodule2.Studenttable.close;
end ;


procedure TForm10.Button2Click(Sender: TObject);
var sbookno: string;
snewstud:string;
begin
sbookno:=dbedit4.text;
with datamodule2.BookTable do
begin
close;
IndexFieldNames:='BookNo';
readonly:=false ;
open;
{��������ü�¼ָ��ָ��ͼ���¼�д�ͼ���¼}
Findkey([sbookno]);
end;
{�жϴ�ͼ���Ƿ�ԤԼ}
if datamodule2.BookTable.FieldByName('ordered').asboolean=true then
{�����ͼ���ѱ�ԤԼ}
begin
with datamodule2.BookTable do
begin
edit; {�޸�ͼ���¼�еĽ��ĺ�ԤԼ״̬�ֶ�ֵ}
SetFields([nil,nil,nil,nil,false,true]);
post;
end;
with datamodule2.RecordTable do
begin
Open;
loc:=datamodule2.RecordTable.locate('BookNo',sbookno,[loPartialKey]);

{��������ü�¼ָ��ָ����Ĵ�ͼ��ļ�¼}
//Findkey([ sbookno]);
snewstud:= datamodule2.RecordTable.FieldByName('orderstu').AsString;
datamodule2.RecordTable.edit;
datamodule2.RecordTable.setfields([nil,nil,snewstud,null,null,null,false,false]);
datamodule2.RecordTable.post;
end;
end
else {���ͼ��δ��ԤԼ}
begin
with datamodule2.BookTable do
begin
edit; {�޸�ͼ���¼�еĽ��ĺ�ԤԼ״̬�ֶ�ֵ}
SetFields([nil,nil,nil,nil,false,false]);
post;
end;
with datamodule2.RecordTable do
begin
//IndexFieldNames:='BookNo';
Open;
{��������ü�¼ָ��ָ����Ĵ�ͼ��ļ�¼}
Findkey([sbookno]);
Delete; {ɾ�����Ĵ�ͼ��ļ�¼}
post;
end;
end;
showmessage('�Ѿ����ͼ��黹! ');
end;

procedure TForm10.Button3Click(Sender: TObject);
begin
modalresult:=mrok;
end;

end.
