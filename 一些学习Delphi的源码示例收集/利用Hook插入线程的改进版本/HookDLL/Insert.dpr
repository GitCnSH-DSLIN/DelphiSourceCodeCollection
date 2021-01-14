library  Insert;

{$R '..\IconRes\LiuMazi.res' '..\IconRes\LiuMazi.txt'} // ����ͼ��

uses
  Windows, Messages,
  JumpHook in 'JumpHook.pas', Threads in 'Threads.pas',
  MainForm in 'MainForm.pas', Publics in 'Publics.pas';

exports
  JumpHookOn, JumpHookOff;

const
  FileMapName = 'HookInsert_FileMap_Mazi'; // �ڴ�ӳ���ļ�
  ProcessName = 'Explorer.exe';     // ������̶���
  
var
  PMainThreadID: PDWORD;
  MutexHandle, FileHandle, SubThreadID: DWORD;
  ModuleFileName: array [0..MAX_PATH] of Char;

begin
 // ���DLL����Ľ���
  ModuleFileName[GetModuleFileName(0, @ModuleFileName[0], MAX_PATH)] := #0;
  if CompareAnsiText(ExtractFileName(ModuleFileName), ProcessName) then
  begin
   // ��ֻ֤��һ���߳�
    MutexHandle := OpenMutex(MUTEX_ALL_ACCESS, FALSE, DllMutex);
    if (MutexHandle <> 0) then
    begin
      CloseHandle(MutexHandle)
    end  
    else begin
     // ��sProcess���߳�
      CreateThread(nil, 0, @ThreadPro, nil, 0, SubThreadID);
     // �����������ü���
      GetModuleFileName(HInstance, @ModuleFileName[0], MAX_PATH);
      LoadLibrary(@ModuleFileName[0]);
     // ֪ͨStart.exe�˳�
      FileHandle := OpenFileMapping(FILE_MAP_ALL_ACCESS, False, FileMapName);
      PMainThreadID := MapViewOfFile(FileHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0);
      PostThreadMessage(PMainThreadID^, WM_QUIT, 0, 0);
      UnmapViewOfFile(PMainThreadID);
      CloseHandle(FileHandle);                        
    end;
  end;  
end.
