unit MainProduceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ComCtrls, ToolWin, StdCtrls, Buttons, ExtCtrls,
  ADODB, DB, DBCtrls, Mask;

type
  TMainProduce = class(TForm)
    Panel1: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    BitBtn12: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    ToolBar1: TToolBar;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    ToolButton1: TToolButton;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    ToolButton2: TToolButton;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    ToolButton3: TToolButton;
    BitBtn10: TBitBtn;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    BitBtn13: TBitBtn;
    BitBtn11: TBitBtn;
    ADOQuery2: TADOQuery;
    DataSource2: TDataSource;
    ADOCommand1: TADOCommand;
    Panel3: TPanel;
    BitBtn14: TBitBtn;
    DBGrid2: TDBGrid;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    Label15: TLabel;
    DBEdit11: TDBEdit;
    ADOQuery3: TADOQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure DataSource2DataChange(Sender: TObject; Field: TField);
    procedure BitBtn14Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    insflag:integer;
  end;

var
  MainProduce: TMainProduce;

implementation

uses MainForm,ChooseForm;

{$R *.dfm}

//--------------��һ����¼------------
procedure TMainProduce.BitBtn3Click(Sender: TObject);
begin
datasource2.DataSet.Next;

end;
//--------------��һ����¼------------
procedure TMainProduce.BitBtn2Click(Sender: TObject);
begin
datasource2.DataSet.Prior;
end;
//--------------������¼------------
procedure TMainProduce.BitBtn1Click(Sender: TObject);
begin
datasource2.DataSet.First;
end;
//--------------ĩ����¼------------
procedure TMainProduce.BitBtn4Click(Sender: TObject);
begin
datasource2.DataSet.Last;
end;

procedure TMainProduce.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
action:=cafree;
end;

procedure TMainProduce.BitBtn10Click(Sender: TObject);
begin
close;
end;

//��ѯ����
procedure TMainProduce.BitBtn12Click(Sender: TObject);
begin
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select * from �������ƻ� where (���ϱ�� like ''%'+edit1.Text+'%'')and');
adoquery2.SQL.Add('(��� like ''%'+edit2.Text+'%'')and(�ƻ��� like ''%'+edit3.Text+'%'')');
adoquery2.Open;

end;

procedure TMainProduce.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
 bitbtn12.Click;
end;

procedure TMainProduce.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
 bitbtn12.Click;
end;

procedure TMainProduce.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
 bitbtn12.Click;
end;




procedure TMainProduce.FormActivate(Sender: TObject);

begin
//�����������ť�����£��򽫴��������ļ���ѡȡ������ı��
//���Ƶ���Ϣ�͵������󴰿��У�����ʼ��һЩ����
 if insflag=1 then
  begin
  dbedit1.Text:=main.str;
  dbedit2.Text:=main.str2;
  end;
  if insflag=2 then
  begin
  dbedit3.Text:=main.str;
  dbedit4.Text:=main.str2;
  dbedit5.Text:=main.str3;
  dbedit6.Text:=main.str4;
  end;

end;

procedure TMainProduce.BitBtn5Click(Sender: TObject);
begin
datasource2.DataSet.Insert;
//�����룬ɾ�����޸ĺ��ƶ���ť�رգ���ֹ�������
bitbtn6.Enabled:=false;
bitbtn7.Enabled:=false;
bitbtn1.Enabled:=false;
bitbtn2.Enabled:=false;
bitbtn3.Enabled:=false;
bitbtn4.Enabled:=false;
bitbtn5.Enabled:=false;
//�򿪱����ȡ����ť��ʹ�ܣ����������ȡ��
bitbtn8.Enabled:=true;
bitbtn9.Enabled:=true;
//�����������ťʹ�ܴ�
bitbtn11.Enabled:=true;
bitbtn13.Enabled:=true;
//�����ñ��水ť�����ύ
dbgrid2.Enabled:=false;
//��������������ͱ�ע�����޸�
dbedit7.ReadOnly:=false;
dbedit7.Text:='0';
dbedit9.ReadOnly:=false;
dbedit9.Text:='0';
dbedit8.ReadOnly:=false;
dbedit10.ReadOnly:=false;
dbedit11.ReadOnly:=false;
dbmemo1.ReadOnly:=false;
end;

procedure TMainProduce.BitBtn13Click(Sender: TObject);
var
newform:Tchoose;
begin
//��ʶ��������������������ļ�����
main.bomflag:=4;
newform:=Tchoose.Create(application);
//�������ڻһ�
self.Enabled:=false;
//��ʶΪ��һ��������ť����
insflag:=1;
end;


procedure TMainProduce.BitBtn11Click(Sender: TObject);
begin
 main.bomflag:=5;
 main.N5.Click;
 //�������ڻһ�
self.Enabled:=false;
//��ʶΪ��һ��������ť����
insflag:=2;
end;

procedure TMainProduce.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
//�����еĿ��
dbgrid1.Columns[0].Width:=64;
dbgrid1.Columns[1].Width:=64;
dbgrid1.Columns[2].Width:=64;
dbgrid1.Columns[3].Width:=64;
dbgrid1.Columns[4].Width:=64;

end;

