unit U_Public;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, DBGrids, DBClient, DB, Registry, winsock,ADODB;

type
  TCurrentParam = record
//���ӱ���
    LoginTime: string;
    Host: string;
    IP: string;
    Num:integer; //�жϱ��0,1
    N_E:integer; //���Ӻ��޸ı��  0,1
//   ���������Ϣ
     userAliasName:string;
     UserName:string;
     CkID:string;
     CkName:string;
     usetype:string;

//���嵥λ��Ϣ��

  //��ӡ����
//    PrintTitle:string;
//������ʱ����ֵ
     tmpCode:string;
     tmpName:string;
     jldw,jldw2:string;
     ggxh:string;
     bzq:string;
     gphh:string;
     sl:double;
     dj:double;
     dj1:double;
     zj,
     bl:double;
     fsyn:string;
     tmpFind
     ,bprint
     ,tzcl
     ,blnADD:boolean;

//���嵥�ݺź��������
    djh,PrintTitle:string;
    ph,printDate :string;
    tzje:double;
//��λ��Ϣ
   dwcode,
   name,
   address,
   tele,
   khyh,
   khyhzh,
   lxr:string;
   past:integer;
  end;

function ConnectLocalDB(const adocon:TadoConnection;const dbname,computername,username,Password:string):boolean;
  function GetComputerIP: string;
//  function ConnectAppServ: boolean; //�ж��Ƿ���������Ӧ�÷�����
  //
  function GetComputerName: string;
  function showMDIForm(aFormClass: TFormClass): TForm;

  function edit_no(L:integer;id:string):string ;
  //
  {�ӽ���}
  function CryptStr(const S:String):String;

{������}
  function CryGetStr(const S:String):String;
  function findundo(const sfields,tbname,sValue:string;ado:TADOQuery):boolean;
//******************************���ù���ֵ******************************************
  //  function DBConnect(aServerName, aDatabaseName, aUserName, aPassword: string): boolean;
  procedure ShowModalForm(aFormClass: TFormClass);
  procedure DbGridSort(dbgrid: TDBGrid; Column: TColumn);
  procedure deledata(const sfields,tbname:string;sValue:variant;ado:TADOQuery);
  procedure cleardata(const tbtmp:string;ado:TADOQuery);
  procedure autorecordtmp(const tbtmp:string;nCont,nRecord:integer;qytmp:TADOQuery) ;
//  procedure close_open_tbtmp;
//  function DBConnect(aServerName, aDatabaseName, aUserName, aPassword: string): boolean;
var
  CurrentParam: TCurrentParam;
  psIndexName: string;
  plAscend:Boolean;
  strsql:string;
implementation
   USES  MAIN,U_DM;
//�������
procedure cleardata(const tbtmp:string;ado:TADOQuery);
begin
strsql:='DELETE FROM  '+tbtmp ;
ado.Close ;
ado.SQL.Clear ;
ado.SQL.Add(strsql);
ado.ExecSQL ;
end;
////
procedure autorecordtmp(const tbtmp:string;nCont,nRecord:integer;qytmp:TADOQuery) ;
var
  i:integer;
begin
strsql:='insert into '+tbtmp+'(seri)';
strsql:=strsql+' values(:@seri)';
for i:=nCont to nRecord do
begin
with qytmp do
begin
  close;
  sql.Clear ;
  sql.Add(strsql);
  Parameters.ParamByName('@seri').Value :=i;
  prepared;
  EXEcsql;
end;
end;
end;

procedure deledata(const sfields,tbname:string;sValue:variant;ado:TADOQuery);
var
 strsql:string;
begin
 strsql:='delete from ' + tbname ;
 strsql:=strsql + ' Where '+ sfields + '=:@s';
 with ado do
 begin
 Close ;
 SQL.Clear ;
 SQL.Add (strsql);
 Prepared ;
 Parameters.ParamByName('@s').Value :=sValue;
 ExecSQL;
end;
end;



procedure ShowModalForm(aFormClass: TFormClass);
begin
  frmMain.statusbar1.Panels[0].text := '���ڴ򿪴���,���Ժ�...';
  frmMain.statusbar1.refresh;
  screen.Cursor := crHourGlass;
  with aFormClass.Create(Application) do
  begin
    frmMain.statusbar1.Panels[0].text := '';
    frmMain.statusbar1.refresh;
    screen.Cursor := crDefault;
    try
      showModal;
    finally
      free;
    end;
  end;
