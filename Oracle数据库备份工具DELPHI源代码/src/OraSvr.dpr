program OraSvr;

uses
  Forms,
  UMain in 'UMain.pas' {FrmMain},
  UNTService in 'UNTService.pas';

{$R *.RES}

begin   
  if StartNTService('OracleBackupService', 'Oracle�����Զ����ݷ���') then
  begin
    NTService.CreateForm(TFrmMain, FrmMain);
    NTService.Run;
    Exit;
  end;

{  Application.Initialize;
  Application.Title := 'Oracle�����Զ����ݷ���';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;  }
end.
