program  Blowup;

{$R  Blowup.res}

uses
  Windows, Messages, Math;

  // ��Ļĳ������ɫȡ��
procedure InvertBlock(hWndScr, hWnd: HWND; ptBeg, ptEnd: TPoint);
var
  hdcScr: HDC;
begin
  hdcScr := GetDCEx(hWndScr, 0, DCX_CACHE or DCX_LOCKWINDOWUPDATE);
  ClientToScreen(hWnd, ptBeg);
  ClientToScreen(hWnd, ptEnd);
  PatBlt(hdcScr, ptBeg.x, ptBeg.y, ptEnd.x - ptBeg.x, ptEnd.y - ptBeg.y, DSTINVERT);
  ReleaseDC(hWndScr, hdcScr);
end;

  // ���Ƴ�һ���µ�λͼ
function CopyBitmap(hBitmapSrc: HBITMAP): HBITMAP;
var
  Bitmap: TBitmap;
  hBitmapDst: HBITMAP;
  hdcSrc, hdcDst: HDC;
begin
  GetObject(hBitmapSrc, SizeOf(TBitmap), @Bitmap);
  hBitmapDst := CreateBitmapIndirect(Bitmap);
  hdcSrc := CreateCompatibleDC(0);
  hdcDst := CreateCompatibleDC(0);
  SelectObject(hdcSrc, hBitmapSrc);
  SelectObject(hdcDst, hBitmapDst);
  BitBlt(hdcDst, 0, 0, Bitmap.bmWidth, Bitmap.bmHeight, hdcSrc, 0, 0, SRCCOPY);
  DeleteDC(hdcSrc);
  DeleteDC(hdcDst);
  Result := hBitmapDst;
end;

   // ������Ϣ����ص�����
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  IDM_EDIT_CUT = 40001;  // �˵���(���ݼ�)ID
  IDM_EDIT_COPY = 40002;
  IDM_EDIT_PASTE = 40003;
  IDM_EDIT_DELETE = 40004;
{$J+}
  bCapturing: Boolean = FALSE; // �������(�������)
  bBlocking: Boolean = FALSE; // �Ҽ�����(��ɫ��Ļ)
  hBitmap: LongWord = 0;
  hWndScr: LongWord = 0;
  ptBeg: TPoint = (X: 0; Y: 0);
  ptEnd: TPoint = (X: 0; Y: 0);
{$J-}   
var
  bm: TBitmap;   
  hBitmapClip: LongWord;
  hdcWnd, hdcMem: HDC;
  iEnable: Integer;
  ps: TPaintStruct;
  Rect: TRect;
