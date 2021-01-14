unit DocuInputForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Grids, DBGrids, ExtCtrls, StdCtrls,
  Buttons, DB, ADODB, DBCtrls, Mask,mainform;

type
  TDocuInput = class(TForm)
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
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    DBComboBox1: TDBComboBox;
    DBEdit4: TDBEdit;
    Label11: TLabel;
    DBEdit5: TDBEdit;
    Label12: TLabel;
    DBEdit6: TDBEdit;
    Label13: TLabel;
    DBEdit7: TDBEdit;
    DataSource2: TDataSource;
    ADOQuery2: TADOQuery;
    Panel3: TPanel;
    ADOQuery3: TADOQuery;
    StringGrid1: TStringGrid;
    ADOCommand1: TADOCommand;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);

    procedure BitBtn4Click(Sender: TObject);
    procedure DBEdit9Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1DblClick(Sender: TObject);




  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetToolBar(isEnable:bool);
    procedure SumAccount();
    //��ִ�������ͱ༭�󣬱���ʱִ�в�ͬ�Ĵ���
    procedure OpType(opname:string);
  end;
//�Խ�Ҫ��dll�еĵ��õĺ���������
type
Tshowdllform=function(Ahandle:Thandle;Acaption:string;tablename:string):string;stdcall;
Ttable=array[1..20] of string;
var
  DocuInput: TDocuInput;
  maxnum,recordnum,curRow,curCol:integer;
  mytable:Ttable;
  op:string;


implementation

{$R *.dfm}

procedure TDocuInput.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;

//----------------��ʼ����----------------------
procedure TDocuInput.DataSource1DataChange(Sender: TObject;
  Field: TField);
  var
  i,j:integer;
