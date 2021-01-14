program  EDRTest;

uses
  Windows, Messages;

function EdrCenterText(hdc: HDC; prc: PRect; pString: PChar): BOOL; stdcall;
  external '..\����21-1\EDRLib.dll' name 'EdrCenterTextA';

   // ������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  hWndDc: HDC;
  ps: TPaintStruct;
  Rect: TRect;
begin
  Result := 0;
  case (Msg) of
    WM_PAINT:
      begin
        hWndDc := BeginPaint(hWnd, ps);
        GetClientRect(hWnd, Rect);
        EdrCenterText(hWndDc, @Rect, 'This string was displayed by a DLL'); // ����
        EndPaint(hWnd, ps);
      end;

    WM_DESTROY:
      begin
        PostQuitMessage(0); // ��һ���˳���ϢWM_QUIT
      end;
      
    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;   

const
  szAppName = 'EDRTest';
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
  WndClass.lpszClassName := szAppName;

 // ע�ᴰ����
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(szAppName, 'DLL Demonstration Program',
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

(* ע: ��Ϊ��ʾ,����ֻ����Ansi��Ļ��ƺ���. *)  
end.
