program MDIDemo;

{$R MDIDemo.Res}

uses
  Windows, Messages, Math;

type
  PHelloData = ^HelloData;
  HelloData = record // structure for storing data unique to each Hello child window
    iColor: UINT;
    clrText: COLORREF;
  end;

  PRectData = ^RectData;
  RectData = record // structure for storing data unique to each Rect child window
    cxClient: SHORT;
    cyClient: SHORT;
  end;
  
const
  szAppName = 'MDIDemo';
  szFrameClass = 'MdiFrame';
  szHelloClass = 'MdiHelloChild';
  szRectClass  = 'MdiRectChild';
  HEAP_NO_SERIALIZE          = $00000001; // API��������..
  HEAP_GROWABLE              = $00000002;
  HEAP_GENERATE_EXCEPTIONS   = $00000004;
  HEAP_ZERO_MEMORY           = $00000008;
  HEAP_REALLOC_IN_PLACE_ONLY = $00000010;
  IDM_FILE_NEWHELLO   = 40001; // ����ID ..
  IDM_FILE_NEWRECT    = 40002;
  IDM_APP_EXIT        = 40003;
  IDM_FILE_CLOSE      = 40004;
  IDM_COLOR_BLACK     = 40005;
  IDM_COLOR_RED       = 40006;
  IDM_COLOR_GREEN     = 40007;
  IDM_COLOR_BLUE      = 40008;
  IDM_COLOR_WHITE     = 40009;
  IDM_WINDOW_CASCADE  = 40010;
  IDM_WINDOW_TILE     = 40011;
  IDM_WINDOW_ARRANGE  = 40012;
  IDM_WINDOW_CLOSEALL = 40013;
  INIT_MENU_POS  = 0; // Windows�Ӳ˵�λ��..
  HELLO_MENU_POS = 2;
  RECT_MENU_POS  = 1;
  IDM_FIRSTCHILD = 50000; // ���б��еĵ�һ������������Ĳ˵�ID
  
var
  hMenuInit, hMenuHello, hMenuRect: HMENU;
  hMenuInitWindow, hMenuHelloWindow, hMenuRectWindow: HMENU;

  // �Ӵ���ö�ٻص�����(���ڹر��Ӵ���)
function CloseEnumProc(hWnd: HWND; lParam: LPARAM): BOOL; stdcall;
begin
  Result := TRUE; // ����ö��
  if (GetWindow(hWnd, GW_OWNER) <> 0) then Exit; // Check for icon title 
  SendMessage(GetParent(hWnd), WM_MDIRESTORE, hWnd, 0);
  if (SendMessage(hWnd, WM_QUERYENDSESSION, 0, 0) = 0) then Exit;
  SendMessage(GetParent(hWnd), WM_MDIDESTROY, hWnd, 0);
end;
  
  // ����ܴ�����Ϣ����ص�����
function FrameWndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+}
  hWndClient: LongWord = 0; // �ͻ����ھ��
{$J-}
var
  ClientCreate: TClientCreateStruct; // �ͻ�����ṹ
  hWndChild: LongWord; // MDI�Ӵ��ھ��
  MDICreate: TMDICreateStruct; // MDI�Ӵ��ڽṹ
