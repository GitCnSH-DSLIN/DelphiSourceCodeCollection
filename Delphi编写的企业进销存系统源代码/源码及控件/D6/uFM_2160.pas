unit uFM_2160;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  US_MD_ITEM, DBTables, Db, DBVrtNav, Grids, DBGrids,
  Buttons, DBCtrls, DBNavPlus, ToolWin, ComCtrls, StdCtrls, Mask, ExtCtrls,
  RXDBCtrl, ToolEdit;

type
  TFM_2160 = class(TS_MasterDetail_With_Item)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    DBDateEdit1: TDBDateEdit;
    RxDBComboEdit1: TRxDBComboEdit;
    DBEdit2: TDBEdit;
    RxDBComboEdit2: TRxDBComboEdit;
    DBComboBox1: TDBComboBox;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBComboBox2: TDBComboBox;
    Label18: TLabel;
    DBEdit13: TDBEdit;
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
    Table1F12: TStringField;
    Table1F13: TStringField;
    Table1Buser: TStringField;
    Table1Btime: TDateTimeField;
    Table1Euser: TStringField;
    Table1Etime: TDateTimeField;
    Table2F01: TStringField;
    Table2K_SN: TIntegerField;
    Table2D_SN: TSmallintField;
    Table2F02: TIntegerField;
    Table2F03: TFloatField;
    Table2F04: TFloatField;
    Table2F05: TFloatField;
    Table2F06: TStringField;
    Table2Buser: TStringField;
    Table2Btime: TDateTimeField;
    Table2Euser: TStringField;
    Table2Etime: TDateTimeField;
    Table1lkF03: TStringField;
    Table1CalF09: TFloatField;
    Table2CalF05: TFloatField;
    Table1CalF08: TFloatField;
    Table1CalF10: TFloatField;
    Query1: TQuery;
    Table2lkF01: TStringField;
    Table2lkF02: TStringField;
    Table2lkF03: TStringField;
    Table2lkF04: TStringField;
    Table2lkF05: TStringField;
    Table1F14: TStringField;
    Table2F07: TStringField;
    Label19: TLabel;
    RxDBComboEdit3: TRxDBComboEdit;
    DBEdit14: TDBEdit;
    Table1lkF14: TStringField;
    Table2lkF07: TFloatField;
    Label14: TLabel;
    DBEdit9: TDBEdit;
    Table1CalTotal: TFloatField;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label4: TLabel;
    Table2F20: TFloatField;
    Table2lkF06: TStringField;
    Table2F08: TDateTimeField;
    Table2F09: TIntegerField;
    procedure Table1AfterInsert(DataSet: TDataSet);
    procedure Table1BeforePost(DataSet: TDataSet);
    procedure RxDBComboEdit1ButtonClick(Sender: TObject);
    procedure RxDBComboEdit2ButtonClick(Sender: TObject);
    procedure Table2CalcFields(DataSet: TDataSet);
    procedure Table1CalcFields(DataSet: TDataSet);
    procedure Table2BeforePost(DataSet: TDataSet);
    procedure Table2AfterPost(DataSet: TDataSet);
    procedure Table2AfterDelete(DataSet: TDataSet);
    procedure DBGrid1EditButtonClick(Sender: TObject);override;
    procedure RxDBComboEdit3ButtonClick(Sender: TObject);
    procedure Table1AfterPost(DataSet: TDataSet);
    procedure Table1AfterScroll(DataSet: TDataSet);
    procedure Table2AfterScroll(DataSet: TDataSet);
    procedure SB2Click(Sender: TObject);
    procedure RxDBComboEdit1Exit(Sender: TObject);
    procedure Table1AfterCancel(DataSet: TDataSet);
    procedure SB3Click(Sender: TObject);
    procedure Table2F20Change(Sender: TField);
    procedure Table2F03Change(Sender: TField);
    procedure Table1BeforeInsert(DataSet: TDataSet);
    procedure Table1BeforeEdit(DataSet: TDataSet);
    procedure Table1BeforeDelete(DataSet: TDataSet);
    procedure Table2BeforeDelete(DataSet: TDataSet);
    procedure Table2BeforeEdit(DataSet: TDataSet);
    procedure Table2BeforeInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure DetailEdit(DataSet: TDataSet); override;
    procedure DetailUpdate(DataSet: TDataSet); override;
    { Public declarations }
  end;

