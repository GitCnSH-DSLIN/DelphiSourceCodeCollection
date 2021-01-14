unit Untps_query;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fm_Base, DB, Grids, DBGrids, StdCtrls, ExtCtrls, Buttons, Menus,
  FR_PTabl, FR_View, DBClient;
  /////////////////////// �������ݼ���
type Tsendrequirement =record  //����
  codes:string;
  copy_date:string;
  part:string;
  storage:string;
  shop:string;
  Transactor:string;
  Condense:string;
  R_Remark:string;
end;
/////////////
////////////////////////////
type
  Tfmps_query = class(TfmBase)
    Panel1: TPanel;
    Label1: TLabel;
    dsps_query: TDataSource;
    Label2: TLabel;
    cmbtop: TComboBox;
    PopupMenu1: TPopupMenu;
    nbatch: TMenuItem;
    Ngoods: TMenuItem;
    cdsmasterdata: TClientDataSet;
    cdsdetaildata: TClientDataSet;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Panel3: TPanel;
    btnauto: TBitBtn;
    btnprint: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    btnpagedown: TBitBtn;
    BitBtn7: TBitBtn;
    procedure BitBtn7Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnpagedownClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnautoClick(Sender: TObject);
    procedure btnautoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure nbatchClick(Sender: TObject);
    procedure NgoodsClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid2TitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    senddata:tsendrequirement;
    managerid:string;//���Ͳֿ�
    flag,LocalCount:integer;
  public
    { Public declarations }
    tj:string;
    tempsql,tables:string;
    buttonflag:integer;//��ѯģʽ;
  end;

var
  fmps_query: Tfmps_query;

implementation

uses untdatadm, func, Untdlgselect, Data, fm_SetColumn;

{$R *.dfm}

procedure Tfmps_query.BitBtn7Click(Sender: TObject);
begin
  inherited;
  close;
end;

procedure Tfmps_query.FormShow(Sender: TObject);
var
  sql:widestring;
begin
  inherited;
  dbgCur:=dbgrid1;
  flag:=0;
  tempsql:='select top 1000';
  tables:=' * from Vgetgoodsplan';
  dmmain.CDSquery.Close;
  dmmain.CDSquery.Data:=null;
  cmbtop.ItemIndex:=0;
  sql:='select managerid from STOCK_Manager where storageid='+''''+trim(shopid)+'''';
  dmmain.CDSexecsql.Close;
  dmmain.CDSexecsql.Data:=null;
  try
  dmmain.CDSexecsql.Data:=adisp.execSql(sql);
  dmmain.CDSexecsql.Open;
  if not dmmain.CDSexecsql.IsEmpty then
  begin
    managerid:=trim(dmmain.CDSexecsql.fieldbyname('managerid').AsString );
    nbatch.Enabled:=false;  //���͵��˵�Ϊ��
    ngoods.Enabled:=true; // ��Ʒ����Ϊ��
  end;
  except
    application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
    exit;
  end;
  btnauto.Enabled:=true;
end;

procedure Tfmps_query.btnpagedownClick(Sender: TObject);
var
  temp:widestring;
  datas:oleVariant;
begin
  inherited;
  datas:=null;
  if not dmmain.cDSquery.Active then exit;

    screen.Cursor := crhourglass;
   //�ص���DBGRID �Ļ���
   dmmain.cdsquery.DisableControls;
   if buttonflag=1 then
   begin
     temp:=tempsql+tables+tj+' and id>'+inttostr(localcount);
   end else
   begin
    temp:=tempsql+tables+tj+' and id>'+inttostr(localcount);
   end;
  dmmain.CDSquery.Close;
  try
  datas:=adisp.GetRecord(temp);
  except
    application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
    exit;
  end;
  if not varisnull(datas) then
  begin
  dmmain.CDSquery.Open;
  dmmain.CDSquery.AppendData(datas,true);
  dmmain.cdsquery.Last;
  dmmain.cdsquery.EnableControls;
  //�õ��˴β�ѯ�ļ�ֵ
  try
  LocalCount := GetKeyFieldValue('id',dmmain.cdsquery);   //��������ֶ�
  except
  end;
  end else
  begin
     //����������
      dmmain.cdsquery.EnableControls;        //ydy  ����Ҫ
     btnpagedown.Enabled := false;
     screen.Cursor :=  crdefault;
    exit;
  end;
    dmmain.cdsquery.EnableControls;
    dbgrid1.Refresh;
screen.Cursor :=  crdefault;
datas:=null;
end;

procedure Tfmps_query.BitBtn3Click(Sender: TObject);
var
  temp:widestring;
  datas:olevariant;
