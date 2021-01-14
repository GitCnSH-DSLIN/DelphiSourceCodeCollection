unit MRPCalForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, DB, ADODB;

type
  TMRPCal = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    ADOQuery2: TADOQuery;
    ADOCommand1: TADOCommand;
    procedure BitBtn1Click(Sender: TObject);
    procedure DataSource2DataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MRPCal: TMRPCal;

implementation

{$R *.dfm}
 //------------MRP����------------------
procedure TMRPCal.BitBtn1Click(Sender: TObject);
var
//���ô������ʱ�Ĳ���
v1,v2,v3:string;
i:integer;
begin
//���ǿ�棬�����Ͳɹ�����
if checkbox1.Checked then
v1:='1'
else
v1:='0';
//�Ƿ�����ǰ��
if checkbox2.Checked then
v2:='1'
else
v2:='0';
//�Ƿ������
if checkbox3.Checked then
v3:='1'
else
v3:='0';
 //���ô�����̣�ִ��mrp����
 adocommand1.CommandText:='exec sf_mrp���� '''+v1+''','''+v2+''','''+v3+'''';
 adocommand1.Execute;
 //ˢ������
 adoquery2.Active:=false;
 adoquery2.Active:=true;
  //������������
  bitbtn2.Enabled:=true;
 end;


procedure TMRPCal.DataSource2DataChange(Sender: TObject; Field: TField);
begin
//�����п��
dbgrid1.Columns[0].Width:=80;
dbgrid2.Columns[1].Width:=80;
dbgrid2.Columns[2].Width:=64;
dbgrid2.Columns[3].Width:=64;
dbgrid2.Columns[4].Width:=64;
dbgrid2.Columns[5].Width:=64;
dbgrid2.Columns[6].Width:=64;
dbgrid2.Columns[7].Width:=64;
dbgrid2.Columns[8].Width:=64;
dbgrid2.Columns[9].Width:=64;
dbgrid2.Columns[10].Width:=64;
dbgrid2.Columns[11].Width:=64;
end;

//�رմ���
procedure TMRPCal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;

//--------------����MRP������-------------
procedure TMRPCal.BitBtn2Click(Sender: TObject);
begin
if application.MessageBox('�Ƿ񷢲����μ�����','����mrp������',MB_OKCANCEL)=ID_OK then
 begin
 //���ô�����̣�ִ��mrp����������
 adocommand1.CommandText:='exec sf_mrp�������';
 adocommand1.Execute;
 //ˢ������
 adoquery2.Active:=false;
 adoquery2.Active:=true;
 adoquery1.Active:=false;
 adoquery1.Active:=true;
 end;
end;

end.
