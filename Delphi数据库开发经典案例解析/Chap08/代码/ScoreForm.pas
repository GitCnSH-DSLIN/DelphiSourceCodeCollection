unit ScoreForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, DB, ADODB;

type
  TScore = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Edit2: TEdit;
    Edit1: TEdit;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DBGrid1: TDBGrid;
    Edit4: TEdit;
    BitBtn4: TBitBtn;
    ADOCommand1: TADOCommand;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    ADOConnection1: TADOConnection;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure showscore();
  end;

var
  Score: TScore;
  courseNum:string;//����γ̱��
implementation

{$R *.dfm}



//------------��ʾĳ�γ�ѧ���ķ���-------------------
procedure TScore.BitBtn2Click(Sender: TObject);
begin
showscore();
end;

//--------------�޸�ѡ��ѧ���ĳɼ�--------------
procedure TScore.BitBtn4Click(Sender: TObject);
var
num:string;
begin
 if edit4.Text='' then
 begin
  showmessage('����������Ч�ɼ�');
  exit;
 end;

 num:=trim(dbgrid1.Fields[0].Text);
 if num='' then
  begin
   showmessage('����ѡ��һ��ѡ��ѧ��');
   exit;
  end;
 //�޸�ѧ���ɼ�
 adocommand1.CommandText:='update �ɼ��� set �ɼ�='''+trim(edit4.Text)+''' where ���='''+num+'''';
 adocommand1.Execute;
 showscore();
end;

//------------��ʾĳ�γ�ѧ���ķ���-------------------
procedure TScore.showscore;
var
pyCode,courseID,courseName:string;//���������ƴ����Ϳγ����ƣ��γ̱��
begin
 courseNum:='';//��ձ�����ȫ�ֱ����еĿγ̱��
 pyCode:=trim(edit1.Text);
 courseID:=trim(edit2.Text);
 courseName:=trim(edit3.Text);
 adoquery1.Close;
 adoquery1.SQL.Clear;
 adoquery1.SQL.Add('select a.���,b.�γ�����,a.ѧ��,c.����,a.�ɼ� from �ɼ��� a,�γ���Ϣ b,ѧ����Ϣ c');
 adoquery1.SQL.Add('where (a.�γ̱�� like ''%'+courseID+'%'')and(b.ƴ���� like ''%'+pyCode+'%'')and(b.�γ����� like ''%'+courseName+'%'')');
 adoquery1.SQL.Add('and(a.�γ̱��=b.�γ̱��)and(a.ѧ��=c.ѧ��)and(a.�Ƿ���ȷ���ɼ�=''N'')');
 adoquery1.Open;
 if adoquery1.RecordCount>0 then //����в�ѯ������򱣴�γ̱��
  courseNum:=courseID;
end;

//----------���ɼ����ı�����ֻ�����������֣�С����--------
procedure TScore.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#13,#8]) then
 key:=#0;
end;
//---------���ô�����̣��ύ�ɼ�--------------
procedure TScore.BitBtn3Click(Sender: TObject);
begin
adocommand1.CommandText:='exec sf_�ɼ��ύ '''+courseNum+'''';
adocommand1.Execute;
showscore();
end;
//---------���ô�����̣�����ѡ��--------------
procedure TScore.BitBtn1Click(Sender: TObject);
begin
adocommand1.CommandText:='exec sf_��ֹѡ��';
adocommand1.Execute;
showmessage('����ѡ�γɹ�����ѡ������Ҫ����ɼ��Ŀγ�');
end;

procedure TScore.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;
end.
