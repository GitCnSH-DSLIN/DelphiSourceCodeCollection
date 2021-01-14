unit Untsalemoney;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fm_Base, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, DB;

type
  Tfmsalemoney = class(TfmBase)
    Panel1: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    ComboBox1: TComboBox;
    edtTime: TEdit;
    Panel3: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    CBType: TComboBox;
    cbBrand: TComboBox;
    CbBreed: TComboBox;
    edtRecNo: TEdit;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    btnExit: TBitBtn;
    btnpagedown: TBitBtn;
    BtnSort: TBitBtn;
    btnAdd: TBitBtn;
    btnEdit: TBitBtn;
    btnDelete: TBitBtn;
    ds_salemoney: TDataSource;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    procedure btnExitClick(Sender: TObject);
    procedure CBTypeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbBrandChange(Sender: TObject);
    procedure CbBreedChange(Sender: TObject);
    procedure BtnSortClick(Sender: TObject);
    procedure btnpagedownClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    LocalCount:integer;
  public
    { Public declarations }
    tempsql,tables,tj:string;
  end;

var
  fmsalemoney: Tfmsalemoney;

implementation

uses untdatadm, fm_SetColumn, func, Untprice, dlg_priceselect, UntEIprices,
  UBaseprices;

{$R *.dfm}

procedure Tfmsalemoney.btnExitClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure Tfmsalemoney.CBTypeChange(Sender: TObject);
var
  t_sql:string;
begin
  inherited;
  if dmmain.DSquery.Active then dmmain.DSquery.Close;
  //��Ʒ��
  t_sql:='select  distinct brand,brand_no from  [goods_code] where type ='+''''+trim(cbtype.text)+''''+' order by brand_no';
  GetDataToComBoX(cbBrand,t_sql,'brand');
  cbBrand.ItemIndex := -1;
  cbbreed.Clear;
end;

procedure Tfmsalemoney.FormShow(Sender: TObject);
var
  t_sql:string;
begin
  inherited;
 ///////�����
  t_sql:='select * from  [goods_type]';
  GetDataToComBoX(cbtype,t_sql,'type');
  cbtype.ItemIndex := -1;
  combobox1.ItemIndex:=0;
  dmmain.dsquery.Close;
  dmmain.dsquery.Data:=null;
  dbgCur:=dbgrid1;
end;

procedure Tfmsalemoney.cbBrandChange(Sender: TObject);
var
  t_sql:string;
begin
  inherited;
  //��Ʒ��
  bitbtn1.Enabled:=false;
  if dmmain.DSquery.Active then dmmain.DSquery.Close;
  if cbtype.Text = '' then exit;
  t_sql:='select distinct breed,breed_no  from  [goods_code] where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+''''+' order by breed_no';
  GetDataToComBoX(cbBreed,t_sql,'breed');
  cbBreed.ItemIndex := -1;
  edtrecno.Clear;
  if CbBreed.Items.Count>0 then
  bitbtn1.Enabled:=true;
end;

procedure Tfmsalemoney.CbBreedChange(Sender: TObject);
var
  t_sql:string;
  quedata:olevariant;
begin
  inherited;
   if cbbrand.Text = '' then exit;
   screen.Cursor := crhourglass;
   //�ص���DBGRID �Ļ���
   dmmain.dsquery.DisableControls;
   tables:=' * from [Vsaleprice]'; //����
   tempsql:= 'select top 20 ';
   tj:=' where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+''''+' and breed = ' + ''''+trim(cbbreed.text)+'''';
   t_sql:=tempsql+tables+tj;
  try
  if dmmain.DSquery.Active then dmmain.dsquery.Close;
  dmmain.dsquery.Data:=null;
   ipubtemp.ty_query(t_sql,quedata);  //.qurrecords(t_sql,quedata);
   if not varisnull(quedata) then
    begin
      dmmain.dsquery.Data:=quedata;
      dmmain.dsquery.Open;
      ///ydy add
       dmmain.dsquery.Last;
       edtRecNo.Text := '��ǰ������: '+inttostr(dmmain.dsquery.recordcount)+'��';

    //���´�
      dmmain.dsquery.EnableControls;
      dbgrid1.Refresh;
      //�õ��˴β�ѯ�ļ�ֵ
     LocalCount := GetKeyFieldValue('id',dmmain.dsquery);   //��������ֶ�

    end else
    begin
       //����������
        dmmain.dsquery.EnableControls;        //ydy  ����Ҫ
       btnpagedown.Enabled := false;
       screen.Cursor :=  crdefault;
      exit;
    end;
  except
    dmmain.dsquery.EnableControls;
    dbgrid1.Refresh;
  end;
  dbgrid1.Refresh;
  screen.Cursor :=  crdefault;
  setdbgrid(dbgrid1,3);
end;

procedure Tfmsalemoney.BtnSortClick(Sender: TObject);
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

procedure Tfmsalemoney.btnpagedownClick(Sender: TObject);
var
  i:Integer;
  t_sql,str1,strend:wideString;
  quedata:olevariant;
  lStart, lEnd : Integer;
