unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ExtDlgs, Menus;

type
  TForm1 = class(TForm)
    Image1: TImage;
    SavePictureDialog1: TSavePictureDialog;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  BZ:Boolean;          //�趨һ����־,�ж�����Ƿ��ڰ���
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  //��ʼ������
  Image1.Canvas.Pen.Width:=10;
  Image1.Canvas.Pen.Color:=clRed;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  //����
  if BZ then
    Image1.Canvas.LineTo(X,Y);
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //�ƶ����ʵ���괦
  Image1.Canvas.MoveTo(X,Y);
  BZ:=True;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //���ñ�־,��ʾ���̧��
  BZ:=False;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  //��Image1����е����ݱ��浽�ļ�
  SavePictureDialog1.FileName:='';
  SavePictureDialog1.Filter:='λͼ(*.bmp)|*.bmp';
  SavePictureDialog1.DefaultExt:='*.bmp';
  SavePictureDialog1.Execute;
  if SavePictureDialog1.FileName <> '' then
    Image1.Picture.SaveToFile(SavePictureDialog1.FileName);
end;

end.
