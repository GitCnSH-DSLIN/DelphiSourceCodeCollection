unit FormStore;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, ExtCtrls, FormOutput;

type
  Tstore = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    Edit2: TEdit;
    Button1: TButton;
    DBGrid1: TDBGrid;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  store: Tstore;

implementation

uses FormManage;

{$R *.dfm}

//----------------����ر�ʱ���صĴ����ѡ��--------------------------
procedure Tstore.FormClose(Sender: TObject; var Action: TCloseAction);
begin
manage.show;
//�����ʱ�Ǵ����۵������е��ÿ���ѯ���壬�򲻷��ع�����������������۵�����
if (output.Enabled=false) then
 begin
 manage.Hide;
 output.enabled:=true;
 end
end;

//------------������ʾʱ�������Ų�ͬ�ı����������ϲ�ѯ�������----------------
procedure Tstore.FormShow(Sender: TObject);
begin
adoquery1.Close;
adoquery1.SQL.Clear;
adoquery1.SQL.Text:='select ����.����,��Ʒ�嵥.Ʒ��,��Ʒ�嵥.��λ,����.�ֿ�,����.�������,����.��浥��,����.����� from ����,��Ʒ�嵥 where ����.����=��Ʒ�嵥.����';
adoquery1.Open;

end;

//------------------------ִ�в�ѯ---------------------------------
procedure Tstore.Button1Click(Sender: TObject);
begin
 adoquery1.Close;
 adoquery1.sql.Clear;
 adoquery1.SQL.Add('select ����.����,��Ʒ�嵥.Ʒ��,��Ʒ�嵥.��λ,����.�ֿ�,����.�������,����.��浥��,����.����� from ����,��Ʒ�嵥');
 adoquery1.SQL.Add('where ����.����=��Ʒ�嵥.���� and ');
 adoquery1.SQL.Add('((��Ʒ�嵥.����='''+edit1.Text+''')or');
 adoquery1.SQL.Add('(��Ʒ�嵥.ƴ������='''+edit2.Text+''')or');
 adoquery1.SQL.Add('(����.�ֿ�='''+combobox1.text+'''))');
 adoquery1.Open;
//����SQL���������Ǵ����ݿ��в�ѯ�������������Ʒƴ�������ţ��ֿ�����֮һ����ֵͬ�ļ�¼�����
//������������ǻ�Ĺ�ϵ�������κν���������ٷ������������е�һ������������һ����Ĺ�ϵ
//��������û��ʹ��ǰ����������ģ����ѯ�����߿��Բ���ǰ����½������޸ĳ��򣬿�������ʲô���Ľ��
end;

//--------------�����۵������е��ÿ���ѯ����-----------------------------
//-----------ʵ��ͨ������grid�ؼ������۵��д�����Ӧ������---------------
procedure Tstore.DBGrid1DblClick(Sender: TObject);
var
name,num:string;

begin
if (output.Enabled=false) then
 begin
  num:=dbgrid1.Fields[0].AsString;
 name:=dbgrid1.Fields[1].AsString;
//�򽫿ͻ���ź����ƴ������۵�����
 if output.currentRow=0 then
  output.currentRow:=1;
 output.StringGrid1.Cells[1,output.currentRow]:=num;
 output.StringGrid1.Cells[2,output.currentRow]:=name;
 output.Enabled:=true;
 //�ɹ��󷵻����۵�
 store.Close;
 manage.Hide;
 end;



end;

end.
