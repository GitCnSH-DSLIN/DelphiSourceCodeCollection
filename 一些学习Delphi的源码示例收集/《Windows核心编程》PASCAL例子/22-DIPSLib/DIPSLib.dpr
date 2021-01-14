library DIPSLib;

{$R 'DIPSLib.res' 'DIPSLib.rc'}

uses
  Windows, Messages, CommCtrl;

type
  TShareMem = record // �����ڴ�ṹ
    g_hhook: HHOOK;
    g_dwThreadIdDIPS: DWORD;
  end;

const
  g_szRegSubKey = 'Software\Richter\Desktop Item Position Saver';
  SHARE_NAME = 'DIPSLib_Shared';
  IDD_DIPS = 101;  

var
  hFileMap: THandle;   // ӳ���ļ����
  PShared: ^TShareMem; // ӳ���ڴ��ַ

  // ����WM_CLOSE
procedure Dlg_OnClose(hWnd: HWND);
begin
  DestroyWindow(hWnd);
end;

  // ����������Ŀλ��
procedure SaveListViewItemPositions(hWndLV: HWND);
var
  nMaxItems, nItem: Integer;
  Key: HKEY;
  szName: array[0..MAX_PATH] of Char;
  pt: TPoint;
begin
  // ����ͼ�����
  nMaxItems := ListView_GetItemCount(hWndLV);

  // �ؽ�ע����
  RegDeleteKey(HKEY_CURRENT_USER, g_szRegSubKey);
  RegCreateKeyEx(HKEY_CURRENT_USER, g_szRegSubKey, 0, nil,
    REG_OPTION_NON_VOLATILE, KEY_SET_VALUE, nil, Key, nil);

  // ����ÿ��ͼ��
  for nItem := 0 to nMaxItems - 1 do
  begin
    // ���ơ�λ��
    ListView_GetItemText(hWndLV, nItem, 0, szName, MAX_PATH);
    ListView_GetItemPosition(hWndLV, nItem, pt);

    // ����ע���
    RegSetValueEx(Key, szName, 0, REG_BINARY, @pt, SizeOf(TPoint));
  end;

  RegCloseKey(Key);
end;

  // �ָ�������Ŀλ��
procedure RestoreListViewItemPositions(hWndLV: HWND);
var
  Key: HKEY;
  nIndex, nItem: Integer;
  dwStyle, cbValueName, cbData, dwType: DWORD;
  szName: array[0..MAX_PATH] of Char;
  pt: TPoint;
  lvfi: TLVFindInfo;
begin
  if (RegOpenKeyEx(HKEY_CURRENT_USER, g_szRegSubKey, 0, KEY_QUERY_VALUE, Key) = ERROR_SUCCESS) then
  begin
    // �ر��Զ�����(ԭ���е�Ԓ)
    dwStyle := GetWindowLong(hWndLV, GWL_STYLE);
    if (dwStyle and LVS_AUTOARRANGE <> 0) then
      SetWindowLong(hWndLV, GWL_STYLE, dwStyle and not LVS_AUTOARRANGE);

    // ö��ע�����
    nIndex := 0;
    repeat
      cbValueName := MAX_PATH;
      cbData := SizeOf(TPoint);
      
      if (RegEnumValue(Key, nIndex, szName, cbValueName, nil,
        @dwType, PByte(@pt), @cbData) = ERROR_NO_MORE_ITEMS) then Break;
        
      if (dwType = REG_BINARY) and (cbData = SizeOf(TPoint)) then
      begin
        // ��������ƥ�������ͼ��
        lvfi.flags := LVFI_STRING;
        lvfi.psz := szName;
        nItem := ListView_FindItem(hWndLV, -1, lvfi);

        // �ҵ���ָ�Ϊ��ǰ��λ��
        if (nItem <> -1) then ListView_SetItemPosition(hWndLV, nItem, pt.X, pt.Y);
      end;

      Inc(nIndex);
    until FALSE;

    // �ָ��Զ�����(ԭ���е�Ԓ)
    SetWindowLong(hWndLV, GWL_STYLE, dwStyle);

    RegCloseKey(Key);
  end;
end;

  // �Ի���ص�
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  Result := TRUE;
  
  case (uMsg) of
    WM_CLOSE:
      Dlg_OnClose(hWnd);

    WM_APP:
      if (lParam <> 0) then
        SaveListViewItemPositions(wParam)
      else
        RestoreListViewItemPositions(wParam);

    else
      Result := FALSE;
  end;
end;

  // ���ӻص�
function GetMsgProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
const {$J+}
  fFirstTime: BOOL = TRUE; {$J-} // �״α�����
begin
  if (fFirstTime = TRUE) then
  begin
    fFirstTime := FALSE;

    // ��������˴���, ����������Ϣ��
    CreateDialog(HInstance, MakeIntResource(IDD_DIPS), 0, @Dlg_Proc);

    // ����DIPS.exe, �������׼������
    PostThreadMessage(PShared.g_dwThreadIdDIPS, WM_NULL, 0, 0);
  end;

  Result := CallNextHookEx(PShared.g_hhook, nCode, wParam, lParam);
end;

  // װж����
function SetDIPSHook(dwThreadId: DWORD): BOOL; stdcall;
begin
  Result := FALSE;

  // Ҫ��װ~
  if (dwThreadId <> 0) then
  begin
    if (PShared.g_hhook <> 0) then Exit;

    // ����DIPS.exe�߳�ID
    PShared.g_dwThreadIdDIPS := GetCurrentThreadId();

    // ��ָ���̰߳�װ����
    PShared.g_hhook := SetWindowsHookEx(WH_GETMESSAGE, @GetMsgProc, HInstance, dwThreadId);

    // ��װ�����Ƿ�ɹ�??
    Result := (PShared.g_hhook <> 0);

    // ��ʹ��������������
    if (Result) then Result := PostThreadMessage(dwThreadId, WM_NULL, 0, 0);
  end else
  begin
  // ����ж��~

    // ж�ع���
    if (PShared.g_hhook <> 0) then
    begin
      Result := UnhookWindowsHookEx(PShared.g_hhook);
      PShared.g_hhook := 0;
    end;
    
  end;
end;

  // DLL �ص�
procedure DLLMain(dwReason: DWORD);
begin
  if (dwReason = DLL_PROCESS_DETACH) then
  begin
    UnmapViewOfFile(PShared);
    CloseHandle(hFileMap);
  end;
end;

  // ��������
exports
  SetDIPSHook;

  // DLL ���
begin
  // ���ûص�
  DllProc := @DLLMain;

  // ���Դ�
  hFileMap := OpenFileMapping(FILE_MAP_ALL_ACCESS, FALSE, SHARE_NAME);

  // ��δ����
  if (hFileMap = 0) then hFileMap := CreateFileMapping(
    INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, SizeOf(TShareMem), SHARE_NAME);

  // ӳ���ڴ�  
  PShared := MapViewOfFile(hFileMap, FILE_MAP_ALL_ACCESS, 0, 0, 0);
end.
