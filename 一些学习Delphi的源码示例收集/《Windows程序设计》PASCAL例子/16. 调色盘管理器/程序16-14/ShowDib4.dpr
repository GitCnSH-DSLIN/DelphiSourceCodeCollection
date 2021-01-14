program  ShowDib4;

{$R  ShowDib4.res}

uses
  Windows, Messages, CommDlg, Math,
  PackeDib in '..\����16-12\PackeDib.pas';

const
  szAppName = 'ShowDib4';

  // ����ͨ�õ�ɫ��
function CreateAllPurposePalette(): HPALETTE;
var
  i, incr, R, G, B: Integer;
  plp: PLogPalette;
begin
  GetMem(plp, SizeOf(TLogPalette) + 246 * SizeOf(TPaletteEntry));
  plp.palVersion := $0300;
  plp.palNumEntries := 247;
 // The following loop calculates 31 gray shades, but 3 of them
 // will match the standard 20 colors
  i := 0;
  G := 0;
  incr := 8;
  while (G <= $FF) do
  begin
    plp.palPalEntry[i].peRed := G;
    plp.palPalEntry[i].peGreen := G;
    plp.palPalEntry[i].peBlue := G;
    plp.palPalEntry[i].peFlags := 0;
    incr := IfThen(incr = 9, 8, 9);
    Inc(i);
    Inc(G, incr);
  end; 
 // The following loop is responsible for 216 entries, but 8 of
 // them will match the standard 20 colors, and another
 // 4 of them will match the gray shades above.
  R := 0;
  while (R <= $FF) do
  begin
    G := 0;
    while (G <= $FF) do
    begin
      B := 0;
      while (B <= $FF) do
      begin
        plp.palPalEntry[i].peRed := R;
        plp.palPalEntry[i].peGreen := G;
        plp.palPalEntry[i].peBlue := B;
        plp.palPalEntry[i].peFlags := 0;
        Inc(i);
        Inc(B, $33);
      end;
      Inc(G, $33);
    end;
    Inc(R, $33);
  end;
  Result := CreatePalette(plp^);
  FreeMem(plp);
end;

  // ������Ϣ������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  IDM_FILE_OPEN = 40001;
  szFilter = 'Bitmap Files (*.BMP)'#0'*.bmp'#0'All Files (*.*)'#0'*.*'#0#0;
{$J+}
  pPackedDib: PBitmapInfo = nil;
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
{$J-}
var
  hWndDc: HDC;
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
        
        hPalette := CreateAllPurposePalette();
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
             // �ͷ���ǰ������ڴ�
              if (pPackedDib <> nil) then
              begin
                FreeMem(pPackedDib);
                pPackedDib := nil;
              end;
             // װ��DIB�ļ�
              SetCursor(LoadCursor(0, IDC_WAIT));
              ShowCursor(TRUE);
              pPackedDib := PackedDibLoad(szFileName);
              ShowCursor(FALSE);
              SetCursor(LoadCursor(0, IDC_ARROW));
             // ���
              if (pPackedDib = nil) then
                MessageBox(hWnd, 'Cannot load DIB file', szAppName, 0);
             // ˢ�´���
              InvalidateRect(hWnd, nil, TRUE);
            end;
        end;
      end;

    WM_PAINT:
      begin
        hWndDc := BeginPaint(hWnd, ps);
        if (pPackedDib <> nil) then
        begin
          SelectPalette(hWndDc, hPalette, FALSE);
          RealizePalette(hWndDc);
          SetDIBitsToDevice(hWndDc,
                            0,
                            0,
                            PackedDibGetWidth(pPackedDib),
                            PackedDibGetHeight(pPackedDib),
                            0,
                            0,
                            0,
                            PackedDibGetHeight(pPackedDib),
                            PackedDibGetBitsPtr(pPackedDib),
                            pPackedDib^,
                            DIB_RGB_COLORS );
        end;
        EndPaint(hWnd, ps);
      end;

    WM_QUERYNEWPALETTE:
      begin
        hWndDc := GetDC(hWnd);
        SelectPalette(hWndDc, hPalette, FALSE);
        RealizePalette(hWndDc);
        InvalidateRect(hWnd, nil, TRUE);
        ReleaseDC(hWnd, hWndDc);
        Result := 1; // return TRUE
      end;

    WM_PALETTECHANGED:
      begin
        if (wParam = Integer(hWnd)) then Exit;
        hWndDc := GetDC(hWnd);
        SelectPalette(hWndDc, hPalette, FALSE);
        RealizePalette(hWndDc);
        UpdateColors(hWndDc);
        ReleaseDC(hWnd, hWndDc);
      end;

    WM_DESTROY:
      begin
        FreeMem(szFileName, MAX_PATH);
        FreeMem(szTitleName, MAX_PATH);
        if (pPackedDib <> nil) then FreeMem(pPackedDib);
        DeleteObject(hPalette);
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
  hWnd := CreateWindow(szAppName, 'Show DIB #4: All-Purpose Palette',
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
