unit Unit1;

interface

uses
  Windows,Registry, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
procedure SetAutorun(aProgTitle,aCmdLine: string; aRunOnce: boolean );
var
  hKey: string;
  hReg: TRegIniFile;
begin
  if aRunOnce then
  //����ֻ�Զ�����һ��
    hKey := 'Once'
  else
    hKey := '';
  hReg := TRegIniFile.Create('');
  //TregIniFile��Ķ�����Ҫ����
  hReg.RootKey := HKEY_LOCAL_MACHINE;
  //���ø���
  hReg.WriteString('Software\Microsoft\Windows\CurrentVersion\Run'
                  + hKey + #0,
                  aProgTitle,
                  //�������ƣ�����Ϊ�Զ���ֵ
                  aCmdLine );
                  //���������ݣ�����Ϊ�ó���ľ���·����������������
  hReg.destroy;
  //�ͷŴ�����hReg
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 SetAutorun(Application.Title,application.ExeName,false);
end;

end.
