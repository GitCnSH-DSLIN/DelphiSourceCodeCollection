program RndRctMT;

uses
  Windows, Messages, Math;

var
  cxClient, cyClient: Integer;

  // �̻߳ص�����
function Thread(hWnd: HWND): DWORD; stdcall;
var
  hBrush: DWORD;
  hWndDc: HDC;
  xLeft, xRight, yTop, yBottom, iRed, iGreen, iBlue: Integer;
begin
  while TRUE do
  begin
    if (cxClient <> 0) or (cyClient <> 0) then
    begin
     // ��Χ
      xLeft := Random(cxClient);
      xRight := Random(cxClient);
      yTop := Random(cyClient);
      yBottom := Random(cyClient);

     // ��ɫ
      iRed := Random(255);
      iGreen := Random(255);
      iBlue := Random(255);

     // ����
      hWndDc := GetDC(hWnd);
      hBrush := CreateSolidBrush(RGB(iRed, iGreen, iBlue));
      SelectObject(hWndDc, hBrush);

      Rectangle(hWndDc, Min(xLeft, xRight),
        Min(yTop, yBottom), Max(xLeft, xRight), Max(yTop, yBottom));
        
      ReleaseDC(hWnd, hWndDc);
      DeleteObject(hBrush);
    end;
    Sleep(50);    
  end;
end;

   // ����ص�����
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  case Msg of
    WM_CREATE:
      begin                                      
        CreateThread(nil, 0, @Thread, Pointer(hWnd), 0, Msg);
      end;

    WM_SIZE:
      begin
        cxClient := LOWORD(lParam);
        cyClient := HIWORD(lParam);
      end;

    WM_DESTROY:
      begin
        PostQuitMessage(0); // ����ѭ��
      end;
  end;
end;

const
  szAppName = 'RndRctMT';
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

 // ע�ᴰ����
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������                      
  hWnd := CreateWindow(szAppName, 'Random Rectangles',
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
