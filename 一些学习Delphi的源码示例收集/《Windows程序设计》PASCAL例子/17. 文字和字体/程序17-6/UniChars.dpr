program UniChars;

{$R UniChars.Res}

uses
  Windows, Messages, CommDlg, Math;

   // �������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+}
  cf: TChooseFont = ();
  iPage: Integer = 0;
  lf: TLogFont = ();
{$J-}
  IDM_FONT = 40001;
var
  hdcWnd: HDC;
  cxChar, cyChar, x, y, i, cxLabels, List: Integer;    
  ps: TPaintStruct;
  Size: TSize;        
  szBuffer: array[0..8] of Char;
  tm: TTextMetric;
  ch: WideChar;
begin
  Result := 0;
  case Msg of
    WM_CREATE:
      begin
        hdcWnd := GetDC(hWnd);
        lf.lfHeight := - GetDeviceCaps(hdcWnd, LOGPIXELSY) div 6;  // 12 points
        lstrcpy(lf.lfFaceName, 'Lucida Sans Unicode');
        ReleaseDC(hWnd, hdcWnd) ;

        cf.lStructSize := SizeOf(TChooseFont);
        cf.hwndOwner := hWnd;
        cf.lpLogFont := @lf;
        cf.Flags := CF_INITTOLOGFONTSTRUCT or CF_SCREENFONTS;
        
        SetScrollRange(hWnd, SB_VERT, 0, 255, FALSE);
        SetScrollPos(hWnd, SB_VERT, iPage, TRUE);
      end;

    WM_COMMAND:
      begin
        case wParam of
          IDM_FONT:
            begin
              if (ChooseFont(cf)) then // ѡ����������
                InvalidateRect(hWnd, nil, TRUE); // ˢ�´���(�ػ�)
            end;
        end;
      end;

    WM_VSCROLL:
      begin
        case LOWORD(wParam) of
          SB_LINEUP:   Dec(iPage);
          SB_LINEDOWN: Inc(iPage);
          SB_PAGEUP:   Dec(iPage, 16);
          SB_PAGEDOWN: Inc(iPage, 16);
          SB_THUMBPOSITION: iPage := HIWORD(wParam);
          else Exit;
        end;
        iPage := Max(0, Min(iPage, 255)); // ��Χ����
        SetScrollPos(hWnd, SB_VERT, iPage, TRUE);
        InvalidateRect(hWnd, nil, TRUE);
      end;

    WM_PAINT:
      begin
        hdcWnd := BeginPaint(hWnd, ps);

        SelectObject(hdcWnd, CreateFontIndirect(lf)); // ������
        GetTextMetrics(hdcWnd, tm); // ����ߴ�
        cxChar := tm.tmMaxCharWidth;
        cyChar := tm.tmHeight + tm.tmExternalLeading;
        cxLabels := 0;
        for i := 0 to 15 do
        begin
          wvsprintf(szBuffer, ' 000%1X: ', @i);
          GetTextExtentPoint(hdcWnd, szBuffer, 7, Size);
          cxLabels := Max(cxLabels, Size.cx); // �����
        end;
        for y := 0 to 15 do
        begin
          List := 16 * iPage + y;
          wvsprintf(szBuffer, ' %03X_: ', @List);
          TextOut(hdcWnd, 0, y * cyChar, szBuffer, 7);
          for x := 0 to 15 do
          begin
            ch := WideChar(256 * iPage + 16 * y + x);
            TextOutW(hdcWnd, x * cxChar + cxLabels, y * cyChar, @ch, 1);
          end;
        end;
        DeleteObject(SelectObject(hdcWnd, GetStockObject(SYSTEM_FONT)));

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
  szAppName = 'UniChars';
  
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
  WndClass.lpszMenuName := szAppName;
  WndClass.lpszClassName := szAppName;

 // ע�ᴰ����
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(szAppName, 'Unicode Characters',
                       WS_OVERLAPPEDWINDOW or WS_VSCROLL,
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
