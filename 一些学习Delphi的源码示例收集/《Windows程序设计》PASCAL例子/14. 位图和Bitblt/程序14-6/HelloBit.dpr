program  HelloBit;

{$R HelloBit.res}

uses
  Windows, Messages;

   // ������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  IDM_BIG   = 40001;
  IDM_SMALL = 40002;
  szText = ' Hello, world! ';
{$J+}
  hBitmap: DWORD = 0;
  hdcMem: HDC = 0;
  cxBitmap: Integer = 0;
  cyBitmap: Integer = 0;
  cxClient: Integer = 0;
  cyClient: Integer = 0;
  iSize: Integer = IDM_BIG; // ��ǰѡ��ߴ�
{$J-}
var
  hMenu: DWORD;
  hdcWnd: HDC;
  ps: TPaintStruct;
  Size: TSize;
  x, y: Integer;
begin
  Result := 0;
  case Msg of
    WM_CREATE:
      begin
        hdcWnd := GetDC(hWnd);
        hdcMem := CreateCompatibleDC(hdcWnd); // �������ݵ��ڴ��豸����
        GetTextExtentPoint32(hdcWnd, szText, lstrlen(szText), Size); // ȡ���ַ�����Χ
        cxBitmap := Size.cx;
        cyBitmap := Size.cy;
        hBitmap := CreateCompatibleBitmap(hdcWnd, cxBitmap, cyBitmap); // ����λͼ
        ReleaseDC(hWnd, hdcWnd);
        SelectObject(hdcMem, hBitmap); // ѡ��λͼ(������ʾƽ��)
        TextOut(hdcMem, 0, 0, szText, lstrlen(szText)); // ��������
      end;

    WM_SIZE:
      begin
        cxClient := LOWORD(lParam);
        cyClient := HIWORD(lParam);
      end;

    WM_COMMAND:
      begin  (* ���ڲ˵�������WM_COMMAND��Ϣ��HIWORD(wParam)Ϊ0,��������ֱ����wParam *)
        hMenu := GetMenu(hWnd);
        if (wParam = IDM_BIG) or (wParam = IDM_SMALL) then
        begin
          CheckMenuItem(hMenu, iSize, MF_UNCHECKED);
          iSize := wParam;
          CheckMenuItem(hMenu, iSize, MF_CHECKED);
          InvalidateRect(hWnd, nil, TRUE); // ˢ��(��ʹ�ػ�)
        end;
      end;

    WM_PAINT:
      begin
        hdcWnd := BeginPaint(hWnd, ps);
        case iSize of
          IDM_BIG:
            begin
              StretchBlt(hdcWnd, 0, 0, cxClient, cyClient, hdcMem, 0, 0, cxBitmap, cyBitmap, SRCCOPY);
            end;

          IDM_SMALL:
            begin
              y := 0;
              while (y < cyClient) do
              begin
                x := 0;
                while (x < cxClient) do
                begin
                  BitBlt(hdcWnd, x, y, cxBitmap, cyBitmap, hdcMem, 0, 0, SRCCOPY);
                  Inc(x, cxBitmap);
                end;
                Inc(y, cyBitmap);
              end;
            end;
        end;
        EndPaint(hWnd, ps);
      end;

    WM_DESTROY:
      begin
        DeleteDC(hdcMem);
        DeleteObject(hBitmap);
        PostQuitMessage(0);
      end;

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam);
  end;
end;
  
const
  szAppName = 'HelloBit';
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
  WndClass.hbrBackground := GetStockObject(WHITE_BRUSH); // ������ˢ
  WndClass.lpszMenuName := szAppName;
  WndClass.lpszClassName := szAppName;
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(szAppName, 'HelloBit',
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
