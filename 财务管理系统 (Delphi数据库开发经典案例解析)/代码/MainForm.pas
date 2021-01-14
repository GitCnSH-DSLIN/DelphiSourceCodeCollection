//---------------------------------------------------------
// ���ݿ⿪������ʵ������  �廪��ѧ������

unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, DB, ADODB, StdCtrls;
type
  Ttable=array[0..2] of string;
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
    N12: TMenuItem;
    N13: TMenuItem;
    N15: TMenuItem;
    StatusBar1: TStatusBar;
    ADOQuery3: TADOQuery;
    ADOCommand1: TADOCommand;
    ADOQuery1: TADOQuery;
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N15Click(Sender: TObject);



  private
    { Private declarations }
  public
    { Public declarations }
    //para���ڱ���ϵͳ������FindForm����Ѱ��MDI�Ӵ��壬setpara���ڸ���para��ֵ
    para:Ttable;
    function FindForm(caption:string):bool;
    procedure setpara();
  end;

var
  main: Tmain;
  para:Ttable;

implementation

{$R *.dfm}
uses SecSettingForm,AccountSettingForm,DocuInputForm,TotalAccountForm,DetailAccountForm,SumAccountForm,FinalReportForm;

//-------------------ͨ���û�����ĺ������жϴ����Ƿ��Ѵ���--------------------
function Tmain.FindForm(caption: string): bool;
var
i:integer;
begin
 for i:=0 to main.MDIChildCount do
  begin
   // ͨ���Դ�������жϴ����Ƿ����
    if main.MDIChildren[i].Caption=caption then
     begin
      //��������Ѵ��ڣ���ָ����壬������true
      SendMessage(mdichildren[i].Handle, WM_SYSCOMMAND, SC_restore, 0);
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

//----�ú����������Ǳ���ϵͳ�������еĲ��������ڵ���ǰ����---
procedure Tmain.setpara;
var
 i:integer;
begin
  adoquery3.Active:=false;
  adoquery3.Active:=true;
  i:=0;
while not adoquery3.Eof do
 begin
  //����ϵͳ����
  para[i]:=adoquery3.FieldByName('ȡֵ').AsString;
  i:=i+1;
  adoquery3.Next;
 end;
end;


//----------------��ʾ��ƿ�Ŀ���ô���-------------------
procedure Tmain.N2Click(Sender: TObject);
var
newform:TSecSetting;
begin
if findForm('��ƿ�Ŀ����')=false then
 begin
   //�����岻���ڣ��򴴽�����
   newform:=Tsecsetting.Create(application);
   newform.Caption:='��ƿ�Ŀ����';
  end;
end;
//----------------��ʾ�ʻ����ô���-------------------
procedure Tmain.N3Click(Sender: TObject);
var
newform:TaccountSetting;
begin
 if findForm('�ʻ����ã��ڳ�����¼�룩')=false then
 begin
   //�����岻���ڣ��򴴽�����
   newform:=TaccountSetting.Create(application);
   newform.Caption:='�ʻ����ã��ڳ�����¼�룩';
  end;
end;

//----------------��ʾƾ֤���ô���-------------------
procedure Tmain.N5Click(Sender: TObject);
var
newform:TDocuInput;
begin
  if findForm('���ƾ֤����')=false then
   begin
    //�����岻���ڣ��򴴽�����
    newform:=Tdocuinput.Create(application);
    newform.Caption:='���ƾ֤����';
   end;
end;




//----------------��ʾ�ܷ����ʲ�ѯ����-------------------
procedure Tmain.N8Click(Sender: TObject);
var
newform:Ttotalaccount;
begin
  if findForm('�ܷ����ʲ�ѯ')=false then
   begin
    //�����岻���ڣ��򴴽�����
    newform:=Ttotalaccount.Create(application);
    newform.Caption:='�ܷ����ʲ�ѯ';
   end;
end;
//----------------��ʾ��ϸ�ʲ�ѯ����-------------------
procedure Tmain.N9Click(Sender: TObject);

