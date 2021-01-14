program  Checker3;

uses
  Windows, Messages, Math;

  // ��������Ϣ����ص�����
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  DIVISIONS = 5;
 {$J+}
  hWndChild: array[0..DIVISIONS-1] of array [0..DIVISIONS-1] of DWORD = // �Ӵ��ھ������
   ( (0, 0, 0, 0, 0), (0, 0, 0, 0, 0), (0, 0, 0, 0, 0), (0, 0, 0, 0, 0), (0, 0, 0, 0, 0) );
 {$J+}
var
  cxBlock, cyBlock, X, Y: Integer;
begin
  Result := 0;

  case Msg of
    WM_CREATE:
        for X := 0 to DIVISIONS - 1 do // �����Ӵ���
          for Y := 0 to DIVISIONS - 1 do
            hWndChild[X][Y] := CreateWindow('Checker3_Child', nil, WS_CHILD or WS_VISIBLE,
                                    0, 0, 0, 0, hWnd, Y shl 8 or X, hInstance, nil);

    WM_SIZE:
      begin  // �����Ӵ���λ�úʹ�С
        cxBlock := LOWORD(lParam) div DIVISIONS;
        cyBlock := HIWORD(lParam) div DIVISIONS;
        for X := 0 to DIVISIONS - 1 do
          for Y := 0 to DIVISIONS - 1 do
            MoveWindow(hwndChild[X][Y], X * cxBlock, Y * cyBlock, cxBlock, cyBlock, TRUE);
      end;

    WM_LBUTTONDOWN:
      MessageBeep(0); // ������Χ������

    WM_DESTROY:
      PostQuitMessage(0); // ������Ϣѭ��
      
    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
  end;  //  END 'case Msg of'  ...
end;
       
  // �Ӵ�����Ϣ����ص�����
function ChildWndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  hWndDc: HDC;
  PS: TPaintStruct;
  Rect: TRect;
begin
  Result := 0;
  case Msg of
   // WM_CREATE:
     // SetWindowLong(hWnd, 0	, 0);
   (* ע��: Windows���Զ�������ʵ�����ӿռ��и��ֽڳ�ʼ��Ϊ0 *)

    WM_LBUTTONDOWN:
      begin                
        SetWindowLong(hWnd, 0 , 1 xor GetWindowLong(hWnd, 0)); // ��־ȡ��
        InvalidateRect(hWnd, nil, FALSE);
      end;

    WM_PAINT:
      begin
        hWndDc := BeginPaint(hWnd, PS);
        
        GetClientRect(hWnd, Rect);
        Rectangle(hWndDc, 0, 0, Rect.Right, Rect.Bottom); // ���߿�
        if (GetWindowLong(hWnd, 0) <> 0) then // �����
        begin
          MoveToEx(hWndDc, 0, 0, nil) ;
          LineTo(hWndDc, Rect.Right, Rect.Bottom);
          MoveToEx(hWndDc, 0, Rect.Bottom, nil);
          LineTo(hWndDc, Rect.Right, 0);
        end;

        EndPaint(hWnd, PS);
      end;

    else Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
  end;
end; 

const
  AppName = 'Checker3';   
var
  hWnd: LongWord;
  Msg: TMsg;
  WndClass: TWndClass;         
begin
 // �����������ṹ
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

 // ע�������崰����
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'Program requires Windows NT!', AppName, MB_ICONERROR);
    Exit;
  end;

 // ����Ӵ�����ṹ
  WndClass.lpfnWndProc := @ChildWndProc;
  WndClass.cbWndExtra := SizeOf(DWORD); // ���ⴰ���ڴ�ռ�ߴ�
  WndClass.hIcon := 0;
  WndClass.lpszClassName := 'Checker3_Child';

 // ע���Ӵ��崰����
  RegisterClass(WndClass); 

 // ����������
  hWnd := CreateWindow(AppName, 'Checker3 Mouse Hit-Test Demo',
                       WS_OVERLAPPEDWINDOW,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       0, 0, hInstance, nil);

 // ��ʾ������
  ShowWindow(hWnd, CmdShow);
  UpdateWindow(hWnd);
  
 // ��Ϣѭ��
  while GetMessage(Msg, 0, 0, 0) do
  begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;
end.
