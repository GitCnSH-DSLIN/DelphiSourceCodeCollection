program VMAlloc;

{$R 'VMAlloc.res' 'VMAlloc.rc'}

uses Windows, Messages;

const
  IDD_VMALLOC =   1; // ��ԴID ~
  IDI_VMALLOC = 101;
  IDC_PAGESIZE       = 100; // �ؼ�ID ~
  IDC_RESERVE        = 101;
  IDC_INDEXTEXT      = 102;
  IDC_INDEX          = 103;
  IDC_USE            = 105;
  IDC_CLEAR          = 106;
  IDC_GARBAGECOLLECT = 107;
  IDC_MEMMAP         = 108;
  MAX_SOMEDATA = 50; // ���鳤��

type
  TSomeData = packed record // �����Ա
    fInUse: BOOL;
    bOtherData: array[0..2048 - SizeOf(BOOL) - 1] of Byte;
  end;
  TDataArray = array[0..MAX_SOMEDATA - 1] of TSomeData;
  PDataArray = ^TDataArray;

var
  g_uPageSize: UINT = 0; // ҳ�泤��
  g_pSomeData: PDataArray = nil; // �����ַ
  g_rcMemMap: TRect; // ��ͼ��Χ

  // WM_INITDIALOG��Ϣ����
function Dlg_OnInitDialog(hWnd, hWndFocus: HWND; lParam: LPARAM): BOOL;
var
  szBuf: array[0..10] of Char;
  kSize: DWORD;
begin
  SendMessage(hWnd, WM_SETICON, ICON_BIG, LoadIcon(HInstance, MakeIntResource(IDI_VMALLOC)));
  SendMessage(hWnd, WM_SETICON, ICON_SMALL, LoadIcon(HInstance, MakeIntResource(IDI_VMALLOC)));

  EnableWindow(GetDlgItem(hWnd, IDC_INDEXTEXT), FALSE);
  EnableWindow(GetDlgItem(hWnd, IDC_INDEX), FALSE);
  EnableWindow(GetDlgItem(hWnd, IDC_USE), FALSE);
  EnableWindow(GetDlgItem(hWnd, IDC_CLEAR), FALSE);
  EnableWindow(GetDlgItem(hWnd, IDC_GARBAGECOLLECT), FALSE);

  // ��ͼ��Χ
  GetWindowRect(GetDlgItem(hWnd, IDC_MEMMAP), g_rcMemMap);
  MapWindowPoints(0, hWnd, g_rcMemMap, 2);
  DestroyWindow(GetDlgItem(hWnd, IDC_MEMMAP));

  kSize := g_uPageSize div 1024;
  wvsprintf(szBuf, '%d KB', @kSize);
  SetDlgItemText(hWnd, IDC_PAGESIZE, szBuf);

  SetDlgItemInt(hWnd, IDC_INDEX, 0, FALSE);

  Result :=TRUE;
end;

  // WM_DESTROY��Ϣ����
procedure Dlg_OnDestroy(hWnd: HWND);
begin
  if (g_pSomeData <> nil) then VirtualFree(g_pSomeData, 0, MEM_RELEASE);
end;

  // ���ύ��������ҳ��
procedure GarbageCollect(pvBase: Pointer; dwNum, dwStructSize: DWORD);
var
  uMaxPages, uPage, uIndex, uIndexLast: UINT;
  fAnyAllocsInThisPage: BOOL;
  mbi: TMemoryBasicInformation;
begin
  uMaxPages := dwNum * dwStructSize div g_uPageSize; // ����: ����������� ??
  uPage := 0;
  
  while (uPage < uMaxPages) do // ������ҳ
  begin
    fAnyAllocsInThisPage := FALSE;
    uIndex := uPage * g_uPageSize div dwStructSize;
    uIndexLast := uIndex + g_uPageSize div dwStructSize;

    while (uIndex < uIndexLast) do // ������Ա
    begin
      // ��ѯ��uIndex���ṹ�Ƿ���ʹ��
      VirtualQuery(@g_pSomeData[uIndex], mbi, SizeOf(mbi)); // **
      fAnyAllocsInThisPage := (mbi.State = MEM_COMMIT) and PBOOL(DWORD(pvBase) + dwStructSize * uIndex)^;
      if (fAnyAllocsInThisPage) then Break;

      Inc(uIndex);
    end;

    // ��ҳû���κ���Ա��ʹ��, ���ύ
    if (not fAnyAllocsInThisPage) then
      VirtualFree(@g_pSomeData[uIndexLast - 1], dwStructSize, MEM_DECOMMIT);

    Inc(uPage);
  end;