begin
  inherited;
  if not dmmain.DSquery.Active then exit;

    screen.Cursor := crhourglass;
   //�ص���DBGRID �Ļ���
   dmmain.dsquery.DisableControls;

    if combobox1.Text = 'ȫ��' then
    begin
      tempsql:=' select '
     //t_sql:='select * from [Vsaleprice] where  type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';
    end else
    begin
      tempsql:='select top ' + trim(ComboBox1.Text)
      //t_sql:='select top ' + trim(ComboBox1.Text) +' * from [Vsaleprice] where  type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';
    end;
    T_sql := tempsql+tables+tj;
    str1 := ' and  id > '+ inttostr(localcount);
    strend := T_sql + str1;
  try
   ipubtemp.ty_query(strend,quedata);
    if not varisnull(quedata) then
    begin
     if dmmain.dsquery.Active then dmmain.dsquery.Close;
      dmmain.dsquery.Open;
      dmmain.dsquery.AppendData(quedata,true);

      ///ydy add
       dmmain.dsquery.Last;
      dmmain.dsquery.EnableControls;
      //�õ��˴β�ѯ�ļ�ֵ
      LocalCount := GetKeyFieldValue('id',dmmain.dsquery);   //��������ֶ�
    edtRecNo.Text := '��ǰ����'+inttostr(dmmain.dsquery.recordcount) +'��';
    setdbgrid(dbgrid1,3);
    end else
    begin
       //����������
        dmmain.dsquery.EnableControls;        //ydy  ����Ҫ
       btnpagedown.Enabled := false;
       screen.Cursor :=  crdefault;
      exit;
    end;
  except
    dmmain.dsquery.EnableControls;
    dbgrid1.Refresh;
  end;
  dbgrid1.Refresh;
  screen.Cursor :=  crdefault;

end;

procedure Tfmsalemoney.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if not dmmain.dsquery.Active  then exit;
  if dmmain.cdsprice.Active then  dmmain.cdsprice.Close;
  dmmain.cdsprice.Params.ParamByName('no').AsString:=trim(dmmain.dsquery.fieldbyname('goods_no').AsString);
  dmmain.cdsprice.Open;
  if not dmmain.cdsprice.IsEmpty then
  begin
    if application.MessageBox(pchar('�Ƿ�ȷ��ɾ����Ʒ���Ϊ��'+trim(dmmain.dsquery.fieldbyname('goods_no').AsString)+'���Ŀ�����������ݣ�'),pchar(application.Title),mb_iconquestion+mb_okcancel)=idyes then
    begin
      dmmain.dsquery.DisableControls;
      dmmain.cdsprice.Edit;
      dmmain.cdsprice.FieldByName('singleprice').AsFloat:=0.00;
      dmmain.cdsprice.FieldByName('batchprice').AsFloat:=0.00;
      dmmain.cdsprice.FieldByName('agion').AsFloat:=0.00;
      dmmain.cdsprice.FieldByName('prices1').AsFloat:=0.00;
      dmmain.cdsprice.FieldByName('prices2').AsFloat:=0.00;
      dmmain.cdsprice.FieldByName('prices3').AsFloat:=0.00;
      dmmain.cdsprice.FieldByName('prices4').AsFloat:=0.00;
      dmmain.cdsprice.FieldByName('prices5').AsFloat:=0.00;
      dmmain.cdsprice.FieldByName('prices6').AsFloat:=0.00;
      dmmain.cdsprice.FieldByName('prices7').AsFloat:=0.00;
      dmmain.cdsprice.FieldByName('prices8').AsFloat:=0.00;
      dmmain.cdsprice.Post;
      try
        dmmain.cdsprice.ApplyUpdates(-1);
        dmmain.DSquery.Refresh;
        dmmain.DSquery.EnableControls;
        dbgrid1.Refresh;
      except
        application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconinformation);
        exit;
      end;
    end;
  end;
end;

procedure Tfmsalemoney.btnAddClick(Sender: TObject);
begin
  inherited;
  if not dmmain.dsquery.Active  then exit;
  fmbaseprice:=tfmbaseprice.Create(self);
  fmbaseprice.goods_no:=trim(dmmain.dsquery.fieldbyname('goods_no').AsString);
  fmbaseprice.ShowModal;
  fmbaseprice.Free;
  dbgrid1.Refresh;
end;

procedure Tfmsalemoney.btnEditClick(Sender: TObject);
begin
  inherited;
  if not dmmain.dsquery.Active  then exit;
  fmbaseprice:=tfmbaseprice.Create(self);
  fmbaseprice.goods_no:=trim(dmmain.dsquery.fieldbyname('goods_no').AsString);
  fmbaseprice.ShowModal;
  fmbaseprice.Free;
  dbgrid1.Refresh;
end;

procedure Tfmsalemoney.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  btnedit.Click;
end;

procedure Tfmsalemoney.BitBtn1Click(Sender: TObject);
begin
  inherited;
  dlgpriceselect:=tdlgpriceselect.Create(self);
  dlgpriceselect.ShowModal;
  dlgpriceselect.Free; 
end;

procedure Tfmsalemoney.BitBtn2Click(Sender: TObject);
begin
  inherited;
  fmEIprices:=tfmEIprices.Create(self);
  fmEIprices.ShowModal;
  fmEIprices.Free; 
end;

procedure Tfmsalemoney.DBGrid1TitleClick(Column: TColumn);
begin
  inherited;
  if (not dbgrid1.DataSource.DataSet.Active ) then exit;
  if trim(column.Field.AsString)='' then exit;
  sortgrid(column.Field.FieldName,dmmain.DSquery,dbgrid1,column);
end;

procedure Tfmsalemoney.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  setdbgrid(dbgrid1,2);
end;

procedure Tfmsalemoney.BitBtn4Click(Sender: TObject);
begin
  inherited;
  fmBaseprices:=tfmBaseprices.Create(self);
  fmBaseprices.ShowModal;
  fmBaseprices.Free; 
end;

procedure Tfmsalemoney.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMMAIN.DSquery.Close;
  dmmain.DSquery.Data:=null;
  inherited;

end;

end.
