unit UdlgGoodsSale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fm_Base, StdCtrls, Buttons, ComCtrls, DB, DBClient,Grids;

type
  TdlgGoodsSale = class(TfmBase)
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label8: TLabel;
    ckbnewDate: TCheckBox;
    dtpBegin: TDateTimePicker;
    dtpEnd: TDateTimePicker;
    Rbt: TRadioButton;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    rball: TRadioButton;
    Cbstorage: TCheckBox;
    cmbstorage: TComboBox;
    cdspart: TClientDataSet;
    cbmstorage: TCheckBox;
    cmbmstorage: TComboBox;
    procedure btnCancelClick(Sender: TObject);
    procedure CbstorageClick(Sender: TObject);
    procedure ckbnewDateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cmbmstorageChange(Sender: TObject);
    procedure cbmstorageClick(Sender: TObject);
  private
    { Private declarations }
    ps:boolean;
  public
    { Public declarations }
    showmodel:integer;
  end;

var
  dlgGoodsSale: TdlgGoodsSale;

implementation

uses untdatadm, func, UntGoodsSale, Ustocking, UTotalbreed, UntGoodsStaff;

{$R *.dfm}

procedure TdlgGoodsSale.btnCancelClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TdlgGoodsSale.CbstorageClick(Sender: TObject);
begin
  inherited;
    ckbcmb(cbstorage,cmbstorage);
end;

procedure TdlgGoodsSale.ckbnewDateClick(Sender: TObject);
begin
  inherited;
  ckbDtps(ckbnewdate,dtpbegin,dtpend);
end;

procedure TdlgGoodsSale.FormShow(Sender: TObject);
var
  t_sql:string;
  datas:olevariant;
begin
  inherited;
  ps:=false;
  dtpbegin.Date :=date-30;
  dtpend.Date:=date;
   ////////////////�ֿ�
  if Mstorage.Count=0 then
  begin
    cmbmstorage.Items.Add('���ֿ�'+shopid);
    t_sql:='select managerid from stock_manager where storageid='+''''+trim(shopid)+'''';
    datas:= null;
    ipubtemp.ty_query(t_sql,datas);
    if varisnull(datas) then
    begin
      ps:=true;
    end else
    begin
      ps:=false;
    end;
    if ps then
    begin
      t_sql:='select storage_no from  [storage] where storage_type<>'+''''+'�ŵ�ֿ�'+''''+' and storage_no<>'+''''+trim(shopid)+'''';
      cdspart.Close;
      cdspart.Data:=null;
      datas:=null;
      ipubtemp.ty_query(t_sql,datas);
      if not varisnull(datas) then
      begin
        cdspart.Data:=datas;
        cdspart.Open;
        datas:=null;
        while not cdspart.Eof do
        begin
          cmbmstorage.Items.Add('���Ͳֿ�'+trim(cdspart.fieldbyname('storage_no').AsString));
          cdspart.Next;
        end;
        cdspart.Close;
        cdspart.Data:=null;
      end;
    end;
    SetValuesData(cmbmstorage);
  end else
  begin
    GetValuesData(cmbmstorage);
    ps:=localb;
  end;
  cmbmstorage.ItemIndex := 0;
  cmbmstorageChange(cmbmstorage);
  cmbmstorage.ItemIndex := -1;
end;

procedure TdlgGoodsSale.btnOkClick(Sender: TObject);
var
  Zt:boolean;
  str,storage_no,varbegin,varend,flag,str1,flag1,stock_id:string;
  i,j:integer;
  datas:olevariant;
