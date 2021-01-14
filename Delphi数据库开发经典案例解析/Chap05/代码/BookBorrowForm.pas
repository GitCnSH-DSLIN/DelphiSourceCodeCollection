unit BookBorrowForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, StdCtrls, ExtCtrls, Grids, DB, ADODB,
  Mask, DBCtrls;

type
  TBookBorrow = class(TForm)
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    Edit1: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Edit5: TEdit;
    Label2: TLabel;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    ADOQuery2: TADOQuery;
    Label6: TLabel;
    Label7: TLabel;
    ADOCommand1: TADOCommand;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     //�ѽ�������Ŀ,���ν�����Ŀ�Ϳɽ���ʱ��
     booknum,thisbook,keeptime:integer;
     //������߱��
     usernum:string;
    procedure cleargrid();

  end;

var
  BookBorrow: TBookBorrow;

implementation

{$R *.dfm}


procedure TBookBorrow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;


//-----------���������Ϣ--------------
procedure TBookBorrow.Edit1KeyPress(Sender: TObject; var Key: Char);
var
name:string;
num:string;
i:integer;
begin
 //ȷ�����ĸ��ֶν��в�ѯ

 if radiobutton1.Checked then
  name:=radiobutton1.Caption;
 if radiobutton2.Checked then
  name:=radiobutton2.Caption;
  //��ս�����Ϣ
  booknum:=0;
  thisbook:=0;
  label6.Caption:='�ѽ���'+inttostr(booknum)+'��';
  label7.Caption:='���ν���'+inttostr(thisbook)+'��';

