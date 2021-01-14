unit uReBuild_Index;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,BDE,DB,Wintypes,WinProcs,DBTables,Registry,DBUNIT,BDEUTIL,TUTIL,FileCtrl;

type
  TReBuild_Index = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    StaticText1: TStaticText;
    tbIndex: TTable;
    ComboBox1: TComboBox;
    Label3: TLabel;
    Memo1: TMemo;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MutilReBuild(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    Procedure OnNeedPassword(Sender: TObject; var Continue: Boolean);
  private
    sTableName: TStringList;//store TableName
    FDataBasename: string;
    function BackupDataBase: boolean;
    procedure SetDMTable(Option: boolean);
    procedure StructReBuild(TableName: string);
    { Private declarations }
  public
    { Public declarations }

    procedure HandleExceptions(Sender: TObject; E: Exception);
    procedure WriteMsg(strWrite:string);
    Function RebuildIndexes(strAlias,strTable:string; var strError: string):Boolean;
    property rDataBaseName: string read FDataBasename write FDataBaseName;
  end;

var
  ReBuild_Index: TReBuild_Index;

implementation

uses utilities,uDM
{$ifndef NoDataBase}
   //,uDM
{$endif}
    ;

{$R *.DFM}

var
  currentPath: string;

function TReBuild_Index.BackupDataBase: boolean;
var
  directory,stemp: string;
  i: integer;
  sTableName: TstringList;
  BusyForm: TForm;
begin
  result := false;
  if not R_YesNoMessage(['ϵͳ����ִ�б�����ҵ,�Ա��������������,Ҫ��������ǰ�����ϱ�����?']) then
    exit;
  SystemBusy(BusyForm,True);

  try
    directory := currentPath+'��������'+FormatDateTime('eemmdd',now);
    i := 1;
    stemp := directory;
    directory := stemp + '001';
    while  DirectoryExists(directory) do begin
      inc(i);
      directory := stemp+IntToString(i,3);
    end;
    ForceDirectories(directory);

    if DirectoryExists(directory) then begin

      sTableName := TStringList.Create;
      Session.GetTableNames(rDataBaseName,'',false,false,sTableName);
      try

        for i:= 0 to sTableName.Count-1 do
          if not DBCopyTableFileIO(DBGetAliasPath(rDataBaseName),sTableName[i],directory,sTableName[i]) then begin
            showmessage('�������Ͽ�ʱ��������');
            result := false;
            break;
          end;
        Result := true;
      finally
        sTableName.Free;
      end;

    end
    else
      showmessage('�ŵ���������,���ܽ�������·��');
  finally
    SystemBusy(BusyForm,False);
  end;
end;

Procedure TReBuild_Index.OnNeedPassword(Sender: TObject; var Continue: Boolean);
begin
  Continue:=True;
end;

procedure TReBuild_Index.HandleExceptions(Sender: TObject; E: Exception);
begin
  if E.Message <> '' then
  begin
    Screen.Cursor := crDefault;
    MessageDlg(E.Message,mtError,[mbOK],0);
  end;
end;

procedure TReBuild_Index.WriteMsg(strWrite:string);
begin
  Memo1.Lines.Add(strWrite);
  Memo1.Update;
end;

Function TReBuild_Index.RebuildIndexes(strAlias,strTable:string; var strError: string):Boolean;
var
  bdeResult : DBIResult;
begin
  Result := False;
  if tbIndex.Active then tbIndex.Active := False;
  tbIndex.DatabaseName := strAlias;
  tbIndex.TableName := strTable;
  Screen.Cursor := crHourGlass;
  try
    WriteMsg('���ڿ������ϱ�'+strTable+'...');
    tbIndex.Exclusive := True;
    tbIndex.Active:=True;
  Finally
    Screen.Cursor := crDefault;
  end;
  if NOT tbIndex.Active
    then
      strError := '������ϱ��޷���ר��ģʽ����,'+#10#13#13+'�������ڱ�����ʹ����ʹ����!'
    else
      begin
        WriteMsg('�����ؽ����ϱ�'+strTable+'��������...');
        Screen.Cursor := crHourGlass;
        try
          bdeResult := DbiRegenIndexes(tbIndex.Handle);
          case bdeResult of
            DBIERR_NONE : Result := True;
            DBIERR_INVALIDHNDL : strError := '���ϱ�ľ������!';
            DBIERR_NEEDEXCLACCESS:  strError := '���ϱ��ڱ��Թ���ģʽ����!';
            DBIERR_NOTSUPPORTED:  strError :=  'Զ�˵������޷����ؽ�!';
            DBIERR_FILEBUSY:  strError :=  '������ϱ��޷���ר��ģʽ����,'+#10#13#13+'�������ڱ�����ʹ����ʹ����!';
          else
            strError := '������ϱ��޷���ר��ģʽ����,'+#10#13#13+'�������ڱ�����ʹ����ʹ����!';
          end;
        Finally
          Screen.Cursor := crDefault;
        end;
      end;
      if Result then
        begin
          WriteMsg('���!');
          WriteMsg('');
        end
      else
        begin
          WriteMsg('ʧ��!'+'  '+strError);
          WriteMsg('');
        end;
end;

//�趨DataModual�����ϱ�״̬
procedure TReBuild_Index.SetDMTable(Option: boolean);
var
  i: integer;
  Index: integer;
begin
{$ifndef NoDataBase}

  if option then //�������ϱ��ǿ�����Ԫ��,���ҹر�
    with DM do begin
      sTableName.Clear;
      for i:= 0 to ComponentCount-1 do
        if (Components[i] is TDataSet)then
          if (Components[i] as TDataSet).active then begin
            sTableName.Add(Components[i].Name);
            (Components[i] as TDataSet).Close;
          end;
    end
  else begin //������������,��DM������ϱ����¿���
    with DM do begin
      sTableName.Sort;
      for i:= 0 to ComponentCount-1 do
        if (Components[i] is TDataSet)then
          if sTableName.Find(Components[i].Name,Index) then
            (Components[i] as TDataSet).Open;
    end
  end;
{$endif}
end;

procedure TReBuild_Index.Button1Click(Sender: TObject);
var
  I : integer;
  strError :string;
  Fail : Boolean;
begin
  Memo1.ScrollBars:=ssBoth;
  strError :='';
  Fail := False;
  ReadWritereg('ReIndexDate',DatetoStr(Now),True);
  if ComboBox1.ItemIndex>0 then
    begin
      if NOT RebuildIndexes(rDataBaseName,Combobox1.Items[ComboBox1.ItemIndex],strError) then
          begin
            MessageDlg('����Ϊ���ϱ�'+Combobox1.Items[ComboBox1.ItemIndex]+'�ؽ�������.'+#10+#10+'ԭ��:'+strError,mtError,[mbOK],0);
            Fail :=True;
          end;
      if NOT Fail then
        MessageDlg('�Ѿ��ɹ���Ϊ���ϱ�'+Combobox1.Items[ComboBox1.ItemIndex]+'�ؽ���������!',mtInformation,[mbOK],0);
    end
  else
    begin
      for i := 1 to Combobox1.Items.Count-1 do
        if NOT RebuildIndexes(rDataBaseName,Combobox1.Items[i],strError) then
          begin
            MessageDlg('����Ϊ���ϱ�'+Combobox1.Items[i]+'�ؽ�������.'+#10+#10+'ԭ��:'+strError,mtError,[mbOK],0);
            Fail :=True;
          end;
     if NOT Fail then
       begin
         MessageDlg('�Ѿ��ɹ���Ϊ���е����ϱ��ؽ���������!',mtInformation,[mbOK],0);
         //Close;
       end;
    end;
  StaticText1.Caption:= Copy(StaticText1.Caption,1,19) + DateToStr(Now);
end;

procedure TReBuild_Index.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TReBuild_Index.FormShow(Sender: TObject);
begin
  StaticText1.Caption:= Copy(StaticText1.Caption,1,19)+ReadWriteReg('ReIndexDate','����ȷ��',False);;
end;

procedure TReBuild_Index.FormDestroy(Sender: TObject);
begin
  setdmTable(False);
  sTableName.Free;
end;

procedure TReBuild_Index.MutilReBuild(Sender: TObject);
var
  BusyForm: TForm;
  sTableName: TstringList;
  strResult: string;
  i: integer;
  password: string;
begin
  if not BackupDataBase then
    if not R_YesNoMessage(['��û�н�������ǰ�����ϱ��ݻ򱸷ݶ���ʧ��,'#13#13'������������������ᵼ���������,�Ƿ��������������ҵ?'+#13#13+'����Ǣѯ�����Ա��']) then
      exit;

  SystemBusy(BusyForm,True);
  sTableName := TStringList.Create;
  Session.GetTableNames(rDataBaseName,'',false,false,sTableName);

  try
    for i:= 0 to sTableName.Count-1 do
      try
          if (LowerCase(sTableName[i])='password') then
            begin
              With tbIndex do
                begin
                  Close;
                  DataBaseName:=rDataBaseName;
                  TableName:='PassWord';
                  Open;
                end;
               if NOT tbIndex.Active then password := '7805'
               else Password := '';
               tbIndex.Close;
            end
          else
            Password := '';
          memo1.Lines.Add('');
          if DBRebuildTable(DBGetAliasPath(rDataBaseName),sTableName[i]+'.DB',DBGetAliasPath(rDataBaseName)+'clone\'+sTableName[i]+'.DB','','','','',PassWord,strResult) then
            memo1.Lines.Add('���ϱ� [' + sTableName[i] + '] �޸��ɹ��� ')
          else begin
            memo1.Lines.Add('���ϱ� [' + sTableName[i] + '] �޸�ʧ��,��Ǣ��ʽ�����Ա�� '+#10#13+'ʧ��ԭ��:'+strResult+#13#10);
          end;
      except
        on E: EDataBaseError do begin
          BusyForm.Hide;
          memo1.Lines.Add('���ϱ� [' + sTableName[i] + '] ���Ͽⷢ������,����ѶϢ ['
                     + E.Message + '].');
        end;
      end;

      BusyForm.Hide;
      memo1.Lines.Add('�ѳɹ����ؽ��������ϱ�');
      showmessage('�ѳɹ����ؽ��������ϱ�');
      DBDeleteTableFileIO(currentPath,'.DB');
  finally
    sTableName.Free;
    SystemBusy(BusyForm,False);
  end;
end;


procedure TReBuild_Index.FormActivate(Sender: TObject);
begin
  sTableName := TStringList.Create;
  Application.OnException := HandleExceptions;
  Screen.Cursor := crHourGlass;
  try
    Session.GetTableNames(rDataBaseName,'',True,False,ComboBox1.Items);
    ComboBox1.Items.Insert(0,'<<���е����ϱ�>>');
    ComboBox1.ItemIndex := 0;
  Finally
    Screen.Cursor := crDefault;
  end;
  setdmTable(True);

  if not DirectoryExists(DBGetAliasPath(rDataBaseName)+'clone\') then begin
    r_okmessage(['�Ҳ������ϱ���,��Ǣ��ʽ�����Ա']);
    close;
  end;

end;

procedure TReBuild_Index.FormCreate(Sender: TObject);
begin
  currentPath := ExtractFilePath(Application.ExeName);
  if currentPath[length(currentPath)] <> '\'  then
  currentPath := currentPath + '\';
  Session.OnPassword:=OnNeedPassWord;
end;

procedure TReBuild_Index.StructReBuild(TableName: string);
var
  strTmpClone,strTmpStruct: string;
  AutoIncIsSingleFieldPrimaryKey : Boolean;
  MultiPassOK                    : boolean;
  OrigCloneTable                 : String;
  AlixPath                       : string;
  AutoIncField                   : Integer;
  PassWord: string;
  CloneTable                     : String;
  strError                       : String;
  WorkTableType                  : DBINAME;
  CloneMode                      : TCloneMode;
begin
  if UpperCase(TableName) = 'PASSWORD.DB' then
    PassWord := '7805'
  else
    PassWord := '';
  AlixPath := DBGetAliasPath(rDataBaseName);
  WorkTableType := DBGetTableType(TableName);
  try
    { set up working tables needed for the multi-pass rebuild}
    strTmpClone := '_CLONE.DB';
    strTmpStruct := '_STRUCT.DB';

    { determine whether AutoInc field can be transformed to an Integer field
      and back during the rebuild process. To be a legal transformation, the
      AutoInc field must be the only field in the primary key. }
    AutoIncIsSingleFieldPrimaryKey :=
            DBCheckAutoIncTranslationAllowed(AlixPath, TableName, '');

    MultiPassOK := False;  { assume failure for now }
    try
      OrigCloneTable := AlixPath+'Clone\'+TableName;
      Application.ProcessMessages;

      { Create a clone of the current clone table. This will ensure we have the
        structure of the original table, even if the clone table is the target table
        itself }

      { Create Clone Table without indices and convert AutoInc to LongInt }
      if DBCloneTableStructure(ExtractFilePath(OrigCloneTable), ExtractFileName(OrigCloneTable),
                               AlixPath, strTmpStruct, '', cmNoChange, AutoIncField) then
        if DBCloneTableStructure(AlixPath, strTmpStruct, AlixPath, strTmpClone, '',
                                 cmDropAllIndices, AutoIncField) then
          if (not AutoIncIsSingleFieldPrimaryKey) Or
              DBCloneTableStructure(AlixPath, strTmpClone, AlixPath, strTmpClone, '',
                                    cmChangeAutoIncToInt, AutoIncField) then
          begin
            CloneTable := AlixPath + strTmpClone;
            { PHASE (1) Rebuild without Primary & Secondary Indices and with AutoInc Fields
              changed to Integer }
            if DBRebuildTable(AlixPath, TableName, CloneTable,'','','','',password, strError) then
            begin
              { PHASE (2) Pack table }
              if DBPackTable(AlixPath, TableName, '', WorkTableType, False) then
              begin
                { PHASE (3) Add Primary index and rebuild }
                if DBCloneTableStructure(AlixPath, strTmpStruct, AlixPath, strTmpClone, '',
                                         cmDropSecondary, AutoIncField) then
                  if (not AutoIncIsSingleFieldPrimaryKey) Or
                     DBCloneTableStructure(AlixPath, strTmpClone, AlixPath, strTmpClone, '',
                                           cmChangeAutoIncToInt, AutoIncField) then
                    if DBRebuildTable(AlixPath, TableName, CloneTable,'','','','',Password, strError) then
                    begin
                      { PHASE (4) Add back secondary indexes }
                      if AutoIncIsSingleFieldPrimaryKey then
                        CloneMode := cmChangeAutoIncToInt
                      else
                        CloneMode := cmNoChange;
                      if DBCloneTableStructure(AlixPath, strTmpStruct, AlixPath, strTmpClone, '',
                                               CloneMode, AutoIncField) then
                      begin
                        if DBRebuildTable(AlixPath, TableName, CloneTable,'','','','',PassWord, strError) then
                        begin
                          if AutoIncIsSingleFieldPrimaryKey And (AutoIncField > 0) then
                          begin
                            if DBSetAutoIncField(AlixPath, TableName, '', AutoIncField) then
                              MultiPassOK := True;
                          end
                          else
                            MultiPassOK := True;
                        end;
                      end;
                    end;

              end;
            end;
          end;
    finally
      { delete clone tables }
      DBDeleteTableFileIO(ExtractFilePath(CloneTable), ExtractFileName(CloneTable));
      DBDeleteTableFileIO(AlixPath, strTmpStruct);
      if MultiPassOK then
        memo1.lines.add('Table [' + TableName + '] rebuilt.')
      else
        memo1.lines.add('FAILED to rebuild table [' + TableName + '] : Error = [' + strError + '].');
    end;
  except
    on E: EDataBaseError do
    begin
      MessageDlg('FAILED to rebuild table [' + TableName + '] : Database error = [' + E.Message + '].',
                 mtInformation, [mbOK], 0);
    end;
  end;

  { Remove any temporary files }
  if not DBDeleteTableFileIO(ExtractFilePath(Application.ExeName), '.DB') then
    memo1.lines.add('Failed to remove temporary files.');

end;

procedure TReBuild_Index.Button4Click(Sender: TObject);
var
  sTableName: TstringList;
//i: integer;
begin

  if not BackupDataBase then
    if not R_YesNoMessage(['���Ͽⱸ��ʧ��,������������������ᵼ���������,�Ƿ��������������ҵ?'+#10#13+'����Ǣѯ�����Ա��']) then
      exit;


  sTableName := TStringList.Create;
  Session.GetTableNames(rDataBaseName,'',false,false,sTableName);

  try
    //for i:= 0 to sTableName.Count-1 do
    //  StructReBuild(sTableName[i]+'.DB');
    StructReBuild('Billdetail.DB');
  finally
    sTableName.Free;
  end;

end;

end.
