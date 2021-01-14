
// Module name: Mutexes.C ->> Mutexes.dpr
// Notices: Copyright (c) 1995-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

program Mutexes;

{$R 'Mutexes.res' 'Mutexes.rc'}

uses
  Windows, Messages,
  Other in '..\Other.pas', CmnHdr in '..\CmnHdr.pas', WindowsX in '..\WindowsX.pas';

const
  IDD_MUTEXES          =  1;
  IDC_PRIORITYCLASS    =  100;
  IDC_DSPYTHRDPRIORITY =  101;
  IDI_MUTEXES          =  101;
  IDC_CNTRTHRDPRIORITY =  102;
  IDC_PAUSE            =  103;
  IDC_SYNCHRONIZE      =  104;
  IDC_SHOWCNTRTHRD     =  105;
  IDC_DATABOX          =  106;

var
  g_hWnd: HWND;                      // ������
  g_fTerminate: BOOL = FALSE;        // �����߳�
  g_hThread: array[0..1] of THandle; // �߳̾��
  g_szNumber: array[0..10] of Char = '0'; // ��������
  g_hMutex: THandle;                      // �������

  // ��ListBox����ִ�
procedure AddToListBox(const szBuffer: PChar);
var
  hWndDataBox: HWND;
  x: Integer;
begin
  hWndDataBox := GetDlgItem(g_hWnd, IDC_DATABOX);

  x := ListBox_AddString(hWndDataBox, szBuffer);
  ListBox_SetCurSel(hWndDataBox, x);

  if (ListBox_GetCount(hWndDataBox) > 100) then
    ListBox_DeleteString(hWndDataBox, 0);
end;

  // �ۼ��߳�
function CounterThread(lpThreadParameter: Pointer): Integer;
var
  nNumber, nDigit: Integer;
  fSyncChecked: BOOL;
begin
  // ����ѭ��
  while (not g_fTerminate) do
  begin
    // �Ƿ�ͬ��
    fSyncChecked := IsDlgButtonChecked(g_hWnd, IDC_SYNCHRONIZE) = BST_CHECKED;
    if (fSyncChecked) then WaitForSingleObject(g_hMutex, INFINITE);

    // StrתInt
    nNumber := Str2Int(g_szNumber);

    // ��ֵ����
    Inc(nNumber);

    // IntתStr
    nDigit := 0;
    while (nNumber <> 0) do
    begin
      g_szNumber[nDigit] := Char($30 + nNumber mod 10);
      Inc(nDigit);
      nNumber := nNumber div 10;
      Sleep(1);
    end;
    g_szNumber[nDigit] := #0;
    StrRev(g_szNumber);

    // �ͷŶ���
    if (fSyncChecked) then ReleaseMutex(g_hMutex);

    // ��ʾ�ۼ�
    if (IsDlgButtonChecked(g_hWnd, IDC_SHOWCNTRTHRD) = BST_CHECKED) then AddToListBox('Cntr: Increment');
  end;

  Result := 0;
end;

  // ��ʾ�߳�
function DisplayThread(lpThreadParameter: Pointer): Integer;
var
  fSyncChecked: BOOL;
  szBuffer: array[0..50] of Char;
begin
  // ����ѭ��
  while (not g_fTerminate) do
  begin
    // �Ƿ�ͬ��
    fSyncChecked := IsDlgButtonChecked(g_hWnd, IDC_SYNCHRONIZE) = BST_CHECKED;
    if (fSyncChecked) then WaitForSingleObject(g_hMutex, INFINITE);

    // �����ִ�
    _wvsprintf(szBuffer, 'Dspy: %s', [DWORD(@g_szNumber)]);

    // �ͷŶ���
    if (fSyncChecked) then ReleaseMutex(g_hMutex);

    // ��ʾ����
    AddToListBox(szBuffer);

    Sleep(1);
  end;

  Result := 0;
end;

  // WM_INITDIALOG
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
var
  dwThreadID, hWndCtl: DWORD; // HWND
