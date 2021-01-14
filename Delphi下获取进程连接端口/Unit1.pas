unit Unit1;

//
//�������Ӷ˿ڲ鿴��
//���ߣ�yeye55
//2008��2��25��
//
//�����ת�ر��ļ��еĴ��룬��ע�����������߲���֤��������
//������޸��˱��ļ��еĴ��룬��ע���޸�λ�ú��޸�����
//
//���ļ�������http://www.programbbs.com/bbs/�Ϸ���
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, StrUtils, PsAPI, tlhelp32, WinSock;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    Button2: TButton;
    Button3: TButton;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

//���³����������VC++6.0�Դ�IPRTRMIB.H�ļ��е���ض����д
const
    MIB_TCP_STATE_CLOSED     =  1;
    MIB_TCP_STATE_LISTEN     =  2;
    MIB_TCP_STATE_SYN_SENT   =  3;
    MIB_TCP_STATE_SYN_RCVD   =  4;
    MIB_TCP_STATE_ESTAB      =  5;
    MIB_TCP_STATE_FIN_WAIT1  =  6;
    MIB_TCP_STATE_FIN_WAIT2  =  7;
    MIB_TCP_STATE_CLOSE_WAIT =  8;
    MIB_TCP_STATE_CLOSING    =  9;
    MIB_TCP_STATE_LAST_ACK   = 10;
    MIB_TCP_STATE_TIME_WAIT  = 11;
    MIB_TCP_STATE_DELETE_TCB = 12;

//������ݽṹ�Ķ���
const
    ANY_SIZE=256;

type
    MIB_TCPEXROW = record
        dwState : DWORD;      //����״̬
        dwLocalAddr : DWORD;  //���ص�ַ
        dwLocalPort : DWORD;  //���ض˿�
        dwRemoteAddr : DWORD; //Զ�̵�ַ
        dwRemotePort : DWORD; //Զ�̶˿�
        dwProcessId : DWORD;  //����ID��
    end;

    MIB_TCPEXTABLE = record
        dwNumEntries : DWORD; //�˿�����
        table : array [0..ANY_SIZE-1] of MIB_TCPEXROW;
    end;

    PMIB_TCPEXTABLE = ^MIB_TCPEXTABLE;

    MIB_UDPEXROW = record
        dwLocalAddr : DWORD; //���ص�ַ
        dwLocalPort : DWORD; //���ض˿�
        dwProcessId : DWORD; //����ID��
    end;

    MIB_UDPEXTABLE = record
        dwNumEntries : DWORD; //�˿�����
        table : array [0..ANY_SIZE-1] of MIB_UDPEXROW;
    end;

    PMIB_UDPEXTABLE = ^MIB_UDPEXTABLE;

//��ȡTCP���ӱ��IP������������
function AllocateAndGetTcpExTableFromStack(
    var pTcpTable;
    bOrder : Bool;
    heap : THandle;
    zero : DWORD;
    flags : DWORD
    ): DWORD; stdcall; external 'iphlpapi.dll'
    name 'AllocateAndGetTcpExTableFromStack';

//��ȡUDP���ӱ��IP������������
function AllocateAndGetUdpExTableFromStack(
    var pUdpTable;
    bOrder : Bool;
    heap : THandle;
    zero : DWORD;
    flags : DWORD
    ): DWORD; stdcall; external 'iphlpapi.dll'
    name 'AllocateAndGetUdpExTableFromStack';


implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
    self.StringGrid1.Cells[0,0]:=' Э��';
    self.StringGrid1.Cells[1,0]:=' ����IP��ַ';
    self.StringGrid1.Cells[2,0]:=' Զ��IP��ַ';
    self.StringGrid1.Cells[3,0]:=' ����״̬';
    self.StringGrid1.Cells[4,0]:=' ����ID';
    self.StringGrid1.Cells[5,0]:=' ��ִ���ļ���';
    self.StringGrid1.Cells[6,0]:=' �ļ�·��';
    self.StringGrid1.Cells[7,0]:=' �ļ�˵�� / ��˾����';
    //
    self.Button1Click(self);
