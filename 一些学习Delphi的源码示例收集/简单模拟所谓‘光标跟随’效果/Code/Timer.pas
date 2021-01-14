unit Timer;

interface   

procedure TimerOn;  // ���������涨ʱ��
procedure TimerOff; // �رչ����涨ʱ��

implementation

uses
  Windows, HintWindow;

var
  TimerHandle: DWORD;

procedure TimerProc(hWnd: HWND; uMsg: UINT; idEvent: UINT; dwTime: DWORD); stdcall;
var
  FocusHandle: DWORD;
  CurrentPos: TPoint;
begin
  FocusHandle := GetFocus();
  AttachThreadInput(GetCurrentThreadId, GetWindowThreadProcessId(GetForegroundWindow(), nil), TRUE);
  GetCaretPos(CurrentPos);
  Windows.ClientToScreen(FocusHandle, CurrentPos);
  Active_Hint(CurrentPos.X + 5, CurrentPos.Y + 5, ' ������,�������������?  :-)');
end;

procedure TimerOn;
begin
  if (TimerHandle = 0) then TimerHandle := SetTimer(0, 0, 500, @TimerProc);
end;

procedure TimerOff;
begin
  if (TimerHandle <> 0) then
  begin
    KillTimer(0, TimerHandle);
    TimerHandle := 0;
  end;
end;

end.
