program MMFShare;

{$R 'MMFShare.res' 'MMFShare.rc'}

uses Windows, Messages;

const
  IDD_MMFSHARE   = 1;
  IDI_MMFSHARE   = 102;
  IDC_DATA       = 100;
  IDC_CREATEFILE = 101;
  IDC_OPENFILE   = 102;
  IDC_CLOSEFILE  = 103;

  // WM_INITDIALOG ����
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_MMFSHARE)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_MMFSHARE)));

  SetWindowText(GetDlgItem(hWnd, IDC_DATA), 'Some test data');
  EnableWindow(GetDlgItem(hWnd, IDC_CLOSEFILE), FALSE);

  Result := TRUE;
end;

  // WM_COMMAND ����
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
const {$J+}
  s_hFileMap: THandle = 0; {$J-}
var
  pView: Pointer;
  hFileMapT: THandle;
begin
  case (id) of
    IDCANCEL:
      begin
        EndDialog(hWnd, id);
      end;

    IDC_CREATEFILE:
      begin
        // ���ǰ�ť����֪ͨ
        if (codeNotify <> BN_CLICKED) then Exit;

        // �����ڴ�ӳ���ļ�
        s_hFileMap := CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, 4 * 1024, 'MMFSharedData');

        // ����(���)�ɹ�
        if (s_hFileMap <> 0) then
        begin
          // �Ƿ�֮ǰ�Ѵ���
          if (GetLastError() = ERROR_ALREADY_EXISTS) then
          begin
            MessageBox(0, 'Mapping already exists - not created.', 'MMFShare', MB_OK);
            CloseHandle(s_hFileMap);
          end else
          begin
            // �����ɹ� ^^

            // ӳ�����ڴ�ռ�
            pView := MapViewOfFile(s_hFileMap, FILE_MAP_READ or FILE_MAP_WRITE, 0, 0, 0);
            
            if (pView <> nil) then
            begin
              // Edit -> MMF
              GetWindowText(GetDlgItem(hWnd, IDC_DATA), pView, 4 * 1024);

              // ȡ���ڴ�ӳ��
              UnmapViewOfFile(pView);

              // �������ٽ���
              EnableWindow(hWndCtl, FALSE);

              // ����ر��ļ�
              EnableWindow(GetDlgItem(hWnd, IDC_CLOSEFILE), TRUE);
            end else
            begin
              MessageBox(0, 'Can'#39't map view of file.', 'MMFShare', MB_OK);
            end;
          end;
        end else
        begin
          MessageBox(0, 'Can'#39't create file mapping.', 'MMFShare', MB_OK);
        end;
      end;

    IDC_CLOSEFILE:
      begin
        // ���ǰ�ť����֪ͨ
        if (codeNotify <> BN_CLICKED) then Exit;

        // �ر��ڴ�ӳ���ļ�
        if CloseHandle(s_hFileMap) then
        begin
          EnableWindow(GetDlgItem(hWnd, IDC_CREATEFILE), TRUE);
          EnableWindow(hWndCtl, FALSE);
        end;
      end;

    IDC_OPENFILE:
      begin
        // ���ǰ�ť����֪ͨ
        if (codeNotify <> BN_CLICKED) then Exit;

        // ���Ѵ��ڵĶ���
        hFileMapT := OpenFileMapping(FILE_MAP_READ or FILE_MAP_WRITE, FALSE, 'MMFSharedData');

        if (hFileMapT <> 0) then
        begin
          // ӳ�����ڴ�ռ�
          pView := MapViewOfFile(hFileMapT, FILE_MAP_READ or FILE_MAP_WRITE, 0, 0, 0);

          // ӳ���Ƿ�ɹ� ?
          if (pView <> nil) then
          begin
            // MMF -> Edit
            SetWindowText(GetDlgItem(hWnd, IDC_DATA), pView);

            // ȡ���ڴ�ӳ��
            UnmapViewOfFile(pView);
          end else
          begin
            MessageBox(0, 'Can'#39't map view.', 'MMFShare', MB_OK);
          end;

          CloseHandle(hFileMapT);
        end else
        begin
          MessageBox(0, 'Can'#39't open mapping.', 'MMFShare', MB_OK);
        end;
      end;
  end; // END case of
end;

  // �Ի�����Ϣ�ص�
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  Result := FALSE;

  case (uMsg) of
    WM_INITDIALOG:
      Result := SetWindowLong(hWnd,
        DWL_MSGRESULT, Longint(Dlg_OnInitDialog(hWnd, wParam, lParam))) <> 0;

    WM_COMMAND:
      Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));
  end;
end;

  // �������߳����
begin
  DialogBox(HInstance, MakeIntResource(IDD_MMFSHARE), 0, @Dlg_Proc);
end.
