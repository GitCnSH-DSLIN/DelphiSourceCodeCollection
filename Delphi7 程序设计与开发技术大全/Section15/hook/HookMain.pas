unit HookMain;

interface

uses Windows,Messages,Dialogs,SysUtils;

type
  TShareData=record   //������Ϣ�Լ���Ϣ�����ݽṹ
    data1:array[1..2] of DWORD;       //������Ϣ�Ľ��̾������ϢID
    data2:TMOUSEHOOKSTRUCT;  //��깳����Ϣ����
  end;

const
  VirtualFileName = 'ShareDllData';
  DataSize = sizeof (TShareData);

var
  hMapFile:THandle;    // �ڴ�ӳ���ļ����
  ShareData:^TShareData; //��������ָ��
  InstalledHook:HHook;       //��װ�Ĺ��Ӿ��

  function HookHandler(iCode:Integer;wParam:WPARAM;lParam:LPARAM):
    LRESULT;stdcall;export;
  function OpenGetKeyHook(sender:HWND;MessageID:WORD):BOOL;stdCall;export;
  function CloseGetKeyHook:BOOL;stdCall;export;
  function GetX:integer;stdcall;export;
  function GetY:integer;stdcall;export;

implementation

function HookHandler(iCode:Integer;wParam:WPARAM;lParam:LPARAM):LRESULT;stdcall;export;
begin
  ShareData^.data2:=pMOUSEHOOKSTRUCT(lparam)^; {��������Ϣ���ݱ��浽ӳ���ڴ��ļ�}
  SendMessage(ShareData^.data1[1],
      ShareData^.data1[2],wParam,0);{�������ڷ��������Ϣ}
  Result:=CallNextHookEx(InstalledHook,iCode,wParam,lParam); {���ù���������һ������}
end;

function OpenGetKeyHook(sender:HWND;MessageID:WORD):BOOL;stdCall;export;
begin
  Result:=False;
  if InstalledHook = 0 then                  {û�а�װ����}
  begin
    ShareData^.data1[1]:=sender;
    ShareData^.data1[2]:=MessageID ;
    InstalledHook := SetWindowsHookEx(WH_mouse,HookHandler,HInstance,0);
    Result:=InstalledHook<>0;
  end;
end;

function CloseGetKeyHook:BOOL;stdCall;export;
begin
  if InstalledHook<>0 then                 {��װ����}
  begin
    UnhookWindowshookEx(InstalledHook);    {�����Ӵӹ������ӳ�}
    InstalledHook:=0;
  end;
  Result:=InstalledHook=0;
end;

function GetX:integer;stdcall;export;
begin
  result :=  ShareData^.data2.pt.X;   {�������λ�õ�X����}
end;

function GetY:integer;stdcall;export;
begin
   result :=  ShareData^.data2.pt.Y ;  {�������λ�õ�Y����}
end;

initialization
  InstalledHook:=0;
  hMapFile:= CreateFileMapping ($FFFFFFFF,nil,
      Page_ReadWrite, 0, DataSize, VirtualFileName);{�����ڴ�ӳ���ļ�}
  if hMapFile = 0 then                                  {�������}
      Raise Exception.Create('�����������ݵ�Buffer���ɹ�!');
   ShareData := MapViewOfFile ( hMapFile, File_Map_Write,
       0, 0, DataSize);                                {����ڴ�ӳ���ļ��ľ��}

finalization
   UnMapViewOfFile(ShareData);  {�ͷ��ڴ�ӳ���ļ�}
   CloseHandle (hMapFile);   
end.
