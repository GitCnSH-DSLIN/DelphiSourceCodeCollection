unit US_DB;

{ DB Form :
һ. ��������
  (1). Form Create - �������ϱ�
  (2). Form Close - �ж����ϱ��Ƿ��Ѵ浵
  (3). Form Destroy - �ر����ϱ�
  (4). FormKeyDown - NavPlus �ȼ�����
  (5). ���� RequiredValue, MoreThanZero, CheckFieldVal �¼����
  (6). [��ѯ], [��ӡ] ��ť��ťʱ, �Ƚ����ϱ�浵
  (7). �ȼ����� : (a) Alt+F - ��������
                  (b) Alt+Q - ��ѯ
                  (c) Alt+P - ��ӡ


��. ����ע������ :

  (1). sTbNm : String - ���ϱ���
  (2). ��ͨ�� aOriValues ��������ȡ�����ϱ��ԭֵ
  (3). �� DM ������ Table �ı仯, ��Ҫˢ�µ� DataSet. ���������´��� :

       (a) �� FormCreate ������ iRefreshDSCnt ΪҪˢ�µ� DataSet ����, �� :
           iRefreshDSCnt := 1;

       (b) �� FormShow ������ asRefreshDSNm ����, ΪҪ���µ� DataSet ����, �� :
           asRefreshDSNm[0] := 'Q_JobTitle';
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  US_FM, Db, Buttons, ExtCtrls, DBCtrls, DBNavPlus, ToolWin, ComCtrls,
  RXDBCtrl, StdCtrls, Mask, ToolEdit, DBTables ;

type
  TS_DB = class(TS_Form)
    ToolBar1: TToolBar;
    DBNavPlus1: TDBNavPlus;
    SB3: TSpeedButton;
    SB2: TSpeedButton;
    SB1: TSpeedButton;
    SB0: TSpeedButton;
    SB4: TSpeedButton;
    SB6: TSpeedButton;
    DataSource1: TDataSource;
    Qry1: TQuery;
    Table1: TTable;
    procedure RequiredValue(Sender: TField);
    procedure MoreThanZero(Sender: TField);
    procedure NeedUniqueValue(Sender: TField);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB6Click(Sender: TObject);
    procedure SB3Click(Sender: TObject);
    procedure SB2Click(Sender: TObject);
    procedure Table1BeforePost(DataSet: TDataSet);
    procedure SB1Click(Sender: TObject);
    procedure Table1BeforeEdit(DataSet: TDataSet);
    procedure Table1AfterInsert(DataSet: TDataSet);
    procedure Table1BeforeDelete(DataSet: TDataSet);
    procedure Table1PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure Table1AfterPost(DataSet: TDataSet);
    procedure Table1AfterDelete(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure Table1AfterCancel(DataSet: TDataSet);
  private
    { Private declarations }
  protected
    { Protected declarations }
    xCurNavigator : TDBNavigator;
  Procedure GetaOriVal(var aOriVal: Array of Variant; xDataBase: TDataSet);  public
    { Public declarations }
    sTbNm: String;      // ���ϱ���
    sKeyFdNm: String;   // ��ֵ�ֶ���
    aOriValues : Array of Variant;        // ����ԭֵ - ��춹��ʶ���
    iRefreshDSCnt : Integer;
    asRefreshDSNm : Array of String;      // Length = iRefreshDSCnt
  end;


var
  S_DB: TS_DB;

implementation

uses utilities, uDataBaseEValue, uDM;

{$R *.DFM}


procedure TS_DB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Table1.State in [dsEdit,dsInsert] then
    if R_YesNoMessage(['������δ�浵,�Ƿ�浵?']) then
      try
        Table1.Post;
      except
        R_OkMessage(['�浵ʧ��,����һ��'],'',MB_ICONERROR);
        Action := caNone;
        Raise;
      end;

  inherited;
end;

procedure TS_DB.FormCreate(Sender: TObject);
begin
  inherited;
  Try
    Table1.Open;
  Except
    R_OkMessage(['���ϱ�������!'],'',MB_ICONERROR);
    Raise
  End;

  // ȡ�� Table1.TableName, ���� sTbNm ��
  sTbNm := Table1.TableName;
  if Pos('.',sTbNm)>0 then
    if Pos('dbo.',sTbNm)=1 then Delete(sTbNm,1,4)
      else Delete(sTbNm, Pos('.',sTbNm), 4);

  // ����ԭ��λֵ����ĳ���
  SetLength(aOriValues, Table1.FieldCount);
  xCurNavigator := DBNavPlus1;
  iRefreshDSCnt := 0;
end;

procedure TS_DB.FormShow(Sender: TObject);
begin
  inherited;
  SetLength(asRefreshDSNm, iRefreshDSCnt);
end;

procedure TS_DB.FormDestroy(Sender: TObject);
begin
  inherited;
  Table1.Close;
end;

procedure TS_DB.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key of
    vk_Insert :         // ���� - Ins
      if xCurNavigator.DataSource.DataSet = Table1 then
        xCurNavigator.DataSource.DataSet.Insert;
    vk_Escape :         // ȡ�� - ESC
      xCurNavigator.DataSource.DataSet.Cancel;
    Ord('S') :            // �浵 - Ctrl+S
      if Shift=[ssCtrl] then DataSetPost(xCurNavigator.DataSource.DataSet);
    vk_F5 :
      Table1.Refresh;
    vk_Delete :         // ɾ�� - Ctrl + Del
    begin
      if Shift=[ssCtrl] then
      begin
        if not xCurNavigator.DataSource.DataSet.IsEmpty then
          if R_YesNoMessage(['��ȷ��Ҫɾ���ñ�������?']) then
            xCurNavigator.DataSource.DataSet.Delete;
        Key := 0;
      end;
    end;
    vk_Home :            // �ױ� - Ctrl + Home  ;  ��һ�� - Ctrl + Home
    begin
      if Shift=[ssCtrl] then xCurNavigator.DataSource.DataSet.First
        else if Shift=[ssAlt] then xCurNavigator.DataSource.DataSet.Prior;
    end;
    vk_End :            // δ�� - Alt + Home  ;  ��һ�� - Alt + End
    begin
      if Shift=[ssCtrl] then begin xCurNavigator.DataSource.DataSet.Last;  Key:=0; end
        else if Shift=[ssAlt] then xCurNavigator.DataSource.DataSet.Next;
    end;
  End;
end;


procedure TS_DB.SB6Click(Sender: TObject);
begin
  inherited;
  Close;
end;


procedure TS_DB.SB3Click(Sender: TObject);
begin
  inherited;
  DataSetPost(Table1);
end;

procedure TS_DB.SB2Click(Sender: TObject);
begin
  inherited;
  DataSetPost(Table1);
end;

procedure TS_DB.RequiredValue(Sender: TField);
begin
  EValue_IsNotNull(Sender);
end;


procedure TS_DB.MoreThanZero(Sender: TField);
begin
  EValueNumber(sender);
end;



procedure TS_DB.Table1BeforePost(DataSet: TDataSet);
begin
  inherited;
  CheckFieldVal(DataSet);
end;

procedure TS_DB.SB1Click(Sender: TObject);
var
  sSQl, sNo : String;
begin
  inherited;
  if InputQuery('���ҶԻ���','�������ţ�', sNo) then
  Try
    //     if not Table1.FindKey([sNo]) then
    sSQL := Format('Select %s From %s Where %s="%s"',[sKeyFdNm, sTbNm ,sKeyFdNm, sNo]);
    QryExec(Qry1, sSQL);
    if Qry1.Fields[0].AsString='' then
    begin
      R_OkMessage(['û���ҵ��ñ�����!']);
      exit;
    end;
    sNo := Qry1.Fields[0].AsString;
    if not Table1.Locate(sKeyFdNm , sNo, []) then
       R_OkMessage(['û���ҵ��ñ�����!'])
  except
     R_OkMessage(['���ҳ���!'#13#13'û���ҵ��ñ�����!'])
  end;
end;


//----------------------------------------------------------
// Func : �� ���ϱ� ��ԭֵȡ�����������б�������
// Call : �� ���ϱ�������¼��е���-
//        (1) Before Edit
//        (2) Before Delete
//        (3) After Insert - �� aOriVal[0] ��Ϊ��
//----------------------------------------------------------
procedure TS_DB.GetaOriVal(var aOriVal: Array of Variant; xDataBase: TDataSet);
var
  i: Integer;
begin
  if (xDataBase.State = dsInsert) then
    aOriVal[0] := ''
  else
    for i := 0 to High(aOriVal) do aOriVal[i] := xDataBase.Fields[i].Value;
end;

procedure TS_DB.Table1BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if not DM.DB.InTransaction then DM.DB.StartTransaction;

  GetaOriVal(aOriValues, DataSet);
end;


procedure TS_DB.Table1AfterInsert(DataSet: TDataSet);
begin
  inherited;
  GetaOriVal(aOriValues, DataSet);
end;


procedure TS_DB.Table1BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if not DM.DB.InTransaction then DM.DB.StartTransaction;

  GetaOriVal(aOriValues, DataSet);
end;


procedure TS_DB.Table1PostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
  inherited;
  CheckKeyValue(E);
end;


procedure TS_DB.Table1AfterPost(DataSet: TDataSet);
var
  i : Integer;
  xDataSet : TComponent;
begin
  inherited;
  if DM.DB.InTransaction then
    try
      DM.DB.Commit;
    except
      DM.DB.Rollback;
      R_OkMessage(['���ϸ���ʧ��!'],'',MB_ICONERROR);
      raise;
    end;

  { ˢ�¶�Ӧ�� DataSet }
  for i := 0 to iRefreshDSCnt-1 do
  begin
    xDataSet := DM.FindComponent(asRefreshDSNm[i]);
    if Assigned(xDataSet) then
    begin
      TDataSet(xDataSet).Close;
      TDataSet(xDataSet).Open;
    end;
  end;
end;

procedure TS_DB.Table1AfterDelete(DataSet: TDataSet);
var
  i : Integer;
  xDataSet : TComponent;
begin
  inherited;
  if DM.DB.InTransaction then
    Try
      DM.DB.Commit;
    Except
      DM.DB.Rollback;
      R_OkMessage(['���ϸ���ʧ��!'],'',MB_ICONERROR);
      Raise;
    End;


  { ˢ�¶�Ӧ�� DataSet }
  for i := 0 to iRefreshDSCnt-1 do
  begin
    xDataSet := DM.FindComponent(asRefreshDSNm[i]);
    if Assigned(xDataSet) then
    begin
      TDataSet(xDataSet).Close;
      TDataSet(xDataSet).Open;
    end;
  end;
end;

procedure TS_DB.NeedUniqueValue(Sender: TField);
begin
  EValue_Unique(Sender, DataSource1, aOriValues[Sender.Index]);
end;

procedure TS_DB.Table1AfterCancel(DataSet: TDataSet);
begin
  inherited;
  if DM.DB.InTransaction then DM.DB.Rollback;
end;

end.
