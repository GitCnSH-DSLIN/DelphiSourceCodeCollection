unit Untnewshopgoods;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fm_Base, Grids, StdCtrls, ExtCtrls, Buttons;

type
  Tfmshopgoods = class(TfmBase)
    Panel1: TPanel;
    Panel2: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Cmd_Cancel: TSpeedButton;
    Panel3: TPanel;
    Edit1: TLabeledEdit;
    GroupBox1: TGroupBox;
    SpeedButton5: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton1: TSpeedButton;
    edtsendstock: TLabeledEdit;
    edtrestock: TLabeledEdit;
    edtp: TLabeledEdit;
    edtt: TLabeledEdit;
    edtrs: TLabeledEdit;
    edtrm: TLabeledEdit;
    Edit2: TLabeledEdit;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Cmd_Delete: TSpeedButton;
    Cmd_Add: TSpeedButton;
    gridbase: TStringGrid;
    Label2: TLabel;
    procedure Cmd_CancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure gridbaseDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure gridbaseSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure gridbaseKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton2Click(Sender: TObject);
    procedure gridbaseDblClick(Sender: TObject);
    procedure gridbaseMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Cmd_AddClick(Sender: TObject);
    procedure Cmd_DeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
    pcol,prow:integer;
    procedure forminit;
    procedure checkdata;
  public
    { Public declarations }
  end;

var
  fmshopgoods: Tfmshopgoods;

implementation

uses untdatadm, Unt_PubStrGrid, func,Public_Don, UntSQpspart, Login_Man,
  UntgoodCodeSelStr, Unitreportxf;

{$R *.dfm}
///////////////////////////////////
procedure tfmshopgoods.forminit;
VAR
 I:INTEGER;
 temp,make:string;
BEGIN
  for i:=0 to (self.ControlCount-1) do
  begin
    if (self.Components[i] is TCustomEdit) then
    begin
      (self.Components[i] as TCustomEdit).Clear;
    end;
  end;
  for i:=1 to gridbase.RowCount-1 do   //������񣬲���ֻ��ȥ�У������´��½�ʱ�����ظ�����
  gridbase.Rows[i].Clear;
      gridbase.RowCount:=2;

  InitialStrGrid(gridbase,'�µ��̻�');
  gridbase.ColCount:=gridbase.ColCount+1;
  gridbase.ColWidths[gridbase.ColCount-1]:=-1;
  if (Public_Do='edited') then exit;
  temp:='select max(right(stock_no,4)) from storage_jion where copy_date='+''''+formatdatetime('yyyy''-''mm''-''dd',date)+''''+' and part_no='+''''+trim(Handle_Part)+'''';
  make:='SNG-'+trim(Handle_Part)+trim(handle_no);//5-11�����в��ű��
  edit2.Text:=setcode(temp,make);
  edit1.Text:=formatdatetime('yyyy''-''mm''-''dd',date);
  edtt.Text:=trim(Handle_Man);
  edtsendstock.Text:=trim(shopid);
end;
procedure  Tfmshopgoods.checkdata;
var
  i:integer;
begin
  if trim(edit2.Text)='' then
  begin
    application.MessageBox('�����뵥�ݱ�ţ�',pchar(application.Title),mb_iconinformation);
    edit2.SetFocus;
    exit;
  end;
  if trim(edtsendstock.Text)='' then
  begin
    application.MessageBox('��ѡ�񷢻��ֿ⣡',pchar(application.Title),mb_iconinformation);
    edtsendstock.SetFocus;
    exit;
  end;
  if trim(edtrestock.Text)='' then
  begin
    application.MessageBox('��ѡ���ջ��ֿ⣡',pchar(application.Title),mb_iconinformation);
    edtrestock.SetFocus;
    exit;
  end;
  if trim(edtp.Text)='' then
  begin
    application.MessageBox('��ѡ�����ˣ�',pchar(application.Title),mb_iconinformation);
    edtp.SetFocus;
    exit;
  end;
  for i:=1 to gridbase.RowCount-1 do
  begin
    if trim(gridbase.Cells[1,i])='' then
    begin
      application.MessageBox('��ѡ����Ʒ��',pchar(application.Title),mb_iconinformation);
      gridbase.SetFocus;
      exit;
    end;
    if (trim(gridbase.Cells[3,i])='') or (trim(gridbase.Cells[3,i])='0') then
    begin
       application.MessageBox('��������Ʒ������',pchar(application.Title),mb_iconinformation);
       gridbase.SetFocus;
       exit;
    end;
  end;
