unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, ADODB, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, StdCtrls, Buttons, Grids, DBGrids,
  cxDropDownEdit, cxContainer, cxTextEdit, cxMaskEdit, cxCalendar,
  cxDBEdit, ComCtrls, RM_Dataset, RM_Common, RM_Class, RM_GridReport;

type
  TForm9 = class(TForm)
    ADOTable1: TADOTable;
    DataSource1: TDataSource;
    BitBtn1: TBitBtn;
    ADOConnection1: TADOConnection;
    ADOTable2: TADOTable;
    ADOTable3: TADOTable;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    DataSource2: TDataSource;
    RMReport1: TRMReport;
    BitBtn3: TBitBtn;
    RMDBDataSet1: TRMDBDataSet;
    cxGrid2: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    ADOTable4: TADOTable;
    cxGridDBTableView1DBColumn: TcxGridDBColumn;
    cxGridDBTableView1DBColumn1: TcxGridDBColumn;
    cxGridDBTableView1DBColumn2: TcxGridDBColumn;
    cxGridDBTableView1DBColumn3: TcxGridDBColumn;
    cxGridDBTableView1DBColumn4: TcxGridDBColumn;
    cxGridDBTableView1DBColumn5: TcxGridDBColumn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    RMDBDataSet2: TRMDBDataSet;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;
  hjsl:Real;
  hjje:Real;
  ljsl:Real;
  ljje:Real;

implementation

{$R *.dfm}

procedure TForm9.FormCreate(Sender: TObject);
begin
ADOConnection1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='
                      + ExtractFilePath(Application.ExeName)
                      + 'db1.mdb;Persist Security Info=False';
ADOTable1.TableName:='rtj';
ADOTable1.Active:=True;
ADOTable2.TableName:='��1';
ADOTable2.Active:=True;
ADOTable3.TableName:='csbh';
ADOTable3.Active:=True;
ADOTable4.TableName:='rtjrq';
ADOTable4.Active:=True;
ADOTable3.Sort:='��ʦ���';
ADOTable3.First;
While not ADOTable3.Eof do
begin
ComboBox1.Items.Add(ADOTable3.FieldByName('��ʦ���').AsString);
ADOTable3.Next;
end;
combobox1.text:=combobox1.items[0];
end;

procedure TForm9.BitBtn1Click(Sender: TObject); //=======================

begin
if DateTimePicker1.Date>datetimePicker2.Date then
    ShowMessage('��ʼ����ѡ�����');

if DateTimePicker1.Date<=datetimePicker2.Date then

///////////////////////////////////////////////////////////////////////////
begin
ADOTable4.Edit;                         //��ʼ�����ѯ��������
ADOTable4.FieldByName('��ʼ����').value:=FormatDateTime('yyyy-mm-dd',
  DateTimePicker1.Date);
ADOTable4.FieldByName('��������').value:=FormatDateTime('yyyy-mm-dd',
  DateTimePicker2.Date);
