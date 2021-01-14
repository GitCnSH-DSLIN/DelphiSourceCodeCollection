unit uMasterDetailSearchNoLook;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ComCtrls, StdCtrls, Buttons,  TSGrid, Grids_ts,
  TSDBGrid, ExtCtrls, ComObj, Easysize, Variants;


type
  TMasterDetailSearchNoLook = class(TForm)
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
    Splitter1: TSplitter;
    FormResizer1: TFormResizer;
    Edit1: TEdit;
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
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FDataBaseName: string; //Ҫ��Ѱ�����Ͽ�����
    FDataSet: TDBDataSet; //Ҫ��Ѱ�����ϱ�
    FDetailDataSet: TDBDataSet;//Ҫ��Ѱ����ϸ�����ϱ�

    FsearchField: array of Integer; //master ���ϱ�Ҫ��Ѱ����λֵ
    FDetailSearchField: array of integer;//detail ���ϱ�Ҫ��Ѱ����λֵ

    FMaster_DisPlay_Field: array of integer;//masterҪ��ʾ����Ѱ�������λֵ
    FDetail_DisPlay_Field: array of integer;//DetailҪ��ʾ����Ѱ�������λֵ

  //============================  write by JEFF  2002.10.16===================
  //  FLookUpDate : array of string; //ҪLookUp�� ���ϱ�����ԭ�ϱ�žʹ���ԭ�����Ƶ�--['T_Cust','T_Material'];
  //  FLookUpPurpose : array of string;  // ҪLookUp�� ���ϱ���λ;
  //  FLookUpVisibleField;array of string; // ҪLookUp�� ���ϱ���ʾ��λ;
  //  FLookUpSourceFindKey :array of string;//Ҫͨ����Դ������Щ��λ���в�����λ�磺ͨ�����ϵ��ĳ��̱�Ų��ҳ�������--ͨ������Ϊ�磺M.F01����ϸ D.F01---['M.F01','D.F01,D.F02'];
  //===============================================================

    FSql: string; //Ҫ��Ѱ�ģӣѣ��﷨
    FFieldType: array of char; //��Ѱ��λ����̬
    FMFieldCount: integer; //Ҫ��Ѱ����λ��Ŀ
    FDFieldCount: integer;// Ҫ��Ѱ��detail��λ��
    FFieldName: array of string; //Ҫ��Ѱ����λԭʼ����
    FFieldDisplayName: array of string; //Ҫ��ʾ����λ����
    FSelRang: array of integer;   (* ѡȡ����ӡ��Χ *)
    FSelR: Boolean;               (* ѡȡ��Ϊ��¼��Χ(True), ������λ��Χ(False) *)
    FOtherWhere: string;//������Ѱʱ����������ֵ
    FKeyValue: TstringList;//Ҫ�����ϱ�ȡ�ص�ʱ,��Ҫ�õ�����λ
    procedure GetSQL;
    procedure SetSearchGrid;
    procedure GetSQLEx;
    procedure InitialSearchField;
    function Get_From_Sentence: string;
    { Private declarations }
  public
    { Public declarations }
    procedure Exec(MDataSet: TDBDataset;MSearchField: array of integer;DDataSet: TDBDataset;DSearchField,iMDisField_List,iDDisField_List: array of integer;sOtherWhere: string);
    Property sDataSet: TDBDataSet read FDataSet write FDataSet;
    property sDataBaseName: string read FDataBaseName write FDataBaseName;
    (* ȷ��Ҫ��ӡ�����Ϸ�Χ *)
    procedure GetSelRang;
    (* Excel ��ӡ��ʽ*)
    procedure ExcelPrint(const Dataset: TDataSet; Excel_ID, s_title: String; SelR: Boolean; PField: array of integer);

  end;

  procedure Search_MasterDetailEx(const MDataSet: TDBDataSet;sMField: array of Integer;const DDataSet: TDBDataSet;sDField,iMDisField_List,iDDisField_List: array of Integer;sOtherWhere: string='');
  procedure Search_MasterDetail(const MDataSet: TDBDataSet;sMField: array of Integer;const DDataSet: TDBDataSet;sDField: array of Integer;sOtherWhere: string='');

