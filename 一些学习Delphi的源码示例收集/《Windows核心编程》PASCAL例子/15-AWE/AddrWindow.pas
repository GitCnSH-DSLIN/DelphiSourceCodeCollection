unit AddrWindow;

interface

uses Windows;

function Initialize_AWE(): BOOL; // ��λ����

type
  TAddrWindow = class(TObject)   // ���ڵ�ַ
  public
    constructor Create();
    destructor Destroy(); override;
    function AW_Create(dwBytes: ULONG; pvPreferredWindowBase: Pointer = nil): BOOL;
    function AW_Destroy(): BOOL;
    function AW_UnmapStorage(): BOOL;
    function AW_Pointer(): Pointer;
  private
    m_pvWindow: Pointer;
    sm_sinf: TSystemInfo;
  end;

  TAddrWindowStorage = class(TObject) // RAM ��
  public
    constructor Create();
    destructor Destroy(); override;
    function AWS_Allocate(ulBytes: ULONG): BOOL;
    function AWS_Free(): BOOL;
    function AWS_HowManyPagesAllocated(): ULONG;
    function AWS_MapStorage(aw: TAddrWindow): BOOL;
    function AWS_UnmapStorage(aw: TAddrWindow): BOOL;
  private
    m_ulPages: ULONG;
    m_pulUserPfnArray: PULONG;
    sm_sinf: TSystemInfo;
    function EnablePrivilege(pszPrivName: PChar; fEnable: BOOL = TRUE): BOOL;
  end;

implementation

const
  MEM_PHYSICAL = $400000;
  SE_LOCK_MEMORY_NAME = 'SeLockMemoryPrivilege';

type
  TAllocateUserPhysicalPages = function (hProcess: THandle; NumberOfPages, UserPfnArray: PULONG): BOOL; stdcall;
  TFreeUserPhysicalPages = function (hProcess: THandle; NumberOfPages, UserPfnArray: PULONG): BOOL; stdcall;
  TMapUserPhysicalPages = function (lpAddress: Pointer; NumberOfPages: ULONG; UserPfnArray: PULONG): BOOL; stdcall;

var
  AllocateUserPhysicalPages: TAllocateUserPhysicalPages;
  FreeUserPhysicalPages: TFreeUserPhysicalPages;
  MapUserPhysicalPages: TMapUserPhysicalPages;

  // ��λ AWE ����
function Initialize_AWE(): BOOL;
var
  hKernel: THandle;
begin
  hKernel := GetModuleHandle(kernel32);
  if (hKernel <> 0) then
  begin
    @AllocateUserPhysicalPages := GetProcAddress(hKernel, 'AllocateUserPhysicalPages');
    @FreeUserPhysicalPages := GetProcAddress(hKernel, 'FreeUserPhysicalPages');
    @MapUserPhysicalPages := GetProcAddress(hKernel, 'MapUserPhysicalPages');
  end;
  Result := (hKernel <> 0) and Assigned(AllocateUserPhysicalPages) and
    Assigned(MapUserPhysicalPages) and Assigned(FreeUserPhysicalPages);
end;

constructor TAddrWindow.Create();
begin
  m_pvWindow := nil;
  GetSystemInfo(sm_sinf);
end;

destructor TAddrWindow.Destroy();
begin
  AW_Destroy();
end;

  // ������ַ����
function TAddrWindow.AW_Create(dwBytes: ULONG; pvPreferredWindowBase: Pointer = nil): BOOL;
begin
  m_pvWindow := VirtualAlloc(pvPreferredWindowBase, dwBytes, MEM_RESERVE or MEM_PHYSICAL, PAGE_READWRITE);
  Result := (m_pvWindow <> nil);
end;

  // �ͷŵ�ַ����
function TAddrWindow.AW_Destroy(): BOOL;
begin
  if (m_pvWindow <> nil) then
  begin
    Result := VirtualFree(m_pvWindow, 0, MEM_RELEASE);
    m_pvWindow := nil;
  end else
    Result := TRUE;
end;

  // ȡ�� RAM ӳ��
function TAddrWindow.AW_UnmapStorage(): BOOL;
var
  mbi: TMemoryBasicInformation;
