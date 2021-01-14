program HMIS;

uses
  Forms,
  Main in 'Main.pas' {F_Main},
  DataModule in 'DataModule.pas' {DM: TDataModule},
  Assistant in 'Assistant.pas' {F_Assis},
  CDrug in 'CDrug.pas' {F_CDrug},
  Query in 'Query.pas' {F_Query},
  MonthCalendar in 'MonthCalendar.pas' {F_Date},
  CMoney in 'CMoney.pas' {F_CMoney},
  CRegister in 'CRegister.pas' {F_CReg},
  CRPrint in 'CRPrint.pas' {F_CRPrint},
  HRegister in 'HRegister.pas' {F_HReg},
  PInput in 'PInput.pas' {F_Input},
  PKucun in 'PKucun.pas' {F_Kucun},
  OnDuty in 'OnDuty.pas' {F_ODuty},
  Person in 'Person.pas' {F_Person},
  Pass_Pope_Modify in 'Pass_Pope_Modify.pas' {F_PP_Modi},
  Crypt in 'Crypt.pas',
  URegister in 'URegister.pas' {F_Register},
  AboutBox in 'AboutBox.pas' {F_AboutBox},
  Config in 'Config.pas' {F_Config},
  LogOn in 'LogOn.pas' {F_LogOn},
  Login in 'Login.pas' {F_Login};

{$R *.res}

begin
  Application.Initialize;

  F_LogOn := TF_LogOn.Create(Application);  //��̬���������¼���洰��
  F_LogOn.Show; //��ʾ�����¼���洰�ڣ����ҳ�������ִ�У�������Բ�����ShowModal������
  F_LogOn.Update; //ˢ����ʾ

  Application.Title := 'ҽԺ��Ϣϵͳ';
  Application.HelpFile := 'D:\Program Files\Borland\Delphi6\Projects\HMIS\Help\HELP_HMIS.HLP';
  Application.CreateForm(TF_Main, F_Main);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TF_Date, F_Date);
  Application.CreateForm(TF_Query, F_Query);
  Application.CreateForm(TF_Register, F_Register);
  Application.CreateForm(TF_Login, F_Login);
  F_Login.ShowModal; //��ʾ�û���¼����
 //F_Login.Free;      //�ͷŵ�¼�������

  F_LogOn.Close;  //�ر������¼���洰��
  F_LogOn.Free;   //�ͷ������¼����ռ�õ��ڴ�ռ�

  Application.Run;
 end.
