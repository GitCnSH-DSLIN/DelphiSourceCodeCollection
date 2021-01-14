unit NetConnection;

interface


uses
  Windows, SysUtils,Classes, WinSock,winsvc,Dialogs;
 type
   _SERVER_INFO_100=record
          sv101_platform_id:DWORD;
          sv101_name:LPWSTR;
   end;
  SERVER_INFO_100=_SERVER_INFO_100;
  PSERVER_INFO_100=^_SERVER_INFO_100;

   _SERVER_INFO_101=record
          sv101_platform_id:DWORD;
          sv101_name:LPWSTR;
          sv101_version_major:DWORD;
          sv101_version_minor:DWORD;
          sv101_type:DWORD;
          sv101_comment:LPWSTR;
   end;
  SERVER_INFO_101=_SERVER_INFO_101;
  PSERVER_INFO_101=^_SERVER_INFO_101;
//  LPSERVER_INFO_101=^_SERVER_INFO_101;

 type
    _NET_DISPLAY_USER =record
             name     :LPWSTR;
             comment  :LPWSTR;
             flags    :DWORD;
             full_name:LPWSTR;
             user_id  :DWORD;
             next_index:DWORD;
 end;
  NET_DISPLAY_USER=_NET_DISPLAY_USER;
  PNET_DISPLAY_USER=^_NET_DISPLAY_USER;

type _NET_DISPLAY_MACHINE=record
             name   :LPWSTR;
             comment:LPWSTR;
             flags  :DWORD;
             user_id:DWORD;
             next_index:DWORD;
end;
  NET_DISPLAY_MACHINE=_NET_DISPLAY_MACHINE;
  PNET_DISPLAY_MACHINE=^_NET_DISPLAY_MACHINE;

type _NET_DISPLAY_GROUP=record
             name      :LPWSTR;
             comment   :LPWSTR;
             user_id  :DWORD;
             flags:DWORD;
             next_index:DWORD;
end;
  NET_DISPLAY_GROUP=_NET_DISPLAY_GROUP;
  PNET_DISPLAY_GROUP=^_NET_DISPLAY_GROUP;


 type
   _SHARE_INFO1_NT=record
    netname    :LPWSTR;
    net_type   :DWORD;
    remark     :LPWSTR;
   end;

  SHARE_INFO1_NT = _SHARE_INFO1_NT;
  PSHARE_INFO1_NT = ^SHARE_INFO1_NT;
  LPBYTE = Pointer;
  NET_API_STATUS = DWORD;
  LPVOID = Pointer;

  type
    share_info1_9x=record
     shi1_netname     :array [0..21] of char;
     shi1_pad1        :char;
     shi1_type        :short;
     shi1_remark      :pchar;
  end;

  Tmy_WNetAddConnection2    = function(lpNetResource:PNetResourceA;
                                     lpPassword:     LPCTSTR;
                                     lpUsername:     LPCTSTR;
                                     dwFlags:        DWORD
                                     ): DWord; stdcall;

  Tmy_WNetCancelConnection2 = function(lpName:  LPCTSTR;
                                       dwFlags: DWORD;
                                       fForce:  BOOL
                                     ): DWord; stdcall;
  Tmy_NetQueryDisplayInformation = function(ServerName:  LPCWSTR;
                                                 Level:  DWORD;
                                                 Index:  DWORD;
                                      EntriesRequested:  DWORD;
                                PreferredMaximumLength:  DWORD;
                                var ReturnedEntryCount:  longint;
                                       SortedBuffer:  Pointer
                                     ): DWord; stdcall;

  TNetServerGetInfo      =function  (servername:LPWSTR;level:DWORD;
                                      VAR buf:PSERVER_INFO_101): DWord; stdcall;

