unit SecSettingForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Grids, DBGrids, ExtCtrls, StdCtrls,
  Buttons, DB, ADODB, DBCtrls, Mask;

type
  TSecSetting = class(TForm)
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    DBRadioGroup2: TDBRadioGroup;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetToolBar(isEnable:bool);
  end;

var
  SecSetting: TSecSetting;

implementation

{$R *.dfm}
//---------------���ùرմ����ģʽ-----------------
procedure TSecSetting.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;


procedure TSecSetting.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  //��ʾ��������
  label2.Caption:=inttostr(adoquery1.RecordCount);
  //�������ݱ���
  dbgrid1.Columns[0].Width:=60;
  dbgrid1.Columns[1].Width:=90;
end;

//-----------ר��дһ��������ʵ�ֹ�������ť�����ã��ô��������----------------
procedure TSecSetting.SetToolBar(isEnable: bool);
begin
 if isEnable=true then
  begin
   //���׼�¼�ȼ�¼�ƶ���ť����Ϊ������
   toolbutton1.Enabled:=false;
   toolbutton2.Enabled:=false;
   toolbutton3.Enabled:=false;
   toolbutton4.Enabled:=false;
   //�������޸ĵȰ�ť����Ϊ������
   toolbutton6.Enabled:=false;
   toolbutton7.Enabled:=false;
   toolbutton8.Enabled:=false;
   //�������ȡ����ť����Ϊ����
   toolbutton10.Enabled:=true;
   toolbutton11.Enabled:=true;
   //�������ڵ�������ʾ�ؼ���Ϊ�ɶ�
   dbedit1.ReadOnly:=false;
   dbedit2.ReadOnly:=false;
   dbedit3.ReadOnly:=false;
   dbradiogroup1.ReadOnly:=false;
   dbradiogroup2.ReadOnly:=false;
 end;

 if isEnable=false then
  begin
   //���׼�¼�ȼ�¼�ƶ���ť����Ϊ����
   toolbutton1.Enabled:=true;
   toolbutton2.Enabled:=true;
   toolbutton3.Enabled:=true;
   toolbutton4.Enabled:=true;
   //�������޸ĵȰ�ť����Ϊ����
   toolbutton6.Enabled:=true;
   toolbutton7.Enabled:=true;
   toolbutton8.Enabled:=true;
   //�������ȡ����ť����Ϊ������
   toolbutton10.Enabled:=false;
   toolbutton11.Enabled:=false;
   //�������ڵ�������ʾ�ؼ���Ϊֻ��
   dbedit1.ReadOnly:=true;
   dbedit2.ReadOnly:=true;
   dbedit3.ReadOnly:=true;
   dbradiogroup1.ReadOnly:=true;
   dbradiogroup2.ReadOnly:=true;
  end;


end;

//---------------������¼----------------
procedure TSecSetting.ToolButton6Click(Sender: TObject);
begin
SetToolBar(true);
datasource1.DataSet.Insert;
end;

//---------------�޸ļ�¼----------------
procedure TSecSetting.ToolButton7Click(Sender: TObject);
begin
SetToolBar(true);
datasource1.DataSet.Edit;
end;

//---------------ɾ����¼----------------
procedure TSecSetting.ToolButton8Click(Sender: TObject);
begin
 if application.MessageBox('ɾ��������¼��','�������ϵͳ',MB_OKCANCEL)=IDOK then
  datasource1.DataSet.Delete;
end;

//---------------�׼�¼----------------
procedure TSecSetting.ToolButton1Click(Sender: TObject);
begin
 datasource1.DataSet.First;
end;

//---------------�ϼ�¼----------------
procedure TSecSetting.ToolButton2Click(Sender: TObject);
begin
 datasource1.DataSet.Prior;
end;

//---------------�¼�¼----------------
procedure TSecSetting.ToolButton3Click(Sender: TObject);
begin
 datasource1.DataSet.Next;
end;

//---------------β��¼----------------
procedure TSecSetting.ToolButton4Click(Sender: TObject);
begin
 datasource1.DataSet.Last;
end;

//---------------�رմ���----------------
procedure TSecSetting.ToolButton13Click(Sender: TObject);
begin
close;
end;

//---------------�����¼----------------
procedure TSecSetting.ToolButton10Click(Sender: TObject);
begin
  //����Ŀ�����Ƿ�������
  if dbedit2.Text='' then
   begin
   showmessage('��Ŀ���벻����Ϊ��ֵ');
   exit;
   end;
  datasource1.DataSet.Post;
  SetToolBar(false);
end;

//---------------ȡ������----------------
procedure TSecSetting.ToolButton11Click(Sender: TObject);
begin
  datasource1.DataSet.Cancel;
  SetToolBar(false);
end;

//----------��ѯ���ݲ���ʾ-------------
procedure TSecSetting.BitBtn1Click(Sender: TObject);
begin
adoquery1.Close;
adoquery1.SQL.Clear;
adoquery1.SQL.Add('select * from ��Ŀ�� where (��Ŀ���� like ''%'+edit1.Text+'%'')and');
adoquery1.SQL.Add('(��Ŀ���� like ''%'+edit2.Text+'%'')and(��Ŀ��� like ''%'+edit3.Text+'%'')');
adoquery1.Open;
end;

end.




