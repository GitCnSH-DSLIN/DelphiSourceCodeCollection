unit US_MD;

{ Master Detail Form :

һ. �������� :
  (1). Form Create - ������ϸ���ϱ� ;
                     �����������������һ��
  (2). Form Close - �ж���ϸ���ϱ��Ƿ��Ѵ浵
  (3). Form Destroy - �ر���ϸ���ϱ�
  (4). DBGrid1Enter - ��������û������, ��������ϸ��
                        ����������, �� DBNavPlus1 ���� DataSource2
  (5). DBGrid1Exit - �� DBNavPlus1 ���� DataSource1
  (6). [��ѯ], [��ӡ] ��ť��ťʱ, �Ƚ���ϸ���ϱ�浵
  (7). OnKeyDow - ������ [F12] ���л���������ϸ�� ;
                  tsDBGrid �� EditButton ���ȼ�Ϊ F4
  (8). Query2 New Record - ��������ֵ��λ��ֵ������ϸ��Ӧ��ֵ��λ
  (9). ����, ��ϸ���� ���ʶ���.
 (10). ����ɾ��ǰ, ɾ����Ӧ��ϸ������

��. ����ע������ :

  (1). (a). sKeyFdNm : String - ������ֵ�ֶ���
       (b). sDKeyFdNm: String - ��ϸ�����������ļ�ֵ�ֶ���
       (c). sKSNFdNm : String - ��ϸ��ֵ���ֶ���, Ĭ��Ϊ'K_SN'

  (2). ���ʶ����ĵ��� :
          �� Form �� Public ���м����������� :
          procedure DetailEdit(DataSet: TDataSet); override;  - ɾ��һ����ϸʱ�Ĺ��ʶ���
          procedure DetailUpdate(DataSet: TDataSet); override;  - ����һ����ϸʱ�Ĺ��ʶ���

          ���޹��ʶ���, �������.

  (3). �����������¼���д��ʽ��,
       a. �жϳ�ʽ, ��д�� inherited; ֮ǰ; 
       b. �����ʽ, ��д�� inherited; ֮�� :
          BeforeEdit ; BeforeDelete ; BeforeCancel

       �����������¼���д��ʽ, �轫��ʽд�� inherited; ֮ǰ :
           AfterPost ; AfterDelete ; AfterCancel

}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  US_EDIT, Db, DBTables, StdCtrls, Mask, DBCtrls, ExtCtrls,
  Buttons, DBNavPlus, ComCtrls, ToolWin, Grids_ts, TSGrid, TSDBGrid,
  RXDBCtrl, ToolEdit, Grids, DBGrids, DBVrtNav;


type
  TS_MasterDetail = class(TS_SingleDBEdit)
    DataSource2: TDataSource;
    Table2: TTable;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    DBVertNavigator1: TDBVertNavigator;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure SB1Click(Sender: TObject);
    procedure SB2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Table2BeforeEdit(DataSet: TDataSet);
    procedure Table2AfterInsert(DataSet: TDataSet);
    procedure Table2BeforeDelete(DataSet: TDataSet);
    procedure Table2AfterPost(DataSet: TDataSet);
    procedure Table1BeforeDelete(DataSet: TDataSet);
    procedure DataSource1StateChange(Sender: TObject);
    procedure Table2BeforePost(DataSet: TDataSet);
    procedure DBGrid1Enter(Sender: TObject);
    procedure DBGrid1Exit(Sender: TObject);
    procedure Table2AfterCancel(DataSet: TDataSet);
    procedure Table2AfterDelete(DataSet: TDataSet);
    procedure Table2BeforeInsert(DataSet: TDataSet);
    procedure DBGrid1EditButtonClick(Sender: TObject); virtual;
    procedure Table1AfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    sKSNFdNm : String;  // ��ϸ��ֵ���ֶ���
    sDTbNm: String;     // ��ϸ���ϱ���
    sDKeyFdNm: String;  // ��ϸ�����������ļ�ֵ�ֶ���
    lDelMasterDetail: boolean;  // ��ʾ������ɾ���������ϸ��ɾ��
    lDelMasterScroll: boolean;  // ��ʾ������ɾ����������� befor scroll �¼�,
                                // ��� befor scroll �¼������ж�, ������� Err : Other user changed the record
    procedure DetailEdit(DataSet: TDataSet);virtual;
    procedure DetailUpdate(DataSet: TDataSet);virtual;
  end;

