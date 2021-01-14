unit VMArray;

interface

uses Windows;

  // TopLevelExceptionFilter����ֵ����
const
  EXCEPTION_EXECUTE_HANDLER = 1; // �Ѵ����쳣, ���������, (��Ҫ��ʾ����Ի���)
  EXCEPTION_CONTINUE_SEARCH = 0; // δ�����쳣, ��Ĭ�ϴ���, (ͨ����ʾ����Ի���)
  EXCEPTION_CONTINUE_EXECUTION = -1; // ���޸�����, �̰߳�ContextRecord����ִ��

  // ��չ�˵��쳣֡(ϵͳֻʹ��ǰ������)
type
  PExceptionRegistration = ^TExceptionRegistration;
  TExceptionRegistration = record
    PrevStruct: PExceptionRegistration; // ��һ�ڵ�λ��
    ExceptionHandler: Pointer;          // �쳣�ص���ַ
    ExceptionAddress: Pointer;          // except���ַ
  end;

  // (�����ڴ�+�쳣����ʵ�ֵ�)ϡ������
type
  TVMArray = class(TObject)
  private
    m_pNext: TVMArray; // ��һ������
    m_pArray: Pointer; // �����׵�ַ
    m_cbReserve: DWORD; // ����ߴ�(in bytes)
    m_dwTypeSize: DWORD; // ��Ա�ߴ�(in bytes)

  protected
    function OnAccessViolation(pvAddrTouched: Pointer; fAttemptedRead: BOOL; // �����޸��ڴ���ʴ���,�ɸ���
      var pep: TExceptionPointers; fRetryUntilSuccessful: BOOL): LongInt; virtual;
      
  public
    constructor Create(dwTypeSize, dwReserveElements: DWORD);
    destructor Destroy(); override;

    class procedure RemoveCurrentThreadOtherSEH(); // ����ժ��SetExceptionHandler()���ӵ�SEH�ص�
    function VMPointer(): Pointer; // ���������׵�ַ

    function ExceptionFilter(var pep: TExceptionPointers; // ����except������Ϊ"������"��������,
      fRetryUntilSuccessful: BOOL = FALSE): LongInt;      // ��û��except��,���ɶ����쳣�ص�����
  end;

implementation

type
  PfnTopLevelExceptionFilter = function (var pep: TExceptionPointers): LongInt; stdcall;

var
  sm_pHead: TVMArray = nil; // ��һ��TVMArray�����ַ
  sm_pfnUnhandledExceptionFilterPrev: PfnTopLevelExceptionFilter; // ��ǰ�Ķ����쳣�ص�

  // �����쳣�ص�
function TopLevelExceptionFilter(var pep: TExceptionPointers): LongInt; stdcall;
var
  p: TVMArray;
begin
  Result := EXCEPTION_CONTINUE_SEARCH;

  // ����ֻ�޸��ڴ���ʴ���
  if (pep.ExceptionRecord.ExceptionCode = EXCEPTION_ACCESS_VIOLATION) then
  begin
    // ����TVMArray��������, һһ����
    p := sm_pHead;
    while (p <> nil) do
    begin
      // ѯ�ʵ�ǰ�ڵ�����Ƿ��޸�����
      Result := p.ExceptionFilter(pep, TRUE);

      // ��������޸�������, ֹͣѭ��
      if (Result <> EXCEPTION_CONTINUE_SEARCH) then Break;

      // �������ϵ���һ��TVMArray����
      p := p.m_pNext;

      // ע: ���������������ͻ��˳�
    end;
  end;

  // ������ǰ�Ķ����쳣�ص�
  if (Result = EXCEPTION_CONTINUE_SEARCH) then
    Result := sm_pfnUnhandledExceptionFilterPrev(pep);
end;

  // �����޸��ڴ���ʴ���(��ExceptionFilter����)
function TVMArray.OnAccessViolation(pvAddrTouched: Pointer; fAttemptedRead: BOOL;
  var pep: TExceptionPointers; fRetryUntilSuccessful: BOOL): LongInt;
var
  fCommittedStorage: BOOL;
