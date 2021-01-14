unit Thread_Unit;

interface

procedure Create_SubThread;
procedure Quit_SubThread;

implementation

uses
  Windows, Messages, Public_Unit;

var
  SubThreadID: Longword;   // ���߳�ID
  TimerHandle: Longword;   // ʱ�Ӿ��
  Leftway: Boolean=False;  // �����־

     // ʱ�ӻص�����
procedure TimerProc(hwnd: HWND; uMsg: UINT; idEvent: UINT; dwTime: DWORD ); stdcall;
begin
   if ContinueAdd=False then Exit;
       // ����һ������λ����
  SendMessage(StatusHandle, PBM_STEPIT, 0, 0);
       // �����������Ƿ�����
  if SendMessage(StatusHandle, PBM_GETPOS, 0, 0)=33 then
  begin
    sleep(600);  Leftway := not Leftway;  // ����������ȡ��
    if Leftway then
      SetWindowLong(StatusHandle,GWL_EXSTYLE, GetWindowLong(StatusHandle, GWL_EXSTYLE) or WS_EX_LAYOUTRTL)
    else
      SetWindowLong(StatusHandle,GWL_EXSTYLE, GetWindowLong(StatusHandle, GWL_EXSTYLE) and not WS_EX_LAYOUTRTL);
  end;
end;

    // �߳��庯��
procedure SubThreadPro; stdcall;
var
  SubMessage: TMSG;
begin
  TimerHandle := SetTimer(0, 0, 30, @TimerProc);
  while GetMessage(SubMessage, 0, 0, 0) do DispatchMessage(SubMessage);
  KillTimer(TimerHandle, 0);
end;

    // �������߳�
procedure Create_SubThread;
begin
  CreateThread(nil, 0, @SubThreadPro, nil, 0, SubThreadID);
end;
    // �˳����߳�
procedure Quit_SubThread;
begin
  PostThreadMessage(SubThreadID, WM_QUIT, 0, 0);
end;

{ ע. �����߳��а�װʱ��,��Ϊ�˸������̼߳���,����
 ����WM_TIMER����������Ϣ��Ӧ����(����:��ק������) }

end.
