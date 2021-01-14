unit Unit1;

interface

uses
  SysUtils, Windows, Classes, Graphics, Forms, Controls,
  StdCtrls, Menus, Dialogs, ExtCtrls;
       
type
  TForm1 = class(TForm)
    Label1: TLabel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N7: TMenuItem;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    procedure Exit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
  public
    procedure SizeItemClick(Sender: TObject);
    procedure SizeClick(Sender: TObject);
  end;
const
  idSysAbout = 100;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  PullDown, Item: TMenuItem;
  Position, I: Integer;
begin
  // ���������˵�
  PullDown := TMenuItem.Create (self);
  PullDown.Caption := '���ִ�С';
  PullDown.OnClick := SizeClick;
  // ���ò˵���λ��
  Position := MainMenu1.Items.IndexOf (file1);
  MainMenu1.Items.Insert (Position + 1, PullDown);
  I := 8;
  while I <= 48 do
  begin
    // �����Ӳ˵�
    Item := TMenuItem.Create (self);
    Item.Caption := IntToStr (I);
    Item.GroupIndex := 1;
    Item.RadioItem := True;
    // �趨��Ӧ�¼�
    Item.OnClick := SizeItemClick;
    PullDown.Insert (PullDown.Count, Item);
    I := I + 4;
  end;
end;

procedure TForm1.SizeItemClick(Sender: TObject);
begin
  with Sender as TMenuItem do
    Label1.Font.Size := StrToInt (Caption);
end;

procedure TForm1.SizeClick (Sender: TObject);
var//�޸����ִ�С
  I: Integer;
  Found: Boolean;
begin
  Found := False;
  with Sender as TMenuItem do
  begin
    for I := 0 to Count - 2 do
      if StrToInt (Items [I].Caption) =
        Label1.Font.Size then
      begin
        Items [I].Checked := True;
        Found := True;
        System.Break; // skip the rest of the loop
      end;
    if not Found then
      Items [Count - 1].Checked := True;
  end;
end;

procedure TForm1.N2Click(Sender: TObject);
var
  I: Integer;
begin
  // ��ӷָ���
  AppendMenu (GetSystemMenu (Handle, FALSE), MF_SEPARATOR, 0, '');
  // ��MainMenu�ؼ��еĲ˵���ӵ�ϵͳ�˵���
  with MainMenu1 do
    for I := 0 to Items.Count - 1 do
      AppendMenu (GetSystemMenu (self.Handle, FALSE),
        mf_Popup, Items[I].Handle, PChar (Items[I].Caption));
  // ʹ��ť��Ϊ������״̬
  N2.Enabled := False;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
//����
if N4.Checked then
  Label1.Font.Style:=Label1.Font.Style -[fsBold]
else
  Label1.Font.Style:=Label1.Font.Style +[fsBold];
//��ѡ��־
N4.Checked:=not N4.Checked ;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
//б��
if N5.Checked then
  Label1.Font.Style:=Label1.Font.Style -[fsItalic]
else
  Label1.Font.Style:=Label1.Font.Style +[fsItalic];
//��ѡ��־
N5.Checked:=not N5.Checked ;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
//�»���
if N6.Checked then
  Label1.Font.Style:=Label1.Font.Style -[fsUnderline]
else
  Label1.Font.Style:=Label1.Font.Style +[fsUnderline];
//��ѡ��־
N6.Checked:=not N6.Checked ;
end;

procedure TForm1.N8Click(Sender: TObject);
begin
//��ɫ
Label1.Font.Color:=clRed;
//��ѡ��־
N8.Checked:=True;
end;

procedure TForm1.N9Click(Sender: TObject);
begin
//��ɫ
Label1.Font.Color:=clGreen;
//��ѡ��־
N9.Checked:=True;
end;

procedure TForm1.N10Click(Sender: TObject);
begin
//��ɫ
Label1.Font.Color:=clBlue;
//��ѡ��־
N10.Checked:=True;
end;

procedure TForm1.N15Click(Sender: TObject);
begin
//����Ϊ��@��Բ��
Label1.Font.Name:=N15.Caption;
//��ѡ��־
N15.Checked :=True;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
//����Ϊ�����塱
Label1.Font.Name:=N1.Caption;
//��ѡ��־
N1.Checked :=True;
end;

procedure TForm1.N14Click(Sender: TObject);
begin
Close;
end;

end.