var
  FM_2160: TFM_2160;
  lNeedCalQty : boolean = true;
  lNeedCalWeigh : boolean = true;
  IfEdit : string='0';
const
 xSQL = 'select A.F01 as ''��������'',M.F12 AS ''�ͻ�����'',A.F02 as ''��Ʒ���'',(A.F03 - A.F07) as ''�ɳ�������'',B.F01 as ''�ͺ�'',B.F02 as ''Ʒ��'',B.F03 as ''����'',B.F04 as ''���'',B.F05 as ''�Ŀ�'',A.F07 as ''�ѳ�(��)����'',A.F04 as ''����'',A.F06 as ''����'',A.K_SN AS ''�������'''
        +' from T2010A as A'
        +' left join T2010 as M on M.F01=A.F01'
        +' left join T1080 as B on A.F02=B.AutoNo';

 xSQL1 = 'select A.F01 as ''��������'',M.F12 AS ''�ͻ�����'',A.F02 as ''��Ʒ���'', A.F07 as ''����'',B.F01 as ''�ͺ�'',B.F02 as ''Ʒ��'',B.F03 as ''����'',B.F04 as ''���'',B.F05 as ''�Ŀ�'',A.F07 as ''�ѳ�(��)����'',A.F04 as ''����'',A.F06 as ''����'',A.K_SN AS ''�������'''
        +' from T2010A as A'
        +' left join T2010 as M on M.F01=A.F01'
        +' left join T1080 as B on A.F02=B.AutoNo';

implementation

 uses uDM,utilities,uFunction, uRP_2160;

{$R *.DFM}

procedure TFM_2160.Table1AfterInsert(DataSet: TDataSet);
begin
  inherited;
  DBDateEdit1.Date := Date;
  Table1F13.AsString := '��';
  DBDateEdit1.Enabled := True;
  DBComboBox2.Enabled := True;
  DBDateEdit1.SetFocus;



end;

procedure TFM_2160.Table1BeforePost(DataSet: TDataSet);
begin
//�ѽ�����,�޸���,����ʱ��,�޸�ʱ��������ϱ�;
  InforSave(DataSet);
  

  inherited;
  if (Table1.State = dsInsert) then
   begin
    if DBComboBox2.Text = '��' then
      Auto_Item_Number(Table1,'F01',CYYMMDD_xxxs,'A',true,Table1F02.AsDateTime)
    else
      Auto_Item_Number(Table1,'F01',CYYMMDD_xxxs,'B',true,Table1F02.AsDateTime);
   end;
  
  Table1F09.AsFloat := Table1CalF09.AsFloat;
  Table1F08.AsFloat := Table1CalF08.AsFloat;
  Table1F10.AsFloat := Table1CalF10.AsFloat;






end;

procedure TFM_2160.RxDBComboEdit1ButtonClick(Sender: TObject);
begin
  inherited;
  select_data(DataSource1,'�ӿͻ�����ѡȡ','select F01 as ''�ͻ����'',F02 as ''�ͻ�����'',F21 as ''�ұ�'',F22 as ''˰��'',F23 as ''˰��'' from T1010  order by F01 ','STK0311',['F03','F04','F06','F07'],[0,2,3,4],[60]);
  
end;

procedure TFM_2160.RxDBComboEdit2ButtonClick(Sender: TObject);
begin
  inherited;
  select_data(DataSource1,'�ӱұ�ѡ��','select F01 as ''�ұ�'',F02 as ''��������'' from T1100','STK0311',['F04','F05'],[0,1],[60,60]);
end;

procedure TFM_2160.Table2CalcFields(DataSet: TDataSet);
begin
  Table2CalF05.AsFloat := Table2F03.AsFloat * Table2F04.AsFloat;
  Table2CalF05.AsFloat := DealFractional(Table2CalF05.asFloat,2);
  inherited;
  
end;

