program  SineWave;

uses
  Windows, Messages;

 // ������Ϣ����ص�����
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  NUM = 1000;
  TWOPI = (2 * 3.1415926);
 {$J+}
  cxClient: Integer = 0;  // ������
  cyClient: Integer = 0;  // ����߶�
 {$J-}
var
  hWndDc: HDC;
  PS: TPaintStruct;
  PTs: array [0..NUM-1] of TPoint; // �����
  J: Integer;  
begin
  Result := 0;
  case Msg of
    WM_SIZE     :  begin // �����³ߴ�
                     cxClient := LOWORD(lParam);
                     cyClient := HIWORD(lParam);
                   end;
                   
    WM_PAINT    :  begin
                    // ��ʼ����
                     hWndDc := BeginPaint(hWnd, PS);
                    // ��������
                     MoveToEx(hWndDc, 0, cyClient div 2, nil);
                     LineTo(hWndDc, cxClient, cyClient div 2);
                    // �������
                     for J := 0 to NUM-1 do
                     begin
                       PTs[J].X := J * cxClient div NUM ;
                       PTs[J].Y := Trunc(cyClient / 2 * (1 - Sin(TWOPI * J / NUM)));
                     end;
                    // ���Ӹ���(�õ����Ҳ�)
                     Polyline(hWndDc, PTs, NUM);
                    // ��������
                     EndPaint(hWndDc, PS);
                   end;
                   
    WM_DESTROY  :  PostQuitMessage(0); // �����˳���Ϣ

    else Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���  
  end;
end;

const  
  AppName = 'SineWave';

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
  WndClass.lpszClassName := AppName;
  
 // ע�ᴰ����
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', AppName, MB_ICONERROR);
    Exit;
  end;
  
 // ��������
  hWnd := CreateWindow(AppName, 'Sine Wave Using Polyline',
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
