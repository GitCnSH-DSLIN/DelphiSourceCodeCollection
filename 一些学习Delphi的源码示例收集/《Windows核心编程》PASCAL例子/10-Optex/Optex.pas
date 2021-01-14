unit Optex;

interface

uses Windows;

type
  // �����ڴ�ṹ
  PSharedInfo = ^TSharedInfo;
  TSharedInfo = record
    m_dwSpinCount: DWORD;  // (ѭ����)ѭ������
    m_lLockCount: Integer; // ��ͼ����Ĵ���
    m_dwThreadId: DWORD;   // ӵ����(�߳�)ID
    m_lRecurseCount: Integer; // ��ӵ�еĴ���
  end;

  // ��ʵ�ֻ�����
  TOptex = class(TObject)
  public
    constructor Create(dwSpinCount: DWORD = 4000); overload;
    constructor Create(pszName: PAnsiChar; dwSpinCount: DWORD = 4000); overload;
    constructor Create(pszName: PWideChar; dwSpinCount: DWORD = 4000); overload;
    destructor Destroy(); override;
    procedure SetSpinCount(dwSpinCount: DWORD); // ѭ������
    procedure Enter(); // �����ٽ���
    function TryEnter(): BOOL; // ���Խ���
    procedure Leave(); // �뿪�ٽ���
    function IsSingleProcessOptex(): BOOL; // �����̶���
  private
    m_hevt: THandle;    // �¼�������
    m_hfm: THandle;     // �����ڴ���
    m_psi: PSharedInfo; // �����ڴ��ַ
    procedure CommonConstructor(dwSpinCount: DWORD; fUnicode: BOOL; pszName: Pointer); // ��ʼ��
    function ConstructObjectName(pszResult, pszPrefix: PChar; fUnicode: BOOL; pszName: Pointer): PChar;
  end;

implementation

{$DEFINE DEBUG}

  // 0=�ദ����, 1=��������, -1=δ����
var sm_fUniprocessorHost: Integer = -1;

  // ���캯��
constructor TOptex.Create(dwSpinCount: DWORD = 4000);
begin
  CommonConstructor(dwSpinCount, FALSE, nil);
end;

constructor TOptex.Create(pszName: PAnsiChar; dwSpinCount: DWORD = 4000);
begin
  CommonConstructor(dwSpinCount, FALSE, pszName);
end;

constructor TOptex.Create(pszName: PWideChar; dwSpinCount: DWORD = 4000);
begin
  CommonConstructor(dwSpinCount, TRUE, pszName);
end;

  // �����̶���
function TOptex.IsSingleProcessOptex(): BOOL;
begin
  Result := (m_hfm = 0);
end;

  // �����ַ���(ͬʱҲ������Unicode->Ansiת��)
function TOptex.ConstructObjectName(pszResult, pszPrefix: PChar; fUnicode: BOOL; pszName: Pointer): PChar;
var
  ArgList: array[0..1] of PChar;
begin
  pszResult^ := #0;
  Result := nil;

  if (pszName <> nil) then
  begin
    ArgList[0] := pszPrefix;
    ArgList[1] := pszName;

    if fUnicode then
      wvsprintfA(pszResult, '%s%S', @ArgList[0])
    else
      wvsprintfA(pszResult, '%s%s', @ArgList[0]);

    Result := pszResult;
  end;
end;

  // ��ʼ������
procedure TOptex.CommonConstructor(dwSpinCount: DWORD; fUnicode: BOOL; pszName: Pointer);
var
  sinf: TSystemInfo;
  szResult: array[0..100] of Char;
begin
  // �������׸�TOptex���󱻽���
  // ���鵱ǰ�����Ƿ񵥴�����
  if (sm_fUniprocessorHost = -1) then
  begin
    GetSystemInfo(sinf);
    sm_fUniprocessorHost := Integer(sinf.dwNumberOfProcessors = 1);
  end;

  // ��ʼ����Ա
  m_hevt := 0;
  m_hfm := 0;
  m_psi := nil;

  // �����̶���
  if (pszName = nil) then
  begin
    // �����ֲ��¼�����
    m_hevt := CreateEventA(nil, FALSE, FALSE, nil);

    // ����ֲ��ṹ�ڴ�
    New(m_psi);
    ZeroMemory(m_psi, SizeOf(TSharedInfo));
  end else
  begin
  // ����̶���

    // ����ȫ���¼�����
    ConstructObjectName(szResult, 'Optex_Event_', fUnicode, pszName);
    m_hevt := CreateEventA(nil, FALSE, FALSE, szResult);

    // ����ȫ�ֽṹ�ڴ�
    ConstructObjectName(szResult, 'Optex_MMF_', fUnicode, pszName);
    m_hfm := CreateFileMappingA(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, SizeOf(TSharedInfo), szResult);
    m_psi := MapViewOfFile(m_hfm, FILE_MAP_WRITE, 0, 0, 0);

    // Note: SHAREDINFO's m_lLockCount, m_dwThreadId, and m_lRecurseCount
    // members need to be initialized to 0. Fortunately, a new pagefile
    // MMF sets all of its data to 0 when created. This saves use from
    // some thread synchronization work.
  end;

  // ѭ������
  SetSpinCount(dwSpinCount);
