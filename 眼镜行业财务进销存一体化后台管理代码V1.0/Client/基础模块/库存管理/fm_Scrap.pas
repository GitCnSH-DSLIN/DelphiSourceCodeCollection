unit fm_Scrap;
////2004-4-8 modify
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fm_Base, Grids, DBGrids, StdCtrls, ExtCtrls, Buttons, Menus;

type
  TfmScrap = class(TfmBase)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn7: TBitBtn;
    Panel3: TPanel;
    Label9: TLabel;
    edtremakt: TEdit;
    Label1: TLabel;
    Label4: TLabel;
    edtnewdate: TEdit;
    Label3: TLabel;
    edtcode: TEdit;
    Label6: TLabel;
    edtnewmen: TEdit;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    sgorder: TStringGrid;
    btnSave: TBitBtn;
    Bevel1: TBevel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Bevel2: TBevel;
    Label5: TLabel;
    EdtTotalCount: TLabel;
    Label10: TLabel;
    edttotals: TLabel;
    Label7: TLabel;
    CmbG: TComboBox;
    Label8: TLabel;
    CmbC: TComboBox;
    Memo1: TMemo;
    BitBtn2: TBitBtn;
    btnprint: TBitBtn;
    procedure BitBtn7Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure sgorderDblClick(Sender: TObject);
    procedure sgorderSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgorderKeyPress(Sender: TObject; var Key: Char);
    procedure btnSaveClick(Sender: TObject);
    procedure sgorderDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnprintClick(Sender: TObject);
  private
    { Private declarations }
    flags:string;
    part_no,stockid:widestring;
    function readdata:boolean; // �����ݣ�
    procedure init;
    ///ydy add 2004-4-14
    procedure DeleteRow(Row: Integer);
    procedure TotalCount;  //���ܼ���
    procedure ClearGrid;
  public
    { Public declarations }
    showmedel:string;
    maxnumber,state:integer;
    StockNum_List:TstringList;    ///���ڴ��һ�����ݸ��ԵĿ������
  end;

var
  fmScrap: TfmScrap;

implementation
uses  dlg_bsselect,UntgoodCodeSelStr, func, untdatadm, Unitreportxf;

var
  pcol,prow:integer;

{$R *.dfm}
function tfmscrap.readdata:boolean;
var
  temp:widestring;
  i:integer;
  r:boolean;
begin
  r:=false;
  if Public_Do='damage_0002' then
  begin
    temp:='select * from dp_scrap as a,dp_scrapdetail as b,goods_prices as c where c.goods_no=b.sd_ccode and a.s_code=b.sd_scode and a.s_code='+''''+trim(list_no)+'''';
    dmmain.CDSquery2.Close;
    dmmain.CDSquery2.Data:=NULL;
    dmmain.CDSquery2.Data:=adisp.resultrecord(temp);
    try
    dmmain.CDSquery2.Open;
     temp:='select * from dp_scrap where s_code='+''''+trim(list_no)+''''; //������
    if dmmain.CDSexecsql.Active then dmmain.CDSexecsql.Close;
    dmmain.CDSexecsql.Data:=null;
    dmmain.CDSexecsql.Data:=adisp.execSql(temp);
    dmmain.CDSexecsql.Open; 
    r:=true;
    bitbtn1.Enabled:=false;
    flags:='1';
    except
    end;
    edtnewdate.text:=dmmain.CDSquery2.fieldbyname('s_newdate').AsString;
    edtnewmen.text:=dmmain.CDSquery2.fieldbyname('s_newman').AsString;
    edtcode.text:=dmmain.CDSquery2.fieldbyname('s_code').AsString;
    cmbg.text:=dmmain.CDSquery2.fieldbyname('s_operater').AsString;
    cmbc.text:=dmmain.CDSquery2.fieldbyname('s_auditer').AsString;
    edtremakt.text:=dmmain.CDSquery2.fieldbyname('s_remark').AsString;
    part_no:=dmmain.CDSquery2.fieldbyname('s_shop').AsString;
    //stockid
    temp:='select storageid from part where part_no='+''''+trim(part_no)+'''';
    dmmain.CDSexecsql.Close;
    dmmain.CDSexecsql.Data:=null;
    try
    dmmain.CDSexecsql.Data:=adisp.execSql(temp);
    dmmain.CDSexecsql.Open;
    stockid:=trim(dmmain.CDSexecsql.fieldbyname('storageid').AsString);
    dmmain.CDSexecsql.Close;
    dmmain.CDSexecsql.Data:=null;
    except
      exit;
    end;
    ///
    sgorder.RowCount:=dmmain.CDSquery2.RecordCount+1;
    for i:=1 to dmmain.CDSquery2.RecordCount do
    begin
      sgorder.Cells[0,i]:=inttostr(i);
      sgorder.Cells[1,i]:=trim(dmmain.CDSquery2.fieldbyname('sd_ccode').AsString);
      sgorder.Cells[2,i]:=trim(dmmain.CDSquery2.fieldbyname('sd_cname').AsString);
      sgorder.Cells[4,i]:=trim(dmmain.CDSquery2.fieldbyname('sd_ccount').AsString);
      sgorder.Cells[8,i]:=trim(dmmain.CDSquery2.fieldbyname('baseprice').AsString);
      dmmain.CDSquery2.Next;
    end;
   GetDataPrint(dmmain.cdsprintmaster,dmmain.CDsquery2);
  end;
  result:=r;
