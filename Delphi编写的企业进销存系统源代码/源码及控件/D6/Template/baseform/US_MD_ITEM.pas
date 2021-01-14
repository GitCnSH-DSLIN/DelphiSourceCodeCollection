unit US_MD_ITEM;

{ Master Detail Form :

һ. �������� :
  (1). ��ϸ�����Զ����


��. �������� :
  (1). ��ϸ���Զ������λ�� sAutoItemFdNm

}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  US_MD, Db, DBTables, Grids_ts, TSGrid, TSDBGrid, DBCtrls,
  DBNavPlus, Buttons, StdCtrls, Mask, ExtCtrls, ToolWin, ComCtrls, Grids,
  DBGrids, DBVrtNav;

type
  TS_MasterDetail_With_Item = class(TS_MasterDetail)
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Table2AfterCancel(DataSet: TDataSet);
    procedure Table2BeforeCancel(DataSet: TDataSet);
    procedure Table2BeforeInsert(DataSet: TDataSet);
    procedure Table2BeforeDelete(DataSet: TDataSet);
    procedure Table2AfterPost(DataSet: TDataSet);
    procedure Table2AfterInsert(DataSet: TDataSet);
    procedure Table2AfterDelete(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1EditButtonClick(Sender: TObject); override;
  private
    { Private declarations }
    lUpdItem, lCnlItem : Boolean;  // �Ƿ�����춸��� <��> �������������
    lIns     : Boolean;  // ��춸��� <��> : True- ��������(Insert) ; False- ׷������(Append)
    iDelItem : Integer;  // ��¼ɾ��ǰ�� <��> ֵ
    iInsItem : Integer;  // ��¼Ӧ������ <��> ֵ

    procedure DecItem(xDataSet: TDataSet);
    procedure IncItem(xDataSet: TDataSet);
  public
    sAutoItemFdNm : String;
    { Public declarations }
  end;

var
  S_MasterDetail_With_Item: TS_MasterDetail_With_Item;

implementation

uses utilities;

{$R *.DFM}


procedure TS_MasterDetail_With_Item.DecItem(xDataSet: TDataSet);
begin
  // ��ɾ���� <��> С� ��ǰ��λ�� <��>, ���ʾɾ���Ĳ������һ�ʼǵ�, ɾ�� <��> �Ժ����� -1
  if iDelItem < xDataSet.FieldByName(sAutoItemFdNm).AsInteger then
  begin
    QryExec(Qry1, Format('Update %s Set %s=%s-1 Where %s=''%s'' And %s>= %d',
        [sDTbNm, sAutoItemFdNm, sAutoItemFdNm, sDKeyFdNm, Table1.FieldByName(sKeyFdNm).AsString, sAutoItemFdNm, Table2.FieldByName(sAutoItemFdNm).AsInteger]), False);
    lCnlItem := True;
    xDataSet.Refresh;
    lCnlItem := False;
    xDataSet.Locate(sAutoItemFdNm, iDelItem ,[]);
  end;
end;

procedure TS_MasterDetail_With_Item.IncItem(xDataSet: TDataSet);
begin
  if lUpdItem then //  (Label : 1)
  begin
    xDataSet.FieldByName(sAutoItemFdNm).AsInteger := iInsItem;
    lUpdItem := False;
  end
  else
    // ��Ϊ Append һ����¼, ��ֱ�ӽ� iInsItem ��ֵ���� <��>
    if not lIns then
       xDataSet.FieldByName(sAutoItemFdNm).AsInteger := iInsItem
    else
    begin
      lUpdItem := True;
      // ��Ҫ������¼���µ� <��> �� +1, ��Ϊ���м��ڳ�һ�� <��>�� ������ļǵ�ʹ��
      QryExec(Qry1, Format('Update %s Set %s=%s+1 Where %s=''%s'' And %s>= %d',
                [sDTbNm, sAutoItemFdNm, sAutoItemFdNm, sDKeyFdNm, Table1.FieldByName(sKeyFdNm).AsString, sAutoItemFdNm, iInsItem]), False);

      // Refresh �� cancel �� xDataSet ����������, �þ������ Table2AfterCancel ��ִ��
      xDataSet.Refresh;  // (Lable : 2)

      // �þ������ (Lable : 1) ��ִ��
      xDataSet.Insert;
    end;
end;



procedure TS_MasterDetail_With_Item.FormCreate(Sender: TObject);
begin
  inherited;
  sAutoItemFdNm := 'D_Sn';
  lIns := True;     // Ĭ��Ϊ [����]
  lUpdItem := False;
  lCnlItem := False;
end;



procedure TS_MasterDetail_With_Item.DBGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

end;



{ ���� [��] ֵ }
procedure TS_MasterDetail_With_Item.Table2AfterInsert(DataSet: TDataSet);
begin
  inherited;
  IncItem(DataSet);
end;


procedure TS_MasterDetail_With_Item.Table2AfterDelete(DataSet: TDataSet);
begin
  inherited;
  if not lDelMasterDetail then DecItem(DataSet);
end;


procedure TS_MasterDetail_With_Item.Table2AfterCancel(DataSet: TDataSet);
begin
  { lIns ��ʾ : ��Ϊ Cancel �� Ins ����, �������� [��]  }
  { lUpdItem ��ʾ : �� (Lable : 2) ���� xDataSet.Refresh ����� Cancel ����, ������ [��] }
  if (lIns and (not lUpdItem)) or lCnlItem then DecItem(DataSet);
  if not lUpdItem then inherited;

  lIns := True;
end;



procedure TS_MasterDetail_With_Item.Table2BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if (Table2.RecordCount = 0) then
  begin
    iInsItem := 1;
    lIns := False;
  end
  else
    if lIns and (not lUpdItem) then iInsItem := Table2.FieldByName(sAutoItemFdNm).AsInteger;
end;

procedure TS_MasterDetail_With_Item.Table2AfterPost(DataSet: TDataSet);
begin
  inherited;
  lIns := True;
end;

procedure TS_MasterDetail_With_Item.Table2BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if not lDelMasterDetail then iDelItem := Table2.FieldByName(sAutoItemFdNm).AsInteger;
end;

procedure TS_MasterDetail_With_Item.Table2BeforeCancel(DataSet: TDataSet);
begin
  inherited;
  iDelItem := Table2.FieldByName(sAutoItemFdNm).AsInteger;
end;

procedure TS_MasterDetail_With_Item.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if not Table2.Active then exit;

  if (Table2.RecordCount > 0) and (Self.ActiveControl = DBGrid1) then
  begin
    if Key = vk_Down then
    begin
      DataSetPost(Table2);
      if Table2.FieldByName(sAutoItemFdNm).AsInteger = Table2.RecordCount then lIns := False;
    end;

    if not lIns then iInsItem := Table2.RecordCount+1;
  end;

  inherited;
end;

procedure TS_MasterDetail_With_Item.DBGrid1EditButtonClick(
  Sender: TObject);
begin
  inherited;
  // Called in DBGrid1KeyDown Where Press Key F4
end;

end.
