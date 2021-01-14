unit PrintScoreForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DB, ADODB, Buttons;

type
  TPrintScore = class(TForm)
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    ADOQuery1: TADOQuery;
    ADOConnection1: TADOConnection;
    ADOQuery2: TADOQuery;
    DataSource1: TDataSource;
    BitBtn1: TBitBtn;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure showscore();
  end;

var
  PrintScore: TPrintScore;
  id:string;
implementation

{$R *.dfm}
uses ReportForm;
//--------------����ѧ�ź�س�����ʾѧ����Ϣ-----------------
procedure TPrintScore.Edit1KeyPress(Sender: TObject; var Key: Char);
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
  adoquery1.SQL.Add('where (a.ѧ��='''+id+''')and(a.�༶���=b.�༶���)');
  adoquery1.Open;

  if adoquery1.RecordCount=0 then
   begin
    showmessage('ѧ���������');
    bitbtn1.Enabled:=false;//ѧ��������������±��Ϊ�գ��������ӡ
    exit;
   end
   else
    bitbtn1.Enabled:=true;

  edit2.Text:=trim(adoquery1.fieldbyname('����').AsString);
  edit3.Text:=trim(adoquery1.fieldbyname('�༶����').AsString);
  showscore();
 end;
end;

//-----------��ѧ���ĳɼ����ڱ���-------------------
procedure TPrintScore.showscore;
begin
 
 adoquery2.SQL.Clear;
 adoquery2.SQL.Add('select a.���,b.�γ�����,a.�ɼ�,b.����ϵ��,b.��ʦ from �ɼ��� a,�γ���Ϣ b');
 adoquery2.SQL.Add('where (a.ѧ��='''+id+''')and(a.�γ̱��=b.�γ̱��)');
 adoquery2.Open;
end;


//-------------------��ӡ�ɼ���-------------------------
procedure TPrintScore.BitBtn1Click(Sender: TObject);
begin
 report.adoquery1.SQL.Clear;
 report.adoquery1.SQL.Add('select a.ѧ��,a.���,b.�γ�����,c.����,a.�ɼ�,b.����ϵ��,b.��ʦ from �ɼ��� a,�γ���Ϣ b,ѧ����Ϣ c');
 report.adoquery1.SQL.Add('where (a.ѧ��='''+id+''')and(a.�γ̱��=b.�γ̱��)and(c.ѧ��=a.ѧ��)');
 report.adoquery1.Open;
 report.QuickRep1.Preview;
end;

procedure TPrintScore.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;

end.