{   TNetShareEnum_9x      =function( pszServer:pchar;
                                    sLevel:short;
                                    pbBuffer:pchar;
                                    cbBuffer:short;
                                    pcEntriesRead:short;
                                    pcTotalAvail:short
                                   ): DWord; stdcall;

 } TNetShareEnum_NT=function(pszServer:LPWSTR; sLevel:longint;
    var p:PSHARE_INFO1_NT;var cbBuffer: longint; var pcEntriesRead: longint; var pcTotalAvail:longint;var hEnum:HWND): NET_API_STATUS; stdcall;

  TIConnectionException = class(Exception);
 type
  TIConnectionReply  = procedure(Sender: TObject; Error : Integer) of object;
  TIConnection = class(TObject)
  private
    hmprdll :        HModule;                    // Handle for mpr.dll
    ShareEnum_dll :  HModule;                    // Handle for mpr.dll
    my_WNetAddConnection2    : Tmy_WNetAddConnection2;
    my_WNetCancelConnection2 : Tmy_WNetCancelConnection2;
    my_NetQueryDisplayInformation:Tmy_NetQueryDisplayInformation;
    NetShareEnum_NT : TNetShareEnum_NT;
    FAddress,fsharename:        String;                     // Address given
    Fusername,Fpassword :    String;
    FosVersion          :    integer;
    FOnEchoClose :  TIConnectionReply;
    FOnEchoOpen :   TIConnectionReply;
    FOnEchoShareEnum :  TIConnectionReply;
    FOnOpenSucceed : TNotifyEvent;
    FNetServerGetInfo      : TNetServerGetInfo;//����ȡ��������Ϣ
  public
    list:tstringlist;
    list_info:tstringlist;
    AutoDo:boolean;
    FGetInfo:boolean;
    constructor Create; virtual;
    destructor  Destroy; override;
    procedure   SetAddress(Value : String);
    function    getserverinfo:Integer;
    function    open : Integer;
    function    close : Integer;
    function    ShareEnum : Integer;
    function    NetQueryDisplayInformation(Level:integer;var var_list:Tstringlist):integer;
    function    get_user(Level:integer;var var_list:Tstringlist):integer;
    function    my_EnumServices(var var_list:Tstringlist):integer;

    property Address       : String         read  FAddress   write SetAddress;
    property ShareName       : String       read  Fsharename   write fsharename;
    property UserName       : String         read  Fusername   write Fusername;
    property PassWord       : String         read  Fpassword   write Fpassword;

    property OnEchoClose : TIConnectionReply   read  FOnEchoClose  write FOnEchoClose;
    property OnEchoOpen  : TIConnectionReply   read  FOnEchoOpen   write FOnEchoOpen;
    property OnShareEnum : TIConnectionReply   read  FOnEchoShareEnum   write FOnEchoShareEnum;
    property OnOpenSucceed : TNotifyEvent   read  FOnOpenSucceed   write FOnOpenSucceed;

  end;

//  function NetShareEnum_NT;external 'netapi32.dll' name 'NetShareEnum';

implementation
   const
       SV_TYPE_WORKSTATION     =   $00000001;
       SV_TYPE_SERVER          =   $00000002;
       SV_TYPE_SQLSERVER       =   $00000004;
       SV_TYPE_DOMAIN_CTRL     =   $00000008;
       SV_TYPE_DOMAIN_BAKCTRL  =   $00000010;
       SV_TYPE_TIME_SOURCE     =   $00000020;
       SV_TYPE_AFP             =   $00000040;
       SV_TYPE_NOVELL          =   $00000080;
       SV_TYPE_DOMAIN_MEMBER   =   $00000100;
       SV_TYPE_PRINTQ_SERVER   =   $00000200;
       SV_TYPE_DIALIN_SERVER   =   $00000400;
       SV_TYPE_XENIX_SERVER    =   $00000800;
       SV_TYPE_SERVER_UNIX     =   SV_TYPE_XENIX_SERVER;
       SV_TYPE_NT              =   $00001000;
       SV_TYPE_WFW             =   $00002000;
       SV_TYPE_SERVER_MFPN     =   $00004000;
       SV_TYPE_SERVER_NT       =   $00008000;
       SV_TYPE_POTENTIAL_BROWSER  =   $00010000;
       SV_TYPE_BACKUP_BROWSER  =   $00020000;
       SV_TYPE_MASTER_BROWSER  =   $00040000;
       SV_TYPE_DOMAIN_MASTER   =   $00080000;
       SV_TYPE_SERVER_OSF      =   $00100000;
       SV_TYPE_SERVER_VMS      =   $00200000;
       SV_TYPE_WINDOWS         =   $00400000;  ///* Windows95 and above */
       SV_TYPE_DFS             =   $00800000;  ///* Root of a DFS tree */
       SV_TYPE_CLUSTER_NT      =   $01000000;  ///* NT Cluster */
       SV_TYPE_TERMINALSERVER  =   $02000000;  ///* Terminal Server(Hydra) */
       SV_TYPE_DCE             =   $10000000;  ///* IBM DSS (Directory and Security Services) or equivalent */
       SV_TYPE_ALTERNATE_XPORT =   $20000000;  ///* return list for alternate transport */
       SV_TYPE_LOCAL_LIST_ONLY =   $40000000;  ///* Return local list only */
       SV_TYPE_DOMAIN_ENUM     =   $80000000;

