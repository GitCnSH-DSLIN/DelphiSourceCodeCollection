unit kccxut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, Buttons, ExtCtrls, DB, ADODB, Menus;

type
  Tkccxfm = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    cxtj0: TComboBox;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    ADOQuery: TADOQuery;
    DataSource1: TDataSource;
    gjz0: TComboBox;
    ADOQuery1: TADOQuery;
    cxbt: TBitBtn;
    qxbt: TBitBtn;
    BitBtn5: TBitBtn;
    gbbt: TBitBtn;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    slms1: TLabel;
    slms: TComboBox;
    sl: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure lastbtClick(Sender: TObject);
    procedure nextbtClick(Sender: TObject);
    procedure closebtClick(Sender: TObject);
    procedure qxbtClick(Sender: TObject);
    procedure cxbtClick(Sender: TObject);
    procedure cxtj0KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gjz0KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure cxtj0Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  kccxfm: Tkccxfm;

implementation

uses kcyjut;

{$R *.dfm}

procedure Tkccxfm.FormCreate(Sender: TObject);
var
mypath:string;
gg,ks,mc:string;
begin
//mypath:=extractfilepath(paramstr(0));
//ADOquery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+mypath+'data\kcgl.mdb;Persist Security Info=False';
//ADOquery1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+mypath+'data\kcgl.mdb;Persist Security Info=False';

//ADOquery.active:=true;
{with adoquery do
begin
close;
sql.Clear;
sql.Add('select * from bhb');
open;
first;
gg:='';
ks:='';
mc:='';
while not eof do
begin
if (mc<>fieldbyname('����').AsString) then
gjz0.Items.Add(fieldbyname('����').AsString);
if (gg<>fieldbyname('���').AsString) then
gjz1.Items.Add(fieldbyname('���').AsString);
if ks<>fieldbyname('��ʽ').AsString then
gjz2.Items.Add(fieldbyname('��ʽ').AsString);
mc:=fieldbyname('����').AsString;
gg:=fieldbyname('���').AsString;
ks:=fieldbyname('��ʽ').AsString;
next;
end;
end;}
with adoquery do
begin
close;
sql.Clear;
sql.Add('select ���,����,���,��λ,ǰ�ڿ��,���ڽ���,��������,��ĩ���,�ܽ��,��ע from kcb');
open;
end;
end;

procedure Tkccxfm.lastbtClick(Sender: TObject);
begin
with adoquery do
begin
Prior;
end;
end;

procedure Tkccxfm.nextbtClick(Sender: TObject);
begin
with adoquery do
begin
next;
end;
end;

procedure Tkccxfm.closebtClick(Sender: TObject);
begin
close;
end;

procedure Tkccxfm.qxbtClick(Sender: TObject);
begin
gjz0.Text:='';
cxtj0.Text:='';
slms.Text:='';
sl.Text:='';
end;

procedure Tkccxfm.cxbtClick(Sender: TObject);
var
str:string;

begin
//if (cxtjbox.Text='') or (gjzedit.Text='') or (gjz1.Text='') or (gjz2.Text='') then
//begin
//showmessage('�������ѯ������Ϣ��');
//exit;
//end;
//str:='select * from kcb where id=:id ';
//if ((cxtjbox.Text<>'') and (cxtj1.Text<>'') and (cxtj2.Text<>'')) then
str:='select * from kcb where  id=:id';
{if cxtj0.Text<>'' then
str:=str+' and ����=:mc';
if cxtj1.Text<>'' then
str:=str+' and ���=:gg';
if cxtj2.Text<>'' then
str:=str+' and ��ʽ=:ks';
if cxtj3.Text<>'' then
 begin
  if gjz31.Text='>' then
  str:=str+' and ��ĩ���>:qmkc';
  if gjz31.Text='<' then
  str:=str+' and ��ĩ���<:qmkc';
  if gjz31.Text='=' then
  str:=str+' and ��ĩ���=:qmkc';
  end;
with adoquery do
begin
close;
sql.Clear;
sql.Add(str);
Parameters.ParamByName('id').Value:='';
if cxtj0.Text<>'' then
Parameters.ParamByName('mc').Value:=gjz0.Text;
if cxtj1.Text<>'' then
Parameters.ParamByName('gg').Value:=gjz1.Text;
if cxtj2.Text<>'' then
Parameters.ParamByName('ks').Value:=gjz2.Text;
if cxtj3.Text<>'' then
Parameters.ParamByName('qmkc').Value:=gjz3.Text;
Parameters.ParamByName('id').Value:='';
open;

end;}
str:='select ���,����,���,��λ,ǰ�ڿ��,���ڽ���,��������,��ĩ���,�ܽ��,��ע from kcb where id=""';
if cxtj0.text='��������' then
str:=str+' and  ����=:gjz';
if cxtj0.text='���ϱ��' then
str:=str+' and ���=:gjz';
if (slms.Text<>'') and (sl.Text<>'') then
str:=str+'  and ��ĩ���'+trim(slms.Text)+':sl';
with adoquery do
begin
close;
sql.Clear;
sql.Add(str);
if  (cxtj0.text<>'') then
Parameters.ParamByName('gjz').Value:=trim(gjz0.Text);
if (slms.Text<>'') and (sl.Text<>'') then
Parameters.ParamByName('sl').Value:=trim(sl.Text);
open;

end;
end;

procedure Tkccxfm.cxtj0KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then
cxbt.Click;
end;

procedure Tkccxfm.gjz0KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then
cxbt.Click;
end;

procedure Tkccxfm.BitBtn1Click(Sender: TObject);
begin
with adoquery do
begin
close;
sql.Clear;
sql.Add('select * from kcb');
open;
end;
end;

procedure Tkccxfm.cxtj0Change(Sender: TObject);
var
str:string;
begin
gjz0.Clear;
str:='select * from bhb';
with adoquery1 do
begin
  close;
  sql.Clear;
  sql.Add(str);
  open;
  first;
  while not eof do
   begin
     if cxtj0.text='��������' then
       gjz0.Items.Add(fieldbyname('����').AsString);
       if cxtj0.text='���ϱ��' then
       gjz0.Items.Add(fieldbyname('���').AsString);
       next;
   end;
end;
with adoquery do
begin
close;
sql.Clear;
sql.Add('select ���,����,���,��λ,ǰ�ڿ��,���ڽ���,��������,��ĩ���,�ܽ��,��ע from kcb');
open;
end;
end;

procedure Tkccxfm.SpeedButton1Click(Sender: TObject);
begin
with adoquery do
begin
close;
sql.Clear;
sql.Add('select ���,����,���,��λ,ǰ�ڿ��,���ڽ���,��������,��ĩ���,�ܽ��,��ע from kcb');
open;
end;
end;

procedure Tkccxfm.BitBtn5Click(Sender: TObject);
begin
with adoquery do
begin
close;
sql.Clear;
sql.Add('select ���,����,���,��λ,ǰ�ڿ��,���ڽ���,��������,��ĩ���,�ܽ��,��ע from kcb');
open;
end;
end;

procedure Tkccxfm.N1Click(Sender: TObject);
begin
cxbt.Click;
end;

procedure Tkccxfm.N2Click(Sender: TObject);
begin
qxbt.Click;
end;

procedure Tkccxfm.N3Click(Sender: TObject);
begin
gbbt.Click;
end;

end.
