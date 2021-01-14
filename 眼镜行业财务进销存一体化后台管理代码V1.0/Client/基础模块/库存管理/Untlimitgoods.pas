unit Untlimitgoods;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fm_Base, DB, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, Menus,
  DBClient;
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
  Tfmlimitgoods = class(TfmBase)
    Panel1: TPanel;
    Label1: TLabel;
    LblSort: TLabel;
    ComboBox1: TComboBox;
    edtTime: TEdit;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    btnExit: TBitBtn;
    btnpagedown: TBitBtn;
    BtnSort: TBitBtn;
    BitBtn1: TBitBtn;
    ds_warn_limit: TDataSource;
    edtRecNo: TEdit;
    PopupMenu1: TPopupMenu;
    Ngoods: TMenuItem;
    Nbatch: TMenuItem;
    btnauto: TBitBtn;
    cdsmasterdata: TClientDataSet;
    cdsdetaildata: TClientDataSet;
    procedure btnExitClick(Sender: TObject);
    procedure BtnSortClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnpagedownClick(Sender: TObject);
    procedure btnautoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnautoClick(Sender: TObject);
    procedure NgoodsClick(Sender: TObject);
    procedure NbatchClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    managerid:string;
    senddata:tsendrequirement;
    LocalCount:integer;
    procedure readdata;
  public
    { Public declarations }
    tempsql,tables,tj:string;
    btnmode:integer;
  end;

var
  fmlimitgoods: Tfmlimitgoods;

implementation

uses func, untdatadm,fm_SetColumn, Udlgstock, Data;

{$R *.dfm}
procedure Tfmlimitgoods.readdata;
var
  t_sql:widestring;
  quedata:olevariant;
begin
  dmmain.cdsquery.Close;
  dmmain.cdsquery.Data:=null;
  quedata:=null;
   screen.Cursor := crhourglass;
   //�ص���DBGRID �Ļ���
   dmmain.cdsquery.DisableControls;
   tables:=' * from [Vwaning_limit]'; //����
   tempsql:= 'select top 20 ';
   T_sql := tempsql+tables+tj;
  try
  if dmmain.cdsquery.Active then dmmain.cdsquery.Close;
  dmmain.cdsquery.Data:=null;
  quedata:=adisp.GetRecord(t_sql);
   if not varisnull(quedata) then
    begin
      dmmain.cdsquery.Data:=quedata;
      dmmain.cdsquery.Open;
      quedata:=null;
      ///ydy add
       dmmain.cdsquery.Last;
       edtRecNo.Text := '��ǰ������: '+inttostr(dmmain.cdsquery.recordcount)+'��';

    //���´�
      dmmain.cdsquery.EnableControls;
      dbgrid1.Refresh;
      //�õ��˴β�ѯ�ļ�ֵ
     LocalCount := GetKeyFieldValue('id',dmmain.cdsquery);   //��������ֶ�

    end else
    begin
       //����������
        dmmain.cdsquery.EnableControls;        //ydy  ����Ҫ
       btnpagedown.Enabled := false;
       screen.Cursor :=  crdefault;
      exit;
    end;
  except
    dmmain.cdsquery.EnableControls;
    dbgrid1.Refresh;
  end;
  dbgrid1.Refresh;
  screen.Cursor :=  crdefault;

end;
procedure Tfmlimitgoods.btnExitClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure Tfmlimitgoods.BtnSortClick(Sender: TObject);
begin
  inherited;
  if not DBGrid1.DataSource.DataSet.Active then  exit;
  with TfmSetColumn.Create(Self) do
  try
    showmodal;
  finally
    free;
  end;
end;

procedure Tfmlimitgoods.FormShow(Sender: TObject);
var
  sql:widestring;
begin
  inherited;
  dbgCur:=dbgrid1;
  combobox1.ItemIndex:=0;
  if btnmode=2 then
  begin
    sql:='select managerid from STOCK_Manager where storageid='+''''+trim(shopid)+'''';
    dmmain.CDSexecsql.Close;
    dmmain.CDSexecsql.Data:=null;
    try
    dmmain.CDSexecsql.Data:=adisp.execSql(sql);
    dmmain.CDSexecsql.Open;
    if not dmmain.CDSexecsql.IsEmpty then
    begin
      managerid:=trim(dmmain.CDSexecsql.fieldbyname('managerid').AsString );
      nbatch.Enabled:=true;  //���͵��˵�Ϊ��
      ngoods.Enabled:=false; // ��Ʒ����Ϊ��
    end;
    except

    end;
    btnauto.Enabled:=true;
  end;
  readdata;
