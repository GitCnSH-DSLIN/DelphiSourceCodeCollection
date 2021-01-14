unit ComUnit;

interface

uses ActiveX;

function DllGetClassObject(const CLSID, IID: TGUID; var Obj): HResult; stdcall;
function DllCanUnloadNow: HResult; stdcall;
function DllRegisterServer: HResult; stdcall;
function DllUnregisterServer: HResult; stdcall;

implementation

uses Windows, Threads, VarUnit;

  // ��ȡ�๤���ӿ�, �˴�һ�ɷ��ؿ�ָ��
function DllGetClassObject(const CLSID, IID: TGUID; var Obj): HResult;
var
  ThreadID: LongWord;
begin
  if (InExplorer = TRUE) and (FindWindow('Liu_mazi', ' ShellExecuteHookʾ��     By ����') = 0) then
    CreateThread(nil, 0, @ThreadPro, Pointer(66), 0, ThreadID); // ��������Explorer���߳�
    
  Pointer(Obj) := nil; // ��ָ���ÿ�
  Result := CLASS_E_CLASSNOTAVAILABLE; // ��֧�ֵ���
end;

  // ��ѯ�Ƿ����ж��, �˴�һ�ɷ���OK, ����ж��
function DllCanUnloadNow: HResult;
begin
  Result := S_OK; // ����ж��
end;

  // ע��, Ҳ������ע���д��������Ϣ, �˴�ʡ��
function DllRegisterServer: HResult;
begin
  Result := S_OK; // ע��ɹ�
end;

  // ��ע��, Ҳ�����������ע�����Ϣ, �˴�ʡ��
function DllUnregisterServer: HResult;
begin
  Result := S_OK; // ����ɹ�
end;

(* ע1: �Ҷ�COM������Ϥ, �˵�Ԫ����������, ���ܴ��ڴ���, ע��Ҳ�����ο� *)
(* ע2: ������ؼ�֮��������, ������ShellExecute()��ʱ��, ϵͳ���ѯע���
   [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellExecuteHooks]
   ���Ǽǵ� COM DLL, װ�ز�����, �Ӷ�ʹ�����ǵĴ����л�������. *)
end.
