program  Colors2;

{$R  Colors2.res}

uses
  Windows, Messages, Math;

  // ������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  case Msg of
    WM_DESTROY:
      begin
        PostQuitMessage(0); // �˳���Ϣѭ��
        DeleteObject(SetClassLong(hWnd, GCL_HBRBACKGROUND, GetStockObject(WHITE_BRUSH)));
        Result := 0;
      end;

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;
  
  // �Ի�����Ϣ���չ���
function ColorScrDlg(hDlg: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
const
{$J+}
  iColor: array[0..2] of Integer = (0, 0, 0); // ����ԭɫֵ(Ҳ�ǽ�����λ��)
{$J-}
var
  hWndParent, hCtrl: LongWord;
  iCtrlID, iIndex: Integer;
begin
  Result := FALSE;
  case Msg of
    WM_INITDIALOG:
      begin
        for iCtrlID := 10 to 12 do // ��ʼ��������
        begin
          hCtrl := GetDlgItem(hDlg, iCtrlID);
          SetScrollRange(hCtrl, SB_CTL, 0, 255, FALSE);
          SetScrollPos(hCtrl, SB_CTL, 0, FALSE);
        end;
        Result := TRUE;
      end;

    WM_VSCROLL:
      begin
        hCtrl := lParam; // �ؼ����
        iCtrlID := GetWindowLong(hCtrl, GWL_ID); // �ؼ�ID
        iIndex := iCtrlID - 10; // �����±�
        hWndParent := GetParent(hDlg); // �Ի�����������
        case LOWORD(wParam) of // ����������
          SB_PAGEDOWN:
            iColor[iIndex] := Min(255, iColor[iIndex] + 16);

          SB_LINEDOWN:
            iColor[iIndex] := Min(255, iColor[iIndex] + 1);

          SB_PAGEUP:
            iColor[iIndex] := Max(0, iColor[iIndex] - 16);

          SB_LINEUP:
            iColor[iIndex] := Max(0, iColor[iIndex] - 1);

          SB_TOP:
            iColor[iIndex] := 0 ;

          SB_BOTTOM:
            iColor[iIndex] := 255;

          SB_THUMBPOSITION,
          SB_THUMBTRACK:
            iColor[iIndex] := HIWORD(wParam);
            
          else Exit; // Return FALSE;
        end;
        SetScrollPos(hCtrl, SB_CTL, iColor[iIndex], TRUE); // ������λ��
        SetDlgItemInt(hDlg, iCtrlID + 3, iColor[iIndex], FALSE); // ��̬����
        DeleteObject(SetClassLong(hWndParent, GCL_HBRBACKGROUND, // ������ˢ
                  CreateSolidBrush(RGB(iColor[0], iColor[1], iColor[2]))));
        InvalidateRect(hWndParent, nil, TRUE); // ˢ��
        Result := TRUE;
      end;
  end;
end;     

const
  szAppName = 'Colors2';
var
  Msg: TMsg;
  hWnd, hDlgModeless: LongWord;
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
  WndClass.hbrBackground := CreateSolidBrush(0);
  WndClass.lpszMenuName := nil;
  WndClass.lpszClassName := szAppName;
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(szAppName, 'Color Scroll',
                       WS_OVERLAPPEDWINDOW or WS_CLIPCHILDREN,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       0, 0, hInstance, nil);

 // ��ʾ����
  ShowWindow(hWnd, CmdShow);
  UpdateWindow(hWnd);

 // �����Ի���
  hDlgModeless := CreateDialog(hInstance, 'ColorScrDlg', hWnd, @ColorScrDlg);

 // ��Ϣѭ��
  while GetMessage(Msg, 0, 0, 0) do
  begin
    if (not IsDialogMessage(hDlgModeless, Msg)) then
    begin
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end;
  end;
end.
