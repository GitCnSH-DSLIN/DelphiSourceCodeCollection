unit uDataBaseEValue;

interface

uses utilities,uConstant,db,SysUtils,dbtables, controls, dbgrids, dbctrls, Variants;

var
  linFieldCheck: Boolean=false;

//==============================================================================
//                     Table EValue
//==============================================================================

// ������е���λ , ���� Befor Post ʱ����
procedure CheckFieldVal(Sender: TDataSet);

//����Ѱ����ʱ,�Ҳ�������,����ʾѶϢ���ʹ����,�Ҳ�������,������True
function R_TableIsEmpty(DataSet: TDataSet): Boolean;

//==============================================================================
//                    TField EValue
//==============================================================================


//------------------------------------------------------------------------------
//function CheckUniqueKey ˵��
//����:����Ƿ��м�ֵ�ظ����Ǹñ������Ƿ��������Ͽ���
//����:
//      xDataSource : ����Ҫ�������ϼ���datasource
//      sKeyName    : keyֵ��λֵ
//      sInputData  : ���������λֵ
//  ����ֵ: ����Ψһʱ,����True;
//          ����Ψһʱ,����False;
//------------------------------------------------------------------------------
function EValueUniqueKey(xDataSource: TDataSource; sKeyName : Array of string;
         sInputData : Array of string):boolean;

//�����λֵ�Ƿ�ΪΨһֵ
procedure EValue_Unique(Sender: TField; xDataSource: TDataSource; sOriVal: string='');

//�����λֵ�Ƿ��춵��0
procedure EValueNumber(Sender: TField);

//����Ƿ���������λֵ
procedure EValue_IsNotNull(Sender: TField; sDefVal: string='');

//------------------------------------------------------------------------------
//function EValue_ForeignKey_IsExist function ˵��
//����:���ĳ����λ��ֵ�Ƿ����ĳ�������,��ForeignKey �Ƿ����
//����:
//      Master_table : ForeignKey ����Ӧ�����ϱ�����,������TTAble ���� TQuery
//      Field        : ForeignKey ����Ӧ������λ����
//      Value        : ��Ҫ����ֵ
//------------------------------------------------------------------------------

function EValue_ForeignKey_IsExist(Master_table:TDBDataSet;Field: string; value:variant): boolean;


//==============================================================================
//������
//==============================================================================

//���������������Ƿ�����������
procedure CheckIntegrity(E: EDatabaseError;sms: string);

//����ǲ����ظ�KEYֵ
Procedure CheckKeyValue(E:EDatabaseError; sms: string='��Ų����ظ�');

//����Ƿ��з���Required ERR
procedure CheckRequired(E:EDatabaseError; var Action: TDataAction);

//���������ϸ������ɾ��
Procedure CheckDetailExist(E:EDatabaseError;sms: string);

// �ж��Ƿ���ڹ������� - �� SQL ����ж�
function ExistSglRelation(var xQry: TQuery; sSQL: string; lInfo: Boolean=True): Boolean;

// �ж��Ƿ���ڹ������� - ͨ������ı������ⲿ����λ���ж�
function ExistRelation(var xQry: TQuery; sVal: string; asRelTbNm, asRelFdNm: Array of string; lNum: Boolean=True; lInfo: Boolean=True): Boolean;



// fun : ��һ�����ϴ��ڹ�������,�򲻿�ɾ����������ֵ
//function Pro_CheckIntegrity(xQry:TQuery; lEdt:boolean; KeyControl:TWinControl;
//         KeyField:TField; refMes,refTB,refFD: array of string):boolean;

function Pro_CheckIntegrity(xQry:TQuery; lEdt:boolean;
         KeyControl: array of TWinControl;
         KeyField: array of TField;
         refMes,refTB,refFD: array of string):boolean;

implementation


// ������е���λ , ���� Befor Post ʱ����
procedure CheckFieldVal(Sender: TDataSet);
var
  i: Integer;
  xEvent: TFieldNotifyEvent;
begin
  for i := 0 to Sender.FieldCount-1 do
    if Assigned(Sender.Fields[i].OnValidate) then
    begin
      xEvent := Sender.Fields[i].OnValidate;
      xEvent(Sender.Fields[i]);
    end;
end;


//������������λ�����Ƿ����ظ�,(����ҵ�����ϱ���)
function EValueUniqueKey(xDataSource: TDataSource; sKeyName : Array of string;
         sInputData : Array of string):boolean;
var
  sQuery : string;
  iCount : integer;
  iKeyNameNum : integer;
  iInputNum : integer;
  TableName: string;
