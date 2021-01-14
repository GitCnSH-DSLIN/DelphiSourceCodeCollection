unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,registry,ActiveX,Comobj,Shlobj;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
const
  IID_IPersistFile: TGUID =
  (D1:$0000010B;D2:$0000;D3:$0000;D4:($C0,$00,$00,$00,$00,$00,$00,$46));
function GetShellFolder (const folder: string):string;
const
  cWin32='SOFTWARE\Microsoft\Windows\CurrentVersion';
  cSHellPrefix = '\Explorer\Shell Folders';
var
  r:TRegistry;
begin
  Result:='';
  r:=TRegistry.Create;
 //��������
  try
    r.Rootkey:=HKEY_CURRENT_USER;
    //ֻҪ��Windows95�����Ժ�汾���˴���һ��
    if r.OpenKey (cWin32 + cShellPrefix, False) then
    //�򿪼�����ʼ��ȡ
     Result:= r.ReadString (folder) + '\';
  finally
    r.Free;
   //�ͷŴ����Ķ���
  end;
end;

function CreateLink(aPathObj,aPathLink,aDesc: string): boolean;
var
  sLink: IShellLink;
  PersFile: IPersistFile;
begin
  Result := false;
  if SUCCEEDED(CoCreateInstance(CLSID_ShellLink, nil,
               CLSCTX_INPROC_SERVER, IID_IShellLinkA, sLink)) then
 //�����ӿ�ʵ���ɹ�
  begin
    sLink.SetPath(PChar(aPathObj));
  //����Ҫ������ݷ�ʽ�ĳ���·�������ļ���
    sLink.SetDescription(PChar(aDesc));
    //���öԿ�ݷ�ʽ��������Ϣ
    if SUCCEEDED(sLink.QueryInterface(IID_IPersistFile,PersFile)) then
    //��ѯ�ӿڳɹ�
    begin
      PersFile.Save(StringToOLEStr(aPathLink),TRUE);
      //�����ݷ�ʽ
      Result := true;
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if not CreateLink(Application.ExeName,
                    GetShellFolder('Desktop')+'mylink.lnk','�ҵĿ�ݷ�ʽ') then
 //����GetShellFolder��ȡϵͳ�����ļ���·��
  begin
    Showmessage('������ݷ�ʽʧ��');
  end;
end;

end.
 