unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, ExtCtrls, Grids, DBGrids, XPMenu;

type
  TForm6 = class(TForm)
    Panel1: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Button1: TButton;
    Button2: TButton;
    Edit4: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    ComboBox1: TComboBox;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Button5: TButton;
    Label2: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Panel3: TPanel;
    Edit8: TEdit;
    Label9: TLabel;
    Button7: TButton;
    Image1: TImage;
    Button8: TButton;
    XPMenu1: TXPMenu;
    Button9: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label10: TLabel;
    Edit9: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    str_humanid:string;   //Ȩ�ޱ��
    function userExist(s:string ): boolean;  //�û��Ƿ����
  public
    { Public declarations }
    ADOQuery_1:TADOQuery;
    DataSource_1: TDataSource;
    str_oldpwd : string;   //������
    str_username : string;  //��½�û���
    int_str_human : integer;  //�Ƿ��ǳ�������Ա  0���ǣ�1��
    procedure clear_checkbox();
  end;

var
  Form6: TForm6;
  //ADOQuery_1:TADOQuery;
  //DataSource_1: TDataSource;
implementation
uses Myjiami;
{$R *.dfm}

procedure TForm6.Button1Click(Sender: TObject);
var
  ADOQuery:TADOQuery;
begin
//--------------�û����������Ƿ�Ϊ��-----
  if (edit2.Text='') or (edit3.Text='') then
  begin
    MessageDlg('�û��������벻��Ϊ�գ���',mtInformation,[mbOK],0);
    exit;
  end;
//--------------�ж��û����Ƿ����-------
  if userExist(edit1.text) then
  begin
    edit1.Text:='';
    exit;
  end;
//--------------�ж���������������Ƿ���ͬ---
  if edit3.Text<>edit2.Text then
  begin
    MessageDlg('�������벻һ�����������룡��',mtInformation,[mbOK],0);
    edit2.Text:='';
    edit3.Text:='';
    exit;
  end;
//--------------���û��ı������---------
  ADOQuery:=TADOQuery.Create(self);
  ADOQuery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+
                              extractfilepath(application.ExeName)+
                              'DATA\db_booksys.mdb;Persist Security Info=False';   //�����ַ���
  ADOQuery.Close;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('select login_id from tab_login');
  ADOQuery.Open;
  ADOQuery.Last;
  edit4.Text:=Myjiami.db_idtoadd(ADOQuery.FieldValues['login_id'],10);
