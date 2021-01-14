
// Module name: Module.C & Module.H ->> Module.dpr
// Notices: Copyright (c) 1995-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

library Module;

uses Windows, Messages, Other in '..\Other.pas';

var
  g_uMsgModCntChange: UINT = 0;
  g_pModuleUsage: PINT = nil;

  // DLL�ص�
procedure Dll_Proc(dwReason: DWORD);
begin
  case (dwReason) of
    DLL_PROCESS_ATTACH:
      begin
        g_pModuleUsage := SectionVirualAddress(HInstance, '.Shared', 4,
          IMAGE_SCN_MEM_SHARED or IMAGE_SCN_MEM_READ or IMAGE_SCN_MEM_WRITE);
        if (g_pModuleUsage = nil) then
        begin
          ExitCode := 1; // ��ֹװ��
          Exit;
        end;

        InterlockedIncrement(g_pModuleUsage^);
        g_uMsgModCntChange := RegisterWindowMessage('MsgModUsgCntChange');
        PostMessage(HWND_BROADCAST, g_uMsgModCntChange, 0, 0);
      end;

    DLL_PROCESS_DETACH:
      begin
        InterlockedDecrement(g_pModuleUsage^);
        PostMessage(HWND_BROADCAST, g_uMsgModCntChange, 0, 0);
      end;
  end;
end;

  // ���ؼ���
function GetModuleUsage(): DWORD;
begin
  Result := g_pModuleUsage^;
end;

  // ��������
exports
  GetModuleUsage;

  // DLLMain
begin
  DllProc := @Dll_Proc;
  Dll_Proc(DLL_PROCESS_ATTACH);
end.
