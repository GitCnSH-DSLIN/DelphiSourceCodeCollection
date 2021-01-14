unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, StdCtrls, Buttons, ToolWin, ComCtrls, jpeg;

type
  Tmain = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    BOM1: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    MPS1: TMenuItem;
    MRP1: TMenuItem;
    MRP2: TMenuItem;
    StatusBar1: TStatusBar;
    Image1: TImage;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    procedure N4Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure BOM1Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure MPS1Click(Sender: TObject);
    procedure MRP1Click(Sender: TObject);
    procedure MRP2Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
   
    
  private
    { Private declarations }
  public
    { Public declarations }
//����MDI�Ӵ����ͨ�������嶨��Ĺ�����������������
    str,str2,str3,str4:string;
//��ʾ���ĸ��Ӵ�����ʹ��������ĸ���������
//bomflag=1��ʾBOM����ʹ������ı���,bomflag=2,3��ʾ��������ʹ��
    bomflag:integer;
  end;

var
  main: Tmain;


implementation

{$R *.dfm}
uses MaterialsForm,BomForm,CalendarForm,mainrequireForm,mainproduceform,MRPCalForm,mrphistoryForm;

//---------------���������ļ������Ӵ���---------------------
procedure Tmain.N4Click(Sender: TObject);
var
newform:Tmaterials;
i,flag:integer;
begin
//flag��0��ʾ�ô��岻����
  flag:=0;
  for i:=0 to main.MDIChildCount do
 begin
// ͨ���Դ�������жϴ����Ƿ����
  if main.MDIChildren[i].Caption='�������ļ�ά��' then
   begin
   //��������Ѵ��ڣ���ָ�����
     SendMessage(mdichildren[i].Handle, WM_SYSCOMMAND, SC_restore, 0);
     mdichildren[i].Show;
     mdichildren[i].Enabled:=true;
     flag:=1;
   //�˳�ѭ��
   break;
   end;
   end;
  //�����岻���ڣ��򴴽�����
   if flag=0 then
 begin
 newform:=Tmaterials.Create(application);
 newform.Caption:='�������ļ�ά��';
 end;
end;

//----------�ر�������----------------------
procedure Tmain.N3Click(Sender: TObject);
begin
main.Close;
end;

//----------------�������嵥(BOM)�Ӵ���------------------------
procedure Tmain.BOM1Click(Sender: TObject);
var
newform:Tbom;
i,flag:integer;
begin
  flag:=0;
  for i:=0 to main.MDIChildCount do
 begin
// ͨ���Դ�������жϴ����Ƿ����
  if main.MDIChildren[i].Caption='�����嵥(BOM)' then
   begin
   //��������Ѵ��ڣ���ָ�����
     SendMessage(mdichildren[i].Handle, WM_SYSCOMMAND, SC_restore, 0);
     mdichildren[i].Show;
     mdichildren[i].Enabled:=true;
    //��ʶ�����Ѵ���
     flag:=1;
   //�˳�ѭ��
   break;
   end;
   end;
  //�����岻���ڣ��򴴽�����
   if flag=0 then
 begin
 newform:=Tbom.Create(application);
 newform.Caption:='�����嵥(BOM)';
 end;
end;

//--------------------------------------------------------------------
//  *********** �����ǡ��������ļ����˵�ѡ��͡������嵥(BOM)���˵�ѡ��ĵ����¼���Ӧ������룬�����Ӵ������Ӧ�Ĳ˵�ѡ�����������Ĵ������һ�¡�
//   ������ο��������
//--------------------------------------------------------------------

procedure Tmain.N5Click(Sender: TObject);
var
newform:TCalendar;
i,flag:integer;
begin
  flag:=0;
  for i:=0 to main.MDIChildCount do
 begin
  if main.MDIChildren[i].Caption='��������' then
   begin
     SendMessage(mdichildren[i].Handle, WM_SYSCOMMAND, SC_restore, 0);
     mdichildren[i].Show;
     mdichildren[i].Enabled:=true;
     flag:=1;
   break;
   end;
   end;
  //�����岻���ڣ��򴴽�����
if flag=0 then
 begin
 newform:=Tcalendar.Create(application);
 newform.Caption:='��������';
 end;
end;


procedure Tmain.N6Click(Sender: TObject);
var
newform:Tmainrequire;
i,flag:integer;
begin
  flag:=0;
  for i:=0 to main.MDIChildCount do
 begin
  if main.MDIChildren[i].Caption='������ƻ�' then
   begin
     SendMessage(mdichildren[i].Handle, WM_SYSCOMMAND, SC_restore, 0);
     mdichildren[i].Enabled:=true;
     mdichildren[i].Focused;
     mdichildren[i].Show;

     flag:=1;
   break;
   end;
   end;

if flag=0 then
 begin
 newform:=Tmainrequire.Create(application);
 newform.Caption:='������ƻ�';
 end;
end;

procedure Tmain.MPS1Click(Sender: TObject);
var
newform:Tmainproduce;
i,flag:integer;
begin
  flag:=0;
  for i:=0 to main.MDIChildCount do
 begin
  if main.MDIChildren[i].Caption='�������ƻ�' then
   begin
     SendMessage(mdichildren[i].Handle, WM_SYSCOMMAND, SC_restore, 0);
     mdichildren[i].Show;
     mdichildren[i].Enabled:=true;
     flag:=1;
   break;
   end;
   end;

if flag=0 then
 begin
 newform:=Tmainproduce.Create(application);
 newform.Caption:='�������ƻ�';
 end;
end;

procedure Tmain.MRP1Click(Sender: TObject);
var
newform:Tmrpcal;
i,flag:integer;
begin
  flag:=0;
  for i:=0 to main.MDIChildCount do
 begin
  if main.MDIChildren[i].Caption='MRP����' then
   begin
     SendMessage(mdichildren[i].Handle, WM_SYSCOMMAND, SC_restore, 0);
     mdichildren[i].Show;
     mdichildren[i].Enabled:=true;
     flag:=1;
   break;
   end;
   end;

if flag=0 then
 begin
 newform:=Tmrpcal.Create(application);
 newform.Caption:='MRP����';
 end;
end;

procedure Tmain.MRP2Click(Sender: TObject);
var
newform:Tmrphistory;
i,flag:integer;
begin
  flag:=0;
  for i:=0 to main.MDIChildCount do
 begin
  if main.MDIChildren[i].Caption='MRP��ʷ��ѯ' then
   begin
     SendMessage(mdichildren[i].Handle, WM_SYSCOMMAND, SC_restore, 0);
     mdichildren[i].Show;
     mdichildren[i].Enabled:=true;
     flag:=1;
   break;
   end;
   end;

if flag=0 then
 begin
 newform:=Tmrphistory.Create(application);
 newform.Caption:='MRP��ʷ��ѯ';
 end;
end;


//ƽ�̸����Ӵ���
procedure Tmain.N8Click(Sender: TObject);
begin
 Tile;
end;
//��������Ӵ���
procedure Tmain.N9Click(Sender: TObject);
begin
  Cascade;
end;



end.
