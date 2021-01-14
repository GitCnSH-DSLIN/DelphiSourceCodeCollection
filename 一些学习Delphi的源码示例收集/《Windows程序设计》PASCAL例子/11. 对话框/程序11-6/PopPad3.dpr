program  PopPad3;

{$R  PopPad3.res}

uses
  Windows, Messages, CommDlg, PopFile, PopFind, PopFont, PopPrnt;

const
  UNTITLED = '(untitled)';
  szAppName = 'PopPad3';
  IDM_FILE_NEW        = 40001; // ����ID ..
  IDM_FILE_OPEN       = 40002;
  IDM_FILE_SAVE       = 40003;
  IDM_FILE_SAVE_AS    = 40004;
  IDM_FILE_PRINT      = 40005;
  IDM_APP_EXIT        = 40006;
  IDM_EDIT_UNDO       = 40007;
  IDM_EDIT_CUT        = 40008;
  IDM_EDIT_COPY       = 40009;
  IDM_EDIT_PASTE      = 40010;
  IDM_EDIT_CLEAR      = 40011;
  IDM_EDIT_SELECT_ALL = 40012;
  IDM_SEARCH_FIND     = 40013;
  IDM_SEARCH_NEXT     = 40014;
  IDM_SEARCH_REPLACE  = 40015;
  IDM_FORMAT_FONT     = 40016;
  IDM_HELP            = 40017;
  IDM_APP_ABOUT       = 40018;

var
  hDlgModeless: HWND = 0; // �Ի�����(Find , FindNext , Replace)

  // ���ô������
procedure DoCaption(hWnd: HWND; const szTitleName: PChar);
const
{$J+}
  List: array[0..1] of PChar = (szAppName, nil); // ת���б�
{$J-}
var
  szCaption: array[0..64 + MAX_PATH] of Char; // ת��������
begin
  if (szTitleName[0] <> #0) then List[1] := szTitleName else List[1] := UNTITLED;
  wvsprintf(szCaption, '%s - %s', @List);
  SetWindowText(hWnd, szCaption);
end;

  // ������Ϣ��
procedure OkMessage(hWnd: HWND; const szMessage, szTitleName: PChar);
var
  szBuffer: array[0..64 + MAX_PATH] of Char; // ת��������
  List: PChar;
begin
  if (szTitleName[0] <> #0) then List := szTitleName else List := UNTITLED;
  wvsprintf(szBuffer, szMessage, @List);
  MessageBox(hWnd, szBuffer, szAppName, MB_OK or MB_ICONEXCLAMATION);
end;

  // �ļ�����ѯ��
function AskAboutSave(hWnd: HWND; const szTitleName: PChar): Integer;
var
  szBuffer: array[0..64 + MAX_PATH] of Char; // ת��������
  List: PChar;
begin
  if (szTitleName[0] <> #0) then List := szTitleName else List := UNTITLED;
  wvsprintf(szBuffer, 'Save current changes in %s?', @List);
  Result := MessageBox(hWnd, szBuffer, szAppName, MB_YESNOCANCEL or MB_ICONQUESTION);
  if (Result = IDYES) and (SendMessage(hWnd, WM_COMMAND, IDM_FILE_SAVE, 0) = 0) then
    Result := IDCANCEL;
end;  

   // (����)�Ի�����Ϣ���չ���
function AboutDlgProc(hDlg: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  Result := FALSE;
  case Msg of
    WM_INITDIALOG:
      Result :=  TRUE;

    WM_COMMAND:
      case LOWORD(wParam) of
        IDOK:
          begin
            EndDialog(hDlg, 0);
            Result := TRUE;
          end;
      end;
  end;
end;

   // ������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+}
  bNeedSave: Boolean = FALSE; // �豣��(�ı��ѱ仯)
  hWndEdit: Integer = 0; // �༭�ؼ����
  iOffset: LongWord = 0; // ��ǰ���λ��
  messageFindReplace: LongWord = 0; // ��ע����Ϣ
  szFileName: PChar = nil;  // ����·��+�ļ���
  szTitleName: PChar = nil; // �ļ���(����·��)
{$J-}
  EDITID = 1;
var
  iSelBeg, iSelEnd, iEnable: Integer;
  pfr: PFindReplace;
begin
  Result := 0; // Ԥ�÷���ֵ(Ҳ��SendMessage���õ���)
  case Msg of
    WM_CREATE:
      begin
        GetMem(szFileName, MAX_PATH + 1); // Ϊ�ַ�����������ڴ沢��ʼ��
        szFileName[0] := #0;
        GetMem(szTitleName, MAX_PATH + 1);
        szTitleName[0] := #0;

        hWndEdit := CreateWindow('edit', nil, // �����༭�ؼ�
          WS_CHILD or WS_VISIBLE or WS_HSCROLL or WS_VSCROLL or WS_BORDER or ES_LEFT
          or ES_NOHIDESEL or ES_MULTILINE or ES_AUTOHSCROLL or ES_AUTOVSCROLL,
          0, 0, 0, 0, hWnd, EDITID, hInstance, nil);
        SendMessage(hWndEdit, EM_LIMITTEXT, 32000, 0); // �������ֳ���
        
        PopFileInitialize(hWnd); // ��ʼ��ͨ�öԻ���ṹ
        PopFontInitialize(hWndEdit); // ��ʼ������
        messageFindReplace := RegisterWindowMessage(FINDMSGSTRING); // ע����Ϣ
        DoCaption(hWnd, szTitleName); // ��ʼ�����������
      end;

    WM_SETFOCUS:
      SetFocus(hWndEdit); // ����ʼ���ڱ༭�ؼ�

    WM_SIZE:
      MoveWindow(hWndEdit, 0, 0, LOWORD(lParam), HIWORD(lParam), TRUE); // �����༭�ؼ�

    WM_INITMENUPOPUP: // �˵�������
      case lParam of
        1: begin // Edit�˵�
             if SendMessage(hWndEdit, EM_CANUNDO, 0, 0) <> 0 then // ���Գ���
               EnableMenuItem(wParam, IDM_EDIT_UNDO, MF_ENABLED)
             else
               EnableMenuItem(wParam, IDM_EDIT_UNDO, MF_GRAYED);

             if IsClipboardFormatAvailable(CF_TEXT) then // �������к�������
               EnableMenuItem(wParam, IDM_EDIT_PASTE, MF_ENABLED)
             else
               EnableMenuItem(wParam, IDM_EDIT_PASTE, MF_GRAYED);
                                                                       // ѡ���ı���βλ��
             SendMessage(hWndEdit, EM_GETSEL, Integer(@iSelBeg), Integer(@iSelEnd));
             if (iSelBeg = iSelEnd) then iEnable := MF_GRAYED else iEnable := MF_ENABLED;
             EnableMenuItem(wParam, IDM_EDIT_CUT, iEnable);
             EnableMenuItem(wParam, IDM_EDIT_COPY, iEnable);
             EnableMenuItem(wParam, IDM_EDIT_CLEAR, iEnable);
           end;

        2: begin // Search�˵�
             if (hDlgModeless = 0) then iEnable := MF_ENABLED else iEnable := MF_GRAYED;
             EnableMenuItem(wParam, IDM_SEARCH_FIND, iEnable);
             EnableMenuItem(wParam, IDM_SEARCH_NEXT, iEnable);
             EnableMenuItem(wParam, IDM_SEARCH_REPLACE, iEnable);
           end;
      end;

    WM_COMMAND:
      if (lParam = hWndEdit) and (LOWORD(wParam) = EDITID) then // �༭�ؼ�
      begin
        case HIWORD(wParam) of
          EN_UPDATE: // ���ݱ仯(�豣��)
            bNeedSave := TRUE;

          EN_ERRSPACE,
          EN_MAXTEXT: // ����(������Χ)
            MessageBox(hWnd, 'Edit control out of space.', szAppName, MB_OK or MB_ICONSTOP);

          else
            Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
        end;
      end else  // ����,���ǲ˵����ݼ�
      begin
        case LOWORD(wParam) of // �˵����ݼ�ID
          IDM_FILE_NEW: // �½�
            begin
              if (bNeedSave)and(AskAboutSave(hWnd, szTitleName) = IDCANCEL) then Exit;

              SetWindowText(hWndEdit, '');
              szFileName[0] := #0;
              szTitleName[0] := #0;
              DoCaption(hWnd, szTitleName);
              bNeedSave := FALSE;
            end;

          IDM_FILE_OPEN: // ��
            begin
              if (bNeedSave)and(AskAboutSave(hWnd, szTitleName) = IDCANCEL) then Exit;
              
              if PopFileOpenDlg(hWnd, szFileName, szTitleName) then // ѡ���ļ��Ի���
              begin                     
                if (not PopFileRead(hWndEdit, szFileName)) then // �����ļ�ʧ��
                begin
                  OkMessage(hWnd, 'Could not read file %s!', szTitleName); // ������ʾ
                  szFileName[0] := #0;
                  szTitleName[0] := #0;
                end;
              end;
              DoCaption(hWnd, szTitleName);
              bNeedSave := FALSE;
            end;

          IDM_FILE_SAVE:
            begin
              if (szFileName[0] <> #0) then // ��֪�ļ���
              begin
                if (PopFileWrite(hWndEdit, szFileName)) then // �����ļ��ɹ�
                begin
                  bNeedSave := FALSE;    Result := 1; // ����TRUE
                end else
                  OkMessage(hWnd, 'Could not write file %s', szTitleName); // ������ʾ
              end else
              begin
                Result := SendMessage(hWnd, WM_COMMAND, IDM_FILE_SAVE_AS, 0); // ����WndProc
              end;  
            end;

          IDM_FILE_SAVE_AS:
            begin
              if PopFileSaveDlg(hWnd, szFileName, szTitleName) then // �����ļ��Ի���
              begin
                DoCaption(hWnd, szTitleName);
                if PopFileWrite(hWndEdit, szFileName) then // ����ɹ�
                begin
                  bNeedSave := FALSE;   Result := 1; // ����TRUE
                end else
                  OkMessage(hWnd, 'Could not write file %s', szTitleName); // ������ʾ
              end;
            end;

          IDM_FILE_PRINT:
            if (not PopPrntPrintFile(hInstance, hWnd, hWndEdit, szTitleName)) then
              OkMessage(hWnd, 'Could not print file %s', szTitleName); // ��ӡ������ʾ

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

          IDM_SEARCH_FIND:
            begin
              SendMessage(hWndEdit, EM_GETSEL, 0, Integer(@iOffset)); // ѡ���ı�ĩβλ��
              hDlgModeless := PopFindFindDlg(hWnd); // Find�Ի���
            end;

          IDM_SEARCH_NEXT:
            begin
              SendMessage(hWndEdit, EM_GETSEL, 0, Integer(@iOffset)); // ѡ���ı�ĩβλ��
              if PopFindValidFind() then // Ѱ�ҹؼ�����Ч
                PopFindNextText(hWndEdit, @iOffset)
              else
                hDlgModeless := PopFindFindDlg(hWnd); 
            end;

          IDM_SEARCH_REPLACE:
            begin
              SendMessage(hWndEdit, EM_GETSEL, 0, Integer(@iOffset)); // ѡ���ı�ĩβλ��
              hDlgModeless := PopFindReplaceDlg(hWnd); // �ı��滻�Ի���
            end;

          IDM_FORMAT_FONT:
            if PopFontChooseFont(hWnd) then PopFontSetFont(hWndEdit); // ��������

          IDM_HELP:
            OkMessage(hWnd, 'Help not yet implemented!', '');


          IDM_APP_ABOUT:
            DialogBox(hInstance, 'AboutBox', hWnd, @AboutDlgProc);

          else
            Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
        end;         
      end;                          

    WM_CLOSE:
      if (not bNeedSave) or (AskAboutSave(hWnd, @szTitleName[0]) <> IDCANCEL) then // ���ڹر�
        DestroyWindow(hWnd);

    WM_QUERYENDSESSION:
      if (not bNeedSave) or (AskAboutSave(hWnd, szTitleName) <> IDCANCEL) then // ϵͳ�ر�
        Result := 1
      else
        Result := 0;

    WM_DESTROY:
      begin
        PopFontDeinitialize();
        FreeMem(szFileName);
        FreeMem(szTitleName);
        PostQuitMessage(0); // �˳�ѭ��
      end;

    else
      begin
        if (Msg = messageFindReplace) then // ��ע����Ϣ
        begin
          pfr := PFindReplace(lParam);

          if (pfr.Flags and FR_DIALOGTERM) <> 0 then hDlgModeless := 0; // ��ֹ�Ի���

          if (pfr.Flags and FR_FINDNEXT) <> 0 then // Ѱ����һ��
            if (not PopFindFindText(hWndEdit, @iOffset, pfr)) then // δ�ҵ�
              OkMessage(hWnd, 'Text not found!', '');

          if ((pfr.Flags and FR_REPLACE) <> 0) or ((pfr.Flags and FR_REPLACEALL) <> 0) then // �滻
            if (not PopFindReplaceText(hWndEdit, @iOffset, pfr)) then // δ�ҵ�
              OkMessage(hWnd, 'Text not found!', '');

          if (pfr.Flags and FR_REPLACEALL) <> 0 then // ȫ���滻
            while(PopFindReplaceText(hWndEdit, @iOffset, pfr)) do;
            
         end else
           Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
      end;
  end;
end;

var
  Msg: TMsg; // ��׼��Ϣ�ṹ
  hWnd, hAccel: LongWord; // ���ھ��, ��ݼ��б���
  WndClass: TWndClass; // ע�ᴰ����ṹ
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
  hWnd := CreateWindow(szAppName, nil,
                       WS_OVERLAPPEDWINDOW,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       0, 0, hInstance, CmdLine);

 // ��ʾ����
  ShowWindow(hWnd, CmdShow);
  UpdateWindow(hWnd);

 // ��ݼ��б�
  hAccel := LoadAccelerators(hInstance, szAppName);

 // ��Ϣѭ��
  while GetMessage(Msg, 0, 0, 0) do
  begin
    if (hDlgModeless = 0) or (not IsDialogMessage(hDlgModeless, Msg)) then
    begin
      if (TranslateAccelerator(hWnd, hAccel, Msg) = 0) then
      begin
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
  end;
end.
