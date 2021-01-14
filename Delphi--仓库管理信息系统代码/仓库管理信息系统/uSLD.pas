unit uSLD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Buttons, Mask, Grids, DBGrids, ExtCtrls, Db, DBClient,
  ComCtrls, Menus, ImgList, Qrctrls, variants, ADODB;

type
  TfrmSLD = class(TForm)
    btnAppend: TSpeedButton;
    btnDelete: TSpeedButton;
    btnEdit: TSpeedButton;
    btnSave: TSpeedButton;
    btnCancel: TSpeedButton;
    btnUndo: TSpeedButton;
    btnSH: TSpeedButton;
    btnRefresh: TSpeedButton;
    Panel1: TPanel;
    pnl_Main: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label39: TLabel;
    edtSlzh: TDBEdit;
    edtZdrq: TDBEdit;
    edtGycj: TDBEdit;
    edtWzly: TDBEdit;
    edtCgr: TDBEdit;
    edtHtbh: TDBEdit;
    edtFph: TDBEdit;
    edtShr: TDBEdit;
    edtDjbz: TDBEdit;
    cbSfsh: TDBCheckBox;
    cmbCkmc: TDBComboBox;
    btn_cgr: TBitBtn;
    DBGrid: TDBGrid;
    pnl_Main1: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edtZg: TDBEdit;
    edtZdr: TDBEdit;
    edtYsr: TDBEdit;
    btn_zg: TBitBtn;
    btn_zdr: TBitBtn;
    btn_ysr: TBitBtn;
    dsSLD: TDataSource;
    dsSLD_DETAIL: TDataSource;
    aqSLDMAIN: TADOQuery;
    aqSLDDetail: TADOQuery;
    pm_Detail: TPopupMenu;
    pmi_Insert: TMenuItem;
    pmi_Delete: TMenuItem;
    Label16: TLabel;
    Label8: TLabel;
    edtFpje: TDBEdit;
    Label9: TLabel;
    edtQzyzf: TDBEdit;
    DBNavigator: TDBNavigator;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_editClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure btn_saveClick(Sender: TObject);
    procedure btn_cgrClick(Sender: TObject);
    procedure btn_zgClick(Sender: TObject);
    procedure btn_zdrClick(Sender: TObject);
    procedure btn_ysrClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAppendClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnUndoClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure DBNavigatorClick(Sender: TObject; Button: TNavigateBtn);
    procedure pmi_InsertClick(Sender: TObject);
    procedure pmi_DeleteClick(Sender: TObject);
    procedure btnSHClick(Sender: TObject);
  private
    procedure btn_valid;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSLD: TfrmSLD;

implementation

uses uDB, uPublic, U_fzlr_clbm, U_Sldjshkp;

{$R *.DFM}

procedure TfrmSLD.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := cafree;
  frmSLD := nil;
end;

procedure TfrmSLD.btn_valid;
begin
  DBNavigator.enabled := not dbnavigator.enabled;
  btnUndo.enabled := not btnUndo.enabled;
  btnAppend.enabled := not btnAppend.enabled;
  btnDelete.enabled := not btnDelete.enabled;
  btnEdit.enabled := not btnEdit.enabled;
  btnSave.enabled := not btnSave.enabled;
  btnSH.enabled := not btnSH.enabled;
  btnRefresh.enabled := not btnRefresh.enabled;
  //��ʾ�����л�
  pnl_Main.enabled := not pnl_Main.enabled;
  pnl_Main1.enabled := not pnl_Main1.enabled;
  //DBGrid��2��3��4��5�ֶ�״̬�л��������ֶ�����ֻ��
  dbgrid.Columns[2].readonly := not dbgrid.Columns[2].readonly;
  dbgrid.Columns[3].readonly := not dbgrid.Columns[3].readonly;
  dbgrid.Columns[4].readonly := not dbgrid.Columns[4].readonly;
  dbgrid.Columns[5].readonly := not dbgrid.Columns[5].readonly;
  //����¼�밴ť�Ŀɼ����л�
  btn_cgr.visible := not btn_cgr.visible;
  btn_zg.visible := not btn_zg.visible;
  btn_zdr.visible := not btn_zdr.visible;
  btn_ysr.visible := not btn_ysr.visible;
