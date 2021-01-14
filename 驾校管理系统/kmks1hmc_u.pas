unit kmks1hmc_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, ImgList, ComCtrls, ToolWin, StdCtrls, ExtCtrls,
  ActnList, Grids, DBGridEh, PrnDbgeh, Mask, DB, DBTables, Menus;

type
  Tkmks1hmc = class(TForm)
    Panel1: TPanel;
    ActionList1: TActionList;
    aSave: TAction;
    aCancel: TAction;
    aPreview: TAction;
    aPrint: TAction;
    aExit: TAction;
    aNew: TAction;
    aDel: TAction;
    aInsert: TAction;
    aDelete: TAction;
    aSetColumn: TAction;
    aFirst: TAction;
    aPrior: TAction;
    aNext: TAction;
    aLast: TAction;
    aCalendar: TAction;
    aCalculator: TAction;
    aXzdd: TAction;
    aSkgc: TAction;
    aKhXx: TAction;
    Label1: TLabel;
    ilsSub: TImageList;
    Panel2: TPanel;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBGridEh1: TDBGridEh;
    DBEdit7: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Panel3: TPanel;
    Label7: TLabel;
    DBEdit1: TDBEdit;
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    btnPreview: TToolButton;
    btnPrint: TToolButton;
    ToolButton9: TToolButton;
    btnSave: TToolButton;
    btnCancel: TToolButton;
    ToolButton3: TToolButton;
    btnNew: TToolButton;
    btnDel: TToolButton;
    ToolButton13: TToolButton;
    btnInsert: TToolButton;
    btnDelete: TToolButton;
    ToolBar2: TToolBar;
    DBNavigator1: TDBNavigator;
    ToolBar3: TToolBar;
    btnExit: TToolButton;
    Label6: TLabel;
    Label8: TLabel;
    DBEdit5: TDBEdit;
    Database1: TDatabase;
    DataSource2: TDataSource;
    Query1: TQuery;
    Query1BDEDesigner: TStringField;
    Query1BDEDesigner2: TStringField;
    Query1BDEDesigner3: TStringField;
    Query1BDEDesigner4: TStringField;
    Query1BDEDesigner5: TStringField;
    Query1BDEDesigner6: TStringField;
    Query1BDEDesigner7: TDateTimeField;
    Query1BDEDesigner8: TStringField;
    Query1BDEDesigner10: TStringField;
    Query1BDEDesigner11: TBooleanField;
    Query1BDEDesigner12: TBooleanField;
    Query1BDEDesigner9: TIntegerField;
    UpdateSQL1: TUpdateSQL;
    Query1BDEDesigner15: TStringField;
    PopupMenu1: TPopupMenu;
    pmnSave: TMenuItem;
    pmnCancel: TMenuItem;
    N11: TMenuItem;
    pmnNew: TMenuItem;
    pmnDel: TMenuItem;
    N6: TMenuItem;
    pmnInsert: TMenuItem;
    pmnDelete: TMenuItem;
    N5: TMenuItem;
    O2: TMenuItem;
    N10: TMenuItem;
    pmnFirst: TMenuItem;
    pmnPrior: TMenuItem;
    pmnNext: TMenuItem;
    pmnLast: TMenuItem;
    MainMenu1: TMainMenu;
    smnFile: TMenuItem;
    smnSave: TMenuItem;
    smnCancel: TMenuItem;
    N3: TMenuItem;
    smnPreview: TMenuItem;
    smnPrint: TMenuItem;
    N1: TMenuItem;
    smnExit: TMenuItem;
    smnEdit: TMenuItem;
    smnNew: TMenuItem;
    smnDel: TMenuItem;
    N9: TMenuItem;
    smnInsert: TMenuItem;
    smnDelete: TMenuItem;
    N4: TMenuItem;
    O1: TMenuItem;
    N2: TMenuItem;
    smnFirst: TMenuItem;
    smnPrior: TMenuItem;
    smnNext: TMenuItem;
    smnLast: TMenuItem;
    Stool: TMenuItem;
    smmCalendar: TMenuItem;
    smmCalculator: TMenuItem;
    Query2: TQuery;
    DBEdit2: TDBEdit;
    DataSource1: TDataSource;
    DBMemo1: TDBMemo;
    Query2BDEDesigner: TStringField;
    Query2BDEDesigner2: TDateTimeField;
    Query2BDEDesigner3: TIntegerField;
    Query2BDEDesigner4: TIntegerField;
    Query2BDEDesigner5: TIntegerField;
    Query2BDEDesigner6: TIntegerField;
    Query2BDEDesigner7: TStringField;
    Query2BDEDesigner8: TDateTimeField;
    Query2BDEDesigner9: TMemoField;
    Query3: TQuery;
    Query1BDEDesigner13: TStringField;
    procedure DateTimePicker1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1EditButtonClick(Sender: TObject);
    procedure Query1UpdateRecord(DataSet: TDataSet;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure Query2AfterInsert(DataSet: TDataSet);
    procedure Query2BeforeDelete(DataSet: TDataSet);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  kmks1hmc: Tkmks1hmc;
  myUpdateKind:TUpdateKind;
resourcestring
  NotImplemented= '%s not implemented!';

  ModifySQL='update ��Ŀһ����_mx set '+
            'ѧ��=:ѧ��,��ѵʱ��=:��ѵʱ��,�������=:�������,'+
            '�����Ļ�=:�����Ļ�,�Ƿ���=:�Ƿ���,����=:���� '+
            'where (ѧ��=:OLD_ѧ��) and (����=:����)';

  InsertSQL='insert into ��Ŀһ����_mx (ѧ��,��ѵʱ��,�������,�����Ļ�,�Ƿ���,����)'+
            'values(:ѧ��,:��ѵʱ��,:�������,:�����Ļ�,:�Ƿ���,:����)';

  DeleteSQL='delete from ��Ŀһ����_mx where (ѧ��=:OLD_ѧ��) and (����=:OLD_����)';

implementation

uses pub_search_u, public_var,TypInfo;

{$R *.dfm}

procedure Tkmks1hmc.FormCreate(Sender: TObject);
begin
  self.Caption:='��Ŀһ���Ի�����';
  label1.Caption:='��Ŀһ���Ի�����';
  Updatesql1.InsertSQL.Text:=InsertSQL;
  UpdateSQL1.ModifySQL.Text:= ModifySQL;
  UpdateSQL1.DeleteSQL.Text:=DeleteSQL;
  Query1.Open;
  Query1.Database.TransIsolation := tiDirtyRead;
  query2.Open;
end;

procedure Tkmks1hmc.Query1UpdateRecord(DataSet: TDataSet;
  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
begin
  if( UpdateKind = ukModify ) then
  begin
    showmessage(Updatesql1.SQL[UpdateKind].Text);
    //mxds_state:=1;
    UpdateSQL1.Apply(UpdateKind);
    UpdateAction := uaApplied;
    exit;
  end;
  if ( UpdateKind = ukInsert ) then
  begin
    showmessage(Updatesql1.SQL[UpdateKind].text);
    UpdateSQL1.Apply(UpdateKind);
    UpdateAction := uaApplied;
    exit;
  end;
  if ( UpdateKind = ukDelete ) then
  begin
    showmessage(Updatesql1.SQL[UpdateKind].text);
    UpdateSQL1.Apply(UpdateKind);
    UpdateAction := uaApplied;
    exit;
  end;
  //������ʾ
  UpdateAction := uaSkip;
  ShowMessage( Format( NotImplemented, [GetEnumName(
  TypeInfo(TUpdateKind), Ord(UpdateKind))]));
end;

procedure Tkmks1hmc.DateTimePicker1Change(Sender: TObject);
begin
  dbedit1.Text:=datetostr(datetimepicker1.Date);
end;

procedure Tkmks1hmc.DBGridEh1KeyPress(Sender: TObject; var Key: Char);
var
  myquery:TQuery;
  search_tmpstr:variant;
  xm_fld:string;
begin
  if key=#13 then
  begin
    if DBGridEh1.SelectedField.FieldName ='����' then
    begin
      myquery:=TQuery.Create(self);
      myquery.DatabaseName:='jx';
      myquery.Close;
      myquery.sql.Clear;
      myquery.SQL.add('select ѧ��,����,�Ա�,���֤��,�ֻ�,�绰,ѡ���� as ��ϵ��,ѧ��״̬ as �������,��Ŀ���ɼ� as ���Գɼ� from student ');
      myquery.SQL.Add('where ����='''+dbgrideh1.SelectedField.AsString+'''');
      myquery.Open;
      if myquery.RecordCount=0 then
      begin
        showmessage('���޴���!');
        myquery.Free;
        exit;
      end;
      xm_fld:=myquery.FieldByName('����').AsString;
      if (search_tmpstr<>xm_fld) and  (xm_fld<>'') then
      begin
        query1.Edit;
        query1.FieldByName('ѧ��').AsString:=myquery.FieldByName('ѧ��').AsString;
        query1.FieldByName('����').AsString:=myquery.FieldByName('����').AsString;
        query1.FieldByName('�Ա�').AsString:=myquery.FieldByName('�Ա�').AsString;
        query1.FieldByName('���֤��').AsString:=myquery.FieldByName('���֤��').AsString;
        query1.FieldByName('�ֻ�').AsString:=myquery.FieldByName('�ֻ�').AsString;
        query1.FieldByName('�绰').AsString:=myquery.FieldByName('�绰').AsString;
        query1.FieldByName('��ϵ��').AsString:=myquery.FieldByName('��ϵ��').AsString;
        query1.FieldByName('�������').AsString:=myquery.FieldByName('�������').AsString;
        query1.FieldByName('���Գɼ�').AsInteger:=myquery.FieldByName('���Գɼ�').AsInteger;
        query1.FieldByName('�����Ļ�').AsBoolean:=false;
        query1.FieldByName('�Ƿ���').AsBoolean:=false;
        query1.FieldByName('����').AsString:=dbedit5.Text;
        myquery.Free;
        dbgrideh1.SelectedIndex:=6; //����'��ѵʱ��'Ϊ����
        exit;
      end;
    end;
    if dbgrideh1.SelectedIndex=6 then
    begin
      dbgrideh1.SelectedIndex:=9;  //����'�������'Ϊ����
      exit;
    end;
    if dbgrideh1.SelectedIndex=9 then
    begin
      dbgrideh1.SelectedIndex:=dbgrideh1.SelectedIndex+1;
      exit;
    end;
    if dbgrideh1.SelectedIndex=10 then
    begin
      dbgrideh1.SelectedIndex:=dbgrideh1.SelectedIndex+1;
      exit;
    end;
    if dbgrideh1.SelectedIndex=11 then
    begin
      dbgrideh1.SelectedIndex:=13; //�����һ��
      dbgrideh1.Perform(WM_KEYDOWN, VK_TAB, 0); //����'tab'��
      exit;
    end;
  end;
end;

procedure Tkmks1hmc.DBGridEh1EditButtonClick(Sender: TObject);
var
  mysqlstr:string;
  search_tmpstr:variant;
begin
  if DBGridEh1.SelectedField.FieldName ='����' then
  begin
    search_tmpstr:=dbgrideh1.SelectedField.AsString;
    pub_search:=Tpub_search.Create(self);
    mysqlstr:='select ѧ��,����,�Ա�,���֤��,�ֻ�,�绰,ѡ���� as ��ϵ��,ѧ��״̬ as �������,��Ŀ���ɼ� as ���Գɼ� from student';
    pub_search.myselect(mysqlstr,'ѧԱ����');
    pub_search.ShowModal;
    if (search_tmpstr<>myarr[1]) and (myarr[1]<>'') then
    begin
      query1.Edit;
      query1.FieldByName('ѧ��').AsString:=myarr[0];
      query1.FieldByName('����').AsString:=myarr[1];
      query1.FieldByName('�Ա�').AsString:=myarr[2];
      query1.FieldByName('���֤��').AsString:=myarr[3];
      query1.FieldByName('�ֻ�').AsString:=myarr[4];
      query1.FieldByName('�绰').AsString:=myarr[5];
      query1.FieldByName('��ϵ��').AsString:=myarr[6];
      query1.FieldByName('�������').AsString:=myarr[7];
      query1.FieldByName('���Գɼ�').AsInteger:=myarr[8];
      query1.FieldByName('�����Ļ�').AsBoolean:=false;
      query1.FieldByName('�Ƿ���').AsBoolean:=false;
      query1.FieldByName('����').AsString:=dbedit5.Text;
      dbgrideh1.SelectedIndex:=6;
    end;
  end;
end;

//����
procedure Tkmks1hmc.btnSaveClick(Sender: TObject);
var
  mybookmark:TBookMark;
begin
  Query1.Database.ApplyUpdates( [Query1] );
  if query2.State in [dsEdit, dsInsert] then
  begin
    query2.FieldByName('������').AsString:='';
    query2.FieldByName('��������').AsDateTime:=date;
    query2.Post;
    //ˢ������
    mybookmark:=query2.GetBookmark;
    query2.Close;
    query2.Open;
    try
      query2.GotoBookmark(mybookmark);
    finally
      query2.FreeBookmark(mybookmark);
    end;
  end;
end;

//ȡ��
procedure Tkmks1hmc.btnCancelClick(Sender: TObject);
begin
  query1.CancelUpdates;
  query2.Cancel;
end;

//����
procedure Tkmks1hmc.btnInsertClick(Sender: TObject);
begin
  query1.Append;;
end;

//ɾ��
procedure Tkmks1hmc.btnDeleteClick(Sender: TObject);
begin
  if Application.MessageBox( 'ȷ��Ҫɾ��������¼��?',
      '����ɾ��', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 ) = IDYES then
    query1.Delete;
end;

//�µ�
procedure Tkmks1hmc.btnNewClick(Sender: TObject);
begin
  if query1.State in [dsEdit,dsInsert] then
    if Application.MessageBox( 'ȷ��Ҫ����˵���?',
      '���ϱ���', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 ) = IDYES then
       kmks1hmc.btnSaveClick(Sender)
    else
      query1.Cancel;
  query2.Insert
end;

//ɾ��
procedure Tkmks1hmc.btnDelClick(Sender: TObject);
begin
  if Application.MessageBox( 'ȷ��Ҫɾ�����ŵ���?',
      '����ɾ��', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 ) = IDYES then
    query2.Delete;
end;

//����
procedure Tkmks1hmc.aExitExecute(Sender: TObject);
begin
  close;
end;

procedure Tkmks1hmc.Query2AfterInsert(DataSet: TDataSet);
var
  dhbmstr_l,sqlstr:string; //�������ֵ
  xdxs:integer;
  xdxs_str:string;  //�µ�����
begin
  //ȡ�µ����
  query3.Close;
  query3.SQL.Clear;
  dhbmstr_l:='KM1DH'+formatdatetime('yyyymmdd',date); //ȡ��������ַ�
  sqlstr:='select * from ��Ŀһ����_zb where ���� like '+''''+dhbmstr_l+'%''';
  showmessage(sqlstr);
  query3.SQL.Add(sqlstr);
  query3.Open;
  if query3.RecordCount<>0 then
  begin
    query3.Last;
    xdxs:=strtoint(copy(query3.fieldbyname('����').AsString,14,5))+1;
    xdxs_str:=formatfloat('00000',xdxs);
    dbedit5.Text:=dhbmstr_l+xdxs_str;
  end
  else
  begin
    dbedit5.Text:=dhbmstr_l+'00001';
  end;
  query3.Close;
end;

procedure Tkmks1hmc.Query2BeforeDelete(DataSet: TDataSet);
var
  myquery:tquery;
begin
  //��ɾ������֮ǰɾ����ϸ��¼
  myquery:=tquery.Create(self);
  with myquery do
  begin
    DatabaseName:='jx';
    DataSource:=DataSource2;
    Close;
    sql.Clear;
    SQL.Add('delete from ��Ŀһ����_mx where ����=:����');
    ExecSQL;
    close;
    free;
  end;
end;

end.
