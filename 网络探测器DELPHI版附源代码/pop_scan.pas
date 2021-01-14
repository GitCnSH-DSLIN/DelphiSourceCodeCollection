unit pop_scan;

interface

uses
  Windows, Messages,Classes,winsock,sysutils;

type
  ESocketException   = class(Exception);
  TWSAStartup            = function (wVersionRequired: word;
                                       var WSData: TWSAData): Integer; stdcall;
  TOpenSocket            = function (af, Struct, protocol: Integer): TSocket; stdcall;
  TInet_addr             = function (cp: PChar): u_long; stdcall;
  Thtons                 = function (hostshort: u_short): u_short; stdcall;
  TConnect               = function (s: TSocket; var name: TSockAddr;
                                       namelen: Integer): Integer; stdcall;
  TCloseSocket           = function (s: TSocket): Integer; stdcall;
  Tsend                  = function( s:TSOCKET; buf:pchar;Len:integer;flags:integer):Integer;stdcall;
  Trecv                  = function( s:TSOCKET; var buf;Len:integer;flags:integer):Integer;stdcall;
  TWSACleanup            =function():integer;stdcall;
  TScan = procedure(Error : Integer) of object;

  Tpop_scan = class(TComponent)
  private
    Fhand_dll :     HModule;                    // Handle for mpr.dll
    FOnScan      : TScan;
    FOnSendDetect  : TScan;
    FAddress     : String;
    FHostName    : String;
    FPort        : String;
    FUserName    : String;
    FPassWord    : String;
    Fsocket      :Tsocket;
    Frecv_info        :string;//���ص���Ϣ

    FWSAStartup            : TWSAStartup;
    FOpenSocket            : TOpenSocket;
    FInet_addr             : TInet_addr;
    Fhtons                 : Thtons;
    FConnect               : TConnect;
    FCloseSocket           : TCloseSocket;
    Fsend                  :Tsend;
    Frecv                  :Trecv;
    FWSACleanup            :TWSACleanup;
    procedure   SetAddress(Value : string);
    procedure   SetHostName(Value : string);
protected
    function    my_recv:Boolean;//��������
  public
    constructor Create(Owner : TComponent); override;
    destructor  Destroy; override;
    function   IpToName(str:string):string;//���ڽ�IP��ַ����һ����������
    function   NameToIp(str:string):string;//���ڽ��������Ʒ���Ip��ַ
    procedure    scan;
    procedure    SendDetect;
    property    Recv_Info    : String       read  Frecv_info write Frecv_info;
  published
    property    Address     : String       read  FAddress write SetAddress;
    property    HostName    : String       read  FHostName write SetHostName;
    property    Port        : String       read  FPort write FPort;
    property    UserName    : String       read  FUserName write FUserName;
    property    PassWord    : String       read  FPassWord write FPassWord;

    property    OnScan    : TScan   read  FOnScan write FOnScan;
    property    OnSendDetect    : TScan   read  FOnSendDetect write FOnSendDetect;
  end;

procedure Register;

implementation


constructor Tpop_scan.Create(Owner : TComponent);
var
 GInitData:TWSAData;
begin
    Inherited Create(Owner);
    self.FPort:='110';

    Fhand_dll := LoadLibrary('wsock32.dll');
    if Fhand_dll = 0 then
        raise ESocketException.Create('Unable to register wsock32.dll');

    @FWSAStartup  := GetProcAddress(Fhand_dll, 'WSAStartup');

    @FOpenSocket :=  GetProcAddress(Fhand_dll, 'socket');
    @FInet_addr :=   GetProcAddress(Fhand_dll, 'inet_addr');
    @Fhtons  :=      GetProcAddress(Fhand_dll, 'htons');
    @FConnect :=     GetProcAddress(Fhand_dll, 'connect');
    @FCloseSocket := GetProcAddress(Fhand_dll, 'closesocket');
    @Fsend        := GetProcAddress(Fhand_dll, 'send');
    @Frecv        := GetProcAddress(Fhand_dll, 'recv');
    @FWSACleanup  := GetProcAddress(Fhand_dll, 'WSACleanup');
    if (@FWSAStartup =nil) or(@Fhtons =nil) or (@FConnect =nil) or (@Fsend =nil) or (@FWSACleanup=nil) or
       (@FOpenSocket =nil) or (@FInet_addr =nil)or (@FCloseSocket =nil) or (@recv=nil) then
          raise ESocketException.Create('����dll��������!');

   if FWSAStartup($101,GInitData)<>0 then
      raise ESocketException.Create('��ʼ��SOCKET����ʧ��!');

end;

procedure  Tpop_scan.SetAddress(Value : string);
var temp_str:string;
begin
  if (Value=FAddress) then exit;
  if (inet_addr(pchar(Value))=-1) then //IP���Ϸ�,������������
    begin
     temp_str:=NameToIp(Value);
     self.FAddress:=temp_str;
     self.FHostName:=Value;
    end else
    begin
     temp_str:=IpToName(Value);
     self.FAddress:=Value;
     self.FHostName:=temp_str;
    end;
