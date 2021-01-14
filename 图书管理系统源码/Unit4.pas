unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ADODB, DB, ExtCtrls, JPEG, IniFiles, XPMenu;

type
  TForm4 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    XPMenu1: TXPMenu;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    int_login:integer;     //���õ�½����
  public
    { Public declarations }
    bool_login:boolean;
  end;

var
  Form4: TForm4;

implementation
uses Myjiami, Unit6, Unit1;
{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
var
  ADOQuery1:TADOQuery;              //����ADOQUERY����
  IniFile1: TIniFile;  //INI�ļ���
  str_id :string;      //Ա�����
  str_humanid:string;  //Ȩ�ޱ��
  str_pwd:string;      //��ǰ�û�����
  bool_select:boolean;
  bool_update:boolean;
  bool_delete:boolean;
  bool_insert:boolean;
begin
  if (edit1.Text='') or (edit2.Text='') then
  begin
    MessageDlg('�û��������벻��Ϊ�գ���', mtInformation, [mbYes],0);
    exit;
  end;
  str_pwd:= edit2.Text ;
  edit2.Text:=Myjiami.editstrtomd(edit2.Text,'A');    //�������
  ADOQuery1:=TADOQuery.Create(self);
  ADOQuery1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+
                              extractfilepath(application.ExeName)+
                              'DATA\db_booksys.mdb;Persist Security Info=False';   //�����ַ���
  ADOQuery1.Close;           //�ر�QUERY
  ADOQuery1.SQL.Clear;       //���QUERY�е�SQL
  ADOQuery1.SQL.Add('select * from tab_login where user_name=:A and user_password=:B');  //����SQL���
  ADOQuery1.Parameters.ParamByName('A').Value:=Edit1.Text;        //��ֵ
  ADOQuery1.Parameters.ParamByName('B').Value:=edit2.Text;        //��ֵ
  ADOQuery1.Open;            //��SQL
  if ADOQuery1.RecordCount > 0 then
  begin
    str_id:=ADOQuery1.FieldValues['employer_id'];
    str_humanid:=ADOQuery1.FieldValues['human_id'];
    form1.Menu_enable;
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select * from tab_empinfo where employer_id=:A');
    ADOQuery1.Parameters.ParamByName('A').Value:=str_id ;
    ADOQuery1.Open;  //�õ�Ա������
    form6.str_oldpwd:=str_pwd;
    form1.StatusBar1.Panels[0].Text:='�����ߣ�';
    form1.StatusBar1.Panels[0].Text:=form1.StatusBar1.Panels[0].Text+ADOQuery1.FieldValues['emp_name'];
    form1.statusbar1.Panels[1].Text:='��½ʱ��:    '+formatdatetime('yyyy/mm/dd hh:nn:SS',now);//�õ���½ʱ��
    bool_login:=true;
    int_login:=0;
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add('select * from tab_human where human_id=:A');
    ADOQuery1.Parameters.ParamByName('A').Value:=str_humanid;
    ADOQuery1.Open;   //�õ���½�ߵ�Ȩ��
    bool_select:=ADOQuery1.FieldByName('human_select').AsBoolean;
    bool_insert:=ADOQuery1.FieldByName('human_insert').AsBoolean;
    bool_update:=ADOQuery1.FieldByName('human_update').AsBoolean;
    bool_delete:=ADOQuery1.FieldByName('human_delete').AsBoolean;
    form1.int_human:=0;
    form6.int_str_human:=0;
    if bool_select=true then
    begin
      form1.N8.Enabled:=true;
      form1.N13.Enabled:=true;
      form1.N18.Enabled:=true;
      form1.N34.Enabled:=true;
      form1.ToolButton11.Visible:=true;
      form1.ToolButton8.Visible:=true;
      form1.N21.Enabled:=true;
      form1.int_human:=2;
    end;
    if bool_insert=true then
    begin
      form1.N4.Enabled:=true;
      form1.N21.Enabled:=true;
      form1.N10.Enabled:=true;
      form1.N15.Enabled:=true;
      form1.ToolButton1.Visible:=true;
      form1.ToolButton11.Visible:=true;
      form1.ToolButton5.Visible:=true;
      form1.int_human:=2;
    end;
    if bool_update= true then
    begin
      form1.N5.Enabled:=true;
      form1.N11.Enabled:=true;
      form1.N16.Enabled:=true;
      form1.N21.Enabled:=true;
      form1.ToolButton2.Visible:=true;
      form1.ToolButton11.Visible:=true;
      form1.ToolButton6.Visible:=true;
      form1.int_human:=2;
    end;
    if bool_delete=true then
    begin
      form1.N6.Enabled:=true;
      form1.N12.Enabled:=true;
      form1.N17.Enabled:=true;
      form1.N21.Enabled:=true;
      form1.ToolButton3.Visible:=true;
      form1.ToolButton11.Visible:=true;
      form1.ToolButton7.Visible:=true;
      form1.int_human:=2;
    end;
    if (bool_select) and (bool_insert=true) and (bool_update=true) and (bool_delete=true) then
    begin
      form1.N20.Enabled:=true;
      form1.N21.Enabled:=true;
      form1.N22.Enabled:=true;
      form1.N32.Enabled:=true;
      form1.N24.Enabled:=true;
      form1.N25.Enabled:=true;
      form1.N35.Enabled:=true;
      form1.N36.Enabled:=true;
      form1.N37.Enabled:=true;
      form1.N39.Enabled:=true;
      form1.int_human:=1;
      form6.int_str_human:=1;
    end;
    form1.form_panel4Click;
    form1.PageControl1.ActivePageIndex:=1;
    form6.Edit5.Text:=edit1.Text;
    form6.str_username:=edit1.Text;
    form4.Close;
  end
  else
  begin
    MessageDlg('�û������������'+#13+'����������!',mtWarning,[mbOK],0);
    edit1.Text:='';
    edit2.Text:='';
    int_login:=int_login + 1;
    if int_login=1 then
    begin
      IniFile1:= TIniFile.Create(extractfilepath(application.ExeName)+'login.ini');  //����һ��INI�ļ�
      IniFile1.WriteInteger('loginlock','times',1);  //���ļ���д������
      IniFile1.Free;
      messagedlg('��ֻ�����λ����¼ϵͳ'+#13+'�����㻹�����λ��ᣡ��',mtWarning,[mbOK],0);
    end;
    IF int_login=2 then
    begin
      IniFile1:= TIniFile.Create(extractfilepath(application.ExeName)+'login.ini');  //����һ��INI�ļ�
      IniFile1.WriteInteger('loginlock','times',2);  //���ļ���д������
      IniFile1.Free;
      MessageDlg('���������һ�λ���'+#13+'���û������������'+#13+'��ϵͳ������������',mtWarning,[mbOK],0);
    end;
    if int_login=3 then   //��½����Ϊ3��ʱ����
    begin
      IniFile1:= TIniFile.Create(extractfilepath(application.ExeName)+'login.ini');  //����һ��INI�ļ�
      IniFile1.WriteString('loginlock','threetime','LOCK');  //���ļ���д������
       IniFile1.WriteInteger('loginlock','times',0);
      IniFile1.Free;
      MessageDlg('��������½����̫��'+#13+'ϵͳ������������'+#13+'�����������ϵ����',mtWarning,[mbOK],0);
      application.Terminate;  //���������˳�����
    end;
  end;
  form6.edit5.text:=edit1.Text;
  ADOQuery1.Free;
end;

procedure TForm4.FormCreate(Sender: TObject);
var
  JPEG:TJPEGImage;     //JPEGͼƬ��
  IniFile1: TIniFile;  //INI�ļ���
  s:string;
  int_superlogin:integer;
begin
//--------------������ͼƬ����--------
  JPEG:=TJPEGImage.Create ; //����TPicture�Ķ���ת��bitmap��JPEG
  //�������λͼ��ֱ������JPEG����
  JPEG.LoadFromFile(extractfilepath(application.ExeName)+'RES\login.jpg');
  image1.Picture.Assign(JPEG);
  image1.stretch:=true;
  image1.Enabled:=true;
  JPEG.Free;
//--------------������½INI�ļ�
  if FileExists(extractfilepath(application.ExeName)+'login.ini') then   //�ļ��Ƿ����
  begin         //�ļ�����
    IniFile1:= TIniFile.Create(extractfilepath(application.ExeName)+'login.ini');  //����һ��INI�ļ�
    s:=IniFile1.ReadString('loginlock','threetime',s);  //���ļ��ж�������
    int_superlogin:=IniFile1.ReadInteger('SUAD','auotlogin',int_superlogin);
    int_login := IniFile1.ReadInteger('loginlock','times',int_login);
    if int_superlogin<>1 then
    begin
      edit1.Text:='';
      edit2.Text:='';
    end;
    if int_login=1 then
    begin
      messagedlg('��ֻ�����λ����¼ϵͳ'+#13+'�����㻹�����λ��ᣡ��',mtWarning,[mbOK],0);
    end;
    IF int_login=2 then
    begin
      MessageDlg('���������һ�λ���'+#13+'���û������������'+#13+'��ϵͳ������������',mtWarning,[mbOK],0);
    end;
    if s = 'LOCK' then
    begin
      MessageDlg('��������½����̫��'+#13+'ϵͳ������������'+#13+'�����������ϵ����',mtWarning,[mbOK],0);
      application.Terminate;
    end
  end
  else
  begin          //�ļ�������
    IniFile1:= TIniFile.Create(extractfilepath(application.ExeName)+'login.ini');  //����һ��INI�ļ�
    IniFile1.WriteString('loginlock','threetime','OPEN');  //���ļ���д������
    IniFile1.WriteInteger ('loginlock','times',int_login);  //���ļ���д���¼����
    IniFile1.WriteInteger('SUAD','auotlogin',1);  //�Գ�����Ա�����
  end;
  IniFile1.Free;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if bool_login = false then
  begin
    application.Terminate;
  end;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  close;
end;

end.
