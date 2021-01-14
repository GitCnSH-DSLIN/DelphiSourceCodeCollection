program  SysMets;

uses
  Windows, Messages, Math, uSysMets;

   // ������Ϣ����ص�����
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+}
  cxChar: Integer = 0;       // Сд��ĸ���
  cxCaps: Integer = 0;       // ��д��ĸ���
  cyChar: Integer = 0;       // Сд��ĸ�߶�
  cxClient: Integer = 0;     // ����ͻ������
  cyClient: Integer = 0;     // ����ͻ����߶�
  iMaxWidth: Integer = 0;    // ��������п��
  iDeltaPerLine: Integer = 0; // ����һ������Ҫ��deltaֵ
  iAccumDelta: Integer = 0;  // Ŀǰ����ֵ 
{$J-}  
var
  X, Y, J, L, iVertPos, iHorzPos, iPaintBeg, iPaintEnd: Integer;
  Buffer: array [0..5] of Char; // ��������� 
  hWndDc: HDC;
  PS: TPaintStruct;
  TM: TTextMetric;
  SI: TScrollInfo;
  ScrollLines: DWORD;
begin
  Result := 0;
  case Msg of
    WM_CREATE:
      begin
        hWndDc := GetDC(hWnd);
        GetTextMetrics(hWndDc, TM); // ȡ�����������Ϣ
        cxChar := TM.tmAveCharWidth;
        if (TM.tmPitchAndFamily and $1) = 0 // ��ȹ̶�?
        then cxCaps := cxChar
        else cxCaps := cxChar * 3 div 2;
        cyChar := TM.tmHeight + TM.tmExternalLeading;
        iMaxWidth := 40 * cxChar + 22 * cxCaps;
        ReleaseDC(hWnd, hWndDc);

        SendMessage(hWnd, WM_SETTINGCHANGE, 0, 0); // ʹ��WM_SETTINGCHANGE��֧����ִ��
      end;

    WM_SETTINGCHANGE:
      begin                 // ÿ�ι�������, ��ֵ����'�������'����
        SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @ScrollLines, 0);
        if (ScrollLines <> 0) then
          iDeltaPerLine := WHEEL_DELTA div ScrollLines // ����һ������Ҫ��deltaֵ
        else
          iDeltaPerLine := 0 ; // ������
      end; 

    WM_SIZE:
      begin
        cxClient := LOWORD(lParam);
        cyClient := HIWORD(lParam);
           // ����ֱ������Χ�͵�ҳ��С
        SI.cbSize := SizeOf(SI);
        SI.fMask  := SIF_RANGE or SIF_PAGE;
        SI.nMin := 0;
        SI.nMax := NUMLINES - 1;
        SI.nPage := cyClient div cyChar;
        SetScrollInfo(hWnd, SB_VERT, SI, TRUE);
           // ����������Χ�͵�ҳ��С
        SI.cbSize := SizeOf(SI);
        SI.fMask := SIF_RANGE or SIF_PAGE;
        SI.nMin := 0;
        SI.nMax := 2 + iMaxWidth div cxChar;
        SI.nPage := cxClient div cxChar;
        SetScrollInfo(hWnd, SB_HORZ, SI, TRUE);
      end;

    WM_VSCROLL:
      begin
           // ȡ����ֱ����ȫ����Ϣ
        SI.cbSize := SizeOf(SI);
        SI.fMask := SIF_ALL;
        GetScrollInfo(hWnd, SB_VERT, SI);
           // �ݴ���ֱ����λ����Ϣ
        iVertPos := SI.nPos;
           // ���ֲ�ͬ�ľ�����
        case LOWORD(wParam) of
          SB_TOP       : SI.nPos := SI.nMin;
          SB_BOTTOM    : SI.nPos := SI.nMax;
          SB_LINEUP    : SI.nPos := SI.nPos-1;
          SB_LINEDOWN  : SI.nPos := SI.nPos+1;
          SB_PAGEUP    : SI.nPos := SI.nPos-SI.nPage;
          SB_PAGEDOWN  : SI.nPos := SI.nPos+SI.nPage;
          SB_THUMBTRACK: SI.nPos := SI.nTrackPos;
        end;
        SI.fMask := SIF_POS;
        SetScrollInfo(hWnd, SB_VERT, SI, TRUE);
        GetScrollInfo(hWnd, SB_VERT, SI);
           // ����ǰ��ͬ�����¹���(������Ч����)
        if (SI.nPos <> iVertPos) then
        begin
          ScrollWindow(hWnd, 0, cyChar * (iVertPos - SI.nPos),  nil, nil);
          UpdateWindow(hWnd);
        end;
      end;

    WM_HSCROLL:
      begin
           // ȡ�ú������ȫ����Ϣ
        SI.cbSize := SizeOf(SI);
        SI.fMask := SIF_ALL;
        GetScrollInfo(hWnd, SB_HORZ, SI);
           // �ݴ�������λ����Ϣ
        iHorzPos := SI.nPos;
           // ���ֲ�ͬ�ľ�����
        case LOWORD(wParam) of
          SB_LINELEFT  : SI.nPos := SI.nPos-1;
          SB_LINERIGHT : SI.nPos := SI.nPos+1;
          SB_PAGELEFT  : SI.nPos := SI.nPos-SI.nPage;
          SB_PAGERIGHT : SI.nPos := SI.nPos+SI.nPage;
          SB_THUMBPOSITION: SI.nPos := SI.nTrackPos;
        end;
        SI.fMask := SIF_POS;
        SetScrollInfo(hWnd, SB_HORZ, SI, TRUE);
        GetScrollInfo(hWnd, SB_HORZ, SI);
           // ����ǰ��ͬ�����ҹ���(������Ч����)
        if (SI.nPos <> iHorzPos) then
        begin
          ScrollWindow(hWnd, cxChar * (iHorzPos - SI.nPos), 0, nil, nil);
          UpdateWindow(hWnd);
        end;
      end;

    WM_KEYDOWN:
      begin // ת��������Ϣ
        case wParam of
          VK_HOME  :  SendMessage(hWnd, WM_VSCROLL, SB_TOP, 0);
          VK_END   :  SendMessage(hWnd, WM_VSCROLL, SB_BOTTOM, 0);
          VK_PRIOR :  SendMessage(hWnd, WM_VSCROLL, SB_PAGEUP, 0);
          VK_NEXT  :  SendMessage(hWnd, WM_VSCROLL, SB_PAGEDOWN, 0);
          VK_UP    :  SendMessage(hWnd, WM_VSCROLL, SB_LINEUP, 0);
          VK_DOWN  :  SendMessage(hWnd, WM_VSCROLL, SB_LINEDOWN, 0);
          VK_LEFT  :  SendMessage(hWnd, WM_HSCROLL, SB_PAGEUP, 0);
          VK_RIGHT :  SendMessage(hWnd, WM_HSCROLL, SB_PAGEDOWN, 0);
        end;
      end;

    WM_MOUSEWHEEL:
       begin
         if (iDeltaPerLine = 0) then Exit;
                                     // ������(2�ֽڴ���������),�����ֵ������120��-120(�������ϻ����¹���3��)
         iAccumDelta := iAccumDelta + ShortInt(HIWORD(wParam));

         while (iAccumDelta >= iDeltaPerLine) do // ������ǰ(��)����
         begin
           SendMessage(hWnd, WM_VSCROLL, SB_LINEUP, 0);
           iAccumDelta := iAccumDelta - iDeltaPerLine;
         end;

         while (iAccumDelta <= -iDeltaPerLine) do // �������(��)����
         begin
           SendMessage(hwnd, WM_VSCROLL, SB_LINEDOWN, 0);
           iAccumDelta := iAccumDelta + iDeltaPerLine ;
         end;

         (* ע��, ͨ�������iAccumDelta���˶����ٴε���0 *)
       end;
       
    WM_PAINT:
      begin
        hWndDc := BeginPaint(hWnd, PS);

        SI.cbSize := SizeOf(SI) ;
        SI.fMask := SIF_POS;
           // ȡ����ֱ����λ��
        GetScrollInfo(hWnd, SB_VERT, SI);
        iVertPos := SI.nPos ;
           // ȡ�ú������λ��
        GetScrollInfo(hWnd, SB_HORZ, SI);
        iHorzPos := SI.nPos;
           // ������Ҫ�ػ�ķ�Χ(��)
        iPaintBeg := Max(0, iVertPos + PS.rcPaint.Top div cyChar);
        iPaintEnd := Min(NUMLINES - 1, iVertPos + PS.rcPaint.Bottom div cyChar);
           // ���λ��Ƹ���
        for J := iPaintBeg to iPaintEnd do
        begin
          X := cxChar * (1 - iHorzPos); // ���к�����(���Ͻ�)
          Y := cyChar * (J - iVertPos); // ����������(���Ͻ�)
          TextOut(hWndDc, X, Y, SysMetrics[J].szLabel, lstrlen(SysMetrics[J].szLabel));
          TextOut(hWndDc, X + 22 * cxCaps, Y, SysMetrics[J].szDesc, lstrlen(SysMetrics[J].szDesc));
          SetTextAlign(hWndDc, TA_RIGHT or TA_TOP);  // ���϶���
          L := GetSystemMetrics(SysMetrics[J].Index);
          TextOut(hWndDc, X + 22 * cxCaps + 40 * cxChar , Y, Buffer, wvsprintf(Buffer, '%5d', @L));
          SetTextAlign(hWndDc, TA_LEFT or TA_TOP); // ���϶���
        end;

        EndPaint(hWnd, PS);
      end;

    WM_DESTROY:
      PostQuitMessage(0); // �˳���Ϣѭ��

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
  end;
end;


const
  AppName = 'SysMets';
  
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
    MessageBox(0,'Program requires Windows NT!', AppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(AppName, 'Get System Metrics',
                       WS_OVERLAPPEDWINDOW or WS_VSCROLL or WS_HSCROLL,
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
