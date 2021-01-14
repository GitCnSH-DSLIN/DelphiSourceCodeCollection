library Hook;

{$R '..\RES\Menu.res' '..\RES\Menu.txt'} // �˵���Դ
{$R '..\RES\Icon.res' '..\RES\Icon.txt'} // ͼ����Դ

uses
  Windows,
  ComUnit in 'ComUnit.pas',
  VarUnit in 'VarUnit.pas',
  FunUnit in 'FunUnit.pas',
  Threads in 'Threads.pas',
  WinUnit in 'WinUnit.pas';

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

var
  ModuleFileName: array [0..MAX_PATH] of Char;
  
begin
  ModuleFileName[GetModuleFileName(0, @ModuleFileName[0], MAX_PATH)] := #0;  // ��������ļ���
  if CompareAnsiText(ExtractFileName(ModuleFileName), 'Explorer.exe') then InExplorer := TRUE;
end.
