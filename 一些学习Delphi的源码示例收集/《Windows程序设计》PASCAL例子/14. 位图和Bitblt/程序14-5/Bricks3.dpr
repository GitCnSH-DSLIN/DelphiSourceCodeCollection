program  Bricks3;

{$R  Bricks3.res}

uses
  Windows, Messages;

   // ������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  if (Msg = WM_DESTROY) then PostQuitMessage(0);
end;    
  
const
  szAppName = 'Bricks3';
var
  hBitmap, hBrush, hWnd: LongWord;
  Msg: TMsg;
  WndClass: TWndClass;
begin
 // ������ˢ
  hBitmap := LoadBitmap(hInstance, 'Bricks');
  hBrush := CreatePatternBrush(hBitmap);
  DeleteObject(hBitmap);

 // ע�ᴰ����
  WndClass.style := CS_HREDRAW or CS_VREDRAW;
  WndClass.lpfnWndProc := @WndProc;
  WndClass.cbClsExtra := 0;
  WndClass.cbWndExtra := 0;
  WndClass.hInstance := hInstance;
  WndClass.hIcon := LoadIcon(0, IDI_APPLICATION);
  WndClass.hCursor := LoadCursor(0, IDC_ARROW);
  WndClass.hbrBackground := hBrush; // ������ˢ
  WndClass.lpszMenuName := nil;
  WndClass.lpszClassName := szAppName;
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(szAppName, 'CreatePatternBrush Demo',
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

 // ɾ����ˢ
  DeleteObject(hBrush);
end.
