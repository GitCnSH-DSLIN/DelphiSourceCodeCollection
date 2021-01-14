program MemReset;

{$R 'MemReset.res' 'MemReset.rc'}

uses Windows;

const
  szAppName = 'MEM_RESET tester';
  szTestData = 'Some text data';

var
  vi: TOSVersionInfo;
  pszData: PChar;
  mbi: TMemoryBasicInformation;
  mst: TMemoryStatus;
  pvDummy: Pointer;

begin
  // Win 9x ��֧�� MEM_RESET
  vi.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(vi);
  if (vi.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS) then
  begin
    MessageBox(0, 'This application requires features not present in Windows 9x.', szAppName, MB_OK);
    Exit;
  end;

  // ����һҳ�ڴ沢д���ַ���
  pszData := VirtualAlloc(nil, 1024, MEM_RESERVE or MEM_COMMIT, PAGE_READWRITE);
  lstrcpy(pszData, szTestData);

  // ѡ�����������洢������
  if (MessageBox(0, 'Do you want to access this data later?', szAppName, MB_YESNO) = IDNO) then
  begin
    VirtualQuery(pszData, mbi, SizeOf(mbi));
    VirtualAlloc(pszData, mbi.RegionSize, MEM_RESET, PAGE_READWRITE);
  end;

  // �ύ�� RAM ͬ������ڴ�
  GlobalMemoryStatus(mst);
  pvDummy := VirtualAlloc(nil, mst.dwTotalPhys, MEM_RESERVE or MEM_COMMIT, PAGE_READWRITE);
  if (pvDummy = nil) then
  begin
    MessageBox(0, 'Allocate the memory failure.', szAppName, MB_OK);
    Exit;
  end;

  // ������������ RAM ��ҳ��
  ZeroMemory(pvDummy, mst.dwTotalPhys);

  // �鿴����������һҳ�ڴ�
  if (lstrcmp(pszData, szTestData) = 0) then
    MessageBox(0, 'Modified data page was saved.', szAppName, MB_OK)
  else
    MessageBox(0, 'Modified data page was NOT saved.', szAppName, MB_OK);
end.