if key=#13 then
  begin
    //��ʾ������Ϣ
    adoquery1.Close;
    adoquery1.SQL.Clear;
    adoquery1.SQL.Add('select a.*,b.ͼ����� from ������Ϣ a,�������� b where (a.'+name+'='''+edit1.Text+''')and(a.����=b.����)');
    adoquery1.Open;
    //���������Ϣ
    usernum:=adoquery1.fieldbyname('���').AsString;

    //���Ķ����Ѿ����ĵ������Ϣ
    num:=adoquery1.FieldByName('���').AsString;
    adoquery2.Close;
    adoquery2.SQL.Clear;
    adoquery2.SQL.Add('select a.*,b.����,b.������,b.�۸� from ͼ����� a,ͼ����Ϣ b where (���߱��='''+num+''')and(a.ͼ����=b.���)and(a.״̬=''δ��'')');
    adoquery2.Open;
    i:=1;
    //�����ĵ����Ѿ��������δ���������Ϣ��ʾ�ڱ����

    cleargrid();
    while not adoquery2.Eof do
     begin
      stringgrid1.Cells[0,i]:=adoquery2.fieldbyname('״̬').AsString;
      stringgrid1.Cells[1,i]:=adoquery2.fieldbyname('ͼ����').AsString;
      stringgrid1.Cells[2,i]:=adoquery2.fieldbyname('����').AsString;
      stringgrid1.Cells[3,i]:=adoquery2.fieldbyname('����ʱ��').AsString;
      stringgrid1.Cells[4,i]:=adoquery2.fieldbyname('Ӧ��ʱ��').AsString;
      stringgrid1.Cells[5,i]:=adoquery2.fieldbyname('������').AsString;
      stringgrid1.Cells[6,i]:=adoquery2.fieldbyname('�۸�').AsString;
      i:=i+1;
      adoquery2.Next;
     end;
     //��ʾ�ѽ��δ����Ϣ
     booknum:=i-1;
     label6.Caption:='�ѽ���'+inttostr(booknum)+'��';
     //������Ķ�����Ϣ��ȷʱ����������ͼ����Ϣ����
     if dbedit3.Text<>'' then
     groupbox2.Enabled:=true
     else
     groupbox2.Enabled:=false;
     //�����������ͼ�������ı���
     edit5.SetFocus;

  end;
end;

//���stringgrid�е�ֵ
procedure TBookBorrow.cleargrid;
var
i,j:integer;
begin
 for i:=1 to 11 do
  for j:=0 to 6 do
   stringgrid1.Cells[j,i]:='';
end;


//-----------���߽���--------------
procedure TBookBorrow.Edit5KeyPress(Sender: TObject; var Key: Char);
var
name:string;
booktype:string;
i:integer;
begin
  //ȷ�����ĸ��ֶν��в�ѯ
  if radiobutton3.Checked then
  name:=radiobutton3.Caption;
 if radiobutton4.Checked then
  name:=radiobutton4.Caption;

  //���������ͼ����Ϣ����������½����ͼ����Ϣ
  if key=#13 then
   begin
    //���ѽ����ͼ�������ﵽ�����������ƣ�����ʾ�������������ٽ���
    if booknum-strtoint(dbedit3.text)>=0 then
     begin
       showmessage('�ﵽ�����������ޣ����ȹ黹ͼ���ٽ���');
       exit;
     end;
    adoquery2.Close;
    adoquery2.SQL.Clear;
    adoquery2.SQL.Add('select * from ͼ����Ϣ where '+name+'='''+edit5.Text+'''');
    adoquery2.Open;
    if adoquery2.FieldByName('���').AsString<>'' then
     begin
     //�ж��Ƿ�����ѽ��и��飬������У��������ٽ�
     for i:=1 to 12 do
      if stringgrid1.Cells[1,i]=adoquery2.FieldByName('���').AsString then
       begin
         showmessage('�����ѽ��и��飬�������ٽ�');
         edit5.Clear;
         exit;
       end;


      //����ͼ����Ϣ
      stringgrid1.Cells[0,booknum+1]:='�½�';
      stringgrid1.Cells[1,booknum+1]:=adoquery2.fieldbyname('���').AsString;
      stringgrid1.Cells[2,booknum+1]:=adoquery2.fieldbyname('����').AsString;
      stringgrid1.Cells[5,booknum+1]:=adoquery2.fieldbyname('������').AsString;
      stringgrid1.Cells[6,booknum+1]:=adoquery2.fieldbyname('�۸�').AsString;
      booktype:=adoquery2.fieldbyname('����').AsString;
      //����ͼ��Ľ���ʱ��͹黹ʱ��
      adoquery2.Close;
      adoquery2.SQL.Clear;
      adoquery2.SQL.Add('select * from ͼ������ where ��������='''+booktype+'''');
      adoquery2.Open;
      keeptime:=adoquery2.fieldbyname('�ɽ�����').AsInteger;
      stringgrid1.Cells[3,booknum+1]:=datetostr(date);
      stringgrid1.Cells[4,booknum+1]:=datetostr(date+keeptime);
     //���½�����Ϣ
      booknum:=booknum+1;
      thisbook:=thisbook+1;
      label6.Caption:='�ѽ���'+inttostr(booknum)+'��';
      label7.Caption:='���ν���'+inttostr(thisbook)+'��';
      //����ı����Ա�������һ����
      edit5.Clear;
      //���������ȡ���½���ļ�¼
      toolbutton1.Enabled:=true;
      toolbutton2.Enabled:=true;


     end;
   end;


end;






procedure TBookBorrow.FormShow(Sender: TObject);
var
i,j:integer;
begin
  //���ñ�Ŀ�Ⱥͱ�ͷ
  stringgrid1.Cells[0,0]:='״̬';
  stringgrid1.ColWidths[0]:=64;
  stringgrid1.Cells[1,0]:='���';
  stringgrid1.ColWidths[1]:=128;
  stringgrid1.Cells[2,0]:='����';
  stringgrid1.ColWidths[2]:=128;
  stringgrid1.Cells[3,0]:='���ʱ��';
  stringgrid1.ColWidths[3]:=64;
  stringgrid1.Cells[4,0]:='Ӧ��ʱ��';
  stringgrid1.ColWidths[4]:=64;
  stringgrid1.Cells[5,0]:='������';
  stringgrid1.ColWidths[5]:=128;
  stringgrid1.Cells[6,0]:='���';
  stringgrid1.ColWidths[6]:=64;
  //�����ѽ�����Ϣ�ͱ��ν�����Ϣ
  booknum:=0;
  thisbook:=0;
  label6.Caption:='�ѽ���'+inttostr(booknum)+'��';
  label7.Caption:='���ν���'+inttostr(thisbook)+'��';


end;

//------------ȷ�����飬�����ݿ��в����¼�¼---------
procedure TBookBorrow.ToolButton1Click(Sender: TObject);
var
i:integer;
maxnum:integer;
begin
//�Զ�ȷ�����ı��
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select max(���ı��) ����� from ͼ�����');
adoquery2.Open;
maxnum:=adoquery2.FieldByName('�����').AsInteger;
maxnum:=maxnum+1;
//�����ݱ�ͼ����ġ��Ĳ������
adocommand1.commandtext:='SET IDENTITY_INSERT ͼ����� on';
adocommand1.execute;
//��������״̬δ�½��ͼ��
 for i:=1 to 12 do
   if stringgrid1.Cells[0,i]='�½�' then
    begin
      adocommand1.CommandText:='insert into ͼ�����([���ı��], [ͼ����], [���߱��], [����ʱ��], [Ӧ��ʱ��], [�������],  [״̬]) values('''+inttostr(maxnum)+''','''+stringgrid1.Cells[1,i]+''','''+usernum+''','''+stringgrid1.Cells[3,i]+''','''+stringgrid1.cells[4,i]+''',''0'',''δ��'')';
      adocommand1.Execute;
      maxnum:=maxnum+1;
    end;
//�رղ�����ɲ��رա�ȷ�����顿��ť
adocommand1.commandtext:='SET IDENTITY_INSERT ͼ����� off';
adocommand1.execute;
toolbutton1.Enabled:=false;
toolbutton2.Enabled:=false;
groupbox2.Enabled:=false;
cleargrid();
edit5.Clear;
edit1.Clear;

end;
//---------ȡ������--------------
procedure TBookBorrow.ToolButton2Click(Sender: TObject);
begin
toolbutton1.Enabled:=false;
toolbutton2.Enabled:=false;
groupbox2.Enabled:=false;
cleargrid();
edit5.Clear;
edit1.Clear;
end;
//---------�˳�ͼ����Ĵ���--------------
procedure TBookBorrow.ToolButton3Click(Sender: TObject);
begin
  if toolbutton1.Enabled=true then
   if application.MessageBox('��δ��������¼���Ƿ�ֱ���˳���','ȷ���˳�',MB_OKCANCEL)=IDOK then
     close;
  if toolbutton1.Enabled=false then
   close;
end;

end.
