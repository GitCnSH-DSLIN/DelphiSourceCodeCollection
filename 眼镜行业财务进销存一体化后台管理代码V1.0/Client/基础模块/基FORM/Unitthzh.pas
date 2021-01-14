unit Unitthzh;

interface

uses
  Classes,winsock,sysutils,windows;   //ע����������

type
  ipdns = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation

uses Unitzcser;

function GetIP(Name:string) : string;
type
  TaPInAddr = array [0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe :PHostEnt;
  pptr : PaPInAddr;
  I : Integer;
  GInitData : TWSADATA;
begin
  WSAStartup($101, GInitData);
  Result := '';
  phe :=GetHostByName(pchar(Name)); //����һ��ָ��������Ϣ�ṹ��ָ��
  pptr := PaPInAddr(Phe^.h_addr_list); //ǿ��ת��
  result:=StrPas(inet_ntoa(pptr^[0]^));//����һ�������ʽ���ַ���IP��ַ
  WSACleanup;
end;

function GetDomainName(Ip:string):string;
var 
  pH:PHostent;
  data:twsadata;
  ii:dword;  //��ii ΪLongWord����
begin
  WSAStartup($101, Data);
  ii:=inet_addr(pchar(ip)); // ����һ���ʺ�Internet�����ֻ���ַ
  pH:=gethostbyaddr(@ii,sizeof(ii),PF_INET);//����һ��ָ��������Ϣ�ṹ��ָ��
  if (ph<>nil) then
  result:=pH.h_name //���ظýṹ��������
  else
  result:='';
  WSACleanup();
end;
procedure ipdns.Execute;
var
  i:integer;
  str:string;
  flag:boolean;
begin
  str:=frmzcser.ipstr;
  flag:=false;
  for i:=1 to length(str) do
  begin
    if ((str[i]>'9') or (str[i]<'0')) and (str[i]<>'.') then
    begin//��IP��Ҫ����dns
      frmzcser.ipstr:=GetIp(str);
      flag:=true;
    end;
    if flag then break;//���DNS->IP��ת��
  end;
    if not flag then
    begin //��IP�������IP->DNS��ת��
        frmzcser.ipstr:=GetDomainName(str);
    end;
end;

end.
 