begin
  Result := True;
  iKeyNameNum := high(sKeyname);
  iInputNum := High(sInputData);
  if (xDataSource.DataSet is TTable) then
    TableName := TTable(xDataSource.DataSet).TableName
  else
  begin
   //M_OkMessage(['����ҵĿǰֻ�����TTable']);
    exit;
  end;

  sQuery := 'SELECT ';
  for iCount := 0 to iKeyNameNum do sQuery := sQuery + sKeyName[iCount] +', ';

  delete(sQuery,length(sQuery)-1,1);
  sQuery := sQuery+' FROM '+ TableName+' WHERE ';
  for iCount := 0 to iInputNum do
    sQuery := sQuery + skeyName[iCount] +'='''+sInputData[iCount]+'''and ';
  delete(sQuery,length(sQuery)-3,3);
  //showmessage(sQuery);
  with TQuery.Create(nil) do
    try
      DatabaseName := TDBDataSet(xDataSource.DataSet).DatabaseName;
      sql.add(sQuery);
      open;
      if IsEmpty then result := True else result := False;
    finally
      free;
    end;
end;

//�����λֵ�Ƿ�ΪΨһֵ
procedure EValue_Unique(Sender: TField; xDataSource: TDataSource; sOriVal: string='');
begin
  if (Sender.IsNull) or (VarToStr(Sender.value)='') then
  begin
    R_OkMessage([Sender.DisplayName], rValue_isnotnull);
    abort;
  end;

  if (sOriVal <> '') then if (sOriVal = Sender.AsString) then exit;

  if not EValueUniqueKey(xDataSource ,[Sender.FieldName],[Sender.AsString]) then
  begin
    R_OkMessage([Sender.AsString],rValue_InvalidKey);
    abort;
  end;

end;


//�����λֵ�Ƿ��춵��0
procedure EValueNumber(Sender:TField);
begin
  if linFieldCheck then exit;
  if sender.IsNull or sender.Value <0 then
  begin
    R_OkMessage([sender.displayname],rValue_OverThanZero);
    linFieldCheck := True;
    Sender.FocusControl;
    linFieldCheck := False;
    abort;
  end;
end;


//����Ƿ���������λֵ
procedure EValue_IsNotNull(Sender: TField; sDefVal: string='');
begin
  if linFieldCheck then exit;
  if (Sender.IsNull) or (varToStr(Sender.value)='') then
    if (sDefVal<>'') then
      Sender.AsString := sDefVal
    else
    begin
      R_OkMessage([Sender.DisplayName],rValue_isnotnull);
      linFieldCheck := True;
      Sender.FocusControl;
      linFieldCheck := False;
      abort;
    end;
end;


function EValue_ForeignKey_IsExist(Master_table:TDBDataSet;Field: string;value: variant): boolean;
begin
  Result := False;
  if Master_table.State in [dsEdit,dsInsert] then
  begin
    R_OkMessage(['���KEYֵ�Ƿ����������,�����������ϱ�춱��޵�״̬']);
    exit;
  end;

  with Master_table do
  begin
    DisableControls;
    try
      if not VarIsNull(Lookup(Field,value,Field)) then
        Result := True;
    finally
      EnableControls;
    end;
  end;
end;

//==============================================================================
//                     ���ϱ�ļ��
//==============================================================================
//����Ѱ����ʱ,�Ҳ�������,����ʾѶϢ���ʹ����,�Ҳ�������,������false
function R_TableIsEmpty(DataSet: TDataSet): Boolean;
begin
  result := False;
  if DataSet.IsEmpty then
  begin
    R_OkMessage([rvalue_notFind]);
    Result := True;
  end;
end;

//==============================================================================
//������
//==============================================================================

//����Ƿ������յ�������,
procedure CheckIntegrity(E: EDatabaseError;sms: string);
begin
  if (E is EDBEngineError) then
    if (E as EDBEngineError).Errors[0].ErrorCode = rForeignKey then
    begin
      R_OkMessage([sms]);
      Abort;
    end;
end;

//����ǲ����ظ�KEYֵ
Procedure CheckKeyValue(E:EDatabaseError; sms: string='��Ų����ظ�');
begin
  if (E is EDBEngineError) then
    if (E as EDBEngineError).Errors[0].ErrorCode = rKeyViol then
    begin
      R_OkMessage([sms]);
      Abort;
    end;
end;

//����Ƿ��з���Required ERR
procedure CheckRequired(E:EDatabaseError; var Action: TDataAction);
begin
   if (E is EDBEngineError) then
    if (E as EDBEngineError).Errors[0].ErrorCode = rRequiredField then
    begin
      R_OkMessage(['asdf']);
      Action := daAbort;
    end;
end;

//���������ϸ������ɾ��
Procedure CheckDetailExist(E:EDatabaseError;sms: string);
begin
  if (E is EDBEngineError) then
    if (E as EDBEngineError).Errors[0].ErrorCode = rDetailExist then
    begin
      R_OkMessage([sms]);
      Abort;
    end;
end;


function ExistSglRelation(var xQry: TQuery; sSQL: string; lInfo: Boolean=True): Boolean;
begin
  Result := True;
  QryExec(xQry, sSQL);
  if (xQry.RecordCount<>0) then
  begin
    if lInfo then R_OkMessage(['�ñʼ�¼�Ѵ��ڹ�������, ������ɾ�����޸�']);
    exit;
  end;
  Result := False;
end;


function ExistRelation(var xQry: TQuery; sVal: string; asRelTbNm, asRelFdNm: Array of string; lNum: Boolean=True; lInfo: Boolean=True): Boolean;
var
  sSQL: string;
  i, iCnt: Integer;
begin
  Result := True;
  iCnt := Length(asRelTbNm);
  if iCnt=0 then begin Result := False; exit; end;

  for i := 0 to iCnt-1 do
  begin
    if lNum then
      sSQL := Format('SELECT %s FROM %s WHERE %s=%s', [asRelFdNm[i], asRelTbNm[i], asRelFdNm[i], sVal])
    else
      sSQL := Format('SELECT %s FROM %s WHERE %s=''%s''', [asRelFdNm[i], asRelTbNm[i], asRelFdNm[i], sVal]);
    QryExec(xQry, sSQL);
    if (xQry.RecordCount<>0) then
    begin
      if lInfo then R_OkMessage(['�ñʼ�¼�Ѵ��ڹ�������, ������ɾ�����������']);
      exit;
    end;
  end;
  Result := False;