begin
  repeat
    // Ϊ�����ַ�ύ�����ڴ�
    fCommittedStorage := (VirtualAlloc(pvAddrTouched, m_dwTypeSize, MEM_COMMIT, PAGE_READWRITE) <> nil);

    // �����ڴ�ʧ��, ֪ͨ�û�
    if (not fCommittedStorage) and (fRetryUntilSuccessful) then
    begin
      MessageBox(0, 'Please close some other applications and Press OK.',
        'Insufficient Memory Available', MB_ICONWARNING or MB_OK);
    end;
  until (fCommittedStorage) or (not fRetryUntilSuccessful);

  // 1.����ɹ�, �ӳ���ָ�����ִ��
  // 2.����ʧ��, ��ϵͳ�����عرճ���(or ����except��ִ��)
  if fCommittedStorage then
    Result := EXCEPTION_CONTINUE_EXECUTION
  else
    Result := EXCEPTION_EXECUTE_HANDLER;
end;

  // TVMArray�����ʼ��
constructor TVMArray.Create(dwTypeSize, dwReserveElements: DWORD);
begin
  // ��һ���ཨ��ʱ��װ�����쳣�ص�
  if (sm_pHead = nil) then
    sm_pfnUnhandledExceptionFilterPrev := SetUnhandledExceptionFilter(@TopLevelExceptionFilter);

  // ���Լ��ӵ�TVMArray���������ͷ
  m_pNext := sm_pHead;
  sm_pHead := Self;

  // ��ҪΪ���鱣���������ڴ�ĳ���
  m_dwTypeSize := dwTypeSize;
  m_cbReserve := m_dwTypeSize * dwReserveElements;

  // Ϊ���鱣�������ڴ�ռ�(���ύ)
  m_pArray := VirtualAlloc(nil, m_cbReserve, MEM_RESERVE or MEM_TOP_DOWN, PAGE_READWRITE);

  // chASSERT(m_pArray <> NULL);
end;

  // TVMArray���������
destructor TVMArray.Destroy();
var
  p: TVMArray;
begin
  // �ͷ������Ӧ�������ڴ�ռ�
  if (m_pArray <> nil) then VirtualFree(m_pArray, 0, MEM_RELEASE);

  // ��TVMArray��������ժ���Լ�
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
    end;
  end; // END: else
end;

  // ���������׵�ַ
function TVMArray.VMPointer(): Pointer;
begin
  Result := m_pArray;
end;

  // ժ����ǰ�߳�����SEH�ڵ�, ����!
class procedure TVMArray.RemoveCurrentThreadOtherSEH();
asm
  // p := TEB.ExceptionList;
  MOV EDX, FS:[0]

  // if (p = $FFFFFFFF) then Exit;
  CMP EDX, -1
  JZ  @@QUIT

  // while (p.PrevStruct <> $FFFFFFFF) do p := p.PrevStruct;
@@LOOP:
  MOV EAX, EDX
  MOV EDX, [EAX].TExceptionRegistration.PrevStruct
  CMP EDX, -1
  JNZ @@LOOP

  // TEB.ExceptionList := p;
  MOV FS:[0], EAX

@@QUIT:
end;

  // �쳣���˺���(��TopLevelExceptionFilter��except�����)
function TVMArray.ExceptionFilter(var pep: TExceptionPointers; fRetryUntilSuccessful: BOOL = FALSE): LongInt;
var
  pvAddrTouched: DWORD;
  fAttemptedRead: BOOL;
begin
  Result := EXCEPTION_CONTINUE_SEARCH;

  // ����ֻ�޸��ڴ���ʴ���
  if (pep.ExceptionRecord.ExceptionCode <> EXCEPTION_ACCESS_VIOLATION) then Exit;

  // ������д�쳣���ڴ��ַ
  pvAddrTouched := pep.ExceptionRecord.ExceptionInformation[1];

  // �����쳣�Ķ���(��orд)
  fAttemptedRead := (pep.ExceptionRecord.ExceptionInformation[0] = 0);

  // ����õ�ַ�����鷶Χ��
  if (DWORD(m_pArray) <= pvAddrTouched) and (DWORD(pvAddrTouched) < (DWORD(m_pArray) + m_cbReserve)) then
    Result := OnAccessViolation(Pointer(pvAddrTouched), fAttemptedRead, pep, fRetryUntilSuccessful);
end;

end.
