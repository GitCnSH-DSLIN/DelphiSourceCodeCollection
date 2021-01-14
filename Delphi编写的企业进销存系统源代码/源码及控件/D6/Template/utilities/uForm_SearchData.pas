unit uForm_SearchData;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ComCtrls, StdCtrls, Buttons, {Easysize,} TSGrid, Grids_ts,
  TSDBGrid, ExtCtrls, ComObj, Variants;


type
  TForm_SearchData = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    tsDBGrid1: TtsDBGrid;
    tsGrid1: TtsGrid;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Animate1: TAnimate;
    DataSource1: TDataSource;
    Query1: TQuery;
    StatusBar1: TStatusBar;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    procedure tsGrid1ButtonClick(Sender: TObject; DataCol,
      DataRow: Integer);
    procedure StartSearch(Sender: TObject);
    procedure tsGrid1ComboGetValue(Sender: TObject; Combo: TtsComboGrid;
      GridDataCol, GridDataRow, ComboDataRow: Integer; var Value: Variant);
    procedure tsGrid1ComboDropDown(Sender: TObject; Combo: TtsComboGrid;
      DataCol, DataRow: Integer);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure tsDBGrid1DblClick(Sender: TObject);
    procedure Query1AfterOpen(DataSet: TDataSet);
    procedure tsGrid1CellEdit(Sender: TObject; DataCol, DataRow: Integer;
      ByUser: Boolean);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private
    FDataBaseName: string; //Ҫ��Ѱ�����Ͽ�����
    FDataSet: TDBDataSet; //Ҫ��Ѱ�����ϱ��п�����TTable ����TQuery)
    FsearchField: array of Integer; //Ҫ��Ѱ����λֵ
    fkeyField: integer; //����Ѱ����λǰ��λ��KEYֵ
    FSql: string; //Ҫ��Ѱ�ģӣѣ��﷨
    FReturn: TStrings; //Ҫ�ش���keyֵ
    FFieldType: array of char; //��Ѱ��λ����̬
    FFieldCount: integer; //Ҫ��Ѱ����λ��Ŀ
    FFieldName: array of string; //Ҫ��Ѱ����λԭʼ����
    FFieldDisplayName: array of string; //Ҫ��ʾ����λ����
    FSelRang: array of integer;   (* ѡȡ����ӡ��Χ *)
    FSelR: Boolean;               (* ѡȡ��Ϊ��¼��Χ(True), ������λ��Χ(False) *)
    procedure GetSQL;
    procedure SetSearchGrid;
    { Private declarations }
  public
    { Public declarations }
    procedure Exec(DataSet: TDBDataset;ikeyField:integer;SearchField: array of integer);
    property sReturn: TStrings read FReturn write FReturn;
    Property sDataSet: TDBDataSet read FDataSet write FDataSet;
    property sDataBaseName: string read FDataBaseName write FDataBaseName;
    (* ȷ��Ҫ��ӡ�����Ϸ�Χ *)
    procedure GetSelRang;
    (* Excel ��ӡ��ʽ*)
    procedure ExcelPrint(const Dataset: TDataSet; Excel_ID, s_title: String; SelR: Boolean; PField: array of integer);

  end;

procedure Search_Data(const DataSet: TDBDataSet;iKeyField:integer;sField: array of Integer);

var
  Form_SearchData: TForm_SearchData;

implementation

uses uCalendar, uSeaRep;

const
  iBool_Cell = 1;
  isearchField = 2;
  isearchKind = 3;
  iSearchValue = 4;

{ iISPrint_Cell = 1;
  iBool_Cell = 2;
  isearchField = 3;
  isearchKind = 4;
  iSearchValue = 5;  }


{$R *.DFM}

{KeyField���������Ѱ����λ��,Ҳ��������Ѱ����λ����Ҫ��KEY ����λ����,iKeyField��ʾ��Ѱ����λǰ��λ��KEY��λ}
procedure Search_Data(const DataSet: TDBDataSet;iKeyField:integer;sField: array of Integer);
begin
  if DataSet=nil then begin
    MessageBoxEx(application.handle,'������Ҫ��ѯ�����ϱ�����','����',MB_OK,SUBLANG_CHINESE_TRADITIONAL);
    exit;
  end;
  if High(sField)=0 then begin
    MessageBoxEx(application.handle,'������Ҫ��ѯ����λ���','����',MB_OK,SUBLANG_CHINESE_TRADITIONAL);
    exit;
  end;

  if iKeyField=0 then begin
    MessageBoxEx(application.handle,'��������������λ���','����',MB_OK,SUBLANG_CHINESE_TRADITIONAL);
    exit;
  end;

  Form_SearchData := TForm_SearchData.Create(Application);
  try
    Form_SearchData.Exec(DataSet,ikeyField,sField);
  finally
    Form_SearchData.Free;
  end;
