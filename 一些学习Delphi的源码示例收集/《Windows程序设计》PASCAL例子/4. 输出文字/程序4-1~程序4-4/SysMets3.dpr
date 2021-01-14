program  SysMets3;

uses
  Windows, Messages, Math, SysMets;

  // ������Ϣ����ص�����
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
 {$J+}
  cxChar: Integer = 0;    // Сд��ĸ���
  cxCaps: Integer = 0;    // ��д��ĸ���
  cyChar: Integer = 0;    // Сд��ĸ�߶�
  cxClient: Integer = 0;  // ����ͻ������
  cyClient: Integer = 0;  // ����ͻ����߶�
  iMaxWidth: Integer = 0; // ��������ܿ��
 {$J-}
var
  X, Y, J, L, iVertPos, iHorzPos, iPaintBeg, iPaintEnd: Integer;
  hWndDc: HDC;      // �豸���ݾ��
  PS: TPaintStruct; // ��ͼ��Ϣ�ṹ
  TM: TTextMetric;  // ���������Ϣ
  SI: TScrollInfo;  // �����ṹ��
  Buffer: array [0..5] of Char; // ���������  
begin
  Result := 0;
 // ���ݲ�ͬ��Ϣ����ͬ����
  case Msg of
    WM_CREATE: begin
                 hWndDc := GetDC(hWnd);

                 GetTextMetrics(hWndDc, TM); // ȡ��Ĭ������Ķ�����Ϣ
                 cxChar := TM.tmAveCharWidth;
                 if (TM.tmPitchAndFamily and $1) = 0 // �����ȹ̶�?
                 then cxCaps := cxChar
                 else cxCaps := cxChar * 3 div 2;
                 cyChar := TM.tmHeight + TM.tmExternalLeading;
                 iMaxWidth := 40 * cxChar + 22 * cxCaps; // ������������

                 ReleaseDC(hWnd, hWndDc);
               end;

    WM_SIZE: begin
              // ��ǰ����ͻ����ߴ�
               cxClient := LOWORD(lParam);
               cyClient := HIWORD(lParam);
              // ����������ֱ������Χ�͵�ҳ��С
               SI.cbSize := SizeOf(SI);
               SI.fMask := SIF_RANGE or SIF_PAGE;
               SI.nMin := 0;
               SI.nMax := NUMLINES - 1;
               SI.nPage := cyClient div cyChar;
               SetScrollInfo(hWnd, SB_VERT, SI, TRUE);
              // �������ú��������Χ�͵�ҳ��С
               SI.cbSize := SizeOf(SI);
               SI.fMask := SIF_RANGE or SIF_PAGE;
               SI.nMin := 0;
               SI.nMax := 2 + iMaxWidth div cxChar;
               SI.nPage := cxClient div cxChar;
               SetScrollInfo(hWnd, SB_HORZ, SI, TRUE);
              (* ע��,ĳЩ�����,�������Զ�����,����nPage����nMax *)
             end;
                   
    WM_VSCROLL: begin
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
                 // �������λ��(Windows���Զ����з�Χ���ƴ���)
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

    WM_HSCROLL: begin
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
                 // �������λ��(Windows���Զ����з�Χ���ƴ���)                  
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

    WM_PAINT: begin
               // ��ʼ����
                hWndDc := BeginPaint(hWnd, PS);
               // ֻȡ����λ����Ϣ
                SI.cbSize := SizeOf(SI);
                SI.fMask := SIF_POS;
               // ȡ����ֱ����λ��
                GetScrollInfo(hWnd, SB_VERT, SI);
                iVertPos := SI.nPos;
               // ȡ�ú������λ��
                GetScrollInfo(hWnd, SB_HORZ, SI);
                iHorzPos := SI.nPos;
               // ������Ҫ�ػ�ķ�Χ(��)
                iPaintBeg := Max(0, iVertPos + PS.rcPaint.Top div cyChar);
                iPaintEnd := Min(NUMLINES - 1, iVertPos + PS.rcPaint.Bottom div cyChar);
               // ���λ��Ƹ���
                for J := iPaintBeg to iPaintEnd do
                begin
                  X := cxChar * (1 - iHorzPos); // ���㱾�����ֺ�����(���Ͻ�)
                  Y := cyChar * (J - iVertPos); // ���㱾������������(���Ͻ�)
                  TextOut(hWndDc, X, Y, SysMetrics[J].szLabel, lstrlen(SysMetrics[J].szLabel));
                  TextOut(hWndDc, X + 22 * cxCaps, Y, SysMetrics[J].szDesc, lstrlen(SysMetrics[J].szDesc));
                  SetTextAlign(hWndDc, TA_RIGHT or TA_TOP); // ����TextOut��������Ϊ���Ͻ�֮����
                  L := GetSystemMetrics(SysMetrics[J].Index);
                  TextOut(hWndDc, X + 22 * cxCaps + 40 * cxChar, Y, Buffer, wvsprintf(Buffer, '%5d', @L));
                  SetTextAlign(hWndDc, TA_LEFT or TA_TOP); // ����TextOut��������Ϊ���Ͻ�֮����
                end;
               // ��������
                EndPaint(hWnd, PS);
              end;

    WM_DESTROY: PostQuitMessage(0);  // ��ӵ�����Ϣѭ������

    else Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
  end;
end;


const
  AppName = 'SysMets3';

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
    MessageBox(0,'This program requires Windows NT!', AppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(AppName, 'Get System Metrics No. 3',
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

        


