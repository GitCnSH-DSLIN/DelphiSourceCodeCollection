unit FormInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ExtCtrls, DBCtrls, Grids, DBGrids, Menus, StdCtrls, FormLogin, FormInput,formoutput;

type
  TInfo = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
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
  Info: TInfo;
  flag:integer;

implementation

uses FormManage;

{$R *.dfm}
//---------------�����Ʒ��Ϣ����˵�����ʾ��Ʒ�嵥----------------
procedure TInfo.N2Click(Sender: TObject);
begin
//��ѯ��Ʒ��Ϣ
adoquery1.Close;
adoquery1.SQL.Clear;
adoquery1.SQL.Text:='select * from  ��Ʒ�嵥';
adoquery1.Open;
//�����еĿ�ȣ������û��鿴
dbgrid1.Columns[2].Width:=80;
dbgrid1.Columns[3].Width:=120;
dbgrid1.Columns[4].Width:=80;
dbgrid1.Columns[6].Width:=80;
//��ʾ�û�������Ʒƴ���Թ���ѯ
label1.Caption:='��Ʒƴ��';
end;

//---------------�����������Ϣ����˵�����ʾ�������嵥----------------
procedure TInfo.N3Click(Sender: TObject);
begin
//��ѯ��������Ϣ
adoquery1.Close;
adoquery1.SQL.Clear;
adoquery1.SQL.Text:='select * from  �������嵥';
adoquery1.Open;
//�����еĿ�ȣ������û��鿴
dbgrid1.Columns[1].Width:=80;
dbgrid1.Columns[2].Width:=80;
dbgrid1.Columns[3].Width:=80;
dbgrid1.Columns[4].Width:=120;
//��ʾ�û����빩����ƴ���Թ���ѯ
label1.Caption:='������ƴ��';
end;

//---------------����ͻ���Ϣ����˵�����ʾ�ͻ��嵥----------------
procedure TInfo.N4Click(Sender: TObject);
begin
//��ѯ�ͻ���Ϣ
adoquery1.Close;
adoquery1.SQL.Clear;
adoquery1.SQL.Text:='select * from  �ͻ��嵥';
adoquery1.Open;
//�����еĿ�ȣ������û��鿴
dbgrid1.Columns[1].Width:=80;
dbgrid1.Columns[2].Width:=80;
dbgrid1.Columns[3].Width:=80;
dbgrid1.Columns[4].Width:=80;
dbgrid1.Columns[5].Width:=120;
//��ʾ�û�����ͻ�ƴ���Թ���ѯ
label1.Caption:='�ͻ�ƴ��';
end;

//----------------����ر�ʱ���صĴ����ѡ��--------------------------
procedure TInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
manage.show;
//�����ʱ�Ǵӽ����������е�����Ϣ�����壬�򲻷��ع�������������ؽ���������
if (input.Enabled=false) then
 begin
 manage.Hide;
 input.enabled:=true;
end
end;

//------------������ʾʱ��Ĭ����ʾ��Ʒ�嵥-------------------------
procedure TInfo.FormShow(Sender: TObject);
begin
n2.Click;
end;

//---------------------ʵ�ֲ�ѯ����--------------------------
procedure TInfo.Button1Click(Sender: TObject);
begin
//���ݱ�ǩ�����ֽ����ж�Ӧ�ö��Ǹ����ݱ���в�ѯ
//��ѯ��Ʒ�嵥�е���Ϣ
 if label1.Caption='��Ʒƴ��' then
  begin
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select * from ��Ʒ�嵥 where ƴ������ like ''%'+edit1.text+'%''');
  adoquery1.Open;
  dbgrid1.Columns[2].Width:=80;
  dbgrid1.Columns[3].Width:=120;
  dbgrid1.Columns[4].Width:=80;
  dbgrid1.Columns[6].Width:=80
  end;

  //��ѯ�������嵥�е���Ϣ
  if label1.Caption='������ƴ��' then
  begin
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select * from �������嵥 where ƴ������ like ''%'+edit1.text+'%''');
  adoquery1.Open;
  dbgrid1.Columns[1].Width:=80;
  dbgrid1.Columns[2].Width:=80;
  dbgrid1.Columns[3].Width:=80;
  dbgrid1.Columns[4].Width:=120
  end;

  //��ѯ�ͻ��嵥�е���Ϣ
  if label1.Caption='�ͻ�ƴ��' then
  begin
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select * from �ͻ��嵥 where ƴ������ like ''%'+edit1.text+'%''');
  adoquery1.Open;
  dbgrid1.Columns[1].Width:=80;
  dbgrid1.Columns[2].Width:=80;
  dbgrid1.Columns[3].Width:=80;
  dbgrid1.Columns[4].Width:=80;
  dbgrid1.Columns[5].Width:=120
  end;
end;

//--------------�ڽ����������۵������е�����Ϣ������-----------------------------
//-----------ʵ��ͨ������grid�ؼ�������������۵��д�����Ӧ������---------------
procedure TInfo.DBGrid1DblClick(Sender: TObject);
var
num,name:string;
begin
//----------------��������д�����Ʒ�򹩻�����Ϣ------------------------
//�ж��Ƿ�ʱ�ӽ����������е��õ���Ϣ�����壬�Լ����õ��ĸ����ݱ�
 if (input.Enabled=false)and(label1.Caption='������ƴ��') then
 begin
//�������̵ı�ź����ƴ��ؽ���������
 num:=dbgrid1.Fields[0].AsString;
 name:=dbgrid1.Fields[3].AsString;
 input.ComboBox2.Text:=num;
 input.Edit3.Text:=name;
//�ɹ��󷵻ؽ�����
 input.Enabled:=true;
 info.Close;
 manage.Hide;
 end;

 if (input.Enabled=false)and(label1.Caption='��Ʒƴ��') then
 begin
//�����ź���Ʒ���ƴ��ؽ���������
  num:=dbgrid1.Fields[0].AsString;
 name:=dbgrid1.Fields[3].AsString;
 if input.currentRow=0 then
  input.currentRow:=1;
 input.StringGrid1.Cells[1,input.currentRow]:=num;
 input.StringGrid1.Cells[2,input.currentRow]:=name;
//�ɹ��󷵻ؽ�����
 input.Enabled:=true;
 info.Close;
 manage.Hide;

 end;
//-------------------�����۵��д��Ϳͻ���Ϣ-------------------
 if (output.Enabled=false)and(label1.Caption='�ͻ�ƴ��') then
 begin
//�򽫿ͻ���ź����ƴ������۵�����
 num:=dbgrid1.Fields[0].AsString;
 name:=dbgrid1.Fields[3].AsString;
 output.ComboBox2.Text:=num;
 output.Edit3.Text:=name;
//�ɹ��󷵻����۵�
 output.Enabled:=true;
 info.Close;
 manage.Hide;
 end;

end;

end.
