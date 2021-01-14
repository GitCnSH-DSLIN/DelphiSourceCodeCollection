unit uFM_2100;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  US_MD_ITEM, DBTables, Db, DBVrtNav, Grids, DBGrids,
  Buttons, DBCtrls, DBNavPlus, ToolWin, ComCtrls, StdCtrls, Mask, ExtCtrls,
  ToolEdit, RXDBCtrl;

type
  TFM_2100 = class(TS_MasterDetail_With_Item)
    Table1F01: TStringField;
    Table1F02: TDateTimeField;
    Table1F03: TStringField;
    Table1F04: TStringField;
    Table1F11: TStringField;
    Table1F13: TStringField;
    Table1Buser: TStringField;
    Table1Btime: TDateTimeField;
    Table1Euser: TStringField;
    Table1Etime: TDateTimeField;
    Table2F01: TStringField;
    Table2K_SN: TIntegerField;
    Table2D_SN: TSmallintField;
    Table2F02: TStringField;
    Table2F03: TFloatField;
    Table2Buser: TStringField;
    Table2Btime: TDateTimeField;
    Table2Euser: TStringField;
    Table2Etime: TDateTimeField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit6: TDBEdit;
    Label6: TLabel;
    DBDateEdit1: TDBDateEdit;
    DBComboBox1: TDBComboBox;
    RxDBComboEdit1: TRxDBComboEdit;
    Table2lkPName: TStringField;
    Table2lkPSpce: TStringField;
    Table2lkPUnit: TStringField;
    procedure Table1BeforePost(DataSet: TDataSet);
    procedure Table1AfterInsert(DataSet: TDataSet);
    procedure DBGrid1EditButtonClick(Sender: TObject);override;
    procedure RxDBComboEdit1ButtonClick(Sender: TObject);
    procedure Table2AfterInsert(DataSet: TDataSet);
    procedure Table1AfterPost(DataSet: TDataSet);
    procedure Table2F02Validate(Sender: TField);
    procedure Table2BeforePost(DataSet: TDataSet);
    procedure Table1AfterScroll(DataSet: TDataSet);
    procedure Table2AfterPost(DataSet: TDataSet);
    procedure Table2AfterScroll(DataSet: TDataSet);
    procedure Table1AfterCancel(DataSet: TDataSet);
    procedure SB3Click(Sender: TObject);
    procedure SB2Click(Sender: TObject);
    procedure Table1BeforeInsert(DataSet: TDataSet);
    procedure Table1BeforeEdit(DataSet: TDataSet);
    procedure Table1BeforeDelete(DataSet: TDataSet);
    procedure Table2BeforeInsert(DataSet: TDataSet);
    procedure Table2BeforeEdit(DataSet: TDataSet);
    procedure Table2BeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    procedure DetailEdit(DataSet: TDataSet); override;
    procedure DetailUpdate(DataSet: TDataSet); override;  
    { Public declarations }
  end;

var
  FM_2100: TFM_2100;
  IfEdit : string='0';
implementation

uses utilities, uDM, uFunction, uRp_2100;

{$R *.DFM}

procedure TFM_2100.Table1BeforePost(DataSet: TDataSet);
begin
//�ѽ�����,�޸���,����ʱ��,�޸�ʱ��������ϱ�;
  InforSave(DataSet);
  inherited;
  { <����> �Զ���� }
  if (Table1.State = dsInsert) then begin
    if DBComboBox1.text = '��' then
       Auto_Item_Number(Table1,'F01',cYYMMDD_xxxS,'A',true,Table1F02.AsDateTime)
    else
       Auto_Item_Number(Table1,'F01',cYYMMDD_xxxS,'B',true,Table1F02.AsDateTime)
  end;
end;

procedure TFM_2100.Table1AfterInsert(DataSet: TDataSet);
begin
  inherited;
  DBDateEdit1.Enabled := True;
  DBComboBox1.Enabled := True;
  Table1F02.AsDateTime := Date();
  Table1F13.AsString := '��';
  DBDateEdit1.SetFocus
end;

procedure TFM_2100.DBGrid1EditButtonClick(Sender: TObject);
begin
  inherited;
  { ��ѡ <ԭ�ϱ��> }
  if DBGrid1.SelectedField = Table2F02 then  begin
    if Select_Data(DataSource2,'����ѡȡ����','SELECT F01 as ''���'' , F02 as ''Ʒ��'' , F03 as ''���'' , F09 as ''��λ'' From T1060 Order By F01','STK0311',['F02'],[0],[])
    then begin
           DBGrid1.SelectedField := Table2F03;
    end;
  end;  
