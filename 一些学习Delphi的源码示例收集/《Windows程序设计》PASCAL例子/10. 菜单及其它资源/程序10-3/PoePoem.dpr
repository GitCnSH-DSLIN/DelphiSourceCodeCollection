program  PoePoem;

{$R PoePoem.res}

uses
  Windows, Messages, Math;

   // ������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+}
  pText: PChar = nil; // ��Դ�ַ�����ַ
  lText: Integer = 0; // ��Դ�ַ�������
  hResource: HGLOBAL = 0; // ��Դ�ڴ������
  hScroll: LongWord = 0; // �������ؼ����
  iPosition: Integer = 0; // ��������ǰλ��
  cxChar: Integer = 0; // �ַ����
  cyChar: Integer = 0; // �ַ��߶�
  cyClient: Integer = 0; // ����߶�
  iNumLines: Integer = 0; // �ı�����
  xScroll: Integer = 0; // ���������
{$J-}
var
  hWndDc: HDC;
  ps: PAINTSTRUCT;
  Rect: TRect;
  tm: TTextMetric;
begin
  Result := 0;
 // ���ֲ�ͬ����Ϣ
  case Msg of
    WM_CREATE:
      begin
        hWndDc := GetDC(hWnd);
        GetTextMetrics(hWndDc, tm); // ���������Ϣ
        cxChar := tm.tmAveCharWidth;
        cyChar := tm.tmHeight + tm.tmExternalLeading;
        ReleaseDC(hWnd, hWndDc);

        xScroll := GetSystemMetrics(SM_CXVSCROLL); // ������ ..
        hScroll := CreateWindow('scrollbar', nil,
                                WS_CHILD or WS_VISIBLE or SBS_VERT,
                                0, 0, 0, 0, hWnd, 1, hInstance, nil);

        hResource := LoadResource(hInstance, FindResource(hInstance, 'AnnabelLee', 'TEXT'));
        pText := LockResource(hResource); // ��Դ��ַ
        while (pText^ <> '\') and (pText^ <> #0) do
        begin
          if (pText^ = #13) then Inc(iNumLines);
          Inc(lText, AnsiNext(pText)-pText);
          pText := AnsiNext(pText);
        end;

        SetScrollRange(hScroll, SB_CTL, 0, iNumLines, FALSE);
        SetScrollPos(hScroll, SB_CTL, 0, FALSE);
      end;

    WM_SIZE:
      begin
        cyClient := HIWORD(lParam);
        MoveWindow(hScroll, LOWORD(lParam)-xScroll, 0, xScroll, cyClient, TRUE);
        SetFocus(hWnd);
      end;

    WM_SETFOCUS:
      begin
        SetFocus(hScroll);
      end;

    WM_VSCROLL:
      begin
        case LOWORD(wParam) of // ��������
          SB_TOP:
            iPosition := 0;

          SB_BOTTOM:
            iPosition := iNumLines;

          SB_LINEUP:
            Dec(iPosition);

          SB_LINEDOWN:
            Inc(iPosition);

          SB_PAGEUP:
            Dec(iPosition, cyClient div cyChar);

          SB_PAGEDOWN:
            Inc(iPosition, cyClient div cyChar);

          SB_THUMBPOSITION:
            iPosition := HIWORD(wParam);
        end;
        iPosition := Max(0, Min(iPosition, iNumLines)); // ��Χ����
        if (iPosition <> GetScrollPos(hScroll, SB_CTL)) then // �仯
        begin
          SetScrollPos(hScroll, SB_CTL, iPosition, TRUE); // ��λ��
          InvalidateRect(hWnd, nil, TRUE); // ˢ��(����WM_PAINT)
        end; 
      end;
      
    WM_PAINT:
      begin
        hWndDc := BeginPaint(hWnd, ps);

        pText := LockResource(hResource);
        GetClientRect(hWnd, Rect);
        Inc(Rect.Left, cxChar);
        Inc(Rect.Top, cyChar * (1 - iPosition));
        DrawTextA(hWndDc, PText, lText, Rect, DT_EXTERNALLEADING);

        EndPaint(hWnd, ps);
      end;


    WM_DESTROY:
      begin
        PostQuitMessage(0); // ��һ��WM_QUIT��Ϣ����Ϣ����
        FreeResource(hResource);  // �ͷ�
      end;

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;    

const
  IDS_APPNAME = 1;
  IDS_CAPTION = 2;
  IDS_ERRMSG = 3;

var
  hWnd: LongWord;
  Msg: TMsg;
  WndClass: TWndClass;
  szAppName: array[0..16] of Char;
  szCaption: array[0..64] of Char;
  szErrMsg: array[0..64] of Char;

begin
 // װ���ַ�����Դ
  LoadString(hInstance, IDS_APPNAME, szAppName, 16);
  LoadString(hInstance, IDS_CAPTION, szCaption, 64);

 // ���ṹ��
  WndClass.style := CS_HREDRAW or CS_VREDRAW;
  WndClass.lpfnWndProc := @WndProc;
  WndClass.cbClsExtra := 0;
  WndClass.cbWndExtra := 0;
  WndClass.hInstance := hInstance;
  WndClass.hIcon := LoadIcon(hInstance, szAppName);
  WndClass.hCursor := LoadCursor(0, IDC_ARROW);
  WndClass.hbrBackground := GetStockObject(WHITE_BRUSH);
  WndClass.lpszMenuName := nil;
  WndClass.lpszClassName := szAppName;

 // ע�ᴰ����
  if (RegisterClass(WndClass) = 0) then
  begin
    LoadStringA(hInstance, IDS_APPNAME, szAppName, 16);
    LoadStringA(hInstance, IDS_ERRMSG, szErrMsg, 64);
    MessageBox(0, szErrMsg, szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(szAppName, szCaption,
                       WS_OVERLAPPEDWINDOW or WS_CLIPCHILDREN,
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

(*  ע1: �ƺ�LockResource�õ��ĵ�ַ������д,�����Ҽ��˸����ȱ��� *)
(*  ע2: Windows.pas��LoadString����ΪLoadStringA,�϶��������� *)
end.
