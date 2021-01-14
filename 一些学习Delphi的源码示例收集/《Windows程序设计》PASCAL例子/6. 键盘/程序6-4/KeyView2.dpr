program  KeyView2;

uses
  Windows, Messages, Math;

  // ������Ϣ����ص�����
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
    // ���������Ա��ַ
  function Pt(FirstPt: PMsg; Index: Integer): PMsg;
  begin
    Result := PMsg( DWORD(FirstPt) + Index * SizeOf(TMsg) );
  end;
const
  {$J+}
  dwCharSet: DWORD = DEFAULT_CHARSET; // ��ǰ���̲��ֶ�Ӧ�ַ���
  cyChar: Integer = 0;       // �ַ��߶�
  cxClient: Integer = 0;     // ����ͻ������
  cyClient: Integer = 0;     // ����ͻ����߶�
  cxClientMax: Integer = 0;  // ������󻯿��
  cyClientMax: Integer = 0;  // ������󻯸߶�
  cLinesMax: Integer = 0;    // ����������
  cLines: Integer = 0;       // �ѱ�������
  MsgList: PMsg = nil;       // ��Ϣ��������
  RectScroll: TRect = (Left: 0; Top: 0; Right: 0; Bottom: 0);
  {$J+}
  szTop = ' Message        Key       Char     Repeat Scan Ext ALT Prev Tran';
  szUnd = ' _______        ___       ____     ______ ____ ___ ___ ____ ____';
  szKeyFormat = ' %-13s %3d %-15s %6u %4d %3s %3s %4s %4s';
  szCharFormat = ' %-24s 0x%04X %c %6u %4d %3s %3s %4s %4s';
  szMessage: array[WM_KEYDOWN..WM_SYSDEADCHAR] of PChar= ('WM_KEYDOWN', 'WM_KEYUP',
    'WM_CHAR', 'WM_DEADCHAR', 'WM_SYSKEYDOWN', 'WM_SYSKEYUP', 'WM_SYSCHAR', 'WM_SYSDEADCHAR');
  szYes  = 'Yes';
  szNo   = 'No';
  szDown = 'Down';
  szUp   = 'Up';
var
  hWndDc: HDC;
  PS: TPaintStruct;
  TM: TTextMetric;
  szBuffer: array [0..128] of Char; // ����ַ���
  szKeyName: array [0..32] of Char; // �����ַ���
  OutList: array[0..8] of DWORD; // (��)ת���б�
  J: Integer;
