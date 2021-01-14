unit login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls, DB, ADODB,mmsystem;

type
  Tlogin_form = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ADOQuery1: TADOQuery;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    loginname:string;
  end;

var
  login_form: Tlogin_form;
  csql:string;
  loginTimes:integer;

implementation
  uses  main;
{$R *.dfm}

{�Զ����������ź���}
function PlayWav(const FileName: string): Boolean;
begin
Result := PlaySound(PChar(FileName), 0, SND_ASYNC);
end;

procedure Tlogin_form.BitBtn2Click(Sender: TObject);
begin
application.Terminate;
end;

procedure Tlogin_form.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
application.Terminate;
end;

procedure Tlogin_form.BitBtn1Click(Sender: TObject);
begin
{���ݿ�������ж��û��������Ƿ���ȷ}
  if (trim(edit1.Text)='') or (trim(edit2.Text)='') then
  begin
  playwav ('sound\error');
  messagebox(handle,'�������û��������룡','����',MB_OK+MB_ICONERROR);
  edit1.SetFocus;
  end
  else
  begin
   with ADOQuery1 do
   begin
    close;
    sql.Clear;
    csql:='select * from admin where user="'+trim(edit1.Text)+'" and password="'+trim(edit2.Text)+'"';
    sql.Add(csql);
    Prepared;
    open;
   end;
   if  ADOQuery1.Eof then
   begin
    LoginTimes:=LoginTimes+1;
     playwav('sound\error.wav');
     messagebox(handle,'��������û����������� '+#13#10+'��˶Ժ������룡','����',MB_OK+MB_ICONERROR);
     edit1.Text:='';
     edit2.Text:='';
     edit1.SetFocus;
     if LoginTimes>=3 then
     begin
     playwav('sound\info.wav');
     messagebox(handle,'���������û���������� '+#13#10+'ϵͳ���Զ��˳���','����',MB_OK+MB_ICONinformation);
     application.Terminate;
     end;
   end
   else
   begin
     loginTimes:=0;
     loginname:=ADOQuery1.FieldValues['user'];
     edit1.Text:='';
     edit2.Text:='';
     ADOQuery1.Free;
     login_form.SendToBack;
      login_form.Hide;
      main_form.Show;
      login_form.Free;
   end;
  end;
end;

end.
