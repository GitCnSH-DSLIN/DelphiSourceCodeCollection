program  DevCaps1;

uses
  Windows, Messages;          

  // ������Ϣ����ص�����
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
type
  TDevCap = record
    iIndex: Integer;
    szLabel: PChar;
    szDesc: PChar;
  end;
const
  NUMLINES = 19;
  DevCaps: array[0..NUMLINES] of TDevCap =  (
    (iIndex: HORZSIZE; szLabel: 'HORZSIZE'; szDesc: 'Width in millimeters:'),
    (iIndex: VERTSIZE; szLabel: 'VERTSIZE'; szDesc: 'Height in millimeters:'),
    (iIndex: HORZRES; szLabel: 'HORZRES'; szDesc: 'Width in pixels:'),
    (iIndex: VERTRES; szLabel: 'VERTRES'; szDesc: 'Height in raster lines:'),
    (iIndex: BITSPIXEL; szLabel: 'BITSPIXEL'; szDesc: 'Color bits per pixel:'),
    (iIndex: PLANES; szLabel: 'PLANES'; szDesc: 'Number of color planes:'),
    (iIndex: NUMBRUSHES; szLabel: 'NUMBRUSHES'; szDesc: 'Number of device brushes:'),
    (iIndex: NUMPENS; szLabel: 'NUMPENS'; szDesc: 'Number of device pens:'),
    (iIndex: NUMMARKERS; szLabel: 'NUMMARKERS'; szDesc: 'Number of device markers:'),
    (iIndex: NUMFONTS; szLabel: 'NUMFONTS'; szDesc: 'Number of device fonts:'),
    (iIndex: NUMCOLORS; szLabel: 'NUMCOLORS'; szDesc: 'Number of device colors:'),
    (iIndex: PDEVICESIZE; szLabel: 'PDEVICESIZE'; szDesc: 'Size of device structure:'),
    (iIndex: ASPECTX; szLabel: 'ASPECTX'; szDesc: 'Relative width of pixel:'),
    (iIndex: ASPECTY; szLabel: 'ASPECTY'; szDesc: 'Relative height of pixel:'),
    (iIndex: ASPECTXY; szLabel: 'ASPECTXY'; szDesc: 'Relative diagonal of pixel:'),
    (iIndex: LOGPIXELSX; szLabel: 'LOGPIXELSX'; szDesc: 'Horizontal dots per inch:'),
    (iIndex: LOGPIXELSY; szLabel: 'LOGPIXELSY'; szDesc: 'Vertical dots per inch:'),
    (iIndex: SIZEPALETTE; szLabel: 'SIZEPALETTE'; szDesc: 'Number of palette entries:'),
    (iIndex: NUMRESERVED; szLabel: 'NUMRESERVED'; szDesc: 'Reserved palette entries:'),
    (iIndex: COLORRES; szLabel: 'COLORRES'; szDesc: 'Actual color resolution:') );
 {$J+}
const
  cxChar: Integer = 0;   // Сд��ĸ���
  cxCaps: Integer = 0;   // ��д��ĸ���
  cyChar: Integer = 0;   // Сд��ĸ�߶�
 {$J-}
var
  Buffer: array [0..5] of Char;
  hWndDc: HDC;
  J, L: Integer;
  PS: TPaintStruct;
  TM: TTextMetric;
begin
  Result := 0;
 // ��ͬ����Ϣ��ʶ
  case Msg of
    WM_CREATE   :  begin
                     hWndDc := GetDC(hWnd); // ȡ�����豸���ݾ��

                     GetTextMetrics(hWndDc, TM); // ȡ�����������Ϣ
                     cxChar := TM.tmAveCharWidth;
                     if (TM.tmPitchAndFamily and $1) = 0 // ��ȹ̶�?
                     then cxCaps := cxChar
                     else cxCaps := cxChar * 3 div 2;
                     cyChar := TM.tmHeight + TM.tmExternalLeading;

                     ReleaseDC(hWnd, hWndDc); // �ͷ��豸���ݾ��
                   end;
                   
    WM_PAINT    :  begin
                     hWndDc := BeginPaint(hWnd, PS); // ��ʼ����

                     for J := 0 to NUMLINES do // �������
                     begin
                       TextOut(hWndDc, 0, cyChar * J, DevCaps[J].szLabel, lstrlen(DevCaps[J].szLabel));
                       TextOut(hWndDc, 14 * cxCaps, cyChar * J, DevCaps[J].szDesc, lstrlen(DevCaps[J].szDesc));
                       SetTextAlign(hWndDc, TA_RIGHT or TA_TOP);  // �����϶���
                       L := GetDeviceCaps(hWndDc, DevCaps[J].iIndex);
                       TextOut(hWndDc, 14 * cxCaps + 35 * cxChar, cyChar * J, Buffer, wvsprintf(Buffer, '%5d', @L));
                       SetTextAlign(hWndDc, TA_LEFT or TA_TOP); // �����϶���
                     end;

                     EndPaint(hWndDc, PS); // ��������
                   end;
                   
    WM_DESTROY  :  PostQuitMessage(0); // �˳���Ϣѭ��
    
    else Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ��� 
  end;
end;


const  
  AppName = 'DevCaps1'; // ��������

var
  hWnd: LongWord;   // ������
  Msg: TMsg;        // ��Ϣ�ṹ
  WndClass: TWndClass; // ��ṹ
   
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
  hWnd := CreateWindow(AppName, 'Device Capabilities',
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
