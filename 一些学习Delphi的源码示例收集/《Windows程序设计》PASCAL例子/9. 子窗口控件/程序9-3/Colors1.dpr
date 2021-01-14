program  Colors1;

uses
  Windows, Messages, Math;

var
  idFocus: Integer; // ��ǰ���������ID
  OldScroll: array[0..2] of Pointer; // ԭ�������������

   // �����ؼ���Ϣ�������
function ScrollProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  id : Integer;
begin
  id := GetWindowLong(hWnd, GWL_ID); // �ؼ�ID
  case Msg of
    WM_KEYDOWN:
      if (wParam = VK_TAB) then  // ��ת���㵽����������
        if (GetKeyState(VK_SHIFT) < 0) then
          SetFocus(GetDlgItem(GetParent(hWnd), (id + 2) mod 3))
        else
          SetFocus(GetDlgItem(GetParent(hWnd), (id + 1) mod 3));
          
    WM_SETFOCUS:
      idFocus := id; // ���潹��ID
  end;
  Result := CallWindowProc(OldScroll[id], hWnd, Msg, wParam, lParam); // ��׼����
end;

   // ��������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  crPrim: array[0..2] of COLORREF = ( $FF, $FF00, $FF0000 ); // ������
  szColorLabel: array[0..2] of PChar = ('Red', 'Green', 'Blue'); // ����
{$J+}
  hBrush: array[0..2] of DWORD = (0, 0, 0); // �������ؼ�������ˢ
  hBrushStatic: DWORD = 0; // ����Static�ؼ�������ˢ
  hWndScroll: array[0..2] of DWORD = (0, 0, 0); // �������ؼ����
  hWndLabel: array[0..2] of DWORD = (0, 0, 0); // ���⾲̬�ı����
  hWndValue: array[0..2] of DWORD = (0, 0, 0); // ��ֵ��̬�ı����
  hWndRect: DWORD = 0; // ��̬���οؼ����(��ɫ����)
  Color: array[0..2] of Integer = (0, 0, 0); // ��ԭɫ(Ҳ�����������ǰλ��)
  cyChar: Integer = 0; // �ڶ��ַ��߶�
  rcColor: TRect = (Left: 0; Top: 0; Right: 0; Bottom: 0); // '��ɫ'��䷶Χ
{$J-}
var
  J, cxClient, cyClient: Integer;
  szBuffer: array[0..10] of Char;
