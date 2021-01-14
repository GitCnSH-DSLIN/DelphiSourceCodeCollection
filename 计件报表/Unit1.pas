unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ToolWin, ComCtrls, OleServer, Excel2000, DB,
  ADODB, Grids, DBGrids, ImgList, Mask, ExtCtrls;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    B_1: TBitBtn;
    B_3: TBitBtn;
    B_2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    E_2: TEdit;
    C_2: TComboBox;
    DateTimePicker1: TDateTimePicker;
    C_1: TComboBox;
    E_3: TEdit;
    E_1: TEdit;
    RadioGroup1: TRadioGroup;

    function Doadosql(q:TADOQuery;sql:string):TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ToolButton4Click(Sender: TObject);
    procedure E_1Enter(Sender: TObject);
    procedure B_1Enter(Sender: TObject);
    procedure B_1Click(Sender: TObject);
    procedure E_1Click(Sender: TObject);
    procedure B_2Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure B_3Click(Sender: TObject);
    procedure E_1KeyPress(Sender: TObject; var Key: Char);
    procedure RadioGroup1Click(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure C_1KeyPress(Sender: TObject; var Key: Char);
    procedure C_1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure E_1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure C_2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DateTimePicker1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    function getdir:string;
    procedure C_2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  q1,pro_q:TADOQuery;
  connstr:string;
implementation

uses Unit2, Unit3, Unit4;

{$R *.dfm}

function TForm1.getdir:string;
begin
  result:=ExtractFileDir(Application.Exename)+'\';
end;

function SSWR(s: real): real; 
var
r1, r2: real; 
s1, s2: string; 
begin 
r1 := int(s); 
r2 := frac(s); 
s1 := copy(floattostr(r1), 1, length(floattostr(r1))); 
if length(floattostr(r2)) >= 5 then 
begin 
if strtoint(copy((floattostr(r2)), 5, 1)) >= 5 then 
if strtoint(copy((floattostr(r2)), 4, 1)) = 9 then 
if strtoint(copy((floattostr(r2)), 3, 1)) = 9 then 
begin 
s1 := inttostr(strtoint(s1) + 1); 
s2 :='';
end 
else 
S2 := inttostr(strtoint(copy((floattostr(r2)), 3, 1)) + 1) 
else if copy((floattostr(r2)), 3, 1) = '0' then 
S2 := '0' + inttostr(strtoint(copy(floattostr(r2), 3, 2)) + 1) 
else s2 := inttostr(strtoint(copy(floattostr(r2), 3, 2)) + 1) 
else s2 := copy(floattostr(r2), 3, 2); 
end 
else s2 := copy(floattostr(r2), 3, 2); 
result := strtofloat(s1 + '.' + s2); 
end; 



function TForm1.Doadosql(q:TADOQuery;sql:string):TADOQuery;
begin

 q:=TADOQuery.Create(nil);
 q.ConnectionString:=connstr;
 q.Close;
 q.SQL.Clear;
 q.SQL.Add(sql);
 q.Open;
 result:=q;

end;


procedure TForm1.FormCreate(Sender: TObject);

begin
  connstr:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+getdir+'data.mdb;Persist Security Info=False';

  pro_q:=Doadosql(pro_q,'select * from Ʒ�� ');
  form1.C_1.Clear;
  while not pro_q.Eof do
    begin
      form1.C_1.Items.Add(pro_q.FieldByName('product').AsString);
      pro_q.Next;
    end;

  form1.C_2.Clear;
  form1.C_2.Items.LoadFromFile(getdir+'gr.dat');


  form1.DateTimePicker1.Date:=date();
  form1.RadioGroup1.Items.Strings[0]:=datetostr(date());

  //�г����ڼ�¼
  q1:=Doadosql(q1,'select id,date as ����,name as ����,product as Ʒ��,good_count as ��Ʒ��,dj as ����,je as ��� from ���� where Date=#'+datetostr(form1.DateTimePicker1.Date)+'#');
  form1.DataSource1.DataSet:=q1;
  form1.DBGrid1.DataSource:=form1.DataSource1;


end;

procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

 if Column.Width<>70 then
        Column.Width:=70;



end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
form2.ShowModal;
end;

procedure TForm1.E_1Enter(Sender: TObject);
begin

E_1.SelStart:=0;
E_1.SelectAll;

end;

procedure TForm1.B_1Enter(Sender: TObject);  //����Ƿ���д����
var
  Dj_q:TADOQuery;
begin
  Dj_q:=Doadosql(Dj_q,'select * from Ʒ�� where product='''+form1.C_1.Text+'''');
  form1.E_2.Clear;
  if not Dj_q.Eof then
      form1.E_2.Text:=Dj_q.FieldByName('Dj').AsString
  else begin
       showmessage('�����Ʒ����Ч!');
       C_1.SetFocus;
       abort;
       end;
if pos(' ',trim(E_1.Text))>0 then
   begin
    showmessage('��Ʒ�����ܰ����ո�!');
    E_1.SetFocus;
    abort;
   end;

if trim(E_1.Text)<>'' then
   E_3.Text:=floattostr(SSWR(strtofloat(trim(E_1.Text))*strtofloat(E_2.text)))
else
   begin
   showmessage('��������Ʒ��!');
   E_1.SetFocus;
   abort;
end;


if trim(C_1.Text)='' then
 begin
  showmessage('������Ʒ��!');
  C_1.SetFocus;
  abort;
 end;

if trim(C_2.Text)='' then
 begin
  showmessage('�����빤������!');
  C_2.SetFocus;
  abort;
 end;


end;

procedure TForm1.B_1Click(Sender: TObject);
begin

  B_1Enter(Sender); //����Ƿ���д����

  q1.Append;
  q1.FieldByName('����').AsString:=datetostr(form1.DateTimePicker1.Date);
  q1.FieldByName('Ʒ��').AsString:=form1.C_1.Text;
  q1.FieldByName('��Ʒ��').AsString:=trim(form1.E_1.Text);
  q1.FieldByName('����').AsString:=form1.C_2.Text;
  q1.FieldByName('����').AsString:=form1.E_2.Text;
  q1.FieldByName('���').AsString:=form1.E_3.Text;
  q1.Post;
  q1.Last;

  E_1.Clear;
  C_1.SetFocus;

end;

procedure TForm1.E_1Click(Sender: TObject);
begin
E_1.SelStart:=0;
end;

procedure TForm1.B_2Click(Sender: TObject); //�޸ġ������¼
begin
if (not q1.IsEmpty) and (B_2.Caption='�޸�') then
   begin

     form1.DateTimePicker1.Date:=q1.fieldbyname('����').AsDateTime;
     form1.RadioGroup1.Items.Strings[0]:=datetostr(form1.DateTimePicker1.Date);     
     C_1.Text:=q1.fieldbyname('Ʒ��').AsString;
     E_1.Text:=q1.fieldbyname('��Ʒ��').AsString;
     C_2.Text:=q1.fieldbyname('����').AsString;
     E_2.Text:=q1.fieldbyname('����').AsString;
     E_3.Text:=q1.fieldbyname('���').AsString;

     B_2.Caption:='����';
     B_1.Enabled:=false;
     B_3.Enabled:=false;
     C_1.SetFocus;
     abort;
   end;

if B_2.Caption='����' then
   begin
       B_1Enter(Sender);
       q1.Edit;
       q1.FieldByName('����').AsString:=datetostr(form1.DateTimePicker1.Date);
       q1.FieldByName('Ʒ��').AsString:=form1.C_1.Text;
       q1.FieldByName('��Ʒ��').AsString:=trim(form1.E_1.Text);
       q1.FieldByName('����').AsString:=form1.C_2.Text;
       q1.FieldByName('����').AsString:=form1.E_2.Text;
       q1.FieldByName('���').AsString:=form1.E_3.Text;
       q1.Post;
       E_1.Clear;
       B_2.Caption:='�޸�';
       B_1.Enabled:=true;
       B_3.Enabled:=true;
   end;

  C_1.SetFocus;
     
end;


procedure TForm1.DBGrid1CellClick(Column: TColumn);//�ָ���ӵ�״̬
begin

   B_2.Caption:='�޸�';
   B_1.Enabled:=true;
   B_3.Enabled:=true;
   E_1.Clear;
   C_1.Text:='';
   C_2.Text:='';
   E_2.Clear;
   E_3.Clear;

if not q1.IsEmpty then
 begin
   form1.RadioGroup1.Items.Strings[0]:=q1.FieldByName('����').AsString;
   form1.DateTimePicker1.Date:=q1.FieldByName('����').AsDateTime;
 end;
end;

procedure TForm1.B_3Click(Sender: TObject); //ɾ����¼
begin
if not q1.IsEmpty then
    if application.MessageBox('ȷʵҪɾ���˼�¼��','ȷ��',MB_YESNO)=IDYES  then
       q1.Delete;
end;

procedure TForm1.E_1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#8 then
    exit;


  if ((Key < '0') or (Key > '9')) and (Key <>'.') then
    Key :=#10 ;

end;

procedure TForm1.RadioGroup1Click(Sender: TObject); //ѡ���ѯ��ʽ
begin

if form1.RadioGroup1.ItemIndex=1 then
  q1:=Doadosql(q1,'select id,date as ����,name as ����,product as Ʒ��,good_count as ��Ʒ��,dj as ����,je as ��� from ����')
else
  q1:=Doadosql(q1,'select id,date as ����,name as ����,product as Ʒ��,good_count as ��Ʒ��,dj as ����,je as ��� from ���� where Date=#'+datetostr(form1.DateTimePicker1.Date)+'#');

  form1.DataSource1.DataSet:=q1;
  form1.DBGrid1.DataSource:=form1.DataSource1;

  DBGrid1CellClick(nil);  //�ָ���ӵ�״̬

end;

procedure TForm1.DateTimePicker1Change(Sender: TObject);
begin
  form1.RadioGroup1.Items.Strings[0]:=datetostr(form1.DateTimePicker1.Date);
  form1.RadioGroup1.ItemIndex:=0;
  
  RadioGroup1Click(Sender); //ѡ���ѯ��ʽ
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
  DBGrid1CellClick(nil);

  form3.ShowModal;


  pro_q:=Doadosql(pro_q,'select * from Ʒ�� ');
  form1.C_1.Clear;
  while not pro_q.Eof do
    begin
      form1.C_1.Items.Add(pro_q.FieldByName('product').AsString);
      pro_q.Next;
    end;


end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
DBGrid1CellClick(nil);

form4.ShowModal;
form1.C_2.Clear;
form1.C_2.Items.LoadFromFile('gr.dat');

end;

procedure TForm1.C_1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(39) then
   begin
    showmessage('�������뵥���ţ�');
    Key :=#10 ;
   end
end;

procedure TForm1.C_1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then
  E_1.SetFocus;
end;

procedure TForm1.E_1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then
  C_2.SetFocus;

end;

procedure TForm1.C_2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then
  if B_1.Enabled then
     B_1.SetFocus
  else B_2.SetFocus;

end;

procedure TForm1.DateTimePicker1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

if key=13 then
  C_1.SetFocus;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
showmessage(getdir)
end;

procedure TForm1.C_2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=chr(39) then
   begin
    showmessage('�������뵥���ţ�');
    Key :=#10 ;
   end
end;

end.
