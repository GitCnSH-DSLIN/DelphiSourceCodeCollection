unit PopFont;

interface

  // ��ʼ��
procedure PopFontInitialize(hWndEdit: LongWord);
  // ����ʼ��
procedure PopFontDeinitialize();
  // ����ѡ��Ի���
function PopFontChooseFont(hWnd: LongWord): Boolean;
  // ��������
procedure PopFontSetFont(hWndEdit: LongWord);

implementation

uses
  Windows, CommDlg, Messages;

var
  logfont: TLogFont;
  hFont: LongWord;

  // ��ʼ��
procedure PopFontInitialize(hWndEdit: LongWord);
begin
  GetObject(GetStockObject(SYSTEM_FONT), SizeOf(TLogFont), Pointer(@logfont));
  hFont := CreateFontIndirect(logfont);
  SendMessage(hWndEdit, WM_SETFONT, hFont, 0);
end;

  // ����ʼ��
procedure PopFontDeinitialize();
begin
  DeleteObject(hFont);
end;

  // ����ѡ��Ի���
function PopFontChooseFont(hWnd: LongWord): Boolean;
const
{$J+}
  cf: TChooseFont =
   ( lStructSize: SizeOf(TChooseFont);
     hwndOwner: 0;
     hDC: 0;
     lpLogFont: @logfont;
     iPointSize: 0;
     Flags: CF_INITTOLOGFONTSTRUCT or CF_SCREENFONTS or CF_EFFECTS;
     rgbColors: 0;
     lCustData: 0;
     lpfnHook: nil;
     lpTemplateName: nil;
     hInstance: 0;
     lpszStyle: nil;
     nFontType: 0;
     nSizeMin: 0;
     nSizeMax: 0  );
{$J-}
begin
  cf.hwndOwner := hWnd;
  Result := ChooseFont(cf);
end;

  // ��������
procedure PopFontSetFont(hWndEdit: LongWord);
var
  hFontNew: LongWord;
  Rect: TRect;
begin
  hFontNew := CreateFontIndirect(logfont);
  SendMessage(hWndEdit, WM_SETFONT, hFontNew, 0);
  DeleteObject(hFont);
  hFont := hFontNew;
  GetClientRect(hWndEdit, Rect);
  InvalidateRect(hWndEdit, @Rect, TRUE);
end;

end.
