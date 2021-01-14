{���ú�����Ԫ����ɾ���Ĺ��ܣ�}
unit Unitpubsub;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes,  Controls, Forms,
  ExtCtrls,  StdCtrls,db,ComCtrls,adodb;
function addID(queryadd:TADOQuery;sql:string;maks:string):string; //����������ţ�
function queryrecord (queryname:TADOQuery;sql:string):boolean; //��ѯ true Ϊ�м�¼��falseΪû�м�¼;
function addpage(queryname:TADOQuery;recno:integer):boolean; //��ҳ������ӻ����ҳ
function ExecRecords(queryname :TADOQuery;SQLPUB:string):boolean; //�޸ĵ��ݴ���
function executesql(queryname :TADOQuery;SQLPUB:string):boolean;//�����ֱ���޸ģ�
procedure adduser;
procedure addstream;
procedure divuser;      //����              //���ݱ��         //�ܽ��         //������        //�����         //�Ƶ���  //������λ��ź�����
function INSERTmantable(indexs:integer;stock_no:string;totalmoney:double;passid:string;checkid:string;billeid:string;UnitId:string;Unitname:string;posid:string;remark:string;Awrite:TADOStoredProc;ATOTAL:TADOStoredProc):boolean;//д���������(t:ok;f:cancel);

function backDB(connection:tadoconnection;filename:string;dbname:string):boolean;
function TotalProcedure(Main_no: Integer; CheckID: String;ATOTAL:TADOStoredProc):integer;
var
servername :string;

implementation


function addID(queryadd:TADOQuery;sql:string;maks:string):string; //����������ţ�
var
  oldmax,newmax:string;
begin
  queryadd.Close;
  queryadd.SQL.Clear;
  queryadd.SQL.Text:=trim(sql);
  queryadd.Open;
  if (queryadd.RecordCount<=0) or (trim(queryadd.Fields.Fields[0].asstring)='') then
  begin
    newmax:=maks+'0001';
  end else
  begin
    oldmax:=inttostr(strtoint(trim(queryadd.Fields.Fields[0].AsString))+1);
    case length(oldmax) of
    1: newmax:=maks+'000'+oldmax;
    2: newmax:=maks+'00'+oldmax;
    3: newmax:=maks+'0'+oldmax;
    4: newmax:=maks+oldmax;
    end;
  end;
  queryadd.Close;
  result:=trim(newmax);
end;
function queryrecord(queryname:TADOQuery;sql:string):boolean; //��ѯ true Ϊ�м�¼��falseΪû�м�¼;
begin
//ydy add ʹ���첽ִ�з�ʽ
//  queryname.ExecuteOptions := queryname.ExecuteOptions+[eoAsyncFetchNonBlocking];
//  queryname.CacheSize := 200;     //ydy ��Ϊ100-1000��  ֱ����aqpublic
  queryname.Close;
  queryname.SQL.Clear;
  queryname.SQL.Text:=trim(sql);
  queryname.Open;
  if queryname.RecordCount<=0 then
  begin
    result:=false;
  end else
  begin
    result:=true;
  end;
end;
function addpage(queryname:TADOQuery;recno:integer):boolean; //��ҳ������ӻ����ҳ(Ϊֻ���)
begin
  if recno<queryname.RecordCount then
  begin
    queryname.RecNo:=recno;
    result:=true;
  end else
  begin
    result:=false;
  end;
end;


function ExecRecords(queryname :TADOQuery;SQLPUB:string):boolean; //�޸ĵ��ݴ���
begin
  result:=false;
  queryname.Close;
  queryname.SQL.Clear;
  queryname.SQL.Text:=trim(SQLPUB);
  try
    queryname.Open;
    result:=true;
  except
    exit;
  end;
end;

function executesql(queryname :TADOQuery;SQLPUB:string):boolean;//�����ֱ���޸ģ�
var
  r:boolean;
begin
  r:=false;
  queryname.Close;
  queryname.SQL.Clear;
  queryname.SQL.Text:=trim(sqlpub);
  try
  queryname.ExecSQL;
  r:=true;
  queryname.Close;
  except
  end;
  result:=r;
end;
procedure adduser;
begin
   //fmservermain.Luser.Caption:=inttostr(strtoint(fmservermain.Luser.Caption)+1);
end;
procedure divuser;
begin
  //fmservermain.Luser.Caption:=inttostr(strtoint(fmservermain.Luser.Caption)-1);
end;
procedure addstream;
begin
  //fmservermain.Lstream.Caption:=inttostr(strtoint(fmservermain.Lstream.Caption)+1);
