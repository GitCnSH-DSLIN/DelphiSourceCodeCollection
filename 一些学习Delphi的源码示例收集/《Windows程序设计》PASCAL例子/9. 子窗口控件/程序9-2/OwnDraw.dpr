program  OwnDraw;

uses
  Windows, Messages;

  // �������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
    // ���������
  procedure Triangle(hWndDc: HDC; var Pt: array of TPoint);
  begin
    SelectObject(hWndDc, GetStockObject(BLACK_BRUSH));
    Polygon(hWndDc, Pt[0], 3);
    SelectObject(hWndDc, GetStockObject(WHITE_BRUSH));
  end;
const
  ID_SMALLER = 1;
  ID_LARGER = 2;
// #define BTN_WIDTH  (8 * cxChar)
// #define BTN_HEIGHT (4 * cyChar)
{$J+}
  hWndSmaller: Integer = 0;
  hWndLarger: Integer = 0;
  cxClient: Integer = 0;
  cyClient: Integer = 0;
  cxChar: Integer = 0;
  cyChar: Integer = 0;
{$J-}
var
  cx, cy: Integer;
  pdis: PDrawItemStruct;
  Pt: array[0..2] of TPoint;
  Rc: TRect;
begin
  Result := 0;
 // ���ֲ�ͬ����Ϣ
  case Msg of
    WM_CREATE: {-- ����ϵͳ����ߴ罨��������ť --}
      begin
        cxChar := LOWORD(GetDialogBaseUnits());
        cyChar := HIWORD(GetDialogBaseUnits());
        hWndSmaller := CreateWindow('button', nil,
                                WS_CHILD or WS_VISIBLE or BS_OWNERDRAW,
                                0, 0, 8 * cxChar, 4 * cyChar,
                                hWnd, ID_SMALLER, hInstance, nil);
        hWndLarger := CreateWindow('button', nil,
                                WS_CHILD or WS_VISIBLE or BS_OWNERDRAW,
                                0, 0, 8 * cxChar, 4 * cyChar,
                                hWnd, ID_LARGER, hInstance, nil);
      end;

    WM_SIZE: {-- �����µĴ���ߴ����������ť --}
      begin
        cxClient := LOWORD(lParam);
        cyClient := HIWORD(lParam);
        MoveWindow(hWndSmaller, cxClient div 2 - 3 * 8 * cxChar div 2,
                cyClient div 2 - 4 * cyChar div 2, 8 * cxChar, 4 * cyChar, TRUE);
        MoveWindow(hWndLarger, cxClient div 2 + 8 * cxChar div 2,
                cyClient div 2 - 4 * cyChar div 2, 8 * cxChar, 4 * cyChar, TRUE);
      end;

    WM_COMMAND: {-- ����������ť����������ߴ� --}
       begin
         GetWindowRect(hWnd, Rc);
         case wParam of (* ����BN_CLICKED=0,����ֱ���ж�. *)
           ID_SMALLER:
             begin
               Inc(Rc.Left, (cxClient div 20));
               Dec(Rc.Right, (cxClient div 20));
               Inc(Rc.Top, (cyClient div 20));
               Dec(Rc.Bottom, (cyClient div 20));
             end;

           ID_LARGER:
             begin
               Dec(Rc.Left, (cxClient div 20));
               Inc(Rc.Right, (cxClient div 20));
               Dec(Rc.Top, (cyClient div 20));
               Inc(Rc.Bottom, (cyClient div 20));
             end;
         end;
         MoveWindow(hWnd, Rc.Left, Rc.Top, Rc.Right - Rc.Left, Rc.Bottom - Rc.Top, TRUE);
       end;

    WM_DRAWITEM: {-- ����BS_OWNERDRAW��ť --}
      begin
        pdis := PDrawItemStruct(lParam);
       // ��䱳��
        FillRect(pdis.hDC, pdis.rcItem, GetStockObject(WHITE_BRUSH));
       // ���Ʊ߿�
        FrameRect(pdis.hDC, pdis.rcItem, GetStockObject(BLACK_BRUSH));
       // ��������
        cx := pdis.rcItem.Right  - pdis.rcItem.Left;
        cy := pdis.rcItem.Bottom - pdis.rcItem.Top;
        case pdis.CtlID of
          ID_SMALLER:
            begin
              Pt[0].X := 3 * cx div 8;  Pt[0].Y := 1 * cy div 8;
              Pt[1].X := 5 * cx div 8;  Pt[1].Y := 1 * cy div 8;
              Pt[2].X := 4 * cx div 8;  Pt[2].Y := 3 * cy div 8;
              Triangle (pdis.hDC, Pt);
              Pt[0].X := 7 * cx div 8;  Pt[0].Y := 3 * cy div 8;
              Pt[1].X := 7 * cx div 8;  Pt[1].Y := 5 * cy div 8;
              Pt[2].X := 5 * cx div 8;  Pt[2].Y := 4 * cy div 8;
              Triangle (pdis.hDC, Pt);
              Pt[0].X := 5 * cx div 8;  Pt[0].Y := 7 * cy div 8;
              Pt[1].X := 3 * cx div 8;  Pt[1].Y := 7 * cy div 8;
              Pt[2].X := 4 * cx div 8;  Pt[2].Y := 5 * cy div 8;
              Triangle (pdis.hDC, Pt);
              Pt[0].X := 1 * cx div 8;  Pt[0].Y := 5 * cy div 8;
              Pt[1].X := 1 * cx div 8;  Pt[1].Y := 3 * cy div 8;
              Pt[2].X := 3 * cx div 8;  Pt[2].Y := 4 * cy div 8;
              Triangle (pdis.hDC, Pt);
            end; 
          ID_LARGER:
            begin
              Pt[0].X := 5 * cx div 8;  Pt[0].Y := 3 * cy div 8;
              Pt[1].X := 3 * cx div 8;  Pt[1].Y := 3 * cy div 8;
              Pt[2].X := 4 * cx div 8;  Pt[2].Y := 1 * cy div 8;
              Triangle(pdis.hDC, Pt);
              Pt[0].X := 5 * cx div 8;  Pt[0].Y := 5 * cy div 8;
              Pt[1].X := 5 * cx div 8;  Pt[1].Y := 3 * cy div 8;
              Pt[2].X := 7 * cx div 8;  Pt[2].Y := 4 * cy div 8;
              Triangle(pdis.hDC, Pt);
              Pt[0].X := 3 * cx div 8;  Pt[0].Y := 5 * cy div 8;
              Pt[1].X := 5 * cx div 8;  Pt[1].Y := 5 * cy div 8;
              Pt[2].X := 4 * cx div 8;  Pt[2].Y := 7 * cy div 8;
              Triangle(pdis.hDC, pt);
              Pt[0].X := 3 * cx div 8 ;  Pt[0].Y := 3 * cy div 8;
              Pt[1].X := 3 * cx div 8 ;  Pt[1].Y := 5 * cy div 8;
              Pt[2].X := 1 * cx div 8 ;  Pt[2].Y := 4 * cy div 8;
              Triangle(pdis.hDC, Pt);
            end;
        end;
       // ��ת��ɫ
        if (pdis.itemState and ODS_SELECTED) <> 0 then InvertRect(pdis.hDC, pdis.rcItem);
       // ���߱߿�
        if (pdis.itemState and ODS_FOCUS) <> 0 then
        begin
          Inc(pdis.rcItem.Left, cx div 16);
          Inc(pdis.rcItem.Top, cy div 16);
          Dec(pdis.rcItem.Right, cx div 16);
          Dec(pdis.rcItem.Bottom, cy div 16);
          DrawFocusRect(pdis.hDC, pdis.rcItem);
        end;
      end;

    WM_DESTROY:
      PostQuitMessage(0); // ����WM_QUIT��Ϣ

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;   

const
  AppName = 'OwnDraw';

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
  hWnd := CreateWindow(AppName, 'Owner-Draw Button Demo',
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
