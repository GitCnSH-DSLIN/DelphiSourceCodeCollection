
// Module name: SprMrkt.C ->> SprMrkt.dpr
// Notices: Copyright (c) 1995-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

program SprMrkt;

{$R 'SprMrkt.res' 'SprMrkt.rc'}

uses
  Windows, Messages,
  Other in '..\Other.pas', CmnHdr in '..\CmnHdr.pas', WindowsX in '..\WindowsX.pas';

const
  IDD_SPRMRKT              =    1;
  IDC_MAXOCCUPANCY         =  100;
  IDC_TIMEOPEN             =  101;
  IDI_SPRMRKT              =  101;
  IDC_NUMCOUNTERS          =  102;
  IDC_SHOPPERCREATIONDELAY =  103;
  IDC_DELAYTOGETIN         =  104;
  IDC_TIMETOSHOP           =  105;
  IDC_WAITDELICNTR         =  106;
  IDC_TIMEATDELICNTR       =  107;
  IDC_TIMEATCHECKOUT       =  108;
  IDC_SHOPPEREVENTS        =  109;

var
  g_hWndLB: HWND = 0; // ��Ϣ���ListBox���

var
  g_nMaxOccupancy,         // ����������������
  g_nTimeOpen,             // ���б��ο���ʱ��
  g_nCheckoutCounters,     // ���н��ʹ�̨����
  g_nMaxDelayBetweenShopperCreation, // �����¹˿͵����ʱ����
  g_nMaxWaitToGetInMarket,           // �˿͵ȴ����볬��, ��ȴ�ʱ��
  g_nMaxTimeShopping,                // �˿͹���, ���ķ�ʱ��
  g_nMaxWaitForDeliCntr,             // �˿͵ȴ�������ʳ, ��ȴ�ʱ��
  g_nMaxTimeSpentAtDeli,             // �˿͹�����ʳ, ���ķ�ʱ��
  g_nMaxTimeAtCheckout: Integer;     // �˿ͽ���, ���ķ�ʱ��

var
  g_hSemEntrance,          // ���ƽ��볬������
  g_hMtxDeliCntr,          // ����һһ������ʳ
  g_hSemCheckout: THandle; // ���ƹ�̨��������

  // ��ListBox��Ӹ�ʽ���ַ���
procedure AddStr(const szFmt: PChar; const va_params: array of DWORD);
var
  szBuf: array[0..150] of Char;
  nIndex: Integer;
begin
  Windows.wvsprintf(szBuf, szFmt, @va_params);

  repeat
    nIndex := ListBox_AddString(g_hWndLB, szBuf);
    if (nIndex = LB_ERR) then ListBox_DeleteString(g_hWndLB, 0) else Break;
  until FALSE;

  ListBox_SetCurSel(g_hWndLB, nIndex);
end;

  // 0 <= Result <= nMaxValue
function Random(nMaxValue: Integer): Integer;
begin
  Result := System.Random(nMaxValue + 1);
end;

  // �˿��̻߳ص�����
function ThreadShopper(nShopperNum: Integer): Integer;
var
  dwResult: DWORD;
  nDuration: Integer;
