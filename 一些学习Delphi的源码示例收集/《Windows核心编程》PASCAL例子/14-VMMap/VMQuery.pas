unit VMQuery;

interface

uses Windows;

type
  TVMQuery = record
    // 1. Region information
    pvRgnBaseAddress: Pointer;
    dwRgnProtection: DWORD; // PAGE_*
    RgnSize: DWORD;
    dwRgnStorage: DWORD;    // MEM_*: Free, Image, Mapped, Private
    dwRgnBlocks: DWORD;
    dwRgnGuardBlks: DWORD;  // If > 0, region contains thread stack
    fRgnIsAStack: BOOL;     // TRUE if region contains thread stack

    // 2. Block information
    pvBlkBaseAddress: Pointer;
    dwBlkProtection: DWORD; // PAGE_*
    BlkSize: DWORD;
    dwBlkStorage: DWORD;    // MEM_*: Free, Reserve, Image, Mapped, Private
  end;

function VM_Query(hProcess: THandle; pvAddress: Pointer; var pVMQ: TVMQuery): BOOL;

implementation

type
  TVMQuery_Help = record
    RgnSize: DWORD;
    dwRgnStorage: DWORD;   // MEM_*: Free, Image, Mapped, Private
    dwRgnBlocks: DWORD;
    dwRgnGuardBlks: DWORD; // If > 0, region contains thread stack
    fRgnIsAStack: BOOL;    // TRUE if region contains thread stack
  end;

  // ��������
var gs_dwAllocGran: DWORD = 0;

  // ����һ��"����"�е����п�
function VMQueryHelp(hProcess: THandle; pvAddress: Pointer; var pVMQHelp: TVMQuery_Help): BOOL;
var
  dwProtectBlock: array[0..3] of DWORD;
  mbi: TMemoryBasicInformation;
  pvRgnBaseAddress, pvAddressBlk: Pointer;
begin
  ZeroMemory(@dwProtectBlock, SizeOf(dwProtectBlock));
  ZeroMemory(@pVMQHelp, SizeOf(pVMQHelp));

  // ��ѯ�ڴ���Ϣ
  Result := VirtualQueryEx(hProcess, pvAddress, mbi, SizeOf(mbi)) = SizeOf(mbi);
  if (not Result) then Exit;

  // "����"����ַ
  pvRgnBaseAddress := mbi.AllocationBase;
  
  pvAddressBlk := pvRgnBaseAddress;
  pVMQHelp.dwRgnStorage := mbi.Type_9;

  // ������"����"
  while TRUE do
  begin
    // ��ѯ��ǰ"��"��Ϣ
    Result := VirtualQueryEx(hProcess, pvAddressBlk, mbi, SizeOf(mbi)) = SizeOf(mbi);
    if (not Result) then Break;

    // �ѳ���"����"��Χ
    if (mbi.AllocationBase <> pvRgnBaseAddress) then Break;

    // Windows98�̶߳�ջ����"����"�����4��"��"������������:
    // 1. reserved, 2. no access, 3. read-write, 4. reserved
    // ����, ������һ���������������4"��"�������Ϣ :)
    if (pVMQHelp.dwRgnBlocks < 4) then
    begin
      if (mbi.State = MEM_RESERVE) then
        dwProtectBlock[pVMQHelp.dwRgnBlocks] := 0
      else
        dwProtectBlock[pVMQHelp.dwRgnBlocks] := mbi.Protect;
    end else
    begin
      MoveMemory(@dwProtectBlock[0], @dwProtectBlock[1], SizeOf(dwProtectBlock) - SizeOf(DWORD));
      if (mbi.State = MEM_RESERVE) then
        dwProtectBlock[3] := 0
      else
        dwProtectBlock[3] := mbi.Protect;
    end;

    // ����"��"����
    Inc(pVMQHelp.dwRgnBlocks);

    // "����"�ܳ���
    Inc(pVMQHelp.RgnSize, mbi.RegionSize);

    // ����"��"����
    if ((mbi.Protect and PAGE_GUARD) = PAGE_GUARD) then Inc(pVMQHelp.dwRgnGuardBlks);

    // **
    if (pVMQHelp.dwRgnStorage = MEM_PRIVATE) then pVMQHelp.dwRgnStorage := mbi.Type_9;

    // ������һ"��"
    Inc(PByte(pvAddressBlk), mbi.RegionSize);
  end;

  // ���ڲ²��"����"�Ƿ��ջ�ռ�
  // 1. Windows 9x: ����, ���ٸ���
  // 2. Windows 2k: ������һ"��"����PAGE_GUARD����
  pVMQHelp.fRgnIsAStack :=
    (pVMQHelp.dwRgnGuardBlks > 0) or
    (
      (pVMQHelp.dwRgnBlocks >= 4) and
      (dwProtectBlock[0] = 0)     and
      (dwProtectBlock[1] = PAGE_NOACCESS)  and
      (dwProtectBlock[2] = PAGE_READWRITE) and
      (dwProtectBlock[3] = 0)
    );

  Result := TRUE;
