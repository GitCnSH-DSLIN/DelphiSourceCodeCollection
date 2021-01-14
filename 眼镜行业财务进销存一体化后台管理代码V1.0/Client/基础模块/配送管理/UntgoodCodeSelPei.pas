unit UntgoodCodeSelPei;
///2004-2-19 ���ݻ�������fm_basequery ��д�� ydy
//2004-3-23ydy �����µ���Ʒ������д
////2004-4-13 ydy create ����ѡ����Ʒ������������Ϣ ר�����ڶ�avgrid�ĸ�ֵ
////������������ѡ��   ֧�ֶ��ȡ����
///2004-4-26 ר������Ϊ�����������͵���Ʒѡ��



interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons,DB, fm_BaseQueryStr;


type
  TfmgoodCodeSelPei = class(TfmBaseQueryStr)
    Panel3: TPanel;
    Label2: TLabel;
    CBType: TComboBox;
    Label4: TLabel;
    cbBrand: TComboBox;
    Label3: TLabel;
    CbBreed: TComboBox;
    DataSource1: TDataSource;
    procedure btnpagedownClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBTypeChange(Sender: TObject);
    procedure cbBrandChange(Sender: TObject);
    procedure CbBreedChange(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    show_mode:string;
    count1,count2:integer;
  end;

var
  fmgoodCodeSelPei: TfmgoodCodeSelPei;

implementation

uses  UntPosQuestBillStr, UntAskGoodsPlan,
  UntPosAskBackBill, UntPosSendBill, untdatadm, func;

var
  LocalCount:integer;   //ֱ�Ӹ��ݱ��ص�ֵ�ϴ���ѯ
  Sqlstr:wideString;


{$R *.dfm}

////��Ҫ�˴�   ��Ϊ˫��ֻ��ѡȡһ������
procedure TfmgoodCodeSelPei.FormActivate(Sender: TObject);
begin
  inherited;
end;

///
procedure TfmgoodCodeSelPei.btnpagedownClick(Sender: TObject);
var
  i:Integer;
  t_sql,str1,strend:wideString;
  quedata:olevariant;
  lStart, lEnd : Integer;
begin
  inherited;
//   lStart := GetTickCount;
     if not dmmain.DSquery.Active then exit;

    screen.Cursor := crhourglass;
   //�ص���DBGRID �Ļ���
   dmmain.dsquery.DisableControls;

    if combobox1.Text = 'ȫ��' then
    begin
      if (show_mode='�����ջ���') or (show_mode='�ŵ��˻����ⵥ') or (show_mode='�ŵ������˻����뵥') then
      begin
        t_sql:='select  *  from  [vSelectGoods]  where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';
        T_sql := t_sql + ' and breed = ' + ''''+trim(cbbreed.text)+''''+' and storage_no='+''''+trim(shopid)+''''; //���ݿ�����ͣ�
      end else
      begin
         t_sql:='select  *  from  [Vgoodscodeprice]  where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';
         T_sql := t_sql + ' and breed = ' + ''''+trim(cbbreed.text)+'''';  //ѡ����Ʒ
      end;
    end else
    begin
      if (show_mode='�����ջ���') or (show_mode='�ŵ��˻����ⵥ') or (show_mode='�ŵ������˻����뵥') then
      begin
        t_sql:='select top ' + trim(ComboBox1.Text) +' *  from  [vSelectGoods]  where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';
        T_sql := t_sql + ' and breed = ' + ''''+trim(cbbreed.text)+''''+' and storage_no='+''''+trim(shopid)+''''; //���ݿ�����ͣ�
      end else
      begin
         t_sql:='select top ' + trim(ComboBox1.Text) +' *  from  [Vgoodscodeprice]  where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';
         T_sql := t_sql + ' and breed = ' + ''''+trim(cbbreed.text)+'''';  //ѡ����Ʒ
      end;
    end;
    str1 := ' and  id > '+ inttostr(localcount);
    strend := T_sql + str1;

///getmore �����ж�LOCALCOUNT�Ƿ����RECORDCOUNT�����������ִ�С� ���������Ժ��������Ϊ0

  try
    ipubtemp.ty_query(strend,quedata);
    if not varisnull(quedata) then
    begin
     if dmmain.dsquery.Active then dmmain.dsquery.Close;
      dmmain.dsquery.Open;
      dmmain.dsquery.AppendData(quedata,true);
       dmmain.dsquery.Last;
      dmmain.dsquery.EnableControls;
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


procedure TfmgoodCodeSelPei.FormShow(Sender: TObject);
var
  t_sql:string;
begin
  inherited;
 ///////�����
  t_sql:='select * from  [goods_type]';
//  t_sql:='select distinct type  from  [goods_code]';
  GetDataToComBoX(cbtype,t_sql,'type');
  cbtype.ItemIndex := -1;
  count1:=0;count2:=0;
end;

procedure TfmgoodCodeSelPei.CBTypeChange(Sender: TObject);
var
  t_sql:string;
begin
  inherited;
  if dmmain.DSquery.Active then dmmain.DSquery.Close;
  t_sql:='select  distinct brand from  [goods_code] where type ='+''''+trim(cbtype.text)+'''';
  GetDataToComBoX(cbBrand,t_sql,'brand');
  cbBrand.ItemIndex := -1;
  cbbreed.Clear;

end;

procedure TfmgoodCodeSelPei.cbBrandChange(Sender: TObject);
var
  t_sql:string;
begin
  inherited;
  if dmmain.DSquery.Active then dmmain.DSquery.Close;
  if cbtype.Text = '' then exit;
  t_sql:='select distinct breed  from  [goods_code] where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';
  GetDataToComBoX(cbBreed,t_sql,'breed');
  cbBreed.ItemIndex := -1;
end;

procedure TfmgoodCodeSelPei.CbBreedChange(Sender: TObject);
var
  t_sql:string;
  quedata:olevariant;
  //TempInterface: IromecheckDisp;   //ydy modify
begin
  inherited;
////////////��ѯ����

    if cbbrand.Text = '' then exit;

    screen.Cursor := crhourglass;
   //�ص���DBGRID �Ļ���
   dmmain.dsquery.DisableControls;
   if (show_mode='�����ջ���') or (show_mode='�ŵ��˻����ⵥ') or (show_mode='�ŵ������˻����뵥') then
   begin
     t_sql:='select top 20 *  from  [vSelectGoods]  where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';
     T_sql := t_sql + ' and breed = ' + ''''+trim(cbbreed.text)+''''+' and storage_no='+''''+trim(shopid)+''''; //���ݿ�����ͣ�
   end else
   begin  //��������
     t_sql:='select top 20 *  from  [Vgoodscodeprice]  where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';
     T_sql := t_sql + ' and breed = ' + ''''+trim(cbbreed.text)+'''';  //ѡ����Ʒ
   end;
  try
   ipubtemp.ty_query(t_sql,quedata);
   if not varisnull(quedata) then
    begin
     if dmmain.DSquery.Active then dmmain.dsquery.Close;
      dmmain.dsquery.Open;
      dmmain.dsquery.Data:=quedata;
      ///ydy add
       dmmain.dsquery.Last;
       edtRecNo.Text := '��ǰ������: '+inttostr(dmmain.dsquery.recordcount)+'��';

    //���´�
      dmmain.dsquery.EnableControls;
      dbgrid1.Refresh;
      //�õ��˴β�ѯ�ļ�ֵ
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
  //�ͷŽӿ�
  screen.Cursor :=  crdefault;
end;


//////ѡ������ ����
procedure TfmgoodCodeSelPei.btnQueryClick(Sender: TObject);
var x,i,countmy:integer;
   BookmarkList: TBookmarkList;
   TempBookmark: TBookmark;
begin


DBGrid1.Datasource.Dataset.DisableControls;

with DBgrid1.SelectedRows do
  if Count > 0 then
      begin

        if show_mode = '�ŵ��˻����ⵥ' then
        begin
        countmy :=FmPosQuestBillstr.sgorder.RowCount -1;
        FmPosQuestBillstr.sgorder.RowCount := FmPosQuestBillstr.sgorder.RowCount + count -1;   ///������
        TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
        for x:= 0 to Count - 1 do
        begin
          if IndexOf(Items[x]) > -1 then
          begin
            DBGrid1.Datasource.Dataset.Bookmark:= Items[x];
            //�õ�ѡ��������
        //    showmessage(DBGrid1.Datasource.Dataset.Fields[1].AsString);

            with  FmPosQuestBillStr do
            begin
              sgorder.cells[0,countmy+ x] := inttostr(countmy+ x);
              sgorder.Cells[1,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('type').AsString);
              sgorder.Cells[2,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_NO').AsString);
              sgorder.Cells[3,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_Name').AsString);
              sgorder.Cells[6,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('base_unit').AsString);
              sgorder.Cells[19,countmy +x ] := '0000100001';
              sgorder.Cells[16,countmy +x ] := '10';
            end;
          end;
        end;
        DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
        DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
       end;
///////��������
        if show_mode = '��������' then
        begin
        countmy :=FmAskGoodsPlan.sgorder.RowCount -1;
        FmAskGoodsPlan.sgorder.RowCount := FmAskGoodsPlan.sgorder.RowCount + count -1;   ///������
        TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
        for x:= 0 to Count - 1 do
        begin
          if IndexOf(Items[x]) > -1 then
          begin
            DBGrid1.Datasource.Dataset.Bookmark:= Items[x];
            //�õ�ѡ��������
        //    showmessage(DBGrid1.Datasource.Dataset.Fields[1].AsString);

            with  FmAskGoodsPlan do
            begin
              sgorder.cells[0,countmy+ x] := inttostr(countmy+ x);
              sgorder.Cells[1,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('type').AsString);
              sgorder.Cells[2,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_NO').AsString);
              sgorder.Cells[3,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_Name').AsString);
              sgorder.Cells[4,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('base_unit').AsString);
              sgorder.Cells[6,countmy +x] :='1';
              sgorder.Cells[8,countmy +x] :='1';
              sgorder.Cells[10,countmy +x] :='0';
              sgorder.Cells[11,countmy +x ] := '10';
            end;
          end;
        end;
        DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
        DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
       end;

        if show_mode = '�ŵ������˻����뵥' then
        begin
        countmy :=FmPosAskBackBill.sgorder.RowCount -1;
        FmPosAskBackBill.sgorder.RowCount := FmPosAskBackBill.sgorder.RowCount + count -1;   ///������
        TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
        for x:= 0 to Count - 1 do
        begin
          if IndexOf(Items[x]) > -1 then
          begin
            DBGrid1.Datasource.Dataset.Bookmark:= Items[x];
            //�õ�ѡ��������
        //    showmessage(DBGrid1.Datasource.Dataset.Fields[1].AsString);

            with  FmPosAskBackBill do
            begin
              sgorder.cells[0,countmy+ x] := inttostr(countmy+ x);
              sgorder.Cells[1,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('type').AsString);
              sgorder.Cells[2,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_NO').AsString);
              sgorder.Cells[3,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_Name').AsString);
              sgorder.Cells[4,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('base_unit').AsString);
              sgorder.Cells[11,countmy +x ] := '10';
            end;
          end;
        end;
        DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
        DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
       end;

//////////////////////
        if show_mode = '�����ջ���' then
        begin
        countmy :=FmPosSendBill.sgorder.RowCount -1;
        FmPosSendBill.sgorder.RowCount := FmPosSendBill.sgorder.RowCount + count -1;   ///������
        TempBookmark:= DBGrid1.Datasource.Dataset.GetBookmark;
        for x:= 0 to Count - 1 do
        begin
          if IndexOf(Items[x]) > -1 then
          begin
            DBGrid1.Datasource.Dataset.Bookmark:= Items[x];
            //�õ�ѡ��������
        //    showmessage(DBGrid1.Datasource.Dataset.Fields[1].AsString);

            with  FmPosSendBill do
            begin
              sgorder.cells[0,countmy+ x] := inttostr(countmy+ x);
              sgorder.Cells[1,countmy+ x] := trim(DBGrid1.Datasource.Dataset.fieldbyname('type').AsString);
              sgorder.Cells[2,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_NO').AsString);
              sgorder.Cells[3,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('Goods_Name').AsString);
              sgorder.Cells[6,countmy +x] := trim(DBGrid1.Datasource.Dataset.Fieldbyname('base_unit').AsString);
              sgorder.Cells[8,countmy +x] := trim('0');
              sgorder.Cells[21,countmy +x] := trim(inttostr(DBGrid1.Datasource.Dataset.Fieldbyname('stock_amount').AsInteger));
              sgorder.Cells[19,countmy +x ] := '0000100001';    ////???
              sgorder.Cells[16,countmy +x ] := '10';
            end;
          end;
        end;
        DBGrid1.Datasource.Dataset.GotoBookmark(TempBookmark);
        DBGrid1.Datasource.Dataset.FreeBookmark(TempBookmark);
       end;

  end else
  begin
    Application.MessageBox('��û��ѡ����Ʒ����ѡ����Ʒ��',pchar(application.Title),mb_iconinformation);
    exit;
  end;

  DBGrid1.Datasource.Dataset.EnableControls;
  close;


end;

procedure TfmgoodCodeSelPei.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if key=#13 then btnquery.Click;
end;

procedure TfmgoodCodeSelPei.DBGrid1TitleClick(Column: TColumn);
begin
  inherited;
  if (not dbgrid1.DataSource.DataSet.Active ) then exit;
  if trim(column.Field.AsString)='' then exit;
  sortgrid(column.Field.FieldName,dmmain.DSquery,dbgrid1,column);
end;

procedure TfmgoodCodeSelPei.DBGrid1DblClick(Sender: TObject);
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
  if show_mode = '��������' then
  begin
    with FmAskGoodsPlan do
    begin
      rows:=sgorder.RowCount;
      if  sgorder.Cells[1,rows-1] = '' then rows := rows -1   //ydy 2004-14 add
      else  sgorder.RowCount := sgorder.RowCount + 1;
      sgorder.Cells[0,rows] := inttostr(rows);   //���
      sgorder.Cells[1,rows]:=trim(dmmain.dsquery.fieldbyname('type').AsString);
      sgorder.Cells[2,rows]:=trim(dmmain.dsquery.fieldbyname('goods_no').AsString);
      sgorder.Cells[3,rows]:=trim(dmmain.dsquery.fieldbyname('goods_name').AsString);
      sgorder.Cells[4,rows] := trim(dmmain.dsquery.Fieldbyname('base_unit').AsString);
      sgorder.Cells[6,rows] :='1';
      sgorder.Cells[8,rows] :='1';
      sgorder.Cells[10,rows] :='0';
      sgorder.Cells[11,rows ] := '10';
      dmmain.dsquery.Close;
      self.close;
    end;
  end;
  if show_mode='�����ջ���' then
  begin
    with FmPosSendBill do
    begin
      rows:=sgorder.RowCount;
      if  sgorder.Cells[1,rows-1] = '' then rows := rows -1   //ydy 2004-14 add
      else  sgorder.RowCount := sgorder.RowCount + 1;
       sgorder.Cells[0,rows] := inttostr(rows);   //���
      sgorder.Cells[1,rows]:=trim(dmmain.dsquery.fieldbyname('type').AsString);
      sgorder.Cells[2,rows]:=trim(dmmain.dsquery.fieldbyname('goods_no').AsString);
      sgorder.Cells[3,rows]:=trim(dmmain.dsquery.fieldbyname('goods_name').AsString);
      sgorder.Cells[6,rows] := trim(dmmain.dsquery.Fieldbyname('base_unit').AsString);
      sgorder.Cells[8,rows] := trim('0');
      sgorder.Cells[21,rows] := trim(inttostr(dmmain.dsquery.Fieldbyname('stock_amount').AsInteger));
      sgorder.Cells[19,rows ] := '0000100001';    ////???
      sgorder.Cells[16,rows ] := '10';
      dmmain.dsquery.Close;
      self.close;
    end;
  end;

end;

procedure TfmgoodCodeSelPei.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMMAIN.DSquery.Close;
  dmmain.DSquery.Data:=null;
  inherited;

end;

end.
