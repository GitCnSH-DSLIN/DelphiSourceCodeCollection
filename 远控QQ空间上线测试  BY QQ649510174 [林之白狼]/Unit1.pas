unit Unit1;


{***************Զ�̿������QQ�ռ�����Դ��********************}

{author:��֮���� QQ:649510174

ԭ����QQ�ռ��з���һƪ���ӣ����ݸ�ʽ���ҵ�IP��ַ�ǣ�*117.43.74.110*
      ����IDHTTP�ؼ���ȡ��������ҳԴ��
      �������Ӧ��IP��ַ
      Ҫ�����������ߵĻ���ֱ����Դ���������һ�����������ĺ������У�
      ��������ٶȿռ䡢�������߶�һ����ԭ��

      HTTP://WWW.365SEC.NET

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, jpeg, ExtCtrls,ShellAPI;

type
  TForm1 = class(TForm)
    mmo1: TMemo;
    btn1: TBitBtn;
    edtip: TEdit;
    btn2: TBitBtn;
    edtUrl: TEdit;
    lbl1: TLabel;
    idhtp1: TIdHTTP;
    img1: TImage;
    lbl2: TLabel;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure img1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
   ShellExecute(0,'open',PChar(edtUrl.Text),0,0,SW_SHOWMAXIMIZED);
   Sleep(100);
  mmo1.Clear;
  mmo1.Lines.Add(idhtp1.Get(Trim(edtUrl.Text)));
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  tmpStr : WideString;
  i,j:Integer;
begin
  tmpStr := mmo1.Lines.Text;

  i:= Pos(',c:''',tmpStr);
  Delete(tmpStr,1,i+length(',c:''')-1);
  edtip.Text := Copy(tmpStr,1,Pos('''}',tmpStr)-1)


end;

procedure TForm1.img1Click(Sender: TObject);
begin
  ShellExecute(0,'open','www.365sec.net',0,0,SW_SHOWMAXIMIZED);
end;

end.