begin

  //�������ݱ���
  dbgrid1.Columns[0].Width:=48;
  dbgrid1.Columns[1].Width:=64;
  dbgrid1.Columns[2].Width:=64;

  //��ʾ��ƾ֤��Ŷ�Ӧ�ķ�¼��
  adoquery2.Close;
  adoquery2.SQL.Clear;
  adoquery2.SQL.Add('select distinct a.*,c.��Ŀ���� from ��¼�� a,ƾ֤�� b,��Ŀ�� c where (a.ƾ֤���='''+dbedit1.Text+''')and(a.��Ŀ����=c.��Ŀ����) order by ���');
  adoquery2.Open;
  //��ʼ������������
  for i:=1 to 20 do
   for j:=0 to 4 do
    if op<>'insert' then
    stringgrid1.Cells[j,i]:='';

  //����¼�����ݶ�����,�������������Թ���������ݿ����ʹ��
  i:=1;
  recordnum:=0;
  while not adoquery2.Eof do
  begin
   stringgrid1.Cells[0,i]:=adoquery2.fieldbyname('��Ŀ����').AsString;
   stringgrid1.Cells[1,i]:=adoquery2.fieldbyname('��Ŀ����').AsString;
   stringgrid1.Cells[2,i]:=adoquery2.fieldbyname('�跽').AsString;
   stringgrid1.Cells[3,i]:=adoquery2.fieldbyname('����').AsString;
   stringgrid1.Cells[4,i]:=adoquery2.fieldbyname('ժҪ').AsString;
   mytable[i]:=adoquery2.fieldbyname('���').AsString;
   i:=i+1;
   recordnum:=recordnum+1;
   adoquery2.Next;

  end;
  //���÷�¼����п��
  stringgrid1.ColWidths[0]:=48;
  stringgrid1.ColWidths[1]:=116;
  stringgrid1.ColWidths[2]:=64;
  stringgrid1.ColWidths[3]:=64;
  stringgrid1.ColWidths[4]:=150;
  //��ʾƾ֤��
  label2.Caption:=inttostr(datasource1.DataSet.RecordCount);
  
end;

//-----------------���ù�������ť--------------------
procedure TDocuInput.SetToolBar(isEnable: bool);
begin
 if isEnable=true then
  begin
   //���׼�¼�ȼ�¼�ƶ���ť����Ϊ������
   toolbutton1.Enabled:=false;
   toolbutton2.Enabled:=false;
   toolbutton3.Enabled:=false;
   toolbutton4.Enabled:=false;
   //�������޸ĵȰ�ť����Ϊ������
   toolbutton6.Enabled:=false;
   toolbutton7.Enabled:=false;
   toolbutton8.Enabled:=false;
   //�������ȡ����ť����Ϊ����
   toolbutton10.Enabled:=true;
   toolbutton11.Enabled:=true;
   //�������ڵ�������ʾ�ؼ���Ϊ���޸�
   dbedit2.Enabled:=true;
   dbedit3.Enabled:=true;
   dbcombobox1.Enabled:=true;
   stringgrid1.Enabled:=true;
   dbgrid1.Enabled:=false;


 end;

 if isEnable=false then
  begin
   //���׼�¼�ȼ�¼�ƶ���ť����Ϊ����
   toolbutton1.Enabled:=true;
   toolbutton2.Enabled:=true;
   toolbutton3.Enabled:=true;
   toolbutton4.Enabled:=true;
   //�������޸ĵȰ�ť����Ϊ����
   toolbutton6.Enabled:=true;
   toolbutton7.Enabled:=true;
   toolbutton8.Enabled:=true;
   //�������ȡ����ť����Ϊ������
   toolbutton10.Enabled:=false;
   toolbutton11.Enabled:=false;
   //�������ڵ�������ʾ�ؼ���Ϊ�����޸�

   dbedit2.Enabled:=false;
   dbedit3.Enabled:=false;
   dbcombobox1.Enabled:=false;
   dbgrid1.Enabled:=true;
   stringgrid1.Enabled:=false;


  end;


end;

//---------------������¼----------------
procedure TDocuInput.ToolButton6Click(Sender: TObject);
var
totalnum:string;


begin

//ˢ�����ݣ��õ�ƾ֤�����������벢��һ����ֹ�����ظ�
adoquery3.Close;
adoquery3.SQL.Clear;
adoquery3.SQL.Add('select max(ƾ֤���) ����� from ƾ֤��');
adoquery3.Open;
totalnum:=adoquery3.FieldByName('�����').Asstring;
totalnum:=copy(totalnum,1,6);
if totalnum='' then totalnum:='0';
totalnum:=inttostr(strtoint(totalnum)+1);


//��ʼ����
SetToolBar(true);
datasource1.DataSet.Insert;

//�����λ��ƾ֤����
if length(totalnum)=1 then
 dbedit1.Text:='00000'+totalnum;
if length(totalnum)=2 then
 dbedit1.Text:='0000'+totalnum;
if length(totalnum)=3 then
 dbedit1.Text:='000'+totalnum;


//Ĭ��ƾ֤�ֺ�
dbcombobox1.SelText:='��';
//���뵱ǰ����
dbedit2.Text:=datetostr(date);
// Ĭ�ϻ���ڼ�
main.setpara;
dbedit4.Text:=main.para[2];
//Ĭ�Ϲ���״̬
dbedit5.Text:='δ��';
//���ò�������
op:='insert';




end;

//---------------�޸ļ�¼----------------
procedure TDocuInput.ToolButton7Click(Sender: TObject);
begin
SetToolBar(true);
datasource1.DataSet.Edit;
//���ò�������
op:='edit';

end;

//---------------ɾ����¼----------------
procedure TDocuInput.ToolButton8Click(Sender: TObject);
begin
 if application.MessageBox('ɾ��������¼��','�������ϵͳ',MB_OKCANCEL)=IDOK then
  begin
    //��ɾ����¼���¼����ɾ��ƾ֤��¼
    adocommand1.CommandText:='delete from ��¼�� where ƾ֤���='''+dbedit1.Text+'''';
    adocommand1.Execute;
    datasource1.DataSet.Delete;
  end;
end;

//---------------�׼�¼----------------
procedure TDocuInput.ToolButton1Click(Sender: TObject);
begin
 datasource1.DataSet.First;


end;

//---------------�ϼ�¼----------------
procedure TDocuInput.ToolButton2Click(Sender: TObject);
begin
 datasource1.DataSet.Prior;

end;

//---------------�¼�¼----------------
procedure TDocuInput.ToolButton3Click(Sender: TObject);
begin
 datasource1.DataSet.Next;

end;

//---------------β��¼----------------
procedure TDocuInput.ToolButton4Click(Sender: TObject);
begin
 datasource1.DataSet.Last;

end;

procedure TDocuInput.ToolButton13Click(Sender: TObject);
begin
close;
end;

//---------------�����¼----------------
procedure TDocuInput.ToolButton10Click(Sender: TObject);
begin
  if dbedit6.Text<>dbedit7.Text then
   showmessage('���˫����ƽ�⣬����')
  else
  begin
   if op='insert' then
    begin
    datasource1.DataSet.Post;
    opType(op);
    end;
   if op='edit' then
    begin
    opType(op);
    datasource1.DataSet.Post;
    end;
  SetToolBar(false);
  //���������ʶ��
  op:='';
  end;
end;

//---------------ȡ������----------------
procedure TDocuInput.ToolButton11Click(Sender: TObject);
begin
  datasource1.DataSet.Cancel;
  SetToolBar(false);
    //���������ʶ��
  op:='';
end;

//----------��ѯ���ݲ���ʾ-------------
procedure TDocuInput.BitBtn1Click(Sender: TObject);
begin
adoquery1.Close;
adoquery1.SQL.Clear;
adoquery1.SQL.Add('select * from ƾ֤�� where (ƾ֤��� like ''%'+edit1.Text+'%'')and');
adoquery1.SQL.Add('(����ڼ� like ''%'+edit2.Text+'%'')and(���� like ''%'+edit3.Text+'%'')');
adoquery1.Open;

end;




//----------------Ϊƾ֤¼���¼��-----------------
procedure TDocuInput.BitBtn4Click(Sender: TObject);
begin
 datasource2.DataSet.Delete;
end;


//----------ͳ�Ʒ�¼���еĸ�����Ϣ�Դ��浽���ݿ�----------
procedure TDocuInput.SumAccount;
var
sumoutput,suminput:double;
i:integer;
begin
suminput:=0;
sumoutput:=0;
//ͳ�ƽ��˫��������
for i:=1 to 20 do
  if (stringgrid1.Cells[2,i]<>'')and(stringgrid1.Cells[3,i]<>'') then
    begin
     suminput:=suminput+strtofloat(stringgrid1.Cells[2,i]);
     sumoutput:=sumoutput+strtofloat(stringgrid1.Cells[3,i]);
    end;
dbedit6.Text:=floattostr(suminput);
dbedit7.Text:=floattostr(sumoutput);
end;

procedure TDocuInput.DBEdit9Exit(Sender: TObject);
begin
SumAccount;
end;


//------------���÷�¼���ͷ-------
procedure TDocuInput.FormShow(Sender: TObject);
begin
  stringgrid1.Cells[0,0]:='��Ŀ����';
  stringgrid1.Cells[1,0]:='��Ŀ����(˫��ѡ��)';
  stringgrid1.Cells[2,0]:='�跽';
  stringgrid1.Cells[3,0]:='����';
  stringgrid1.Cells[4,0]:='ժҪ';
end;





//----���ڷ�¼��������ʱ���������������п��е�����������µ�һ������----
procedure TDocuInput.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
//��ֹ����������ʱ�����п���
if stringgrid1.Cells[0,Arow-1]='' then
 begin
  showmessage('������������пյ���Ŀ');
  exit;
 end;
//����ѡȡ�ĵ�Ԫ����ֵ
curRow:=ARow;
curCol:=ACol;
if (curCol<=4)and(curCol>=2) then
  stringgrid1.Options:=stringgrid1.Options+[goEditing];
//��ֹѡ�б�����
if ARow=0 then curRow:=ARow+1;
//ͳ�ƽ��˫����Ϣ
sumAccount();

end;

//---�������¼��ʱ����dll�еı��ѡ���Ŀ���ƺͺ��� -----
procedure TDocuInput.StringGrid1DblClick(Sender: TObject);
var
showForm:TShowDllForm;
module:Thandle;

begin
 //ֻ��˫��ָ���в���Ч
 if curCol<>1 then exit;
 //����dll
 module:=loadlibrary('sec.dll');
 //������������module����һ��С��32�Ĵ������
 //�ɴ˿����ж��Ƿ����ɹ�
 if module<32 then exit;
 @showForm:=getprocaddress(module,pchar(1));
 if @showForm=nil then exit;

 //ͨ��dll���ݲ���
 stringgrid1.Cells[0,curRow]:=showForm(application.Handle,'ѡ���Ŀ����','��Ŀ��');

 //Ϊ��Ŀ������ӿ�Ŀ����
 adoquery3.Close;
 adoquery3.SQL.Clear;
 adoquery3.SQL.Add('select ��Ŀ���� from ��Ŀ�� where ��Ŀ����='''+stringgrid1.Cells[0,curRow]+'''');
 adoquery3.Open;
 stringgrid1.Cells[1,curRow]:=adoquery3.fieldbyname('��Ŀ����').AsString;
 stringgrid1.Cells[2,curRow]:='0';
 stringgrid1.Cells[3,curRow]:='0';

end;

//---------------------�Է�¼����в�����޸�ʱ��ִ�еĲ���--------------------------
procedure TDocuInput.OpType(opname: string);
var
 i:integer;
 inputval,outputval,oldnum:string;
begin
//���������ƾ֤����ֱ�ӽ���¼���е�������������
  if opname='insert' then
   begin
     for i:=1 to 20 do
      begin
      //��������Ϊ�գ�������ѭ��
       if stringgrid1.Cells[0,i]='' then continue;
       inputval:=stringgrid1.cells[2,i];
       outputval:=stringgrid1.cells[3,i];
       //�������ݣ����ڽ跽�ʹ���������sql server��Ϊmoney������Ҫ����ת��
       adocommand1.CommandText:='insert into ��¼��([ƾ֤���],[��Ŀ����],[�跽],[����],[ժҪ]) values('''+dbedit1.Text+''','''+stringgrid1.Cells[0,i]+''',cast('''+inputval+''' as money),cast('''+outputval+''' as money),'''+stringgrid1.Cells[4,i]+''')';
       adocommand1.Execute;
      end;
   end;
  if opname='edit' then
   begin
     for i:=1 to 20 do
      begin
       if stringgrid1.Cells[0,i]='' then continue;
       inputval:=stringgrid1.cells[2,i];
       outputval:=stringgrid1.cells[3,i];
       //��ƾ֤�����ķ�¼��ԭ�����ݽ��и���
       if i<=recordnum then
       adocommand1.CommandText:='update ��¼�� set [��Ŀ����]='''+stringgrid1.cells[0,i]+''',[�跽]=cast('''+inputval+''' as money),[����]=cast('''+outputval+''' as money),[ժҪ]='''+stringgrid1.Cells[4,i]+''' where ���='''+mytable[i]+''''
       else
       //����ƾ֤�����ķ�¼���е�������
       adocommand1.CommandText:='insert into ��¼��([ƾ֤���],[��Ŀ����],[�跽],[����],[ժҪ]) values('''+dbedit1.Text+''','''+stringgrid1.Cells[0,i]+''',cast('''+inputval+''' as money),cast('''+outputval+''' as money),'''+stringgrid1.Cells[4,i]+''')';
       adocommand1.Execute;
      end;
   end;

end;





end.