end;
/////////////////////
/////////////////////////////
procedure Tfmshopgoods.Cmd_CancelClick(Sender: TObject);
var
  i:integer;
  sqlpub:widestring;
  flag:olevariant;
begin
  inherited;
   frm_Public_Don:=Tfrm_Public_Don.Create(self);
  frm_Public_Don.no:=trim(edit2.Text);
  frm_Public_Don.ShowModal;
  if Public_Do_Result='02' then
  begin
    checkdata;
    if Public_Do='edited' then
    begin
      if not bedit then
      begin
        if trim(Handle_Man)<>trim(edtt.Text) then
        begin
          Application.MessageBox('�����޸����ݣ�',pchar(application.Title),mb_iconinformation);
          exit;
        end;
      end;
      sqlpub:='delete from [storage_jion] where stock_no='+''''+trim(list_no)+'''';
      try
      flag:=adisp.updatesql(sqlpub);
      sqlpub:= 'delete from [storage_jion_detail] where stock_no='+''''+trim(list_no)+'''';
      flag:=adisp.updatesql(sqlpub);
      except
        Application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
        Exit;
      end;
    end;
    dmmain.cdsstorage_jion .Close;
    dmmain.cdsstorage_jion .Open;
    dmmain.cdsstorage_jion .Append;
    dmmain.cdsstorage_jion .FieldByName('Copy_Date').AsString:=edit1.Text; //¼������
    dmmain.cdsstorage_jion .FieldByName('Stock_NO').AsString:=edit2.Text;  //���ݱ��
    dmmain.cdsstorage_jion .FieldByName('sendStock_NO').AsString:=trim(edtsendstock.Text);     //�ֿ���
    dmmain.cdsstorage_jion .FieldByName('retailstock_no').AsString:=trim(edtrestock.Text);        //��������
    dmmain.cdsstorage_jion .FieldByName('Transactor').AsString:=edtt.Text;     //������
    dmmain.cdsstorage_jion .FieldByName('Proposer').AsString:=edtp.Text;      //�Ƶ���
    dmmain.cdsstorage_jion .FieldByName('resume').AsString:=edtrs.Text;       //ժҪ
    dmmain.cdsstorage_jion .FieldByName('Remark').AsString:=edtrm.Text;       //˵��
    dmmain.cdsstorage_jion .FieldByName('Part_no').AsString:=Handle_Part; //���ű��
    dmmain.cdsstorage_jion .Post;
    if Public_Do<>'edited' then
    begin
      dmmain.cdsReceipt.Close;
      dmmain.cdsReceipt.Open;
      dmmain.cdsReceipt.Append;
      dmmain.cdsReceipt.FieldByName('Receipt_NO').AsString:=trim(edit2.Text);
      dmmain.cdsReceipt.FieldByName('Receipt_Name').AsString:='�µ��̻�';
      dmmain.cdsReceipt.FieldByName('Copy_Date').AsString:=trim(edit1.Text);
      dmmain.cdsReceipt.FieldByName('Proposer').AsString:=trim(edtt.Text);
      dmmain.cdsReceipt.FieldByName('Condense').AsString:=trim(edtrs.Text);
      dmmain.cdsReceipt.FieldByName('Check_Result').Asinteger:=0;
      dmmain.cdsReceipt.FieldByName('Flag_Sign').AsString:='�ݸ�';
      dmmain.cdsReceipt.FieldByName('Re_part').AsString:=trim(Handle_Part);
      dmmain.cdsReceipt.Post;
    end;
    dmmain.cdsstorage_detail.Close;
   dmmain.cdsstorage_detail.Open;
    for i:=1 to gridbase.RowCount-1 do
    begin
     dmmain.cdsstorage_detail.Append;
     dmmain.cdsstorage_detail.FieldByName('Stock_NO').AsString:=edit2.Text; //���ݱ��
     dmmain.cdsstorage_detail.FieldByName('Goods_NO').AsString:=trim(gridbase.Cells[1,i]);  //��Ʒ���
     dmmain.cdsstorage_detail.FieldByName('Amount').AsString:=trim(gridbase.Cells[3,i]);  //�̻�����
     dmmain.cdsstorage_detail.FieldByName('ord').AsInteger:=i;    //���
     dmmain.cdsstorage_detail.Post;
    end;
    try
      if Public_Do<>'edited' then
      begin
        dmmain.cdsReceipt.ApplyUpdates(-1);
      end;
      dmmain.cdsstorage_jion.ApplyUpdates(-1);
      dmmain.cdsstorage_detail.ApplyUpdates(-1);
      close;
    except
      Application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
      Exit;
    end;
  end;