var
  MasterDetailSearchNoLook: TMasterDetailSearchNoLook;

implementation
{$DEFINE TEST}


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
  TestSQLOutput = 'C:\WINNT\Profiles\Administrator.000\����ʼ�����ܱ�\';

{$R *.DFM}
procedure Search_MasterDetailEx(const MDataSet: TDBDataSet;sMField: array of Integer;const DDataSet: TDBDataSet;sDField,iMDisField_List,iDDisField_List: array of Integer;sOtherWhere: string='');
begin
  if MDataSet=nil then begin
    MessageBoxEx(application.handle,'������Ҫ��ѯ�����ϱ�����','����',MB_OK,SUBLANG_CHINESE_TRADITIONAL);
    exit;
  end;
  if High(sMField)=0 then begin
    MessageBoxEx(application.handle,'������Ҫ��ѯ����λ���','����',MB_OK,SUBLANG_CHINESE_TRADITIONAL);
    exit;
  end;

  MasterDetailSearchNoLook := TMasterDetailSearchNoLook.Create(Application);
  try
    MasterDetailSearchNoLook.Exec(MDataSet,sMField,DDataSet,sDField,iMDisField_List,iDDisField_List,sOtherWhere);
  finally
    MasterDetailSearchNoLook.Free;
  end;

end;

{KeyField���������Ѱ����λ��,Ҳ��������Ѱ����λ����Ҫ��KEY ����λ����,iKeyField��ʾ��Ѱ����λǰ��λ��KEY��λ}
procedure Search_MasterDetail(const MDataSet: TDBDataSet;sMField: array of Integer;const DDataSet: TDBDataSet;sDField: array of Integer;sOtherWhere: string='');
begin
  if MDataSet=nil then begin
    MessageBoxEx(application.handle,'������Ҫ��ѯ�����ϱ�����','����',MB_OK,SUBLANG_CHINESE_TRADITIONAL);
    exit;
  end;
  if High(sMField)=0 then begin
    MessageBoxEx(application.handle,'������Ҫ��ѯ����λ���','����',MB_OK,SUBLANG_CHINESE_TRADITIONAL);
    exit;
  end;

  MasterDetailSearchNoLook := TMasterDetailSearchNoLook.Create(Application);
  try
    MasterDetailSearchNoLook.Exec(MDataSet,sMField,DDataSet,sDField,[],[],sOtherWhere);
  finally
    MasterDetailSearchNoLook.Free;
  end;
end;

{ TForm_SearchData }


procedure TMasterDetailSearchNoLook.GetSelRang;
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



procedure TMasterDetailSearchNoLook.ExcelPrint(const Dataset: TDataSet; Excel_ID, s_title: String; SelR: Boolean; PField: array of integer);
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




procedure TMasterDetailSearchNoLook.Exec(MDataSet: TDBDataset;MSearchField: array of integer;DDataSet: TDBDataset;DSearchField,iMDisField_List,iDDisField_List: array of integer;sOtherWhere: string);
var
  iCount: integer;
begin
  //��ʼִ����Ѱ
  FOtherWhere := sOtherWhere;
  sDataSet := MDataSet;
  FDetailDataSet := DDataSet;

  SetLength(FSearchField,high(MSearchField)+1);   //��Ҫ��Ѱ�������ϱ���λ����
  for iCount := 0 to high(MsearchField) do
    FsearchField[iCount] := MSearchField[iCount];

  SetLength(FDetailsearchField,high(DSearchField)+1);  //��Ҫ��Ѱ��detail���ϱ���λ����
  for iCount := 0 to high(DsearchField) do
    FDetailSearchField[iCount] := dSearchField[iCount];

  if High(iMDisField_List)<>(-1) then begin
    SetLength(FMaster_DisPlay_Field,High(iMDisField_List)+1);
    for iCount := low(iMDisField_List) to high(iMDisField_List) do
      FMaster_DisPlay_Field[iCount] := iMDisField_List[iCount];
  end;

  if High(iDDisField_List)<>(-1) then begin
    SetLength(FDetail_DisPlay_Field,High(iDDisField_List)+1);
    for iCount := low(iDDisField_List) to high(iDDisField_List) do
      FDetail_DisPlay_Field[iCount] := iDDisField_List[iCount];  //��Ҫ��ѯ����λ��Ҫ��ʾ����λ  ������������
  end;

  

  FMFieldCount := high(MSearchField)+1;
  FDFieldCount := high(DsearchField)+1;

  Query1.DatabaseName := MDataSet.DatabaseName;

   //�趨��Ѱ��λ����Ѷ(�ͱ�)
  InitialSearchField;

  if (High(iDDisField_List)<>(-1)) or (High(iMDisField_List)<>(-1)) then
    GetSQLEx //�����ȡ��Ҫ��ʾ�������Ǹ���λ
  else
    GetSQL; //ȡ�ãӣѣ��﷨
  SetSearchGrid; //�趨ҪѰ�ҵ�GRID����
  showmodal;
