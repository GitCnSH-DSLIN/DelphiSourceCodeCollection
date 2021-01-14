unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, StdCtrls, ExtCtrls,jpeg, Animate,Zlib;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    ClientSocket1: TClientSocket;
    Timer1: TTimer;
    Button3: TButton;
    Panel1: TPanel;
    AnimatedImage1: TAnimatedImage;
    Bevel1: TBevel;
    Label2: TLabel;
    RadioButton1: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ClientSocket1Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
Form1: TForm1;
c:longint;
m:tmemorystream;
ff:boolean;
implementation
uses Unit3;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
try
clientsocket1.Close;
clientsocket1.Host:=edit1.text;
clientsocket1.Open; //���ӷ����
except
showmessage(edit1.text+#13#10+'δ������δ��װ�������');
end;
//Timer1.Enabled:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
//clientsocket1.Socket.SendText('gets');
//clientsocket1.Socket.SendText('gets'); //�������룬֪ͨ�������Ҫ��Ļͼ��
Timer1.Enabled:=true;
//clientsocket1.Socket.SendText('gets'); //�������룬֪ͨ�������Ҫ��Ļͼ��
end;

procedure TForm1.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
caption:='���ӵ�'+edit1.text;
end;

procedure TForm1.ClientSocket1Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
caption:='����'+edit1.text+'ʧ��';
showmessage(edit1.text+#13#10+'δ������δ��װ�������');
errorcode:=0;
end;

procedure TForm1.ClientSocket1Read(Sender: TObject;
  Socket: TCustomWinSocket);
var
buffer:array [0..20000] of byte; //���ý��ջ�����
len:integer;
ll:string;
b:tbitmap;
j:tjpegimage;
begin
try
if c=0 then //CΪ����˷��͵��ֽ��������Ϊ0��ʾΪ��δ��ʼͼ�����
begin
ff:=false;
ll:=socket.ReceiveText;
c:=strtoint(ll); //��������յ��ֽ���
clientsocket1.Socket.SendText('okok'); //֪ͨ����˿�ʼ����ͼ��
end else
begin //����Ϊͼ�����ݽ��ղ���
len:=socket.ReceiveLength; //����������
socket.ReceiveBuf(buffer,len); //�������ݰ������뻺������
m.Write(buffer,len); //׷������M��
if m.Size>=c then //��������ȴ�������յ��ֽ�������������
begin
ff:=true;
m.Position:=0;
b:=tbitmap.Create;
j:=tjpegimage.Create;
try
j.LoadFromStream(m); //����M�е����ݶ���JPGͼ�����J��
b.Assign(j); //��JPGתΪBMP
//Image1.Picture.Bitmap.Assign(b); //�����image1Ԫ��
//Image1.Picture.Bitmap:=b;
AnimatedImage1.Glyph.Assign(b);
finally //����Ϊ�������
b.free;
j.free;
//clientsocket1.Socket.SendText('gets');
clientsocket1.Active:=false;
clientsocket1.Active:=true;
m.Clear;
c:=0;
end;
end;
end;
except
end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
m:=tmemorystream.Create;
Button1.Click;
ff:=true;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
m.free;
ClientSocket1.Close;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
if ff then
begin
if RadioButton1.Checked then
clientsocket1.Socket.SendText('gets') else
clientsocket1.Socket.SendText('gets1');
end;
 //�������룬֪ͨ�������Ҫ��Ļͼ��
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
Timer1.Enabled:=false;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
Timer1.Enabled:=false;
//stopThread;
end;



end.
