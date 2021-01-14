program DIPS;

{$R 'DIPS.res' 'DIPS.rc'}

uses Windows, Messages;

const
  IDI_DIPS    = 101; // ��ԴID
  IDD_DIPS    = 102;
  IDC_RESTORE = 3;   // �ؼ�ID
  IDC_SAVE    = 1000;

  // ��̬����DLL����
function SetDIPSHook(dwThreadId: DWORD): BOOL; stdcall; external '..\22-DIPSLib\DIPSLib.dll';

  // ����WM_INITDIALOG
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_DIPS)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_DIPS)));
  Result := TRUE;
end;

  // ����WM_COMMAND
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
begin
  case (id) of
    IDC_SAVE, IDC_RESTORE, IDCANCEL: EndDialog(hWnd, id);
  end;
end;

  // �Ի���ص�
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  Result := FALSE;
  case (uMsg) of
    WM_INITDIALOG:
      Result := SetWindowLong(hWnd, DWL_MSGRESULT, Longint(Dlg_OnInitDialog(hWnd, wParam, lParam))) <> 0;
    WM_COMMAND:
      Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));
  end;
end;

  // �������
var
  cWhatToDo: Char;
  hWndLV, hWndDIPS: HWND;
  Msg: TMsg;
begin
  // �������
  if (ParamCount = 0) then
    cWhatToDo := #0
  else begin
    cWhatToDo := ParamStr(1)[1];
    CharUpperBuff(@cWhatToDo, 1);
    if (cWhatToDo <> 'S') and (cWhatToDo <> 'R') then cWhatToDo := #0;
  end;

  // ����ѡ��
  if (cWhatToDo = #0) then
  begin
    case DialogBox(HInstance, MakeIntResource(IDD_DIPS), 0, @Dlg_Proc) of
      IDC_SAVE: cWhatToDo := 'S';
      IDC_RESTORE: cWhatToDo := 'R';
    end;
  end;

  // ��������
  if (cWhatToDo = #0) then Exit;

  // ������
  hWndLV := GetTopWindow(GetTopWindow(FindWindow('ProgMan', nil)));
  if (IsWindow(hWndLV) = FALSE) then
  begin
    MessageBox(0, 'Did not find out the Desktop.', 'DIPS', MB_OK);
    Exit;
  end;

  // ��װ����
  if (SetDIPSHook(GetWindowThreadProcessId(hWndLV, nil)) = FALSE) then
  begin
    MessageBox(0, 'Install the hook failure.', 'DIPS', MB_OK);
    Exit;
  end;

  // ����ȴ�
  GetMessage(Msg, 0, 0, 0);

  // ��λ����
  hWndDIPS := FindWindow(nil, 'Richter DIPS');
  if (IsWindow(hWndDIPS) = FALSE) then
  begin
    MessageBox(0, 'The find window way failure.', 'DIPS', MB_OK);
    Exit;
  end;

  // ��������
  SendMessage(hWndDIPS, WM_APP, hWndLV, Longint(cWhatToDo = 'S'));

  // �رմ���
  SendMessage(hWndDIPS, WM_CLOSE, 0, 0);
  if (IsWindow(hWndDIPS) = TRUE) then
    MessageBox(0, 'Close the window way failure.', 'DIPS', MB_OK);

  // ж�ع���
  SetDIPSHook(0);
end.
