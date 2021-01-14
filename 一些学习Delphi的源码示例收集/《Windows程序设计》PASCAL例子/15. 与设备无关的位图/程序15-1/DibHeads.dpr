program  DibHeads;

{$R DibHeads.res}

uses
  Windows, CommDlg, Messages, Math;

  // ��hWnd����Ӹ�ʽ���ַ���
procedure Printf(hWnd: HWND; const szFormat: PChar; const Args: array of const);
var
  szBuffer: array[0..1024] of Char;
  ArgsList: array of DWORD;
  J: Integer;
begin
  SetLength(ArgsList, High(Args)+1);
  for J := Low(Args) to High(Args) do
  begin
    case Args[J].VType of
      vtInteger:
        ArgsList[J] := DWORD(Args[J].VInteger);
      vtChar:
        ArgsList[J] := DWORD(Args[J].VChar);
      vtPChar:
        ArgsList[J] := DWORD(Args[J].VPChar);
      vtString:
        ArgsList[J] := DWORD(Args[J].VString);
      vtAnsiString:
        ArgsList[J] := DWORD(Args[J].VAnsiString);
    end;
  end;
  wvsprintf(szBuffer, szFormat, @ArgsList[0]);
  SendMessage(hWnd, EM_SETSEL, -1, -1); // ��β
  SendMessage(hWnd, EM_REPLACESEL, 0, Integer(@szBuffer[0])); // �滻
  SendMessage(hWnd, EM_SCROLLCARET, 0, 0);
end;

  // ��hWnd�����DIB�ļ���Ϣ
procedure DisplayDibHeaders(hWnd: HWND; const szFileName: PChar);
const
  szInfoName: array[0..3] of PChar =
    ('BITMAPCOREHEADER', 'BITMAPINFOHEADER', 'BITMAPV4HEADER', 'BITMAPV5HEADER');
  szCompression: array[0..4] of PChar =
    ('BI_RGB', 'BI_RLE8', 'BI_RLE4', 'BI_BITFIELDS', 'unknown');
var
  pbmch: PBitmapCoreHeader;
  pbmfh: PBitmapFileHeader;
  pbmih: PBitmapV5Header;
  bSuccess: Boolean;
  dwFileSize, dwHighSize, dwBytesRead: DWORD;
  hFile: THandle;
  i : Integer;
  pFile: PByte;
  szV: PChar;