end;

{ TForm_SearchData }


procedure TForm_SearchData.GetSelRang;
var
  i, nCol : integer;
  Bk : Variant;
begin
  (* ��û�н���ѡȡ, ��ͬ�ѡȡ��ȫ����λ , Ҫȫ����ӡ *)
  if (tsDBGrid1.SelectedCols.Count = 0) and (tsDBGrid1.SelectedRows.Count = 0) then begin
     FSelR := False;    // ��־ѡȡ��Ϊ��λ��Χ
     SetLength(FSelRang, Query1.FieldCount);
     for i := 0 to Query1.FieldCount - 1 do FSelRang[i] := i;
     Exit;
   end;
  (* ��ѡȡ��λ��ӡ��Χ *)
  if (tsDBGrid1.SelectedCols.Count <> 0) then begin
     FSelR := False; // ��־ѡȡ��Ϊ��λ��Χ
     SetLength(FSelRang, tsDBGrid1.SelectedCols.Count);
     nCol:= tsDBGrid1.SelectedCols.First;
     FSelRang[0] := nCol-1;
     for i := 1 to tsDBGrid1.SelectedCols.Count-1 do begin
       nCol := tsDBGrid1.Selectedcols.Next(nCol);
       FSelRang[i] := nCol-1;
     end;
  end;
  (* ��ѡȡ��¼��ӡ��Χ *)
  if (tsDBGrid1.SelectedRows.Count <> 0) then begin
     FSelR := True;  // ��־ѡȡ��Ϊ��¼��Χ
     SetLength(FSelRang, tsDBGrid1.SelectedRows.Count);
     i := 0;
     Bk := tsDBGrid1.SelectedRows.First;
     While not VarIsEmpty(Bk) do begin
       Query1.Bookmark := Bk;
       FSelRang[i] := Query1.RecNo-1;
       Inc(i);
       Bk := tsDBGrid1.SelectedRows.Next(Bk);
     end;
  end;
end;



procedure TForm_SearchData.ExcelPrint(const Dataset: TDataSet; Excel_ID, s_title: String; SelR: Boolean; PField: array of integer);
var
  i, j : integer;
  ExcelFile : Variant;