end;

procedure TfrmSLD.btn_editClick(Sender: TObject);
begin
  //���ж��Ƿ��м�¼�ɱ༭
  if aqSLDMain.recordcount = 0 then
  begin
    application.MessageBox('û�м�¼���ܱ༭', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
    exit;
  end;
  //�жϴ˵����Ƿ�����˹��ˣ�������ˣ��Ͳ����޸�
  if aqSLDMain.FieldByName('�Ƿ����').value = true then
  begin
    application.messagebox('�˵�������ˣ����ܱ༭', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
    exit;
  end;
  //ʹ���ݼ����ڱ༭״̬
  dsSLD.edit;
  edtSlzh.enabled := false;
  //���������Ч��
  btn_valid;
  cmbckmc.setfocus;
end;

procedure TfrmSLD.btn_cancelClick(Sender: TObject);
begin
  //�����ղŵĲ���
  aqSLDMain.CancelUpdates;
  //����������ʾ���Ϊ������״̬
  btn_valid;
end;

procedure TfrmSLD.btn_saveClick(Sender: TObject);
var
  s_slzh: string;
begin
  //������ݵ���Ч��
  if cmbCkmc.text = '' then
  begin
    application.MessageBox('�ֿ����Ʋ���Ϊ��', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
    cmbCkmc.SetFocus;
    exit;
  end;
  if length(trim(edtSlzh.text)) <> 9 then
  begin
    application.MessageBox('�����ֺ�ӦΪ��λ', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
    edtSlzh.SetFocus;
    exit;
  end;
  //�жϹؼ����Ƿ��ظ�
  s_slzh := edtSlzh.Text;
  aqSLDMain.IndexName := '�����ֺ�';
  aqSLDMain.Refresh;
  if dsSLD.state = dsinsert then
  begin
    //����ظ�
   { if aqSLDMain.FindField(s_slzh) then
    begin
      application.MessageBox('�����ֺ����ظ�', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
      edtSlzh.SetFocus;
      exit;
    end;       }
  end;
  //�ύ���������ݿ�
  aqSLDMain.Post;
 // aqSLDMain.ApplyUpdates(0);
  //����������ʾ���Ϊ������״̬
  btn_valid;
end;

procedure TfrmSLD.btn_cgrClick(Sender: TObject);
begin
  aqSLDMain.FieldByName('StockPerson').value := GetEmployeeName;
end;

procedure TfrmSLD.btn_zgClick(Sender: TObject);
begin
  aqSLDMain.FieldByName('Admin').value := GetEmployeeName;
end;

procedure TfrmSLD.btn_zdrClick(Sender: TObject);
begin
  aqSLDMain.FieldByName('DrawPerson').value := GetEmployeeName;
end;

procedure TfrmSLD.btn_ysrClick(Sender: TObject);
begin
  aqSLDMain.FieldByName('CheckPerson').value := GetEmployeeName;
end;

procedure TfrmSLD.FormShow(Sender: TObject);
var
  s_value: string;
  query: TADOQuery;
begin
  //����ֿ���Ϣ��
  query := TADOquery.Create(self);
  query.Connection:= dmWarehouse.ACWarehouse;
  query.SQL.Text := 'select * from CKDYB' ;
  query.open;
  cmbCkmc.Items.Clear ;
  //ѭ����������д��ֿ�����
  while not query.eof do
  begin
    s_value := query.fieldbyname('WName').asstring;
    cmbCkmc.Items.Add(s_value);
    query.next;
  end;
  
  aqSLDMain.Close;
  aqSLDDetail.Close;

  aqSLDMain.Open;
  aqSLDDetail.SQL.Text:='select * from SLD_DETAIL where  InNo="'+trim(edtSlzh.Text)+'"';
  aqSLDDetail.Open;
end;

procedure TfrmSLD.btnAppendClick(Sender: TObject);
begin
  //ȡ������
  aqSLDMain.filter := '';
  aqSLDMain.filtered := true;
  //���ݼ��������״̬
  aqSLDMain.Insert;
  edtSlzh.enabled := true;
  //�ı��������Ч��
  btn_valid;
  cmbCkmc.SetFocus;
  aqSLDDetail.SQL.Text:='select * from SLD_DETAIL where InNo="'+trim(edtSlzh.Text)+'"';
  aqSLDDetail.Open;
end;

procedure TfrmSLD.btnDeleteClick(Sender: TObject);
begin
  //�ж��Ƿ��м�¼��ɾ��
  if aqSLDMain.recordcount = 0 then
  begin
    application.MessageBox('û�м�¼��ɾ��', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
    exit;
  end;
  //ȷ��ɾ��
  if application.messagebox('��ȷ���Ƿ�Ҫɾ��', '�ֿ����ϵͳ', mb_iconinformation + mb_yesno) = idyes then
  begin
    aqSLDMain.delete;
  //  aqSLDMain.applyupdates(0);
  end;
end;

procedure TfrmSLD.btnEditClick(Sender: TObject);
begin
  //���ж��Ƿ��м�¼�ɱ༭
  if aqSLDMain.recordcount = 0 then
  begin
    application.MessageBox('û�м�¼���ܱ༭', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
    exit;
  end;
  //�жϴ˵����Ƿ�����˹��ˣ�������ˣ��Ͳ����޸�
  if aqSLDMain.FieldByName('IsAuditing').value = true then
  begin
    application.messagebox('�˵�������ˣ����ܱ༭', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
    exit;
  end;
  //ʹ���ݼ����ڱ༭״̬
  dsSLD.edit;
  edtSlzh.enabled := false;
  //���������Ч��
  btn_valid;
  cmbckmc.setfocus;
end;

procedure TfrmSLD.btnUndoClick(Sender: TObject);
begin
  //�����ղŵĲ���
  aqSLDMain.CancelUpdates;
  //����������ʾ���Ϊ������״̬
  btn_valid;
end;

procedure TfrmSLD.btnSaveClick(Sender: TObject);
var
  s_slzh: string;
  query: TADOQuery;
begin
  //������ݵ���Ч��
  if cmbCkmc.text = '' then
  begin
    application.MessageBox('�ֿ����Ʋ���Ϊ��', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
    cmbCkmc.SetFocus;
    exit;
  end;
  if length(trim(edtSlzh.text)) <> 9 then
  begin
    application.MessageBox('�����ֺ�ӦΪ��λ', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
    edtSlzh.SetFocus;
    exit;
  end;
  //�жϹؼ����Ƿ��ظ�
  s_slzh := edtSlzh.Text;
  if aqSLDMain.state = dsinsert then
  begin
      query := TADOquery.Create(self);
      query.Connection:= dmWarehouse.ACWarehouse;
      query.SQL.Text := 'select * from SLD_MAIN where InNo ="' + s_slzh + '"' ;
      query.open;
      if not query.Eof then
      begin
        MessageBox(handle, '�������ֺ��Ѵ���!', '��ʾ', mb_IconInformation + mb_Ok);
        aqSLDMain.Cancel;
        edtSlzh.SetFocus;
        exit;
      end
  end;
  //�ύ���������ݿ�
  aqSLDMain.Post;
  //dsSLD.ApplyUpdates(0);
  //����������ʾ���Ϊ������״̬
  btn_valid;
end;

procedure TfrmSLD.btnRefreshClick(Sender: TObject);
begin
  aqSLDMain.open;
  aqSLDDetail.SQL.Text:='select * from SLD_DETAIL where InNo="'+trim(edtSlzh.Text)+'"';
  aqSLDDetail.Open;
end;

procedure TfrmSLD.btnCancelClick(Sender: TObject);
begin
  frmSld := nil;
  close;
end;

procedure TfrmSLD.DBNavigatorClick(Sender: TObject; Button: TNavigateBtn);
begin
     aqSLDDetail.SQL.Text:='select * from SLD_DETAIL where InNo="'+trim(edtSlzh.Text)+'"';
     aqSLDDetail.Open; 
end;

procedure TfrmSLD.pmi_InsertClick(Sender: TObject);
var
  i: integer;
  query: TADOQuery;
begin
  //�ж��Ƿ��ڱ༭״̬��
  if btnEdit.Enabled = true then
  begin
    application.MessageBox('���ڱ༭״̬����Ӳ���', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
    exit;
  end;
  if  aqSLDMain.state = dsinsert then
  begin
    application.MessageBox('���ڱ༭״̬����Ӳ���', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
    exit;
  end;
  
  //��������¼�봰��
  application.createform(TfrmClbm_Fzlr, frmClbm_Fzlr);
  try
    frmClbm_Fzlr.showmodal;
  finally
    frmClbm_Fzlr.free;
  //��ѡ�еĲ��ϼӵ�DBGrid��
    for i := Low(ClbmRec) to High(clbmRec) do
    begin
      aqSLDDetail.Active := True;
      aqSLDDetail.open;
//      aqSLDDetail.Filter := 'InNo=' + '''' + aqSLDMain.fieldbyname('InNo').asstring + '''';
//      aqSLDDetail.filtered := true;
//      aqSLDDetail.IndexFieldNames := '���ϱ��';
      //�ж��Ƿ����ظ��Ĳֿ�
{      query := TADOQuery.Create(self);
      query.Connection:= dmWarehouse.ACWarehouse;
      query.SQL.Text := 'select * from CLBM_TEMP where MatCode="' + clbmRec[i].clbm + '"' ;
      query.open;
      if not query.Eof then
      begin
        MessageBox(handle, '�˲��ϱ����Ѵ���!', '��ʾ', mb_IconInformation + mb_Ok);
        continue;
      end;       }
      //��ӽ�aqSLDDetail
      aqSLDDetail.insert;
      aqSLDDetail.fieldbyname('InNo').value := aqSLDMain.fieldbyname('InNo').asstring;
      aqSLDDetail.fieldbyname('MatCode').value := ClbmRec[i].clbm;
      aqSLDDetail.fieldbyname('MatName').value := ClbmRec[i].clmc;
      aqSLDDetail.fieldbyname('Size').value := ClbmRec[i].ggxh;
      aqSLDDetail.fieldbyname('CUnit').value := ClbmRec[i].jldw;
      aqSLDDetail.fieldbyname('PlanPrice').value := ClbmRec[i].jhdj;
      aqSLDDetail.fieldbyname('PriceUnit').value := ClbmRec[i].djdw;
      aqSLDDetail.fieldbyname('BillNum').value := 0.0;
      aqSLDDetail.fieldbyname('InNum').value := 0.0;
      aqSLDDetail.post;
    end;
  end;
  dbgrid.Refresh;
end;

procedure TfrmSLD.pmi_DeleteClick(Sender: TObject);
begin
  //�ж��Ƿ��м�¼��ɾ��
  if aqSLDDetail.recordcount = 0 then
  begin
    application.MessageBox('û�м�¼��ɾ��', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
    exit;
  end;
  //�ж��Ƿ������״̬��
  if (btnEdit.enabled = false) then
  begin
    application.MessageBox('�������״̬��ɾ���ֿ�', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
    exit;
  end;
  if application.messagebox('��ȷ���Ƿ�Ҫɾ��', '�ֿ����ϵͳ', mb_iconinformation + mb_yesno) = idyes then
  begin
    aqSLDDetail.delete;
  end;
end;

//��˴���
procedure TfrmSLD.btnSHClick(Sender: TObject);
begin
  if aqSLDMAIN.FieldByName('IsAuditing').value = true then
  begin
    application.MessageBox('�˵��������', '������ƻ�����ϵͳ', mb_iconinformation + mb_defbutton1);
    exit;
  end;
  if application.MessageBox('��ȷ���Ƿ����ͨ��', 'Tip', mb_iconinformation + mb_yesno) = idyes then
  begin
    application.createform(TfrmClsldDjsh, frmClsldDjsh);
    try
      aqSLDMAIN.edit;
      frmClsldDjsh.showmodal;
    finally
      frmClsldDjsh.free;
    end;
  end;
end;

end.

