unit Unit2;

interface

uses
  Classes,Graphics;

type
  TSquareThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure Paint;        //�ڴ����л�������
  Public
    X1,Y,X2,Step:Integer;  //�����ε��¡���λ�úͱ仯�Ĳ���
    EColor:TColor;         //�����ε���ɫ
    Constructor Create(Col:TColor;XPos,YPos:Integer);     //���캯��

end;

implementation

Uses Unit1;

Procedure TSquareThread.Paint;
Begin
  //ʹ�ô������ɫ���ϵط���һ��������
  Form1.Canvas.Pen.Color:=Form1.Color;
  Form1.Canvas.Brush.Color:=Form1.Color;
  Form1.Canvas.Rectangle(X1-10,Y-10,X1+10,Y+10);
  //ʹ�ô������ɫ���ϵط���һ��������
  Form1.Canvas.Pen.Color:=EColor;
  Form1.Canvas.Brush.Color:=EColor;
  Form1.Canvas.Rectangle(X2-10, Y-10, X2+10, Y+10);
End;

Constructor TSquareThread.Create (Col: TColor; XPos, YPos: Integer);
Begin
  EColor:=Col;      //��ɫ
  X2:=XPos;         //X����
  X1:=X2;
  Y:=YPos;          //Y����
  Inherited Create (True);
End;

procedure TSquareThread.Execute;
begin
  Step:=1;          //����
  Repeat
  X1:=X2;
  X2:=X2+Step;      //�ı�X����λ��
  if X2<160 then
  Step:=1           //�������
  Else if X2>(Form1.ClientWidth-15) then
    Step:=-1;       //�����ұ�
  Synchronize(Paint);
  Until Terminated;
end;

end.
 