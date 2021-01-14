program  Environ;

uses
  Windows, Messages; 

   // ��������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
     // ������������������ӵ�ListBox
  procedure FillListBox(hWndList: LongWord);
  var
    iLength: Integer;
    pVarBlock, pVarBeg, pVarEnd, pVarName: PChar;
  begin
    pVarBlock := GetEnvironmentStrings(); // ��Ϣ��ַ
    while (pVarBlock^ <> #0) do // ������2��#0����
    begin
      if (pVarBlock^ <> '=') then // ����'='��ͷ��
      begin
       // ȡ������������ӵ�Listbox ..
        pVarBeg := pVarBlock ;
        while (pVarBlock^ <> '=') do Inc(pVarBlock);
        pVarEnd := pVarBlock;
        iLength := pVarEnd - pVarBeg + 1;
        GetMem(pVarName, iLength);
        CopyMemory(pVarName, pVarBeg, iLength-1);
        pVarName[iLength] := #0;
        SendMessage(hWndList, LB_ADDSTRING, 0, Integer(pVarName)); // ���
        FreeMem(pVarName, iLength);
      end;
     // ������һ�� 
      while (pVarBlock^ <> #0) do Inc(pVarBlock);
      Inc(pVarBlock);
    end;
    FreeEnvironmentStrings(pVarBlock); // �ͷ�
  end;
const
  ID_LIST = 1;
  ID_TEXT = 2;
{$J+}
  hWndList: LongWord = 0;
  hWndText: LongWord = 0;
{$J-}
var
  iIndex, iLength, cxChar, cyChar: Integer;
  pVarName, pVarValue: PChar;
begin
  Result := 0;
  case Msg of
    WM_CREATE:
      begin
        cxChar := LOWORD(GetDialogBaseUnits());
        cyChar := HIWORD(GetDialogBaseUnits());
        hWndList := CreateWindow('listbox', nil,
                      WS_CHILD or WS_VISIBLE or LBS_STANDARD,
                      cxChar, cyChar * 3,
                      cxChar * 30 + GetSystemMetrics(SM_CXVSCROLL), cyChar * 20,
                      hWnd, ID_LIST,
                      GetWindowLong(hWnd, GWL_HINSTANCE),
                      nil);
        hWndText := CreateWindow('static', nil,
                      WS_CHILD or WS_VISIBLE or SS_LEFT,
                      cxChar, cyChar,
                      GetSystemMetrics(SM_CXSCREEN), cyChar,
                      hWnd, ID_TEXT,
                      GetWindowLong(hWnd, GWL_HINSTANCE),
                      nil);
        FillListBox(hWndList); // ���
      end;

    WM_SETFOCUS:
      SetFocus(hWndList); // ת������

    WM_COMMAND:              // ListBox ѡ���� �仯 ..     
      if (LOWORD(wParam) = ID_LIST)and(HIWORD(wParam) = LBN_SELCHANGE) then
      begin
        iIndex := SendMessage(hWndList, LB_GETCURSEL, 0, 0); // ��ǰѡ��
        iLength := SendMessage(hWndList, LB_GETTEXTLEN, iIndex, 0) + 1; // ����(����)
        GetMem(pVarName, iLength);
        SendMessage(hWndList, LB_GETTEXT, iIndex, Integer(pVarName)); // ȡ��(����)

        iLength := GetEnvironmentVariable(pVarName, nil, 0); // ����(ֵ)
        GetMem(pVarValue, iLength);
        GetEnvironmentVariable(pVarName, pVarValue, iLength); // ȡ��(ֵ)          
        SetWindowText(hWndText, pVarValue); // ��ӡ(ֵ)
        
        FreeMem(pVarName);
        FreeMem(pVarValue);
      end;

    WM_DESTROY:
      PostQuitMessage(0); // ��һ���˳���Ϣ

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end;
  

const
  szAppName = 'Environ';

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
  hWnd := CreateWindow(szAppName, 'Environment List Box',
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

(* ע,�˳�����һ��СBug, static��'������Ҫ�Զ�����',
   ����ַ���̫��, ����һ�е�static���ǿ��������� *)
end.
