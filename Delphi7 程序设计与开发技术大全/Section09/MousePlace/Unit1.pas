unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
rtButton2: TRect;
begin
// ��ȡB u t t o n 2���������
rtButton2 := Button2.BoundsRect;
// ������ת��Ϊ��Ļ����
MapWindowPoints(handle, 0, rtButton2, 2);
// ������ƶ��ķ�Χ������B u t t o n 2�����
ClipCursor( @rtButton2 ) ;
end ;
procedure TForm1.Button2Click(Sender: TObject);
begin
// ȡ������ƶ���Χ������
        ClipCursor( 0 );
end;

end.