begin
 // ��ʾ�ļ���
  Printf(hWnd, 'File: %s'#13#10#13#10, [szFileName]);
 // ���ļ�
  hFile := CreateFile(szFileName, GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_FLAG_SEQUENTIAL_SCAN, 0);
 // ��ʧ��
  if (hFile = INVALID_HANDLE_VALUE) then
  begin
    Printf(hWnd, 'Cannot open file.'#13#10#13#10, []);
    Exit;
  end;
 // ȡ�ļ��ߴ�  
  dwFileSize := GetFileSize(hFile, @dwHighSize);
 // �ļ�����
  if (dwHighSize <> 0) then
  begin
    Printf(hWnd, 'Cannot deal with >4G files.'#13#10#13#10, []);
    CloseHandle(hFile);
    Exit;
  end;
 // �����ڴ�(׼�����ļ�)
  GetMem(pFile, dwFileSize);
 // ����ʧ��  
  if (pFile = nil) then
  begin
    Printf(hWnd, 'Cannot allocate memory.'#13#10#13#10, []);
    CloseHandle(hFile);
    Exit;
  end;
 // ���ù��λ'æ'
  SetCursor(LoadCursor(0, IDC_WAIT));
  ShowCursor(TRUE);
 // �ļ������ڴ�  
  bSuccess := ReadFile(hFile, pFile^, dwFileSize, dwBytesRead, nil);
 // �ָ�Ϊ�������
  ShowCursor(FALSE);
  SetCursor(LoadCursor(0, IDC_ARROW));
 // �������
  if (not bSuccess) or (dwBytesRead <> dwFileSize) then
  begin
    Printf(hWnd, 'Could not read file.'#13#10#13#10, []);
    CloseHandle(hFile);
    FreeMem(pFile);
    Exit;
  end;
 // �ر��ļ�  
  CloseHandle(hFile);
 // ��ʾ�ļ��ߴ�  
  Printf(hWnd, 'File size = %u bytes'#13#10#13#10, [dwFileSize]);
 // ��ʾ TBitmapFileHeader ��Ϣ
  pbmfh := PBitmapFileHeader(pFile);
  Printf(hWnd, 'BITMAPFILEHEADER'#13#10, []);
  Printf(hWnd, #9'.bfType = 0x%X'#13#10, [pbmfh.bfType]);
  Printf(hWnd, #9'.bfSize = %u'#13#10, [pbmfh.bfSize]);
  Printf(hWnd, #9'.bfReserved1 = %u'#13#10, [pbmfh.bfReserved1]);
  Printf(hWnd, #9'.bfReserved2 = %u'#13#10, [pbmfh.bfReserved2]);
  Printf(hWnd, #9'.bfOffBits = %u'#13#10#13#10, [pbmfh.bfOffBits]);
 // ȷ����Ϣ�ṹ����
  pbmih := PBitmapV5Header(Integer(pFile) + SizeOf(TBitmapFileHeader));
  case pbmih.bV5Size of
    SizeOf(TBitmapCoreHeader):
      begin
        i := 0;
        szV := nil;
      end;
    SizeOf(TBitmapInfoHeader):
      begin
        i := 1;
        szV := 'i';
      end;
    SizeOf(TBitmapV4Header):
      begin
        i := 2;
        szV := 'V4';
      end;
    SizeOf(TBitmapV5Header):
      begin
        i := 3;
        szV := 'V5';
      end;
    else
      begin
        Printf(hWnd, 'Unknown header size of %u.'#13#10#13#10, [pbmih.bV5Size]);
        FreeMem(pFile);
        Exit;
      end;
  end;
 // ��ʾ��Ϣͷ�����ַ���
  Printf(hWnd, '%s'#13#10, [szInfoName[i]]);
 // ��ʾ TBitmapCoreHeader ��Ϣ
  if (pbmih.bV5Size = Sizeof(TBitmapCoreHeader)) then
  begin
   pbmch := PBitmapCoreHeader(pbmih);
   Printf(hWnd, #9'.bcSize = %u'#13#10, [pbmch.bcSize]);
   Printf(hWnd, #9'.bcWidth = %u'#13#10, [pbmch.bcWidth]);
   Printf(hWnd, #9'.bcHeight = %u'#13#10, [pbmch.bcHeight]);
   Printf(hWnd, #9'.bcPlanes = %u'#13#10, [pbmch.bcPlanes]);
   Printf(hWnd, #9'.bcBitCount = %u'#13#10#13#10, [pbmch.bcBitCount]);
   FreeMem(pFile);
   Exit;
  end;
 // ��ʾ TBitmapInfoHeader ��Ϣ
  Printf(hWnd, #9'.b%sSize = %u'#13#10, [szV, pbmih.bV5Size]);
  Printf(hWnd, #9'.b%sWidth = %i'#13#10, [szV, pbmih.bV5Width]);
  Printf(hWnd, #9'.b%sHeight = %i'#13#10, [szV, pbmih.bV5Height]);
  Printf(hWnd, #9'.b%sPlanes = %u'#13#10, [szV, pbmih.bV5Planes]);
  Printf(hWnd, #9'.b%sBitCount=%u'#13#10, [szV, pbmih.bV5BitCount]);
  Printf(hWnd, #9'.b%sCompression = %s'#13#10, [szV, szCompression[Min(4, pbmih.bV5Compression)]]);
  Printf(hWnd, #9'.b%sSizeImage= %u'#13#10, [szV, pbmih.bV5SizeImage]);
  Printf(hWnd, #9'.b%sXPelsPerMeter = %i'#13#10, [szV, pbmih.bV5XPelsPerMeter]);
  Printf(hWnd, #9'.b%sYPelsPerMeter = %i'#13#10, [szV, pbmih.bV5YPelsPerMeter]);
  Printf(hWnd, #9'.b%sClrUsed = %i'#13#10, [szV, pbmih.bV5ClrUsed]);
  Printf(hWnd, #9'.b%sClrImportant = %i'#13#10#13#10, [szV, pbmih.bV5ClrImportant]);
  if (pbmih.bV5Size = SizeOf(TBitmapInfoHeader)) then
  begin
    if (pbmih.bV5Compression = BI_BITFIELDS) then
    begin
      Printf(hWnd, 'Red Mask = %08X'#13#10, [pbmih.bV5RedMask]);
      Printf(hWnd, 'Green Mask = %08X'#13#10, [pbmih.bV5GreenMask]);
      Printf(hWnd, 'Blue Mask  = %08X'#13#10#13#10, [pbmih.bV5BlueMask]);
    end;
    FreeMem(pFile);
    Exit;
  end;
 // ��ʾ TBitmapV4Header ��Ϣ
  Printf(hwnd, #9'.b%sRedMask   = %08X'#13#10, [szV, pbmih.bV5RedMask]);
  Printf(hwnd, #9'.b%sGreenMask = %08X'#13#10, [szV, pbmih.bV5GreenMask]);
  Printf(hwnd, #9'.b%sBlueMask  = %08X'#13#10, [szV, pbmih.bV5BlueMask]);
  Printf(hwnd, #9'.b%sAlphaMask = %08X'#13#10, [szV, pbmih.bV5AlphaMask]);
  Printf(hwnd, #9'.b%sCSType = %u'#13#10, [szV, pbmih.bV5CSType]);
  Printf(hwnd, #9'.b%sEndpoints.ciexyzRed.ciexyzX = %08X'#13#10, [szV, pbmih.bV5Endpoints.ciexyzRed.ciexyzX]);
  Printf(hwnd, #9'.b%sEndpoints.ciexyzRed.ciexyzY = %08X'#13#10, [szV, pbmih.bV5Endpoints.ciexyzRed.ciexyzY]);
  Printf(hwnd, #9'.b%sEndpoints.ciexyzRed.ciexyzZ = %08X'#13#10, [szV, pbmih.bV5Endpoints.ciexyzRed.ciexyzZ]);
  Printf(hwnd, #9'.b%sEndpoints.ciexyzGreen.ciexyzX = %08X'#13#10, [szV, pbmih.bV5Endpoints.ciexyzGreen.ciexyzX]);
  Printf(hwnd, #9'.b%sEndpoints.ciexyzGreen.ciexyzY = %08X'#13#10, [szV, pbmih.bV5Endpoints.ciexyzGreen.ciexyzY]);
  Printf(hwnd, #9'.b%sEndpoints.ciexyzGreen.ciexyzZ = %08X'#13#10, [szV, pbmih.bV5Endpoints.ciexyzGreen.ciexyzZ]);
  Printf(hwnd, #9'.b%sEndpoints.ciexyzBlue.ciexyzX = %08X'#13#10, [szV, pbmih.bV5Endpoints.ciexyzBlue.ciexyzX]);
  Printf(hwnd, #9'.b%sEndpoints.ciexyzBlue.ciexyzY = %08X'#13#10, [szV, pbmih.bV5Endpoints.ciexyzBlue.ciexyzY]);
  Printf(hwnd, #9'.b%sEndpoints.ciexyzBlue.ciexyzZ = %08X'#13#10, [szV, pbmih.bV5Endpoints.ciexyzBlue.ciexyzZ]);
  Printf(hwnd, #9'.b%sGammaRed = %08X'#13#10, [szV, pbmih.bV5GammaRed]);
  Printf(hwnd, #9'.b%sGammaGreen = %08X'#13#10, [szV, pbmih.bV5GammaGreen]);
  Printf(hWnd, #9'.b%sGammaBlue  = %08X'#13#10#13#10, [szV, pbmih.bV5GammaBlue]);
  if (pbmih.bV5Size = SizeOf(TBitmapV4Header)) then
  begin
   FreeMem(pFile);
   Exit;
  end;
 // ��ʾ TBitmapV5Header ��Ϣ
  Printf(hWnd, #9'.b%sIntent = %u'#13#10, [szV, pbmih.bV5Intent]);
  Printf(hWnd, #9'.b%sProfileData = %u'#13#10, [szV, pbmih.bV5ProfileData]);
  Printf(hWnd, #9'.b%sProfileSize = %u'#13#10, [szV, pbmih.bV5ProfileSize]);
  Printf(hWnd, #9'.b%sReserved = %u'#13#10#13#10, [szV, pbmih.bV5Reserved]);
  
  FreeMem(pFile);
end;                

  // ������Ϣ������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  IDM_FILE_OPEN = 40001;
  szFilter = 'Bitmap Files (*.BMP)'#0'*.bmp'#0'All Files (*.*)'#0'*.*'#0#0;
{$J+}
  hWndEdit: DWORD = 0; // �༭�ؼ����
  ofn: TOpenFilename =
   (
    lStructSize: SizeOf(TOpenFilename);
    hwndOwner: 0; // ��������,����
    hInstance: 0;
    lpstrFilter: szFilter;
    lpstrCustomFilter: nil;
    nMaxCustFilter: 0;
    nFilterIndex: 0;
    lpstrFile: nil; // ��ʼ�ļ���&����ѡ����ļ���(������·��),����
    nMaxFile: MAX_PATH;
    lpstrFileTitle: nil; // ������lpstrFile,���ǽ������ļ���,����
    nMaxFileTitle: MAX_PATH;
    lpstrInitialDir: nil;
    lpstrTitle: nil;
    Flags: 0 ;
    nFileOffset: 0;
    nFileExtension: 0;
    lpstrDefExt: 'bmp';
    lCustData: 0;
    lpfnHook: nil;
    lpTemplateName: nil;
   );
{$J-}
begin
  Result := 0;
  case Msg of
    WM_CREATE:
      begin
        hWndEdit := CreateWindow('edit', nil,
                      WS_CHILD or WS_VISIBLE or WS_BORDER or WS_VSCROLL or
                      WS_HSCROLL or ES_MULTILINE or ES_AUTOVSCROLL or ES_READONLY,
                      0, 0, 0, 0, hWnd, 1, hInstance, nil);
        ofn.hwndOwner := hWnd;
        GetMem(ofn.lpstrFile, MAX_PATH);
        GetMem(ofn.lpstrFileTitle, MAX_PATH);
      end;
    WM_SIZE:
      begin
        MoveWindow(hWndEdit, 0, 0, LOWORD(lParam), HIWORD(lParam), TRUE);
      end;
    WM_COMMAND:
      begin
        if (LOWORD(wParam) = IDM_FILE_OPEN) and (GetOpenFileName(ofn)) then
          DisplayDibHeaders(hWndEdit, ofn.lpstrFile);
      end;
    WM_DESTROY:
      begin
        FreeMem(ofn.lpstrFile, MAX_PATH);
        FreeMem(ofn.lpstrFileTitle, MAX_PATH);
        PostQuitMessage(0); // �˳�
      end;
    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;

const
  szAppName = 'DibHeads';
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
  hWnd := CreateWindow(szAppName, 'DIB Headers',
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
