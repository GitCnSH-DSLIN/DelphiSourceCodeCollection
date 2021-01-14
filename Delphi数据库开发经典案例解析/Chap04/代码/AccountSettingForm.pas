unit AccountSettingForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, DB, ADODB;

type
  TAccountSetting = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    ADOTable1: TADOTable;
    DataSource1: TDataSource;
    ADOTable2: TADOTable;
    DataSource2: TDataSource;
    ADOCommand1: TADOCommand;
    ADOQuery1: TADOQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure DataSource2DataChange(Sender: TObject; Field: TField);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AccountSetting: TAccountSetting;

implementation

{$R *.dfm}
uses sumaccountform;
procedure TAccountSetting.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
action:=cafree;
end;

//-------------���ñ��-----------------
procedure TAccountSetting.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
 //�����ʲ���ʼ�����п�
 dbgrid1.Columns[0].Width:=64;
 dbgrid1.Columns[1].Width:=100;
 dbgrid1.Columns[2].Width:=64;
 dbgrid1.Columns[3].Width:=64;
 dbgrid1.Columns[4].Width:=64;
 dbgrid1.Columns[5].Width:=64;
end;

procedure TAccountSetting.DataSource2DataChange(Sender: TObject;
  Field: TField);
begin
//����ϵͳ�������п�
 dbgrid2.Columns[0].Width:=32;
 dbgrid2.Columns[1].Width:=112;
 dbgrid2.Columns[2].Width:=32;
end;

//-----------------��ʼ���ʻ�-----------------------
procedure TAccountSetting.BitBtn1Click(Sender: TObject);
begin
 //ִ�д�����̣���ʼ���ʻ�
 adocommand1.CommandText:='EXEC sf_��ʼ���ʻ�';
 if application.MessageBox('�Ƿ����ԭ�ʲ���Ϣ������ʼ�����ʲ���','ȷ��',MB_OKCANCEL)=IDOK then
 adocommand1.Execute;
 //ˢ�����ݱ�
 adotable1.Active:=false;
 adotable1.Active:=true;
 adotable2.Active:=false;
 adotable2.Active:=true;
end;

//--------------------�������ʻ�-----------------
procedure TAccountSetting.BitBtn2Click(Sender: TObject);
begin

//�ж��Ƿ�����ƽ��
adoquery1.Close;
adoquery1.SQL.Clear;
adoquery1.SQL.Add('select sum(�ۼƽ跽) �跽,sum(�ۼƴ���) ���� from �ʲ���ʼ����');
adoquery1.Open;
if adoquery1.FieldByName('�跽').AsString<>adoquery1.FieldByName('����').AsString then
 begin
 showmessage('���ʲ���ʼ����ƽ�⣬��������ƽ������������');
 exit;
 end;
//�������ƽ�⣬������½��ʲ�
if application.MessageBox('������ƽ�⣬�������ʲ���ɾ��������ʷ��¼'+#13+'�Ƿ������','ȷ��',MB_OKCANCEL)=IDOK then
 begin
  //ִ�д�����̣������ʻ�
  adocommand1.CommandText:='EXEC sf_�����ʻ�';
  adocommand1.Execute;
  //ˢ�����ݱ�
  adotable1.Active:=false;
  adotable1.Active:=true;
  adotable2.Active:=false;
  adotable2.Active:=true;
  //��ʾ�ʻ����óɹ���Ϣ
  showmessage('���ʻ����óɹ�');
 end;

end;

//��ʾ��ʼ��ʱ������ƽ���
procedure TAccountSetting.BitBtn3Click(Sender: TObject);
var
  newform:Tsumaccount;
begin
    //��������ƽ�ⴰ��
    newform:=Tsumaccount.Create(application);
    newform.Caption:='����ƽ���(��ʼ��)';
    //�ڳ�ʼ��ʱʹ��
    newform.forinitial;
    
end;

end.