begin
  Result := 0;
  case Msg of
    WM_INPUTLANGCHANGE,
    WM_CREATE,
    WM_DISPLAYCHANGE,
    WM_SIZE: begin

               if (Msg = WM_INPUTLANGCHANGE) then
               begin
                 dwCharSet := wParam;
                 Result := 1; // TRUE
               end;
               if (Msg = WM_SIZE) then
               begin
                 cxClient := LOWORD(lParam);
                 cyClient := HIWORD(lParam);
               end else
               begin
                // ������󻯳ߴ�
                 cxClientMax := GetSystemMetrics(SM_CXMAXIMIZED);
                 cyClientMax := GetSystemMetrics(SM_CYMAXIMIZED);
                // ָ���ַ�������߶�
                 hWndDc := GetDC(hWnd);
                 SelectObject(hWndDc, CreateFont(0, 0, 0, 0, 0, 0, 0, 0,
                     dwCharSet, 0, 0, 0, FIXED_PITCH, nil));
                 GetTextMetrics(hWndDc, TM);
                 cyChar := TM.tmHeight;
                 DeleteObject(SelectObject(hWndDc, GetStockObject(SYSTEM_FONT)));
                 ReleaseDC(hWnd, hWndDc) ;
                // ���·����ڴ�
                 if (MsgList <> nil) then FreeMem(MsgList, cLinesMax * SizeOf(TMsg));
                 cLinesMax := cyClientMax div cyChar;
                 GetMem(MsgList, cLinesMax * SizeOf(TMsg));
                 cLines := 0;
               end;

               RectScroll.Left := 0;
               RectScroll.Right := cxClient;
               RectScroll.Top := cyChar;
               RectScroll.Bottom := cyChar * (cyClient div cyChar);
               InvalidateRect(hWnd, nil, TRUE);
               
             end; // ........  end case  .....  ^^

    WM_KEYDOWN,
    WM_KEYUP,
    WM_DEADCHAR,
    WM_SYSKEYDOWN,
    WM_SYSKEYUP,
    WM_SYSCHAR,
    WM_SYSDEADCHAR,
    WM_CHAR: begin
               Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
               for J := cLines downto 1 do // �ڳ���λ
                 Pt(MsgList, J)^ := Pt(MsgList, J-1)^;
               MsgList.hwnd := hWnd; // MsgList[0] := ...
               MsgList.message := Msg;
               MsgList.wParam := wParam;
               MsgList.lParam := lParam;
               cLines := Min(cLines + 1, cLinesMax); // �ѱ�������
               ScrollWindow(hWnd, 0, -cyChar, @RectScroll, @RectScroll); // ����
             end;

    WM_PAINT: begin
                hWndDc := BeginPaint(hWnd, PS);

                SelectObject(hWndDc, CreateFont (0, 0, 0, 0, 0, 0, 0, 0, // ѡ�봴��������
                           dwCharSet, 0, 0, 0, FIXED_PITCH, nil));
                SetBkMode(hWndDc, TRANSPARENT); // ����ʱ������϶(͸��)
                TextOut(hWndDc, 0, 0, szTop, lstrlen(szTop)); // ����
                TextOut(hWndDc, 0, 0, szUnd, lstrlen(szUnd)); // �»���
                for J := 0 to Min(cLines, cyClient div cyChar - 1)-1 do // �Ѵ�����or��������
                begin
                  OutList[0] := DWORD(szMessage[Pt(MsgList, J)^.message]); // ��Ϣ�����ַ���
                  OutList[1] := Pt(MsgList, J)^.wParam; // �����ֵ
                  OutList[3] := LOWORD(Pt(MsgList, J)^.lParam); // �ظ�����
                  OutList[4] := HIWORD(Pt(MsgList, J)^.lParam) and $FF; // ɨ����
                  if (Pt(MsgList, J)^.lParam and $01000000) <> 0 // ��������
                  then OutList[5] := DWORD(PChar(szYes))
                  else OutList[5] := DWORD(PChar(szNo));
                  if (Pt(MsgList, J)^.lParam and $20000000) <> 0 // ALT������?
                  then OutList[6] := DWORD(PChar(szYes))
                  else OutList[6] := DWORD(PChar(szNo));
                  if (Pt(MsgList, J)^.lParam and $40000000) <> 0 // ��ǰ״̬
                  then OutList[7] := DWORD(PChar(szDown))
                  else OutList[7] := DWORD(PChar(szUp));
                  if (Pt(MsgList, J)^.lParam and $80000000) <> 0 // ת��״̬
                  then OutList[8] := DWORD(PChar(szUp))
                  else OutList[8] := DWORD(PChar(szDown));
                  if (Pt(MsgList, J)^.message = WM_SYSDEADCHAR)or
                     (Pt(MsgList, J)^.message = WM_DEADCHAR)or
                     (Pt(MsgList, J)^.message = WM_SYSCHAR)or
                     (Pt(MsgList, J)^.message = WM_CHAR) then
                  begin // �ַ���Ϣ
                    OutList[2] := Pt(MsgList, J)^.wParam; // �ַ�����
                    TextOut(hWndDc, 0, (cyClient div cyChar - 1 - J) * cyChar,
                      szBuffer, wvsprintf(szBuffer, szCharFormat, @OutList));
                  end else
                  begin // ������Ϣ
                    GetKeyNameText(Pt(MsgList, J)^.lParam, szKeyName, 32); // ����
                    OutList[2] := DWORD(@szKeyName[0]);
                    TextOut(hWndDc, 0, (cyClient div cyChar - 1 - J) * cyChar,
                      szBuffer, wvsprintf(szBuffer, szKeyFormat, @OutList));
                  end;
                end;
                DeleteObject(SelectObject(hWndDc, GetStockObject(SYSTEM_FONT))); // ɾ������

                EndPaint(hWnd, PS);
              end;

    WM_DESTROY: PostQuitMessage(0); // ��WM_QUIT��Ϣ

    else Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
  end;
end;


const
  AppName = 'KeyView2'; // ��������

var
  WndClass: TWndClass;  // ������ṹ
  hWnd: LongWord;       // ������
  Msg: TMsg;            // ��Ϣ�ṹ
  
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
    MessageBox(0,'This program requires Windows NT!', AppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(AppName, 'Keyboard Message Viewer #2',
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

        