end;

procedure  Tpop_scan.SetHostName(Value : string);
var temp_str:string;
begin
  if (Value=FHostName) then exit;
  if (inet_addr(pchar(Value))=-1) then //IP���Ϸ�,������������
    begin
     temp_str:=NameToIp(Value);
     self.FAddress:=temp_str;
     self.FHostName:=Value;
    end else
    begin
     temp_str:=IpToName(Value);
     self.FAddress:=Value;
     self.FHostName:=temp_str;
    end;
end;

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
destructor Tpop_scan.Destroy;
begin
   FWSACleanup;
    if Fhand_dll <> 0 then
        FreeLibrary(Fhand_dll);

    inherited Destroy;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function  Tpop_scan.IpToName(str:string):string;//���ڽ�IP��ַ����һ����������
var
    addr:sockaddr_in;
    host:phostent;
begin
   addr.sin_addr.s_addr:=inet_addr(pchar(str));

   host:=gethostbyaddr(@addr.sin_addr,4,AF_INET);
   if (host=nil) then
    result:='[��֪]'
    else
    result:=host.h_name;
end;

function  Tpop_scan.NameToIp(str:string):string;//���ڽ��������Ʒ���Ip��ַ
var
    Ph : PHostEnt;
    FAddress:string;
    FIPAddress:longint;
begin
   result:='';
   FAddress:=str;
   Ph := GetHostByName(PChar(FAddress));
   if Ph = nil then exit;

   FIPAddress := longint(plongint(Ph^.h_addr_list^)^);
   result:=StrPas(inet_ntoa(TInAddr(FIPAddress)));
end;

function Tpop_scan.my_recv:Boolean;
 var
    S: string;
    buf:array[0..300]of Char;
    n:integer;
begin
   result:=false;
   fillchar(buf,sizeof(buf),#0);
   S:='';
   n:=Frecv(Fsocket,buf,sizeof(buf),0);
   if (n>0) then
    begin
     s:=s+buf;
     self.Frecv_info:=s;//���淵������
     if (copy(s,1,3)='+OK') then result:=true
    end;

end;

procedure Tpop_scan.scan ;
var
  serv_addr:tSockAddrIn;
  istate:integer;
begin
  self.Frecv_info:='';
  Fsocket:=FOpenSocket(AF_INET,SOCK_STREAM,IPPROTO_TCP);

  serv_addr.sin_family:=AF_INET;
  serv_addr.sin_port:=Fhtons(strtoint(fport));
  serv_addr.sin_addr.S_addr:=FInet_addr(pchar(faddress));
  serv_addr.sin_zero:='';
  istate:=FConnect(fsocket,serv_addr,sizeof(serv_addr));
  FCloseSocket(fsocket);
  if Assigned(FOnScan) then
        FOnScan(istate);
end;

procedure Tpop_scan.SendDetect;
var
  serv_addr:tSockAddrIn;
  istate:integer;
  run:boolean;
  temp_str:string;
begin
  self.Frecv_info:='';
  Fsocket:=FOpenSocket(AF_INET,SOCK_STREAM,IPPROTO_TCP);

  serv_addr.sin_family:=AF_INET;
  serv_addr.sin_port:=Fhtons(strtoint(fport));
  serv_addr.sin_addr.S_addr:=FInet_addr(pchar(faddress));
  serv_addr.sin_zero:='';
  istate:=FConnect(fsocket,serv_addr,sizeof(serv_addr));

  if (istate=0) then
   begin
     my_recv;//�����ӳɹ�������
     temp_str:='USER '+fusername+#13#10;//�����û�����
     fsend(Fsocket,pchar(temp_str),Length(temp_str),0);
     run:=my_recv;//���û�ȷ������

    if run then
     begin
       temp_str:='PASS '+fpassword+#13#10;
       fsend(Fsocket,pchar(temp_str),Length(temp_str),0);
       run:=my_recv;//������ȷ������
       if run then
        begin
          if Assigned(FOnSendDetect) then FOnSendDetect(0);//�ɹ�
        end else
         if Assigned(FOnSendDetect) then FOnSendDetect(-3);//����ʧ��

       temp_str:='QUIT'+#13#10;//�ر�
       fsend(Fsocket,pchar(temp_str),Length(temp_str),0);
//       run:=my_recv;
//       FConnect(fsocket,serv_addr,sizeof(serv_addr));//����һ�ο��Լ�ʱ�ر�(����)
      end else
       if Assigned(FOnSendDetect) then FOnSendDetect(-2);//�����û�ʧ��
   end else if Assigned(FOnSendDetect) then FOnSendDetect(-1);//������ʧ��

  FCloseSocket(fsocket);
end;

procedure Register;
begin
    RegisterComponents('Standard', [Tpop_scan]);
end;

end.