constructor TIConnection.Create;
var
//    WSAData: TWSAData;
   OSVer:TOSVersionInfo;//�汾��Ϣ
begin
    fpassword:='';
    fusername:='';
    fsharename:='ipc$';
    AutoDo:=true;
    FGetInfo:=false;
    // initialise winsock
//    if WSAStartup($101, WSAData) <> 0 then
//        raise TIConnectionException.Create('Error initialising Winsock');

//�Ȼ�ȡϵͳ�汾,�پ���װ�غ���
    ZeroMemory(@OSVer, sizeof(TOSVersionInfoA));
    OSVer.dwOSVersionInfoSize:= sizeof(TOSVersionInfoA);
    GetVersionEx(OSVer); FosVersion:=integer(OSVer.dwPlatformId);
    list:=tstringlist.Create;//�����ַ����б�
    list_info:=tstringlist.Create;//�����ַ����б�

    if FosVersion=VER_PLATFORM_WIN32_NT then
      begin
        ShareEnum_dll:=LoadLibrary('netapi32.dll');
        if ShareEnum_dll = 0 then
           raise TIConnectionException.Create('Unable to register netapi32.dll');
      end else
      begin
        ShareEnum_dll:=LoadLibrary('svrapi.dll');
        if ShareEnum_dll = 0 then
           raise TIConnectionException.Create('Unable to register svrapi.dll');
      end;
    hmprdll := LoadLibrary('mpr.dll');
    if hmprdll = 0 then
        raise TIConnectionException.Create('Unable to register mpr.dll');


    @my_WNetAddConnection2  := GetProcAddress(hmprdll, 'WNetAddConnection2A');
    @my_WNetCancelConnection2 := GetProcAddress(hmprdll, 'WNetCancelConnection2A');
//  if FosVersion=VER_PLATFORM_WIN32_NT then//win9x��֧��
    @my_NetQueryDisplayInformation:=GetProcAddress(ShareEnum_dll, 'NetQueryDisplayInformation');
    @NetShareEnum_NT := GetProcAddress(ShareEnum_dll, 'NetShareEnum');
    @FNetServerGetInfo := GetProcAddress(ShareEnum_dll, 'NetServerGetInfo');

    if (@my_WNetAddConnection2 =nil) or (@FNetServerGetInfo =nil) or (@my_NetQueryDisplayInformation =nil) or
       (@my_WNetCancelConnection2 =nil) or (@NetShareEnum_NT =nil) then
          raise TIConnectionException.Create('����dll��������!');
//  if (FosVersion=VER_PLATFORM_WIN32_NT) and (@my_NetQueryDisplayInformation =nil) then
//          raise TIConnectionException.Create('����NetQueryDisplayInformation��������!');

end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
destructor TIConnection.Destroy;
begin
    if hmprdll <> 0 then
        FreeLibrary(hmprdll);
    if ShareEnum_dll <> 0 then
        FreeLibrary(ShareEnum_dll);
    list.Free;list_info.Free;
    inherited Destroy;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TIConnection.SetAddress(Value : String);
begin
    // Only change if needed (could take a long time)
    if FAddress = Value then Exit;
    FAddress:= Value;
end;

function TIConnection.getserverinfo:Integer;
var
    pBuf:PSERVER_INFO_101;
    pBuf_100:PSERVER_INFO_100;
    str:string;
    res:Dword;
    ServerName:pwchar;
