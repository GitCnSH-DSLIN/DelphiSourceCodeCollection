program  Stretch;

uses
  Windows, Messages;

   // ������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+}
  cxClient: Integer = 0;
  cyClient: Integer = 0;
  cxSource: Integer = 0;
  cySource: Integer = 0;
{$J-}  
var
  hdcClient, hdcWindow: HDC;
  ps: TPaintStruct;
begin
  Result := 0;
  case Msg of
    WM_CREATE:
      begin 
        cxSource := GetSystemMetrics(SM_CXSIZEFRAME) + GetSystemMetrics(SM_CXSIZE);
        cySource := GetSystemMetrics(SM_CYSIZEFRAME) + GetSystemMetrics(SM_CYCAPTION);
      end;

    WM_SIZE:
      begin
        cxClient := LOWORD(lParam);
        cyClient := HIWORD(lParam);
      end;

    WM_PAINT:
      begin
        hdcClient := BeginPaint(hWnd, ps);
        hdcWindow := GetWindowDC(hWnd);
        StretchBlt(hdcClient, 0, 0, cxClient, cyClient, hdcWindow, 0, 0, cxSource, cySource, MERGECOPY);
        ReleaseDC(hWnd, hdcWindow);
        EndPaint(hWnd, ps);
      end;

    WM_DESTROY:
      begin
        PostQuitMessage(0); // ��һ���˳���ϢWM_QUIT
      end;

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;    
  
const
  szAppName = 'Stretch';
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
  WndClass.hIcon := LoadIcon(0, IDI_INFORMATION);
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
  hWnd := CreateWindow(szAppName, 'StretchBlt Demo',
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
