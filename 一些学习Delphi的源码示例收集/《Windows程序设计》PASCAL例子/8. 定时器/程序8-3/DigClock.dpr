program  DigClock;

uses
  Windows, Messages;

  // ��������API�Ա����  { var -> const }
function Polygon(DC: HDC; const Points; Count: Integer): BOOL; stdcall; external gdi32 name 'Polygon';

  // ����һ��ʮ����λ
procedure DisplayDigit(hdc: HDC; iNumber: Integer);
const
  fSevenSegment: array[0..9] of array[0..6] of Boolean = // 0~9 �߶���
  ( (TRUE, TRUE, TRUE, FALSE, TRUE, TRUE, TRUE),
    (FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE),
    (TRUE, FALSE, TRUE, TRUE, TRUE, FALSE, TRUE),
    (TRUE, FALSE, TRUE, TRUE, FALSE, TRUE, TRUE),
    (FALSE, TRUE, TRUE, TRUE, FALSE, TRUE, FALSE),
    (TRUE, TRUE, FALSE, TRUE, FALSE, TRUE, TRUE),
    (TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE),
    (TRUE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE),
    (TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE),
    (TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, TRUE) );
  ptSegment: array[0..6] of array[0..5] of TPoint = // ��������������
  ( ( (X: 7; Y: 6), (X: 11; Y: 2), (X: 31; Y: 2), (X: 35; Y: 6), (X: 31; Y: 10), (X: 11; Y: 10) ),
    ( (X: 6; Y: 7), (X: 10; Y: 11), (X: 10; Y: 31), (X: 6; Y: 35), (X: 2; Y: 31), (X: 2; Y: 11) ),
    ( (X: 36; Y: 7), (X: 40; Y: 11), (X: 40; Y: 31), (X: 36; Y: 35), (X: 32; Y: 31), (X: 32; Y: 11) ),
    ( (X: 7; Y: 36), (X: 11; Y: 32), (X: 31; Y: 32), (X: 35; Y: 36), (X: 31; Y: 40), (X: 11; Y: 40) ),
    ( (X: 6; Y: 37), (X: 10; Y: 41), (X: 10; Y: 61), (X: 6; Y: 65), (X: 2; Y: 61), (X: 2; Y: 41) ),
    ( (X: 36; Y: 37), (X: 40; Y: 41), (X: 40; Y: 61), (X: 36; Y: 65), (X: 32; Y: 61), (X: 32; Y: 41) ),
    ( (X: 7; Y: 66), (X: 11; Y: 62), (X: 31; Y: 62), (X: 35; Y: 66), (X: 31; Y: 70), (X: 11; Y: 70) ) );
var
  iSeg : Integer;
begin
  for iSeg := 0 to 6 do
    if fSevenSegment[iNumber][iSeg] then
      Polygon(hdc, ptSegment[iSeg][0], 6);
end;

  // ��������ʮ����λ                                  { ��λ����0 }
procedure DisplayTwoDigits(hdc: HDC; iNumber: Integer; fSuppress: Boolean);
begin
  if (not fSuppress)or(iNumber div 10 <> 0) then DisplayDigit(hdc, iNumber div 10); // ����ʮλ����
  OffsetWindowOrgEx(hdc, -42, 0, nil); // ԭ������
  DisplayDigit(hdc, iNumber mod 10); // ���Ƹ�λ����
  OffsetWindowOrgEx(hdc, -42, 0, nil); // ԭ������
end;

  // ����ð��
procedure DisplayColon(hdc: HDC);
const
  ptColon: array[0..1] of array[0..3] of TPoint =
  (   ( (X: 2; Y: 21), (X: 6; Y: 17), (X: 10; Y: 21), (X: 6; Y: 25) ),
      ( (X: 2; Y: 51), (X: 6; Y: 47), (X: 10; Y: 51), (X: 6; Y: 55) )   );
begin
  Polygon(hdc, ptColon[0][0], 4);
  Polygon(hdc, ptColon[1][0], 4);
  OffsetWindowOrgEx(hdc, -12, 0, nil); // ԭ������
end;

  // ���Ƶ�ǰʱ��               
procedure DisplayTime(hdc: HDC; f24Hour, fSuppress: Boolean);
var
 st: TSystemTime;
begin
  GetLocalTime(st);
  if f24Hour then
    DisplayTwoDigits(hdc, st.wHour, fSuppress)
  else begin
    st.wHour := st.wHour mod 12;
    if (st.wHour = 0) then st.wHour := 12;
    DisplayTwoDigits(hdc, st.wHour, fSuppress);
  end;               
  DisplayColon(hdc);
  DisplayTwoDigits(hdc, st.wMinute, FALSE);
  DisplayColon(hdc);
  DisplayTwoDigits(hdc, st.wSecond, FALSE);
end; 

  // ������Ϣ�������   
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  ID_TIMER = 1; // ��ʱ��ID
  {$J+}
  f24Hour: Boolean = FALSE;
  fSuppress: Boolean = FALSE;
  hBrushRed: HBRUSH = 0;
  cxClient: Integer = 0;
  cyClient: Integer = 0;
  {$J-}
var
  hWndDc: HDC;
  PS: TPaintStruct;
  Buffer: array[0..1] of Char;
begin
  Result := 0;

  case Msg of
    WM_CREATE:
      begin
        hBrushRed := CreateSolidBrush(RGB(255, 0, 0));  // ������ˢ
        SetTimer(hWnd, ID_TIMER, 1000, nil); // ��װʱ��
        SendMessage(hWnd, WM_SETTINGCHANGE, 0, 0); // ʹWM_SETTINGCHANGE��ִ֧��
      end;

    WM_SETTINGCHANGE:
      begin
        GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_ITIME, Buffer, 2); // ʹ��24Сʱ��ʽ
        f24Hour := (Buffer[0] = '1');
        GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_ITLZERO, Buffer, 2); // ��ֹСʱǰ��0
        fSuppress := (Buffer[0] = '0');
        InvalidateRect(hWnd, nil, TRUE);
      end;

    WM_SIZE:
      begin
        cxClient := LOWORD(lParam);
        cyClient := HIWORD(lParam);
      end;


    WM_TIMER:
      InvalidateRect(hWnd, nil, TRUE); // ˢ��

    WM_PAINT:
      begin
        hWndDc := BeginPaint(hWnd, PS);

        SetMapMode(hWndDc, MM_ISOTROPIC);
        SetWindowExtEx(hWndDc, 276, 72, nil); // ���ڳߴ�
        SetViewportExtEx(hWndDc, cxClient, cyClient, nil); // �ӿڳߴ�
        SetWindowOrgEx(hWndDc, 138, 36, nil); // ����ԭ��
        SetViewportOrgEx(hWndDc, cxClient div 2, cyClient div 2, nil); // �ӿ�ԭ��
        SelectObject(hWndDc, GetStockObject(NULL_PEN));
        SelectObject(hWndDc, hBrushRed);
        DisplayTime(hWndDc, f24Hour, fSuppress);
        
        EndPaint(hWnd, PS);
      end;

    WM_DESTROY:
      begin
        PostQuitMessage(0); // ����GetMessage����FALSE
        KillTimer(hWnd, ID_TIMER); // ɾ����ʱ��
        DeleteObject(hBrushRed); // ɾ����ˢ����
      end;

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
  end;
end;


const
  AppName = 'DigClock';

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
  hWnd := CreateWindow(AppName, 'Digital Clock',
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