end;


//==============================================================================
// ������2
// (��ǰ����ʽ,��:CheckIntegrity ��,��Ϊͨ�������Ͽ�����趨��������Եȸ���Լ��,
//  Ȼ���� Table.PostError �¼���,���ݴ�������������������������Ϣ.
//  ���������ʱ,�������Ͽ��������ֱ�������Ͽ���������������Ե�Լ��,
//  ������д�����³�ʽ��Ϊ��������Կ���. �ÿ�����ģ���е���  )
//==============================================================================

//---------------------------------
// fun : ��һ�����ϴ��ڹ�������,�򲻿�ɾ����������ֵ
// ����: DataSet �� BeforeDelete �� BeforeEdit �¼�
// ����: xQry - ���ڳ�ʽ��ִ�� SQL ���
//       lEdt - True: BeforeEdit; False: BeforeDelete
//       KeyControl - Key ��λ�������� DBEdit �� DBGrid
//                    (���ж��ֵ���,���Դ���Ϊ����. ��Ϊ DBGrid,���ֻ��һ��Ԫ�ؼ���)
//       KeyField - Key ��λ (���ж��ֵ���,���Դ���Ϊ����)
//       refMes - �������ϱ�������
//       refTB - �������ϱ���
//       refFD - ��Ӧ�������ϱ���ⲿ����λ�� (��Ϊ���ֵ,�ö��ŷָ�)
// ע  : ��������밴˳��һһ��Ӧ
// ��1 : Pro_CheckIntegrity(Qry1, false, [DBEdit1], [Table1F01],
//           ['����','������'],['T2010','T2160'],['F03','F03']);
// ��2 : Pro_CheckIntegrity(Qry1, true, [DBGrid1], [Table1F01, Table1F02],
//           ['����','������'],['T2010A','T2160A'],['F03,F04','F03,F04']);
//---------------------------------
function Pro_CheckIntegrity(xQry:TQuery; lEdt:boolean;
         KeyControl: array of TWinControl;
         KeyField: array of TField;
         refMes,refTB,refFD: array of string):boolean;
var
  lExist: boolean;
  s: string;
  i, j: integer;
  aFDNm: array of string;
begin
  Result := False;
  // ��û�д��� refTB ��ֵ, ���ʾ���ÿ���, �˳�����
  if Length(refTB[1]) = 0 then exit;

  // ������ BeforeEdit ʱ����,���жϸ��ĵ��Ƿ��Ǽ�ֵ��λ,������, �˳�
  if lEdt then
  begin
    lExist := true;
    // -��Ϊ��ֵ�����Ŀ���Ϊ DBEdit, ��ѭ���ж�,������û�о۽�,
    //  ���ʾ��ǰ�����޸ļ�ֵ, �˳�
    if KeyControl[0] is TDBEdit then
    begin
      for i := 0 to High(KeyControl) do
        if KeyControl[i].Focused then begin lExist:=false; break; end;
      if lExist then exit;
    end;
    // -��Ϊ��ֵ�����Ŀ���Ϊ DBGrid,����Grid ӵ�н���,
    //  ���䵱ǰѡȡ�� Field ��Ϊ��ֵ��λ, �˳�
    if KeyControl[0] is TDBGrid then
    begin
      if not KeyControl[0].Focused then exit;
      for i := 0 to High(KeyField) do
        if TDBGrid(KeyControl[0]).SelectedField=KeyField[i] then
           begin lExist:=false; break; end;
      if lExist then exit;
    end;
  end;


  // �ж��ڹ��������ϱ����Ƿ��Ѵ�������
  for i := 0 to High(refTB) do
  begin
    SetLength(aFDNm, SubStrCnt(',',refFD[i]) + 1);
    GetStrArray(aFDNm, ',', refFD[i]);

    s := format('Select %s From %s Where %s="%s" ',
         [aFDNm[0],refTB[i],aFDNm[0],KeyField[0].AsString]);
    for j := 1 to High(aFDNm) do
      s := s + format(' AND %s="%s" ',[aFDNm[j],KeyField[j].AsString]);

    QryExec(xQry,s);
    if xQry.RecordCount>0 then
    begin
      R_OKMessage([refMes[i]],'�ñʼ�¼��"%s"���Ѵ��ڹ�������,'#13#13'��������ɾ���������ؼ���λֵ!');
      Result := false;
      abort;
    end;
  end;

end;


end.