end;

procedure Tfmlimitgoods.BitBtn1Click(Sender: TObject);
begin
  inherited;
  dlgstock:=tdlgstock.Create(self);
  dlgstock.showmode:=2;
  dlgstock.ShowModal;
  dlgstock.Free;
end;

procedure Tfmlimitgoods.btnpagedownClick(Sender: TObject);
var
  i:Integer;
  t_sql,str1,strend:wideString;
  quedata:olevariant;
  lStart, lEnd : Integer;
begin
  inherited;
  if not dmmain.cdsquery.Active then exit;

    screen.Cursor := crhourglass;
   dmmain.cdsquery.DisableControls;
    if combobox1.Text = 'ȫ��' then
    begin
      tempsql:='select'
    end else
    begin
      tempsql:='select top ' + trim(ComboBox1.Text);
    end;
    T_sql := tempsql+tables+tj;
    str1 := ' and  id > '+ inttostr(localcount);
    strend := T_sql + str1;
  try
   quedata:=adisp.GetRecord(strend);
    if not varisnull(quedata) then
    begin
     if dmmain.cdsquery.Active then dmmain.cdsquery.Close;
      dmmain.cdsquery.Open;
      dmmain.cdsquery.AppendData(quedata,true);
      quedata:=null;
      ///ydy add
       dmmain.cdsquery.Last;
      dmmain.cdsquery.EnableControls;
      //�õ��˴β�ѯ�ļ�ֵ
      LocalCount := GetKeyFieldValue('id',dmmain.cdsquery);   //��������ֶ�
    edtRecNo.Text := '��ǰ����'+inttostr(dmmain.cdsquery.recordcount) +'��';
    end else
    begin
       //����������
        dmmain.cdsquery.EnableControls;        //ydy  ����Ҫ
       btnpagedown.Enabled := false;
       screen.Cursor :=  crdefault;
      exit;
    end;
  except
    dmmain.cdsquery.EnableControls;
    dbgrid1.Refresh;
  end;
  dbgrid1.Refresh;
  screen.Cursor :=  crdefault;

end;

procedure Tfmlimitgoods.btnautoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 p:Tpoint;
begin
  inherited;
  GetCursorPos(P);
  PopupMenu1.Popup(p.x,p.y);
end;

procedure Tfmlimitgoods.btnautoClick(Sender: TObject);
var
 p:Tpoint;
begin
  inherited;
  GetCursorPos(P);
  btnautoMouseDown(sender,mbLeft,[ssLeft],p.x,p.Y);

end;

procedure Tfmlimitgoods.NgoodsClick(Sender: TObject);
var
   x:integer;
   BookmarkList: TBookmarkList;
   TempBookmark: TBookmark;
   temp,make:string;
