unit PrjMisc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Dialogs,
  Controls, StdCtrls, Global;

procedure CheckPrevInstance;

implementation

uses MainFrm;

//-----------------------------------------------------------------------------
// ����: ��ֹ�����ڶ�������ʵ��
//-----------------------------------------------------------------------------
procedure CheckPrevInstance;
var
  Handle, Ret: HWND;
begin
  CreateMutex(nil, False, SSoftName);
  // ���֮ǰ�Ѿ�������һ��ʵ��
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    Handle := GetDesktopWindow;
    Handle := GetWindow(Handle, GW_CHILD);
    while IsWindow(Handle) do
    begin
      // �жϴ˴������Ա�־
      Ret := GetProp(Handle, PChar(SSoftName));
      if Ret = Handle then
      begin
        SetForegroundWindow(Handle);
        PostMessage(Handle, WM_SHOW_MAIN_WIN, 0, 0);
        Break;
      end;
      // ת�������б�����һ������.
      Handle := GetWindow(Handle, GW_HWNDNEXT);
    end;
    Halt;
  end;
end;

end.
