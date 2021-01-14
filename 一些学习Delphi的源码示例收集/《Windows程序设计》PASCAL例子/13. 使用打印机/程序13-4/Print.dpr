program  Print;

uses
  Windows, Messages, WinSpool;

procedure PageGDICalls(hdcPrn: HDC; cxPage, cyPage: Integer);
const
  szTextStr = 'Hello, Printer!';
begin
  Rectangle(hdcPrn, 0, 0, cxPage, cyPage);
  MoveToEx(hdcPrn, 0, 0, nil);
  LineTo(hdcPrn, cxPage, cyPage);
  MoveToEx(hdcPrn, cxPage, 0, nil);
  LineTo(hdcPrn, 0, cyPage);
  SaveDC(hdcPrn);
  SetMapMode(hdcPrn, MM_ISOTROPIC);
  SetWindowExtEx(hdcPrn, 1000, 1000, nil);
  SetViewportExtEx(hdcPrn, cxPage div 2, -cyPage div 2, nil);
  SetViewportOrgEx(hdcPrn, cxPage div 2,  cyPage div 2, nil);
  Ellipse(hdcPrn, -500, 500, 500, -500);
  SetTextAlign(hdcPrn, TA_BASELINE or TA_CENTER);
  TextOut(hdcPrn, 0, 0, szTextStr, lstrlen(szTextStr));
  RestoreDC(hdcPrn, -1);
end;

  // ����ص�����
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+}
  cxClient: Integer = 0;
  cyClient: Integer = 0;
{$J-}
var
  hWndDc: HDC;
  hMenu: DWORD;
  Ps: TPaintStruct;
begin
  Result := 0;
  case Msg of
    WM_CREATE:
      begin
        hMenu := GetSystemMenu(hWnd, FALSE);
        AppendMenu(hMenu, MF_SEPARATOR, 0, nil);
        AppendMenu(hMenu, 0, 1, '&Print');
      end;

    WM_SIZE:
      begin
        cxClient := LOWORD(lParam);
        cyClient := HIWORD(lParam);
      end;

    WM_SYSCOMMAND:
      begin
        if (wParam = 1) then
        begin
          if (not PrintMyPage(hWnd)) then
            MessageBox(hWnd, 'Could not print page!', szAppName, MB_OK or MB_ICONEXCLAMATION);
        end else
        begin
          Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
        end;
      end;

    WM_PAINT:
      begin
        hWndDc := BeginPaint(hWnd, Ps);
        PageGDICalls(hWndDc, cxClient, cyClient);
        EndPaint(hWnd, Ps);
      end;

    WM_DESTROY:
      PostQuitMessage(0);

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
  end;
end;

var
  hWnd: LongWord;   // ������
  Msg: TMsg;        // ��Ϣ�ṹ
  WndClass: TWndClass; // ��ṹ
begin
 // ע�ᴰ����
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
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(szAppName, nil,
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