begin
  inherited;
  str:='';
  zt:=false;
  storage_no:='';
  varbegin:='';
  varend:='';
  STR1:='';
  stock_id:='';
  if not ps then
  begin
    zt:=true;
    STORAGE_NO:='';
    stoCK_ID:=shopid;
  end else
  begin
    stoCK_ID:='';
    STORAGE_NO:='';
  end;
  if cbmstorage.Checked then
  begin
    storage_no:='';
    i:=pos('�ֿ�', trim(cmbmstorage.Text));
    if i>0 then
    begin
      stock_id:=copy(trim(cmbmstorage.Text),i+4,length(trim(cmbmstorage.Text)));
    end else
    begin
      stock_id:=trim(cmbmstorage.Text);
    end;
    zt:=true;
  end ;
  if cbstorage.Checked then
  begin
    if trim(cmbstorage.Text)<>'ȫ���ֿ�' then
    begin
      i:=pos('�ֿ�', trim(cmbstorage.Text));
      if i>0 then
      begin
        stock_id:=copy(trim(cmbstorage.Text),i+4,length(trim(cmbstorage.Text)));
      end else
      begin
        stock_id:=trim(cmbstorage.Text);
      end;
      storage_no:='';
    end else
    begin
      storage_no:='';
      if  not ps then
      begin
        storage_no:='';
        stock_id:=shopid;
      end else
      begin
        storage_no:='';
        //stock_id:='';
        i:=pos('�ֿ�', trim(cmbmstorage.Text));
        if i>0 then
        begin
          stock_id:=copy(trim(cmbmstorage.Text),i+4,length(trim(cmbmstorage.Text)));
        end else
        begin
          stock_id:=trim(cmbmstorage.Text);
        end;
      end;
    end;
  end;
  if ckbnewdate.Checked then
  begin
    varbegin:=formatdatetime('yyyy''-''mm''-''dd',dtpbegin.Date);
    varend:=formatdatetime('yyyy''-''mm''-''dd',dtpend.Date);
    zt:=true;
  end;
  if rball.Checked then
  begin
    if zt then
    begin
      flag:='1';
    end else
    begin
      flag:='0';
    end;
    flag1:='0';
  end else
  begin
    if zt then
    begin
      flag:='3';
    end else
    begin
      flag:='2';
    end;
    flag1:='1';
  end;
  if showmodel=0 then  ///�����Ʒ��������
  begin
  str:=' exec Goods_Staff_Sale '+''''+trim(varbegin)+''''+','+''''+trim(varend)+''''+','+flag+','+''''+trim(storage_no)+''''+','+''''+trim(stock_id)+''''+',';

  str1:=STR+inttostr(fmGoodsSale.LocalCount) ;
  end;
   if showmodel=1 then  ///�����Ʒ�䶯
  begin
    str1:=' exec LS_StockTotalStaff '+inttostr(fmstocking.LocalCount)+','+''''+trim(varbegin)+''''+','+''''+trim(varend)+''''+','+flag1+','+''''+trim(storage_no)+''''+','+''''+trim(stock_id)+'''';
  end;
  if showmodel=2 then
  begin
    str1:=' exec total_breed'+''''+trim(storage_no)+''''+','+''''+trim(stock_id)+''''+','+''''+trim(varbegin)+''''+','+''''+trim(varend)+''''+','+inttostr(fmTotalBreed.LocalCount);
  end;
  if showmodel=3 then   //���ṹ����
  begin
    str1:=' exec StockGoodsStaffTotal'+''''+trim(varbegin)+''''+','+''''+trim(varend)+''''+','+''''+trim(storage_no)+''''+','+''''+trim(stock_id)+''''+','+inttostr(fmStockAmountStaff.LocalCount);
  end;
  dmmain.CDSquery.Close;
  dmmain.CDSquery.Data:=null;
  datas:=null;
   try
    datas:= adisp.GetRecord(str1);
    if not varisnull(datas) then
    begin
      dmmain.CDSquery.Data:= datas;
      dmmain.CDSquery.Open;
      dmmain.CDSquery.Last;
      if showmodel=0 then
      begin
        fmGoodsSale.temp:=str;
        setdbgrid(fmGoodsSale.dbgrid1,2);
      end ;
      if showmodel=1 then
      begin
        fmstocking.cdsdata.Close;
        fmstocking.cdsdata.Data:=null;
        if not varisnull(datas) then
        begin
          fmstocking.cdsdata.Data:=datas;
          fmstocking.cdsdata.Open;
          datas:=null;
        end;
        fmstocking.tables:=' exec LS_StockTotalStaff ';
        fmstocking.tempsql:=','+''''+trim(varbegin)+''''+','+''''+trim(varend)+''''+','+flag1;
        fmstocking.storage:=storage_no;
        fmstocking.stock_id:=stock_id;
        setdbgrid(fmstocking.dbgrid2,3);
      end;
      if showmodel=2 then
      begin
        fmTotalBreed.cdsdata.Close;
        fmTotalBreed.cdsdata.Data:=null;
        if not varisnull(datas) then
        begin
          fmTotalBreed.cdsdata.Data:=datas;
          fmTotalBreed.cdsdata.Open;
          datas:=null;
        end;
        fmTotalBreed.tempsql:=' exec total_breed'+''''+trim(storage_no)+''''+','+''''+trim(stock_id)+''''+','+''''+trim(varbegin)+''''+','+''''+trim(varend)+''''+',';
        setdbgrid(fmTotalBreed.dbgrid2,3);
      end;
      if showmodel=3 then
      begin
        fmStockAmountStaff.cdsdata.Close;
        fmStockAmountStaff.cdsdata.Data:=null;
        if not varisnull(datas) then
        begin
         fmStockAmountStaff.cdsdata.Data:=datas;
          fmStockAmountStaff.cdsdata.Open;
          datas:=null;
        end;
        fmStockAmountStaff.tempsql:=' exec StockGoodsStaffTotal'+''''+trim(varbegin)+''''+','+''''+trim(varend)+''''+','+''''+trim(storage_no)+''''+','+''''+trim(stock_id)+''''+',';
        setdbgrid(fmStockAmountStaff.dbgrid1,3);
      end;
    end else
    begin
      application.MessageBox('û����Ʒ�䶯���ݣ�',pchar(application.Title),mb_iconinformation);
      exit; 
    end;
  except
    application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
    exit;
  end;
end;

procedure TdlgGoodsSale.cmbmstorageChange(Sender: TObject);
var
  t_sql:string;
  datas:olevariant;
begin
  inherited;
  t_sql:='select storageid from stock_manager where managerid='+''''+trim(copy(trim(cmbmstorage.Text),pos('�ֿ�',trim(cmbmstorage.Text))+4,length(trim(cmbmstorage.Text))))+'''';
  GetDataToComBoX(cmbstorage,t_sql,'storageid');
  cmbstorage.Items.Add('ȫ���ֿ�');
  cmbstorage.ItemIndex:=-1;

end;

procedure TdlgGoodsSale.cbmstorageClick(Sender: TObject);
begin
  inherited;
   ckbcmb(cbmstorage,cmbmstorage);
end;

end.
