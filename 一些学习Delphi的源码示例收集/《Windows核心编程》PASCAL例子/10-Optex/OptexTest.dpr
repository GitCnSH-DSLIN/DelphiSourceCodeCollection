program OptexTest;

{$R 'Optex.res' 'Optex.rc'}

uses Windows, Messages, Optex in 'Optex.pas';

function SecondFunc(Optex: TOptex): Integer;
begin
  // ������Խ�ȥ,˵��������
  if (Optex.TryEnter() <> FALSE) then {DebugBreak()};

  // �ȴ����߳��뿪�ٽ���
  Optex.Enter();

  // ӵ�м�������
  Optex.Enter();
  MessageBox(0, 'Secondary: Entered the optex'#13#10'(Dismiss me 2nd)', 'OptexTest', 0);

  // ӵ�м�������, ������Ȼӵ��
  Optex.Leave();
  MessageBox(0, 'Secondary: The primary thread should not display a box yet', 'OptexTest', 0);

  // �뿪�ٽ���(�������߳�)
  Optex.Leave();

  Result := 0;
end;

procedure FirstFunc(fLocal: BOOL; Optex: TOptex);
var
  hOtherThread: THandle;
  dwThreadId: DWORD;
  si: TStartupInfo;
  pi: TProcessInformation;
  szPath: array[0..MAX_PATH] of Char;
begin
  // �����ٽ���
  Optex.Enter();

  // �ٴν���
  if (Optex.TryEnter() <> TRUE) then {DebugBreak()};

  // �����̲���
  if (fLocal) then
  begin
    // �������߳�(Ϊ�˲���)
    hOtherThread := BeginThread(nil, 0,  @SecondFunc, Pointer(Optex), 0, dwThreadId);
  end else
  begin
    // �����½���(Ϊ�˲���)
    GetModuleFileName(0, szPath, SizeOf(szPath));
    si.cb := SizeOf(TStartupInfo);
    CreateProcess(nil, szPath, nil, nil, FALSE, 0, nil, nil, si, pi);
    hOtherThread := pi.hProcess;
    CloseHandle(pi.hThread);
  end;

  // �ȴ��ڶ����߳�(�������½����е����߳�)����
  MessageBox(0, 'Primary: Hit OK to give optex to secondary', 'OptexTest', 0);

  // �뿪�ٽ���
  Optex.Leave();
  Optex.Leave();

  // �ȴ��ڶ����߳�ӵ�ж���
  MessageBox(0, 'Primary: Hit OK to wait for the optex'#13#10'(Dismiss me 1st)', 'OptexTest', 0);

  // �ȴ��ڶ����߳��ͷŶ���
  Optex.Enter();

  // �ȴ��ڶ����߳�(��ڶ�������)����
  WaitForSingleObject(hOtherThread, INFINITE);
  CloseHandle(hOtherThread);
  
  Optex.Leave();
end;

  // �������߳����
var
  hevt: THandle;
  OptexSingle, OptexCross: TOptex;
begin
  // ������������ж��Ƿ��ظ�����
  hevt := CreateEvent(nil, FALSE, FALSE, 'OptexTest');
  if (GetLastError() <> ERROR_ALREADY_EXISTS) then
  begin
    // ��һ��ʵ��

    // ���Ե����̶���
    OptexSingle := TOptex.Create;
    FirstFunc(TRUE, OptexSingle);
    OptexSingle.Free;

    // ���Զ���̶���
    OptexCross := TOptex.Create('CrossOptexTest');
    FirstFunc(FALSE, OptexCross);
    OptexCross.Free;
  end else
  begin
    // �ڶ���ʵ��

    // �ж����ӵ�����
    {DebugBreak();}

    // ���Զ���̶���
    OptexCross := TOptex.Create('CrossOptexTest');
    SecondFunc(OptexCross);
    OptexCross.Free;
  end;

  CloseHandle(hevt);
end.
