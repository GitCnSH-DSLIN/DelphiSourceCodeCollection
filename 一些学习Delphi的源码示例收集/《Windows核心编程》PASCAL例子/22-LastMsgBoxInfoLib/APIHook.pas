unit APIHook;

interface

uses Windows, ImageHlp, TlHelp32, Toolhelp;

type
  // API Hook ��
  TAPIHook = class(TObject)
  public
    constructor Create(pszCalleeModName, pszFuncName: LPSTR; pfnHook: FARPROC; fExcludeAPIHookMod: BOOL);
    destructor Destroy(); override;
    function OriginProc(): FARPROC; // ��Hook�ĺ�����ԭʼ��ַ
    class function ThisModuleIsAutoLoad(hModCallee, hModCaller: HMODULE): BOOL; // ģ���Ƿ��Զ�����
    class procedure HookLoadLibraryAndGetProcAddress(fInstall: BOOL); stdcall;  // Hook��̬���ú���
  private
    m_pNext: TAPIHook;          // ����������һ��ͬ�����
    m_pszCalleeModName: LPCSTR; // ��HOOK��������ģ����(ANSI)
    m_pszFuncName: LPCSTR;      // ��HOOK������(ANSI)
    m_pfnOrig: FARPROC;         // ԭʼ������ַ
    m_pfnHook: FARPROC;         // �滻������ַ
    m_fExcludeAPIHookMod: BOOL; // ��Hook��ģ��(LastMsgBoxInfoLib.dll)
    class procedure ReplaceIATEntryInAllMods(pszCalleeModName: LPCSTR; pfnCurrent, pfnNew: FARPROC; fExcludeAPIHookMod: BOOL); stdcall;
    class procedure ReplaceIATEntryInOneMod(pszCalleeModName: LPCSTR; pfnCurrent, pfnNew: FARPROC; hModCaller: HMODULE); stdcall;
    class procedure FixupNewlyLoadedModule(hMod: HMODULE; dwFlags: DWORD); stdcall;
  end;

implementation

type
  // DLL����ṹ
  TImageImportDescriptor = record
    OriginalFirstThunk: DWORD; // ���溯����Ϣ��TImageThunkData�����RVA
    TimeDateStamp, ForwarderChain: DWORD;
    Name: DWORD;               // DLL�����ַ�����RVA
    FirstThunk: DWORD;         // ��һ��TImageThunkData����Ŀ�����RVA, װ�غ�,
  end;                         // ��TImageThunkData���鱻�޸�Ϊ��������ڵ�ַ
  PImageImportDescriptor = ^TImageImportDescriptor;

  // ����������Ϣ
  TImageImportByName = packed record
    Hint: Word; // �����0, ��ʾ�����Ĳο����
    Name: array [0..0] of Char; // �������ַ���
  end;
  PImageImportByName = ^TImageImportByName;

  // ��������ṹ
  TImageThunkData = record
    case Integer of               // ���λ����1, ��ΪTImageImportByName��RVA,
      0: (ForwarderString: PByte);// ����, ��31λ��������ĺ��������, ����,
      1: (Function_: PDWORD);     // װ�غ�, �������һ�ݿ�����Ϊ��������ڵ�ַ
      2: (Ordinal: ULONG);
      3: (AddressOfData: PImageImportByName);
  end;
  PImageThunkData = ^TImageThunkData;

const
  cPushOpCode: Byte = $68; // 80x86������PUSHָ�������

var
  sm_pHead: TAPIHook = nil; // �����ͷ(�׸�HOOK����)
  sm_pvMaxAppAddr: Pointer = nil; // ���������õ�ַ
  sm_LoadLibraryA: TAPIHook = nil; // ��Ҫ����Hook����
  sm_LoadLibraryW: TAPIHook = nil;
  sm_LoadLibraryExA: TAPIHook = nil;
  sm_LoadLibraryExW: TAPIHook = nil;
  sm_GetProcAddress: TAPIHook = nil;

  // HookĿǰ������װ��ģ���һ��DLL�����ľ�̬����
constructor TAPIHook.Create(pszCalleeModName, pszFuncName: LPSTR; pfnHook: FARPROC; fExcludeAPIHookMod: BOOL);
var
  SI: TSystemInfo;
begin
  // �˴���ɷ��������ط� **
  if (sm_pvMaxAppAddr = nil) then
  begin
    GetSystemInfo(SI);
    sm_pvMaxAppAddr := SI.lpMaximumApplicationAddress;
  end;

  // ���Լ���ӵ���������
  m_pNext := sm_pHead;
  sm_pHead := Self;

  // ��������HOOK�����Ϣ
  m_pszCalleeModName := pszCalleeModName;
  m_pszFuncName := pszFuncName;
  m_pfnHook := pfnHook;
  m_fExcludeAPIHookMod := fExcludeAPIHookMod;
  m_pfnOrig := GetProcAddress(GetModuleHandleA(pszCalleeModName), m_pszFuncName);

  // ׼��Hook�ĺ���������
  if (m_pfnOrig = nil) then Exit;

  // ȡ����ʵ�ʵ�ַ **
  if (DWORD(m_pfnOrig) > DWORD(sm_pvMaxAppAddr)) then
  begin
    if (PByte(m_pfnOrig)^ = cPushOpCode) then
      m_pfnOrig := PPointer(DWORD(m_pfnOrig) + 1)^;
  end;

  // ��������װ��ģ��Hook
  ReplaceIATEntryInAllMods(m_pszCalleeModName, m_pfnOrig, m_pfnHook, m_fExcludeAPIHookMod);
end;

  // ��Ŀǰ������װ��ģ��ȡ��֮ǰ�ĺ���Hook
destructor TAPIHook.Destroy();
var
  p: TAPIHook;
begin
  // ��������װ��ģ�鷴Hook
  ReplaceIATEntryInAllMods(m_pszCalleeModName, m_pfnHook, m_pfnOrig, m_fExcludeAPIHookMod);

  // ���Լ��Ӷ���������ժ��
  if (sm_pHead = Self) then
    sm_pHead := sm_pHead.m_pNext
  else begin
    p := sm_pHead;
    while (p.m_pNext <> nil) do
    begin
      if (p.m_pNext = Self) then
      begin
        p.m_pNext := p.m_pNext.m_pNext;
        Break;
      end;
      p := p.m_pNext;
    end; // END while ..
  end;
end;

  // �滻������װ��ģ���������е�һ�������ĵ�ַ
class procedure TAPIHook.ReplaceIATEntryInAllMods(pszCalleeModName: LPCSTR;
  pfnCurrent, pfnNew: FARPROC; fExcludeAPIHookMod: BOOL); stdcall;
var
  hModThisMod: HMODULE;
  th: TToolhelp;
  me: TModuleEntry32;
  fOk: BOOL;
begin
  // �Ƿ�Hook��DLL (LastMsgBoxInfoLib.dll)
  if fExcludeAPIHookMod then hModThisMod := HInstance else hModThisMod := 0;

  // ���յ�ǰ�������̵�ģ���б�
  th := TToolhelp.Create(TH32CS_SNAPMODULE, GetCurrentProcessId());

  // ö�ٸ�ģ��, �ֱ���Hook����
  me.dwSize := SizeOf(TModuleEntry32);
  fOk := th.ModuleFirst(@me);
  while (fOk) do
  begin
    if (me.hModule <> hModThisMod) then
      ReplaceIATEntryInOneMod(pszCalleeModName, pfnCurrent, pfnNew, me.hModule);

    fOk := th.ModuleNext(@me);
  end;

  th.Free;
end;

  // �滻ָ����һ��ģ���������е�һ�������ĵ�ַ
class procedure TAPIHook.ReplaceIATEntryInOneMod(pszCalleeModName: LPCSTR;
  pfnCurrent, pfnNew: FARPROC; hModCaller: HMODULE); stdcall;
