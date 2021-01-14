unit kcgl1ut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons;

type
  Tkcgl1fm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    ADOQuery: TADOQuery;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    GroupBox1: TGroupBox;
    clbh: TLabeledEdit;
    clmc: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    zje: TEdit;
    Label7: TLabel;
    clgg: TComboBox;
    clks: TComboBox;
    clpl: TComboBox;
    cldw: TComboBox;
    qqkc: TEdit;
    bh: TEdit;
    BitBtn8: TBitBtn;
    Label9: TLabel;
    bqjh: TEdit;
    bqxh: TEdit;
    Label10: TLabel;
    qmkc: TEdit;
    Label11: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
  procedure reloaddata(str:string;adoquery:TADOQUERY);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  kcgl1fm: Tkcgl1fm;
  vsl:integer;
  vzje:double;
implementation

{$R *.dfm}
procedure Tkcgl1fm.reloaddata(str:string;adoquery:TADOQUERY);
begin
  with adoquery do
    begin
      close;
      sql.clear;
      sql.add(str);
      open;
    end;
end;

procedure Tkcgl1fm.FormCreate(Sender: TObject);
var
mypath,gg,ks,str:string;
begin
mypath:=extractfilepath(paramstr(0));
ADOquery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+mypath+'data\kcgl.mdb;Persist Security Info=False';
with adoquery do
begin
close;
sql.Clear;
sql.Add('select * from bhb');
open;
first;
gg:='';
ks:='';
while not eof do
begin
clmc.Items.Add(fieldbyname('����').AsString);
if (gg<>fieldbyname('���').AsString) then
clgg.Items.Add(fieldbyname('���').AsString);
if ks<>fieldbyname('��ʽ').AsString then
clks.Items.Add(fieldbyname('��ʽ').AsString);
gg:=fieldbyname('����').AsString;
ks:=fieldbyname('��ʽ').AsString;
next;
end;
end;
str:='select * from kcb';
reloaddata(str,adoquery);
end;

procedure Tkcgl1fm.DBGrid1CellClick(Column: TColumn);
begin
with adoquery do
  begin
   clbh.Text:=fieldbyname('���').AsString;
   clmc.Text:=fieldbyname('����').AsString;
   clgg.Text:=fieldbyname('���').AsString;
   clks.Text:=fieldbyname('��ʽ').AsString;
   clpl.Text:=fieldbyname('Ʒ��').AsString;
   qqkc.Text:=fieldbyname('ǰ�ڿ��').AsString;
   bqjh.Text:=fieldbyname('���ڽ���').AsString;
   bqxh.Text:=fieldbyname('��������').AsString;
   qmkc.Text:=fieldbyname('��ĩ���').AsString;
   cldw.Text:=fieldbyname('��λ').AsString;
   zje.Text:=fieldbyname('�ܽ��').AsString;
   bh.Text:=fieldbyname('num').AsString;
   end;
end;

procedure Tkcgl1fm.BitBtn5Click(Sender: TObject);
begin
with adoquery do
  begin
   Prior;
   clbh.Text:=fieldbyname('���').AsString;
   clmc.Text:=fieldbyname('����').AsString;
   clgg.Text:=fieldbyname('���').AsString;
   clks.Text:=fieldbyname('��ʽ').AsString;
   clpl.Text:=fieldbyname('Ʒ��').AsString;
   qqkc.Text:=fieldbyname('ǰ�ڿ��').AsString;
   bqjh.Text:=fieldbyname('���ڽ���').AsString;
   bqxh.Text:=fieldbyname('��������').AsString;
   qmkc.Text:=fieldbyname('��ĩ���').AsString;
   cldw.Text:=fieldbyname('��λ').AsString;
   zje.Text:=fieldbyname('�ܽ��').AsString;
   bh.Text:=fieldbyname('num').AsString;
  end;
end;

procedure Tkcgl1fm.BitBtn6Click(Sender: TObject);
begin
with adoquery do
  begin
   next;
   clbh.Text:=fieldbyname('���').AsString;
   clmc.Text:=fieldbyname('����').AsString;
   clgg.Text:=fieldbyname('���').AsString;
   clks.Text:=fieldbyname('��ʽ').AsString;
   clpl.Text:=fieldbyname('Ʒ��').AsString;
   qqkc.Text:=fieldbyname('ǰ�ڿ��').AsString;
   bqjh.Text:=fieldbyname('���ڽ���').AsString;
   bqxh.Text:=fieldbyname('��������').AsString;
   qmkc.Text:=fieldbyname('��ĩ���').AsString;
   cldw.Text:=fieldbyname('��λ').AsString;
   zje.Text:=fieldbyname('�ܽ��').AsString;
   bh.Text:=fieldbyname('num').AsString;
  end;
end;

