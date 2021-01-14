unit uFM_2040;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  US_MD_ITEM, DBTables, Db, DBVrtNav, Grids, DBGrids,
  Buttons, DBCtrls, DBNavPlus, ToolWin, ComCtrls, StdCtrls, Mask, ExtCtrls,
  ToolEdit, RXDBCtrl;

type
  TFM_2040 = class(TS_MasterDetail_With_Item)
    Table1F01: TStringField;
    Table1F02: TDateTimeField;
    Table1F03: TStringField;
    Table1F04: TStringField;
    Table1F05: TFloatField;
    Table1F06: TStringField;
    Table1F07: TFloatField;
    Table1F08: TFloatField;
    Table1F09: TFloatField;
    Table1F10: TFloatField;
    Table1F11: TStringField;
    Table1Buser: TStringField;
    Table1Btime: TDateTimeField;
    Table1Euser: TStringField;
    Table1Etime: TDateTimeField;
    Table2D_SN: TSmallintField;
    Table2F02: TStringField;
    Table2F03: TFloatField;
    Table2F04: TFloatField;
    Table2F05: TFloatField;
    Table2F06: TDateTimeField;
    Table2F07: TFloatField;
    DBEdit4: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    DBEdit12: TDBEdit;
    Table2F01: TStringField;
    DBDateEdit1: TDBDateEdit;
    Table2K_SN: TIntegerField;
    RxDBComboEdit1: TRxDBComboEdit;
    RxDBComboEdit2: TRxDBComboEdit;
    Table1lk_FirmName: TStringField;
    Table1lk_Rate: TStringField;
    Table2lk_MaterialName: TStringField;
    Table2lk_MaterialGuiGe: TStringField;
    DBComboBox1: TDBComboBox;
    Table2Cal_Money: TFloatField;
    Table1Cal_PayMoney: TFloatField;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    Table2Buser: TStringField;
    Table2Btime: TDateTimeField;
    Table2Euser: TStringField;
    Table2Etime: TDateTimeField;
    Label6: TLabel;
    procedure DBGrid1EditButtonClick(Sender: TObject); override;
    procedure RxDBComboEdit1ButtonClick(Sender: TObject);
    procedure RxDBComboEdit2ButtonClick(Sender: TObject);
    procedure Table2CalcFields(DataSet: TDataSet);
    procedure Table2BeforePost(DataSet: TDataSet);
    procedure Table1BeforePost(DataSet: TDataSet);
    procedure Table2AfterPost(DataSet: TDataSet);
    procedure Table2AfterDelete(DataSet: TDataSet);
    procedure Table1F06Change(Sender: TField);
    procedure Table1AfterInsert(DataSet: TDataSet);
    procedure Table1F07Change(Sender: TField);
    procedure Table1AfterPost(DataSet: TDataSet);
    procedure Table1AfterScroll(DataSet: TDataSet);
    procedure Table1BeforeInsert(DataSet: TDataSet);
    procedure Table2BeforeInsert(DataSet: TDataSet);
    procedure Table1BeforeDelete(DataSet: TDataSet);
    procedure Table2BeforeDelete(DataSet: TDataSet);
    procedure Table1BeforeEdit(DataSet: TDataSet);
    procedure Table2BeforeEdit(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure Table1CalcFields(DataSet: TDataSet);
    procedure Table2AfterScroll(DataSet: TDataSet);
    procedure SB3Click(Sender: TObject);
    procedure SB2Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CalMoney;
    { Public declarations }
  end;

var
  FM_2040: TFM_2040;
  IfEdit : string='0';
implementation
uses utilities,uDM, uFM_2030, uFunction, uFM_SEG, uRp_2040;

{$R *.DFM}
procedure TFM_2040.CalMoney;
begin
  QryExec(Qry1,'select sum(F05) as money from T2040A where F01='+''''+Table1F01.AsString+'''');

  if Table1F06.AsString='���'  then begin
     Table1F09.Asfloat := Qry1.FieldByName('Money').asfloat; //��ϸ�ܶ�
     Table1F10.Asfloat := Qry1.FieldByName('Money').asfloat; //�����ܶ�
     Table1F08.Asfloat := Qry1.FieldByName('Money').asfloat*Table1F07.asfloat; //˰��
  end;
  if Table1F06.AsString='��˰' then begin
     Table1F09.Asfloat := Qry1.FieldByName('Money').asfloat; //��ϸ�ܶ�
     Table1F10.Asfloat := Qry1.FieldByName('Money').asfloat; //�����ܶ�
     Table1F08.Asfloat := 0; //˰��
  end;
  if Table1F06.AsString='�ں�'  then begin
     Table1F09.Asfloat := Qry1.FieldByName('Money').asfloat; //��ϸ�ܶ�
     Table1F10.Asfloat := Qry1.FieldByName('Money').asfloat*(1-Table1F07.asfloat); //�����ܶ�
     Table1F08.Asfloat := Qry1.FieldByName('Money').asfloat*Table1F07.asfloat; //˰��
  end;
end;

procedure TFM_2040.DBGrid1EditButtonClick(Sender: TObject);
var
 iNo : string;
begin
//��ϸ��������ѡ��
  if DBGrid1.SelectedField = Table2F06 then
      AssignDBDate(Sender, DataSource2, 'F06');
  if DBGrid1.SelectedField = Table2F02 then begin
     //select_data(DataSource2,'���ϵ�ѡ����','select F01 as ���ϱ��,F02 as Ʒ��, F03 as ���,F07 as �ο��۸� from T1060','STK0311',['F02','f04'],[0,3],[]);
     if not SelectMaterialProd(iNo) then exit;
     if Table2.State in [dsBrowse] then Table2.Edit;
     Table2F02.asstring := iNo;
     DM.Q_T1060.Close;
     DM.Q_T1060.open;
  end;
  inherited;

end;

procedure TFM_2040.RxDBComboEdit1ButtonClick(Sender: TObject);
begin
  inherited;
  if select_data(DataSource1,'���Ϲ�Ӧ�̵�ѡ����','select M.F01 as ��Ӧ�̱��,M.F02 as ���� ,M.F21 as �ұ�, M.F22 as ˰��,M.F23 as ˰��,D.F02 as ���� from T5010 as M left join T1100 as D On M.F21=D.F01 ',
          'STK0311',['F03','F04','F06','F07','F05'],[0,2,3,4,5],[70,210]) =false then
     abort;
  DM.Q_T1020.Close;
  DM.Q_T1020.open;
end;

procedure TFM_2040.RxDBComboEdit2ButtonClick(Sender: TObject);
begin
  inherited;
  select_data(DataSource1,'�ұ��ѡ����','select F01 as �ұ�,F02 as ���� from T1100','STK0311',['F04','F05'],[0,1],[]);
  DM.Q_T1100.Close;
  DM.Q_T1100.open;
end;

procedure TFM_2040.Table2CalcFields(DataSet: TDataSet);
begin
  inherited;
  Table2Cal_Money.AsFloat :=Table2F03.AsFloat*Table2F04.AsFloat;
end;

procedure TFM_2040.Table2BeforePost(DataSet: TDataSet);
begin
  inherited;
  Table2F05.asfloat :=Table2Cal_Money.AsFloat;
  InforSave(DataSet);
end;

procedure TFM_2040.Table1BeforePost(DataSet: TDataSet);
begin
  inherited;
  RequiredValue(Table1F03);
  if table1.State = dsinsert then
     Auto_Item_Number(Table1,'F01',cYYMMDD_xxxs,'A',True,Table1F02.AsDateTime);
  InforSave(DataSet);
end;

procedure TFM_2040.Table2AfterPost(DataSet: TDataSet);
begin
  inherited;
  IfEdit := '1';
  table1.edit;
  CalMoney;
  table1.post;
  InforDisplay(DataSet, '���ϲɹ�����ϸ��');
  
end;

procedure TFM_2040.Table2AfterDelete(DataSet: TDataSet);
begin
  inherited;
  IfEdit := '1';
  table1.edit;
  CalMoney;
  table1.post;
end;

procedure TFM_2040.Table1F06Change(Sender: TField);
begin
  inherited;
  CalMoney;
end;

procedure TFM_2040.Table1AfterInsert(DataSet: TDataSet);
begin
  inherited;
  DBDateEdit1.Enabled := true;
  Table1F02.AsDateTime := date;
end;

procedure TFM_2040.Table1F07Change(Sender: TField);
begin
  inherited;
  CalMoney;
end;

procedure TFM_2040.Table1AfterPost(DataSet: TDataSet);
begin
  inherited;
  DBDateEdit1.Enabled := false;
  InforDisplay(DataSet, '���ϲɹ�����ϸ��');
end;

procedure TFM_2040.Table1AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if table1.state = dsBrowse then
     DBDateEdit1.Enabled := false;
  InforDisplay(DataSet, '���ϲɹ�����ϸ��');

end;

procedure TFM_2040.Table1BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  IfDo('����',Qry1,GlobalUser,Hint,'F02');
end;

procedure TFM_2040.Table2BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  IfDo('����',Qry1,GlobalUser,Hint,'F02');
end;

procedure TFM_2040.Table1BeforeDelete(DataSet: TDataSet);
begin
  IfDo('ɾ��',Qry1,GlobalUser,Hint,'F03');
  inherited;
end;

procedure TFM_2040.Table2BeforeDelete(DataSet: TDataSet);
begin
  IfDo('ɾ��',Qry1,GlobalUser,Hint,'F03');
  inherited;
end;

procedure TFM_2040.Table1BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if IfEdit = '0' then
     IfDo('�޸�',Qry1,GlobalUser,Hint,'F04');
     IfEdit :='0';
end;

procedure TFM_2040.Table2BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  IfDo('�޸�',Qry1,GlobalUser,Hint,'F04');
end;

procedure TFM_2040.FormCreate(Sender: TObject);
begin
  inherited;
  if IfHaveRight(Qry1,GlobalUser,Hint,'F06')=false then begin
     DBEdit9.Visible := false;
     DBEdit10.Visible := false;
     DBEdit11.Visible := false;
     DBGrid1.Columns[5].Visible := false;
     DBGrid1.Columns[6].Visible := false;
     Label8.Visible := false;
     Label9.Visible := false;
     Label10.Visible := false;
     DBEdit2.Visible := false;
     Label4.Visible := false;
  end ;
  if IfHaveRight(Qry1,GlobalUser,Hint,'F05')=false then
     SB2.Visible := false;
end;

procedure TFM_2040.Table1CalcFields(DataSet: TDataSet);
begin
  inherited;
  Table1Cal_PayMoney.asfloat := Table1F08.asfloat +Table1F10.asfloat;
end;

procedure TFM_2040.Table2AfterScroll(DataSet: TDataSet);
begin
  inherited;
  InforDisplay(DataSet, '���ϲɹ�����ϸ��');
end;

procedure TFM_2040.SB3Click(Sender: TObject);
begin
  inherited;
  Search_MasterDetailex(table1,[0,1,1,2],table2,[3,4,8],[0,1,2,9],[3,4,5,7,8],['T5010','T1060'],['F01','F01'],['F02','F02,F03'],['��������','Ʒ��,���'],['M.F03','D.F02'],'');
end;

procedure TFM_2040.SB2Click(Sender: TObject);
begin
  inherited;
  if Application.FindComponent('Rp_2040')=nil then
    Rp_2040 := TRp_2040.Create(self);
  with Rp_2040 do
  begin
   Query1.Close;
   Query1.Params[0].AsString := Table1F01.AsString;
   Query1.Open;
   Preview;
  end;
end;

end.
