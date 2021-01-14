unit uFM_2080;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  US_MD_ITEM, DBTables, Db, DBVrtNav, Grids, DBGrids,
  Buttons, DBCtrls, DBNavPlus, ToolWin, ComCtrls, StdCtrls, Mask, ExtCtrls,
  ToolEdit, RXDBCtrl;

type
  TFM_2080 = class(TS_MasterDetail_With_Item)
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
    DBDateEdit1: TDBDateEdit;
    RxDBComboEdit1: TRxDBComboEdit;
    Table2lkF01: TStringField;
    Table2lkF02: TStringField;
    Table2lkF03: TStringField;
    Table2lkF04: TStringField;
    Table2lkF05: TStringField;
    Table1F13: TStringField;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    Table1lkF03: TStringField;
    Table1lkF04: TStringField;
    RxDBComboEdit2: TRxDBComboEdit;
    RxDBComboEdit3: TRxDBComboEdit;
    DBComboBox1: TDBComboBox;
    Table1F05: TStringField;
    Table1F06: TStringField;
    Label10: TLabel;
    DBEdit2: TDBEdit;
    Table2lkF07: TFloatField;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Table2F06: TStringField;
    Table2F20: TFloatField;
    procedure Table1BeforePost(DataSet: TDataSet);
    procedure DBGrid1EditButtonClick(Sender: TObject);override;
    procedure RxDBComboEdit3ButtonClick(Sender: TObject);
    procedure RxDBComboEdit2ButtonClick(Sender: TObject);
    procedure RxDBComboEdit1ButtonClick(Sender: TObject);
    procedure Table2BeforePost(DataSet: TDataSet);
    procedure Table1AfterPost(DataSet: TDataSet);
    procedure Table1AfterInsert(DataSet: TDataSet);
    procedure Table1AfterScroll(DataSet: TDataSet);
    procedure Table2AfterPost(DataSet: TDataSet);
    procedure Table2AfterScroll(DataSet: TDataSet);
    procedure SB3Click(Sender: TObject);
    procedure SB2Click(Sender: TObject);
    procedure Table2F20Change(Sender: TField);
    procedure Table2F03Change(Sender: TField);
    procedure Table1BeforeDelete(DataSet: TDataSet);
    procedure Table1BeforeEdit(DataSet: TDataSet);
    procedure Table1BeforeInsert(DataSet: TDataSet);
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
  FM_2080: TFM_2080;
  lNeedCalQty :boolean = true;
  lNeedCalWeigh :boolean = true;
  IfEdit : string='0';
implementation

uses utilities, uDM, uFM_SES, uFunction, uFM_SCM, uRP_2080;

{$R *.DFM}

procedure TFM_2080.Table1BeforePost(DataSet: TDataSet);
begin
  inherited;
  //�ѽ�����,�޸���,����ʱ��,�޸�ʱ��������ϱ�
  InforSave(DataSet);
  if Table1.State in [dsInsert] then
    if Table1F13.AsString = '��' then
       Auto_Item_Number(Table1,'F01',cYYMMDD_xxxS,'A',true,Table1F02.AsDateTime)
    else
       Auto_Item_Number(Table1,'F01',cYYMMDD_xxxS,'B',True,Table1F02.AsDateTime)
end;

procedure TFM_2080.DBGrid1EditButtonClick(Sender: TObject);
var
  iNo: integer;
begin
  inherited;
  if DBGrid1.SelectedField = Table2lkF01 then
    if not SelComeMaterial(Table1F01.AsString,Table1F05.AsString,Table1F06.AsString,Table2lkF01.AsString,Table2lkF02.AsString,Table2lkF03.AsString,Table2lkF04.AsString,Table2lkF05.AsString,Table2lkF07.ASInteger,iNo,false) then Exit;
    if Table2.State in [dsBrowse] then Table2.Edit;
    Table2F02.asinteger := iNo;

  { ��ѡ <�����> }
  if DBGrid1.SelectedField = Table2F06 then  begin
    if Select_Data(DataSource2,'���ѡȡ����','select F01 as �����,F02 as ������Ʒ���,F03 as �ͺ�,F04 as Ʒ��,F05 as ���,F06 as ����,F07 as �Ŀ�,F10 as ������ from T2020A where F08=''�ͻ�����'' and F11<F10','STK0311',['F06','F02','F03'],[0,1,7],[80,0])
    then begin
           DBGrid1.SelectedField := Table2F03;
    end;
  end;