begin
  Result := 0;
  case Msg of
    WM_CREATE:
      begin
       // ��̬����(��ɫ����, ID: 9)
        hWndRect := CreateWindow('static', nil,
                       WS_CHILD or WS_VISIBLE or SS_WHITERECT,
                       0, 0, 0, 0, hWnd, 9, hInstance, nil);
        for J := 0 to 2 do
        begin
         // ������(ID: 0~2)
          hWndScroll[J] := CreateWindow('scrollbar', nil,
                                  WS_CHILD or WS_VISIBLE or WS_TABSTOP or SBS_VERT,
                                  0, 0, 0, 0, hWnd, J, hInstance, nil);
          SetScrollRange(hWndScroll[J], SB_CTL, 0, 255, FALSE);
          SetScrollPos(hWndScroll[J], SB_CTL, 0, FALSE);
         // ����(ID: 3~5)
          hWndLabel[J] := CreateWindow('static', szColorLabel[J],
                                 WS_CHILD or WS_VISIBLE or SS_CENTER,
                                 0, 0, 0, 0, hWnd, J + 3, hInstance, nil);
         // ��ֵ(ID: 6~8)
          hWndValue[J] := CreateWindow('static', '0',
                                 WS_CHILD or WS_VISIBLE or SS_CENTER,
                                 0, 0, 0, 0, hWnd, J + 6, hInstance, nil);
         // '���໯'������
          OldScroll[J] := Pointer(SetWindowLong(hWndScroll[J], GWL_WNDPROC, Integer(@ScrollProc)));
         // ������������ˢ
          hBrush[J] := CreateSolidBrush(crPrim[J]);
        end;
        hBrushStatic := CreateSolidBrush(GetSysColor(COLOR_BTNHIGHLIGHT)); // ����Static������ˢ
        cyChar := HIWORD(GetDialogBaseUnits()); // �ڶ��ַ��߶�
      end;

    WM_SIZE:
      begin
        cxClient := LOWORD(lParam);
        cyClient := HIWORD(lParam);                                      
        SetRect(rcColor, cxClient div 2, 0, cxClient, cyClient); // '��ɫ'�������
        MoveWindow(hWndRect, 0, 0, cxClient div 2, cyClient, TRUE); // ��̬����(��ɫ)
        for J := 0 to 2 do // ���������ؼ�
        begin
          MoveWindow(hWndScroll[J], (2 * J + 1) * cxClient div 14, 2 * cyChar,
                  cxClient div 14, cyClient - 4 * cyChar, TRUE);
          MoveWindow(hWndLabel[J], (4 * J + 1) * cxClient div 28, cyChar div 2,
                  cxClient div 7, cyChar, TRUE);
          MoveWindow(hWndValue[J], (4 * J + 1) * cxClient div 28,
                  cyClient - 3 * cyChar div 2, cxClient div 7, cyChar, TRUE);
        end;
        SetFocus(hWnd); // ����������Ӱ����
      end;

    WM_SETFOCUS:
      SetFocus(hWndScroll[idFocus]); // ����ת��������

    WM_VSCROLL:
      begin
        J := GetWindowLong(lParam, GWL_ID); // ��������������ID(��Ӧ�����±�)
        case LOWORD(wParam) of
          SB_PAGEDOWN:
            Color[J] := Min(255, Color[J] + 16);

          SB_LINEDOWN:
            Color[J] := Min(255, Color[J] + 1);

          SB_PAGEUP:
            Color[J] := Max(0, Color[J] - 16);

          SB_LINEUP:
            Color[J] := Max(0, Color[J] - 1);

          SB_TOP:
            Color[J] := 0;

          SB_BOTTOM:
            Color[J] := 255;

          SB_THUMBPOSITION,
          SB_THUMBTRACK:
            Color[J] := HIWORD(wParam);
        end;
        SetScrollPos(hWndScroll[J], SB_CTL, color[J], TRUE); // ����λ��
        wvsprintf(szBuffer, '%i', @Color[J]); // IntToStr --> szBuffer
        SetWindowText(hWndValue[J], szBuffer); // ��ɫ��ֵ
        DeleteObject(SetClassLong(hWnd, GCL_HBRBACKGROUND, // ���������屳����ˢ
                  CreateSolidBrush(RGB(Color[0], Color[1], Color[2]))));
        InvalidateRect(hWnd, @rcColor, TRUE); // ˢ��
      end;

    WM_CTLCOLORSCROLLBAR: 
      begin
        J := GetWindowLong(lParam, GWL_ID);
        Result := hBrush[J]; // ����������ˢ��
      end;

    WM_CTLCOLORSTATIC:
      begin
        J := GetWindowLong(lParam, GWL_ID);
        if (J >= 3) and (J <= 8) then  // ��̬���ֿؼ�
        begin
          SetTextColor(wParam, crPrim[J mod 3]);
          SetBkColor(wParam, GetSysColor(COLOR_BTNHIGHLIGHT));
          Result := hBrushStatic;
        end;
      end;  

    WM_SYSCOLORCHANGE:
      begin
        DeleteObject(hBrushStatic);
        hBrushStatic := CreateSolidBrush(GetSysColor(COLOR_BTNHIGHLIGHT));
      end;

    WM_DESTROY:
      begin
        PostQuitMessage(0); // ����WM_QUITʹ��Ϣѭ������
        DeleteObject(SetClassLong(hWnd, GCL_HBRBACKGROUND, GetStockObject(WHITE_BRUSH))); // ѡ����ɾ��
        for J:= 0 to 2 do DeleteObject(hBrush[J]);
        DeleteObject(hBrushStatic);
      end;
      
    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;   

const            
  AppName = 'Colors1';
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
  WndClass.hbrBackground := CreateSolidBrush(0); // ��ɫ
  WndClass.lpszMenuName := nil;
  WndClass.lpszClassName := AppName;
 // ע�ᴰ����
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', AppName, MB_ICONERROR);
    Exit;
  end;
 // ��������
  hWnd := CreateWindow(AppName, 'Color Scroll',
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
