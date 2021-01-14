program  Typer;

uses
  Windows, Messages, Math;

  // ������Ϣ����ص�����                  
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
  {$J+}
  dwCharSet: DWORD = DEFAULT_CHARSET; // ��ǰ���̲��ֶ�Ӧ�ַ���
  cxChar: Integer = 0;       // (�ȿ�)�ַ����
  cyChar: Integer = 0;       // (�ȿ�)�ַ��߶�
  cxClient: Integer = 0;     // ����ͻ������
  cyClient: Integer = 0;     // ����ͻ����߶�
  pBuffer: PChar = nil;      // �ַ���������
  cxBuffer: Integer = 0;     // ����������
  cyBuffer: Integer = 0;     // ��������߶�
  xCaret: Integer = 0;       // ������ź�����
  yCaret: Integer = 0;       // �������������  
  {$J+}
 // �����ά�����Ա��ַ
  function Pt(Y, X: Integer): PChar;
  begin
    Result := PChar( DWORD(pBuffer) + Y * cxBuffer + X );
  end;  
var
  hWndDc: HDC;
  PS: TPaintStruct;
  TM: TTextMetric;
  X, Y, J: Integer;  
begin
  Result := 0;
  case Msg of
    WM_INPUTLANGCHANGE,
    WM_CREATE,
    WM_SIZE: begin
               if (Msg = WM_INPUTLANGCHANGE) then dwCharSet := wParam; // ���ַ���
               
               if (Msg = WM_SIZE) then
               begin
                 cxClient := LOWORD(lParam);  cyClient := HIWORD(lParam);
               end else
               begin // ��ǰ�ַ���(�ȿ�)�ַ��ߴ�
                 hWndDc := GetDC(hWnd);
                 SelectObject(hWndDc, CreateFont(0, 0, 0, 0, 0, 0, 0, 0, dwCharSet,
                   0, 0, 0, FIXED_PITCH, nil));
                 GetTextMetrics(hWndDc, TM);
                 cxChar := TM.tmAveCharWidth;
                 cyChar := TM.tmHeight;
                 DeleteObject(SelectObject(hWndDc, GetStockObject(SYSTEM_FONT)));
                 ReleaseDC(hWnd, hWndDc);
               end;
               
              // �����ڴ�
               if (pBuffer <> nil) then FreeMem(pBuffer, cxBuffer * cyBuffer);
               cxBuffer := Max(1, cxClient div cxChar);
               cyBuffer := Max(1, cyClient div cyChar);
               GetMem(pBuffer, cxBuffer * cyBuffer);
               FillChar(pBuffer^, cxBuffer * cyBuffer, Byte(' '));

              // Ԥ�ù��
               xCaret := 0;  yCaret := 0;
               if(hWnd = GetFocus) then SetCaretPos(0, 0);
               
              // ��������
               InvalidateRect(hWnd, nil, TRUE);
             end;

    WM_SETFOCUS: begin // ������ʾ'�������'
                   CreateCaret(hWnd, 0, cxChar, cyChar);
                   SetCaretPos(xCaret * cxChar, yCaret * cyChar);
                   ShowCaret(hWnd);
                 end;

    WM_KILLFOCUS: begin // ����ɾ��'�������'
                    HideCaret(hWnd);
                    DestroyCaret;
                  end;

    WM_KEYDOWN: begin
                  case wParam of
                    VK_HOME   : xCaret := 0;
                    VK_END    : xCaret := cxBuffer - 1;
                    VK_PRIOR  : yCaret := 0;
                    VK_NEXT   : yCaret := cyBuffer - 1;
                    VK_LEFT   : xCaret := Max(xCaret - 1, 0);
                    VK_RIGHT  : xCaret := Min(xCaret + 1, cxBuffer - 1);
                    VK_UP     : yCaret := Max(yCaret - 1, 0);
                    VK_DOWN   : yCaret := Min(yCaret + 1, cyBuffer - 1);
                    VK_DELETE : begin
                                 // ǰ�Ƹ���xCaret����β��Ϊ' '
                                  for X := xCaret to cxBuffer - 2 do
                                    Pt(yCaret, X)^ := Pt(yCaret, X + 1)^;
                                  Pt(yCaret, cxBuffer - 1)^ := ' ';
                                 // ���ػ�仯�Ĳ������� 
                                  HideCaret(hWnd);
                                  hWndDc := GetDC(hWnd);
                                  SelectObject(hWndDc, CreateFont(0, 0, 0, 0, 0, 0,
                                    0, 0, dwCharSet, 0, 0, 0, FIXED_PITCH, nil));
                                  TextOut(hWndDc, xCaret * cxChar, yCaret * cyChar,
                                    Pt(yCaret, xCaret), cxBuffer - xCaret);
                                  DeleteObject(SelectObject(hWndDc, GetStockObject(SYSTEM_FONT)));
                                  ReleaseDC(hWnd, hWndDc);
                                  ShowCaret(hWnd);
                               end;
                  end; // END CASE  ....
                  SetCaretPos(xCaret * cxChar, yCaret * cyChar);
                end;

    WM_CHAR: begin            // �ظ�����
               for J := 1 to LOWORD(lParam) do
               begin
                 case wParam of
                   $08: begin  // �ظ�, ת��Del��
                          if (xCaret > 0) then
                          begin
                            Dec(xCaret);
                            SendMessage(hWnd, WM_KEYDOWN, VK_DELETE, 1);
                          end;
                        end;

                   $09: begin  // TAB, ת�ɿո�
                          repeat SendMessage(hWnd, WM_CHAR, $20, 1);
                          until (xCaret mod 8) = 0; 
                        end;

                   $0A: begin  // ����
                          Inc(yCaret);
                          if yCaret = cyBuffer then yCaret := 0 ;
                        end;

                   $0D: begin  // �س�
                          xCaret := 0;
                          Inc(yCaret);
                          if yCaret = cyBuffer then yCaret := 0 ;
                        end;
                        
                   $1B: begin  // ESC, ���
                          FillChar(pBuffer^, cxBuffer * cyBuffer, Byte(' '));
                          xCaret := 0 ;
                          yCaret := 0 ;
                          InvalidateRect(hWnd, nil, FALSE);
                        end;

                   else begin  // ��ͨ�ַ�
                          Pt(yCaret, xCaret)^ := Char(wParam);
                         // �ػ汻���ǵ��ַ�
                          HideCaret(hWnd);
                          hWndDc := GetDC(hWnd);
                          SelectObject(hWndDc, CreateFont(0, 0, 0, 0, 0, 0, 0, 0,
                              dwCharSet, 0, 0, 0, FIXED_PITCH, nil));
                          TextOut(hWndDc, xCaret * cxChar, yCaret * cyChar,
                              Pt(yCaret, xCaret), 1);
                          DeleteObject(SelectObject(hWndDc, GetStockObject(SYSTEM_FONT)));
                          ReleaseDC(hWnd, hWndDc);
                          ShowCaret(hWnd);
                         // �޸�'�������'λ��
                          Inc(xCaret);
                          if (xCaret = cxBuffer) then
                          begin
                            xCaret := 0 ;
                            Inc(yCaret);
                            if (yCaret = cyBuffer) then yCaret := 0;
                          end;
                        end;
                 end; // END CASE ....
               end; // END FOR ....
               SetCaretPos(xCaret * cxChar, yCaret * cyChar);
             end;

    WM_PAINT: begin
                hWndDc := BeginPaint(hWnd, PS);
                
                SelectObject(hWndDc, CreateFont(0, 0, 0, 0, 0, 0, 0, 0, dwCharSet, 0, 0, 0, FIXED_PITCH, nil));

                for Y := 0 to (cyBuffer - 1) do // ���Ƹ���
                  TextOut(hWndDc, 0, Y * cyChar, Pt(Y, 0), cxBuffer);

                DeleteObject(SelectObject(hWndDc, GetStockObject(SYSTEM_FONT)));

                EndPaint(hWnd, PS);
              end;

    WM_DESTROY: PostQuitMessage(0); // ��WM_QUIT��Ϣ

    else Result := DefWindowProc(hWnd, Msg, wParam, lParam); // Ĭ�ϴ���
  end;
end;


const
  AppName = 'Typer'; // ��������

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
  hWnd := CreateWindow(AppName, 'Typing Program',
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

        


