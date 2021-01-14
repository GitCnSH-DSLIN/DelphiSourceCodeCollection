unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ComCtrls, Menus;

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
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    StatusBar1: TStatusBar;
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    storestr:string;
    function FindForm(caption: string): bool;

  end;

var
  Main: TMain;

implementation

{$R *.dfm}
uses UserSettingForm,UserDocuForm,BookSettingForm,BookDocuForm,BookOrderForm,BookBorrowForm,BookReturnForm,BookOverdueForm,ForfeitForm;

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
      SendMessage(mdichildren[i].Handle, WM_SYSCOMMAND, SC_Maximize, 0);
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

//-------------�򿪶���������ô���----------
procedure TMain.N2Click(Sender: TObject);
Var
 newform:TUserSetting;
begin
 if FindForm('�����������')=false then
  begin
   newform:=TUserSetting.Create(application);
   newform.Caption:='�����������';
  end;

end;
//-------------�򿪶��ߵ���������----------
procedure TMain.N3Click(Sender: TObject);
Var
 newform:TUserDocu;
begin
 if FindForm('���ߵ�������')=false then
  begin
   newform:=TUserDocu.Create(application);
   newform.Caption:='���ߵ�������';
  end;

end;
//-------------��ͼ��������ô���----------
procedure TMain.N5Click(Sender: TObject);
Var
 newform:TBookSetting;
begin
 if FindForm('ͼ���������')=false then
  begin
   newform:=TBookSetting.Create(application);
   newform.Caption:='ͼ���������';
  end;

end;
//-------------��ͼ�鵵��������----------
procedure TMain.N6Click(Sender: TObject);
Var
 newform:TBookDocu;
begin
 if FindForm('ͼ�鵵������')=false then
  begin
   newform:=TBookDocu.Create(application);
   newform.Caption:='ͼ�鵵������';
  end;

end;
//-------------��ͼ����������----------
procedure TMain.N8Click(Sender: TObject);
Var
 newform:TBookOrder;
begin
 if FindForm('ͼ������')=false then
  begin
   newform:=TBookOrder.Create(application);
   newform.Caption:='ͼ������';
  end;
end;


//-------------��ͼ����Ĵ���----------
procedure TMain.N9Click(Sender: TObject);
Var
 newform:TBookBorrow;
begin
 if FindForm('ͼ�����')=false then
  begin
   newform:=TBookBorrow.Create(application);
   newform.Caption:='ͼ�����';
  end;
end;
//-------------��ͼ��黹����----------
procedure TMain.N10Click(Sender: TObject);
var
 newform:TBookReturn;
begin
  if FindForm('ͼ��黹')=false then
   begin
    newform:=TBookReturn.Create(application);
    newform.Caption:='ͼ��黹';
   end;
end;
//-------------�鿴����ͼ��----------
procedure TMain.N11Click(Sender: TObject);
var
 newform:TBookOverdue;
begin
  if FindForm('�����嵥')=false then
   begin
    newform:=TBookOverdue.Create(application);
    newform.Caption:='�����嵥';
   end;
end;
//-------------�ջ�ͼ�鷣��----------
procedure TMain.N12Click(Sender: TObject);
var
 newform:TForfeit;
begin
  if FindForm('ͼ�鷣��')=false then
   begin
    newform:=TForfeit.Create(application);
    newform.Caption:='ͼ�鷣��';
   end;
end;

procedure TMain.N13Click(Sender: TObject);
begin
close;
end;

end.