begin
  inherited;
  dbgCur:=dbgrid2;
  dmmain.CDSquery.EnableConstraints;
  buttonflag:=1;
  screen.Cursor :=  crHourGlass;
  dbgrid1.Visible:=false;
  dbgrid2.Visible :=true;
  dbgCur:=dbgrid2;
  tj:='';
  tables:=' * from VPSSQ where 1=1 and storage_no='+''''+trim(shopid)+'''';
  temp:=tempsql+tables;//'select top 100 * from VPSSQ where 1=1 and storage_no='+''''+trim(shopid)+'''';//
  dmmain.CDSquery.Close;
  dmmain.CDSquery.Data:=null;
  dmmain.CDSquery.IndexName:='';
  dmmain.CDSquery.IndexDefs.Clear;
   datas:=null;
  try
    datas:=adisp.GetRecord(temp);
    if not varisnull(datas) then
    begin
      dmmain.CDSquery.Data:=datas;
      dmmain.CDSquery.Open;
      datas:=null;
    end else
    begin
      application.MessageBox('û���ŵ��������Ʒ���ݣ�',pchar(application.Title),mb_iconinformation);
      screen.Cursor :=  crdefault;
      exit;
    end;
  except
    application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
    exit;
  end;
  dmmain.CDSquery.Last;
  try
  LocalCount := GetKeyFieldValue('id',dmmain.cdsquery);   //��������ֶ�
  except
  end;
  dbgrid2.Refresh;
  screen.Cursor :=  crdefault;
end;

procedure Tfmps_query.BitBtn4Click(Sender: TObject);
var
  temp:widestring;
  datas:olevariant;
begin
  inherited;
  dbgCur:=dbgrid1;
  buttonflag:=0;
  screen.Cursor :=  crHourGlass;
  dbgrid1.Visible:=true;
  dbgrid2.Visible :=false;
  tj:=' and storage_no='+''''+trim(shopid)+'''';
  dbgCur:=dbgrid1;
  tables:=' id,VCOfficeID,goods_no,goods_name,stock_amount,NQty, NSendQty, totalamount,saleamount from [vpssq] where 1=1 ';//+tj+' group by VCOfficeID,goods_no,goods_name,stock_amount,NQty, NSendQty, totalamount,id';
  temp:=tempsql+tables+tj+' group by VCOfficeID,goods_no,goods_name,stock_amount,NQty, NSendQty, totalamount,id,saleamount';
  dmmain.CDSquery.Close;
  dmmain.CDSquery.Data:=null;
  dmmain.CDSquery.IndexName:='';
  dmmain.CDSquery.IndexDefs.Clear;
  datas:=null;
  try
    datas:=adisp.GetRecord(temp);
    if not varisnull(datas) then
    begin
      dmmain.CDSquery.Data:=datas;
      dmmain.CDSquery.Open;
      datas:=null;
    end else
    begin
      application.MessageBox('û���ŵ��������Ʒ���ݣ�',pchar(application.Title),mb_iconinformation);
      screen.Cursor :=  crdefault;
      exit;
    end;
  except
    application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
    exit;
  end;
  dmmain.CDSquery.Last;
  LocalCount := GetKeyFieldValue('id',dmmain.cdsquery);   //��������ֶ�
  screen.Cursor :=  crdefault;
end;

procedure Tfmps_query.BitBtn1Click(Sender: TObject);
begin
  inherited;
  dlgps_select:=tdlgps_select.Create(self);
  dlgps_select.ShowModal;
  dlgps_select.Free;
end;

procedure Tfmps_query.btnautoClick(Sender: TObject);
var
 p:Tpoint;
begin
  inherited;
  GetCursorPos(P);
  btnautoMouseDown(sender,mbLeft,[ssLeft],p.x,p.Y);
end;

procedure Tfmps_query.btnautoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 p:Tpoint;
begin
  inherited;
  GetCursorPos(P);
  PopupMenu1.Popup(p.x,p.y);
end;

procedure Tfmps_query.nbatchClick(Sender: TObject);
var
   x,i:integer;
   BookmarkList: TBookmarkList;
   TempBookmark: TBookmark;
   temp,make:string;
   Fb,Scomp:boolean;
   GoodsNO,GoodsMoney:tstringlist;
