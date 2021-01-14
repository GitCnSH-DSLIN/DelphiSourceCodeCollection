program  Beeper2;

uses
  Windows, Messages;

  // ��ʱ���ص�����
procedure TimerProc(hWnd: HWND; uMsg: UINT; idEvent: UINT; dwTime: DWORD); stdcall;
const
  {$J+}
  fFlipFlop: Boolean = FALSE; // ��ɫ��־
  {$J-}
var
  hWndDc: HDC;
  Rect: TRect;
  hBrush: DWORD;
begin
  MessageBeep($80000000); // ����            
  GetClientRect(hWnd, Rect); // ����ͻ�����Χ
  fFlipFlop := not fFlipFlop; // ��ɫ��־ȡ��
  if fFlipFlop then
    hBrush := CreateSolidBrush(RGB(255,0,0)) // ������ɫ��ˢ
  else
    hBrush := CreateSolidBrush(RGB(0,0,255)); // ������ɫ��ˢ
  hWndDc := GetDC(hWnd); // ȡ���豸�������
  FillRect(hWndDc, Rect, hBrush); // ������
  DeleteObject(hBrush); // ɾ����ˢ����
  ReleaseDC(hWnd, hWndDc); // �ͷ��豸�������
end;

  // ������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  ID_TIMER = 1; // ��ʱ��ID
begin
  Result := 0;
 // ���ֲ�ͬ����Ϣ 
  case Msg of
    WM_CREATE   :  SetTimer(hWnd, ID_TIMER, 1000, @TimerProc); // ��װ��ʱ��
                   
    WM_DESTROY  :  begin
                     PostQuitMessage(0); // ����WM_QUIT����GetMessage����FALSE
                     KillTimer(hWnd, ID_TIMER); // ɾ����ʱ��
                   end;

    else Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
  end;
end;

const
  AppName = 'Beeper2';
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
  hWnd := CreateWindow(AppName, 'Beeper2 Timer Demo',
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
