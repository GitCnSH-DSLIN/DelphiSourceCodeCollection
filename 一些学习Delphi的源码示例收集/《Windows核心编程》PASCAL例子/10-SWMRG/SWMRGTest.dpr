program SWMRGTest;

{$R 'SWMRG.res' 'SWMRG.rc'}

uses Windows, Messages, SWMRG in 'SWMRG.pas';

  // ��Դ��������
var g_swmrg: TSWMRG;

  // �̻߳ص�����
function Thread(pvParam: Pointer): Integer;
var
  sz: array[0..50] of Char;
  n: Integer;
begin
  // ѡ���/д
  wvsprintf(sz, 'SWMRG Test: Thread %d', @pvParam);
  n := MessageBox(0, 'YES: Attempt to read'#13#10'NO: Attempt to write', sz, MB_YESNO);

  // ���Զ�/д
  if (n = IDYES) then
  begin
    g_swmrg.WaitToRead();
    MessageBox(0, 'OK stops READING', sz, MB_OK);
  end else
  begin
    g_swmrg.WaitToWrite();
    MessageBox(0, 'OK stops WRITING', sz, MB_OK);
  end;

  // ֹͣ��/д
  g_swmrg.Done();

  Result := 0;
end;

  // �������
var
  hThreads: array[1..MAXIMUM_WAIT_OBJECTS] of THandle;
  nThreads: Integer;
  dwThreadId: DWORD;
begin
  // ������������
  g_swmrg := TSWMRG.Create();

  // ����һ���߳�
  for nThreads := 1 to 8 do
    hThreads[nThreads] := BeginThread(nil, 0, @Thread, Pointer(nThreads), 0, dwThreadId);

  // �ȴ��߳̽���
  nThreads := 8;
  WaitForMultipleObjects(nThreads, @hThreads[1], TRUE, INFINITE);

  // �ر��߳̾��
  while (nThreads > 0) do
  begin
    CloseHandle(hThreads[nThreads]);
    Dec(nThreads);
  end;

  // �ͷű�������
  g_swmrg.Free();
end.
