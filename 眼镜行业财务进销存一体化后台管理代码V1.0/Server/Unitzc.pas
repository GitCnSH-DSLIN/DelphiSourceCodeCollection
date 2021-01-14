unit Unitzc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,registry, Buttons, ComCtrls;

type
  TFormzc = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel3: TPanel;
    cfind: TAnimate;
    Panel4: TPanel;
    Label1: TLabel;
    Panel5: TPanel;
    editfwqmc: TLabeledEdit;
    edityhm: TLabeledEdit;
    edityhmm: TLabeledEdit;
    editsjkmc: TLabeledEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    r1: TRadioButton;
    r2: TRadioButton;
    labelzs: TLabel;
    procedure edityhmEnter(Sender: TObject);
    procedure edityhmmEnter(Sender: TObject);
    procedure editsjkmcEnter(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure editfwqmcKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure editsjkmcKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure r1Click(Sender: TObject);
    procedure r2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Formzc: TFormzc;
  flag:integer;
implementation

uses Chain_Data, Unitpubsub;

{$R *.dfm}

procedure TFormzc.edityhmEnter(Sender: TObject);
begin
  //labelzs.Caption:='�������û���[����Ϊ��]';
end;

procedure TFormzc.edityhmmEnter(Sender: TObject);
begin
  //labelzs.Caption:='������ע������[����Ϊ��]';
end;

procedure TFormzc.editsjkmcEnter(Sender: TObject);
begin
  application.MessageBox('���������ݿ�����','��ʾ',mb_iconwarning); 
end;

procedure TFormzc.BitBtn1Click(Sender: TObject);
var
  reg:treginifile;
  //reg:tinifile;
begin
  cfind.Active:=true;
  labelzs.Caption:='��������';
  reg:=treginifile.Create;
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  reg.WriteString('\software\manager_sales','��������',editfwqmc.Text);
  reg.WriteString('\software\manager_sales','�û�����',edityhm.Text);
  reg.WriteString('\software\manager_sales','�û�����',edityhmm.Text);
  reg.WriteString('\software\manager_sales','���ݿ�����',editsjkmc.Text);
  reg.WriteString('\software\manager_sales','����ģʽ',inttostr(flag));
  try
    application.CreateForm(Tfrm_Chain_Data,frm_Chain_Data);
  except
    reg.WriteString('\software\manager','��������','');
    reg.WriteString('\software\manager','�û�����','');
    reg.WriteString('\software\manager','�û�����','');
    reg.WriteString('\software\manager','���ݿ�����','');
    reg.WriteString('\software\manager','����ģʽ','');
    application.MessageBox('���ݿ����Ӵ�������ע����Ϣ�Ƿ���ȷ','����',mb_iconwarning);
    editfwqmc.SetFocus;
    reg.free;
    exit;
  end;
  application.MessageBox('���ݿ��������!',pchar(application.Title),mb_iconinformation);
  servername:=trim(editfwqmc.Text);
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\SOFTWARE\Microsoft\windows\CurrentVersion\Run',true); //д������е�������
  Reg.writeString ('SOFTWARE\Microsoft\windows\CurrentVersion\Dataservice',Application.Exename,'');
  reg.free;
  close;
end;

procedure TFormzc.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TFormzc.editfwqmcKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=13 then
    sendmessage(getactivewindow,wm_nextdlgctl,0,0);
end;

procedure TFormzc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
end;

procedure TFormzc.editsjkmcKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  sendmessage(getactivewindow,wm_nextdlgctl,0,0);
end;



procedure TFormzc.FormShow(Sender: TObject);
begin
  r2.Checked:=true;
  flag:=2;
end;

procedure TFormzc.r1Click(Sender: TObject);
begin
  if r1.Checked then
  begin
    edityhm.Enabled:=false;
    edityhmm.Enabled:=false;
    flag:=1;
  end else
  begin
    edityhm.Enabled:=true;
    edityhmm.Enabled:=true;
    flag:=0;
  end;
end;

procedure TFormzc.r2Click(Sender: TObject);
begin
   if r1.Checked then
  begin
    edityhm.Enabled:=false;
    edityhmm.Enabled:=false;
    flag:=1;
  end else
  begin
    edityhm.Enabled:=true;
    edityhmm.Enabled:=true;
    flag:=0;
  end;
end;

end.