end;



procedure TFM_2080.DetailEdit(DataSet: TDataSet);
begin
  //ɾ��һ����ϸ,���϶�Ӧ������
  if Table1F13.AsString='��' then
   begin
    UpdateStock(Qry1,'T1090','+','F06',Table2F03,Table2F02);
    UpdateStock(Qry1,'T1090','+','F12',Table2F03,Table2F02);
    UpdateStock(Qry1,'T1090','+','F13',Table2F20,Table2F02);
    UpdateStock(Qry1,'T1090','+','F14',Table2F20,Table2F02);
   end
  else
   begin
    UpdateStock(Qry1,'T1090','-','F06',Table2F03,Table2F02) ;
    UpdateStock(Qry1,'T1090','-','F12',Table2F03,Table2F02) ;
    UpdateStock(Qry1,'T1090','-','F13',Table2F20,Table2F02);
    UpdateStock(Qry1,'T1090','-','F14',Table2F20,Table2F02);
   end;

  if (DBComboBox1.Text = '��') and (Table2F06.asstring <> '') then
    QryExec(Qry1,'update T2020A set F11=F11-'''+Table2F03.AsString+''' where F01='''+Table2F06.AsString+''' and F02='''+Table2F02.AsString+'''',False)
  else
    QryExec(Qry1,'update T2020A set F11=F11+'''+Table2F03.AsString+''' where F01='''+Table2F06.AsString+''' and F02='''+Table2F02.AsString+'''',False);

end;

procedure TFM_2080.DetailUpdate(DataSet: TDataSet);
begin
  //����һ����ϸ,��ȥ��Ӧ������
  if Table1F13.AsString='��' then
   begin
    UpdateStock(Qry1,'T1090','-','F06',Table2F03,Table2F02);
    UpdateStock(Qry1,'T1090','-','F12',Table2F03,Table2F02);
    UpdateStock(Qry1,'T1090','-','F13',Table2F20,Table2F02);
    UpdateStock(Qry1,'T1090','-','F14',Table2F20,Table2F02);
   end
  else
   begin
    UpdateStock(Qry1,'T1090','+','F06',Table2F03,Table2F02);
    UpdateStock(Qry1,'T1090','+','F12',Table2F03,Table2F02);
    UpdateStock(Qry1,'T1090','+','F13',Table2F20,Table2F02);
    UpdateStock(Qry1,'T1090','+','F14',Table2F20,Table2F02);
   end;

  if (DBComboBox1.Text = '��') and (Table2F06.asstring <> '') then
    QryExec(Qry1,'update T2020A set F11=F11+'''+Table2F03.AsString+''' where F01='''+Table2F06.AsString+''' and F02='''+Table2F02.AsString+'''',False)
  else
    QryExec(Qry1,'update T2020A set F11=F11-'''+Table2F03.AsString+''' where F01='''+Table2F06.AsString+''' and F02='''+Table2F02.AsString+'''',False);

end;



procedure TFM_2080.RxDBComboEdit3ButtonClick(Sender: TObject);
begin
  inherited;
  Select_Data(DataSource1,'��Ա��ѡ����','select F01 as ���� from T1040','STK0311',['F04'],[0],[]);
end;

procedure TFM_2080.RxDBComboEdit2ButtonClick(Sender: TObject);
begin
  inherited;
  Select_Data(DataSource1,'�ͻ���ѡ����','select F01 as �ͻ����,F03 as �ͻ���� from T1010 ','STK0311',['F05'],[0],[]);
end;

procedure TFM_2080.RxDBComboEdit1ButtonClick(Sender: TObject);
begin
  inherited;
  Select_Data(DataSource1,'���ϳ��̵�ѡ����','select F01 as ���ϳ��̱��,F03 as ���ϳ��̼�� from T1011 ','STK0311',['F06'],[0],[]);
end;

procedure TFM_2080.Table2BeforePost(DataSet: TDataSet);
begin
  inherited;
//�ѽ�����,�޸���,����ʱ��,�޸�ʱ��������ϱ�;
  InforSave(DataSet);
end;

procedure TFM_2080.Table1AfterPost(DataSet: TDataSet);
begin
  inherited;
  InforDisplay(DataSet,'�ͻ�������(��)�ⵥ����');
  DBComboBox1.Enabled := false;
  DBDateEdit1.Enabled := false;
end;

procedure TFM_2080.Table1AfterInsert(DataSet: TDataSet);
begin
  inherited;
  DBDateEdit1.Date := Date;
  Table1F13.AsString := '��';
  DBComboBox1.Enabled := true;
  DBDateEdit1.Enabled := true;
end;

procedure TFM_2080.Table1AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if Table1.State in [dsinsert] then
  begin
    DBDateEdit1.Enabled := True;
    DBComboBox1.Enabled := true;
  end
  else
  begin
    DBDateEdit1.Enabled := false;
    DBComboBox1.Enabled := false;
  end;
  InforDisplay(DataSet,'�ͻ�������(��)�ⵥ����');
end;

procedure TFM_2080.Table2AfterPost(DataSet: TDataSet);
begin
  inherited;
  InforDisplay(DataSet,'�ͻ�������(��)�ⵥ��ϸ��');
end;

procedure TFM_2080.Table2AfterScroll(DataSet: TDataSet);
begin
  inherited;
  InforDisplay(DataSet,'�ͻ�������(��)�ⵥ��ϸ��');
end;

procedure TFM_2080.SB3Click(Sender: TObject);
begin
  inherited;
    Search_MasterDetailex(table1,[0,1,1,3,4],table2,[2],[0,1,3,4],[2,16],['T1010','T1090'],['F01','AutoNo'],['F03','F01,F02,F03,F04,F05,F07'],['�ͻ����','�ͺ�,Ʒ��,����,���,�Ŀ�,����'],['M.F03','D.F02'],'');
end;

procedure TFM_2080.SB2Click(Sender: TObject);
begin
  inherited;
  if Application.FindComponent('Rp_2080')=nil then
    Rp_2080 := TRp_2080.Create(self);
  with Rp_2080 do
  begin
   Query1.Close;
   Query1.Params[0].AsString := Table1F01.AsString;
   query1.Params[1].AsString := Table1F13.AsString;
   if DBComboBox1.text = '��' then
      QRLabel1.Caption := '�ͻ������������ϵ�'
   else
      QRLabel1.Caption := '�ͻ������������ϵ�';
   Query1.Open;
   Preview;



  end;
end;

procedure TFM_2080.Table2F20Change(Sender: TField);
begin
  inherited;
  {lNeedCalWeigh := False;
  if lNeedCalQty  then
  Try
     Table2F03.AsFloat := DealFractional((Table2F20.AsFloat/Table2lkF07.AsFloat),2);
  Except
     Table2F03.AsFloat := 0;
  end;
  lNeedCalWeigh := True;}
end;

procedure TFM_2080.Table2F03Change(Sender: TField);
begin
  inherited;
  {lNeedCalQty := false;
  if lNeedCalWeigh then
  Try
     Table2F20.AsFloat := DealFractional(Table2lkF07.AsFloat * Table2F03.AsFloat,2);
  Except
     Table2F20.AsFloat := 0;
  end;
  lNeedCalQty := true;}

end;

procedure TFM_2080.Table1BeforeDelete(DataSet: TDataSet);
begin
  inherited;
   IfDo('ɾ��',Qry1,GlobalUser,Hint,'F03');
end;

procedure TFM_2080.Table1BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if IfEdit = '0' then
     IfDo('�޸�',Qry1,GlobalUser,Hint,'F04');
     IfEdit :='0';
end;

procedure TFM_2080.Table1BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  IfDo('����',Qry1,GlobalUser,Hint,'F02');
end;

procedure TFM_2080.Table2BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  IfDo('ɾ��',Qry1,GlobalUser,Hint,'F03');
end;

procedure TFM_2080.Table2BeforeEdit(DataSet: TDataSet);
begin
  inherited;

     IfDo('�޸�',Qry1,GlobalUser,Hint,'F04');

end;

procedure TFM_2080.Table2BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  IfDo('����',Qry1,GlobalUser,Hint,'F02');
end;

end.
