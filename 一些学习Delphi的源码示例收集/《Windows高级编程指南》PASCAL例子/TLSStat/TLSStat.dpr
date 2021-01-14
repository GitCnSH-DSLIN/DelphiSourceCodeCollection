
// Module name: TLSStat.C ->> TLSStat.dpr
// Notices: Copyright (c) 1995-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

program TLSStat;

{$R 'TLSStat.res' 'TLSStat.rc'}

uses
  Windows, Messages,
  Other in '..\Other.pas', CmnHdr in '..\CmnHdr.pas', WindowsX in '..\WindowsX.pas';

const
  g_szModName = 'TLSStat';
  IDD_TLSSTAT    =  1;
  IDC_CLEAR      =  100;
  IDC_THREADNUM  =  101;
  IDI_TLSSTAT    =  101;
  IDC_NUMCYCLES  =  102;
  IDC_CYCLETIME  =  103;
  IDC_LOG        =  104;

  // �̲߳���
type
  PThreadData = ^TThreadData;
  TThreadData = record
    nThreadNum: Integer;  // �̱߳��
    nNumCycles: Integer;  // ѭ������
    dwCycleTime: DWORD;   // ����ʱ��
  end;

  // ListBox
var
  g_hWndLogLB: HWND = 0;

  // TLS����
threadvar
  gt_dwStartTime: DWORD;

  // �̺߳���
function ThreadFunc(var lpThreadData: TThreadData): Integer;
var
  szBuf: array[0..100] of Char;
begin
  // ��ʼʱ��
  gt_dwStartTime := GetTickCount();

  // ��ʾ��ʼ
  _wvsprintf(szBuf, 'Thread started: %d', [lpThreadData.nThreadNum]);
  ListBox_AddString(g_hWndLogLB, szBuf);
  ListBox_SetCurSel(g_hWndLogLB, 0);

  // ѭ������
  while (lpThreadData.nNumCycles > 0) do
  begin
    Dec(lpThreadData.nNumCycles);

    // ��ʾ״̬
    _wvsprintf(szBuf, 'Thread %d, Cycles left=%d, time running=%d',
      [lpThreadData.nThreadNum, lpThreadData.nNumCycles, GetTickCount() - gt_dwStartTime]);
    ListBox_AddString(g_hWndLogLB, szBuf);

    // ����һ��
    Sleep(lpThreadData.dwCycleTime);
  end;

  // ��ʾ����
  _wvsprintf(szBuf, 'Thread ended: %d, total time=%d',
    [lpThreadData.nThreadNum, GetTickCount() - gt_dwStartTime]);
  ListBox_AddString(g_hWndLogLB, szBuf);

  // �ͷŽṹ
  HeapFree(GetProcessHeap(), 0, @lpThreadData);

  Result := 0;
end;

  // WM_INITDIALOG
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  chSETDLGICONS(hWnd, IDI_TLSSTAT, IDI_TLSSTAT);

  SetDlgItemInt(hWnd, IDC_THREADNUM, 1, FALSE);
  SetDlgItemInt(hWnd, IDC_NUMCYCLES, 10, FALSE);
  SetDlgItemInt(hWnd, IDC_CYCLETIME, 3, FALSE);

  g_hWndLogLB := GetDlgItem(hWnd, IDC_LOG);

  SetFocus(GetDlgItem(hWnd, IDOK));
  Result := TRUE;
end;

  // WM_COMMAND
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
var
  dwIDThread: DWORD;
  hThread: THandle;
  lpThreadData: PThreadData;
begin
  case (id) of
    IDC_CLEAR:
      begin
        SetDlgItemInt(hWnd, IDC_THREADNUM, 1, FALSE);
        ListBox_ResetContent(g_hWndLogLB);
      end;

    IDOK:
      begin
        // ����ṹ
        lpThreadData := HeapAlloc(GetProcessHeap(), 0, SizeOf(TThreadData));
        if (lpThreadData = nil) then
        begin
          chMB('Error creating ThreadData', g_szModName);
          Exit;
        end;

        // ��д�ṹ
        lpThreadData.nThreadNum := GetDlgItemInt(hWnd, IDC_THREADNUM, PBOOL(nil)^, FALSE);
        lpThreadData.nNumCycles := GetDlgItemInt(hWnd, IDC_NUMCYCLES, PBOOL(nil)^, FALSE);
        lpThreadData.dwCycleTime := 1000 * GetDlgItemInt(hWnd, IDC_CYCLETIME, PBOOL(nil)^, FALSE);

        // �������
        SetDlgItemInt(hWnd, IDC_THREADNUM, lpThreadData.nThreadNum + 1, FALSE);

        // �����߳�
        hThread := BeginThread(nil, 0, @ThreadFunc, lpThreadData, 0, dwIDThread);

        // �ͷ���Դ
        if (hThread <> 0) then
        begin
          CloseHandle(hThread);
        end else
        begin
          chMB('Error creating the new thread', g_szModName);
          HeapFree(GetProcessHeap(), 0, lpThreadData);
        end;
      end;

    IDCANCEL:
      begin
        EndDialog(hWnd, id);
      end;
  end;
end;

  // �Ի���ص�
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  case (uMsg) of
    WM_INITDIALOG:
      Result := SetDlgMsgResult(hWnd, LRESULT(Dlg_OnInitDialog(hWnd, wParam, lParam)));

    WM_COMMAND:
    begin
      Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));
      Result := TRUE;
    end;

    else Result := FALSE;
  end;
end;

  // ���߳����
var
  szBuf: array[0..100] of Char;
begin
  // ��¼��ʼʱ��
  gt_dwStartTime := GetTickCount();

  chWARNIFUNICODEUNDERWIN95();
  DialogBox(HInstance, MakeIntResource(IDD_TLSSTAT), 0, @Dlg_Proc);

  // ��ʾ����ʱ��
  _wvsprintf(szBuf, 'Total time running application=%d.', [GetTickCount() - gt_dwStartTime]);
  chMB(szBuf, g_szModName);
end.