end;

procedure TFM_2100.RxDBComboEdit1ButtonClick(Sender: TObject);
begin
  inherited;
  { ��ѡ <������> }
  SelSingle_Data(DataSource1,['����','�Ա�'],'Select F01,F02 From T1040 Order By F01','T1040','F04','F01','F02',True,0);
end;

procedure TFM_2100.Table2AfterInsert(DataSet: TDataSet);
begin
  inherited;
  DBGrid1.SelectedField := Table2F02;
end;

procedure TFM_2100.DetailEdit(DataSet: TDataSet);
begin
  if DBComboBox1.Text = '��' then
    UpdateDatumStock(Qry1,'T1060','+','F04',Table2F03,Table2F02)
  else
    UpdateDatumStock(Qry1,'T1060','-','F04',Table2F03,Table2F02);
end;

procedure TFM_2100.DetailUpdate(DataSet: TDataSet);
begin
  if DBComboBox1.Text = '��' then
    UpdateDatumStock(Qry1,'T1060','-','F04',Table2F03,Table2F02)
  else
    UpdateDatumStock(Qry1,'T1060','+','F04',Table2F03,Table2F02);
end;
procedure TFM_2100.Table1AfterPost(DataSet: TDataSet);
begin
  inherited;
  DBDateEdit1.Enabled := False;
  DBComboBox1.Enabled := False;
//��ʾ�����������޸ļ�¼
  InforDisplay(Dataset,'����������(��)������');  
end;

procedure TFM_2100.Table2F02Validate(Sender: TField);
begin
  inherited;
  DatumNoValidate(Qry1,'T1060',sender)
end;

procedure TFM_2100.Table2BeforePost(DataSet: TDataSet);
begin
//�ѽ�����,�޸���,����ʱ��,�޸�ʱ��������ϱ�;
  InforSave(DataSet);
  inherited;

end;

procedure TFM_2100.Table1AfterScroll(DataSet: TDataSet);
begin
  inherited;
//��ʾ�����������޸ļ�¼
  InforDisplay(Dataset,'����������(��)������');
end;

procedure TFM_2100.Table2AfterPost(DataSet: TDataSet);
begin
  inherited;
//��ʾ�����������޸ļ�¼
  InforDisplay(Dataset,'����������(��)����ϸ��');
end;

procedure TFM_2100.Table2AfterScroll(DataSet: TDataSet);
begin
  inherited;
//��ʾ�����������޸ļ�¼
  InforDisplay(Dataset,'����������(��)����ϸ��');
end;

procedure TFM_2100.Table1AfterCancel(DataSet: TDataSet);
begin
  inherited;
  DBDateEdit1.Enabled := False;
  DBComboBox1.Enabled := False;
end;

procedure TFM_2100.SB3Click(Sender: TObject);
begin
  inherited;
  Search_MasterDetailex(table1,[0,1,1,2,3],table2,[3,4],[0,1,2],[3,4],['T1060'],['F01'],['F02,F03'],['Ʒ��,���'],['D.F02'],'');
end;

procedure TFM_2100.SB2Click(Sender: TObject);
begin
  inherited;
  if Application.FindComponent('Rp_2100')=nil then
    Rp_2100 := TRp_2100.Create(self);
  with Rp_2100 do
  begin
   Query1.Close;
   Query1.Params[0].AsString := Table1F01.AsString;
   Query1.Params[1].AsString := Table1F13.AsString;
   Query1.Open;
   if DBComboBox1.Text = '��' then
      QRLabel1.Caption := '�������ϵ�'
   else
      QRLabel1.Caption := '�����������ϵ�';
   Preview;
  end;

end;

procedure TFM_2100.Table1BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  IfDo('����',Qry1,GlobalUser,Hint,'F02');
end;

procedure TFM_2100.Table1BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if IfEdit = '0' then
     IfDo('�޸�',Qry1,GlobalUser,Hint,'F04');
     IfEdit :='0';
end;

procedure TFM_2100.Table1BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  IfDo('ɾ��',Qry1,GlobalUser,Hint,'F03');
end;

procedure TFM_2100.Table2BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  IfDo('����',Qry1,GlobalUser,Hint,'F02');
end;

procedure TFM_2100.Table2BeforeEdit(DataSet: TDataSet);
begin
  inherited;

     IfDo('�޸�',Qry1,GlobalUser,Hint,'F04');

end;

procedure TFM_2100.Table2BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  IfDo('ɾ��',Qry1,GlobalUser,Hint,'F03');
end;

end.