end;

//������״̬ת��Ϊ˵���ַ���
function StateToString(dwState : DWORD): String;
begin
    result:='';
    case dwState of
        MIB_TCP_STATE_CLOSED     : result:='�ر�';
        MIB_TCP_STATE_LISTEN     : result:='����';
        MIB_TCP_STATE_SYN_SENT   : result:='ͬ������';
        MIB_TCP_STATE_SYN_RCVD   : result:='ͬ������';
        MIB_TCP_STATE_ESTAB      : result:='�ѽ���';
        MIB_TCP_STATE_FIN_WAIT1  : result:='�ȴ����1';
        MIB_TCP_STATE_FIN_WAIT2  : result:='�ȴ����2';
        MIB_TCP_STATE_CLOSE_WAIT : result:='�ȴ��ر�';
        MIB_TCP_STATE_CLOSING    : result:='���ڹر�';
        MIB_TCP_STATE_LAST_ACK   : result:='���ȷ��';
        MIB_TCP_STATE_TIME_WAIT  : result:='�ȴ�ʱ��';
        MIB_TCP_STATE_DELETE_TCB : result:='ɾ��';
        else result:=Format('δ֪״̬%d',[dwState]);
    end;
end;

//���ݽ���ID���ҿ�ִ���ļ���
function IdToExeFile(hSnapshot : THandle; dwProcessId : DWORD): String;
var
    lppe : TProcessEntry32;
    b : BOOL;
begin
    lppe.dwSize:=SizeOf(lppe);
    //ȡ��1����������
    b:=Process32First(hSnapshot,lppe);
    result:='';
    while b do
    begin
        if lppe.th32ProcessID=dwProcessId then
        begin
            result:=lppe.szExeFile;
            break;
        end;
        //ȡ��һ������
        b:=Process32Next(hSnapshot,lppe);
    end;
end;

//���ݽ���ID���ҿ�ִ���ļ�·��
function IdToExeDir(dwProcessId : DWORD): String;
var
    cbNeeded : DWORD;
    hProcess : THandle;
    hModules : HMODULE;
    lpFilename : array [0..1024-1] of Char;
begin
    result:='';
    hProcess:=OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ,false,dwProcessId);
    if hProcess=0 then exit;
    EnumProcessModules(hProcess,@hModules,sizeof(hModule),cbNeeded);
    GetModuleFileNameEx(hProcess,hModules,lpFilename,1024);
    result:=lpFilename;
    CloseHandle(hProcess);
end;

//�����ļ��������ļ���Ϣ
function ExeDirToFileInfo(Filename : String): String;
var
    NameLen,BufLen,ValLen : DWORD;
    pBuf,pVal : Pointer;
    LangCode : String;
