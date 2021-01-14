unit Button_Unit;

interface

 //-----������ť-----
procedure Create_Button;

implementation     

uses
  Windows, Public_Unit, Enum_Unit;

const
 {--- windows��Ϣ ---}  
  WM_LBUTTONUP = $0202;       // ������̧��
  WM_SETREDRAW       = $000B; // �Ƿ������ػ� 
  LVM_DELETEALLITEMS = $1009; // ���ListView

var
  ButtonHanlde: LongWord;      // Button���
  Button_Proc : Pointer;       // ԭButton����

  //----�����¼�����----
procedure ButtonClick;
begin
 {--- ��ʼ�� ---}
  Cur_Item_Index := -1;
  SetLength(Icon_Handle, 0);
  Cur_Item_Count := 0;
 {-- ���ͼ�� --}
  RefurbishFrom;
 {--- ˢ �� ----}
  SendMessage(ListViewHanlde, WM_SETREDRAW, 0, 0); // ����ListView
  SendMessage(ListViewHanlde, LVM_DELETEALLITEMS, 0, 0);// ���
  EnumWindows(@EnumWindowsProc, 0);                // ��������
  SendMessage(ListViewHanlde, WM_SETREDRAW, 1, 0); // ����ListView
end;

  //----��ť�������-----
function ButtonProc(WinHanlde, MessageID, WParam, LParam: LongWord): Longint; stdcall;
begin
  Result:=CallWindowProc ( Button_Proc, WinHanlde , MessageID, wParam, lParam);
  if (MessageID = WM_LBUTTONUP) then  ButtonClick;  //�������¼�
end;

  //-----������ť-----
procedure Create_Button;
begin
  ButtonHanlde := CreateWindowEx(0,
                                'BUTTON',
                                'ˢ ��',
                                WS_CHILD or WS_VISIBLE or BS_FLAT,
                                30,
                                10,
                                75,
                                25,
                                WindowHanlde,
                                0,
                                hInstance,
                                nil);
  if (ButtonHanlde = 0) then
  begin
    MessageBox(0, '������ťʧ��', nil, 0);
    Halt;
  end;
 //---��Button����-----
  SendMessage(ButtonHanlde, WM_SETFONT, MyFont_Hanlde, 0);
 //---��Button����-----
  Button_Proc := Pointer(SetWindowLong(ButtonHanlde, GWL_WNDPROC, LongWord(@ButtonProc)));
end;

end.
