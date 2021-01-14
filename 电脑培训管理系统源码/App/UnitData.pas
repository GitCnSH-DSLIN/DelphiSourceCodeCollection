unit UnitData;

interface
uses Windows, Messages, SysUtils,Forms,Classes,IniFiles,DBCtrls,DBTables,
DB,DateUtils, Grids, DBGrids;

var
ini:TIniFile;
sPath:string;//ϵͳ·��
sWarrant:string;//�û�Ȩ��
sOperator,sWorker:string;
sIme,sCompanyName,sCompanyPhone,sCompanyAddress:string;
//���뷨����˾���ơ���˾�绰����˾��ַ

    function Msgs(Msgs:string;Button:string='OK'):integer;
    //������ʾ��ʾ�Ի���
    //�кܶ�Ĭ�ϵ�ѡ��,��ֱ��ʹ��,����¼��
    //
    procedure CreateIni(str:string);
    procedure DestroyIni;
    // ��ȡ���ֵ�ƴ�����ַ�,�������������GetPYIndexStr ��.
    function GetPYIndexChar(strChinese: string; bUpCase: Boolean = True): char;

    // ��ȡ������ֵ�ƴ�����ַ���ɵ��ַ���.
    function GetPYIndexStr(strChinese: string; bUpCase: Boolean = True): string;
    procedure ShowDetail(dbm:TObject);
    //��ʾDBEdit��DBMemo������
    procedure AddToItem(TableName,FindField:string;AddItem:TStrings;mClear:Boolean=true;Condition:string='NULL');
    //TableNameҪ���ֶ����ڵı�,FindField��Ҫ���뵽TSTrings����ֶ�,
    //Condition����,���Բ���,Ĭ��Ϊ'NULL'
    //
    function GetValue(TableName,FindField,ReturnField,FindString:string;Condition:string='NULL'):string;
    //����ָ�����ַ�����ָ���ı��н�����ȡ����
    //
    function GetStrId(mQuery:TObject;mFieldName:string):string;
    //���ڸ��������ֶ����Ӳ�ѯ�з�����ֵ
    //
    procedure SetStrId(mQuery:TObject;mFieldName,mValue:string);
    //���ڸ��������ֶ���(mFieldName)���ó���������ֵ(mvalue)

    function ReturnWeek(dt:TDateTime):string;

implementation

uses UnitDetail, UnitDM;
//-----------------------------------------------------------
/////////////////////////////////////////////////////
//����:   Msg
//����:
//����:Msg,��Ҫ��ʾ��ʾ��Ϣ
//     Button,��ť��Ϣ(��ʾ�Ի��������ļ�����ť,Ĭ�Ͼ�ֻ��OK��ť)
//����ֵ:��ʾ�û������ĸ���ť
/////////////////////////////////////////////////////
function Msgs(Msgs:string;Button:string='OK'):integer;
var
    b:integer;
    Str:string;
begin
//������ʾ��ʾ�Ի���
//�кܶ�Ĭ�ϵ�ѡ��,��ֱ��ʹ��,����¼��

b:=0; //Ĭ��ΪOK��ť

if Button='OK' then  b:=MB_OK+MB_ICONWARNING;
if Button='OKCANCEL' then b:=MB_OKCANCEL+MB_ICONWARNING; //OK��CANCEL��ť
if Button='YESNO' then b:=MB_YESNO+MB_ICONWARNING;     //YES��NO ��ť

Str:=Msgs;

if Msgs='window' then Str:='������������з�������';
if Msgs='error' then Str:='����δ֪����';

result:=Application.MessageBox(PChar(Str),'��ʾ',b);
end;
//------------------------------------------------------------------------------
procedure CreateIni(str: string);
begin
ini:=TIniFile.Create(str);
end;
//------------------------------------------------------------------------------
procedure DestroyIni;
begin
ini.Free;
end;

