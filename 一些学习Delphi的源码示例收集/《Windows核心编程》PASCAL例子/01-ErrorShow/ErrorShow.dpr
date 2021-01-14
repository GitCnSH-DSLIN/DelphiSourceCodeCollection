program ErrorShow;

{$R 'ErrorShow.res' 'ErrorShow.rc'}

uses
  Windows, Messages;

const
  g_szAppName = 'Error Show';
  ESM_POKECODEANDLOOKUP = WM_USER + 100; // �Զ�����Ϣ(�����ύ�������)
  IDD_ERRORSHOW = 101;  // �Ի���ģ����ԴID
  IDI_ERRORSHOW = 102;  // ͼ����ԴID(�˴����Ի���ͼ��)
  IDC_ERRORCODE = 1000; // �Ի����ӿؼ�ID..
  IDC_ERRORTEXT = 1001;
  IDC_ALWAYSONTOP = 1002;

  // �Ի���WM_INITDIALOG��Ϣ����
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  // ����ͼ��
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_ERRORSHOW)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_ERRORSHOW)));

  // ���Ƴ���
  SendMessage(GetDlgItem(hWnd, IDC_ERRORCODE), EM_LIMITTEXT, 5, 0);

  // �������
  SendMessage(hWnd, ESM_POKECODEANDLOOKUP, lParam, 0);

  // ���ܽ���
  Result := TRUE;
end;

  // �Ի���WM_COMMAND��Ϣ����
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
    // �˺���ת����C���Ժ궨��: #define MAKELANGID(p, s) ((((WORD) (s)) << 10) | (WORD) (p))
  function MakeLangID(p, s: Word): DWORD;
  begin
    Result := (s shl 10) or p;
  end;
var
  dwError: DWORD;
  hLocal: THandle; // HLOCAL
  fOk: DWORD; // BOOL
  hDll: HMODULE;
begin
  case (id) of // �ӿؼ�(��˵���)ID
    IDCANCEL:
      begin
        EndDialog(hWnd, id);
      end;

    IDC_ALWAYSONTOP:
      begin
        if (IsDlgButtonChecked(hWnd, IDC_ALWAYSONTOP) = BST_CHECKED) then
          SetWindowPos(hWnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE)
        else
          SetWindowPos(hWnd, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
      end;

    IDC_ERRORCODE:
      begin
        EnableWindow(GetDlgItem(hWnd, IDOK), GetWindowTextLength(hWndCtl) > 0);
      end;

    IDOK:
      begin
        // ȡ���������
        dwError := GetDlgItemInt(hWnd, IDC_ERRORCODE, PBOOL(nil)^, FALSE);

        // ���������ڴ�(����ϵͳ����)
        hLocal := 0;

        // ȡ����������
        fOk := FormatMessage(
          FORMAT_MESSAGE_FROM_SYSTEM or FORMAT_MESSAGE_ALLOCATE_BUFFER,
          nil, dwError, MakeLangID(LANG_CHINESE, SUBLANG_CHINESE_SIMPLIFIED),
          PChar(@hLocal), 0, nil);

        // ��������ʧ��
        if (fOk = 0) then
        begin
          // ������ش���?
          hDll := LoadLibraryEx('NetMsg.dll', 0, DONT_RESOLVE_DLL_REFERENCES);
          if (hDll <> 0) then
          begin
            FormatMessage(
              FORMAT_MESSAGE_FROM_HMODULE or FORMAT_MESSAGE_FROM_SYSTEM,
              Pointer(hDll), dwError, MakeLangID(LANG_CHINESE, SUBLANG_CHINESE_SIMPLIFIED),
              PChar(@hLocal), 0, nil);
            FreeLibrary(hDll);
          end;
        end;

        // ��ȷ�����ڴ�
        if (hLocal <> 0) then
        begin
          SetDlgItemText(hWnd, IDC_ERRORTEXT, PChar(LocalLock(hLocal)));
          LocalFree(hLocal);
        end else
        begin
          SetDlgItemText(hWnd, IDC_ERRORTEXT, 'Error number not found.');
        end;
      end;
  end; // END: case (id) of
end;

  // �Ի�����Ϣ����ص�
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM):BOOL; stdcall;
begin
  case (uMsg) of // ��ϢID
    WM_INITDIALOG:
      begin
        Result := BOOL(SetWindowLong(hWnd, DWL_MSGRESULT, Longint(Dlg_OnInitDialog(hWnd, wParam, lParam))));
      end;

    WM_COMMAND:
      begin
        Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));
        Result := TRUE;
      end;

    ESM_POKECODEANDLOOKUP:
      begin
        SetDlgItemInt(hWnd, IDC_ERRORCODE, wParam, FALSE);
        PostMessage(hWnd, WM_COMMAND, MakeWParam(IDOK, BN_CLICKED), GetDlgItem(hWnd, IDOK));
        SetForegroundWindow(hWnd);
        Result := TRUE;
      end;

    else Result := FALSE;
  end;
end;

  // �ַ���ת����
function StrToInt(const S: string): Integer;
var
  P: PByte;
begin
  Result := 0;
  P := @S[1];
  while (P^ <> $00) do
  begin
    if (P^ > $39) or (P^ < $30) then
    begin
      Result := 0;
      Exit;
    end else
    begin
      Result := Result * 10 + (P^ - $30);
      Inc(P);
    end;
  end;
end;

  // �������
var
  hWnd: LongWord; // HWND
begin
  // ����Ѵ��ڳ���ʵ��, �����ύ�µĴ������, ������ģ̬�Ի���
  hWnd := FindWindow('#32770', 'Error Show');
  if (IsWindow(hWnd) = FALSE) then
    DialogBoxParam(HInstance, MakeIntResource(IDD_ERRORSHOW), 0, @Dlg_Proc, StrToInt(Paramstr(1)))
  else
    SendMessage(hWnd, ESM_POKECODEANDLOOKUP, StrToInt(Paramstr(1)), 0);
end.



