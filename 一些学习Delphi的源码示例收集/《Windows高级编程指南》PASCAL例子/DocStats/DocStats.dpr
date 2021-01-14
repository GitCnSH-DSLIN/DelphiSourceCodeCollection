
// Module name: DocStats.C ->> DocStats.dpr
// Notices: Copyright (c) 1995-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

program DocStats;

{$R 'DocStats.res' 'DocStats.rc'}

uses
  Windows, Messages, CommDlg,
  Other in '..\Other.pas', CmnHdr in '..\CmnHdr.pas', WindowsX in '..\WindowsX.pas';

const
  g_szModName = 'DocStats';
  IDD_DOCSTATS    =     1;
  IDC_FILESELECT  =   101;
  IDI_DOCSTATS    =   102;
  IDC_FILENAME    =  1000;
  IDC_DODOCSTATS  =  1001;
  IDC_NUMLETTERS  =  1002;
  IDC_NUMWORDS    =  1003;
  IDC_NUMLINES    =  1004;

const
  STAT_LETTERS = 0;
  STAT_WORDS   = 1;
  STAT_LINES   = 2;
  STAT_FIRST = STAT_LETTERS;
  STAT_LAST  = STAT_LINES;

type
  TStatType = STAT_FIRST..STAT_LAST;

var
  g_hEventsDataReady: array[TStatType] of THandle; // �����Ѿ�׼����
  g_hEventsProcIdle: array[TStatType] of THandle;  // �����Ѿ������
  g_bFileBuf: array[0..1023] of Byte; // �ļ����ݻ�����
  g_dwNumBytesInBuf: DWORD;           // ���������ݳ���

  // �����߳�
function StatThreadFunc(StatType: TStatType): Integer;
var
  dwByteIndex: Integer;
  bByte: Byte;
  fInWord, fIsWordSep: BOOL;
