unit U_Ckdakp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, Buttons, StdCtrls, Mask, DBCtrls, Db, DBClient;

type
  TfrmCkxx_KP = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    btnCancel: TSpeedButton;
    btnOK: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCkxx_KP: TfrmCkxx_KP;

implementation

uses U_ckxxwh, main, WzglDB,uWarehouseSetting, uDB;

{$R *.DFM}

procedure TfrmCkxx_KP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmWarehouse.XXDB_CKDYB.cancel;
  dmWarehouse.XXDB_CKDYB.cancelupdates;
end;

procedure TfrmCkxx_KP.btnCancelClick(Sender: TObject);
begin
  close;
end;

//ȷ�ϲ���
procedure TfrmCkxx_KP.btnOKClick(Sender: TObject);
var
  s_ckmc: string;
begin
  if trim(dbedit1.text) = '' then
  begin
    application.messagebox('�ֿ����Ʋ���Ϊ��', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
    dbedit1.setfocus;
    exit;
  end;
//�ظ����
  s_ckmc := dbedit1.Text;

  //���ֿ������Ƿ����ظ�
  
{  dmDB.XXDB_CKXX_INDEX.IndexFieldNames := '�ֿ�����';
  dmDB.XXDB_CKXX_INDEX.Refresh;
  if dmDB.XXDB_CKXX.state = dsinsert then
  begin
    if dmDB.XXDB_CKXX_INDEX.FindKey([s_ckmc]) then
    begin
      application.MessageBox('�ֿ��������ظ�', '���ʹ���ϵͳ', mb_iconinformation + mb_defbutton1);
      dbedit1.SetFocus;
      exit;
    end; 
  end;  }
  if trim(dbedit2.text) = '' then
  begin
    application.messagebox('�ֿ�ص㲻��Ϊ��', '���ʹ���ϵͳ', mb_iconinformation + mb_defbutton1);
    dbedit2.setfocus;
    exit;
  end;

  dmWarehouse.XXDB_CKDYB.post;
  dmWarehouse.XXDB_CKDYB.UpdateBatch;//.ApplyUpdates(0);
  close;
end;

end.