var
  S_MasterDetail: TS_MasterDetail;

implementation

uses utilities,uDataBaseEValue, uDM;

{$R *.DFM}

procedure TS_MasterDetail.DetailUpdate(DataSet: TDataSet);
begin
  // �ڴ˴���д��ϸ���������ϵĶ�Ӧ���ʶ���
end;

procedure TS_MasterDetail.DetailEdit(DataSet: TDataSet);
begin
  // �ڴ˴���д��ϸ��ɾ�����ϵĶ�Ӧ���ʶ���
end;


procedure TS_MasterDetail.FormCreate(Sender: TObject);
begin
  Try
    Table2.Open;
  Except
    R_OkMessage(['��ϸ������ʧ��']);
  End;

  inherited;

  sKSNFdNm := 'K_SN';

  // ȡ�� Table2.TableName, ���� sDTbNm ��
  sDTbNm := Table2.TableName;
  if Pos('.',sDTbNm)>0 then
    if Pos('dbo.',sDTbNm)=1 then Delete(sDTbNm,1,4)
      else Delete(sDTbNm, Pos('.',sDTbNm), 4);

  sDKeyFdNm := Table2.IndexFieldNames;
  if Pos(';',sDKeyFdNm) > 0 then
    sDKeyFdNm := Copy(sDKeyFdNm, 1, Pos(';',sDKeyFdNm)-1);
    
  lDelMasterDetail := False;
  lDelMasterScroll := False;
  Table1.Last;
end;


procedure TS_MasterDetail.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Table2.State in [dsEdit,dsInsert] then
    if R_YesNoMessage(['������δ�浵,�Ƿ�浵?']) then
      try
        Table2.Post;
      except
        R_OkMessage(['�浵ʧ��,����һ��?']);
        Action := caNone;
        raise;
      end;

  inherited;
end;


procedure TS_MasterDetail.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = vk_F12) then
  begin
    if (ActiveControl = DBGrid1) then
      DBEdit1.SetFocus
    else
      DBGrid1.SetFocus;
    Key := 0;
    Exit;
  end;
  inherited;
end;


procedure TS_MasterDetail.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key of
    vk_F4: DBGrid1EditButtonClick(Sender);
  //  vk_Return: Key := vk_Tab;
  end;
end;



procedure TS_MasterDetail.FormDestroy(Sender: TObject);
begin
  Table2.Close;
  inherited;
end;


procedure TS_MasterDetail.SB1Click(Sender: TObject);
begin
  DataSetPost(Table2);
  inherited;
end;

procedure TS_MasterDetail.SB2Click(Sender: TObject);
begin
  DataSetPost(Table2);
  inherited;
end;


procedure TS_MasterDetail.Table2AfterInsert(DataSet: TDataSet);
begin
  inherited;
end;



{ ��ϸ������ }
procedure TS_MasterDetail.Table2BeforeInsert(DataSet: TDataSet);
begin
  if not DM.DB.InTransaction then DM.DB.StartTransaction;
  inherited;
end;


procedure TS_MasterDetail.Table2BeforeEdit(DataSet: TDataSet);
begin
  if not DM.DB.InTransaction then DM.DB.StartTransaction;
  try
    DetailEdit(DataSet);
  except
    R_OkMessage(['ɾ����ϸ���ϳ���!'],'',MB_ICONERROR);
    raise;
  end;

  inherited;
end;


procedure TS_MasterDetail.Table2BeforeDelete(DataSet: TDataSet);
begin
  if not DM.DB.InTransaction then DM.DB.StartTransaction;

  if Dataset.State in [dsEdit,dsInsert] then exit;

  try
    DetailEdit(DataSet);
  except
    R_OkMessage(['ɾ����ϸ���ϳ���!'],'',MB_ICONERROR);
    raise;
  end;

  inherited;
