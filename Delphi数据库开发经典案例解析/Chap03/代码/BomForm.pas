unit BomForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DB, ADODB, Grids, DBGrids, StdCtrls, Buttons,MainForm,
  ToolWin, ExtCtrls;

type
  Tbom = class(TForm)
    TreeView1: TTreeView;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    DBGrid1: TDBGrid;
    ADOQuery3: TADOQuery;
    DataSource1: TDataSource;
    ADOCommand1: TADOCommand;
    ToolBar1: TToolBar;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    ToolButton1: TToolButton;
    BitBtn5: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    ToolButton2: TToolButton;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    ToolButton3: TToolButton;
    BitBtn11: TBitBtn;
    BitBtn6: TBitBtn;
    Panel1: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    BitBtn12: TBitBtn;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    BitBtn13: TBitBtn;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Memo1: TMemo;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
   
    

    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure Edit8KeyPress(Sender: TObject; var Key: Char);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);

  private
    { Private declarations }
  public
    { Public declarations }
//��ʾ��ť�������ò�ͬ��ֵ��ʾ��ͬ�Ĳݴ�
//insflag=1��ʶ�������ť������
//insflag=2��ʾ����ͬ���ť������
//insflag=3��ʾ�޸İ�ť������
    insflag:integer;
//���ݿ������������������Ϊdecimal����sql��������Ҫ����ת��
 ratio,num:double;
//������д�ĺ����͹���
    procedure showtree();
    function checknode(pnode:Ttreenode):integer;
 end;

type
//��������ڱ�������ͼ�и��ڵ����ϸ����
 Ttable=array[1..200,1..3] of string;
//��������ڴ洢����ͼ���ڵ�Ľڵ�λ��
//����һ����һ��������ѯ����õ�ĳ���ڵ������
 Tnodetable=array[1..200] of TTreeNode;
var
  bom: Tbom;
  mytable:TTable;
  mynodetable:Tnodetable;
  

implementation

{$R *.dfm}

uses chooseForm;
//---------�㴰���X��ťʱ�رմ���----------
procedure Tbom.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;

//--------��ʾ����ʱ�ʹ�������ͼ-------
procedure Tbom.FormShow(Sender: TObject);
begin
  showtree();
end;

//----------�Լ���д����ʾ����ͼ�Ĺ���--------------
procedure Tbom.showtree();
var
pnode1,pnode,curnode:TTreenode;
pcode,code,pname,name:string;
i,count,order:integer;
begin
 //�������ݣ�ˢ����������
 adoquery1.Close;
 adoquery1.SQL.Clear;
 adoquery1.SQL.Add('select a.*,b.* from �����嵥 a, �������ļ� b');
 adoquery1.SQL.Add('where a.���ϱ��=b.���ϱ��');
 adoquery1.SQL.Add('order by a.�Ͳ���,a.������');
 adoquery1.Open;

 //���ڡ�ȫ����Ʒ����һ�����ݲ��������嵥���У����Ҫ���������ļ��ж���
 adoquery2.Close;
 adoquery2.SQL.Clear;
 adoquery2.SQL.Add('select �������� from �������ļ� where ���ϱ��=''0''');
 adoquery2.Open;

 //�������ڵ㡮ȫ����Ʒ��
 curnode:=treeview1.Items.AddFirst(nil,adoquery2.fieldbyname('��������').AsString);

  //�����������ͼ�е�����
//order����ĳ���ڵ��ǵڼ���������
//������Ҳ�Ǹýڵ���mytable�еĴ���λ�ã���ʼ��Ϊ0
 order:=0;

 //�����������
 while not adoquery1.Eof do
 begin
  //�������ŵȶ������
  pcode:=adoquery1.fieldbyname('������').AsString;
  code:=adoquery1.fieldbyname('���ϱ��').AsString;
  name:=adoquery1.fieldbyname('��������').AsString;

  //���Ҽ�¼�ĸ���������Ӧ����������
  adoquery2.Close;
  adoquery2.SQL.Clear;
  adoquery2.SQL.Add('select �������� from �������ļ� where ���ϱ��='''+pcode+'''');
  adoquery2.Open;
  pname:=adoquery2.fieldbyname('��������').AsString;
  //���㵱ǰ����ͼ�е��ܽ����Ŀ
  count:=treeview1.Items.Count;
  //�ӵ�һ���ڵ㿪ʼ�������������������Ƿ���Ҫ�����Ľڵ�ĸ���ڵ������������ͬ
  //����ͬ����������ڵ��´�������
  for i:=1 to count do
   begin
   pnode1:=treeview1.Items.Item[i-1];
     if pnode1.Text=pname then
       begin
       //�����ӽڵ�
       pnode:=treeview1.Items.AddChild(pnode1,name);
       pnode.Expanded:=true;
       //���ݴ���˳�򴢴�������Ϣ
       order:=order+1;
       mytable[order,1]:=pcode;
       mytable[order,2]:=code;
       mytable[order,3]:=name;
       //�������ڵ�Ľڵ�����
       mynodetable[order]:=pnode;

       end;
   end;
   //������һ����¼
 adoquery1.Next;
 end;
end;

//----------��ʾ������ͼ��ѡ�еĽڵ�������嵥����------
procedure Tbom.TreeView1Click(Sender: TObject);
var
pcode,code,name,temp:string;
i:integer;
begin
//��ѡ������׽ڵ㣬������Ʒ��Ϣ
if treeview1.Selected.Parent=nil then
 begin
 adoquery3.Close;
 adoquery3.SQL.Clear;
 adoquery3.SQL.Add('select a.*,b.* from �������ļ� a,�����嵥 b');
 adoquery3.SQL.Add('where (a.���ϱ��=b.���ϱ��)and(b.������=''0'')');
 adoquery3.Open;
  edit1.Text:='0';
  edit2.Text:='ȫ����Ʒ';
  edit3.Text:='';
  edit4.Text:='';
  edit5.Text:='0';
  groupbox1.Caption:='ȫ����Ʒ';
 end
else
//��ѡ����Ƿ��׽ڵ�����Ľڵ㣬��������Ӧ�������嵥��Ϣ
begin
//ȡ����ѡ�ڵ��������mytable�е�λ��
  i:=checknode(treeview1.Selected);
//�Ӵ�����ж�����ϸ����
 pcode:=mytable[i,1];
 code:=mytable[i,2];
 name:=mytable[i,3];

 //���ݽڵ��Ƿ����ӽڵ㣬����sql��ͬ�������в�ѯ
 adoquery3.Close;
 adoquery3.SQL.Clear;
 //��ѡȡ�ýڵ����ӽڵ㣬�������ʾ��������������Ϣ
 if treeview1.Selected.HasChildren then
  begin
  adoquery3.SQL.Add('select a.*,b.* from �������ļ� a,�����嵥 b where (a.���ϱ��=b.���ϱ��)');
  adoquery3.SQL.Add('and(b.������='''+code+''')');
  temp:='�����������嵥';
  end
  else
//���û���ӽڵ㣬����ʾ���Լ�����Ϣ
  begin
  adoquery3.SQL.Add('select a.*,b.* from �������ļ� a,�����嵥 b where (a.���ϱ��=b.���ϱ��)');
  adoquery3.SQL.Add('and(b.���ϱ��='''+code+''')');
  adoquery3.SQL.Add('and(b.������='''+pcode+''')');
  temp:='���������';
  end;
  adoquery3.Open;
  //�ڴ�����ı�������ʾѡ�еĽڵ����Ϣ
  edit1.Text:=code;
  edit2.Text:=name;
  edit3.Text:=pcode;
  edit4.Text:=dbgrid1.Fields[11].AsString;
  edit5.Text:=inttostr(treeview1.Selected.level);
  memo1.Text:=adoquery3.fieldbyname('��������').AsString;
  edit9.Text:=adoquery3.fieldbyname('���ϳ���').AsString;
  edit10.Text:=adoquery3.fieldbyname('���Ͽⷿ').AsString;
  edit11.Text:=adoquery3.fieldbyname('�����').AsString;
  edit12.Text:=adoquery3.fieldbyname('�������').AsString;
  groupbox1.Caption:=copy(name,1,16)+temp;
end;



end;

//----------���б�д�ĺ���-----------------------
//----���ڴ�һ������ڵ�ı��в���ĳ���ڵ����ϸ��mytable�еĴ���λ��-----
function Tbom.checknode(pnode:TTreeNode):integer;
var
i:integer;
begin
 for i:=1 to treeview1.Items.Count-1 do
  if pnode=mynodetable[i] then
   begin
   checknode:=i;
   end;
end;





//--------------�׼�¼---------------------
procedure Tbom.BitBtn1Click(Sender: TObject);
begin
 datasource1.DataSet.First;
end;

//--------------��һ����¼---------------------
procedure Tbom.BitBtn2Click(Sender: TObject);
begin
 datasource1.DataSet.Prior;
end;

//--------------��һ����¼---------------------
procedure Tbom.BitBtn3Click(Sender: TObject);
begin
datasource1.DataSet.Next;
end;

//--------------β��¼---------------------
procedure Tbom.BitBtn4Click(Sender: TObject);
begin
datasource1.DataSet.Last;
end;

//----------------��������---------------------------------
procedure Tbom.BitBtn5Click(Sender: TObject);

begin

//��ʶ�������ť������
insflag:=1;
//����ı����е�����
edit1.Clear;
edit2.Clear;
edit3.Clear;
edit4.Clear;
edit5.Clear;
edit9.Clear;
edit10.Clear;
edit11.Clear;
edit12.Clear;
//����Ѱ��ť��Ϊ����״̬��ͬ����������ť��������
bitbtn13.Enabled:=true;
bitbtn1.Enabled:=false;
bitbtn2.Enabled:=false;
bitbtn3.Enabled:=false;
bitbtn4.Enabled:=false;
bitbtn5.Enabled:=false;
bitbtn6.Enabled:=false;
bitbtn7.Enabled:=false;
bitbtn8.Enabled:=false;
bitbtn9.Enabled:=true;
bitbtn10.Enabled:=true;
//�����޸��ı����е�����
edit4.ReadOnly:=false;
edit9.ReadOnly:=false;
edit10.ReadOnly:=false;
edit11.ReadOnly:=false;
edit12.ReadOnly:=false;
end;

//----------------����ͬ����------------------------------
procedure Tbom.BitBtn6Click(Sender: TObject);
begin

//��ʶ����ͬ���ť������
insflag:=2;
//����ı����е�����
edit1.Clear;
edit2.Clear;
edit3.Clear;
edit4.Clear;
edit5.Clear;
edit9.Clear;
edit10.Clear;
edit11.Clear;
edit12.Clear;
memo1.Clear;
//����Ѱ��ť��Ϊ����״̬��ͬ����������ť��������
bitbtn13.Enabled:=true;
bitbtn1.Enabled:=false;
bitbtn2.Enabled:=false;
bitbtn3.Enabled:=false;
bitbtn4.Enabled:=false;
bitbtn5.Enabled:=false;
bitbtn6.Enabled:=false;
bitbtn7.Enabled:=false;
bitbtn8.Enabled:=false;
bitbtn9.Enabled:=true;
bitbtn10.Enabled:=true;
//�����޸��ı����е�����
edit4.ReadOnly:=false;
edit9.ReadOnly:=false;
edit10.ReadOnly:=false;
edit11.ReadOnly:=false;
edit12.ReadOnly:=false;
end;



//--------------ɾ������----------------------
procedure Tbom.BitBtn8Click(Sender: TObject);
begin
//ѯ���û���ȷ��ɾ��
 if treeview1.Selected.HasChildren then
  showmessage('����ɾ������������ȫ������')
 else
  begin
  //ɾ������
  adocommand1.CommandText:='delete from �����嵥 where (���ϱ��='''+edit1.Text+''')and(������='''+edit3.Text+''')';
  if application.MessageBox('ȷʵɾ���������ݣ�','ɾ��',MB_OKCANCEL)=ID_OK then
  begin
  adocommand1.Execute;
  //���»�������ͼ
  treeview1.Items.Clear;
  showtree();
  end;
  end;

end;

//--------�޸�����------------------------
procedure Tbom.BitBtn7Click(Sender: TObject);
begin
//��ʶ�޸��ť������
insflag:=3;
//����Ӧ��ť��Ϊ����״̬
bitbtn1.Enabled:=false;
bitbtn2.Enabled:=false;
bitbtn3.Enabled:=false;
bitbtn4.Enabled:=false;
bitbtn5.Enabled:=false;
bitbtn6.Enabled:=false;
bitbtn7.Enabled:=false;
bitbtn8.Enabled:=false;
bitbtn9.Enabled:=true;
bitbtn10.Enabled:=true;
//�����޸��ı����е�����
edit4.ReadOnly:=false;
edit9.ReadOnly:=false;
edit10.ReadOnly:=false;
edit11.ReadOnly:=false;
edit12.ReadOnly:=false;
//�����û��������йص���ϢӦ�����������ļ����޸�
showmessage('���ϱ�ţ��������Ƶ����������������ļ����޸�');
end;

//-------------�����Ӵ��壬ѡ������--------------------
procedure Tbom.BitBtn13Click(Sender: TObject);
var
newform:Tchoose;
begin

main.bomflag:=1;
newform:=Tchoose.Create(application);
//�������ڻһ�
self.Enabled:=false;
end;

//---------����ָ�ʱ��������������幫�������е�����--------------
procedure Tbom.FormActivate(Sender: TObject);
var
i:integer;
begin
//������������ť�����£��򽫴��������ļ���ѡȡ������ı��
//���Ƶ���Ϣ�͵�BOM�����У�����ʼ��һЩ����
 if insflag=1 then
  begin
  edit1.Text:=main.str;
  edit2.Text:=main.str2;
  edit4.Text:='0.0';
  edit11.Text:='0.0';
  if treeview1.Selected.Parent=nil then
  edit3.Text:='0'
  else
  begin
  i:=checknode(treeview1.Selected);
  edit3.Text:=mytable[i,2];
  end;
  edit5.Text:=inttostr(treeview1.Selected.Level+1);
 end;
//���������ͬ���ť�����£�������������������ͬ���������ź͵Ͳ����б仯
 if insflag=2 then
  begin
  edit1.Text:=main.str;
  edit2.Text:=main.str2;
  edit4.Text:='0.0';
  edit11.Text:='0.0';
  if treeview1.Selected.Parent=nil then
  begin
  edit3.Text:='0';
  edit5.Text:=inttostr(treeview1.Selected.Level+1);
  showmessage('������Ϊ"ȫ����Ʒ"���ͬ����')
  end
  else
  begin
  i:=checknode(treeview1.Selected);
  edit3.Text:=mytable[i,1];
  edit5.Text:=inttostr(treeview1.Selected.Level);
  end;
 end;

end;

//------------����������������޸�-------------------
procedure Tbom.BitBtn9Click(Sender: TObject);
begin
//��������ʺ����������ݿ�����decimal�洢�������Ҫ������ת��һ��
  ratio:=strtofloat(edit11.Text);
  num:=strtofloat(edit4.text);
//�����������ͬ��������Ĵ���
if (insflag=1)or(insflag=2) then
  adocommand1.CommandText:='insert into �����嵥([������], [���ϱ��], [��Ҫ����], [�Ͳ���],[���ϳ���],[���Ͽⷿ],[�����],[�������],[��������]) values('''+edit3.Text+''','''+edit1.Text+''','''+floattostr(num)+''','''+edit5.Text+''','''+edit9.Text+''','''+edit10.Text+''','''+floattostr(ratio)+''','''+edit12.Text+''','''+memo1.Text+''')';
//���޸Ĳ����Ĵ���
if insflag=3 then
  adocommand1.CommandText:='update �����嵥 set [��Ҫ����]='''+floattostr(num)+''',[���ϳ���]='''+edit9.Text+''',[���Ͽⷿ]='''+edit10.Text+''',[�����]='''+floattostr(ratio)+''',[�������]='''+edit12.Text+''',[��������]='''+memo1.Text+''' where (���ϱ��='''+edit1.Text+''')and(������='''+edit3.Text+''')';
adocommand1.Execute;

//�����������ͼ�����»���
treeview1.Items.Clear;
showtree();
//���������ʶ
insflag:=0;
//�ָ���ť����
bitbtn13.Enabled:=false;
bitbtn1.Enabled:=true;
bitbtn2.Enabled:=true;;
bitbtn3.Enabled:=true;
bitbtn4.Enabled:=true;
bitbtn5.Enabled:=true;
bitbtn6.Enabled:=true;
bitbtn7.Enabled:=true;
bitbtn8.Enabled:=true;
bitbtn9.Enabled:=false;
bitbtn10.Enabled:=false;
//�������޸��ı����е�����
edit4.ReadOnly:=true;
edit9.ReadOnly:=true;
edit10.ReadOnly:=true;
edit11.ReadOnly:=true;
edit12.ReadOnly:=true;
end;

//---------------ȡ������-------------------------
procedure Tbom.BitBtn10Click(Sender: TObject);
begin
//���������ʶ
insflag:=0;
//����ı����е�����
edit1.Clear;
edit2.Clear;
edit3.Clear;
edit4.Clear;
edit5.Clear;
edit9.Clear;
edit10.Clear;
edit11.Clear;
edit12.Clear;
memo1.Clear;
//�ָ���ť����
bitbtn13.Enabled:=false;
bitbtn1.Enabled:=true;
bitbtn2.Enabled:=true;;
bitbtn3.Enabled:=true;
bitbtn4.Enabled:=true;
bitbtn5.Enabled:=true;
bitbtn6.Enabled:=true;
bitbtn7.Enabled:=true;
bitbtn8.Enabled:=true;
bitbtn9.Enabled:=false;
bitbtn10.Enabled:=false;
//�������޸��ı����е�����
edit4.ReadOnly:=true;
edit9.ReadOnly:=true;
edit10.ReadOnly:=true;
edit11.ReadOnly:=true;
edit12.ReadOnly:=true;
end;

//---------------��ѯ����--------------------
procedure Tbom.BitBtn12Click(Sender: TObject);
begin
adoquery3.Close;
adoquery3.SQL.Clear;
adoquery3.SQL.Add('select a.*,b.* from �����嵥 a,�������ļ� b where (a.������ like ''%'+edit6.Text+'%'')and');
adoquery3.SQL.Add('(b.�������� like ''%'+edit7.Text+'%'')and(b.ƴ������ like ''%'+edit8.Text+'%'')');
adoquery3.SQL.Add('and(a.���ϱ��=b.���ϱ��)');
adoquery3.Open;


end;

//------���ı����а���enter��ִ�в�ѯ-------------
procedure Tbom.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
 bitbtn12.Click;
end;

procedure Tbom.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
 bitbtn12.Click;
end;

procedure Tbom.Edit8KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
 bitbtn12.Click;
end;

//-----------�رմ���--------------------
procedure Tbom.BitBtn11Click(Sender: TObject);
begin
close;
end;

procedure Tbom.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  //���ñ����еĿ��
  dbgrid1.Columns[0].Width:=80;
  dbgrid1.Columns[1].Width:=100;
  dbgrid1.Columns[2].Width:=64;
  dbgrid1.Columns[3].Width:=64;
  dbgrid1.Columns[4].Width:=64;
  dbgrid1.Columns[5].Width:=64;
  dbgrid1.Columns[6].Width:=64;
  dbgrid1.Columns[7].Width:=64;
  dbgrid1.Columns[8].Width:=64;
  dbgrid1.Columns[9].Width:=64;
  dbgrid1.Columns[10].Width:=64;
  dbgrid1.Columns[11].Width:=64;
end;

end.
