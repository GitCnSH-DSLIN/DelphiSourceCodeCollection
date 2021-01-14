unit DetailAccountForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Grids, DBGrids, ExtCtrls, StdCtrls,
  Buttons, DB, ADODB, DBCtrls, Mask;

type
  TDetailAccount = class(TForm)
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Label4: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Button1: TButton;
    Button2: TButton;
    Label5: TLabel;
    BitBtn2: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);



    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);


    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    
    
  private
    { Private declarations }
  public
    { Public declarations }
  //����б������Ŀ�ĺ���
  procedure setlist();
  end;

var
  DetailAccount: TDetailAccount;

implementation

{$R *.dfm}

procedure TDetailAccount.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;


procedure TDetailAccount.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  //��ʾ��������
  label2.Caption:=inttostr(adoquery1.RecordCount);
  //�������ݱ���
  dbgrid1.Columns[0].Width:=80;
  dbgrid1.Columns[1].Width:=64;
  dbgrid1.Columns[2].Width:=64;
  dbgrid1.Columns[3].Width:=64;
  dbgrid1.Columns[4].Width:=64;
  dbgrid1.Columns[5].Width:=64;
  dbgrid1.Columns[6].Width:=64;
  dbgrid1.Columns[7].Width:=64;
  dbgrid1.Columns[8].Width:=64;
end;


//---------------�׼�¼----------------
procedure TDetailAccount.ToolButton1Click(Sender: TObject);
begin
 datasource1.DataSet.First;
end;

//---------------�ϼ�¼----------------
procedure TDetailAccount.ToolButton2Click(Sender: TObject);
begin
 datasource1.DataSet.Prior;
end;

//---------------�¼�¼----------------
procedure TDetailAccount.ToolButton3Click(Sender: TObject);
begin
 datasource1.DataSet.Next;
end;

//---------------β��¼----------------
procedure TDetailAccount.ToolButton4Click(Sender: TObject);
begin
 datasource1.DataSet.Last;
end;

procedure TDetailAccount.ToolButton13Click(Sender: TObject);
begin
close;
end;

//----------��ѯ���ݲ���ʾ-------------
procedure TDetailAccount.BitBtn1Click(Sender: TObject);
begin
adoquery1.Close;
adoquery1.SQL.Clear;
adoquery1.SQL.Add('select a.*,b.��Ŀ���� from ������ϸ�ʲ� a,��Ŀ�� b where (a.��Ŀ���� like ''%'+edit1.Text+'%'')and');
adoquery1.SQL.Add('(a.��Ŀ����=b.��Ŀ����)');
adoquery1.Open;
//������õ����ݹ����������������б�
datasource1.DataSet.Filtered:=false;
setlist();

end;



procedure TDetailAccount.FormShow(Sender: TObject);

begin
  setlist();
end;

//-------------�����ݼ������еĿ�Ŀ������ӵ��б���-------------
procedure TDetailAccount.setlist;
var
name:string;
begin
listbox1.Clear;
listbox2.Clear;
 while not adoquery1.Eof do
  begin
    name:=adoquery1.fieldbyname('��Ŀ����').AsString;
    //����б���û�и���������ӣ���������������
    if listbox1.Items.IndexOf(name)=-1 then
     listbox1.Items.Insert(listbox1.Items.Count,name);
    adoquery1.Next;
  end;
end;

//ѡ��һ����Ŀ���Ʋ���������ӵ��ұߵ��б���
procedure TDetailAccount.ListBox1Click(Sender: TObject);
begin
if listbox1.Items.Count<>0 then
button1.Enabled:=true;
end;

//ѡ��һ����Ŀ���ƣ���������ұߵ��б���ɾ��
procedure TDetailAccount.ListBox2Click(Sender: TObject);
begin
if listbox2.Items.Count<>0 then
button2.Enabled:=true;
end;

//-----���ұߵ��б������ĳһ��----------
procedure TDetailAccount.Button1Click(Sender: TObject);
var
name:string;
begin
name:=listbox1.Items.Strings[listbox1.ItemIndex];
//���ұߵ��б�򲻴��ڸ��������������
if listbox2.Items.IndexOf(name)=-1 then
listbox2.Items.Insert(listbox2.Items.Count,name);
//�����ڱ��и���ѡ����������ʾ
bitbtn2.Enabled:=true;
end;

//-----���ұߵ��б���ɾ��ĳһ��----------
procedure TDetailAccount.Button2Click(Sender: TObject);
begin
//����Ϊ�գ�����Խ���������б���ɾ��
if listbox2.Items.Count<>0 then
listbox2.Items.Delete(listbox2.ItemIndex);
//���ұ��б��ѿգ��򽫰�ť���
if listbox2.Items.Count=0 then
begin
button2.Enabled:=false;
bitbtn2.Enabled:=false;
end;
end;

//----------����ѡ�������ʾ����-----------
procedure TDetailAccount.BitBtn2Click(Sender: TObject);
var
filstr:string;
i:integer;
begin
filstr:='';
//�����б��������������ݼ��Ĺ��������
for i:=0 to listbox2.Count-1 do
 begin
   filstr:=filstr+'��Ŀ����='''+listbox2.Items.Strings[i]+'''';
   if i<>listbox2.Count-1 then
   filstr:=filstr+' OR ';
 end;
datasource1.DataSet.Filter:=filstr;
datasource1.DataSet.Filtered:=true;
end;



end.




