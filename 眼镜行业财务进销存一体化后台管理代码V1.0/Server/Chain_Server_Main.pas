unit Chain_Server_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,shellapi, StdCtrls, Menus;
const
  WM_WZGLNOTIFY = WM_USER + 199;  //�Զ�����Ϣ
  strNotifyTip = '������Ӧ�÷�������';
  ID_MAIN = 199;
  const
  CM_RESTORE = WM_USER + $1000; {�Զ���ġ��ָ�����Ϣ}
  WZGL_APP_NAME = 'Manager_System';
type
  Tfrm_Chain_Server_Main = class(TForm)
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    Show1: TMenuItem;
    N1: TMenuItem;
    About1: TMenuItem;
    N2: TMenuItem;
    Close1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Show1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);


  private
     {Private declarations }
      nid:NOTIFYICONDATA;
     cancels:boolean;
     FpNotify : PNotifyIconDataA;
     Index:Integer;
    function AddIcon(hwnd: HWND): Boolean; //��״̬�����ͼ��
    function RemoveIcon(hwnd: HWND): Boolean; //��״̬����ȥͼ��
    procedure Notify(var Msg: TMessage); message WM_WZGLNOTIFY; //�Զ�����Ϣ������
    procedure minimize(sender: Tobject); //������С�����̣�����Application.OnMinimize
    procedure RestoreRequest(var message: TMessage); message CM_RESTORE;
  public
    { Public declarations }
  end;

var
  frm_Chain_Server_Main: Tfrm_Chain_Server_Main;
  IconData: TNotifyIconData;
  tags:boolean;

implementation

uses Unitzc, Chain_Data, UBook;

{$R *.dfm}

///////////////�Զ��庯��/////////////////////////////////
////////////////////////////////////////{�����ָ�����Ϣ}

procedure Tfrm_Chain_Server_Main.RestoreRequest(var message: TMessage);
begin
  if IsIconic(Application.Handle) = True then  //�����Ƿ���С��
    Application.Restore  //�ָ�����
  else
    Application.BringToFront; //�ᵽǰ����ʾ
end;
//��״̬�����ͼ��
function Tfrm_Chain_Server_Main.AddIcon(hwnd: HWND): Boolean;
begin
  nid.cbSize := sizeof(NOTIFYICONDATA);
  nid.Wnd := hwnd;
  nid.uID := iD_MAIN;
  nid.uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
  nid.uCallbackMessage := WM_WZGLNOTIFY;
  nid.hIcon := LoadIcon(hInstance, 'MAINICON');
  strCopy(nid.szTip, strNotifyTip);
  AddIcon := Shell_NotifyIcon(NIM_ADD, @nid);
end;

//��״̬����ȥͼ��
function Tfrm_Chain_Server_Main.RemoveIcon(hwnd: HWND): Boolean;
var
  nid: NOTIFYICONDATA;
begin
  nid.cbSize := sizeof(NOTIFYICONDATA);
  nid.Wnd := hwnd;
  nid.uID := iD_MAIN ;
  nid.uFlags := 0;
  RemoveIcon := Shell_NotifyIcon(NIM_DELETE, @nid);
end;

//�Զ�����Ϣ������
procedure Tfrm_Chain_Server_Main.Notify(var Msg: TMessage);
var
  Pt: TPoint;
begin
  case msg.LParam of
    WM_RBUTTONDOWN:    //������Ҽ�ʱ,������ݲ˵�
      begin
        SetForeGroundWindow(nid.wnd);
        GetCursorPos(Pt);
        Popupmenu1.Popup(pt.x, pt.y);
      end;
  end;
end;

//������С�����̣�����Application.OnMinimize;
procedure tfrm_Chain_Server_Main.minimize(sender: Tobject);
begin
  AddIcon(handle);
  ShowWindow(Application.handle, sw_hide);
end;

//******************************************************************************
procedure Tfrm_Chain_Server_Main.FormCreate(Sender: TObject);
begin
  application.OnMinimize:=minimize;
end;

procedure Tfrm_Chain_Server_Main.Show1Click(Sender: TObject);
begin
    RemoveIcon(handle);
  self.WindowState:=wsNormal;
  ShowWindow(Application.handle, SW_SHOWNORMAL);
end;

procedure Tfrm_Chain_Server_Main.Close1Click(Sender: TObject);
begin
  cancels:=true;
  RemoveIcon(handle);
  application.Terminate;
end;

procedure Tfrm_Chain_Server_Main.FormShow(Sender: TObject);
begin
  cancels:=false;
end;

procedure Tfrm_Chain_Server_Main.About1Click(Sender: TObject);
begin
  Application.MessageBox('����������ϵͳ�����ʶ��Ƽ����ƣ�'+#13#10+'������ģ�飬����رգ�','����������ϵͳ��',mb_ok);
end;

procedure Tfrm_Chain_Server_Main.N3Click(Sender: TObject);
begin
  Formzc:=TFormzc.create(self);
  Formzc.ShowModal;
  Formzc.Free;
end;

procedure Tfrm_Chain_Server_Main.N4Click(Sender: TObject);
begin
  if not frm_Chain_Data.ADOConnMaster.Connected then
  begin
    application.MessageBox(pchar('��δ�������ݿ⣬����������ݿ����ӣ�'),pchar(application.Title),mb_iconinformation);
    exit;
  end;
  FmBook:=tFmBook.Create(self);
  FmBook.ShowModal;
  FmBook.Free;
end;

procedure Tfrm_Chain_Server_Main.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
end;

procedure Tfrm_Chain_Server_Main.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   canclose:=cancels;
  if not canclose then application.Minimize;
end;

end.
