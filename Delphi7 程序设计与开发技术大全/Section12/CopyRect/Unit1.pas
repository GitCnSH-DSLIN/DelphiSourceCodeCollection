unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
const
  Step=200;
  X0=20;    //��߽�
  Y0=20;    //�ϱ߽�
var
  Bitmap:TBitmap;
  MidX:Integer;                                   //�м��������ǰ����������λͼ�Ŀ�
  RatioX:Real;                                    //ÿ��λͼ���������
  I:Integer;
  Rect1,Rect2:TRect;                              //Դ��Ŀ���������
begin
  Bitmap:=TBitmap.Create;
  Bitmap.LoadFromFile('a.bmp');                   //װ��λͼ�ļ�
  RatioX:=Bitmap.Width/Step;
  for I:=0 to Step do
  begin
    MidX:=Round(RatioX*I);
    with Rect1 do
    begin
      Left:=Bitmap.Width-MidX;
      Top:=0;
      Right:=Bitmap.Width;
      Bottom:=Bitmap.Height;
    end;
    with Rect2 do
    begin
      Left:=X0;
      Top:=Y0;
      Right:=X0+MidX;
      Bottom:=Y0+Bitmap.Height;
    end;
    Canvas.CopyRect(Rect2,Bitmap.Canvas,Rect1);  //����λͼ
  end;
  Bitmap.Free;                                   //�ͷ�λͼ��Դ
end;

end.
