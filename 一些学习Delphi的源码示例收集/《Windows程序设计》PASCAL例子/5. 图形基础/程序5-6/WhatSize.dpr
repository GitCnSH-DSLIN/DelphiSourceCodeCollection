program  WhatSize;

uses
  Windows, Messages;

  // ������Ϣ����ص�����
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
    // ���Ƶ���������Ϣ 
  procedure Show(hWin, hDc, xText, yText, iMapMode: Integer; szMapMode: PChar);
  var
    Buffer: array[0..60] of Char;     // ���(ת������ַ���)������
    List: array[0..4] of LongWord; // ��(wvsprintf)ת���б�
    Rect: TRect;
  begin
    SaveDC(hDc); // �����豸����
    SetMapMode(hDc, iMapMode); // �趨�µ�ӳ��ʽ
    GetClientRect(hWin, Rect); // ȡ����ʾ��������
    DPtoLP(hDc, Rect, 2); // ת��Ϊ�߼�����
    RestoreDC(hDc, -1); // �ָ��豸����(����ԭӳ��ʽ)
    List[0] := LongWord(szMapMode); // ��дת���б� ..
    List[1] := Rect.Left;
    List[2] := Rect.Right;
    List[3] := Rect.Top;
    List[4] := Rect.Bottom;            { ת�������Buffer����TextOut��� }
    TextOut(hDc, xText, yText, Buffer, wvsprintf(Buffer, '%-20s %7d %7d %7d %7d', @List));
  end;
const
{$J+}
  cxChar: Integer = 0; // ������
  cyChar: Integer = 0; // ����߶�
{$J-}
 Heading = 'Mapping Mode            Left   Right     Top  Bottom';
 UndLine = '------------            ----   -----     ---  ------';
var
  hWndDc: HDC;
  PS: TPaintStruct;
  TM: TTextMetric;
begin
  Result := 0;
  case Msg of
    WM_CREATE   :  begin
                     hWndDc := GetDC(hWnd);
                                                        // �ȿ�����
                     SelectObject(hWndDc, GetStockObject(SYSTEM_FIXED_FONT));
                     GetTextMetrics(hWndDc, TM);  // ȡ�����������Ϣ
                     cxChar := TM.tmAveCharWidth;
                     cyChar := TM.tmHeight + TM.tmExternalLeading;

                     ReleaseDC(hWnd, hWndDc);
                   end;

    WM_PAINT    :  begin
                     hWndDc := BeginPaint(hWnd, PS);
                                                        // �ȿ�����
                     SelectObject(hWndDc, GetStockObject(SYSTEM_FIXED_FONT));
                    // ���� xViewPort = xWindow * cxChar , yViewPort = yWindow * cyChar
                     SetMapMode(hWndDc, MM_ANISOTROPIC);
                     SetWindowExtEx(hWndDc, 1, 1, nil);
                     SetViewportExtEx(hWndDc, cxChar, cyChar, nil);
                    // �������, ��������кż���
                     TextOut(hWndDc, 1, 1, Heading, lstrlen(Heading));
                     TextOut(hWndDc, 1, 2, UndLine, lstrlen(UndLine));
                     Show(hWnd, hWndDc, 1, 3, MM_TEXT, 'TEXT (pixels)');
                     Show(hWnd, hWndDc, 1, 4, MM_LOMETRIC, 'LOMETRIC (.1 mm)');
                     Show(hWnd, hWndDc, 1, 5, MM_HIMETRIC, 'HIMETRIC (.01 mm)');
                     Show(hWnd, hWndDc, 1, 6, MM_LOENGLISH, 'LOENGLISH (.01 in)');
                     Show(hWnd, hWndDc, 1, 7, MM_HIENGLISH, 'HIENGLISH (.001 in)');
                     Show(hWnd, hWndDc, 1, 8, MM_TWIPS, 'TWIPS (1/1440 in)');

                     EndPaint(hWnd, PS);
                   end;

    WM_DESTROY  :  PostQuitMessage(0); // �˳���Ϣѭ��

    else Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���  
  end;
end;


const  
  AppName = 'WhatSize';

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
    MessageBox(0, 'This Program requires Windows NT!', AppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(AppName, 'What Size is the Window?',
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