end;

procedure TS_MasterDetail.Table2AfterPost(DataSet: TDataSet);
begin
  inherited;
  try
    DetailUpdate(DataSet);
    DM.DB.Commit;
  except
    DM.DB.Rollback;
    R_OkMessage(['���ϸ���ʧ��!'],'',MB_ICONERROR);
    raise;
  end;

end;


procedure TS_MasterDetail.Table2AfterCancel(DataSet: TDataSet);
begin
  inherited;
  DM.DB.Rollback;
end;


procedure TS_MasterDetail.Table2AfterDelete(DataSet: TDataSet);
begin
  inherited;
  if not lDelMasterDetail then
    Try
      DM.DB.Commit;
    Except
      DM.DB.Rollback;
      R_OkMessage(['���ϸ���ʧ��!'],'',MB_ICONERROR);
      Raise;
    End;
end;





procedure TS_MasterDetail.Table1BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  // ɾ������֮ǰ, ��ɾ����Ӧ����ϸ������;
  // ������ lDelMasterDetail ��־
  Table2.DisableControls;
  lDelMasterDetail := true;
  lDelMasterScroll := true;
  try
    try
      Table2.First;
      while not Table2.eof do
        Table2.Delete;
    except
      R_OkMessage(['��������,�޷�ɾ����ϸ��'],'',MB_ICONERROR);
      DM.DB.Rollback;
      Table2.Close;
      Table2.Open;
      abort;
    end;
  finally
    lDelMasterDetail := False;
    Table2.EnableControls;
  end;

end;


procedure TS_MasterDetail.Table2BeforePost(DataSet: TDataSet);
begin
  inherited;
  //-- ����ǰ����һ����λ����¼�
  CheckFieldVal(DataSet);

  //-- <K_SN>�Զ����
  if (Table2.State = dsInsert) and (sKSNFdNm<>'') then
  Try
    Table2.FieldByName(sKSNFdNm); // ����ϸ���� <K_SN> ��λ,��˾�ᴥ���쳣, ������<K_SN>���Զ����
    QryExec(Qry1,'Select max('+sKSNFdNm+') from '+sDTbNm+' Where '+sDKeyFdNm+'= "'+Table1.FieldByName(sKeyFdNm).AsString+'" ' );
    Table2.FieldByName(sKSNFdNm).AsInteger := Qry1.Fields[0].AsInteger + 1;
  except
    //
  end;
end;


procedure TS_MasterDetail.DataSource1StateChange(Sender: TObject);
begin
  inherited;
  // ���� Table ״̬���� Panel3 ����ɫ (ͬ Panel1)
  Case Table1.State of
    dsBrowse : Panel3.Color := $0099F2C6;
    dsEdit   : Panel3.Color := $00FBDAD7;
    dsInsert : Panel3.Color := $00F1C9FA;
  End;
end;


// �� Navplas ��������ɫ����ʶ��ǰ������������������ϸ����
procedure TS_MasterDetail.DBGrid1Enter(Sender: TObject);
begin
  inherited;
  DataSetPost(Table1);

  if (Table1.RecordCount = 0) then
     DBEdit1.SetFocus
  else
  begin 
    xCurNavigator := TDBNavigator(DBVertNavigator1);
    Panel2.Enabled := True;
  end;
end;

procedure TS_MasterDetail.DBGrid1Exit(Sender: TObject);
begin
  inherited;
  DataSetPost(Table2);
  xCurNavigator := DBNavPlus1;
  Panel2.Enabled := False;
end;


procedure TS_MasterDetail.DBGrid1EditButtonClick(Sender: TObject);
begin
  inherited;
  // Called in DBGrid1KeyDown Where Press Key F4
end;

procedure TS_MasterDetail.Table1AfterScroll(DataSet: TDataSet);
begin
  inherited;
  lDelMasterScroll := false;
end;

end.