end;



procedure DbGridSort(dbgrid: TDBGrid; Column: TColumn);
var
//��ģ��ʹ�õ���psIndexName, plAscend�����������϶���
  mode: char; //��¼�ǡ����򡱻��ǡ�����
  ColName: string; //��¼��ǰ�ֶ���
  iCol: Integer; //��¼��ǰ�к�
begin
  with dbgrid.DataSource.DataSet as Tclientdataset do //Table0
  begin
//��⵱ǰ�������Ƿ��Ѵ�
    if not Active
      then begin
      Application.MessageBox('��������δ�򿪣�', 'ֹͣ', MB_OK + MB_ICONSTOP);
      Abort
    end;
//��⵱ǰ�ֶ��Ƿ������򡱡������ֶ����Ͳ�������
    case Column.Field.DataType of
      ftBoolean,
        ftBytes,
        ftBlob, //Binary
        ftMemo,
        ftGraphic,
        ftFmtMemo, //Formatted memo
        ftParadoxOle: //OLE
        begin
          Abort
        end;
    end; //case
    mode := '0';
    iCol := Column.Field.FieldNo - 1;
    try
      ColName := Column.fieldname;
      if psIndexName = Column.fieldname then
      begin //��ԭ��ͬ��
        if plAscend //����
          then begin
          mode := '2';
          IndexName := ColName + '2'; //Ӧ������
        end
        else begin
          mode := '1';
          IndexName := ColName + '1'; //Ӧ������
        end;
        plAscend := not plAscend;
      end
      else begin //����
        IndexName := ColName + '2';
        plAscend := false;
        psIndexName := ColName;
      end;
    except
      on EDatabaseError do //��δ�������������½���
      begin
//�����½�����
        IndexName := '';
        if mode = '1'
          then AddIndex(ColName + '1', ColName, [], '', '', 0) //
        else //����'0'
          AddIndex(ColName + '2', ColName, [ixDescending], '', '', 0);
        try //try 1
          if mode <> '1'
            then begin
            mode := '2'; //ת��
            plAscend := false;
          end
          else plAscend := true;
          IndexName := ColName + mode;
          psIndexName := ColName;
        except
          IndexName := '';
        end //try 2
      end
    end;
    first;
  end; //with
  dbgrid.SelectedIndex := iCol;
end;

//******************************���ú���ֵ****************************************** ******************//

//   Ѱ���ظ�ֵ
function findundo(const sfields,tbname,sValue:string;ado:TADOQuery):boolean;
var
 strsql:string;
begin
 result:=false;
 strsql:='select '+ sfields +' from ' + tbname ;
 strsql:=strsql + ' Where '+ sfields + '=:@s';
 with ado do
 begin
 Close ;
 SQL.Clear ;
 SQL.Add (strsql);
 Prepared ;
 Parameters.ParamByName('@s').Value :=sValue;
 Open ;
 if RecordCount >0 then
    result:=true;
 end;
end;
//DecodeDate(date,Year,Month,Day);
function showMDIForm(aFormClass: TFormClass): TForm;
begin
  frmMain.statusbar1.Panels[0].text := '���ڴ򿪴���,���Ժ�...';
  frmMain.statusbar1.refresh;
  screen.Cursor := crHourGlass;
  lockwindowupdate(frmMain.handle);
  result := aFormClass.Create(Application);
  with result do
  begin
    top:=100;
    left:=60;
//    WindowState := wsMaximized;
    //position:=poDesktopCenter;//poScreenCenter;//pomainformcenter;
    frmMain.statusbar1.Panels[0].text := '';
    frmMain.statusbar1.refresh;
    show;
    lockwindowupdate(0);
    screen.Cursor := crDefault;
  end;
end;
//
function ConnectLocalDB(const adocon:TadoConnection;const dbname,computername,username,Password:string):boolean;
begin
 with adocon do
 begin
  Close;
  LoginPrompt:=false;    //�����ݿⲻ����ʱ�������жϡ�����������
  ConnectionString:='Provider=SQLOLEDB.1;'+
                   'Password='+Password+';'+
                   'Persist Security Info=True;'+
                   'User ID='+username+';Initial Catalog='+dbname+';'+
                   'Data Source='+ComputerName;
  try
    KeepConnection:=true;
    Connected:=true;
    Open;
    ConnectLocalDB:=true;
   except
     ConnectLocalDB:=false;
   end;
   end;
