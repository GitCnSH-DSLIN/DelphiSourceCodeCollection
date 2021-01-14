unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellApi;

const
  WM_EXIT_PROGRAM = WM_USER + 500;

type
  TMainForm = class(TForm)
    UpgradeButton: TButton;
    Label1: TLabel;
    procedure UpgradeButtonClick(Sender: TObject);
  private
    procedure WMExitProgram(var Message: TMessage); message WM_EXIT_PROGRAM;
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

//-----------------------------------------------------------------------------
// ����: ִ���Զ���������
//-----------------------------------------------------------------------------
procedure RunAutoUpgrader;
const
  SAutoUpgraderFileName = 'AutoUpgrader.exe';
  SScriptURL = 'http://localhost/script.aus';
  SCurVersion = '1.0';
  SSoftName = 'OwnerTest';
var
  FileName, Params: string;
begin
  FileName := ExtractFilePath(Application.ExeName) + SAutoUpgraderFileName;
  Params := Format('"%s" "%s" "%s" %d %d %d', [
    SScriptURL,                // �����ű��ļ���URL
    SCurVersion,               // ��������ĵ�ǰ�汾��
    SSoftName,                 // ����������������
    MainForm.Handle,           // ������������������Ϣ�Ĵ��ھ��
    WM_EXIT_PROGRAM,           // ���������յ�����Ϣ��Ӧ�˳�����
    GetCurrentProcessID        // ��������Ľ���ID 
    ]);
    
  ShellExecute(Application.Handle, nil, PChar(FileName), PChar(Params), '', SW_SHOW);
end;

{ TMainForm }

procedure TMainForm.UpgradeButtonClick(Sender: TObject);
begin
  RunAutoUpgrader;
end;

procedure TMainForm.WMExitProgram(var Message: TMessage);
begin
  Close;
end;

end.
