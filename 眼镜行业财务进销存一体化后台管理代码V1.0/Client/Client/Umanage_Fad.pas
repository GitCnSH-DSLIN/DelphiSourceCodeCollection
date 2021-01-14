unit Umanage_Fad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, StdCtrls, Buttons, XPMenu;

type
  Tfrm_Umanage_Fad = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Cmd_Cancel: TSpeedButton;
    Panel3: TPanel;
    Edit1: TLabeledEdit;
    GroupBox1: TGroupBox;
    SpeedButton5: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Edit_Storage_Name: TLabeledEdit;
    Edit5: TLabeledEdit;
    Edit7: TLabeledEdit;
    Edit8: TLabeledEdit;
    Edit9: TLabeledEdit;
    Edit2: TLabeledEdit;
    Panel6: TPanel;
    Panel8: TPanel;
    Label2: TLabel;
    Panel9: TPanel;
    Panel10: TPanel;
    Cmd_Delete: TSpeedButton;
    Cmd_Add: TSpeedButton;
    Edit4: TLabeledEdit;
    edtgatrhername: TLabeledEdit;
    edtgatrher: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    StringGrid1: TStringGrid;
    Label3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Cmd_CancelClick(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure Cmd_AddClick(Sender: TObject);
    procedure Cmd_DeleteClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure StringGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
    stockid:widestring;
    Pcol,Prow:integer;
    procedure init;
  public
    { Public declarations }
  end;

var
  frm_Umanage_Fad: Tfrm_Umanage_Fad;
  iColcount,Total_Count:Integer;
  i:integer;
  Insert_Sql:String;
  ss,tempstr:string;
implementation

uses func, Data,  Public_Don, Storage_Select, Login_Man,
  ChildShop_Select, untdatadm, UntgoodCodeSelStr, Supply_Monad,
  Unt_PubStrGrid, Unitreportxf;

{$R *.dfm}
procedure tfrm_umanage_fad.init;
var
  temp,make:string;
begin
  InitialStrGrid(stringgrid1,'��Ӫҵ�Գ���');
  if (Public_Do='Business_Storage_Out') then exit;
  edit1.Text:=formatdatetime('yyyy''-''mm''-''dd',date);
  Edit7.Text:=Handle_Man;
  temp:='select max(right(Out_NO,4)) from out_strip where copy_date='+''''+trim(edit1.Text)+''''+' and part_no='+''''+trim(Handle_Part)+'''';
  make:='OSK-'+trim(Handle_Part)+trim(handle_no); //�ò��ű��
  edit2.Text:=setcode(temp,make);
end;

//�Զ�����ͳ�ƹ���
//*******************************************

procedure Tfrm_Umanage_Fad.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   DMMAIN.CDSquery2.Close;
  dmmain.CDSquery2.Data:=null;
  DMMAIN.CDSexecsql.Close;
  dmmain.CDSexecsql.Data:=null;
  dmmain.cdsprintmaster.Close;
  dmmain.cdsprintmaster.Data:=null;
  dmmain.cdsoutstrip.Close;
  dmmain.cdsoutstrip.Data:=null;
  dmmain.cdsoutdetail.Close;
  dmmain.cdsoutdetail.Data:=null;
  Action:=Cafree;
end;

procedure Tfrm_Umanage_Fad.FormShow(Sender: TObject);
var
    icount,k:integer;
    tt,yy,temppos:integer;
  sqlsub:widestring;
begin
    iColcount:=StringGrid1.ColCount-1; //��Ҫ��������ݵ������������
    StringGrid1.RowCount:=2;
    Total_Count:=StringGrid1.RowCount;
    init;
    //�ݸ嵥�ݲ鿴
    if (Public_Do='Business_Storage_Out') then
    begin
      sqlsub:='Select a.*,b.*,c.* from out_strip as a,out_strip_detail as b,Goods_code as c where a.out_no=b.out_no and b.goods_no=c.goods_no and a.out_No='''+List_No+'''';
      dmmain.CDSquery2.Close;
      dmmain.CDSquery2.Data:=null;
      dmmain.CDSquery2.Data:=adisp.resultrecord(sqlsub);
      try
      dmmain.CDSquery2.Open;
      except
      end;
      k:=dmmain.CDSquery2.RecordCount;
      StringGrid1.RowCount:=k+1;
      //�Զ�����STRINGGRID������
      for K:=1 to StringGrid1.RowCount do
      begin
        StringGrid1.Cells[0,K]:=IntTostr(k); //��ʾ��0�е�i�е�����
      end;
      //******************
      Edit1.Text:=trim(dmmain.CDSquery2.FieldByName('Copy_Date').AsString);
      Edit2.Text:=trim(dmmain.CDSquery2.FieldByName('out_No').AsString);
      Edtgatrher.Text:=trim(dmmain.CDSquery2.FieldByName('Gatrher_monad').AsString);
      Edtgatrhername.Text:=trim(dmmain.CDSquery2.FieldByName('wldw').AsString);
      Edit4.Text:=trim(dmmain.CDSquery2.FieldByName('Storage_NO').AsString);
      //Edit_Storage_Name.Text:=dmmain.CDSquery2.FieldByName('Storage_Name').AsString;
      Edit5.Text:=trim(dmmain.CDSquery2.FieldByName('Transactor').AsString);
      Edit7.Text:=trim(dmmain.CDSquery2.FieldByName('proposer').AsString);
      Edit8.Text:=trim(dmmain.CDSquery2.FieldByName('Condense').AsString);
      Edit9.Text:=trim(dmmain.CDSquery2.FieldByName('Remark').AsString);
      wldwno:=trim(dmmain.CDSquery2.FieldByName('Gatrher_monad').AsString);
      stockid:=trim(dmmain.CDSquery2.FieldByName('Storage_NO').AsString);
      for k:=1 to dmmain.CDSquery2.RecordCount do
      begin
        StringGrid1.Cells[0,k]:=trim(dmmain.CDSquery2.FieldByName('ord').AsString);//���
        StringGrid1.Cells[1,k]:=trim(dmmain.CDSquery2.FieldByName('Goods_NO').AsString);//��Ʒ���
        StringGrid1.Cells[2,k]:=trim(dmmain.CDSquery2.FieldByName('Goods_Name').AsString);//��Ʒ����
        StringGrid1.Cells[4,k]:=trim(dmmain.CDSquery2.FieldByName('Price').AsString);//����
        StringGrid1.Cells[3,k]:=trim(dmmain.CDSquery2.FieldByName('amount').AsString);//���
        StringGrid1.Cells[5,k]:=trim(dmmain.CDSquery2.FieldByName('Money').AsString);//���
        StringGrid1.Cells[6,k]:=trim(dmmain.CDSquery2.FieldByName('type').AsString);
        StringGrid1.Cells[7,k]:=trim(dmmain.CDSquery2.FieldByName('provider').AsString);
        StringGrid1.Cells[8,k]:=trim(dmmain.CDSquery2.FieldByName('Out_Remark').AsString);
        dmmain.CDSquery2.Next;
      end;
      GetDataPrint(dmmain.cdsprintmaster,dmmain.CDsquery2);
    end;
end;

procedure Tfrm_Umanage_Fad.Cmd_CancelClick(Sender: TObject);
var
    i,j,icol:integer;
    Check_Flag:string;
    temp:widestring;
begin
    frm_Public_Don:=Tfrm_Public_Don.Create(self);
    frm_Public_Don.ShowModal;
    if Public_Do='Storage_Umanage_Fad' then
    begin
        if Public_Do_Result='02' then
        begin
            if Trim(Edit1.Text)='' then
            begin
                application.MessageBox('��������,��¼�����ڡ�����Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                Edit1.SetFocus;
                Exit;
            end;
            if Trim(Edit2.Text)='' then
            begin
                application.MessageBox('��������,�����ݱ�š�����Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                Edit2.SetFocus;
                Exit;
            end;
            if Trim(Edtgatrher.Text)='' then
            begin
                application.MessageBox('��������,���ջ���λ������Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                Edtgatrher.SetFocus;
                Exit;
            end;
            if Trim(Edit4.Text)='' then
            begin
                application.MessageBox('��������,�������ֿ⡿����Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                Edit4.SetFocus;
                Exit;
            end;
            if Trim(Edit5.Text)='' then
            begin
                application.MessageBox('��������,�������ˡ�����Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                Edit5.SetFocus;
                Exit;
            end;
            if Trim(Edit7.Text)='' then
            begin
                application.MessageBox('��������,���Ƶ��ˡ�����Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                Edit7.SetFocus;
                Exit;
            end;
            for i:=1 to Total_Count-1 do
            begin
                if StringGrid1.Cells[1,i]='' then
                begin
                    application.MessageBox('��������,����Ʒ��š�����Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                    Exit;
                end;
                if StringGrid1.Cells[3,i]='' then
                begin
                    application.MessageBox('��������,������������Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                    Exit;
                end;
            end;
            if dmmain.cdsoutstrip.Active then dmmain.cdsoutstrip.Close;
            dmmain.cdsoutstrip.Open;
            dmmain.cdsoutstrip.Insert;
            dmmain.cdsoutstrip.FieldByName('copy_date').AsString:=trim(edit1.Text);
            dmmain.cdsoutstrip.FieldByName('out_no').AsString:=trim(edit2.Text);
            dmmain.cdsoutstrip.FieldByName('gatrher_monad').AsString:=trim(edtgatrher.Text);
            dmmain.cdsoutstrip.FieldByName('storage_no').AsString:=trim(edit4.Text);
            dmmain.cdsoutstrip.FieldByName('transactor').AsString:=trim(edit5.Text);
            dmmain.cdsoutstrip.FieldByName('proposer').AsString:=trim(edit7.Text);
            dmmain.cdsoutstrip.FieldByName('condense').AsString:=trim(edit8.Text);
            dmmain.cdsoutstrip.FieldByName('remark').AsString:=trim(edit9.Text);
            dmmain.cdsoutstrip.FieldByName('part_no').AsString:=trim(Handle_Part);
            dmmain.cdsoutstrip.FieldByName('out_name').AsString:=trim('��Ӫҵ�Գ��ⵥ');
            dmmain.cdsoutstrip.FieldByName('wldw').AsString:=trim(edtgatrhername.Text);
            dmmain.cdsoutstrip.Post;
            dmmain.cdsReceipt.close;
            dmmain.cdsReceipt.Open;
            dmmain.cdsReceipt.Append;
            dmmain.cdsReceipt.FieldByName('Receipt_NO').AsString:=Trim(Edit2.Text);
            dmmain.cdsReceipt.FieldByName('Receipt_Name').AsString:='��Ӫҵ�Գ��ⵥ';
            dmmain.cdsReceipt.FieldByName('Copy_Date').AsString:=Trim(Edit1.Text);
            dmmain.cdsReceipt.FieldByName('Proposer').AsString:=Trim(Edit7.Text);
            dmmain.cdsReceipt.FieldByName('Check_Result').Asinteger:=0;
            dmmain.cdsReceipt.FieldByName('Flag_Sign').AsString:='�ݸ�';
            dmmain.cdsReceipt.FieldByName('Condense').AsString:=Trim(Edit8.Text);
            dmmain.cdsReceipt.FieldByName('Re_part').AsString:=trim(Handle_Part);
            dmmain.cdsReceipt.Post;
            if dmmain.cdsoutdetail.Active then  dmmain.cdsoutdetail.Close;
            dmmain.cdsoutdetail.Open;
            for i:=1 to stringgrid1.RowCount-1 do
            begin
              dmmain.cdsoutdetail.Insert;
              dmmain.cdsoutdetail.FieldByName('out_no').AsString:=trim(edit2.Text);
              dmmain.cdsoutdetail.FieldByName('goods_no').AsString:=trim(stringgrid1.Cells[1,i]);
              dmmain.cdsoutdetail.FieldByName('goods_name').AsString:=trim(stringgrid1.Cells[2,i]);
              dmmain.cdsoutdetail.FieldByName('ord').AsString:=inttostr(i);
              dmmain.cdsoutdetail.FieldByName('amount').AsString:=trim(stringgrid1.Cells[3,i]);
              dmmain.cdsoutdetail.FieldByName('price').AsString:=trim(stringgrid1.Cells[4,i]);
              dmmain.cdsoutdetail.FieldByName('money').AsString:=trim(stringgrid1.Cells[5,i]);
              dmmain.cdsoutdetail.FieldByName('out_remark').AsString:=trim(stringgrid1.Cells[8,i]);
              dmmain.cdsoutdetail.Post;
            end;
            try
            dmmain.cdsReceipt.ApplyUpdates(-1);
            dmmain.cdsoutdetail.ApplyUpdates(-1);
            dmmain.cdsoutstrip.ApplyUpdates(-1);
            setnull(frm_Umanage_Fad);
            init;
            except
              Application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
              Exit;
            end;
             //Application.MessageBox('��ϲ�㣡������Ӫ�Գ��ⵥ���ݸ嵥�ݱ�������ɹ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
        end;
        if Public_Do_Result='03' then
        begin
            Close;
        end;
    end;
    //�޸Ĳݸ�
    if Public_Do='Business_Storage_Out' then
    begin
      if Public_Do_Result='02' then //���浥��
      begin
        if not bedit then
        begin
          if trim(Handle_Man)<>trim(edit7.Text) then
          begin
            Application.MessageBox('�����޸����ݣ�',pchar(application.Title),mb_iconinformation);
            exit;
          end;
        end;
        temp:='select * from out_strip where out_no='+''''+trim(edit2.Text)+'''';
        dmmain.CDSexecsql.Close;
        dmmain.CDSexecsql.Data:=null;
        dmmain.CDSexecsql.Data:=adisp.execSql(temp);
        dmmain.CDSexecsql.Open;
        dmmain.CDSexecsql.Edit;
        dmmain.CDSexecsql.FieldByName('gatrher_monad').AsString:=trim(edtgatrher.Text);
        dmmain.CDSexecsql.FieldByName('storage_no').AsString:=trim(edit4.Text);
        dmmain.CDSexecsql.FieldByName('transactor').AsString:=trim(edit5.Text);
        dmmain.CDSexecsql.FieldByName('condense').AsString:=trim(edit8.Text);
        dmmain.CDSexecsql.FieldByName('remark').AsString:=trim(edit9.Text);
        dmmain.CDSexecsql.FieldByName('wldw').AsString:=trim(edtgatrhername.Text);
        dmmain.CDSexecsql.Post;
        try
          dmmain.CDSexecsql.ApplyUpdates(-1);
        except
          application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
          exit;
        end;
        temp:='select * from out_strip_detail where out_no='+''''+trim(edit2.Text)+'''';
        dmmain.CDSexecsql.Close;
        dmmain.CDSexecsql.Data:=null;
        dmmain.CDSexecsql.Data:=adisp.execSql(temp);
        dmmain.CDSexecsql.Open;
        for i:=1 to stringgrid1.RowCount-1 do
        begin
          dmmain.CDSexecsql.Edit;
          dmmain.CDSexecsql.FieldByName('amount').AsString:=trim(stringgrid1.Cells[3,i]);
          dmmain.CDSexecsql.FieldByName('money').AsString:=trim(stringgrid1.Cells[5,i]);
          dmmain.CDSexecsql.FieldByName('out_remark').AsString:=trim(stringgrid1.Cells[8,i]);
          dmmain.CDSexecsql.Post;
          dmmain.CDSexecsql.Next;
        end;
        try
          dmmain.CDSexecsql.ApplyUpdates(-1);
        except
          application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
          exit;
        end;
      end;
      if Public_Do_Result='03' then
      begin
          Close;
      end;
    end;
    frm_Public_Don.Free;
end;

procedure Tfrm_Umanage_Fad.StringGrid1DrawCell(Sender: TObject; ACol,
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
    with sender as TStringGrid do
    begin
        if (GDFocused in state) then
        begin
            Pcol:=Acol;
            Prow:=ARow;
            func.String_Col:=ARow;
        end;
    end;
end;

procedure Tfrm_Umanage_Fad.StringGrid1DblClick(Sender: TObject);
var
    openstr,bmbh:string;
    S1,s2,s3:string;
begin
    if Trim(Edit2.Text)='' then
    begin
        Application.MessageBox('����ʧ�ܣ������ݱ�š�����Ϊ�գ�',pchar(application.Title),mb_iconwarning);
        Edit2.SetFocus;
        Exit;
    end;
    if Trim(Edit4.Text)='' then
    begin
        Application.MessageBox('����ʧ�ܣ���������λ������Ϊ�գ�',pchar(application.Title),mb_iconwarning);
        Edit4.SetFocus;
        Exit;
    end;
    if Trim(Edit5.Text)='' then
    begin
        Application.MessageBox('����ʧ�ܣ��������ˡ�����Ϊ�գ�',pchar(application.Title),mb_iconwarning);
        Edit5.SetFocus;
        Exit;
    end;
  if pcol in [1,2] then
  begin
   bmbh:=shopid;
   shopid:=trim(edit4.Text);
   fmgoodCodeSelStr:= TfmgoodCodeSelStr.Create(self);
   try
   fmgoodcodeselStr.show_mode:='7';
   fmgoodcodeselStr.ShowModal;
   finally
   fmgoodcodeselStr.Free;
   shopid:=bmbh;
   end;
  end;
  if pcol = 3 then  //��������
  begin
   for i := prow+1 to STRINGGRID1.rowcount -1 do
   begin
   STRINGGRID1.cells[3,i]:= STRINGGRID1.cells[3,prow];
   //ͬʱҪ������
   end;
  end;
end;


procedure Tfrm_Umanage_Fad.SpeedButton5Click(Sender: TObject);
begin
    Check_Storage:='';Check_Storage_Result:='';
    Check_Storage:='Storage_Umanage_Fad';
    frm_Storage_Select:=Tfrm_Storage_Select.Create(self);
    frm_Storage_Select.ShowModal;
    Edit_Storage_Name.Text:=Trim(Check_Storage_Result);
    edit4.Text:=Check_Storage_Result_NO;
    frm_Storage_Select.Free;
end;

procedure Tfrm_Umanage_Fad.SpeedButton9Click(Sender: TObject);
begin
    Employe_Check:='';
    Employe_Check:='Storage_Umanage_Fad';
    Employe_Check_Result:='';
    frm_Login_Man:=Tfrm_Login_Man.Create(self);
    frm_Login_Man.Caption:='������ѡ��';
    frm_Login_Man.ShowModal;
    Edit5.Text:=Employe_Check_Result;
    frm_Login_Man.Free;
end;

procedure Tfrm_Umanage_Fad.SpeedButton8Click(Sender: TObject);
begin
    ChildShop_Str:='';
    ChildShop_Result_NO:='';
    ChildShop_Result_Name:='';
    ChildShop_Str:='Storage_Umanage_Fad';
    frm_ChildShop_Select:=Tfrm_ChildShop_Select.Create(self);
    frm_ChildShop_Select.ShowModal;
    frm_ChildShop_Select.Free;
end;

procedure Tfrm_Umanage_Fad.Cmd_AddClick(Sender: TObject);
var
    i:integer;
begin
    StringGrid1.RowCount:=StringGrid1.RowCount+1;
    Total_Count:=StringGrid1.RowCount;
    for i:=1 to StringGrid1.RowCount-1 do
    begin
        StringGrid1.Cells[0,i]:=IntTostr(i); //��ʾ��0�е�i��
    end;
end;

procedure Tfrm_Umanage_Fad.Cmd_DeleteClick(Sender: TObject);
begin

  deletegridrows(stringgrid1,prow);
end;
procedure Tfrm_Umanage_Fad.SpeedButton2Click(Sender: TObject);
var
  user,wldwname,remarks:widestring;
  flag,inmethod,intof:olevariant;
  totals:double;
  bmbh:string;
begin
  if trim(stringgrid1.Cells[1,1])='' then exit;
  if (Public_Do<>'Business_Storage_Out') then exit;  //�������޸�
  no:=trim(edit2.Text);
  typed:='��Ӫҵ�Գ��ⵥ';
  user:=trim(Handle_No);
  flag:=adisp.receipted(no,typed,user,1,Handle_Part);
  if flag='3' then //
  begin
    //��Ӳ������///////////////////////////////////////
    for i:=1 to stringgrid1.RowCount-1 do
    begin
       totals:=totals+strtofloat(stringgrid1.Cells[5,i]); //�ѽ�����
    end;
    wldwname:=trim(edtgatrhername.Text);
    remarks:='��Ӫҵ�Գ���';
    bmbh:=shopid;
    shopid:=edit4.Text;
    try
    intof:=ipubtemp.MoneyTable(6,no,totals,user,user,user,wldwno,wldwname,shopid,remarks);
    except
    application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
    exit;
    end;
    shopid:=bmbh;
    if vartostr(intof)='1' then
    begin
      flag:='3';
    end else
    begin
      flag:='2';
    end;
    if flag='3' then
    begin
    /////////////////���Ӧ����Ʒ���۱�����ӵ���////////
      inmethod:=2;
      flag:=adisp.inputstorage(no,inmethod,stockid);  //��������⣡��//5-19 edit;
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
end;

procedure Tfrm_Umanage_Fad.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  pcol:=acol;
  prow:=arow;
end;

procedure Tfrm_Umanage_Fad.StringGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if trim(stringgrid1.Cells[1,1])='' then exit;
  if pcol=3 then
  begin
    if not (key in ['0'..'9',#8,'.']) then
    begin
      key:=#0;
    end else
    begin
      if key<>#8 then
      begin
        if stringgrid1.Cells[3,prow]<>'0' then
        begin
          stringgrid1.Cells[3,prow]:=stringgrid1.Cells[3,prow]+key;
        end else
        begin
          stringgrid1.Cells[3,prow]:=key;
        end;
        stringgrid1.Cells[5,prow]:=floattostr(strtofloat(stringgrid1.Cells[3,prow])*strtofloat(stringgrid1.Cells[4,prow]));
      end else
      begin
        stringgrid1.Cells[3,prow]:=copy(stringgrid1.Cells[3,prow],1,length(stringgrid1.Cells[3,prow])-1);   //��ȥ�������
        if  stringgrid1.Cells[3,prow]='' then
        begin
          stringgrid1.Cells[3,prow]:='0';
        end;
        if trim(stringgrid1.Cells[3,prow])='0' then
        begin
          stringgrid1.Cells[5,prow]:='0';
        end else
        begin
          stringgrid1.Cells[5,prow]:=floattostr(strtofloat(stringgrid1.Cells[3,prow])*strtofloat(stringgrid1.Cells[4,prow]));
        end;
      end;
    end;
  end else
  begin
    application.MessageBox('ֻ��������Ʒ������',pchar(application.Title),mb_iconinformation);
    exit;
  end;
end;

procedure Tfrm_Umanage_Fad.SpeedButton1Click(Sender: TObject);
begin
  Check_Mond:='';
  wldwno:='';
  Check_Mond:='DW-0001';
  frm_Supply_Monad:=Tfrm_Supply_Monad.Create(self);
  frm_Supply_Monad.Caption:='���ջ���λ��';
  frm_Supply_Monad.ShowModal;
  edtgatrhername.Text:=Trim(check_Mond_Result);
  edtgatrher.Text:=wldwno;
  frm_Supply_Monad.Free;
end;

procedure Tfrm_Umanage_Fad.StringGrid1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  i:integer;  
begin
  if prow<>0 then
  begin
    if (trim(StringGrid1.Cells[3,prow])<>'') and (trim(StringGrid1.Cells[8,prow])<>'') then
    begin
      if strtoint(StringGrid1.Cells[3,prow])> strtoint(StringGrid1.Cells[8,prow]) then
      begin
        StringGrid1.Cells[3,prow]:='0';
        application.MessageBox('�����ѳ������������',pchar(application.Title),mb_iconinformation);
        exit;
      end;
    end;
    if (trim(StringGrid1.Cells[3,prow])<>'') then
    begin
      for i:=1 to stringgrid1.RowCount-1 do
      begin
        if (trim(StringGrid1.Cells[3,i])<>'') then
        StringGrid1.Cells[5,i]:=floattostr(strtofloat(StringGrid1.Cells[3,i])*strtofloat(StringGrid1.Cells[4,i]));
      end;
    end;
  end;
end;

procedure Tfrm_Umanage_Fad.SpeedButton3Click(Sender: TObject);
begin
  if dmmain.cdsprintmaster.IsEmpty then exit;
  fastrepxf:=tfastrepxf.Create(self);
  fastrepxf.filenames:='OutStock.ini';
  fastrepxf.ShowModal;
  fastrepxf.Free;
end;

end.
