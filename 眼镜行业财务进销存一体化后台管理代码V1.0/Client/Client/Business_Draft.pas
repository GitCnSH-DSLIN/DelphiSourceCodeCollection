unit Business_Draft;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, Buttons, ExtCtrls;

type
  Tfrm_Business_Draft = class(TForm)
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox2: TComboBox;
    dsquery: TDataSource;
    Panel1: TPanel;
    BitBtn5: TBitBtn;
    BtnDelete: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
    procedure settitle;    //�����������
    function DeleteStock(No:string):boolean;
  public
    { Public declarations }
  end;

var
  frm_Business_Draft: Tfrm_Business_Draft;

implementation

uses Stock_Contract, Data, func, Stock_Enter, Stock_Fad, Stock_Pay,
  Goods_Write, Quality_Check, Umanage_Fad,
 untdatadm, Umoneystock, fm_Scrap, fm_Overflow,
  Uinstock, Goods_Requirement, Uflat, Untnewshopgoods,
  UntZsManager, UUnPos, w_more, UYdPosBill, UntPosSendBill, UStock_cancel,
  UUnfinance;

{$R *.dfm}

procedure Tfrm_business_Draft.settitle;     //�����������
begin
    DBGrid1.Columns[0].Width:=80;   DBGrid1.Columns[1].Width:=100;    DBGrid1.Columns[2].Width:=200;
    DBGrid1.Columns[3].Width:=80;   DBGrid1.Columns[4].Width:=60;    DBGrid1.Columns[5].Width:=100;
    DBGrid1.Columns[6].Width:=60;    DBGrid1.Columns[7].Width:=100;
    DBGrid1.Columns[8].Width:=100;  DBGrid1.Columns[9].Width:=100;   DBGrid1.Columns[10].Width:=100;
end;

function Tfrm_Business_Draft.DeleteStock(No:string):boolean;
var
  sql:widestring;
begin
  result:=false;
  sql:='delete from receipt where receipt_no='+''''+trim(no)+''''; //ɾ���ݸ壡����
  try
    adisp.updatesql(sql); 
    result:=true;
  except
  end;
end;
//////////////////
procedure Tfrm_Business_Draft.FormShow(Sender: TObject);
var
  subsql:widestring;
  olevalue:olevariant;
