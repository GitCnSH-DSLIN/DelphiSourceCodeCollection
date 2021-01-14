program Start;

{$R '..\IconRes\Liumazi.res' '..\IconRes\Liumazi.txt'}

uses Windows, FUnit in 'FUnit.pas';

begin
  if (OpenMutex(MUTEX_ALL_ACCESS, FALSE, ExeMutex) <> 0) or
     (OpenMutex(MUTEX_ALL_ACCESS, FALSE, DllMutex) <> 0) then Exit;
     
 // �����������              
  HMutex := CreateMutex(nil, TRUE, ExeMutex);
  
 // Ѱ��Explorer
  ExplorerPID := FindProcess('Explorer.exe');
  if (ExplorerPID = 0) then
  begin
    MessageBox(0, 'Ѱ��Explorer���� ', nil, 0);  Exit;
  end;
  
 // ����ӳ���ļ�
  FileMap := CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, SizeOf(TNode), FileMapName);
  if (FileMap = 0) then
  begin
    MessageBox(0, '����ӳ���ļ����� ', nil, 0);  Exit;
  end;
  
 // ӳ�䵽������
  PtNode := MapViewOfFile(FileMap, FILE_MAP_WRITE, 0, 0, 0);
  if (PtNode = nil) then
  begin
    MessageBox(0, 'ӳ�䵽�����̳��� ', nil, 0);    
    CloseHandle(FileMap);  Exit;
  end;

 // д������
  PtNode^.MainThread := GetCurrentThreadID();
  PtNode^.ExplorerID := ExplorerPID;

 // �ر�ӳ��
  UnmapViewOfFile(PtNode);
  
 // �����平��
  GetMsgHookOn;

 // ��Ϣѭ��(1.�̲߳���������,ʹ�����平�ӳ�����Ч; 2.�ȴ�����Explorer�����̷߳���WM_QUIT)
  while GetMessage(Msg, 0, 0, 0) do;
  
 // �����平��
  GetMsgHookOff;

 // �ر�ӳ���ļ�
  CloseHandle(FileMap);
  
 // �ͷŻ������
  ReleaseMutex(HMutex);
end.
