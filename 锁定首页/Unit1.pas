unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Registry, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  hKey: string;
  hReg: TRegIniFile;
begin
  hReg := TRegIniFile.Create('');
  //TregIniFile��Ķ�����Ҫ����
  hReg.RootKey := HKEY_CLASSES_ROOT;
  hReg.OpenKey('CLSID\{871C5380-42A0-1069-A2EA-08002B30309D}\shell\OpenHomePage\Command',False);
  //���ø���

  hReg.WriteExpandString('','"%ProgramFiles%\Internet Explorer\iexplore.exe"'+edit1.text );
                  //���������ݣ�����Ϊ�ó���ľ���·����������������
  hReg.destroy;
  //�ͷŴ�����hReg
  ShowMessage('������ɣ�');
end;

end.
