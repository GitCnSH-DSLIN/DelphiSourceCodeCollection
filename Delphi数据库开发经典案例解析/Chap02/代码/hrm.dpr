program hrm;

uses
  Forms,
  MainDlg in 'MainDlg.pas' {main};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '������Դ����';
  Application.CreateForm(Tmain, main);
  Application.Run;
end.