procedure TFM_2160.Table1CalcFields(DataSet: TDataSet);
begin
 //������ϸ�ܶ�
  Query1.Close;
  Query1.SQL.Clear;
  Query1.SQL.Add('select sum(F05) as TM from T2160A where F01='''+Table1F01.AsString+'''');
  Query1.Open;
  Table1CalF09.AsFloat := Query1.Fields[0].AsFloat;
//����˰��
  if  Table1F06.AsString = '��˰' then
   begin
     Table1CalF08.AsFloat := 0;
     Table1CalF10.AsFloat := DealFractional(Query1.Fields[0].AsFloat,2);
     Table1CalTotal.AsFloat := Table1CalF08.AsFloat + Table1CalF10.AsFloat;
   end;

  if Table1F06.AsString = '�ں�' then
     begin
      Table1CalF08.AsFloat := DealFractional((Query1.Fields[0].AsFloat *  Table1F07.AsFloat),2);
      Table1CalF10.AsFloat := DealFractional((Query1.Fields[0].AsFloat - Query1.Fields[0].AsFloat * Table1F07.AsFloat),2);
      Table1CalTotal.AsFloat := Table1CalF08.AsFloat + Table1CalF10.AsFloat;
     end ;

  if Table1F06.AsString = '���' then
     begin
       Table1CalF08.AsFloat := DealFractional((Query1.Fields[0].AsFloat * Table1F07.AsFloat),2);
       Table1CalF10.AsFloat := DealFractional(Query1.Fields[0].AsFloat,2);
       Table1CalTotal.AsFloat := Table1CalF08.AsFloat + Table1CalF10.AsFloat;
     end;


  inherited;

end;

procedure TFM_2160.Table2BeforePost(DataSet: TDataSet);
begin
   Table2F05.AsFloat := Table2CalF05.AsFloat;
//�ѽ�����,�޸���,����ʱ��,�޸�ʱ��������ϱ�;
  InforSave(DataSet);
  inherited;
  
end;

procedure TFM_2160.Table2AfterPost(DataSet: TDataSet);
begin
//ˢ��������
  Table1.Refresh;
  Table1.Edit;
  Table1.Post;
  inherited;
  InforDisplay(DataSet,'��(��)����ϸ');
  
  if Table2.RecordCount <> 0  then begin
     RxDBComboEdit1.Enabled := False;
     RxDBComboEdit3.Enabled := False
  end else begin
     RxDBComboEdit1.Enabled := True;
     RxDBComboEdit3.Enabled := True
  end;
    
end;

procedure TFM_2160.Table2AfterDelete(DataSet: TDataSet);
begin
//ˢ������
  Table1.Refresh;
  inherited;
  Table1.Edit;
  Table1.Post;

  if Table2.RecordCount <> 0  then begin
     RxDBComboEdit1.Enabled := False;
     RxDBComboEdit3.Enabled := False
  end else begin
     RxDBComboEdit1.Enabled := True;
     RxDBComboEdit3.Enabled := True
  end;
end;

procedure TFM_2160.DetailEdit(DataSet: TDataSet);
begin
  inherited;
{ ɾ��һ����ϸʱ, ��Ӧ ���� ����� }
{ ɾ��һ����ϸʱ, ��Ӧ ��ȥ �������ѳ����� }
if Table1F13.AsString = '��' then
 begin
  UpdateStock(Qry1,'T1080','+','F06',Table2F03,Table2F02);
  UpdateStock(Qry1,'T1080','+','F12',Table2F03,Table2F02);
  QryExec(Qry1,'Update T2010A set F07=F07-'''+Table2F03.AsString+''' where F01='''+Table2F06.AsString+''' and F02='''+Table2F02.asString+''' and F06='''+Table2F08.AsString+''' and K_SN='''+Table2F09.AsString+'''',False);
 end
else
 begin
  UpdateStock(Qry1,'T1080','-','F06',Table2F03,Table2F02);
  UpdateStock(Qry1,'T1080','-','F12',Table2F03,Table2F02);
  QryExec(Qry1,'Update T2010A set F07=F07+'''+Table2F03.asString+''' where F01='''+Table2F06.AsString+''' and F02='''+Table2F02.asString+''' and F06='''+Table2F08.AsString+''' and K_SN='''+Table2F09.AsString+'''',False);
 end;

end;

procedure TFM_2160.DetailUpdate(DataSet: TDataSet);
begin
  inherited;
{ ����һ����ϸʱ, ��Ӧ ��ȥ ����� }
  if Table1F13.AsString = '��' then
   begin
    UpdateStock(Qry1,'T1080','-','F06',Table2F03,Table2F02);
    UpdateStock(Qry1,'T1080','-','F12',Table2F03,Table2F02);
    QryExec(Qry1,'Update T2010A set F07=F07+'''+Table2F03.AsString+''' where F01='''+Table2F06.AsString+''' and F02='''+Table2F02.asString+''' and F06='''+Table2F08.AsString+''' and K_SN='''+Table2F09.AsString+'''',False);

   end
  else
   begin
    UpdateStock(Qry1,'T1080','+','F06',Table2F03,Table2F02);
    UpdateStock(Qry1,'T1080','+','F12',Table2F03,Table2F02);
    QryExec(Qry1,'Update T2010A set F07=F07-'''+Table2F03.asString+''' where F01='''+Table2F06.AsString+''' and F02='''+Table2F02.asString+''' and F06='''+Table2F08.AsString+''' and K_SN='''+Table2F09.AsString+'''',False);
   end;
end;

procedure TFM_2160.DBGrid1EditButtonClick(Sender: TObject);
begin
  inherited;
  if DBGrid1.SelectedField = Table2F06 then
   if Table1F13.AsString = '��' then
    begin
     if Select_Data(DataSource2, '�Ӷ���ѡȡ',
                   format('%s Where A.F03 > A.F07  and M.F03='''+Table1F03.asString+''''+ ' and M.F14='+''''+Table1F14.asString+'''',[xSQL] ),
                   'STK0311', ['F06','F02','F03','F04','F08','F09'],[0,2,3,10,11,12],
                   [75,50,0,70,28,76,45,72,28,72,45,60,20])
     then begin
           DBGrid1.SelectedField := Table2F03;
         end;
    end
   else
    begin
      if Select_Data(DataSource2, '�Ӷ���ѡȡ',
                     format('%s where (A.F07 > 0) and (A.F07 <= A.F03)  and M.F03='''+Table1F03.AsString+'''',[xSQL1] ),
                     'STK0311',['F06','F02','F03','F04','F08','F09'],[0,2,3,10,11,12],
                     [75,50,0,50,28,76,45,72,28,72,45,60])
    then begin
          DBGrid1.SelectedField := Table2F03;
         end;
    end;
end;

procedure TFM_2160.RxDBComboEdit3ButtonClick(Sender: TObject);
begin
  inherited;
  select_data(DataSource1,'��ָ�ͳ�������ѡȡ','select F01 as ''ָ�ͳ��̱��'',F02 as ''ָ�ͳ�������'' from T1011 ','STK0311',['F14'],[0],[]);
end;

procedure TFM_2160.Table1AfterPost(DataSet: TDataSet);
begin
  inherited;
  InforDisplay(DataSet,'��(��)������');
  DBDateEdit1.Enabled := False;
  DBComboBox2.Enabled := False;
end;

procedure TFM_2160.Table1AfterScroll(DataSet: TDataSet);
begin
  inherited;
  InforDisplay(DataSet,'��(��)������');
  if Table1.State = dsInsert then
   begin
    DBDateEdit1.Enabled := True;
    DBComboBox2.Enabled := True;
   end
  else
   begin
     DBDateEdit1.Enabled := False;
     DBComboBox2.Enabled := False;
   end;

  if (Table2.State= dsBrowse) and (Table2.RecordCount <> 0)  then begin
     RxDBComboEdit1.Enabled := False;
     RxDBComboEdit3.Enabled := False
  end else begin
     RxDBComboEdit1.Enabled := True;
     RxDBComboEdit3.Enabled := True
  end;   
end;

procedure TFM_2160.Table2AfterScroll(DataSet: TDataSet);
begin
  inherited;
  InforDisplay(DataSet,'��(��)����ϸ');
end;

procedure TFM_2160.SB2Click(Sender: TObject);
begin
  inherited;
    if Application.FindComponent('RP_2160')=nil then
     RP_2160 := TRP_2160.Create(Application);
  with RP_2160 do
  begin
   Query1.close;
   Query1.Params[0].AsString := DBEdit1.text ;
   if DBComboBox2.Text = '��' then
     QRLabel1.Caption := '������'
   else
     QRLabel1.Caption := '�˻���';
   Query1.open;
   PreviewModal;
  end;
end;

procedure TFM_2160.RxDBComboEdit1Exit(Sender: TObject);
begin
//�����˿�����
  inherited;
  if Table1F12.AsString='' then
  begin
    if Copy(formatdatetime('YYYYMM',Table1F02.AsDateTime),5,2) < '12' then
     begin
       QryExec(Qry1,'select F20 from T1010 where F01='''+Table1F03.AsString+'''');
       if Qry1.Fields[0].AsString = '25' then
        begin
          if formatdatetime('dd',Table1F02.AsDatetime) > '25' then

            Table1F12.AsString := copy(formatdatetime('YYYYMM',Table1F02.AsDateTime),3,2)+inttostr((strtoint(formatdatetime('mm',Table1F02.ASDateTime)))+1)
          else
            Table1F12.AsString := copy(formatdatetime('YYYYMM',Table1F02.AsDateTime),3,4);
        end
       else
         Table1F12.AsString := copy(formatdatetime('YYYYMM',Table1F02.AsDateTime),3,4);
     end
    else
     begin
       QryExec(Qry1,'select F20 from T1010 where F01='''+Table1F03.AsString+'''');
       if Qry1.Fields[0].AsString = '25' then
        begin
          if formatdatetime('dd',Table1F02.AsDatetime) > '25' then

            Table1F12.AsString := IntToString(strtoint(copy(formatdatetime('YYYYMM',Table1F02.AsDateTime),3,2))+1,2)+'01'
          else
            Table1F12.AsString := copy(formatdatetime('YYYYMM',Table1F02.AsDateTime),3,4);
        end
       else
         Table1F12.AsString := copy(formatdatetime('YYYYMM',Table1F02.AsDateTime),3,4);
     end;
 end;
end;

procedure TFM_2160.Table1AfterCancel(DataSet: TDataSet);
begin
  inherited;
  DBDateEdit1.Enabled := False;
  DBComboBox2.Enabled := False;
end;

procedure TFM_2160.SB3Click(Sender: TObject);
begin
  inherited;
  Search_MasterDetailex(table1,[0,1,1,2,11,12],table2,[3,4,5],[0,11],[3,4,6,5,20,7],['T1010','T1080'],['F01','AutoNo'],['F03','F01,F02,F03,F04,F05'],['�ͻ����','�ͺ�,Ʒ��,����,���,�Ŀ�'],['M.F03','D.F02'],'');

end;

procedure TFM_2160.Table2F20Change(Sender: TField);
begin
  inherited;
  lNeedCalWeigh := false;
  if lNeedCalQty  then
  Try
     Table2F03.AsFloat := DealFractional(table2F20.AsFloat/table2lkf07.AsFloat,2);
  Except
     Table2F03.AsFloat := 0;
  end;
  lNeedCalWeigh := true;
end;

procedure TFM_2160.Table2F03Change(Sender: TField);
begin
  inherited;
  lNeedCalQty := false;
  if lNeedCalWeigh  then
  Try
     Table2F20.AsFloat := DealFractional(table2F03.AsFloat * table2lkf07.AsFloat,2);
  Except
     Table2F20.AsFloat := 0;
  end;
  lNeedCalQty := true;
end;

procedure TFM_2160.Table1BeforeInsert(DataSet: TDataSet);
begin
  inherited;
   IfDo('����',Qry1,GlobalUser,Hint,'F02');
end;

procedure TFM_2160.Table1BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if IfEdit = '0' then
     IfDo('�޸�',Qry1,GlobalUser,Hint,'F04');
     IfEdit :='0';
end;

procedure TFM_2160.Table1BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  IfDo('ɾ��',Qry1,GlobalUser,Hint,'F03');
end;

procedure TFM_2160.Table2BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  IfDo('ɾ��',Qry1,GlobalUser,Hint,'F03');
end;

procedure TFM_2160.Table2BeforeEdit(DataSet: TDataSet);
begin
  inherited;

     IfDo('�޸�',Qry1,GlobalUser,Hint,'F04');

end;

procedure TFM_2160.Table2BeforeInsert(DataSet: TDataSet);
begin
  inherited;
   IfDo('����',Qry1,GlobalUser,Hint,'F02');
end;

procedure TFM_2160.FormCreate(Sender: TObject);
begin
  inherited;
  QryExec(Qry1,'select F06 from TUserRight where K_SN =''����'' and NM='''+GlobalUser+'''');
   if Qry1.Fields[0].AsBoolean then
   begin
     DBGrid1.Columns[9].Visible := true;
     DBGrid1.Columns[12].Visible := True;
     DBEdit6.Visible := True;
     DBEdit7.Visible := True;
     DBEdit9.Visible := True;
   end
   else
   begin
     DBGrid1.Columns[9].Visible := false;
     DBGrid1.Columns[12].Visible := false;
     DBEdit6.Visible := false;
     DBEdit7.Visible := false;
     DBEdit9.Visible := false;
   end;
end;

end.
