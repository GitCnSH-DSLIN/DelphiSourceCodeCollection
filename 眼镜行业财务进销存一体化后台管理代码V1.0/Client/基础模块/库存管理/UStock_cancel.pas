unit UStock_cancel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fm_Base, Grids, StdCtrls, ExtCtrls, Buttons;

type
  TFmCancel = class(TfmBase)
    Panel1: TPanel;
    Panel2: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Label1: TLabel;
    Panel3: TPanel;
    Edit1: TLabeledEdit;
    GroupBox1: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Edit4: TLabeledEdit;
    Edit6: TLabeledEdit;
    Edit8: TLabeledEdit;
    Edit9: TLabeledEdit;
    Edit10: TLabeledEdit;
    Edit5: TLabeledEdit;
    Edit2: TLabeledEdit;
    Panel6: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Cmd_Delete: TSpeedButton;
    Cmd_Add: TSpeedButton;
    StringGrid1: TStringGrid;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Cmd_DeleteClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Pcol,Prow:integer;
    procedure init;
    function ReadData():boolean;
    Function CheckData():boolean;
    Function SaveData():boolean;
  public
    { Public declarations }
  end;

var
  FmCancel: TFmCancel;

implementation

uses func, untdatadm, Unt_PubStrGrid, Supply_Monad, Login_Man, Unitreportxf,
  Public_Don, UntgoodCodeSelStr;

{$R *.dfm}
//////////////////////
procedure tFmCancel.init;
var
  temp,make:string;
begin
    InitialStrGrid(stringgrid1,'����˻�');
    edit1.Text:=formatdatetime('yyyy''-''mm''-''dd',date);
    Edit8.Text:=Handle_Man;
    edit5.Text:=shopid;
    if public_do<>'Edited' then
    begin
    temp:='select max(right(stock_no,4)) from Cancel_strip where copy_date='+''''+formatdatetime('yyyy''-''mm''-''dd',date)+''''+' and shop_no='+''''+trim(Handle_Part)+'''';
    make:='KTH-'+trim(Handle_Part)+trim(handle_no);//5-11�ò��ű��
    edit2.Text:=setcode(temp,make);
    end;
end;

Function TFmCancel.ReadData :boolean;
var
  sqlsub:widestring;
  k:integer;