begin
  inherited;
  ///д��Ʒ�����;
  if dmmain.CDSquery.IsEmpty then
  begin
    Application.MessageBox('û����Ʒ��',pchar(application.Title),mb_iconinformation);
    exit;
  end;
  try
    fb:=false;
   dmmain.CDSquery.DisableControls;  //
   temp:='select max(right(stock_no,4)) from goods_requirement where copy_date='+''''+formatdatetime('yyyy''-''mm''-''dd',date)+''''+' and part_no='+''''+trim(Handle_Part)+'''';
   make:='SQ-'+trim(Handle_Part);   //5-11 �������ò��ű��
   senddata.codes:=setcode(temp,make);
   senddata.copy_date:=formatdatetime('yyyy''-''mm''-''dd',date);
   senddata.part:=trim(Handle_Part);
   senddata.Transactor:=trim(Handle_Man);
   senddata.storage:=trim(shopid);
   senddata.Condense:='����:'+trim(Handle_Part)+'����������Ʒ�����������Ʒ��������Ʒ����';
   senddata.R_Remark:='�ӵ���������Ʒ�����������Ʒ��������Ʒ����';
   senddata.shop:=trim(shopid);
  dmmain.cdsGoods_Requirement.Close;
  dmmain.cdsGoods_Requirement.Open;
  dmmain.cdsGoods_Requirement.Append;
  dmmain.cdsGoods_Requirement.FieldByName('Copy_Date').AsString:=senddata.copy_date; //¼������
  dmmain.cdsGoods_Requirement.FieldByName('Stock_NO').AsString:=senddata.codes;  //���ݱ��
  dmmain.cdsGoods_Requirement.FieldByName('Storage_NO').AsString:=senddata.storage;     //�ֿ���
  dmmain.cdsGoods_Requirement.FieldByName('Shop_NO').AsString:=senddata.shop;        //��������
  dmmain.cdsGoods_Requirement.FieldByName('Transactor').AsString:=senddata.Transactor;     //������
  dmmain.cdsGoods_Requirement.FieldByName('Proposer').AsString:=senddata.Transactor;      //�Ƶ���
  dmmain.cdsGoods_Requirement.FieldByName('Condense').AsString:=senddata.Condense;       //ժҪ
  dmmain.cdsGoods_Requirement.FieldByName('R_Remark').AsString:=senddata.R_Remark;       //˵��
  dmmain.cdsGoods_Requirement.FieldByName('Part_no').AsString:=Handle_Part; //���ű��
  dmmain.cdsGoods_Requirement.Post;
  /////�ݸ�
  dmmain.cdsReceipt.Close;
  dmmain.cdsReceipt.Open;
  dmmain.cdsReceipt.Append;
  dmmain.cdsReceipt.FieldByName('Receipt_NO').AsString:=senddata.codes;
  dmmain.cdsReceipt.FieldByName('Receipt_Name').AsString:='��Ʒ����';
  dmmain.cdsReceipt.FieldByName('Copy_Date').AsString:=senddata.copy_date;
  dmmain.cdsReceipt.FieldByName('Proposer').AsString:=senddata.Transactor;
  dmmain.cdsReceipt.FieldByName('Condense').AsString:=senddata.Condense;
  dmmain.cdsReceipt.FieldByName('Check_Result').Asinteger:=0;
  dmmain.cdsReceipt.FieldByName('Flag_Sign').AsString:='�ݸ�';
  dmmain.cdsReceipt.FieldByName('Re_Part').AsString:=Handle_Part;
  dmmain.cdsReceipt.Post;
  /////////////��ϸ
  dmmain.cdsGoods_Requirement_Detail.Close;
  dmmain.cdsGoods_Requirement_Detail.Open;
  //////////////////////
  //dmmain.cdsquery.DisableControls;
  dmmain.CDSquery.First;
  GoodsNO:=tstringlist.Create;
  GoodsMoney:=tstringlist.Create;
  scomp:=false;
  for x:=0 to dmmain.CDSquery.RecordCount-1 do
  begin
    if (dmmain.cdsquery.FieldByName('saleamount').AsFloat< dmmain.cdsquery.FieldByName('totalamount').AsFloat)  then
    begin
      scomp:=false;
      IF GOODSMONEY.Count=0 THEN
      BEGIN
        GoodsNO.Add(trim(dmmain.CDSquery.Fieldbyname('Goods_NO').AsString));
        GOODSMONEY.Add(floattostr(dmmain.cdsquery.FieldByName('totalamount').AsFloat-dmmain.CDSquery.Fieldbyname('stock_amount').AsFloat));
      END ELSE
      BEGIN
        FOR I:=0 TO GOODSNO.Count-1 DO
        BEGIN
          if trim(Goodsno.Strings[i])=trim(dmmain.CDSquery.Fieldbyname('Goods_NO').AsString) then
          begin
            scomp:=true;
            GOODSMONEY.Strings[i] :=floattostr(strtoint(goodsmoney.Strings[i])+dmmain.cdsquery.FieldByName('totalamount').AsFloat);

          END;
        END;
        if not scomp then
        begin
          GoodsNO.Add(trim(dmmain.CDSquery.Fieldbyname('Goods_NO').AsString));
          GOODSMONEY.Add(floattostr(dmmain.cdsquery.FieldByName('totalamount').AsFloat-dmmain.CDSquery.Fieldbyname('stock_amount').AsFloat));
        end;
      END;
    END;
    dmmain.CDSquery.Next;
 end;
 FOR I:=0 TO GOODSNO.Count-1 DO
 BEGIN
   dmmain.cdsGoods_Requirement_Detail.Append;
    dmmain.cdsGoods_Requirement_Detail.FieldByName('Stock_NO').AsString:=senddata.codes; //���ݱ��
    dmmain.cdsGoods_Requirement_Detail.FieldByName('Goods_NO').AsString:=trim(gOODSno.Strings[i]);  //��Ʒ���
    dmmain.cdsGoods_Requirement_Detail.FieldByName('R_Amount').AsString:=Goodsmoney.Strings[i];  //��������
    dmmain.cdsGoods_Requirement_Detail.FieldByName('Remark').AsString:=trim('����������Ʒ����');    //����˵��
    dmmain.cdsGoods_Requirement_Detail.Post;
    fb:=true;
 END;
 try
   if fb then
   begin
     dmmain.cdsReceipt.ApplyUpdates(-1);
     dmmain.cdsGoods_Requirement.ApplyUpdates(-1);
     dmmain.cdsGoods_Requirement_Detail.ApplyUpdates(-1);
     application.MessageBox(pchar('ȱ�������п��������������������Ʒ��������[��Ʒ����]����ҵ��ݸ�鿴��'),pchar(application.Title),mb_iconwarning);
     dmmain.cdsquery.EnableControls;
     exit;
   end else
   begin
     dmmain.cdsReceipt.Cancel;
     dmmain.cdsGoods_Requirement.Cancel;
     dmmain.cdsGoods_Requirement_Detail.Cancel;
   end;
   dmmain.cdsquery.EnableControls;
   dbgrid2.Refresh;
   goodsno.Free;
   goodsno:=nil;
   goodsmoney.Free;
   goodsmoney:=nil;
 except
 end;
 except
  application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
  exit;
 end;