end;
procedure tfmscrap.init;
var
  maks,sql,s_newdate:string;
  t_sql:widestring;
begin
  s_newdate:=formatdatetime('yyyy''-''mm''-''dd',date);
  sql:='select max(right(s_Code,4)) from DP_scrap where s_newdate='+''''+s_NewDate+''''+' and s_shop='+''''+trim(Handle_Part)+''''; //5-19 ���ű��
  maks:='BS-'+Handle_Part+trim(handle_no); //shopid 5-11 �ò��ű�ţ�
  edtcode.Text:=setcode(sql,maks); //Autoid
  edtremakt.Clear;
  flags:='1';
  state:=0;
  ClearGrid;
  t_sql:='select p_name from dp_person where p_workid='+''''+trim(Handle_Part)+'''';
  GetDataToComBoX(cmbg,t_sql,'p_name');
  cmbc.Items:=cmbg.Items;
  EdtTotalCount.Caption :='';
  edttotals.Caption :='';

end;

procedure TfmScrap.BitBtn7Click(Sender: TObject);
begin
  inherited;
  case Application.MessageBox('����ñ�����?','��ʾ��Ϣ',mb_iconquestion+mb_YESNOCancel) of
    idYes: btnSave.Click;
    idNo: Close;
    idCancel :Abort;
  end;
end;

procedure TfmScrap.FormShow(Sender: TObject);
var
  t_sql :string;
begin
  inherited;
  sgorder.ColWidths[0] := 20;
  sgorder.Cells[1,0]:='��Ʒ���';
  sgorder.ColWidths[2]:=100;      //���� ��Ʒ���� �еĿ��
  sgorder.Cells[2,0]:='��Ʒ����';
  sgorder.Cells[3,0]:='��Ʒ����';
  sgorder.Cells[4,0]:='��Ʒ����';
  sgorder.Cells[5,0]:='��Ʒ�ۿ�';
  sgorder.Cells[6,0]:='�ۿۺ󵥼�';
  sgorder.Cells[7,0]:='���';
  sgorder.ColWidths[8]:=0; //�ɱ���;
  sgorder.ColWidths[0] := 20;
  sgorder.ColWidths[1] := 130;
  sgorder.ColWidths[2] := 190;
  sgorder.ColWidths[6] := 70;

  if not readdata then
  begin
    init;
     edtnewdate.Text:=formatdatetime('yyyy''-''mm''-''dd',Date);
    edtnewmen.Text :=trim(Handle_Man);
    //t_sql:='select * from  [Chang] where Part ='+''''+trim(shopid)+'''';
    //GetDataToComBoX(cmbg,t_sql,'Employe_Name');
    //cmbg.ItemIndex := -1;
    //cmbc.Items := cmbg.Items;
  end;
