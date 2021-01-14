program  ClipView;

uses
  Windows, Messages;

  // ������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+}
  hWndNextViewer: Longint = 0; // ��һ�����Ӵ���
{$J-}
var
  hWndDc: HDC;
  ps: TPaintStruct;
  Rect: TRect;
  hGlobal: DWORD;
  pGlobal: PChar;
begin
  Result := 0;
  case Msg of
    WM_CREATE:
      hWndNextViewer := SetClipboardViewer(hWnd); // ��Ӽ��Ӵ���

    WM_CHANGECBCHAIN:
      begin
        if (wParam = hWndNextViewer) then // ��ժ��������һ�����Ӵ���
          hWndNextViewer := lParam
        else
          if (hWndNextViewer <> 0) then
            SendMessage(hWndNextViewer, Msg, wParam, lParam); // ������һ�����Ӵ���
      end;

    WM_DRAWCLIPBOARD:
      begin
        if (hWndNextViewer <> 0) then
          SendMessage(hWndNextViewer, Msg, wParam, lParam); // ������һ�����Ӵ���
        InvalidateRect(hWnd, nil, TRUE); // �ػ�(����������������)
      end;

    WM_PAINT:
      begin
        hWndDc := BeginPaint(hWnd, ps);

        GetClientRect(hWnd, Rect); // ����ͻ�����Χ
        OpenClipboard(hWnd); // �򿪼�����
        hGlobal := GetClipboardData(CF_TEXT); // ȡ��������Ϣ�ڴ��
        if (hGlobal <> 0) then // ȡ��
        begin
          pGlobal := GlobalLock(hGlobal); // ����
          DrawText(hWndDc, pGlobal, -1, Rect, DT_EXPANDTABS); // ����
          GlobalUnlock(hGlobal); // ����
        end;
        CloseClipboard(); // �رռ�����

        EndPaint(hWnd, ps);
      end;

    WM_DESTROY:
      begin
        PostQuitMessage(0); // ��һ��WM_QUIT��Ϣ
        ChangeClipboardChain(hWnd, hWndNextViewer); // �Ӽ��Ӵ�������ժ��
      end;

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;

const
  szAppName = 'ClipView';
var
  hWnd: DWORD;
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
  WndClass.lpszClassName := szAppName;

 // ע�ᴰ����
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(szAppName, 'Simple Clipboard Viewer (Text Only)',
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
