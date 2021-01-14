program  IconDemo;

{$R IconDemo.res}

uses
  Windows, Messages;

const  
  IDI_ICON = 101;

   // ������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+}
  hIcon: HICON = 0;
  cxIcon: Integer = 0;
  cyIcon: Integer = 0;
  cxClient: Integer = 0;
  cyClient: Integer = 0;
{$J-}
var
  hWndDc: HDC;
  ps: PAINTSTRUCT;
  x, y: Integer;
begin
  Result := 0;
 // ���ֲ�ͬ����Ϣ
  case Msg of
    WM_CREATE:
      begin
        hIcon := LoadIcon(hInstance, MAKEINTRESOURCE(IDI_ICON));
        cxIcon := GetSystemMetrics(SM_CXICON);
        cyIcon := GetSystemMetrics(SM_CYICON);
      end;

    WM_SIZE:
      begin
        cxClient := LOWORD(lParam);
        cyClient := HIWORD(lParam);
      end;

    WM_PAINT:
      begin
        hWndDc := BeginPaint(hWnd, ps);

        y := 0;
        while (y < cyClient) do
        begin
          x := 0;
          while (x < cxClient) do
          begin
            DrawIcon(hWndDc, x, y, hIcon);
            Inc(x, cyIcon);
          end;
          Inc(y, cyIcon);
        end;

        EndPaint(hWnd, ps);
      end;


    WM_DESTROY:
      PostQuitMessage(0); // ��һ���˳���ϢWM_QUIT

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end; 

  
const
  szAppName = 'IconDemo';

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
  WndClass.hIcon := LoadIcon(hInstance, MAKEINTRESOURCE(IDI_ICON));
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
  hWnd := CreateWindow(szAppName, 'Icon Demo',
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
