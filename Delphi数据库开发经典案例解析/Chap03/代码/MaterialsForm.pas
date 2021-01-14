unit MaterialsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ToolWin, ExtCtrls, Grids, DBGrids,
  ADODB, DB, DBCtrls, DBTables, Mask,BomForm;

type
  Tmaterials = class(TForm)
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
    Panel1: TPanel;
    BitBtn11: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    DataSource1: TDataSource;
    ADOTable1: TADOTable;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBComboBox1: TDBComboBox;
    DBEdit4: TDBEdit;
    DBComboBox2: TDBComboBox;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit21: TDBEdit;
    DBEdit22: TDBEdit;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    DBEdit25: TDBEdit;
    DBEdit26: TDBEdit;
    DBComboBox3: TDBComboBox;

    procedure FormShow(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    
   
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    
   


  private
    { Private declarations }
  public
    OrderCode:string;
    { Public declarations }
  end;

var
  materials: Tmaterials;

implementation

uses MainForm;

{$R *.dfm}



//-----------������ʾʱ�����ñ��е��п���ʼ�������б��-----
procedure Tmaterials.FormShow(Sender: TObject);
begin

//�����еĿ��
dbgrid1.Columns[0].Width:=64;
dbgrid1.Columns[1].width:=80;
//���ü�����λ�����б���е�����
adoquery1.Close;
adoquery1.SQL.Clear;
adoquery1.SQL.Add('select distinct ������λ from �������ļ�');
adoquery1.Open;
while not adoquery1.Eof do
begin
dbcombobox1.Items.Add(adoquery1.fieldbyname('������λ').AsString);
adoquery1.Next;
end;
//���üƻ���������б���е�����
adoquery1.Close;
adoquery1.SQL.Clear;
adoquery1.SQL.Add('select �������,������ from ���ϼƻ����');
adoquery1.Open;
while not adoquery1.Eof do
begin
dbcombobox2.Items.Add(adoquery1.fieldbyname('�������').AsString);
dbcombobox3.Items.Add(adoquery1.fieldbyname('������').AsString);
adoquery1.Next;
end;

end;



//-----------------��ʾ�������ļ��е�������������--------------------
procedure Tmaterials.DataSource1DataChange(Sender: TObject; Field: TField);
var
num,temp:string;
begin
//showmessage(dbgrid1.Fields[0].AsString);
//����ѡȡ�����ݼ�¼����ѯ��������ϸ����
num:=dbgrid1.Fields[0].AsString;
adoquery1.Close;
adoquery1.SQL.Clear;
adoquery1.SQL.Add('select * from �������ļ� where ���ϱ��='''+num+'''');
adoquery1.Open;

//��ʾ�ƻ��������ƣ��������ļ��д洢������ƴ�����룩
temp:=adoquery1.fieldbyname('�ƻ����').AsString;
adoquery1.Close;
adoquery1.SQL.Clear;
adoquery1.SQL.Add('select ������� from ���ϼƻ���� where ������='''+temp+'''');
adoquery1.Open;
dbcombobox2.Text:=adoquery1.fieldbyname('�������').AsString;

end;
//--------------��һ����¼------------
procedure Tmaterials.BitBtn3Click(Sender: TObject);
begin
datasource1.DataSet.Next;

end;
//--------------��һ����¼------------
procedure Tmaterials.BitBtn2Click(Sender: TObject);
begin
datasource1.DataSet.Prior;
end;
//--------------������¼------------
procedure Tmaterials.BitBtn1Click(Sender: TObject);
begin
datasource1.DataSet.First;
end;
//--------------ĩ����¼------------
procedure Tmaterials.BitBtn4Click(Sender: TObject);
begin
datasource1.DataSet.Last;
end;

//---------�㴰���Xͼ��ʱ�رմ����������С��---------
procedure Tmaterials.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//������Ӵ���Ĺرհ�ťʱ�ͷŹرմ��壬����������������룬������С����������ǹر�
action:=cafree;
end;

//----------��ѯ���е����ݲ���ʾ--------------------
procedure Tmaterials.BitBtn11Click(Sender: TObject);
begin
//��ѯ����
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select * from �������ļ� where (���ϱ�� like ''%'+edit1.Text+'%'')and');
adoquery2.SQL.Add('(�������� like ''%'+edit2.Text+'%'')and(ƴ������ like ''%'+edit3.Text+'%'')');
adoquery2.Open;


//����ѯ�õ�������ͨ��clone����Ƶ�adotable��ȥ
adotable1.Clone(adoquery2,ltUnspecified);
end;

//------------����һ����¼-----------------
procedure Tmaterials.BitBtn5Click(Sender: TObject);

begin
//��dbgrid�в���һ���µ����ݣ�����ʾ�û����ұ��ı������޸�
datasource1.DataSet.Insert;
showmessage('�����ұߵ��ı��������������ݵ���ϸ����');
//�������ı���������Ĭ��ֵ����ֹ�û����������ֵ���ͻ��߶Բ���Ϊ�յ��������ֵ
dbedit1.Text:='0000';
dbedit2.Text:='�ڴ������������������Ϊ��';
dbedit9.Text:='0.00';
dbedit10.Text:='0.00';
dbedit11.Text:='0.00';
dbedit12.Text:='0.00';
dbedit19.Text:='0.00';
dbedit20.Text:='0.00';
dbedit21.Text:='0.00';
dbedit16.Text:='0';
dbedit17.Text:='0';
dbedit18.Text:='0';
dbedit23.Text:='10';
dbcombobox1.SelText:=dbcombobox1.Items.Strings[0];
dbcombobox3.SelText:=dbcombobox3.Items.Strings[0];
//�������ļ��д洢��������ƴ�������������ƣ���˲���ʱ
//��Ҫ����ƴ������������
dbcombobox2.Visible:=false;
dbcombobox3.Visible:=true;
dbedit26.Text:='20040101';
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
//�����޸��ı����е�����
dbedit1.ReadOnly:=false;
dbedit2.ReadOnly:=false;
dbedit3.ReadOnly:=false;
dbedit4.ReadOnly:=false;
dbedit5.ReadOnly:=false;
dbedit6.ReadOnly:=false;
dbedit7.ReadOnly:=false;
dbedit8.ReadOnly:=false;
dbedit9.ReadOnly:=false;
dbedit10.ReadOnly:=false;
dbedit11.ReadOnly:=false;
dbedit12.ReadOnly:=false;
dbedit13.ReadOnly:=false;
dbedit14.ReadOnly:=false;
dbedit15.ReadOnly:=false;
dbedit16.ReadOnly:=false;
dbedit17.ReadOnly:=false;
dbedit18.ReadOnly:=false;
dbedit19.ReadOnly:=false;
dbedit20.ReadOnly:=false;
dbedit21.ReadOnly:=false;
dbedit22.ReadOnly:=false;
dbedit23.ReadOnly:=false;
dbedit24.ReadOnly:=false;
dbedit25.ReadOnly:=false;
dbedit26.ReadOnly:=false;

end;

//----------�༭һ�����еļ�¼--------------
procedure Tmaterials.BitBtn6Click(Sender: TObject);
begin

datasource1.DataSet.Edit;
//�������ļ��д洢��������ƴ�������������ƣ���˲���ʱ
//��Ҫ����ƴ������������
dbcombobox2.Visible:=false;
dbcombobox3.Visible:=true;

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
//�����޸��ı����е�����
dbedit1.ReadOnly:=false;
dbedit2.ReadOnly:=false;
dbedit3.ReadOnly:=false;
dbedit4.ReadOnly:=false;
dbedit5.ReadOnly:=false;
dbedit6.ReadOnly:=false;
dbedit7.ReadOnly:=false;
dbedit8.ReadOnly:=false;
dbedit9.ReadOnly:=false;
dbedit10.ReadOnly:=false;
dbedit11.ReadOnly:=false;
dbedit12.ReadOnly:=false;
dbedit13.ReadOnly:=false;
dbedit14.ReadOnly:=false;
dbedit15.ReadOnly:=false;
dbedit16.ReadOnly:=false;
dbedit17.ReadOnly:=false;
dbedit18.ReadOnly:=false;
dbedit19.ReadOnly:=false;
dbedit20.ReadOnly:=false;
dbedit21.ReadOnly:=false;
dbedit22.ReadOnly:=false;
dbedit23.ReadOnly:=false;
dbedit24.ReadOnly:=false;
dbedit25.ReadOnly:=false;
dbedit26.ReadOnly:=false;
end;

//-----------ɾ��һ����¼------------------------
procedure Tmaterials.BitBtn7Click(Sender: TObject);
begin
if application.MessageBox('ȷʵɾ����¼���������ȡ��!','ɾ����¼',MB_OKCANCEL)=IDOK then
datasource1.DataSet.Delete
else
abort;
end;

//--------ȡ������--------------
procedure Tmaterials.BitBtn9Click(Sender: TObject);
begin
datasource1.DataSet.Cancel;
//�����״̬�£���ʾ������������
dbcombobox3.Visible:=false;
dbcombobox2.Visible:=true;

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
//�ر������޸��ı����е�����
dbedit1.ReadOnly:=true;
dbedit2.ReadOnly:=true;
dbedit3.ReadOnly:=true;
dbedit4.ReadOnly:=true;
dbedit5.ReadOnly:=true;
dbedit6.ReadOnly:=true;
dbedit7.ReadOnly:=true;
dbedit8.ReadOnly:=true;
dbedit9.ReadOnly:=true;
dbedit10.ReadOnly:=true;
dbedit11.ReadOnly:=true;
dbedit12.ReadOnly:=true;
dbedit13.ReadOnly:=true;
dbedit14.ReadOnly:=true;
dbedit15.ReadOnly:=true;
dbedit16.ReadOnly:=true;
dbedit17.ReadOnly:=true;
dbedit18.ReadOnly:=true;
dbedit19.ReadOnly:=true;
dbedit20.ReadOnly:=true;
dbedit21.ReadOnly:=true;
dbedit22.ReadOnly:=true;
dbedit23.ReadOnly:=true;
dbedit24.ReadOnly:=true;
dbedit25.ReadOnly:=true;
dbedit26.ReadOnly:=true;
end;



//----------------�ύ�����ݱ��������޸�----------------
procedure Tmaterials.BitBtn8Click(Sender: TObject);
begin
if application.MessageBox('ȷ��ִ�ж����������Ĳ�����','ȷ��',MB_OKCANCEL)=IDOK then
datasource1.DataSet.Post
else
abort;
//�����״̬�£���ʾ������������
dbcombobox3.Visible:=false;
dbcombobox2.Visible:=true;
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
//�ر������޸��ı����е�����
dbedit1.ReadOnly:=true;
dbedit2.ReadOnly:=true;
dbedit3.ReadOnly:=true;
dbedit4.ReadOnly:=true;
dbedit5.ReadOnly:=true;
dbedit6.ReadOnly:=true;
dbedit7.ReadOnly:=true;
dbedit8.ReadOnly:=true;
dbedit9.ReadOnly:=true;
dbedit10.ReadOnly:=true;
dbedit11.ReadOnly:=true;
dbedit12.ReadOnly:=true;
dbedit13.ReadOnly:=true;
dbedit14.ReadOnly:=true;
dbedit15.ReadOnly:=true;
dbedit16.ReadOnly:=true;
dbedit17.ReadOnly:=true;
dbedit18.ReadOnly:=true;
dbedit19.ReadOnly:=true;
dbedit20.ReadOnly:=true;
dbedit21.ReadOnly:=true;
dbedit22.ReadOnly:=true;
dbedit23.ReadOnly:=true;
dbedit24.ReadOnly:=true;
dbedit25.ReadOnly:=true;
dbedit26.ReadOnly:=true;
end;
//------------------�رմ���----------------------
procedure Tmaterials.BitBtn10Click(Sender: TObject);
begin
//SendMessage(handle, WM_SYSCOMMAND, SC_close, 0);
close;
end;
//---------���κ�һ���ı����ϰ�enter������ִ�в�ѯ---------
procedure Tmaterials.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
 bitbtn11.Click;
end;

procedure Tmaterials.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
 bitbtn11.Click;
end;

procedure Tmaterials.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
 bitbtn11.Click;
end;

end.
