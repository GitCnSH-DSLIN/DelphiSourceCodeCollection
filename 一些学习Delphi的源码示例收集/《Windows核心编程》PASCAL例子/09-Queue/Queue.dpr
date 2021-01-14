program Queue;

{$R 'Queue.res' 'Queue.rc'}

uses
  Windows, Messages;

const
  ERROR_DATABASE_FULL = 4314; // ���ݿ�����(�������)
  IDD_QUEUE =   1; // ģ����ԴID
  IDI_QUEUE = 102; // ͼ����ԴID
  IDC_CLIENTS = 1000; // �ؼ�ID~
  IDC_SERVERS = 1001;

type
  PElement = ^TElement; // ���г�Ա
  TElement = record
    m_nThreadNum, m_nRequestNum: Integer;
  end;

  TQueue = class(TObject) // ������
  public
    constructor Create(nMaxElements: Integer);
    destructor Destroy(); override;
    function Append(PtElement: PElement; dwTimeout: DWORD): BOOL;
    function Remove(PtElement: PElement; dwTimeout: DWORD): BOOL;
  private
    m_pElements: PElement;   // �����ַ
    m_nMaxElements: Integer; // ���鳤��
    m_hmtxQ, m_hsemNumElements: THandle; // Mutex(���з���Ȩ), semaphore(���г���)
  end;

  // ���캯��
constructor TQueue.Create(nMaxElements: Integer);
begin
  m_pElements := HeapAlloc(GetProcessHeap(), 0, SizeOf(TElement) * nMaxElements);
  m_nMaxElements := nMaxElements;
  m_hmtxQ := CreateMutex(nil, FALSE, nil);
  m_hsemNumElements := CreateSemaphore(nil, 0, nMaxElements, nil);
end;

  // ��������
destructor TQueue.Destroy();
begin
  CloseHandle(m_hsemNumElements);
  CloseHandle(m_hmtxQ);
  HeapFree(GetProcessHeap(), 0, m_pElements);
end;

  // ��Ӳ���
function TQueue.Append(PtElement: PElement; dwTimeout: DWORD): BOOL;
var
  dw, lPrevCount: DWORD;
begin
  Result := FALSE;

  // �ȴ����з���Ȩ
  dw := WaitForSingleObject(m_hmtxQ, dwTimeout);

  // �ȴ��ɹ�
  if (dw = WAIT_OBJECT_0) then
  begin
    // ��������
    Result := ReleaseSemaphore(m_hsemNumElements, 1, @lPrevCount);

    // ��������
    if (Result) then
      PElement(DWORD(m_pElements) + SizeOf(TElement) * lPrevCount)^ := PtElement^
    else
      SetLastError(ERROR_DATABASE_FULL);

    // �ͷŶ��з���Ȩ
    ReleaseMutex(m_hmtxQ);
  end else
  begin
  // �ȴ���ʱ
    SetLastError(ERROR_TIMEOUT);
  end;
end;

  // ���Ӳ���
function TQueue.Remove(PtElement: PElement; dwTimeout: DWORD): BOOL;
begin
  // 1.�ȴ����з���Ȩ(m_hmtxQ)
  // 2.���зǿ�(m_hsemNumElements)
  Result := (WaitForMultipleObjects(2, @m_hmtxQ, TRUE, dwTimeout) = WAIT_OBJECT_0);

  // �ȴ��ɹ�
  if (Result) then
  begin
    // ��ȡ��ͷ
    PtElement^ := m_pElements^;

    // ���Ƕ�ͷ
    MoveMemory(m_pElements, PElement(Integer(m_pElements) + SizeOf(TElement)), SizeOf(TElement) * (m_nMaxElements - 1));

    // �ͷŶ��з���Ȩ
    ReleaseMutex(m_hmtxQ);
  end else
  begin
  // �ȴ���ʱ
    SetLastError(ERROR_TIMEOUT);
  end;
end;

  // ȫ�ֱ��� :-)
var
  g_q: TQueue;                // ���ж���
  g_fShutdown: BOOL = FALSE;  // �����ź�
  g_hWnd: HWND;               // ���Ի���
  g_hThreads: array[0..MAXIMUM_WAIT_OBJECTS-1] of THandle; // �߳̾��
  g_nNumThreads: Integer = 0; // �߳�����

  // ��װAPI, ���ڵ���
function wvsprintf(Output: PChar; Format: PChar; Arg_List: array of Integer): Integer;
begin
  Result := Windows.wvsprintf(Output, Format, @Arg_List[Low(Arg_List)]);
