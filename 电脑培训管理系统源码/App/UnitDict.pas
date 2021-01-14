unit UnitDict;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseDBForm, DB, ComCtrls, DBCtrls, ExtCtrls, MenuBar, ToolWin,
  StdCtrls, Grids, DBGrids;

type
  TfrmDict = class(TBaseDBFrm)
    DS: TDataSource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    cbDict: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure cbDictClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDict: TfrmDict;

implementation

uses UnitData, UnitDM;

{$R *.dfm}

procedure TfrmDict.FormShow(Sender: TObject);
begin
  inherited;
cbDict.Items.Clear;
cbDict.Items.Add('0����Ч��־��');
cbDict.Items.Add('1����ѵ�����');
cbDict.Items.Add('2��ְҵ��');
cbDict.Items.Add('3��ѧ����');
cbDict.Items.Add('4��ѧԱ״̬��');
cbDict.Items.Add('5����Ա���ͱ�');
cbDict.Items.Add('6��ʡ���С�����');
cbDict.Items.Add('7�����ű�');
cbDict.Items.Add('8��ְλ��');
cbDict.Items.Add('9���Ա��');
cbDict.Items.Add('10����Ф��');
cbDict.Items.Add('11��������');
cbDict.Items.Add('12��������');


cbDict.ItemIndex:=0;
DS.DataSet:=DM.T_FLAG;
DS.DataSet.Active:=true;
end;

procedure TfrmDict.ToolButton4Click(Sender: TObject);
begin
  inherited;
if DN.DataSource.DataSet.State in[dsEdit,dsInsert] then
    DN.DataSource.DataSet.Post;

end;

procedure TfrmDict.cbDictClick(Sender: TObject);
begin
  inherited;
DS.DataSet.Close;
case cbDict.ItemIndex of
    0:begin
//0����Ч��־�� T_FLAG
        DS.DataSet:=DM.T_FLAG;
    end;
    1:begin
//1����ѵ����� T_KIND
        DS.DataSet:=DM.T_KIND;
    end;
    2:begin
//2��ְҵ�� T_JOB
        DS.DataSet:=DM.T_JOB;
    end;
    3:begin
//3��ѧ���� T_KNOWLEDGE
        DS.DataSet:=DM.T_KNOWLEDGE;
    end;
    4:begin
//4��ѧԱ״̬�� T_STATE
        DS.DataSet:=DM.T_STATE;
    end;
    5:begin
//5����Ա���ͱ� T_XTYPE
        DS.DataSet:=DM.T_XTYPE;
    end;
    6:begin
//6��ʡ���С����� T_SITE
        DS.DataSet:=DM.T_SITE;
    end;
    7:begin
//7�����ű� T_PART
        DS.DataSet:=DM.T_PART;
    end;
    8:begin
//8��ְλ�� T_ZW
        DS.DataSet:=DM.T_ZW;
    end;
    9:begin
//9���Ա�� T_SEX
        DS.DataSet:=DM.T_SEX;
    end;
    10:begin
//10����Ф�� T_SX
        DS.DataSet:=DM.T_SX;
    end;
    11:begin
//11�������� T_STAR
        DS.DataSet:=DM.T_STAR;
    end;
    12:begin
//12�������� T_WEATHER
        DS.DataSet:=DM.T_WEATHER;
    end;
end;
DS.DataSet.Open;
end;

procedure TfrmDict.ToolButton1Click(Sender: TObject);
var
    ii:integer;
begin
  inherited;
if DN.DataSource.DataSet.State in[dsEdit,dsInsert] then
for ii:=0 to DS.DataSet.FieldCount-1 do
begin
    if UpperCase(DS.DataSet.Fields[ii].FieldName)='FLAG' then
    begin
        DS.DataSet.Fields.Fields[ii].AsString:='Y';
    end;
    if UpperCase(DS.DataSet.Fields[ii].FieldName)='OPERATOR' then
    begin
        DS.DataSet.Fields.Fields[ii].AsString:=sOperator;
    end;

end;
end;

procedure TfrmDict.DBGrid1CellClick(Column: TColumn);
begin
  inherited;
if UpperCase(Column.FieldName)='DETAIL'then
begin
    ShowDetail(Column);

end;
end;

end.
