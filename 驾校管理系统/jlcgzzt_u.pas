unit jlcgzzt_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Buttons, Mask, DB, DBTables, Grids, DBGrids,
  ExtCtrls, ComCtrls, TabNotBk, DBGridEh, PrnDbgeh,EhlibBDE;

type
  Tjlcgzzt = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    Database1: TDatabase;
    Label8: TLabel;
    Table2: TTable;
    Table2BDEDesigner: TStringField;
    Table2BDEDesigner2: TStringField;
    Table3: TTable;
    Table3BDEDesigner: TStringField;
    Table3BDEDesigner2: TStringField;
    DataSource2: TDataSource;
    Table4: TTable;
    Table4_jlc: TStringField;
    Table4_jly: TStringField;
    Table4BDEDesigner: TStringField;
    Table4BDEDesigner2: TIntegerField;
    Table4BDEDesigner3: TIntegerField;
    Table4BDEDesigner4: TIntegerField;
    Table4BDEDesigner5: TStringField;
    Table4BDEDesigner6: TMemoField;
    Table4BDEDesigner7: TStringField;
    Table4BDEDesigner8: TDateTimeField;
    Table1BDEDesigner: TStringField;
    Table1BDEDesigner2: TStringField;
    Table1BDEDesigner3: TStringField;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    SpeedButton1: TSpeedButton;
    Label9: TLabel;
    Label10: TLabel;
    Label14: TLabel;
    SpeedButton3: TSpeedButton;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    Edit3: TEdit;
    GroupBox2: TGroupBox;
    DBMemo1: TDBMemo;
    GroupBox3: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    BitBtn4: TBitBtn;
    TabSheet2: TTabSheet;
    Query1: TQuery;
    DataSource3: TDataSource;
    Panel2: TPanel;
    Label15: TLabel;
    DBNavigator2: TDBNavigator;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Edit5: TEdit;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    DBGridEh1: TDBGridEh;
    PrintDBGridEh1: TPrintDBGridEh;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3Exit(Sender: TObject);
    procedure Table4AfterScroll(DataSet: TDataSet);
    procedure Table4AfterInsert(DataSet: TDataSet);
    procedure Table4BeforePost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    search_str:string;
  end;

var
  jlcgzzt: Tjlcgzzt;

implementation

uses public_var, pub_search_u;

{$R *.dfm}

procedure Tjlcgzzt.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
   if key=#13 then
      edit3.SetFocus
   else
      if table4.state<>dsedit then table4.Edit;
end;

procedure Tjlcgzzt.Edit1Exit(Sender: TObject);
begin
   if table1.Locate('����',edit1.Text,[loCaseInsensitive]) and (edit1.text<>'') then
      edit2.Text:=table1.FieldValues['ѧ��']
   else
      if edit1.text<>'' then MessageDlg('û�д˳��ţ�', mtWarning, [mbOk], 0);
end;

procedure Tjlcgzzt.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
   if key=#13 then
      edit3.SetFocus
   else
      if table4.state<>dsedit then table4.Edit;
end;

procedure Tjlcgzzt.Edit2Exit(Sender: TObject);
begin
   if table1.Locate('ѧ��',edit2.Text,[]) and (edit2.text<>'') then
      edit1.Text:=table1.FieldValues['����']
   else
      if edit2.text<>'' then MessageDlg('û�д�ѧ�ţ�', mtWarning, [mbOk], 0);
end;

procedure Tjlcgzzt.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
   if key=#13 then
      DBLookupComboBox1.SetFocus
   else
      if table4.state<>dsedit then table4.Edit;
end;

procedure Tjlcgzzt.Edit3Exit(Sender: TObject);
begin
   if not (table2.Locate('����',edit3.Text,[]) and (edit3.text<>'')) then
      if edit3.text<>'' then MessageDlg('û�д��ˣ�', mtWarning, [mbOk], 0);
end;

procedure Tjlcgzzt.Table4AfterScroll(DataSet: TDataSet);
begin
  if table4.state<>dsinsert then
  begin
    table1.Locate('���',table4.FieldValues['���_jlc'],[]);
    edit1.Text:=table1.FieldValues['����'];
    edit2.Text:=table1.FieldValues['ѧ��'];
    table2.Locate('���',table4.FieldValues['���_jly'],[]);
    edit3.Text:=table2.FieldValues['����'];
  end;
end;

procedure Tjlcgzzt.Table4AfterInsert(DataSet: TDataSet);
begin
    edit1.Text:='';
    edit2.Text:='';
    edit3.Text:='';
end;



procedure Tjlcgzzt.Table4BeforePost(DataSet: TDataSet);
begin
   table4.FieldValues['���_jlc']:=table1.lookup('����',edit1.text,'���');
   table4.FieldValues['���_jly']:=table2.lookup('����',edit3.Text,'���');
   table4.FieldValues['������']:='';
   table4.FieldValues['��������']:=date;
end;


procedure Tjlcgzzt.SpeedButton1Click(Sender: TObject);
var
  mysqlstr:string;
  search_tmpstr:variant;
