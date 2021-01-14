
// Module name: LISLab.C ->> LISLab.dpr
// Notices: Copyright (c) 1995-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

program LISLab;

{$R 'LISLab.res' 'LISLab.rc'}

uses
  Windows, Messages,
  Other in '..\Other.pas', CmnHdr in '..\CmnHdr.pas', WindowsX in '..\WindowsX.pas';

const
  IDD_LISLAB         =    1;
  IDC_WNDFOCUS       =  100;
  IDC_WNDACTIVE      =  101;
  IDC_WNDFOREGROUND  =  102;
  IDI_LISLAB         =  102;
  IDC_WNDCAPTURE     =  103;
  IDC_CLIPCURSOR     =  104;
  IDC_WNDFUNC        =  105;
  IDC_FUNCSTART      =  106;
  IDC_DELAY          =  107;
  IDC_WNDS           =  110;
  IDC_THREADATTACH   =  111;
  IDC_THREADDETACH   =  112;
  IDC_MOUSEMSGS      =  113;
  IDC_SETCLIPRECT    =  114;
  IDC_REMOVECLIPRECT =  115;
  IDC_HIDECURSOR     =  116;
  IDC_SHOWCURSOR     =  117;
  IDC_EVENTPENDING   =  118;
  IDC_PREVWND        =  119;
  IDC_INFINITELOOP   =  120;

const
  Timer_Delay = 1000;

var
  g_uTimerId: DWORD = 1;
  g_nEventId: DWORD = 0;
  g_dwEventTime: DWORD = 0;
  g_hWndSubject: HWND = 0;
  g_hWndNotepad: HWND = 0;

  // ����������Ϣ
procedure CalcWndText(hWnd: HWND; const szBuf: PChar; nLen: Integer);
var
  szClass, szCaption: array[0..50] of Char;
  szBufT: array[0..150] of Char;
