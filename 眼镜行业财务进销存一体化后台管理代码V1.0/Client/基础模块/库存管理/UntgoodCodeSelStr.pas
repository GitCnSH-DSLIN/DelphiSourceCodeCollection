unit UntgoodCodeSelStr;
///2004-2-19 ���ݻ�������fm_basequery ��д�� ydy
//2004-3-23ydy �����µ���Ʒ������д
////2004-4-12 ydy create ����ѡ����Ʒ������������Ϣ ר�����ڶ�stringgrid�ĸ�ֵ
////������������ѡ��   ֧�ֶ��ȡ����



interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons,DB, fm_BaseQueryStr,
  DBClient;


type
  TfmgoodCodeSelStr = class(TfmBaseQueryStr)
    Panel3: TPanel;
    Label2: TLabel;
    CBType: TComboBox;
    Label4: TLabel;
    cbBrand: TComboBox;
    Label3: TLabel;
    CbBreed: TComboBox;
    DataSource1: TDataSource;
    procedure btnpagedownClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBTypeChange(Sender: TObject);
    procedure cbBrandChange(Sender: TObject);
    procedure CbBreedChange(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    LocalCount:integer;   //ֱ�Ӹ��ݱ��ص�ֵ�ϴ���ѯ
    Sqlstr:wideString;
  public
    { Public declarations }
    show_mode:string;
  end;

var
  fmgoodCodeSelStr: TfmgoodCodeSelStr;
//  LocalCount:integer;   //ֱ�Ӹ��ݱ��ص�ֵ�ϴ���ѯ
//  Sqlstr:wideString;

implementation

uses fm_Scrap, fm_Check,
  fm_Overflow,untdatadm, func, Stock_Contract, Goods_Write, Umanage_Fad,
  Uinstock, Uflat, Goods_Requirement, Untnewshopgoods, UntZsManager,
  UStock_cancel;



{$R *.dfm}

////ֻ��Ҫѡһ��
procedure TfmgoodCodeSelStr.DBGrid1DblClick(Sender: TObject);
var
  rows:integer;
begin
  inherited;

  if not dbgrid1.DataSource.DataSet.Active then
  begin
    application.MessageBox('��ѡ����Ʒ��',pchar(application.Title),mb_iconinformation);
    exit;
  end;

///����2004-4-14
  if show_mode='2' then
  begin
    with fmScrap do
    begin
      rows:=sgorder.RowCount;
      if  sgorder.Cells[1,rows-1] = '' then rows := rows -1   //ydy 2004-14 add
      else  sgorder.RowCount := sgorder.RowCount + 1;
      sgorder.Cells[0,rows] := inttostr(rows);   //���
      sgorder.Cells[1,rows]:=trim(dmmain.dsquery.fieldbyname('goods_no').AsString);
      sgorder.Cells[2,rows]:=trim(dmmain.dsquery.fieldbyname('goods_name').AsString);
      sgorder.Cells[3,rows]:=trim(dmmain.dsquery.fieldbyname('singleprice').AsString);
      StockNum_List.Add(dmmain.dsquery.fieldbyname('Stock_amount').AsString);
      sgorder.Cells[8,rows]:=trim(dmmain.dsquery.fieldbyname('baseprice').AsString);//�ɱ���
      maxnumber:=dmmain.dsquery.fieldbyname('Stock_amount').AsInteger;
      dmmain.dsquery.Close;
      self.close;
    end;
  end;
  if show_mode='3' then    //��Ʒ�̵��ѯ
  begin
    with fmcheck do
    begin
      rows:=sgorder.RowCount;
      if  sgorder.Cells[1,rows-1] = '' then rows := rows -1   //ydy 2004-14 add
      else  sgorder.RowCount := sgorder.RowCount + 1;
       sgorder.Cells[0,rows] := inttostr(rows);   //���
      sgorder.Cells[1,rows]:=trim(dmmain.dsquery.fieldbyname('goods_no').AsString);
      sgorder.Cells[2,rows]:=trim(dmmain.dsquery.fieldbyname('goods_name').AsString);
      sgorder.Cells[3,rows]:=trim(dmmain.dsquery.fieldbyname('singleprice').AsString);
      sgorder.Cells[7,rows]:=trim(dmmain.dsquery.fieldbyname('stock_amount').AsString);
      pd_maxnumber:=dmmain.dsquery.fieldbyname('Stock_amount').AsInteger;
      dmmain.dsquery.Close;
      self.close;
    end;
  end;
  if show_mode='4' then    //��Ʒ���浥��  //WG EDIT 2004-2-26
  begin
    with fmOverflow do
    begin
      rows:=sgorder.RowCount;
      if  sgorder.Cells[1,rows-1] = '' then rows := rows -1   //ydy 2004-14 add
      else  sgorder.RowCount := sgorder.RowCount + 1;
       sgorder.Cells[0,rows] := inttostr(rows);   //���
      sgorder.Cells[1,rows]:=trim(dmmain.dsquery.fieldbyname('goods_no').AsString);
      sgorder.Cells[2,rows]:=trim(dmmain.dsquery.fieldbyname('goods_name').AsString);
      sgorder.Cells[3,rows]:=trim(dmmain.dsquery.fieldbyname('singleprice').AsString);
      sgorder.Cells[8,rows]:=trim(dmmain.dsquery.fieldbyname('baseprice').AsString); //�ɱ���
//      pd_maxnumber:=dmmain.dsquery.fieldbyname('Stock_amount').AsInteger;
      dmmain.dsquery.Close;
      self.close;
    end;
  end;
  if show_mode='5' then    //�ɹ���ͬ  //WG EDIT 2004-4-16
  begin
    with frm_Stock_Contract do
    begin
      rows:=stringgrid1.RowCount;
      if  stringgrid1.Cells[1,rows-1] = '' then rows := rows -1   //ydy 2004-14 add
      else stringgrid1.RowCount := stringgrid1.RowCount + 1;
      stringgrid1.Cells[0,rows] := inttostr(rows);   //���
      stringgrid1.Cells[1,rows]:=trim(dmmain.dsquery.fieldbyname('goods_no').AsString);
      stringgrid1.Cells[2,rows]:=trim(dmmain.dsquery.fieldbyname('goods_name').AsString);
      stringgrid1.Cells[3,rows]:='0';
      stringgrid1.Cells[4,rows]:='0';
      stringgrid1.Cells[5,rows]:='0';
      stringgrid1.Cells[6,rows]:=trim(dmmain.dsquery.fieldbyname('type').AsString);
      stringgrid1.Cells[7,rows]:=trim(dmmain.dsquery.fieldbyname('provider').AsString);
//      pd_maxnumber:=dmmain.dsquery.fieldbyname('Stock_amount').AsInteger;
      dmmain.dsquery.Close;
      self.close;
    end;
  end;
  if show_mode='6' then    //�����Ǽ�  //WG EDIT 2004-4-16
  begin
    with frm_Goods_Write do
    begin
      rows:=stringgrid1.RowCount;
      if  stringgrid1.Cells[1,rows-1] = '' then rows := rows -1   //ydy 2004-14 add
      else  stringgrid1.RowCount := stringgrid1.RowCount + 1;
      stringgrid1.Cells[0,rows] := inttostr(rows);   //���
      stringgrid1.Cells[1,rows]:=trim(dmmain.dsquery.fieldbyname('goods_no').AsString);
      stringgrid1.Cells[2,rows]:=trim(dmmain.dsquery.fieldbyname('goods_name').AsString);
      stringgrid1.Cells[6,rows]:=trim(dmmain.dsquery.fieldbyname('type').AsString);
      stringgrid1.Cells[7,rows]:=trim(dmmain.dsquery.fieldbyname('provider').AsString);
//      pd_maxnumber:=dmmain.dsquery.fieldbyname('Stock_amount').AsInteger;
      dmmain.dsquery.Close;
      self.close;
    end;
  end;
  /////////////////
  if show_mode='7' then    //��Ӫҵ����  //WG EDIT 2004-4-16
  begin
    with frm_Umanage_Fad do
    begin
      rows:=stringgrid1.RowCount;
      if  stringgrid1.Cells[1,rows-1] = '' then rows := rows -1   //ydy 2004-14 add
      else  stringgrid1.RowCount := stringgrid1.RowCount + 1;
      stringgrid1.Cells[0,rows] := inttostr(rows);   //���
      stringgrid1.Cells[1,rows]:=trim(dmmain.dsquery.fieldbyname('goods_no').AsString);
      stringgrid1.Cells[2,rows]:=trim(dmmain.dsquery.fieldbyname('goods_name').AsString);
      stringgrid1.Cells[4,rows]:=trim(dmmain.dsquery.fieldbyname('baseprice').AsString);
      stringgrid1.Cells[6,rows]:=trim(dmmain.dsquery.fieldbyname('type').AsString);
      stringgrid1.Cells[7,rows]:=trim(dmmain.dsquery.fieldbyname('provider').AsString);
      stringgrid1.Cells[8,rows]:=trim(dmmain.dsquery.fieldbyname('stock_amount').AsString);
//      pd_maxnumber:=dmmain.dsquery.fieldbyname('Stock_amount').AsInteger;
      dmmain.dsquery.Close;
      self.close;
    end;
  end;
  //////////////////
  if show_mode='8' then    //��Ӫҵ���  //WG EDIT 2004-4-16
  begin
    with frmin_stock do
    begin
      rows:=stringgrid1.RowCount;
      if  stringgrid1.Cells[1,rows-1] = '' then rows := rows -1   //ydy 2004-14 add
      else  stringgrid1.RowCount := stringgrid1.RowCount + 1;
      stringgrid1.Cells[0,rows] := inttostr(rows);   //���
      stringgrid1.Cells[1,rows]:=trim(dmmain.dsquery.fieldbyname('goods_no').AsString);
      stringgrid1.Cells[2,rows]:=trim(dmmain.dsquery.fieldbyname('goods_name').AsString);
      stringgrid1.Cells[3,rows]:=trim(dmmain.dsquery.fieldbyname('baseprice').AsString);
      stringgrid1.Cells[5,rows]:=trim(dmmain.dsquery.fieldbyname('provider').AsString);
//      pd_maxnumber:=dmmain.dsquery.fieldbyname('Stock_amount').AsInteger;
      dmmain.dsquery.Close;
      self.close;
    end;
  end;
  ////////////////////
  if show_mode='9' then    //�ײ͹���  //WG EDIT 2004-4-16
  begin
    with fmflat do
    begin
      rows:=stringgrid2.RowCount;
      if  stringgrid2.Cells[1,rows-1] = '' then rows := rows -1   //ydy 2004-14 add
      else  stringgrid2.RowCount := stringgrid2.RowCount + 1;
      stringgrid2.Cells[0,rows] := inttostr(rows);   //���
      stringgrid2.Cells[1,rows]:=trim(dmmain.dsquery.fieldbyname('goods_no').AsString);
      stringgrid2.Cells[2,rows]:=trim(dmmain.dsquery.fieldbyname('goods_name').AsString);
      stringgrid2.Cells[3,rows]:=trim(dmmain.dsquery.fieldbyname('baseprice').AsString);
      stringgrid2.Cells[6,rows]:=trim(dmmain.dsquery.fieldbyname('type').AsString);
      stringgrid2.Cells[7,rows]:=trim(dmmain.dsquery.fieldbyname('provider').AsString);
      psum.Add(dmmain.dsquery.fieldbyname('stock_amount').AsString);
//      pd_maxnumber:=dmmain.dsquery.fieldbyname('Stock_amount').AsInteger;
      dmmain.dsquery.Close;
      self.close;
    end;
  end;
  /////////////////////
  if show_mode='10' then    //��Ʒ����  //WG EDIT 2004-4-16
  begin
    with frm_Goods_Requirement do
    begin
      rows:=stringgrid1.RowCount;
      if  stringgrid1.Cells[1,rows-1] = '' then rows := rows -1   //ydy 2004-14 add
      else  stringgrid1.RowCount := stringgrid1.RowCount + 1;
      stringgrid1.Cells[0,rows] := inttostr(rows);   //���
      StringGrid1.Cells[1,rows]:=trim(dmmain.dsquery.FieldByName('Goods_NO').AsString);
      StringGrid1.Cells[2,rows]:=trim(dmmain.dsquery.FieldByName('Goods_Name').AsString);
      StringGrid1.Cells[4,rows]:=trim(dmmain.dsquery.FieldByName('Base_unit').AsString);
      StringGrid1.Cells[5,rows]:=trim(dmmain.dsquery.FieldByName('Norms_Type').AsString);
      StringGrid1.Cells[6,rows]:=trim(dmmain.dsquery.FieldByName('type').AsString);
      StringGrid1.Cells[7,rows]:=trim(dmmain.dsquery.FieldByName('brand').AsString);
      StringGrid1.Cells[8,rows]:=trim(dmmain.dsquery.FieldByName('breed').AsString);
      StringGrid1.Cells[9,rows]:=trim(dmmain.dsquery.FieldByName('Color').AsString);
      StringGrid1.Cells[10,rows]:=trim(dmmain.dsquery.FieldByName('ball').AsString);
      StringGrid1.Cells[11,rows]:=trim(dmmain.dsquery.FieldByName('poll').AsString);
      StringGrid1.Cells[12,rows]:=trim(dmmain.dsquery.FieldByName('provider').AsString);
      StringGrid1.Cells[13,rows]:=trim(dmmain.dsquery.FieldByName('barcode').AsString);
      StringGrid1.Cells[14,rows]:=trim(dmmain.dsquery.FieldByName('brand').AsString);
      StringGrid1.Cells[15,rows]:=trim(dmmain.dsquery.FieldByName('memo').AsString);
//      pd_maxnumber:=dmmain.dsquery.fieldbyname('Stock_amount').AsInteger;
      dmmain.dsquery.Close;
      self.close;
    end;
  end;
  if show_mode='12' then    //�µ��̻�  //WG EDIT 2004-6-4
  begin
    with fmshopgoods do
    begin
      rows:=gridbase.RowCount;
      if  gridbase.Cells[1,rows-1] = '' then rows := rows -1   //ydy 2004-14 add
      else  gridbase.RowCount := gridbase.RowCount + 1;
      gridbase.Cells[0,rows] := inttostr(rows);   //���
      gridbase.Cells[1,rows]:=trim(dmmain.dsquery.fieldbyname('goods_no').AsString);
      gridbase.Cells[2,rows]:=trim(dmmain.dsquery.fieldbyname('goods_name').AsString);
      gridbase.Cells[3,rows]:=trim('0');
      gridbase.Cells[4,rows]:=trim(dmmain.dsquery.fieldbyname('provider').AsString);
      gridbase.Cells[5,rows]:=trim(dmmain.dsquery.fieldbyname('memo').AsString);
      gridbase.Cells[6,rows]:=trim(dmmain.dsquery.fieldbyname('Stock_amount').AsString);
//      pd_maxnumber:=dmmain.dsquery.fieldbyname('Stock_amount').AsInteger;
      dmmain.dsquery.Close;
      self.close;
    end;
  end;
  /////////////////////
  if show_mode='13' then    //��Ʒ����  //WG EDIT 2004-6-4
  begin
    with fmZSmanager do
    begin
      rows:=stringgrid1.RowCount;
      if  stringgrid1.Cells[1,rows-1] = '' then rows := rows -1   //ydy 2004-14 add
      else  stringgrid1.RowCount := stringgrid1.RowCount + 1;
      stringgrid1.Cells[0,rows] := inttostr(rows);   //���
      stringgrid1.Cells[1,rows]:=trim(dmmain.dsquery.fieldbyname('goods_no').AsString);
      stringgrid1.Cells[2,rows]:=trim(dmmain.dsquery.fieldbyname('goods_name').AsString);
      stringgrid1.Cells[4,rows]:=trim(dmmain.dsquery.fieldbyname('type').AsString);
      stringgrid1.Cells[5,rows]:=trim(dmmain.dsquery.fieldbyname('provider').AsString);
      dmmain.dsquery.Close;
      self.close;
    end;
  end;
  ////////////////////////////////
   if show_mode='14' then    //��Ʒ����  //WG EDIT 2004-6-4
  begin
    with fmcancel do
    begin
      rows:=stringgrid1.RowCount;
      if  stringgrid1.Cells[1,rows-1] = '' then rows := rows -1   //ydy 2004-14 add
      else  stringgrid1.RowCount := stringgrid1.RowCount + 1;
      stringgrid1.cells[0,rows] := inttostr(rows);
      stringgrid1. Cells[1,rows] := trim(dmmain.dsquery.Fieldbyname('Goods_NO').AsString);
      stringgrid1.Cells[2,rows] := trim(dmmain.dsquery.Fieldbyname('Goods_Name').AsString);
      stringgrid1.Cells[4,rows] := trim(dmmain.dsquery.fieldbyname('type').AsString);
      stringgrid1.Cells[6,rows] := trim(dmmain.dsquery.fieldbyname('stock_amount').AsString);
      dmmain.dsquery.Close;
      self.close;
    end;
  end;
  /////////////////////////////////
end;

procedure TfmgoodCodeSelStr.FormActivate(Sender: TObject);
begin
  inherited;
// btnQueryClick(sender);
end;

///
procedure TfmgoodCodeSelStr.btnpagedownClick(Sender: TObject);
var
  i:Integer;
  t_sql,str1,strend:wideString;
  quedata:olevariant;
  //2004-2-10Ϊ���Ż���������   �ٶ�����ߵ�52��
  lStart, lEnd : Integer;
begin
  inherited;
//   lStart := GetTickCount;
    quedata:=null;
     if not dmmain.DSquery.Active then exit;

    screen.Cursor := crhourglass;
   //�ص���DBGRID �Ļ���
   dmmain.dsquery.DisableControls;

    IF strtoint(SHOW_MODE) IN [2..4,7,9,12,14] then
    begin
      if combobox1.Text = 'ȫ��' then
      begin
      t_sql:='select  *  from  [vSelectGoods] where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';
      T_sql := t_sql + ' and breed = ' + ''''+trim(cbbreed.text)+'''';
      end else
      begin
      t_sql:='select top ' + trim(ComboBox1.Text) +' *  from  [vSelectGoods] where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';
      end;
      T_sql := t_sql + ' and breed = ' + ''''+trim(cbbreed.text)+''''+' and storage_no='+''''+trim(shopid)+'''';
    end else
    begin
      if combobox1.Text = 'ȫ��' then
      begin
      t_sql:='select  *  from  [Vgoodscodeprice] where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';   //5-11�޸� old:vselectgoods
      T_sql := t_sql + ' and breed = ' + ''''+trim(cbbreed.text)+'''';
      end else
      begin
      t_sql:='select top ' + trim(ComboBox1.Text) +' *  from  [Vgoodscodeprice] where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';
      end;
      T_sql := t_sql + ' and breed = ' + ''''+trim(cbbreed.text)+'''';
    end;
    str1 := ' and  id > '+ inttostr(localcount);

    strend := T_sql + str1;

///getmore �����ж�LOCALCOUNT�Ƿ����RECORDCOUNT�����������ִ�С� ���������Ժ��������Ϊ0

  try
   ipubtemp.ty_query(strend,quedata);
    if not varisnull(quedata) then
    begin
      dmmain.dsquery.EnableControls;
     if dmmain.dsquery.Active then dmmain.dsquery.Close;
      dmmain.dsquery.Open;
      dmmain.dsquery.AppendData(quedata,true);
      quedata:=null;
      ///ydy add
       dmmain.dsquery.Last;
    //���´�
      //�õ��˴β�ѯ�ļ�ֵ
      LocalCount := GetKeyFieldValue('id');   //��������ֶ�
    edtRecNo.Text := '��ǰ����'+inttostr(dmmain.dsquery.recordcount) +'��';
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


procedure TfmgoodCodeSelStr.FormShow(Sender: TObject);
var
  t_sql:string;
begin
  inherited;
   ///////�����
  t_sql:='select * from  [goods_type]';
  //  t_sql:='select distinct type  from  [goods_code]';
  GetDataToComBoX(cbtype,t_sql,'type');
  cbtype.ItemIndex := -1;
  combobox1.ItemIndex:=0;
  dmmain.dsquery.Close;
  dmmain.dsquery.Data:=null;
end;

procedure TfmgoodCodeSelStr.CBTypeChange(Sender: TObject);
var
  t_sql:string;
begin
  inherited;
  if dmmain.DSquery.Active then dmmain.DSquery.Close;
  //��Ʒ��
  t_sql:='select  distinct brand from  [goods_code] where type ='+''''+trim(cbtype.text)+'''';
  GetDataToComBoX(cbBrand,t_sql,'brand');
  cbBrand.ItemIndex := -1;
  cbbreed.Clear;

end;

procedure TfmgoodCodeSelStr.cbBrandChange(Sender: TObject);
var
  t_sql:string;
begin
  inherited;
  //��Ʒ��
  if dmmain.DSquery.Active then dmmain.DSquery.Close;
  if cbtype.Text = '' then exit;
  t_sql:='select distinct breed  from  [goods_code] where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';
  GetDataToComBoX(cbBreed,t_sql,'breed');
  cbBreed.ItemIndex := -1;
  edtrecno.Clear;
end;

procedure TfmgoodCodeSelStr.CbBreedChange(Sender: TObject);
var
  t_sql:string;
  quedata:olevariant;
begin
  inherited;
////////////��ѯ����
    quedata:=null;
   if cbbrand.Text = '' then exit;

   screen.Cursor := crhourglass;
   //�ص���DBGRID �Ļ���
   dmmain.dsquery.DisableControls;
   IF strtoint(SHOW_MODE) IN [2..4,7,9,12,14] then
   begin
     t_sql:='select top 20 *  from  [vSelectGoods] where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';
     T_sql := t_sql + ' and breed = ' + ''''+trim(cbbreed.text)+''''+' and storage_no='+''''+trim(shopid)+'''';
   end else
   begin
     t_sql:='select top 20 *  from  [Vgoodscodeprice] where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';   //5-11�޸�  OLD  vSelectGoods
     T_sql := t_sql + ' and breed = ' + ''''+trim(cbbreed.text)+'''';
   end;
   try
  if dmmain.DSquery.Active then dmmain.dsquery.Close;
  dmmain.dsquery.Data:=null;
   ipubtemp.ty_query(t_sql,quedata);  //.qurrecords(t_sql,quedata);
   if not varisnull(quedata) then
    begin
      dmmain.dsquery.Data:=quedata;
      dmmain.dsquery.Open;
      quedata:=null;
      dmmain.dsquery.Last;
      edtRecNo.Text := '��ǰ������: '+inttostr(dmmain.dsquery.recordcount)+'��';
      dmmain.dsquery.EnableControls;
      dbgrid1.Refresh;
      LocalCount := GetKeyFieldValue('id');   //��������ֶ�
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
  dbgrid1.Refresh;   //ydy add 2004-4-13
  screen.Cursor :=  crdefault;
end;

procedure TfmgoodCodeSelStr.btnQueryClick(Sender: TObject);
var
   x,i,countmy:integer;
   BookmarkList: TBookmarkList;
   TempBookmark: TBookmark;
begin
if show_mode='1' then
begin
  DBGrid1DblClick(Sender);
  exit;   //������ʱ��֧�ֶ���ѡ��
end;

if not dmmain.DSquery.Active then
  begin
    if dbgrid1.SelectedRows.Count < 1 then
    Application.MessageBox('��ָ�����۵���Ʒ',pchar(application.Title),mb_iconinformation);
    exit;
end;
  DBGrid1.Datasource.Dataset.DisableControls;

  if   show_mode='2' then
  begin
    countmy :=fmScrap.sgorder.RowCount ;
    if fmScrap.sgorder. Cells[1,countmy-1] = '' then      ///���һ��Ϊ�����ӵ����� 2004-4-14 add
    countmy := countmy -1;
    with DBgrid1.SelectedRows do
      if Count > 0 then
          begin
            fmScrap.sgorder.RowCount := countmy  + count;     //modify ydy
            TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;

            for x:= 0 to Count - 1 do
            begin
                if IndexOf(Items[x]) > -1 then
            begin
            DBGrid1.Datasource.Dataset.Bookmark:= Items[x];
            //�õ�ѡ��������

            with  fmScrap do
            begin
              with sgorder do
              begin
                cells[0,countmy + x] := inttostr(countmy+ x);
                Cells[1,countmy + x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_NO').AsString);
                Cells[2,countmy + x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_Name').AsString);
                Cells[3,countmy + x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('singleprice').AsString);
                Cells[8,countmy + x]:=trim(DBGrid1.Datasource.Dataset.fieldbyname('baseprice').AsString);//�ɱ���
                StockNum_List.Add(trim(DBGrid1.Datasource.Dataset.fieldbyname('Stock_amount').AsString));
              end;
            end;

            end;
            end;
            DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
            DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
            end else
            begin
              DBGrid1.Datasource.Dataset.EnableControls;
              Application.MessageBox('��û��ѡ����Ʒ����ѡ����Ʒ��',pchar(application.Title),mb_iconinformation);
              exit;
            end;
end;

if   show_mode='3' then
begin
    countmy :=fmcheck.sgorder.RowCount;
    if fmcheck.sgorder. Cells[1,countmy-1] = '' then      ///���һ��Ϊ�����ӵ����� 2004-4-14 add
    countmy := countmy -1;
    with DBgrid1.SelectedRows do
      if Count > 0 then
          begin
            fmcheck.sgorder.RowCount := countmy + count;
            TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
            for x:= 0 to Count - 1 do
            begin
            if IndexOf(Items[x]) > -1 then
            begin
            DBGrid1.Datasource.Dataset.Bookmark:= Items[x];
            //�õ�ѡ��������

            with  fmcheck do
            begin
              with sgorder do
              begin
                cells[0,countmy+ x] := inttostr(countmy+ x);
                Cells[1,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_NO').AsString);
                Cells[2,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_Name').AsString);
                Cells[3,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('singleprice').AsString);
                cells[7,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('stock_amount').AsString);
              end;
            end;

            end;
            end;
            DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
            DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
            end else
            begin
              DBGrid1.Datasource.Dataset.EnableControls;
              Application.MessageBox('��û��ѡ����Ʒ����ѡ����Ʒ��',pchar(application.Title),mb_iconinformation);
              exit;
            end;
end;

  if   show_mode='4' then
  begin
    countmy :=fmOverflow.sgorder.RowCount;
    if fmOverflow.sgorder.Cells[1,countmy-1] = '' then      ///���һ��Ϊ�����ӵ����� 2004-4-14 add
    countmy := countmy -1;
    with DBgrid1.SelectedRows do
      if Count > 0 then
          begin
            fmOverflow.sgorder.RowCount := countmy + count ;      ///2004-4-14 new ydy
            TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
            for x:= 0 to Count - 1 do
            begin
            if IndexOf(Items[x]) > -1 then
            begin
            DBGrid1.Datasource.Dataset.Bookmark:= Items[x];
            //�õ�ѡ��������

            with  fmOverflow do
            begin
              with sgorder do
              begin
                cells[0,countmy+ x] := inttostr(countmy+ x);
                Cells[1,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_NO').AsString);
                Cells[2,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_Name').AsString);
                Cells[3,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('singleprice').AsString);
                Cells[8,countmy + x]:=trim(DBGrid1.Datasource.Dataset.fieldbyname('baseprice').AsString);//�ɱ���
              end;
            end;

            end;
            end;
            DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
            DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
            end else
            begin
              DBGrid1.Datasource.Dataset.EnableControls;
              Application.MessageBox('��û��ѡ����Ʒ����ѡ����Ʒ��',pchar(application.Title),mb_iconinformation);
              exit;
            end;
  end;

  if   show_mode='5' then   //�ɹ���ͬ
  begin
    countmy :=frm_stock_contract.stringgrid1.RowCount;
  if frm_stock_contract.stringgrid1.Cells[1,countmy-1] = '' then      ///���һ��Ϊ�����ӵ����� 2004-4-14 add
  countmy := countmy -1;
  with DBgrid1.SelectedRows do
  if Count > 0 then
  begin
    frm_stock_contract.stringgrid1.RowCount := countmy + count ;      ///2004-4-14 new ydy
    TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
    for x:= 0 to Count - 1 do
    begin
      if IndexOf(Items[x]) > -1 then
      begin
        DBGrid1.Datasource.Dataset.Bookmark:= Items[x];
  //�õ�ѡ��������
        with  frm_stock_contract do
        begin
          with stringgrid1 do
          begin
            cells[0,countmy+ x] := inttostr(countmy+ x);
            Cells[1,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_NO').AsString);
            Cells[2,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_Name').AsString);
            Cells[3,countmy +x]:='0';
            Cells[4,countmy +x]:='0';
            Cells[5,countmy +x]:='0';
            Cells[6,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('type').AsString);
            Cells[7,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('provider').AsString);
          end;
       end;
     end;
   end;
  DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
  DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
  end else
  begin
    DBGrid1.Datasource.Dataset.EnableControls;
    Application.MessageBox('��û��ѡ����Ʒ����ѡ����Ʒ��',pchar(application.Title),mb_iconinformation);
    exit;
  end;
end;
/////////////////////////////////////////////////
  if   show_mode='6' then   //�����Ǽ�
  begin
    countmy :=frm_Goods_Write.stringgrid1.RowCount;
  if frm_Goods_Write.stringgrid1.Cells[1,countmy-1] = '' then      ///���һ��Ϊ�����ӵ����� 2004-4-14 add
    countmy := countmy -1;
  with DBgrid1.SelectedRows do
  if Count > 0 then
  begin
    frm_Goods_Write.stringgrid1.RowCount := countmy + count ;      ///2004-4-14 new ydy
    TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
    for x:= 0 to Count - 1 do
    begin
      if IndexOf(Items[x]) > -1 then
      begin
        DBGrid1.Datasource.Dataset.Bookmark:= Items[x];
    //�õ�ѡ��������
        with  frm_Goods_Write do
        begin
          with stringgrid1 do
          begin
            cells[0,countmy+ x] := inttostr(countmy+ x);
            Cells[1,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_NO').AsString);
            Cells[2,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_Name').AsString);
            Cells[5,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('type').AsString);
            //Cells[7,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('provider').AsString);
          end;
        end;
      end;
    end;
  DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
  DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
  end else
  begin
    DBGrid1.Datasource.Dataset.EnableControls;
    Application.MessageBox('��û��ѡ����Ʒ����ѡ����Ʒ��',pchar(application.Title),mb_iconinformation);
    exit;
  end;
end;
/////////////////////////
 if   show_mode='7' then   //��Ӫҵ����
  begin
    countmy :=frm_Umanage_Fad.stringgrid1.RowCount;
  if frm_Umanage_Fad.stringgrid1.Cells[1,countmy-1] = '' then      ///���һ��Ϊ�����ӵ����� 2004-4-14 add
    countmy := countmy -1;
  with DBgrid1.SelectedRows do
  if Count > 0 then
  begin
    frm_Umanage_Fad.stringgrid1.RowCount := countmy + count ;      ///2004-4-14 new ydy
    TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
    for x:= 0 to Count - 1 do
    begin
      if IndexOf(Items[x]) > -1 then
      begin
        DBGrid1.Datasource.Dataset.Bookmark:= Items[x];
    //�õ�ѡ��������
        with  frm_Umanage_Fad do
        begin
          with stringgrid1 do
          begin
            cells[0,countmy+ x] := inttostr(countmy+ x);
            Cells[1,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_NO').AsString);
            Cells[2,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_Name').AsString);
            Cells[4,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('baseprice').AsString);
            Cells[6,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('type').AsString);
            Cells[7,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('provider').AsString);
            Cells[8,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('stock_amount').AsString);
          end;
        end;
      end;
    end;
  DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
  DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
  end else
  begin
    DBGrid1.Datasource.Dataset.EnableControls;
    Application.MessageBox('��û��ѡ����Ʒ����ѡ����Ʒ��',pchar(application.Title),mb_iconinformation);
    exit;
  end;
end;
////////////////////////
  if   show_mode='8' then   //��Ӫҵ����
  begin
    countmy :=frmin_stock.stringgrid1.RowCount;
  if frmin_stock.stringgrid1.Cells[1,countmy-1] = '' then      ///���һ��Ϊ�����ӵ����� 2004-4-14 add
    countmy := countmy -1;
  with DBgrid1.SelectedRows do
  if Count > 0 then
  begin
    frmin_stock.stringgrid1.RowCount := countmy + count ;      ///2004-4-14 new ydy
    TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
    for x:= 0 to Count - 1 do
    begin
      if IndexOf(Items[x]) > -1 then
      begin
        DBGrid1.Datasource.Dataset.Bookmark:= Items[x];
    //�õ�ѡ��������
        with  frmin_stock do
        begin
          with stringgrid1 do
          begin
            cells[0,countmy+ x] := inttostr(countmy+ x);
            Cells[1,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_NO').AsString);
            Cells[2,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_Name').AsString);
            Cells[3,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('baseprice').AsString);
            Cells[5,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('provider').AsString);
            //Cells[7,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('provider').AsString);
          end;
        end;
      end;
    end;
  DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
  DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
  end else
  begin
    DBGrid1.Datasource.Dataset.EnableControls;
    Application.MessageBox('��û��ѡ����Ʒ����ѡ����Ʒ��',pchar(application.Title),mb_iconinformation);
    exit;
  end;
end;
///////////////////////
 if   show_mode='9' then   //�ײͶ���
  begin
    countmy :=fmflat.stringgrid2.RowCount;
  if fmflat.stringgrid2.Cells[1,countmy-1] = '' then      ///���һ��Ϊ�����ӵ����� 2004-4-14 add
    countmy := countmy -1;
  with DBgrid1.SelectedRows do
  if Count > 0 then
  begin
    fmflat.stringgrid2.RowCount := countmy + count ;      ///2004-4-14 new ydy
    TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
    for x:= 0 to Count - 1 do
    begin
      if IndexOf(Items[x]) > -1 then
      begin
        DBGrid1.Datasource.Dataset.Bookmark:= Items[x];
    //�õ�ѡ��������
        with  fmflat do
        begin
          with stringgrid2 do
          begin
            cells[0,countmy+ x] := inttostr(countmy+ x);
            Cells[1,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_NO').AsString);
            Cells[2,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_Name').AsString);
            Cells[3,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('baseprice').AsString);
            Cells[6,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('type').AsString);
            Cells[7,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('provider').AsString);
            //Cells[7,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('provider').AsString);
            psum.Add(DBGrid1.Datasource.Dataset.fieldbyname('stock_amount').AsString);
          end;
        end;
      end;
    end;
  DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
  DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
  end else
  begin
    DBGrid1.Datasource.Dataset.EnableControls;
    Application.MessageBox('��û��ѡ����Ʒ����ѡ����Ʒ��',pchar(application.Title),mb_iconinformation);
    exit;
  end;
end;
///////////////////////
if   show_mode='10' then   //��Ʒ����
  begin
    countmy :=frm_Goods_Requirement.stringgrid1.RowCount;
  if frm_Goods_Requirement.stringgrid1.Cells[1,countmy-1] = '' then      ///���һ��Ϊ�����ӵ����� 2004-4-14 add
    countmy := countmy -1;
  with DBgrid1.SelectedRows do
  if Count > 0 then
  begin
    frm_Goods_Requirement.stringgrid1.RowCount := countmy + count ;      ///2004-4-14 new ydy
    TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
    for x:= 0 to Count - 1 do
    begin
      if IndexOf(Items[x]) > -1 then
      begin
        DBGrid1.Datasource.Dataset.Bookmark:= Items[x];
    //�õ�ѡ��������
        with  frm_Goods_Requirement do
        begin
          with stringgrid1 do
          begin
            Cells[0,countmy+ x] := inttostr(countmy+ x);   //���
            Cells[1,countmy+ x]:=trim(DBGrid1.Datasource.Dataset.FieldByName('Goods_NO').AsString);
            Cells[2,countmy+ x]:=trim(DBGrid1.Datasource.Dataset.FieldByName('Goods_Name').AsString);
            Cells[4,countmy+ x]:=trim(DBGrid1.Datasource.Dataset.FieldByName('Base_unit').AsString);
            Cells[5,countmy+ x]:=trim(DBGrid1.Datasource.Dataset.FieldByName('Norms_Type').AsString);
            Cells[6,countmy+ x]:=trim(DBGrid1.Datasource.Dataset.FieldByName('type').AsString);
            Cells[7,countmy+ x]:=trim(DBGrid1.Datasource.Dataset.FieldByName('brand').AsString);
            Cells[8,countmy+ x]:=trim(DBGrid1.Datasource.Dataset.FieldByName('breed').AsString);
            Cells[9,countmy+ x]:=trim(DBGrid1.Datasource.Dataset.FieldByName('Color').AsString);
            Cells[10,countmy+ x]:=trim(DBGrid1.Datasource.Dataset.FieldByName('ball').AsString);
            Cells[11,countmy+ x]:=trim(DBGrid1.Datasource.Dataset.FieldByName('poll').AsString);
            Cells[12,countmy+ x]:=trim(DBGrid1.Datasource.Dataset.FieldByName('provider').AsString);
            Cells[13,countmy+ x]:=trim(DBGrid1.Datasource.Dataset.FieldByName('barcode').AsString);
            Cells[14,countmy+ x]:=trim(DBGrid1.Datasource.Dataset.FieldByName('brand').AsString);
            Cells[15,countmy+ x]:=trim(DBGrid1.Datasource.Dataset.FieldByName('memo').AsString);
          end;
        end;
      end;
    end;
  DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
  DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
  end else
  begin
    DBGrid1.Datasource.Dataset.EnableControls;
    Application.MessageBox('��û��ѡ����Ʒ����ѡ����Ʒ��',pchar(application.Title),mb_iconinformation);
    exit;
  end;
end;

  if   show_mode='12' then   //�µ��̻�
  begin
    countmy :=fmshopgoods.gridbase.RowCount;
  if fmshopgoods.gridbase.Cells[1,countmy-1] = '' then      ///���һ��Ϊ�����ӵ����� 2004-4-14 add
    countmy := countmy -1;
  with DBgrid1.SelectedRows do
  if Count > 0 then
  begin
    fmshopgoods.gridbase.RowCount := countmy + count ;      ///2004-4-14 new ydy
    TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
    for x:= 0 to Count - 1 do
    begin
      if IndexOf(Items[x]) > -1 then
      begin
        DBGrid1.Datasource.Dataset.Bookmark:= Items[x];
    //�õ�ѡ��������
        with  fmshopgoods do
        begin
          with gridbase do
          begin
            cells[0,countmy+ x] := inttostr(countmy+ x);
            Cells[1,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_NO').AsString);
            Cells[2,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_Name').AsString);
            Cells[3,countmy+ x] := trim('0');
            Cells[4,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('provider').AsString);
            Cells[5,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('memo').AsString);
            Cells[6,countmy+ x] :=trim(DBGrid1.Datasource.Dataset.fieldbyname('stock_amount').AsString);
          end;
        end;
      end;
    end;
  DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
  DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
  end else
  begin
    DBGrid1.Datasource.Dataset.EnableControls;
    Application.MessageBox('��û��ѡ����Ʒ����ѡ����Ʒ��',pchar(application.Title),mb_iconinformation);
    exit;
  end;
end;
  //////////////////////////

  if   show_mode='13' then   //��Ʒ����
  begin
    countmy :=fmZSmanager.stringgrid1.RowCount;
  if fmZSmanager.stringgrid1.Cells[1,countmy-1] = '' then      ///���һ��Ϊ�����ӵ����� 2004-4-14 add
    countmy := countmy -1;
  with DBgrid1.SelectedRows do
  if Count > 0 then
  begin
    fmZSmanager.stringgrid1.RowCount := countmy + count ;      ///2004-4-14 new ydy
    TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
    for x:= 0 to Count - 1 do
    begin
      if IndexOf(Items[x]) > -1 then
      begin
        DBGrid1.Datasource.Dataset.Bookmark:= Items[x];
    //�õ�ѡ��������
        with  fmZSmanager do
        begin
          with stringgrid1 do
          begin
            cells[0,countmy+ x] := inttostr(countmy+ x);
            Cells[1,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_NO').AsString);
            Cells[2,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_Name').AsString);
            Cells[4,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('type').AsString);
            Cells[5,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('provider').AsString);
          end;
        end;
      end;
    end;
  DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
  DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
  end else
  begin
    DBGrid1.Datasource.Dataset.EnableControls;
    Application.MessageBox('��û��ѡ����Ʒ����ѡ����Ʒ��',pchar(application.Title),mb_iconinformation);
    exit;
  end;
end;
///////////////////////
if   show_mode='14' then   //�˻�
  begin
    countmy :=FmCancel.stringgrid1.RowCount;
  if FmCancel.stringgrid1.Cells[1,countmy-1] = '' then      ///���һ��Ϊ�����ӵ����� 2004-4-14 add
    countmy := countmy -1;
  with DBgrid1.SelectedRows do
  if Count > 0 then
  begin
    FmCancel.stringgrid1.RowCount := countmy + count ;      ///2004-4-14 new ydy
    TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
    for x:= 0 to Count - 1 do
    begin
      if IndexOf(Items[x]) > -1 then
      begin
        DBGrid1.Datasource.Dataset.Bookmark:= Items[x];
    //�õ�ѡ��������
        with  FmCancel do
        begin
          with stringgrid1 do
          begin
            cells[0,countmy+ x] := inttostr(countmy+ x);
            Cells[1,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_NO').AsString);
            Cells[2,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_Name').AsString);
            Cells[4,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('type').AsString);
            //Cells[5,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('provider').AsString);
            Cells[6,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('stock_amount').AsString);
          end;
        end;
      end;
    end;
  DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
  DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
  end else
  begin
    DBGrid1.Datasource.Dataset.EnableControls;
    Application.MessageBox('��û��ѡ����Ʒ����ѡ����Ʒ��',pchar(application.Title),mb_iconinformation);
    exit;
  end;
end;
//////////////////////////
  DBGrid1.Datasource.Dataset.EnableControls;
  close;
end;

procedure TfmgoodCodeSelStr.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if key=#13 then btnquery.Click;
end;

procedure TfmgoodCodeSelStr.DBGrid1TitleClick(Column: TColumn);
begin
  inherited;
  if (not dbgrid1.DataSource.DataSet.Active ) then exit;
  if trim(column.Field.AsString)='' then exit;
  sortgrid(column.Field.FieldName,dmmain.DSquery,dbgrid1,column);
end;

procedure TfmgoodCodeSelStr.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMMAIN.DSquery.Close;
  dmmain.DSquery.Data:=null;
  inherited;

end;

end.
