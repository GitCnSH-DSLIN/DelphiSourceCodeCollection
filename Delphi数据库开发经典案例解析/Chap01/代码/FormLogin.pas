unit FormLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB;

type
  Tlogin = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    ADOQuery1: TADOQuery;
    Edit3: TEdit;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);

   
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    

    private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  login: Tlogin;

implementation

uses FormManage, FormInfo;

{$R *.dfm}

//--------------------------�������Զ���ʾ�û���-----------
procedure Tlogin.Edit3Exit(Sender: TObject);
begin
  adoquery1.Close;
 adoquery1.SQL.Clear;
 adoquery1.SQL.Add('select ���� from �û��嵥 where �û����='''+edit3.Text+'''');
 adoquery1.Open;
 edit1.Text:=adoquery1.fieldbyname('����').AsString;

end;

//---------------------�����ź�س��������ʺ������------------
procedure Tlogin.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then { �ж��ǰ�ִ�м�}
//ʵ����Ҳ���Ե���edit3��onexit������ʵ�֣���һ����
 begin
 adoquery1.Close;
 adoquery1.SQL.Clear;
 adoquery1.SQL.Add('select ���� from �û��嵥 where �û����='''+edit3.Text+'''');
 adoquery1.Open;
 edit1.Text:=adoquery1.fieldbyname('����').AsString;
 end;
end;


//------------������������ʱ�ɰ�enter��ִ�в�ѯ-----------
procedure Tlogin.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then { �ж��ǰ�ִ�м�}
button1.Click;
end;



//--------------�û���������У���¼ϵͳ--------------------------------------------------------------
procedure Tlogin.Button1Click(Sender: TObject);
var
num,user,pass,temp:string;

begin
//------------------�����û������������ʺŽ��в�ѯ----------
 //�����û�������ʺź�����
 user:=edit1.Text;
 pass:=Edit2.Text;
//ʹ��ADOQuery1���ʱҪ���ɺõ�ϰ�ߣ��Ƚ���رգ�
//��ԭ����SQL��������������µ�SQL���
 ADOQuery1.Close;
 ADOQuery1.SQL.Clear;
 ADOQuery1.SQL.Text:='select �û���� from �û��嵥 where ����='''+user+'''and ����='''+pass+'''';
 Adoquery1.Open;
 temp:=adoquery1.FieldByName('�û����').AsString;
 if temp<>'' then
 //�����������ȷ���û��������룬��ô��Ȼ�ܲ鵽�û���ţ�������Ϊ��
 begin

 //---------------�����û���õ�Ȩ����ȷ���ܷ������ش���-----------------------
//�Ƚ����а�ťʹ�ܶ���Ϊ��
    manage.Button1.Enabled:=false;
    manage.Button2.Enabled:=false;
    manage.Button3.Enabled:=false;
    manage.Button4.Enabled:=false;
    manage.Button5.Enabled:=false;
    info.N2.Enabled:=false;
    info.N3.Enabled:=false;
    info.N4.Enabled:=false;

//--------����û��Ƿ���н�����Ȩ�ޣ����ǣ��򽫽�������ť��Ϊ����----------
    adoquery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Text:='select Ȩ����� from Ȩ���嵥 where �û����='''+temp+'''and Ȩ������=''������''';
    Adoquery1.Open;
    if adoquery1.FieldByName('Ȩ�����').AsString<>'' then
    manage.Button2.Enabled:=true;

//-----------����û��Ƿ�������۵�Ȩ�ޣ����ǣ������۵���ť��Ϊ����---------------
    adoquery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Text:='select Ȩ����� from Ȩ���嵥 where �û����='''+temp+'''and Ȩ������=''���۵�''';
    Adoquery1.Open;
    if adoquery1.FieldByName('Ȩ�����').AsString<>'' then
    manage.Button3.Enabled:=true;

//------------����û��Ƿ���п���ѯȨ�ޣ����ǣ��򽫿�����ť�ÿ���--------
    adoquery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Text:='select Ȩ����� from Ȩ���嵥 where �û����='''+temp+'''and Ȩ������=''����ѯ''';
    Adoquery1.Open;
    if adoquery1.FieldByName('Ȩ�����').AsString<>'' then
    manage.Button4.Enabled:=true;

//----------����û��Ƿ����Ȩ�޹���Ȩ�ޣ����ǣ���Ȩ�޹���ť��Ϊ����---------
    adoquery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Text:='select Ȩ����� from Ȩ���嵥 where �û����='''+temp+'''and Ȩ������=''Ȩ�޹���''';
    Adoquery1.Open;
    if adoquery1.FieldByName('Ȩ�����').AsString<>'' then
    manage.Button5.Enabled:=true;

//---------����û��Ƿ������Ʒ����ά��Ȩ�ޣ����ǣ�������ά����ť����Ʒ����ά���˵���Ϊ����----------------------
    adoquery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Text:='select Ȩ����� from Ȩ���嵥 where �û����='''+temp+'''and Ȩ������=''��Ʒ����ά��''';
    Adoquery1.Open;
    if adoquery1.FieldByName('Ȩ�����').AsString<>'' then
    begin
    info.N2.Enabled:=true;
    manage.Button1.Enabled:=true
    end;

//-------����û��Ƿ���й���������ά��Ȩ�ޣ����ǣ�������ά����ť�͹���������ά���˵��ÿ���------
    adoquery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Text:='select Ȩ����� from Ȩ���嵥 where �û����='''+temp+'''and Ȩ������=''����������ά��''';
    Adoquery1.Open;
    if adoquery1.FieldByName('Ȩ�����').AsString<>'' then
    begin
    info.N3.Enabled:=true;
    manage.Button1.Enabled:=true
    end;

//---------����û��Ƿ���пͻ�����ά��Ȩ�ޣ����ǣ�������ά����ť�Ϳͻ�����ά���˵���Ϊ����----
    adoquery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Text:='select Ȩ����� from Ȩ���嵥 where �û����='''+temp+'''and Ȩ������=''�ͻ�����ά��''';
    Adoquery1.Open;
    if adoquery1.FieldByName('Ȩ�����').AsString<>'' then
    begin
    info.N4.Enabled:=true;
    manage.Button1.Enabled:=true
    end;
//---------��¼�ɹ����ڹ������״̬���ϱ�ʾ��¼���û���---------------
  manage.Visible:=true;
  manage.StatusBar1.Panels[0].Text:=user;

  login.Hide;
 end
//---------��¼ʧ�ܣ���ʾ�û���������----------------------------------
  else
   begin
    ShowMessage('�û��������������������µ�¼');
   end

end;

//----------��¼�����ٴ���ʾʱ�����ԭ��������û���������--------------
procedure Tlogin.FormShow(Sender: TObject);
begin
edit1.Clear;
edit2.Clear;
end;







end.


