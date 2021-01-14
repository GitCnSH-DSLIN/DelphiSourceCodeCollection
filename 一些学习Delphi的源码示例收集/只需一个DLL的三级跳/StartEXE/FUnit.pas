unit FUnit;

interface

uses Windows;

type
  TNode = record       // �ڴ�ӳ������ṹ
    MainThread: DWORD; // Start.exe�߳�ID
    ExplorerID: DWORD; // Explorer ����ID
  end;
  PNode = ^TNode;

const
  ExeMutex = 'JumpInsert_ExeMutex_Mazi'; // ��ֹ�������ͬʱ���в���
  DllMutex = 'JumpInsert_DllMutex_Mazi'; // ��ֻ֤����һ���߳�
  FileMapName = 'JumpInsert_FileMap_Mazi'; // �ڴ�ӳ���ļ���

var
  HMutex: THandle;  // �������
  Msg: TMsg;        // ��׼��Ϣ�ṹ
  FileMap: THandle; // �ڴ�ӳ���ļ����
  PtNode: PNode;    // ӳ���ڴ��ַ
  ExplorerPID: DWORD; // Explorer����ID

    //----Ѱ��ָ������,������ID----//
function FindProcess(ExeName: string): DWORD;
    //------------ DLL ------------//
procedure  GetMsgHookOn; external '..\JumpDLL\Insert.dll';
procedure GetMsgHookOff; external '..\JumpDLL\Insert.dll';
    //------------ DLL ------------//

implementation

type //----������Ϣ�ṹ----//
  TProcessEntry32 = packed record
    dwSize: DWORD;              // �ṹ�ߴ�
    cntUsage: DWORD;
    th32ProcessID: DWORD;       // this process
    th32DefaultHeapID: DWORD;
    th32ModuleID: DWORD;        // associated exe
    cntThreads: DWORD;
    th32ParentProcessID: DWORD; // this process's parent process
    pcPriClassBase: Longint;    // Base priority of process's threads
    dwFlags: DWORD;
    szExeFile: array[0..MAX_PATH - 1] of Char;
  end;
    //---------Tool API----------//
function CreateToolhelp32Snapshot(dwFlags, th32ProcessID: DWORD): THandle stdcall; external 'kernel32.dll';
function Process32First(hSnapshot: THandle; var lppe: TProcessEntry32): BOOL stdcall; external 'kernel32.dll';
function Process32Next(hSnapshot: THandle; var lppe: TProcessEntry32): BOOL stdcall; external 'kernel32.dll';
    //---------Tool API----------//

    //----Ѱ��ָ������,������ID----//
function FindProcess(ExeName: string): DWORD;
var
  sphandle: THandle;  Found: BOOL;
  PStruct: TProcessEntry32;
     // β���Ƿ�ƥ��,���ִ�Сд
  function AnsiEndsText(const ASubText, AText: string): Boolean;
  var
    P: PChar;
    L, L2: Integer;
  begin
    P := PChar(AText);
    L := Length(ASubText);
    L2 := Length(AText);
    Inc(P, L2 - L);
    if (L > L2) then
      Result := FALSE
    else
      Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE,P, L, PChar(ASubText), L) = 2;
  end;       
begin                                      	
  Result := 0;
    	        	
  sphandle := CreateToolhelp32Snapshot($00000002, 0);
  PStruct.dwSize := Sizeof(PStruct);
  Found := Process32First(sphandle, PStruct);

  while Found do
  begin
    if AnsiEndsText(ExeName, PStruct.szExefile) then
    begin
      Result := PStruct.th32ProcessID;
      Break;
    end;
    
    Found := Process32Next(sphandle, PStruct);
  end;
  
  CloseHandle(sphandle);
end;

end.