begin
  search_tmpstr:=Edit1.Text;
  pub_search:=Tpub_search.Create(self);
  mysqlstr:='select * from ���������ͳ�Ʊ�';
  pub_search.myselect(mysqlstr,'���������ͳ��');
  pub_search.ShowModal;
  if (search_tmpstr<>myarr[1]) and (myarr[1]<>'') then
  begin
    Edit1.Text:=myarr[1];
    table4.Edit;
  end;
  //�ж�edit1�Ƿ��н���
  if not Edit1.Focused then edit1.SetFocus;
    Edit3.SetFocus;
end;

procedure Tjlcgzzt.SpeedButton3Click(Sender: TObject);
var
  mysqlstr:string;
  search_tmpstr:variant;
begin
  search_tmpstr:=Edit3.Text;
  pub_search:=Tpub_search.Create(self);
  mysqlstr:='select * from ����Ա����';
  pub_search.myselect(mysqlstr,'����Ա����');
  pub_search.ShowModal;
  if (search_tmpstr<>myarr[1]) and (myarr[1]<>'') then
  begin
    Edit3.Text:=myarr[1];
    table4.Edit;
  end;
  //�ж�edit1�Ƿ��н���
  if not Edit3.Focused then edit3.SetFocus;
    dblookupcombobox1.SetFocus;
end;

procedure Tjlcgzzt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  self.Destroy;
end;

procedure Tjlcgzzt.BitBtn4Click(Sender: TObject);
begin
  self.close;
end;

procedure Tjlcgzzt.FormCreate(Sender: TObject);
var
  i:integer;
begin
   table1.Open;
   table2.Open;
   table3.Open;
   table4.Open;
   //��ʼ��combobox
    with query1 do
    begin
      close;
      sql.clear;
      sql.add('SELECT cqktj.����, cqktj.ѧ��, jlyda.����, cgzzt.��������, cgzzt.��ѵ����, cgzzt.��������, cgzzt.�������, cgzzt.����״̬, cgzzt.��ע, cgzzt.������, cgzzt.�������� FROM ���������ͳ�Ʊ� cqktj, ����������״̬ cgzzt, ����Ա���� jlyda ');
      sql.add('where cqktj.��� = cgzzt.���_jlc and jlyda.��� = cgzzt.���_jly');
      open;
      for i:=0 to FieldCount-1 do
          combobox3.Items.Add(Fields[i].FieldName);
      close;
      combobox3.ItemIndex:=0;
    end;

end;

procedure Tjlcgzzt.BitBtn5Click(Sender: TObject);
var
  comitem_clsname:string;
begin
  query1.open;
  comitem_clsname:=query1.FieldByName(combobox3.Text).ClassName;
  with query1 do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT cqktj.����, cqktj.ѧ��, jlyda.���� as ����, cgzzt.��������, cgzzt.��ѵ����, cgzzt.��������, cgzzt.�������, cgzzt.����״̬, cgzzt.��ע, cgzzt.������, cgzzt.�������� FROM ���������ͳ�Ʊ� cqktj, ����������״̬ cgzzt, ����Ա���� jlyda ');
    sql.add('where (cqktj.��� = cgzzt.���_jlc) and (jlyda.��� = cgzzt.���_jly)');
    if edit5.text<>'' then
    begin
      //showmessage(comitem_clsname);
      if comitem_clsname='TStringField' then
        sql.add(' and '+combobox3.text+' '+combobox4.Text+' '+''''+edit5.text+'''');
      if (comitem_clsname='TIntegerField') or (comitem_clsname='TBooleanField') then
        sql.add(' and '+combobox3.text+' '+combobox4.Text+' '+edit5.text);
      if  comitem_clsname='TDateTimeField' then
        sql.Add(' and cgzzt.'+combobox3.text+' '+combobox4.Text+' #'+edit5.Text+'#');
    end;
    if not Prepared then Prepare;
    open;
  end;
  if query1.RecordCount=0 then
    showmessage('�޼�¼')
  else
    dbgrideh1.datasource:=datasource3
    //dbgrideh1.Columns[4].Footer.valuetype:=fvtSum;
end;



procedure Tjlcgzzt.BitBtn7Click(Sender: TObject);
begin
  printdbgrideh1.Preview;
end;

procedure Tjlcgzzt.DBGridEh1DblClick(Sender: TObject);
var
bhstr:string;
begin
  //showmessage(query1.FieldValues['����']);
  //ȡ'���������ͳ�Ʊ�'�ñ��
  bhstr:=table1.Lookup('����',query1.FieldValues['����'],'���');
  if table4.Locate('���_jlc',bhstr,[]) then
     pagecontrol1.ActivePage:=TabSheet1
  else
     showmessage('��λ����');

end;

//���з�ɫ��ʾ
procedure Tjlcgzzt.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  //if dbgrideh1.DataSource.DataSet.RecNo mod 2=1 then
  if DBGridEh1.SumList.RecNo mod 2 = 1 then
    Background := $00FFC4C4
  else
    Background := $00FFDDDD;
end;

end.
