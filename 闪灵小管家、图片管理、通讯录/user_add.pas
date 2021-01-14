unit user_add;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,mmsystem;

type
  Tadd_user = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox1: TComboBox;
    Edit3: TEdit;
    Edit2: TEdit;
    Edit1: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  add_user: Tadd_user;
  csql:string;
implementation
   uses manage;
{$R *.dfm}

{�Զ����������ź���}
function PlayWav(const FileName: string): Boolean;
begin
Result := PlaySound(PChar(FileName), 0, SND_ASYNC);
end;

procedure Tadd_user.BitBtn1Click(Sender: TObject);
begin
if (trim(edit1.Text)='') or (trim(edit2.Text)='') or (trim(edit3.Text)='') then
begin
 Playwav('sound\error.wav');
 messagebox(handle,'����û���Ϣ��д������','����',MB_OK+MB_ICONWARNING);
 edit1.SetFocus;
 exit;
 end;
 if trim(edit2.Text)<>trim(edit3.Text) then
 begin
 Playwav('sound\error.wav');
 messagebox(handle,'������������벻ͬ��'+#13#10+'���������룡','����',MB_OK+MB_ICONWARNING);
 edit2.Clear;
 edit3.Clear;
 edit2.SetFocus;
 exit;
 end;
 //*�жϴ��û��Ƿ��Ѿ�����
with manage_form.ADOQuery1 do
begin
 close;
 sql.Clear;
 csql:='select * from admin where user=:a';
 sql.Add(csql);
 Parameters[0].Value:=trim(edit1.Text);
 prepared;
 open;
end;
 if not manage_form.ADOQuery1.Eof then
 begin
 playwav('sound\info.wav');
 messagebox(handle,'���û��Ѿ����ڣ�','����',MB_OK+MB_ICONWARNING);
 manage_form.ADOQuery1.close;
 manage_form.ADOQuery1.sql.Clear;
 manage_form.ADOQuery1.sql.Add('select * from admin');
 manage_form.ADOQuery1.prepared;
 manage_form.ADOQuery1.open;
 exit;
  end;
 with manage_form.ADOQuery1 do
 begin
 close;
 sql.Clear;
 csql:='insert into admin values(:a,:b,:c)';
 sql.Add(csql);
 Parameters[0].Value:=trim(edit1.Text);
 Parameters[1].Value:=trim(edit2.Text);
 Parameters[2].Value:=combobox1.Text;
 ExecSQL;
 close;
 sql.Clear;
 sql.Add('select * from admin');
 prepared;
 open;
 end;
 edit1.Text:='';
 edit2.Text:='';
 edit3.Text:='';
 add_user.Close;
end;

procedure Tadd_user.Edit1Change(Sender: TObject);
begin
if length(trim(edit1.Text))>20 then
begin
playwav('sound\info.wav');
messagebox(handle,'�û�������ܳ���20λ��','����',MB_OK+MB_ICONWARNING);
edit1.MaxLength:=20;
end;
end;

procedure Tadd_user.Edit2Change(Sender: TObject);
begin
if length(trim(edit2.Text))>20 then
begin
playwav('sound\info.wav');
messagebox(handle,'��������ܳ���20λ��','����',MB_OK+MB_ICONWARNING);
edit2.MaxLength:=20;
end;
end;
end.
