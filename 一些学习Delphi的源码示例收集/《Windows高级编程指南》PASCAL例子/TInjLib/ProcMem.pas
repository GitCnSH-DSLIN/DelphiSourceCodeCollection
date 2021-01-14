
// Module name: ProcMem.C & ProcMem.H ->> ProcMem.pas
// Notices: Copyright (c) 1995-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

unit ProcMem;

interface

uses Windows;

function AllocProcessMemory(hProcess: THandle; dwNumBytes: DWORD): Pointer;
function FreeProcessMemory(hProcess: THandle; pvMem: Pointer): BOOL;

implementation

  // ����Զ���ڴ�
function AllocProcessMemory(hProcess: THandle; dwNumBytes: DWORD): Pointer;
label
  Finally_;
var
  Context: TContext;
  dwThreadId, dwNumBytesXferred, dwError: DWORD;
  hThread, hInstKrnl: THandle;
  mbi: TMemoryBasicInformation;
  fOk: BOOL;
begin
  hInstKrnl := GetModuleHandle(Kernel32);
  fOk := FALSE;
  Result := nil;

  // ����һ��������߳� (��������֮ǰ, ���ջ�ռ�һֱ����)
  hThread := CreateRemoteThread(hProcess, nil, dwNumBytes + SizeOf(THandle),
    GetProcAddress(hInstKrnl, 'ExitThread'), nil, CREATE_SUSPENDED, dwThreadId);
  if (hThread = 0) then
  begin
    dwError := GetLastError();
    goto Finally_;
  end;

  // ��ȡԶ���̻߳�����
  Context.ContextFlags := CONTEXT_CONTROL or CONTEXT_INTEGER;
  if (GetThreadContext(hThread, Context) = FALSE) then goto Finally_;

  // ��ѯջ��ָ�봦ҳ��
  fOk := VirtualQueryEx(hProcess, Pointer(Context.Esp - SizeOf(DWORD)), mbi, SizeOf(mbi)) = SizeOf(mbi);
  if (fOk = FALSE) then goto Finally_;

  // ���ύ��ջҳ�涥��
  Result := mbi.BaseAddress;

  // ��һ��DWORD�����߳̾��
  fOk := WriteProcessMemory(hProcess, Result, @hThread, SizeOf(hThread), dwNumBytesXferred);
  if (fOk = FALSE) then goto Finally_;

  Inc(PHandle(Result));

Finally_:
  if (fOk = FALSE) then
  begin
    if (hThread <> 0) then
    begin
      ResumeThread(hThread);
      CloseHandle(hThread);
    end;
    Result := nil;
  end;  
end;

  // �ͷ�Զ���ڴ�
function FreeProcessMemory(hProcess: THandle; pvMem: Pointer): BOOL;
var
  hThread: THandle;
  dwNumBytesXferred: DWORD;
begin
  // ��ȡ�߳̾��
  Dec(PHandle(pvMem));
  Result := ReadProcessMemory(hProcess, pvMem, @hThread, SizeOf(hThread), dwNumBytesXferred);

  // �ָ��߳�ִ�� (ʹ����Խ���, ���Ҷ�ջ�ռ䱻�ͷ�)
  if (Result) then
  begin
    if (ResumeThread(hThread) = $FFFFFFFF) then Result := FALSE;
    CloseHandle(hThread);
  end;
end;

end.

