program  About1;

{$R  About1.res}

uses
  Windows, Messages; 

  // �Ի�����Ϣ���չ���
function AboutDlgProc(hDlg: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  Result := FALSE;
  case Msg of
    WM_INITDIALOG:
      Result := TRUE;

    WM_COMMAND:
      case LOWORD(wParam) of
        IDOK, IDCANCEL:
          begin
            EndDialog(hDlg, 0);
            Result := TRUE;
          end;
      end;
  end;
end;

   // ��������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  IDM_APP_ABOUT = 40001;
begin
  Result := 0;
  case Msg of
//  WM_CREATE:
//    hInstance = ((LPCREATESTRUCT) lParam)->hInstance ;
//  ע: SysInit.hInstance�����ȱ���ʼ��Ϊ��ģ����

    WM_COMMAND:
      if (LOWORD(wParam) = IDM_APP_ABOUT) then
        DialogBox(hInstance, 'AboutBox', hWnd, @AboutDlgProc)
      else
        Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����

    WM_DESTROY:
      PostQuitMessage(0); // �˳�ѭ��

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;      

const
  szAppName = 'About1';
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