end;

procedure TfmScrap.BitBtn1Click(Sender: TObject);
begin
  inherited;
  fmbsselect:=tfmbsselect.Create(self);
  fmbsselect.ShowModal;
  fmbsselect.Free;
  flags:='2';
end;

procedure TfmScrap.sgorderDblClick(Sender: TObject);
var
  i:integer;
begin
  inherited;
  if flags='1' then
  begin
  if pcol in [1,2,3] then
    begin
     fmgoodCodeSelStr:= TfmgoodCodeSelStr.Create(nil);
     try
     fmgoodcodeselStr.show_mode:='2';
     fmgoodcodeselStr.ShowModal;
     finally
     fmgoodcodeselStr.Free;
     end;
     memo1.Lines := StockNum_List;  ///test
{
      with tfmgoods.Create(self) do
      try
        show_mode:='2';
        ShowModal;
      finally
        Free;
      end;
}
    end;
  if pcol = 4 then  //��������
  begin
   for i := prow+1 to sgorder.rowcount -1 do
   begin
   sgorder.cells[4,i]:= sgorder.cells[4,prow];
   //ͬʱҪ������
   if strtoint(sgorder.Cells[4,i]) <= strtoint(StockNum_List[i-1]) then
   begin
      if trim(sgorder.Cells[6,i])<>'' then
      begin
        sgorder.Cells[7,i]:=floattostr(strtofloat(sgorder.Cells[6,i])*strtofloat(sgorder.Cells[4,i])); // ���ۿ۵���
      end else
      begin
        sgorder.Cells[7,i]:=floattostr(strtofloat(sgorder.Cells[3,i])*strtofloat(sgorder.Cells[4,i]));  //���ۿ۵���
      end;
      TotalCount; 
   end
   else  begin
      Application.MessageBox('���������ѳ�������Ʒ������������������룡',pchar(application.Title),mb_iconwarning);
      sgorder.Cells[4,prow] := '';     //�������
      exit;
   end;

   end;
  end;
  end;
end;

procedure TfmScrap.sgorderSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  inherited;
  pcol:=acol;
  prow:=arow;
end;

procedure TfmScrap.sgorderKeyPress(Sender: TObject; var Key: Char);
var
   i:integer;