end;

  // WM_COMMAND��Ϣ����
procedure Dlg_OnCommand(hWnd: HWND; id: Integer; hWndCtl: HWND; CodeNotify: UINT);
var
  uIndex: UINT;
  mbi: TMemoryBasicInformation;
  fOk: BOOL;
begin
  case (id) of
    IDCANCEL:
      begin
        EndDialog(hWnd, id);
      end;

    IDC_RESERVE:
      begin
        // �������������ڴ�
        g_pSomeData := VirtualAlloc(nil, MAX_SOMEDATA * SizeOf(TSomeData), MEM_RESERVE, PAGE_READWRITE);

        EnableWindow(GetDlgItem(hWnd, IDC_RESERVE), FALSE);
        EnableWindow(GetDlgItem(hWnd, IDC_INDEXTEXT), TRUE);
        EnableWindow(GetDlgItem(hWnd, IDC_INDEX), TRUE);
        EnableWindow(GetDlgItem(hWnd, IDC_USE), TRUE);
        EnableWindow(GetDlgItem(hWnd, IDC_GARBAGECOLLECT), TRUE);
        SetFocus(GetDlgItem(hWnd, IDC_INDEX));

        InvalidateRect(hWnd, @g_rcMemMap, FALSE);
      end;

    IDC_INDEX:
      begin
        // ����Edit���ݱ仯
        if (CodeNotify <> EN_CHANGE) then Exit;

        // �����������ð�ť
        uIndex := GetDlgItemInt(hWnd, id, PBOOL(nil)^, FALSE);
        if (g_pSomeData <> nil) and (uIndex <= MAX_SOMEDATA - 1) then
        begin
          VirtualQuery(@g_pSomeData[uIndex], mbi, SizeOf(mbi));
          fOk := (mbi.State = MEM_COMMIT);
          if fOk then fOk := g_pSomeData[uIndex].fInUse;

          EnableWindow(GetDlgItem(hWnd, IDC_USE), not fOk);
          EnableWindow(GetDlgItem(hWnd, IDC_CLEAR), fOk);
        end else
        begin
          EnableWindow(GetDlgItem(hWnd, IDC_USE), FALSE);
          EnableWindow(GetDlgItem(hWnd, IDC_CLEAR), FALSE);
        end
      end;

    IDC_USE:
      begin
        uIndex := GetDlgItemInt(hWnd, IDC_INDEX, PBOOL(nil)^, FALSE);
        if (uIndex <= MAX_SOMEDATA - 1) then
        begin
          // �ύָ����Ա(����ҳ��), ��Ϊ��Ա����"����ʹ��"
          VirtualAlloc(@g_pSomeData[uIndex], SizeOf(TSomeData), MEM_COMMIT, PAGE_READWRITE);
          g_pSomeData[uIndex].fInUse := TRUE;

          EnableWindow(GetDlgItem(hWnd, IDC_USE), FALSE);
          EnableWindow(GetDlgItem(hWnd, IDC_CLEAR), TRUE);
          SetFocus(GetDlgItem(hWnd, IDC_CLEAR));

          InvalidateRect(hWnd, @g_rcMemMap, FALSE);

          // ע1: �ύС��ṹ�ڴ�,ʵ���ϻᵼ�������ڵ�����ҳ�汻�ύ.
          // ע2: ���ύ��ҳ��ᱻϵͳ����,��������Ա��fInUse��ΪFALSE
        end;
      end;

    IDC_CLEAR:
      begin
        uIndex := GetDlgItemInt(hWnd, IDC_INDEX, PBOOL(nil)^, FALSE);
        if (uIndex <= MAX_SOMEDATA - 1) then
        begin
          // ȥ��ָ����Ա"����ʹ��"��ʶ
          g_pSomeData[uIndex].fInUse := FALSE;

          EnableWindow(GetDlgItem(hWnd, IDC_USE), TRUE);
          EnableWindow(GetDlgItem(hWnd, IDC_CLEAR), FALSE);
          SetFocus(GetDlgItem(hWnd, IDC_USE));
        end;
      end;

    IDC_GARBAGECOLLECT:
      begin
        // ���������ڴ�
        GarbageCollect(g_pSomeData, MAX_SOMEDATA, SizeOf(TSomeData));

        // �ػ��ڴ�״̬
        InvalidateRect(hWnd, @g_rcMemMap, FALSE);
      end;
  end;