//-------------����һ���û�--------------
  edit2.Text:=Myjiami.editstrtomd(edit2.Text,'A');   //�������
  ADOQuery.Close;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('insert into tab_login (login_id,user_name,user_password,human_id,employer_id) values (:A,:S,:D,:F,:G)');
  ADOQuery.Parameters.ParamByName('A').Value:=edit4.Text;//##**
  ADOQuery.Parameters.ParamByName('S').Value:=edit1.Text;
  ADOQuery.Parameters.ParamByName('D').Value:=edit2.Text;
  ADOQuery.Parameters.ParamByName('F').Value:=edit4.Text;
  ADOQuery.Parameters.ParamByName('G').Value:=combobox1.Text;
  try
    ADOQuery.ExecSQL;
    ADOQuery.Close;
    ADOQuery.SQL.Clear;
    ADOQuery.SQL.Add('insert into tab_human (human_id) values (:A)');
    ADOQuery.Parameters.ParamByName('A').Value:=edit4.Text;//##**
    ADOQuery.ExecSQL;//��Ȩ�ޱ�����Ӽ�¼
    str_humanid:=edit4.Text;
    MessageDlg('�û������ɹ�����'+#13+'��������Ը�����û���Ȩ�ˣ�'+#13+'�����Ժ���Ȩ����',mtInformation,[mbOK],0);
    button9.Enabled:=true;
  except
    MessageDlg('�����û�ʧ�ܣ���',mtWarning,[mbOK],0);
  end;
  ADOQuery.Free;
end;
//�û��Ƿ���ڵĺ���
function TForm6.userExist(s:string): boolean;
var
  ADOQuery:TADOQuery;
begin
  ADOQuery:=TADOQuery.Create(self);
  ADOQuery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+
                              extractfilepath(application.ExeName)+
                              'DATA\db_booksys.mdb;Persist Security Info=False';   //�����ַ���
  ADOQuery.Close;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('select user_name from tab_login where user_name=:A');
  ADOQuery.Parameters.ParamByName('A').Value:=s;
  ADOQuery.Open;
  result:= False;//Ĭ�Ϸ���False
  if ADOQuery.RecordCount>0 then
  begin
    MessageDlg('�û������ڣ���ѡ�������û�����', mtInformation,[mbOk], 0);
    result := true;
  end;
  ADOQuery.Free;
end;

//���崴������COMBOBOX���������
procedure TForm6.FormCreate(Sender: TObject);
var
  ADOQuery:TADOQuery;
  i:integer;
  Pic:TPicture;
begin
//--------------ͼƬ����--------
  Pic:=TPicture.Create;//����TPicture�Ķ���ת��bitmap��JPEG
  //�������λͼ��ֱ������JPEG����
  Pic.LoadFromFile(extractfilepath(application.ExeName)+'RES\bmp3.bmp');
  image1.Picture.Assign(Pic.Bitmap);
  image1.stretch:=true;
  image1.Enabled:=true;
  Pic.Free;
//--------------------------------
  ADOQuery_1:=TADOQuery.Create(self);
  DataSource_1:= TDataSource.Create(self);
  ADOQuery_1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+
                              extractfilepath(application.ExeName)+
                              'DATA\db_booksys.mdb;Persist Security Info=False';   //�����ַ���
//--------------------------------
  ADOQuery:=TADOQuery.Create(self);
  ADOQuery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+
                              extractfilepath(application.ExeName)+
                              'DATA\db_booksys.mdb;Persist Security Info=False';   //�����ַ���
  ADOQuery.Close;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('select employer_id from tab_empinfo');
  ADOQuery.Open;      //�õ�Ա�����
  if ADOQuery.RecordCount<0 then exit;  //���û�м�¼���˳�
  combobox1.Items.Clear;                //���COMBOBOX�е�����
  for i:=0 to (ADOQuery.RecordCount-1) do  //��COMBOBOX��ѭ���������
  begin
    combobox1.Items.Add(ADOQuery.FieldValues['employer_id']);   //��Ӽ�¼
    ADOQuery.Next;                         //�ƶ���¼
  end;
  ADOQuery.Free;
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
  ADOQuery_1.Close;
  ADOQuery_1.SQL.Clear;
  ADOQuery_1.SQL.Add('select * from tab_login');
  ADOQuery_1.Open;
  DataSource_1.DataSet:=ADOQuery_1;
  DBGrid1.DataSource:=DataSource_1;
  DBGrid1.Columns.Items[0].FieldName:='login_id';
  DBGrid1.Columns.Items[1].FieldName:='user_name';
  DBGrid1.Columns.Items[2].FieldName:='human_id';
  DBGrid1.Columns.Items[3].FieldName:='employer_id';
end;

procedure TForm6.Button5Click(Sender: TObject);
var
  ADOQuery:TADOQuery;
begin
  if (edit5.Text<> str_username) and (int_str_human = 0) then
  begin
    MessageDlg('����Ȩ�޸������˵����룡��',mtInformation, [mbYes],0);
    edit5.Text:='';
    exit;
  end;
  if (edit9.Text <> str_oldpwd)  and (int_str_human = 0) then
  begin
    MessageDlg('�����벻��ȷ��'+#13+'���������룡��',mtInformation, [mbYes],0);
    edit9.Text:='';
    exit;
  end;
  if (edit6.Text<>edit7.Text) or (edit6.Text='') then
  begin
    MessageDlg('�������벻һ�£�'+#13+'����Ϊ��'+#13+'���������룡��',mtInformation, [mbYes],0);
    edit6.Text:='';
    edit7.Text:='';
    exit;
  end;
  edit6.Text:=Myjiami.editstrtomd(edit6.text,'A');  //����EDIT�е��ַ���
  ADOQuery:=TADOQuery.Create(self);
  ADOQuery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+
                              extractfilepath(application.ExeName)+
                              'DATA\db_booksys.mdb;Persist Security Info=False';   //�����ַ���
  ADOQuery.Close;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('update tab_login set user_password=:A where user_name=:S');
  ADOQuery.Parameters.ParamByName('S').Value:=edit5.Text;
  ADOQuery.Parameters.ParamByName('A').Value:=edit6.Text;
  try
    ADOQuery.ExecSQL;
    MessageDlg('�����޸ĳɹ�����',mtInformation, [mbYes],0);
    edit5.Text:='';
    edit6.Text:='';
    edit7.Text:='';
  except
    MessageDlg('����ʧ�ܣ���',mtWarning, [mbYes],0);
  end;
  ADOQuery.Free;
end;
//�û�ɾ��
procedure TForm6.Button7Click(Sender: TObject);
var
  ADOQuery:TADOQuery;
begin
  if edit8.Text='' then
  begin
    MessageDlg('Ҫɾ�����û�������Ϊ�գ���',mtInformation, [mbYes],0);
    exit;
  end;
  ADOQuery:=TADOQuery.Create(self);
  ADOQuery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+
                              extractfilepath(application.ExeName)+
                              'DATA\db_booksys.mdb;Persist Security Info=False';   //�����ַ���
  ADOQuery.Close;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('select * from tab_login where user_name=:A');
  ADOQuery.Parameters.ParamByName('A').Value:=trim(edit8.Text);
  ADOQuery.Open;
  if ADOQuery.RecordCount<=0 then
  begin
    MessageDlg('�û��������޷�ɾ������',mtInformation, [mbYes],0);
    ADOQuery.Free;
    exit;
  end;
  ADOQuery.Close;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('delete from tab_login where user_name=:A');
  ADOQuery.Parameters.ParamByName('A').Value:=edit8.Text;
  if MessageDlg('��ȷ��Ҫɾ������û��𣡣�',mtInformation, [mbYes,mbNo],0)=mrYes then
  begin
    ADOQuery.ExecSQL;
    edit8.Text:='';
  end;
  ADOQuery.Free;
end;

procedure TForm6.Button8Click(Sender: TObject);
begin
  close;
end;

procedure TForm6.Button9Click(Sender: TObject);
var
  ADOQuery:TADOQuery;
begin
  ADOQuery:=TADOQuery.Create(self);
  ADOQuery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+
                              extractfilepath(application.ExeName)+
                              'DATA\db_booksys.mdb;Persist Security Info=False';   //�����ַ���
  ADOQuery.Close;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('update tab_human set human_select=:A,human_update=:S,human_delete=:D,human_insert=:F where human_id=:G');
  ADOQuery.Parameters.ParamByName('A').Value:=CheckBox1.Checked;
  ADOQuery.Parameters.ParamByName('S').Value:=CheckBox2.Checked;
  ADOQuery.Parameters.ParamByName('D').Value:=CheckBox4.Checked;
  ADOQuery.Parameters.ParamByName('F').Value:=CheckBox3.Checked;
  ADOQuery.Parameters.ParamByName('G').Value:=str_humanid ;
  try
    ADOQuery.ExecSQL;
    MessageDlg('���Ѿ��ɹ���Ϊ����û�������Ȩ�ޣ���',mtInformation, [mbYes],0);
  except
    MessageDlg('����ʧ�ܣ���',mtInformation, [mbYes],0);
  end;
  clear_checkbox;
  button9.Enabled:=false;
  ADOQuery.Free;
end;

procedure TForm6.clear_checkbox;
begin
  CheckBox1.Checked:=false;
  CheckBox2.Checked:=false;
  CheckBox3.Checked:=false;
  CheckBox4.Checked:=false;
end;

procedure TForm6.FormShow(Sender: TObject);
var
  ADOQuery:TADOQuery;
  i:integer;
begin
//--------------------------------
  ADOQuery:=TADOQuery.Create(self);
  ADOQuery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+
                              extractfilepath(application.ExeName)+
                              'DATA\db_booksys.mdb;Persist Security Info=False';   //�����ַ���
  ADOQuery.Close;
  ADOQuery.SQL.Clear;
  ADOQuery.SQL.Add('select employer_id from tab_empinfo');
  ADOQuery.Open;      //�õ�Ա�����
  if ADOQuery.RecordCount<0 then exit;  //���û�м�¼���˳�
  combobox1.Items.Clear;                //���COMBOBOX�е�����
  for i:=0 to (ADOQuery.RecordCount-1) do  //��COMBOBOX��ѭ���������
  begin
    combobox1.Items.Add(ADOQuery.FieldValues['employer_id']);   //��Ӽ�¼
    ADOQuery.Next;                         //�ƶ���¼
  end;
  edit1.Text:='';
  edit2.Text:='';
  edit3.Text:='';
  edit4.Text:='';
  edit6.Text:='';
  edit7.Text:='';
  edit8.Text:='';
  if int_str_human=1 then
  begin
    edit5.Text:='';
    edit9.Enabled:=false;
  end
  else
  begin
    edit9.Enabled:=true;
  end;
  edit9.Text:='';
  ADOQuery.Free;
end;

procedure TForm6.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
  key:=#10;
end;

end.
