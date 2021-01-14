unit EMF9;

interface

uses Windows;

const
  szClass = 'EMF9';
  szTitle = 'EMF9: Enhanced MetaFile Demo #9';

procedure CreateRoutine(hWnd: HWND); // ����emf
procedure PaintRoutine(hwnd: HWND; hdc: HDC; cxArea, cyArea: Integer); // ����emf

implementation

  // ����emf
procedure CreateRoutine(hWnd: HWND);
begin
  // �˴�ʹ����һ���е�emf8.emf
end;

  // ����emf
procedure PaintRoutine(hWnd: HWND; hdc: HDC; cxArea, cyArea: Integer);
var
  emh: TEnhMetaHeader;
  hemf: HENHMetaFile;
  cxMms, cyMms, cxPix, cyPix, cxImage, cyImage: Integer;
  Rect: TRect;
begin
  cxMms := GetDeviceCaps(hdc, HORZSIZE);
  cyMms := GetDeviceCaps(hdc, VERTSIZE);
  cxPix := GetDeviceCaps(hdc, HORZRES);
  cyPix := GetDeviceCaps(hdc, VERTRES);

  hemf := GetEnhMetaFile('..\����18-10\emf8.emf');
  GetEnhMetaFileHeader(hemf, SizeOf(emh), @emh);
  
  cxImage := emh.rclFrame.Right - emh.rclFrame.Left;
  cyImage := emh.rclFrame.Bottom - emh.rclFrame.Top;
  cxImage := cxImage * cxPix div cxMms div 100;
  cyImage := cyImage * cyPix div cyMms div 100;
  
  Rect.left := (cxArea - cxImage) div 2;
  Rect.right := (cxArea + cxImage) div 2;
  Rect.top := (cyArea - cyImage) div 2;
  Rect.bottom := (cyArea + cyImage) div 2;

  PlayEnhMetaFile(hdc, hemf, Rect);
  DeleteEnhMetaFile(hemf);
end;

end.