end;

procedure Tfmshopgoods.FormShow(Sender: TObject);
  var
  i:integer;
  tempstr:widestring;
begin
  forminit;
    if (Public_Do='edited')  then
    begin
      tempstr:='Select a.*,b.*,c.* from storage_jion as a, storage_jion_detail as b, Goods_code as c where a.stock_no=b.stock_no and b.goods_no=c.goods_no and a.Stock_NO='+''''+trim(List_No)+'''';
      dmmain.CDSquery2.Data:=null;
      dmmain.CDSquery2.Close;
      try
      dmmain.CDSquery2.Data:=adisp.resultrecord(tempstr);
      dmmain.CDSquery2.Open;
      gridbase.RowCount:= dmmain.CDSquery2.RecordCount+1;
      except
      end;
      if not dmmain.CDSquery2.IsEmpty then       //���ؼ�¼��Ϊ��ʱ��������Ҫ����Wy
      begin
          //
          edit1.Text:=ForMatDateTime('yyyy''-''mm''-''dd',dmmain.CDSquery2.FieldValues['Copy_Date']);
          edit2.Text:=dmmain.CDSquery2.FieldValues['Stock_NO'];
          edtsendstock.Text:=dmmain.CDSquery2.FieldValues['sendstock_NO'];
          edtrestock.Text:=dmmain.CDSquery2.FieldValues['retailstock_no'];
          edtt.Text:=dmmain.CDSquery2.FieldValues['Transactor'];
          edtp.Text:=dmmain.CDSquery2.FieldValues['Proposer'];
          edtrs.Text:=dmmain.CDSquery2.FieldValues['resume'];
          edtrm.Text:=dmmain.CDSquery2.FieldValues['Remark'];
          //******************
          for i:=1 to dmmain.CDSquery2.RecordCount  do //wy edit;
          begin
            gridbase.Cells[0,i]:=IntTostr(i); //��ʾ��0�е�i�е�����
            gridbase.Cells[1,i]:=trim(dmmain.CDSquery2.FieldByName('Goods_NO').AsString);
            gridbase.Cells[2,i]:=trim(dmmain.CDSquery2.FieldByName('Goods_Name').AsString);
            gridbase.Cells[3,i]:=trim(dmmain.CDSquery2.fieldbyname('Amount').AsString);
            gridbase.Cells[4,i]:=trim(dmmain.CDSquery2.fieldbyname('provider').AsString);
            gridbase.Cells[5,i]:=trim(dmmain.CDSquery2.FieldByName('memo').AsString);
            dmmain.CDSquery2.Next;
          end;
          GetDataPrint(dmmain.cdsprintmaster,dmmain.CDsquery2);
      end else
      begin
          application.MessageBox('�������Ѳ����ڣ���˶Ժ������',pchar(application.Title),mb_iconinformation);
      end;
    end;
end;

procedure Tfmshopgoods.SpeedButton1Click(Sender: TObject);
begin
  inherited;
   dlgSQpspart:=tdlgSQpspart.Create(self);
   dlgSQpspart.ShowModal;
   dlgSQpspart.Free;
   if dmmain.CDSdata.IsEmpty  then exit;
   edtsendstock.Text:=trim(dmmain.CDSdata.fieldbyname('storageid').AsString);
   dmmain.CDSdata.Close;
   dmmain.CDSdata.Data:=null;
end;

procedure Tfmshopgoods.SpeedButton5Click(Sender: TObject);
begin
  inherited;
  dlgSQpspart:=tdlgSQpspart.Create(self);
   dlgSQpspart.ShowModal;
   dlgSQpspart.Free;
   if dmmain.CDSdata.IsEmpty  then exit;
   edtrestock.Text:=trim(dmmain.CDSdata.fieldbyname('storageid').AsString);
   dmmain.CDSdata.Close;
   dmmain.CDSdata.Data:=null;
end;

