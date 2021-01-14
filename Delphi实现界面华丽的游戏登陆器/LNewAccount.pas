unit LNewAccount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Grobal2, RzButton, Main;

type
  TfrmNewAccount = class(TForm)
    GroupBox1: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    EditPassword: TEdit;
    EditAccount: TEdit;
    Label1: TLabel;
    EditConfirm: TEdit;
    Label2: TLabel;
    EditYourName: TEdit;
    Label3: TLabel;
    EditSSNo: TEdit;
    Label4: TLabel;
    EditBirthDay: TEdit;
    Label5: TLabel;
    EditQuiz1: TEdit;
    Label6: TLabel;
    EditAnswer1: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    EditQuiz2: TEdit;
    EditAnswer2: TEdit;
    MemoHelp: TMemo;
    Label11: TLabel;
    EditPhone: TEdit;
    Label12: TLabel;
    EditMobPhone: TEdit;
    Label13: TLabel;
    EditEMail: TEdit;
    Label14: TLabel;
    LabelStatus: TLabel;
    Label15: TLabel;
    ButtonOK: TRzButton;
    procedure EditEnter(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
  private
    function CheckUserEntrys():Boolean;
    function NewIdCheckBirthDay():Boolean;
    { Private declarations }

  public
    procedure Open();
    { Public declarations }
  end;

var
  frmNewAccount: TfrmNewAccount;
  NewIdRetryUE:TUserEntry;
  NewIdRetryAdd:TUserEntryAdd;
implementation

uses HUtil32{, EDecode};
var
  dwOKTick:LongWord;

{$R *.dfm}

function TfrmNewAccount.CheckUserEntrys: Boolean;
begin
   Result:=False;
   EditAccount.Text:=Trim(EditAccount.Text);
   EditQuiz1.Text := Trim(EditQuiz1.Text);
   EditYourName.Text := Trim(EditYourName.Text);
   if Length(EditAccount.Text) < 3 then begin
      Application.MessageBox('��¼�ʺŵĳ��ȱ������3λ��','��ʾ��Ϣ', MB_OK + MB_ICONINFORMATION);
      Beep;
      EditAccount.SetFocus;
      exit;
   end;
   if not NewIdCheckBirthday then exit;
   if Length(EditPassword.Text) < 3 then begin
      EditPassword.SetFocus;
      exit;
   end;
   if EditPassword.Text <> EditConfirm.Text then begin
      EditConfirm.SetFocus;
      exit;
   end;
   if Length(EditQuiz1.Text) < 1 then begin
      EditQuiz1.SetFocus;
      exit;
   end;
   if Length(EditAnswer1.Text) < 1 then begin
      EditAnswer1.SetFocus;
      exit;
   end;
   if Length(EditQuiz2.Text) < 1 then begin
      EditQuiz2.SetFocus;
      exit;
   end;
   if Length(EditAnswer2.Text) < 1 then begin
      EditAnswer2.SetFocus;
      exit;
   end;
   if Length(EditYourName.Text) < 1 then begin
      EditYourName.SetFocus;
      exit;
   end;
   Result:=True;
end;

procedure TfrmNewAccount.EditEnter(Sender: TObject);
begin
   if Sender = EditAccount then begin
      MemoHelp.Clear;
      MemoHelp.Lines.Add ('�����ʺ����ƿ��԰�����');
      MemoHelp.Lines.Add ('�ַ������ֵ���ϡ�');
      MemoHelp.Lines.Add ('�ʺ����Ƴ��ȱ���Ϊ4�����ϡ�');
      MemoHelp.Lines.Add ('��½�ʺŲ���Ϸ�е��������ơ�');
      MemoHelp.Lines.Add ('����ϸ���봴���ʺ�������Ϣ��');
      MemoHelp.Lines.Add ('���ĵ�½�ʺſ��Ե�½��Ϸ');
      MemoHelp.Lines.Add ('��������վ����ȡ��һЩ�����Ϣ��');
      MemoHelp.Lines.Add ('');
      MemoHelp.Lines.Add ('�������ĵ�½�ʺŲ�Ҫ����Ϸ�еĽ�');
      MemoHelp.Lines.Add ('ɫ����ͬ��');
      MemoHelp.Lines.Add ('��ȷ��������벻�ᱻ�����ƽ⡣');
      exit;
   end;
   if Sender = EditPassword then begin
      MemoHelp.Clear;
      MemoHelp.Lines.Add ('��������������ַ������ֵ���ϣ�');
      MemoHelp.Lines.Add ('�����볤�ȱ�������4λ��');
      MemoHelp.Lines.Add ('���������������ݲ�Ҫ���ڼ򵥣�');
      MemoHelp.Lines.Add ('�Է����˲µ���');
      MemoHelp.Lines.Add ('���ס����������룬�����ʧ����');
      MemoHelp.Lines.Add ('���޷���¼��Ϸ��');
   end;
   if Sender = EditConfirm then begin
      MemoHelp.Clear;
      MemoHelp.Lines.Add ('�ٴ���������');
      MemoHelp.Lines.Add ('��ȷ�ϡ�');
   end;
   if Sender = EditYourName then begin
      MemoHelp.Clear;
      MemoHelp.Lines.Add ('����������ȫ��.');
   end;
   if Sender = EditSSNo then begin
      MemoHelp.Clear;
      MemoHelp.Lines.Add ('������������֤��');
      MemoHelp.Lines.Add ('���磺 720101-146720');
   end;
   if Sender = EditBirthDay then begin
      MemoHelp.Clear;
      MemoHelp.Lines.Add ('��������������');
      MemoHelp.Lines.Add ('���磺1977/10/15');
   end;
   if Sender = EditQuiz1 then begin
      MemoHelp.Clear;
      MemoHelp.Lines.Add ('�������һ��������ʾ����');
      MemoHelp.Lines.Add ('�����ʾ���������붪ʧ����');
      MemoHelp.Lines.Add ('�������á�');
      MemoHelp.Lines.Add ('');
   end;
   if Sender = EditAnswer1 then begin
      MemoHelp.Clear;
      MemoHelp.Lines.Add ('���������������');
      MemoHelp.Lines.Add ('�𰸡�');
      MemoHelp.Lines.Add ('');
   end;
   if Sender = EditQuiz2 then begin
      MemoHelp.Clear;
      MemoHelp.Lines.Add ('������ڶ���������ʾ����');
      MemoHelp.Lines.Add ('�����ʾ���������붪ʧ����');
      MemoHelp.Lines.Add ('�������á�');
      MemoHelp.Lines.Add ('');
   end;
   if Sender = EditAnswer2 then begin
      MemoHelp.Clear;
      MemoHelp.Lines.Add ('���������������');
      MemoHelp.Lines.Add ('�𰸡�');
      MemoHelp.Lines.Add ('');
   end;
   if Sender = EditPhone then begin
      MemoHelp.Clear;
      MemoHelp.Lines.Add ('���������ĵ绰');
      MemoHelp.Lines.Add ('���롣');
      MemoHelp.Lines.Add ('');
   end;
   if Sender = EditMobPhone then begin
      MemoHelp.Clear;
      MemoHelp.Lines.Add ('�����������ֻ����롣');
      MemoHelp.Lines.Add ('');
   end;
   if Sender = EditEMail then begin
      MemoHelp.Clear;
      MemoHelp.Lines.Add ('�����������ʼ���ַ�������ʼ�����');
      MemoHelp.Lines.Add ('����������µ�һЩ��Ϣ');
      MemoHelp.Lines.Add ('');
   end;
end;

function TfrmNewAccount.NewIdCheckBirthDay: Boolean;
var
   str, t1, t2, t3, syear, smon, sday: string;
   ayear, amon, aday, sex: integer;
   flag: Boolean;
begin
   Result := TRUE;
   flag := TRUE;
   str := EditBirthDay.Text;
   str := GetValidStr3 (str, syear, ['/']);
   str := GetValidStr3 (str, smon, ['/']);
   str := GetValidStr3 (str, sday, ['/']);
   ayear := Str_ToInt(syear, 0);
   amon := Str_ToInt(smon, 0);
   aday := Str_ToInt(sday, 0);
   if (ayear <= 1890) or (ayear > 2101) then flag := FALSE;
   if (amon <= 0) or (amon > 12) then flag := FALSE;
   if (aday <= 0) or (aday > 31) then flag := FALSE;
   if not flag then begin
      Beep;
      EditBirthDay.SetFocus;
      Result := FALSE;
   end;
end;

procedure TfrmNewAccount.ButtonOKClick(Sender: TObject);
var
   ue: TUserEntry;
   ua: TUserEntryAdd;
begin
  if GetTickCount - dwOKTick < 5000 then begin
    Application.MessageBox('���Ժ��ٵ�ȷ��������','��ʾ��Ϣ',MB_OK + MB_ICONINFORMATION);
    exit;
  end;
  if CheckUserEntrys then begin
    FillChar(ue, sizeof(TUserEntry), #0);
    FillChar(ua, sizeof(TUserEntryAdd), #0);
    ue.sAccount:= LowerCase(EditAccount.Text);
    ue.sPassword:= EditPassword.Text;
    ue.sUserName:= EditYourName.Text;
    ue.sSSNo:= '650101-1455111';
    ue.sQuiz:= EditQuiz1.Text;
    ue.sAnswer:= Trim(EditAnswer1.Text);
    ue.sPhone:= EditPhone.Text;
    ue.sEMail:= Trim(EditEMail.Text);
    ua.sQuiz2:= EditQuiz2.Text;
    ua.sAnswer2:= Trim(EditAnswer2.Text);
    ua.sBirthday:= EditBirthday.Text;
    ua.sMobilePhone:= EditMobPhone.Text;
    NewIdRetryUE := ue;
    NewIdRetryUE.sAccount := '';
    NewIdRetryUE.sPassword := '';
    NewIdRetryAdd := ua;
    MainForm.SendUpdateAccount(ue, ua);
    ButtonOK.Enabled:=False;
    dwOKTick:=GetTickCount();    
  end;
end;


procedure TfrmNewAccount.Open;
begin
  ButtonOK.Enabled:=True;
  EditAccount.Text:='';
  EditPassword.Text:='';
  EditConfirm.Text:='';
  EditYourName.Text:='';
  EditBirthDay.Text:='';
  EditQuiz1.Text:='';
  EditAnswer1.Text:='';
  EditQuiz2.Text:='';
  EditAnswer2.Text:='';
  EditEMail.Text:='';
  EditPhone.Text:='';
  EditMobPhone.Text:='';
  ShowModal;
end;

end.
