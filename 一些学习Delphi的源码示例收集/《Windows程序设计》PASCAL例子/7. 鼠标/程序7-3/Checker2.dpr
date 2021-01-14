program  Checker2;

uses
  Windows, Messages, Math;

  // ������Ϣ����ص�����
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  DIVISIONS = 5;
 {$J+}
  fState: array[0..DIVISIONS-1] of array [0..DIVISIONS-1] of Boolean = (
    (FALSE, FALSE, FALSE, FALSE, FALSE), (FALSE, FALSE, FALSE, FALSE, FALSE),
    (FALSE, FALSE, FALSE, FALSE, FALSE), (FALSE, FALSE, FALSE, FALSE, FALSE),
    (FALSE, FALSE, FALSE, FALSE, FALSE) );
  cxBlock: Integer = 0; // ������
  cyBlock: Integer = 0; // ����߶�
 {$J+}
var
  hWndDc: HDC;
  PS: TPaintStruct;
  X, Y: Integer;  
  Rect: TRect; // ʧЧ��Χ
  Point: TPoint;
begin
  Result := 0;

  case Msg of
  
    WM_SIZE:
      begin // ����ߴ�
        cxBlock := LOWORD(lParam) div DIVISIONS;
        cyBlock := HIWORD(lParam) div DIVISIONS;
      end;

    WM_SETFOCUS:
      ShowCursor(TRUE);

    WM_KILLFOCUS:
      ShowCursor(FALSE);
      
    WM_KEYDOWN :
      begin
       // ��ǰ���λ��
        GetCursorPos(Point);
        ScreenToClient(hWnd, Point);
       // ������������
        X := Max(0, Min(DIVISIONS - 1, Point.X div cxBlock));
        Y := Max(0, Min(DIVISIONS - 1, Point.Y div cyBlock));
       // ������ֵ
        case (wParam) of
          VK_UP    :  Dec(Y);
          VK_DOWN  :  Inc(Y);
          VK_LEFT  :  Dec(X);
          VK_RIGHT :  Inc(X);
          VK_HOME  :  begin  X := 0;  Y := 0;  end;
          VK_END   :  begin  X := DIVISIONS - 1;  Y := DIVISIONS - 1;  end;
          VK_RETURN,
          VK_SPACE :  SendMessage(hWnd, WM_LBUTTONDOWN, MK_LBUTTON,
                              MakeLong(X * cxBlock, Y * cyBlock)); // ������Ͻ�(ѡ��)
        end;
       // �����λ��
        X := (X + DIVISIONS) mod DIVISIONS;
        Y := (Y + DIVISIONS) mod DIVISIONS;
        Point.X := X * cxBlock + cxBlock div 2;
        Point.Y := Y * cyBlock + cyBlock div 2;
        ClientToScreen(hWnd, Point);
        SetCursorPos(Point.X, Point.Y);
      end;

    WM_LBUTTONDOWN:
      begin
        X := LOWORD(lParam) div cxBlock;
        Y := HIWORD(lParam) div cyBlock;
        if (X < DIVISIONS)and(Y < DIVISIONS) then
        begin
          fState[X][Y] := not fState[X][Y]; // ȡ��
          Rect.Left := X * cxBlock;
          Rect.Top := Y * cyBlock;
          Rect.Right := (X + 1) * cxBlock;
          Rect.Bottom := (y + 1) * cyBlock;
          InvalidateRect(hWnd, @Rect, FALSE); // ˢ��
        end else
          MessageBeep(0); // ������Χ������
      end;

    WM_PAINT:
      begin
        hWndDc := BeginPaint(hWnd, PS); // ��ʼ����
        
        for X := 0 to DIVISIONS - 1 do
          for Y := 0 to DIVISIONS - 1 do
          begin     // ���Ʊ߿�
            Rectangle(hWndDc, X * cxBlock, Y * cyBlock, (X + 1) * cxBlock, (Y + 1) * cyBlock);
            if fState[X][Y] then // ���Ʋ��
            begin
              MoveToEx(hWndDc, X * cxBlock,  Y * cyBlock, nil);
              LineTo(hWndDc, (X+1) * cxBlock, (Y+1) * cyBlock);
              MoveToEx(hWndDc, X * cxBlock, (Y+1) * cyBlock, nil);
              LineTo(hWndDc, (X+1) * cxBlock, Y  * cyBlock);
            end;
          end;

        EndPaint(hWnd, PS); // ��������
      end;

    WM_DESTROY:
      PostQuitMessage(0); // �����߳���Ϣѭ��

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���

  end;  //  END 'case Msg of'  ....
end;


const  
  AppName = 'Checker2';

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
  hWnd := CreateWindow(AppName, 'Checker2 Mouse Hit-Test Demo',
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