begin
  result:=0;
  list_info.Clear;
  list_info.add(FAddress);

    if pos('\\',FAddress)=1 then str:=FAddress
    else str:='\\'+FAddress;

    ServerName:=StringToOleStr(str);

    res:=FNetServerGetInfo(ServerName,101,pBuf);

    if (res =0) then
      begin
       if (pBuf.sv101_type and SV_TYPE_DOMAIN_CTRL) =SV_TYPE_DOMAIN_CTRL then str:='PDC'
	  else
       if (pBuf.sv101_type and SV_TYPE_DOMAIN_BAKCTRL)=SV_TYPE_DOMAIN_BAKCTRL then str:='BDC'
	  else
       if (pBuf.sv101_type and SV_TYPE_SERVER_NT)=SV_TYPE_SERVER_NT then str:='NT4.0 / WINDOWS2000'
	  else
       if (pBuf.sv101_type and SV_TYPE_NT)=SV_TYPE_NT then str:='NT WORKSTATION'
	  else
       if (pBuf.sv101_type and SV_TYPE_SQLSERVER)=SV_TYPE_SQLSERVER then str:='SQL_server'
	  else
       if (pBuf.sv101_type and SV_TYPE_NOVELL)=SV_TYPE_NOVELL then str:='Novell Netware Server'
	  else
       if (pBuf.sv101_type and SV_TYPE_WFW)=SV_TYPE_WFW then str:='WINDOWS ME/Windows for Workgroups'
	  else
       if (pBuf.sv101_type and SV_TYPE_WINDOWS)=SV_TYPE_WINDOWS then str:='Windows 9x'
	  else
            str:=inttostr(pBuf.sv101_type);

       list_info.Add('����:'+pBuf.sv101_name);
       list_info.Add('ϵͳ:'+str);
       list_info.add('platform:'+inttostr(pBuf.sv101_platform_id));
       list_info.add('�汾:'+format('%d - %d',[ pBuf.sv101_version_major, pBuf.sv101_version_minor]));
       list_info.add('����:'+format('%d',[pBuf.sv101_type]));
       list_info.add('��ע:'+pBuf.sv101_comment);
    end else
    begin
     res:=FNetServerGetInfo(ServerName,100,PSERVER_INFO_101(pBuf_100));

     if (res =0) then
      begin
       list_info.Add('����:'+pBuf_100.sv101_name);
       list_info.add('platform:'+inttostr(pBuf_100.sv101_platform_id));
      end else result:=-1;
    end;

