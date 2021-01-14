unit ListView_Unit;

interface

   //----����ListView------
procedure Create_ListView;

implementation

uses
  Windows, Public_Unit;

const
 {-- ListView Style --}
  LVS_SHOWSELALWAYS = $0008; //һֱѡ��
  LVS_REPORT        = $0001; //����ģʽ
  LVS_SINGLESEL     = $0004; //ֻ�ܵ�ѡ
  
 {-- Windows��Ϣ --}
  WM_LBUTTONDOWN    = $0201; //����������
  LVM_INSERTCOLUMN  = $101B; //����ListView��
  LVM_SETEXTENDEDLISTVIEWSTYLE = $1036; //�޸�ListView����
  LVM_GETNEXTITEM   = $100C; //ȡ��item���

 {--LVM_SETEXTENDEDLISTVIEWSTYLE����--}
  LVS_EX_GRIDLINES        = $0001;     //��ʾϸ������
  LVS_EX_FULLROWSELECT    = $0020;     //����ѡ������

 {-- LVM_GETNEXTITEM ���� --}
  LVNI_FOCUSED     = $0001 ;       //ȡ�����־
  
 {-- T_Lv_Column ��Ч��Ա��־ --}
  LVCF_FMT     =   $01;  //fmt
  LVCF_WIDTH   =   $02;  //lx
  LVCF_TEXT    =   $04;  //pszText

 {-- fmt (���뷽ʽ) --}
  LVCFMT_LEFT  =   $00;  //�����

type
 {--����нṹ(LVM_INSERTCOLUMN��Ϣ)--}
  T_Lv_Column = packed record
    mask    : UINT   ;    // ��Ч��־
    fmt     : integer;    // ���뷽ʽ
    lx      : integer;    // �еĿ��
    pszText : LPTSTR ;    // ��������
    cchTextMax : integer; // ����,��ѯʱ��
    iSubItem   : integer; // ����
  end;

var
  ListView_Proc: Pointer; // ԭListView����

   //-----���ô˺���,ʹcomctl32.dll�Զ�װ��,DLL��ʼ�����뽫ע����
procedure InitCommonControls; stdcall; external 'ComCtl32.dll' name 'InitCommonControls';  

   //---ListView�����������-------
procedure ListViewClick;
begin             // ȡ��ǰѡ�е�item��� [ 0 .. X ]
  Cur_Item_Index := SendMessage(ListViewHanlde, LVM_GETNEXTITEM, -1, LVNI_FOCUSED);
  RefurbishFrom;  // ˢ�� �� ��ӵ����ػ�ͼ�� .
end;

   //----ListView�������-----
function ListViewProc(WinHanlde, MessageID, WParam, LParam: Longword): Longint; stdcall;
begin
  Result := CallWindowProc(ListView_Proc, WinHanlde , MessageID, wParam, lParam);
  if (MessageID = WM_LBUTTONDOWN) then ListViewClick ; // �������¼�
end;

   //----��LIstView�����----
                        {--����--}      {--�п�--}      {--λ��--}
procedure Add_Column(ColText: PChar; Width: Integer; Index: Integer);
var
  Lv_Column:T_Lv_Column;
begin
  Lv_Column.mask:= LVCF_FMT or LVCF_WIDTH or LVCF_TEXT  ;
  Lv_Column.fmt := LVCFMT_LEFT;
  Lv_Column.lx  := Width;
  Lv_Column.pszText := ColText;
  SendMessage(ListViewHanlde, LVM_INSERTCOLUMN, Index, integer(@Lv_Column));
end;

   //-----�����б��-----
procedure Create_ListView;
begin
 //--����ListView--
  ListViewHanlde := CreateWindowEx (0, 'SysListView32', '����',
                                   WS_CHILDWINDOW or WS_VISIBLE or LVS_REPORT or LVS_SHOWSELALWAYS or
                                   WS_CLIPSIBLINGS or WS_CLIPCHILDREN or WS_BORDER or LVS_SINGLESEL,
                                   1, 45, 445, 163, WindowHanlde, 0, hInstance, nil);
  if ListViewHanlde=0 then
  begin
    MessageBox(0, '�����б�ؼ�ʧ��', nil, 0);
    Halt;
  end;
 //--ListView����--
  SendMessage(ListViewHanlde, LVM_SETEXTENDEDLISTVIEWSTYLE, 0, LVS_EX_GRIDLINES or LVS_EX_FULLROWSELECT);
 //--ListView����--
  SendMessage(ListViewHanlde, WM_SETFONT, MyFont_Hanlde, 0);
 //--������Ӹ���--
  Add_Column('  �������', 80, 0);
  Add_Column('  ��������', 80, 1);
  Add_Column(' ������', 70, 2);
  Add_Column('  ��&��', 65, 3);
  Add_Column('  ��������·��', 150, 4);
 //---�账�����---
  ListView_Proc := Pointer(SetWindowLong(ListViewHanlde, GWL_WNDPROC, Longint(@ListViewProc)));
 //---���ÿպ���---
 InitCommonControls;
end;  

end.
