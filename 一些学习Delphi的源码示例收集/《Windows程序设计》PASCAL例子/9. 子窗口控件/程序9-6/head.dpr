program  head;

uses
  Windows, Messages;

var
  szFile: array[0..MAX_PATH] of Char; // ��ǰѡ���ļ�
  OldList: Pointer; // ��׼�б����Ϣ�������

   // �б����Ϣ�������
function ListProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  if (Msg = WM_KEYDOWN) and (wParam = VK_RETURN) then // ���س�����˫��
    SendMessage(GetParent(hWnd), WM_COMMAND, MAKELONG(1, LBN_DBLCLK), hWnd);
  Result := CallWindowProc(OldList, hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
end;

   // ��������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  ID_LIST = 1;
  ID_TEXT = 2;
  DTFLAGS = (DT_WORDBREAK or DT_EXPANDTABS or DT_NOCLIP or DT_NOPREFIX); // ���Ʊ�ʶ
  DIRATTR = (DDL_READWRITE or DDL_READONLY or DDL_HIDDEN or DDL_SYSTEM // �ļ�������
            or DDL_DIRECTORY or DDL_ARCHIVE or DDL_DRIVES);
  MAXREAD = 8192; // �ļ����ݻ������ߴ�           
{$J+}
  bValidFile: Boolean = FALSE; // ��ǰѡ������Ч�ļ�
  hWndList: LongWord = 0; // ListBox ���
  hWndText: LongWord = 0; // Static ���
  Rect: TRect = (Left: 0; Top: 0; Right: 0; Bottom: 0); // �ļ����������Χ
{$J-}
var
  hWndDc: HDC;
  ps: PAINTSTRUCT;
  J, cxChar, cyChar: Integer;
  szBuffer: array[0..MAX_PATH] of Char;         
  hFile: THANDLE;
  buffer: array[0..MAXREAD] of Byte; // �ļ�����
begin
  Result := 0;
 // ���ֲ�ͬ����Ϣ
  case Msg of
    WM_CREATE:
      begin
        cxChar := LOWORD(GetDialogBaseUnits());
        cyChar := HIWORD(GetDialogBaseUnits());
        Rect.Left := 20 * cxChar;
        Rect.Top := 3 * cyChar;

        hWndList := CreateWindow('listbox', nil,
                          WS_CHILDWINDOW or WS_VISIBLE or LBS_STANDARD,
                          cxChar, cyChar * 3,
                          cxChar * 15 + GetSystemMetrics(SM_CXVSCROLL),
                          cyChar * 20,
                          hWnd, ID_LIST,
                          GetWindowLong(hWnd, GWL_HINSTANCE),
                          nil);
        SendMessage(hWndList, LB_DIR, DIRATTR, Integer(PChar('*.*'))); // �о�
        OldList := Pointer(SetWindowLong(hWndList, GWL_WNDPROC, Integer(@ListProc)));

        GetCurrentDirectory(MAX_PATH + 1, szBuffer); // ��ǰ·��
        hWndText := CreateWindow('static', szBuffer,
                          WS_CHILDWINDOW or WS_VISIBLE or SS_LEFT,
                          cxChar, cyChar, cxChar * MAX_PATH, cyChar,
                          hWnd, ID_TEXT,
                          GetWindowLong(hWnd, GWL_HINSTANCE),
                          nil);
      end;

    WM_SIZE:
      begin
        Rect.Right := LOWORD(lParam);
        Rect.Bottom := HIWORD(lParam);
      end;

    WM_SETFOCUS:
      begin
        SetFocus(hWndList);
      end;

    WM_COMMAND:           // ListBox                     // ˫�����
      if (LOWORD(wParam) = ID_LIST) and (HIWORD(wParam) = LBN_DBLCLK) then
      begin
        J := SendMessage(hWndList, LB_GETCURSEL, 0, 0); // ��ǰѡ����Ŀ
        if (J = LB_ERR) then Exit;
        
        SendMessage(hWndList, LB_GETTEXT, J, Integer(@szBuffer[0])); // ȡ��ѡ��
        hFile := CreateFile(szBuffer, GENERIC_READ, FILE_SHARE_READ, // ���ļ�
                          nil, OPEN_EXISTING, 0, 0);
        if (INVALID_HANDLE_VALUE <> hFile) then
        begin
          CloseHandle(hFile); // �ر��ļ�
          
          bValidFile := TRUE; // ѡ������Ч�ļ�
          lstrcpy(szFile, szBuffer); // �����ļ����ַ���

          GetCurrentDirectory(MAX_PATH + 1, szBuffer); // ��ǰ·��
          if (szBuffer[lstrlen(szBuffer) - 1] <> '\') then  // '\' ��β
            lstrcat(szBuffer, '\');

          SetWindowText(hWndText, lstrcat(szBuffer, szFile)); // ·��+�ļ���
        end else
        begin
          bValidFile := FALSE; // δѡ����Ч�ļ�
          szBuffer[lstrlen(szBuffer) - 1] := #0; // ��ȥ���һ���ַ�']'

          if not SetCurrentDirectory(szBuffer + 1) then // �̷�(��'-')
          begin
           // '[-x-]' --> '[-x:'
            szBuffer[3] := ':';
            szBuffer[4] := #0;
           // ����Ϊ 'x:' 
            SetCurrentDirectory(szBuffer + 2);
          end;
          
          GetCurrentDirectory(MAX_PATH + 1, szBuffer); // ��ǰĿ¼
          SetWindowText(hWndText, szBuffer);
          
          SendMessage(hWndList, LB_RESETCONTENT, 0, 0); // ���
          SendMessage(hWndList, LB_DIR, DIRATTR, Integer(PChar('*.*'))); // �о�
        end;
        InvalidateRect(hWnd, nil, TRUE); // ˢ��(����WM_PAINT)
      end;

    WM_PAINT:
      begin
        if (not bValidFile) then // δѡ����Ч�ļ�
        begin
          Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ֻ��䱳��
          Exit;
        end;
        hFile := CreateFile(szFile, GENERIC_READ, FILE_SHARE_READ,
                         nil, OPEN_EXISTING, 0, 0);
        if (INVALID_HANDLE_VALUE = hFile) then // �ļ���ʧ��
        begin
          Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ֻ��䱳��
          bValidFile := FALSE;    Exit;
        end;
        ReadFile(hFile, buffer, MAXREAD, DWORD(J), nil); // �����ļ�
        CloseHandle(hFile); // �ر��ļ�

        hWndDc := BeginPaint(hWnd, ps);
        SelectObject(hWndDc, GetStockObject(SYSTEM_FIXED_FONT));
        SetTextColor(hWndDc, GetSysColor(COLOR_BTNTEXT));
        SetBkColor(hWndDc, GetSysColor(COLOR_BTNFACE));
        DrawTextA(hWndDc, @buffer[0], DWORD(J), Rect, DTFLAGS);         
        EndPaint(hWnd, ps);
      end;


    WM_DESTROY:
      PostQuitMessage(0); // ��һ���˳���ϢWM_QUIT

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end; 

  
const
  szAppName = 'head';

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
  WndClass.hbrBackground :=  COLOR_WINDOW + 1;
  WndClass.lpszMenuName := nil;
  WndClass.lpszClassName := szAppName;

 // ע�ᴰ����
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(szAppName, 'head',
                       WS_OVERLAPPEDWINDOW or WS_CLIPCHILDREN,
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

(*  ע��,�˳����������ļ�ʧ��,һ�ɵ���Ŀ¼or�̷����� *)  
end.
