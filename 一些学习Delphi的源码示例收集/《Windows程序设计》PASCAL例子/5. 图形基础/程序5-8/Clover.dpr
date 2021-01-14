program  Clover;

uses
  Windows, Messages, Math;

  // ������Ϣ����ص�����
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  TWO_PI = (2.0 * 3.1415926);
 {$J+}
  hRgnClip: HRGN = 0; // �ϲ�������֮���
  cxClient: Integer = 0;  // ���嵱ǰ���
  cyClient: Integer = 0;  // ���嵱ǰ�߶�
 {$J-}
var
  J: Integer;
  PS: TPaintStruct;
  hWndDC: HDC; // �豸���ݾ��
  hCursor: LongWord; // �����
  hRgnTemp: array[0..5] of HRGN; // ��ʱ����֮���
  fAngle, fRadius: Extended;  
begin
  Result := 0;
  case Msg of
    WM_SIZE:  begin
                cxClient := LOWORD(lParam);
                cyClient := HIWORD(lParam);

                hCursor := SetCursor(LoadCursor(0, IDC_WAIT));
                ShowCursor(TRUE);

                if (hRgnClip <> 0) then // ɾ����ǰ���������
                begin
                  DeleteObject(hRgnClip);  hRgnClip := 0;
                end;
               // ����4����Բ����
                hRgnTemp[0] := CreateEllipticRgn(0, cyClient div 3, cxClient div 2, 2 * cyClient div 3);
                hRgnTemp[1] := CreateEllipticRgn(cxClient div 2, cyClient div 3, cxClient, 2 * cyClient div 3);
                hRgnTemp[2] := CreateEllipticRgn(cxClient div 3, 0, 2 * cxClient div 3, cyClient div 2);
                hRgnTemp[3] := CreateEllipticRgn(cxClient div 3, cyClient div 2, 2 * cxClient div 3, cyClient);
               // ����3���յ�����
                hRgnTemp[4] := CreateRectRgn(0, 0, 1, 1);
                hRgnTemp[5] := CreateRectRgn(0, 0, 1, 1);
                hRgnClip := CreateRectRgn(0, 0, 1, 1);
               // �ϲ�����
                CombineRgn(hRgnTemp[4], hRgnTemp[0], hRgnTemp[1], RGN_OR);
                CombineRgn(hRgnTemp[5], hRgnTemp[2], hRgnTemp[3], RGN_OR);
                CombineRgn(hRgnClip, hRgnTemp[4], hRgnTemp[5], RGN_XOR);
               // ɾ��������ʱ����
                for J := 0 to 5 do DeleteObject(hRgnTemp[J]);

                SetCursor(hCursor);
                ShowCursor(FALSE);
              end;

    WM_PAINT: begin
                hWndDc := BeginPaint(hWnd, PS); // ��ʼ����

                SetViewportOrgEx(hWndDc, cxClient div 2, cyClient div 2, nil); // ԭ��
                SelectClipRgn(hWndDc, hRgnClip); // ���ü�������(�����ⲻ�ᱻ��ͼ)
                fRadius := Hypot(cxClient / 2.0, cyClient / 2.0);
                fAngle := 0;
                while (fAngle < TWO_PI) do  // ��תһ��
                begin
                  MoveToEx(hWndDc, 0, 0, nil);
                  LineTo(hWndDc, Trunc(fRadius*Cos(fAngle)+0.5), Trunc(-fRadius*Sin(fAngle)+0.5));
                  fAngle := fAngle + TWO_PI / 360;
                end;

                EndPaint(hWnd, PS); // ��������
              end;

    WM_DESTROY: begin
                  DeleteObject(hRgnClip); // ɾ���������
                  PostQuitMessage(0); // �˳���Ϣѭ��
                end;

    else Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
  end;
end;


const  
  AppName = 'Clover';  // ��������

var
  hWnd: LongWord;
  Msg: TMsg;
  WndClass: TWndClass;

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
    MessageBox(0, 'This Program requires Windows NT!', AppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(AppName, 'Draw a Clover',
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
