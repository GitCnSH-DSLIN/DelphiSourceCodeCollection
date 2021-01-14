unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, ADODB, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGrid, cxContainer, cxListBox, cxDBEdit,
  StdCtrls, DBCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  Unit8, cxDBLookupEdit, cxDBLookupComboBox, Buttons;

type
  TForm2 = class(TForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    ADOTable1: TADOTable;
    DataSource1: TDataSource;
    cxGrid1DBTableView1DBColumn: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn1: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn3: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn4: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn6: TcxGridDBColumn;
    ADOTable2: TADOTable;
    DataSource2: TDataSource;
    DBLookupListBox1: TDBLookupListBox;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    DBLookupListBox2: TDBLookupListBox;
    Label3: TLabel;
    Edit1: TEdit;
    ADOTable3: TADOTable;
    DataSource3: TDataSource;
    Label4: TLabel;
    ADOConnection1: TADOConnection;
    BitBtn7: TBitBtn;
    procedure ADOTable1BeforePost(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure DBLookupListBox2DblClick(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Math;

{$R *.dfm}

procedure TForm2.ADOTable1BeforePost(DataSet: TDataSet);
begin
if DataSet.FieldByName('ʱ��').IsNull then
begin
ShowMessage('��ѡ��ʱ�䣬�˼�¼��ʱ�䲻��Ϊ��ֵ��');
Abort;
end;
if DataSet.FieldByName('����').IsNull then
begin
ShowMessage('����������ֵ���˼�¼����������Ϊ��ֵ��');
Abort;
end;
if DataSet.FieldByName('����').IsNull then
begin
ShowMessage('��ѡ��������ۣ��˼�¼�Ĳ������۲���Ϊ��ֵ��');
Abort;
end;
DataSet.FieldByName('���').value:=
DataSet.FieldByName('����').value*
DataSet.FieldByName('����').value;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
ADOTable2.Active:=False;
ADOTable2.Close;
ADOTable2.Active:=True;
ADOTable2.Open;
ADOTable1.Active:=False;
ADOTable1.Close;
ADOTable1.Active:=True;
ADOTable1.Open;
ADOTable1.Sort:='ʱ��';
ADOTable1.First;
  repeat
ADOTable1.Edit;
ADOTable1.FieldByName('���').value:=
ADOTable1.FieldByName('����').value*
ADOTable1.FieldByName('����').value;
ADOTable1.Post;
ADOTable1.Next;
  until ADOTable1.Eof=True;
ADOTable1.UpdateCursorPos;
ADOTable1.Close;
ADOTable1.Open;
ShowMessage('���ֵ������� ��');
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
ADOTable1.Append;
end;

procedure TForm2.BitBtn4Click(Sender: TObject);
begin
ADOTable1.Cancel;
ADOTable1.UpdateCursorPos;
ADOTable1.Close;
ADOTable1.Open;
ADOTable1.UpdateCursorPos;
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
ADOTable1.Edit;
ADOTable1.Post;
ADOTable1.refresh;
ADOTable1.UpdateCursorPos;
ShowMessage('��¼����ɹ���');
end;

procedure TForm2.BitBtn5Click(Sender: TObject);
begin
if messagebox(self.Handle ,'ȷ��ɾ��������¼��','ϵͳ��ʾ ��',mb_yesno)=idyes then
  begin
     ADOTable1.delete ;
  end
else   ;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
ADOConnection1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='
                      + ExtractFilePath(Application.ExeName)
                      + 'db1.mdb;Persist Security Info=False';
ADOTable1.TableName:='��1';
ADOTable1.Active:=True;
ADOTable2.TableName:='csbh';
ADOTable2.Active:=True;
ADOTable3.TableName:='����';
ADOTable3.Active:=True;
ADOTable2.Active:=False;
ADOTable2.Close;
ADOTable2.Active:=True;
ADOTable2.Open;
ADOTable1.Active:=False;
ADOTable1.Close;
ADOTable1.Active:=True;
ADOTable1.Open;
end;

procedure TForm2.Edit1Change(Sender: TObject);

begin

if Not (trim(Edit1.Text) = '') then
begin
  ADOTable3.Filtered:=True;
  ADOTable3.Filter:='[�ٲ���] like ''%'+Edit1.Text+'%''';
end;

end;

procedure TForm2.DBLookupListBox2DblClick(Sender: TObject);
begin
ADOTable1.Edit;
ADOTable1.FieldByName('����').value:=
ADOTable3.FieldByName('��Ʒ����').value;
ADOTable1.FieldByName('����').value:=
ADOTable3.FieldByName('�۸�').value;
end;

procedure TForm2.BitBtn7Click(Sender: TObject);
begin
Form8.ShowModal;
end;

end.
