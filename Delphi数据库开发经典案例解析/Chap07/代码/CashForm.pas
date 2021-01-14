unit CashForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, ExtCtrls, ImgList,
  ComCtrls, ToolWin, Buttons;

type
  TCash = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Edit4: TEdit;
    DataSource1: TDataSource;
    ADOConnection1: TADOConnection;
    DBGrid1: TDBGrid;
    ADODataSet1: TADODataSet;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    ADOQuery1: TADOQuery;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    BitBtn2: TBitBtn;
    ADOCommand1: TADOCommand;
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure DataSource2DataChange(Sender: TObject; Field: TField);
    procedure Edit6Change(Sender: TObject);
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit3DblClick(Sender: TObject);
    procedure Edit4DblClick(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Cash: TCash;

implementation

{$R *.dfm}
//------------���ݲ������ﵥ�ı����ʾ�䴦�����շ���Ŀ----------
procedure TCash.DataSource1DataChange(Sender: TObject; Field: TField);
var
num:string;//����Һű��
begin
 dbgrid1.Columns[0].Width:=96;
 dbgrid1.Columns[1].Width:=48;
 dbgrid1.Columns[2].Width:=32;
 dbgrid1.Columns[3].Width:=48;
 dbgrid1.Columns[4].Width:=48;
 dbgrid1.Columns[5].Width:=60;
 dbgrid1.Columns[6].Width:=120;
 dbgrid1.Columns[7].Width:=60;
 dbgrid1.Columns[8].Width:=60;
 dbgrid1.Columns[9].Width:=48;
 dbgrid1.Columns[10].Width:=60;
 dbgrid1.Columns[11].Width:=96;
 num:=trim(dbgrid1.Fields[0].Text);//���������
 //������ʾ�Ĳ��˵����ﻮ�۵���ʾ�仮��ҩƷ��ҽ����Ŀ��ϸ
 adoquery1.Close;
 adoquery1.SQL.Clear;
 adoquery1.SQL.Add('select distinct a.���,a.ҩƷ���,b.����,a.����,a.����,a.��� from ���ﻮ����ϸ a,v�շ���Ŀ��ҩƷ b');
 adoquery1.SQL.Add(' where (a.ҩƷ���=b.���)and(a.���۱��='''+num+''')');
 adoquery1.Open;
 //��ʾ���ۺ��Ӧ�ս��
 edit5.Text:=trim(dbgrid1.Fields[5].Text);

end;

//-----������ʾ���˵�ҩƷ��ҽ����Ŀ�շ���ϸ����------
procedure TCash.DataSource2DataChange(Sender: TObject; Field: TField);
var
i:integer;
begin
 for i:=0 to 5 do
  dbgrid2.Columns[i].Width:=80;
end;

//---------�����տ��ı�����������ʾ������---------
procedure TCash.Edit6Change(Sender: TObject);
var
 debt,pay:double;
begin
 if trim(edit6.Text)='' then exit;
 debt:=strtofloat(edit5.Text);
 pay:=strtofloat(edit6.Text);
 edit7.Text:=floattostr(pay-debt);
end;

procedure TCash.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
if (not(key IN ['0'..'9',#13,#46,#8]))THEN //ֻ������ı����������ֺ�С����
   key:=#0
end;

//-------------�����տ�-------------
procedure TCash.BitBtn2Click(Sender: TObject);
begin
if trim(edit7.Text)<>'' then
if strtofloat(edit7.Text)<0 then//�տ�Ӧ������֧�����
 begin
 showmessage('�տ����֧��ҽ�Ʒ���');
 exit;
 end
 else
 begin //�������ﻮ�۵��������˵��ʵ�����Ϊ���շ�
  adocommand1.CommandText:='update ���ﻮ�� set �Ƿ��շ�=''��'',�շ�ʱ��='''+datetostr(date)+' '+timetostr(time)+ ''' where ���='''+trim(dbgrid1.Fields[0].Text)+'''';
  adocommand1.Execute;
  adodataset1.Active:=false;
  adodataset1.Active:=true;
 end;
end;

procedure TCash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;

//-----------����������ѯδ�շѵ����ﵥ----------
procedure TCash.BitBtn1Click(Sender: TObject);
var
time1,time2:string;
begin
   //���ò�ѯʱ������������������Ĭ��Ϊһ���ϴ��ʱ��ֵ���Ա������м�¼
   if trim(edit3.Text)='' then
    time1:='1900-1-1 01:00:00'
    else
    time1:=edit3.Text;

   if trim(edit4.Text)='' then
    time2:='2099-1-1 01:00:00'
   else
    time2:=edit4.Text;

   adoquery1.Close;
   adoquery1.SQL.Clear;
   adoquery1.SQL.Add('select a.* ,b.����,b.�Ա� from ���ﻮ�� a, ����Һ� b');
   adoquery1.SQL.Add(' where (a.�Һű��=b.���)and(a.�Ƿ��շ�=''��'')');
   adoquery1.SQL.Add('and(a.��� like ''%'+edit1.Text+'%'')');
   adoquery1.SQL.Add('and(b.���� like ''%'+edit2.Text+'%'')');
   adoquery1.SQL.Add('and(a.����ʱ��>'''+time1+''')and(a.����ʱ��<'''+time2+''')');
   adoquery1.Open;
   //����ѯ�õ�������ͨ��clone����Ƶ�����ȥ
   adodataset1.Clone(adoquery1,ltUnspecified);
end;

//˫���ı��򣬳���֮ǰԼ8Сʱʱ��ֵ�͵�ǰʱ��ֵ
procedure TCash.Edit3DblClick(Sender: TObject);
begin
edit3.Text:=datetostr(date)+' '+timetostr(time-0.5);
end;

procedure TCash.Edit4DblClick(Sender: TObject);
begin
edit4.Text:=datetostr(date)+' '+timetostr(time);
end;

end.
