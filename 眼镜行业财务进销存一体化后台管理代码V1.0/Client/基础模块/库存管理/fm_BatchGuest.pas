unit fm_BatchGuest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fm_Base, ExtCtrls, Buttons, StdCtrls, DBCtrls, Mask,DB;

type
  TfmBatchGuest = class(TfmBase)
    Panel2: TPanel;
    btnExit: TBitBtn;
    btnAdd: TBitBtn;
    btnEdit: TBitBtn;
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    btnDelete: TBitBtn;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Bevel2: TBevel;
    Label24: TLabel;
    Label25: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBComboBox2: TDBComboBox;
    DBEdit16: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    DBEdit20: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit21: TDBEdit;
    GroupBox1: TGroupBox;
    btnSelect: TSpeedButton;
    edtCode: TLabeledEdit;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DSBATCHGUEST: TDataSource;
    procedure Model(bl:Boolean);
    procedure btnExitClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit3Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmBatchGuest: TfmBatchGuest;

implementation

uses  func, untdatadm;

{$R *.dfm}
procedure TfmBatchGuest.Model(bl:Boolean);
var
  i:Integer;
begin
  btnAdd.Enabled:=bl;
  btnEdit.Enabled:=bl;
  btnDelete.Enabled:=bl;
  btnSelect.Enabled:=bl;
  edtCode.Enabled:=bl;
  btnSave.Enabled:=not bl;
  btnCancel.Enabled:=not bl;
  for i:=0 to self.ComponentCount-1 do
  begin
    if self.Components[i] is TDBEdit then
    begin
      TDBEdit(self.Components[i]).ReadOnly:=bl;
      if bl=false then TDBEdit(self.Components[i]).Color:=clInfoBk
      else TDBEdit(self.Components[i]).Color:=clCream;
    end;
    if self.Components[i] is TDBCombobox then
    begin
      TDBCombobox(self.Components[i]).ReadOnly:= bl;
      if bl=false then TDBComboBox(self.Components[i]).Color:=clInfoBk
      else TDBComboBox(self.Components[i]).Color:=clCream;
    end;
  end;
end;

procedure TfmBatchGuest.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmBatchGuest.btnAddClick(Sender: TObject);
var
  sql:widestring;
begin
  inherited;
  Model(false);
  sql:='';
  //dmmain.SocketConn.AppServer.batchguest(trim(sql));
  if  dmmain.cdsBatchGuest.Active then dmmain.cdsBatchGuest.close;
  dmmain.cdsBatchGuest.Params.ParamByName('no').AsString:='@';
  try
    dmmain.cdsBatchGuest.Open;
  except
  end;
  with dmMain.cdsBatchGuest do
  begin
    Append;
    FieldByName('BG_Times').Value:=0;
    FieldByname('BG_Money').Value:=0;
    FieldByname('BG_Point').Value:=0;
    FieldByName('BG_newDate').Value:=FormatDateTime('yyyy-mm-dd',now());
  end;
  dbedit1.SetFocus;
end;

procedure TfmBatchGuest.btnEditClick(Sender: TObject);
begin
  inherited;
  if not dmMain.cdsBatchGuest.Active then
  begin
    Application.MessageBox('û�м�¼�����޸�!','��ʾ��Ϣ',mb_iconwarning);
    exit;
  end;
  if (dmMain.cdsBatchGuest.recordcount = 0)  then
  begin
    Application.MessageBox('û�м�¼�����޸�!','��ʾ��Ϣ',mb_iconwarning);
    exit;
  end;
  Model(false);
  dbedit1.ReadOnly:=true;
  dbedit1.Color:=clCream;
  dmMain.cdsBatchGuest.Edit;
  dbedit3.SetFocus;
end;

procedure TfmBatchGuest.btnSaveClick(Sender: TObject);
begin
  inherited;
  with dmMain.cdsBatchGuest do
  begin
    if state in [dsInsert] then
    begin
      if dbedit1.Text='' then
      begin
        Application.MessageBox('�û���Ų���Ϊ��!','��ʾ��Ϣ',mb_iconwarning);
        dbedit1.SetFocus;
        exit;
      end;
    end;
    Model(true);
    Post;
    ApplyUpdates(-1); //APPLIYupdate(-1);
  end;
end;

procedure TfmBatchGuest.btnCancelClick(Sender: TObject);
begin
  inherited;
  Model(true);
  with dmMain.cdsBatchGuest do
  begin
    if state in [dsInsert,dsEdit] then
    Cancel;
  end;
end;

procedure TfmBatchGuest.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if not dmMain.cdsBatchGuest.Active then
  begin
    Application.messagebox('��ָ���ͻ����!', '��ʾ��Ϣ', mb_iconwarning + mb_defbutton1);
    exit;
  end;
  if dmMain.cdsBatchGuest.recordcount <> 0 then
  begin
    if Application.messagebox('ȷ��Ҫɾ���ü�¼��', '��ʾ��Ϣ', mb_iconQuestion + mb_yesno) = idyes then
    begin
      dmMain.cdsBatchGuest.delete;
      dmMain.cdsBatchGuest.applyupdates(-1); //applydatetime(-1);
    end;
  end
  else
  begin
    Application.messagebox('û�м�¼��ɾ��!', '��ʾ��Ϣ', mb_iconwarning + mb_defbutton1);
  end;
end;

procedure TfmBatchGuest.btnSelectClick(Sender: TObject);
begin
  inherited;
  if edtCode.Text<>'' then
  begin
    if  dmmain.cdsBatchGuest.Active then dmmain.cdsBatchGuest.close;
    dmmain.cdsBatchGuest.Params.ParamByName('no').AsString:=trim(edtcode.Text);
    try
    dmmain.cdsBatchGuest.Open;
    if dmmain.cdsBatchGuest.IsEmpty then
    begin
      application.MessageBox(pchar('û���ҵ��ͻ����Ϊ��'+trim(edtcode.Text)+'�Ŀͻ���'),pchar(application.Title),mb_iconinformation);
      exit; 
    end;
    except
    end;
  end;
end;

procedure TfmBatchGuest.FormCreate(Sender: TObject);
begin
  inherited;
  Model(true);
   //ͬ�����ۡ�
end;

procedure TfmBatchGuest.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  with dmMain.cdsBatchGuest do
  begin
    if state in [dsInsert,dsEdit] then
    Cancel;
  end;
  if dmmain.cdsBatchGuest.Active then dmmain.cdsBatchGuest.Close;
  action:=cafree
end;

procedure TfmBatchGuest.edtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key=#13 then
  begin
    btnselect.Click;
  end;
end;

procedure TfmBatchGuest.DBEdit3Exit(Sender: TObject);
var
  str:string;
begin
  inherited;
  if dmmain.cdsBatchGuest.state in [dsInsert,dsEdit] then
  begin
    if trim(dbedit3.Text)<>'' then
    begin
      str:= dbedit3.text;
      dbedit4.Text:=selectpy(str);
    end;
  end;
end;

end.
