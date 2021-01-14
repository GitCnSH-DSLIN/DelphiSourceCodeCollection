unit uFM_2121;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  US_MD_ITEM, DBTables, Db, DBVrtNav, Grids, DBGrids,
  Buttons, DBCtrls, DBNavPlus, ToolWin, ComCtrls, StdCtrls, Mask, ExtCtrls,
  ToolEdit, RXDBCtrl;

type
  TFM_2121 = class(TS_MasterDetail_With_Item)
    Table1F01: TStringField;
    Table1F02: TDateTimeField;
    Table1F03: TStringField;
    Table1F04: TStringField;
    Table1F11: TStringField;
    Table1Buser: TStringField;
    Table1Btime: TDateTimeField;
    Table1Euser: TStringField;
    Table1Etime: TDateTimeField;
    Table2F01: TStringField;
    Table2K_SN: TIntegerField;
    Table2D_SN: TSmallintField;
    Table2F02: TIntegerField;
    Table2F03: TFloatField;
    Table2Buser: TStringField;
    Table2Btime: TDateTimeField;
    Table2Euser: TStringField;
    Table2Etime: TDateTimeField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBDateEdit1: TDBDateEdit;
    RxDBComboEdit1: TRxDBComboEdit;
    Table2lkF01: TStringField;
    Table2lkF02: TStringField;
    Table2lkF03: TStringField;
    Table2lkF04: TStringField;
    Table2lkF05: TStringField;
    Table2F06: TStringField;
    Table2lkF07: TFloatField;
    Table2F10: TStringField;
    Table2F20: TFloatField;
    procedure Table1BeforePost(DataSet: TDataSet);
    procedure RxDBComboEdit1ButtonClick(Sender: TObject);
    procedure DBGrid1EditButtonClick(Sender: TObject);override;
    procedure Table2BeforePost(DataSet: TDataSet);
    procedure Table2AfterPost(DataSet: TDataSet);
    procedure Table2AfterScroll(DataSet: TDataSet);
    procedure Table1AfterPost(DataSet: TDataSet);
    procedure Table1AfterScroll(DataSet: TDataSet);
    procedure Table1AfterInsert(DataSet: TDataSet);
    procedure SB3Click(Sender: TObject);
    procedure SB2Click(Sender: TObject);
    procedure Table2F20Change(Sender: TField);
    procedure Table2F03Change(Sender: TField);
    procedure Table1BeforeInsert(DataSet: TDataSet);
    procedure Table1BeforeEdit(DataSet: TDataSet);
    procedure Table1BeforeDelete(DataSet: TDataSet);
    procedure Table2BeforeDelete(DataSet: TDataSet);
    procedure Table2BeforeEdit(DataSet: TDataSet);
    procedure Table2BeforeInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    procedure DetailEdit(DataSet: TDataSet); override;
    procedure DetailUpdate(DataSet: TDataSet); override;
    { Public declarations }
  end;

var
  FM_2121: TFM_2121;
  lNeedCalQty : boolean = true;
  lNeedCalWeigh : boolean = true;
  IfEdit : string='0';
implementation

uses utilities, uDM, uFM_SES, uFunction, uFM_SEP, uRP_2121;

{$R *.DFM}

procedure TFM_2121.Table1BeforePost(DataSet: TDataSet);
begin
  inherited;
  //�ѽ�����,�޸���,����ʱ��,�޸�ʱ��������ϱ�;
  InforSave(DataSet);
  if Table1.State in [dsInsert] then
  Auto_Item_Number(Table1,'F01',cYYMMDD_xxxS,'A',true,Table1F02.AsDateTime);
end;

procedure TFM_2121.RxDBComboEdit1ButtonClick(Sender: TObject);
begin
  inherited;
  Select_Data(DataSource1,'��Ա��ѡ����','select F01 as ���� from T1040','STK0311',['F04'],[0],[]);
end;

procedure TFM_2121.DBGrid1EditButtonClick(Sender: TObject);
var
  iNo: integer;
begin
  inherited;
  if DBGrid1.SelectedField = Table2lkF01 then
  begin
    if not SelProd(Table2lkF01.AsString,Table2lkF02.AsString,Table2lkF03.AsString,Table2lkF04.AsString,Table2lkF05.AsString,iNo) then Exit;
    if Table2.State in [dsBrowse] then Table2.Edit;
    Table2F02.asinteger := iNo;
  end;

  { ��ѡ <�����> }
  if DBGrid1.SelectedField = Table2F06 then  begin
    if Select_Data(DataSource2,'���ѡȡ����','select M.F01 as �����,'
                +'M.F02 as ��������,M.F03 as ��Ʒ���,'
                +'M.F06 as Ԥ��������,M.F04 as ��������,P.F01 as �ͺ�,P.F02 as Ʒ��,'
                +'P.F03 as ����,P.F04 as ���,P.F05 as �Ŀ� from T2020 as M '
                +'left join T1080 as P ON M.F03=P.AutoNo where M.F07<M.F06 and M.F09=''��Ʒ''',
                'STK0311',['F06','F02','F03','F10'],[0,2,3,5],[73,60,0,63,60,28,76,40,62,28])
    then begin
           DBGrid1.SelectedField := Table2F03;
    end;
  end;

