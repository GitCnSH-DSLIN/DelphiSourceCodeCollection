unit CalendarForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Mask, DB, Grids, DBGrids, ADODB, ExtCtrls,
  ComCtrls, ToolWin, Buttons;

type
  TCalendar = class(TForm)
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBMemo1: TDBMemo;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn11: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    ToolBar1: TToolBar;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    ToolButton1: TToolButton;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    ToolButton2: TToolButton;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    ToolButton3: TToolButton;
    BitBtn10: TBitBtn;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ADOQuery2: TADOQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    
  private
    { Private declarations }
  public
    { Public declarations }
  maxorder,maxdate,maxyear:integer;
  end;

var
  Calendar: TCalendar;

implementation

uses MainForm;

{$R *.dfm}
 //-----------�رմ���--------------
procedure TCalendar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;

//------------��������--------------
procedure TCalendar.BitBtn1Click(Sender: TObject);
begin
datasource1.DataSet.First;
end;

//------------ǰһ������--------------
procedure TCalendar.BitBtn2Click(Sender: TObject);
begin
datasource1.DataSet.Prior;
end;

//------------��һ������--------------
procedure TCalendar.BitBtn3Click(Sender: TObject);
begin
datasource1.DataSet.Next;
end;

//------------���һ������--------------
procedure TCalendar.BitBtn4Click(Sender: TObject);
begin
datasource1.DataSet.Last;
end;

//----------��������---------------------
procedure TCalendar.BitBtn5Click(Sender: TObject);
begin
datasource1.DataSet.Insert;
//�������ʱ��Ϊ�ұ��ı������Ĭ��ֵ����ֹ��Ӵ��������
maxorder:=adoquery2.fieldbyname('maxorder').AsInteger;
maxdate:=adoquery2.fieldbyname('maxdate').AsInteger;
maxyear:=adoquery2.fieldbyname('maxyear').AsInteger;
dbedit1.Text:=inttostr(maxyear);
dbedit2.Text:=inttostr(maxorder+1);
dbedit3.Text:=inttostr(maxdate+2);

//�����룬ɾ�����޸ĺ��ƶ���ť�رգ���ֹ�������
bitbtn6.Enabled:=false;
bitbtn7.Enabled:=false;
bitbtn1.Enabled:=false;
bitbtn2.Enabled:=false;
bitbtn3.Enabled:=false;
bitbtn4.Enabled:=false;
bitbtn5.Enabled:=false;
//�򿪱����ȡ����ť��ʹ�ܣ����������ȡ��
bitbtn8.Enabled:=true;
bitbtn9.Enabled:=true;
//�����޸��ı���������
dbedit1.ReadOnly:=false;
dbedit2.ReadOnly:=false;
dbedit3.ReadOnly:=false;
dbedit4.ReadOnly:=false;
dbmemo1.ReadOnly:=false;
end;

//----------��ѯ------------------
procedure TCalendar.BitBtn11Click(Sender: TObject);
begin
//��ѯ����
adoquery1.Close;
adoquery1.SQL.Clear;
adoquery1.SQL.Add('select * from �������� where (��� like ''%'+edit1.Text+'%'')and');
adoquery1.SQL.Add('(�ƻ��� like ''%'+edit2.Text+'%'')');
adoquery1.Open;

end;

//---------------��ѯʱ��enter������Ӧ----------------------
procedure TCalendar.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
 bitbtn11.Click;
end;

procedure TCalendar.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
 bitbtn11.Click;
end;

//-----------�������--------------------
procedure TCalendar.BitBtn8Click(Sender: TObject);
begin
//����������ݽ���У��
 if (dbedit1.Text='')or(dbedit2.Text='')or(dbedit3.Text='')or(dbedit4.Text='') then
 showmessage('���벻��Ϊ��')
  else if strtoint(dbedit3.Text)>strtoint(dbedit4.Text) then
 showmessage('��ʼ���ڲ������ڽ�������')
 else
 begin
 datasource1.DataSet.Post;
 //�����룬ɾ�����޸ĺ��ƶ���ť��
bitbtn6.Enabled:=true;
bitbtn7.Enabled:=true;
bitbtn1.Enabled:=true;
bitbtn2.Enabled:=true;
bitbtn3.Enabled:=true;
bitbtn4.Enabled:=true;
bitbtn5.Enabled:=true;
//�رձ����ȡ����ť��ʹ��
bitbtn8.Enabled:=false;
bitbtn9.Enabled:=false;
//�����޸�
dbedit1.ReadOnly:=true;
dbedit2.ReadOnly:=true;
dbedit3.ReadOnly:=true;
dbedit4.ReadOnly:=true;
dbmemo1.ReadOnly:=true;
 end;

end;

//---------------ȡ������-------------------
procedure TCalendar.BitBtn9Click(Sender: TObject);
begin
datasource1.DataSet.Cancel;
 //�����룬ɾ�����޸ĺ��ƶ���ť��
bitbtn6.Enabled:=true;
bitbtn7.Enabled:=true;
bitbtn1.Enabled:=true;
bitbtn2.Enabled:=true;
bitbtn3.Enabled:=true;
bitbtn4.Enabled:=true;
bitbtn5.Enabled:=true;
//�رձ����ȡ����ť��ʹ��
bitbtn8.Enabled:=false;
bitbtn9.Enabled:=false;
//�������޸��ı���������
dbedit1.ReadOnly:=true;
dbedit2.ReadOnly:=true;
dbedit3.ReadOnly:=true;
dbedit4.ReadOnly:=true;
dbmemo1.ReadOnly:=true;
end;

//-------------�رմ���------------------
procedure TCalendar.BitBtn10Click(Sender: TObject);
begin
close;
end;

//----------�༭ĳ������---------------
procedure TCalendar.BitBtn6Click(Sender: TObject);
begin
datasource1.DataSet.Edit;
//�����룬ɾ�����޸ĺ��ƶ���ť�رգ���ֹ�������
bitbtn6.Enabled:=false;
bitbtn7.Enabled:=false;
bitbtn1.Enabled:=false;
bitbtn2.Enabled:=false;
bitbtn3.Enabled:=false;
bitbtn4.Enabled:=false;
bitbtn5.Enabled:=false;
//�򿪱����ȡ����ť��ʹ�ܣ����������ȡ��
bitbtn8.Enabled:=true;
bitbtn9.Enabled:=true;
//�����޸�
dbedit1.ReadOnly:=false;
dbedit2.ReadOnly:=false;
dbedit3.ReadOnly:=false;
dbedit4.ReadOnly:=false;
dbmemo1.ReadOnly:=false;
end;

//-------------ɾ������-------------------------
procedure TCalendar.BitBtn7Click(Sender: TObject);
begin
if application.MessageBox('ɾ���������ݣ�','ɾ��',MB_OKCANCEL)=ID_OK then
datasource1.DataSet.Delete;
end;

procedure TCalendar.DBGrid1DblClick(Sender: TObject);
begin
 if main.bomflag=3 then
 begin
 //ȡ���ϵı�ź����ƣ��浽�����������Ĺ���������ȥ
  main.str:=dbgrid1.Fields[0].AsString;
  main.str2:=dbgrid1.Fields[1].AsString;
  main.str3:=dbgrid1.Fields[2].AsString;
  main.str4:=dbgrid1.Fields[3].AsString;
//�����־,�رմ���
   main.bomflag:=0;
   main.n6.Click;
   close;
 end;

  if main.bomflag=5 then
 begin
 //ȡ���ϵı�ź����ƣ��浽�����������Ĺ���������ȥ
  main.str:=dbgrid1.Fields[0].AsString;
  main.str2:=dbgrid1.Fields[1].AsString;
  main.str3:=dbgrid1.Fields[2].AsString;
  main.str4:=dbgrid1.Fields[3].AsString;
//�����־,�رմ���
   main.bomflag:=0;
   main.MPS1.Click;
   close;
 end;
end;



end.
