unit UntSrv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp;

type
  TFrmSrv = class(TForm)
    SrvSocket: TServerSocket;
    gp1: TGroupBox;
    MemClientLink: TMemo;
    gb2: TGroupBox;
    gb3: TGroupBox;
    MemSendMsg: TMemo;
    btnSend: TButton;
    gp4: TGroupBox;
    MemClientMsg: TMemo;
    SrvSocket2: TServerSocket;
    SrvSocket1: TServerSocket;
    procedure SrvSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormCreate(Sender: TObject);
    procedure SrvSocketListen(Sender: TObject; Socket: TCustomWinSocket);
    procedure SrvSocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure SrvSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSendClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSrv: TFrmSrv;
  ClientHost:TList;
implementation

{$R *.dfm}
//�����ͻ���
procedure TFrmSrv.SrvSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  ClientHost.Add(Socket);
  MemClientLink.Lines.Add(Socket.RemoteHost+':'+Socket.RemoteAddress);
end;

procedure TFrmSrv.FormCreate(Sender: TObject);
begin
  ClientHost:=TList.Create;
  MemClientLink.ReadOnly:=True;
end;
//�����ڽ�����������ʱ
procedure TFrmSrv.SrvSocketListen(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  MemClientLink.Lines.Add('Link...'+#13+Socket.RemoteHost+Socket.RemoteAddress);
end;
//���տͻ�����Ϣ
procedure TFrmSrv.SrvSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
Var
  Len : Word;
  Buf : Array of Char;
  Msg : String;
begin //���յ�һ����Ϣ��,��������һ��
  try
    Socket.ReceiveBuf(Len,2); //ǰ�����ֽڴ����Ϣ�����ݳ���
    if Len < 1 then Exit;
    SetLength(Buf,Len);
    Socket.ReceiveBuf(Buf[0],len);
    SetLength(Msg, len);
    Move(Buf[0], Msg[1], Len);
    MemClientMsg.Lines.Add(Socket.LocalHost+':'+Msg);
    MemClientMsg.Lines.Add(#13);
  except

  end;
end;
//�ͷſͻ���
procedure TFrmSrv.SrvSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  ClientHost.Remove(Socket);
end;
//�رմ���
procedure TFrmSrv.FormClose(Sender: TObject; var Action: TCloseAction);
Var
  I : Integer;
begin
  for i := 0 to ClientHost.Count-1 do ClientHost.Delete(i);
  FreeAndNil(ClientHost);
end;

procedure TFrmSrv.btnSendClick(Sender: TObject);
Var
  Len,I : Word;
  Buf : Array of Char;
  Msg : String;
begin
  if ClientHost.Count<=0 then
  begin
    MessageDlg('�Բ��𣬵�ǰû��һ̨�ͻ��˳���',MtWarning,[Mbyes],0);
    Exit;    
  end;

  Msg:=Trim(MemSendMsg.Text);
  Len:=Length(Msg);
  SetLength(Buf,Len+2);   //����buf����,ǰ�����ֽڴ����Ϣ�����ݳ���
  Move(Len,Buf[0],2);     //����Ϣ�����ݳ��ȷ���ǰ�����ֽ�
  Move(Msg[1],Buf[2],Len);//����Ϣ�����ݷ������,�ӵ������ֽڿ�ʼ���
  for i := 0 to ClientHost.Count-1 do
  begin
    try
      TCustomWinSocket(ClientHost[i]).SendBuf(Buf[0],Len+2);
    except
      TCustomWinSocket(ClientHost[i]).Close;
      ClientHost.Remove(ClientHost[i]);
    end;
  end;
end;

end.
