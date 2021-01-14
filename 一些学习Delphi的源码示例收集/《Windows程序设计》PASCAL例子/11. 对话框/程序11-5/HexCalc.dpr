program  HexCalc;

{$R  HexCalc.res}

uses
  Windows, Messages;

  // ����ID=VK_ESCAPE��ť����
procedure ShowNumber(hWnd: HWND; iNumber: DWORD);
var
  szBuffer: array[0..8] of Char;
begin
  wvsprintf(szBuffer, '%X', @iNumber);
  SetDlgItemText(hWnd, VK_ESCAPE, szBuffer);
end;

  // ˫Ŀ����
function CalcIt(iFirstNum: DWORD; iOperation: Char; iNum: DWORD): DWORD;
begin
  case iOperation of
    '=': Result := iNum;
    '+': Result := iFirstNum + iNum;
    '-': Result := iFirstNum - iNum;
    '*': Result := iFirstNum * iNum;
    '&': Result := iFirstNum and iNum;
    '|': Result := iFirstNum or  iNum;
    '^': Result := iFirstNum xor iNum;
    '<': Result := iFirstNum shl iNum;
    '>': Result := iFirstNum shr iNum;
    '/': if iNum = 0 then Result := MAXDWORD else Result := iFirstNum div iNum;
    '%': if iNum = 0 then Result := MAXDWORD else Result := iFirstNum mod iNum;
    else Result := 0;
  end;
end;

  // ������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+}
  bNewNumber: Boolean = TRUE;
  iOperation: Char = '=';
  iFirstNum: DWORD = 0;
  iNumber: DWORD = 0;
{$J-}
var
  hButton: DWORD;
begin
  Result := 0;
  case Msg of
    WM_KEYDOWN:
      begin
        if (wParam = VK_LEFT) then SendMessage(hWnd, WM_COMMAND, VK_BACK, 0)
        else Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
      end;

    WM_CHAR:
      begin
        if (wParam >= $61) and (wParam <= $66) then Dec(wParam, $20) // Сдת��д
        else if (wParam = VK_RETURN) then wParam := Ord('='); // �س�ת�Ⱥ� '='
        hButton := GetDlgItem(hWnd, wParam); // �Ƿ���ڶ�Ӧ��ť(ASCII��=ID)
        if (hButton <> 0) then
        begin
          SendMessage(hButton, BM_SETSTATE, 1, 0);
          Sleep(100);
          SendMessage(hButton, BM_SETSTATE, 0, 0);
          SendMessage(hWnd, WM_COMMAND, wParam, 0);
        end else
        begin
          MessageBeep(0);
        end;
      end;

    WM_COMMAND:
      begin
        SetFocus(hWnd);
        if (wParam = VK_BACK) then (* ע: ������ť֪ͨ�� BN_CLICKED = 0, ��ͬ *)
        begin
          iNumber := iNumber div 16; // ����1λ
          ShowNumber(hWnd, iNumber);
        end else
          if (wParam = VK_ESCAPE) then
          begin
            iNumber := 0; // ��0
            ShowNumber(hWnd, 0);
          end else
            if ((wParam >= $30)and(wParam <= $39)) or  // 16���������ַ� ..
               ((wParam >= $41)and(wParam <= $46)) then
            begin
              if bNewNumber then
              begin
                iFirstNum := iNumber;
                iNumber := 0;
              end;
              bNewNumber := FALSE;
              if (iNumber <= MAXDWORD shr 4) then // ���п�(16����)λ
              begin
                if (wParam >= $30) and (wParam <= $39) then
                  iNumber := 16 * iNumber + wParam - Ord('0')
                else
                  iNumber := 16 * iNumber + wParam - Ord('A') + 10;
                ShowNumber(hWnd, iNumber);
              end else
                MessageBeep(0); // λ��������
            end else  // �������������� ..
            begin
              if (HIWORD(wParam) = BN_CLICKED) then // ����
              begin
                if (not bNewNumber) then // ֮ǰδ����
                begin
                  iNumber := CalcIt(iFirstNum, iOperation, iNumber);
                  ShowNumber(hWnd, iNumber);
                end;
                bNewNumber := TRUE;
                iOperation := Char(wParam);
              end;
            end;
      end;

    WM_DESTROY:
      begin
        PostQuitMessage(0); // �˳���Ϣѭ��
      end;

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;
  
const
  szAppName = 'HexCalc';
var
  hWnd: LongWord;
  Msg: TMsg;  
  WndClass: TWndClass;          
begin
 // ע�ᴰ����
  WndClass.style := CS_HREDRAW or CS_VREDRAW;
  WndClass.lpfnWndProc := @WndProc;
  WndClass.cbClsExtra := 0;
  WndClass.cbWndExtra := DLGWINDOWEXTRA;
  WndClass.hInstance := hInstance;
  WndClass.hIcon := LoadIcon(hInstance, szAppName);
  WndClass.hCursor := LoadCursor(0, IDC_ARROW);
  WndClass.hbrBackground := COLOR_BTNFACE + 1;
  WndClass.lpszMenuName := nil;
  WndClass.lpszClassName := szAppName;
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateDialog(hInstance, szAppName, 0, nil);
  ShowWindow(hWnd, CmdShow);

 // ��Ϣѭ��
  while GetMessage(Msg, 0, 0, 0) do
  begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;
end.
