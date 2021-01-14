unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TForm1 = class(TForm)
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    Bz:Boolean;     //����һ������־�����ܵ�ȫ�ֲ����ͱ���
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then              //���������������
  begin
    Bz:=True;                        //����־��������ΪTrue�����ɻ�״̬
    Form1.Canvas.MoveTo(X,Y);        //�������ƶ�����갴�������λ��
  end;
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft then             //�����������̧��
    Bz:=False;                      //����־��������ΪFalse�������ɻ�״̬
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Bz:=False;                        //��ʼ����־����Ϊ���ɻ�״̬
  Form1.Canvas.Pen.Color:=clRed;    //���û�����ɫΪ��ɫ
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Bz then                         //�����־����ΪTrue�����ɻ�״̬����
  begin
    Form1.Canvas.LineTo(X,Y);        //�ӻ���λ�û��ߵ���굱ǰλ��
    Form1.Canvas.MoveTo(X,Y);        //���û���λ��
  end;
end;

end.
