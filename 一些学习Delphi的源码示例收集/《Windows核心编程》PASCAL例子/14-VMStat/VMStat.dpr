program VMStat;

{$R 'VMStat.res' 'VMStat.rc'}

uses Windows, Messages;

const
  IDD_VMSTAT = 1;   // �Ի���ID
  IDI_VMSTAT = 101; // ͼ��ID
  IDC_DATA = 1000;  // �ؼ�ID
  IDT_UPDATE = 1;   // ��ʱ��ID

  // WM_INITDIALOG��Ϣ����
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  // �޸ĶԻ���ͼ��
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_VMSTAT)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_VMSTAT)));

  // ��װˢ�¶�ʱ��
  SetTimer(hWnd, IDT_UPDATE, 1 * 1000, nil);

  // ִ��һ��OnTimer
  SendMessage(hWnd, WM_TIMER, IDT_UPDATE, 0);
  
  Result := TRUE;
end;

  // WM_TIMER��Ϣ����
procedure Dlg_OnTimer(hWnd: HWND; id: UINT);
var
  ms: TMemoryStatus;
  szData: array[0..512] of Char;
  PfList: array[0..11] of DWORD;
begin
  // ��ǰ�ڴ���Ϣ
  ms.dwLength := SizeOf(TMemoryStatus);
  GlobalMemoryStatus(ms);

  // ��ʽ���ַ���
  ZeroMemory(@PfList, SizeOf(PfList));
  PfList[0] := ms.dwMemoryLoad;
  PfList[1] := ms.dwTotalPhys;
  PfList[2] := ms.dwAvailPhys;
  PfList[4] := ms.dwTotalPageFile;
  PfList[6] := ms.dwAvailPageFile;
  PfList[8] := ms.dwTotalVirtual;
  PfList[10] := ms.dwAvailVirtual;
  wvsprintf(szData,
    '%d'#13#10'%d'#13#10'%I64d'#13#10'%I64d'#13#10'%I64d'#13#10'%I64d'#13#10'%I64d',
    @PfList);

  // �������ֿؼ�
  SetDlgItemText(hWnd, IDC_DATA, szData);
end;

  // WM_COMMAND��Ϣ����
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
begin
  if (id = IDCANCEL) then
  begin
    KillTimer(hWnd, IDT_UPDATE);
    EndDialog(hWnd, id);
  end;
end;

  // �Ի���ص�����
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  case (uMsg) of
    WM_INITDIALOG:
      begin
        Result := SetWindowLong(hWnd, DWL_MSGRESULT,
          Longint(Dlg_OnInitDialog(hWnd, wParam, lParam))) <> 0;
      end;

    WM_COMMAND:
      begin
        Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));
        Result := TRUE;
      end;

    WM_TIMER:
      begin
        Dlg_OnTimer(hWnd, wParam);
        Result := TRUE;        
      end;
      
    else Result := FALSE;
  end;
end;

  // �������߳����
begin
  DialogBox(HInstance, MakeIntResource(IDD_VMSTAT), 0, @Dlg_Proc);
end.