begin
  inherited;
  if flags='1' then
  begin
    if pcol in [4] then
    begin
      if not (key in ['0'..'9',#8,'.']) then
      begin
        key:=#0;
      end else
      begin
        if key<>#8 then
        begin
          if pcol=4 then
          begin
            if sgorder.Cells[4,prow]='0' then
            begin
            sgorder.Cells[4,prow] :=key ;
            end else
            begin
              sgorder.Cells[4,prow]:=sgorder.Cells[4,prow]+key;
            end;
          end;
        end else
        begin
          if pcol=4 then
          begin
            sgorder.Cells[4,prow]:='0';  //�����˸����;
            sgorder.Cells[7,prow]:='';
             //���ܼ���
           TotalCount;
          end;
          exit;
        end;
      end;
    end;
    if trim(sgorder.Cells[3,prow])<>'' then
    begin
//      if strtoint(sgorder.Cells[4,prow]) <= maxnumber then
      if strtoint(sgorder.Cells[4,prow]) <= strtoint(StockNum_List[prow-1]) then
      begin
        if trim(sgorder.Cells[6,prow])<>'' then
        begin
          sgorder.Cells[7,prow]:=floattostr(strtofloat(sgorder.Cells[6,prow])*strtofloat(sgorder.Cells[4,prow])); // ���ۿ۵���
        end else
        begin
          sgorder.Cells[7,prow]:=floattostr(strtofloat(sgorder.Cells[3,prow])*strtofloat(sgorder.Cells[4,prow]));  //���ۿ۵���
        end;
      end else
      begin
        Application.MessageBox('���������ѳ�������Ʒ������������������룡',pchar(application.Title),mb_iconwarning);
        sgorder.Cells[4,prow] := '';     //�������
        exit;
      end;
    end else
    begin
      sgorder.Cells[7,prow]:='0';
    end;
  end;

    //���ܼ���
    TotalCount;

end;

procedure TfmScrap.btnSaveClick(Sender: TObject);

var
  i,j,flag:integer;
  sql:widestring;
  start,ends,checkcode:olevariant;
  numbers,s_codes,goodsno,fieldnames:widestring;
  ZHbeg,zhend :string;
  temp:widestring;
begin
  inherited;
  if (trim(cmbg.Text)='') or (trim(cmbc.Text)='') then
  begin
    application.MessageBox('��ѡ�������ˣ�',pchar(application.Title),mb_iconinformation);
    cmbg.SetFocus;
    exit;
  end;
  if trim(sgorder.Cells[1,1])='' then
  begin
    application.MessageBox('��ѡ������Ʒ��ϸ��',pchar(application.Title),mb_iconinformation);
    exit;
  end;
  if not dmmain.CDSscrap.Active then dmmain.CDSscrap.Open;
  if Public_Do='damage_0001' then
  begin
  dmmain.CDSscrap.Insert;
  dmmain.CDSscrap.FieldByName('s_code').AsString:=trim(edtcode.Text );
  dmmain.CDSscrap.FieldByName('s_shop').AsString:=trim(Handle_Part); //5-19
  dmmain.CDSscrap.FieldByName('s_newdate').AsString:=formatdatetime('yyyy''-''mm''-''dd',date);
  dmmain.CDSscrap.FieldByName('s_newman').AsString:=trim(edtnewmen.Text );
  dmmain.CDSscrap.FieldByName('s_remark').AsString:=trim(edtremakt.Text);
  dmmain.CDSscrap.FieldByName('s_operater').AsString:=trim(cmbg.Text);
  dmmain.CDSscrap.FieldByName('s_auditer').AsString:=trim(cmbc.Text);
  ////////add auditer//////////////////////
  dmmain.CDSscrap.FieldByName('s_state').AsString:='0';
  /////////////////////////////////////////
  dmmain.CDSscrap.Post;
  if  not dmmain.CDSscrapdetail.Active then dmmain.CDSscrapdetail.Open;
  j:=sgorder.RowCount-1;
  for i:=1 to  j do
  begin
    with dmmain.CDSscrapdetail do
    begin
      insert;
      fieldbyname('sd_scode').AsString:=trim(edtcode.Text);
      fieldbyname('sd_ccode').AsString:=trim(sgorder.Cells[1,i]);
      fieldbyname('sd_cname').AsString:=trim(sgorder.Cells[2,i]);
      fieldbyname('sd_ccount').AsString:=trim(sgorder.Cells[4,i]);
      post;
    end;
  end;
  dmmain.cdsReceipt.Close;
  dmmain.cdsReceipt.Open;
  dmmain.cdsReceipt.Append;
  dmmain.cdsReceipt.FieldByName('Receipt_NO').AsString:=Trim(Edtcode.Text);
  dmmain.cdsReceipt.FieldByName('Receipt_Name').AsString:='��汨��';
  dmmain.cdsReceipt.FieldByName('Copy_Date').AsString:=Trim(Edtnewdate.Text);
  dmmain.cdsReceipt.FieldByName('Proposer').AsString:=Trim(edtnewmen.Text);
  dmmain.cdsReceipt.FieldByName('Check_Result').Asinteger:=0;
  dmmain.cdsReceipt.FieldByName('Flag_Sign').AsString:='�ݸ�';
  dmmain.cdsReceipt.FieldByName('Condense').AsString:=Trim(edtremakt.Text);
  dmmain.cdsReceipt.FieldByName('Re_part').AsString:=trim(Handle_Part);
  dmmain.cdsReceipt.Post;
  try
    //ApplyUpdates(-1);
    //dmmain.cdsOrderDetail.ApplyUpdates(-1);
    loadborlanced(dmmain.cdsReceipt);
    loadborlanced(dmmain.CDSscrap);
    loadborlanced(dmmain.CDSscrapdetail);
    if flags='2' then
    begin
      sql:='update dp_checkdetail set cd_state='+''''+'5'+''''+' where cd_ccount>0 and cd_state='+''''+'2'+''''+' and cd_checkcode in (select c_code from dp_check where c_shop='+''''+trim(Handle_Part)+''''+' )';
      ipubtemp.scrapsate(sql);//�̵㵥�̿���  wg edit 2004-2-26
    end;
  except
  //���븺���ݴ�
    application.MessageBox('��������ֹ����',pchar(application.Title),mb_iconwarning);
    savefromdata(dmmain.CDSscrap,'scrap');
    savefromdata(dmmain.cdsscrapDetail,'scrapdetail');
    exit;
  end;
  init;
  end else
  begin
    if not bedit then
    begin
      if trim(Handle_Man)<>trim(edtnewmen.Text) then
      begin
        Application.MessageBox('�����޸����ݣ�',pchar(application.Title),mb_iconinformation);
        exit;
      end;
    end;
     if  dmmain.CDSexecsql.Active then dmmain.CDSexecsql.close;
    temp:='select * from dp_scrap where sd_scode'+''''+trim(list_no)+'''';
    dmmain.CDSexecsql.Data:=null;
    dmmain.CDSexecsql.Data :=adisp.execSql(temp);
    dmmain.CDSexecsql.Open;
    dmmain.CDSexecsql.edit;
    dmmain.CDSexecsql.FieldByName('s_newdate').AsString:=formatdatetime('yyyy''-''mm''-''dd',date);
    dmmain.CDSexecsql.FieldByName('s_newman').AsString:=trim(edtnewmen.Text );
    dmmain.CDSexecsql.FieldByName('s_remark').AsString:=trim(edtremakt.Text);
    dmmain.CDSexecsql.FieldByName('s_operater').AsString:=trim(cmbg.Text);
    dmmain.CDSexecsql.FieldByName('s_auditer').AsString:=trim(cmbc.Text);
    ////////add auditer//////////////////////
    dmmain.CDSexecsql.FieldByName('s_state').AsString:='0';
    /////////////////////////////////////////
    dmmain.CDSexecsql.Post;
    try
    dmmain.CDSexecsql.ApplyUpdates(-1);
    except
      application.MessageBox('��������ֹ����',pchar(application.Title),mb_iconwarning);
      exit;
    end;
    if  dmmain.CDSexecsql.Active then dmmain.CDSexecsql.close;
    temp:='select * from dp_scrapdetail where sd_scode'+''''+trim(list_no)+'''';
    dmmain.CDSexecsql.Data:=null;
    dmmain.CDSexecsql.Data :=adisp.execSql(temp);
    dmmain.CDSexecsql.Open;
    j:=sgorder.RowCount-1;
    for i:=1 to  j do
    begin
      with dmmain.CDSexecsql do
      begin
        edit;
        fieldbyname('sd_ccount').AsString:=trim(sgorder.Cells[4,i]);
        post;
      end;
    end;
    try
    dmmain.CDSexecsql.ApplyUpdates(-1);
    except
      application.MessageBox('��������ֹ����',pchar(application.Title),mb_iconwarning);
      exit;
    end;
  end;
end;

procedure TfmScrap.sgorderDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  s:string;
  r:TRect;
begin
  inherited;
//ydy add ������ʾ��ɫ
 with Sender as Tstringgrid do
        begin
        if gdSelected in State then
        Canvas.Brush.Color:= clTeal; //clyellow;//clRed;
        Canvas.TextRect(Rect,Rect.Left,Rect.Top,' '+Cells[ACol,ARow]);
        if gdFocused in State then
        Canvas.DrawFocusRect(Rect);
        end;

//����ˮƽ���У�����ֱ����
with Sender as Tstringgrid do
    begin
      Canvas.FillRect(Rect);
      s:=Cells[ACol,ARow];
      r:=Rect;
      DrawText(Canvas.Handle,PChar(s),Length(s),r,DT_CENTER or DT_SINGLELINE or DT_VCENTER);
    end;

end;

procedure TfmScrap.N1Click(Sender: TObject);
var
  rows:integer;
begin
  inherited;
  rows:=sgorder.RowCount-1;
  if (trim(sgorder.Cells[1,rows])<>'') and (trim(sgorder.Cells[4,rows])<>'') then
  begin
    sgorder.RowCount:=sgorder.RowCount+1;
    sgorder.Rows[sgorder.RowCount-1].Text:='';
  end;
end;
//������
procedure TfmScrap.N2Click(Sender: TObject);
var
  i :integer;
begin
  inherited;
  if sgorder.RowCount=1 then
  begin
    Application.MessageBox('û�м�¼����ɾ��!','��ʾ��Ϣ',mb_iconwarning);
    exit;
  end;
  if Application.MessageBox('ȷʵҪɾ����¼��?','��ʾ��Ϣ',mb_iconquestion+mb_yesno)=idyes then
  begin
 //ydy add
     if sgorder.RowCount = 2 then   //ֻ������ڶ��е�����
     begin
     sgorder.Rows[sgorder.Row].Clear;
     if StockNum_List.Count>0 then
       StockNum_List.Clear;
     end;
    //ydy add
    if sgorder.RowCount > 2 then
    begin
    //ydy changed
    deleteRow(sgorder.row );        ///�ǶԵ�
    if  StockNum_List.Count>0 then
      StockNum_List.Delete(sgorder.row-1);    //��0��ʼ
    memo1.Lines := StockNum_List;  ///test
//    sgorder.RowCount:=sgorder.RowCount-1;
    end;
  end;
  ///2004-4-14 ɾ���Ժ�����д���
  for i:=1 to sgorder.RowCount-1 do
  begin
  sgorder.Cells[0,i] := inttostr(i);
  end;
  //���ܼ���
  TotalCount;

end;

//ɾ��һ��
procedure TfmScrap.DeleteRow(Row: Integer);
var
  i : integer;
begin
//���һ��ֱ��ɾ��
 if (Row = sgorder.RowCount-1) and (row >1)  then
    Sgorder.RowCount := Sgorder.RowCount - 1;

//�Զ�����
  if (Row < Sgorder.RowCount) and (Row > Sgorder.FixedRows-1) then
  begin
    if Row < Sgorder.RowCount - 1 then
    begin
      for i := Row to Sgorder.RowCount-1 do
        Sgorder.Rows[i] := Sgorder.Rows[i+1];
      Sgorder.RowCount := Sgorder.RowCount - 1;
    end;
  end;
end;

procedure TfmScrap.FormCreate(Sender: TObject);
begin
  inherited;
 StockNum_List := Tstringlist.create;  ///���ڴ��һ�����ݸ��ԵĿ������
end;

procedure TfmScrap.FormDestroy(Sender: TObject);
begin
  inherited;
  StockNum_List.Free;
end;

////���ܼ���
procedure TFmScrap.TotalCount;
var
  i:integer;
begin
    edttotals.caption :='0';
    EdtTotalCount.caption  :='0';
    for i:= 1 to  sgorder.RowCount -1 do
    begin
        //�ϼƽ��
       if   sgorder.Cells[7,i] <>'' then
       begin
       edttotals.caption := floattostrf(strtofloat(edttotals.caption)+strtofloat( sgorder.Cells[7,i]),ffFixed,11,2);
       end;
       if   sgorder.Cells[4,i] <>'' then
       begin
       //�ϼ�����
       EdtTotalCount.caption :=floattostr(strtofloat(edttotalcount.caption) + strtofloat(sgorder.Cells[4,i]));
       end;
     end;
end;

procedure TFmScrap.ClearGrid;
var
  i,j:integer;
begin
   ///////////ydy add to clear the stringgrid
   with sgorder do
   begin
      for i:=1 to colCount do
         for j:=1 to rowCount do
            cells[i,j]:='';
   end;
   sgorder.RowCount := 2;
end;

procedure TfmScrap.BitBtn2Click(Sender: TObject);
var
  user,wldwname,remarks:widestring;
  flag,inmethod,intof:olevariant;
  bz,i:integer;
  totals:double;
begin
  if Public_Do='damage_0001' then exit;
  if trim(sgorder.Cells[1,1])='' then exit;
  no:=trim(edtcode.Text);
  typed:='��汨��';
  user:=trim(Handle_No);
  flag:=adisp.receipted(no,typed,user,1,Handle_Part);
  if flag='3' then //
  begin
   ////�޸Ŀ�棬д���ⵥ
   bz:=2;
   try
   ipubtemp.stock(bz,stockid,Handle_Man,part_no); //wg edit 4-8
   totals:=0;
   for i:=1 to sgorder.RowCount-1 do
    begin
      if trim(sgorder.Cells[8,i])='' then sgorder.Cells[8,i]:='0';
      totals:=totals+(strtofloat(sgorder.Cells[8,i])* strtofloat(sgorder.Cells[4,i])); //�ѽ�����
    end;
    wldwname:='��';
    wldwno:='��';
    remarks:='��:'+shopid+'�ֿ� ��汨��';
    intof:=ipubtemp.MoneyTable(9,no,totals,user,user,user,wldwno,wldwname,shopid,remarks);
    if vartostr(intof)='1' then
    begin
      flag:='3';
    end else
    begin
      flag:='2';
    end;
   except
     application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
     exit;
   end;
  end;
  if flag='1' then
  begin
    application.MessageBox('��˳ɹ���',pchar(application.Title),mb_iconinformation);
    close;
    exit;
  end;
  if flag='2' then
  begin
    application.MessageBox('��Ȩ���н������',pchar(application.Title),mb_iconinformation);
    exit;
  end;
  if flag='3' then
  begin
    application.MessageBox('�����ϣ�',pchar(application.Title),mb_iconinformation);
    close;
    exit;
  end;
  if flag='4' then
  begin
    application.MessageBox('�������ϣ�',pchar(application.Title),mb_iconinformation);
    exit;
  end;
  if flag='5' then
  begin
    application.MessageBox('����˳ɹ���',pchar(application.Title),mb_iconinformation);
    exit;
  end;
  if flag='6' then
  begin
    application.MessageBox('���ݹ��ʺ󣬲��ܽ�����˻���ˣ�',pchar(application.Title),mb_iconinformation);
    exit;
  end;
  inherited;

end;

procedure TfmScrap.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmmain.CDSexecsql.Close;
  dmmain.CDSexecsql.Data:=null;
  dmmain.cdsprintmaster.Close;
  dmmain.cdsprintmaster.Data:=null;
  dmmain.CDSscrap.Close;
  dmmain.CDSscrap.Data:=null;
  dmmain.CDSscrapdetail.Close;
  dmmain.CDSscrapdetail.Data:=null;
  inherited;
end;

procedure TfmScrap.btnprintClick(Sender: TObject);
begin
  inherited;
   if dmmain.cdsprintmaster.IsEmpty then exit;
  fastrepxf:=tfastrepxf.Create(self);
  fastrepxf.filenames:='Scrap.ini';
  fastrepxf.ShowModal;
  fastrepxf.Free;
end;

end.

