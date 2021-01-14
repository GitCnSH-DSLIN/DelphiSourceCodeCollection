unit FormOutput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, StdCtrls, Grids, ExtCtrls;

type
  Toutput = class(TForm)
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit3: TEdit;
    StringGrid1: TStringGrid;
    ComboBox3: TComboBox;
    Button1: TButton;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Button2: TButton;
    ADOQuery1: TADOQuery;
    ADOCommand1: TADOCommand;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox3Select(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure ComboBox2DropDown(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    
  private
    { Private declarations }
//-------------����ѡȡ��stringgrid��Ԫ��Ա���У���ֵΪpublic���Թ����������е���-----------------
  public
  currentRow: integer;
  currentCol:integer;
    { Public declarations }
  end;

var
  output: Toutput;
  currentRow: integer;
  currentCol:integer;
implementation

uses FormInfo, FormManage;

{$R *.dfm}
//-------------------���崴��ʱ������stringgrid���������ԣ���ȵ���Ϣ--------------
//---------------ͬʱΪҵ��Ա������ݴʵ�---------------------------------------
procedure Toutput.FormCreate(Sender: TObject);
var
i,j,num:integer;
begin
//-------------����stringgrid�У�������---------------------

stringgrid1.Cols[0].Add('���');
stringgrid1.ColWidths[0]:=32;
stringgrid1.Cols[1].Add('����(˫��)');
stringgrid1.ColWidths[1]:=80;
stringgrid1.Cols[2].Add('Ʒ��');
stringgrid1.ColWidths[2]:=128;
stringgrid1.Cols[3].Add('��λ');
stringgrid1.ColWidths[3]:=32;
 stringgrid1.Cols[4].Add('����');
 stringgrid1.ColWidths[4]:=64;
stringgrid1.Cols[5].Add('�ֿ�');
stringgrid1.ColWidths[5]:=48;
 stringgrid1.Cols[6].Add('����');
 stringgrid1.ColWidths[6]:=64;
stringgrid1.Cols[7].Add('���');
stringgrid1.ColWidths[7]:=64;
 stringgrid1.Cols[8].Add('˰��');
 stringgrid1.ColWidths[8]:=64;
stringgrid1.Cols[9].Add('˰��');
stringgrid1.ColWidths[9]:=64;
stringgrid1.Cols[10].Add('����˰��');
stringgrid1.ColWidths[10]:=64;

for i:=1 to 20 do
 begin
 stringgrid1.Rows[i].Add(inttostr(i));
 stringgrid1.RowHeights[i]:=20;
 end;
//-------------------------����ҵ��Ա���ݴʵ�------------------------
adoquery1.Close;
adoquery1.SQL.Add('select ���� from �û��嵥 where ����!=''sys''');
adoquery1.Open;
combobox1.Clear;
while not adoquery1.Eof do
begin
 combobox1.Items.Add(adoquery1.fieldbyname('����').AsString);
 adoquery1.Next;
end;
end;

//------------------����ѡȡ�ĵ�Ԫ�У���ֵ--------------------------
//-----------------������ۼۣ���������Ϣ��������Щ��Ϣ���м���---------
//-------------------��ͳ�ƽ����ʾ�ڴ����·����ı�����-----------------
procedure Toutput.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
 price,number,tax,sum:double;
 j:integer;
begin
//��ȡѡȡ�ĵ�ǰ��Ԫ���У���ֵ
 currentCol:=ACol;
 currentRow:=ARow;
//ֻ�е�ѡȡ�ֿ�ʱ����̬�����б����ʾ
 if (currentCol<>5) then
  combobox3.Visible:=false;
//ֻ����Ʒ��Ϣ��Ϊ��ʱ�ſ������뵥λ��Ĭ��˰��
 if (currentCol=3)and(stringgrid1.Cells[2,currentRow]<>'') then
   begin
  adoquery1.Close;
 adoquery1.SQL.Clear;
 adoquery1.SQL.Add('select distinct ��λ from ��Ʒ�嵥 where ����='''+stringgrid1.Cells[1,currentRow]+'''');
 adoquery1.Open;
 stringgrid1.Cells[3,currentRow]:=adoquery1.FieldByName('��λ').AsString;
 stringgrid1.Cells[8,currentRow]:='17';
   end;



 //--------------------����Ʒ��Ϣ�����������۲�Ϊ��ʱ�����ܽ��м���------------------------
  if (currentRow<>0)and(stringgrid1.Cells[1,currentRow]<>'')and(stringgrid1.Cells[4,currentRow]<>'')and(stringgrid1.Cells[6,currentRow]<>'')and(stringgrid1.Cells[5,currentRow]<>'') then
   begin
 //-----------------����ĳ�����۵���ϸ�Ľ�����˰��Ͳ���˰��-------------------------
//-----------------------���￪ʼ��ӵĴ������жϳ�������------------------------
//------------------������Ʒ��������������ڿ���еĴ�������----------------------
 adoquery1.Close;
 adoquery1.SQL.Clear;
 adoquery1.SQL.Add('select ������� from ���� where ����='''+stringgrid1.Cells[1,currentRow]+'''');
 adoquery1.Open;
 if strtoint(stringgrid1.Cells[4,currentRow])>adoquery1.FieldByName('�������').AsInteger then
  begin
  showmessage('�ÿ��д�����Ʒ�������С����������,���������������');
  stringgrid1.Cells[4,currentRow]:=adoquery1.FieldByName('�������').AsString;
  end;

//----------����ĳ�����۵���ϸ�Ľ�����˰��Ͳ���˰��-----------------------
   number:=strtofloat(stringgrid1.Cells[4,currentRow]);
   price:=strtofloat(stringgrid1.Cells[6,currentRow]);
   tax:=strtofloat(stringgrid1.Cells[8,currentRow])/100;
   stringgrid1.Cells[7,currentRow]:=floattostr(number*price);
   stringgrid1.Cells[9,currentRow]:=floattostr(tax*number*price/(1+tax));
   stringgrid1.Cells[10,currentRow]:=floattostr(number*price/(1+tax));

  //----------------ͳ�ƺϼƽ��-----------------------
   sum:=0;
   for j:=1 to 20 do
   if  stringgrid1.Cells[7,j]<>'' then
      sum:=sum+strtofloat(stringgrid1.Cells[7,j]);
   edit4.Text:=floattostr(sum);
  //----------------ͳ�ƺϼ�˰��-----------------------
   sum:=0;
   for j:=1 to 20 do
   if  stringgrid1.Cells[9,j]<>'' then
      sum:=sum+strtofloat(stringgrid1.Cells[9,j]);
   edit6.Text:=floattostr(sum);
   //----------------ͳ�ƺϼƲ���˰��-----------------------
   sum:=0;
   for j:=1 to 20 do
   if  stringgrid1.Cells[10,j]<>'' then
      sum:=sum+strtofloat(stringgrid1.Cells[10,j]);
   edit5.Text:=floattostr(sum);

end;
end;


//---------------��ѡȡ�ֿ���������ʱ����ʾ�ֿ��������б�--------------
//-------------------�����òֿ������ݴʵ�-------------------------------
procedure Toutput.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

//------------------�ֿ��������б����ʾ����긽��-----------------
if (currentCol=5)and(stringgrid1.Cells[2,currentRow]<>'') then
   begin
   combobox3.Visible:=true;
   combobox3.Left:=X;
   combobox3.Top:=Y+120;
 //------------------------������ݴʵ�-----------------------
 //------------------ע��ͽ������Ĳ�֮ͬ��-------------------
 //-------------�����Ǹ�����Ʒ�ı������ѯ���������Ʒ�Ĳֿ�-------
 adoquery1.Close;
 adoquery1.SQL.Clear;
 adoquery1.SQL.Add('select distinct �ֿ� from ���� where ����='''+stringgrid1.Cells[1,currentRow]+'''');
 adoquery1.Open;
 combobox3.Items.Clear;
 while not adoquery1.Eof do
  begin
  combobox3.Items.Add(adoquery1.FieldByName('�ֿ�').AsString);
  adoquery1.Next;
  end;
  end;
end;

//------------------��ѡȡ��ֵ��ӵ�stringgrid��Ԫ���������б��--------------
procedure Toutput.ComboBox3Select(Sender: TObject);
begin
if currentCol=5 then
begin
 stringgrid1.Cells[5,currentRow]:=combobox3.Text;
 combobox3.Visible:=false;
 combobox3.Items.Clear;
end;
end;


//----------˫�������ж�����Ʒ��Ϣ----------------------
procedure Toutput.StringGrid1DblClick(Sender: TObject);

begin
//--------ֻ�����ڵ�һ���ɡ���˫��������ʾ��˫��----------
if currentCol=1 then
begin
//---------------��ʾ����嵥---------------------------
manage.button4.click;
//-------------��ʾ��Ʒ�嵥ʱ��������Խ�����������в���------
output.Enabled:=false;
end;
end;

//----------------��̬��ӿͻ����ݴʵ�-----------------------
//--------�ͻ����ϴ�����˫���������ݹ��ܼ��ͻ����ϴ���Ĵ���--------
procedure Toutput.ComboBox2DropDown(Sender: TObject);
begin
//��ʾ�ͻ��嵥
 info.visible:=true;
 info.N4.Click;
//��ʾ�ͻ��嵥ʱ��������Խ�����������в���
 output.Enabled:=false;

end;



//---------------������ʾʱ���õ�ǰֵ-------------------------
procedure Toutput.FormShow(Sender: TObject);
begin
//�Ʊ��¼�Ϊ��ǰ����
edit1.Text:=datetostr(date);
//�Ƶ��˼���¼�û�
edit2.Text:=manage.StatusBar1.Panels[0].Text;
currentRow:=1;
currentCol:=1;
end;

//----------------�رմ���ʱ�򿪹�����----------------------------
procedure Toutput.FormClose(Sender: TObject; var Action: TCloseAction);
var
i,j:integer;
begin
manage.show;

end;

//-----------------�������۵������۵���ϸ����-------------------------
procedure Toutput.Button1Click(Sender: TObject);
var
maxnum,maxnum2,temp,inputnum,inputnum2:string;
newnum,newnum2,i:integer;
begin
  //�������۵�������ţ��Ա�����µ����۵�����ʱ��Ų���ͻ
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select max(���) ����� from ���۵�');
  adoquery1.Open;
  maxnum:=adoquery1.FieldByName('�����').asstring;

//�Զ����ı�Ž��н�ȡ������ת��Ϊ����ֵ���ֶ�̫��ʱ���Բ�����strtoint��ת��
 //��ֹ�����һ����¼ʱ����
    if (maxnum='')or(maxnum=' ') then
   temp:='00000'
   else
   temp:=copy(maxnum,1,5);
   //�²�������۵����Ϊ����ǰ�������+1
    newnum:=strtoint(temp)+1;
//������ϱ���
if length(inttostr(newnum))=1 then
 inputnum:='0000'+inttostr(newnum);
if length(inttostr(newnum))=2 then
 inputnum:='000'+inttostr(newnum);
if length(inttostr(newnum))=3 then
 inputnum:='00'+inttostr(newnum);
if length(inttostr(newnum))=4 then
 inputnum:='0'+inttostr(newnum);
if length(inttostr(newnum))=5 then
 inputnum:=inttostr(newnum);
//�������۵���ϸ������Ա�����µ����۵���ϸ����ʱ��Ų���ͻ
   adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select max(���) ����� from ���۵���ϸ');
  adoquery1.Open;
  maxnum2:=adoquery1.FieldByName('�����').asstring;

//��ֹ�����һ����¼ʱ����
    if (maxnum2='')or(maxnum2=' ') then
   temp:='00000'
   else
   temp:=copy(maxnum2,1,5);
   newnum2:=strtoint(temp);

//�������۵���ϸ���ݿ����ɺܶ���������������ѭ�������۵���ϸѭ�����ٱ�ź���ϱ���



  //-----------�����µ����۵������۵���ϸ-----------------------------
  //����ͻ���Ϊ�ջ���ʱû�����۵���ϸ���ݣ���ȡ������
  if (combobox2.Text='')or(edit4.Text='') then
  showmessage('�ͻ��Ų���Ϊ�գ������۵���ϸ���ݱ�������')
  else
  begin
   //�����µ����۵�����
   adocommand1.CommandText:='insert into ���۵�([���],[�ͻ����],[��������],[ҵ��Ա],[�Ƶ���],[˰�ۺϼ�],[����˰��],[˰��]) values('''+inputnum+''','''+combobox2.Text+''','''+edit1.Text+''','''+combobox1.Text+''','''+edit2.Text+''','''+edit4.Text+''','''+edit5.Text+''','''+edit6.Text+''')';
   adocommand1.Execute;
      //�������۵���ϸ��Ŀ���������������۵���ϸ����
   for i:=1 to 20 do
    if stringgrid1.Cells[7,i]<>'' then
     //������ϱ���
     begin
     newnum2:=newnum2+1;
     if length(inttostr(newnum2))=1 then
      inputnum2:='0000'+inttostr(newnum2);
     if length(inttostr(newnum2))=2 then
      inputnum2:='000'+inttostr(newnum2);
     if length(inttostr(newnum2))=3 then
      inputnum2:='00'+inttostr(newnum2);
     if length(inttostr(newnum2))=4 then
      inputnum2:='0'+inttostr(newnum2);
     if length(inttostr(newnum2))=5 then
      inputnum2:=inttostr(newnum2);
     adocommand1.CommandText:='insert into ���۵���ϸ([���],[���۵���],[����],[��������],[���ۼ�],[˰�ۺϼ�],[˰��],[����˰��],[˰��],[�ֿ�]) values('''+inputnum2+''','''+inputnum+''','''+stringgrid1.Cells[1,i]+''','''+stringgrid1.Cells[4,i]+''','''+stringgrid1.Cells[6,i]+''','''+stringgrid1.Cells[7,i]+''','''+stringgrid1.Cells[8,i]+''','''+stringgrid1.Cells[10,i]+''','''+stringgrid1.Cells[9,i]+''','''+stringgrid1.Cells[5,i]+''')';
     adocommand1.Execute;
     end;
  //֪ͨ�û��������ɹ�
   showmessage('���۵�����ϸ����ɹ�');

  end;

end;
//------------------�ύ���۵�----------------------------------
//---------����Ԥ������ӡ�������������ȫһ��--------------------
procedure Toutput.Button3Click(Sender: TObject);
var
i,j:integer;
begin
adocommand1.CommandText:='exec sf_���۵�';
adocommand1.Execute;
showmessage('���۵�����ɹ�');
//���ǰ�������
for i:=1 to 10 do
 for j:=1 to 20 do
  stringgrid1.Cells[i,j]:='';
combobox1.Text:='';
combobox2.Text:='';
edit3.Clear;
edit4.Clear;
edit5.Clear;
edit6.Clear;
end;

end.
