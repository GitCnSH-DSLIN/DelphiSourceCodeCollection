unit MainRequireForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ComCtrls, ToolWin, StdCtrls, Buttons, ExtCtrls,
  ADODB, DB, DBCtrls, Mask;

type
  TMainRequire = class(TForm)
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
    RadioGroup1: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
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
  private
    { Private declarations }
  public
    { Public declarations }
    insflag:integer;
  end;

var
  MainRequire: TMainRequire;

implementation

uses MainForm,ChooseForm;

{$R *.dfm}

//--------------��һ����¼------------
procedure Tmainrequire.BitBtn3Click(Sender: TObject);
begin
datasource1.DataSet.Next;

end;
//--------------��һ����¼------------
procedure Tmainrequire.BitBtn2Click(Sender: TObject);
begin
datasource1.DataSet.Prior;
end;
//--------------������¼------------
procedure Tmainrequire.BitBtn1Click(Sender: TObject);
begin
datasource1.DataSet.First;
end;
//--------------ĩ����¼------------
procedure Tmainrequire.BitBtn4Click(Sender: TObject);
begin
datasource1.DataSet.Last;
end;
//---------�رմ���---------------
procedure TMainRequire.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
action:=cafree;
end;

procedure TMainRequire.BitBtn10Click(Sender: TObject);
begin
close;
end;

//-----------��ѯ---------------------
procedure TMainRequire.BitBtn12Click(Sender: TObject);
begin
adoquery1.Close;
adoquery1.SQL.Clear;
adoquery1.SQL.Add('select * from ������ƻ� where (���ϱ�� like ''%'+edit1.Text+'%'')and');
adoquery1.SQL.Add('(��� like ''%'+edit2.Text+'%'')and(�ƻ��� like ''%'+edit3.Text+'%'')');
adoquery1.Open;

end;
//------��Ӧenter��-----------
procedure TMainRequire.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
 bitbtn12.Click;
end;

procedure TMainRequire.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
 bitbtn12.Click;
end;

procedure TMainRequire.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
 bitbtn12.Click;
end;

//---------------���빫������------------------
procedure TMainRequire.FormActivate(Sender: TObject);
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

//--------����������---------------
procedure TMainRequire.BitBtn5Click(Sender: TObject);
begin
datasource1.DataSet.Insert;
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
dbgrid1.Enabled:=false;
//��������������ͱ�ע�����޸�
dbedit7.ReadOnly:=false;
dbedit7.Text:='0';
dbmemo1.ReadOnly:=false;
end;

//-----------���������ļ������м�������--------------
procedure TMainRequire.BitBtn13Click(Sender: TObject);
var
newform:Tchoose;
begin
//��ʶ��������������������ļ�����
main.bomflag:=2;
newform:=Tchoose.Create(application);
//�������ڻһ�
self.Enabled:=false;
//��ʶΪ��һ��������ť����
insflag:=1;
end;

//-----------�ӹ������������м�������--------------
procedure TMainRequire.BitBtn11Click(Sender: TObject);
begin
 main.bomflag:=3;
 main.N5.Click;
 //�������ڻһ�
self.Enabled:=false;
//��ʶΪ�ڶ���������ť����
insflag:=2;
end;

//----�����ı����е���������-------------
procedure TMainRequire.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
//Ϊ��Ʒ�����ı����ѯ��Ʒ����
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select �������� from �������ļ� where ���ϱ��='''+dbedit1.Text+'''');
adoquery2.Open;
//���ݱ��С�״̬����ȡֵȷ����ѡ���ȡֵ
if copy(adoquery1.FieldByName('״̬').AsString,1,4)='����' then
radiobutton1.Checked:=true
else
radiobutton2.Checked:=true;
//�����еĿ��
dbgrid1.Columns[0].Width:=64;
dbgrid1.Columns[1].Width:=64;
dbgrid1.Columns[2].Width:=64;
dbgrid1.Columns[3].Width:=64;
dbgrid1.Columns[4].Width:=64;

end;

//-----------�༭����------------------
procedure TMainRequire.BitBtn6Click(Sender: TObject);
begin
datasource1.DataSet.Edit;
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
dbgrid1.Enabled:=false;
//��������������ͱ�ע�����޸�
dbedit7.ReadOnly:=false;
dbmemo1.ReadOnly:=false;
end;

//------------------�������--------------------
procedure TMainRequire.BitBtn8Click(Sender: TObject);
var
state,dorder,dnum:string;
begin
if radiobutton1.Checked then
 state:='����'
 else
 state:='��Ч';
dorder:=dbedit4.Text;
dnum:=dbedit1.Text;
datasource1.DataSet.Post;
adocommand1.CommandText:='update ������ƻ� set ״̬='''+state+''''+'where (���ϱ��='''+dnum+''')and(�ƻ���='''+dorder+''')';
adocommand1.Execute;
dbgrid1.Enabled:=true;

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
dbgrid1.Enabled:=true;
//�ָ�dbedit��ֻ������
dbedit7.ReadOnly:=true;
dbmemo1.ReadOnly:=true;
//ˢ������
adoquery1.Active:=false;
adoquery1.Active:=true;
end;

//------------------ȡ������--------------------
procedure TMainRequire.BitBtn9Click(Sender: TObject);
begin
datasource1.DataSet.Cancel;
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
dbgrid1.Enabled:=true;
//�ָ�dbedit��ֻ������
dbedit7.ReadOnly:=true;
dbmemo1.ReadOnly:=true;
end;

//---------------ɾ������-------------
procedure TMainRequire.BitBtn7Click(Sender: TObject);
begin
if application.MessageBox('ȷʵɾ�������ݣ�','ɾ��',MB_OKCANCEL)=ID_OK then
 datasource1.dataset.delete;
end;


end.