end;

procedure TMasterDetailSearchNoLook.InitialSearchField;
var
  iCount: integer;
begin
  SetLength(ffieldname,FMFieldCount+FDFieldCount);
  SetLength(FFieldType,FMFieldCount+FDFieldCount);
  SetLength(FFieldDisplayname,FMFieldCount+FDFieldCount);

  for iCount := 0 to FMFieldCount-1 do begin
    FFieldName[iCount] :='M.'+ TTable(sDataSet).Fields[fsearchfield[iCount]].FieldName;
    FFieldDisplayName[iCount] := TTable(sDataSet).Fields[fsearchfield[iCount]].DisplayName;
    case TTable(sDataSet).Fields[fsearchfield[iCount]].DataType  of
      ftdatetime :          FFieldType[iCount] := 'D';
      ftString:         FFieldType[ICount] := 'S';
      ftInteger,ftFloat:FFieldType[ICount] := 'I';
      else
        FFieldType[iCount] := 'N';
    end;//end of case
  end;

  for iCount := 0 to FDFieldCount-1 do begin
    FFieldName[iCount+FMFieldCount] :='D.'+ TTable(FDetailDataSet).Fields[fDetailsearchfield[iCount]].FieldName;
    FFieldDisplayName[iCount+FMFieldCount] := TTable(FDetailDataSet).Fields[fDetailsearchfield[iCount]].DisplayName;
    case TTable(FDetailDataSet).Fields[fDetailsearchfield[iCount]].DataType  of
      ftdatetime :          FFieldType[iCount+FMFieldCount] := 'D';
      ftString:         FFieldType[ICount+FMFieldCount] := 'S';
      ftInteger,ftFloat:FFieldType[ICount+FMFieldCount] := 'I';
      else
        FFieldType[iCount+FMFieldCount] := 'N';
    end;//end of case
  end;
end;

//ȡ�� SQL�����From���ִ�
function TMasterDetailSearchNoLook.Get_From_Sentence: string;   //JEFF�� �õ�SQL����е� From ����䣻
var
  iCount: integer;
  LM,LD: TList;
  sFrom: string;
begin
  FKeyValue := TstringList.Create;//����Ҫ������ȡ�ص���λ����(����)
  LM := TList.Create;
  LD := TList.Create;
  try
    TTable(FDetailDataSet).GetDetailLinkFields(lm,ld); // JEFF���õ���������ϸ��������λ

    sFrom := ' FROM '+TTable(sDataSet).TableName+' M, '+TTable(FDetailDataSet).tablename+' D WHERE ';
    for iCount:= 0 to LM.Count-1 do begin         //JEFF ����SQL���������ϱ�����ϣ���������λ��TTable(FDetailDataSet).GetDetailLinkFields(lm,ld)�õ���
      sFrom := sFrom +' M.'+TField(Lm[iCount]).FieldName+' = D.'+TField(LD[iCount]).FieldName+' AND';
      FKeyValue.Add(TField(Lm[iCount]).FieldName);
    end;
    if FOtherWhere <>'' then
      sFrom := sFrom +' '+FOtherWhere+'AND';

    delete(sFrom,length(sFrom)-2,3);

  finally
    Lm.Free;
    LD.Free;
  end;
  result := sFrom;