begin   // wy edit 3-14
    ComboBox1.ItemIndex:=0;
    ComboBox2.ItemIndex:=0;
    subsql:='Select Copy_Date,Receipt_Name,Receipt_No,Condense,Proposer,Level_Count,Level_Name1,E1,E2,E3,E4,E5,check_result as ��˼��� from '+
    '[V_Stock_Level]'+
    ' where Check_Result<=5 and Flag_sign='+''''+'�ݸ�'+''''+' and ( Examine_Man1 like '+''''+trim('%'+Handle_No+'%')+''''+' or Examine_Man2 like '+''''+trim('%'+Handle_No+'%')+''''+' or Examine_Man3 like '+''''+trim('%'+Handle_No+'%')+''''+' or Examine_Man4 like'+''''+trim('%'+Handle_No+'%')+''''+' or Examine_Man5 like '+''''+trim('%'+Handle_No+'%')+''''
    +') and  (e1 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e1 is null) and (e2 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e2 is null) and (e3 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e3 is null) and (e4 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e4 is null )and (e5 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e5 is null) and re_part='+''''+trim(Handle_part)+'''';
    dmmain.CDSquery.Close;
    dmmain.CDSquery.Data:=null;
    olevalue:=adisp.GetRecord(subsql);
    if not varisnull(olevalue) then  //wg edit 3-14
    begin
      dmmain.CDSquery.Data:=olevalue;
      dmmain.CDSquery.Open;
      olevalue:=null;
      DBGrid1.Enabled:=True;
      settitle;    //�����������
      dbgrid1.Refresh;
   end;
end;

procedure Tfrm_Business_Draft.DBGrid1DblClick(Sender: TObject);
begin
    //����ݸ嵥�ݵ�������Ϊ����
    if not (dmmain.CDSquery.Active) then  exit;
    DBGRID1.DataSource.DataSet.DisableControls;
    if (dmmain.CDSquery.FieldByName('��˼���').AsString='6') then
    begin
      application.MessageBox('�����ѹ��ʣ����ܲ�����',pchar(application.Title),mb_iconinformation);
      exit;
    end;
    List_No:=trim(dmmain.CDSquery.Fieldbyname('Receipt_No').AsString);//���ݱ��
    LevelType:=trim(dmmain.CDSquery.Fieldbyname('Receipt_Name').AsString);//��������
    if Trim(LevelType)<>'' then
    begin
        Public_Do:='';
        if LevelType='��Ʒ����' then //��������
        begin
            Public_Do:='Requirement_0001';//��Ʒ����
            frm_Goods_Requirement:=Tfrm_Goods_Requirement.Create(self);
            frm_Goods_Requirement.ShowModal;
            frm_Goods_Requirement.Free;
        end;
        if LevelType='�ɹ���ͬ' then //��������
        begin
            Public_Do:='Business_Draft_0002';//�ɹ���ͬ
            frm_Stock_Contract:=Tfrm_Stock_Contract.Create(self);
            frm_Stock_Contract.ShowModal;
            frm_Stock_Contract.Free;
        end;
        if LevelType='�ɹ���ⵥ' then //��������
        begin
            Public_Do:='Business_Draft_0001';// �ɹ���ⵥ
            frm_Stock_Enter:=Tfrm_Stock_Enter.Create(self);
            frm_Stock_Enter.ShowModal;
            frm_Stock_Enter.Free;
        end;
        if LevelType='�ɹ��˻���' then //��������
        begin
            Public_Do:='Business_Draft_0003';// �ɹ��˻���
            frm_Stock_Fad:=Tfrm_Stock_Fad.Create(self);
            frm_Stock_Fad.ShowModal;
            frm_Stock_Fad.Free;
        end;
        if LevelType='�ɹ����' then //��������
        begin
            Public_Do:='Business_Draft_0004';// �ɹ����
            frm_Stock_Pay:=Tfrm_Stock_Pay.Create(self);
            frm_Stock_Pay.SpeedButton6.Enabled:=false;
            frm_Stock_Pay.SpeedButton9.Enabled:=false;
            frm_Stock_Pay.ShowModal;
            frm_Stock_Pay.Free;
        end;
        if LevelType='�����Ǽǵ�' then //��������
        begin
            Public_Do:='Business_Draft_0005';// �����Ǽǵ�
            frm_Goods_Write:=Tfrm_Goods_Write.Create(self);
            frm_Goods_Write.ShowModal;
            frm_Goods_Write.Free;
        end;
        if LevelType='�������յ�' then //��������
        begin
            Public_Do:='Business_Draft_0006';// �������յ�
            Public_Do_Result:='';
            frm_Quality_Check:=Tfrm_Quality_Check.Create(self);
            frm_Quality_Check.ShowModal;
            frm_Quality_Check.Free;
        end;
        if LevelType='��汨��' then //��������
        begin
            Public_Do:='damage_0002';// ��汨��
            Public_Do_Result:='';
             fmscrap:=tfmscrap.Create(self);
            fmscrap.ShowModal;
            fmscrap.Free;
        end;
        if LevelType='��Ӫҵ�Գ��ⵥ' then //��������
        begin
            Public_Do:='Business_Storage_Out';// ���ⵥ
            Public_Do_Result:='';
            frm_Umanage_Fad:=Tfrm_Umanage_Fad.Create(self);
            frm_Umanage_Fad.ShowModal;
            frm_Umanage_Fad.Free;
        end;
        if LevelType='������ⵥ' then //��������
        begin
          Public_Do:='Business_money';// ͬ�۵�����
          Public_Do_Result:='';
          frmmoneystock:=tfrmmoneystock.Create(self);
          frmmoneystock.ShowModal;
          frmmoneystock.Free;
        end;
        if LevelType='��汨�絥' then //��������
        begin
            Public_Do:='stock_outed';// ���д�����ⵥ
            Public_Do_Result:='';
           fmOverflow:=tfmOverflow.Create(self);
            fmOverflow.ShowModal;
            fmOverflow.Free;
        end;
        if LevelType='��Ӫҵ����ⵥ' then //��������
        begin
            Public_Do:='Business_Storage_in';// ���д�����ⵥ
            Public_Do_Result:='';
             frmin_stock:=Tfrmin_stock.Create(self);
           frmin_stock.ShowModal;
           frmin_stock.Free;
        end;
        if LevelType='�ײͶ���' then //��������
        begin
          Public_Do:='flatedit';// ���д�����ⵥ
          Public_Do_Result:='';
          fmflat:=Tfmflat.Create(self);
          fmflat.ShowModal;
          fmflat.Free;
        end;
       if LevelType='���͵�' then //��������
        begin
          ShowFmPosSendbill('1','1',503);//���͵���
        end;
        if LevelType='Ԥ����Ʒ���͵�' then //��������
        begin
          ShowYDPosSendbill('1','1',503)//Ԥ������//Ԥ����Ʒ���͵���
        end;
        if LevelType='�����˻���' then //��������
        begin
          ShowUNPosSendbill('1','1',505);//�����˻�����
        end;
        if LevelType='�µ��̻�' then //��������
        begin
          Public_Do:='edited';// ���д�����ⵥ
          Public_Do_Result:='';
          fmshopgoods:=tfmshopgoods.Create(self);
          fmshopgoods.ShowModal;
          fmshopgoods.Free;
        end;
        if LevelType='��Ʒ���嵥' then //��������
        begin
          Public_Do:='edited';// ���д�����ⵥ
          Public_Do_Result:='';
          fmZSmanager:=tfmZSmanager.Create(self);
          fmZSmanager.ShowModal;
          fmZSmanager.Free;
        end;
        if LevelType='�ֽ���õ�' then //��������
        begin
          Public_Do:='';// ���д�����ⵥ
          Public_Do_Result:='';
          w_skBill('Edit',trim(dmmain.CDSquery.fieldbyname('receipt_no').asstring),1,false);
        end;
        if LevelType='һ����õ�' then //��������
        begin
          Public_Do:='';// ���д�����ⵥ
          Public_Do_Result:='';
          w_skBill('Edit',trim(dmmain.CDSquery.fieldbyname('receipt_no').asstring),2,false);
        end;
        if LevelType='�������뵥' then //��������
        begin
          Public_Do:='';// ���д�����ⵥ
          Public_Do_Result:='';
          w_skBill('Edit',trim(dmmain.CDSquery.fieldbyname('receipt_no').asstring),3,false);
        end;
        if LevelType='��̯���÷�����' then //��������
        begin
          Public_Do:='';// ���д�����ⵥ
          Public_Do_Result:='';
          w_skBill('Edit',trim(dmmain.CDSquery.fieldbyname('receipt_no').asstring),4,false);
        end;
        if LevelType='��̯����̯����' then //��������
        begin
          Public_Do:='';// ���д�����ⵥ
          Public_Do_Result:='';
          w_skBill('Edit',trim(dmmain.CDSquery.fieldbyname('receipt_no').asstring),5,false);
        end;
        if LevelType='����˻���' then //��������
        begin
          Public_Do:='';// ���д�����ⵥ
          Public_Do:='Edited';
          FmCancel:=tFmCancel.Create(self);
          FmCancel.ShowModal;
          FmCancel.Free;
        end;
        if LevelType='�����˻���' then //��������
        begin
          Public_Do:='';// ���д�����ⵥ
          Public_Do:='Edited';
          fmfinanceUnpos:=tfmfinanceUnpos.Create(self);
          fmfinanceUnpos.ShowModal;
          fmfinanceUnpos.Free;
        end;
        if LevelType='Ӧ��������' then //��������
        begin
          Public_Do:='';// ���д�����ⵥ
          Public_Do_Result:='';
          w_skBill('Edit',trim(dmmain.CDSquery.fieldbyname('receipt_no').asstring),6,false);
        end;
        if LevelType='Ӧ�տ�����' then //��������
        begin
          Public_Do:='';// ���д�����ⵥ
          Public_Do_Result:='';
          w_skBill('Edit',trim(dmmain.CDSquery.fieldbyname('receipt_no').asstring),7,false);
        end;
        if LevelType='Ӧ�������' then //��������
        begin
          Public_Do:='';// ���д�����ⵥ
          Public_Do_Result:='';
          w_skBill('Edit',trim(dmmain.CDSquery.fieldbyname('receipt_no').asstring),8,false);
        end;
        if LevelType='Ӧ�տ����' then //��������
        begin
          Public_Do:='';// ���д�����ⵥ
          Public_Do_Result:='';
          w_skBill('Edit',trim(dmmain.CDSquery.fieldbyname('receipt_no').asstring),9,false);
        end;
    end;
    if Trim(LevelType)='' then   //����ݸ嵥�ݵ�����Ϊ��
    begin
        Exit;
    end;
    try
    dmmain.cdsquery.Refresh;
    DBGRID1.Refresh;
    DBGRID1.DataSource.DataSet.EnableControls;
    except
      DBGRID1.DataSource.DataSet.EnableControls;
    end;
end;

procedure Tfrm_Business_Draft.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dmmain.cdsquery.Close;
  dmmain.cdsquery.Data:=null;
  Action:=cafree;
end;

procedure Tfrm_Business_Draft.ComboBox1Change(Sender: TObject);
var
    tempstr:widestring;
begin
    tempstr:='';
    if Combobox1.ItemIndex=0 then
    begin
        tempstr:='Select Copy_Date,Receipt_Name,Receipt_No,Condense,Proposer,Level_Count,Examine_Man1,Examine_Man2,Examine_Man3,Examine_Man4,Examine_Man5,Level_Name1,Level_Name2,Level_Name3,Level_Name4,Level_Name5,E1,E2,E3,E4,E5,check_result as ��˼��� from'
        +' [V_Stock_Level]'
        +' where Check_Result<>6 and Flag_sign='+''''+trim('�ݸ�')+''''+' and ( Examine_Man1 like '+''''+trim('%'+Handle_No+'%')+''''+' or Examine_Man2 like '+''''+trim('%'+Handle_No+'%')+''''+' or Examine_Man3 like '+''''+trim('%'+Handle_No+'%')+''''+' or Examine_Man4 like'+''''+trim('%'+Handle_No+'%')+''''+' or Examine_Man5 like '+''''+trim('%'+Handle_No+'%')+''''
    +') and  (e1 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e1 is null) and (e2 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e2 is null) and (e3 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e3 is null) and (e4 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e4 is null )and (e5 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e5 is null) and RE_Part='+''''+trim(Handle_part)+'''';
    end;
    dmmain.CDSquery.Data:=null;
    dmmain.CDSquery.Close;
     //wg edit 3-14   begin
    try
    dmmain.CDSquery.Data:=ADISP.getrecord(tempstr);
    except
    end;
    dmmain.CDSquery.Open;
    settitle;   //�����������
    ComboBox2.ItemIndex:=0;
//Receipt_No,Receipt_Name,Level_Count,Condense,Proposer,Examine_Man1,Examine_Man2,Examine_Man3,Examine_Man4,Examine_Man5,Check_Result

end;

procedure Tfrm_Business_Draft.ComboBox2Change(Sender: TObject);
var
    tempstr:widestring;

begin
    tempstr:='';
    if Combobox2.ItemIndex=0 then
    begin
        tempstr:='Select Copy_Date,Receipt_Name,Receipt_No,Condense,Proposer,Level_Count,';
        tempstr:=tempstr+'E1,E2,E3,E4,E5,check_result as ��˼��� from [V_Stock_Level]'+' where  Check_Result<> 6 and Flag_sign=''�ݸ�'''+' and ( Examine_Man1 like '+''''+trim('%'+Handle_No+'%')+''''+' or Examine_Man2 like '+''''+trim('%'+Handle_No+'%')+''''+' or Examine_Man3 like '+''''+trim('%'+Handle_No+'%')+''''+' or Examine_Man4 like'+''''+trim('%'+Handle_No+'%')+''''+' or Examine_Man5 like '+''''+trim('%'+Handle_No+'%')+''''
    +') and  (e1 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e1 is null) and (e2 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e2 is null) and (e3 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e3 is null) and (e4 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e4 is null )and (e5 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e5 is null) and RE_Part='+''''+trim(Handle_part)+'''';
    end
    else
    begin
        tempstr:='Select Copy_Date,Receipt_Name,Receipt_No,Condense,Proposer,Level_Count,';
        tempstr:=tempstr+'E1,E2,E3,E4,E5,check_result as ��˼��� from [V_Stock_Level]'+' where Check_Result<> 6 and Receipt_Name='''+Trim(ComboBox2.Text)+''' and Flag_sign=''�ݸ�'''+' and ( Examine_Man1 like '+''''+trim('%'+Handle_No+'%')+''''+' or Examine_Man2 like '+''''+trim('%'+Handle_No+'%')+''''+' or Examine_Man3 like '+''''+trim('%'+Handle_No+'%')+''''+' or Examine_Man4 like'+''''+trim('%'+Handle_No+'%')+''''+' or Examine_Man5 like '+''''+trim('%'+Handle_No+'%')+''''
    +') and  (e1 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e1 is null) and (e2 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e2 is null) and (e3 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e3 is null) and (e4 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e4 is null )and (e5 not like '+''''+trim('%'+Handle_Man+'%')+''''+' or e5 is null) and RE_Part='+''''+trim(Handle_part)+'''';
    end;
    dmmain.CDSquery.Close;
 //wg edit 3-14   begin
    dmmain.CDSquery.Data:=adisp.getrecord(tempstr);
    dmmain.CDSquery.Open;
    settitle;
   ComboBox1.ItemIndex:=0;
end;


procedure Tfrm_Business_Draft.BitBtn5Click(Sender: TObject);
begin
  close;
end;

procedure Tfrm_Business_Draft.BtnDeleteClick(Sender: TObject);
begin
   if not (dmmain.CDSquery.Active) then  exit;

  if application.MessageBox(pchar('�Ƿ�ȷ��ɾ�����쵥�ݣ�['+trim(dmmain.CDSquery.Fieldbyname('Receipt_No').AsString)+']?'),pchar(application.Title),mb_iconquestion+mb_yesno)=idyes then
  begin
    try
      DBGRID1.DataSource.DataSet.DisableControls;
      DeleteStock(trim(dmmain.CDSquery.Fieldbyname('Receipt_No').AsString));
      dmmain.cdsquery.Refresh;
      DBGRID1.Refresh;
      DBGRID1.DataSource.DataSet.EnableControls;
    except
    end;
  end;
end;

procedure Tfrm_Business_Draft.DBGrid1TitleClick(Column: TColumn);
begin
  if (not dbgrid1.DataSource.DataSet.Active ) then exit;
  if trim(column.Field.AsString)='' then exit;
  sortgrid(column.Field.FieldName,dmmain.CDSquery,dbgrid1,column);
end;

end.