end;

  // ��չ��VirtualQuery()
function VM_Query(hProcess: THandle; pvAddress: Pointer; var pVMQ: TVMQuery): BOOL;
var
  sinf: TSystemInfo;
  mbi: TMemoryBasicInformation;
  VMQHelp: TVMQuery_Help;
begin
  if (gs_dwAllocGran = 0) then
  begin
    GetSystemInfo(sinf);
    gs_dwAllocGran := sinf.dwAllocationGranularity;
  end;
  ZeroMemory(@pVMQ, SizeOf(pVMQ));

  // ��ѯ�ڴ���Ϣ
  Result := VirtualQueryEx(hProcess, pvAddress, mbi, SizeOf(mbi)) = SizeOf(mbi);
  if (not Result) then Exit;

  // ��д"��"��Ϣ
  case (mbi.State) of
    MEM_FREE:       // Free block (not reserved)
      begin
        pVMQ.pvBlkBaseAddress := nil;
        pVMQ.BlkSize := 0;
        pVMQ.dwBlkProtection := 0;
        pVMQ.dwBlkStorage := MEM_FREE;
      end;
    MEM_RESERVE:    // Reserved block without committed storage in it.
      begin
        pVMQ.pvBlkBaseAddress := mbi.BaseAddress;
        pVMQ.BlkSize := mbi.RegionSize;
        pVMQ.dwBlkProtection := mbi.AllocationProtect;
        pVMQ.dwBlkStorage := MEM_RESERVE;
      end;
    MEM_COMMIT:     // Reserved block with committed storage in it.
      begin
        pVMQ.pvBlkBaseAddress := mbi.BaseAddress;
        pVMQ.BlkSize := mbi.RegionSize;
        pVMQ.dwBlkProtection := mbi.Protect;
        pVMQ.dwBlkStorage := mbi.Type_9;
      end;

    else Exit;
  end;

  // ��д"����"��Ϣ
  case (mbi.State) of
    MEM_FREE:       // Free block (not reserved)
      begin
        pVMQ.pvRgnBaseAddress := mbi.BaseAddress;
        pVMQ.dwRgnProtection := mbi.AllocationProtect;
        pVMQ.RgnSize := mbi.RegionSize;
        pVMQ.dwRgnStorage := MEM_FREE;
        pVMQ.dwRgnBlocks := 0;
        pVMQ.dwRgnGuardBlks := 0;
        pVMQ.fRgnIsAStack := FALSE;
      end;
    MEM_RESERVE:    // Reserved block without committed storage in it.
      begin
        pVMQ.pvRgnBaseAddress := mbi.AllocationBase;
        pVMQ.dwRgnProtection := mbi.AllocationProtect;

        VMQueryHelp(hProcess, pvAddress, VMQHelp);
        pVMQ.RgnSize := VMQHelp.RgnSize;
        pVMQ.dwRgnStorage := VMQHelp.dwRgnStorage;
        pVMQ.dwRgnBlocks := VMQHelp.dwRgnBlocks;
        pVMQ.dwRgnGuardBlks := VMQHelp.dwRgnGuardBlks;
        pVMQ.fRgnIsAStack := VMQHelp.fRgnIsAStack;
      end;
    MEM_COMMIT:     // Reserved block with committed storage in it.
      begin
        pVMQ.pvRgnBaseAddress := mbi.AllocationBase;
        pVMQ.dwRgnProtection := mbi.AllocationProtect;

        VMQueryHelp(hProcess, pvAddress, VMQHelp);
        pVMQ.RgnSize := VMQHelp.RgnSize;
        pVMQ.dwRgnStorage := VMQHelp.dwRgnStorage;
        pVMQ.dwRgnBlocks := VMQHelp.dwRgnBlocks;
        pVMQ.dwRgnGuardBlks := VMQHelp.dwRgnGuardBlks;
        pVMQ.fRgnIsAStack := VMQHelp.fRgnIsAStack;
      end;
      
    else Exit;
  end;
end;

end.
