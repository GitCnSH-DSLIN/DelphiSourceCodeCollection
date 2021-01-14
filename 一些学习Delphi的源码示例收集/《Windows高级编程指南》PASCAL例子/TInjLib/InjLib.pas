
// Module name: InjLib.C & InjLib.H ->> InjLib.pas
// Notices: Copyright (c) 1995-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

unit InjLib;

interface

uses Windows;

function InjectLibA(hProcess: THandle; const lpszLibFile: PAnsiChar): BOOL; stdcall;
function InjectLibW(hProcess: THandle; const lpszLibFile: PWideChar): BOOL; stdcall;

implementation

uses ProcMem, Other;

  // ����Լ��
type
  PfnLoadLibrary = function (lpLibFileName: PByte): HMODULE; stdcall;
  PfnFreeLibrary = function (hLibModule: HMODULE): BOOL; stdcall;

  // �̲߳���
type
  PInjLibInfo = ^TInjLibInfo;
  TInjLibInfo = record
    fnLoadLibrary: PfnLoadLibrary;
    fnFreeLibrary: PfnFreeLibrary;
    pbLibFile: array[0 .. MAX_PATH * SizeOf(WideChar)] of Byte;
  end;

  // �����Ƶ��̴߳���
function ThreadFunc(var pInjLibInfo: TInjLibInfo): DWORD; stdcall;
begin
  // װ��ָ�����ӿ�
  Result := pInjLibInfo.fnLoadLibrary(@pInjLibInfo.pbLibFile);

  // װ�سɹ����ͷ�
  if (Result <> 0) then pInjLibInfo.fnFreeLibrary(Result);
end;

  // ����������볤��
procedure AfterThreadFunc();
begin
end;

  // ����Զ���߳� (�ɸ��߳�����ָ��DLL)
function InjectLibWorA(hProcess: THandle; pbLibFile: PByte; fUnicode: BOOL): BOOL;
label
  _Finally;
var
  hInstKrnl, hInstDllRemote: HMODULE;
  InjLibInfo: TInjLibInfo;
  pdwCodeRemote: PDWORD;
  pInjLibInfoRemote: PInjLibInfo;
  cbCodeSize, dwNumBytesXferred, dwThreadId, cbMemSize, dwOldProtect: DWORD;
  hThread: THandle;
  fOk: BOOL;
begin
  hThread := 0;
  hInstDllRemote := 0;
  
  // ���������ݳ���
  cbCodeSize := DWORD(@AfterThreadFunc) - DWORD(@ThreadFunc);
  cbMemSize := cbCodeSize + SizeOf(InjLibInfo) + 3;

  // ��дInjLibInfo
  hInstKrnl := GetModuleHandle('Kernel32');
  InjLibInfo.fnLoadLibrary := GetProcAddress(hInstKrnl, IfThen(fUnicode, 'LoadLibraryW', 'LoadLibraryA'));
  InjLibInfo.fnFreeLibrary := GetProcAddress(hInstKrnl, 'FreeLibrary');
  InjLibInfo.pbLibFile[0] := 0;
  if (fUnicode) then
    lstrcpyW(PWideChar(@InjLibInfo.pbLibFile), PWideChar(pbLibFile))
  else
    lstrcpyA(PAnsiChar(@InjLibInfo.pbLibFile), PAnsiChar(pbLibFile));

  // �����㹻���ڴ� (��ָ�����̿ռ�)
  pdwCodeRemote := AllocProcessMemory(hProcess, cbMemSize);
  if (pdwCodeRemote = nil) then goto _Finally;

  // ҳ�汣������
  fOk := VirtualProtectEx(hProcess, pdwCodeRemote, cbMemSize, PAGE_EXECUTE_READWRITE, dwOldProtect);
  if (fOk = FALSE) then goto _Finally;

  // д���̴߳���
  fOk := WriteProcessMemory(hProcess, pdwCodeRemote, @ThreadFunc, cbCodeSize, dwNumBytesXferred);
  if (fOk = FALSE) then goto _Finally;

  // ����ṹ��ַ **                                    
  pInjLibInfoRemote := Pointer(DWORD(pdwCodeRemote) + (cbCodeSize + 3) and (not 3));

  // д��ṹ����
  fOk := WriteProcessMemory(hProcess, pInjLibInfoRemote, @InjLibInfo, SizeOf(InjLibInfo), dwNumBytesXferred);
  if (fOk = FALSE) then goto _Finally;

  // ����Զ���߳�
  hThread := CreateRemoteThread(hProcess, nil, 0, pdwCodeRemote, pInjLibInfoRemote, 0, dwThreadId);
  if (hThread = 0) then goto _Finally;

  // �ȴ��߳̽���
  WaitForSingleObject(hThread, INFINITE);

_Finally:
  if (hThread <> 0) then
  begin
    GetExitCodeThread(hThread, hInstDllRemote); // �߳��˳����� = �̺߳�������ֵ = DLLװ�ص�ַ
    CloseHandle(hThread);
  end;

  // �ͷ�Զ���ڴ�
  if (pdwCodeRemote <> nil) then FreeProcessMemory(hProcess, pdwCodeRemote);

  // �Ƿ�����ɹ�
  Result := (hInstDllRemote <> 0);
end;

  // Զ��װ��DLL(Anis��)
function InjectLibA(hProcess: THandle; const lpszLibFile: LPCSTR): BOOL; stdcall;
begin
  Result := InjectLibWorA(hProcess, PByte(lpszLibFile), FALSE);
end;

  // Զ��װ��DLL(Wide��)
function InjectLibW(hProcess: THandle; const lpszLibFile: LPCWSTR): BOOL; stdcall;
begin
  Result := InjectLibWorA(hProcess, PByte(lpszLibFile), TRUE);
end;

end.
