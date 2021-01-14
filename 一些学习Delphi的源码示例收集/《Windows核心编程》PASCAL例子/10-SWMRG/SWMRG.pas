unit SWMRG;

interface

uses Windows;

type
  TSWMRG = class(TObject) // ��Դ(���/��д)������
  public
    constructor Create();
    destructor Destroy(); override;
    procedure WaitToRead();  // �ȴ�(��������)��Դ��Ȩ��
    procedure WaitToWrite(); // �ȴ�(��������)��ԴдȨ��
    procedure Done();        // ����(��������)��Դ�ķ���
  private
    m_cs: TRTLCriticalSection; // ���ڻ�������������Ա
    m_hsemReaders: THandle; // ��Դ��Ȩ�޵ȴ��ź���
    m_hsemWriters: THandle; // ��ԴдȨ�޵ȴ��ź���
    m_nWaitingReaders: Integer; // �ȴ���Ȩ���̼߳���ֵ
    m_nWaitingWriters: Integer; // �ȴ�дȨ���̼߳���ֵ
    m_nActive: Integer; // ״̬(0: ����; >0: ���ڶ�ȡ���߳�����; -1: 1���߳�����д��)
  end;

implementation

  // ���캯��
constructor TSWMRG.Create();
begin
  m_nWaitingReaders := 0;
  m_nWaitingWriters := 0;
  m_nActive := 0;

  m_hsemReaders := CreateSemaphore(nil, 0, MAXLONG, nil);
  m_hsemWriters := CreateSemaphore(nil, 0, MAXLONG, nil);

  InitializeCriticalSection(m_cs);
end;

  // ��������
destructor TSWMRG.Destroy();
begin
{$IFDEF DEBUG}
   if (m_nActive <> 0) then DebugBreak();
{$ENDIF}

  m_nWaitingReaders := 0;
  m_nWaitingWriters := 0;
  m_nActive := 0;

  CloseHandle(m_hsemReaders);
  CloseHandle(m_hsemWriters);

  DeleteCriticalSection(m_cs);
end;

  // �ȴ�(��������Դ)��Ȩ��
procedure TSWMRG.WaitToRead();
var
  fResourceWritePending: BOOL;
begin
  // �ȴ����Ա��������Ȩ
  EnterCriticalSection(m_cs);

  // ���߳�(�ȴ�д/����д)
  fResourceWritePending := (m_nWaitingWriters <> 0) or (m_nActive < 0);

  // ����(�ȴ�/����)������
  if (fResourceWritePending) then Inc(m_nWaitingReaders) else Inc(m_nActive);

  // �ͷ����Ա��������Ȩ
  LeaveCriticalSection(m_cs);

  // �ȴ�(��������Դ)��Ȩ��
  if (fResourceWritePending) then WaitForSingleObject(m_hsemReaders, INFINITE);
end;

  // �ȴ�(��������Դ)дȨ��
procedure TSWMRG.WaitToWrite();
var
  fResourceOwned: BOOL;
begin
  // �ȴ����Ա��������Ȩ
  EnterCriticalSection(m_cs);

  // ���߳����ڷ���(��Դ)
  fResourceOwned := (m_nActive <> 0);

  // �޸�(�ȴ�/����)д����
  if (fResourceOwned) then Inc(m_nWaitingWriters) else m_nActive := -1;

  // �ͷ����Ա��������Ȩ
  LeaveCriticalSection(m_cs);

  // �ȴ�(��������Դ)дȨ��
  if (fResourceOwned) then WaitForSingleObject(m_hsemWriters, INFINITE);
end;

  // ����(��������Դ)�ķ���
procedure TSWMRG.Done();
var
  hsem: THandle; // �ź���������
  lCount: LongInt; // �ź�������ֵ������
begin
  hsem := 0; lCount := 1;

  // �ȴ����Ա��������Ȩ
  EnterCriticalSection(m_cs);

  // �޸�(��Դ)״̬����ֵ
  if (m_nActive > 0) then Dec(m_nActive) else Inc(m_nActive);

  // �����߳�������(��Դ)
  if (m_nActive = 0) then
  begin
    // ���ȿ�����Դд����
    if (m_nWaitingWriters > 0) then
    begin
      m_nActive := -1;
      Dec(m_nWaitingWriters);
      hsem := m_hsemWriters;

      // �ͷ�һ���ȴ�д���߳�
    end else
    begin
      // Ȼ��ſ�����Դ������
      if (m_nWaitingReaders > 0) then
      begin
        m_nActive := m_nWaitingReaders;
        m_nWaitingReaders := 0;
        hsem := m_hsemReaders;
        lCount := m_nActive;

        // �ͷ����еȴ������߳�
      end else
      begin
        // There are no threads waiting at all; no semaphore gets released
      end;
    end;
  end;

  // �ͷ����Ա��������Ȩ
  LeaveCriticalSection(m_cs);

  // �ͷ����ɵȴ������߳�
  if (hsem <> 0) then ReleaseSemaphore(hsem, lCount, nil);
end;

end.
