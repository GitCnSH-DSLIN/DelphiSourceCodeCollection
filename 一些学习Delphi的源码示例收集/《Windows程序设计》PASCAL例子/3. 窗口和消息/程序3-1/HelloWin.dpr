program  HelloWin;

uses
  Windows, Messages, MMSystem;

  // �������    {������}  {��Ϣ��ʶ} {��Ϣ����1}     {��Ϣ����2}
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  hWndDc: HDC;  // �豸���ݾ��
  Rect: TRect;  // �ͻ�����Χ
  PS: TPaintStruct; 
begin
  Result := 0;
 // ���ֲ�ͬ����Ϣ 
  case Msg of
    WM_CREATE   :  PlaySound('HelloWin.Wav', 0, SND_FILENAME or SND_ASYNC);
    
    WM_PAINT    :  begin
                    // ��ʼ����(ʹ����������Ч�������豸���ݾ��)
                     hWndDc := BeginPaint(hWnd, PS);

                    // ȡ�õ�ǰ����ͻ�����Χ,�����м�������� 
                     GetClientRect(hWnd, Rect);
                     DrawText(hWndDc, 'Hello, Windows 98!', -1, Rect,
                       DT_SINGLELINE or DT_CENTER or DT_VCENTER);
                       
                    // ��������(�ͷ��豸���ݾ��)   
                     EndPaint(hWnd, PS);
                   end;
                   
    WM_DESTROY  :  PostQuitMessage(0); // ����WM_QUIT����GetMessage����FALSE

    else Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
  end;
end;

const
  AppName = 'HelloWin';
  
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
  hWnd := CreateWindow(AppName, 'The Hello Program',
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

 (* �����ж�RegisterClass()���, ��ҪΪ��Ԥ��UniCode�溯����98����ʧ�� *)
end.