end;

  // �ͻ��߳�, �������
function ClientThread(nThreadNum: Integer): Integer;
var
  hWndLB: HWND;
  e: TElement;
  nRequestNum: Integer;
  sz: array[0..1024] of Char;
begin
  hWndLB := GetDlgItem(g_hWnd, IDC_CLIENTS);
  nRequestNum := 1;

  while (g_fShutdown = FALSE) do
  begin
    // �����Ա
    e.m_nThreadNum := nThreadNum;
    e.m_nRequestNum := nRequestNum;

    // �������
    if g_q.Append(@e, 200) then
    begin
      wvsprintf(sz, 'Sending %d:%d', [nThreadNum, nRequestNum]);
    end else
    begin
      if (GetLastError() = ERROR_TIMEOUT) then
        wvsprintf(sz, 'Sending %d:%d (timeout)', [nThreadNum, nRequestNum])
      else
        wvsprintf(sz, 'Sending %d:%d (full)', [nThreadNum, nRequestNum]);
    end;

    // ��ʾ��Ϣ
    SendMessage(hWndLB, LB_SETCURSEL, SendMessage(hWndLB, LB_ADDSTRING, 0, Integer(@sz[0])), 0);

    Sleep(2500);
    Inc(nRequestNum);
  end;

  Result := 0;
end;

  // �����߳�, ���ϳ���
function ServerThread(nThreadNum: Integer): Integer;
var
  hWndLB: HWND;
  sz: array[0..1024] of Char;
  e: TElement;
begin
  hWndLB := GetDlgItem(g_hWnd, IDC_SERVERS);

  while (g_fShutdown = FALSE) do
  begin
    // ���Գ���
    if g_q.Remove(@e, 5000) then
    begin
      wvsprintf(sz, '%d: Processing %d:%d', [nThreadNum, e.m_nThreadNum, e.m_nRequestNum]);
      Sleep(2000 * e.m_nThreadNum);
    end else
      Windows.wvsprintf(sz, '%d: (timeout)', @nThreadNum);

    // ��ʾ��Ϣ
    SendMessage(hWndLB, LB_SETCURSEL, SendMessage(hWndLB, LB_ADDSTRING, 0, Integer(@sz[0])), 0);
  end;

  Result := 0;
end;

  // �Ի���WM_INITDIALOG����
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
var
  dwThreadID: DWORD;
  x: Integer;
begin
  // ���ô���ͼ��
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_QUEUE)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_QUEUE)));

  // ���Ի�����
  g_hWnd := hWnd;

  // �����ͻ��߳�
  for x := 0 to 3 do
  begin
    g_hThreads[g_nNumThreads] := BeginThread(nil, 0, @ClientThread, Pointer(x), 0, dwThreadID);
    Inc(g_nNumThreads);
  end;

  // ���������߳�
  for x := 0 to 1 do
  begin
    g_hThreads[g_nNumThreads] := BeginThread(nil, 0, @ServerThread, Pointer(x), 0, dwThreadID);
    Inc(g_nNumThreads);
  end;

  // ����Ĭ�Ͻ���
  Result := TRUE;
end;

  // �Ի���WM_COMMAND��Ϣ����
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
begin
  if (id = IDCANCEL) then EndDialog(hWnd, id);
end;

  // �Ի�����Ϣ����ص�
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  Result := FALSE;

  case (uMsg) of
    WM_INITDIALOG:
      Result := SetWindowLong(hWnd, DWL_MSGRESULT, Longint(Dlg_OnInitDialog(hWnd, wParam, lParam))) <> 0;

    WM_COMMAND:
      Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));
  end;
end;

  // ����'���߳�'��ڵ�
begin
  // �������ж���
  g_q := TQueue.Create(10);

  // ������ʾ����
  DialogBox(HInstance, MakeIntResource(IDD_QUEUE), 0, @Dlg_Proc);

  // ֪ͨ�߳̽���
  InterlockedExchange(Integer(g_fShutdown), 1);

  // �ȴ��߳̽���
  WaitForMultipleObjects(g_nNumThreads, @g_hThreads[0], TRUE, INFINITE);

  // �ر��߳̾��
  while (g_nNumThreads > 0) do
  begin
    Dec(g_nNumThreads);
    CloseHandle(g_hThreads[g_nNumThreads]);
  end;

  // �ͷŶ��ж���
  g_q.Free;
end.
