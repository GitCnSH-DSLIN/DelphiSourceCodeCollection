unit pxjyz_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, DBCtrls, Buttons, StdCtrls, DB, DBTables, Grids, DBGrids,
  ExtCtrls, ComCtrls, TabNotBk, PrnDbgeh, DBGridEh;

type
  Tpxjyz = class(TForm)
    Label1: TLabel;
    DataSource1: TDataSource;
    Table1: TTable;
    Database1: TDatabase;
    Table1BDEDesigner: TStringField;
    Table1BDEDesigner2: TStringField;
    Table1BDEDesigner3: TStringField;
    Table1BDEDesigner4: TDateTimeField;
    Table1BDEDesigner5: TStringField;
    Table2: TTable;
    Table2BDEDesigner: TAutoIncField;
    Table2BDEDesigner2: TStringField;
    Table2BDEDesigner3: TStringField;
    Table2BDEDesigner4: TStringField;
    Table2BDEDesigner5: TStringField;
    DataSource2: TDataSource;
    Table2BDEDesigner6: TStringField;
    Table2BDEDesigner7: TDateTimeField;
    Query1: TQuery;
    DataSource3: TDataSource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBComboBox1: TDBComboBox;
    DBComboBox2: TDBComboBox;
    DBEdit3: TDBEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Panel1: TPanel;
    Label9: TLabel;
    DBNavigator1: TDBNavigator;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    TabSheet2: TTabSheet;
    DBGridEh1: TDBGridEh;
    PrintDBGridEh1: TPrintDBGridEh;
    procedure Edit2Exit(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Table2BeforePost(DataSet: TDataSet);
    procedure Table2AfterInsert(DataSet: TDataSet);
    procedure Table2AfterScroll(DataSet: TDataSet);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Query1AfterScroll(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pxjyz: Tpxjyz;

implementation

uses pub_search_u, public_var;

{$R *.dfm}

procedure Tpxjyz.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
   if key=#13 then
      DBComboBox1.SetFocus
   else
      if table2.state<>dsedit then table2.Edit;
end;

procedure Tpxjyz.Edit2Exit(Sender: TObject);
begin
   if table1.Locate('����',edit2.Text,[loCaseInsensitive]) and (edit2.text<>'') then
   begin
      table2.FieldValues['ѧ��']:=table1.FieldValues['ѧ��'];
      edit2.Text:=table1.FieldValues['����'];
      edit3.Text:=table1.fieldbyname('���֤��').AsString;
   end
   else
      if edit2.text<>'' then MessageDlg('û�д��ˣ�', mtWarning, [mbOk], 0);
end;


procedure Tpxjyz.Table2BeforePost(DataSet: TDataSet);
begin
    table2.FieldValues['������']:='';
    table2.FieldValues['��������']:=date;
end;

procedure Tpxjyz.Table2AfterInsert(DataSet: TDataSet);
begin
     edit2.Text:='';
     edit3.text:='';
end;

procedure Tpxjyz.Table2AfterScroll(DataSet: TDataSet);
begin
  if table2.state<>dsinsert then
  begin
    table1.Locate('ѧ��',table2.FieldValues['ѧ��'],[]);
    edit2.Text:=table1.FieldValues['����'];
    edit3.Text:=table1.fieldbyname('���֤��').AsString;
  end;
end;

procedure Tpxjyz.SpeedButton1Click(Sender: TObject);
var
  mysqlstr:string;
  search_tmpstr:variant;
begin
  search_tmpstr:=Edit2.Text;
  pub_search:=Tpub_search.Create(self);
  mysqlstr:='select ѧ��,����,���֤�� from student';
  pub_search.myselect(mysqlstr,'ѧԱ����');
  pub_search.ShowModal;
  if (search_tmpstr<>myarr[1]) and (myarr[1]<>'') then
  begin
    Edit2.Text:=myarr[1];
    table2.Edit;
  end;
  //�ж�edit1�Ƿ��н���
  if not Edit2.Focused then edit2.SetFocus;
    dbcombobox1.SetFocus;
end;

procedure Tpxjyz.BitBtn1Click(Sender: TObject);
var
   sqlstr:string;
begin
 if combobox1.text<>'' then
 begin
   sqlstr:='select xyda.����,xyda.���֤��,pxjyz.* from student xyda,��ѵ��ҵ֤ pxjyz where xyda.ѧ��=pxjyz.ѧ�� ';
   query1.Close;
   query1.SQL.Clear;
   if edit1.text<>'' then
   begin
     sqlstr:=sqlstr+'and '+ComboBox1.Text+ComboBox2.Text+''''+Edit1.Text+'''';
     query1.SQL.Add(sqlstr)
   end
   else
     query1.SQL.Add(sqlstr);
   //if not Prepared then  Prepare; //����׼��
   query1.Open;
   if query1.RecordCount=0 then
      showmessage('����ؼ�¼��');
 end
 else
   showmessage('û��ѡ���ѯ������');
end;

procedure Tpxjyz.FormCreate(Sender: TObject);
begin
   if table1.state<>dsbrowse then table1.Open;
   if table2.state<>dsbrowse then table2.Open;
end;

procedure Tpxjyz.Query1AfterScroll(DataSet: TDataSet);
begin
   table2.Locate('ѧ��',query1.FieldValues['ѧ��'],[]);
end;

procedure Tpxjyz.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   self.Destroy;
end;

procedure Tpxjyz.BitBtn4Click(Sender: TObject);
begin
  self.close;
end;

procedure Tpxjyz.BitBtn3Click(Sender: TObject);
begin
   printdbgrideh1.Preview;
end;

end.
