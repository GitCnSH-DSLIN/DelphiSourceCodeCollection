
// Module name: SomeLib.C & SomeLib.H ->> SomeLib.dpr
// Notices: Copyright (c) 1995-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

library SomeLib;

{$R 'SomeLib.res' 'SomeLib.rc'}

uses
  Windows, Messages;

const
  IDS_STRINGFIRST = 1000;
  IDS_STRINGLAST = IDS_STRINGFIRST + 9;
  IDS_STRINGNUM = IDS_STRINGLAST - IDS_STRINGFIRST + 1;

const
  RESSTR_SIZE = 1000 * SizeOf(Char);

var
  g_hMutex: THandle = 0; // �������
  g_dwTlsIndex: DWORD = TLS_OUT_OF_INDEXES; // TLS����

  // ��ȡ��Դ�ַ���
function LoadResString(): PChar;
const {$J+}
  nStringId: Integer = 0; {$J-}
var
  lpszStr: PChar;
begin
  lpszStr := TlsGetValue(g_dwTlsIndex);
  if (lpszStr = nil) then
  begin
    lpszStr := HeapAlloc(GetProcessHeap(), 0, RESSTR_SIZE);
    TlsSetValue(g_dwTlsIndex, lpszStr);
  end;

  WaitForSingleObject(g_hMutex, INFINITE);
  LoadString(HInstance, IDS_STRINGFIRST + nStringId, lpszStr, RESSTR_SIZE);
  nStringId := (nStringId + 1) mod IDS_STRINGNUM;
  ReleaseMutex(g_hMutex);

  Result := lpszStr;
end;

  // DLL�ص�
procedure Dll_Proc(dwReason: DWORD);
var
  lpszStr: PChar;
begin
  case (dwReason) of
    DLL_PROCESS_ATTACH: // ������� (�ɵ���LoadLibrary���̵߳���)
      begin
        g_dwTlsIndex := TlsAlloc();
        if (g_dwTlsIndex = TLS_OUT_OF_INDEXES) then
        begin
          ExitCode := 1; // DLLMain����FALSE
          Exit;
        end;

        g_hMutex := CreateMutex(nil, FALSE, nil);
        if (g_hMutex = 0) then
        begin
          ExitCode := 1; // �Ӷ���ֹ�ɹ�װ��
          Exit;
        end;
      end;

    DLL_THREAD_DETACH: // �߳̽��� (�ɵ���ExitThread���̵߳���)
      begin
        if (g_dwTlsIndex <> TLS_OUT_OF_INDEXES) then
        begin
          lpszStr := TlsGetValue(g_dwTlsIndex);
          if (lpszStr <> nil) then HeapFree(GetProcessHeap(), 0, lpszStr);
        end;
      end;

    DLL_PROCESS_DETACH: // �뿪���� (�ɵ���FreeLibrary���̵߳���)
      begin
        if (g_dwTlsIndex <> TLS_OUT_OF_INDEXES) then
        begin
          lpszStr := TlsGetValue(g_dwTlsIndex);
          if (lpszStr <> nil) then HeapFree(GetProcessHeap(), 0, lpszStr);

          TlsFree(g_dwTlsIndex);
        end;

        if (g_hMutex <> 0) then CloseHandle(g_hMutex);
      end;
  end;
end;

  // ��������
exports
  LoadResString;

  // DLLMain
begin
  DllProc := @Dll_Proc;
  Dll_Proc(DLL_PROCESS_ATTACH);
end.
