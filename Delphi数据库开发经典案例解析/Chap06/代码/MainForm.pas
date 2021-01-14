unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus;

type
  TMain = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    RoomNum:integer;//����ѡ��Ŀշ����
    YDNum:string;//����ѡ���Ԥ������
    RZNum:string;//����ѡ�����ס����
    function FindForm(caption: string): bool;//�ж��Ӵ����Ƿ��Ѿ�����
  end;

var
  Main: TMain;

implementation

{$R *.dfm}
uses RoomTypeForm,RoomInfoForm,ReservationForm,DebtForm,RoomStatusForm,ResideForm,CheckOutForm;
//-----------ͨ���û�����ĺ������жϴ����Ƿ��Ѵ���--------------------
function TMain.FindForm(caption: string): bool;
var
i:integer;
begin
 for i:=0 to main.MDIChildCount do
  begin
   // ͨ���Դ�������жϴ����Ƿ����
    if main.MDIChildren[i].Caption=caption then
     begin
      //��������Ѵ��ڣ���ָ����壬������true
      SendMessage(mdichildren[i].Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
      mdichildren[i].Enabled:=true;
      mdichildren[i].Show;
      mdichildren[i].SetFocus;
      result:=true;
      break;
     end
     else
     //�細�岻���ڣ��򷵻�false�����򽫴�������
      result:=false;
  end
end;

//--------------��ʾ���ͷ��������á�����-------------------
procedure TMain.N2Click(Sender: TObject);
var
newform:TRoomType;
begin
 if FindForm('�ͷ���������')=false then
  newform:=TRoomType.Create(application);
  newform.Caption:='�ͷ���������';
end;
//--------------��ʾ���ͷ���Ϣ���á�����-------------------
procedure TMain.N3Click(Sender: TObject);
var
newform:TRoomInfo;
begin
 if FindForm('�ͷ���Ϣ����')=false then
  newform:=TRoomInfo.Create(application);
  newform.Caption:='�ͷ���Ϣ����';
end;
//--------------��ʾ��Ԥ����������-------------------
procedure TMain.N5Click(Sender: TObject);
var
newform:TReservation;
begin
 if FindForm('Ԥ������')=false then
  newform:=TReservation.Create(application);
  newform.Caption:='Ԥ������';
end;



//--------------��ʾ����ס��������-------------------
procedure TMain.N6Click(Sender: TObject);
var
newform:TReside;
begin
 if FindForm('��ס����')=false then
  newform:=TReside.Create(application);
  newform.Caption:='��ס����';
end;
//--------------��ʾ�����Ѽ��ʡ�����-------------------
procedure TMain.N7Click(Sender: TObject);
var
newform:TDebt;
begin
 if FindForm('���Ѽ���')=false then
  newform:=TDebt.Create(application);
  newform.Caption:='���Ѽ���';
end;
//--------------��ʾ�������˷�������-------------------
procedure TMain.N8Click(Sender: TObject);
var
newform:TCheckOut;
begin
 if FindForm('�����˷�')=false then
  newform:=TCheckOut.Create(application);
  newform.Caption:='�����˷�';
end;
//--------------��ʾ����̬��������-------------------
procedure TMain.N9Click(Sender: TObject);
var
newform:TRoomStatus;
begin
 if FindForm('��̬����')=false then
  newform:=TRoomStatus.Create(application);
  newform.Caption:='��̬����';

end;
//--------------�˳�����-------------------
procedure TMain.N10Click(Sender: TObject);
begin
 close;
end;

end.