end;

//��ʹ�������趨Ҫ��ʾ����Щ��λʱ,
procedure TMasterDetailSearchNoLook.GetSQLEx;
var
  iCount: integer;
  sSelect: string;
begin
  sSelect := 'SELECT ';

  //���� select ���﷨
  for iCount := Low(FMaster_DisPlay_Field) to high(FMaster_DisPlay_Field) do
    sSelect := sSelect+' M.'+TTable(sDataSet).Fields[FMaster_DisPlay_Field[iCount]].FieldName+' as '+TTable(sDataSet).Fields[FMaster_DisPlay_Field[iCount]].DisplayName+', ';

  for iCount := low(FDetail_DisPlay_Field) to high(FDetail_DisPlay_Field) do
      sSelect := sSelect+' D.'+TTable(FDetailDataSet).Fields[FDetail_DisPlay_Field[iCount]].FieldName+' as '+TTable(FDetailDataSet).Fields[FDetail_DisPlay_Field[iCount]].DisplayName+', ';

  trim(sSelect);
  Delete(sSelect,length(sSelect)-1,1);

  FSql := sSelect + Get_From_Sentence;

  {$ifdef TESt}
  {AssignFile(output, testSQLoutput+'aaa1.sql');
  rewrite(output);
  writeln(output,fsql);
  closefile(output);}
  {$Endif} 
end;

//��ʹ������ָ��Ҫ��ʾ������Щ��λ,������Ѱ����λΪ��ʾ����λ
procedure TMasterDetailSearchNoLook.GetSQL;
var
  iCount: integer;
  iCountRepeat: integer;
  iRepeatTime: integer;
  sSelect: string;
begin
  sSelect := 'SELECT ';

  //���� select ���﷨
  iRepeatTime := 0;
  for iCount := 0 to FMFieldCount-1 do begin
    for iCountRepeat := 0 to iCount-1 do
      if fsearchfield[iCount] = fsearchfield[iCountRepeat] then //JEFF����ѡ�����������ڷ�Χ
        inc(iRepeatTime);
    if iRepeatTime = 0 then//��ѡ���,����ʱ�����ǻ�ѡ�������ͬ����λ�����Ƚ�,��������λ,������ѡ���������λֻ��Ҫ��ʾһ���ͺ���
      sSelect := sSelect+' M.'+TTable(sDataSet).Fields[fsearchfield[iCount]].FieldName+' as '+TTable(sDataSet).Fields[fsearchfield[iCount]].DisplayName+', ';
    iRepeatTime := 0;
  end;

  iRepeatTime := 0;
  for iCount := 0 to FDFieldCount-1 do begin
    for iCountRepeat := 0 to iCount-1 do
      if fDetailsearchfield[iCount] = fDetailsearchfield[iCountRepeat] then
        inc(iRepeatTime);
    if iRepeatTime = 0 then//��ѡ���,����ʱ�����ǻ�ѡ�������ͬ����λ�����Ƚ�,��������λ,������ѡ���������λֻ��Ҫ��ʾһ���ͺ���
      sSelect := sSelect+' D.'+TTable(FDetailDataSet).Fields[fDetailsearchfield[iCount]].FieldName+' as '+TTable(FDetailDataSet).Fields[fDetailsearchfield[iCount]].DisplayName+', ';
    iRepeatTime := 0;
  end;

  trim(sSelect);
  Delete(sSelect,length(sSelect)-1,1);

  FSql := sSelect + Get_From_Sentence;
  {$ifdef TEST}
  {AssignFile(output, TestSQLOutput+'aaa2.sql');
  rewrite(output);
  writeln(output,fsql);
  closefile(output); }
  {$endif}
end;

procedure TMasterDetailSearchNoLook.SetSearchGrid;
var
  iCount: integer;
  iRows: integer;
begin
  //�趨tsGrid�Ļ���
  iRows := FMFieldCount+FDFieldCount;
  with tsGrid1 do begin
    tsGrid1.Rows := iRows;

    for iCount := 0 to iRows-1 do begin
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

