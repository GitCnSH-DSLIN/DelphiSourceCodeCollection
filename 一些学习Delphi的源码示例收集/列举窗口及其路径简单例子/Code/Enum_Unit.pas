unit Enum_Unit;

interface

    //----��������ص�����-----
function EnumWindowsProc(WinHwnd, Param: LongWord): Boolean; stdcall;

implementation

uses
  Windows, Public_Unit;

const
 {--Windows ��Ϣ--}
  LVM_INSERTITEM = $1007 ; // ���ListView��Ŀ
  LVM_SETITEM    = $1006 ; // ���ListView����Ŀ
  
 {--- ��ʶ���� ---}
  LVIF_TEXT = $0001 ;   // Lv_Item�ı���Ա��Ч��־
  TH32CS_SNAPMODULE = $00000008;   // ģ���б����

type
 {-- ����ListView(��)��Ŀ�ṹ --}
  T_Lv_Item = packed record
      mask     : UINT ;      // ��Ч��Ա��־
      iItem    : integer;    // ��Ŀ������
      iSubItem : integer;    // ����Ŀ������
      state    : UINT;
      stateMask: UINT;
      pszText  : LPTSTR;     // ��Ŀ����
      cchTextMax : integer;
      iImage : integer;
      lParam : LPARAM;
   end;

 {-- ö���� ���� ģ����Ϣ�ṹ --}
  TMODULEENTRY32 = record
    dwSize: DWORD;        // ���ṹ�ߴ�
    th32ModuleID: DWORD;  // This module
    th32ProcessID: DWORD; // owning process
    GlblcntUsage: DWORD;  // Global usage count on the module
    ProccntUsage: DWORD;  // Module usage count in th32ProcessID's context
    modBaseAddr: PBYTE;   // Base address of module in th32ProcessID's context
    modBaseSize: DWORD;   // Size in bytes of module starting at modBaseAddr
    hModule: HMODULE;     // The hModule of this module in th32ProcessID's context
    szModule: array[0..255] of Char;
    szExePath: array[0..260 - 1] of Char;// ģ������·��
  end;

var
  WindowText   : string  ;       // �������
  WindowClass  : string  ;       // ��������
  WindowIcon   : LongWord;       // ����ͼ��
  WindowRect   : TRect;          // ����ߴ�

  WinThreadID  : LongWord;       // �߳�ID
  WinProcessId : LongWord;       // ����ID

  ModuleStruct : TMODULEENTRY32; // ģ����Ϣ�ṹ
  ModuleHandle : LongWord;       // ���վ��
  FoundModule  : Boolean ;       // �Ƿ��ҵ�ģ��

  FullFileName : string  ;       // ����·��
  FileIconIndex: UINT=0  ;       // ͼ������
  ExeFileIcon  : LongWord;       // �ļ�ͼ��

   //--------------API  Function------------------
function ExtractIcon(hInst: HINST; lpszExeFileName: PChar; nIconIndex: UINT) : HICON; stdcall; external 'shell32.dll' name 'ExtractIconA';
function CreateToolhelp32Snapshot(dwFlags, th32ProcessID: DWORD) : THandle ; stdcall; external 'kernel32.dll' name 'CreateToolhelp32Snapshot';
function Module32First(hSnapshot: THandle; var lpme: TModuleEntry32): BOOL ; stdcall; external 'kernel32.dll' name 'Module32First';
function Module32Next(hSnapshot: THandle; var lpme: TModuleEntry32): BOOL ; stdcall; external 'kernel32.dll' name 'Module32Next';
   //--------------API  Function------------------



   //----β��ƥ���,�����ִ�Сд----
function AnsiEndsText(const ASubText, AText: string): Boolean;
var
  P: PChar;
  L, L2: Integer;
begin
  P := PChar(AText);
  L := Length(ASubText);
  L2 := Length(AText);
  Inc(P, L2 - L);
  if L > L2 then
    Result := FALSE
  else
    Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE,P, L, PChar(ASubText), L) = 2;
end;

   //----תΪ10������ʽ�ַ���----
function Int_to_Str(Value: Integer): string;
var
  tmp: Integer;
begin
  Result := '';
  if (Value < 0) then
  begin
    Value := -Value;
    while TRUE do
    begin
      tmp := Value Mod 10;
      Result := Char(tmp+$30) + Result;
      Value := Value Div 10;
      if (Value = 0) then break;
    end;
    Result := '-' + Result;
  end
  else
  begin
    while TRUE do
    begin
      tmp := Value Mod 10;
      Result := Char(tmp+$30) + Result;
      Value := Value Div 10;
      if (Value = 0) then break;
    end;
  end;
end;

   //----תΪ8λ16������ʽ�ַ���----
function Int_to_Hex(Value: integer): string;
var
  i, v: integer;
