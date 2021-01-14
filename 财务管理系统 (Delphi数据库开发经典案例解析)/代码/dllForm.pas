unit dllForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, ADODB;

type
  TdllSec = class(TForm)
    ADOTable1: TADOTable;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
finally newform.Close;
end;
end;

//-------˫��ѡ��������---------
procedure TdllSec.DBGrid1DblClick(Sender: TObject);
begin
resultstr:=dbgrid1.Fields[0].Text;
close;
end;

//--------���ñ���----------
procedure TdllSec.FormShow(Sender: TObject);
var
i:integer;
begin
for i:=0 to dbgrid1.FieldCount-1 do
 dbgrid1.Columns[i].Width:=64;
end;

end.