end;
{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
function TIConnection.open : Integer;
var
    FNetResource:TNetResourceA;
    str:string;
    res:Dword;
begin
    if pos('\\',FAddress)=1 then str:=FAddress+'\'+fsharename
    else str:='\\'+FAddress+'\'+fsharename;

    FNetResource.dwType:=RESOURCETYPE_ANY;
    FNetResource.lpLocalName:='';
    FNetResource.lpProvider:='';
    FNetResource.lpRemoteName:=pchar(str);

    res:=my_WNetAddConnection2(@FNetResource,pchar(fpassword),pchar(fusername),0);

    list.clear;
    list.add(FAddress);

   if autodo then//���Զ�����Ӧ�¼�
     begin
      if (res=0) then
        ShareEnum
      else
      if Assigned(FOnEchoClose) then
           FOnEchoClose(Self, res);
     end else
      if Assigned(FOnEchoOpen) then
          FOnEchoOpen(Self, res);

end;

function TIConnection.ShareEnum : Integer;
var
   cbBuffer,EntriesRead, TotalAvail: longint;
   hEnum:HWND;
   res:NET_API_STATUS;
   p:PSHARE_INFO1_NT;
   IP_str:string;
   ServerName:pwchar;
   i:integer;
begin
    if list.count>1 then
      begin
       list.clear;
       list.add(FAddress);
      end;
    if (pos('\\',FAddress)=1) then
      IP_str:=FAddress
     else
      IP_str:='\\'+FAddress;

     ServerName:=StringToOleStr(IP_str);

     cbBuffer:=   $0ffffff; hEnum:=0;

   res:=NetShareEnum_NT(ServerName,1,p,cbBuffer,EntriesRead,TotalAvail,hEnum);

   if (res=0) or (res=234) then
    if EntriesRead>0 then
      for i:=0 to EntriesRead-1 do
       begin
        list.add(string(p^.netname)+'   '+string(p^.remark));
        inc(p);
       end;

   if autodo then
     begin
      if ((res=0) or (res=234)) then//���Զ�����Ӧ�¼�
        begin
         if Assigned(FOnEchoShareEnum) then
           FOnEchoShareEnum(Self, res);
          close;
        end else
       if Assigned(FOnEchoClose) then
            FOnEchoClose(Self, res);
     end else
   if Assigned(FOnEchoShareEnum) then
          FOnEchoShareEnum(Self, res);
end;


function TIConnection.close : Integer;
var
   str:string;
begin
    if pos('\\',FAddress)=1 then str:=FAddress+'\'+fsharename
    else str:='\\'+FAddress+'\'+fsharename;

   if Assigned(FOnOpenSucceed) then //��Ӧ�ⲿ�Ĳ����û��¼�
            FOnOpenSucceed(Self);

    Result:=my_WNetCancelConnection2(pchar(str),0,true);

  if FGetInfo then getserverinfo;//��ȡ�����汾����Ϣ

    if Assigned(FOnEchoClose) then
        FOnEchoClose(Self, Result);
end;

function usri1_flags(flags:DWORD):string;//����˵��
begin
  result:='';
//  if (flags and 1)=1 then result:='��Ҫ����';
  if (flags and 2)=2 then result:=result+'��ͣ��,';
  if (flags and $20)=$20 then result:=result+'������';
{  if (flags and 8)=8 then result:=result+'The home directory is required. Windows NT ignores this value';

//  if (flags and $40)=   $40 then result:=result+'���û����ܸ�������';
//  if (flags and $20)=   $20 then result:=result+'The Account is Locked';
//  if (flags and $80)=   $80 then result:=result+'Password does not ����';
 }
  if result='' then result:='��Ϣ���:'+inttostr(flags);
end;

//����:��Ҫ���ص���������,Ҫע���Ƿ�Ϊvar�� ���µ� dwRec����,Ҫ�ڶ�������Ϊvar
//����API�������غ󲻿�����
//�Һ���һ��Ҫ��CLose���Ӻ������
function TIConnection.NetQueryDisplayInformation(Level:integer;var var_list:Tstringlist):integer;
var
   p:PNET_DISPLAY_USER;
   res, i:DWORD;
   dwRec:longint;
   IP_str:string;
   ServerName:pwchar;
   count:integer;
begin
     var_list.clear;
     var_list.add(FAddress);
    if (pos('\\',FAddress)=1) then
      IP_str:=FAddress
     else
      IP_str:='\\'+FAddress;

    ServerName:=StringToOleStr(IP_str);
    i:=0;
    res :=my_NetQueryDisplayInformation(ServerName, Level, i, 8000,8000,dwRec,@p);
    if((res=0) or (res=234)) then
     begin
      if dwRec>0 then
      begin
        for count:=0 to dwRec-1 do
          begin
            var_list.add(inttostr(count+1)+'->['+string(p^.name)+']  '+usri1_flags(p^.flags)+'  ����:'+string(p^.comment)+'  ID:'+inttostr(p^.user_id));
            inc(p);
          end;
      end;
     end;
end;

function TIConnection.get_user(Level:integer;var var_list:Tstringlist):integer;
var
   FNetResource:TNetResourceA;
   p:PNET_DISPLAY_USER;
   res, i:DWORD;
   dwRec:longint;
   IP_str:string;
   ServerName:pwchar;
   count:integer;
begin
     var_list.clear;

    if (pos('\\',FAddress)=1) then
      IP_str:=FAddress
     else
      IP_str:='\\'+FAddress;

    ServerName:=StringToOleStr(IP_str);
//��������
    ip_str:=ip_str+'\ipc$';
    FNetResource.dwType:=RESOURCETYPE_ANY;
    FNetResource.lpLocalName:='';
    FNetResource.lpProvider:='';
    FNetResource.lpRemoteName:=pchar(IP_str);

    res:=my_WNetAddConnection2(@FNetResource,'','',0);
    if (res<>0) and (res<>1219) then exit; //0����ɹ�,1219����ƾ�ݳ�ͻ,����ǰ�������ӻ�δ�Ͽ�
//���û�
    i:=0;
    res :=my_NetQueryDisplayInformation(ServerName, Level, i, 8000,8000,dwRec,@p);
    if((res=0) or (res=234)) then
     begin
      if dwRec>0 then
      begin
        for count:=0 to dwRec-1 do
          begin
             if (p^.flags and 2)<>2 then//ֻ�в�ͣ�õ��û���Ҫ
               var_list.add(string(p^.name));
            inc(p);
          end;
      end;
     end;

   Result:=my_WNetCancelConnection2(pchar(ip_str),0,true);//�ر�����
end;

function TIConnection.my_EnumServices(var var_list:Tstringlist):integer;
var
  BytesNeeded,serviceReturned,resumeHandle:Dword;
  returnflag:Bool;
  lpservice:Array of TEnumServiceStatus;
  service:TEnumServiceStatus;
  i,bytes:Dword;
  hscmanager:SC_HANDLE;
  str:string;
begin
    if pos('\\',FAddress)=1 then str:=FAddress
    else str:='\\'+FAddress;

  var_list.Clear;
  var_list.add(FAddress);
  returnflag:=false;
  resumeHandle:=0;
  BytesNeeded:=0;
  hscmanager:=OpenSCManager(pchar(str),0,SC_MANAGER_ALL_ACCESS);//��service control manager database
  if hscmanager =0 then
   Begin
//   var_list.add('�޷���service control manager database');
   exit;
   End;
  returnflag:=EnumServicesStatus(hscmanager,
                    SERVICE_WIN32 or SERVICE_DRIVER,
                    SERVICE_ACTIVE or SERVICE_INACTIVE,
                    service,
                    0,
                    BytesNeeded,
                    serviceReturned,
                    resumeHandle);
//ö��Service
  if (returnflag=false) and (GetLastError()=ERROR_MORE_DATA) then
   begin
      resumeHandle:=0;
      bytes:=BytesNeeded + sizeof(TEnumServiceStatus);
      SetLength(lpservice,bytes div sizeof(TEnumServiceStatus)+1); // һ��Ҫ��ô�С,�������
     returnflag:=EnumServicesStatus(hscmanager,
                            SERVICE_WIN32 or SERVICE_DRIVER,
                            SERVICE_ACTIVE or SERVICE_INACTIVE,
                            lpservice[0],
                            bytes,
                            BytesNeeded,
                            serviceReturned,
                            resumeHandle);
     for i := 0 to serviceReturned-1 do
      begin
       if lpservice[i].ServiceStatus.dwCurrentState = SERVICE_STOPPED then
        var_list.Add(inttostr(i+1)+'->['+lpservice[i].lpServiceName+']  '+lpservice[i].lpDisplayName+'  :ֹͣ') else
       if lpservice[i].ServiceStatus.dwCurrentState = SERVICE_RUNNING then
         var_list.Add(inttostr(i+1)+'->['+lpservice[i].lpServiceName+']  '+lpservice[i].lpDisplayName+'  :����') else
         var_list.Add(inttostr(i+1)+'->['+lpservice[i].lpServiceName+']  '+lpservice[i].lpDisplayName+'  :��ͣ');
      end;
   end;
  CloseServiceHandle(hscmanager);//�ر�service control manager database

end;

end.
{procedure TForm1.Button2Click(Sender:TObject);
var
i:integer;
hService:SC_HANDLE;
lpServiceArgVectors:Pchar;
  returnstatus:TServiceStatus;
begin
lpServiceArgVectors:=nil;
for i := 0 to (ListBox1.Items.Count-1) do
if ListBox1.Selected[i] then
begin
hService:=OpenService(hscmanager,

                      Pchar(ListBox1.Items[i]),

                      SERVICE_ALL_ACCESS);
//�򿪸�Service
if hService < 0 then
begin
showmessage('�޷��򿪸�Service');
exit;
end;
QueryServiceStatus(hService,returnstatus);
//�鿴��Service��״̬
if returnstatus.dwCurrentState = SERVICE_STOPPED then

//�����Service��ֹͣ��������
StartService(hService,0,lpServiceArgVectors);
CloseServiceHandle(hService);//�رո�Service
end;
end;


procedure TForm1.Button3Click(Sender:TObject);
var
i:integer;
begin
for i := 0 to (ListBox1.Items.Count-1) do
if ListBox1.Selected[i] then
begin
hService:=OpenService(hscmanager,

                    Pchar (ListBox1.Items[i]),

                    SERVICE_ALL_ACCESS);
//�򿪸�Service
if hService < 0 then
begin
showmessage('�޷��򿪸�Service');
exit;
end;
QueryServiceStatus(hService,returnstatus);
//�鿴��Service��״̬
if returnstatus.dwCurrentState = SERVICE_RUNNING then
//�����Service����������ֹͣ��
ControlService(hService,

                SERVICE_CONTROL_STOP,

                returnstatus);
CloseServiceHandle(hService);//�رո�Service
end;
end;

procedure TForm1.FormClose(Sender:TObject;varAction:TCloseAction);
begin
CloseServiceHandle(hscmanager);//�ر�service control manager database
End;
end.
}

