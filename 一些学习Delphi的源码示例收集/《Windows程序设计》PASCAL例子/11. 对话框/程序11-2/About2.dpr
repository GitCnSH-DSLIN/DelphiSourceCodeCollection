program  About2;

{$R  About2.res}

uses
  Windows, Messages;

const
  IDC_BLACK     = 1000; // �ؼ�ID ...
  IDC_BLUE      = 1001;
  IDC_GREEN     = 1002;
  IDC_CYAN      = 1003;
  IDC_RED       = 1004;
  IDC_MAGENTA   = 1005;
  IDC_YELLOW    = 1006;
  IDC_WHITE     = 1007;
  IDC_RECT      = 1008;
  IDC_ELLIPSE   = 1009;
  IDC_PAINT     = 1010;
  IDM_APP_ABOUT = 40001; // �˵�ID

var
  iCurrentColor: Integer = IDC_BLACK; // ��ǰͼ����ɫ(������)
  iCurrentFigure: Integer = IDC_RECT; // ��ǰͼ����״(������)

   // ���ͼ��        // ����     // ��ɫ  // ��״
procedure PaintWindow(hWnd: HWND; iColor, iFigure: Integer);
const
  crColor: array[0..7] of COLORREF = ( 0, $FF0000, $FF00, $FFFF00, $FF, $FF00FF, $FFFF, $FFFFFF); 
var
  hBrush, hWndDc: LongWord;
  Rect: TRect;
begin
  hWndDc := GetDC(hWnd);
  GetClientRect(hWnd, Rect);
  hBrush := CreateSolidBrush(crColor[iColor - IDC_BLACK]);
  hBrush := SelectObject(hWndDc, hBrush);
  if (iFigure = IDC_RECT) then
    Rectangle(hWndDc, Rect.Left, Rect.Top, Rect.Right, Rect.Bottom)
  else
    Ellipse(hWndDc, Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
  DeleteObject(SelectObject(hWndDc, hBrush));
  ReleaseDC(hWnd, hWndDc);
end;

  // ˢ�±��������ͼ��(�˴�����Static)
procedure PaintTheBlock(hCtrl: HWND; iColor, iFigure: Integer);
begin
  InvalidateRect(hCtrl, nil, TRUE);
  UpdateWindow(hCtrl);
  PaintWindow(hCtrl, iColor, iFigure);
end;

  // �Ի�����Ϣ���չ���
function AboutDlgProc(hDlg: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
const
{$J+}
  hCtrlBlock: LongWord = 0; // ����ͼ��Static���
  iColor: Integer = 0;   // ��ǰͼ����ɫ(Static)
  iFigure: Integer = 0;  // ��ǰͼ����״(Static)
{$J-}
begin
  Result := FALSE;
  case Msg of
    WM_INITDIALOG: // ��ʼ�� ..
      begin
        iColor := iCurrentColor;
        iFigure := iCurrentFigure;
        CheckRadioButton(hDlg, IDC_BLACK, IDC_WHITE, iColor);
        CheckRadioButton(hDlg, IDC_RECT, IDC_ELLIPSE, iFigure);
        hCtrlBlock := GetDlgItem(hDlg, IDC_PAINT);
        SetFocus(GetDlgItem(hDlg, iColor));
      end;

    WM_COMMAND: // �����ť ..
      case LOWORD(wParam) of
        IDOK:
          begin
            iCurrentColor := iColor;
            iCurrentFigure := iFigure;
            EndDialog(hDlg, 1);
            Result := TRUE;
          end;

        IDCANCEL:
          begin
            EndDialog(hDlg, 0);
            Result := TRUE;
          end;

        IDC_BLACK,
        IDC_RED,
        IDC_GREEN,
        IDC_YELLOW,
        IDC_BLUE,
        IDC_MAGENTA,
        IDC_CYAN,
        IDC_WHITE:
          begin
            iColor := LOWORD(wParam); // �ؼ�ID
            CheckRadioButton(hDlg, IDC_BLACK, IDC_WHITE, LOWORD(wParam));
            PaintTheBlock(hCtrlBlock, iColor, iFigure);
            Result := TRUE;
          end;

        IDC_RECT,
        IDC_ELLIPSE:
          begin
            iFigure := LOWORD(wParam); // �ؼ�ID
            CheckRadioButton(hDlg, IDC_RECT, IDC_ELLIPSE, LOWORD (wParam));
            PaintTheBlock(hCtrlBlock, iColor, iFigure);
            Result := TRUE;
          end;
      end;

    WM_PAINT:
      PaintTheBlock(hCtrlBlock, iColor, iFigure);
  end;
end;

   // ��������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  ps: PAINTSTRUCT;
begin
  Result := 0;
  case Msg of
    WM_COMMAND:
      case LOWORD(wParam) of
        IDM_APP_ABOUT:
          if (DialogBox(hInstance, 'AboutBox', hWnd, @AboutDlgProc) <> 0) then
            InvalidateRect(hWnd, nil, TRUE); // ѡ����'OK'�����
      end;

    WM_PAINT:
      begin
        BeginPaint(hWnd, ps); // ������䱳��(��ɫ)
        EndPaint(hWnd, ps);
        PaintWindow(hWnd, iCurrentColor, iCurrentFigure); // ����ͼ��
      end;

    WM_DESTROY:
      PostQuitMessage(0); // �˳���Ϣѭ��

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;      

const
  szAppName = 'About2';
var
  Msg: TMsg;
  hWnd: LongWord;
  WndClass: TWndClass;          
begin
 // ���ṹ��
  WndClass.style := CS_HREDRAW or CS_VREDRAW;
  WndClass.lpfnWndProc := @WndProc;
  WndClass.cbClsExtra := 0;
  WndClass.cbWndExtra := 0;
  WndClass.hInstance := hInstance;
  WndClass.hIcon := LoadIcon(hInstance, szAppName);
  WndClass.hCursor := LoadCursor(0, IDC_ARROW);
  WndClass.hbrBackground := GetStockObject(WHITE_BRUSH);
  WndClass.lpszMenuName := szAppName;
  WndClass.lpszClassName := szAppName;

 // ע�ᴰ����
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(szAppName, 'About Box Demo Program',
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