procedure Tfmshopgoods.SpeedButton9Click(Sender: TObject);
begin
  inherited;
  Employe_Check:='';
  Employe_Check:='Storage_Umanage_Fad';
  Employe_Check_Result:='';
  frm_Login_Man:=Tfrm_Login_Man.Create(self);
  frm_Login_Man.Caption:='������ѡ��';
  frm_Login_Man.ShowModal;
  Edtp.Text := Employe_Check_Result;
end;

procedure Tfmshopgoods.gridbaseDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
  var
  s:string;
  r:TRect;
begin
//ydy add ������ʾ��ɫ
 with Sender as Tstringgrid do
        begin
        if gdSelected in State then
        Canvas.Brush.Color:= clTeal;  //clBlue; //clyellow;//clRed;
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

procedure Tfmshopgoods.gridbaseSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
  pcol:=acol;
  prow:=arow;
end;

procedure Tfmshopgoods.gridbaseKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if pcol=3 then
  begin
    if key in ['0'..'9',#8,#13,#37] then
    begin
      gridbase.Options:=gridbase.Options+[goediting];
    end else
    begin
      gridbase.Options:=gridbase.Options-[goediting];
      key:=#0;
    end;
  end else
  begin
    gridbase.Options:=gridbase.Options-[goediting];
    key:=#0;
  end;
end;

procedure Tfmshopgoods.SpeedButton2Click(Sender: TObject);
var
  user,temp,remarks,ofid:widestring;
  flag,intof:olevariant;
  totals:double;
  i:integer;
begin
  inherited;
   if Public_Do<>'edited'then exit;
  no:=trim(edit2.Text);
  typed:='�µ��̻�';
  user:=trim(Handle_No);
  try
  flag:=adisp.receipted(no,typed,user,1,Handle_Part);
  if flag='3' then //
  begin
    flag:=ipubtemp.OutNewShop(no);
  end;
  except
    //
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
    //exit;
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
end;

procedure Tfmshopgoods.gridbaseDblClick(Sender: TObject);
var
  i,j:integer;
begin
  inherited;
  if pcol in [1,2] then
  begin
   fmgoodCodeSelStr:= TfmgoodCodeSelStr.Create(self);
   try
   fmgoodcodeselStr.show_mode:='12';
   fmgoodcodeselStr.ShowModal;
   finally
   fmgoodcodeselStr.Free;
   end;
  end;
  if pcol = 3 then  //��������
  begin
    j:=gridbase.ColCount-1;
   for i := prow+1 to gridbase.rowcount -1 do
   begin
     gridbase.cells[3,i]:= gridbase.cells[3,prow];
     if trim(gridbase.cells[3,i-1])<>'' then
     begin
       if strtofloat(gridbase.cells[3,i-1])> strtofloat(gridbase.cells[j,i-1]) then
       begin
         application.MessageBox(pchar('����������������̻����������飡'),pchar(application.Title),mb_iconinformation);
         gridbase.SetFocus;
         exit;
       end;
     end;
  end;
  end;
end;

procedure Tfmshopgoods.gridbaseMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
  var
    i:integer;
begin
  inherited;
  for i:=1 to gridbase.RowCount-1do
  begin
    if (trim(gridbase.cells[3,i])<>'') and (trim(gridbase.cells[6,i])<>'') then
    begin
      if strtofloat(gridbase.cells[3,i])> strtofloat(gridbase.cells[6,i]) then
      begin
        application.MessageBox(pchar('����������������̻����������飡'),pchar(application.Title),mb_iconinformation);
        gridbase.cells[3,i]:='0';
        gridbase.SetFocus;
        exit;
      end;
    end;
  end;
end;

procedure Tfmshopgoods.Cmd_AddClick(Sender: TObject);
begin
  inherited;
  addgridrows(gridbase);
end;

procedure Tfmshopgoods.Cmd_DeleteClick(Sender: TObject);
begin
  inherited;
  deletegridrows(gridbase,prow);
end;

procedure Tfmshopgoods.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  dmmain.CDSquery2.Close;
  dmmain.CDSquery2.Data:=null;
  dmmain.cdsprintmaster.Close;
  dmmain.cdsprintmaster.Data:=null;
end;

procedure Tfmshopgoods.SpeedButton3Click(Sender: TObject);
begin
  inherited;
  if dmmain.cdsprintmaster.IsEmpty then exit;
  fastrepxf:=tfastrepxf.Create(self);
  fastrepxf.filenames:='NewShopGoods.ini';
  fastrepxf.ShowModal;
  fastrepxf.Free;
end;

end.
