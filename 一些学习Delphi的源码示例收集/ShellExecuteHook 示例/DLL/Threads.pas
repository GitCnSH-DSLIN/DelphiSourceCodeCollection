unit Threads;

interface

procedure ThreadPro(X: Integer); stdcall; // �̺߳���

implementation

uses Windows, Messages, WinUnit;

  // �̺߳���
procedure ThreadPro(X: Integer); stdcall;
var
  ModuleFileName: array [0..MAX_PATH] of Char;
  Msg: TMsg;
  ContinueLoop: Boolean;
begin
 // ��ֹ�ظ�
  if (FindWindow('Liu_mazi', 'ShellExecuteHook') <> 0) then Exit;

 // ע�ᴰ����
  RegWinClass();
  
 // ��������
  CreateMyWin();

 // ���Ӽ���
  ModuleFileName[GetModuleFileName(HInstance, @ModuleFileName[0], MAX_PATH)] := #0;
  LoadLibrary(@ModuleFileName[0]);

 // ��Ϣѭ��
  ContinueLoop := TRUE;
  while ContinueLoop do
  begin
    if not PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then // δȡ����Ϣ
      WaitMessage() // ����, ֱ������Ϣ�������
    else begin
      if (Msg.message = WM_QUIT) then
        ContinueLoop := FALSE // ֹͣѭ��
      else begin
        TranslateMessage(Msg); // ת��
        DispatchMessage(Msg);  // �ַ�
      end;
    end;
  end;

 // ע��������  
  DesWinClass();

 // ���ټ���
  FreeLibraryAndExitThread(HInstance, 66);
end;

end.
