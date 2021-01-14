program  ShowBit;

uses
  Windows, Messages;

const
  szAppName = 'ShowBit';  

  // ����λͼ
procedure DrawBitmap(hWndDc, xStart, yStart, hBitmap: Integer);
var
  bm: TBitmap;
  hMemDC: HDC;
  pt: TPoint;
begin
  hMemDC := CreateCompatibleDC(hWndDc);
  SelectObject(hMemDC, hBitmap);
  GetObject(hBitmap, SizeOf(TBitmap), @bm);
  pt.x := bm.bmWidth;
  pt.y := bm.bmHeight;
  BitBlt(hWndDc, xStart, yStart, pt.x, pt.y, hMemDC, 0, 0, SRCCOPY);
  DeleteDC(hMemDC);
end;

   // �������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+}
  hLibrary: Integer = 0;
  iCurrent: Integer = 1;
{$J-}
var
  hBitmap: LongWord; // HBITMAP
  hWndDc: HDC;
  ps: TPaintStruct;
begin
  Result := 0;
  case (Msg) of
    WM_CREATE:
      begin
        hLibrary := LoadLibrary('..\����21-5\BITLIB.DLL'); // ��ԴDLL
        if (hLibrary = 0) then
        begin
          MessageBox(hWnd, 'Can'#$27't load BITLIB.DLL.', szAppName, 0);
          Result:= -1; // ��ֹ��������
        end;
      end;

    WM_CHAR:
      begin
        if (hLibrary <> 0) then
        begin
          Inc(iCurrent); // ��һ��
          InvalidateRect(hWnd, nil, TRUE);
        end;
      end;

    WM_PAINT:
      begin
        hWndDc := BeginPaint(hWnd, ps);

        if (hLibrary <> 0) then
        begin
          hBitmap := LoadBitmap(hLibrary, MakeIntResource(iCurrent));
          if (hBitmap = 0) then
          begin
            iCurrent := 1;
            hBitmap := LoadBitmap(hLibrary, MakeIntResource(iCurrent));
          end;
          if (hBitmap <> 0) then
          begin
            DrawBitmap(hWndDc, 0, 0, hBitmap);
            DeleteObject(hBitmap);
          end;
        end;

        EndPaint(hWnd, ps);
      end;

    WM_DESTROY:
      begin
        if (hLibrary <> 0) then FreeLibrary(hLibrary);
        PostQuitMessage(0); // ��һ���˳���ϢWM_QUIT
      end;
      
    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;   

var
  hWnd: LongWord;
  Msg: TMsg;
  WndClass: TWndClass;
begin
 // ���ṹ��
  WndClass.style := CS_HREDRAW or CS_VREDRAW;
  WndClass.lpfnWndProc := @WndProc;
  WndClass.cbClsExtra := 0;
  WndClass.cbWndExtra := 0;
  WndClass.hInstance := hInstance;
  WndClass.hIcon := LoadIcon(0, IDI_APPLICATION);
  WndClass.hCursor := LoadCursor(0, IDC_ARROW);
  WndClass.hbrBackground := GetStockObject(WHITE_BRUSH);
  WndClass.lpszMenuName := nil;
  WndClass.lpszClassName := szAppName;

 // ע�����
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(szAppName,
                       'Show Bitmaps from BITLIB (Press Key)',
                       WS_OVERLAPPEDWINDOW,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       0, 0, hInstance, nil);
  if (hWnd = 0) then Exit;

 // ��ʾ����
  ShowWindow(hWnd, CmdShow);
  UpdateWindow(hWnd);
    
 // ��Ϣѭ��
  while GetMessage(Msg, 0, 0, 0) do
  begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;
end.