procedure TMasterDetailSearchNoLook.tsGrid1ButtonClick(Sender: TObject; DataCol,
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

procedure TMasterDetailSearchNoLook.StartSearch(Sender: TObject);
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
    for i := 0 to (FMFieldCount+FMFieldCount)-1 do
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
    // Query1.SQL.Add(FSql + ' AND  '+sWhere+' ')
    else
      Query1.SQL.Add(FSql + ' WHERE '+sWhere);
    {$ifdef TEST}
    {AssignFile(output,  TestSQLOutput+'SQL.sql');
    rewrite(output);
    writeln(output,Query1.SQL.Text);
    closefile(output);}
    {$endif}
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

procedure TMasterDetailSearchNoLook.tsGrid1ComboGetValue(Sender: TObject;
  Combo: TtsComboGrid; GridDataCol, GridDataRow, ComboDataRow: Integer;
  var Value: Variant);
begin
  //��ʹ����ѡ���˵�һ����Ѱ����ֵ����Ѱ����ʱ,������ʹ���߸ı�
  if (GridDataCol= ibool_Cell) and (GridDataRow=1) then begin
    MessageBoxEx(application.handle,'�������趨�������ֵ','����',MB_OK,SUBLANG_CHINESE_TRADITIONAL);
    value := '';
  end;
end;

procedure TMasterDetailSearchNoLook.tsGrid1ComboDropDown(Sender: TObject;
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

procedure TMasterDetailSearchNoLook.BitBtn3Click(Sender: TObject);
begin
  Close;
end;

procedure TMasterDetailSearchNoLook.BitBtn2Click(Sender: TObject);
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

  if FKeyValue.Count > 1 then begin  //JEFFע:FKeyValue �Ǵ�������������λ
    VFieldArray := VarArrayCreate([0,FKeyValue.Count-1],varolestr); // ��VFieldArray ���ɱ������飬varolestr��һ�����ͣ�
    for iCount := 0 to FKeyValue.Count-1 do begin    //��vFieldArray �е�ÿ��ԭ�ظ�ֵ
      vFieldArray[iCount] := Query1.Fieldbyname(sDataSet.Fieldbyname(FKeyValue[iCount]).DisplayName).value;
      sParimayKey := sParimaykey + FKeyValue[iCount]+';'
    end;
    Delete(sParimayKey,length(sParimayKey),1);
    sDataSet.Locate(sParimayKey,vFieldArray,[]);
  end
  else
  begin
    sParimayKey := FKeyValue[0];      //JEFFע: ͨ��������ֵ���в��� 
    vFieldArray := Query1.Fieldbyname(sDataSet.Fieldbyname(FKeyValue[0]).DisplayName).value;
    sDataSet.Locate(sParimayKey,vFieldArray,[]);
  end;
  close;
end;

procedure TMasterDetailSearchNoLook.tsDBGrid1DblClick(Sender: TObject);
begin
  BitBtn2Click(nil);
end;

procedure TMasterDetailSearchNoLook.Query1AfterOpen(DataSet: TDataSet);
begin
  BitBtn2.Enabled := not query1.IsEmpty;
  (* add code*)
  BitBtn4.Enabled := not query1.IsEmpty;
  BitBtn5.Enabled := not query1.IsEmpty;
  (**)
end;

procedure TMasterDetailSearchNoLook.tsGrid1CellEdit(Sender: TObject; DataCol,
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

procedure TMasterDetailSearchNoLook.BitBtn4Click(Sender: TObject);
begin
  GetSelRang;
  SearchRepExc(Query1,FSelR,FSelRang);
end;

procedure TMasterDetailSearchNoLook.BitBtn5Click(Sender: TObject);
begin
  GetSelRang;
  ExcelPrint(Query1,'Excel.Application','���ϱ�',FSelR,FSelRang);
end;

procedure TMasterDetailSearchNoLook.FormDestroy(Sender: TObject);
begin
  FKeyValue.Free;
end;

procedure TMasterDetailSearchNoLook.FormCreate(Sender: TObject);
begin
  FormResizer1.InitializeForm;
end;

procedure TMasterDetailSearchNoLook.FormResize(Sender: TObject);
begin
  FormResizer1.ResizeAll;
end;

end.
