unit DBConnectFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, INIFiles;

type
  TfrmDBConnect = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtServerName: TEdit;
    edtDatabaseName: TEdit;
    edtUserName: TEdit;
    edtPassword: TEdit;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ReadFromIni(var aServerName, aDatabaseName, aUserName, aPassword: string);//��ȡ�����ļ���Ϣ
procedure WriteToIni(const aServerName, aDatabaseName, aUserName, aPassword: string);//�������ļ�д����Ϣ

function DBConnectExecute(aClass: TFormClass): boolean; //���ڴ򿪴��壬���ж��Ƿ����óɹ�

var
  Connected: Boolean;
implementation

uses  main,common;

{$R *.dfm}
//���ڴ򿪴��壬���ж��Ƿ����óɹ�
function DBConnectExecute(aClass: TFormClass): boolean;
begin
  with aClass.Create(Application) do
  begin
    try
      showModal;
    finally
      free;
      result := Connected;
    end;
  end;
end;

//��ȡ�����ļ���Ϣ
procedure ReadFromIni(var aServerName, aDatabaseName, aUserName, aPassword: string);
var
  IniFile: TIniFile;
  FileName: string;
begin
  FileName := ExtractFilePath(application.ExeName) + '\DB.ini';
  IniFile := TIniFile.Create(FileName);
  aServerName := IniFile.ReadString('DB', 'ServerName', '');
  aDatabaseName := IniFile.ReadString('DB', 'DatabaseName', '');
  aUserName := IniFile.ReadString('DB', 'UserName', '');
  aPassword := IniFile.ReadString('DB', 'Password', '');
  IniFile.Free;
end;

//�������ļ�д����Ϣ
procedure WriteToIni(const aServerName, aDatabaseName, aUserName, aPassword: string);
var
  IniFile: TIniFile;
  FileName: string;
begin
  FileName := ExtractFilePath(application.ExeName) + '\DB.ini';
  IniFile := TIniFile.Create(FileName);
  IniFile.WriteString('DB', 'ServerName', aServerName);
  IniFile.WriteString('DB', 'DatabaseName', aDatabaseName);
  IniFile.WriteString('DB', 'UserName', aUserName);
  IniFile.WriteString('DB', 'Password', aPassword);
  IniFile.Free;
end;

//д��ini���������Ƿ�������
procedure TfrmDBConnect.btnOKClick(Sender: TObject);
begin
  writeToIni(edtServerName.Text, edtDatabaseName.Text, edtUserName.Text, edtPassword.Text);
  if ConnectLocalDB(frmmain.ADOConnect,edtDatabaseName.Text,edtServerName.Text,edtUserName.Text, edtPassword.Text) then
  begin
    Application.MessageBox('���ӳɹ�', '��ʾ', mb_iconInformation + mb_defbutton1);
    Connected := True;
    Close;
  end
  else
  begin
    Application.MessageBox('����ʧ��', '��ʾ', mb_iconInformation + mb_defbutton1);
  end;
end;

//�����屻����ʱ���������ļ���Ϣ��ʾ��������
procedure TfrmDBConnect.FormCreate(Sender: TObject);
var
  serverName, databaseName, userName, password: string;
begin
  readFromIni(serverName, databaseName, userName, password);
  Connected := False;
  edtservername.Text :=servername;
  edtdatabasename.Text := databaseName;
  edtUserName.Text :=userName;
  edtPassword.Text := password;
  end;

procedure TfrmDBConnect.btnCancelClick(Sender: TObject);
begin
  close;
end;

end.

