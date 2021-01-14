program WfMETest;

{$R 'WfMETest.res' 'WfMETest.rc'}

uses Windows, Messages, WaitForMultExp in 'WaitForMultExp.pas';

const
  IDI_WFMETEXT = 101; // ��Դ���ID
  IDD_WFMETEST = 102;
  IDC_NUMOBJS    = 1000; // ���ڿؼ�ID
  IDC_TIMEOUT    = 1001;
  IDC_EXPRESSION = 1002;
  IDC_OBJLIST    = 1003;
  IDC_RESULT     = 1004;
  MAX_KERNEL_OBJS = 1000; // �¼�������������
  MAX_EXPRESSION_SIZE = ((64 * 63) + 63); // m_ahExpObjs���鳤��
  WM_WAITEND = (WM_USER + 101); // �Զ�����Ϣ, �����ݽ��ȴ����

type
  TAWFME = record
    m_hWnd: HWND;            // ����ݽ�Ŀ�괰�ھ��
    m_dwMilliseconds: DWORD; // ����Ϊ��λ�ĳ�ʱ���
    m_nExpObjects: DWORD;    // m_ahExpObjs ʵ��ʹ�ó���
    m_ahExpObjs: array[0..MAX_EXPRESSION_SIZE - 1] of THandle; // ����б���ɵı��ʽ
  end;

var
  g_ahObjs: array[0..MAX_KERNEL_OBJS - 1] of THandle; // �¼��������б�
  g_awfme: TAWFME;

  // �첽�ȴ��̺߳���
function AsyncWaitForMultipleExpressions(const pawfme: TAWFME): Integer;
begin
  // ����ȴ�
  Result := WaitForMultipleExpressions(
    pawfme.m_nExpObjects, @pawfme.m_ahExpObjs[0], pawfme.m_dwMilliseconds);

  // ֪ͨ���
  PostMessage(pawfme.m_hWnd, WM_WAITEND, Result, 0);
end;

  // ʮ�����ִ�ת����
function StrToInt(const S: PChar): Integer;
var
  P: PByte;
begin
  Result := 0;
  P := PByte(S);
  while (P^ <> $00) do
  begin
    if (P^ > $39) or (P^ < $30) then // Խ��
    begin
      Result := 0;
      Exit;
    end else
    begin
      Result := Result * 10 + (P^ - $30);
      Inc(P); // ָ�����
    end;
  end;
end;

  // s1���׸�δ������s2���ַ���ƫ��
function StrSpn(const s1, s2: PChar): Integer;
var
  p1, p2: PChar;