procedure TMainProduce.BitBtn6Click(Sender: TObject);
begin
datasource2.DataSet.Edit;
//�����룬ɾ�����޸ĺ��ƶ���ť�رգ���ֹ�������
bitbtn6.Enabled:=false;
bitbtn7.Enabled:=false;
bitbtn1.Enabled:=false;
bitbtn2.Enabled:=false;
bitbtn3.Enabled:=false;
bitbtn4.Enabled:=false;
bitbtn5.Enabled:=false;
//�򿪱����ȡ����ť��ʹ�ܣ����������ȡ��
bitbtn8.Enabled:=true;
bitbtn9.Enabled:=true;
//�����������ťʹ�ܴ�
bitbtn11.Enabled:=true;
bitbtn13.Enabled:=true;
//�����ñ��水ť�����ύ
dbgrid2.Enabled:=false;
//��������������ͱ�ע�����޸�
dbedit7.ReadOnly:=false;
dbedit9.ReadOnly:=false;
dbedit8.ReadOnly:=false;
dbedit10.ReadOnly:=false;
dbedit11.ReadOnly:=false;
dbmemo1.ReadOnly:=false;
end;

procedure TMainProduce.BitBtn8Click(Sender: TObject);

begin

datasource2.DataSet.Post;

//�����룬ɾ�����޸ĺ��ƶ���ť��
bitbtn6.Enabled:=true;
bitbtn7.Enabled:=true;
bitbtn1.Enabled:=true;
bitbtn2.Enabled:=true;
bitbtn3.Enabled:=true;
bitbtn4.Enabled:=true;
bitbtn5.Enabled:=true;
//�رձ����ȡ����ť��ʹ��
bitbtn8.Enabled:=false;
bitbtn9.Enabled:=false;
//�����������ťʹ�ܹر�
bitbtn11.Enabled:=false;
bitbtn13.Enabled:=false;
//�ָ�dbgrid��ѡȡ����
dbgrid2.Enabled:=true;
//�ָ�dbedit��ֻ������
dbedit7.ReadOnly:=true;
dbedit9.ReadOnly:=true;
dbedit8.ReadOnly:=true;
dbedit10.ReadOnly:=true;
dbedit11.ReadOnly:=true;
dbmemo1.ReadOnly:=true;
dbmemo1.ReadOnly:=true;
//ˢ������
adoquery2.Active:=false;
adoquery2.Active:=true;
end;

procedure TMainProduce.BitBtn9Click(Sender: TObject);
begin


datasource2.DataSet.Cancel;

//�����룬ɾ�����޸ĺ��ƶ���ť��
bitbtn6.Enabled:=true;
bitbtn7.Enabled:=true;
bitbtn1.Enabled:=true;
bitbtn2.Enabled:=true;
bitbtn3.Enabled:=true;
bitbtn4.Enabled:=true;
bitbtn5.Enabled:=true;
//�رձ����ȡ����ť��ʹ��
bitbtn8.Enabled:=false;
bitbtn9.Enabled:=false;
//�����������ťʹ�ܹر�
bitbtn11.Enabled:=false;
bitbtn13.Enabled:=false;
//�ָ�dbgrid��ѡȡ����
dbgrid2.Enabled:=true;
//�ָ�dbedit��ֻ������
dbedit7.ReadOnly:=true;
dbedit9.ReadOnly:=true;
dbedit8.ReadOnly:=true;
dbedit10.ReadOnly:=true;
dbedit11.ReadOnly:=true;
dbmemo1.ReadOnly:=true;
dbmemo1.ReadOnly:=true;
//ˢ������
adoquery2.Active:=false;
adoquery2.Active:=true;
end;

procedure TMainProduce.BitBtn7Click(Sender: TObject);
begin
if application.MessageBox('ȷʵɾ�������ݣ�','ɾ��',MB_OKCANCEL)=ID_OK then
 datasource2.dataset.delete;
end;


procedure TMainProduce.DataSource2DataChange(Sender: TObject;
  Field: TField);
begin
//Ϊ��Ʒ�����ı����ѯ��Ʒ����
adoquery3.Close;
adoquery3.SQL.Clear;
adoquery3.SQL.Add('select �������� from �������ļ� where ���ϱ��='''+dbedit1.Text+'''');
adoquery3.Open;
dbedit2.Text:=adoquery3.FieldByName('��������').AsString;
end;

procedure TMainProduce.BitBtn14Click(Sender: TObject);
var
order,num:string;
begin
//ѡ�е����ݵļƻ��ں����ϱ��
 order:=dbgrid1.Fields[3].AsString;
 num:=dbgrid1.Fields[0].AsString;
 //��������ƻ����е����������������ƻ���
 adocommand1.CommandText:='insert into �������ƻ�([���ϱ��], [���], [�ƻ���], [��ʼ����], [��������], [��������], [MPS����], [״̬], [��ע]) select ���ϱ��,���,�ƻ���, ��ʼ����,��������,��������,��������,״̬,��ע from ������ƻ� where (���ϱ��='''+num+''')and(�ƻ���='''+order+''')';
 adocommand1.Execute;
 //���浽������ƻ���ʷ
 adocommand1.CommandText:='insert into ������ƻ���ʷ select * from ������ƻ� where (���ϱ��='''+num+''')and(�ƻ���='''+order+''')';
 adocommand1.Execute;
 //ɾ����������ƻ����е��ѱ����뵽�������ƻ����е�����
  adocommand1.CommandText:='delete from ������ƻ� where (���ϱ��='''+num+''')and(�ƻ���='''+order+''')';
  adocommand1.Execute;

 //ˢ������
adoquery2.Active:=false;
adoquery2.Active:=true;
adoquery1.Active:=false;
adoquery1.Active:=true;
 end;

end.
