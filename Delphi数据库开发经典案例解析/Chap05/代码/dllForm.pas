unit dllForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, ADODB, ExtCtrls, StdCtrls, Buttons;

type
  TdllSec = class(TForm)
    ADOTable1: TADOTable;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Label5: TLabel;
    Edit3: TEdit;
    ADOQuery1: TADOQuery;
    procedure DBGrid1DblClick(Sender: TObject);

    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//�˺�������ȡ�õ�ǰӦ�ó���ľ������ʾ����
function showdllform(Ahandle:Thandle;Acaption:string;tablename:string):string;stdcall;
//�ô˱��������dll�ĳ��򷵻�ֵ
var
 resultstr:string;
implementation

{$R *.dfm}
function showdllform(Ahandle:Thandle;Acaption:string;tablename:string):string;stdcall;
var
newform:Tdllsec;
begin
//ȡ�þ��
application.Handle:=Ahandle;
//��������
newform:=Tdllsec.Create(application);
newform.Caption:=Acaption+'(˫��ѡ��)';
//�������ݿ�����
newform.ADOTable1.TableName:=tablename;
newform.ADOTable1.Active:=true;
//��ʾ����
try
 newform.ShowModal;
//����˫����ѡ��Ľ��
 result:=resultstr;
 //�ͷŸô���
finally newform.Free;
end;
end;

//-------˫��ѡ��������---------
procedure TdllSec.DBGrid1DblClick(Sender: TObject);
begin
resultstr:=dbgrid1.Fields[0].Text;
close;
end;


procedure TdllSec.BitBtn1Click(Sender: TObject);
begin
   adoquery1.Close;
   adoquery1.SQL.Clear;
   adoquery1.SQL.Add('select * from '+adotable1.TableName);
   adoquery1.SQL.Add(' where('+label3.Caption+' like ''%'+edit1.Text+'%'')');
   adoquery1.SQL.Add('and('+label4.Caption+' like ''%'+edit2.Text+'%'')');
   adoquery1.Open;
   //����ѯ�õ�������ͨ��clone����Ƶ�adotable��ȥ
   adotable1.Clone(adoquery1,ltUnspecified);
end;

end.
