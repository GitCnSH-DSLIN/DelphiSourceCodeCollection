unit LogVisor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, ImgList;

type
  TLogForm = class(TForm)
    Page1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    ImageList1: TImageList;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Button3: TButton;
    Button4: TButton;
    Label7: TLabel;
    GroupBox3: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Button5: TButton;
    Button6: TButton;
    Label10: TLabel;
    Edit7: TEdit;
    Button7: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    UserCode: String;
  end;

var
  LogForm: TLogForm;

implementation

uses XedUser, Data, MenuExec;

{$R *.dfm}

procedure TLogForm.FormCreate(Sender: TObject);
begin
  Page1.Pages[0].TabVisible := False;
  Page1.Pages[1].TabVisible := False;
  Page1.Pages[2].TabVisible := False;
  Page1.ActivePageIndex := 0;
  DM.PassWord.Open;
//  Page1.ActivePageIndex := 2;
end;

procedure TLogForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  A00Form.Logined := Self.ModalResult = mrOK;
  DM.PassWord.Close;
end;

procedure TLogForm.Button3Click(Sender: TObject);
var
  FFind: Boolean;
begin
  FFind := DM.PassWord.Locate('���', Edit3.Text, []);
  if FFind then Begin
    ShowMessage('�������Ա����Ѿ�����');
    Exit;
  End else Begin
    if Edit4.Text <> Edit7.Text then Begin
      ShowMessage('����˶Դ�������������');
      Exit;
    End;
    if Length(Edit7.Text) < 6  then Begin
      ShowMessage('���볤����ҪΪ6-10�ַ�������������');
      Exit;
    End;
    DM.PassWord.Append;
    DM.PassWord['���'] := Edit3.Text;
    DM.PassWord['����'] := Edit4.Text;
    DM.PassWord.Post;
    ShowMessage('�µĲ���Ա�Ѿ�����');
  End;
end;

procedure TLogForm.Button1Click(Sender: TObject);
var
  FFind: Boolean;
begin
  if Edit1.Focused then begin
    Edit2.SetFocus;
    Exit;
  End;
  if DM.PassWord.RecordCount = 0 then Begin
    ModalResult := mrOK;
    Exit;
  End;
  UserCode := Edit1.Text;
  FFind := DM.PassWord.Locate('���', Edit1.Text, []);
  Systemor := False;
  if FFind then Begin
    if DM.PassWord['����'] = Edit2.Text then Begin
      if '*' = DM.PASSWORD.FieldByname('��ע').Value then Begin
        Systemor := True;
      End;
      ModalResult := mrOK;
    End Else Begin
      ShowMessage('�������');
      Exit;
    End;
  End;
end;

procedure TLogForm.Button7Click(Sender: TObject);
var
  FFind: Boolean;
begin
  FFind := DM.PassWord.Locate('���', Edit3.Text, []);
  if FFind then Begin
    if Edit4.Text <> Edit7.Text then Begin
      ShowMessage('����˶Դ�������������');
      Exit;
    End;
    if DM.PassWord['����'] <> Edit4.Text then Begin
      ShowMessage('ֻ��ɾ��֪������Ĳ���Ա');
      Exit;
    End;
    DM.PassWord.Delete;
    ShowMessage(Format('���Ϊ��"%s"�Ĳ���Ա�Ѿ�ɾ��', [Edit3.Text]));
  End else Begin
    ShowMessage('û���������Ա���');
  End;
end;

procedure TLogForm.Button5Click(Sender: TObject);
var
  FFind: Boolean;
begin
  if Edit5.Text <> Edit6.Text then Begin
    ShowMessage('����˶Դ�������������');
    Exit;
  End;
  if Length(Edit5.Text) < 6  then Begin
    ShowMessage('���볤����ҪΪ6-10�ַ�������������');
    Exit;
  End;
  FFind := DM.PassWord.Locate('���', UserCode, []);
  if FFind then Begin
    DM.PassWord.Edit;
    DM.PassWord['����'] := Edit6.Text;
    DM.PassWord.Post;
  End else Begin
    ShowMessage('�������Ա��Ų�����');
  End;
end;

procedure TLogForm.FormActivate(Sender: TObject);
begin
  Case Page1.ActivePageIndex of
    0: LogForm.Edit1.SetFocus;
    1: LogForm.Edit3.SetFocus;
    2: LogForm.Edit5.SetFocus;
  End;

end;

end.
