unit lkcycj_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Mask, DBCtrls, DB, DBTables,
  ComCtrls, Grids, DBGridEh, frxClass, frxDBSet, frxDesgn, frxChBox;

type
  Tlkcycj = class(TForm)
    Label1: TLabel;
    DataSource1: TDataSource;
    Table1: TTable;
    Database1: TDatabase;
    Table1BDEDesigner2: TStringField;
    Table1BDEDesigner3: TStringField;
    Table1BDEDesigner4: TStringField;
    Table1BDEDesigner5: TStringField;
    Table1BDEDesigner6: TStringField;
    DataSource2: TDataSource;
    Table2: TTable;
    Table2BDEDesigner: TStringField;
    Table2BDEDesigner2: TBooleanField;
    Table2BDEDesigner3: TDateTimeField;
    Table2BDEDesigner4: TBooleanField;
    Table2BDEDesigner30CM: TBooleanField;
    Table2BDEDesigner5: TBooleanField;
    Table2BDEDesigner6: TBooleanField;
    Table2BDEDesigner7: TBooleanField;
    Table2BDEDesigner8: TBooleanField;
    Table2BDEDesigner9: TBooleanField;
    Table2BDEDesigner10: TBooleanField;
    Table2BDEDesigner11: TBooleanField;
    Table2BDEDesigner12: TBooleanField;
    Table2BDEDesigner13: TBooleanField;
    Table2BDEDesigner14: TBooleanField;
    Table2BDEDesigner15: TBooleanField;
    Table2BDEDesigner16: TBooleanField;
    Table2BDEDesigner17: TBooleanField;
    Table2BDEDesigner18: TBooleanField;
    Table2BDEDesigner19: TBooleanField;
    Table2BDEDesigner20: TBooleanField;
    Table2BDEDesigner21: TBooleanField;
    Table2BDEDesigner22: TBooleanField;
    Table2BDEDesigner23: TBooleanField;
    Table2BDEDesigner24: TBooleanField;
    Table2BDEDesigner25: TBooleanField;
    Table2BDEDesigner26: TBooleanField;
    Table2BDEDesigner27: TBooleanField;
    Table2BDEDesigner50CM: TBooleanField;
    Table2BDEDesigner30CM2: TBooleanField;
    Table2BDEDesigner28: TBooleanField;
    Table2BDEDesigner20KM: TBooleanField;
    Table2BDEDesigner29: TBooleanField;
    Table2BDEDesigner30: TBooleanField;
    Table2BDEDesigner31: TBooleanField;
    Table2BDEDesigner32: TBooleanField;
    Table2BDEDesigner33: TBooleanField;
    Table2BDEDesigner34: TBooleanField;
    Table2BDEDesigner35: TBooleanField;
    Table2BDEDesigner36: TBooleanField;
    Table2BDEDesigner37: TBooleanField;
    Table2BDEDesigner38: TStringField;
    Table2BDEDesigner39: TDateTimeField;
    Table1BDEDesigner: TStringField;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label8: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SpeedButton2: TSpeedButton;
    Label6: TLabel;
    SpeedButton3: TSpeedButton;
    Edit5: TEdit;
    Edit4: TEdit;
    Edit3: TEdit;
    Edit2: TEdit;
    Edit1: TEdit;
    DBEdit6: TDBEdit;
    DateTimePicker1: TDateTimePicker;
    DBRadioGroup1: TDBRadioGroup;
    GroupBox2: TGroupBox;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    DBCheckBox11: TDBCheckBox;
    DBCheckBox12: TDBCheckBox;
    DBCheckBox13: TDBCheckBox;
    DBCheckBox14: TDBCheckBox;
    DBCheckBox15: TDBCheckBox;
    DBCheckBox16: TDBCheckBox;
    DBCheckBox17: TDBCheckBox;
    DBCheckBox18: TDBCheckBox;
    DBCheckBox19: TDBCheckBox;
    DBCheckBox20: TDBCheckBox;
    DBCheckBox21: TDBCheckBox;
    DBCheckBox22: TDBCheckBox;
    DBCheckBox23: TDBCheckBox;
    DBCheckBox24: TDBCheckBox;
    DBCheckBox25: TDBCheckBox;
    DBCheckBox26: TDBCheckBox;
    DBCheckBox27: TDBCheckBox;
    DBCheckBox28: TDBCheckBox;
    DBCheckBox29: TDBCheckBox;
    DBCheckBox30: TDBCheckBox;
    DBCheckBox31: TDBCheckBox;
    DBCheckBox32: TDBCheckBox;
    DBCheckBox33: TDBCheckBox;
    DBCheckBox34: TDBCheckBox;
    DBCheckBox35: TDBCheckBox;
    DBCheckBox36: TDBCheckBox;
    DBCheckBox37: TDBCheckBox;
    DBCheckBox38: TDBCheckBox;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Panel3: TPanel;
    DBNavigator3: TDBNavigator;
    Label10: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label11: TLabel;
    Edit6: TEdit;
    BitBtn5: TBitBtn;
    DBGridEh1: TDBGridEh;
    DataSource3: TDataSource;
    Query1: TQuery;
    frxDesigner1: TfrxDesigner;
    frxDBDataset1: TfrxDBDataset;
    frxReport1: TfrxReport;
    frxCheckBoxObject1: TfrxCheckBoxObject;
    procedure DateTimePicker1Change(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Table2BeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure Table2AfterInsert(DataSet: TDataSet);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit4Exit(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Edit5Exit(Sender: TObject);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Table2AfterScroll(DataSet: TDataSet);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frxReport1ProgressStart(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer);
    procedure frxReport1GetValue(const VarName: String;
      var Value: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  lkcycj: Tlkcycj;
  //comitem_clsname:string;

implementation

uses pub_search_u, public_var;

{$R *.dfm}

procedure Tlkcycj.DateTimePicker1Change(Sender: TObject);
begin
    dbedit6.Text:=datetostr(datetimepicker1.date);
end;

procedure Tlkcycj.Table2BeforePost(DataSet: TDataSet);
begin
  with table2 do
  begin
    FieldValues['ѧ��']:=table1.FieldValues['ѧ��'];
    FieldValues['���س���']:=DBCheckBox1.Checked;
    FieldValues['�������30CM']:=DBCheckBox2.Checked;
    FieldValues['�ܷ���']:=DBCheckBox3.Checked;
    FieldValues['˫���Ѱ�']:=DBCheckBox4.Checked;
    FieldValues['��ͷ����']:=DBCheckBox5.Checked;
    FieldValues['�յ�����']:=DBCheckBox6.Checked;
    FieldValues['�Ҵ�']:=DBCheckBox7.Checked;
    FieldValues['Ϩ��']:=DBCheckBox8.Checked;
    FieldValues['���']:=DBCheckBox9.Checked;
    FieldValues['Э����']:=DBCheckBox10.Checked;
    FieldValues['����']:=DBCheckBox11.Checked;
    FieldValues['��������']:=DBCheckBox12.Checked;
    FieldValues['��������']:=DBCheckBox13.Checked;
    FieldValues['ǿ�г���']:=DBCheckBox14.Checked;
    FieldValues['������']:=DBCheckBox15.Checked;
    FieldValues['����λ�øо���']:=DBCheckBox16.Checked;
    FieldValues['������ɲ']:=DBCheckBox17.Checked;
    FieldValues['������ɲ']:=DBCheckBox18.Checked;
    FieldValues['������Ǳ�']:=DBCheckBox19.Checked;
    FieldValues['�ƶ���ƽ˳']:=DBCheckBox20.Checked;
    FieldValues['����ʹ��ת���']:=DBCheckBox21.Checked;
    FieldValues['����ʹ�ö��������']:=DBCheckBox22.Checked;
    FieldValues['�����Ź���']:=DBCheckBox23.Checked;
    FieldValues['���ֳ���']:=DBCheckBox24.Checked;
    FieldValues['����ͣ������']:=DBCheckBox25.Checked;
    FieldValues['ͣ��������������50CM']:=DBCheckBox26.Checked;
    FieldValues['ͣ�����ұ��ߴ���30CM']:=DBCheckBox27.Checked;
    FieldValues['��ϵ���մ�']:=DBCheckBox28.Checked;
    FieldValues['�������ų��ٵ���20KM']:=DBCheckBox29.Checked;
    FieldValues['���ײ�����ɼӼ���']:=DBCheckBox30.Checked;
    FieldValues['������ʻ']:=DBCheckBox31.Checked;
    FieldValues['Υ��·�ڹ涨']:=DBCheckBox32.Checked;
    FieldValues['�����������г�']:=DBCheckBox33.Checked;
    FieldValues['�ӵ�������']:=DBCheckBox34.Checked;
    FieldValues['����������']:=DBCheckBox35.Checked;
    FieldValues['����ʱ�����СǷ׼']:=DBCheckBox36.Checked;
    FieldValues['�𲽴ܶ�']:=DBCheckBox37.Checked;
    FieldValues['���ܸ���Ŀ������Ӧ����']:=DBCheckBox38.Checked;
  end;
end;

procedure Tlkcycj.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    query1.Close;
    lkcycj.Destroy;
end;

procedure Tlkcycj.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure Tlkcycj.Table2AfterInsert(DataSet: TDataSet);
var
  i:integer;
begin
  dbedit7.Text:=''; //������
  dbedit8.Text:=datetostr(date);
  //��ʼ��editΪ��
  for i:=0 to groupbox1.ControlCount-1 do
    if (groupbox1.Controls[i] is TEdit) then
      (groupbox1.controls[i] as TEdit).Text:='';

  //��ʼ��DBCheckBoxΪ'false'
  for i:=0 to groupbox2.ControlCount-1 do
    if  (groupbox2.Controls[i] is TDBCheckBox) then
      (groupbox2.Controls[i] as TDBCheckBox).Checked:=false;
end;

procedure Tlkcycj.Edit1Exit(Sender: TObject);
begin
with table1 do
 begin
    if (edit1.Text<>'') and (locate('����',edit1.Text,[loCaseInsensitive])) then
     begin
         edit1.Text:=fieldbyname('����').AsString;
         edit2.Text:=fieldbyname('�Ա�').AsString;
         edit3.Text:=fieldbyname('ѧϰ����').AsString;
         edit4.Text:=fieldbyname('���֤��').AsString;
         edit5.Text:=fieldbyname('׼��֤���').AsString;
         exit;
     end;
    if (edit1.Text<>'') and (not locate('����',edit1.Text,[locaseinsensitive])) then
    begin
    MessageDlg('û�д��ˣ�', mtWarning, [mbOk], 0);
    exit;
    end;
   end;
end;

procedure Tlkcycj.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
   if key=#13 then
      dbradiogroup1.SetFocus
   else
      if table2.state<>dsedit then table2.Edit;
end;

procedure Tlkcycj.Edit4Exit(Sender: TObject);
begin
with table1 do
 begin
    if (edit4.Text<>'') and (locate('���֤��',edit4.Text,[loCaseInsensitive])) then
     begin
         edit1.Text:=fieldbyname('����').AsString;
         edit2.Text:=fieldbyname('�Ա�').AsString;
         edit3.Text:=fieldbyname('ѧϰ����').AsString;
         edit4.Text:=fieldbyname('���֤��').AsString;
         edit5.Text:=fieldbyname('׼��֤���').AsString;
         exit;
     end;
    if (edit4.Text<>'') and (not locate('���֤��',edit4.Text,[locaseinsensitive])) then
    begin
    MessageDlg('�޴˼�¼��', mtWarning, [mbOk], 0);
    exit;
    end;
   end;
end;

procedure Tlkcycj.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
   if key=#13 then
      dbradiogroup1.SetFocus
   else
      if table2.state<>dsedit then table2.Edit;
end;

procedure Tlkcycj.Edit5Exit(Sender: TObject);
begin
with table1 do
 begin
    if (edit5.Text<>'') and (locate('׼��֤���',edit5.Text,[loCaseInsensitive])) then
     begin
         edit1.Text:=fieldbyname('����').AsString;
         edit2.Text:=fieldbyname('�Ա�').AsString;
         edit3.Text:=fieldbyname('ѧϰ����').AsString;
         edit4.Text:=fieldbyname('���֤��').AsString;
         edit5.Text:=fieldbyname('׼��֤���').AsString;
         exit;
     end;
    if (edit5.Text<>'') and (not locate('׼��֤���',edit5.Text,[locaseinsensitive])) then
    begin
    MessageDlg('�޴˼�¼��', mtWarning, [mbOk], 0);
    exit;
    end;
   end;
end;

procedure Tlkcycj.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
   if key=#13 then
      dbradiogroup1.SetFocus
   else
      if table2.state<>dsedit then table2.Edit;
end;

procedure Tlkcycj.SpeedButton1Click(Sender: TObject);
var
  mysqlstr:string;
  search_tmpstr:variant;
begin
  search_tmpstr:=Edit1.Text;
  pub_search:=Tpub_search.Create(self);
  mysqlstr:='select ѧ��,����,�Ա�,ѧϰ���� as ֤��,���֤��,׼��֤��� from student';
  pub_search.myselect(mysqlstr,'ѧԱ����');
  pub_search.ShowModal;
  if (search_tmpstr<>myarr[1]) and (myarr[1]<>'') then
  begin
    Edit1.Text:=myarr[1];
    table2.Edit;
  end;
  //��������Ϊ�н���
  if not Edit1.Focused then edit1.SetFocus;
    dbradiogroup1.SetFocus; //������һ�ؼ�����
end;

procedure Tlkcycj.SpeedButton2Click(Sender: TObject);
var
  mysqlstr:string;
  search_tmpstr:variant;
begin
  search_tmpstr:=Edit4.Text;
  pub_search:=Tpub_search.Create(self);
  mysqlstr:='select ѧ��,����,�Ա�,ѧϰ���� as ֤��,���֤��,׼��֤��� from student';
  pub_search.myselect(mysqlstr,'ѧԱ����');
  pub_search.ShowModal;
  if (search_tmpstr<>myarr[1]) and (myarr[1]<>'') then
  begin
    Edit4.Text:=myarr[4];
    table2.Edit;
  end;
  //��������Ϊ�н���
  if not Edit4.Focused then edit4.SetFocus;
    dbradiogroup1.SetFocus;  //������һ�ؼ�����
end;

procedure Tlkcycj.SpeedButton3Click(Sender: TObject);
var
  mysqlstr:string;
  search_tmpstr:variant;
begin
  search_tmpstr:=Edit5.Text;
  pub_search:=Tpub_search.Create(self);
  mysqlstr:='select ѧ��,����,�Ա�,ѧϰ���� as ֤��,���֤��,׼��֤��� from student';
  pub_search.myselect(mysqlstr,'ѧԱ����');
  pub_search.ShowModal;
  if (search_tmpstr<>myarr[1]) and (myarr[1]<>'') then
  begin
    Edit5.Text:=myarr[5];
    table2.Edit;
  end;
  //��������Ϊ�н���
  if not Edit5.Focused then edit5.SetFocus;
    dbradiogroup1.SetFocus;  //������һ�ؼ�����
end;

procedure Tlkcycj.Table2AfterScroll(DataSet: TDataSet);
begin
  if table2.state<>dsinsert then
  begin
    with table1 do
    begin
      Locate('ѧ��',table2.fieldbyname('ѧ��').AsString,[]);
      edit1.Text:=fieldbyname('����').AsString;
      edit2.Text:=fieldbyname('�Ա�').AsString;
      edit3.Text:=fieldbyname('ѧϰ����').AsString;
      edit4.Text:=fieldbyname('���֤��').AsString;
      edit5.Text:=fieldbyname('׼��֤���').AsString;
    end;
  end;
end;

procedure Tlkcycj.FormCreate(Sender: TObject);
var
  sqlstr:string;
  wherestr:string;
  i:integer;
begin
  //��ʼ��combobox_items
  with query1 do
  begin
    close;
    sql.Clear;
    sqlstr:='SELECT a.����, a.�Ա�, a.���֤��, a.ѧϰ����, a.׼��֤���, b.* FROM Student a, ·������ɼ� b';
    wherestr:='WHERE  a.ѧ�� = b.ѧ�� ';
    sql.Add(sqlstr);
    sql.Add(wherestr);
    open;
    for i:=0 to FieldCount-1 do
      combobox1.Items.Add(Fields[i].FieldName);
    combobox1.ItemIndex:=0;
    close;
  end;
end;

procedure Tlkcycj.BitBtn5Click(Sender: TObject);
var
  comitem_clsname:string;
  wherestr:string;
begin
  query1.Open;
  comitem_clsname:=query1.FieldByName(combobox1.Text).ClassName;
  with query1 do
  begin
    close;
    sql.Clear;
    wherestr:='WHERE  a.ѧ�� = b.ѧ�� ';
    sql.Add('SELECT a.����, a.�Ա�, a.���֤��, a.ѧϰ����, a.׼��֤���, case b.�ɼ� when True then '+'����'+' else '+'������'+' end  as �ɼ�,b.����ʱ��, b.������, b.��������,');
    sql.add('b.���س���, b.�������30CM, b.�ܷ���, b.˫���Ѱ�, b.��ͷ����, b.�յ�����, b.�Ҵ�, b.Ϩ��, b.���, Э����, b.����, b.��������, b.��������, b.ǿ�г���, b.������, b.����λ�øо���, b.������ɲ, b.������ɲ, b.������Ǳ�, b.�ƶ���ƽ˳, ');
    sql.add('b.����ʹ��ת���, b.����ʹ�ö��������,b.�����Ź���, b.���ֳ���, b.����ͣ������, b.ͣ��������������50CM, b.ͣ�����ұ��ߴ���30CM, b.��ϵ���մ�, b.�������ų��ٵ���20KM, b.���ײ�����ɼӼ���, b.������ʻ, ');
    sql.Add('b.Υ��·�ڹ涨, b.�����������г�, b.�ӵ�������, b.����������, b.����ʱ�����СǷ׼, b.�𲽴ܶ�, b.���ܸ���Ŀ������Ӧ���� from Student a,·������ɼ� b');
    sql.Add(wherestr);
    if edit6.text<>'' then
    begin
      showmessage(comitem_clsname);
      if comitem_clsname='TStringField' then
        wherestr:='and '+combobox1.Text+' '+combobox2.Text+' '+''''+edit6.Text+'''';
      if comitem_clsname='TDateTimeField' then
        wherestr:='and b.'+combobox1.Text+' '+combobox2.Text+' #'+edit6.Text+'#';
      if (comitem_clsname='TIntegerField') or (comitem_clsname='TBooleanField') then
        wherestr:='and '+combobox1.Text+' '+combobox2.Text+' '+edit6.Text;
      sql.add(wherestr);
    end;
    if not Prepared then Prepare;
    open;
  end;
  if query1.RecordCount=0 then
    showmessage('�޼�¼')
  else
    dbgrideh1.datasource:=datasource3;
end;



procedure Tlkcycj.frxReport1ProgressStart(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
  if frxdbDataSet1.Value['�ɼ�'] then
    //frxreport1.page.comco['�ɼ�']:='����'
  else
    //frVariables['�ɼ�']:='������';
    
end;

procedure Tlkcycj.frxReport1GetValue(const VarName: String;
  var Value: Variant);
begin
  {
  if VarName='Memo9' then
    if query1.FieldByName('�ɼ�').AsBoolean then
      Value:='����'
    else
      Value:='������';
   }
end;

end.