begin
  inherited;
  ///д��Ʒ�����;
  if dmmain.CDSquery.IsEmpty then
  begin
    Application.MessageBox('û����Ʒ��',pchar(application.Title),mb_iconinformation);
    exit;
  end;
  try
   DBGrid1.Datasource.Dataset.DisableControls;  //
   temp:='select max(right(stock_no,4)) from goods_requirement where copy_date='+''''+formatdatetime('yyyy''-''mm''-''dd',date)+''''+' and part_no='+''''+trim(Handle_Part)+'''';
   make:='SQ-'+trim(Handle_Part);   //5-11 �������ò��ű��
   senddata.codes:=setcode(temp,make);
   senddata.copy_date:=formatdatetime('yyyy''-''mm''-''dd',date);
   senddata.part:=trim(Handle_Part);
   senddata.Transactor:=trim(Handle_Man);
   senddata.storage:=trim(shopid);
   senddata.Condense:='����:'+trim(Handle_Part)+'���ڿ�����޵���Ʒ��������Ʒ����';
   senddata.R_Remark:='�ӵ��ڿ�����޵���Ʒ��������Ʒ����';
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
  with DBgrid1.SelectedRows do
  if Count > 0 then
  begin
    TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
    for x:= 0 to Count - 1 do
    begin
      if IndexOf(Items[x]) > -1 then
      begin
        DBGrid1.Datasource.Dataset.Bookmark:= Items[x];
  //�õ�ѡ��������
        dmmain.cdsGoods_Requirement_Detail.Append;
        dmmain.cdsGoods_Requirement_Detail.FieldByName('Stock_NO').AsString:=senddata.codes; //���ݱ��
        dmmain.cdsGoods_Requirement_Detail.FieldByName('Goods_NO').AsString:=trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_NO').AsString);  //��Ʒ���
        if DBGrid1.Datasource.Dataset.Fieldbyname('UP_amount').AsFloat>0 then
        begin
          if DBGrid1.Datasource.Dataset.Fieldbyname('overflow').AsFloat<0 then
          begin
            dmmain.cdsGoods_Requirement_Detail.FieldByName('R_Amount').AsString:=floattostr((-DBGrid1.Datasource.Dataset.Fieldbyname('overflow').AsFloat)-1);  //�������� (����)
          end else
          begin
            dmmain.cdsGoods_Requirement_Detail.FieldByName('R_Amount').AsString:=floattostr(DBGrid1.Datasource.Dataset.Fieldbyname('overflow').AsFloat-1);  //�������� (����)
          end;
        end else
        begin
          dmmain.cdsGoods_Requirement_Detail.FieldByName('R_Amount').AsString:=floattostr(1-DBGrid1.Datasource.Dataset.Fieldbyname('enteramount').AsFloat);  //��������(����)
        end;
        dmmain.cdsGoods_Requirement_Detail.FieldByName('Remark').AsString:=trim('���ڿ������');    //����˵��
        dmmain.cdsGoods_Requirement_Detail.Post;
   ///////////////////////////////
     end;
   end;
  DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
  DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
  end else
  begin
    //dmmain.cdsquery.DisableControls;
    dmmain.CDSquery.First;
    for x:=0 to dmmain.CDSquery.RecordCount-1 do
    begin
      dmmain.cdsGoods_Requirement_Detail.Append;
      dmmain.cdsGoods_Requirement_Detail.FieldByName('Stock_NO').AsString:=senddata.codes; //���ݱ��
      dmmain.cdsGoods_Requirement_Detail.FieldByName('Goods_NO').AsString:=trim(dmmain.CDSquery.Fieldbyname('Goods_NO').AsString);  //��Ʒ���
      if dmmain.CDSquery.Fieldbyname('UP_amount').AsFloat>0 then
      begin
        if dmmain.CDSquery.Fieldbyname('overflow').AsFloat<0 then
        begin
          dmmain.cdsGoods_Requirement_Detail.FieldByName('R_Amount').AsString:=floattostr((-dmmain.CDSquery.Fieldbyname('overflow').AsFloat)-1);  //�������� (����)
        end else
        begin
          dmmain.cdsGoods_Requirement_Detail.FieldByName('R_Amount').AsString:=floattostr(dmmain.CDSquery.Fieldbyname('overflow').AsFloat-1);  //�������� (����)
        end;
      end else
      begin
        dmmain.cdsGoods_Requirement_Detail.FieldByName('R_Amount').AsString:=floattostr(1-dmmain.CDSquery.Fieldbyname('enteramount').AsFloat);  //��������(����)
      end;
      dmmain.cdsGoods_Requirement_Detail.FieldByName('Remark').AsString:=trim('���ڿ������');    //����˵��
      dmmain.cdsGoods_Requirement_Detail.Post;
      dmmain.CDSquery.Next;
   end;
   dmmain.cdsquery.EnableControls;
  try
     dmmain.cdsReceipt.ApplyUpdates(-1);
     dmmain.cdsGoods_Requirement.ApplyUpdates(-1);
     dmmain.cdsGoods_Requirement_Detail.ApplyUpdates(-1);
     application.MessageBox('�ӿ�������Զ�����[��Ʒ����]����ҵ��ݸ�鿴��',pchar(application.Title),mb_iconwarning);
     exit;
   except
   end;
 end;  
  except
    application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
    exit;
  end;
end;

procedure Tfmlimitgoods.NbatchClick(Sender: TObject);
var
  temp,make,billno:string;
  mdata,Ddata:olevariant;//����������
 x,iEditMode,PsRst:integer;
 BookmarkList: TBookmarkList;
 TempBookmark: TBookmark;