//------------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////
// ����: GetPYIndexChar(strChinese: string;bUpCase: Boolean = True): char;
//
// ��������:��ȡ���ֵ�ƴ�����ַ�.
// ��: GetPYIndexChar('��') ������'C'.
//
// ע��:���ڶ���һ�����ֵ�����(string����)ֻ�е�һ����Ч,�������������
// ����,GetPYIndexChar('����')Ҳ������'C'.
//
// �ڶ��������������ش�д����Сд , ȱʡΪ��д .
////////////////////////////////////////////////////////////////////////////
function GetPYIndexChar(strChinese: string;bUpCase: Boolean = True): char;
begin
// ���ݺ��ֱ���ƴ�����ַ��ֱ�Ϊ��A������Z���ĺ������뷶Χ��
// Ҫ�����ĺ���ֻ��Ҫ�����������λ����һ�����ַ��ķ�Χ�ڣ�
// �Ϳ����жϳ�����ƴ�����ַ���
  case WORD(strChinese[1]) shl 8 + WORD(strChinese[2]) of
    $B0A1..$B0C4 : result := 'A';
    $B0C5..$B2C0 : result := 'B';
    $B2C1..$B4ED : result := 'C';
    $B4EE..$B6E9 : result := 'D';
    $B6EA..$B7A1 : result := 'E';
    $B7A2..$B8C0 : result := 'F';
    $B8C1..$B9FD : result := 'G';
    $B9FE..$BBF6 : result := 'H';
    $BBF7..$BFA5 : result := 'J';
    $BFA6..$C0AB : result := 'K';
    $C0AC..$C2E7 : result := 'L';
    $C2E8..$C4C2 : result := 'M';
    $C4C3..$C5B5 : result := 'N';
    $C5B6..$C5BD : result := 'O';
    $C5BE..$C6D9 : result := 'P';
    $C6DA..$C8BA : result := 'Q';
    $C8BB..$C8F5 : result := 'R';
    $C8F6..$CBF9 : result := 'S';
    $CBFA..$CDD9 : result := 'T';
    $CDDA..$CEF3 : result := 'W';
    $CEF4..$D188 : result := 'X';
    $D1B9..$D4D0 : result := 'Y';
    $D4D1..$D7F9 : result := 'Z';
    else
               result := char(0);
  end;
  if not bUpCase then
  begin // ת��ΪСд
    result := Chr(Ord(result)+32);
  end;
end;

////////////////////////////////////////////////////////////////////////////
// ����: GetPYIndexStr(strChinese: string;bUpCase: Boolean = True): string;
//
// ��������:��ȡ������ֵ�ƴ�����ַ���ɵ��ַ���.
// ��: GetPYIndexStr('��') ������'C'.
//     GetPYIndexStr('����')������'CX'.
//
// �ڶ��������������ش�д����Сд , ȱʡΪ��д .
////////////////////////////////////////////////////////////////////////////
function GetPYIndexStr(strChinese: string;bUpCase: Boolean = True): string;
var
  strChineseTemp : string;
  cTemp : Char;
begin
  result := '';
  strChineseTemp := strChinese;
  while strChineseTemp<>'' do
  begin
    cTemp := GetPYIndexChar(strChineseTemp);
    if not bUpCase then
    begin // ת��ΪСд
      cTemp := Chr(Ord(cTemp)+32);
    end;
    result := result + string(cTemp);
    strChineseTemp := Copy(strChineseTemp,3,Length(strChineseTemp));
  end;
end;


//------------------------------------------------------------------------------
procedure ShowDetail(dbm:TObject);
begin
try
    frmDetail:=TfrmDetail.Create(nil);
    if dbm is TDBMemo then
    begin
        frmDetail.Caption:=TDBMemo(dbm).Field.DisplayName;
        frmDetail.DBMemo1.DataSource:=TDBMemo(dbm).DataSource;
        frmDetail.DBMemo1.DataField:=TDBMemo(dbm).DataField;
    end;
    if dbm is TDBEdit then
    begin
        frmDetail.Caption:=TDBEdit(dbm).Field.DisplayName;
        frmDetail.DBMemo1.DataSource:=TDBEdit(dbm).DataSource;
        frmDetail.DBMemo1.DataField:=TDBEdit(dbm).DataField;
    end;
    if dbm is TColumn then
    begin
        frmDetail.Caption:=TColumn(dbm).Field.DisplayName;
        frmDetail.DBMemo1.DataSource:=TColumn(dbm).Field.DataSet.DataSource;
        frmDetail.DBMemo1.DataField:=TColumn(dbm).FieldName;
    end;
    frmDetail.ShowModal;
    frmDetail.Free;
except
    Msgs('window');
    frmDetail.Free;
end;

end;

//------------------------------------------------------------------------------
//-----------------------------------------------------------
/////////////////////////////////////////////////////
//����: AddToItem
//����: ��һ������ĳһ�ֶε�ֵȫ�����浽һ��TStrings����
//      �ı���AddItem��ȥ��
//����: TableNameҪ���ֶ����ڵı�,FindField��Ҫ���뵽
//      TSTrings����ֶ�,
//      AddItem������������������FindField��ֵ��
//      mClear�Ƿ����AddItem��
//      Condition����SQL�е�WHERE����,���Բ���,Ĭ��Ϊ'NULL'
//
//����ֵ: ��
/////////////////////////////////////////////////////

