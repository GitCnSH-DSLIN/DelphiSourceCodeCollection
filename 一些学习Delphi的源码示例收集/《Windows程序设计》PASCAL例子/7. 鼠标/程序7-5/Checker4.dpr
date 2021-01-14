program  Checker4;

uses
  Windows, Messages, Math;

const
  ChildClass = 'Checker4_Child'; // �Ӵ�������

var
  idFocus: Integer = 0; // ��ǰ�����ӿؼ�ID

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
            hWndChild[X][Y] := CreateWindow(ChildClass, nil, WS_CHILD or WS_VISIBLE,
                                    0, 0, 0, 0, hWnd, Y shl 8 or X, hInstance, nil);

    WM_SIZE:
      begin  // ������Ӵ���λ�úʹ�С
        cxBlock := LOWORD(lParam) div DIVISIONS;
        cyBlock := HIWORD(lParam) div DIVISIONS;
        for X := 0 to DIVISIONS - 1 do
          for Y := 0 to DIVISIONS - 1 do
            MoveWindow(hwndChild[X][Y], X * cxBlock, Y * cyBlock, cxBlock, cyBlock, TRUE);
      end;

    WM_LBUTTONDOWN:
      MessageBeep(0); // ������Χ������

    WM_SETFOCUS:
      SetFocus(GetDlgItem(hWnd, idFocus)); // ת�����㵽�Ӵ���

    WM_KEYDOWN: // ������Ϣ���ӿؼ�ת������
      begin
       // ��ǰ����
        X := idFocus and $FF;
        Y := idFocus shr 8;
       // ����λ��
        case wParam of
          VK_UP   : Dec(Y);
          VK_DOWN : Inc(Y);
          VK_LEFT : Dec(X);
          VK_RIGHT: Inc(X);
          VK_HOME : begin X := 0;  Y := 0 ;  end;
          VK_END  : begin X := DIVISIONS - 1;  Y := DIVISIONS - 1; end;
          else Exit;
        end;
       // ���轹��
        X := (X + DIVISIONS) mod DIVISIONS;
        Y := (Y + DIVISIONS) mod DIVISIONS;
        idFocus := Y shl 8 or X;
        SetFocus(GetDlgItem(hWnd, idFocus)); // SetFocus(hWndChild[X][Y]);
      end;

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

    WM_KEYDOWN:
      begin
        if (wParam <> VK_RETURN) and (wParam <> VK_SPACE) then
          SendMessage(GetParent(hWnd), Msg, wParam, lParam) // ת��������Ϣ
        else
        begin
          SetWindowLong(hWnd, 0 , 1 xor GetWindowLong(hWnd, 0)); // ��־ȡ��
          InvalidateRect(hWnd, nil, FALSE); // ˢ��
        end;
      end;

    WM_LBUTTONDOWN:
      begin
        SetWindowLong(hWnd, 0 , 1 xor GetWindowLong(hWnd, 0)); // ��־ȡ��
        SetFocus(hWnd);
        InvalidateRect(hWnd, nil, FALSE); // ˢ��
      end;

    WM_SETFOCUS:
      begin
        InvalidateRect(hWnd, nil, TRUE);      
        idFocus := GetWindowLong(hWnd, GWL_ID);
      end;

    WM_KILLFOCUS:
      InvalidateRect(hWnd, nil, TRUE);

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

        if (hWnd = GetFocus) then // ���߿�
        begin
          Rect.Left := Rect.Left + Rect.Right div 10;
          Rect.Right := Rect.Right - Rect.Left;
          Rect.Top := Rect.Top + Rect.Bottom div 10;
          Rect.Bottom := Rect.Bottom - Rect.Top;
          SelectObject(hWndDc, GetStockObject(NULL_BRUSH));
          SelectObject(hWndDc, CreatePen(PS_DASH, 0, 0));
          Rectangle(hWndDc, Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
          DeleteObject(SelectObject(hWndDc, GetStockObject(BLACK_PEN)));
        end;

        EndPaint(hWnd, PS);
      end;

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
  end;
end; 

const
  AppName = 'Checker4';   
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
  WndClass.lpszClassName := ChildClass;

 // ע���Ӵ��崰����
  RegisterClass(WndClass); 

 // ����������
  hWnd := CreateWindow(AppName, 'Checker4 Mouse Hit-Test Demo',
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
