unit UntClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient,
  ScktComp, ExtCtrls;

type
  TFrmClient = class(TForm)
    ClientSocket: TClientSocket;
    gb1: TGroupBox;
    gb2: TGroupBox;
    MemReadMsg: TMemo;
    btnSend: TButton;
    gb3: TGroupBox;
    MemSendMsg: TMemo;
    Connet: TButton;
    GroupBox1: TGroupBox;
    LeSrvName: TLabeledEdit;
    LeSrvPort: TLabeledEdit;
    procedure ConnetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LeSrvPortKeyPress(Sender: TObject; var Key: Char);
    procedure LeSrvNameKeyPress(Sender: TObject; var Key: Char);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure btnSendClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmClient: TFrmClient;

implementation

{$R *.dfm}

procedure TFrmClient.ConnetClick(Sender: TObject);
begin
  Try
    if Trim(LeSrvName.Text )='' then
    begin
      MessageDlg('�����������IP��ַ��������ƣ�',MtInformation,[mbyes],0);
      exit;
    end;

    if Trim(LeSrvPort.Text )='' then
    begin
      MessageDlg('������������˿ںţ�',MtInformation,[mbyes],0);
      exit;
    end
    else
    if (Strtoint(Trim(LeSrvPort.Text))<0) or (Strtoint(Trim(LeSrvPort.Text))>999999) then
    begin
      MessageDlg('�������˿ںž���0��9999֮�䣡',MtInformation,[mbyes],0);
      exit;
    end;
    //ClientSocket.Active:=False;
    //IdUdpClient1.Active:=False;
    ClientSocket.Port:=Strtoint(Trim(LeSrvPort.Text));
    ClientSocket.Host:=trim(LeSrvName.Text);
    //IdUdpClient1.Host:=trim(LeSrvName.Text);
    //IdUdpClient1.Port:=ClientSocket.Port;
    //IdUdpClient1.Active:=true;
    ClientSocket.Active:=true;
    BtnSend.Enabled:=true;
    self.Connet.Enabled:=false;
  Except
    MessageBox(0,'����ʧ�ܣ���鿴������Ƿ���������','',MB_OK + MB_ICONWARNING);
  end;
end;

procedure TFrmClient.FormCreate(Sender: TObject);
begin
  BtnSend.Enabled:=false;
end;

procedure TFrmClient.LeSrvPortKeyPress(Sender: TObject; var Key: Char);
begin
  if Not(Key in ['0'..'9',#10,#8,#13]) then
  begin
    Key:=#0;
  end;
end;

procedure TFrmClient.LeSrvNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Not(Key in ['0'..'9',#8,#10,#13,#46]) then
  begin
    Key:=#0;
  end;
end;

procedure TFrmClient.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  Len:Word;
  Buf:Array of Char;
  Msg:String;
begin
  try
    Socket.ReceiveBuf(Len, 2);
    If Len <1 then Exit;
    SetLength(Buf,Len);
    Socket.ReceiveBuf(Buf[0],Len);
    SetLength(Msg,Len);
    Move(buf[0],Msg[1],Len);
    MemReadMsg.Lines.Add(Msg);
    MemReadMsg.Lines.Add(#13); 
  except
  end;
end;

procedure TFrmClient.btnSendClick(Sender: TObject);
Var
  Len:Word;
  Buf:Array of Char;
  Msg:String;
Begin//ǰ�����ֽڴ����Ϣ�����ݳ���)
  Msg:=Trim(MemSendMsg.Text);
  Len:=length(Msg);
  SetLength(Buf,Len+2);
  Move(len,Buf[0],2);
  Move(Msg[1],Buf[2],Len);
  ShowMessage(inttostr(high(Buf)));
  ClientSocket.Socket.SendBuf(Buf[0],Len+2);
  MemReadMsg.Lines.Add('�Լ�:');
  MemReadMsg.Lines.Add(#13);
  MemReadMsg.Lines.Add('  '+Msg);
  MemReadMsg.Lines.Add(#13);
end;

end.