begin
  VirtualQuery(m_pvWindow, mbi, SizeOf(mbi));
  Result := MapUserPhysicalPages(m_pvWindow, mbi.RegionSize div sm_sinf.dwPageSize, nil);
end;

  // ���ش��ڵ�ַ
function TAddrWindow.AW_Pointer(): Pointer;
begin
  Result := m_pvWindow;
end;

constructor TAddrWindowStorage.Create();
begin
  m_ulPages := 0;
  m_pulUserPfnArray := nil;
  GetSystemInfo(sm_sinf);
end;

destructor TAddrWindowStorage.Destroy();
begin
  AWS_Free();
end;

  // �������� RAM
function TAddrWindowStorage.AWS_Allocate(ulBytes: ULONG): BOOL;
begin
  // �����ǰ�ķ���
  AWS_Free();

  // �����ڴ�ҳ����
  m_ulPages := (ulBytes + sm_sinf.dwPageSize) div sm_sinf.dwPageSize;

  // ����ҳ�������
  m_pulUserPfnArray := HeapAlloc(GetProcessHeap(), 0, m_ulPages * SizeOf(ULONG));
  
  if (m_pulUserPfnArray <> nil) then
  begin
    // ���� RAM ҳ��
    EnablePrivilege(SE_LOCK_MEMORY_NAME, TRUE);
    Result := AllocateUserPhysicalPages(GetCurrentProcess(), @m_ulPages, m_pulUserPfnArray);
    EnablePrivilege(SE_LOCK_MEMORY_NAME, FALSE);
  end else
    Result := FALSE;
end;

  // �ͷ����� RAM
function TAddrWindowStorage.AWS_Free(): BOOL;
begin
  if (m_pulUserPfnArray <> nil) then
  begin
    // �ͷ� RAM ҳ��
    if FreeUserPhysicalPages(GetCurrentProcess(), @m_ulPages, m_pulUserPfnArray) then
    begin
      // �ͷ�ҳ�������
      HeapFree(GetProcessHeap(), 0, m_pulUserPfnArray);

      m_ulPages := 0;
      m_pulUserPfnArray := nil;

      Result := TRUE;
    end else
      Result := FALSE;
  end else
    Result := TRUE;  
end;

  // ����ҳ������
function TAddrWindowStorage.AWS_HowManyPagesAllocated(): ULONG;
begin
  Result := m_ulPages;
end;

  // ӳ��RAM������
function TAddrWindowStorage.AWS_MapStorage(aw: TAddrWindow): BOOL;
begin
  Result := MapUserPhysicalPages(aw.AW_Pointer, AWS_HowManyPagesAllocated(), m_pulUserPfnArray);
end;

  // ȡ�� RAM ӳ��
function TAddrWindowStorage.AWS_UnmapStorage(aw: TAddrWindow): BOOL;
begin
  Result := MapUserPhysicalPages(aw.AW_Pointer, AWS_HowManyPagesAllocated(), nil);
end;

  // �����û�Ȩ��
function TAddrWindowStorage.EnablePrivilege(pszPrivName: PChar; fEnable: BOOL = TRUE): BOOL;
var
  hToken: THandle;
  tp: TTokenPrivileges;
begin
  // �򿪽�������
  if OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES, hToken) then
  begin
    // ����Ȩ��Luid
    tp.PrivilegeCount := 1;
    LookupPrivilegeValue(nil, pszPrivName, tp.Privileges[0].Luid);

    // ������߽�ֹ
    if fEnable then
      tp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED
    else
      tp.Privileges[0].Attributes := 0;

    // �����û�Ȩ��
    AdjustTokenPrivileges(hToken, FALSE, tp, SizeOf(TTokenPrivileges), PTokenPrivileges(nil)^, PULONG(nil)^);
    Result := (GetLastError() = ERROR_SUCCESS);

    CloseHandle(hToken);
  end else
    Result := FALSE;
end;

  // ע, �����ӵ�Window XP�ϴ�"Lock Pages in Memory"Ȩ��, ��������:
  // ��ʼ -> ���� -> ������� -> ������ -> ���ذ�ȫ���� -> ���ز��� ->
  // �û�Ȩ��ָ�� -> �ڴ�������ҳ -> ���� -> ����û�����, ����....
end.