end;
{��ȡ���ؼ����������}

function GetComputerName: string;
var
  pcComputer: PChar;
  dwCSize: DWORD;
begin
  dwCSize := MAX_COMPUTERNAME_LENGTH + 1;
  result := '';
  GetMem(pcComputer, dwCSize);
  try
    if Windows.GetComputerName(pcComputer, dwCSize) then
      Result := pcComputer;
  finally
    FreeMem(pcComputer);
  end;
end;

///////////////��ȡ���ؼ������IP��ַ

function GetComputerIP: string;
var
  ch: array[1..32] of Char;
  i: Integer;
  WSData: TWSAData;
  MyHost: PHostEnt;
  S_IP: string;
begin
  if WSAstartup(2, wsdata) <> 0 then
    EXIT;
  if getHostName(@ch[1], 32) <> 0 then
    EXIT;
  MyHost := GetHostByName(@ch[1]);
  if MyHost = nil then
    EXIT
  else
  begin
    for i := 1 to 4 do
    begin
      S_IP := S_IP + inttostr(Ord(MyHost.h_addr^[i - 1]));
      if i < 4 then
        S_IP := S_IP + '.';
    end;
  end;
  RESULT := S_IP;
end;
/////////////

{
function ConnectAppServ: boolean; //�ж��Ƿ���������Ӧ�÷�����
var
  vs_Host, vs_Address, vs_Port: string;
  reg: TRegistry;
begin
  Result := True;
  reg := Tregistry.create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
//  frmMain.SocketConnection.Connected := false;
  //��ȡע������õ�Ӧ�÷�������Ϣ
  if Reg.OpenKey('\Software\�ִ�����', False) then
  begin
    vs_Host := reg.ReadString('Host');
    vs_Address := reg.ReadString('Address');
    vs_Port := reg.readstring('Port');
    try
      CurrentParam.IP := vs_Address;
 {     dm.dbconnect.ConnectionString :='Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initial Catalog=fspsami;Data Source='+CurrentParam.IP;
      dm.dbconnect.Open ;

      sys_dm.sdbconnect.ConnectionString :='Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initial Catalog=fspsami;Data Source='+CurrentParam.IP;
      sys_dm.sdbconnect.Open ;

      dmls.sadoconn.ConnectionString :='Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initial Catalog=fspsami;Data Source='+CurrentParam.IP;
      dmls.sadoconn.Open ;   }
      //��������
//      with frmMain do
//      begin
//        SocketConnection.Address := vs_Address;
//        SocketConnection.Host := vs_Host;
//        SocketConnection.Port := strtoint(vs_Port);
//        SocketConnection.Connected := true;
//      end;
 {     reg.closekey;
    except //δ�����ϣ��������ô���
      reg.closekey;
      if not LjszExecute(TfrmLjsz) then
        Result := False;
    end;
  end
  else
  begin
    if not LjszExecute(TfrmLjsz) then //���û��ע����Ϣ���������ô���
      Result := False;
  end;
end;}

{�ӽ���}
function CryptStr(const S:String):String;
var
  i: Integer;
  FKey: Integer;
begin
  result:='';
    begin
 //     Randomize;
 //     FKey := Random($FF);
      FKey:=254-length(s) ;
      for i:=1 to Length(s) do
       Result := Result+Chr( Ord(s[i]) xor i xor FKey);
      Result := Result + Char(FKey);
    end;
end;

function CryGetStr(const S:String):String;
var
  i: Integer;
  FKey: Integer;
begin
  result:='';
   Begin
      FKey :=  Ord(S[Length(s)]);
      for i:=1 to Length(s) - 1 do
      Result := Result+Chr( Ord(s[i]) xor i xor FKey);

   end;
end;

function edit_no(L:integer;id:string):string ;
var
i:integer;
s:string;
begin
   s:='0';
   i:=length(id);
   i:=L-i;
   for i:=0 to i-1 do
     s:='0'+s  ;
  result:=s+id;
end;

end.
