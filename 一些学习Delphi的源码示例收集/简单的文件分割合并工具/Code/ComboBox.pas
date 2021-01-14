unit  ComboBox;

interface

    // ---- ����ComboBox�ؼ� ---- //
procedure Create_ComboBox;

implementation

uses
  Windows, Messages, PublicUnit;

var
  DefComboBoxProc: Pointer;          // Ĭ��ComboBox����
  ComboBoxDrawRect: TRect;           // ����ComboBox��Χ
  SubButtonWidth: Integer;           // ��ǰϵͳ��ť���
  FrameBrush, BosomBrush: LongWord;  // ������ɫˢ�Ӿ��

    // ---- ��ComboBox���� ---- //  
function NewComboBoxProc(hWnd, MsgID, wParam, lParam: LongWord): LongWord; stdcall;
var
  TempRT: TRect;        // ��������
  TempDC: LongWord;     // ���ƻ���
  TempPS: TPaintStruct; // ..... ^^
begin
  Result := 0;
  if (MsgID = WM_PAINT) then
  begin
    TempDC := BeginPaint(hWnd, TempPS);

   // �������Ա߿� ..
    TempRT := ComboBoxDrawRect;
    InflateRect(TempRT, -1, -1);
    FrameRect(TempDC, TempRT, FrameBrush);
    InflateRect(TempRT, -1, -1);
    FrameRect(TempDC, TempRT, BosomBrush);
    
   // ����������ť ..
    TempRT := ComboBoxDrawRect; 
    Inc(TempRT.Left, ComboBoxDrawRect.Right-SubButtonWidth-4);
    InflateRect(TempRT, -1, -1);
    DrawFrameControl(TempDC, TempRT, DFC_SCROLL, DFCS_SCROLLCOMBOBOX or DFCS_MONO);
    
    EndPaint(hWnd, TempPS);
  end else
    Result := CallWindowProc(DefComboBoxProc, hWnd, MsgID, wParam, lParam);
end; 

    // ---- ����ComboBox�ؼ� ---- //
procedure Create_ComboBox;
var
  hSubEdit: LongWord;
begin
// ����ComboBox ..
  hComboBox := CreateWindowEx(0, 'COMBOBOX', 'ComboBox8Mazi',
                              WS_CHILD or WS_CLIPCHILDREN or CBS_DROPDOWN,
                              59, 72, 93, 300,
                              hPanel1, ComboBoxID, hInstance, nil);
  if (hComboBox = 0) then
  begin
    MessageBox(0, 'Create ComboBox Error !!', nil, MB_SETFOREGROUND);  Halt;
  end;            
// ��EDITֻ�������� ..
  hSubEdit := FindWindowEx(hComboBox, 0, 'EDIT', nil);
  SetWindowLong(hSubEdit, GWL_STYLE	, (GetWindowLong(hSubEdit, GWL_STYLE) or ES_NUMBER));
// ��Ӹ�����ѡ��Ŀ ..
  SendMessage(hComboBox, CB_ADDSTRING, 0, Longword(PChar(string('1'))));
  SendMessage(hComboBox, CB_ADDSTRING, 0, Longword(PChar('14')));
  SendMessage(hComboBox, CB_ADDSTRING, 0, Longword(PChar('30')));
  SendMessage(hComboBox, CB_ADDSTRING, 0, Longword(PChar('62')));
  SendMessage(hComboBox, CB_ADDSTRING, 0, Longword(PChar('125')));
// ��������,����С�ߴ� ..
  SendMessage(hComboBox, WM_SETFONT, hSmallFont, 0);
  ShowWindow(hComboBox, SW_SHOW); 
// ĳЩȫ�ֱ�����ʼ�� ..
  GetWindowRect(hComboBox, ComboBoxDrawRect);
  OffsetRect(ComboBoxDrawRect, -ComboBoxDrawRect.Left, -ComboBoxDrawRect.Top);
  SubButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  BosomBrush := CreateSolidBrush(GetSysColor(COLOR_WINDOW));
  FrameBrush := CreateSolidBrush( RGB(0, 0, 0) );
// ����ComboBox�¹��� ..
  DefComboBoxProc := Pointer(SetWindowLong(hComboBox, GWL_WNDPROC, LongWord(@NewComboBoxProc)));  
end;

end.