begin
    result:='';
    NameLen:=Length(Filename);
    if NameLen=0 then exit;
    //��ȡ�汾��Ϣ
    BufLen:=GetFileVersionInfoSize(PChar(Filename),NameLen);
    pBuf:=AllocMem(BufLen);
    if pBuf=nil then exit;
    if GetFileVersionInfo(PChar(Filename),0,BufLen,pBuf)=false then
    begin
        FreeMem(pBuf);
        exit;
    end;
    //��ȡ����ҳ��Ϣ
    if VerQueryValue(pBuf,'\VarFileInfo\Translation',pVal,ValLen)=false then
    begin
        FreeMem(pBuf);
        exit;
    end;
    LangCode:=Format('%.2x%.2x%.2x%.2x',[
        BYTE(PChar(pVal)[1]),
        BYTE(PChar(pVal)[0]),
        BYTE(PChar(pVal)[3]),
        BYTE(PChar(pVal)[2])]);
    //��ȡ�ļ�˵��
    if VerQueryValue(pBuf,PChar('\StringFileInfo\'+LangCode+'\FileDescription'),pVal,ValLen)=false then
    begin
        FreeMem(pBuf);
        exit;
    end;
    result:=PChar(pVal);
    //��ȡ��˾����
    if VerQueryValue(pBuf,PChar('\StringFileInfo\'+LangCode+'\CompanyName'),pVal,ValLen)=false then
    begin
        FreeMem(pBuf);
        exit;
    end;
    result:=result+' / '+PChar(pVal);
    FreeMem(pBuf);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
    hSnapshot : THandle; //���̿���
    pTcpTab : PMIB_TCPEXTABLE; //TCP���ӱ�
    pUdpTab : PMIB_UDPEXTABLE; //UDP���ӱ�
    i : Integer;
begin
    self.StringGrid1.RowCount:=2;
    //�������̿���
    hSnapshot:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
    //��ȡTCP���ӱ�
    if AllocateAndGetTcpExTableFromStack(pTcpTab,true,GetProcessHeap(),2,2)<>0 then
    begin
        MessageBox(self.Handle,'�޷���ȡTCP���ӱ�','����ʧ��',MB_ICONEXCLAMATION or MB_OK);
    end
    else
    begin
        //���TCP���ӱ�
        for i:=0 to pTcpTab.dwNumEntries-1 do
        begin
            self.StringGrid1.Cells[0,self.StringGrid1.RowCount-1]:=
                'TCP';
            self.StringGrid1.Cells[1,self.StringGrid1.RowCount-1]:=
                inet_ntoa(TInAddr(pTcpTab.table[i].dwLocalAddr))+
                ':'+IntToStr(ntohs(pTcpTab.table[i].dwLocalPort));
            self.StringGrid1.Cells[2,self.StringGrid1.RowCount-1]:=
                inet_ntoa(TInAddr(pTcpTab.table[i].dwRemoteAddr))+
                ':'+IntToStr(ntohs(pTcpTab.table[i].dwRemotePort));
            self.StringGrid1.Cells[3,self.StringGrid1.RowCount-1]:=
                StateToString(pTcpTab.table[i].dwState);
            self.StringGrid1.Cells[4,self.StringGrid1.RowCount-1]:=
                IntToStr(pTcpTab.table[i].dwProcessId);
            self.StringGrid1.Cells[5,self.StringGrid1.RowCount-1]:=
                IdToExeFile(hSnapshot,pTcpTab.table[i].dwProcessId);
            self.StringGrid1.Cells[6,self.StringGrid1.RowCount-1]:=
                IdToExeDir(pTcpTab.table[i].dwProcessId);
            self.StringGrid1.Cells[7,self.StringGrid1.RowCount-1]:=
                ExeDirToFileInfo(self.StringGrid1.Cells[6,self.StringGrid1.RowCount-1]);
            self.StringGrid1.RowCount:=self.StringGrid1.RowCount+1;
        end;
    end;
    //��ȡUDP���ӱ�
    if AllocateAndGetUdpExTableFromStack(pUdpTab,true,GetProcessHeap(),2,2)<>0 then
    begin
        MessageBox(self.Handle,'�޷���ȡUDP���ӱ�','����ʧ��',MB_ICONEXCLAMATION or MB_OK);
    end
    else
    begin
        //���UDP���ӱ�
        for i:=0 to pUdpTab.dwNumEntries-1 do
        begin
            self.StringGrid1.Cells[0,self.StringGrid1.RowCount-1]:=
                'UDP';
            self.StringGrid1.Cells[1,self.StringGrid1.RowCount-1]:=
                inet_ntoa(TInAddr(pUdpTab.table[i].dwLocalAddr))+
                ':'+IntToStr(ntohs(pUdpTab.table[i].dwLocalPort));
            self.StringGrid1.Cells[2,self.StringGrid1.RowCount-1]:=
                '*.*.*.*:*';
            self.StringGrid1.Cells[3,self.StringGrid1.RowCount-1]:=
                '';
            self.StringGrid1.Cells[4,self.StringGrid1.RowCount-1]:=
                IntToStr(pUdpTab.table[i].dwProcessId);
            self.StringGrid1.Cells[5,self.StringGrid1.RowCount-1]:=
                IdToExeFile(hSnapshot,PUdpTab.table[i].dwProcessId);
            self.StringGrid1.Cells[6,self.StringGrid1.RowCount-1]:=
                IdToExeDir(pUdpTab.table[i].dwProcessId);
            self.StringGrid1.Cells[7,self.StringGrid1.RowCount-1]:=
                ExeDirToFileInfo(self.StringGrid1.Cells[6,self.StringGrid1.RowCount-1]);
            self.StringGrid1.RowCount:=self.StringGrid1.RowCount+1;
        end;
    end;
    //�رվ��
    CloseHandle(hSnapshot);
    //
    if self.StringGrid1.RowCount=2 then
    begin
        self.Label1.Caption:='���� TCP/UDP ���Ӷ˿ڣ� 0 ��';
        self.StringGrid1.Cells[0,1]:='��';
        self.StringGrid1.Cells[1,1]:='';
        self.StringGrid1.Cells[2,1]:='';
        self.StringGrid1.Cells[3,1]:='';
        self.StringGrid1.Cells[4,1]:='';
        self.StringGrid1.Cells[5,1]:='';
        self.StringGrid1.Cells[6,1]:='';
        self.StringGrid1.Cells[7,1]:='';
    end
    else
    begin
        self.StringGrid1.RowCount:=self.StringGrid1.RowCount-1;
        self.Label1.Caption:=Format('���� TCP/UDP ���Ӷ˿ڣ� %d ��',
            [self.StringGrid1.RowCount-1]);
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
    ColLen : array of Integer;
    c,r,n : Integer;
    f : TFileStream;
    s : String;
begin
    if (self.StringGrid1.ColCount=0) or
       (self.StringGrid1.RowCount=0) then exit;
    if not self.SaveDialog1.Execute then exit;
    //����ÿ���ַ�����
    SetLength(ColLen,self.StringGrid1.ColCount);
    for c:=0 to self.StringGrid1.ColCount-1 do
    begin
        ColLen[c]:=0;
        for r:=0 to self.StringGrid1.RowCount-1 do
        begin
            n:=Length(self.StringGrid1.Cells[c,r]);
            if n>ColLen[c] then ColLen[c]:=n;
        end;
        ColLen[c]:=ColLen[c]+1;
    end;
    //ÿ�ж����д���ļ�
    f:=TFileStream.Create(self.SaveDialog1.FileName,fmCreate);
    for r:=0 to self.StringGrid1.RowCount-1 do
    begin
        for c:=0 to self.StringGrid1.ColCount-1 do
        begin
            s:=self.StringGrid1.Cells[c,r];
            n:=Length(s);
            s:=s+DupeString(' ',ColLen[c]-n);
            f.Write(Pointer(s)^,ColLen[c]);
        end;
        s:=#13#10#32;
        f.Write(Pointer(s)^,3);
    end;
    MessageBox(self.Handle,PChar(
        '���ӱ���Ϣ�ѱ��浽�ļ� '+
        self.SaveDialog1.FileName+
        ' �С�'),'�������',MB_ICONINFORMATION or MB_OK);
    //
    SetLength(ColLen,0);
    f.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    MessageBox(self.Handle,
        '�������Ӷ˿ڲ鿴��'+#13+#13+
        '���ߣ�yeye55'+#13+#13+
        '2008��2��25��'+#13+#13+
        '������������http://www.programbbs.com/bbs/�Ϸ���',
        '����',MB_ICONASTERISK or MB_OK);
end;

end.

