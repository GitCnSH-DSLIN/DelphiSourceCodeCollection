unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TForm1 = class(TForm)
    procedure FormClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormClick(Sender: TObject);
var
  I:Integer;
begin
  Canvas.Pen.Width := 4;               //�����߿�Ϊ4�����ؿ�
  Canvas.Pen.Color := clRed;           //���ñʵ���ɫΪ��ɫ
  Canvas.Ellipse(25,20,200,70);        //��һ����Բ����ɫ���ߣ�
  for I := 0 to 15 do
  begin
    Canvas.Pen.Mode := TPenMode(i);     //���ñʵ�ģʽ
    Canvas.MoveTo(30 + I * 10,10);
    Canvas.LineTo(30 + I * 10,90);
  end;
end;
end.