end;

  // WM_PAINT��Ϣ����
procedure Dlg_OnPaint(hWnd: HWND);
var
  ps: TPaintStruct;
  uMaxPages, uMemMapWidth, uPage, uIndex, uIndexLast: UINT;
  mbi: TMemoryBasicInformation;
  nBrush: Integer;
begin
  BeginPaint(hWnd, ps);

  uMaxPages := MAX_SOMEDATA * SizeOf(TSomeData) div g_uPageSize; // ����: �����ǳ����� ??
  uMemMapWidth := g_rcMemMap.Right - g_rcMemMap.Left;

  if (g_pSomeData = nil) then
  begin
    // ��δ���������ڴ�, ֻ������

    Rectangle(ps.hdc, g_rcMemMap.Left, g_rcMemMap.Top,
      g_rcMemMap.Right - Integer(uMemMapWidth mod uMaxPages), g_rcMemMap.Bottom);
  end else
  begin
    // ���������ڴ�, ����״̬��ͼ

    uPage := 0;
    while (uPage < uMaxPages) do // ������ҳ
    begin
      uIndex := uPage * g_uPageSize div SizeOf(TSomeData);
      uIndexLast := uIndex + g_uPageSize div SizeOf(TSomeData);

      while (uIndex < uIndexLast) do // ������Ա
      begin
        VirtualQuery(@g_pSomeData[uIndex], mbi, SizeOf(mbi));

        case (mbi.State) of
          MEM_FREE:    nBrush := WHITE_BRUSH;
          MEM_RESERVE: nBrush := GRAY_BRUSH;
          MEM_COMMIT:  nBrush := BLACK_BRUSH;
          else nBrush := 0; // WHITE_BRUSH = 0;
        end;

        SelectObject(ps.hdc, GetStockObject(nBrush));
        Rectangle(ps.hdc,
          g_rcMemMap.Left + Integer(uMemMapWidth div uMaxPages * uPage),
          g_rcMemMap.Top,
          g_rcMemMap.Left + Integer(uMemMapWidth div uMaxPages * (uPage + 1)),
          g_rcMemMap.Bottom);

        Inc(uIndex);
      end;

      Inc(uPage);
    end;
  end;

  EndPaint(hWnd, ps);
end;

  // �Ի���ص�
function Dlg_Proc(hWnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): BOOL; stdcall;
begin
  Result := TRUE;

  case (uMsg) of
    WM_INITDIALOG:
      Result := BOOL(SetWindowLong(hWnd,
        DWL_MSGRESULT, Longint(Dlg_OnInitDialog(hWnd, wParam, lParam))));

    WM_COMMAND:
      Dlg_OnCommand(hWnd, LOWORD(wParam), lParam, HIWORD(wParam));

    WM_PAINT:
      Dlg_OnPaint(hWnd);

    WM_DESTROY:
      Dlg_OnDestroy(hWnd);

    else Result := FALSE;  
  end;
end;

  // ������ڵ�
var
  si: TSystemInfo;
begin
  GetSystemInfo(si);
  g_uPageSize := si.dwPageSize;

  DialogBox(HInstance, MakeIntResource(IDD_VMALLOC), 0, @Dlg_Proc);
end.
