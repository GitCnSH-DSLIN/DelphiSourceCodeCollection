unit fm_Check;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fm_Base, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, Menus,
  ComCtrls;

type
  TfmCheck = class(TfmBase)
    Label1: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    BtnClose: TBitBtn;
    Panel3: TPanel;
    Label9: TLabel;
    editbz: TEdit;
    editrq: TEdit;
    editbh: TEdit;
    editzdr: TEdit;
    sgorder: TStringGrid;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    BtnCheckAll: TBitBtn;
    BtnSave: TBitBtn;
    pd_tbegin: TDateTimePicker;
    Label5: TLabel;
    Label10: TLabel;
    pd_tend: TDateTimePicker;
    Bevel1: TBevel;
    Label11: TLabel;
    CmbG: TComboBox;
    Label12: TLabel;
    CmbC: TComboBox;
    BitBtn1: TBitBtn;
    procedure BtnCloseClick(Sender: TObject);
    procedure sgorderDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgorderKeyPress(Sender: TObject; var Key: Char);
    procedure sgorderSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure BtnCheckAllClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure sgorderDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    pcol,prow:integer;
    cx_fl:integer;
    pdall_maxnumber:array of integer;
    procedure init;
  public
    { Public declarations }
    pd_maxnumber:integer;
    pd_mode:integer;  //�̵��־ 1ΪӪҵ���̵� 0Ϊͣҵ�̵�
  end;

var
  fmCheck: TfmCheck;
//  shopid,operater:string;
implementation

uses  UntgoodCodeSelStr, func,untdatadm, Check_Query;

{$R *.dfm}

procedure Tfmcheck.init;
var
  i:integer;
  sql,marks,s_NewDate:string;
begin
  for i:=1 to sgorder.RowCount-1 do
    sgorder.Rows[i].Text:='';
  sgorder.RowCount:=2;
  editbz.Clear;
  s_newdate:=formatdatetime('yyyy''-''mm''-''dd',date);
  sql:='select max(right(C_Code,4)) from DP_check where C_NewDate='+''''+s_NewDate+''''+' and C_Shop='+''''+trim(Handle_Part)+'''';//5-11 �ò��ű��
  marks:='PDD-'+Handle_Part;
  editbh.Text:=setcode(sql,marks);
  editrq.Text:=s_newdate;
  editzdr.Text:=Handle_Man;
end;

/////////////////////�Զ���////////////////
procedure TfmCheck.BtnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfmCheck.sgorderDblClick(Sender: TObject);
begin
  inherited;
  if cx_fl=0 then
    if pcol in [1,2,3] then
    begin
     fmgoodCodeSelStr:= TfmgoodCodeSelStr.Create(nil);
     try
     fmgoodcodeselStr.show_mode:='3';
     fmgoodcodeselStr.ShowModal;
     finally
     fmgoodcodeselStr.Free;
     end;
   end;
end;

procedure TfmCheck.FormShow(Sender: TObject);
var
  t_sql :string;
begin
  inherited;
  cx_fl:=0;
  sgorder.Cells[1,0]:='��Ʒ���';
  sgorder.Cells[2,0]:='��Ʒ����';
  sgorder.Cells[3,0]:='��Ʒ����';
  sgorder.Cells[4,0]:='�̵�����';
  sgorder.Cells[5,0]:='��Ʒ���';
  sgorder.Cells[6,0]:='�̵��־';
  sgorder.Cells[7,0]:='';
  sgorder.ColWidths[7]:=-1;
  sgorder.ColWidths[0] := 20;
  sgorder.ColWidths[1] := 130;
  sgorder.ColWidths[2] := 190;
  t_sql:='select p_name from  [dp_person] where p_workid ='+''''+trim(Handle_Part)+'''';
  GetDataToComBoX(cmbg,t_sql,'p_Name');
  cmbg.ItemIndex := -1;
  cmbc.Items := cmbg.Items;
  init;
end;

procedure TfmCheck.sgorderKeyPress(Sender: TObject; var Key: Char);
var
  pd_fl:integer;