begin
  chSETDLGICONS(hWnd, IDI_MUTEXES, IDI_MUTEXES);

  g_hWnd := hWnd;
  g_hMutex := CreateMutex(nil, FALSE, nil);
  g_hThread[0] := BeginThread(nil, 0, @CounterThread, nil, 0, dwThreadID);
  g_hThread[1] := BeginThread(nil, 0, @DisplayThread, nil, 0, dwThreadID);

  hWndCtl := GetDlgItem(hWnd, IDC_PRIORITYCLASS);
  ComboBox_AddString(hWndCtl, 'Idle');
  ComboBox_AddString(hWndCtl, 'Normal');
  ComboBox_AddString(hWndCtl, 'High');
  ComboBox_AddString(hWndCtl, 'Realtime');
  ComboBox_SetCurSel(hWndCtl, 1); // Normal

  hWndCtl := GetDlgItem(hWnd, IDC_DSPYTHRDPRIORITY);
  ComboBox_AddString(hWndCtl, 'Idle');
  ComboBox_AddString(hWndCtl, 'Lowest');
  ComboBox_AddString(hWndCtl, 'Below normal');
  ComboBox_AddString(hWndCtl, 'Normal');
  ComboBox_AddString(hWndCtl, 'Above normal');
  ComboBox_AddString(hWndCtl, 'Highest');
  ComboBox_AddString(hWndCtl, 'Timecritical');
  ComboBox_SetCurSel(hWndCtl, 3); // Normal

  hWndCtl := GetDlgItem(hWnd, IDC_CNTRTHRDPRIORITY);
  ComboBox_AddString(hWndCtl, 'Idle');
  ComboBox_AddString(hWndCtl, 'Lowest');
  ComboBox_AddString(hWndCtl, 'Below normal');
  ComboBox_AddString(hWndCtl, 'Normal');
  ComboBox_AddString(hWndCtl, 'Above normal');
  ComboBox_AddString(hWndCtl, 'Highest');
  ComboBox_AddString(hWndCtl, 'Timecritical');
  ComboBox_SetCurSel(hWndCtl, 3); // Normal

  Result := TRUE;
end;

  // WM_DESTROY
procedure Dlg_OnDestroy(hWnd: HWND);
begin
  g_fTerminate := TRUE;
  ResumeThread(g_hThread[0]);
  ResumeThread(g_hThread[1]);
end;

  // WM_COMMAND
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
var
  hThread: THANDLE;
  dw: Integer;
begin
  case (id) of
    IDCANCEL:
      begin
        EndDialog(hWnd, id);
      end;

    IDC_PRIORITYCLASS: // �������ȼ�
      begin
        if (codeNotify <> CBN_SELCHANGE) then Exit;

        case ComboBox_GetCurSel(hWndCtl) of
          0: dw := IDLE_PRIORITY_CLASS;
          1: dw := NORMAL_PRIORITY_CLASS;
          2: dw := HIGH_PRIORITY_CLASS;
          3: dw := REALTIME_PRIORITY_CLASS;
          else dw := NORMAL_PRIORITY_CLASS;
        end;
        SetPriorityClass(GetCurrentProcess(), dw);
      end;

    IDC_DSPYTHRDPRIORITY, // �߳����ȼ�
    IDC_CNTRTHRDPRIORITY:
      begin
        if (codeNotify <> CBN_SELCHANGE) then Exit;

        case ComboBox_GetCurSel(hWndCtl) of
          0: dw := THREAD_PRIORITY_IDLE;
          1: dw := THREAD_PRIORITY_LOWEST;
          2: dw := THREAD_PRIORITY_BELOW_NORMAL;
          3: dw := THREAD_PRIORITY_NORMAL;
          4: dw := THREAD_PRIORITY_ABOVE_NORMAL;
          5: dw := THREAD_PRIORITY_HIGHEST;
          6: dw := THREAD_PRIORITY_TIME_CRITICAL;
          else dw := THREAD_PRIORITY_NORMAL;
        end;
        hThread := IfThen(id = IDC_CNTRTHRDPRIORITY, g_hThread[0], g_hThread[1]);
        SetThreadPriority(hThread, dw);
      end;

    IDC_PAUSE: // ��ͣor�ָ�
      begin
        if (Button_GetCheck(hWndCtl) = BST_CHECKED) then
        begin
          SuspendThread(g_hThread[0]);
          SuspendThread(g_hThread[1]);
        end else
        begin
          ResumeThread(g_hThread[0]);
          ResumeThread(g_hThread[1]);
        end;
      end;
   end; // END: case (id) of ..
end;

  // �Ի���ص�
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  case (uMsg) of
    WM_INITDIALOG:
      begin
        Result := SetDlgMsgResult(hWnd, LRESULT(Dlg_OnInitDialog(hWnd, wParam, lParam)));
      end;

    WM_DESTROY:
      begin
        Dlg_OnDestroy(hWnd);
        Result := TRUE;
      end;

    WM_COMMAND:
      begin
        Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));
        Result := TRUE;
      end;

    else Result := FALSE;
  end;
end;

  // ���߳����
begin
  chWARNIFUNICODEUNDERWIN95();
  DialogBox(HInstance, MakeIntResource(IDD_MUTEXES), 0, @Dlg_Proc);

  // �ȴ��߳̽���
  WaitForMultipleObjects(2, @g_hThread, TRUE, INFINITE);

  // �رն�����
  CloseHandle(g_hThread[0]);
  CloseHandle(g_hThread[1]);
  CloseHandle(g_hMutex);
end.
