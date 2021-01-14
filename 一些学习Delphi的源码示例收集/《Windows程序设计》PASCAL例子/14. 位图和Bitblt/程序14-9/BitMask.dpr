program  BitMask;

{$R BitMask.res}

uses
  Windows, Messages;

   // ������Ϣ������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+}
  hBitmapImag: HBITMAP = 0;
  hBitmapMask: HBITMAP = 0;
  cxClient: Integer = 0;
  cyClient: Integer = 0;
  cxBitmap: Integer = 0;
  cyBitmap: Integer = 0;
{$J+}
var
  Bitmap: TBitmap;
  hdcWnd, hdcMemImag, hdcMemMask: HDC;
  x, y: Integer;
  ps: TPaintStruct;
begin
  Result := 0;
  case Msg of
    WM_CREATE:
      begin
       // װ��λͼ��ȡ��ߴ�
        hBitmapImag := LoadBitmap(hInstance, 'BitMask');
        GetObject(hBitmapImag, SizeOf(TBitmap), @Bitmap);
        cxBitmap := Bitmap.bmWidth;
        cyBitmap := Bitmap.bmHeight;

       // ���� ��Դλͼ �ڴ��豸����
        hdcMemImag := CreateCompatibleDC(0); // ����ʾ������
        SelectObject(hdcMemImag, hBitmapImag);

       // ���� ����λͼ �ڴ��豸����
        hBitmapMask := CreateBitmap(cxBitmap, cyBitmap, 1, 1, nil);
        hdcMemMask := CreateCompatibleDC(0); // ����ʾ������
        SelectObject(hdcMemMask, hBitmapMask);

       // һ����ɫ��Χ����Բ
        SelectObject(hdcMemMask, GetStockObject(BLACK_BRUSH)); // ��ɫ(0)������ʾ����
        Rectangle(hdcMemMask, 0, 0, cxBitmap, cyBitmap);
        SelectObject(hdcMemMask, GetStockObject(WHITE_BRUSH)); // ��ɫ(1)������ʾλͼ
        Ellipse(hdcMemMask, 0, 0, cxBitmap, cyBitmap);
        
       // ʹ(��Դ)λͼ���ܱ��                                            
        BitBlt(hdcMemImag, 0, 0, cxBitmap, cyBitmap, hdcMemMask, 0, 0, SRCAND); // AND
        
        DeleteDC(hdcMemImag);
        DeleteDC(hdcMemMask);
      end;

    WM_SIZE:
      begin
        cxClient := LOWORD(lParam);
        cyClient := HIWORD(lParam);
      end;

    WM_PAINT:
      begin
        hdcWnd := BeginPaint(hWnd, ps);

       // ѡ��λͼ���ڴ��豸
        hdcMemImag := CreateCompatibleDC(hdcWnd);
        SelectObject(hdcMemImag, hBitmapImag);
        hdcMemMask :=CreateCompatibleDC(hdcWnd);
        SelectObject(hdcMemMask, hBitmapMask);

       // ͼ��λ�þ���
        x := (cxClient - cxBitmap) div 2 ;
        y := (cyClient - cyBitmap) div 2 ;

       // �Ȼ�һ����ɫ����Բ
        BitBlt(hdcWnd, x, y, cxBitmap, cyBitmap, hdcMemMask, 0, 0, $0220326); // (D and (not S))
       // ����Բ������ʾλͼ
        BitBlt(hdcWnd, x, y, cxBitmap, cyBitmap, hdcMemImag, 0, 0, SRCPAINT); // or

        DeleteDC(hdcMemImag);
        DeleteDC(hdcMemMask);
        EndPaint(hwnd, ps);
      end;

    WM_DESTROY:
      begin
        DeleteObject(hBitmapImag);
        DeleteObject(hBitmapMask);
        PostQuitMessage(0); // �˳�
      end;

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;

const
  szAppName = 'BitMask';
var
  hWnd: LongWord;
  Msg: TMsg;
  WndClass: TWndClass;
begin
 // ע�ᴰ����
  WndClass.style := CS_HREDRAW or CS_VREDRAW;
  WndClass.lpfnWndProc := @WndProc;
  WndClass.cbClsExtra := 0;
  WndClass.cbWndExtra := 0;
  WndClass.hInstance := hInstance;
  WndClass.hIcon := LoadIcon(0, IDI_APPLICATION);
  WndClass.hCursor := LoadCursor(0, IDC_ARROW);
  WndClass.hbrBackground := GetStockObject(LTGRAY_BRUSH);
  WndClass.lpszMenuName := nil;
  WndClass.lpszClassName := szAppName;
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(szAppName, 'Bitmap Masking Demo',
                       WS_OVERLAPPEDWINDOW,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       0, 0, hInstance, nil);

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
