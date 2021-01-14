program TimedMsgBox;

{$R 'TimedMsgBox.res' 'TimedMsgBox.rc'}

uses Windows;

const g_szCaption = 'Timed Message Box';

var g_nSecLeft: Integer = 0;

  // �����ص�
procedure MsgBoxTimeout(pvContext: Pointer; fTimeout: Bool); stdcall;
const
  ID_MSGBOX_STATIC_TEXT = $FFFF; // MessageBox()�������ֿؼ�ID
var
  hWndMsgBox: HWND; // MessageBox()���ھ��
  sz: array[0..100] of Char;
begin
  hWndMsgBox := FindWindow(nil, g_szCaption);
  if (hWndMsgBox = 0) then Exit;

  if (g_nSecLeft = 0) then
    EndDialog(hWndMsgBox, IDOK) // ����MessageBox()ģ̬�Ի���
  else begin
    wvsprintf(sz, 'You have %d seconds to respond ..', @g_nSecLeft);
    SetDlgItemText(hWndMsgBox, ID_MSGBOX_STATIC_TEXT, sz);
    Dec(g_nSecLeft);
  end;
end;

  // ϵͳ�汾
function IsWindows9x(): Bool;
var
  vi: TOSVersionInfo;
begin
  vi.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(vi);
  Result := (vi.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS);
end;

  // �������
type
  TCreateTimerQueueTimer = function (var phNewTimer: THandle; hTimerQueue: THandle;
    pfnCallback, pvContext: Pointer; dwDueTime, dwPeriod, dwFlags: DWORD): Bool; stdcall;
  TDeleteTimerQueueTimer = function (hTimerQueue, hTimer, hCompletionEvent: THandle): Bool; stdcall;
var
  KernelHandle, hTimerQTimer: THandle;
  CreateTimerQueueTimer: TCreateTimerQueueTimer;
  DeleteTimerQueueTimer: TDeleteTimerQueueTimer;
begin
  // �ж�ϵͳ
  if IsWindows9x() then
  begin
    MessageBox(0, 'This application requires features not present in Windows 9x.', 'TimedMsgBox', 0);
    Exit;
  end;

  // ��λ����
  KernelHandle := GetModuleHandle(kernel32);
  @CreateTimerQueueTimer := GetProcAddress(KernelHandle, 'CreateTimerQueueTimer');
  @DeleteTimerQueueTimer := GetProcAddress(KernelHandle, 'DeleteTimerQueueTimer');
  if (@CreateTimerQueueTimer = nil) or (@DeleteTimerQueueTimer = nil) then
  begin
    MessageBox(0, 'The fixed position function failure.', 'TimedMsgBox', 0);
    Exit;
  end;

  // �ȴ�����
  g_nSecLeft := 10;

  // ������ʱ
  CreateTimerQueueTimer(hTimerQTimer, 0, @MsgBoxTimeout, nil, 1000, 1000, 0);

  // ��ʾ����
  MessageBox(0, 'You have 10 seconds to respond ..', g_szCaption, MB_OK);

  // ɾ����ʱ
  DeleteTimerQueueTimer(0, hTimerQTimer, 0);

  // Ϊ�η���
  if (g_nSecLeft = 0) then
    MessageBox(0, 'Timeout', 'Result', MB_OK)          // ����10��
  else
    MessageBox(0, 'User responded', 'Result', MB_OK);  // �ֶ�ֹͣ
end.