begin
  inherited;
  try
  temp:= 'Select * from GetGoodsPlanMaster where 1=2';
  CdsMasterData.Close;
  CdsMasterData.Data:=null;
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
     FieldByName('Memo').AsString := '�ֿ� '+trim(shopid)+' ��������������͵�';
     FieldByName('IPlanStatus').Asinteger := 0;
   end;

   with CdsDetailData do
   begin
    EmptyDataSet;
     with DBgrid1.SelectedRows do
     if Count > 0 then
     begin
       TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
       for x:= 0 to Count - 1 do
       begin
         if IndexOf(Items[x]) > -1 then
         begin
          Append;
          FieldByName('VcGetGoodsPlanID').AsString := '';
          FieldByName('ord').asInteger := x;
          FieldByName('VCPtyieID').AsString := Trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_NO').AsString); //��Ʒ���
          FieldByName('vcGoodUnitId').AsString := Trim(DBGrid1.Datasource.Dataset.Fieldbyname('norms_type').AsString);
          if DBGrid1.Datasource.Dataset.Fieldbyname('UP_amount').AsFloat>0 then
          begin
            if DBGrid1.Datasource.Dataset.Fieldbyname('overflow').AsFloat<0 then
            begin
              FieldByName('NQty').AsString:=floattostr((-DBGrid1.Datasource.Dataset.Fieldbyname('overflow').AsFloat)-1);  //�������� (����)
            end else
            begin
              FieldByName('NQty').AsString:=floattostr(DBGrid1.Datasource.Dataset.Fieldbyname('overflow').AsFloat-1);  //�������� (����)
            end;
          end else
          begin
            FieldByName('NQty').AsString:=floattostr(1-DBGrid1.Datasource.Dataset.Fieldbyname('enteramount').AsFloat);  //��������(����)
          end;
          //FieldByName('NQty').asFloat := (1-DBGrid1.Datasource.Dataset.Fieldbyname('enteramount').AsFloat);
          FieldByName('NSendQty').asFloat := 0;
          FieldByName('NEndQty').asFloat := 0;
          FieldByName('IGetStatus').asFloat := 0;
          FieldByName('iUnit').asFloat := 0;
          FieldByName('NRate').asFloat := 0;
        end;
      end;
      DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
      DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
    end else
    begin
      dmmain.cdsquery.DisableControls;
      dmmain.CDSquery.First;
      for x:=0 to dmmain.CDSquery.RecordCount-1 do
      begin
        Append;
        FieldByName('VcGetGoodsPlanID').AsString := '';
        FieldByName('ord').asInteger := x;
        FieldByName('VCPtyieID').AsString := Trim(dmmain.CDSquery.Fieldbyname('Goods_NO').AsString); //��Ʒ���
        FieldByName('vcGoodUnitId').AsString := Trim(dmmain.CDSquery.Fieldbyname('norms_type').AsString);
       if dmmain.CDSquery.Fieldbyname('UP_amount').AsFloat>0 then
        begin
          if dmmain.CDSquery.Fieldbyname('overflow').AsFloat<0 then
          begin
            FieldByName('NQty').AsString:=floattostr((-dmmain.CDSquery.Fieldbyname('overflow').AsFloat)-1);  //�������� (����)
          end else
          begin
            FieldByName('NQty').AsString:=floattostr(dmmain.CDSquery.Fieldbyname('overflow').AsFloat-1);  //�������� (����)
          end;
        end else
        begin
          FieldByName('NQty').AsString:=floattostr(1-dmmain.CDSquery.Fieldbyname('enteramount').AsFloat);  //��������(����)
        end;
        //FieldByName('NQty').asFloat := (1-dmmain.CDSquery.Fieldbyname('enteramount').AsFloat);
        FieldByName('NSendQty').asFloat := 0;
        FieldByName('NEndQty').asFloat := 0;
        FieldByName('IGetStatus').asFloat := 0;
        FieldByName('iUnit').asFloat := 0;
        FieldByName('NRate').asFloat := 0;
        post;
        dmmain.CDSquery.Next;
      end;
      dmmain.cdsquery.EnableControls;
    end;
    PsRst := CdsDetailData.RecordCount;
     mdata:= CdsMasterData.Data;
     Ddata:=CdsDetailData.Data;
     adisp.InsertGetPlan(mdata,dData,iEditMode, PsRst);

    if PsRst <> 0 then
    begin
      application.MessageBox('����ʧ�ܣ�',pchar(application.Title),mb_iconwarning);
      exit;
    end else
    begin
      application.MessageBox('�ӿ�������Զ�����[���͵�]��',pchar(application.Title),mb_iconinformation);
      exit;
    end;
   end;
  except
     application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
     exit;
  end;
end;

procedure Tfmlimitgoods.DBGrid1TitleClick(Column: TColumn);
begin
  inherited;
  if (not dbgrid1.DataSource.DataSet.Active ) then exit;
  if trim(column.Field.AsString)='' then exit;
  sortgrid(column.Field.FieldName,dmmain.CDSquery,dbgrid1,column);
end;

procedure Tfmlimitgoods.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMMAIN.CDSquery.Close;
  dmmain.CDSquery.Data:=null;
  inherited;

end;

end.