end;

procedure Tfmps_query.NgoodsClick(Sender: TObject);
var
  temp,make,billno:string;
  mdata,Ddata:olevariant;//����������
 x,iEditMode,PsRst,i:integer;
 BookmarkList: TBookmarkList;
 TempBookmark: TBookmark;
 fb,Scomp:boolean;
   GoodsNO,GoodsMoney,GoodsType:tstringlist;
begin
  inherited;
  try
  fb:=false;
  temp:= 'Select * from GetGoodsPlanMaster where 1=2';
  CdsMasterData.Data:=adisp.PubBatch(temp);
  CdsMasterData.Open;
  temp:='Select * from GetGoodsPlan where 1=2';
  CdsDetailData.Close;
  CdsDetailData.Data:=null;
  CdsDetailData.Data:=adisp.PubBatch(temp);
  CdsDetailData.Open;
  except
    application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
    exit;
  end;
  if dmmain.CDSquery.IsEmpty then
  begin
    Application.MessageBox('û����Ʒ��',pchar(application.Title),mb_iconinformation);
    exit;
  end;
  try
    temp:='select max(right(VcBillNo,4)) from GetGoodsPlanMaster where DGetDate='+''''+formatdatetime('yyyy''-''mm''-''dd',date)+''''+' and VCOfficeID='+''''+trim(Handle_Part)+'''';
    make:='PSQ-'+trim(Handle_Part)+trim(handle_no); //�����в��ű��
    billno:=setcode(temp,make);
    dmmain.CDSquery.First;
    with CdsMasterData do
    begin
     EmptyDataSet;
     Append;
     FieldByName('VcGetGoodsPlanID').AsString :='';
     FieldByName('VcBillNo').AsString :=trim(BillNo);
     FieldByName('VCOfficeID').AsString :=trim(Handle_Part);
     FieldByName('iBilltype').asinteger := 501;
     FieldByName('VcStockID').AsString := trim(managerid);
     FieldByName('DGetDate').asDateTime := date;
     FieldByName('VcEID').AsString := Handle_Man;
     FieldByName('vcCheckE').AsString := Handle_Man;
     FieldByName('Memo').AsString := '�ֿ� '+trim(shopid)+' ��治���������������͵�';
     FieldByName('IPlanStatus').Asinteger := 0;
   end;

   with CdsDetailData do
   begin
     EmptyDataSet;
      dmmain.cdsquery.DisableControls;
      GoodsNO:=tstringlist.Create;
      GoodsMoney:=tstringlist.Create;
      Goodstype:=tstringlist.Create;
      for x:=0 to dmmain.CDSquery.RecordCount-1 do
      begin
        if (dmmain.cdsquery.FieldByName('saleamount').AsFloat< dmmain.cdsquery.FieldByName('totalamount').AsFloat)  then
        begin
          scomp:=false;
          IF GOODSMONEY.Count=0 THEN
          BEGIN
            GoodsNO.Add(trim(dmmain.CDSquery.Fieldbyname('Goods_NO').AsString));
            Goodstype.Add(Trim(dmmain.CDSquery.Fieldbyname('Norms_Type').AsString));
            GOODSMONEY.Add(floattostr(dmmain.cdsquery.FieldByName('totalamount').AsFloat-dmmain.CDSquery.Fieldbyname('stock_amount').AsFloat));
          END ELSE
          BEGIN
            FOR I:=0 TO GOODSNO.Count-1 DO
            BEGIN
              if trim(Goodsno.Strings[i])=trim(dmmain.CDSquery.Fieldbyname('Goods_NO').AsString) then
              begin
                scomp:=true;
                GOODSMONEY.Strings[i] :=floattostr(strtoint(goodsmoney.Strings[i])+dmmain.cdsquery.FieldByName('totalamount').AsFloat);

              END;
            END;
            if not scomp then
            begin
              GoodsNO.Add(trim(dmmain.CDSquery.Fieldbyname('Goods_NO').AsString));
              Goodstype.Add(Trim(dmmain.CDSquery.Fieldbyname('norms_type').AsString));
              GOODSMONEY.Add(floattostr(dmmain.cdsquery.FieldByName('totalamount').AsFloat-dmmain.CDSquery.Fieldbyname('stock_amount').AsFloat));
            end;
          END;
        end;
        dmmain.CDSquery.Next;
      end;
      for i:=0 to goodsno.Count-1 do
      begin
        Append;
        FieldByName('VcGetGoodsPlanID').AsString := '';
        FieldByName('ord').asInteger := x;
        FieldByName('VCPtyieID').AsString := Trim(Goodsno.Strings[i]); //��Ʒ���
        FieldByName('vcGoodUnitId').AsString := Trim(GoodsType.Strings[i]);
        FieldByName('NQty').asFloat :=strtofloat(goodsmoney.Strings[i]) ;
        FieldByName('NSendQty').asFloat := 0;
        FieldByName('NEndQty').asFloat := 0;
        FieldByName('IGetStatus').asFloat := 0;
        FieldByName('iUnit').asFloat := 0;
        FieldByName('NRate').asFloat := 0;
        fb:=true;
      end;
      goodsno.Free;
      goodsno:=nil;
      goodsmoney.Free;
      goodsmoney:=nil;
      goodstype.Free;
      goodstype:=nil;
      dmmain.cdsquery.EnableControls;
    end;
    PsRst := CdsDetailData.RecordCount;
     mdata:= CdsMasterData.Data;
     Ddata:=CdsDetailData.Data;
     if fb then
     adisp.InsertGetPlan(mdata,dData,iEditMode, PsRst);

    if PsRst <> 0 then
    begin
      application.MessageBox('����ʧ�ܣ�',pchar(application.Title),mb_iconwarning);
      exit;
    end else
    begin
      application.MessageBox('��ȱ�������Զ�����[�������뵥]��',pchar(application.Title),mb_iconinformation);
      exit;
    end;
  except
     application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
     exit;
  end;

end;

procedure Tfmps_query.DBGrid1TitleClick(Column: TColumn);
begin
  inherited;
  if (not dbgrid1.DataSource.DataSet.Active ) then exit;
  if trim(column.Field.AsString)='' then exit;
  sortgrid(column.Field.FieldName,dmmain.CDSquery,dbgrid1,column);
end;

procedure Tfmps_query.DBGrid2TitleClick(Column: TColumn);
begin
  inherited;
  if (not dbgrid2.DataSource.DataSet.Active ) then exit;
  if trim(column.Field.AsString)='' then exit;
  sortgrid(column.Field.FieldName,dmmain.CDSquery,dbgrid2,column);
end;

procedure Tfmps_query.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmmain.CDSquery.Data:=null;
  DMMAIN.CDSquery.Close;
  inherited;

end;

procedure Tfmps_query.BitBtn2Click(Sender: TObject);
begin
  inherited;
   with TfmSetColumn.Create(Self) do
  try
    showmodal;
  finally
    free;
  end;
end;

end.
