unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    Memo1: TMemo;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
uses IdHTTP;

function GetWebPageHTML(URL: string): string;
var 
 IDHTTP: TIDHttp;
begin
 Result:= '';
 IDHTTP:= TIDHTTP.Create(nil);
 try
   try
    // idhttp.Request.UserAgent:='IE7.0';        //�ٶ������������Ϣ
     idhttp.HandleRedirects:= true;                //����֧���ض��������ܳ���
     idhttp.ReadTimeout:= 20000;                   //�������ʱ�����ٷ���
     Result:= IDHTTP.Get(URL);//ȡ����ҳ����

   except
   end;
 finally
   IDHTTP.Free; 
 end;
end;


procedure TForm1.BitBtn1Click(Sender: TObject);
begin
//Edit1.Text:=GetWebPageHTML('http:\\www.kuai115.com');
Memo1.Lines.Text:= GetWebPageHTML(Edit1.text);
//Memo1.Lines.Text:= utf8toansi(GetWebPageHTML(Edit1.text));  //utf8toansi ����
end;

end.
