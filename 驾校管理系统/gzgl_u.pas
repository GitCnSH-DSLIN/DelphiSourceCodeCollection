unit gzgl_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, ComCtrls, TabNotBk, DB, DBTables,
  Buttons, Grids, DBGrids, ExtCtrls, frxClass, frxDBSet, frxDesgn;

type
  Tgzgl = class(TForm)
    DataSource1: TDataSource;
    Database1: TDatabase;
    Table1: TTable;
    Table2: TTable;
    Table1BDEDesigner: TStringField;
    Table1BDEDesigner2: TStringField;
    Table1BDEDesigner3: TStringField;
    DataSource2: TDataSource;
    Table2BDEDesigner: TStringField;
    Table2BDEDesigner3: TFloatField;
    Table2BDEDesigner4: TFloatField;
    Table2BDEDesigner5: TFloatField;
    Table2BDEDesigner6: TFloatField;
    Table2BDEDesigner7: TFloatField;
    Table2BDEDesigner8: TFloatField;
    Table2BDEDesigner9: TFloatField;
    Table2BDEDesigner10: TFloatField;
    Table2BDEDesigner11: TFloatField;
    Table2BDEDesigner12: TFloatField;
    Table2BDEDesigner13: TFloatField;
    Table2BDEDesigner14: TFloatField;
    Table2BDEDesigner17: TStringField;
    Table2BDEDesigner18: TStringField;
    Table2BDEDesigner19: TDateTimeField;
    Label21: TLabel;
    Query1: TQuery;
    frxDBDataset1: TfrxDBDataset;
    Table2BDEDesigner16: TFloatField;
    Table2BDEDesigner15: TFloatField;
    Table2BDEDesigner2: TFloatField;
    frxDesigner1: TfrxDesigner;
    frxReport1: TfrxReport;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    SpeedButton1: TSpeedButton;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    Edit3: TEdit;
    Edit2: TEdit;
    Panel1: TPanel;
    Label17: TLabel;
    DBNavigator1: TDBNavigator;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    DBGrid1: TDBGrid;
    GroupBox2: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    TabSheet2: TTabSheet;
    procedure Edit2Exit(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Table2BeforePost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure Table2AfterScroll(DataSet: TDataSet);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Table2AfterInsert(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  gzgl: Tgzgl;

implementation

uses pub_search_u, public_var;

{$R *.dfm}

procedure Tgzgl.Edit2Exit(Sender: TObject);
begin
  if (edit2.text<>'') and table1.Locate('����',edit2.Text,[locaseinsensitive]) then
  begin
     edit3.Text:=table1.FieldValues['ְ��'];
     //table2.Locate('���',table1.FieldValues['���'],[locaseinsensitive]);
     //datasource2.Enabled:=true;
  end
  else
  begin
     MessageDlg('û�д��ˣ�', mtWarning, [mbOk], 0);
  end;
end;

procedure Tgzgl.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
 if key=#13 then dbedit3.SetFocus;
end;

procedure Tgzgl.Table2BeforePost(DataSet: TDataSet);
begin
  with table2 do
  begin
     fieldvalues['���']:=table1.FieldValues['���'];
     fieldbyname('Ӧ���ϼ�').AsCurrency:=fieldbyname('��������').AsCurrency+fieldbyname('ѵ������').AsCurrency+fieldbyname('��������').AsCurrency+fieldbyname('���ݹ���').AsCurrency+fieldbyname('�Ӱ๤��').AsCurrency+fieldbyname('���ڷ�').AsCurrency;
     fieldbyname('Ӧ�ۺϼ�').AsCurrency:=fieldbyname('���').AsCurrency+fieldbyname('�¹ʿ۳�').AsCurrency+fieldbyname('Ч���۳�').AsCurrency+fieldbyname('�ݼٿ۳�').AsCurrency+fieldbyname('���տ۳�').AsCurrency+fieldbyname('�����۳�').AsCurrency;
     fieldbyname('ʵ������').AsCurrency:=fieldbyname('Ӧ���ϼ�').AsCurrency-fieldbyname('Ӧ�ۺϼ�').AsCurrency;
     fieldvalues['������']:='';
     fieldvalues['��������']:=date;
  end;
end;

procedure Tgzgl.FormCreate(Sender: TObject);
begin
   table1.Open;
   table2.Open;
end;


procedure Tgzgl.Table2AfterScroll(DataSet: TDataSet);
begin
 if table2.state<>dsinsert then
 begin
   table1.Locate('���',table2.FieldValues['���'],[locaseinsensitive]);
   edit2.Text:=table1.fieldbyname('����').AsString;
   edit3.Text:=table1.fieldbyname('ְ��').AsString;
 end;
end;

procedure Tgzgl.SpeedButton1Click(Sender: TObject);
var
  mysqlstr:string;
  search_tmpstr:variant;
begin
  search_tmpstr:=Edit2.Text;
  pub_search:=Tpub_search.Create(self);
  mysqlstr:='select * from ְ������';
  pub_search.myselect(mysqlstr,'ְ������');
  pub_search.ShowModal;
  if (search_tmpstr<>myarr[1]) and (myarr[1]<>'') then
  begin
    Edit2.Text:=myarr[1];
    table2.Edit;
  end;
  //�ж�edit1�Ƿ��н���
  if not Edit2.Focused then edit2.SetFocus;
    dbedit3.SetFocus;
end;

procedure Tgzgl.Table2AfterInsert(DataSet: TDataSet);
begin
  edit2.Text:='';
  edit3.Text:='';
end;


procedure Tgzgl.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   gzgl.free;
end;

procedure Tgzgl.BitBtn3Click(Sender: TObject);
begin
  close;
end;

procedure Tgzgl.BitBtn2Click(Sender: TObject);
begin
    frxreport1.ShowReport;
end;

end.