procedure AddToItem(TableName, FindField: string; AddItem: TStrings;mClear:Boolean=true;Condition:string='NULL');
var
    s:string;
//    i:integer;
begin
if mClear then
    AddItem.Clear;

DM.Q_Any.Close;
DM.Q_Any.SQL.Clear;
DM.Q_Any.SQL.Add('SELECT DISTINCT '+FindField+' FROM '+TableName);
if Condition<>'NULL' then
    DM.Q_Any.SQL.Add(' WHERE '+ Condition);

DM.Q_Any.Open;

if DM.Q_Any.RecordCount<=0 then Exit; //����û�����ݼ�¼���˳�

while not DM.Q_Any.Eof do
begin
    s:='';
    //for i:=0 to DM.Q_Any.FieldCount-1 do
        s:=s+DM.Q_Any.Fields.Fields[0].AsString;
    if (s<>'') then  AddItem.Add(s);

    DM.Q_Any.Next;
end;
DM.Q_Any.Close;
end;
//-------------------------------------------------------------------
/////////////////////////////////////////////////////
//����:GetValue
//����: ��һ�������ҳ�����������һ���ֶ�ֵ��
//����:TableNameҪ���ֶ����ڵı�,FindFieldҪ�ҵ��ֶ���,
//       ReturnField��Ҫ���ص��ֶ�����
//     FindStringҪ�ҵ��ֶ�ֵ��Condition����SQL�е�
//     WHERE����,���Բ���,Ĭ��Ϊ'NULL'
//����ֵ:''��ʾû���ҵ�����������ֵ������ͷ����ҵ���ֵ
/////////////////////////////////////////////////////
function GetValue(TableName,FindField,ReturnField,FindString: string;Condition:string='NULL'): string;
begin
DM.Q_Any.Close;
DM.Q_Any.SQL.Clear;
DM.Q_Any.SQL.Add('SELECT '+ReturnField+','+FindField+' FROM '+TableName+' WHERE ('+FindField+' = '''+FindString+''')');
if Condition<>'NULL' then
    DM.Q_Any.SQL.Add(' and ('+Condition+')');
DM.Q_Any.Open;
if DM.Q_Any.RecordCount=0 then  //û�����������ļ�¼
begin
result:='';
end
else
begin
result:=DM.Q_Any.fields.Fields[0].AsString;
end;
DM.Q_Any.Close;
end;
//-----------------------------------------------------------
/////////////////////////////////////////////////////
//����:GetStrId
//����:�õ��ֶ���Ϊ mFieldName��ֵ
//����: mQuery��ѯ����mFieldName�ֶ���
//
//����ֵ: �ֶε�ֵ
/////////////////////////////////////////////////////
function GetStrId(mQuery:TObject;mFieldName:string):string;
begin
if mQuery is TQuery then
    Result:=TQuery(mQuery).FieldByName(mFieldName).AsString;
if mQuery is TTable then
    Result:=TTable(mQuery).FieldByName(mFieldName).AsString;
if mQuery is TDataSource then
    Result:=TDataSource(mQuery).DataSet.FieldByName(mFieldName).AsString;

end;
//-----------------------------------------------------------
/////////////////////////////////////////////////////
//����:SetStrId
//����:�����ֶ���Ϊ mFieldName��ֵ
//����: mQuery��ѯ����mFieldName�ֶ�����mValue�ֶ�ֵ
//
//����ֵ: ��
/////////////////////////////////////////////////////
procedure SetStrId(mQuery:TObject;mFieldName,mValue:string);
begin
if mQuery is TQuery then
begin
    if not (TQuery(mQuery).State in [dsEdit,dsInsert]) then Exit;
    TQuery(mQuery).FieldByName(mFieldName).AsString:=mValue;
end;
if mQuery is TDataSource then
begin
    if not (TDataSource(mQuery).DataSet.State in [dsEdit,dsInsert]) then Exit;
    TDataSource(mQuery).DataSet.FieldByName(mFieldName).AsString:=mValue;
end;
end;
//------------------------------------------------------------------------------
function ReturnWeek(dt:TDateTime):string;
var
    yy,wy,dy:word;
begin
    DecodeDateWeek(dt,yy,wy,dy);
    case dy of
        1:result:='����һ';
        2:result:='���ڶ�';
        3:result:='������';
        4:result:='������';
        5:result:='������';
        6:result:='������';
        7:result:='������';
    end;
end;
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------


end.
