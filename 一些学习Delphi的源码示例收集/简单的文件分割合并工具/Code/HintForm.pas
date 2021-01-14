unit  HintForm;

interface

    // ---- �������ַ�Χ ---- //
function GetTextExtent(const DrawText: string): LongWord;
    // ---- ������ʾ���� ---- //
procedure Active_HintForm(Left, Top: Integer; const Text: string);
    // ---- ������ʾ���� ---- //
procedure Create_HintForm;

implementation

uses
  Windows, Messages, ListUnit, PublicUnit;

var
  Hint_Str: string;          // Hint����Ҫ��ʾ����ʾ����
  No_Enter: Boolean = TRUE;  // �����δ����Hint������
  DragMove: Integer;         // ��קʱ�����Hint�ƶ�����
  
    // ---- �������뺯�� ---- //
function GetTabbedTextExtent(hDC: HDC; lpString: PChar; nCount,
  nTabPositions: Integer; pnTabStopPositions: pointer): LongWord; stdcall;
  external user32 name 'GetTabbedTextExtentA';

     // ---- ��ȡ���ֳ��� ---- //
function GetTextExtent(const DrawText: string): DWORD;
begin
  Result := GetTabbedTextExtent(hHintFormDC, PChar(DrawText), Length(DrawText), 0, nil);
end;

    // ---- ������ʾ���� ---- //
procedure Active_HintForm(Left, Top: Integer; const Text: string);
var
  Width, Height: Integer;
  ScreenWidth: Integer;
begin
 // ��ʼ�� ..
  Hint_Str := Text;
  No_Enter := TRUE;
  DragMove := 0;
 // ȡ�÷�Χ
  Width := GetTextExtent(Text);
  Height := HIWORD(Width) + 4;
  Width := LOWORD(Width) + 7;
 // ������Ļ
  ScreenWidth := Word( GetSystemMetrics(SM_CXSCREEN) );
  if ((Left+Width) > ScreenWidth) then Left := ScreenWidth-Width;
 // ��ʾ����
  SetWindowPos(hHintForm, HWND_TOPMOST, Left, Top, Width, Height, SWP_NOACTIVATE);
  ShowWindow(hHintForm, SW_SHOWNOACTIVATE);
end;

    // ---- ��ʾ������� ---- //
function HintProc(hHint, MsgID, WParam, LParam: LongWord): LongWord; stdcall;
var
  CursorPos: TPoint;
begin
  Result := DefWindowProc(hHint, MsgID, WParam, LParam);
  case MsgID of
    WM_PAINT       : TextOut(hHintFormDC, 3, 1, PChar(Hint_Str), Length(Hint_Str));      
    WM_MOUSEMOVE   : begin
                       if No_Enter  then  // ����HintForm
                       begin
                         No_Enter := FALSE;  SetLeaveEvent(hHint);
                       end;
                       if OnDraging then  // ������ק״̬
                       begin
                         SetCursor(hDrapCursor);  Inc(DragMove);
                         if (DragMove>2) then ShowWindow(hHint, SW_HIDE);
                       end;
                     end;
    WM_LBUTTONDOWN,
    WM_RBUTTONDOWN,
    WM_RBUTTONUP   : begin  // �����Լ���ת����Ϣ�� ListBox
                       CursorPos.X := LOWORD(LParam);
                       CursorPos.Y := HIWORD(LParam);
                       ClientToScreen(hHint, CursorPos);
                       ShowWindow(hHint, SW_HIDE);
                       ScreenToClient(hListBox, CursorPos);
                       LParam := (CursorPos.Y shl 16) or CursorPos.X;
                       SendMessage(hListBox, MsgID, WParam, LParam);
                     end;
    WM_MOUSELEAVE  : begin
                       ShowWindow(hHint, SW_HIDE);
                       ReTest_Enter_List; // ��ֹ��ק���뿪,ListBox��Ӧ����.
                     end;
  end;
end;

    // ---- ע����ʾ���� ---- //
function RegisterHint: Boolean;
var
  HintClass: TWndClass;  
begin
  with HintClass do
  begin
    Style := CS_HREDRAW or CS_VREDRAW;
    lpfnWndProc := @HintProc;
    cbClsExtra := 0;
    cbWndExtra := 0;
    hInstance := SysInit.HInstance;
    hIcon := 0;
    hCursor :=  hArrowCursor;
    hbrBackground := CreateSolidBrush(GetSysColor(COLOR_INFOBK));
    lpszMenuName := nil;
    lpszClassName := 'Splitter_HintForm_Mazi';
  end;                
  Result := RegisterClass(HintClass) <> 0;
end;            

    // ---- ������ʾ���� ---- //
procedure Create_HintForm;
begin
  if (RegisterHint = FALSE) then
  begin
    MessageBox(0, 'Register HintForm Error !!' , nil, MB_SETFOREGROUND);  Halt;
  end;           
  hHintForm := CreateWindowEx(WS_EX_TOPMOST or WS_EX_TOOLWINDOW,
                              'Splitter_HintForm_Mazi', 'Love_Mazi',
                              WS_POPUP or WS_BORDER, 0, 0, 0, 0,
                              hMainForm, 0, hInstance, nil);
  if (hHintForm = 0) then
  begin
    MessageBox(0, 'Create HintForm Error !!', nil, MB_SETFOREGROUND);  Halt;
  end;

  hHintFormDC := GetDC(hHintForm);
  SetBkMode(hHintFormDC, TRANSPARENT);
  SelectObject(hHintFormDC, hSmallFont);
end;

end.