ADOTable4.post;
ADOTable1.Active:=False;
ADOTable1.Close;
ADOTable1.Active:=True;
ADOTable1.Open;
ADOTable2.Active:=False;
ADOTable2.Close;
ADOTable2.Active:=True;
ADOTable2.Open;
ADOTable3.Active:=False;
ADOTable3.Close;
ADOTable3.Active:=True;
ADOTable3.Open;
ADOTable4.Active:=False;
ADOTable4.Close;
ADOTable4.Active:=True;
ADOTable4.Open;
ADOTable1.first;                        //��ʼ�������
while not ADOTable1.eof do              //ѭ��DELETE
ADOTable1.delete;


                                  //��table1=��ʦ����ʦ���
        ADOTable3.Filtered:=false;         //��table1=��ʦ����ʦ���
  ADOTable3.Filter:=
  '��ʦ���='''+combobox1.text+'''';
  ADOTable3.Filtered:=True;
        ADOTable1.edit;
        ADOTable1.FieldByName('��ʦ���').value:=
        ADOTable3.FieldByName('��ʦ���').value;
        ADOTable1.FieldByName('��ʦ').value:=
        ADOTable3.FieldByName('��ʦ').value;
        ADOTable1.Post;
ADOTable1.Refresh;


    ADOTable2.Filtered:=false;                 //��ʼ��ѯ�������ڵ�����
  ADOTable2.Filter:=
  'ʱ��>='''+FormatDateTime('yyyy-mm-dd',
  DateTimePicker1.Date)+''' and ʱ��<='''+
  FormatDateTime('yyyy-mm-dd',
  DateTimePicker2.Date)+''' and ��ʦ='''+
  ADOTable3.FieldByName('��ʦ').value+'''';
  ADOTable2.Filtered:=True;


    hjsl:=0;
    hjje:=0;
  ADOTable2.First;
while not  ADOTable2.Eof  do                      //��ʼѭ������ֵ���ۼ�
begin
if ADOTable2.FieldByName('���').IsNull then
begin
ShowMessage('���ڡ���������¼�롱�������������¼�����ֵ�������');
Abort;
end;
if ADOTable2.FieldByName('����').IsNull then
begin
ShowMessage('���ڡ���������¼�롱���������¼�ġ�����������Ϊ��ֵ');
Abort;
end;
if ADOTable2.FieldByName('���').value=0 then
begin
ShowMessage('���ڡ���������¼�롱�������������¼�����ֵ�������');
Abort;
end;
if ADOTable2.FieldByName('����').value=0 then
begin
ShowMessage('���ڡ���������¼�롱���������¼�ġ�����������Ϊ��ֵ');
Abort;
end;
hjsl:=hjsl+ADOTable2.FieldByName('����').value;
hjje:=hjje+ADOTable2.FieldByName('���').value;
ADOTable2.Next;
end;
ADOTable1.Edit;                                       //��ʼ��table1=�ϼ�
ADOTable1.FieldByName('�ϼ�����').value:=hjsl;
ADOTable1.FieldByName('�ϼƽ��').value:=hjje;
ADOTable1.Post;
ADOTable1.Refresh;

                                                //��ʼ��ѯ��ʦ���ۼ�
   ADOTable2.Filtered:=false;
  ADOTable2.Filter:=
  '��ʦ='''+ADOTable1.FieldByName('��ʦ').value+'''';
  ADOTable2.Filtered:=True;
    ADOTable2.First;
while  not ADOTable2.Eof       do                //��ʼѭ������ֵ
begin
if ADOTable2.FieldByName('�ۼ�����').IsNull then
begin
ShowMessage('���ڡ�����ҵ��ͳ�ơ�����������ͳ���ۼ����ݣ�');
abort;
end;
if ADOTable2.FieldByName('�ۼƽ��').IsNull then
begin
ShowMessage('���ڡ�����ҵ��ͳ�ơ�����������ͳ���ۼ����ݣ�');
abort;
end;
if ADOTable2.FieldByName('�ۼ�����').value=0 then
begin
ShowMessage('���ڡ�����ҵ��ͳ�ơ�����������ͳ���ۼ����ݣ�');
abort;
end;
if ADOTable2.FieldByName('�ۼƽ��').value=0 then
begin
ShowMessage('���ڡ�����ҵ��ͳ�ơ�����������ͳ���ۼ����ݣ�');
abort;
end;
ADOTable2.Next;
end;
  ADOTable2.Sort:='�ۼƽ��';                    //��ʼ��rable1=�ۼ�
  ADOTable2.Last;
  ADOTable1.Edit;
ADOTable1.FieldByName('�ۼ�����').value:=
ADOTable2.FieldByName('�ۼ�����').value;
ADOTable1.FieldByName('�ۼƽ��').value:=
ADOTable2.FieldByName('�ۼƽ��').value;
ADOTable1.Post;


ADOTable1.Refresh;
ShowMessage('����ͳ�����!');
end;
////////////////////////////////////////////////////////////////////////////////
end;


procedure TForm9.BitBtn3Click(Sender: TObject);
begin
RMReport1.LoadFromFile('Rmf\rtj.rmf');
RMReport1.ShowReport;
end;

procedure TForm9.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
 Key:=#0;
end;

procedure TForm9.BitBtn5Click(Sender: TObject);  //=======================************


begin
if DateTimePicker1.Date>datetimePicker2.Date then
    ShowMessage('��ʼ����ѡ�����');

if DateTimePicker1.Date<=datetimePicker2.Date then

///////////////////////////////////////////////////////////////////////////
begin
///////////////////////////////////////////// //��ʼͳ�����г�ʦ�ۼ�
ADOTable4.Edit;                                                 //��ʼ�����ѯ��������
ADOTable4.FieldByName('��ʼ����').value:=FormatDateTime('yyyy-mm-dd',
  DateTimePicker1.Date);
ADOTable4.FieldByName('��������').value:=FormatDateTime('yyyy-mm-dd',
  DateTimePicker2.Date);
ADOTable4.post;
ADOTable1.Active:=False;
ADOTable1.Close;
ADOTable1.Active:=True;
ADOTable1.Open;
ADOTable2.Active:=False;
ADOTable2.Close;
ADOTable2.Active:=True;
ADOTable2.Open;
ADOTable3.Active:=False;
ADOTable3.Close;
ADOTable3.Active:=True;
ADOTable3.Open;
ADOTable4.Active:=False;
ADOTable4.Close;
ADOTable4.Active:=True;
ADOTable4.Open;
ADOTable1.first;                        //��ʼ�������
while not ADOTable1.eof do              //ѭ��DELETE
ADOTable1.Delete;
  ///////////////////////////////////////////////////////
                 //��table1=��ʦ����ʦ���
ADOTable1.Refresh;
ADOTable3.Filtered:=false;          //�ر�ɸѡ����Ȼֻ��һ����¼
ADOTable3.First;
                   repeat
        ADOTable1.Append;                            //ѭ�����ӳ�ʦ��ż�¼
        ADOTable1.FieldByName('��ʦ���').value:=
        ADOTable3.FieldByName('��ʦ���').value;
        ADOTable1.FieldByName('��ʦ').value:=
        ADOTable3.FieldByName('��ʦ').value;
       ADOTable3.Next;
        until ADOTable3.Eof=True;
        //ADOTable1.Post;
ADOTable1.Refresh;
ADOTable1.Sort:='��ʦ���';
ADOTable1.First;

////////////////////////////////////////////////////////////////////////////////////
while not ADOTable1.Eof=True do
begin
    ADOTable2.Filtered:=false;                 //��ʼ��ѯ�������ڵ�����
  ADOTable2.Filter:=
  'ʱ��>='''+FormatDateTime('yyyy-mm-dd',
  DateTimePicker1.Date)+''' and ʱ��<='''+
  FormatDateTime('yyyy-mm-dd',
  DateTimePicker2.Date)+''' and ��ʦ='''+
  ADOTable1.FieldByName('��ʦ').value+'''';
  ADOTable2.Filtered:=True;
///////////////////////////////////////////////////
hjsl:=0;
hjje:=0;
  ADOTable2.First;

while  not ADOTable2.Eof       do                //��ʼѭ������ֵ���ۼ�
begin
if ADOTable2.FieldByName('���').IsNull then
begin
ShowMessage('���ڡ���������¼�롱�������������¼�����ֵ�������');
Abort;
end;
if ADOTable2.FieldByName('����').IsNull then
begin
ShowMessage('���ڡ���������¼�롱���������¼�ġ�����������Ϊ��ֵ');
Abort;
end;
if ADOTable2.FieldByName('���').value=0 then
begin
ShowMessage('���ڡ���������¼�롱�������������¼�����ֵ�������');
Abort;
end;
if ADOTable2.FieldByName('����').value=0 then
begin
ShowMessage('���ڡ���������¼�롱���������¼�ġ�����������Ϊ��ֵ');
Abort;
end;
hjsl:=hjsl+ADOTable2.FieldByName('����').value;
hjje:=hjje+ADOTable2.FieldByName('���').value;
ADOTable2.Next;
end;
ADOTable1.Edit;                                       //��ʼѭ����table1=�ϼ�
ADOTable1.FieldByName('�ϼ�����').value:=hjsl;
ADOTable1.FieldByName('�ϼƽ��').value:=hjje;


 ADOTable2.Filtered:=false;                         //��ʼ��ѯ�ۼ�����
  ADOTable2.Filter:=
  '��ʦ='''+ADOTable1.FieldByName('��ʦ').value+'''';
  ADOTable2.Filtered:=True;
  ADOTable2.First;
while  not ADOTable2.Eof       do                //��ʼѭ������ֵ
begin
if ADOTable2.FieldByName('�ۼ�����').IsNull then
begin
ShowMessage('���ڡ�����ҵ��ͳ�ơ�����������ͳ���ۼ����ݣ�');
Abort;
end;
if ADOTable2.FieldByName('�ۼƽ��').IsNull then
begin
ShowMessage('���ڡ�����ҵ��ͳ�ơ�����������ͳ���ۼ����ݣ�');
Abort;
end;
if ADOTable2.FieldByName('�ۼ�����').value=0 then
begin
ShowMessage('���ڡ�����ҵ��ͳ�ơ�����������ͳ���ۼ����ݣ�');
abort;
end;
if ADOTable2.FieldByName('�ۼƽ��').value=0 then
begin
ShowMessage('���ڡ�����ҵ��ͳ�ơ�����������ͳ���ۼ����ݣ�');
abort;
end;
ADOTable2.Next;
end;
  ADOTable2.Sort:='�ۼƽ��';                    //��ʼѭ����ado1=�ۼ�
  ADOTable2.Last;
  ADOTable1.Edit;
ADOTable1.FieldByName('�ۼ�����').value:=
ADOTable2.FieldByName('�ۼ�����').value;
ADOTable1.FieldByName('�ۼƽ��').value:=
ADOTable2.FieldByName('�ۼƽ��').value;
ADOTable1.Next;
end;             //ÿ����ʦ���ݴ������

ADOTable1.Prior;                                     //���¸�λ��ˢ��ado1����
ADOTable1.Refresh;
ADOTable1.Sort:='��ʦ���';
ADOTable1.First;


hjsl:=0;
hjje:=0;
ljsl:=0;
ljje:=0;
         repeat                                  //��ʼѭ���ۼ�
hjsl:=hjsl+ADOTable1.FieldByName('�ϼ�����').value;
hjje:=hjje+ADOTable1.FieldByName('�ϼƽ��').value;
ljsl:=ljsl+ADOTable1.FieldByName('�ۼ�����').value;
ljje:=ljje+ADOTable1.FieldByName('�ۼƽ��').value;
ADOTable1.Next;
         until ADOTable1.Eof=True;
ADOTable1.Append;
ADOTable1.FieldByName('��ʦ���').value:='�ܺϼ�';          //��ʼ��table1�ܺϼ�
ADOTable1.FieldByName('�ϼ�����').value:=hjsl;
ADOTable1.FieldByName('�ϼƽ��').value:=hjje;
ADOTable1.FieldByName('�ۼ�����').value:=ljsl;
ADOTable1.FieldByName('�ۼƽ��').value:=ljje;

ADOTable1.Post;                                     //���¸�λ��ˢ��ado1����
ADOTable1.Refresh;
ADOTable1.Active:=False;
ADOTable1.Close;
ADOTable1.Active:=True;
ADOTable1.Open;
ADOTable1.Refresh;
ADOTable2.Active:=False;
ADOTable2.Close;
ADOTable2.Active:=True;
ADOTable2.Open;
ADOTable2.Refresh;
ADOTable3.Active:=False;
ADOTable3.Close;
ADOTable3.Active:=True;
ADOTable3.Open;
ADOTable3.Refresh;
ADOTable4.Active:=False;
ADOTable4.Close;
ADOTable4.Active:=True;
ADOTable4.Open;
ADOTable4.Refresh;

ShowMessage('����ͳ�����!');




//////////////////////////////////////////////////////////////////////




end;



end;

end.