begin
  Result := 0;

  p1 := s1;
  while (p1^ <> #0) do // ����s1
  begin
    p2 := s2;
    while (p2^ <> #0) do // ����s2
    begin
      if (p1^ = p2^) then Break;
      Inc(p2); // ָ�����
    end;
    if (p2^ = #0) then Exit; // s1��ǰ�ַ�������s2��

    Inc(p1); // ָ�����
    Inc(Result);
  end;
end;

  // s1���״γ���s2����һ�ַ���λ��
function StrPBrk(const s1, s2: PChar): PChar;
var
  p1, p2: PChar;
begin
  p1 := s1;
  while (p1^ <> #0) do // ����s1
  begin
    p2 := s2;
    while (p2^ <> #0) do // ����s2
    begin
      if (p1^ = p2^) then
      begin
        Result := p1; // ����λ��
        Exit;
      end;

      Inc(p2); // ָ�����
    end;

    Inc(p1); // ָ�����
  end;

  Result := nil; // û�ҵ�
end;

  // �Էָ���t���ֽ�s
function StrTok(const s, t: PChar): PChar;
const
{$J+}
  sStrTok: PChar = nil;
{$J-}
var
  sBegin, sEnd: PChar;
begin
  // ȷ�������׵�ַ
  if (s = nil) then
    sBegin := sStrTok
  else
    sBegin := s;
  if (sBegin = nil) then
  begin
    Result := nil;
    Exit;
  end;

  // ������ͷ�ָ���
  Inc(sBegin, StrSpn(sBegin, t));
  if (sBegin^ = #0) then
  begin
    sStrTok := nil;
    Result := nil;
    Exit;
  end;
  Result := sBegin;

  // ��λ��һ�ָ���
  sEnd := StrPBrk(sBegin, t);
  if (sEnd <> nil) and (sEnd^ <> #0) then
  begin
    sEnd^ := #0;
    Inc(sEnd);
  end;
  sStrTok := sEnd;
end;

  // �Ի���WM_INITDIALOG��Ϣ����
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  // ���ô���ͼ��
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_WFMETEXT)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_WFMETEXT)));

  // �ӿؼ�Ĭ��ֵ
  SetDlgItemInt(hWnd, IDC_NUMOBJS, 4, FALSE);
  SetDlgItemInt(hWnd, IDC_TIMEOUT, 30000, FALSE);
  SetDlgItemText(hWnd, IDC_EXPRESSION, '1 2 | 2 3 4 | 1 4');

  // ListBox �п�
  SendMessage(GetDlgItem(hWnd, IDC_OBJLIST),
    LB_SETCOLUMNWIDTH, LOWORD(GetDialogBaseUnits()) * 4, 0);

  // ����Ĭ�Ͻ���
  Result := TRUE;
end;

  // �Ի���WM_WAITEND��Ϣ����
function Dlg_OnWaitEnd(hWnd: HWND; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  n: Integer;
begin
  // ����¼�����
  n := 0;
  while (g_ahObjs[n] <> 0) do
  begin
    CloseHandle(g_ahObjs[n]);
    Inc(n);
  end;

  // ��ʾ�ȴ����
  if (wParam = WAIT_TIMEOUT) then
    SetDlgItemText(hWnd, IDC_RESULT, 'Timeout')
  else
    if (wParam = Longint(WAIT_FAILED)) then
      SetDlgItemText(hWnd, IDC_RESULT, 'Failed') // **
    else
      SetDlgItemInt(hWnd, IDC_RESULT, wParam - WAIT_OBJECT_0, FALSE);

  // ���ô��ڿؼ�
  EnableWindow(GetDlgItem(hWnd, IDC_NUMOBJS), TRUE);
  EnableWindow(GetDlgItem(hWnd, IDC_TIMEOUT), TRUE);
  EnableWindow(GetDlgItem(hWnd, IDC_EXPRESSION), TRUE);
  EnableWindow(GetDlgItem(hWnd, IDOK), TRUE);
  SetFocus(GetDlgItem(hWnd, IDC_EXPRESSION));

  Result := 0;
end;

  // �Ի���WM_COMMAND��Ϣ����
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
var
  szExpression: array[0..100] of Char;
  szBuf: array[0..20] of Char;
  nObjects, n: Integer;
  dwThreadId: DWORD;
  p: PChar;
begin
  // ���ʽ��
  GetWindowText(GetDlgItem(hWnd, IDC_EXPRESSION), szExpression, SizeOf(szExpression));

  // ��������
  nObjects := GetDlgItemInt(hWnd, IDC_NUMOBJS, PBOOL(nil)^, FALSE);

  case (id) of
    IDCANCEL:
      begin
        EndDialog(hWnd, id);
      end;

    IDC_OBJLIST:
      if (codeNotify = LBN_SELCHANGE) then
      begin
        // ListBoxѡ����Ŀ�Ѿ��ı�

        // �����¼�������Ϊ���ź�
        for n := 0 to nObjects - 1 do ResetEvent(g_ahObjs[n]);

        // ����ѡ�����¼�����״̬
        for n := 0 to nObjects - 1 do
        begin
          if (SendMessage(GetDlgItem(hWnd, IDC_OBJLIST), LB_GETSEL, n, 0) > 0) then
            SetEvent(g_ahObjs[n]);
        end;
      end;

    IDOK:
      begin
        // ������������
        if (nObjects <= 0) or (nObjects > MAX_KERNEL_OBJS) then Exit;

        // ���ô��ڿؼ�
        SetFocus(GetDlgItem(hWnd, IDC_OBJLIST));
        EnableWindow(GetDlgItem(hWnd, IDC_NUMOBJS), FALSE);
        EnableWindow(GetDlgItem(hWnd, IDC_TIMEOUT), FALSE);
        EnableWindow(GetDlgItem(hWnd, IDC_EXPRESSION), FALSE);
        EnableWindow(GetDlgItem(hWnd, IDOK), FALSE);

        // ��ʾ����ִ��
        SetDlgItemText(hWnd, IDC_RESULT, 'Waiting...');

        // ��ʼ��g_awfme
        g_awfme.m_hwnd := hWnd;
        g_awfme.m_dwMilliseconds := GetDlgItemInt(hWnd, IDC_TIMEOUT, PBOOL(nil)^, FALSE);
        g_awfme.m_nExpObjects := 0;
        ZeroMemory(@g_awfme.m_ahExpObjs[0], SizeOf(g_awfme.m_ahExpObjs));

        // ��������б�
        SendMessage(GetDlgItem(hWnd, IDC_OBJLIST), LB_RESETCONTENT, 0, 0);
        ZeroMemory(@g_ahObjs[0], SizeOf(g_ahObjs));
        for n := 1 to nObjects do
        begin
          // �����¼�����
          g_ahObjs[n - 1] := CreateEvent(nil, FALSE, FALSE, nil);

          // ���List��Ŀ
          wvsprintf(szBuf, '  %d', @n);
          SendMessage(GetDlgItem(hWnd, IDC_OBJLIST),
            LB_ADDSTRING, 0, Longint(@szBuf[lstrlen(szBuf) - 3]));
        end;

        // �������ʽ��
        p := StrTok(szExpression, ' ');
        while (p <> nil) do
        begin
          // ��ǰԪ������
          if (p^ = '|') then                                      
            g_awfme.m_ahExpObjs[g_awfme.m_nExpObjects] := 0   // #0 = '|' = OR
          else begin
            n := StrToInt(p);                                 // ��n���¼�����
            g_awfme.m_ahExpObjs[g_awfme.m_nExpObjects] := g_ahObjs[n - 1];
          end;

          // ���鳤������
          Inc(g_awfme.m_nExpObjects);

          // ��λ��һԪ��
          p := StrTok(nil, ' ');
        end;

        // �����ȴ��߳�
        CloseHandle(
          BeginThread(nil, 0, @AsyncWaitForMultipleExpressions, @g_awfme, 0, dwThreadId) );
      end;
  end;
end;

  // �Ի�����Ϣ����ص�
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  Result := FALSE;

  case (uMsg) of
    WM_INITDIALOG:
      Result := SetWindowLong(hWnd, DWL_MSGRESULT,
        Longint(Dlg_OnInitDialog(hWnd, wParam, lParam))) <> 0;

    WM_COMMAND:
      Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));

    WM_WAITEND:
      Result := (Dlg_OnWaitEnd(hwnd, wParam, lParam) <> 0);
  end;
end;

  // �������߳���ڵ�
begin
  DialogBox(HInstance, MakeIntResource(IDD_WFMETEST), 0, @Dlg_Proc);
end.
