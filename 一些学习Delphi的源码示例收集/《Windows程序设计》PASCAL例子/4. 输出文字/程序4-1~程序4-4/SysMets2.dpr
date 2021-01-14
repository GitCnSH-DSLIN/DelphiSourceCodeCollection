program  SysMets2;

uses
  Windows, Messages, Math, SysMets;

 // ������Ϣ����ص�����
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
 {$J+}
  cxChar: Integer = 0;       // Сд��ĸ���
  cxCaps: Integer = 0;       // ��д��ĸ���
  cyChar: Integer = 0;       // Сд��ĸ�߶�
  cyClient: Integer = 0;     // ����ͻ����߶�
  iVscrollPos: Integer = 0;  // ������ǰλ��
 {$J-}
var
  J, Y, L: Integer; // ѭ������, ���������, ת���б�(����ֻ��һ��)
  Buffer: array [0..5] of Char; // ת�����������
  hWndDc: HDC;      // �豸���ݾ��
  PS: TPaintStruct; // ��ͼ��Ϣ�ṹ
  TM: TTextMetric;  // ���������Ϣ
begin
  Result := 0;
  case Msg of
    WM_CREATE: begin
                // ȡ��Ĭ������Ķ�����Ϣ
                 hWndDc := GetDC(hWnd);
                 GetTextMetrics(hWndDc, TM);
                 cxChar := TM.tmAveCharWidth;
                 if (TM.tmPitchAndFamily and $1) = 0 // ��ȹ̶�?
                 then cxCaps := cxChar
                 else cxCaps := cxChar * 3 div 2;
                 cyChar := TM.tmHeight + TM.tmExternalLeading;
                 ReleaseDC(hWnd, hWndDc);
                // �������Χ����ʼλ��
                 SetScrollRange(hWnd, SB_VERT, 0, NUMLINES - 1, FALSE) ;
                 SetScrollPos(hWnd, SB_VERT, iVscrollPos, TRUE);
               end;

    WM_SIZE: cyClient := HIWORD(lParam); // Ŀǰ����ͻ����߶�

    WM_VSCROLL: begin
                  case LOWORD(wParam) of  // ������
                    SB_LINEUP   : Dec(iVscrollPos); // �Ϸ�һ��
                    SB_LINEDOWN : Inc(iVscrollPos); // �·�һ��
                    SB_PAGEUP   : Dec(iVscrollPos, (cyClient div cyChar)); // �Ϸ�һҳ
                    SB_PAGEDOWN : Inc(iVscrollPos, (cyClient div cyChar)); // �·�һҳ
                    SB_THUMBPOSITION: iVscrollPos := HIWORD(wParam); // ��קֹͣ
                  end;
                  iVscrollPos := Max(0, Min(iVscrollPos, NUMLINES-1)); // ��Χ����
                  if (iVscrollPos <> GetScrollPos(hWnd, SB_VERT)) then // �Ѿ��ı�
                  begin
                    SetScrollPos(hWnd, SB_VERT, iVscrollPos, TRUE); // ���ù�����λ��
                    InvalidateRect(hWnd, nil, TRUE); // ��ʾ����ʧЧ(�Ӷ�����WM_PAINT)
                  end;
                end;

    WM_PAINT: begin
                hWndDc := BeginPaint(hWnd, PS); // ��ʼ����

                for J := 0 to NUMLINES-1 do // ���Ƹ���
                begin
                  Y := cyChar * (J - iVscrollPos);   // ���㱾�����������
                  TextOut(hWndDc, 0, Y, SysMetrics[J].szLabel, lstrlen(SysMetrics[J].szLabel));
                  TextOut(hWndDc, 22 * cxCaps, Y, SysMetrics[J].szDesc, lstrlen(SysMetrics[J].szDesc));
                  SetTextAlign(hWndDc, TA_RIGHT or TA_TOP); // �˺�����������Ϊ���Ͻ�֮����
                  L := GetSystemMetrics(SysMetrics[J].Index);
                  TextOut(hWndDc, 22 * cxCaps + 40 * cxChar, Y, Buffer, wvsprintf(Buffer, '%5d', @L));
                  SetTextAlign(hWndDc, TA_LEFT or TA_TOP); // �˺�����������Ϊ���Ͻ�֮����
                end;

                EndPaint(hWnd, PS); // ��������
              end;

    WM_DESTROY: PostQuitMessage(0); // ����WM_QUIT����GetMessage����FALSE

    else Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
  end;
end;

const
  AppName = 'SysMets2'; // ��������

var
  hWnd: LongWord;       // ������
  Msg: TMsg;            // ��Ϣ�ṹ
  WndClass: TWndClass;  // ������ṹ

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
  hWnd := CreateWindow(AppName, 'Get System Metrics No. 2',
                       WS_OVERLAPPEDWINDOW or WS_VSCROLL, // ���봹ֱ������
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

        