begin     
  Result := 0;
  case (Msg) of
    WM_CREATE:
      begin // Ϊ�Լ������ͻ�����
        ClientCreate.hWindowMenu := hMenuInitWindow; // Ҫ�����б�Ĳ˵�
        ClientCreate.idFirstChild := IDM_FIRSTCHILD; // ���б��еĵ�һ������������Ĳ˵�ID
        hWndClient := CreateWindow('MDICLIENT', nil,
          WS_CHILD or WS_CLIPCHILDREN or WS_VISIBLE,
          0, 0, 0, 0, hWnd, 1, hInstance, @ClientCreate);
      end;

    WM_COMMAND: // �˵�(or��ݼ�����)
      begin
        case LOWORD(wParam) of
          IDM_FILE_NEWHELLO:  // ����Hello�Ӵ���
            begin
              MDICreate.szClass := szHelloClass;
              MDICreate.szTitle := 'Hello';
              MDICreate.hOwner := hInstance;
              MDICreate.x := Integer(CW_USEDEFAULT);
              MDICreate.y := Integer(CW_USEDEFAULT);
              MDICreate.cx := Integer(CW_USEDEFAULT);
              MDICreate.cy := Integer(CW_USEDEFAULT);
              MDICreate.style := 0;
              MDICreate.lParam := 0;
              hWndChild :=
                SendMessage(hWndClient, WM_MDICREATE, 0, LongInt(@MDICreate));
            end;

          IDM_FILE_NEWRECT: // ����Rect�Ӵ���
            begin
              MDICreate.szClass := szRectClass ;
              MDICreate.szTitle := 'Rectangles';
              MDICreate.hOwner := hInstance;
              MDICreate.x := Integer(CW_USEDEFAULT);
              MDICreate.y := Integer(CW_USEDEFAULT);
              MDICreate.cx := Integer(CW_USEDEFAULT);
              MDICreate.cy := Integer(CW_USEDEFAULT);
              MDICreate.style := 0;
              MDICreate.lParam := 0;
              hWndChild :=
                SendMessage(hWndClient, WM_MDICREATE, 0, LongInt(@MDICreate));
            end;

          IDM_FILE_CLOSE: // �رջ�Ӵ���
            begin
              hWndChild := SendMessage(hWndClient, WM_MDIGETACTIVE, 0, 0); // ȡ��Ӵ���
              if (SendMessage(hWndChild, WM_QUERYENDSESSION, 0, 0) <> 0) then //ѯ���Ƿ���Թر�
                SendMessage(hWndClient, WM_MDIDESTROY, hWndChild, 0); // �ر�
            end;

          IDM_APP_EXIT: // �˳�����
            begin
              SendMessage(hWnd, WM_CLOSE, 0, 0); // �ر�����
            end;

          IDM_WINDOW_TILE: // ���з�ʽ..
            begin
              SendMessage(hWndClient, WM_MDITILE, 0, 0);
            end;

          IDM_WINDOW_CASCADE:
            begin
              SendMessage(hWndClient, WM_MDICASCADE, 0, 0);
            end;

          IDM_WINDOW_ARRANGE:
            begin
              SendMessage(hWndClient, WM_MDIICONARRANGE, 0, 0);
            end;

          IDM_WINDOW_CLOSEALL: // �ر������Ӵ���
            begin
              EnumChildWindows(hWndClient, @CloseEnumProc, 0); // �����ر�
            end;

          else
            begin // ����WM_COMMAND��Ϣ������Ӵ���
              hWndChild := SendMessage(hWndClient, WM_MDIGETACTIVE, 0, 0);
              if IsWindow(hWndChild) then SendMessage(hWndChild, WM_COMMAND, wParam, lParam);
              Result := DefFrameProc(hWnd, hWndClient, Msg, wParam, lParam);
            end;
        end;
      end;

    WM_QUERYENDSESSION,
    WM_CLOSE:
      begin
        SendMessage(hWnd, WM_COMMAND, IDM_WINDOW_CLOSEALL, 0); // �ر������Ӵ���
        if (GetWindow(hWndClient, GW_CHILD) <> 0) then
          Exit // �����Ӵ���, �򲻵���DefFrameProc(), ����ֹ�ر�..
        else
          Result := DefFrameProc(hWnd, hWndClient, Msg, wParam, lParam);
      end;

    WM_DESTROY:
      begin
        PostQuitMessage(0); // ��ǰ�̵߳���Ϣ���з�һ��WM_QUIT
      end;

    else
      begin
        Result := DefFrameProc(hWnd, hWndClient, Msg, wParam, lParam); // ��׼�����Ϣ����
      end;
  end;
end;

  // Hello�Ӵ�����Ϣ����ص�����
function HelloWndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  clrTextArray: array[0..4] of COLORREF = // RGB(x, y, z) -> $0 z y x
    ( $000000, $0000FF, $00FF00, $FF0000, $FFFFFF );
{$J+}
  hWndClient: LongWord = 0;
  hWndFrame: LongWord = 0;
{$J+}
var
  hWndDc: HDC;
  hMenu: LongWord; // HMENU
  HelloDataPt: PHelloData;
  ps: TPaintStruct;
  Rect: TRect;
begin
  Result := 0;
  case (Msg) of
    WM_CREATE:
      begin
       // Ĭ�϶��Ϸ���ṹ�ڴ�,��ʼ��,������ָ���ڴ��ڶ����ڴ�
        HelloDataPt := HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY, SizeOf(HelloData));
        HelloDataPt.iColor := IDM_COLOR_BLACK;
        HelloDataPt.clrText := 0; // RGB(0, 0, 0)
        SetWindowLong(hWnd, 0, LongWord(HelloDataPt));

       // �����ܴ��ںͿͻ����ھ��
        hWndClient := GetParent(hWnd);
        hWndFrame := GetParent(hWndClient);
      end;

    WM_COMMAND:
      begin
        case wParam of
          IDM_COLOR_BLACK,
          IDM_COLOR_RED,
          IDM_COLOR_GREEN,
          IDM_COLOR_BLUE,
          IDM_COLOR_WHITE:
            begin
              HelloDataPt := PHelloData(GetWindowLong(hWnd, 0)); // ����ָ��
              hMenu := GetMenu(hWndFrame); // ��ܴ��ڲ˵�
              CheckMenuItem(hMenu, HelloDataPt.iColor, MF_UNCHECKED);
              HelloDataPt.iColor := wParam; // ��ǰ��ѡ�˵���
              CheckMenuItem(hMenu, HelloDataPt.iColor, MF_CHECKED);
              HelloDataPt.clrText := clrTextArray[wParam - IDM_COLOR_BLACK]; // ��ǰ��ɫ
              InvalidateRect(hWnd, nil, FALSE); // ˢ��
            end;
        end;
      end;

    WM_PAINT:
      begin
        hWndDc := BeginPaint(hWnd, ps);

        HelloDataPt := PHelloData(GetWindowLong(hWnd, 0)); // ����ָ��
        SetTextColor(hWndDc, HelloDataPt.clrText); // ������ɫ
        GetClientRect(hWnd, Rect);
        DrawText(hWndDc, 'Hello, World!', -1, Rect, DT_SINGLELINE or DT_CENTER or DT_VCENTER);

        EndPaint(hWnd, ps);
      end;

    WM_MDIACTIVATE: // WM_MDISETMENU�������ò˵����б��Ӳ˵�
      begin
       // Set the Hello menu if gaining focus
        if (lParam = Integer(hWnd)) then
          SendMessage(hWndClient, WM_MDISETMENU, hMenuHello, hMenuHelloWindow);

       // Check or uncheck menu item
        HelloDataPt := PHelloData(GetWindowLong(hWnd, 0));
        if (lParam = Integer(hWnd)) then
          CheckMenuItem(hMenuHello, HelloDataPt.iColor, MF_CHECKED)
        else
          CheckMenuItem(hMenuHello, HelloDataPt.iColor, MF_UNCHECKED);

       // Set the Init menu if losing focus
        if (lParam <> Integer(hWnd)) then
          SendMessage(hWndClient, WM_MDISETMENU, hMenuInit, hMenuInitWindow);

        DrawMenuBar(hWndFrame);
      end;

    WM_QUERYENDSESSION,
    WM_CLOSE:
      begin
        if (IDOK = MessageBox(hWnd, 'OK to close window?',
          'Hello', MB_ICONQUESTION or MB_OKCANCEL)) then // ȷ�Ϲر�
        begin
          Result := DefMDIChildProc(hWnd, Msg, wParam, lParam);
        end else
        begin
          Exit; // ������DefMDIChildProc(), �Ӷ���ֹ�ر�
        end;
      end;

    WM_DESTROY:
      begin
        HelloDataPt := PHelloData(GetWindowLong(hWnd, 0));
        HeapFree(GetProcessHeap(), 0, HelloDataPt); // �ͷ��ڴ�
      end;

    else
      begin
        Result := DefMDIChildProc(hWnd, Msg, wParam, lParam); // ��׼MDI�Ӵ�����Ϣ����
      end;
  end;