begin
  Result := 0;
  Randomize();

  // ����ȴ�ʱ��
  nDuration := Random(g_nMaxWaitToGetInMarket);
  AddStr('%04lu: Waiting to get in store (%lu).', [nShopperNum, nDuration]);

  // �ȴ����볬��
  dwResult := WaitForSingleObject(g_hSemEntrance, nDuration);
  if (dwResult = WAIT_TIMEOUT) then
  begin
    AddStr('%04lu: Tired of waiting; went home.', [nShopperNum]); // ��ʱ�ؼ� ^^
    Exit;
  end;

  // ����һ��ʱ��
  nDuration := Random(g_nMaxTimeShopping);
  AddStr('%04lu: In supermarket, shopping for %lu.', [nShopperNum, nDuration]);
  Sleep(nDuration);

  // ���ܹ�����ʳ
  if (Random(2) = 0) then
  begin
    // ����ȴ�ʱ��
    nDuration := Random(g_nMaxWaitForDeliCntr);
    AddStr('%04lu: Waiting for service at Deli Counter (%lu).', [nShopperNum, nDuration]);

    // �ȴ�������ʳ
    dwResult := WaitForSingleObject(g_hMtxDeliCntr, nDuration);
    if (dwResult = STATUS_WAIT_0) then
    begin
      // ������ʳ��ʱ
      nDuration := Random(g_nMaxTimeSpentAtDeli);
      AddStr('%04lu: Being served at Deli (%lu).', [nShopperNum, nDuration]);
      Sleep(nDuration);

      // ������ʳ���
      ReleaseMutex(g_hMtxDeliCntr);
    end else
    begin
      AddStr('%04lu: Tired of waiting at Deli.', [nShopperNum]); // ��ʱ�뿪 ^^
    end;
  end else
  begin
    AddStr('%04lu: Not going to the Deli counter.', [nShopperNum]); // ������ʳ ^^
  end;

  // �ȴ���̨����
  AddStr('%04lu: Waiting for an empty checkout counter.', [nShopperNum]);
  WaitForSingleObject(g_hSemCheckout, INFINITE);

  // ��������ʱ��
  nDuration := Random(g_nMaxTimeAtCheckout);
  AddStr('%04lu: Checking out (%lu).', [nShopperNum, nDuration]);
  Sleep(nDuration);

  // ��ɹ�̨����
  AddStr('%04lu: Leaving checkout counter.', [nShopperNum]);
  ReleaseSemaphore(g_hSemCheckout, 1, nil);

  // �뿪���лؼ�
  AddStr('%04lu: Left the supermarket.', [nShopperNum]);
  ReleaseSemaphore(g_hSemEntrance, 1, nil);
end;

  // �����̻߳ص�����
function ThreadSuperMarket(hWnd: HWND): Integer;
var
  dwCloseTime: DWORD;
  hThread: THandle;
  dwThreadId: DWORD;
  nShopperNum: Integer; // = 0
  nMaxOccupancy: Integer;
begin
  nShopperNum := 0; // �˿�����?

  // �˿ͽ�������
  g_hSemEntrance := CreateSemaphore(nil, 0, g_nMaxOccupancy, nil);

  // ��ʳ��������
  g_hMtxDeliCntr := CreateMutex(nil, FALSE, nil);

  // ���ʹ�̨����
  g_hSemCheckout := CreateSemaphore(nil, g_nCheckoutCounters, g_nCheckoutCounters, nil);

  // �򿪳��д���
  AddStr('---> Opening the supermarket to shoppers.', []);
  ReleaseSemaphore(g_hSemEntrance, g_nMaxOccupancy, nil);

  // ���й���ʱ��
  dwCloseTime := GetTickCount() + DWORD(g_nTimeOpen);

  // ���п�ʼ��ת
  while (GetTickCount() < dwCloseTime) do
  begin
    // ����һλ�˿�
    hThread := BeginThread(nil, 0, @ThreadShopper, Pointer(nShopperNum), 0, dwThreadId);
    CloseHandle(hThread);
    Inc(nShopperNum);

    // ��λ���ټ��
    Sleep(Random(g_nMaxDelayBetweenShopperCreation));
  end;

  // ����׼������
  AddStr('---> Waiting for shoppers to check out ', [DWORD(PChar('so store can close.'))]);

  // �ȴ��˿��뿪
  for nMaxOccupancy := 1 to g_nMaxOccupancy - 1 do
  begin
    WaitForSingleObject(g_hSemEntrance, INFINITE);
    AddStr('---> %d shoppers NOT in store.', [nMaxOccupancy]);
  end;

  // �رճ��д���
  AddStr('---> Store closed--end of simulation.', []);

  // ����ں˶���
  CloseHandle(g_hSemCheckout);
  CloseHandle(g_hMtxDeliCntr);
  CloseHandle(g_hSemEntrance);

  // ֪ͨ�������
  SendMessage(hWnd, WM_USER, 0, 0);

  Result := 0;