end;

  // ��������
destructor TOptex.Destroy();
begin
{$IFDEF DEBUG}
  // �����̶���,�������߳�ӵ����ʱ,�����ͷ�
  if IsSingleProcessOptex() and (m_psi.m_dwThreadId <> 0) then
  begin
    {DebugBreak();}
  end;

  // ����̶���. �����߳�ӵ����ʱ,�����ͷ�
  if (IsSingleProcessOptex() = FALSE) and (m_psi.m_dwThreadId = GetCurrentThreadId()) then
  begin
    {DebugBreak()};
  end;
{$ENDIF}

  if IsSingleProcessOptex() then
    Dispose(m_psi)
  else begin
    UnmapViewOfFile(m_psi);
    CloseHandle(m_hfm);
  end;
  
  CloseHandle(m_hevt);
end;

  // ����ѭ������
procedure TOptex.SetSpinCount(dwSpinCount: DWORD);
begin
  // �ദ��������
  if (sm_fUniprocessorHost = 0) then
    InterlockedExchange(Integer(m_psi.m_dwSpinCount), Integer(dwSpinCount));
end;

  // �����ٽ���
procedure TOptex.Enter();
var
  dwThreadId: DWORD;
begin
  // ѭ�����ѳɹ�����
  if TryEnter() then Exit;

  dwThreadId := GetCurrentThreadId();

  // 1.���ӽ������
  // 2.֮ǰδ������
  if (InterlockedIncrement(m_psi.m_lLockCount) = 1) then
  begin
    m_psi.m_dwThreadId := dwThreadId;
    m_psi.m_lRecurseCount := 1;
  end else
  begin
    // ӵ�ж�����Ǳ��߳�
    if (m_psi.m_dwThreadId = dwThreadId) then
    begin
      // ����ӵ�м���
      Inc(m_psi.m_lRecurseCount);
    end else
    begin
      // �ȴ������߳��뿪
      WaitForSingleObject(m_hevt, INFINITE);

      // ��ʱ�ſ�ӵ�ж���
      m_psi.m_dwThreadId := dwThreadId;
      m_psi.m_lRecurseCount := 1;
    end;
  end;
end;

  // (ѭ��)���Խ���
function TOptex.TryEnter(): BOOL;
var
  dwThreadId, dwSpinCount: DWORD;
begin
  dwThreadId := GetCurrentThreadId();

  // ѭ������
  dwSpinCount := m_psi.m_dwSpinCount;

  repeat
    // �� m_lLockCount = 0, �� m_lLockCount := 1, �� Result = TRUE
    Result := (InterlockedCompareExchange(Pointer(m_psi.m_lLockCount), Pointer(1), Pointer(0)) = Pointer(0));

    // ����δ��ӵ��(û���߳̽����ٽ���)
    if (Result) then
    begin
      m_psi.m_dwThreadId := dwThreadId;
      m_psi.m_lRecurseCount := 1;
    end else
    begin
      if (m_psi.m_dwThreadId = dwThreadId) then
      begin
        InterlockedIncrement(m_psi.m_lLockCount);
        Inc(m_psi.m_lRecurseCount);
        Result := TRUE;
      end;
    end;

    // $FFFFFFFF = -1 
    Dec(dwSpinCount);
  until (Result) or (dwSpinCount = $FFFFFFFF);
end;

  // �뿪�ٽ���
procedure TOptex.Leave();
begin
{$IFDEF DEBUG}
  // ֻ��ӵ�����߳̿����뿪
  if (GetCurrentThreadId() <> m_psi.m_dwThreadId) then {DebugBreak()};
{$ENDIF}

  // �������ü���
  Dec(m_psi.m_lRecurseCount);
  if (m_psi.m_lRecurseCount > 0) then
  begin
    // ��Ȼӵ�ж���
    InterlockedDecrement(m_psi.m_lLockCount);
  end else
  begin
    // ����ӵ�ж���
    m_psi.m_dwThreadId := 0;

    // 1.���ٽ������
    // 2.���������߳�
    if (InterlockedDecrement(m_psi.m_lLockCount) > 0) then SetEvent(m_hevt);
  end;
end;

end.
