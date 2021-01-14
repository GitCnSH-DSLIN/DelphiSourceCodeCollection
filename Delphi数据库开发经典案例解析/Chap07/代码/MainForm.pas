unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, StdCtrls;

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
    N11: TMenuItem;
    N12: TMenuItem;
    N10: TMenuItem;
    StatusBar1: TStatusBar;
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    
    function FindForm(caption: string): bool;//�ж��Ӵ����Ƿ��Ѿ�����
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

uses MedInfoForm,ChargeItmForm,ClinicRegForm,PriceConfirmForm,CashForm,StoreSearchForm,RegSearchForm,MedSendForm;
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

//--------------��ʾ��ҩƷ��Ϣ������-------------------
procedure TMain.N2Click(Sender: TObject);
var
newform:TMedInfo;
begin
 if FindForm('ҩƷ��Ϣ')=false then
  newform:=TMedInfo.Create(application);
  newform.Caption:='ҩƷ��Ϣ';
end;

//--------------��ʾ���շ���Ŀ������-------------------
procedure TMain.N3Click(Sender: TObject);
var
newform:TChargeItm;
begin
 if FindForm('�շ���Ŀ')=false then
  newform:=TChargeItm.Create(application);
  newform.Caption:='�շ���Ŀ';
end;
//--------------��ʾ������Һš�����-------------------
procedure TMain.N5Click(Sender: TObject);
var
newform:TClinicReg;
begin
 if FindForm('����Һ�')=false then
  newform:=TClinicReg.Create(application);
  newform.Caption:='����Һ�';
end;

//--------------��ʾ�����ﻮ�ۡ�����-------------------
procedure TMain.N6Click(Sender: TObject);
var
newform:TPriceConfirm;
begin
 if FindForm('���ﻮ��')=false then
  newform:=TPriceConfirm.Create(application);
  newform.Caption:='���ﻮ��';
end;
//--------------��ʾ�������շѡ�����-------------------
procedure TMain.N7Click(Sender: TObject);
var
newform:TCash;
begin
 if FindForm('�����շ�')=false then
  newform:=TCash.Create(application);
  newform.Caption:='�����շ�';
end;
//--------------��ʾ��ҩ����ҩ������-------------------
procedure TMain.N8Click(Sender: TObject);
var
newform:TMedSend;
begin
 if FindForm('ҩ����ҩ')=false then
  newform:=TMedSend.Create(application);
  newform.Caption:='ҩ����ҩ';
end;

//--------------��ʾ�����ҹҺ���������-------------------
procedure TMain.N11Click(Sender: TObject);
var
newform:TRegSearch;
begin
 if FindForm('���ҹҺ���')=false then
  newform:=TRegSearch.Create(application);
  newform.Caption:='���ҹҺ���';
end;

//--------------��ʾ��ҩƷ�����������-------------------
procedure TMain.N12Click(Sender: TObject);
var
newform:TStoreSearch;
begin
 if FindForm('ҩƷ�����')=false then
  newform:=TStoreSearch.Create(application);
  newform.Caption:='ҩƷ�����';
end;

//--------------�˳�����-------------------
procedure TMain.N10Click(Sender: TObject);
begin
 close;
end;












end.
