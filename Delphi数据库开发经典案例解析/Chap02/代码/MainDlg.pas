unit MainDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, DB, ADODB, DBCtrls, Grids, DBGrids, Mask;

type
  Tmain = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TreeView1: TTreeView;
    ADOQuery1: TADOQuery;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    TabSheet4: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit4: TEdit;
    DBGrid1: TDBGrid;
    ADOQuery2: TADOQuery;
    DBNavigator1: TDBNavigator;
    DataSource1: TDataSource;
    PageControl2: TPageControl;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    DBGrid2: TDBGrid;
    DBNavigator2: TDBNavigator;
    ADOTable1: TADOTable;
    DataSource2: TDataSource;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ComboBox1: TComboBox;
    Label9: TLabel;
    Edit8: TEdit;
    Label10: TLabel;
    Edit9: TEdit;
    Label11: TLabel;
    Edit10: TEdit;
    Label12: TLabel;
    ComboBox2: TComboBox;
    Label13: TLabel;
    Edit11: TEdit;
    Edit12: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    Edit13: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    Edit14: TEdit;
    ComboBox3: TComboBox;
    Label18: TLabel;
    Edit15: TEdit;
    Label19: TLabel;
    Edit16: TEdit;
    Label20: TLabel;
    Edit17: TEdit;
    Label21: TLabel;
    Edit18: TEdit;
    Label22: TLabel;
    Edit19: TEdit;
    Label23: TLabel;
    Edit20: TEdit;
    Label24: TLabel;
    Edit21: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    DBGrid3: TDBGrid;
    Panel3: TPanel;
    DataSource3: TDataSource;
    ADOQuery3: TADOQuery;
    Edit22: TEdit;
    Label25: TLabel;
    Label26: TLabel;
    Edit23: TEdit;
    Label27: TLabel;
    Edit24: TEdit;
    Label28: TLabel;
    ComboBox4: TComboBox;
    Label29: TLabel;
    ComboBox5: TComboBox;
    Button4: TButton;
    PageControl3: TPageControl;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    ADOTable2: TADOTable;
    DataSource4: TDataSource;
    DBGrid4: TDBGrid;
    DBNavigator3: TDBNavigator;
    DBGrid5: TDBGrid;
    Panel4: TPanel;
    Edit25: TEdit;
    Label30: TLabel;
    Label31: TLabel;
    Edit26: TEdit;
    Button5: TButton;
    DBNavigator4: TDBNavigator;
    Panel7: TPanel;
    Edit31: TEdit;
    Label36: TLabel;
    Button8: TButton;
    DBGrid8: TDBGrid;
    ADOQuery4: TADOQuery;
    DataSource5: TDataSource;
    DBEdit1: TDBEdit;
    Label37: TLabel;
    Label38: TLabel;
    DBEdit2: TDBEdit;
    Label39: TLabel;
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
    DBEdit15: TDBEdit;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit21: TDBEdit;
    Label58: TLabel;
    ADOCommand1: TADOCommand;
    Panel8: TPanel;
    Edit32: TEdit;
    Button9: TButton;
    Label59: TLabel;
    Label60: TLabel;
    Edit33: TEdit;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    DataSource6: TDataSource;
    DataSource7: TDataSource;
    DBNavigator5: TDBNavigator;
    Panel10: TPanel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    DBEdit29: TDBEdit;
    DBEdit30: TDBEdit;
    DBEdit31: TDBEdit;
    DBEdit32: TDBEdit;
    DBEdit33: TDBEdit;
    DBEdit34: TDBEdit;
    DBEdit35: TDBEdit;
    ADOTable3: TADOTable;
    ADOTable4: TADOTable;
    Panel5: TPanel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    DBEdit36: TDBEdit;
    DBEdit37: TDBEdit;
    DBEdit38: TDBEdit;
    DBEdit39: TDBEdit;
    DBEdit40: TDBEdit;
    DBEdit41: TDBEdit;
    DBEdit42: TDBEdit;
    DBNavigator6: TDBNavigator;
    Label61: TLabel;
    Edit27: TEdit;
    Button6: TButton;


    procedure TreeView1Click(Sender: TObject);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);

    

    procedure TabSheet2Show(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure TabSheet9Show(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure TabSheet7Show(Sender: TObject);
    




    
  private
    { Private declarations }
  public

    { Public declarations }
  end;
type
 Ttable=array[1..200,1..3] of string;
 //����һ��200��3�е��ַ������飬��������ʾ���οؼ�ʱ����֯����������ж����Ļ�����ŵ���Ϣ�Թ���ʾ
var
  main: Tmain;
  mytable:Ttable;
 //��ʼ��һ������
implementation

{$R *.dfm}

//--------------------------------------------------------------------
//----------------�������ü����빦�ܵ�ʵ��----------------------------
//---------------------------------------------------------------------
procedure Tmain.Button12Click(Sender: TObject);
//�������ͼ����ʾ
var
pnode:TTreeNode;
i:integer;
//pnodeΪ���ڵ����͵ı���
scode,scodel,sname:string;
ItemLevel,ParentIndex:integer;

begin
adoquery1.Open;
i:=1;
while not adoquery1.Eof do
begin
scode:=adoquery1.FieldByName('����').AsString;
scodel:=adoquery1.FieldByName('��λ���').AsString;
sname:=adoquery1.FieldByName('���').AsString;
ItemLevel:=adoquery1.FieldByName('ItemLevel').AsInteger;
ParentIndex:=adoquery1.FieldByName('ParentIndex').AsInteger;
//�����е����ݰ����ݴ���ľ���˳��AbsIndex��������ȡ��
//������˳��������ݿ���Ϊ��ʵ��������ṩ��෽��
mytable[i,1]:=scode;
mytable[i,2]:=scodel;
mytable[i,3]:=sname;
i:=i+1;
//�������������λ��ź����ǰ�涨��õ��ַ���������
if (ItemLevel=0) then
begin
treeview1.Items.AddFirst(nil,sname);
//����ǵ�һ���ڵ㣬��ô��û�и��ڵ㣬�丸�ڵ���nil���գ���������һ���ڵ������
end
else
begin
pnode:=treeview1.Items.Item[ParentIndex];
treeview1.Items.AddChild(pnode,sname);
//���ݼ�¼�ĸ��ڵ����ԣ�����Ϊ���м�¼��������ͼ
end;
adoquery1.Next;
end;


end;



procedure Tmain.TreeView1Click(Sender: TObject);
//���������Ϊ���ڻ������ü����봰������ʾ��������ؼ�����ѡ��ĳһ�ڵ����Ϣ
var
temp:integer;
pnode:TTreeNode;
begin
edit1.Text:=treeview1.Selected.Text;
//��ʾ��ǰ��ѡȡ�Ľڵ�����ƣ�Ҳ���ǵ�λ��
if treeview1.Selected.Parent.Index<>-1 then
edit2.Text:=treeview1.Selected.Parent.Text
else
edit2.Text:='ʡҽҩ����';
//��ʾ��ǰѡȡ�ڵ�ĸ��ڵ�����ƣ�Ҳ�����ϼ���λ��
//�����ǰѡȡ��ʱ�ڵ�ʱ��һ�����ڵ㣬��ֱ����ʾ'ʡҽҩ����'
edit3.Text:=mytable[treeview1.Selected.AbsoluteIndex+1,2];
temp:=length(edit3.Text)-1;
temp:=round(temp/2);
edit27.Text:=inttostr(temp);
if treeview1.Selected.Parent.index<>-1 then
edit4.Text:=mytable[treeview1.Selected.Parent.AbsoluteIndex+1,2]
else
edit4.Text:='0';
//index��ָĳ��Ԫ�ڸü����е���ţ���absolute�������������еľ������
//���������ַ��������еģ��뵱ǰ�ڵ����Ӧ����Ϣ��ȡ��������ʾ�ڴ�����
//�������д�����Ϊ����ʾ��ǰ�ڵ�ı�ź͸��ڵ�ı��
//--------------------------------------------------------------------




button13.Enabled:=true;
button14.Enabled:=true;
button15.Enabled:=true;
button6.Enabled:=true;
//�����ĳ����ѡȡ�Ľڵ����ɾ�����޸����ƣ������ӽڵ�ȹ���

end;




procedure Tmain.Button13Click(Sender: TObject);
//�ڵ�ǰ�ڵ��£�����һ���ӽڵ�
var
pnode:TTreeNode;

begin
pnode:=treeview1.Selected;
//pnode�൱��һ��ָ�룬��ָ��ǰ�û���ѡȡ�Ľڵ�
treeview1.Items.AddChild(pnode,pnode.Text);
//���������Ϊ��ǰ�ڵ�����һ���ӽڵ�
button16.Enabled:=true;
//����������������
//������Ϣ����ʾ�û�����
MessageBox(0,'�뱣���������޸ģ������Զ�Ϊ�½ڵ����±���','��ʾ',MB_OK);
end;

//--------����Ϊͬ���ڵ�------------------
procedure Tmain.Button6Click(Sender: TObject);
var
pnode:TTreeNode;
begin
//ָ��ѡ�нڵ�ĸ��ڵ�
  pnode:=treeview1.Selected.Parent;
if pnode=nil then
  MessageBox(0,'������Ϊ�����ڵ����ͬ���ڵ�,������ȡ��','ע��!',MB_OK)
 else
  //�ڸ��ڵ�������ӽڵ㣬�൱�����ͬ��ڵ�
  begin
  treeview1.Items.AddChild(pnode,pnode.Text);
button16.Enabled:=true;
//����������������
//������Ϣ����ʾ�û�����
MessageBox(0,'�뱣���������޸ģ������Զ�Ϊ�½ڵ����±���','��ʾ',MB_OK);
   end;

end;

procedure Tmain.Button14Click(Sender: TObject);
//ɾ����ǰ�ڵ�
begin
treeview1.Selected.Delete;
button16.Enabled:=true;
//ɾ����ǰ��ѡȡ�Ľڵ㲢����������������
end;
//-----------------------------------------------------------------------
procedure Tmain.Button15Click(Sender: TObject);
//�޸ĵ�ǰ��ѡȡ�Ľڵ�����
begin
treeview1.Selected.Text:=edit1.Text;
button16.Enabled:=true;
//�û��ӵ�һ���༭�����޸ĵ�ǰ�ڵ����Ʋ��ύ�޸�
//����������������
end;

procedure Tmain.Button16Click(Sender: TObject);
//���������ͼ������ȫ������
var
i,temp:integer;
name,number,absindex,itemindex,itemlevel,parentindex:string;
order,code,s,sp:string;
//����ı���Ϊ�ڵ�����ݺ�ѭ�����Ʊ���
pnode:TTreeNode;
//����ͼ�ڵ�
begin
adocommand1.CommandText:='set IDENTITY_insert ��֯��������� on';
adocommand1.Execute;
//��SQL SERVER�е���֯���������Ĳ������
adocommand1.CommandText:='select * into zztemp from ��֯���������';
adocommand1.Execute;
//һ���������ڶ�һ����������޸�ǰ����Ҫ����һ����ʱ���Ա��汸��
//�����û���Ҫ���Դ�SQL SERVER�лָ������ݱ�����ڳ����б�дSQL ���
//�����ݱ���������¶�����֯�����������
adocommand1.CommandText:='delete from ��֯���������';
adocommand1.Execute;
//���Ҫ�����ı�
adocommand1.CommandText:='insert into ��֯���������([�ڲ����],[���],[AbsIndex],[ItemIndex],[ItemLevel],[ParentIndex],[����],[��λ���],[��λ����]) values(''300'',''ʡҽҩ����'',''0'',''0'',''0'',''-1'',''0'',''0'',''ʡҽҩ����'')';
adocommand1.Execute;
//ֱ�Ӳ�����������

for i:=2 to treeview1.Items.Count do
//��treeview1.items.count���Լ������ؼ������еĽڵ���Ŀ
 begin
 pnode:=treeview1.Items.Item[i-1];
 //����ָ������ͼ�����нڵ�
 name:=pnode.Text;
 number:=inttostr(300+pnode.AbsoluteIndex);
 //�ڲ�������Ϊ��300��ʼ��Ҳ������Ϊ����Ը��ʹ�õ��κ�����
 absindex:=inttostr(pnode.AbsoluteIndex);
 itemindex:=inttostr(pnode.Index);
 parentindex:=inttostr(pnode.Parent.AbsoluteIndex);
 //Ϊ�ڵ���������������
 s:=inttostr(pnode.Index);
  if length(s)=1 then
   s:='0'+s
   else
   s:=s;
   order:=s;
   //ȡ����ı������Index,Ҳ��������
   //������������λ���������������С��10�Ľڵ�ı����1λ����
   //������б��룬������1��indexתΪ�ַ���01
//-----------------------------------------------------------
//ĳһ���ڵ�ı��ʵ�����������Լ������ţ�Ҳ�������ڱ����е�INDEX
//ǰ����ϸ��ڵ�ı����ɣ������ڵ�ı��Ҳ���������ַ��������Ƴ�
while pnode.Parent<>nil do
 begin
   sp:=inttostr(pnode.Parent.Index);
   if length(sp)=1 then
   sp:='0'+sp
   else
   sp:=sp;
   s:=sp+s;
   pnode:=pnode.Parent;
   //�ڵ�ı�ŵ�������ǰ��������ĸ��ڵ��ţ�Ҳ���ڼ����������и��ڵ������
   //����ļ���ָ�ַ�����
   //ȡ���ڵ�����ţ���һֱ׷�ݵ��������ڵ㣬�Ӷ�����һ���ڵ���������
 end;
   code:=copy(s,2,length(s));

   //��������ı��Ϊ0�������н���תΪ��00�������Ҫȥ��һ����
   temp:=length(code)-1;
   temp:=round(temp/2);
   itemlevel:=inttostr(temp);
   //���ݱ�ŵĳ���������������������Ҳ��������itemlevel
  adocommand1.CommandText:='insert into ��֯���������([�ڲ����],[���],[AbsIndex],[ItemIndex],[ItemLevel],[ParentIndex],[����],[��λ���],[��λ����]) values('''+number+''','''+name+''','''+absindex+''','''+itemindex+''','''+itemlevel+''','''+parentindex+''','''+order+''','''+code+''','''+name+''')';
  adocommand1.Execute;
  //����в����¼�¼
 end;
 adocommand1.CommandText:='set IDENTITY_insert ��֯��������� off';
adocommand1.Execute;
//�ص���֯���������Ĳ������
adocommand1.Commandtext:='drop table zztemp';
adocommand1.Execute;
//ɾ����ʱ��
MessageBox(0,'�Ի����������޸��Ѿ�����ɹ���','�ɹ�',MB_OK);
//ˢ������ͼ����ʾ
treeview1.Items.Clear;
adoquery1.Active:=false;
adoquery1.Active:=true;
button12.Click;
end;

 //------------------------------------------------------------
 //------------------������Ϣ�����ܵ�ʵ��--------------------
 //-------------------------------------------------------------
procedure Tmain.TabSheet2Show(Sender: TObject);
//��ʾ������Ϣ
begin
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select �ڲ����,��λ���,��λ����,ƴ������,��λ��ַ,');
adoquery2.SQL.Add('��λ�绰����,��������,�ʺ�,����ȫ�� from ��֯���������');
adoquery2.Open;
//�����п��
dbgrid1.Columns[0].Width:=64;
dbgrid1.Columns[1].Width:=64;
dbgrid1.Columns[2].Width:=192;
dbgrid1.Columns[3].Width:=64;
dbgrid1.Columns[4].Width:=256;
dbgrid1.Columns[5].Width:=128;
dbgrid1.Columns[6].Width:=128;
dbgrid1.Columns[7].Width:=128;
dbgrid1.Columns[8].Width:=128;
end;

procedure Tmain.Button8Click(Sender: TObject);
begin
//��ѯ������Ϣ
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select �ڲ����,��λ���,��λ����,ƴ������,��λ��ַ,');
adoquery2.SQL.Add('��λ�绰����,��������,�ʺ�,����ȫ�� from ��֯���������');
adoquery2.SQL.Add('where ��λ���� like ''%'+edit31.Text+'%''');
adoquery2.Open;
//���ò�ѯ�����ʾʱ���п��
dbgrid1.Columns[0].Width:=64;
dbgrid1.Columns[1].Width:=64;
dbgrid1.Columns[2].Width:=192;
dbgrid1.Columns[3].Width:=64;
dbgrid1.Columns[4].Width:=256;
dbgrid1.Columns[5].Width:=128;
end;

//--------------------------------------------------------------
//-----------------------ְԱ��Ϣ�����ܵ�ʵ��-----------------
//----------------------ְԱ��Ϣά��----------------------------

procedure Tmain.DBGrid2CellClick(Column: TColumn);
//���û���dbgrid����ѡȡ��ְԱ��ȫ����Ϣ��ӵ�ְԱ��Ϣά�������е���Ӧ�ı�����
begin

adotable1.Refresh;
edit5.Text:=dbgrid2.Fields[1].AsString;
edit6.Text:=dbgrid2.Fields[2].AsString;
edit7.Text:=dbgrid2.Fields[3].AsString;
combobox1.Text:=dbgrid2.Fields[4].AsString;
edit8.Text:=dbgrid2.Fields[5].AsString;
edit9.Text:=dbgrid2.Fields[6].AsString;
edit10.Text:=dbgrid2.Fields[7].AsString;
combobox2.Text:=dbgrid2.Fields[8].AsString;
edit11.Text:=dbgrid2.Fields[9].AsString;
edit12.Text:=dbgrid2.Fields[10].AsString;
edit13.Text:=dbgrid2.Fields[11].AsString;
combobox3.Text:=dbgrid2.Fields[12].AsString;
edit14.Text:=dbgrid2.Fields[13].AsString;
edit15.Text:=dbgrid2.Fields[14].AsString;
edit16.Text:=dbgrid2.Fields[15].AsString;
edit17.Text:=dbgrid2.Fields[16].AsString;
edit18.Text:=dbgrid2.Fields[18].AsString;
edit19.Text:=dbgrid2.Fields[17].AsString;
edit20.Text:=dbgrid2.Fields[19].AsString;
edit21.Text:=dbgrid2.Fields[20].AsString;

//�����޸ģ����룬ɾ����¼
button1.Enabled:=true;
button2.Enabled:=true;
button3.Enabled:=true;

end;

//--------------�޸���ѡȡ��ְԱ������-------------
procedure Tmain.Button1Click(Sender: TObject);

var
intNum:integer;
begin
//��ȡѡȡ��ְԱ���ڲ����
intNum:=dbgrid2.Fields[0].AsInteger;

//�������ݱ�
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('update ְԱ������Ϣ�� set ְԱ���='''+edit5.Text+'''');
adoquery2.SQL.Add(',����='''+edit6.Text+'''');
adoquery2.SQL.Add(',��������='''+edit7.Text+'''');
adoquery2.SQL.Add(',�Ա�='''+combobox1.text+'''');
adoquery2.SQL.Add(',��������='''+edit8.Text+'''');
adoquery2.SQL.Add(',����='''+edit9.Text+'''');
adoquery2.SQL.Add(',����='''+edit10.Text+'''');
adoquery2.SQL.Add(',����='''+combobox2.Text+'''');
adoquery2.SQL.Add(',�Ļ��̶�='''+edit11.Text+'''');
adoquery2.SQL.Add(',��ҵѧУ='''+edit12.Text+'''');
adoquery2.SQL.Add(',����״��='''+edit13.Text+'''');
adoquery2.SQL.Add(',����״��='''+combobox3.Text+'''');
adoquery2.SQL.Add(',���֤����='''+edit14.Text+'''');
adoquery2.SQL.Add(',��ͥ�绰='''+edit15.Text+'''');
adoquery2.SQL.Add(',�칫�绰='''+edit16.Text+'''');
adoquery2.SQL.Add(',�ֻ�='''+edit17.Text+'''');
adoquery2.SQL.Add(',�����ʼ���ַ='''+edit19.Text+'''');
adoquery2.SQL.Add(',ְ���˺�='''+edit18.Text+'''');
adoquery2.SQL.Add(',��λ���='''+edit20.Text+'''');
adoquery2.SQL.Add(',��ע='''+edit21.Text+'''');
adoquery2.SQL.Add(' where �ڲ����='''+inttostr(intNum)+'''');

adoquery2.SQL.Add('select ���� from ְԱ������Ϣ�� where �ڲ����='''+inttostr(intNum)+'''');
adoquery2.Open;
//��ʾ���������ݵ�ְԱ�������������³ɹ�����Ϣ
label58.Caption:=adoquery2.fieldbyname('����').asstring+'����Ϣ�Ѿ����ɹ��޸�';
//ˢ��dbgrid�е�����
adotable1.Active:=false;
adotable1.Active:=true;

end;

//------------ɾ����¼---------------------------
procedure Tmain.Button2Click(Sender: TObject);
var
deleteName:string;
deleteNum:integer;
begin
//����Ҫɾ����¼��ְԱ��������ְԱ���
deleteName:=edit6.Text;
deleteNum:=dbgrid2.Fields[0].AsInteger;
//Ϊ���������ֻ��ְԱ�����ͱ�Ŷ�����ʱ����ɾ��
adocommand1.CommandText:='delete from ְԱ������Ϣ�� where (�ڲ����='''+inttostr(deleteNum)+''')and(����='''+deleteName+''')';
adocommand1.Execute;
//��ʾɾ���ɹ�����Ϣ
MessageBox(0,'ɾ����¼�ɹ�!','ɾ��',MB_OK);
label58.Caption:=deleteName+'�ļ�¼�ѱ��ɹ�ɾ��';
//ˢ��dbgrid������
adotable1.Active:=false;
adotable1.Active:=true;

end;


//----------------�����¼�¼----------------------------
procedure Tmain.Button3Click(Sender: TObject);

var
MaxIntNum:integer;
TotalNum:integer;
begin

adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select max(�ڲ����) �����,count(�ڲ����) ������ from ְԱ������Ϣ��');
adoquery2.Open;
//�������ݱ���ְԱ�ڲ���ŵ����ֵ��������
//�Զ������²����ְԱ���ݵ��ڲ����
MaxIntNum:=adoquery2.FieldByName('�����').AsInteger;
TotalNum:=adoquery2.FieldByName('������').AsInteger;
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select count(ְԱ���) ��ͬ��� from ְԱ������Ϣ�� where ְԱ���='''+edit5.Text+'''');
adoquery2.Open;
//�ж������ְԱ��ţ���������ְԱ��������е���ͬ������ʾ�޸�
if (adoquery2.FieldByName('��ͬ���').AsInteger>0) then
 MessageBox(0,'ְԱ���������ְԱ�����ͬ!','Error!',MB_OK)
 else
 begin
 //�������û�����յı�ź��������������Ϊ�գ�����ʾ����
  if (edit5.Text='')or(edit6.Text='') then
  MessageBox(0,'�����ͱ�Ų���Ϊ��!','Error!',MB_OK)
   else
   begin
    //��ְԱ������Ϣ��������
    adocommand1.CommandText:='set IDENTITY_insert ְԱ������Ϣ�� on';
    adocommand1.Execute;
    //����в����¼�¼������ֻ�����˲���Ϊ�յ����������update������������и���
    adocommand1.CommandText:='insert into ְԱ������Ϣ��([�ڲ����], [ְԱ���], [����]) values('''+inttostr(MaxIntNum+1)+''','+''''+edit5.Text+''','+''''+edit6.Text+''')';
    adocommand1.Execute;
    adoquery2.Close;
    adoquery2.SQL.Clear;
    //�����²�����������ɲ���Ĺ���
    adoquery2.SQL.Add('update ְԱ������Ϣ�� set ��������='''+edit7.Text+'''');
    adoquery2.SQL.Add(',�Ա�='''+combobox1.text+'''');
  adoquery2.SQL.Add(',��������='''+edit8.Text+'''');
  adoquery2.SQL.Add(',����='''+edit9.Text+'''');
  adoquery2.SQL.Add(',����='''+edit10.Text+'''');
  adoquery2.SQL.Add(',����='''+combobox2.Text+'''');
  adoquery2.SQL.Add(',�Ļ��̶�='''+edit11.Text+'''');
  adoquery2.SQL.Add(',��ҵѧУ='''+edit12.Text+'''');
  adoquery2.SQL.Add(',����״��='''+edit13.Text+'''');
  adoquery2.SQL.Add(',����״��='''+combobox3.Text+'''');
  adoquery2.SQL.Add(',���֤����='''+edit14.Text+'''');
  adoquery2.SQL.Add(',��ͥ�绰='''+edit15.Text+'''');
  adoquery2.SQL.Add(',�칫�绰='''+edit16.Text+'''');
  adoquery2.SQL.Add(',�ֻ�='''+edit17.Text+'''');
  adoquery2.SQL.Add(',�����ʼ���ַ='''+edit19.Text+'''');
  adoquery2.SQL.Add(',ְ���˺�='''+edit18.Text+'''');
  adoquery2.SQL.Add(',��λ���='''+edit20.Text+'''');
  adoquery2.SQL.Add(',��ע='''+edit21.Text+'''');
  adoquery2.SQL.Add(' where �ڲ����='''+inttostr(MaxIntNum+1)+'''');
  adoquery2.SQL.Add('select ���� from ְԱ������Ϣ�� where �ڲ����='''+inttostr(MaxIntNum+1)+'''');
   adoquery2.Open;

   adoquery2.FieldByName('����').AsString;
//ˢ��dbgrid�����ݲ����Ͳ���ɹ�����Ϣ
//label58���Ƿ�����Ǹ�captionΪ�գ�������ʾ��Ϣ��label�ؼ�
   label58.Caption:=adoquery2.fieldbyname('����').asstring+'����Ϣ�Ѿ����ɹ�����';
    adotable1.Active:=false;
    adotable1.Active:=true;
//�����˹ص��������
        adocommand1.CommandText:='set IDENTITY_insert ְԱ������Ϣ�� off';
    adocommand1.Execute;

   end;
end;


end;

 //--------------------------------------------------------------
//-----------------------ְԱ��Ϣ�����ܵ�ʵ��-----------------
//----------------------ְԱ��Ϣ��ѯ----------------------------

procedure Tmain.Button4Click(Sender: TObject);
begin
//�����Ǵ��������в�ѯ���ݣ���ע�������߼��������ʹ�÷�����ͨ�����ʹ��
  adoquery3.Close;
  adoquery3.SQL.Clear;
  adoquery3.SQL.Add('select a.����,a.�Ա�,a.��������,a.����,a.����,b.��λ����,a.�칫�绰,a.����״��,a.�Ļ��̶� from ְԱ������Ϣ�� a,��֯��������� b');
  adoquery3.sql.add('where (a.��λ���=b.��λ���)and((���� like ''%'+edit22.text+'%'')and');
  adoquery3.SQL.Add('(�������� like ''%'+edit23.Text+'%'')and');
  adoquery3.SQL.Add('(���� like ''%'+edit24.Text+'%'')and');
  adoquery3.SQL.Add('(���� like ''%'+combobox5.Text+''')and');
  adoquery3.SQL.Add('(�Ա� like ''%'+combobox4.Text+'''))');
  adoquery3.Open

end;
//-----------������ʾʱ������������������ʾ����-----------
procedure Tmain.TabSheet3Show(Sender: TObject);
begin
button4.Click;
end;



//--------------------------------------------------------------------------------
//----------------------н�ʸ��������ܵ�ʵ��-----------------------------------
//-----------------���ʷ�����ʷ��ѯ,��������˰�ʱ���ʾ��ְԱ���͹���------------


procedure Tmain.Button5Click(Sender: TObject);
//���ʷ�����ʷ��ѯ
var
i:integer;
begin
  adoquery3.Close;
  adoquery3.SQL.Clear;
  adoquery3.SQL.Add('select b.����,a.* from ���ʷ�����ʷ�� a,ְԱ������Ϣ�� b ');
  adoquery3.SQL.Add('where (a.ְԱ���=b.ְԱ���)and((b.���� like ''%'+edit26.Text+'%'')and');
  adoquery3.SQL.Add('(a.���� like ''%'+edit25.Text+'%''))');
  adoquery3.Open;
  //���ñ�Ŀ��
    for i:=3 to 29 do
    dbgrid5.Columns[i].Width:=64;

end;

procedure Tmain.TabSheet9Show(Sender: TObject);
 //��ʾʱ�г������������ݣ��൱�������ֵ���в�ѯ
begin
button5.Click;
end;


//-------------------------���¹��ʹ���------------------------------------------
//---------���ñ��е��ֶεĿ��------------
procedure Tmain.TabSheet7Show(Sender: TObject);
begin
dbgrid8.Columns[0].Width:=80;
dbgrid8.Columns[1].Width:=80;
dbgrid8.Columns[2].Width:=86;
dbgrid8.Columns[3].Width:=86;
dbgrid8.Columns[4].Width:=86;
dbgrid8.Columns[5].Width:=80;
dbgrid8.Columns[6].Width:=80;
dbgrid8.Columns[7].Width:=80;
dbgrid8.Columns[8].Width:=80;

end;
 
 //---------��ȡ���ʵ���ʷ��¼---------------------------------
procedure Tmain.Button9Click(Sender: TObject);
//����SQL ����ʱ�Ľű���ʵ���¹���ͳ�Ʊ���γ�
begin
//��������Ҫ�������ݵ��·ݺͽ��������ݵĵ�ǰ�·ݣ����Ϊ�գ�����ʾ��������
 if (edit32.text='')or(edit33.text='') then
   MessageBox(0,'���벻��Ϊ��!','����',MB_OK)

//��������ʱ��ĸ�ʽ
   else if (length(edit32.Text)<>6)or(length(edit33.Text)<>6) then
    MessageBox(0,'����Ӧ��''200301''��ʽ!','����',MB_OK)

    else
    begin
//�γɵ��¹���ͳ�Ʊ�
     adocommand1.CommandText:='exec sf_�γ��¹���ͳ�Ʊ� '''+edit32.Text+''','''+edit33.Text+'''';
     adocommand1.Execute;
     //ˢ������
     adoquery4.Active:=false;
     adoquery4.Active:=true;

    end;

end;
//------------���㵱�¹���------------------
procedure Tmain.Button10Click(Sender: TObject);
begin
      adocommand1.CommandText:='exec sf_���¹���ͳ��';
     adocommand1.Execute;
//ˢ������
     adoquery4.Active:=false;
     adoquery4.Active:=true;


end;

//----------------������ѡȡ��Ա���Ĺ���----------------
procedure Tmain.Button11Click(Sender: TObject);

var
num:string;
begin
//��ȡҪ���Ź��ʵ�Ա���ı��
num:=adoquery4.Fields[2].AsString;
//���Ź���
adocommand1.CommandText:='exec sf_���¹��ʷ��� '''+num+'''';
adocommand1.Execute;
MessageBox(0,'��ѡԱ���Ĺ��ʷ����ѳɹ�!','Success',MB_OK);
//ˢ������
adoquery4.Active:=false;
adoquery4.Active:=true;

end;



end.