begin
  Result := '00000000';
  i := 8;
  while (Value <> 0) do
  begin
    v := (Value and $0F);
    if (v > 9) then v := v + 7;
    Result[i] := Char(v+$30);
    Value := Value shr 4;
    i := i-1;
  end;
end;

   //--�������Ŀ��ListView {---����---}    {--��Ŀ���--}   {--����Ŀ���--}
procedure Add_SubItem(SubItemText: Pchar; ItemIndex: integer; SubItemIndex: Integer);
var
  Sub_Lv_Item: T_Lv_Item;
begin
  Sub_Lv_Item.mask := LVIF_TEXT;
  Sub_Lv_Item.iItem := ItemIndex;
  Sub_Lv_Item.iSubItem := SubItemIndex;
  Sub_Lv_Item.pszText := SubItemText;
  Sendmessage(ListViewHanlde, LVM_SETITEM, 0, Integer(@Sub_Lv_Item));
end;

   //---��������ص�����--  {--���ھ��--}   {--�������--}
function EnumWindowsProc(WinHwnd: LongWord; Param: LongWord): Boolean; stdcall;
var
  Main_Lv_Item: T_Lv_Item;    
begin
   {--��������--}
  Result := TRUE; 
   {--��������--}
  if ( IsWindowVisible(WinHwnd) or IsIconic(WinHwnd) ) and
       (
        (GetWindowLong(WinHwnd, GWL_HWNDPARENT) = 0) or
        (GetWindowLong(WinHwnd, GWL_HWNDPARENT) = Longint(GetDesktopWindow))
       )and
     ( GetWindowLong(WinHwnd, GWL_EXSTYLE) and WS_EX_TOOLWINDOW = 0 )  then
  begin
  {-----��������------}
    SetLength(WindowText, GetWindowTextLength(WinHwnd)+2);
    Getwindowtext(WinHwnd, Pchar(WindowText), GetWindowTextLength(WinHwnd)+2);
    WindowText := string( Pchar(WindowText) );
  {-----��������------}
    SetLength(WindowClass, 512);
    GetClassName(WinHwnd, Pchar(WindowClass), 512);
    WindowClass := string( Pchar(WindowClass) );
  {----����ͼ����---}                          {--Сͼ��--}
    WindowIcon := SendMessage(WinHwnd, WM_GETICON, ICON_SMALL, 0);
    if (WindowIcon = 0) then                     {--��ͼ��--}
      WindowIcon := SendMessage(WinHwnd, WM_GETICON, ICON_BIG, 0);
  {-----����ߴ�------}
    GetWindowRect(WinHwnd, WindowRect);
  {----�߳�&����ID----}
    WinThreadID := GetWindowThreadProcessId(WinHwnd, @WinProcessId);
    
  {---ģ���б����----}
    ModuleHandle := CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, WinProcessId);
    ModuleStruct.dwSize := sizeof(ModuleStruct);
  {-----��1��ģ��-----}
    FoundModule := Module32First(ModuleHandle, ModuleStruct);
    while (FoundModule) do
    begin
      FullFileName := ModuleStruct.szExePath;
    {----�Ƿ��׺exe----}
      if AnsiEndsText('.exe', FullFileName) then
      begin
      {---�����ļ�ͼ����--}                       
        ExeFileIcon := ExtractIcon(Hinstance, PChar(FullFileName), FileIconIndex);
      {---��ͼ����������--}
        Cur_Item_Count := Cur_Item_Count+1;
        SetLength(Icon_Handle, Cur_Item_Count);
        Icon_Handle[Cur_Item_Count-1].WindowIcon := WindowIcon;
        Icon_Handle[Cur_Item_Count-1].FileIcon := ExeFileIcon;
      {--���ListVew��Ŀ--}
        Main_Lv_Item.mask := LVIF_TEXT;
        Main_Lv_Item.iItem := Cur_Item_Count-1;
        Main_Lv_Item.iSubItem := 0;
        Main_Lv_Item.pszText := Pchar(WindowText);
        Sendmessage(ListViewHanlde, LVM_INSERTITEM, 0, Integer(@Main_Lv_Item));
      {--���ListVew����Ŀ--}
        Add_SubItem(PChar(WindowClass), Cur_Item_Count-1, 1);
        Add_SubItem(PChar('$'+Int_to_Hex(WinHwnd)), Cur_Item_Count-1, 2);
        Add_SubItem(PChar
                    (Int_to_Str(WindowRect.Right-WindowRect.Left)+'*'+
                     Int_to_Str(WindowRect.Bottom-WindowRect.Top)),
                    Cur_Item_Count-1, 3);
        Add_SubItem(PChar(FullFileName), Cur_Item_Count-1, 4);

        Break;
      end;
    {----��һ��ģ��----}
      FoundModule := Module32Next(ModuleHandle, ModuleStruct);
    end;
  {----�ͷž��----}
    CloseHandle(ModuleHandle);
  end;
end;


end.