begin
  if (hWnd = 0) then begin lstrcpy(szBuf, '(no window)'); Exit; end;
  if (IsWindow(hWnd) = FALSE) then begin lstrcpy(szBuf, '(invalid window)'); Exit; end;

  GetClassName(hWnd, szClass, chDIMOF(szClass));
  GetWindowText(hWnd, szCaption, chDIMOF(szCaption));    
  _wvsprintf(szBufT, '[%s] %s', [ DWORD(@szClass), DWORD(IfThen(szCaption[0] = #0, '(no caption)', @szCaption)) ]);

  lstrcpyn(szBuf, szBufT, nLen - 1);  
  szBuf[nLen - 1] := #0;
end;

type
  TWalkWindowTreeData = record
    hWndLB: HWND;      // Handle to the output list box
    hWndParent: HWND;  // Handle to the parent
    nLevel: Integer;   // Nesting depth
    nIndex: Integer;   // List box item index
    szBuf: array[0..99] of Char; // Output buffer
    iBuf: Integer;     // Index into szBuf
  end;

  // �ݹ�ö�ٴ��ڽṹ
procedure WalkWindowTreeRecurse(var WWT: TWalkWindowTreeData);
const
  nIndexAmount = 2;
var
  hWndChild: HWND;
  nBlank: Integer;
begin
  if (IsWindow(WWT.hWndParent) = FALSE) then Exit;

  // �������
  Inc(WWT.nLevel);

  // ǰ׺�ո�
  WWT.iBuf := 0;
  nBlank := WWT.nLevel * nIndexAmount;
  while (WWT.iBuf < nBlank) do
  begin
    WWT.szBuf[WWT.iBuf] := ' ';
    Inc(WWT.iBuf);
  end;

  // ������Ϣ
  CalcWndText(WWT.hWndParent, @WWT.szBuf[WWT.iBuf], chDIMOF(WWT.szBuf) - WWT.iBuf);

  // ��ӵ�ListBox
  WWT.nIndex := ListBox_AddString(WWT.hWndLB, WWT.szBuf);
  ListBox_SetItemData(WWT.hWndLB, WWT.nIndex, WWT.hWndParent);

  // �ݹ����
  hWndChild := GetFirstChild(WWT.hWndParent);
  while (hWndChild <> 0) do
  begin
    WWT.hWndParent := hWndChild;
    WalkWindowTreeRecurse(WWT);
    hWndChild := GetNextSibling(hWndChild);
  end;

  // ��μ���
  Dec(WWT.nLevel);
end;

  // ���ڽṹ -> ListBox
procedure WalkWindowTree(hWndLB, hWndParent: HWND);
var
  WWT: TWalkWindowTreeData;
begin
  WWT.hWndLB := hWndLB;
  WWT.hWndParent := hWndParent;
  WWT.nLevel := -1;

  WalkWindowTreeRecurse(WWT);
end;

  // WM_INITDIALOG
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
var
  hWndT: DWORD; // HWND
begin
  // ����ͼ��
  chSETDLGICONS(hWnd, IDI_LISLAB, IDI_LISLAB);

  // ���ù��
  SetClassLong(hWnd, GCL_HCURSOR, LoadCursor(0, IDC_UPARROW));

  // ��װʱ��
  g_uTimerId := SetTimer(hWnd, g_uTimerId, TIMER_DELAY, nil);

  // �����б�
  hWndT := GetDlgItem(hWnd, IDC_WNDFUNC);
  ComboBox_AddString(hWndT, 'SetFocus');
  ComboBox_AddString(hWndT, 'SetActiveWindow');
  ComboBox_AddString(hWndT, 'SetForegroundWnd');
  ComboBox_AddString(hWndT, 'BringWindowToTop');
  ComboBox_AddString(hWndT, 'SetWindowPos-TOP');
  ComboBox_AddString(hWndT, 'SetWindowPos-BTM');
  ComboBox_SetCurSel(hWndT, 0);

  // �����б�
  hWndT := GetDlgItem(hWnd, IDC_WNDS);
  ListBox_AddString(hWndT, '---> This dialog box <---');
  ListBox_SetItemData(hWndT, 0, hWnd);
  ListBox_SetCurSel(hWndT, 0);
  g_hWndNotepad := FindWindow('Notepad', nil);
  WalkWindowTree(hWndT, g_hWndNotepad);

  Result := TRUE;
end;

  // WM_DESTROY
procedure Dlg_OnDestroy(hWnd: HWND);
begin
  if (g_uTimerId <> 0) then KillTimer(hWnd, g_uTimerId);
end;

  // WM_COMMAND
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
var
  hWndT: DWORD; // HWND
  Rc: TRect;
begin
  case (id) of
    IDCANCEL: // �رճ���
      begin
        EndDialog(hWnd, 0);
      end;

    IDC_FUNCSTART: // ִ�ж���
      begin
        // ִ��ʱ��
        g_dwEventTime := GetTickCount() + 1000 * GetDlgItemInt(hWnd, IDC_DELAY, PBOOL(nil)^, FALSE);

        // ��������
        hWndT := GetDlgItem(hWnd, IDC_WNDS);
        g_hWndSubject := ListBox_GetItemData(hWndT, ListBox_GetCurSel(hWndT));

        // �������
        g_nEventId := ComboBox_GetCurSel(GetDlgItem(hWnd, IDC_WNDFUNC));

        // ��Ҫ����
        SetWindowText(GetDlgItem(hWnd, IDC_EVENTPENDING), 'Pending');
      end;

    IDC_THREADATTACH: // ��������
      begin
        AttachThreadInput(GetWindowThreadProcessId(g_hWndNotepad, nil), GetCurrentThreadId(), TRUE);
      end;

    IDC_THREADDETACH: // ȡ������
      begin
        AttachThreadInput(GetWindowThreadProcessId(g_hWndNotepad, nil), GetCurrentThreadId(), FALSE);
      end;

    IDC_SETCLIPRECT:  // ������귶Χ
      begin
        SetRect(rc, 0, 0, GetSystemMetrics(SM_CXSCREEN) div 2, GetSystemMetrics(SM_CYSCREEN) div 2);
        ClipCursor(@rc);
      end;

    IDC_REMOVECLIPRECT: // ȡ������
      begin
        ClipCursor(nil);
      end;

    IDC_HIDECURSOR: // �������
      begin
        ShowCursor(FALSE);
      end;

    IDC_SHOWCURSOR: // ��ʾ���
      begin
        ShowCursor(TRUE);
      end;

    IDC_INFINITELOOP: // ��ѭ��
      begin
        SetCursor(LoadCursor(0, IDC_NO));
        repeat Sleep(1) until FALSE;
      end;
  end;
end;

  // ǿ����ListBox׷���ַ���
procedure AddStr(hWndLB: HWND; const szBuf: PChar);
var
  nIndex: Integer;
begin
  repeat
    nIndex := ListBox_AddString(hWndLB, szBuf);
    if (nIndex = LB_ERR) then ListBox_DeleteString(hWndLB, 0) else Break;
  until FALSE;

  ListBox_SetCurSel(hWndLB, nIndex);
end;

  // WM_RBUTTONDOWN & WM_RBUTTONDBLCLK
function Dlg_OnRButtonDown(hWnd: HWND; fDoubleClick: BOOL; x, y: Integer; keyFlags: UINT): Integer;
var
  szBuf: array[0..100] of Char;
begin
  _wvsprintf(szBuf, 'Capture=%-3s, Msg=RButtonDown, DblClk=%-3s, x=%5d, y=%5d',
    [ DWORD(IfThen(GetCapture() = 0, 'No', 'Yes')), DWORD(IfThen(fDoubleClick, 'Yes', 'No')), x, y ]);
    
  AddStr(GetDlgItem(hWnd, IDC_MOUSEMSGS), szBuf);

  if (fDoubleClick = FALSE) then SetCapture(hWnd) else ReleaseCapture();

  Result := 0;
end;

  // WM_RBUTTONUP
function Dlg_OnRButtonUp(hWnd: HWND; x, y: Integer; keyFlags: UINT): Integer;
var
  szBuf: array[0..100] of Char;
begin
  _wvsprintf(szBuf, 'Capture=%-3s, Msg=RButtonUp,   x=%5d, y=%5d',
    [ DWORD(IfThen(GetCapture() = 0, 'No', 'Yes')), x, y ]);

  AddStr(GetDlgItem(hWnd, IDC_MOUSEMSGS), szBuf);

  Result := 0;
end;

  // WM_LBUTTONDOWN & WM_LBUTTONDBLCLK
function Dlg_OnLButtonDown(hWnd: HWND; fDoubleClick: BOOL; x, y: Integer; keyFlags: UINT): Integer;
var
  szBuf: array[0..100] of Char;
begin
  _wvsprintf(szBuf, 'Capture=%-3s, Msg=LButtonDown, DblClk=%-3s, x=%5d, y=%5d',
    [ DWORD(IfThen(GetCapture() = 0, 'No', 'Yes')), DWORD(IfThen(fDoubleClick, 'Yes', 'No')), x, y ]);

  AddStr(GetDlgItem(hWnd, IDC_MOUSEMSGS), szBuf);

  Result := 0;
end;

  // WM_LBUTTONUP
procedure Dlg_OnLButtonUp(hWnd: HWND; x, y: Integer; keyFlags: UINT);
var
  szBuf: array[0..100] of Char;
begin
  _wvsprintf(szBuf, 'Capture=%-3s, Msg=LButtonUp,   x=%5d, y=%5d',
    [ DWORD(IfThen(GetCapture() = 0, 'No', 'Yes')), x, y ]);

  AddStr(GetDlgItem(hWnd, IDC_MOUSEMSGS), szBuf);
end;

  // WM_MOUSEMOVE
procedure Dlg_OnMouseMove(hWnd: HWND; x, y: Integer; keyFlags: UINT);
var
  szBuf: array[0..100] of Char;
begin
  _wvsprintf(szBuf, 'Capture=%-3s, Msg=MouseMove,  x=%5d, y=%5d',
    [ DWORD(IfThen(GetCapture() = 0, 'No', 'Yes')), x, y ]);

  AddStr(GetDlgItem(hWnd, IDC_MOUSEMSGS), szBuf);
end;

  // WM_TIMER
procedure Dlg_OnTimer(hWnd: HWND; id: UINT);
var
  szBuf: array[0..100] of Char;
  hWndT: DWORD; // HWND
  Rc: TRect;  
begin
  // ����ؼ�
  CalcWndText(GetFocus(), szBuf, chDIMOF(szBuf));
  SetWindowText(GetDlgItem(hWnd, IDC_WNDFOCUS), szBuf);

  // ��겶׽
  CalcWndText(GetCapture(), szBuf, chDIMOF(szBuf));
  SetWindowText(GetDlgItem(hWnd, IDC_WNDCAPTURE), szBuf);

  // ���㴰��
  CalcWndText(GetActiveWindow(), szBuf, chDIMOF(szBuf));
  SetWindowText(GetDlgItem(hWnd, IDC_WNDACTIVE), szBuf);

  // ǰ̨����
  CalcWndText(GetForegroundWindow(), szBuf, chDIMOF(szBuf));
  SetWindowText(GetDlgItem(hWnd, IDC_WNDFOREGROUND), szBuf);

  // ��귶Χ
  GetClipCursor(Rc);
  _wvsprintf(szBuf, 'Left=%d, Top=%d, Right=%d, Bottom=%d', [ Rc.Left, Rc.Top, Rc.Right, Rc.Bottom ]);
  SetWindowText(GetDlgItem(hWnd, IDC_CLIPCURSOR), szBuf);

  // û�д�ִ�ж�������ִ��ʱ��δ��
  if (g_dwEventTime = 0) or (GetTickCount() < g_dwEventTime) then Exit;

  // �������
  case (g_nEventId) of
    0: g_hWndSubject := SetFocus(g_hWndSubject);

    1: g_hWndSubject := SetActiveWindow(g_hWndSubject);

    2: begin
         hWndT := GetForegroundWindow();
         SetForegroundWindow(g_hWndSubject);
         g_hWndSubject := hWndT;
       end;

    3: BringWindowToTop(g_hWndSubject);

    4: begin
         SetWindowPos(g_hWndSubject, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
         g_hWndSubject := 1;
       end;
       
    5: begin
         SetWindowPos(g_hWndSubject, HWND_BOTTOM, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
         g_hWndSubject := 1;
       end;
  end;

  // �������
  if (g_hWndSubject = 1) then
    SetWindowText(GetDlgItem(hWnd, IDC_PREVWND), 'Can''t tell')
  else begin
    CalcWndText(g_hWndSubject, szBuf, chDIMOF(szBuf));
    SetWindowText(GetDlgItem(hWnd, IDC_PREVWND), szBuf);
  end;

  // ִ�����
  g_hWndSubject := 0;
  g_nEventId := 0;
  g_dwEventTime := 0;
  SetWindowText(GetDlgItem(hWnd, IDC_EVENTPENDING), 'Executed');
end;

  // �Ի���ص�
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM):BOOL; stdcall;
begin
  Result := TRUE;
  
  case (uMsg) of
    WM_INITDIALOG:
      Result := SetDlgMsgResult(hWnd, LRESULT(Dlg_OnInitDialog(hWnd, wParam, lParam)));

    WM_DESTROY:
      Dlg_OnDestroy(hWnd);

    WM_COMMAND:
      Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));

    WM_MOUSEMOVE:
      Dlg_OnMouseMove(hWnd, LOWORD(lParam), HIWORD(lParam), wParam);

    WM_LBUTTONDOWN:
      Dlg_OnLButtonDown(hWnd, FALSE, LOWORD(lParam), HIWORD(lParam), wParam);

    WM_LBUTTONDBLCLK:
      Dlg_OnLButtonDown(hWnd, TRUE, LOWORD(lParam), HIWORD(lParam), wParam);

    WM_LBUTTONUP:
      Dlg_OnLButtonUp(hWnd, LOWORD(lParam), HIWORD(lParam), wParam);

    WM_RBUTTONDOWN:
      Dlg_OnRButtonDown(hWnd, FALSE, LOWORD(lParam), HIWORD(lParam), wParam);

    WM_RBUTTONDBLCLK:
      Dlg_OnRButtonDown(hWnd, TRUE, LOWORD(lParam), HIWORD(lParam), wParam);

    WM_RBUTTONUP:
      Dlg_OnRButtonUp(hWnd, LOWORD(lParam), HIWORD(lParam), wParam);

    WM_TIMER:
      Dlg_OnTimer(hWnd, wParam);

    else Result := FALSE;
  end;
end;

  // �������
begin
  chWARNIFUNICODEUNDERWIN95();
  DialogBox(HInstance, MakeIntResource(IDD_LISLAB), 0, @Dlg_Proc);
end.
