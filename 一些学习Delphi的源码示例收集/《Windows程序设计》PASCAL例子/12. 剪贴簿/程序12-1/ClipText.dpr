program  ClipText;

{$R  ClipText.Res}

uses
  Windows, Messages;

  // ������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+}
  pText: PChar = nil; // �ַ�������
{$J-}
  szDefaultText  = 'Default Text - ANSI Version';
  IDM_EDIT_CUT   = 40001;
  IDM_EDIT_COPY  = 40002;
  IDM_EDIT_PASTE = 40003;
  IDM_EDIT_CLEAR = 40004;
  IDM_EDIT_RESET = 40005;
var
  iEnable: Integer;
  hWndDc: HDC;
  ps: TPaintStruct;
  Rect: TRect;
  hGlobal: DWORD;
  pGlobal: PChar;  
begin
  Result := 0;
 // ���ֲ�ͬ����Ϣ
  case Msg of
    WM_CREATE:
      SendMessage(hWnd, WM_COMMAND, IDM_EDIT_RESET, 0); // ������ΪszDefaultText

    WM_INITMENUPOPUP:
      begin
        if IsClipboardFormatAvailable(CF_TEXT) then
          EnableMenuItem(wParam,IDM_EDIT_PASTE, MF_ENABLED)
        else
          EnableMenuItem(wParam,IDM_EDIT_PASTE, MF_GRAYED);

        if pText <> nil then iEnable := MF_ENABLED else iEnable := MF_GRAYED;
        EnableMenuItem(wParam, IDM_EDIT_CUT, iEnable);
        EnableMenuItem(wParam, IDM_EDIT_COPY, iEnable);
        EnableMenuItem(wParam, IDM_EDIT_CLEAR, iEnable);
      end;

    WM_COMMAND:
      begin
        case LOWORD(wParam) of
          IDM_EDIT_PASTE: // ճ�� ..
            begin
              OpenClipboard(hWnd); // �򿪼�����
              hGlobal := GetClipboardData(CF_TEXT); // �ڴ����
              if (hGlobal <> 0) then // ����CF_TEXT��ʽ��Ϣ
              begin
                pGlobal := GlobalLock(hGlobal); // �ڴ���ַ
                if (pText <> nil) then // ���·����ַ�������ռ�
                begin
                  FreeMem(pText); pText := nil;
                end;
                GetMem(pText, GlobalSize(hGlobal));
                lstrcpy(pText, pGlobal); // ����
                InvalidateRect(hWnd, nil, TRUE); // ��ʹ����ˢ��
              end;
              CloseClipboard(); // �رռ�����
            end;

          IDM_EDIT_CUT,  // ���� ..
          IDM_EDIT_COPY: // ���� ..
            begin
              if (pText = nil) then Exit;
              hGlobal := GlobalAlloc(GHND or GMEM_SHARE, (lstrlen(pText) + 1)); // �����ڴ�
              pGlobal := GlobalLock(hGlobal); // ����
              lstrcpy(pGlobal, pText); // ����
              GlobalUnlock(hGlobal); // ����
              OpenClipboard(hWnd); // �򿪼�����
              EmptyClipboard(); // ��ռ�����
              SetClipboardData(CF_TEXT, hGlobal); // д��
              CloseClipboard(); // �رռ�����
              if (LOWORD(wParam) = IDM_EDIT_CUT) then // ִ��"���"
                SendMessage(hWnd, WM_COMMAND, IDM_EDIT_CLEAR, 0);
            end;

          IDM_EDIT_CLEAR: // ��� ..
            begin
              if (pText <> nil) then
              begin
                FreeMem(pText);
                pText := nil;
              end;
              InvalidateRect(hWnd, nil, TRUE); // ˢ��
            end;

          IDM_EDIT_RESET: // ���� ..
            begin
              if (pText <> nil) then
              begin
                FreeMem(pText);
                pText := nil;
              end;   
              GetMem(pText, lstrlen(szDefaultText) + 1); // ���������ַ�������ռ�
              lstrcpy(pText, szDefaultText); // ����
              InvalidateRect(hWnd, nil, TRUE); // ˢ��
            end;

          else
            Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
        end;   
      end;

    WM_PAINT:
      begin
        hWndDc := BeginPaint(hWnd, ps);
        if (pText <> nil) then
        begin
          GetClientRect(hWnd, Rect);
          DrawText(hWndDc, pText, -1, Rect, DT_EXPANDTABS or DT_WORDBREAK);
        end;
        EndPaint(hWnd, ps);
      end;


    WM_DESTROY:
      begin
        if (pText <> nil) then FreeMem(pText);
        PostQuitMessage(0); // ��һ���˳���ϢWM_QUIT
      end;

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;

const
  szAppName = 'ClipText';
  szCaption = 'Clipboard Text Transfers - ANSI Version';
var
  hWnd, hAccel: DWORD;
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
  WndClass.lpszMenuName := szAppName;
  WndClass.lpszClassName := szAppName;

 // ע�ᴰ����
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(szAppName, szCaption,
                       WS_OVERLAPPEDWINDOW,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       0, 0, hInstance, nil);

 // ��ʾ����
  ShowWindow(hWnd, CmdShow);
  UpdateWindow(hWnd);

 // ������ټ�
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
