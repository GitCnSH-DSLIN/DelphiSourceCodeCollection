program  DibConv;

{$R DibConv.res}

uses
  Windows, Messages, CommDlg;

const
  szAppName = 'DibConv';

   // DIB  ->  DDB
function CreateBitmapObjectFromDibFile(hdc: HDC; const szFileName: PChar): HBITMAP;
var
  pbmfh: PBitmapFileHeader;
  hFile: THandle;
  dwFileSize, dwHighSize, dwBytesRead: DWORD;
  bSuccess: Boolean;
begin
  Result := 0;
 // ���ļ�
  hFile := CreateFile(szFileName, GENERIC_READ, FILE_SHARE_READ, nil,
                   OPEN_EXISTING, FILE_FLAG_SEQUENTIAL_SCAN, 0);
  if (hFile = INVALID_HANDLE_VALUE) then Exit;
 // �ļ��ߴ�
  dwFileSize := GetFileSize(hFile, @dwHighSize);
  if (dwHighSize <> 0) then
  begin
    CloseHandle(hFile);
    Exit;
  end;
 // �����ڴ�
  GetMem(pbmfh, dwFileSize);
  if (pbmfh = nil) then
  begin
    CloseHandle(hFile);
    Exit;
  end;
 // �����ڴ�
  bSuccess := ReadFile(hFile, pbmfh^, dwFileSize, dwBytesRead, nil);
  CloseHandle(hFile);
 // ��ʽ����
  if (not bSuccess) or (dwBytesRead <> dwFileSize) or
     (pbmfh.bfType <> PWORD(PChar('BM'))^) or
     (pbmfh.bfSize <> dwFileSize) then
  begin
    FreeMem(pbmfh);
    Exit;
  end;
 // ����DDB
  Result := CreateDIBitmap(hdc,
                           PBitmapInfoHeader(Integer(pbmfh) + SizeOf(TBitmapFileHeader))^,
                           CBM_INIT,
                           PChar(DWORD(pbmfh) + pbmfh.bfOffBits),
                           PBitmapInfo(Integer(pbmfh) + SizeOf(TBitmapFileHeader))^,
                           DIB_RGB_COLORS
                           );
 // �ͷ��ڴ�
  FreeMem(pbmfh);
end;

  // ������Ϣ����ص�����
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  IDM_FILE_OPEN = 40001;
  szFilter = 'Bitmap Files (*.BMP)'#0'*.bmp'#0'All Files (*.*)'#0'*.*'#0#0;
{$J+}
  ofn: TOpenFilename = 
    (
    lStructSize: SizeOf(TOpenFilename);
    hwndOwner: 0; // ��������
    hInstance: 0;
    lpstrFilter: szFilter;
    lpstrCustomFilter: nil;
    nMaxCustFilter: 0;
    nFilterIndex: 0;
    lpstrFile: nil; // szFileName
    nMaxFile: MAX_PATH;
    lpstrFileTitle: nil; // szTitleName
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
  hBitmap: LongWord = 0;
  cxClient: Integer = 0;
  cyClient: Integer = 0;
{$J+}
var
  Bitmap: TBitmap;
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
              if (not GetOpenFileName(ofn)) then Exit;
             // ɾ����λͼ
              if (hBitmap <> 0) then
              begin
                DeleteObject(hBitmap);
                hBitmap := 0;
              end;
             // ����DIB��ת����DDB
              SetCursor(LoadCursor(0, IDC_WAIT));
              ShowCursor(TRUE);
              hdcWnd := GetDC(hWnd);
              hBitmap := CreateBitmapObjectFromDibFile(hdcWnd, szFileName);
              ReleaseDC(hWnd, hdcWnd);
              ShowCursor(FALSE);
              SetCursor(LoadCursor(0, IDC_ARROW));
             // ˢ�´���
              InvalidateRect(hWnd, nil, TRUE);

              if (hBitmap = 0) then
                MessageBox(hWnd, 'Cannot load DIB file',
                  szAppName, MB_OK or MB_ICONEXCLAMATION);
            end;
        end;
      end;
      
    WM_PAINT:
      begin
        hdcWnd := BeginPaint(hWnd, ps);
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
      
    WM_DESTROY:
      begin
        FreeMem(szFileName, MAX_PATH);
        FreeMem(szTitleName, MAX_PATH);
        if (hBitmap <> 0) then DeleteObject(hBitmap);
        PostQuitMessage(0); // �˳�
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
  hWnd := CreateWindow(szAppName, 'DIB to DDB Conversion',
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
