unit Unit1;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Grids;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    DrawGrid1: TDrawGrid;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
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

procedure TForm1.FormCreate(Sender: TObject);
var
  I, J: Integer;
begin
  //�趨�����������ʹ�����ϵͳ�������Ŀ
  StringGrid1.ColCount := Screen.Fonts.Count + 1;
  StringGrid1.ColWidths [0] := 50;

  for I := 1 to Screen.Fonts.Count do
  begin
    // �趨��һ��Ϊ���������
    StringGrid1.Cells [I, 0] := Screen.Fonts.Strings [I-1];
    //������Ҫ���������
    StringGrid1.Canvas.Font.Name := StringGrid1.Cells [I, 0];
    StringGrid1.Canvas.Font.Size := 32;
    StringGrid1.ColWidths [I] :=
      StringGrid1.Canvas.TextWidth ('AaBbYyZz');
  end;

  // �趨����
  StringGrid1.RowCount := 26;
  for I := 1 to 25 do
  begin
    //�ڵ�һ��д�����ڵ�����
    StringGrid1.Cells [0, I] := IntToStr (I+7);
    // �趨�߶�
    StringGrid1.RowHeights [I] := 15 + I*2;
    // ���������Ĭ�ϵ�����
    for J := 1 to StringGrid1.ColCount do
      StringGrid1.Cells [J, I] := 'AaBbYyZz'
  end;
  StringGrid1.RowHeights [0] := 25;
end;

procedure TForm1.StringGrid1DrawCell (Sender: TObject;
  Col, Row: Integer; Rect: TRect; State: TGridDrawState);
const
  colors: array[0..4] of TColor = ( //���������Grid������һ��
    clRed,
    clBlue,
    clYellow,
    clBlack,
    clGray);
begin
  with StringGrid1.Canvas do
  begin
    FillRect(Rect);
    Font.Color := colors[Row mod 5]; //�޸ı�����ɫ
    TextOut(Rect.left,Rect.top,Stringgrid1.cells[col,row]);
  end;

  //ѡ������
  if (Col = 0) or (Row = 0) then
    StringGrid1.Canvas.Font.Name := 'Arial'
  else
    StringGrid1.Canvas.Font.Name := StringGrid1.Cells [Col, 0];

  // �趨����Ĵ�С
  if Row = 0 then
    StringGrid1.Canvas.Font.Size := 14
  else
    StringGrid1.Canvas.Font.Size := Row + 7;

  // �趨������ɫ
  if gdSelected in State then
    StringGrid1.Canvas.Brush.Color := clHighlight
  else if gdFixed in State then
    StringGrid1.Canvas.Brush.Color := clBtnFace
  else
    StringGrid1.Canvas.Brush.Color := clWindow;

  // ����ı�
  StringGrid1.Canvas.TextRect (Rect, Rect.Left, Rect.Top,
    StringGrid1.Cells [Col, Row]);

  // �趨����
  if gdFocused in State then
    StringGrid1.Canvas.DrawFocusRect (Rect);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  I,J:Integer;
  Rect:TRect;
begin
  DrawGrid1.Refresh;
  for I:=1 to DrawGrid1.RowCount -1 do
    for J:=1 to DrawGrid1.ColCount -1 do
    begin
      Rect:=DrawGrid1.CellRect(J,I);//����ÿһ����Ԫ��
      DrawGrid1.Canvas.TextOut(Rect.Left,Rect.Top,'�ı�');//����ı�
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Bmp:TBitMap;
  Rect:TRect;
  I,J:Integer;
begin
  DrawGrid1.Refresh;
  Bmp:=TBitMap.Create;
  Bmp.LoadFromFile('1.bmp');//װ��ͼ��
  for I:=1 to DrawGrid1.RowCount -1 do
    for J:=1 to DrawGrid1.ColCount -1 do
    begin
      Rect:=DrawGrid1.CellRect(J,I);//����ÿһ����Ԫ��
      DrawGrid1.Canvas.Draw(Rect.Left,Rect.Top,Bmp);//��ͼ
    end;
end;

end.
