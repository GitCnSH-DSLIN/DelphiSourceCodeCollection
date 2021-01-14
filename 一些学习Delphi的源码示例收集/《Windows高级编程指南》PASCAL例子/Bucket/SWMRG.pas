                
// Module name: SWMRG.H & SWMRG.C ->> SWMRG.pas
// Notices: Copyright (c) 1995-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

unit SWMRG;

interface

uses Windows;

  // ����ͬ������
type
  SingleWriterMultiReaderGuard = record
    hMutexNoWriter: THandle;  // �Ƿ����߳�д, �������
    hEventNoReaders: THandle; // �Ƿ����̶߳�, �¼�����(�ֶ�����)
    hSemNumReaders: THandle;  // �����̼߳���, �ź�������
  end;
  TSWMRG = SingleWriterMultiReaderGuard;
  PSWMRG = ^TSWMRG;

function SWMRGInitialize(var pSWMRG: TSWMRG; const lpszName: PChar): BOOL;
procedure SWMRGDelete(var pSWMRG: TSWMRG);

function SWMRGWaitToWrite(var pSWMRG: TSWMRG; dwTimeout: DWORD): DWORD;
procedure SWMRGDoneWriting(var pSWMRG: TSWMRG);

function SWMRGWaitToRead(var pSWMRG: TSWMRG; dwTimeout: DWORD): DWORD;
procedure SWMRGDoneReading(var pSWMRG: TSWMRG);

implementation

uses CmnHdr;

  // �����ַ���
function ConstructObjName(const lpszPrefix, lpszSuffix, lpszFullName: PChar; cbFullName: Integer; fOk: PBOOL): PChar;
begin
  Result := nil;
  fOk^ := TRUE;
  if (lpszSuffix = nil) then Exit;

  if (lstrlen(lpszPrefix) + lstrlen(lpszSuffix) >= cbFullName) then
  begin
    fOk^ := FALSE;
    Exit;
  end;

  lstrcpy(lpszFullName, lpszPrefix);
  lstrcat(lpszFullName, lpszSuffix);
  Result := lpszFullName;
end;

  // ��������
function SWMRGInitialize(var pSWMRG: TSWMRG; const lpszName: PChar): BOOL;
var
  szFullObjName: array[0..100] of Char;
  lpszObjName: PChar;
  fOk: BOOL;
begin
  pSWMRG.hMutexNoWriter := 0;
  pSWMRG.hEventNoReaders := 0;
  pSWMRG.hSemNumReaders := 0;

  lpszObjName := ConstructObjName('SWMRGMutexNoWriter', lpszName, szFullObjName, chDIMOF(szFullObjName), @fOk);
  if (fOk) then  pSWMRG.hMutexNoWriter := CreateMutex(nil, FALSE, lpszObjName);

  lpszObjName := ConstructObjName('SWMRGEventNoReaders', lpszName, szFullObjName, chDIMOF(szFullObjName), @fOk);
  if (fOk) then  pSWMRG.hEventNoReaders := CreateEvent(nil, TRUE, TRUE, lpszObjName);

  lpszObjName := ConstructObjName('SWMRGSemNumReaders', lpszName,  szFullObjName, chDIMOF(szFullObjName), @fOk);
  if (fOk) then pSWMRG.hSemNumReaders := CreateSemaphore(nil, 0, $7FFFFFFF, lpszObjName);

  Result := (pSWMRG.hMutexNoWriter <> 0) and (pSWMRG.hEventNoReaders <> 0) and (pSWMRG.hSemNumReaders <> 0);
  if (not Result) then SWMRGDelete(pSWMRG);
end;

  // ɾ������
procedure SWMRGDelete(var pSWMRG: TSWMRG);
begin
  if (pSWMRG.hMutexNoWriter <> 0) then CloseHandle(pSWMRG.hMutexNoWriter);
  if (pSWMRG.hEventNoReaders <> 0) then CloseHandle(pSWMRG.hEventNoReaders);
  if (pSWMRG.hSemNumReaders <> 0) then  CloseHandle(pSWMRG.hSemNumReaders);
end;

  // �ȴ�д��
function SWMRGWaitToWrite(var pSWMRG: TSWMRG; dwTimeout: DWORD): DWORD;
var
  aHandles: array[0..1] of THandle;
begin
  aHandles[0] := pSWMRG.hMutexNoWriter;  // �Ƿ����߳�д
  aHandles[1] := pSWMRG.hEventNoReaders; // �Ƿ����̶߳�
  Result := WaitForMultipleObjects(2, @aHandles, TRUE, dwTimeout);
end;

  // д�����
procedure SWMRGDoneWriting(var pSWMRG: TSWMRG);
begin
  ReleaseMutex(pSWMRG.hMutexNoWriter); // û���߳�д
end;

  // �ȴ���ȡ
function SWMRGWaitToRead(var pSWMRG: TSWMRG; dwTimeout: DWORD): DWORD;
var
  lPreviousCount: Longint;
begin
  // û���߳�д
  Result := WaitForSingleObject(pSWMRG.hMutexNoWriter, dwTimeout);

  // �ǳ�ʱ����
  if (Result <> WAIT_TIMEOUT) then
  begin
    // ���߼�������
    ReleaseSemaphore(pSWMRG.hSemNumReaders, 1, @lPreviousCount);

    // ��ʼ���̶߳�
    if (lPreviousCount = 0) then ResetEvent(pSWMRG.hEventNoReaders);

    // ��û���߳�д
    ReleaseMutex(pSWMRG.hMutexNoWriter);
  end;
end;

  // ��ȡ���
procedure SWMRGDoneReading(var pSWMRG: TSWMRG);
var
  aHandles: array[0..1] of THandle;
  lNumReaders: Longint;
begin
  aHandles[0] := pSWMRG.hMutexNoWriter; // ��ʱ��ֹ��д
  aHandles[1] := pSWMRG.hSemNumReaders; // ���ٶ��߼���
  WaitForMultipleObjects(2, @aHandles, TRUE, INFINITE);

  // ȡ�ü���
  ReleaseSemaphore(pSWMRG.hSemNumReaders, 1, @lNumReaders);
  WaitForSingleObject(pSWMRG.hSemNumReaders, INFINITE);

  // ���̶߳�
  if (lNumReaders = 0) then SetEvent(pSWMRG.hEventNoReaders);

  // ���߳�д
  ReleaseMutex(pSWMRG.hMutexNoWriter);
end;

end.
