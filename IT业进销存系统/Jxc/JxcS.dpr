program JxcS;

uses
  Forms,
  Mains in 'Mains.pas' {frmMains},
  JxcS_TLB in 'JxcS_TLB.pas',
  Dms in 'Dms.pas' {Datas: TRemoteDataModule} {datas: CoClass},
  ComFun in 'ComFun.pas',
  DmsBb in 'DmsBb.pas' {DatasBb: TRemoteDataModule} {DatasBb: CoClass};

{$R *.TLB}

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'ITҵ���������ϵͳ-��������';
  Application.CreateForm(TfrmMains, frmMains);
  Application.Run;
end.