var
newform:Tdetailaccount;
begin
  if findForm('��ϸ�ʲ�ѯ')=false then
   begin
    //�����岻���ڣ��򴴽�����
    newform:=Tdetailaccount.Create(application);
    newform.Caption:='��ϸ�ʲ�ѯ';
   end;
end;


//----------------��ʾ����ƽ�����-------------------
procedure Tmain.N11Click(Sender: TObject);
var
newform:Tsumaccount;
begin
  if findForm('����ƽ���(��ʽʹ��)')=false then
   begin
    //�����岻���ڣ��򴴽�����
    newform:=Tsumaccount.Create(application);
    newform.Caption:='����ƽ���(��ʽʹ��)';
    //����ʽƽ�����ʹ��
    newform.foruse;
   end;
end;

//----------------ִ��ƾ֤���ʴ������---------------------
procedure Tmain.N6Click(Sender: TObject);
var
pnum,inputsum,outputsum:string;
begin

if application.MessageBox('ƾ֤���ʺ󼴲����޸ģ��Ƿ�ȷ�Ϲ��ʣ�','ȷ��',MB_OKCANCEL)=IDOK then
begin
//��÷�¼���е�ͳ������
adoquery1.Active:=false;
adoquery1.Active:=true;
pnum:=adoquery1.FieldByName('ƾ֤��').AsString;
inputsum:=adoquery1.FieldByName('�跽���').AsString;
outputsum:=adoquery1.FieldByName('�������').AsString;
//ִ�д�����̣�ʵ��ƾ֤����
try
adocommand1.CommandText:='exec sf_ƾ֤����';
adocommand1.Execute;
except
showmessage('����ʧ��');
exit;
end;
//��ʾ�ɹ���Ϣ������ʾͳ������
showmessage('���ʳɹ�'+#13+#13+'����ƾ֤��ĿΪ:'+pnum+#13+'�跽���ϼ�:'+inputsum+#13+'�������ϼ�'+outputsum);
//ɾ����¼���ƾ֤��
adocommand1.CommandText:='delete from ��¼��';
adocommand1.Execute;
adocommand1.CommandText:='delete from ƾ֤��';
adocommand1.Execute;
end;
end;


//-----ִ����ĩ���ʵĴ������--------
procedure Tmain.N12Click(Sender: TObject);
begin

 if application.MessageBox('���ʽ�������һ������ڼ䣬�Ƿ���ʣ�','ȷ��',MB_OKCANCEL)=IDOK then
 begin
  try
   adocommand1.CommandText:='exec sf_��ĩ����';
   adocommand1.Execute;
  except
    showmessage('����ʧ��');
    exit;
  end;
 showmessage('���ʳɹ�');
 end;
end;

//--------�ʲ���ծ��������ɺʹ�ӡ----------
procedure Tmain.N13Click(Sender: TObject);
var
index:integer;
inputstring:string;
newform:TFinalReport;
begin
 //ȡ�õ�ǰ����ڼ��ֵ
 setpara();
 index:=strtoint(para[2]);
 //��ʾ�û�����Ҫ��ʾ�Ļ���ڼ�
 inputstring:= InputBox('��ѡ����Ҫͳ�ƵĻ���ڼ�', '����ڼ�', inttostr(index-1));
 index:=strtoint(inputstring);
 //�����ʲ���ծ��
 adocommand1.CommandText:='exec sf_�����ʲ���ծ�� '''+inputstring+'''';
 adocommand1.Execute;

 //��ʾ�����壬���ﲻ��Ҫ�ٲ����Ƿ����б�����
 //��Ϊÿ�ε��õı����嶼������ʾ��ͬ�Ļ���ڼ�
 newform:=TFinalReport.Create(application);
 newform.SetPeriod(index);
 newform.QuickRep1.Preview;
end;

//------�رմ���--------------------
procedure Tmain.N15Click(Sender: TObject);
begin
close;
end;


end.