end;



procedure TFM_2121.DetailEdit(DataSet: TDataSet);
begin
  //ɾ��һ����ϸ,��ȥ��Ӧ������
  UpdateStock(Qry1,'T1080','-','F06',Table2F03,Table2F02);
  UpdateStock(Qry1,'T1080','-','F12',Table2F03,Table2F02);
  //�������
  QryExec(Qry1,'update T2020 set F07=F07-'''+Table2F03.AsString+''' where F01='''+Table2F06.AsString+''' and F03='''+Table2F02.AsString+'''',False)  
end;

procedure TFM_2121.DetailUpdate(DataSet: TDataSet);
begin
  //����һ����ϸ,���϶�Ӧ������
  UpdateStock(Qry1,'T1080','+','F06',Table2F03,Table2F02);
  UpdateStock(Qry1,'T1080','+','F12',Table2F03,Table2F02);
  //�������
  QryExec(Qry1,'update T2020 set F07=F07+'''+Table2F03.AsString+''' where F01='''+Table2F06.AsString+''' and F03='''+Table2F02.AsString+'''',False)  
end;



procedure TFM_2121.Table2BeforePost(DataSet: TDataSet);
begin
  inherited;
 //�ѽ�����,�޸���,����ʱ��,�޸�ʱ��������ϱ�;
  InforSave(DataSet);
end;

procedure TFM_2121.Table2AfterPost(DataSet: TDataSet);
begin
  inherited;
  InforDisplay(DataSet,'��Ʒ��ⵥ��ϸ��');
end;

procedure TFM_2121.Table2AfterScroll(DataSet: TDataSet);
begin
  inherited;
  InforDisplay(DataSet,'��Ʒ��ⵥ��ϸ��');
end;

procedure TFM_2121.Table1AfterPost(DataSet: TDataSet);
begin
  inherited;
  DBDateEdit1.Enabled := false;
  InforDisplay(DataSet,'��Ʒ��ⵥ����');
end;

procedure TFM_2121.Table1AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if Table1.State in [dsinsert] then
    DBDateEdit1.Enabled := True
  else
    DBDateEdit1.Enabled := false;
  InforDisplay(DataSet,'��Ʒ��ⵥ����');
end;

procedure TFM_2121.Table1AfterInsert(DataSet: TDataSet);
begin
  inherited;
  DBDateEdit1.Date := Date ;
  DBDateEdit1.Enabled := true;
end;

procedure TFM_2121.SB3Click(Sender: TObject);
begin
  inherited;
  Search_MasterDetailex(table1,[0,1,1,2,3],table2,[3,6],[0,1,2,3],[3,6,17],['T1080'],['AutoNo'],['F01,F02,F03,F04,F05,F07'],['�ͺ�,Ʒ��,����,���,�Ŀ�,����'],['D.F02'],'');
end;

procedure TFM_2121.SB2Click(Sender: TObject);
begin
  inherited;
  if Application.FindComponent('RP_2121')=nil then
    RP_2121 := TRP_2121.Create(Application);
  with Rp_2121 do
  begin
    Query1.Close;
    Query1.Params[0].AsString := Table1F01.AsString;
    Query1.Open;
    Preview;
  end;
end;

procedure TFM_2121.Table2F20Change(Sender: TField);
begin
  inherited;
  lNeedCalWeigh := false;
  if lNeedCalQty Then
  Try
     Table2F03.AsFloat := DealFractional(Table2F20.AsFloat/Table2lkF07.AsFloat,2);
  Except
     Table2F03.AsFloat := 0;
  end;
  lNeedCalWeigh := true;
end;

procedure TFM_2121.Table2F03Change(Sender: TField);
begin
  inherited;
  lNeedCalQty := false;
  if lNeedCalWeigh Then
  Try
     Table2F20.AsFloat := DealFractional(Table2lkF07.AsFloat * Table2F03.AsFloat,2);
  Except
     Table2F20.AsFloat := 0;
  end;
  lNeedCalQty := true;
end;

procedure TFM_2121.Table1BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  IfDo('����',Qry1,GlobalUser,Hint,'F02');
end;

procedure TFM_2121.Table1BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if IfEdit = '0' then
     IfDo('�޸�',Qry1,GlobalUser,Hint,'F04');
     IfEdit :='0';
end;

procedure TFM_2121.Table1BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  IfDo('ɾ��',Qry1,GlobalUser,Hint,'F03');
end;

procedure TFM_2121.Table2BeforeDelete(DataSet: TDataSet);
begin
  inherited;
   IfDo('ɾ��',Qry1,GlobalUser,Hint,'F03');
end;

procedure TFM_2121.Table2BeforeEdit(DataSet: TDataSet);
begin
  inherited;

     IfDo('�޸�',Qry1,GlobalUser,Hint,'F04');

end;

procedure TFM_2121.Table2BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  IfDo('����',Qry1,GlobalUser,Hint,'F02');
end;

end.
