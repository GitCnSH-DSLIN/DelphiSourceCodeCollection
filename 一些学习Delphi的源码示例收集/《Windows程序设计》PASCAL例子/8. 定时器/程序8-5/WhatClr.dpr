program  WhatClr;

uses
  Windows, Messages;

  // ��Ϣ����ص�����   
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  ID_TIMER = 1; // ��ʱ��ID
  {$J+}
  ClrCurr: COLORREF = 0; // ��ǰ��ɫ
  ClrLast: COLORREF = 0; // �ϴ���ɫ
  hdcScreen: HDC = 0; // ��Ļ'�豸���ݾ��'
  {$J-}
var
  hWndDc: HDC; // ����ͻ���'�豸���ݾ��'
  Rect: TRect; // ����ͻ����ߴ緶Χ
  Pt: TPoint;  // ��ǰ���������Ļλ��
  Ps: TPaintStruct;
  Buffer: array[0..8] of Char; // ���������
  List: array[0..2] of Integer; // ת��������
begin
  Result := 0;
  case Msg of
    WM_CREATE:
      begin
        hdcScreen := CreateDC('DISPLAY', nil, nil, nil); // ȡ�� ��Ļ'�豸���ݾ��'
        SetTimer(hWnd, ID_TIMER, 1000, nil); // ��װ��ʱ��, ���Ϊһ��.
      end;
      
    WM_TIMER:
      begin
        GetCursorPos(Pt); // ��굱ǰλ��
        ClrCurr := GetPixel(hdcScreen, Pt.X, Pt.Y); // ȡ��ɫ
        SetPixel(hdcScreen, Pt.X, Pt.Y, 0); // ���ڵ�
        if (ClrCurr <> ClrLast) then
        begin
          ClrLast := ClrCurr;
          InvalidateRect(hWnd, nil, FALSE);
        end;
      end;
      
    WM_PAINT:
      begin
        hWndDc := BeginPaint(hWnd, Ps);

        GetClientRect(hWnd, Rect);
        List[0] := GetRValue(ClrCurr);
        List[1] := GetGValue(ClrCurr);
        List[2] := GetBValue(ClrCurr);
        wvsprintf(Buffer, '  %02X %02X %02X  ', @List[0]);
        DrawText(hWndDc, Buffer, -1, Rect, DT_SINGLELINE or DT_CENTER or DT_VCENTER);

        EndPaint(hWnd, Ps);
      end;
      
    WM_DESTROY:
      begin
        KillTimer(hWnd, ID_TIMER); // ɾ����ʱ��
        DeleteDC(hdcScreen); // �ͷ� ��Ļ'�豸���ݾ��'
        PostQuitMessage(0);  // ��WM_QUITʹGetMessage����FALSE
      end;
      
    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
  end;
end;

   // ����������ʵĳߴ�
procedure FindWindowSize(var cxWindow, cyWindow: Integer);
var
  hdcScreen: HDC;
  TM: TTextMetric;
begin
  hdcScreen := CreateIC('DISPLAY', nil, nil, nil); // ȡ�� ��Ļ'�豸���ݾ��'
  GetTextMetrics(hdcScreen, TM); // ȡ�����������Ϣ
  cxWindow := 2 * GetSystemMetrics(SM_CXBORDER) +  12 * TM.tmAveCharWidth;
  cyWindow := 2 * GetSystemMetrics(SM_CYBORDER) + GetSystemMetrics(SM_CYCAPTION) + 2 * tm.tmHeight;
  DeleteDC(hdcScreen); // �ͷ� ��Ļ'�豸���ݾ��'
end;

const
  AppName = 'WhatClr';
var
  hWnd: LongWord;
  cxWindow, cyWindow: Integer;
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
  FindWindowSize(cxWindow, cyWindow);
  hWnd := CreateWindow(AppName, 'What Color',
                       WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU or WS_BORDER,
                       CW_USEDEFAULT, CW_USEDEFAULT, cxWindow, cyWindow,
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
