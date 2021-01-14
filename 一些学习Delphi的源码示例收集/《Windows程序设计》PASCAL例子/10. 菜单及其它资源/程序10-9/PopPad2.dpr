program  PopPad2;

{$R  PopPad2.res}

uses
  Windows, Messages;

const
  szAppName = 'PopPad2';   

   // ������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
     // �ر�ȷ���Ӻ��� ..
  function AskConfirmation(hWnd: LongWord): Integer;
  begin
    Result := MessageBox(hWnd, 'Really want to close PopPad2?',
                       szAppName, MB_YESNO or MB_ICONQUESTION);
  end;
const
  ID_EDIT = 1; // �ؼ�ID
  IDM_FILE_NEW   = 40001; // ����ID ..
  IDM_FILE_OPEN  = 40002;
  IDM_FILE_SAVE  = 40003;
  IDM_FILE_SAVE_AS = 40004;
  IDM_FILE_PRINT = 40005;
  IDM_APP_EXIT   = 40006;
  IDM_EDIT_UNDO  = 40007;
  IDM_EDIT_CUT   = 40008;
  IDM_EDIT_COPY  = 40009;
  IDM_EDIT_PASTE = 40010;
  IDM_EDIT_CLEAR = 40011;
  IDM_EDIT_SELECT_ALL = 40012;
  IDM_HELP_HELP = 40013;
  IDM_APP_ABOUT = 40014;
{$J+}
  hWndEdit: LongWord = 0; // �༭����ؼ����
{$J-}
var
  iSelect, iEnable: Integer;
begin
  Result := 0;
  case Msg of
    WM_CREATE:
      hWndEdit := CreateWindow('edit', nil, // �����༭����ؼ�
                    WS_CHILD or WS_VISIBLE or WS_HSCROLL or WS_VSCROLL or WS_BORDER
                    or ES_LEFT or ES_MULTILINE or ES_AUTOHSCROLL or ES_AUTOVSCROLL,
                    0, 0, 0, 0, hWnd, ID_EDIT, PCreateStruct(lParam).hInstance, nil);

    WM_SETFOCUS:
      SetFocus(hWndEdit); // ����ʼ���ڱ༭������

    WM_SIZE:
      MoveWindow(hWndEdit, 0, 0, LOWORD(lParam), HIWORD(lParam), TRUE); // �����༭����ߴ�

    WM_INITMENUPOPUP:
      if (lParam = 1) then // LOWORD(lParam)=1 and HIWORD(lParam)=0 , Edit�˵�
      begin
        if SendMessage(hWndEdit, EM_CANUNDO, 0, 0) <> 0 then // ���Գ���
          EnableMenuItem(wParam, IDM_EDIT_UNDO, MF_ENABLED)
        else
          EnableMenuItem(wParam, IDM_EDIT_UNDO, MF_GRAYED);

        if IsClipboardFormatAvailable(CF_TEXT) then // �������к�������
          EnableMenuItem(wParam, IDM_EDIT_PASTE, MF_ENABLED)
        else
          EnableMenuItem(wParam, IDM_EDIT_PASTE, MF_GRAYED);

        iSelect := SendMessage(hWndEdit, EM_GETSEL, 0, 0);
        if (HIWORD(iSelect) = LOWORD(iSelect)) then // ��ʼ�������ͬ
          iEnable := MF_GRAYED
        else
          iEnable := MF_ENABLED; 
        EnableMenuItem(wParam, IDM_EDIT_CUT, iEnable);
        EnableMenuItem(wParam, IDM_EDIT_COPY, iEnable);
        EnableMenuItem(wParam, IDM_EDIT_CLEAR, iEnable);
      end else
       Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����

    WM_COMMAND:
      if (lParam <> 0) then // �༭����ؼ�(����϶���Ϊ0)
      begin
        if (LOWORD(lParam) = ID_EDIT) and
           ((HIWORD(wParam) = EN_ERRSPACE) or (HIWORD(wParam) = EN_MAXTEXT)) then
          MessageBox(hWnd, 'Edit control out of space.', szAppName, MB_OK or MB_ICONSTOP)
        else
          Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼���� 
      end else
      begin
        case LOWORD(wParam) of // �˵�(���ݼ�)��Ϣ
          IDM_FILE_NEW,
          IDM_FILE_OPEN,
          IDM_FILE_SAVE,
          IDM_FILE_SAVE_AS,
          IDM_FILE_PRINT:
            MessageBeep(0);

          IDM_APP_EXIT:
            SendMessage(hWnd, WM_CLOSE, 0, 0);

          IDM_EDIT_UNDO:
            SendMessage(hWndEdit, WM_UNDO, 0, 0);

          IDM_EDIT_CUT:
            SendMessage(hWndEdit, WM_CUT, 0, 0);

          IDM_EDIT_COPY:
            SendMessage(hWndEdit, WM_COPY, 0, 0);

          IDM_EDIT_PASTE:
            SendMessage(hWndEdit, WM_PASTE, 0, 0);

          IDM_EDIT_CLEAR:
            SendMessage(hWndEdit, WM_CLEAR, 0, 0);

          IDM_EDIT_SELECT_ALL:
            SendMessage(hWndEdit, EM_SETSEL, 0, -1);

          IDM_HELP_HELP:
            MessageBox(hWnd, 'Help not yet implemented!',
                     szAppName, MB_OK or MB_ICONEXCLAMATION);

          IDM_APP_ABOUT:
            MessageBox(hWnd, 'POPPAD2 (c) Charles Petzold, 1998',
                     szAppName, MB_OK or MB_ICONINFORMATION);

          else
            Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
        end;         
      end;

    WM_CLOSE:
      if (IDYES = AskConfirmation(hWnd)) then DestroyWindow(hWnd); // ����ر�ȷ��

    WM_QUERYENDSESSION:
      if (IDYES = AskConfirmation(hWnd)) then Result := 1 else Result := 0; // ϵͳ�ر�

    WM_DESTROY:
      PostQuitMessage(0); // �˳�ѭ��

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;

var
  Msg: TMsg;
  hWnd, hAccel: LongWord;
  WndClass: TWndClass;          
begin
 // ���ṹ��
  WndClass.style := CS_HREDRAW or CS_VREDRAW;
  WndClass.lpfnWndProc := @WndProc;
  WndClass.cbClsExtra := 0;
  WndClass.cbWndExtra := 0;
  WndClass.hInstance := hInstance;
  WndClass.hIcon := LoadIcon(hInstance, szAppName);
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
  hWnd := CreateWindow(szAppName, szAppName,
                       WS_OVERLAPPEDWINDOW,
                       GetSystemMetrics(SM_CXSCREEN) div 4,
                       GetSystemMetrics(SM_CYSCREEN) div 4,
                       GetSystemMetrics(SM_CXSCREEN) div 2,
                       GetSystemMetrics(SM_CYSCREEN) div 2,
                       0, 0, hInstance, nil);

 // ��ʾ����
  ShowWindow(hWnd, CmdShow);
  UpdateWindow(hWnd);

 // �����ݼ��б�
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

(* ע��: "�����ݼ���һ���˵����Ӧ����ô������Ϣ������򻹻��յ� ..." *)
end.
