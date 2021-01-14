unit backup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Gauges, StdCtrls;

type
  Tbackup_From = class(TForm)
    Gauge1: TGauge;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  backup_From: Tbackup_From;
  DataFile: String;
implementation

{$R *.dfm}

procedure Tbackup_From.Button1Click(Sender: TObject);
var
  i: integer;
begin
DataFile := GetCurrentDir+'\date\super.mdb';
  try
    if not savedialog1.Execute then exit;
    if FileExists(savedialog1.FileName+'.mdb') then
    begin
      if Messagebox(handle,'�������ݿ��������Ƿ񸲸ǣ�','����ѡ��',mb_iconquestion+mb_yesno)=IDNo then Exit;
    end
    else
    begin
      for i:=Gauge1.MinValue to Gauge1.MaxValue do
        Gauge1.Progress := i;
      CopyFile(PChar(DataFile),PChar(SaveDialog1.FileName+'.mdb'),True);
      Messagebox(handle,'���ݿⱸ�ݳɹ���','��������',mb_iconinformation+mb_ok);
    end;
  except
    Messagebox(handle,'���棺���ݿⱸ��ʧ�ܣ�','���̴���',mb_iconwarning+mb_ok);
  end;
end;
procedure Tbackup_From.Button2Click(Sender: TObject);
var
  i: integer;
begin
DataFile := extractfilepath(application.exename)+'\date\super.mdb';
  try
    if not opendialog1.Execute then exit;
    if Messagebox(handle,'���棺���������п��ܶ�ʧ��ȷ����ԭ��','ȷ����ԭ',mb_iconquestion+mb_yesno)=IDNo then Exit;
    for i:=Gauge1.MinValue to Gauge1.MaxValue do
      Gauge1.Progress := i;
      CopyFile(PChar(OpenDialog1.FileName),PChar(DataFile),true);
      Messagebox(handle,'���ݿ⻹ԭ�ɹ���','��ԭ����',mb_iconinformation+mb_ok);
  except
    Messagebox(handle,'���棺���ݿ⻹ԭʧ�ܣ�','��ȡ����',mb_iconwarning+mb_ok);
  end;
end;

procedure Tbackup_From.Button3Click(Sender: TObject);
begin
close;
end;

end.
