program BBS;

uses
  Forms,
  BBS_Unit in 'BBS_Unit.pas' {B};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�������Ա�';
  Application.CreateForm(TB, B);
  Application.Run;
end.
