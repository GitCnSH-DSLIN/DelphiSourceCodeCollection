unit U_User;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB, ADODB, Grids, DBGrids, ComCtrls, Mask,
  DBCtrls, Buttons;

type
  TfrmUse = class(TForm)
    Panel1: TPanel;
    tyqmp: TADOQuery;
    dstmp: TDataSource;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    Panel4: TPanel;
    btn_refresh: TSpeedButton;
    btn_insert: TSpeedButton;
    btn_edit: TSpeedButton;
    btn_cancel: TSpeedButton;
    btn_save: TSpeedButton;
    DBNavigator: TDBNavigator;
    Panel5: TPanel;
    dbcmbType: TDBComboBox;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    btn_delete: TSpeedButton;
    sbtnsetup: TSpeedButton;
    procedure btn_saveClick(Sender: TObject);
    procedure btn_refreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure btn_insertClick(Sender: TObject);
    procedure btn_editClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure sbtnsetupClick(Sender: TObject);
  private
    { Private declarations }
     procedure btn_valid;
  public
    { Public declarations }
  end;

var
  frmUse: TfrmUse;

implementation
    uses main,u_public,U_DM,U_pwd;
{$R *.dfm}
 procedure TfrmUse.btn_valid;
begin
  DBNavigator.enabled := not dbnavigator.enabled;
  btn_insert.enabled := not btn_insert.enabled;
  btn_delete.enabled := not btn_delete.enabled;
  btn_edit.enabled := not btn_edit.enabled;
  btn_cancel.enabled := not btn_cancel.enabled;
  btn_Save.enabled := not btn_Save.enabled;
  btn_refresh.enabled := not btn_refresh.enabled;
  sbtnsetup.Enabled:=not sbtnsetup.Enabled;
  Panel5.Enabled :=NOT Panel5.Enabled ;
end;
procedure TfrmUse.btn_saveClick(Sender: TObject);
begin
if (length(dbedit1.Text)=0) or (length(dbcmbType.Text)=0)then
begin
    application.MessageBox('��Ա����Ͳ������Ͳ�Ϊ�գ������������µ���ԱID��!', '��������ϵͳ', mb_iconinformation + mb_defbutton1);
    dbedit1.SetFocus;
    exit;
end;
if dm.ADO_USESZ.state = dsinsert then
begin
if findundo('log_id','usesz',trim(dbedit1.Text),frmmain.adoqytmp) then
begin
    application.MessageBox('��Ա�����Ѵ��ڣ������������µ���ԱID��!', '��������ϵͳ', mb_iconinformation + mb_defbutton1);
    dbedit1.SetFocus;
    exit;
end;
 if not CurrentParam.tmpFind then
 begin
    application.MessageBox('��û��������Ա���룬�������������룡', '��������ϵͳ', mb_iconinformation + mb_defbutton1);

    dbedit1.SetFocus;
    exit;
end;
end;
  dm.ADO_USESZ.Post;
  //����������ʾ���Ϊ������״̬
  btn_valid;

end;

procedure TfrmUse.btn_refreshClick(Sender: TObject);
begin

close;
dm.ADO_USESZ.Close ;
end;

procedure TfrmUse.FormCreate(Sender: TObject);
begin
dm.ADO_USESZ.Active :=true;

end;

procedure TfrmUse.btn_deleteClick(Sender: TObject);
begin
  //�ж��Ƿ��м�¼��ɾ��
  if dm.ADO_USESZ.recordcount = 0 then
  begin
    application.MessageBox('û�м�¼��ɾ��', '��������ϵͳ', mb_iconinformation + mb_defbutton1);
    exit;
  end;
  //ȷ��ɾ��
if trim(dbedit1.Text)='SYSTEM' then
begin
application.MessageBox('�Բ�����û��ɾ�����û���Ȩ�ޣ�', '��������ϵͳ', mb_iconinformation + mb_defbutton1);
exit;
end;

  if application.messagebox('��ȷ���Ƿ�Ҫɾ��', '��������ϵͳ', mb_iconinformation + mb_yesno) = idyes then
    dm.ADO_USESZ.delete;

end;

procedure TfrmUse.btn_insertClick(Sender: TObject);
begin
  //ȡ������
  dm.ADO_USESZ.Filter := '';
  dm.ADO_USESZ.Filtered := true;
  //���ݼ��������״̬
  dm.ADO_USESZ.Insert;
  //�ı��������Ч��
  btn_valid;
  dbedit1.SetFocus;
end;

procedure TfrmUse.btn_editClick(Sender: TObject);
begin
  //���ж��Ƿ��м�¼�ɱ༭
//  dm.tbsys_log.Close ;
//  dm.tbsys_log.Open ;
  if dm.ADO_USESZ.recordcount = 0 then
  begin
    application.MessageBox('û�м�¼���ܱ༭', '��������ϵͳ', mb_iconinformation + mb_defbutton1);
    exit;
  end;
    //ʹ���ݼ����ڱ༭״̬
  dm.ADO_USESZ.edit;
  //���������Ч��
  btn_valid;
  dbedit1.setfocus;
 // dbedit1.Enabled :=false;
end;

procedure TfrmUse.btn_cancelClick(Sender: TObject);
begin
dm.ADO_USESZ.CancelUpdates ;
 btn_valid;
end;

procedure TfrmUse.sbtnsetupClick(Sender: TObject);
var
frmPwd:TfrmPwd;
begin
if dm.ADO_USESZ.state = dsinsert then
begin
   CurrentParam.tmpFind :=false;
   frmPwd:=TfrmPwd.Create(self);
   frmPwd.ShowModal ;
end;   
end;

end.