procedure Tkcgl1fm.BitBtn2Click(Sender: TObject);
var
str:string;
vbqjh,vbqkc:integer;
v1zje:double;
begin
str:='update kcb set ���=:clbh,����=:clmc,���=:clgg,��ʽ=:clks';
str:=str+',Ʒ�� =:clpl,ǰ�ڿ��=:qqkc,���ڽ���=:qbjh,��������=:bqxh,��ĩ���=:qmkc,��λ=:cldw,�ܽ��=:zje where num=:bh';
 with adoquery do
   begin
    close;
    sql.Clear;
    sql.Add(str);
    Parameters.ParamByName('clbh').Value:=trim(clbh.Text);
    Parameters.ParamByName('clmc').Value:=trim(clmc.Text);
    Parameters.ParamByName('clgg').Value:=trim(clgg.Text);
    Parameters.ParamByName('clks').Value:=trim(clks.Text);
    Parameters.ParamByName('clpl').Value:=trim(clpl.Text);
    Parameters.ParamByName('qqkc').Value:=trim(qqkc.Text);
    Parameters.ParamByName('bqjh').Value:=trim(bqjh.Text);
    Parameters.ParamByName('bqxh').Value:=trim(bqxh.Text);
    Parameters.ParamByName('qmkc').Value:=trim(qmkc.Text);
    Parameters.ParamByName('cldw').Value:=trim(cldw.Text);
     parameters.ParamByName('zje').Value:=trim(zje.Text);
    Parameters.ParamByName('bh').Value:=trim(bh.Text);
    if messagedlg('��ʾ����Ҫ�޸ĵĲ��ϱ���ǣ�['+clbh.Text+']ȷ���޸���',mtconfirmation,[mbyes,mbno],0)=mryes then
    begin
    try
    execsql;
    showmessage('�޸ĳɹ���');
    except
    showmessage('�޸�ʧ�ܣ�');
    end;
   end;
   end;

  str:='select * from kcb';
  reloaddata(str,adoquery);
end;

procedure Tkcgl1fm.BitBtn3Click(Sender: TObject);
var
str,str1:string;
vbqjh,vbqkc:integer;
v1zje:double;
begin
 str:='delete  from kcb where num=:bh';
 //str1:='delete from yrkb where ���=:bh';
 with adoquery do
   begin
    close;
    sql.Clear;
    sql.Add(str);
    Parameters.ParamByName('bh').Value:=trim(bh.Text);
    if messagedlg('���棺ɾ���󲻿ɻָ�!��Ҫɾ���Ĳ��ϱ���ǣ�['+clbh.Text+']ȷ��ɾ����',mtconfirmation,[mbyes,mbno],0)=mryes then
    begin
    try
     execsql;
     showmessage('ɾ���ɹ���');
    except
     showmessage('ɾ��ʧ�ܣ�');
    end;
   end;
   end;
  str:='select * from kcb';
   reloaddata(str,adoquery);
end;

procedure Tkcgl1fm.BitBtn7Click(Sender: TObject);
begin
close;
end;

procedure Tkcgl1fm.BitBtn1Click(Sender: TObject);
var
str:string;
begin
str:='select * from kcb where id=:id';
if clbh.Text<>'' then
str:=str+' and ���=:clbh';
if clmc.Text<>'' then
str:=str+' and ����=:clmc';
if clgg.Text<>'' then
str:=str+' and ���=:clgg';
if clks.Text<>'' then
str:=str+' and ��ʽ=:clks';
if clpl.Text<>'' then
str:=str+' and Ʒ��=:clpl';
  with adoquery do
  begin
    close;
    sql.Clear;
    sql.Add(str);
    Parameters.ParamByName('id').Value:='';
      if clbh.Text<>'' then
    Parameters.ParamByName('clbh').Value:=trim(clbh.Text);
     if clmc.Text<>'' then
    Parameters.ParamByName('clmc').Value:=trim(clmc.Text);
    if clgg.Text<>'' then
    Parameters.ParamByName('clgg').Value:=trim(clgg.Text);
    if clks.Text<>'' then
    Parameters.ParamByName('clks').Value:=trim(clks.Text);
    if clpl.Text<>'' then
    Parameters.ParamByName('clpl').Value:=trim(clpl.Text);
    open;
    if recordcount<1 then
    showmessage('�Բ���û���ҵ����ѯ�ļ�¼����˶ԣ�')
    else
    showmessage('�����ҵ�'+inttostr(recordcount)+'����¼���뵥��������Ҫ�ļ�¼���Ȼ������߽������ݲ�����');
  end;
end;

procedure Tkcgl1fm.BitBtn8Click(Sender: TObject);
var
str:string;
begin
str:='select * from kcb';
reloaddata(str,adoquery);
end;

procedure Tkcgl1fm.BitBtn4Click(Sender: TObject);
begin
   clbh.Text:='';
   clmc.Text:='';
   clgg.Text:='';
   clks.Text:='';
   clpl.Text:='';
   qqkc.Text:='';
   bqjh.Text:='';
   bqxh.Text:='';
   qmkc.Text:='';
   cldw.Text:='';
   zje.Text:='';
   bh.Text:='';
end;

end.