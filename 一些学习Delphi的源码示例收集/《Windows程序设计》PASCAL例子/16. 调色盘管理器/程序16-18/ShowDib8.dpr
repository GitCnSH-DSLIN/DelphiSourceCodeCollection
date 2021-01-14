program  ShowDib8;

{$R  ShowDib8.res}

uses
  Windows, Messages, CommDlg, Math,
  PackeDib in '..\����16-12\PackeDib.pas';

const
  szAppName = 'ShowDib8';

  // ������Ϣ������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  IDM_FILE_OPEN = 40001;
  szFilter = 'Bitmap Files (*.BMP)'#0'*.bmp'#0'All Files (*.*)'#0'*.*'#0#0;
{$J+}
  hBitmap: LongWord = 0;
  hPalette: LongWord = 0;
  cxClient: Integer = 0;
  cyClient: Integer = 0;
  ofn: TOpenFilename =
    (
    lStructSize: SizeOf(TOpenFilename);
    hwndOwner: 0; // ��������,����
    hInstance: 0;
    lpstrFilter: szFilter;
    lpstrCustomFilter: nil;
    nMaxCustFilter: 0;
    nFilterIndex: 0;
    lpstrFile: nil; // szFileName,����
    nMaxFile: MAX_PATH;
    lpstrFileTitle: nil; // szTitleName,����
    nMaxFileTitle: MAX_PATH;
    lpstrInitialDir: nil;
    lpstrTitle: nil;
    Flags: 0;
    nFileOffset: 0;
    nFileExtension: 0;
    lpstrDefExt: 'bmp';
    lCustData: 0;
    lpfnHook: nil;
    lpTemplateName: nil;
    );
  szFileName: PChar = nil;
  szTitleName: PChar = nil;
  pBits: PByte = nil;  
{$J-}
var
  Bitmap: TBitmap;
  pPackedDib: PBitmapInfo;
  hdcWnd, hdcMem: HDC;
  ps: TPaintStruct;
begin
  Result := 0;
  case Msg of
    WM_CREATE:
      begin
        GetMem(szFileName, MAX_PATH);
        GetMem(szTitleName, MAX_PATH);   
        ofn.hwndOwner := hWnd;
        ofn.lpstrFile := szFileName;
        ofn.lpstrFileTitle := szTitleName;
      end;

    WM_SIZE:
      begin
        cxClient := LOWORD(lParam);
        cyClient := HIWORD(lParam);
      end;

    WM_COMMAND:
      begin
        case LOWORD(wParam) of
          IDM_FILE_OPEN:
            begin
             // �ļ�ѡ��Ի���
              if (not GetOpenFileName(ofn)) then Exit; // return 0
             // ɾ����λͼ
              if (hBitmap <> 0) then
              begin
                DeleteObject(hBitmap);
                hBitmap := 0;
              end;
             // ɾ���ɵ�ɫ��
              if (hPalette <> 0) then
              begin
                DeleteObject(hPalette);
                hPalette := 0;
              end;
             // װ��DIB�ļ�
              SetCursor(LoadCursor(0, IDC_WAIT));
              ShowCursor(TRUE);
              pPackedDib := PackedDibLoad(szFileName);
              ShowCursor(FALSE);
              SetCursor(LoadCursor(0, IDC_ARROW));
             // װ��ɹ�..
              if (pPackedDib <> nil) then
              begin
               // Create the DIB section from the DIB
                hBitmap := CreateDIBSection(0, pPackedDib^, DIB_RGB_COLORS,
                  Pointer(pBits), 0, 0);
               // Copy the bits
                CopyMemory(pBits, PackedDibGetBitsPtr(pPackedDib),
                  PackedDibGetBitsSize(pPackedDib));
               // Create palette from the DIB
                hPalette := PackedDibCreatePalette(pPackedDib);
               // Free the packed-DIB memory
                FreeMem(pPackedDib);
              end else
              begin
                MessageBox(hWnd, 'Cannot load DIB file', szAppName, 0);
              end;
             // ˢ�´���
              InvalidateRect(hWnd, nil, TRUE);
            end;
        end;
      end;

    WM_PAINT:
      begin
        hdcWnd := BeginPaint(hWnd, ps);

        if (hPalette <> 0) then
        begin
          SelectPalette(hdcWnd, hPalette, FALSE);
          RealizePalette(hdcWnd);
        end;

        if (hBitmap <> 0) then
        begin
          GetObject(hBitmap, SizeOf(TBitmap), @Bitmap);
          hdcMem := CreateCompatibleDC(hdcWnd);
          SelectObject(hdcMem, hBitmap);
          BitBlt(hdcWnd, 0, 0, Bitmap.bmWidth, Bitmap.bmHeight, hdcMem, 0, 0, SRCCOPY);
          DeleteDC(hdcMem);
        end;
        
        EndPaint(hWnd, ps);
      end;

    WM_QUERYNEWPALETTE:
      begin
        if (hPalette = 0) then Exit; // return FALSE
        hdcWnd := GetDC(hWnd);
        SelectPalette(hdcWnd, hPalette, FALSE);
        RealizePalette(hdcWnd);
        InvalidateRect(hWnd, nil, TRUE);
        ReleaseDC(hWnd, hdcWnd);
        Result := 1; // return TRUE
      end;

    WM_PALETTECHANGED:
      begin
        if (hPalette = 0) or (wParam = Integer(hWnd)) then Exit;
        hdcWnd := GetDC(hWnd);
        SelectPalette(hdcWnd, hPalette, FALSE);
        RealizePalette(hdcWnd);
        UpdateColors(hdcWnd);
        ReleaseDC(hWnd, hdcWnd);
      end;

    WM_DESTROY:
      begin
        FreeMem(szFileName, MAX_PATH);
        FreeMem(szTitleName, MAX_PATH);
        if (hBitmap <> 0) then DeleteObject(hBitmap);
        if (hPalette <> 0) then DeleteObject(hPalette);
        PostQuitMessage(0); // �˳���Ϣѭ��
      end;
      
    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;

var
  hWnd: LongWord;
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
  hWnd := CreateWindow(szAppName, 'Show DIB #8: DIB Section',
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
