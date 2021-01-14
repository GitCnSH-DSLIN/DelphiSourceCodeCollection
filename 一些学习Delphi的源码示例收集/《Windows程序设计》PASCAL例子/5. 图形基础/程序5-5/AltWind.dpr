program  AltWind;

uses
  Windows, Messages;

  // ������Ϣ����ص�����
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+}
  cxClient: Integer = 0; // ������
  cyClient: Integer = 0; // ����߶�
{$J-}  
  FigurePoints: array[0..9] of TPoint = (
                 (X: 10; Y: 70), (X: 50; Y: 70),
                 (X: 50; Y: 10), (X: 90; Y: 10),
                 (X: 90; Y: 50), (X: 30; Y: 50),
                 (X: 30; Y: 90), (X: 70; Y: 90),
                 (X: 70; Y: 30), (X: 10; Y: 30)
                                         );
var
  hWndDc: HDC;
  PS: TPaintStruct;
  Points: array[0..9] of TPoint;
  J: Integer;  
begin
  Result := 0;
  case Msg of
    WM_SIZE     :  begin
                     cxClient := LOWORD(lParam);
                     cyClient := HIWORD(lParam);
                   end;

    WM_PAINT    :  begin
                     hWndDc := BeginPaint(hWnd, PS);
                     
                    // ѡ���ɫ��ˢ
                     SelectObject(hWndDc, GetStockObject(GRAY_BRUSH));
                    // �ʵ�����ͼ��
                     for J := 0 to 9 do
                     begin
                       Points[J].X := cxClient * FigurePoints[J].X div 200;
                       Points[J].Y := cyClient * FigurePoints[J].Y div 100;
                     end;
                    // ��ALTERNATE��ʽ��
                     SetPolyFillMode(hWndDc, ALTERNATE);
                     Polygon(hWndDc, Points, 10);
                    // ͼ����������
                     for J := 0 to 9 do
                       Points[J].X := Points[J].X + cxClient div 2;
                    // ��WINDING��ʽ��
                     SetPolyFillMode(hWndDc, WINDING);
                     Polygon(hWndDc, Points, 10);      

                     EndPaint(hWnd, PS);
                   end;

    WM_DESTROY  :  PostQuitMessage(0); // ����ǰ�߳���Ϣ���з�WM_QUIT
    
    else Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
  end;
end;


const  
  AppName = 'AltWind';

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
    MessageBox(0, 'Program requires Windows NT!', AppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(AppName, 'Alternate and Winding Fill Modes',
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
