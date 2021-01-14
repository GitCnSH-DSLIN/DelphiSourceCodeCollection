unit SparseStream;

interface

uses Windows;

const
  FILE_DEVICE_FILE_SYSTEM = $00000009;
  FILE_SUPPORTS_SPARSE_FILES = $00000040;
  FILE_ATTRIBUTE_SPARSE_FILE = $00000200;
  FILE_READ_DATA  = $0001;
  FILE_WRITE_DATA = $0002;
  METHOD_BUFFERED = 0;
  METHOD_NEITHER  = 3;
  FSCTL_SET_SPARSE = (FILE_DEVICE_FILE_SYSTEM shl 16) or (FILE_WRITE_DATA shl 14) or (49 shl 2) or (METHOD_BUFFERED);
  FSCTL_SET_ZERO_DATA = (FILE_DEVICE_FILE_SYSTEM shl 16) or (FILE_WRITE_DATA shl 14) or (50 shl 2) or (METHOD_BUFFERED);
  FSCTL_QUERY_ALLOCATED_RANGES = (FILE_DEVICE_FILE_SYSTEM shl 16) or (FILE_READ_DATA shl 14) or (51 shl 2) or (METHOD_NEITHER);
  HEAP_ZERO_MEMORY = $00000008;
  
type
  PFileAllocatedRangeBuffer = ^TFileAllocatedRangeBuffer;
  TFileAllocatedRangeBuffer = record
    FileOffset, Length: LARGE_INTEGER;
  end;

  TFileAllocatedRangeBufferArray = array[0..99] of TFileAllocatedRangeBuffer;
  PFileAllocatedRangeBufferArray = ^TFileAllocatedRangeBufferArray;

  PFileZeroDataInformation = ^TFileZeroDataInformation;
  TFileZeroDataInformation = record
    FileOffset, BeyondFinalZero: LARGE_INTEGER;
  end;

  TSparseStream = class(TObject)
  public
    function DoesFileSystemSupportSparseStreams(pszVolume: PChar): BOOL;
    function DoesFileContainAnySparseStreams(pszPathname: PChar): BOOL;

    constructor Create(hStream: THandle = INVALID_HANDLE_VALUE);
    procedure Initialize(hStream: THandle = INVALID_HANDLE_VALUE);
    function Handle(): THandle;

    function IsStreamSparse(): BOOL;
    function MakeSparse(): BOOL;
    function DecommitPortionOfStream(qwOffsetStart, qwOffsetEnd: Int64): BOOL;
    
    function QueryAllocatedRanges(pdwNumEntries: PDWORD): PFileAllocatedRangeBuffer;
    function FreeAllocatedRanges(pfarb: PFileAllocatedRangeBuffer): BOOL;
    
  private
    m_hStream: THandle;
    function AreFlagsSet(fdwFlagBits, fFlagsToCheck: DWORD): BOOL;    
  end;

implementation

  // �߼����Ƿ�֧��ϡ���ļ�
function TSparseStream.DoesFileSystemSupportSparseStreams(pszVolume: PChar): BOOL;
var
  dwFileSystemFlags: DWORD;
begin
  dwFileSystemFlags := 0;
  Result := GetVolumeInformation(pszVolume, nil, 0, nil, PDWORD(nil)^, dwFileSystemFlags, nil, 0);
  if Result then Result := AreFlagsSet(dwFileSystemFlags, FILE_SUPPORTS_SPARSE_FILES);
end;

  // ָ���ļ��Ƿ�Ϊϡ���ļ�
function TSparseStream.DoesFileContainAnySparseStreams(pszPathname: PChar): BOOL;
var
  dw: DWORD;
begin
  dw := GetFileAttributes(pszPathname);
  Result := (dw <> $FFFFFFF) and AreFlagsSet(dw, FILE_ATTRIBUTE_SPARSE_FILE);
end;

constructor TSparseStream.Create(hStream: THandle = INVALID_HANDLE_VALUE);
begin
  Initialize(hStream);
end;

procedure TSparseStream.Initialize(hStream: THandle = INVALID_HANDLE_VALUE);
begin
  m_hStream := hStream;
end;

  // �����ļ����m_hStream
function TSparseStream.Handle(): THandle;
begin
  Result := m_hStream;
end;

  // m_hStream�Ƿ�ϡ���ļ�
function TSparseStream.IsStreamSparse(): BOOL;
var
  bhfi: TByHandleFileInformation;
begin
  GetFileInformationByHandle(m_hStream, bhfi);
  Result := AreFlagsSet(bhfi.dwFileAttributes, FILE_ATTRIBUTE_SPARSE_FILE);
end;

  // m_hStream���ϡ���ļ�
function TSparseStream.MakeSparse(): BOOL;
var
  dw: DWORD;
begin
  Result := DeviceIoControl(m_hStream, FSCTL_SET_SPARSE, nil, 0, nil, 0, dw, nil);
end;

  // m_hStreamָ���������
function TSparseStream.DecommitPortionOfStream(qwOffsetStart, qwOffsetEnd: Int64): BOOL;
var
  dw: DWORD;
  fzdi: TFileZeroDataInformation;
begin
  fzdi.FileOffset.QuadPart := qwOffsetStart;
  fzdi.BeyondFinalZero.QuadPart := qwOffsetEnd + 1;
  
  Result := DeviceIoControl(m_hStream, FSCTL_SET_ZERO_DATA, @fzdi,
    SizeOf(TFileZeroDataInformation), nil, 0, dw, nil);
end;

  // ��ѯm_hStream����ռ�
function TSparseStream.QueryAllocatedRanges(pdwNumEntries: PDWORD): PFileAllocatedRangeBuffer;
var
  farb: TFileAllocatedRangeBuffer;
  cb: DWORD;
begin
  farb.FileOffset.QuadPart := 0;
  farb.Length.LowPart := GetFileSize(m_hStream, @farb.Length.HighPart);

  cb := 100 * SizeOf(TFileAllocatedRangeBuffer);
  Result := HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY, cb);

  DeviceIoControl(m_hStream, FSCTL_QUERY_ALLOCATED_RANGES, @farb,
    SizeOf(TFileAllocatedRangeBuffer), Result, cb, cb, nil);

  pdwNumEntries^ := cb div SizeOf(TFileAllocatedRangeBuffer);
end;

  // �ͷŶ��ϵ�(����)�ڴ�
function TSparseStream.FreeAllocatedRanges(pfarb: PFileAllocatedRangeBuffer): BOOL;
begin
  Result := HeapFree(GetProcessHeap(), 0, pfarb);
end;

  // ��־λ�Ƿ����Ϊ'��'
function TSparseStream.AreFlagsSet(fdwFlagBits, fFlagsToCheck: DWORD): BOOL;
begin
  Result := (fdwFlagBits and fFlagsToCheck) = fFlagsToCheck;
end;

end.