end;

  // WM_INITDIALOG
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
var
  hWndSB: DWORD; // HWND
begin
  chSETDLGICONS(hWnd, IDI_SPRMRKT, IDI_SPRMRKT);

  g_hWndLB := GetDlgItem(hWnd, IDC_SHOPPEREVENTS);

  hWndSB := GetDlgItem(hWnd, IDC_MAXOCCUPANCY);
  ScrollBar_SetRange(hWndSB, 0, 500, TRUE);
  FORWARD_WM_HSCROLL(hWnd, hWndSB, SB_THUMBTRACK, 30);

  hWndSB := GetDlgItem(hWnd, IDC_TIMEOPEN);
  ScrollBar_SetRange(hWndSB, 0, 5000, TRUE);
  FORWARD_WM_HSCROLL(hWnd, hWndSB, SB_THUMBTRACK, 5000);

  hWndSB := GetDlgItem(hWnd, IDC_NUMCOUNTERS);
  ScrollBar_SetRange(hWndSB, 0, 30, TRUE);
  FORWARD_WM_HSCROLL(hWnd, hWndSB, SB_THUMBTRACK, 5);

  hWndSB := GetDlgItem(hWnd, IDC_SHOPPERCREATIONDELAY);
  ScrollBar_SetRange(hWndSB, 0, 1000, TRUE);
  FORWARD_WM_HSCROLL(hWnd, hWndSB, SB_THUMBTRACK, 300);

  hWndSB := GetDlgItem(hWnd, IDC_DELAYTOGETIN);
  ScrollBar_SetRange(hWndSB, 0, 100, TRUE);
  FORWARD_WM_HSCROLL(hWnd, hWndSB, SB_THUMBTRACK, 20);

  hWndSB := GetDlgItem(hWnd, IDC_TIMETOSHOP);
  ScrollBar_SetRange(hWndSB, 0, 100, TRUE);
  FORWARD_WM_HSCROLL(hWnd, hWndSB, SB_THUMBTRACK, 80);

  hWndSB := GetDlgItem(hWnd, IDC_WAITDELICNTR);
  ScrollBar_SetRange(hWndSB, 0, 100, TRUE);
  FORWARD_WM_HSCROLL(hWnd, hWndSB, SB_THUMBTRACK, 20);

  hWndSB := GetDlgItem(hWnd, IDC_TIMEATDELICNTR);
  ScrollBar_SetRange(hWndSB, 0, 100, TRUE);
  FORWARD_WM_HSCROLL(hWnd, hWndSB, SB_THUMBTRACK, 70);

  hWndSB := GetDlgItem(hWnd, IDC_TIMEATCHECKOUT);
  ScrollBar_SetRange(hWndSB, 0, 100, TRUE);
  FORWARD_WM_HSCROLL(hWnd, hWndSB, SB_THUMBTRACK, 60);

  Result := TRUE;
end;

  // WM_HSCROLL
procedure Dlg_OnHScroll(hWnd, hWndCtl: HWND; code: UINT; pos: Integer);
var
  szBuf: array[0..10] of Char;
  nPosCrnt, nPosMin, nPosMax: Integer;
