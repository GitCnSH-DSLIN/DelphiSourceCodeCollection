unit  Threads;

interface

  // �����̻߳ص�����
procedure ThreadPro(X: Integer); stdcall;

implementation

uses Windows, Messages, MainForm, Publics;

  // �����̻߳ص�����
procedure ThreadPro(X: Integer); stdcall;
var
  MsgStruct: TMsg;
  hMutexObj: DWORD;
begin
  hMutexObj := CreateMutex(nil, FALSE, DllMutex);

  Register_MainForm;
  Create_MainForm;
  while GetMessage(MsgStruct, 0, 0, 0) do
  begin
    TranslateMessage(MsgStruct);
    DispatchMessage(MsgStruct);
  end;
  Unregister_MainForm;
  
  CloseHandle(hMutexObj);
  FreeLibraryAndExitThread(HInstance, 0);            
end;

(* ע,����߳��д���,Ҳ������FindWindow����ֹ�ظ����� *)
end.
