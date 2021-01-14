unit WinUnit;

interface

procedure RegWinClass(); // ע�ᴰ����
procedure DesWinClass(); // ע��������
procedure CreateMyWin(); // ��������

implementation

uses Windows, Messages, ShellAPI, FunUnit;

  // ���ڻص�
function WindowProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const
{$J+}
  CurChoose: Integer = 9; // ��ǰѡ��(����)�˵���
{$J-}
  HookName = '{5EED7056-B89D-4DE8-A060-D285EA746799}';
  HookPath = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellExecuteHooks';
  SysBrush: array[5..9] of Integer =
   (WHITE_BRUSH, LTGRAY_BRUSH, GRAY_BRUSH, DKGRAY_BRUSH, BLACK_BRUSH);
var
  HMenu: LongWord;
begin
  Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����

  case Msg of
    WM_CREATE:
      begin
        WindowProc(hWnd, WM_COMMAND, 9, 0); // ��ʼ��(�˵���ѡ�ͱ�����ˢ)
      end;

    WM_INITMENUPOPUP:
      if (lParam = 0) then // LOWORD(lParam)=0 and HIWORD(lParam)=0, "���"�˵�
      begin
        if QueryRegStr(HKEY_LOCAL_MACHINE, HookPath, HookName) then
          EnableMenuItem(wParam, 2, MF_ENABLED) // ����
        else
          EnableMenuItem(wParam, 2, MF_GRAYED); // ����
      end;

    WM_COMMAND:
      begin
        case wParam of
          1: // "��λ����"
          begin
           // ���� LastKey
            SetRegStr(HKEY_CURRENT_USER,
              'Software\Microsoft\Windows\CurrentVersion\Applets\Regedit',
              'LastKey', '�ҵĵ���\HKEY_LOCAL_MACHINE\' + HookPath);
              
           // �� Regedit
            ShellExecute(0, 'open', 'Regedit.exe', nil, nil, SW_SHOW);
          end;

          2: // "ɾ����ֵ"
          begin
            DelRegStr(HKEY_LOCAL_MACHINE, HookPath, HookName);
          end;

          3: // "��λ�ļ�"
          begin
            ShellExecute(0, 'open', 'Explorer.exe',
              '/e,/select,C:\Liu_Mazi.DLL', nil, SW_SHOW);
          end;

          4: // "ɾ���ļ�"
          begin
            if QueryRegStr(HKEY_LOCAL_MACHINE, HookPath, HookName) then
              MessageBox(hWnd,
                #13#10'����"ɾ����ֵ",��ȡ���ҹ�   ', 'ShellExecuteHook', 0)
            else begin
              DeleteFileRestart('C:\Liu_Mazi.DLL');
              MessageBox(hWnd,
                #13#10'�õ�,�ļ���������ʱ��ɾ��   ', 'ShellExecuteHook', 0);
            end
          end;

          5, 6, 7, 8, 9: // "����"
          begin
           // ���ù�ѡ
            HMenu := GetMenu(hWnd);
            CheckMenuItem(HMenu, CurChoose, MF_UNCHECKED);
            CurChoose := wParam;
            CheckMenuItem(HMenu, CurChoose, MF_CHECKED);
            
           // ���ñ���
            SetClassLong(hWnd, GCL_HBRBACKGROUND, GetStockObject(SysBrush[CurChoose]));
            InvalidateRect(hWnd, nil, TRUE);
          end;

          10:
          begin // "����"
            MessageBox(hWnd,
              #13#10'ѡ��"ɾ����ֵ"�˵�������   ', 'ShellExecuteHook', 0);
          end;

          11:
          begin // "����"
            MessageBox(hWnd,
              #13#10'ShellExecuteHookʾ������    By ����    '#13#10, 'ShellExecuteHook', 0);
          end;

          12:
          begin // "��Դ"
            ShellExecute(0, 'open', 'http://www.2ccc.com/', nil, nil, SW_SHOW);
          end;
        end;
      end;

    WM_DESTROY:
      begin
        PostQuitMessage(0); // ��һ��WM_QUIT��Ϣ�����ô˺������̵߳���Ϣ����
      end;
  end;
end;

  // ע�ᴰ����
procedure RegWinClass();
var
  WinClass: TWndClass;
begin
 // ���
  WinClass.Style := 0;
  WinClass.lpfnWndProc := @WindowProc;
  WinClass.cbClsExtra := 0;
  WinClass.cbWndExtra := 0;
  WinClass.hInstance := HInstance;
  WinClass.hIcon := LoadIcon(HInstance, 'Liu_mazi');
  WinClass.hCursor := LoadCursor(0, IDC_ARROW);
  WinClass.hbrBackground := GetStockObject(BLACK_BRUSH);
  WinClass.lpszMenuName := 'Liu_mazi';
  WinClass.lpszClassName := 'Liu_mazi';
 // ע��
  RegisterClass(WinClass);
end;

 // ע��������
procedure DesWinClass();
begin
  UnregisterClass('Liu_mazi', HInstance);
end;

  // ��������
procedure CreateMyWin();
begin
  CreateWindowEx(WS_EX_TOPMOST, 'Liu_mazi', ' ShellExecuteHookʾ��     By ����',
    WS_OVERLAPPEDWINDOW or WS_VISIBLE, 100, 100, 300, 150, 0, 0, HInstance, nil);
end;

(* ע1: ����LastKey������2000���ϵ�RegEdit���� *)
(* ע2: �˵�������WM_COMMAND, HIWORD(wParam)=0 *)
end.
