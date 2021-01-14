unit DatabaseConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TF_DBConfig = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LEdit1: TLabeledEdit;
    LEdit2: TLabeledEdit;
    BB_Confirm: TBitBtn;
    BB_Cancel: TBitBtn;
    procedure BB_ConfirmClick(Sender: TObject);
    procedure BB_CancelClick(Sender: TObject);
    procedure LEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_DBConfig: TF_DBConfig;

implementation
uses  IniFiles, Config;
{$R *.dfm}

procedure TF_DBConfig.BB_ConfirmClick(Sender: TObject);
var    {*****ȷ����ť�����¼�*****}
    ini:TIniFile;
begin
    if (LEdit1.Text='')or(LEdit2.Text='') then
      begin
      ShowMessage('���������ݿ�������������ݿ���');
      LEdit1.SetFocus;  //���������ݿ�������������
      exit;
      end;
    //��INI�ļ�������������򴴽���Ӧ�ó���ͬ������׺��Ϊ.INI��ini�����ļ�
    ini := TIniFile.Create(ChangeFileExt(Application.ExeName,'.INI'));
    ini.WriteString('Database','Initial Catalog',LEdit2.Text);  //�����ݿ���д�������ļ�
    ini.WriteString('Database','Data Source',LEdit1.Text);      //�����ݿ��������д�������ļ�
    Close;  //�ر����ݿ���������ô���
end;

procedure TF_DBConfig.BB_CancelClick(Sender: TObject);
begin  {*****ȡ����ť�����¼�*****}
    Close;  //�ر����ݿ���������ô���
end;

procedure TF_DBConfig.LEdit2KeyPress(Sender: TObject; var Key: Char);
begin  {*****���ݿ����������������¼�*****}
    if (Key = #13) then        //���»س���ִ��
      BB_ConfirmClick(Self); //����ȷ����ť����¼�
end;

procedure TF_DBConfig.FormCreate(Sender: TObject);
var  {*****���ݿ���������ô��崴���¼�*****}
    pName : PChar;
    Size_Com : dword;
begin
    Size_Com := MAX_COMPUTERNAME_LENGTH + 1;
    if GetComputerName(pName, Size_Com) then  //GetComputerName��ȡ�ü������API����
      Label2.Caption := 'Ĭ��ֵ��' + pName;
end;

procedure TF_DBConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := caFree;
    F_Config := nil;
end;

end.
