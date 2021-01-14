library StrLib;

uses Windows;

const
  MAX_STRINGS = 256; // �ַ�����������
  MAX_LENGTH  = 63;  // �ַ�����������
  SHARE_NAME  = 'Share'; // ӳ���ļ���

type
  PShareMem = ^TShareMem;
  TShareMem = record // �ڴ�ӳ��ṹ
    iTotal: Integer;
    szStrings: array[0..MAX_STRINGS - 1] of array[0..MAX_LENGTH] of WideChar;
  end;
  PGetStrCB = function (pString, pParam: Pointer): BOOL; stdcall; // �ص���ʽ

var
  FileMap: LongWord; // ӳ���ļ����
  PShared: PShareMem; // �ڴ�ӳ��ָ��

  // ����ַ���(Unicode��)
function AddStringW(pStringIn: PWideChar): BOOL; stdcall;
var
  i: Integer;
begin
  Result := FALSE;
  if (PShared.iTotal = MAX_STRINGS - 1) then Exit; // �ַ����б���
  if (pStringIn^ = #0) then Exit; // �����մ�
  for i := PShared.iTotal downto 1 do // Ѱ�Һ��ʲ����, ���Ƴ���λ
  begin
    if CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE, pStringIn, -1,
      @PShared.szStrings[i - 1][0], -1) in [2, 3] then Break; // ��С��
    CopyMemory(@PShared.szStrings[i][0], @PShared.szStrings[i - 1][0], (MAX_LENGTH + 1) * SizeOf(WideChar));
  end;
  CopyMemory(@PShared.szStrings[i][0], pStringIn, (MAX_LENGTH + 1) * SizeOf(WideChar));
  Inc(PShared.iTotal); // �ַ�����������
  Result := TRUE;
end;

  // ����ַ���(Ansi��)
function AddStringA(pStringIn: PChar): BOOL; stdcall;
var
  iLength: Integer;
  pWideStr: PWideChar;
begin
  iLength := MultiByteToWideChar(CP_ACP, 0, pStringIn, -1, nil, 0) + SizeOf(WideChar);
  GetMem(pWideStr, iLength);
  MultiByteToWideChar(CP_ACP, 0, pStringIn, -1, pWideStr, iLength); // ת��
  Result := AddStringW(pWideStr); // ����AddStringW()���
  FreeMem(pWideStr);
end;

  // ɾ���ַ���(Unicode��)
function DeleteStringW(pStringIn: PWideChar): BOOL; stdcall;
var
  i, j: Integer;
begin
  Result := FALSE;
  if (PShared.iTotal = 0) then Exit; // �ַ����б��
  if (pStringIn^ = #0) then Exit; // �����ִ�
  for i := 0 to PShared.iTotal - 1 do
  begin
    if CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
      pStringIn, -1, @PShared.szStrings[i][0], -1) = 2 then Break; // ���
  end;
  if (i = PShared.iTotal) then Exit;  // ������
  for j := i to PShared.iTotal - 1 do // �ƶ�����
    CopyMemory(@PShared.szStrings[j][0], @PShared.szStrings[j + 1][0], (MAX_LENGTH + 1) * SizeOf(WideChar));
  Dec(PShared.iTotal); // �ַ���������
  PShared.szStrings[PShared.iTotal][0] := #0; // �ÿ�
  Result := TRUE;
end;

  // ɾ���ַ���(Ansi��)
function DeleteStringA(pStringIn: PChar): BOOL; stdcall;
var
  iLength: Integer;
  pWideStr: PWideChar;
begin
  iLength := MultiByteToWideChar(CP_ACP, 0, pStringIn, -1, nil, 0) + SizeOf(WideChar);
  GetMem(pWideStr, iLength);
  MultiByteToWideChar(CP_ACP, 0, pStringIn, -1, pWideStr, iLength); // ת��
  Result := DeleteStringW(pWideStr); // ����DeleteStringW()ɾ��
  FreeMem(pWideStr);
end;

  // ö���ַ���(Unicode��)
function GetStringsW(pfnGetStrCallBack: PGetStrCB; pParam: Pointer): Integer; stdcall;
var
  bReturn: Boolean;
  i: Integer;
begin
  for i := 0 to PShared.iTotal -1 do
  begin
    bReturn := pfnGetStrCallBack(@PShared.szStrings[i][0], pParam); // �������ṩ�Ļص�����
    if (bReturn = FALSE) then
    begin
      Result := i + 1;  Exit; // ����ʵ��ö�ٴ���
    end;
  end;
  Result := PShared.iTotal;
end;

  // ö���ַ���(Ansi��)
function GetStringsA(pfnGetStrCallBack: PGetStrCB; pParam: Pointer): Integer; stdcall;
var
  bReturn: Boolean;
  i, iLength: Integer;
  pAnsiStr: PChar;
begin
  for i := 0 to PShared.iTotal - 1 do
  begin
    iLength := WideCharToMultiByte(CP_ACP, 0, @PShared.szStrings[i][0], -1, nil, 0, nil, nil) + SizeOf(Char);
    GetMem(pAnsiStr, iLength);
    WideCharToMultiByte(CP_ACP, 0, @PShared.szStrings[i][0], -1, pAnsiStr, iLength, nil, nil); // ת��
    bReturn := pfnGetStrCallBack(pAnsiStr, pParam); // �������ṩ�Ļص�����
    FreeMem(pAnsiStr);
    if (bReturn = FALSE) then // ������Ҫ��ֹͣ
    begin
      Result := i + 1;  Exit; // ����ʵ��ö�ٴ���
    end;
  end;
  Result := PShared.iTotal;
end;

exports
  AddStringW, AddStringA, DeleteStringW, DeleteStringA, GetStringsW, GetStringsA; // ����

  // ��ں���
procedure DLLMain(dwReason: DWORD);
begin
  if (dwReason = DLL_PROCESS_DETACH) then
  begin
    UnmapViewOfFile(PShared);
    CloseHandle(FileMap);
  end;
end;

begin
  DllProc := @DLLMain; // �������
  FileMap := OpenFileMapping(FILE_MAP_ALL_ACCESS, FALSE, SHARE_NAME); // ���Դ�
  if (FileMap = 0) then // δ����
  begin
    FileMap :=
      CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, SizeOf(TShareMem), SHARE_NAME);
    PShared := MapViewOfFile(FileMap, FILE_MAP_ALL_ACCESS, 0, 0, 0);
    ZeroMemory(PShared, SizeOf(TShareMem));
  end else
    PShared := MapViewOfFile(FileMap, FILE_MAP_ALL_ACCESS, 0, 0, 0);
end.
