program accesscp;

uses
  Forms,
  uFrmMain in 'uFrmMain.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ѹ��Access���ݿ�ĳ��� V1.0';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
