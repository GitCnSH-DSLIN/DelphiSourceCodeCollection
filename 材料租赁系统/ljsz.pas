unit ljsz;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ComCtrls, ImgList, ExtCtrls, Registry, Spin, Db,
  DBClient, variants;

type
  TfrmLjsz = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    Panel2: TPanel;
    Label1: TLabel;
    edtAppHost: TEdit;
    Label2: TLabel;
    edtAppIP: TEdit;
    btnAppName: TBitBtn;
    Label3: TLabel;
    edtPort: TEdit;
    btnOK: TSpeedButton;
    btnCancel: TSpeedButton;
    procedure btnOKClick(Sender: TObject);
    procedure edtAppHostExit(Sender: TObject);
    procedure edtAppIPExit(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnAppNameClick(Sender: TObject);
    procedure edtAppHostKeyPress(Sender: TObject; var Key: Char);
    procedure edtAppIPKeyPress(Sender: TObject; var Key: Char);
    procedure edtPortKeyPress(Sender: TObject; var Key: Char);
  private
    //��ע���д��Ӧ��������Ϣ
    procedure WriteToReg(const bAppHost, bAppIP, aPort: string);
    { Private declarations }
  public
    { Public declarations }
  end;

//�����ô��ڣ��������Ƿ����ӳɹ�
function LjszExecute(aFormClass: TFormClass): boolean;

var
  frmLjsz: TfrmLjsz;
  Connected: boolean= false; //�����Ƿ����ӳɹ� ��
implementation
uses u_main,U_NET,u_public;
{$R *.DFM}

//�����ô��ڣ��������Ƿ����ӳɹ�
function LjszExecute(aFormClass: TFormClass): boolean;
begin
  with aFormClass.Create(Application) do
  begin
    Connected := False;
    try
      showModal;
    finally
      free;
    end;
    result := Connected;
  end;
end;

//��ע�����д��Ӧ�÷�������������Ϣ
procedure TfrmLjsz.WriteToReg(const bAppHost, bAppIP, aPort: string);
var
  Reg: Tregistry;
begin
  reg := Tregistry.create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  if not Reg.OpenKey('\Software\�ִ�����', False) then
  begin
    reg.createkey('\Software\�ִ�����');
    Reg.OpenKey('\Software\�ִ�����', False);
  end;
  Reg.WriteString('Host', bAppHost);
  Reg.WriteString('Address', bAppIP);
  Reg.WriteString('Port', aPort);
  reg.free;
end;

procedure TfrmLjsz.btnOKClick(Sender: TObject);
begin
  if ((edtAppHost.text = null) or (edtAppHost.text = '')) and ((edtAppIP.text = null) or (edtAPPIP.text = '')) then
  begin
    Application.MessageBox('������Ӧ�÷��������ֻ�IP��', '�������..', mb_iconinformation + mb_defbutton1);
    exit;
  end;
  try
    strtoint(edtPort.text);
  except
    Application.MessageBox('��������ȷ�Ķ˿ں�', '�������..', mb_iconinformation + mb_defbutton1);
    exit;
  end;
  statusbar1.panels[0].text := '��������Ӧ�ó�������������Ժ�..';
  statusbar1.refresh;
  Screen.cursor := crHourGlass;
//  frmMain.SocketConnection.Connected := false;
//  frmMain.SocketConnection.Host := edtAppHost.text;
//  frmMain.SocketConnection.Address := edtAppIP.text;
//  frmMain.SocketConnection.Port := strtoint(edtPort.text);
  try
//    frmMain.SocketConnection.Connected := true;
    screen.Cursor := crDefault;
    application.MessageBox('���ӳɹ�', '���ʹ���ϵͳ', mb_iconinformation + mb_defbutton1);
    Connected := True;
  except
    screen.cursor := crdefault;
    application.MessageBox('����ʧ��', '���ʹ���ϵͳ', mb_iconinformation + mb_defbutton1);
    statusbar1.panels[0].text := '����ʧ�ܣ�������..';
    statusbar1.refresh;
    exit;
  end;
  //���ӳɹ���ע�����д��Ӧ�÷�����������Ϣ
  CurrentParam.IP :=edtappip.Text;
  CurrentParam.Host := edtAppHost.Text;
  WriteToReg(edtAppHost.Text, edtAppIP.Text, edtPort.Text);
  close;
end;

//�رմ���
procedure TfrmLjsz.btnCancelClick(Sender: TObject);
begin
  close;
end;

//���ÿ��ӻ�������ѡ������
procedure TfrmLjsz.btnAppNameClick(Sender: TObject);
begin
  edtAppIP.clear;
  edtAppHost.text := NetExecute(TFrmNet);
end;

//��Ӧ�÷�������������Զ���Ӧ�÷�����IP��ַ������ÿ�
procedure TfrmLjsz.edtAppHostExit(Sender: TObject);
begin
//  if edtAppHost.Text <> '' then
//    edtAppIP.Text := '';
end;

//��Ӧ�÷�����IP��ַ������Զ���Ӧ�÷�������������ÿ�
procedure TfrmLjsz.edtAppIPExit(Sender: TObject);
begin
//  if edtAppIP.Text <> '' then
//    edtAppHost.Text := '';
end;

//Ӧ�÷�����������򰴼��¼��������¡��س������󣬽����뽹��ת�Ƶ�����˿ں������
procedure TfrmLjsz.edtAppHostKeyPress(Sender: TObject; var Key: Char);
begin
//  edtAppIP.clear;
//  if key = #13 then
//    edtPort.SetFocus;
end;

//Ӧ�÷�����IP��ַ����򰴼��¼��������¡��س������󣬽����뽹��ת�Ƶ�����˿ں������
procedure TfrmLjsz.edtAppIPKeyPress(Sender: TObject; var Key: Char);
begin
//  edtAppHost.clear;
//  if key = #13 then
//    edtPort.SetFocus;
end;

//�˿ں�����򰴼��¼��������¡��س������󣬵��á�ȷ������ť��Click����
procedure TfrmLjsz.edtPortKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    btnOK.click;
end;

end.

