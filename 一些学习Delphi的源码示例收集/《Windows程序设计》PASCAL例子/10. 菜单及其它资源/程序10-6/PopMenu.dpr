program  PopMenu;

{$R  PopMenu.res}

uses
  Windows, Messages;

const
  szAppName = 'PopMenu';

   // ������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  IDM_FILE_NEW     = 40001; // �˵���ID ..
  IDM_FILE_OPEN    = 40002;
  IDM_FILE_SAVE    = 40003;
  IDM_FILE_SAVE_AS = 40004;
  IDM_APP_EXIT     = 40005;
  IDM_EDIT_UNDO    = 40006;
  IDM_EDIT_CUT     = 40007;
  IDM_EDIT_COPY    = 40008;
  IDM_EDIT_PASTE   = 40009;
  IDM_EDIT_CLEAR   = 40010;
  IDM_BKGND_WHITE  = 40011;
  IDM_BKGND_LTGRAY = 40012;
  IDM_BKGND_GRAY   = 40013;
  IDM_BKGND_DKGRAY = 40014;
  IDM_BKGND_BLACK  = 40015;
  IDM_APP_HELP     = 40016;
  IDM_APP_ABOUT    = 40017;
  idColor: array[0..4] of Integer = (WHITE_BRUSH, LTGRAY_BRUSH, GRAY_BRUSH, DKGRAY_BRUSH, BLACK_BRUSH);
{$J+}
  hMenu: LongWord = 0; // ����ʽ�˵���� 
  iSelection: Integer = IDM_BKGND_WHITE; // ��ǰѡ�в˵���
{$J-}
var
  Point: TPoint;
begin
  Result := 0;
  case Msg of
    WM_CREATE:
      begin
        hMenu := LoadMenu(hInstance, szAppName);
        hMenu := GetSubMenu(hMenu, 0);
      end;

    WM_RBUTTONUP:
      begin
        Point.X := LOWORD(lParam);
        Point.Y := HIWORD(lParam);
        ClientToScreen(hWnd, Point);
        TrackPopupMenu(hMenu, TPM_RIGHTBUTTON, Point.X, Point.Y, 0, hWnd, nil);
      end;

    WM_COMMAND:
      begin
        case LOWORD(wParam) of
          IDM_FILE_NEW,
          IDM_FILE_OPEN,
          IDM_FILE_SAVE,
          IDM_FILE_SAVE_AS,
          IDM_EDIT_UNDO,
          IDM_EDIT_CUT,
          IDM_EDIT_COPY,
          IDM_EDIT_PASTE,
          IDM_EDIT_CLEAR:
            begin
              MessageBeep(0);
            end;

          IDM_BKGND_WHITE,
          IDM_BKGND_LTGRAY,
          IDM_BKGND_GRAY,
          IDM_BKGND_DKGRAY,
          IDM_BKGND_BLACK:
            begin
              CheckMenuItem(hMenu, iSelection, MF_UNCHECKED); // ��ѡ
              iSelection := LOWORD(wParam);
              CheckMenuItem(hMenu, iSelection, MF_CHECKED); // ѡ��
              SetClassLong(hWnd, GCL_HBRBACKGROUND, GetStockObject(idColor[LOWORD(wParam)-IDM_BKGND_WHITE]));
              InvalidateRect(hWnd, nil, TRUE);
            end;

          IDM_APP_ABOUT:
            begin
              MessageBox(hWnd, 'Menu Demonstration Program '#13#10' (c) Charles Petzold, 1998',
                       szAppName, MB_ICONINFORMATION or MB_OK);
            end;

          IDM_APP_EXIT:
            begin
              SendMessage(hWnd, WM_CLOSE, 0, 0);
            end;

          IDM_APP_HELP:
            begin
              MessageBox(hWnd, 'Help not yet implemented!',
                       szAppName, MB_ICONEXCLAMATION or MB_OK);
            end;

          else
            begin
              Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
            end;
        end;
      end;

    WM_DESTROY:
      PostQuitMessage(0); // ��һ���˳���ϢWM_QUIT

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;     


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
  WndClass.hIcon := LoadIcon(0, szAppName);
  WndClass.hCursor := LoadCursor(0, IDC_ARROW);
  WndClass.hbrBackground := GetStockObject(WHITE_BRUSH);
  WndClass.lpszMenuName := nil;
  WndClass.lpszClassName := szAppName;

 // ע�ᴰ����
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(szAppName, 'Popup Menu Demonstration',
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
