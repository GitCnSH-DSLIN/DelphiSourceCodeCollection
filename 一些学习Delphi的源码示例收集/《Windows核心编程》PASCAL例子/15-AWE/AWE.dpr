program AWE;

{$R 'AWE.res' 'AWE.rc'}

uses
  Windows, Messages, AddrWindow in 'AddrWindow.pas';

const
  IDD_AWE = 101; // ��ԴID
  IDI_AWE = 104;
  IDC_WINDOW0TEXT    = 1006; // �ؼ�ID
  IDC_WINDOW0STORAGE = 1007;
  IDC_WINDOW1STORAGE = 1008;
  IDC_WINDOW1TEXT    = 1009;
  g_nChars = 1024; // �ַ�������

var
  g_aw: array[0..1] of TAddrWindow; // 2 memory address windows
  g_aws: array[0..1] of TAddrWindowStorage; // 2 storage blocks

  // WM_INITDIALOG����
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
var
  n, id: Integer;
  hWndCB: DWORD; // HWND
begin
  Result := TRUE;
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_AWE)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_AWE)));

  // ������ַ����
  g_aw[0].AW_Create(g_nChars);
  g_aw[1].AW_Create(g_nChars);

  // �������� RAM
  if (g_aws[0].AWS_Allocate(g_nChars) = FALSE) or
     (g_aws[1].AWS_Allocate(g_nChars) = FALSE) then
  begin
    MessageBox(0, 'Failed to allocate RAM.'#13#10'Most likely reason: you are not granted the Lock Pages in Memory user right.', 'AWE', MB_OK);
    EndDialog(hWnd, IDCANCEL);
    Exit;
  end;

  // д��һ�� RAM
  g_aws[0].AWS_MapStorage(g_aw[0]);
  lstrcpy(g_aw[0].AW_Pointer, 'Text in Storage 0');

  // д�ڶ��� RAM
  g_aws[1].AWS_MapStorage(g_aw[0]);
  lstrcpy(g_aw[0].AW_Pointer, 'Text in Storage 1');

  // ��ʼ���ӿؼ�
  for n := 0 to 1 do
  begin
    // ��ȡ���
    if (n = 0) then id := IDC_WINDOW0STORAGE else id := IDC_WINDOW1STORAGE;
    hWndCB := GetDlgItem(hWnd, id);

    // �����Ŀ
    SendMessage(hWndCB, CB_ADDSTRING, 0, LongInt(PChar('No storage')));
    SendMessage(hWndCB, CB_ADDSTRING, 0, LongInt(PChar('Storage 0')));
    SendMessage(hWndCB, CB_ADDSTRING, 0, LongInt(PChar('Storage 1')));

    // ֪ͨ�ı�
    SendMessage(hWndCB, CB_SETCURSEL, n + 1, 0);
    SendMessage(hWnd, WM_COMMAND, MakeWParam(id, CBN_SELCHANGE), hWndCB);

    // ���Ƴ���
    if (n = 0) then
      SendMessage(GetDlgItem(hWnd, IDC_WINDOW0TEXT), EM_LIMITTEXT, g_nChars, 0)
    else
      SendMessage(GetDlgItem(hWnd, IDC_WINDOW1TEXT), EM_LIMITTEXT, g_nChars, 0);
  end;
end;

  // WM_COMMAND����
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
var
  nWindow, nStorage: Integer;
  hWndText: DWORD; // HWND
  mbi: TMemoryBasicInformation;
begin
  case (id) of
    IDCANCEL:
      begin
        EndDialog(hWnd, id); // ����ģ̬�Ի���
      end;

    IDC_WINDOW0STORAGE,
    IDC_WINDOW1STORAGE:
      if (codeNotify = CBN_SELCHANGE) then // ComboBoxѡ��ı�
      begin
        // ��ǰ������ַ����
        if (id = IDC_WINDOW0STORAGE) then nWindow := 0 else nWindow := 1;
        nStorage := SendMessage(hWndCtl, CB_GETCURSEL, 0, 0) - 1;

        // ѡ��'No storage'
        // ��û����Ŀ��ѡ��
        if (nStorage = -1) then
        begin
          g_aw[nWindow].AW_UnmapStorage(); // ȡ��ӳ��
        end else
        begin
          if (g_aws[nStorage].AWS_MapStorage(g_aw[nWindow]) = FALSE) then // ����ӳ��
          begin
            g_aw[nWindow].AW_UnmapStorage();
            SendMessage(hWndCtl, CB_SETCURSEL, 0, 0);
            MessageBox(0, 'This storage can be mapped only once.', 'AWE', MB_OK);
          end;
        end;

        // ��ַ���ڶ�ӦEdit
        if (nWindow = 0) then
          hWndText := GetDlgItem(hWnd, IDC_WINDOW0TEXT)
        else
          hWndText := GetDlgItem(hWnd, IDC_WINDOW1TEXT);

        // ��ѯ��ַ����״̬ (ע: ��ΪMEM_RESERVE��δӳ��)
        VirtualQuery(g_aw[nWindow].AW_Pointer, mbi, SizeOf(TMemoryBasicInformation));
        if (mbi.State = MEM_COMMIT) then
        begin
          EnableWindow(hWndText, TRUE);
          SetWindowText(hWndText, g_aw[nWindow].AW_Pointer);
        end else
        begin
          EnableWindow(hWndText, FALSE);
          SetWindowText(hWndText, '(No storage)');
        end;
      end;

    IDC_WINDOW0TEXT,
    IDC_WINDOW1TEXT:
      if (codeNotify = EN_CHANGE) then // Edit���ݸı�
      begin
        if (id = IDC_WINDOW0TEXT) then nWindow := 0 else nWindow := 1;
        GetWindowText(hWndCtl, g_aw[nWindow].AW_Pointer, g_nChars); // ������RAM
      end;
  end;
end;

  // �Ի���ص�
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  case (uMsg) of
    WM_INITDIALOG:
      begin
        Result := BOOL( SetWindowLong(hWnd, DWL_MSGRESULT,
          Longint(Dlg_OnInitDialog(hWnd, wParam, lParam))) );
      end;

    WM_COMMAND:
      begin
        Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));
        Result := TRUE;
      end;

    else Result := FALSE;
  end;
end;

  // �������
var
  vi: TOSVersionInfo;
begin
  // �ж�ϵͳ
  vi.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(vi);
  if (vi.dwPlatformId <> VER_PLATFORM_WIN32_NT) and (vi.dwMajorVersion < 5) then
  begin
    MessageBox(0, 'This application requires features present in Windows 2000.', 'AWE', MB_OK);
    Exit;
  end;

  // ��λ����
  if (Initialize_AWE() = FALSE) then
  begin
    MessageBox(0, 'The fixed position function failure.', 'AWE', MB_OK);
    Exit;
  end;

  // ��������
  g_aw[0] := TAddrWindow.Create();
  g_aw[1] := TAddrWindow.Create();
  g_aws[0] := TAddrWindowStorage.Create();
  g_aws[1] := TAddrWindowStorage.Create();

  // ��ʾ����
  DialogBox(HInstance, MakeIntResource(IDD_AWE), 0, @Dlg_Proc);

  // �ͷŶ���
  g_aw[0].Free;
  g_aw[1].Free;
  g_aws[0].Free;
  g_aws[1].Free;
end.
