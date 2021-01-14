program SysInfo;

{$R 'SysInfo.res' 'SysInfo.rc'}

uses Windows, Messages;

const
  IDD_SYSINFO = 1; // ��ԴID
  IDI_SYSINFO = 6;
  IDC_PROCARCH       = 100; // �ؼ�ID
  IDC_PAGESIZE       = 101;
  IDC_MINAPPADDR     = 102;
  IDC_MAXAPPADDR     = 103;
  IDC_ACTIVEPROCMASK = 104;
  IDC_NUMOFPROCS     = 105;
  IDC_ALLOCGRAN      = 107;
  IDC_PROCLEVEL      = 108;
  IDC_PROCREV        = 109;
  PROCESSOR_ARCHITECTURE_INTEL = 0; // CPU�ṹ
  PROCESSOR_ARCHITECTURE_ALPHA = 2;
  PROCESSOR_ARCHITECTURE_IA64  = 6;
  PROCESSOR_ARCHITECTURE_ALPHA64 = 7;
  PROCESSOR_ARCHITECTURE_UNKNOWN = $FFFF;

  // ������ Windows 9x
var g_fWin9xIsHost: Bool = FALSE;

  // �򵥰�װ��ʽ��API
function wvsprintf(Output: PChar; Format: PChar; const Arg_List: array of Integer): Integer;
begin
  Result := Windows.wvsprintf(Output, Format, @Arg_List[Low(Arg_List)]);
end;

  // ��ֵת��ʽ���ַ���
function BigNumToString(lNum: DWORD; szBuf: PChar): PChar;
var
  szNum: array[0..100] of Char;
  nf: TNumberFmt;
begin
  wvsprintf(szNum, '%d', [ lNum ]);

  nf.NumDigits := 0;
  nf.LeadingZero := 0;
  nf.Grouping := 3;
  nf.lpDecimalSep := '.';
  nf.lpThousandSep := ',';
  nf.NegativeOrder := 0;
  GetNumberFormat(LOCALE_USER_DEFAULT, 0, szNum, @nf, szBuf, 100);

  Result := szBuf;
end;

  // �ڴ�������ʾCpu��Ϣ
procedure ShowCPUInfo(hWnd: HWND; wProcessorArchitecture, wProcessorLevel, wProcessorRevision: WORD);
var
  szCPUArch: array[0..64] of Char;
  szCPULevel: array[0..64] of Char;
  szCPURev: array[0..64] of Char;
begin
  szCPUArch := '(unknown)';
  szCPULevel := '(unknown)';
  szCPURev := '(unknown)';

  case (wProcessorArchitecture) of
    PROCESSOR_ARCHITECTURE_INTEL:
      begin
        lstrcpy(szCPUArch, 'Intel');

        case (wProcessorLevel) of
          3,
          4:begin
              wvsprintf(szCPULevel, '80%c86', [ wProcessorLevel + Ord('0') ]);
              if (not g_fWin9xIsHost) then
              begin
                wvsprintf(szCPURev, '%c%d',
                  [ HiByte(wProcessorRevision) + Ord('A'), LoByte(wProcessorRevision) ]);
              end;
            end;

          5:begin
              wvsprintf(szCPULevel, 'Pentium', []);
              if (not g_fWin9xIsHost) then
              begin
                wvsprintf(szCPURev, 'Model %d, Stepping %d',
                  [ HiByte(wProcessorRevision), LoByte(wProcessorRevision) ]);
              end;
            end;

          6:begin
              wvsprintf(szCPULevel, 'Pentium Pro or Pentium II', []);
              if (not g_fWin9xIsHost) then
              begin
                wvsprintf(szCPURev, 'Model %d, Stepping %d',
                  [ HiByte(wProcessorRevision), LoByte(wProcessorRevision) ]);
              end;
            end;
        end; // END: case (wProcessorLevel) of
      end;

    PROCESSOR_ARCHITECTURE_ALPHA:
      begin
        lstrcpy(szCPUArch, 'Alpha');
        wvsprintf(szCPULevel, '%d', [ wProcessorLevel ]);
        wvsprintf(szCPURev, 'Model %c, Pass %d',
          [ HiByte(wProcessorRevision) + Ord('A'), LoByte(wProcessorRevision) ]);
      end;

    PROCESSOR_ARCHITECTURE_IA64:
      begin
        lstrcpy(szCPUArch, 'IA-64');
        wvsprintf(szCPULevel, '%d', [ wProcessorLevel ]);
        wvsprintf(szCPURev, 'Model %c, Pass %d',
          [ HiByte(wProcessorRevision) + Ord('A'), LoByte(wProcessorRevision) ]);
      end;

    PROCESSOR_ARCHITECTURE_ALPHA64:
      begin
        lstrcpy(szCPUArch, 'Alpha64');
        wvsprintf(szCPULevel, '%d', [ wProcessorLevel ]);
        wvsprintf(szCPURev, 'Model %c, Pass %d',
          [ HiByte(wProcessorRevision) + Ord('A'), LoByte(wProcessorRevision) ]);
      end;

    PROCESSOR_ARCHITECTURE_UNKNOWN:
      begin
         wvsprintf(szCPUArch, 'Unknown', []);
      end

    else wvsprintf(szCPUArch, 'Unknown', []);
  end;

  SetDlgItemText(hWnd, IDC_PROCARCH, szCPUArch);
  SetDlgItemText(hWnd, IDC_PROCLEVEL, szCPULevel);
  SetDlgItemText(hWnd, IDC_PROCREV, szCPURev);
end;

  // WM_INITDIALOG��Ϣ����
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): Bool;
var
  sinf: TSystemInfo;
  szBuf: array[0..50] of Char;
begin
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_SYSINFO)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_SYSINFO)));

  GetSystemInfo(sinf);
  if (g_fWin9xIsHost) then sinf.wProcessorLevel := sinf.dwProcessorType div 100;
  ShowCPUInfo(hWnd, sinf.wProcessorArchitecture, sinf.wProcessorLevel, sinf.wProcessorRevision);

  SetDlgItemText(hWnd, IDC_PAGESIZE, BigNumToString(sinf.dwPageSize, szBuf));

  wvsprintf(szBuf, '%08lX', [ Integer(sinf.lpMinimumApplicationAddress) ]);
  SetDlgItemText(hWnd, IDC_MINAPPADDR, szBuf);

  wvsprintf(szBuf, '%08lX', [ Integer(sinf.lpMaximumApplicationAddress) ]);
  SetDlgItemText(hWnd, IDC_MAXAPPADDR, szBuf);
                       
  wvsprintf(szBuf, '0x%016I64X', [ Integer(sinf.dwActiveProcessorMask), 0 ]); // **
  SetDlgItemText(hWnd, IDC_ACTIVEPROCMASK, szBuf);

  SetDlgItemText(hWnd, IDC_NUMOFPROCS, BigNumToString(sinf.dwNumberOfProcessors, szBuf));

  SetDlgItemText(hWnd, IDC_ALLOCGRAN, BigNumToString(sinf.dwAllocationGranularity, szBuf));

  Result := TRUE;
end;

  // WM_COMMAND��Ϣ����
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
begin
  case (id) of
    IDCANCEL: EndDialog(hWnd, id);
  end;
end;

  // �Ի���ص�
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

    else Result := FALSE;
  end;
end;

  // �������
var
  vi: TOSVersionInfo;
begin
  vi.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(vi);
  g_fWin9xIsHost := (vi.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS);

  DialogBox(HInstance, MakeIntResource(IDD_SYSINFO), 0, @Dlg_Proc);
end.