begin
  Result := 0;
  fInWord := FALSE;

  repeat
    WaitForSingleObject(g_hEventsDataReady[StatType], INFINITE); // �ȴ�����

    case (StatType) of
      STAT_LETTERS: // ��ĸ
        for dwByteIndex := 0 to g_dwNumBytesInBuf - 1 do
        begin
          bByte := g_bFileBuf[dwByteIndex];
          if IsCharAlpha(Char(bByte)) then Inc(Result);
        end;

      STAT_WORDS: // ����
        for dwByteIndex := 0 to g_dwNumBytesInBuf - 1 do
        begin
          bByte := g_bFileBuf[dwByteIndex];
          fIsWordSep := StrChr(' '#9#13#10, Char(bByte)) <> nil; // �Ƿ�ָ���
          if (fInWord = FALSE) and (fIsWordSep = FALSE) then // �����µĵ���
          begin
            Inc(Result);
            fInWord := TRUE; // ��ǰ���ڵ�����
          end else
            if (fInWord) and (fIsWordSep) then fInWord := FALSE; // �������ʺ��һ���ָ���
        end;

      STAT_LINES: // ��
        for dwByteIndex := 0 to g_dwNumBytesInBuf - 1 do
        begin
          bByte := g_bFileBuf[dwByteIndex];
          if (bByte = 13) then Inc(Result);
        end;
    end;

    SetEvent(g_hEventsProcIdle[StatType]); // �������
  until (g_dwNumBytesInBuf = 0);
end;

  // ͳ���ĵ�
function Doc_Stats(const pszPathname: PChar; var pdwNumLetters, pdwNumWords, pdwNumLines: DWORD): BOOL;
var
  hFile: THandle;
  hThreads: array[TStatType] of THandle;
  dwThreadID: DWORD;
  StatType: TStatType;
begin
  Result := FALSE;
  pdwNumLetters := 0;
  pdwNumWords := 0;
  pdwNumLines := 0;

  // ��ֻ����ʽ���ļ�
  hFile := CreateFile(pszPathname, GENERIC_READ, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if (hFile = INVALID_HANDLE_VALUE) then
  begin
    chMB('File could not be opened ', g_szModName);
    Exit;
  end;

  // �����¼�������߳�
  for StatType := STAT_FIRST to STAT_LAST do
  begin
    g_hEventsDataReady[StatType] := CreateEvent(nil, FALSE, FALSE, nil); // ���ݻ�δ׼����
    g_hEventsProcIdle[StatType] := CreateEvent(nil, FALSE, TRUE, nil);   // û������δ����
    hThreads[StatType] := BeginThread(nil, 0, @StatThreadFunc, Pointer(StatType), 0, dwThreadID);
  end;

  // ���������ļ�������
  repeat
    // �ȴ��������
    WaitForMultipleObjects(STAT_LAST - STAT_FIRST + 1, @g_hEventsProcIdle, TRUE, INFINITE);

    // ������������
    ReadFile(hFile, g_bFileBuf, chDIMOF(g_bFileBuf), g_dwNumBytesInBuf, nil);

    // ���Ѵ����߳�
    for StatType := STAT_FIRST to STAT_LAST do SetEvent(g_hEventsDataReady[StatType]);
  until (g_dwNumBytesInBuf = 0);

  // �ر��ļ����
  CloseHandle(hFile);

  // �ȴ��߳̽���
  WaitForMultipleObjects(STAT_LAST - STAT_FIRST + 1, @hThreads, TRUE, INFINITE);

  // ȡ��ͳ�ƽ��
  GetExitCodeThread(hThreads[STAT_LETTERS], pdwNumLetters);
  GetExitCodeThread(hThreads[STAT_WORDS], pdwNumWords);
  GetExitCodeThread(hThreads[STAT_LINES], pdwNumLines);

  // ����ں˶���
  for StatType := STAT_FIRST to STAT_LAST do
  begin
    CloseHandle(hThreads[StatType]);
    CloseHandle(g_hEventsDataReady[StatType]);
    CloseHandle(g_hEventsProcIdle[StatType]);
  end;

  Result := TRUE;
end;

  // WM_INITDIALOG
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  chSETDLGICONS(hWnd, IDI_DOCSTATS, IDI_DOCSTATS);
  EnableWindow(GetDlgItem(hWnd, IDC_DODOCSTATS), FALSE);
  Result := TRUE;
end;

  // WM_COMMAND
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
var
  szPathname: array[0..MAX_PATH] of Char;
  ofn: TOpenFilename;
  dwNumLetters, dwNumWords, dwNumLines: DWORD;
begin
  case (id) of
    IDC_FILENAME: // �ļ���Edit
      begin
        EnableWindow(GetDlgItem(hWnd, IDC_DODOCSTATS), Edit_GetTextLength(hWndCtl) > 0);
      end;

    IDC_FILESELECT: // ѡ���ļ�
      begin
        chINITSTRUCT(ofn, SizeOf(ofn), TRUE);
        ofn.hWndOwner := hWnd;
        ofn.lpstrFile := szPathname;
        ofn.lpstrFile[0] := #0;
        ofn.nMaxFile := chDIMOF(szPathname);
        ofn.lpstrTitle := 'Select file for reversing';
        ofn.Flags := OFN_EXPLORER or OFN_FILEMUSTEXIST;
        GetOpenFileName(ofn);

        SetDlgItemText(hWnd, IDC_FILENAME, ofn.lpstrFile);
        SetFocus(GetDlgItem(hWnd, IDC_DODOCSTATS));
      end;

    IDC_DODOCSTATS: // ͳ��
      begin
        GetDlgItemText(hWnd, IDC_FILENAME, szPathname, chDIMOF(szPathname));
        if Doc_Stats(szPathname, dwNumLetters, dwNumWords, dwNumLines) then
        begin
          SetDlgItemInt(hWnd, IDC_NUMLETTERS, dwNumLetters, FALSE);
          SetDlgItemInt(hWnd, IDC_NUMWORDS, dwNumWords, FALSE);
          SetDlgItemInt(hWnd, IDC_NUMLINES, dwNumLines, FALSE);
        end;
      end;

    IDCANCEL: // �˳�����
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

  // ���߳����
begin
  chWARNIFUNICODEUNDERWIN95();
  DialogBox(HInstance, MakeIntResource(IDD_DOCSTATS), 0, @Dlg_Proc);
end.
