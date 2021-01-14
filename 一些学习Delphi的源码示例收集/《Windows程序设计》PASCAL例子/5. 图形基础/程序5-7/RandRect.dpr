program  RandRect;

uses
  Windows, Messages;

var
  cxClient, cyClient: Integer; // ���嵱ǰ�ߴ�

  // ������Ϣ����ص�����
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  Result := 0;
  case Msg of
    WM_SIZE     :  begin
                     cxClient := LOWORD(lParam);
                     cyClient := HIWORD(lParam);
                   end;

    WM_DESTROY  :  PostQuitMessage(0);  // ����WM_QUIT��Ϣ���߳���Ϣ����

    else Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
  end;
end;

  // �ڴ���������������
procedure DrawRectangle(hWnd: HWND);
var
  hWndDC: LongWord;
  hBrush: LongWord;
  Rect: TRect;
begin  
  if (cxClient = 0)or(cyClient = 0) then Exit;
 // �����������
  SetRect(Rect, Random(cxClient), Random(cyClient), Random(cxClient), Random(cyClient));
 // �����ɫ��ˢ
  hBrush := CreateSolidBrush(RGB(Random(257), Random(257), Random(257)));
 // ������
  hWndDC := GetDC(hWnd);
  FillRect(hWndDC, Rect, hBrush);
  ReleaseDC(hWnd, hWndDC);
 // ɾ����ˢ
  DeleteObject(hBrush);
end;

const  
  AppName = 'RandRect';

var
  WndClass: TWndClass;
  hWnd: LongWord;
  Msg: TMsg;
      
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
    MessageBox(0, 'This Program requires Windows NT!', AppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(AppName, 'Random Rectangles',
                       WS_OVERLAPPEDWINDOW,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       0, 0, hInstance, nil);

 // ��ʾ����
  ShowWindow(hWnd, CmdShow);
  UpdateWindow(hWnd);
  
 // ��Ϣѭ��
  while TRUE do
  begin  // ȡ����Ϣ�򷵻�TRUE
    if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
    begin
      if (Msg.message = WM_QUIT) then Break; // ����ѭ��
      TranslateMessage(Msg); // ����ת�ַ�
      DispatchMessage(Msg);  // �ַ���Ϣ
    end else
    begin // û����ϢҪ�����ʱ�����������
      DrawRectangle(hWnd);
      Sleep(5); // �����Ҽ���һ����ʱ����
    end;
  end;
end.
