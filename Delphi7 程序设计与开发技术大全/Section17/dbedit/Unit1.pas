unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, DBCtrls, ExtCtrls, DB, DBTables, Mask;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    DBNavigator1: TDBNavigator;
    Panel1: TPanel;
    Button1: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Label6: TLabel;
    BitBtn1: TBitBtn;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    procedure Button1Click(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure Edit1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
with Table1 do
begin
Open;
Setkey;
FieldByName('Name').AsString:=Edit1.text;
if gotokey then
label6.Caption:='��ѯ�ɹ��� '
else
begin
label6.Caption:='��ѯʧ�ܣ� ' ;
dbedit1.text:='';
dbedit2.text:='';
dbedit3.text:='';
dbedit4.text:='';
end ;
end ;
end ;


procedure TForm1.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
with label6 do
case Button of
nbFirst: Caption :='���������¼��' ;
nbPrior: Caption :='���������¼��' ;
nbNext: Caption :='���������¼��' ;
nbLast: Caption :='���������¼�� ' ;
nbInsert: Caption :='�����¼�� ' ;
nbDelete: Caption :='ɾ����¼�� ' ;
nbEdit: Caption :='���ڱ༭��¼��' ;
nbPost: Caption :='�ύ��¼�� ' ;
nbCancel: Caption :='ȡ���޸ģ� ' ;
nbRefresh: Caption :='ˢ�¼�¼�� ' ;
end ;
table1.open;
Edit1.Text:=table1.FieldByName('Name').AsString;
end;
procedure TForm1.Edit1Click(Sender: TObject);
begin
label6.Caption :='���ڲ�ѯ��¼�� ' ;
end;

end.