end;
function INSERTmantable(indexs:integer;stock_no:string;totalmoney:double;passid:string;checkid:string;billeid:string;UnitId:string;Unitname:string;posid:string;remark:string;Awrite:TADOStoredProc;ATOTAL:TADOStoredProc):boolean;//д���������(t:ok;f:cancel);
var
  returnid:integer; //����MAINTABLE id
  retrunflag:integer; //����ִ�гɹ���־;
  typed:array [1..27] of integer;
  i:integer;
  bool:boolean;
begin
  for i:=1 to 27 do  //��ʼ������;
  begin
    if i<=4 then
    begin
      typed[i]:=100+i;
    end;
    if i in [5..8] then
    begin
      typed[i]:=200+(i-4);
    end;
    if i in [9,10] then
    begin
      typed[i]:=300+(i-8);
    end;
    if i in [11..13] then
    begin
      typed[i]:=400+(i-10);
    end;
    if i in [14,15] then
    begin
      typed[i]:=500+(i-13);
    end;
    if i in [16..18] then
    begin
      typed[i]:=600+(i-15);
    end;
    if i in [19..22] then
    begin
      typed[i]:=700+(i-18);
    end;
    if i in [23..27] then
    begin
      typed[i]:=800+(i-22);
    end;
  end;
  /////////////////////////////////
  //awrite.ProcedureName:='WriteMainBill';
  awrite.Close;
  awrite.Parameters.ParamByName('@BillCode').Value:=trim(stock_no);
  awrite.Parameters.ParamByName('@Billtype').Value:=typed[indexs];
  awrite.Parameters.ParamByName('@Billdate').Value:=formatdatetime('yyyy''-''mm''-''dd',now);
  awrite.Parameters.ParamByName('@Billeid').Value:=trim(billeid);
  awrite.Parameters.ParamByName('@checkeid').Value:=trim(checkid);//�����
  awrite.Parameters.ParamByName('@passeid').Value:=trim(passid);//����
  awrite.Parameters.ParamByName('@unitid').Value:=trim(unitid);
  awrite.Parameters.ParamByName('@unitname').Value:=trim(unitname);
  awrite.Parameters.ParamByName('@total').Value:=totalmoney;
  awrite.Parameters.ParamByName('@ischeck').Value:=trim('f');
  awrite.Parameters.ParamByName('@red').Value:=trim('f');
  awrite.Parameters.ParamByName('@Shopno').Value:=posid;
  awrite.Parameters.ParamByName('@Explain').Value:=trim(remark);
  awrite.Parameters.ParamByName('@EditMode').Value:=0;
  awrite.Parameters.ParamByName('@Billid').Value:=0;
  awrite.Prepared;
  awrite.ExecProc;
  returnid:=awrite.Parameters.ParamByName('@RETURN_VALUE').Value;
  bool:=false;
  if returnid=-1 then
  begin
     bool:=false;
  end else
  begin
    //ATOTAL.ProcedureName:='LQ_FillAccount';
    atotal.Close;
    ATOTAL.Parameters.ParamByName('@BillId').Value:=returnid;
    ATOTAL.Parameters.ParamByName('@checke').Value:=trim(checkid);
    ATOTAL.Prepared;
    ATOTAL.ExecProc;
    retrunflag:=ATOTAL.Parameters.ParamByName('@RETURN_VALUE').Value;
    if retrunflag=0 then
    begin
      bool:=true;
    end;
  end;
  result:=bool;
  ////////////////////////////////////
end;

function backDB(connection:tadoconnection;filename:string;dbname:string):boolean;
var
  adop:tadocommand;
begin
  result:=false;
  adop:=tadocommand.Create(nil);
  adop.Connection:=connection;
  try
  adop.CommandText:='backup database '+trim(dbname)+' To disk='+''''+trim(filename)+'''';
  adop.Execute;
  adop.Free;
  adop:=nil;
  result:=true;
  except
    adop.Free;
    adop:=nil;
  end;
end ;


function TotalProcedure(Main_no: Integer; CheckID: String;ATOTAL:TADOStoredProc):integer;
begin
  atotal.Close;
  ATOTAL.Parameters.ParamByName('@BillId').Value:=main_no;
  ATOTAL.Parameters.ParamByName('@checke').Value:=trim(checkid);
  ATOTAL.Prepared;
  ATOTAL.ExecProc;
  result:=ATOTAL.Parameters.ParamByName('@RETURN_VALUE').Value;
end;
/////////////////////////
end.