end;

  // Rect�Ӵ�����Ϣ����ص�����
function RectWndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+}
  hWndClient: LongWord = 0;
  hWndFrame: LongWord = 0;
{$J-}
var
  hBrush: LongWord; // HBRUSH
  hWndDc: HDC;
  RectDataPt: PRectData;
  ps: TPaintStruct;
  xLeft, xRight, yTop, yBottom: Integer;
  nRed, nGreen, nBlue: SHORT;
begin
  Result := 0;
  case (Msg) of
    WM_CREATE:       
      begin
       // ����ṹ�ڴ�,�������ַ�����ڶ����ڴ�
        RectDataPt := PRectData(HeapAlloc(GetProcessHeap(),
          HEAP_ZERO_MEMORY, SizeOf(RectData)));
        SetWindowLong(hWnd, 0, LongWord(RectDataPt));

       // ��װ(��ͼ)��ʱ��
        SetTimer(hWnd, 1, 250, nil);

       // ���游������
        hWndClient := GetParent(hWnd);
        hWndFrame := GetParent(hWndClient);
      end;

    WM_SIZE:
      begin
        if (wParam <> SIZE_MINIMIZED) then // If not minimized, save the window size
        begin
          RectDataPt := PRectData(GetWindowLong(hWnd, 0));
          RectDataPt.cxClient := LOWORD(lParam);
          RectDataPt.cyClient := HIWORD(lParam);
        end;
        Result := DefMDIChildProc(hWnd, Msg, wParam, lParam); // ��׼����
      end;

    WM_TIMER: // ����һ������ľ���
      begin
       // ȡ��ָ��
        RectDataPt := PRectData(GetWindowLong(hWnd, 0));

       // �����Χ
        xLeft := Random(RectDataPt.cxClient);
        xRight := Random(RectDataPt.cxClient);
        yTop := Random(RectDataPt.cyClient);
        yBottom := Random(RectDataPt.cyClient);

       // �����ɫ
        nRed := Random(255);
        nGreen := Random(255);
        nBlue := Random(255);

       // ������
        hWndDc := GetDC(hWnd);
        hBrush := CreateSolidBrush(RGB(nRed, nGreen, nBlue));
        SelectObject(hWndDc, hBrush);
        Rectangle(hWndDc, Min(xLeft, xRight),
          Min(yTop, yBottom), Max(xLeft, xRight), Max(yTop, yBottom));
        ReleaseDC(hWnd, hWndDc);
        DeleteObject(hBrush);
      end;

    WM_PAINT:
      begin
        InvalidateRect(hWnd, nil, TRUE); // ȫ��ʧЧ
        BeginPaint(hWnd, ps); // ��Ч,���ñ���ɫ���(Ҳ�������)
        EndPaint(hWnd, ps);
      end;

    WM_MDIACTIVATE:  // �õ�orʧȥ���㶼���յ�����Ϣ
      begin // Set the appropriate menu
        if (lParam = Integer(hWnd)) then
          SendMessage(hWndClient, WM_MDISETMENU, hMenuRect, hMenuRectWindow)
        else
          SendMessage(hWndClient, WM_MDISETMENU, hMenuInit, hMenuInitWindow);
        DrawMenuBar(hWndFrame);
      end;

    WM_DESTROY:
      begin
        RectDataPt := PRectData(GetWindowLong(hWnd, 0)); // ȡ��ָ��
        HeapFree(GetProcessHeap(), 0, RectDataPt); // �ͷ��ڴ�
        KillTimer(hWnd, 1); // ɾ����ʱ��
      end;

    else
      begin
        Result := DefMDIChildProc(hWnd, Msg, wParam, lParam); // ��׼MDI�Ӵ�����Ϣ����
      end;
  end;
end;