begin
  result:=false;
  if (Public_Do='Edited')  then
  begin
    sqlsub:='Select a.*,b.*,c.stock_amount from Cancel_strip as a, Cancel_strip_detail as b,vselectgoods as c where a.stock_no=b.stock_no and b.goods_no=c.goods_no and c.storage_no=a.storage_no and a.stock_No='''+List_No+'''';
    dmmain.CDSexecsql.Close;
    dmmain.CDSexecsql.Data:=adisp.execSql(sqlsub);
    dmmain.CDSexecsql.Open;
    StringGrid1.RowCount:=dmmain.CDSexecsql.RecordCount+1;
    if dmmain.CDSexecsql.IsEmpty then
    begin
        application.MessageBox('���˻����ѱ�ɾ����',pchar(application.Title),mb_iconwarning);
        exit;
    end;
    //******************
    Edit1.Text:=dmmain.CDSexecsql.Fieldbyname('Copy_Date').AsString;
    Edit2.Text:=dmmain.CDSexecsql.Fieldbyname('stock_No').AsString;
    Edit4.Text:=dmmain.CDSexecsql.Fieldbyname('WLDW').AsString;
    Edit6.Text:=dmmain.CDSexecsql.Fieldbyname('Transactor').AsString;
    Edit5.Text:=dmmain.CDSexecsql.Fieldbyname('Storage_NO').AsString;
    Edit8.Text:=dmmain.CDSexecsql.Fieldbyname('proposer').AsString;
    Edit9.Text:=dmmain.CDSexecsql.Fieldbyname('Condense').AsString;
    Edit10.Text:=dmmain.CDSexecsql.Fieldbyname('Remark').AsString;
    wldwno:=trim(dmmain.CDSexecsql.Fieldbyname('Contract_No').AsString);//Contract_No
    for k:=1 to dmmain.CDSexecsql.RecordCount  do

    begin
        StringGrid1.Cells[0,K]:=IntTostr(k); //��ʾ��0�е�i�е�����
        StringGrid1.Cells[1,k]:=trim(dmmain.CDSexecsql.Fieldbyname('Goods_NO').AsString);//��Ʒ���
        StringGrid1.Cells[2,k]:=trim(dmmain.CDSexecsql.Fieldbyname('Quality').AsString);//��Ʒ����
        StringGrid1.Cells[3,k]:=trim(dmmain.CDSexecsql.Fieldbyname('amount').AsString);//����
        StringGrid1.Cells[4,k]:=trim(dmmain.CDSexecsql.Fieldbyname('pass_no').AsString);//��Ʒ���
        StringGrid1.Cells[5,k]:=trim(dmmain.CDSexecsql.Fieldbyname('Fade_Name').AsString);  //��Ʒ˵��
        StringGrid1.Cells[6,k]:=trim(dmmain.CDSexecsql.Fieldbyname('stock_amount').AsString);
        dmmain.CDSexecsql.Next;
    end;
    GetDataPrint(dmmain.cdsprintmaster,dmmain.CDsexecsql);
    result:=true;
  end;
end;

function TFmCancel.CheckData:boolean;
VAR
  i:integer;
begin
  result:=false;
  if Trim(Edit1.Text)='' then
  begin
      application.MessageBox('��������,��¼�����ڡ�����Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
      Edit1.SetFocus;
      Exit;
  end;
  if Trim(Edit2.Text)='' then
  begin
      application.MessageBox('��������,�����ݱ�š�����Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
      Edit2.SetFocus;
      Exit;
  end;
  if Trim(Edit4.Text)='' then
  begin
      application.MessageBox('��������,��������λ������Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
      Edit4.SetFocus;
      Exit;
  end;
  if Trim(Edit5.Text)='' then
  begin
      application.MessageBox('��������,���˻��ֿ⡿����Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
      Edit5.SetFocus;
      Exit;
  end;
  if Trim(Edit6.Text)='' then
  begin
      application.MessageBox('��������,�������ˡ�����Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
      Edit6.SetFocus;
      Exit;
  end;
  if Trim(Edit8.Text)='' then
  begin
      application.MessageBox('��������,���Ƶ��ˡ�����Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
      Edit8.SetFocus;
      Exit;
  end;
  for i:=1 to stringgrid1.RowCount-1 do
  begin
    if StringGrid1.Cells[1,i]='' then
    begin
        application.MessageBox('��������,����Ʒ��š�����Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
        Exit;
    end;
    if (StringGrid1.Cells[3,i]='') or (StringGrid1.Cells[3,i]='0') then
    begin
        application.MessageBox('��������,������������Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
        Exit;
    end;
    {if (StringGrid1.Cells[9,i]='') or (StringGrid1.Cells[9,i]='0') then
    begin
        application.MessageBox('��������,���˻����ۡ�����Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
        Exit;
    end;}
  end;
  result:=true;
end;


function TFmCancel.SaveData:boolean;
var
  sqlsub:widestring;
  i:integer;
begin
  if Public_Do_Result='02' then
  begin
    if public_Do<>'Edited' then
    begin
      dmmain.cdsCancel_strip.Close;  //����
      dmmain.cdsCancel_strip.Open;
      dmmain.cdsCancel_strip.Append;
      dmmain.cdsCancel_strip.FieldByName('Copy_Date').AsString:=Trim(Edit1.Text);
      dmmain.cdsCancel_strip.FieldByName('Stock_No').AsString:=Trim(Edit2.Text);
      dmmain.cdsCancel_strip.FieldByName('WLDW').AsString:=Trim(Edit4.Text);
      dmmain.cdsCancel_strip.FieldByName('Storage_NO').AsString:=Trim(Edit5.Text);
      dmmain.cdsCancel_strip.FieldByName('Transactor').AsString:=Trim(Edit6.Text);
      dmmain.cdsCancel_strip.FieldByName('Shop_NO').AsString:=Trim(Handle_Part);
      dmmain.cdsCancel_strip.FieldByName('Proposer').AsString:=Trim(Edit8.Text);
      dmmain.cdsCancel_strip.FieldByName('Condense').AsString:=Trim(Edit9.Text);
      dmmain.cdsCancel_strip.FieldByName('Remark').AsString:=Trim(Edit10.Text);
      dmmain.cdsCancel_strip.FieldByName('Contract_No').AsString:=trim(wldwno);//
      dmmain.cdsCancel_strip.FieldByName('Stock_name').AsString:=trim('����˻���');//
      dmmain.cdsCancel_strip.Post;
      dmmain.cdsReceipt.Close;
      dmmain.cdsReceipt.Open;  //�ݸ�
      dmmain.cdsReceipt.Append;
      dmmain.cdsReceipt.FieldByName('Receipt_NO').AsString:=Trim(Edit2.Text);
      dmmain.cdsReceipt.FieldByName('Receipt_Name').AsString:='����˻���';
      dmmain.cdsReceipt.FieldByName('Copy_Date').AsString:=Trim(Edit1.Text);
      dmmain.cdsReceipt.FieldByName('Proposer').AsString:=Trim(Edit8.Text);
      dmmain.cdsReceipt.FieldByName('Condense').AsString:=Trim(Edit10.Text);
      dmmain.cdsReceipt.FieldByName('Check_Result').Asinteger:=0;
      dmmain.cdsReceipt.FieldByName('Flag_Sign').AsString:='�ݸ�';
      dmmain.cdsReceipt.FieldByName('Re_part').AsString:=trim(Handle_Part);
      dmmain.cdsReceipt.Post;
      if not dmmain.cdsCanceldetail.Active then dmmain.cdsCanceldetail.Open;
      for i:=1 to stringgrid1.RowCount-1 do  //ϸ��
      begin
        dmmain.cdsCanceldetail.Insert;
        dmmain.cdsCanceldetail.FieldByName('Stock_NO').AsString:= Trim(Edit2.Text);
        dmmain.cdsCanceldetail.FieldByName('Goods_NO').AsString:=Trim(StringGrid1.Cells[1,i]);
        dmmain.cdsCanceldetail.FieldByName('amount').AsString:= Trim(StringGrid1.Cells[3,i]);
        dmmain.cdsCanceldetail.FieldByName('Pass_NO').AsString:= Trim(StringGrid1.Cells[4,i]);
        dmmain.cdsCanceldetail.FieldByName('quality').AsString:=Trim(StringGrid1.Cells[2,i]);
        dmmain.cdsCanceldetail.FieldByName('Fade_Name').AsString:=Trim(StringGrid1.Cells[5,i]);
        dmmain.cdsCanceldetail.Post;
      end;
      try
        dmmain.cdsReceipt.ApplyUpdates(-1);
        dmmain.cdsCancel_strip.ApplyUpdates(-1);
        dmmain.cdsCanceldetail.ApplyUpdates(-1);
        setnull(fmcancel);
        init;
      except
        Application.MessageBox('�������������ϣ�',Pchar(Application.Title),Mb_ICONwarning);
        Exit;
      end;
    end else
    begin
      if not bedit then
      begin
        if trim(Handle_Man)<>trim(edit8.Text) then
        begin
          Application.MessageBox('�����޸����ݣ�',pchar(application.Title),mb_iconinformation);
          exit;
        end;
      end;
      sqlsub:='select * from [Cancel_strip] where Stock_No='+''''+Trim(List_NO)+'''';
      dmmain.CDSexecsql.Close;
      dmmain.CDSexecsql.Data:=adisp.execSql(sqlsub);
      dmmain.CDSexecsql.Open;
      dmmain.CDSexecsql.Edit;
      dmmain.CDSexecsql.FieldByName('WLDW').AsString:=Trim(Edit4.Text);
      dmmain.CDSexecsql.FieldByName('Contract_No').AsString:=trim(wldwno);
      dmmain.CDSexecsql.FieldByName('Storage_NO').AsString:=Trim(Edit5.Text);
      dmmain.CDSexecsql.FieldByName('Transactor').AsString:=Trim(Edit6.Text);
      dmmain.CDSexecsql.FieldByName('proposer').AsString:=Trim(Edit8.Text);
      dmmain.CDSexecsql.FieldByName('Condense').AsString:=Trim(Edit9.Text);
      dmmain.CDSexecsql.FieldByName('Remark').AsString:=Trim(Edit10.Text);
      dmmain.CDSexecsql.Post;
          //dmmain.CDSexecsql.Next;
      try
        dmmain.CDSexecsql.ApplyUpdates(-1);
      except
        Application.MessageBox('�������������ϣ�',Pchar(Application.Title),Mb_ICONwarning);
        Exit;
      end;
      sqlsub:='select * from [Cancel_strip_detail] where Stock_No='+''''+Trim(List_NO)+'''';
      dmmain.CDSexecsql.Close;
      dmmain.CDSexecsql.Data:=adisp.execSql(sqlsub);
      dmmain.CDSexecsql.Open;
      for i:=1 to stringgrid1.RowCount-1 do
      begin
        dmmain.CDSexecsql.edit;
        dmmain.CDSexecsql.FieldByName('Goods_NO').AsString:=Trim(StringGrid1.Cells[1,i]);
        dmmain.CDSexecsql.FieldByName('amount').AsString:= Trim(StringGrid1.Cells[3,i]);
        dmmain.CDSexecsql.FieldByName('Pass_NO').AsString:= Trim(StringGrid1.Cells[4,i]);
        dmmain.CDSexecsql.FieldByName('quality').AsString:=Trim(StringGrid1.Cells[2,i]);
        dmmain.CDSexecsql.FieldByName('Fade_Name').AsString:=Trim(StringGrid1.Cells[5,i]);
        dmmain.CDSexecsql.Post;
        dmmain.CDSexecsql.Next;
      end;
      try
        dmmain.CDSexecsql.ApplyUpdates(-1);
      except
        Application.MessageBox('�������������ϣ�',Pchar(Application.Title),Mb_ICONwarning);
        Exit;
      end;
    end;
  end ;
  if Public_Do_Result='03' then
  begin
    close;
  end;
end;
////////////////////////////
procedure TFmCancel.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  Check_Mond:='';
  Check_Mond:='Stock_pay_Str';
  frm_Supply_Monad:=Tfrm_Supply_Monad.Create(self);
  frm_Supply_Monad.Caption:='��������λ��';
  frm_Supply_Monad.ShowModal;
  Edit4.Text:=check_Mond_Result;
  frm_Supply_Monad.Free;
end;

procedure TFmCancel.SpeedButton9Click(Sender: TObject);
begin
  inherited;
  Employe_Check:='';
  Employe_Check:='Stock_Fad_str';
  Employe_Check_Result:='';
  frm_Login_Man:=Tfrm_Login_Man.Create(self);
  frm_Login_Man.Caption:='������ѡ��';
  frm_Login_Man.ShowModal;
  Edit6.Text:=Employe_Check_Result;
  frm_Login_Man.Free;
end;

procedure TFmCancel.FormShow(Sender: TObject);
begin
  inherited;
  init;
  readdata;
end;

procedure TFmCancel.Cmd_DeleteClick(Sender: TObject);
begin
  inherited;
  deletegridrows(stringgrid1,prow);
end;

procedure TFmCancel.SpeedButton3Click(Sender: TObject);
begin
  inherited;
  if dmmain.cdsprintmaster.IsEmpty then exit;
  fastrepxf:=tfastrepxf.Create(self);
  fastrepxf.filenames:='CancelGoods.ini';
  fastrepxf.ShowModal;
  fastrepxf.Free;
end;

procedure TFmCancel.SpeedButton4Click(Sender: TObject);
begin
  inherited;
  if not checkDATA THEN EXIT;
  frm_Public_Don:=Tfrm_Public_Don.Create(self);
  frm_Public_Don.no:=trim(edit2.Text);
  frm_Public_Don.ShowModal;
  frm_Public_Don.FREE;
  SAVEDATA;
end;

procedure TFmCancel.SpeedButton2Click(Sender: TObject);
var
  user,wldwname,remarks:widestring;
  flag,intof:olevariant;
  i:integer;
  totals:double;
begin
  inherited;
  if trim(Public_Do)<>'Edited' then exit;
  no:=trim(edit2.Text);
  typed:=' ����˻���';
  user:=trim(Handle_No);
  flag:=adisp.receipted(no,typed,user,1,Handle_Part);
  if flag='3' then
  begin
    if adisp.CancelGoods(trim(edit5.Text),no) then   ///////����ʵ�ʵĿ����������
    begin
      flag:='3';
    end else
    begin
      flag:='2';
    end;
  end;
  if flag='1' then
  begin
    application.MessageBox('��˳ɹ���',pchar(application.Title),mb_iconinformation);
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

end;

procedure TFmCancel.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
  PCOL:=ACOL;
  PROW:=AROW;
end;

procedure TFmCancel.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  IF ((PCOL=3) OR (PCOL=5)) AND (PROW>0) THEN
  BEGIN
    IF (Pcol=3)  then
    begin
      if key in ['0'..'9',#8,#13,'.'] then
      begin
        stringgrid1.Options:=stringgrid1.Options+[goediting];
      end else
      begin
        key:=#0;
      end;
    end else
    begin
      stringgrid1.Options:=stringgrid1.Options+[goediting];
    end;
  END ELSE
  BEGIN
    stringgrid1.Options:=stringgrid1.Options-[goediting];
    KEY:=#0;
  END;
end;

procedure TFmCancel.StringGrid1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
  var
    i:integer;
begin
  inherited;
  for i:=1 to stringgrid1.RowCount-1 do
  begin
    if (trim(stringgrid1.Cells[3,i])<>'') and (trim(stringgrid1.Cells[6,i])<>'') then
    begin
      if strtoint(trim(stringgrid1.Cells[3,i]))>strtoint(trim(stringgrid1.Cells[6,i])) then
      begin
        application.MessageBox('�˻��������ö��ڿ��������',pchar(application.Title)mb_iconinformation);
        stringgrid1.Cells[3,i]:='0';
        exit;
      end;
    end;
  end;
end;

procedure TFmCancel.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  s:string;
  r:TRect;
begin
   inherited;
  with Sender as Tstringgrid do
  begin
  if gdSelected in State then
  Canvas.Brush.Color:= clTeal; //clyellow;//clRed;
  Canvas.TextRect(Rect,Rect.Left,Rect.Top,' '+Cells[ACol,ARow]);
  if gdFocused in State then
  Canvas.DrawFocusRect(Rect);
  end;
  with Sender as Tstringgrid do
  begin
    Canvas.FillRect(Rect);
    s:=Cells[ACol,ARow];
    r:=Rect;
    DrawText(Canvas.Handle,PChar(s),Length(s),r,DT_CENTER or DT_SINGLELINE or DT_VCENTER);
  end;


end;

procedure TFmCancel.StringGrid1DblClick(Sender: TObject);
var
  i:integer;
begin
  inherited;
  if pcol in [1,2] then
  begin
   fmgoodCodeSelStr:= TfmgoodCodeSelStr.Create(self);
   try
   fmgoodcodeselStr.show_mode:='14';
   fmgoodcodeselStr.ShowModal;
   finally
   fmgoodcodeselStr.Free;
   end;
  end;
  if pcol = 3 then  //��������
  begin
   for i := prow+1 to STRINGGRID1.rowcount -1 do
   begin
   STRINGGRID1.cells[3,i]:= STRINGGRID1.cells[3,prow];
   end;
  end;

end;

procedure TFmCancel.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmmain.CDSexecsql.Close;
  dmmain.CDSexecsql.Data:=null;
  dmmain.cdsCancel_strip.Close;
  dmmain.cdsCancel_strip.Data:=null;
  dmmain.cdsCanceldetail.Close;
  dmmain.cdsCanceldetail.Data:=null;
  inherited;

end;

end.