begin
  Result := 0;
  case Msg of
    WM_LBUTTONDOWN:
      begin
        if (not bCapturing) then
        begin
          hWndScr := GetDesktopWindow();
          if LockWindowUpdate(hWndScr) then
          begin
            bCapturing := TRUE;
            SetCapture(hWnd); // ���������Ϣ���������������
            SetCursor(LoadCursor(0, IDC_CROSS)); // 'ʮ��'���
          end else
            MessageBeep(0); // ��������
        end;
      end;

    WM_RBUTTONDOWN:
      begin
        if (bCapturing) then
        begin
          bBlocking := TRUE;
          ptBeg.x := LOWORD(lParam);
          ptBeg.y := HIWORD(lParam);
          ptEnd := ptBeg;
          InvertBlock(hWndScr, hWnd, ptBeg, ptEnd);
        end;
      end;

    WM_MOUSEMOVE:
      begin
        if (bBlocking) then
        begin
          InvertBlock(hWndScr, hWnd, ptBeg, ptEnd); // �ָ�
          ptEnd.x := LOWORD(lParam);
          ptEnd.y := HIWORD(lParam);
          InvertBlock(hWndScr, hWnd, ptBeg, ptEnd); // ��ת
        end;
      end;

    WM_LBUTTONUP,
    WM_RBUTTONUP:
      begin
        if bBlocking then
        begin
          InvertBlock(hWndScr, hWnd, ptBeg, ptEnd); // �ָ�
          ptEnd.x := LOWORD(lParam);
          ptEnd.y := HIWORD(lParam);
          if (hBitmap <> 0) then // ɾ��ԭ��λͼ
          begin
            DeleteObject(hBitmap);
            hBitmap := 0;
          end;
          hdcWnd := GetDC(hWnd);
          hdcMem := CreateCompatibleDC(hdcWnd);
          hBitmap := CreateCompatibleBitmap(hdcWnd, abs(ptEnd.x - ptBeg.x), abs(ptEnd.y - ptBeg.y));
          SelectObject(hdcMem, hBitmap);
          StretchBlt(hdcMem, 0, 0, abs(ptEnd.x - ptBeg.x), abs(ptEnd.y - ptBeg.y), // ����ͼ��
            hdcWnd, ptBeg.x, ptBeg.y, ptEnd.x - ptBeg.x,  ptEnd.y - ptBeg.y, SRCCOPY);
          DeleteDC(hdcMem);
          ReleaseDC(hWnd, hdcWnd);
          InvalidateRect(hWnd, nil, TRUE);
        end;
        if (bBlocking or bCapturing) then
        begin
          bBlocking := FALSE;
          bCapturing := FALSE;
          SetCursor(LoadCursor(0, IDC_ARROW)); // ��ͨ���
          ReleaseCapture(); // ����������
          LockWindowUpdate(0);
        end;
      end;

    WM_INITMENUPOPUP:
      begin
        iEnable := IfThen(IsClipboardFormatAvailable(CF_BITMAP), MF_ENABLED , MF_GRAYED);
        EnableMenuItem(wParam, IDM_EDIT_PASTE, iEnable); // �����庬��λͼʱ����

        iEnable := IfThen(hBitmap <> 0, MF_ENABLED, MF_GRAYED); // ������λͼʱ����
        EnableMenuItem(wParam, IDM_EDIT_CUT, iEnable);
        EnableMenuItem(wParam, IDM_EDIT_COPY, iEnable);
        EnableMenuItem(wParam, IDM_EDIT_DELETE, iEnable);
      end;

    WM_COMMAND:
      begin
        case LOWORD(wParam) of
          IDM_EDIT_CUT,
          IDM_EDIT_COPY:
            begin
              if (hBitmap <> 0) then
              begin
                hBitmapClip := CopyBitmap(hBitmap);
                OpenClipboard(hWnd);
                EmptyClipboard();
                SetClipboardData(CF_BITMAP, hBitmapClip);
                CloseClipboard();
              end;
              if (LOWORD(wParam) = IDM_EDIT_CUT) then
                WndProc(hWnd, WM_COMMAND, IDM_EDIT_DELETE, 0);
            end;

          IDM_EDIT_DELETE:
            begin
              if (hBitmap <> 0) then
              begin
                DeleteObject(hBitmap);
                hBitmap := 0;
              end;
              InvalidateRect(hWnd, nil, TRUE);
            end;

          IDM_EDIT_PASTE:
            begin
              if (hBitmap <> 0) then
              begin
                DeleteObject(hBitmap);
                hBitmap := 0;
              end;
              OpenClipboard(hWnd);
              hBitmapClip := GetClipboardData(CF_BITMAP);
              if (hBitmapClip <> 0) then
                hBitmap := CopyBitmap(hBitmapClip);
              CloseClipboard();
              InvalidateRect(hWnd, nil, TRUE);
            end;
        end;
      end;

    WM_PAINT:
      begin
        hdcWnd := BeginPaint(hWnd, ps);

        if (hBitmap <> 0) then
        begin
          GetClientRect(hWnd, Rect);
          hdcMem := CreateCompatibleDC(hdcWnd);
          SelectObject(hdcMem, hBitmap);
          GetObject(hBitmap, SizeOf(TBitmap), @bm);
          SetStretchBltMode(hdcWnd, COLORONCOLOR);
          StretchBlt(hdcWnd, 0, 0, Rect.Right, Rect.Bottom, hdcMem,
            0, 0, bm.bmWidth, bm.bmHeight, SRCCOPY);
          DeleteDC(hdcMem);
        end;
        
        EndPaint(hWnd, ps);
      end;

    WM_DESTROY:
      begin
        if (hBitmap <> 0) then DeleteObject(hBitmap);
        PostQuitMessage(0); // �˳�
      end;

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;

const
  szAppName = 'Blowup';
var
  hAccel, hWnd: LongWord;
  Msg: TMsg;
  WndClass: TWndClass;
begin
 // ע�ᴰ����
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
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;
 // ��������
  hWnd := CreateWindow(szAppName, 'Blow-Up Mouse Demo',
                       WS_OVERLAPPEDWINDOW,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       0, 0, hInstance, nil);
 // ��ʾ����
  ShowWindow(hWnd, CmdShow);
  UpdateWindow(hWnd);
 // �����ݼ� 
  hAccel := LoadAccelerators(hInstance, szAppName);    
 // ��Ϣѭ��
  while GetMessage(Msg, 0, 0, 0) do
  begin
    if (TranslateAccelerator(hWnd, hAccel, Msg) = 0) then
    begin
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end;
  end;
end.
