unit WaitForMultExp;

interface

uses Windows;

function WaitForMultipleExpressions(nExpObjects: DWORD;
  phExpObjects: PWOHandleArray; dwMilliseconds: DWORD): DWORD; stdcall;

implementation

type
  // �������ʽ�ṹ
  PExpression = ^TExpression;
  TExpression = record
    m_phExpObjects: PWOHandleArray; // �б�λ��
    m_nExpObjects: DWORD;           // �б���
  end;

  // �������ʽ�߳�
function WFME_ThreadExpression(var Expression: TExpression): Integer;
begin
  Result := WaitForMultipleObjectsEx(
    Expression.m_nExpObjects, Expression.m_phExpObjects, TRUE, INFINITE, TRUE);
end;

  // �յ�APC�ص�����
procedure WFME_ExpressionAPC(dwData: DWORD); stdcall;
begin
  // û��ʵ�ʶ���, ��������ʹWaitForMultipleObjectsEx()����
end;

  // ��չ��WaitForXX
function WaitForMultipleExpressions(nExpObjects: DWORD;
  phExpObjects: PWOHandleArray; dwMilliseconds: DWORD): DWORD; stdcall;
var
  phExpObjectsTemp: PWOHandleArray;
  hsemOnlyOne: THandle; // �������ź����ں˶���
  Expression: array[0..MAXIMUM_WAIT_OBJECTS - 1] of TExpression; // ���ʽ����
  ahThreads: array[0..MAXIMUM_WAIT_OBJECTS - 1] of THandle; // �߳̾������
  dwExpNum, dwNumExps, dwObjBegin, dwObjCur, dwThreadId: DWORD;
begin
  // �����ڴ沢��������б�
  GetMem(phExpObjectsTemp, SizeOf(THandle) * (nExpObjects + 1));
  CopyMemory(phExpObjectsTemp, phExpObjects, SizeOf(THandle) * nExpObjects);
  phExpObjectsTemp[nExpObjects] := 0;

  // ��ֹ����̵߳ȴ��ɹ�, (����ɶ�θı����״̬)
  hsemOnlyOne := CreateSemaphore(nil, 1, 1, nil);

  // ������������������б�
  dwNumExps := 0;
  dwObjBegin := 0;
  dwObjCur := 0;
  Result := 0;
  while (Result <> WAIT_FAILED) and (dwObjCur <= nExpObjects) do
  begin
    // ��λ�������ʽβ��
    while (phExpObjectsTemp[dwObjCur] <> 0) do Inc(dwObjCur);

    // β�������ź������
    phExpObjectsTemp[dwObjCur] := hsemOnlyOne;

    // ��д�������ʽ�ṹ
    Expression[dwNumExps].m_phExpObjects := @phExpObjectsTemp[dwObjBegin];
    Expression[dwNumExps].m_nExpObjects := dwObjCur - dwObjBegin + 1;

    // ���ʽ�ڲ��������
    if (Expression[dwNumExps].m_nExpObjects > MAXIMUM_WAIT_OBJECTS) then
    begin
      Result := WAIT_FAILED;
      SetLastError(ERROR_SECRET_TOO_LONG);
    end;

    // ׼�������¸����ʽ
    Inc(dwObjCur);
    dwObjBegin := dwObjCur;
    Inc(dwNumExps);

    // ԭ��: ���ʽ��������
    // ����: ��������64�����ʽ, dwNumExpsӦ�þ͵���64, ��Ŀǰ���ʽ������δ����64
    if (dwNumExps = MAXIMUM_WAIT_OBJECTS) then
    begin
      Result := WAIT_FAILED;
      SetLastError(ERROR_TOO_MANY_SECRETS);
    end;
  end;

  // ��������б�û������
  if (Result <> WAIT_FAILED) then
  begin
    // Ϊÿ�����ʽ�����߳�
    for dwExpNum := 0 to dwNumExps - 1 do
    begin
      ahThreads[dwExpNum] :=
        BeginThread(nil, 1, @WFME_ThreadExpression, @Expression[dwExpNum], 0, dwThreadId);
    end;

    // �ȴ�ĳһ�����ʽ����
    Result := WaitForMultipleObjects(dwNumExps, @ahThreads[0], FALSE, dwMilliseconds);

    // ��ʱ, ׼������ʱ����
    if (Result = WAIT_TIMEOUT) then
    begin
      // ��ֹ���ʽ�̵߳ȴ��ɹ�
      Result := WaitForSingleObject(hsemOnlyOne, 0);

      // ����ȴ��ź���hsemOnlyOne��ʱ,
      // ˵���б��ʽ�̸߳պõȴ��ɹ�
      if (WAIT_TIMEOUT = Result) then
      begin
        // �ҳ��ȴ��ɹ����߳�
        Result := WaitForMultipleObjects(dwNumExps, @ahThreads[0], FALSE, INFINITE);
      end else
      begin
        // ����, ���ճ�ʱ����
        Result := WAIT_TIMEOUT;
      end;
    end;

    // �������ڵȴ��ı��ʽ�߳�
    for dwExpNum := 0 to dwNumExps - 1 do
    begin
      if (WAIT_TIMEOUT = Result) or (dwExpNum <> (Result - WAIT_OBJECT_0)) then
        QueueUserAPC(@WFME_ExpressionAPC, ahThreads[dwExpNum], 0);
    end;

{$IFDEF DEBUG}
   WaitForMultipleObjects(dwExpNum, @ahThreads[0], TRUE, INFINITE);
{$ENDIF}

    // �ر��߳�(�ں˶���)���
    for dwExpNum := 0 to dwNumExps - 1 do CloseHandle(ahThreads[dwExpNum]);
  end;

  // ����ź���(�ں�)����
  CloseHandle(hsemOnlyOne);
end;

end.