begin
  inherited;
  if not (key in ['0'..'9',#8]) then
  begin
    key:=#0;
    exit;
  end;
  if pcol=4 then     //¼���̵�����������ʵʱͳ��
  begin
    if trim(sgorder.Cells[1,prow])<>'' then
    begin
      if key=#8 then
      begin
        sgorder.Cells[4,prow]:='';
        sgorder.Cells[5,prow]:='';
        sgorder.Cells[6,prow]:='';
      end
      else begin
        if cx_fl=0 then
        begin
          sgorder.Cells[4,prow]:=sgorder.Cells[4,prow]+key;
          try
            if trim(sgorder.Cells[4,prow])='' then exit;
            pd_fl:=strtoint(trim(sgorder.Cells[7,prow]))-strtoint(trim(sgorder.Cells[4,prow]));
            pd_fl:=pd_fl*-1;
            sgorder.Cells[5,prow]:=inttostr(pd_fl);
            if pd_fl<0 then sgorder.Cells[6,prow]:='�̿�'
            else if pd_fl>0 then sgorder.Cells[6,prow]:='��Ӯ'
              else sgorder.Cells[6,prow]:='��ƽ';
          except
            sgorder.Cells[5,prow]:='0';
            sgorder.Cells[5,prow]:='���ݳ���';
          end;
        end else
        begin
          sgorder.Cells[4,prow]:=sgorder.Cells[4,prow]+key;
          try
            if trim(sgorder.Cells[4,prow])='' then exit;
            pd_fl:=strtoint(trim(sgorder.Cells[7,prow]))-strtoint(trim(sgorder.Cells[4,prow])); //pdall_maxnumber[prow-1]
            pd_fl:=pd_fl*-1;
            sgorder.Cells[5,prow]:=inttostr(pd_fl);
            if pd_fl<0 then sgorder.Cells[6,prow]:='�̿�'
            else if pd_fl>0 then sgorder.Cells[6,prow]:='��Ӯ'
              else sgorder.Cells[6,prow]:='��ƽ';
          except
            sgorder.Cells[5,prow]:='0';
            sgorder.Cells[5,prow]:='���ݳ���';
          end;
        end;
      end;
    end;
  end;
end;

procedure TfmCheck.sgorderSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  inherited;
  pcol:=acol;
  prow:=arow;
end;

procedure TfmCheck.N1Click(Sender: TObject);
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

procedure TfmCheck.N2Click(Sender: TObject);
begin
  inherited;
  if trim(sgorder.Cells[1,1])='' then
  begin
    Application.MessageBox('û�м�¼����ɾ��!','��ʾ��Ϣ',mb_iconwarning);
    exit;
  end;
  if Application.MessageBox('ȷʵҪɾ����¼��?','��ʾ��Ϣ',mb_iconquestion+mb_yesno)=idyes then
  begin
//    edttotals.Text:=floattostr(strtofloat(edttotals.Text)-strtofloat(sgorder.Cells[7,rows]));
    sgorder.RowCount:=sgorder.RowCount-1;
  end;
end;

procedure TfmCheck.BtnCheckAllClick(Sender: TObject);
var
  t_sql:widestring;
  fh_rs:olevariant;
  i:integer;
begin
  inherited;
 if application.MessageBox('�����������ֿ���̵㣬�ȽϷ�ʱ�䣬��ȷ����',pchar(application.Title),mb_iconinformation+mb_yesno)=idyes then
  begin

  cx_fl:=1;
  t_sql:='select Storage_NO,Goods_NO,Stock_amount,Goods_Name,singleprice from vSelectGoods where Storage_NO='+''''+trim(shopid)+'''';
  ipubtemp.ty_query(t_sql,fh_rs);
  if varisnull(fh_rs) then
  begin
    sgorder.RowCount:=2;
    sgorder.Rows[1].Text:='';
    application.MessageBox('����Ʒ���̣�',pchar(application.Title),mb_iconinformation);
    exit;
  end else
  begin
    dmmain.DSquery.Data:=fh_rs;
    if not dmmain.DSquery.Active then dmmain.DSquery.Open;
    setlength(pdall_maxnumber,dmmain.DSquery.RecordCount);
    sgorder.RowCount:=dmmain.DSquery.RecordCount+1;
    for i:=1 to dmmain.DSquery.RecordCount do
    begin
       sgorder.Rows[i].Text:='';
       sgorder.Cells[1,i]:=trim(dmmain.DSquery.fieldbyname('goods_no').AsString);
       sgorder.Cells[2,i]:=trim(dmmain.DSquery.fieldbyname('goods_name').AsString);
       sgorder.Cells[3,i]:=trim(dmmain.DSquery.fieldbyname('singleprice').AsString);
       sgorder.Cells[7,i]:=trim(dmmain.DSquery.fieldbyname('stock_amount').AsString);
       pdall_maxnumber[i-1]:=dmmain.DSquery.fieldbyname('stock_amount').AsInteger;
       dmmain.DSquery.Next;
     end;
  end;
 end;
end;

procedure TfmCheck.BtnSaveClick(Sender: TObject);
var
  i:integer;
begin
  inherited;
  if (trim(cmbg.Text)='') or (trim(cmbc.text)='') then
  begin
    application.MessageBox('��ѡ�����˻������!',pchar(application.Title),mb_iconinformation);
    exit;
  end;
  if not dmmain.cDScheck.Active then dmmain.cDScheck.Open;
  dmmain.cDScheck.Append;
///�����ˣ������δ����
  dmmain.cDScheck.FieldByName('c_code').AsString:=trim(editbh.Text);  //���ݱ��
  dmmain.cDScheck.FieldByName('c_shop').AsString:=trim(Handle_Part);       //�������id��
  dmmain.cDScheck.FieldByName('c_operater').AsString:= Handle_Man;  //trim(operater);
  dmmain.cDScheck.FieldByName('c_newdate').AsString:=trim(editrq.Text);  //¼������
  dmmain.cDScheck.FieldByName('c_newman').AsString:=trim(editzdr.Text);  //�Ƶ���
  dmmain.cDScheck.FieldByName('c_remark').AsString:=trim(editbz.Text);  //��ע
  dmmain.cDScheck.FieldByName('C_Auditer').AsString:=trim(cmbc.Text);  //�����
  dmmain.cDScheck.FieldByName('C_Jinshou').AsString:=trim(cmbg.Text);  //������
  dmmain.cDScheck.FieldByName('c_state').AsString:='4';      //�̵�״̬
  dmmain.cDScheck.Post;
  if not dmmain.cDScheckdetail.Active then dmmain.cDScheckdetail.Open;
  for i:=1 to sgorder.RowCount-1 do
  begin
    dmmain.cDScheckdetail.Append;
    dmmain.cDScheckdetail.FieldByName('CD_CheckCode').AsString:=trim(editbh.Text);   //���ݱ��
    dmmain.cDScheckdetail.FieldByName('CD_CCount').AsString:=trim(sgorder.Cells[4,i]);  //�̵�����
    dmmain.cDScheckdetail.FieldByName('CD_cName').AsString:=trim(sgorder.Cells[2,i]);   //��Ʒ����
    if sgorder.Cells[6,i]='��Ӯ' then dmmain.cDScheckdetail.FieldByName('CD_state').AsString:='1'   //�̵��־ 
    else if sgorder.Cells[6,i]='�̿�' then dmmain.cDScheckdetail.FieldByName('CD_state').AsString:='2'
         else if sgorder.Cells[6,i]='��ƽ' then dmmain.cDScheckdetail.FieldByName('CD_state').AsString:='0'
              else dmmain.cDScheckdetail.FieldByName('CD_state').AsString:='3';
    dmmain.cDScheckdetail.FieldByName('CD_Amount').AsString:=sgorder.Cells[5,i];    //��Ʒ���
    dmmain.cDScheckdetail.FieldByName('CD_cCode').AsString:=sgorder.Cells[1,i];   //��Ʒ���
    dmmain.cDScheckdetail.Post;
  end;
  try
    dmmain.cDScheck.ApplyUpdates(-1);
    dmmain.cDScheckdetail.ApplyUpdates(-1);
    init;
  except
    savefromdata(dmmain.cDScheck,'reports/check');
    savefromdata(dmmain.cDScheckdetail,'reports/check');
    application.MessageBox('��������ֹ����',pchar(application.Title),mb_iconwarning);
    exit;
  end;
  if pd_mode=1 then  //Ӫҵ���̵�
  begin

  end;


end;

procedure TfmCheck.sgorderDrawCell(Sender: TObject; ACol, ARow: Integer;
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

procedure TfmCheck.BitBtn1Click(Sender: TObject);
begin
  inherited;
  frmcheck_query:=Tfrmcheck_query.Create(self);
  try
    frmcheck_query.ShowModal;
  except
    showmessage('���ڴ�ʧ�ܣ�');
  end;
end;

procedure TfmCheck.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmmain.cDScheck.Close;
  dmmain.cDScheck.Data:=null;
  dmmain.cDScheckdetail.Close;
  dmmain.cDScheckdetail.Data:=null;
  inherited;

end;

end.