begin
  // ��Χλ��
  nPosCrnt := ScrollBar_GetPos(hWndCtl);
  ScrollBar_GetRange(hWndCtl, @nPosMin, @nPosMax);

  // ��������
  case (code) of
    SB_LINELEFT:
      Dec(nPosCrnt);

    SB_LINERIGHT:
      Inc(nPosCrnt);

    SB_PAGELEFT:
      Dec(nPosCrnt, (nPosMax - nPosMin + 1) div 10);

    SB_PAGERIGHT:
      Inc(nPosCrnt, (nPosMax - nPosMin + 1) div 10);

    SB_THUMBTRACK:
      nPosCrnt := pos;

    SB_LEFT:
      nPosCrnt := nPosMin;

    SB_RIGHT:
      nPosCrnt := nPosMax;
  end;

  // ��Χ����
  if (nPosCrnt < nPosMin) then
    nPosCrnt := nPosMin
  else
    if (nPosCrnt > nPosMax) then
      nPosCrnt := nPosMax;

  // ����λ��
  ScrollBar_SetPos(hWndCtl, nPosCrnt, TRUE);

  // ��ʾλ��
  _wvsprintf(szBuf, '%d', [nPosCrnt]);
  SetWindowText(GetPrevSibling(hWndCtl), szBuf);
end;

  // WM_COMMAND
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
var
  dwThreadId: DWORD;
  hThread: THandle;
begin
  case (id) of
    IDOK:
      begin
        // �������
        g_nMaxOccupancy := ScrollBar_GetPos(GetDlgItem(hWnd, IDC_MAXOCCUPANCY));
        g_nTimeOpen := ScrollBar_GetPos(GetDlgItem(hWnd, IDC_TIMEOPEN));
        g_nCheckoutCounters := ScrollBar_GetPos(GetDlgItem(hWnd, IDC_NUMCOUNTERS));
        g_nMaxDelayBetweenShopperCreation := ScrollBar_GetPos(GetDlgItem(hWnd, IDC_SHOPPERCREATIONDELAY));
        g_nMaxWaitToGetInMarket := ScrollBar_GetPos(GetDlgItem(hWnd, IDC_DELAYTOGETIN));
        g_nMaxTimeShopping := ScrollBar_GetPos(GetDlgItem(hWnd, IDC_TIMETOSHOP));
        g_nMaxWaitForDeliCntr := ScrollBar_GetPos(GetDlgItem(hWnd, IDC_WAITDELICNTR));
        g_nMaxTimeSpentAtDeli := ScrollBar_GetPos(GetDlgItem(hWnd, IDC_TIMEATDELICNTR));
        g_nMaxTimeAtCheckout := ScrollBar_GetPos(GetDlgItem(hWnd, IDC_TIMEATCHECKOUT));

        // ����б�
        ListBox_ResetContent(GetDlgItem(hWnd, IDC_SHOPPEREVENTS));

        // ���ð�ť
        EnableWindow(hWndCtl, FALSE);

        // ���ý���
        if (GetFocus() = 0) then SetFocus(GetDlgItem(hWnd, IDC_MAXOCCUPANCY));

        // �����ȼ�
        SetPriorityClass(GetCurrentProcess(), HIGH_PRIORITY_CLASS);

        // �����߳�
        hThread := BeginThread(nil, 0, @ThreadSuperMarket, Pointer(hWnd), 0, dwThreadId);
        CloseHandle(hThread);
      end;

    IDCANCEL:
      begin
        EndDialog(hWnd, id);
      end;
  end;
end;

  // �Ի���ص�����
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  case (uMsg) of
    WM_INITDIALOG:
      begin
        Result := SetDlgMsgResult(hWnd, LRESULT(Dlg_OnInitDialog(hWnd, wParam, lParam)));
      end;

    WM_COMMAND:
      begin
        Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));
        Result := TRUE;
      end;

    WM_HSCROLL:
      begin
        Dlg_OnHScroll(hWnd, lParam, LOWORD(wParam), HIWORD(wParam));
        Result := TRUE;
      end;

    WM_USER: // �����ѹ��� ^^
      begin
        SetPriorityClass(GetCurrentProcess(), NORMAL_PRIORITY_CLASS);
        EnableWindow(GetDlgItem(hWnd, IDOK), TRUE);

        Result := TRUE;
      end;

    else Result := FALSE;
  end;
end;

  // ���߳����
begin
  chWARNIFUNICODEUNDERWIN95();
  DialogBox(HInstance, MakeIntResource(IDD_SPRMRKT), 0, @Dlg_Proc);
end.