begin
  if not dataset.active then begin
     beep;
     Application.MessageBox(PChar('�Բ���!û�����Ͽ�����ӡ!'),PChar('����'),MB_ICONWARNING+MB_OK);
     exit;
  end;
  if Dataset.recordcount = 0 then begin
     beep;
     Application.MessageBox(PChar('�Բ���!û�����Ͽ�����ӡ!'),PChar('����'),MB_ICONWARNING+MB_OK);
     exit;
  end;
  Screen.Cursor := crHourglass;
  Try
    ExcelFile := CreateOleObject(Excel_ID);
    ExcelFile.Visible := true;
    ExcelFile.WorkBooks.Add;
  Except
    Application.MessageBox(PChar('���� Excel ʱ��������!'#13'�޷�������Ͷ��Excel!'),PChar('����'),MB_ICONWARNING+MB_OK);
    exit;
  End;

  ExcelFile.Cells[1,1].value := s_title;

  With Dataset do begin
    First;
    if SelR then begin     (* ��ѡȡ����ӡ�ļ�¼��Χ *)
       // ��ӡȫ����λ����:
       for i := 0 to FieldCount-1 do ExcelFile.Cells[3,i+1].value := Fields[i].DisplayLabel;
       // ��ӡ����ѡ��¼:
       DataSet.MoveBy(PField[0]);
       for j := 0 to Dataset.FieldCount-1 do ExcelFile.Cells[4,j+1].value := Fields[j].asstring;
       for i := 1 to High(PField) do begin
         DataSet.MoveBy(PField[i] - PField[i-1]);
         for j := 0 to Dataset.FieldCount-1 do ExcelFile.Cells[i+4,j+1].value := Fields[j].asstring;
       end;
    end
    else begin             (* ��ѡȡ����ӡ����λ��Χ *)
       // ��ӡѡȡ����λ����:
       for i := 0 to High(PField) do ExcelFile.Cells[3,i+1].value := Fields[PField[i]].DisplayLabel;
       // ��ӡ����ѡ��λ�����м�¼:
       for i := 0 to RecordCount - 1 do begin
         for j := 0 to High(PField) do ExcelFile.Cells[i+4,j+1].value := Fields[PField[j]].asstring;
         Next;
       end;
    end;  // end of else
  end;    // end of with
  Screen.Cursor := crDefault;
end;




procedure TForm_SearchData.Exec(DataSet: TDBDataset;ikeyField:integer;SearchField: array of integer);
var
  iCount: integer;
begin
  //��ʼִ����Ѱ
  sDataSet := DataSet;
  SetLength(FSearchField,high(searchfield)+1);

  FFieldCount := high(searchField)+1;
  for iCount := 0 to FFieldCount-1 do
    FsearchField[iCount] := SearchField[iCount];

  fkeyField := ikeyField;

  Query1.DatabaseName := DataSet.DatabaseName;
  GetSQL; //ȡ�ãӣѣ��﷨
  SetSearchGrid; //�趨ҪѰ�ҵ�GRID����
  showmodal;
end;


procedure TForm_SearchData.GetSQL;
var
  iCount: integer;
  iPos: integer;
  i2Pos: integer;
  sFrom: string;
  sSelect: string;
  sOldSQL: string;
begin
  SetLength(ffieldname,FFieldCount);
  SetLength(FFieldDisplayname,FFieldCount);
  SetLength(FFieldType,FFieldCount);

  sSelect := 'SELECT ';
  if sDataSet is TTable then begin
    sFrom := ' FROM '+TTable(sDataSet).TableName;
    //���� select ���﷨
    for iCount := 0 to FFieldCount-1 do begin
      sSelect := sSelect+TTable(sDataSet).Fields[fsearchfield[iCount]].FieldName+' as '+TTable(sDataSet).Fields[fsearchfield[iCount]].DisplayName+', ';
      FFieldName[iCount] := TTable(sDataSet).Fields[fsearchfield[iCount]].FieldName;
      FFieldDisplayName[iCount] := TTable(sDataSet).Fields[fsearchfield[iCount]].DisplayName;
      case TTable(sDataSet).Fields[fsearchfield[iCount]].DataType  of
        ftdatetime :          FFieldType[iCount] := 'D';
        ftString:         FFieldType[ICount] := 'S';
        ftInteger,ftFloat:FFieldType[ICount] := 'I';
        else
          FFieldType[iCount] := 'N';
      end;//end of case
    end;
  end else
  begin
    sOldSQL := UpperCase(Trim(TQuery(sDataSet).SQL.Text));

    iPos := pos('FROM',sOldSQL);

    if iPos<0 then begin
      MessageBoxEx(application.handle,'������TQueryԪ�� SQL �﷨����','����',MB_OK,SUBLANG_CHINESE_TRADITIONAL);
      exit;
    end;

    i2Pos := pos('ORDER',sOldSQL);

    while sOldSQL[iPOS] <>' ' do
      inc(iPos);
    inc(iPos);

    if i2Pos=0 then
      sFrom := 'FROM '+copy(sOldSQL,iPos,length(sOldSQL)-iPos+1)
    else
      sFrom := 'FROM '+copy(sOldSQL,iPos,i2Pos-iPos);

    //����query��Select�﷨
    for iCount := 0 to FFieldCount-1 do begin
      sSelect := sSelect + TQuery(sDataSet).Fields[fsearchfield[iCount]].Origin +' as '+TQuery(sDataSet).Fields[fsearchfield[iCount]].DisplayName+', ';
      FFieldName[iCount] := TQuery(sDataSet).Fields[fsearchfield[iCount]].Origin;
      FFieldDisplayName[iCount] := TQuery(sDataSet).Fields[fsearchfield[iCount]].DisplayName;
      case TQuery(sDataSet).Fields[fsearchfield[iCount]].DataType  of
        ftdatetime :          FFieldType[iCount] := 'D';
        ftString:         FFieldType[ICount] := 'S';
        ftInteger,ftFloat:FFieldType[ICount] := 'I';
        else
          FFieldType[iCount] := 'N';
      end;//end of case
    end;
  end;//end of if ... else

  trim(sSelect);
  Delete(sSelect,length(sSelect)-1,1);

  FSql := sSelect + sFrom;

  {AssignFile(output, 'f:\aaa.sql');
  rewrite(output);
  writeln(output,fsql);
  closefile(output);}
end;

procedure TForm_SearchData.SetSearchGrid;
var
  iCount: integer;
begin
  //�趨tsGrid�Ļ���
  with tsGrid1 do begin
    tsGrid1.Rows := FFieldCount;

    for iCount := 0 to FFieldCount-1 do begin
     // tsGrid1.Cell[iISPrint_Cell,iCount+1] := False;
      tsGrid1.Cell[iBool_Cell,iCount+1] := '����';
      tsGrid1.Cell[isearchKind,iCount+1] := '=';
      tsGrid1.Cell[isearchField,iCount+1] := FFieldDisplayName[iCount]; //ָ����Ѱ��λ������
    end;
    tsGrid1.cell[1,1] := '';//��һ����Ѱ����ֵ����Ҫ����Ѱ����
   // tsGrid1.cell[2,1] := '';//��һ����Ѱ����ֵ����Ҫ����Ѱ����
    tsGrid1.Col[isearchField].ReadOnly := true;
    tsGrid1.CurrentCell.MoveTo(isearchValue,1);//���α������ڵ�һ��Ҫ������Ѱ����ֵ�ĵط�
  end;//end of with
end;

procedure TForm_SearchData.tsGrid1ButtonClick(Sender: TObject; DataCol,
  DataRow: Integer);
begin
  //��������λֵ�������ͱ�ʱ,��ʹ���߿�����ѡ��ķ�ʽ
  if DataCol <> isearchvalue then
    exit;

  if FFieldType[DataRow-1]='D' then
   with TCalendarDlg.Create(nil) do
      try
        if ShowModal=mrok then
          tsGrid1.Cell[DataCol,DataRow] := FormatDateTime('yyyy/mm/dd',Calendar1.CalendarDate);//copy(inttostr(Calendar1.Month+101),2,2)+'/' +copy(inttostr(Calendar1.Day+101),2,2)+'/'+inttostr(Calendar1.Year);
      finally
        free;
      end;
end;

procedure TForm_SearchData.StartSearch(Sender: TObject);
var
  sWhere: string;

  function GetEValue(s: string):string;//ȡ���ж�ʽ
  begin
    if s='����' then
      result := 'AND'
    else if s= '��' then
      Result := 'OR'
    else
      Result := '';
    if sWhere = '' then
      Result := '';
  end;

  function GetSearchKind(i: integer): string;//ȡ��Ҫ��Ѱ������ֵ
  var
    sKind: string;
    sSearchValue: string;
  begin
    sKind := tsGrid1.Cell[isearchKind,i+1];
    sSearchValue := tsGrid1.Cell[iSearchValue,i+1];
    case FFieldType[i] of
       'S':
          if sKind = 'LIKE%' then
            Result := ' '+copy(sKind,1,4) + ' "'+sSearchValue+'%") '
          else if sKind = '%LIKE' then
            Result := ' '+copy(sKind,2,4) + ' "%'+sSearchValue+'") '
          else if sKind = '%LIKE%' then
            Result := ' '+copy(sKind,2,4) + ' "%'+sSearchValue+'%") '
          else
            Result := ' '+sKind + ' "'+sSearchValue+'") ';
      'I': Result :=  ' '+sKind + sSearchValue+') ';
      'D','N':
          Result := ' '+sKind + ' "'+sSearchValue+'") ';
    end;
  end;

  procedure GetSWhere;//ȡ��Ҫ��Ѱ������ֵ
  var
    i: integer;
  begin
    for i := 0 to FFieldCount-1 do
      if vartostr(tsGrid1.Cell[iSearchValue,i+1])<>'' then
        sWhere := sWhere+GetEvalue(tsGrid1.Cell[iBool_Cell,i+1])+' ( '+ FFieldname[i] +GetSearchKind(i);
  end;

begin
  //��ʼ��Ѱ����
  Query1.Close;
  Query1.SQL.Clear;
  Animate1.Active := True;
  try
    GetSWhere;//ȡ��Ҫ��Ѱ������ֵ
    if sWhere = '' then begin
      MessageBoxEx(application.handle,'�������ѯ����','����',MB_OK,SUBLANG_CHINESE_TRADITIONAL);
      exit;
    end;
    if pos('WHERE',UpperCase(FSql)) <> 0 then
      Query1.SQL.Add(FSql + ' AND ( '+sWhere+' )')
    else
      Query1.SQL.Add(FSql + ' WHERE '+sWhere);
    {for Test}
    {AssignFile(output, 'f:\aaa.sql');
    rewrite(output);
    writeln(output,Query1.SQL.Text);
    closefile(output); }
    {end of Test}
    Query1.open;
    if Query1.IsEmpty then begin
      MessageBoxEx(application.handle,'�Ҳ�����Ҫ������,�����������ѯ����','����',MB_OK,SUBLANG_CHINESE_TRADITIONAL);
      tsGrid1.SetFocus;
      tsGrid1.CurrentCell.MoveTo(iSearchvalue,1);
      StatusBar1.SimpleText := '���ҵ� 0 ������';
    end else
      StatusBar1.SimpleText := '���ҵ� '+inttostr(query1.recordcount)+' ������';

  finally
    Animate1.Stop;
  end;
end;

procedure TForm_SearchData.tsGrid1ComboGetValue(Sender: TObject;
  Combo: TtsComboGrid; GridDataCol, GridDataRow, ComboDataRow: Integer;
  var Value: Variant);
begin
  //��ʹ����ѡ���˵�һ����Ѱ����ֵ����Ѱ����ʱ,������ʹ���߸ı�
  if (GridDataCol= ibool_Cell) and (GridDataRow=1) then begin
    MessageBoxEx(application.handle,'�������趨�������ֵ','����',MB_OK,SUBLANG_CHINESE_TRADITIONAL);
    value := '';
  end;
end;

procedure TForm_SearchData.tsGrid1ComboDropDown(Sender: TObject;
  Combo: TtsComboGrid; DataCol, DataRow: Integer);
begin
  //ָ����Ѱ������
  if tsgrid1.CurrentDataCol <> iSearchKind then
    exit;
  case FFieldType[tsgrid1.CurrentDataRow-1] of
    'S':begin
         Combo.DropDownRows := 4;
          Combo.Rows := 4;
          Combo.Cell[1,1] := '=';
          Combo.Cell[1,2] := 'LIKE%';
          Combo.Cell[1,3] := '%LIKE';
          Combo.Cell[1,4] := '%LIKE%';
        end;
    else
      begin
        Combo.DropDownRows := 6;
        combo.Rows := 6;
        Combo.Cell[1,1] := '=';
        Combo.Cell[1,2] := '>';
        Combo.Cell[1,3] := '>=';
        Combo.Cell[1,4] := '<';
        Combo.Cell[1,5] := '<=';
        Combo.Cell[1,6] := '<>';
      end;//
  end;//end of case

end;

procedure TForm_SearchData.BitBtn3Click(Sender: TObject);
begin
  Close;
end;

procedure TForm_SearchData.BitBtn2Click(Sender: TObject);
var
  sParimayKey: string;
  icount: Integer;
  vFieldArray: variant;
begin
  {ִ��ȡ�صĶ���}
  if query1.IsEmpty then begin
    if sender = nil then
      exit;
    MessageBoxEx(application.handle,'�����Ͽɹ�ȡ��','����',MB_OK,SUBLANG_CHINESE_TRADITIONAL);
    exit;
  end;

  sParimayKey := '';
  if fkeyField > 1 then
    VFieldArray := VarArrayCreate([0,FKeyField-1],varolestr);


  for iCount := 0 to FKeyField-1 do begin //ȡ��Ҫ��Ѱ�ļ�ֵ
    if sDataSet is TTable then
      sParimayKey := sParimaykey + FFieldName[iCount]+';'
    else
      sParimayKey := sParimaykey + sDataSet.Fields[FSearchField[iCount]].FieldName+';';
    if fkeyField>1 then
      vFieldArray[iCount] := Query1.Fields[icount].Value
    else
      vFieldArray := Query1.Fields[icount].Value;
  end;

  Delete(sParimayKey,length(sParimayKey),1);

  sDataSet.Locate(sParimayKey,vFieldArray,[]);
  close;
end;

procedure TForm_SearchData.tsDBGrid1DblClick(Sender: TObject);
begin
  BitBtn2Click(nil);
end;

procedure TForm_SearchData.Query1AfterOpen(DataSet: TDataSet);
begin
  BitBtn2.Enabled := not query1.IsEmpty;
  (* add code*)
  BitBtn4.Enabled := not query1.IsEmpty;
  BitBtn5.Enabled := not query1.IsEmpty;
  (**)
end;

procedure TForm_SearchData.tsGrid1CellEdit(Sender: TObject; DataCol,
  DataRow: Integer; ByUser: Boolean);
begin
  BitBtn2.Enabled := False;
  (**)
  BitBtn4.Enabled := False;
  BitBtn5.Enabled := False;
  (**)
  if Query1.Active then
    Query1.Close;
end;

procedure TForm_SearchData.BitBtn4Click(Sender: TObject);
begin
  GetSelRang;
  SearchRepExc(Query1,FSelR,FSelRang);
end;

procedure TForm_SearchData.BitBtn5Click(Sender: TObject);
begin
  GetSelRang;
  ExcelPrint(Query1,'Excel.Application','���ϱ�',FSelR,FSelRang);
end;

end.
