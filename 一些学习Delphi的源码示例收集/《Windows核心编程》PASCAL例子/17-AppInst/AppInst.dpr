program AppInst;

{$R 'AppInst.res' 'AppInst.rc'}

uses
  Windows, Messages;

const
  IDD_APPINST =   1; // ģ��ID
  IDI_APPINST = 101; // ͼ��ID
  IDC_COUNT   = 100; // �ؼ�ID

var
  g_uMsgAppInstCountUpdate: DWORD = INVALID_ATOM; // ��ע����Ϣ
  g_plApplicationInstances: PLongInt = nil;       // ����ڵ�ַ

  // ����WM_INITDIALOG
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
begin
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_APPINST)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_APPINST)));

  PostMessage(HWND_BROADCAST, g_uMsgAppInstCountUpdate, 0, 0); // ֪ͨ����ʵ��, �����ѱ仯

  Result := TRUE;
end;

  // ����WM_COMMAND
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; codeNotify: UINT);
begin
  if (id = IDCANCEL) then EndDialog(hWnd, id);
end;

  // �Ի�����Ϣ�ص�
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM):BOOL; stdcall;
begin
  case (uMsg) of
    WM_INITDIALOG:
      begin
        Result := SetWindowLong(hWnd, DWL_MSGRESULT, Longint(Dlg_OnInitDialog(hWnd, wParam, lParam))) <> 0;
      end;

    WM_COMMAND:
      begin
        Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));
        Result := TRUE;
      end

    else
      if (uMsg = g_uMsgAppInstCountUpdate) then
      begin
        SetDlgItemInt(hWnd, IDC_COUNT, g_plApplicationInstances^, FALSE); // ��ʾ���¼���ֵ
        Result := TRUE;
      end else
        Result := FALSE;
  end;
end;

  // �ȽϽ����ַ�����
function CompareSectionName(S1, S2: PByte): BOOL;
begin
  while (S1^ <> 0) and (S2^ <> 0) and (S1^ <> S2^) do
  begin
    Inc(S1);
    Inc(S2);
  end;
  Result := (S1^ = S2^); // or (S2^ = 0)
end;

  // Ѱ�ҷ��������Ľ�
function SectionVirualAddress(const Name: string; MiniSize, Character: DWORD): Pointer;
var
  BasePt: DWord;
  TempPt: PByte;
  NumSec: Word;
begin
  Result := nil;

  // EXE ӳ�����ַ
  BasePt := GetModuleHandle(nil);
  if (BasePt = 0) then Exit else TempPt := PByte(BasePt);

  // Ч�� DOS �ļ�ͷ
  if (PImageDosHeader(TempPt).e_magic <> IMAGE_DOS_SIGNATURE) then Exit;
  Inc(TempPt, PImageDosHeader(TempPt)._lfanew);

  // Ч�� PE �ļ�ͷ
  if (PImageNtHeaders(TempPt).Signature <> IMAGE_NT_SIGNATURE) then Exit;
  NumSec := PImageNtHeaders(TempPt).FileHeader.NumberOfSections;

  // ��λ���ڱ�����
  Inc(TempPt, SizeOf(DWORD) + SizeOf(TImageFileHeader) +
    PImageNtHeaders(TempPt).FileHeader.SizeOfOptionalHeader);

  // ��������, Ѱ�ҷ��������Ľ�
  while (NumSec <> 0) do
  begin
    if ( CompareSectionName(@PImageSectionHeader(TempPt).Name[0], @Name[1]) ) and    // ����
       ( PImageSectionHeader(TempPt).Characteristics and Character = Character ) and // ����
       ( PImageSectionHeader(TempPt).Misc.VirtualSize >= MiniSize ) then             // ��С
    begin
      Result := Pointer(BasePt + PImageSectionHeader(TempPt).VirtualAddress);
      Exit;
    end;

    Dec(NumSec);
    Inc(PImageSectionHeader(TempPt), 1);
  end;
end;

  // �������
begin
  // ����, �ܸ�л DelphiBBS �ϵ������Ǹ���İ���, ��ϸ�������
  // http://www.delphibbs.com/delphibbs/dispq.asp?lid=3088031

  // ����Ϊֹ, ��û�ҵ�����ɹ�����Delphi����ʱ�����½ڵķ���,
  // �����֪��, ϣ���ܽ���, ��ʤ�м�, ����: Liu_mazi@126.com

  // Ŀǰ�õ���һ�������ѵİ취, ������֮������PE�༭�����޸�,
  // �ֹ���EXE����һ����Ϊ'Shared'�Ĵ��������ԵĽ�, ��VSize=4,
  // ����������ʱ, �᳢��Ѱ����������Ľ�, �������洢ȫ������

  // ��λ�½�
  g_plApplicationInstances := SectionVirualAddress('Shared', 4,
    IMAGE_SCN_MEM_SHARED or IMAGE_SCN_MEM_READ or IMAGE_SCN_MEM_WRITE);
  if (g_plApplicationInstances = nil) then
  begin
    MessageBox(0, '��λ�����ʧ��', 'AppInst', MB_OK);
    Exit;
  end;

  // ע����Ϣ
  g_uMsgAppInstCountUpdate := RegisterWindowMessage('MsgAppInstCountUpdate');

  // ���Ӽ���
  InterlockedExchangeAdd(g_plApplicationInstances, 1);

  // ��ʾ����
  DialogBox(HInstance, MakeIntResource(IDD_APPINST), 0, @Dlg_Proc);

  // ���ټ���
  InterlockedExchangeAdd(g_plApplicationInstances, -1);

  // �㲥֪ͨ
  PostMessage(HWND_BROADCAST, g_uMsgAppInstCountUpdate, 0, 0);
end.
