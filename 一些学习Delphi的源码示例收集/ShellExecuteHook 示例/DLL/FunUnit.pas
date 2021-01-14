unit FunUnit;

interface

uses Windows;

function ExtractFileName(const FullName: string): string; // ����ļ���
function CompareAnsiText(const Str1, Str2: string): Boolean; // �ַ����Ƚ�
procedure SetRegStr(RootKey: HKEY; const StrPath, StrName, StrData: PChar); // ���ü�ֵ
procedure DelRegStr(RootKey: HKEY; const StrPath, StrValue: PChar); // ɾ����ֵ
function QueryRegStr(RootKey: HKEY; const StrPath, StrValue: PChar): Boolean; // ��ѯ��ֵ
procedure DeleteFileRestart(const FileName: string); // ɾ���ļ�(������)

implementation

  // ����ļ���
function ExtractFileName(const FullName: string): string;
var
  P: Integer;
begin
  P := Length(FullName);
  while (P > 0) and (FullName[P] <> '\') and (FullName[P] <> ':') do Dec(P);
  Result := Copy(FullName, P + 1, Length(FullName) - P);
end;

  // �ַ����Ƚ�
function CompareAnsiText(const Str1, Str2: string): Boolean;
begin
  Result :=
    CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE, @Str1[1], -1, @Str2[1], -1) = 2;
end;

  // ����ע����ֵ
procedure SetRegStr(RootKey: HKEY; const StrPath, StrName, StrData: PChar);
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

  // ɾ��ע����ֵ
procedure DelRegStr(RootKey: HKEY; const StrPath, StrValue: PChar);
var
  TempKey: HKEY;
  Disposition: LongWord;
begin
 // ��
	TempKey := 0;
  Disposition := REG_OPENED_EXISTING_KEY;
	RegCreateKeyEx(RootKey, StrPath, 0, nil, 0, KEY_ALL_ACCESS, nil, TempKey, @Disposition);

 // ɾ��
	RegDeleteValue(TempKey, StrValue);
  
 // �ر�
	RegCloseKey(TempKey);
end;

  // ��ѯע����ֵ
function QueryRegStr(RootKey: HKEY; const StrPath, StrValue: PChar): Boolean;
var
  TempKey: Hkey;
  Disposition, ValueType: LongWord;
begin
 // ��
	TempKey := 0;
  Disposition := REG_OPENED_EXISTING_KEY;
	RegCreateKeyEx(RootKey, StrPath, 0, nil, 0, KEY_ALL_ACCESS, nil, TempKey, @Disposition);

 // ��ѯ
	ValueType := REG_SZ;
	Result := RegQueryValueEx(TempKey, StrValue, nil, @ValueType, nil, nil) = ERROR_SUCCESS;
  
 // �ر�
	RegCloseKey(TempKey);
end;

  // ɾ���ļ�(������)
procedure DeleteFileRestart(const FileName: string);
    // �Ƿ�9x����ϵͳ
  function IsWindows9x(): Boolean;
  var
    Osi: TOSVersionInfo;
  begin
    Osi.dwOSVersionInfoSize := SizeOf(Osi);
    GetVersionEx(Osi);
    Result := Osi.dwPlatformId <> VER_PLATFORM_WIN32_NT;
  end;
var
  PathBuff: array[0..MAX_PATH] of Char;
begin
  if (IsWindows9x() = FALSE) then
    MoveFileEx(@FileName[1], nil, MOVEFILE_DELAY_UNTIL_REBOOT) // �ɸú���дע���
  else begin
    GetShortPathName(@FileName[1], @PathBuff[0], MAX_PATH); // תΪ"8.3������"���ļ���
    WritePrivateProfileString('rename', 'NUL', @PathBuff[0], 'wininit.ini'); // дwininit�ļ�
  end;
end;

end.