var
  ulSize: ULONG;
  pImportDesc: PImageImportDescriptor;
  pThunk: PImageThunkData;
  pszModName: LPSTR;
  ppfn: ^FARPROC;
  fFound: BOOL;
  dwProtect, dwTemp: DWORD;
begin
  // ��λ�����������
  pImportDesc := ImageDirectoryEntryToData(Pointer(hModCaller), TRUE, IMAGE_DIRECTORY_ENTRY_IMPORT, ulSize);
  if (pImportDesc = nil) then Exit;

  // ����TImageImportDescriptor���� (Ѱ������ƥ���DLL)
  // ע: Delphi���ɵ�PE�ļ�, ����һ��DLLֻռ�����һ��
  while (pImportDesc.Name <> 0) do
  begin
    pszModName := LPSTR(hModCaller + pImportDesc.Name);
    if (lstrcmpiA(pszModName, pszCalleeModName) = 0) then // DLL����ƥ��
    begin
      // ��λ��������ַ��
      pThunk := PImageThunkData(hModCaller + pImportDesc.FirstThunk);

      // ����TImageThunkData���� (Ѱ�ҵ�ַƥ��ĺ���)
      while (pThunk.Function_ <> nil) do
      begin
        // ������ַ������ַ
        ppfn := @pThunk.Function_;

        // �Ƿ�ҪHook�ĵ�ַ
        fFound := (ppfn^ = pfnCurrent);

        // ȡ������ʵ��ַ **
        if (fFound = FALSE) and (DWORD(ppfn^) > DWORD(sm_pvMaxAppAddr)) then
        begin
          if (PByte(ppfn^)^ = cPushOpCode) then
          begin
            ppfn := Pointer(DWORD(ppfn^) + 1);
            fFound := (ppfn^ = pfnCurrent);
          end;
        end;

        // �ҵ����дFunction_
        if (fFound) then
        begin
          VirtualProtect(ppfn, SizeOf(FARPROC), PAGE_EXECUTE_WRITECOPY, dwProtect);
          WriteProcessMemory(GetCurrentProcess(), ppfn, @pfnNew, SizeOf(FARPROC), dwTemp);
          VirtualProtect(ppfn, SizeOf(FARPROC), dwProtect, dwTemp);
          Break;
        end;

        // ��һ��TImageThunkData
        Inc(pThunk);
      end;
    end;

    // ��һ��TImageImportDescriptor
    Inc(pImportDesc);
  end;
end;

  // ����װ�ص�DLL����Hook����
class procedure TAPIHook.FixupNewlyLoadedModule(hMod: HMODULE; dwFlags: DWORD); stdcall;
var
  p: TAPIHook;
begin
  if (hMod <> 0) and (hMod <> HInstance) and (dwFlags and LOAD_LIBRARY_AS_DATAFILE = 0) then
  begin
    p := sm_pHead;
    while (p <> nil) do
    begin
      ReplaceIATEntryInOneMod(p.m_pszCalleeModName, p.m_pfnOrig, p.m_pfnHook, hMod);
      p := p.m_pNext;
    end;
  end;
end;

  // LoadLibraryA���滻����
function Hook_LoadLibraryA(pszModulePath: LPCSTR): HMODULE; stdcall;
begin
  Result := Windows.LoadLibraryA(pszModulePath);
  TAPIHook.FixupNewlyLoadedModule(Result, 0);
end;

  // LoadLibraryW���滻����
function Hook_LoadLibraryW(pszModulePath: LPCWSTR): HMODULE; stdcall;
begin
  Result := Windows.LoadLibraryW(pszModulePath);
  TAPIHook.FixupNewlyLoadedModule(Result, 0);
end;

  // LoadLibraryExA���滻����
function Hook_LoadLibraryExA(pszModulePath: LPCSTR; hFile: THandle; dwFlags: DWORD): HMODULE; stdcall;
begin
  Result := Windows.LoadLibraryExA(pszModulePath, hFile, dwFlags);
  TAPIHook.FixupNewlyLoadedModule(Result, dwFlags);
end;

  // LoadLibraryExW���滻����
