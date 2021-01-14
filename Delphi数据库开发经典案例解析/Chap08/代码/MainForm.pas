unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls;

type
  Tmain = class(TForm)
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
    StatusBar1: TStatusBar;
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function FindForm(caption: string): bool;
  end;

var
  main: Tmain;

implementation

{$R *.dfm}
uses ClassInfoForm,StudentInfoForm,CourseInfoForm,CourseElectForm,ScheduleForm,ScoreForm,PrintScoreForm;
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

//--------------��ʾ���༶��Ϣά��������-------------------
procedure TMain.N2Click(Sender: TObject);
var
newform:TClassInfo;
begin
 if FindForm('�༶��Ϣά��')=false then
  newform:=TClassInfo.Create(application);
  newform.Caption:='�༶��Ϣά��';
end;

//--------------��ʾ��ѧ����Ϣά��������-------------------
procedure Tmain.N3Click(Sender: TObject);
var
newform:TStudentInfo;
begin
 if FindForm('ѧ����Ϣά��')=false then
  newform:=TStudentInfo.Create(application);
  newform.Caption:='ѧ����Ϣά��';
end;
//--------------��ʾ���γ���Ϣά��������-------------------
procedure Tmain.N4Click(Sender: TObject);
var
newform:TCourseInfo;
begin
 if FindForm('�γ���Ϣά��')=false then
  newform:=TCourseInfo.Create(application);
  newform.Caption:='�γ���Ϣά��';
end;
//--------------��ʾ��ѧ��ѡ�Ρ�����-------------------
procedure Tmain.N6Click(Sender: TObject);
var
newform:TCourseElect;
begin
 if FindForm('ѧ��ѡ��')=false then
  newform:=TCourseElect.Create(application);
  newform.Caption:='ѧ��ѡ��';
end;
//--------------��ʾ���α��ѯ������-------------------
procedure Tmain.N7Click(Sender: TObject);
var
newform:TSchedule;
begin
 if FindForm('�α��ѯ')=false then
  newform:=TSchedule.Create(application);
  newform.Caption:='�α��ѯ';
end;
//--------------��ʾ���ɼ����롿����-------------------
procedure Tmain.N8Click(Sender: TObject);
var
newform:TScore;
begin
 if FindForm('�ɼ�����')=false then
  newform:=TScore.Create(application);
  newform.Caption:='�ɼ�����';
end;
//--------------��ʾ����ӡ�ɼ���������-------------------
procedure Tmain.N10Click(Sender: TObject);
var
newform:TPrintScore;
begin
 if FindForm('��ӡ�ɼ���')=false then
  newform:=TPrintScore.Create(application);
  newform.Caption:='��ӡ�ɼ���';
end;

end.
