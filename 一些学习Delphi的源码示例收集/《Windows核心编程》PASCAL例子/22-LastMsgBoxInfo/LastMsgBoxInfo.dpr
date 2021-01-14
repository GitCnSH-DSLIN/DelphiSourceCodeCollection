program LastMsgBoxInfo;

{$R 'LastMsgBoxInfo.res' 'LastMsgBoxInfo.rc'}

uses Windows, Messages;

const
  IDD_LASTMSGBOXINFO = 101;
  IDI_LASTMSGBOXINFO = 102;
  IDC_INFO           = 1001;

  // ��̬����DLL����
function LastMsgBoxInfo_HookAllApps(fInstall: BOOL; dwThreadId: DWORD): BOOL; stdcall;
type
  TfnHookAllApps = function (fInstall: BOOL; dwThreadId: DWORD): BOOL; stdcall;
var
  hLib: HMODULE;
  pfn: FARPROC;
begin
  Result := FALSE;

  hLib := GetModuleHandle('LastMsgBoxInfoLib.dll');
  if (hLib = 0) then
  begin
    hLib := LoadLibrary('..\22-LastMsgBoxInfoLib\LastMsgBoxInfoLib.dll');
    if (hLib = 0) then
    begin
      MessageBox(0, 'Can not find the ..\22-LastMsgBoxInfoLib\LastMsgBoxInfoLib.dll.', 'LastMsgBoxInfo', MB_OK);
      Exit;
    end;
  end;
  
  pfn := GetProcAddress(hLib, 'LastMsgBoxInfo_HookAllApps');
  if (pfn = nil) then
  begin
    MessageBox(0, 'Can not find the LastMsgBoxInfo_HookAllApps() function.', 'LastMsgBoxInfo', MB_OK);
    FreeLibrary(hLib);
    Exit;
  end;

  Result := TfnHookAllApps(pfn)(fInstall, dwThreadID);
  
  if (fInstall = FALSE) then FreeLibrary(hLib);
end;

  // WM_INITDIALOG��Ϣ����
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_LASTMSGBOXINFO)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_LASTMSGBOXINFO)));
  SetDlgItemText(hWnd, IDC_INFO, 'Waiting for a Message Box to be dismissed.');
  Result := TRUE;
end;

  // WM_SIZE��Ϣ����
procedure Dlg_OnSize(hWnd: HWND; state: UINT; cx, cy: Integer);
begin
  SetWindowPos(GetDlgItem(hWnd, IDC_INFO), 0, 0, 0, cx, cy, SWP_NOZORDER);
end;

  // WM_COMMAND��Ϣ����
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
begin
  case (id) of
    IDCANCEL: EndDialog(hWnd, id);
  end;
end;

  // WM_COPYDATA��Ϣ����
function Dlg_OnCopyData(hWnd, hWndFrom: HWND; pcds: PCopyDataStruct): BOOL;
begin
  SetDlgItemTextA(hWnd, IDC_INFO, pcds.lpData);
  Result := TRUE;
end;

  // �Ի�����Ϣ�ص�����
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  Result := FALSE;
  
  case (uMsg) of
    WM_INITDIALOG:
      Result := SetWindowLong(hWnd, DWL_MSGRESULT, Longint(Dlg_OnInitDialog(hWnd, wParam, lParam))) <> 0;

    WM_SIZE:
      Dlg_OnSize(hWnd, wParam, LOWORD(lParam), HIWORD(lParam));

    WM_COMMAND:
      Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));

    WM_COPYDATA:
      Result := Dlg_OnCopyData(hWnd, wParam, PCopyDataStruct(lParam));
  end;
end;

  // �������������
var
  dwThreadId: DWORD = 0;
  Msg: TMsg;
begin
  // ʹ�Լ�������Hook(���֮ǰ�Ѱ�װ)
  PostThreadMessage(GetCurrentThreadID(), WM_NULL, 0, 0);
  PeekMessage(Msg, 0, WM_NULL, WM_NULL, PM_REMOVE);

  // ��װHook�ɹ�����ʾ����, �����˳�
  if LastMsgBoxInfo_HookAllApps(TRUE, dwThreadId) then
  begin
    DialogBox(HInstance, MakeIntResource(IDD_LASTMSGBOXINFO), 0, @Dlg_Proc);
    LastMsgBoxInfo_HookAllApps(FALSE, 0);
  end else
    MessageBox(0, 'Install the message hook failure.', 'LastMsgBoxInfo', MB_OK);
end.
