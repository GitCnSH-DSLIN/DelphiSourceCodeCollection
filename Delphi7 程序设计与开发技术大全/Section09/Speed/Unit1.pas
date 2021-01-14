unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  OSpeed: Word; // �����˸��ԭʼ�ٶ�
  CSpeed: Word; // �����˸�ĵ�ǰ�ٶ�
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
// ��ȡ�����˸��ԭʼ�ٶ�
  OSpeed:=GetCaretBlinkTime;
  Edit1.Text:=IntToStr(OSpeed);
  CSpeed:=OSpeed;

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
//�ָ������˸��ԭʼ�ٶ�
SetCaretBlinkTime(OSpeed);

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
//�ӿ�����˸���ٶ�
  CSpeed:=CSpeed div 2;
  SetCaretBlinkTime(CSpeed);
  Edit1.Text:=IntToStr(CSpeed);
  Edit1.SetFocus;
end;


procedure TForm1.Button2Click(Sender: TObject);
begin
//���������˸���ٶ�
  CSpeed:=CSpeed*2;
  SetCaretBlinkTime(CSpeed);
  Edit1.Text:=IntToStr(CSpeed);
  Edit1.SetFocus;
end;


procedure TForm1.Button3Click(Sender: TObject);
begin
//�ָ������˸��ԭʼ�ٶ�
  SetCaretBlinkTime(OSpeed);
  Edit1.Text:=IntToStr(OSpeed);
  CSpeed:=OSpeed;
  Edit1.SetFocus;
end;


end.
 