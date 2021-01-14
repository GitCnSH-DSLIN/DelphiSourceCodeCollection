program  StrProg;

{$R StrProg.Res}

uses
  Windows, Messages;

type
  TCBParam = record
    hWndDc, xText, yText, xStart, yStart, xIncr, yIncr, xMax, yMax: Integer;
  end;

const
  IDC_STRING = 1000;
  IDM_ENTER  = 40001;
  IDM_DELETE = 40002;
  szAppName  = 'StrProg';
  MAX_LENGTH = 63;
  
var
  szString: array[0..MAX_LENGTH] of Char;

function AddString(pStringIn: PChar): BOOL; stdcall; external '..\����21-3\StrLib.dll' name 'AddStringA';
function DeleteString(pStringIn: PChar): BOOL; stdcall; external '..\����21-3\StrLib.dll' name 'DeleteStringA';
function GetStrings(pfnGetStrCallBack, pParam: Pointer): Integer; stdcall; external '..\����21-3\StrLib.dll' name 'GetStringsA';

  // �Ի�����Ϣ���ջص�����
function DlgProc(hDlg: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  Result := FALSE; // δ������
  case (Msg) of
    WM_INITDIALOG:
      begin
        SendDlgItemMessage(hDlg, IDC_STRING, EM_LIMITTEXT, MAX_LENGTH, 0); // �޳�
        Result := TRUE;
      end;

    WM_COMMAND:
      begin
        case (wParam) of
          IDOK:
            begin
              GetDlgItemText(hDlg, IDC_STRING, @szString[0], MAX_LENGTH + 1); // ȡEdit
              EndDialog(hDlg, Integer(TRUE));
              Result := TRUE;
            end;

          IDCANCEL:
            begin
              EndDialog(hDlg, Integer(FALSE));
              Result := TRUE;
            end;
        end; // END: case (wParam) of ..
      end;
  end; // END: case (Msg) of ..
end;

  // �ַ���ö�ٻص�����
function GetStrCallBack(pString: Pointer; var CBParam: TCBParam): BOOL; stdcall;
begin
  Result := TRUE;

  TextOut(CBParam.hWndDc, CBParam.xText, CBParam.yText, pString, lstrlen(pString));
  
  Inc(CBParam.yText, CBParam.yIncr);
  if (CBParam.yText > CBParam.yMax) then
  begin
    CBParam.yText := CBParam.yStart;

    Inc(CBParam.xText, CBParam.xIncr);
    if (CBParam.xText > CBParam.xMax) then
      Result := FALSE;
  end;
end;

  // ������Ϣ����ص�����
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+}
  cxChar: Integer = 0;
  cyChar: Integer = 0;
  cxClient: Integer = 0;
  cyClient: Integer = 0;
  iDataChangeMsg: UINT = 0;
{$J-}           
var
  CBParam: TCBParam;
  hWndDc: HDC;
  ps: TPaintStruct;
  tm: TTextMetric;
begin
  Result := 0;
  case (Msg) of
    WM_CREATE:
      begin
        hWndDc := GetDC(hWnd);
        GetTextMetrics(hWndDc, tm); // �����С
        cxChar := tm.tmAveCharWidth;
        cyChar := tm.tmHeight + tm.tmExternalLeading;
        ReleaseDC(hWnd, hWndDc);

        iDataChangeMsg := RegisterWindowMessage('StrProgDataChange'); // ע����Ϣ
      end;

    WM_COMMAND:
      begin
        case (wParam) of
          IDM_ENTER: // ����ַ���
            if BOOL(DialogBox(hInstance, 'EnterDlg', hWnd, @DlgProc)) then
            begin
              if AddString(szString) then
                PostMessage(HWND_BROADCAST, iDataChangeMsg, 0, 0) // �㲥
              else
                MessageBeep(0); // ��ӳ���
            end;

          IDM_DELETE: // ɾ���ַ���
            if BOOL(DialogBox(hInstance, 'DeleteDlg', hWnd, @DlgProc)) then
            begin
              if DeleteString(szString) then
                PostMessage(HWND_BROADCAST, iDataChangeMsg, 0, 0) // �㲥
              else
                MessageBeep(0); // ɾ������
            end;
        end; // END: case (wParam) of ..
      end;

    WM_SIZE:
      begin
        cxClient := LOWORD(lParam);
        cyClient := HIWORD(lParam);
      end;

    WM_PAINT:
      begin
        hWndDc := BeginPaint(hWnd, ps);

        CBParam.hWndDc := hWndDc;
        CBParam.xStart := cxChar;
        CBParam.xText := cxChar;
        CBParam.yStart := cyChar;
        CBParam.yText := cyChar;
        CBParam.xIncr := cxChar * MAX_LENGTH;
        CBParam.yIncr := cyChar;
        CBParam.xMax := CBParam.xIncr * (1 + cxClient div CBParam.xIncr);
        CBParam.yMax := cyChar * (cyClient div cyChar - 1);

        GetStrings(@GetStrCallBack, @CBParam); // ö�ٻ���

        EndPaint(hWnd, ps);
      end;

    WM_DESTROY:
      begin
        PostQuitMessage(0); // ��һ���˳���ϢWM_QUIT
      end;
      
    else
      begin
        if (Msg = iDataChangeMsg) then InvalidateRect(hWnd, nil, TRUE) // �ػ�
        else Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
      end;
  end;
end;   

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
  WndClass.lpszMenuName := szAppName;
  WndClass.lpszClassName := szAppName;

 // ע�ᴰ����
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������
  hWnd := CreateWindow(szAppName, 'DLL Demonstration Program',
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

(* ע: ��Ϊ��ʾ,����ֻ����Ansi��ĺ���. *)  
end.
