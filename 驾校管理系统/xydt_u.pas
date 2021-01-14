unit xydt_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, DB, DBTables, Buttons, Grids, DBGrids,
  ExtCtrls, ComCtrls, TabNotBk;

type
  Txydt = class(TForm)
    Label1: TLabel;
    DataSource1: TDataSource;
    Table1: TTable;
    Database1: TDatabase;
    Table1BDEDesigner: TStringField;
    Table1BDEDesigner2: TStringField;
    Table1BDEDesigner3: TStringField;
    Table1BDEDesigner4: TStringField;
    Table1BDEDesigner1801: TStringField;
    Table1BDEDesigner5: TStringField;
    Table1BDEDesigner6: TStringField;
    Table1BDEDesigner7: TStringField;
    Table1BDEDesigner8: TMemoField;
    Table1BDEDesigner9: TStringField;
    Table1BDEDesigner10: TDateTimeField;
    Table2: TTable;
    Table2BDEDesigner: TStringField;
    Table2BDEDesigner2: TStringField;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    DBEdit1: TDBEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    GroupBox1: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    GroupBox2: TGroupBox;
    DBMemo1: TDBMemo;
    Panel1: TPanel;
    Label10: TLabel;
    DBNavigator1: TDBNavigator;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit8: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    DBGrid1: TDBGrid;
    TabSheet2: TTabSheet;
    procedure Table1AfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Table1BeforePost(DataSet: TDataSet);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure Table1BeforeInsert(DataSet: TDataSet);
    procedure Table1AfterInsert(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  xydt: Txydt;
  numflag:integer;
  i:integer;

implementation

uses pub_search_u, public_var;

{$R *.dfm}

procedure Txydt.Table1AfterScroll(DataSet: TDataSet);
begin
  if not table2.Active then table2.Open;
  if table2.locate('ѧ��',table1.FieldValues['��׮ѧԱ'],[loCaseInsensitive]) then
  edit1.Text:=table2.fieldbyname('����').AsString
  else
  edit1.Text:='';

  if table2.locate('ѧ��',table1.FieldValues['����·ѵѧԱ'],[]) then
  edit2.Text:=table2.fieldbyname('����').AsString
  else
  edit2.Text:='';

  if table2.locate('ѧ��',table1.FieldValues['1801��·ѵѧԱ'],[]) then
  edit3.Text:=table2.fieldbyname('����').AsString
  else
  edit3.Text:='';

  if table2.locate('ѧ��',table1.FieldValues['֧���Ͽ�ѧԱ'],[]) then
  edit4.Text:=table2.fieldbyname('����').AsString
  else
  edit4.Text:='';

  if table2.locate('ѧ��',table1.FieldValues['ҹѵѧԱ'],[]) then
  edit5.Text:=table2.fieldbyname('����').AsString
  else
  edit5.Text:='';

  if table2.locate('ѧ��',table1.FieldValues['����·ѵѧԱ'],[]) then
  edit6.Text:=table2.fieldbyname('����').AsString
  else
  edit6.Text:='';

  if table2.locate('ѧ��',table1.FieldValues['�ڼ���ѵ��ѧԱ'],[]) then
  edit7.Text:=table2.fieldbyname('����').AsString
  else
  edit7.Text:='';
        
end;

procedure Txydt.FormCreate(Sender: TObject);
begin
   if not table1.Active then table1.open;
   if not table2.Active then table2.Active:=true;
end;

procedure Txydt.Table1BeforePost(DataSet: TDataSet);
begin
  table1.FieldValues['��׮ѧԱ']:=table2.Lookup('����',edit1.text,'ѧ��');
  table1.FieldValues['����·ѵѧԱ']:=table2.Lookup('����',edit2.text,'ѧ��');
  table1.FieldValues['1801��·ѵѧԱ']:=table2.Lookup('����',edit3.text,'ѧ��');
  table1.FieldValues['֧���Ͽ�ѧԱ']:=table2.Lookup('����',edit4.text,'ѧ��');
  table1.FieldValues['ҹѵѧԱ']:=table2.Lookup('����',edit5.text,'ѧ��');
  table1.FieldValues['����·ѵѧԱ']:=table2.Lookup('����',edit6.text,'ѧ��');
  table1.FieldValues['�ڼ���ѵ��ѧԱ']:=table2.Lookup('����',edit7.text,'ѧ��');
  table1.FieldValues['������']:='';
  table1.FieldValues['��������']:=date;
end;

procedure Txydt.SpeedButton1Click(Sender: TObject);
var
  mysqlstr:string;
  search_tmpstr:variant;
begin
  search_tmpstr:=Edit1.Text;
  pub_search:=Tpub_search.Create(self);
  mysqlstr:='select ѧ��,����,ѧϰ���� as ֤��,���֤��,�ֻ�,�绰 from student';
  pub_search.myselect(mysqlstr,'ѧԱ����');
  pub_search.ShowModal;
  if (search_tmpstr<>myarr[1]) and (myarr[1]<>'') then
  begin
    Edit1.Text:=myarr[1];
    table1.Edit;
  end;
  //�ж�edit1�Ƿ��н���
  if not Edit1.Focused then edit1.SetFocus;
    Edit2.SetFocus;
end;

procedure Txydt.SpeedButton2Click(Sender: TObject);
var
  mysqlstr:string;
  search_tmpstr:variant;
begin
  search_tmpstr:=Edit2.Text;
  pub_search:=Tpub_search.Create(self);
  mysqlstr:='select ѧ��,����,ѧϰ���� as ֤��,���֤��,�ֻ�,�绰 from student';
  pub_search.myselect(mysqlstr,'ѧԱ����');
  pub_search.ShowModal;
  if (search_tmpstr<>myarr[1]) and (myarr[1]<>'') then
  begin
    Edit2.Text:=myarr[1];
    table1.Edit;
  end;
  //�ж�edit1�Ƿ��н���
  if not Edit2.Focused then edit2.SetFocus;
    Edit3.SetFocus;
end;

procedure Txydt.SpeedButton3Click(Sender: TObject);
var
  mysqlstr:string;
  search_tmpstr:variant;
begin
  search_tmpstr:=Edit3.Text;
  pub_search:=Tpub_search.Create(self);
  mysqlstr:='select ѧ��,����,ѧϰ���� as ֤��,���֤��,�ֻ�,�绰 from student';
  pub_search.myselect(mysqlstr,'ѧԱ����');
  pub_search.ShowModal;
  if (search_tmpstr<>myarr[1]) and (myarr[1]<>'') then
  begin
    Edit3.Text:=myarr[1];
    table1.Edit;
  end;
  //�ж�edit1�Ƿ��н���
  if not Edit3.Focused then edit3.SetFocus;
    Edit4.SetFocus;
end;

procedure Txydt.SpeedButton4Click(Sender: TObject);
var
  mysqlstr:string;
  search_tmpstr:variant;
begin
  search_tmpstr:=Edit4.Text;
  pub_search:=Tpub_search.Create(self);
  mysqlstr:='select ѧ��,����,ѧϰ���� as ֤��,���֤��,�ֻ�,�绰 from student';
  pub_search.myselect(mysqlstr,'ѧԱ����');
  pub_search.ShowModal;
  if (search_tmpstr<>myarr[1]) and (myarr[1]<>'') then
  begin
    Edit4.Text:=myarr[1];
    table1.Edit;
  end;
  //�ж�edit1�Ƿ��н���
  if not Edit4.Focused then edit4.SetFocus;
    Edit5.SetFocus;
end;

procedure Txydt.SpeedButton5Click(Sender: TObject);
var
  mysqlstr:string;
  search_tmpstr:variant;
begin
  search_tmpstr:=Edit5.Text;
  pub_search:=Tpub_search.Create(self);
  mysqlstr:='select ѧ��,����,ѧϰ���� as ֤��,���֤��,�ֻ�,�绰 from student';
  pub_search.myselect(mysqlstr,'ѧԱ����');
  pub_search.ShowModal;
  if (search_tmpstr<>myarr[1]) and (myarr[1]<>'') then
  begin
    Edit5.Text:=myarr[1];
    table1.Edit;
  end;
  //�ж�edit1�Ƿ��н���
  if not Edit5.Focused then edit5.SetFocus;
    Edit6.SetFocus;
end;

procedure Txydt.SpeedButton6Click(Sender: TObject);
var
  mysqlstr:string;
  search_tmpstr:variant;
begin
  search_tmpstr:=Edit6.Text;
  pub_search:=Tpub_search.Create(self);
  mysqlstr:='select ѧ��,����,ѧϰ���� as ֤��,���֤��,�ֻ�,�绰 from student';
  pub_search.myselect(mysqlstr,'ѧԱ����');
  pub_search.ShowModal;
  if (search_tmpstr<>myarr[1]) and (myarr[1]<>'') then
  begin
    Edit6.Text:=myarr[1];
    table1.Edit;
  end;
  //�ж�edit1�Ƿ��н���
  if not Edit6.Focused then edit6.SetFocus;
    Edit7.SetFocus;
end;

procedure Txydt.SpeedButton7Click(Sender: TObject);
var
  mysqlstr:string;
  search_tmpstr:variant;
begin
  search_tmpstr:=Edit7.Text;
  pub_search:=Tpub_search.Create(self);
  mysqlstr:='select ѧ��,����,ѧϰ���� as ֤��,���֤��,�ֻ�,�绰 from student';
  pub_search.myselect(mysqlstr,'ѧԱ����');
  pub_search.ShowModal;
  if (search_tmpstr<>myarr[1]) and (myarr[1]<>'') then
  begin
    Edit7.Text:=myarr[1];
    table1.Edit;
  end;
  //�ж�edit1�Ƿ��н���
  if not Edit7.Focused then edit7.SetFocus;
    dbmemo1.SetFocus;
end;

procedure Txydt.Table1BeforeInsert(DataSet: TDataSet);
begin
   table1.DisableControls;
   table1.Open;
   table1.Edit;
   table1.Last;
   table1.EnableControls;
   i:=table1.fieldbyname('���').AsInteger+1-120000;
end;

procedure Txydt.Table1AfterInsert(DataSet: TDataSet);
begin
   table1.FieldByName('���').AsString:=formatfloat('120000',i);
   edit1.Text:='';
   edit2.Text:='';
   edit3.Text:='';
   edit4.Text:='';
   edit5.Text:='';
   edit6.Text:='';
   edit7.Text:='';
end;

procedure Txydt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   xydt.Destroy;
end;

procedure Txydt.BitBtn4Click(Sender: TObject);
begin
   close;
end;

end.
