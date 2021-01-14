unit Bounce;

interface

uses
  Windows, Math;
  
const
  szAppName = 'Bounce';
  szTitle = 'Bounce: Palette Animation Demo';
  ID_TIMER = 1;
  
var
  plp: PLogPalette;

function CreateRoutine(hWnd: HWND): HPALETTE; // ��ʼ��
procedure PaintRoutine(hdc: HDC; cxClient, cyClient: Integer); // ����ͼ��
procedure TimerRoutine(hdc: HDC; hPalette: HPALETTE); // �ƶ�ͼ��
procedure DestroyRoutine(hWnd: HWND; hPalette: HPALETTE); // ����ʼ��

implementation

  // ��ʼ��(�����ڴ�,������ɫ��,��װ��ʱ��)
function CreateRoutine(hWnd: HWND): HPALETTE;
var
  J: Integer;
begin
  GetMem(plp, SizeOf(TLogPalette) + 33 * SizeOf(TPaletteEntry));
  plp.palVersion := $0300;
  plp.palNumEntries := 34;
  for J := 0 to 33 do
  begin
    plp.palPalEntry[J].peRed := 255;
    plp.palPalEntry[J].peGreen := IfThen(J = 0, 0 ,255); // ��һ����ɫ����Ŀ��ɫ,������ɫ
    plp.palPalEntry[J].peBlue := IfThen(J = 0, 0, 255);
    plp.palPalEntry[J].peFlags := IfThen(J = 33, 0, PC_RESERVED); // ����������һ����ɫ����Ŀ
  end;
  Result := CreatePalette(plp^);
  SetTimer(hWnd, ID_TIMER, 50, nil);
end;

  // ����ͼ��(��Բ)
procedure PaintRoutine(hdc: HDC; cxClient, cyClient: Integer);
var
  hBrush: LongWord;
  J, x1, x2, y1, y2: Integer;
  Rect: TRect;
begin
 // �����һ����ɫ����Ŀ���Ʊ���
  SetRect(Rect, 0, 0, cxClient, cyClient);
  hBrush := CreateSolidBrush(PaletteIndex(33));
  FillRect(hdc, Rect, hBrush);
  DeleteObject(hBrush);
  
 // ѡ��ջ���(�ޱ߿�)
  SelectObject(hdc, GetStockObject(NULL_PEN));
 // ��33����Բ(��W״)
  for J := 0 to 32 do
  begin
    x1 := J * cxClient div 33;
    x2 := (J + 1)* cxClient div 33;

    if (J < 9) then // ���ϵ���
    begin
      y1 := J * cyClient div 9;
      y2 := (J + 1) * cyClient div 9;
    end else
      if (J < 17) then // ���µ���
      begin
        y1 := (16 - J) * cyClient div 9;
        y2 := (17 - J) * cyClient div 9;
      end else
        if (J < 25) then // ���ϵ���
        begin
          y1 := (J - 16) * cyClient div 9;
          y2 := (J - 15) * cyClient div 9;
        end else
        begin // ���µ���
          y1 := (32 - J) * cyClient div 9;
          y2 := (33 - J) * cyClient div 9;
        end;

    hBrush := CreateSolidBrush(PaletteIndex(J));
    SelectObject(hdc, hBrush);
    Ellipse(hdc, x1, y1, x2, y2);
    DeleteObject(SelectObject(hdc, GetStockObject(WHITE_BRUSH)));
  end;
end;

  // �ƶ�ͼ��(ʵ�����Ǹı��ɫ����Ŀ)
procedure TimerRoutine(hdc: HDC; hPalette: HPALETTE);
const
{$J+}
  bLeftToRight: Boolean = TRUE; // ����
  iBall: Integer = 0;
{$J-}
begin
 // ��ɫ
  plp.palPalEntry[iBall].peGreen := 255;
  plp.palPalEntry[iBall].peBlue := 255;
 // �ƶ�
  Inc(iBall, IfThen(bLeftToRight, 1, -1));
 // �߽�
  if (iBall = IfThen(bLeftToRight, 33, -1)) then
  begin
    iBall := IfThen(bLeftToRight, 31, 1);
    bLeftToRight := not bLeftToRight;
  end;
 // ��ɫ
  plp.palPalEntry[iBall].peGreen := 0;
  plp.palPalEntry[iBall].peBlue  := 0;
 // �޸�
  AnimatePalette(hPalette, 0, 33, @plp.palPalEntry[0]);
end;

  // ����ʼ��(ɾ����ʱ��,ɾ����ɫ��,�ͷ��ڴ�)
procedure DestroyRoutine(hWnd: HWND; hPalette: HPALETTE);
begin
  KillTimer(hWnd, ID_TIMER);
  DeleteObject(hPalette);
  FreeMem(plp);
end;

end.
