program  ShowDib1;

{$R ShowDib1.res}

uses
  Windows, Messages, DibFile;

const
  szAppName = 'ShowDib1';  

  // ������Ϣ������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  IDM_FILE_OPEN = 40001;
  IDM_FILE_SAVE = 40002;
{$J+}
  pbmfh: PBitmapFileHeader = nil;
  pbmi: PBitmapInfo = nil;
  pBits: PByte = nil;
  cxClient: Integer = 0;
  cyClient: Integer = 0;
  cxDib: Integer = 0;
  cyDib: Integer = 0;
  szFileName: PChar = nil;
  szTitleName: PChar = nil;
{$J-}
var
  bSuccess: Boolean;
  hWndDc: HDC;
  ps: TPaintStruct;
begin
  Result := 0;
  case Msg of
    WM_CREATE:
      begin
        DibFileInitialize(hWnd);
        GetMem(szFileName, MAX_PATH);
        GetMem(szTitleName, MAX_PATH);
      end;
    WM_SIZE:
      begin
        cxClient := LOWORD(lParam);
        cyClient := HIWORD(lParam);
      end;
    WM_INITMENUPOPUP:
      begin
        if (pbmfh <> nil) then
          EnableMenuItem(wParam, IDM_FILE_SAVE, MF_ENABLED)
        else
          EnableMenuItem(wParam, IDM_FILE_SAVE, MF_GRAYED);
      end;
    WM_COMMAND:
      begin
        case LOWORD(wParam) of
          IDM_FILE_OPEN:
            begin
             // �ļ�ѡ��Ի���
              if (not DibFileOpenDlg(hWnd, szFileName, szTitleName)) then Exit;
             // �ͷ���ǰ������ڴ�
              if (pbmfh <> nil) then
              begin
                FreeMem(pbmfh);
                pbmfh := nil;
              end;
             // װ��DIB�ļ�
              SetCursor(LoadCursor(0, IDC_WAIT));
              ShowCursor(TRUE);
              pbmfh := DibLoadImage(szFileName);
              ShowCursor(FALSE);
              SetCursor(LoadCursor(0, IDC_ARROW));
             // ˢ�´���(�ػ�)
              InvalidateRect(hWnd, nil, TRUE);
             // װ�����
              if (pbmfh = nil) then
              begin
                MessageBox(hwnd, 'Cannot load DIB file', szAppName, 0);
                Exit;
              end;
             // �����2��ָ��
              pbmi := PBitmapInfo(Integer(pbmfh) + 14);
              pBits := PByte(Integer(pbmfh) + pbmfh.bfOffBits);
             // DIB �ߴ�
              if (pbmi.bmiHeader.biSize = SizeOf(TBitmapCoreHeader)) then
              begin
                cxDib := PBitmapCoreHeader(pbmi).bcWidth;
                cyDib := PBitmapCoreHeader(pbmi).bcHeight;
              end else
              begin
                cxDib := pbmi.bmiHeader.biWidth;
                cyDib := abs(pbmi.bmiHeader.biHeight);
              end;
            end;
          IDM_FILE_SAVE:
            begin
             // �ļ�����Ի���
              if (not DibFileSaveDlg(hWnd, szFileName, szTitleName)) then Exit;
             // ����DIB�ļ�
              SetCursor(LoadCursor(0, IDC_WAIT));
              ShowCursor(TRUE);
              bSuccess := DibSaveImage(szFileName, pbmfh);
              ShowCursor(FALSE);
              SetCursor(LoadCursor(0, IDC_ARROW));
              if (not bSuccess) then
                MessageBox(hWnd, 'Cannot save DIB file', szAppName, 0);
            end;
        end;
      end;
    WM_PAINT:
      begin
        hWndDc := BeginPaint(hWnd, ps);
        if (pbmfh <> nil) then
          SetDIBitsToDevice(hWndDc,
                            0,                     // xDst
                            0,                     // yDst
                            cxDib,                 // cxSrc
                            cyDib,                 // cySrc
                            0,                     // xSrc
                            0,                     // ySrc
                            0,                     // first scan line
                            cyDib,                 // number of scan lines
                            pBits,
                            pbmi^,
                            DIB_RGB_COLORS
                            );
        EndPaint(hWnd, ps);
      end;
    WM_DESTROY:
      begin
        FreeMem(szFileName, MAX_PATH);
        FreeMem(szTitleName, MAX_PATH);
        if (pbmfh <> nil) then FreeMem(pbmfh);
        PostQuitMessage(0); // �˳�
      end;
    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;

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
  hWnd := CreateWindow(szAppName, 'Show DIB #1',
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
