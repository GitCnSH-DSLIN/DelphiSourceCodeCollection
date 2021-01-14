unit JmpHook;

interface

procedure GetMsgHookOn;
procedure GetMsgHookOff;

implementation

uses
  Windows, Publics;

var
  GetMsgHook: HHOOK;     // ���Ӿ��
  LibraryH: DWORD;       // ���ӿ���
  ThreadPt: Pointer;     // �̺߳���
  ThreadID: DWORD;       // �����߳�ID
  ModuleFileName: array [0..MAX_PATH] of Char;
  
   // GetMessage���ӻص�����
function GetMsgHookPro(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  if (PtNode <> nil) and (PtNode^.ExplorerID <> 0) and
     (GetCurrentProcessId() = PtNode^.ExplorerID) then // ����Explorer����
  begin
  // װ���Լ����Ӽ���
    GetModuleFileName(HInstance, @ModuleFileName[0], MAX_PATH);
    LibraryH := LoadLibrary(ModuleFileName);

  // ��λDLL���̺߳���
    if (LibraryH <> 0) then ThreadPt := GetProcAddress(LibraryH, 'ThreadPro');

  // ����Explorer�߳�
    if (ThreadPt <> nil) then CreateThread(nil, 0, ThreadPt, Pointer($66666666), 0, ThreadID);
  end;
  
  Result:= CallNextHookEx(GetMsgHook, nCode, wParam, lParam);  
end;

procedure GetMsgHookOn;
begin
  GetMsgHook := SetWindowsHookEx(WH_GETMESSAGE, @GetMsgHookPro, HInstance, 0);
end;

procedure GetMsgHookOff;
begin
  UnHookWindowsHookEx(GetMsgHook);
end;

end.
