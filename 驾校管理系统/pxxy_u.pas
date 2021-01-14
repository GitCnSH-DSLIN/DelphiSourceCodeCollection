unit pxxy_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Mask, ComCtrls, TabNotBk, DB, DBTables,
  Buttons, ExtCtrls, Grids, DBGridEh, PrnDbgeh;

type
  Tpxxy = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    Database1: TDatabase;
    Table1BDEDesigner: TStringField;
    Table1BDEDesigner2: TStringField;
    Table1BDEDesigner3: TStringField;
    Table1BDEDesigner4: TStringField;
    Table1BDEDesigner5: TDateTimeField;
    Table1BDEDesigner6: TFloatField;
    Table1BDEDesigner7: TFloatField;
    Table1BDEDesigner8: TFloatField;
    Table1BDEDesigner9: TDateTimeField;
    Table2: TTable;
    Table2BDEDesigner: TStringField;
    Table2BDEDesigner2: TStringField;
    Table2BDEDesigner3: TFloatField;
    Table2BDEDesigner4: TFloatField;
    Table2BDEDesigner5: TFloatField;
    Table2BDEDesigner6: TFloatField;
    Table2BDEDesigner7: TStringField;
    Table2BDEDesigner8: TDateTimeField;
    Table2BDEDesigner9: TStringField;
    DataSource2: TDataSource;
    Table3: TTable;
    Table3BDEDesigner2: TStringField;
    DataSource3: TDataSource;
    Label18: TLabel;
    Table3BDEDesigner: TMemoField;
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
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    SpeedButton1: TSpeedButton;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit3: TEdit;
    GroupBox2: TGroupBox;
    DBMemo1: TDBMemo;
    GroupBox3: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    TabSheet2: TTabSheet;
    DataSource4: TDataSource;
    Query1: TQuery;
    DBGridEh1: TDBGridEh;
    Panel2: TPanel;
    Label19: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit13: TEdit;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    PrintDBGridEh1: TPrintDBGridEh;
    procedure Edit1Exit(Sender: TObject);
    procedure Table2BeforePost(DataSet: TDataSet);
    procedure Table2AfterInsert(DataSet: TDataSet);
    procedure Table2BeforeScroll(DataSet: TDataSet);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure ComboBox1DropDown(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pxxy: Tpxxy;

implementation

uses pub_search_u, public_var;

{$R *.dfm}

procedure Tpxxy.Edit1Exit(Sender: TObject);
begin
  with table1 do
  begin
     if (edit1.Text<>'') and (Locate('ѧ��',edit1.Text,[locaseinsensitive])) then
     begin
       edit1.text:=fieldbyname('ѧ��').AsString;
       edit2.Text:=fieldbyname('����').AsString;
       edit3.Text:=fieldbyname('���֤��').AsString;
       edit4.Text:=fieldbyname('ѧϰ����').AsString;
       edit6.Text:=fieldbyname('Ӧ��ѧ��').AsString;
       edit7.Text:=fieldbyname('�׸�').AsString;
       edit8.Text:=fieldbyname('�ڶ��θ���').AsString;
       edit9.text:=fieldbyname('�ڶ��θ�������').AsString;
       edit10.Text:=fieldbyname('����ʱ��').AsString;
       exit;
     end;
     if (edit1.Text<>'') and (not locate('ѧ��',edit1.Text,[locaseinsensitive])) then
     begin
       MessageDlg('û�д�ѧ�ţ�', mtWarning, [mbOk], 0);
     end;
  end;
end;

procedure Tpxxy.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
   if key=#13 then edit5.setfocus;
end;

procedure Tpxxy.SpeedButton1Click(Sender: TObject);
var
  mysqlstr:string;
  search_tmpstr:variant;
begin
  search_tmpstr:=Edit1.Text;
  pub_search:=Tpub_search.Create(self);
  mysqlstr:='select ѧ��,����,���֤��,ѧϰ����,Ӧ��ѧ��,�ڶ��θ���,�ڶ��θ�������,����ʱ�� from student';
  pub_search.myselect(mysqlstr,'ѧԱ����');
  pub_search.ShowModal;
  if (search_tmpstr<>myarr[0]) and (myarr[0]<>'') then
  begin
    Edit1.Text:=myarr[0];
    table2.Edit;
  end;
  //�ж�edit1�Ƿ��н���
  if not Edit1.Focused then edit1.SetFocus;
    Edit5.SetFocus;
end;

procedure Tpxxy.Table2BeforePost(DataSet: TDataSet);
begin
   table2.FieldValues['ѧ��']:=edit1.Text;
end;

procedure Tpxxy.Table2AfterInsert(DataSet: TDataSet);
begin
   edit1.text:='';
   edit2.Text:='';
   edit3.Text:='';
   edit4.Text:='';
   edit5.Text:='';
   edit6.Text:='';
   edit7.Text:='';
   edit8.text:='';
   edit9.Text:='';
   edit10.text:='';
   edit11.Text:='';
   edit12.text:='';
   table2.FieldValues['������']:='';
   table2.FieldValues['��������']:=datetostr(now);
end;

procedure Tpxxy.Table2BeforeScroll(DataSet: TDataSet);
begin
   table1.Locate('ѧ��',table2.FieldValues['ѧ��'],[locaseinsensitive]);
  with table1 do
  begin
    edit1.text:=FieldValues['ѧ��'];
    if fieldvalues['����']<>null then
    edit2.Text:=fieldvalues['����']
    else
    edit2.Text:='';
    if fieldvalues['���֤��']<>null then
    edit3.Text:=fieldvalues['���֤��']
    else
    edit3.Text:='';
    if fieldvalues['ѧϰ����']<>null then
    edit4.Text:=fieldvalues['ѧϰ����']
    else
     edit4.Text:='';
     if fieldvalues['Ӧ��ѧ��']<>null then
         edit6.Text:=inttostr(fieldvalues['Ӧ��ѧ��'])
     else
         edit6.Text:='';
     if fieldvalues['�׸�']<>null then
         edit7.Text:=inttostr(fieldvalues['�׸�'])
     else
         edit7.Text:='';
     if fieldvalues['�ڶ��θ���']<>null then
        edit8.Text:=inttostr(fieldvalues['�ڶ��θ���'])
     else
        edit8.Text:='';
     if fieldvalues['�ڶ��θ�������']<>null then
         edit9.text:=datetostr(fieldvalues['�ڶ��θ�������'])
     else
         edit9.text:='';
     if fieldvalues['����ʱ��']<>null then
         edit10.Text:=datetostr(fieldvalues['����ʱ��'])
     else
         edit10.Text:='';
    edit11.Text:='0'; //inttostr(fieldvalues['������']);
    edit12.Text:='0';  //inttostr(fieldvalues['�ؿ���']);
  end;
end;

procedure Tpxxy.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   pxxy.free;
end;

procedure Tpxxy.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure Tpxxy.BitBtn3Click(Sender: TObject);
var
   sqlstr:string;
begin
 if combobox1.text<>'' then
 begin
   sqlstr:='SELECT Stu.����,Stu.���֤��,Stu.ѧϰ����,pxxy.ѧ��,pxxy.ѵ����ʽ,pxxy.������,pxxy.�ؿ���,pxxy.�ɷѽ���д,pxxy.�ɷѽ��Сд,pxxy.���˴���,pxxy.��������,pxxy.������ FROM student stu,��ѵЭ�� pxxy WHERE (pxxy.ѧ��=Stu.ѧ��)';
   query1.Close;
   query1.SQL.Clear;
   if edit1.text<>'' then
   begin
     sqlstr:=sqlstr+'and '+ComboBox1.Text+ComboBox2.Text+''''+Edit13.Text+'''';
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

procedure Tpxxy.BitBtn5Click(Sender: TObject);
begin
  printdbgrideh1.Preview;
end;

procedure Tpxxy.ComboBox1DropDown(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to table1.Fields.Count-6 do
      combobox1.Items.Add(table1.Fields[i].FieldName);

  for i:=1 to table2.Fields.Count-1 do
      combobox1.Items.Add(table2.Fields[i].FieldName);
end;

end.