var
  hAccel: LongWord; // HACCEL;
  hWndFrame, hWndClient: HWND;
  Msg: TMsg;
  WndClass: TWndClass;
begin
 // Register the frame window class (ע���ܴ���)
  WndClass.style := CS_HREDRAW or CS_VREDRAW;
  WndClass.lpfnWndProc := @FrameWndProc;
  WndClass.cbClsExtra := 0;
  WndClass.cbWndExtra := 0;
  WndClass.hInstance := hInstance;
  WndClass.hIcon := LoadIcon(0, IDI_APPLICATION);
  WndClass.hCursor := LoadCursor(0, IDC_ARROW);
  WndClass.hbrBackground := COLOR_APPWORKSPACE + 1;
  WndClass.lpszMenuName := nil;
  WndClass.lpszClassName := szFrameClass;
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // Register the Hello child window class (ע��Hello�Ӵ���)
  WndClass.style := CS_HREDRAW or CS_VREDRAW;
  WndClass.lpfnWndProc := @HelloWndProc;
  WndClass.cbClsExtra := 0;
  WndClass.cbWndExtra := SizeOf(PHelloData); // ����ʵ������ռ�
  WndClass.hInstance := hInstance;
  WndClass.hIcon := LoadIcon(0, IDI_APPLICATION);
  WndClass.hCursor := LoadCursor(0, IDC_ARROW);
  WndClass.hbrBackground := GetStockObject(WHITE_BRUSH);
  WndClass.lpszMenuName := nil;
  WndClass.lpszClassName := szHelloClass;
  RegisterClass(WndClass);

 // Register the Rect child window class (ע��Rect�Ӵ���)
  WndClass.style := CS_HREDRAW or CS_VREDRAW;
  WndClass.lpfnWndProc := @RectWndProc;
  WndClass.cbClsExtra := 0;
  WndClass.cbWndExtra := SizeOf(PRectData); // ����ʵ������ռ�
  WndClass.hInstance := hInstance;
  WndClass.hIcon := LoadIcon(0, IDI_APPLICATION);
  WndClass.hCursor := LoadCursor(0, IDC_ARROW);
  WndClass.hbrBackground := GetStockObject(WHITE_BRUSH);
  WndClass.lpszMenuName := nil;
  WndClass.lpszClassName := szRectClass;
  RegisterClass(WndClass);

 // Obtain handles to three possible menus & submenus (����˵�)
  hMenuInit := LoadMenu(hInstance, 'MdiMenuInit');
  hMenuHello := LoadMenu(hInstance, 'MdiMenuHello');
  hMenuRect := LoadMenu(hInstance, 'MdiMenuRect');
  hMenuInitWindow := GetSubMenu(hMenuInit, INIT_MENU_POS); // Windows�Ӳ˵�..
  hMenuHelloWindow := GetSubMenu(hMenuHello, HELLO_MENU_POS);
  hMenuRectWindow := GetSubMenu(hMenuRect, RECT_MENU_POS);

 // Load accelerator table (�����ݼ���)
  hAccel := LoadAccelerators(hInstance, szAppName);

 // Create the frame window (������ܴ���)
  hWndFrame := CreateWindow(szFrameClass, 'MDI Demonstration',
                   WS_OVERLAPPEDWINDOW or WS_CLIPCHILDREN,
                   Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT),
                   Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT),
                   0, hMenuInit, hInstance, nil);
  hWndClient := GetWindow(hWndFrame, GW_CHILD); // ��ܴ�����Ϣ�����������Ŀͻ�����
  ShowWindow(hWndFrame, CmdShow);
  UpdateWindow(hWndFrame);

 // Enter the modified message loop (��Ϣѭ��)
  while GetMessage(Msg, 0, 0, 0) do
  begin
    if (not TranslateMDISysAccel(hWndClient, Msg)) and
       (TranslateAccelerator(hWndFrame, hAccel, Msg) = 0) then
    begin
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end;
  end;

 // Clean up by deleting unattached menus
  DestroyMenu(hMenuHello);
  DestroyMenu(hMenuRect);
end.
