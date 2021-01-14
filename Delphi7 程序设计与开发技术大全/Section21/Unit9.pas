unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, ComCtrls, Mask, DBCtrls;

type
  TForm9 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    DBGrid1: TDBGrid;
    RadioGroup1: TRadioGroup;
    Label2: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label4: TLabel;
    Edit4: TEdit;
    Button5: TButton;
    RadioGroup2: TRadioGroup;
    Edit6: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    DBCheckBox1: TDBCheckBox;
    DBEdit1: TDBEdit;
    DBCheckBox2: TDBCheckBox;
    DBEdit2: TDBEdit;
    DBGrid2: TDBGrid;
    procedure TabSheet1Show(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm9.TabSheet1Show(Sender: TObject);
begin  {���������ֶ�Ϊ�����ֶ�}
//datamodule2.BookTable.IndexFieldNames:='BookName';
end;

procedure TForm9.TabSheet2Show(Sender: TObject);
begin   {�����������ֶ�Ϊ�����ֶ�}
//datamodule2.BookTable.IndexFieldNames:='author';
end;

procedure TForm9.Button5Click(Sender: TObject);
begin     {���������ؼ��ֲ�ѯ}
datamodule2.BookTable.Open;
datamodule2.BookTable.FindNearest([edit1.text]);
end;

procedure TForm9.Button1Click(Sender: TObject);
begin       {������������ѯ}
datamodule2.BookTable.Open;
datamodule2.BookTable.FindNearest([edit4.text]);
end;

procedure TForm9.Button2Click(Sender: TObject);
var srecord:integer;
sstudno: string ;
sbookno: string ;
sordstno: string ;
begin {�жϴ�ͼ���Ƿ��ѱ�ԤԼ}
if dbcheckbox1.checked=true then
begin
showmessage('�����ѱ�����ͬѧԤԼ���޷��ٴα����Ļ�ԤԼ! ');
radiogroup1.Enabled:=false;
button2.Enabled :=false;
end
else
begin {�ж�ѧ���Ƿ���ȷ}
sstudno:=edit3.text;
datamodule2.studentTable.IndexFieldNames:='stuno';
datamodule2.studentTable.Open;
if not datamodule2.Studenttable.Findkey([sstudno]) then
begin
showmessage('ѧ�Ŵ���! ');
edit6.Enabled :=false;
button6.Enabled := false;
end
else
begin
case radiogroup1.ItemIndex of
0: {ͼ�鱻���ĵ����}
begin
{�ڽ��ļ�¼���ݱ���в���һ���µĽ��ļ�¼}
with datamodule2.RecordTable do
begin
open;
last;
srecord:=datamodule2.RecordTable.fieldbyname('recordno').asinteger + 1 ;
sstudno:=edit6.text;
sbookno:=dbedit2.text;
insert; {����һ���¼�¼�����ø��ֶ�ֵ}
setfields([srecord,sstudno,sbookno,null,null,null,false,false]);
post;
showmessage('���ĳɹ�! ');
end;
{�޸�ͼ���¼���ݱ���е���Ӧ��¼}
with datamodule2.BookTable do
begin
sbookno:=dbedit2.text;
IndexFieldNames:='BookNo';
close;
readonly:=false;
Open;
FindKey([sbookno]); {ָ���ͼ���¼}
edit;
{�޸Ĵ�ͼ���ͼ���¼}
setfields([nil,nil,nil,nil,nil,true,false]);
datamodule2.BookTable.Post;
showmessage('���ĳɹ�! ');
end ;
end ;
1 : {ԤԼͼ��}
begin
{�޸�ͼ���¼���ݱ���е���Ӧ��¼}
with datamodule2.BookTable do
begin
sbookno:=dbedit2.text;
datamodule2.BookTable.close;
IndexFieldNames:='BookNo';
datamodule2.BookTable.readonly:=false ;
Open;
Findkey([sbookno]); {ָ���ͼ���¼}
edit ;
{�޸Ĵ�ͼ���ͼ���¼��ԤԼ״ֵ̬}
setfields([nil,nil,nil,nil,nil,true,true]);
post;
end;
{�ڽ��ļ�¼���ݱ���в���һ���µĽ��ļ�¼}
with datamodule2.RecordTable do
begin
sordstno:=edit6.text;
IndexFieldNames:='BookNo';
Open;
Findkey([dbedit2.text]); {ָ���ͼ��Ľ��ļ�¼}
edit ;
{�޸Ĵ�ͼ��Ľ��ļ�¼�е�ԤԼ״ֵ̬}
setfields([nil,nil,nil,nil,nil,nil,true]);
post;
end ;
showmessage('ԤԼ�ɹ�! ');
end ;
end ;
end ;
end ;
end ;
procedure TForm9.Button3Click(Sender: TObject);
begin
edit6.clear;
edit6.Enabled :=true;
button6.Enabled :=True;
radiogroup2.Enabled:=true;
end;

procedure TForm9.Button4Click(Sender: TObject);
begin
modalresult:=mrok;
end;

procedure TForm9.Button6Click(Sender: TObject);
var srecord:integer;
sstudno: string ;
sbookno: string ;
sordstno : string ;
begin {�жϴ�ͼ���Ƿ��ѱ�ԤԼ}
if dbcheckbox2.checked=true then
begin
showmessage('���ĳɹ�! ');
//showmessage('�����ѱ�����ͬѧԤԼ���޷��ٴα����Ļ�ԤԼ! ');
radiogroup2.Enabled:=false;
button6.Enabled :=false;
end
else
begin {�ж�ѧ���Ƿ���ȷ}
sstudno:=edit6.text;
datamodule2.studentTable.IndexFieldNames:='stuno';
datamodule2.studentTable.Open;
if not datamodule2.Studenttable.Findkey([sstudno]) then
begin
showmessage('ѧ�Ŵ���! ');
edit6.Enabled :=false;
button6.Enabled := false;
end
else
begin
case radiogroup2.ItemIndex of
0: {ͼ�鱻���ĵ����}
begin
{�ڽ��ļ�¼���ݱ���в���һ���µĽ��ļ�¼}
with datamodule2.RecordTable do
begin
open;
last;
srecord:=datamodule2.RecordTable.fieldbyname('recordno').asinteger + 1 ;
sstudno:=edit6.text;
sbookno:=dbedit2.text;
insert; {����һ���¼�¼�����ø��ֶ�ֵ}
setfields([srecord,sbookno,sstudno,null,null,null,false,false]);
post;
end;
{�޸�ͼ���¼���ݱ���е���Ӧ��¼}
with datamodule2.BookTable do
begin
sbookno:=dbedit2.text;
IndexFieldNames:='BookNo';
close;
readonly:=false;
Open;
FindKey([sbookno]); {ָ���ͼ���¼}
edit;
{�޸Ĵ�ͼ���ͼ���¼}
setfields([nil,nil,nil,nil,nil,true,false]);
datamodule2.BookTable.Post;
showmessage('���ĳɹ�! ');
end ;
end ;
1 : {ԤԼͼ��}
begin
{�޸�ͼ���¼���ݱ���е���Ӧ��¼}
with datamodule2.BookTable do
begin
sbookno:=dbedit2.text;
datamodule2.BookTable.close;
IndexFieldNames:='BookNo';
datamodule2.BookTable.readonly:=false ;
Open;
Findkey([sbookno]); {ָ���ͼ���¼}
edit ;
{�޸Ĵ�ͼ���ͼ���¼��ԤԼ״ֵ̬}
setfields([nil,nil,nil,nil,nil,true,true]);
post;
end;
{�ڽ��ļ�¼���ݱ���в���һ���µĽ��ļ�¼}
with datamodule2.RecordTable do
begin
sordstno:=edit6.text;
IndexFieldNames:='BookNo';
Open;
Findkey([dbedit1.text]); {ָ���ͼ��Ľ��ļ�¼}
edit ;
{�޸Ĵ�ͼ��Ľ��ļ�¼�е�ԤԼ״ֵ̬}
setfields([nil,nil,nil,sstudno,nil,true,nil]);
post;
end ;
showmessage('ԤԼ�ɹ�! ');
end ;
end ;
end ;
end ;

end;

procedure TForm9.Button7Click(Sender: TObject);
begin
edit6.clear;
edit6.Enabled :=true;
button6.Enabled :=True;
radiogroup2.Enabled:=true;
end;

procedure TForm9.Button8Click(Sender: TObject);
begin
modalresult:=mrok;
end;

end.