function Hook_LoadLibraryExW(pszModulePath: LPCWSTR; hFile: THandle; dwFlags: DWORD): HMODULE; stdcall;
begin
  Result := Windows.LoadLibraryExW(pszModulePath, hFile, dwFlags);
  TAPIHook.FixupNewlyLoadedModule(Result, dwFlags);
end;

  // GetProcAddress()���滻����
function Hook_GetProcAddress(hMod: HMODULE; pszProcName: LPCSTR): FARPROC; stdcall;
var
  p: TAPIHook;
begin
  // ����������GetProcAddress()
  Result := Windows.GetProcAddress(hMod, pszProcName);

  if (hMod <> HInstance) and (Result <> nil) then
  begin
    p := sm_pHead;
    while (p <> nil) do
    begin
      // �����������ѱ�Hook, �����滻������ַ
      if (Result = p.m_pfnOrig) then
      begin
        Result := p.m_pfnHook;
        Break;
      end;
      p := p.m_pNext;
    end;
  end;
  
end;

  // ���ر�������Hook��DLL������ʵ�ʵ�ַ
function TAPIHook.OriginProc(): FARPROC;
begin
  Result := m_pfnOrig;
end;

  // hModCallee�Ƿ�hModCaller��̬����
class function TAPIHook.ThisModuleIsAutoLoad(hModCallee, hModCaller: HMODULE): BOOL;
var
  ulSize: ULONG;
  pImportDesc: PImageImportDescriptor;
  pszModName: LPSTR;
begin
  Result := FALSE;

  // ��λ����ǰ����EXE�ĺ��������
  pImportDesc := ImageDirectoryEntryToData(Pointer(hModCaller), TRUE, IMAGE_DIRECTORY_ENTRY_IMPORT, ulSize);
  if (pImportDesc = nil) then Exit;

  // ����ImageImportDescriptor����
  while (pImportDesc.Name <> 0) do
  begin
    // ��鱻���õ�DLL��ַ�Ƿ�ƥ��
    pszModName := LPSTR(hModCaller + pImportDesc.Name);
    if (GetModuleHandle(pszModName) = hModCallee) then
    begin
      Result := TRUE;
      Exit;
    end;

    // ��һ��TImageImportDescriptor
    Inc(pImportDesc);
  end;
end;

  // Hook LoadLibrary��GetProcAddress, �Ա���Ӷ�̬����
class procedure TAPIHook.HookLoadLibraryAndGetProcAddress(fInstall: BOOL); stdcall;
begin
  if fInstall then
  begin
    if (sm_LoadLibraryA = nil) then
      sm_LoadLibraryA := TAPIHook.Create(Kernel32, 'LoadLibraryA', @Hook_LoadLibraryA, TRUE);

    if (sm_LoadLibraryW = nil) then
      sm_LoadLibraryW := TAPIHook.Create(Kernel32, 'LoadLibraryW', @Hook_LoadLibraryW, TRUE);

    if (sm_LoadLibraryExA = nil) then
      sm_LoadLibraryExA := TAPIHook.Create(Kernel32, 'LoadLibraryExA', @Hook_LoadLibraryExA, TRUE);

    if (sm_LoadLibraryExW = nil) then
      sm_LoadLibraryExW := TAPIHook.Create(Kernel32, 'LoadLibraryExW', @Hook_LoadLibraryExW, TRUE);

    if (sm_GetProcAddress = nil) then
      sm_GetProcAddress := TAPIHook.Create(Kernel32, 'GetProcAddress', @Hook_GetProcAddress, TRUE);
  end else
  begin
    sm_LoadLibraryA.Free;
    sm_LoadLibraryA := nil;

    sm_LoadLibraryW.Free;
    sm_LoadLibraryW := nil;

    sm_LoadLibraryExA.Free;
    sm_LoadLibraryExA := nil;

    sm_LoadLibraryExW.Free;
    sm_LoadLibraryExW := nil;

    sm_GetProcAddress.Free;
    sm_GetProcAddress := nil;
  end;
end;

end.
