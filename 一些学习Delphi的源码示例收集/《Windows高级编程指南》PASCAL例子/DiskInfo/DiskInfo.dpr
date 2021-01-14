
// Module name: DiskInfo.C ->> DiskInfo.dpr
// Notices: Copyright (c) 1995-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

program DiskInfo;

{$R 'DiskInfo.res' 'DiskInfo.rc'}

uses
  Windows, Messages,
  Other in '..\Other.pas', CmnHdr in '..\CmnHdr.pas', WindowsX in '..\WindowsX.pas';

const
  IDD_DISKINFO   =    1;
  IDC_LOGDRIVES  =  100;
  IDC_DRIVETYPE  =  101;
  IDI_DISKINFO   =  101;
  IDC_VOLINFO    =  102;
  IDC_DISKINFO   =  103;

  // ��ʾ�߼���������Ϣ
procedure Dlg_FillDriveInfo(hWnd: HWND; const lpszRootPathName: PChar);
var
  p: PChar;
  szBuf: array[0..200] of Char;
  lpVolumeNameBuffer: array[0..200] of Char;
  lpFileSystemNameBuffer: array[0..50] of Char;
  dwVolumeSerialNumber, dwMaximumComponentLength, dwFileSystemFlags,
  dwSectorsPerCluster, dwBytesPerSector, dwFreeClusters, dwClusters: DWORD;
begin
  // ���������
  case GetDriveType(lpszRootPathName) of
    DRIVE_UNKNOWN:     p := 'Cannot be determined';
    DRIVE_NO_ROOT_DIR: p := 'Path does not exist';
    DRIVE_REMOVABLE:   p := 'Removable';
    DRIVE_FIXED:       p := 'Fixed';
    DRIVE_REMOTE:      p := 'Remote';
    DRIVE_CDROM:       p := 'CD-ROM';
    DRIVE_RAMDISK:     p := 'RAM disk';
    else p := 'Unknown';
  end;
  SetWindowText(GetDlgItem(hWnd, IDC_DRIVETYPE), p);

  // �߼�����Ϣ
  if GetVolumeInformation(lpszRootPathName,
        lpVolumeNameBuffer, chDIMOF(lpVolumeNameBuffer), // ����
        @dwVolumeSerialNumber, dwMaximumComponentLength, // ���к�
        dwFileSystemFlags,                               // ��־
        lpFileSystemNameBuffer, chDIMOF(lpFileSystemNameBuffer)) // �ļ�ϵͳ
     then
  begin
    _wvsprintf(szBuf, '%s'#13#10'%u'#13#10'%u'#13#10,
     [ DWORD(@lpVolumeNameBuffer), dwVolumeSerialNumber, dwMaximumComponentLength ]);

    if (dwFileSystemFlags and FS_CASE_IS_PRESERVED <> 0) then lstrcat(szBuf, 'FS_CASE_IS_PRESERVED');
    lstrcat(szBuf, #13#10);
    if (dwFileSystemFlags and FS_CASE_SENSITIVE <> 0) then lstrcat(szBuf, 'FS_CASE_SENSITIVE');
    lstrcat(szBuf, #13#10);
    if (dwFileSystemFlags and FS_UNICODE_STORED_ON_DISK <> 0) then lstrcat(szBuf, 'FS_UNICODE_STORED_ON_DISK');
    lstrcat(szBuf, #13#10);
    if (dwFileSystemFlags and FS_PERSISTENT_ACLS <> 0) then lstrcat(szBuf, 'FS_PERSISTENT_ACLS');
    lstrcat(szBuf, #13#10);
    if (dwFileSystemFlags and FS_FILE_COMPRESSION <> 0) then lstrcat(szBuf, 'FS_FILE_COMPRESSION');
    lstrcat(szBuf, #13#10);
    if (dwFileSystemFlags and FS_VOL_IS_COMPRESSED <> 0) then lstrcat(szBuf, 'FS_VOL_IS_COMPRESSED');
    lstrcat(szBuf, #13#10);

    lstrcat(szBuf, lpFileSystemNameBuffer);
  end else
  begin
    lstrcat(szBuf, 'NO VOLUME INFO');
  end;
  SetWindowText(GetDlgItem(hWnd, IDC_VOLINFO), szBuf);

  // �߼��̿ռ�
  if GetDiskFreeSpace(lpszRootPathName, dwSectorsPerCluster, dwBytesPerSector, dwFreeClusters, dwClusters) then
  begin
    _wvsprintf(szBuf, '%u'#13#10'%u'#13#10'%u'#13#10'%u',
      [ dwSectorsPerCluster, dwBytesPerSector, dwFreeClusters, dwClusters ]);
  end else
  begin
    lstrcat(szBuf, 'NO'#13#10'DISK'#13#10'SPACE'#13#10'INFO');
  end;
  SetWindowText(GetDlgItem(hWnd, IDC_DISKINFO), szBuf);
end;

  // WM_INITDIALOG
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
var
  dwNumBytesForDriveStrings: DWORD;
  pszAllDrives, pszDrive: PChar;
  szLogDrive: array[0..100] of Char;
  hWndCtl, nNumDrives, nDriveNum: Integer;
begin
  chSETDLGICONS(hWnd, IDI_DISKINFO, IDI_DISKINFO);

  // �����߼�������
  dwNumBytesForDriveStrings := GetLogicalDriveStrings(0, nil) * SizeOf(Char);
  pszAllDrives := HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY, dwNumBytesForDriveStrings);
  GetLogicalDriveStrings(dwNumBytesForDriveStrings div SizeOf(Char), pszAllDrives);

  // ��ӵ�ComboBox
  pszDrive := pszAllDrives;
  hWndCtl := GetDlgItem(hWnd, IDC_LOGDRIVES);
  nNumDrives := 0;
  while (pszDrive^ <> #0) do
  begin
    ComboBox_AddString(hWndCtl, pszDrive);
    Inc(nNumDrives);

    // ���������#0
    pszDrive := StrChr(pszDrive, #0) + 1;
  end;

  HeapFree(GetProcessHeap(), 0, pszAllDrives);

  // ��һ��Ӳ���̷�
  for nDriveNum := 0 to nNumDrives - 1 do
  begin
    ComboBox_GetLBText(hWndCtl, nDriveNum, szLogDrive);
    if (GetDriveType(szLogDrive) = DRIVE_FIXED) then Break;
  end;

  // û���ҵ��̶���
  if (nDriveNum = nNumDrives) then
  begin
    nDriveNum := 0;
    ComboBox_GetLBText(hWndCtl, 0, szLogDrive);
  end;

  // ��ʾѡ������Ϣ
  ComboBox_SetCurSel(hWndCtl, nDriveNum);
  Dlg_FillDriveInfo(hWnd, szLogDrive);

  Result := TRUE;
end;

  // WM_COMMAND
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
var
  szLogDrive: array[0..100] of Char;
begin
  case (id) of
    IDC_LOGDRIVES:
      begin
        if (codeNotify <> CBN_SELCHANGE) then Exit;
        ComboBox_GetText(hWndCtl, szLogDrive, chDIMOF(szLogDrive));
        Dlg_FillDriveInfo(hWnd, szLogDrive);
      end;

    IDCANCEL:
      begin
        EndDialog(hwnd, id);
      end;
  end;
end;

  // �Ի���ص�
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

    else Result := FALSE;
  end;
end;

  // �������
begin
  chWARNIFUNICODEUNDERWIN95();
  DialogBox(HInstance, MakeIntResource(IDD_DISKINFO), 0, @Dlg_Proc);
end.
