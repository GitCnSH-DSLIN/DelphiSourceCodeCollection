program  SysPal1;

uses
  Windows, Messages;

const
  szAppName = 'SysPal1';

  // �Ƿ�֧�ֵ�ɫ��  
function CheckDisplay(hWnd: HWND): Boolean;
var
  hWndDc: HDC;
  iPalSize: Integer;
begin
  hWndDc := GetDC(hWnd);
  iPalSize := GetDeviceCaps(hWndDc, SIZEPALETTE);
  ReleaseDC(hWnd, hWndDc);
  if (iPalSize <> 256) then // 256ɫ
  begin
    MessageBox(hWnd,
      'This program requires that the video '#13#10'display mode have a 256-color palette.',
      szAppName, MB_ICONERROR);
    Result := FALSE;
  end else
  begin
    Result := TRUE;
  end;  
end;

   // ������Ϣ������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+}
  cxClient: Integer = 0;
  cyClient: Integer = 0;
  sizeChar: SIZE = (cx: 0; cy: 0); // �ַ�������ߴ�
{$J-}
var
  hWndDc: HDC;
  ps: TPaintStruct;
  i, x, y: Integer;  
  pe: array[0..255] of TPaletteEntry;
  szBuffer: array[0..16] of Char;
  List: array[0..3] of DWORD;
begin
  Result := 0;
  case Msg of
    WM_CREATE:
      begin
        if (CheckDisplay(hWnd) = FALSE) then
        begin
          Result := -1; // ���ô������� :-)
        end else
        begin
          hWndDc := GetDC(hWnd);
          SelectObject(hWndDc, GetStockObject(SYSTEM_FIXED_FONT));
          GetTextExtentPoint32(hWndDc, 'FF-FF-FF', 10, sizeChar);
          ReleaseDC(hWnd, hWndDc);
        end;
      end;

    WM_DISPLAYCHANGE:
      begin
        if (CheckDisplay(hWnd) = FALSE) then DestroyWindow(hWnd);
      end;

    WM_SIZE:
      begin
        cxClient := LOWORD(lParam);
        cyClient := HIWORD(lParam);
      end;

    WM_PAINT:
      begin
        hWndDc := BeginPaint(hWnd, ps);

        SelectObject(hWndDc, GetStockObject(SYSTEM_FIXED_FONT));
        GetSystemPaletteEntries(hWndDc, 0, 256, pe); // ϵͳ��ɫ��
        x := 0;
        y := 0;
        for i := 0 to 255 do
        begin
          List[0] := pe[i].peRed;
          List[1] := pe[i].peGreen;
          List[2] := pe[i].peBlue;
          TextOut(hWndDc, x, y, szBuffer, wvsprintf(szBuffer, '%02X-%02X-%02X', @List[0]));
          x := x + sizeChar.cx;
          if (x + sizeChar.cx > cxClient) then // ����
          begin
            x := 0;
            y := y + sizeChar.cy;
            if (y > cyClient) then Break; // ����
          end;
        end;

        EndPaint(hWnd, ps);
      end;  

    WM_PALETTECHANGED:
      begin
        InvalidateRect(hWnd, nil, FALSE);
      end;

    WM_DESTROY:
      begin
        PostQuitMessage(0); // �˳�ѭ��
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
  WndClass.lpszMenuName := nil;
  WndClass.lpszClassName := szAppName;
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(szAppName, 'System Palette #1',
                       WS_OVERLAPPEDWINDOW,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       0, 0, hInstance, nil);   
  if (hWnd = 0) then Exit;

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
