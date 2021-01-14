program  SysMets1;

uses
  Windows, Messages, SysMets;

  // �������    { ��� }    { ��ʶ }   { ����1 }       { ����2 }
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+} // �����޸ĳ���
  cxChar: Integer = 0;   // Сд��ĸ���
  cxCaps: Integer = 0;   // ��д��ĸ���
  cyChar: Integer = 0;   // Сд��ĸ�߶�
{$J-}
var
  hWndDc: HDC;          // �豸���ݾ��
  PS: TPaintStruct;     // ��ͼ��Ϣ�ṹ
  TM: TTextMetric;      // ���������Ϣ
  J, OutList: Integer;  // ѭ������, ת���б�(����ֻ��һ��)
  Buffer: array [0..5] of Char; // ����ַ���
begin
  Result := 0;
 // ����ͬ����Ϣ 
  case Msg of
    WM_CREATE: begin
                 hWndDc := GetDC(hWnd); // ȡ���豸���ݾ��

                 GetTextMetrics(hWndDc, TM);  // ȡ�����������Ϣ
                 cxChar := TM.tmAveCharWidth; // Сд��ĸ���
                 if (TM.tmPitchAndFamily and $1) = 0 // �Ƿ�̶��������(�����д��ĸ���)
                 then cxCaps := cxChar
                 else cxCaps := cxChar * 3 div 2;
                 cyChar := TM.tmHeight + TM.tmExternalLeading; // Сд��ĸ�߶�

                 ReleaseDC(hWnd, hWndDc); // �ͷ��豸���ݾ��
               end;

    WM_PAINT: begin
                hWndDc := BeginPaint(hWnd, PS); // ��ʼ����

                for J := 0 to NUMLINES-1 do // �������������Ϣ
                begin
                  TextOut(hWndDc, 0, cyChar * J, SysMetrics[J].szLabel, lstrlen(SysMetrics[J].szLabel));
                  TextOut(hWndDc, 22 * cxCaps, cyChar * J, SysMetrics[J].szDesc, lstrlen(SysMetrics[J].szDesc));
                  SetTextAlign(hWndDc, TA_RIGHT or TA_TOP); // �˺�����������Ϊ���Ͻ�֮����
                  OutList := GetSystemMetrics(SysMetrics[J].Index);              {ת�������س���(����϶���5)}
                  TextOut(hWndDc, 22 * cxCaps + 40 * cxChar, cyChar * J, Buffer, wvsprintf(Buffer, '%5d', @OutList));
                  SetTextAlign(hWndDc, TA_LEFT or TA_TOP); // �˺�����������Ϊ���Ͻ�֮����
                end;

                EndPaint(hWndDc, PS); // ��������
              end;

    WM_DESTROY: PostQuitMessage(0); // ����WM_QUIT����GetMessage����FALSE

    else Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
  end;
end;

const
  AppName = 'SysMets1'; // ��������
  
var
  hWnd: LongWord;       // ������
  Msg: TMsg;            // ��Ϣ�ṹ
  WndClass: TWndClass;  // ������ṹ

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
  hWnd := CreateWindow(AppName, 'Get System Metrics No. 1',
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

