program  BlokOut2;

uses
  Windows, Messages;
  
  // ������Ϣ����ص�����
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
    // ��������Ļ��ɫ�ľ��ο�
  procedure DrawBoxOutline(hWin: DWORD; ptBeg, ptEnd: TPoint);
  var
    hWndDc: HDC;
  begin
    hWndDc := GetDC(hWin);
    SetROP2(hWndDc, R2_NOT); // ��ǰ�����ģʽΪ��Ļ��ɫȡ��
    SelectObject(hWndDc, GetStockObject(NULL_BRUSH)); // �����߿�
    Rectangle(hWndDc, ptBeg.X, ptBeg.Y, ptEnd.X, ptEnd.Y);
    ReleaseDC(hWin, hWndDc);
  end;
const
 {$J+}
  fBlocking: Boolean = FALSE;  // ����'��ק'
  ptBeg: TPoint = (X: 0; Y: 0);
  ptEnd: TPoint = (X: 0; Y: 0);
  fValidBox: Boolean = FALSE;  // �о���Ҫ��
  ptBoxBeg: TPoint = (X: 0; Y: 0);
  ptBoxEnd: TPoint = (X: 0; Y: 0);
 {$J+}
var
  hWndDc: HDC;
  PS: TPaintStruct;
begin
  Result := 0;
  case Msg of
    WM_LBUTTONDOWN:
      begin
        ptBeg.X := LOWORD(lParam);
        ptEnd.X := LOWORD(lParam);
        ptBeg.Y := HIWORD(lParam);
        ptEnd.Y := HIWORD(lParam);
        DrawBoxOutline(hWnd, ptBeg, ptEnd);
        SetCapture(hWnd); // �������
        SetCursor(LoadCursor(0, IDC_CROSS)); // ʮ�ֹ��
        fBlocking := TRUE;
      end;

    WM_MOUSEMOVE:
      begin
        if fBlocking then
        begin
          SetCursor(LoadCursor(0, IDC_CROSS)); // ʮ�ֹ��
          DrawBoxOutline(hWnd, ptBeg, ptEnd); // ����ԭ����
          ptEnd.X := LOWORD(lParam);
          ptEnd.Y := HIWORD(lParam);
          DrawBoxOutline(hWnd, ptBeg, ptEnd); // �����¾���
        end;
      end;

    WM_LBUTTONUP:
      begin
        if fBlocking then
        begin
          DrawBoxOutline(hWnd, ptBeg, ptEnd); // ����
          ptBoxBeg := ptBeg;
          ptBoxEnd.X := LOWORD(lParam);
          ptBoxEnd.Y := HIWORD(lParam);
          ReleaseCapture; // ȡ������
          SetCursor(LoadCursor(0, IDC_ARROW)); // �������
          fBlocking := FALSE; // ������ק״̬
          fValidBox := TRUE;  // �о���Ҫ��
          InvalidateRect(hWnd, nil, TRUE); // ˢ��
        end;
      end;

    WM_CHAR:
      begin                // ��ESC����ȡ��
        if (fBlocking) and (wParam = VK_ESCAPE) then
        begin
          DrawBoxOutline(hWnd, ptBeg, ptEnd); // ����
          ReleaseCapture; // ȡ������
          SetCursor(LoadCursor(0, IDC_ARROW)); // �������
          fBlocking := FALSE; // ������ק״̬
        end;
      end;

    WM_PAINT:
      begin
        hWndDc := BeginPaint(hWnd, PS); // ��ʼ����

        if fValidBox then // �о���Ҫ��
        begin
          SelectObject(hWndDc, GetStockObject(BLACK_BRUSH));
          Rectangle(hWndDc, ptBoxBeg.X, ptBoxBeg.Y, ptBoxEnd.X, ptBoxEnd.Y) ;
        end;

        if fBlocking then // ��ק'״̬'
        begin
          SetROP2(hWndDc, R2_NOT);
          SelectObject(hWndDc, GetStockObject(NULL_BRUSH));
          Rectangle(hWndDc, ptBeg.X, ptBeg.Y, ptEnd.X, ptEnd.Y);
        end;

        EndPaint(hWnd, PS); // ��������
      end;

    WM_DESTROY:
       PostQuitMessage(0); // �����߳���Ϣѭ��

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
  end;
end;


const  
  AppName = 'BlokOut2';

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
  hWnd := CreateWindow(AppName, 'Mouse Button & Capture Demo',
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
