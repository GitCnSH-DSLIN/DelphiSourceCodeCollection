program  NoPopUps;

{$R  NoPopUps.res}

uses
  Windows, Messages; 

   // ������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  IDM_FILE       = 40001;
  IDM_EDIT       = 40002;
  IDM_FILE_NEW   = 40003;
  IDM_FILE_OPEN  = 40004;
  IDM_FILE_SAVE  = 40005;
  IDM_FILE_SAVE_AS = 40006;
  IDM_MAIN       = 40007;
  IDM_EDIT_UNDO  = 40008;
  IDM_EDIT_CUT   = 40009;
  IDM_EDIT_COPY  = 40010;
  IDM_EDIT_PASTE = 40011;
  IDM_EDIT_CLEAR = 40012;   
{$J+}
  hMenuMain: LongWord = 0;
  hMenuEdit: LongWord = 0;
  hMenuFile: LongWord = 0;
{$J-}
begin
  Result := 0;
  case Msg of
    WM_CREATE:
      begin
        hMenuMain := LoadMenu(hInstance, 'MenuMain');
        hMenuFile := LoadMenu(hInstance, 'MenuFile');
        hMenuEdit := LoadMenu(hInstance, 'MenuEdit');
        SetMenu(hWnd, hMenuMain);
      end;

    WM_COMMAND:
      begin
        case LOWORD(wParam) of
          IDM_MAIN:
            SetMenu(hWnd, hMenuMain);

          IDM_FILE:
            SetMenu(hWnd, hMenuFile);

          IDM_EDIT:
            SetMenu(hWnd, hMenuEdit);

          IDM_FILE_NEW,
          IDM_FILE_OPEN,
          IDM_FILE_SAVE,
          IDM_FILE_SAVE_AS,
          IDM_EDIT_UNDO,
          IDM_EDIT_CUT,
          IDM_EDIT_COPY,
          IDM_EDIT_PASTE,
          IDM_EDIT_CLEAR:
            MessageBeep(0);

          else
            Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
        end;
      end;

    WM_DESTROY:
      begin
        SetMenu(hWnd, hMenuMain);
        DestroyMenu(hMenuFile);
        DestroyMenu(hMenuEdit);
        PostQuitMessage(0);
      end;

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;

const
  szAppName = 'NoPopUps';

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
  WndClass.hIcon := LoadIcon(0, IDI_APPLICATION);
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
  hWnd := CreateWindow(szAppName, 'No-Popup Nested Menu Demonstration',
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
