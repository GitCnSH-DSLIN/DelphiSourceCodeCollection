  unit pass;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, ADODB,mmsystem;

type
  Trepass = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    procedure Edit2Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  repass: Trepass;

implementation
 uses manage;
{$R *.dfm}

function PlayWav(const FileName: string): Boolean;
begin
Result := PlaySound(PChar(FileName), 0, SND_ASYNC);
end;

procedure Trepass.Edit2Change(Sender: TObject);
begin
if length(trim(edit1.Text))>20 then
begin
playwav('sound\info.wav');
messagebox(handle,'��������ܳ���20λ��','����',MB_OK+MB_ICONWARNING);
edit1.MaxLength:=20;
end;
end;

procedure Trepass.BitBtn1Click(Sender: TObject);
var pass:string;
begin
pass:=manage_form.ADOQuery1.FieldValues['password'];
if (trim(edit1.Text)='') or (trim(edit2.Text)='') or (trim(edit3.Text)='') then
    begin
      playwav('sound\error.wav');
      messagebox(handle,'���������д������','��ʾ',MB_OK+MB_ICONWARNING);
      exit;
    end;
if trim(edit2.Text)<>trim(edit3.Text) then
    begin
      playwav('sound\error.wav');
      messagebox(handle,'��������������벻ͬ��'#13#10'���������룡','��ʾ',MB_OK+MB_ICONWARNING);
      edit2.Text:='';
      edit3.Text:='';
      exit;
    end;
if trim(edit2.Text)<>pass then
   begin
      playwav('sound\error.wav');
      messagebox(handle,'����д�ľ����벻��ȷ��','��ʾ',MB_OK+MB_ICONWARNING);
      edit1.Text:='';
      exit;
   end
   else
   begin
    manage_form.ADOQuery1.Edit;
    manage_form.ADOQuery1.FieldValues['password']:=trim(edit3.Text);
    manage_form.ADOQuery1.Post;
    playwav('sound\sucess.wav');
    messagebox(handle,'�����޸ĳɹ���','��ʾ',MB_OK+MB_ICONINFORMATION);
    edit1.Text:='';
    edit2.Text:='';
    edit3.Text:='';
    repass.Close;
   end;

end;

end.
