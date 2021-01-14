unit cprkut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, ComCtrls, DBCtrls, StdCtrls,
  ExtCtrls, Buttons;

type
  Tcprkfm = class(TForm)
    inpl: TPanel;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    bcbt: TSpeedButton;
    gbbt: TSpeedButton;
    sxbt: TSpeedButton;
    Bevel2: TBevel;
    kg: TComboBox;
    DBNavigator1: TDBNavigator;
    GroupBox1: TGroupBox;
    djbh: TLabel;
    Label9: TLabel;
    Label1: TLabel;
    Label15: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    jhrqbox: TDateTimePicker;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    ADOQuery: TADOQuery;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    ADOQuery3: TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure bcbtClick(Sender: TObject);
    procedure gbbtClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
   private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cprkfm: Tcprkfm;
   bsave:boolean;
implementation

uses mainut, inut, tldyut;

{$R *.dfm}

procedure Tcprkfm.FormCreate(Sender: TObject);
var
 Present: TDateTime;
 Year, Month, Day: Word;//����ʱ�����
 sno,cno,vno:string;//���ݱ�ű���
 llen:integer; //��ȡ���ȵı���
  sbh,sgg,sdw:TStringList;//�������ƻ�ȡ���
 i:integer;
begin
kg.Text:='';

//ADOTable1.Active:=true;
//�Զ���ȡ�����󵥾ݺ�
present:=now;
DecodeDate(Present, Year, Month, Day);

with adoquery do
  begin
   close;
   sql.Clear;
   sql.Add('select * from cprkdb');
   open;
   if recordcount<1 then
     begin
     cno:='00001';
     vno:='CPRK'+inttostr(Year)+inttostr(Month)+inttostr(Day)+cno;
     end
     else
     begin
      close;
      sql.Clear;
      sql.Add('select max(���ݱ��) as maxno  from cprkdb');
      open;
      sno:=fieldbyname('maxno').AsString;
      llen:=strtoint(copy(sno,13,5))+1;
     case length(inttostr(llen)) of
     1:cno:='0000'+inttostr(strtoint(copy(sno,13,5))+1);
     2:cno:='000'+inttostr(strtoint(copy(sno,13,5))+1);
     3:cno:='00'+inttostr(strtoint(copy(sno,13,5))+1);
     4:cno:='0'+inttostr(strtoint(copy(sno,13,5))+1);
     5:cno:=inttostr(strtoint(copy(sno,13,5))+1);
      else
       cno:='00001';
    end;
        vno:='CPRK'+inttostr(Year)+inttostr(Month)+inttostr(Day)+cno;

    end;
  end;
  djbh.Caption:=vno;
jhrqbox.Date:=date(); //��ȡ��ǰ����
kg.Clear;
with adoquery do
  begin
  close;
  sql.clear;
   sql.add('select * from gzyb where ְ��="������Ա"');
 open;
  first;
  kg.Text:=fieldbyname('����').AsString;
  while not eof do
  begin
  kg.Items.Add(fieldbyname('����').AsString);
  next;
  end;
end;
with adoquery1 do
  begin
  close;
  sql.clear;
  sql.add('select * from cprkb where ���ݱ��=:djbh');
  Parameters.ParamByName('djbh').Value:=trim(djbh.Caption);
  open;
end; 

DBGrid1.Columns[0].Width:=30;
DBGrid1.Columns[1].Width:=100;
DBGrid1.Columns[2].Width:=70;
DBGrid1.Columns[3].Width:=70;
DBGrid1.Columns[4].Width:=70;
DBGrid1.Columns[5].Width:=150;
DBGrid1.Columns[6].Width:=0;
DBGrid1.Columns[7].Width:=0;

{i:=0;
with adoquery do
  begin
    close;
    sql.Clear;
    sql.Add('select ���� from bhb');
    open;
    first;
    while not eof do
      begin
        DBGrid1.Columns[1].PickList.Strings[i]:=fieldbyname('����').asstring;
        inc(i);
        next;
    end;
end;}
end;

procedure Tcprkfm.DBGrid1CellClick(Column: TColumn);
var
vbh:string;
begin
adoquery1.edit;
DBGrid1.Fields[6].AsString:=djbh.Caption;
DBGrid1.Fields[7].AsString:='';
{
 with adoquery do
 begin
 close;
 sql.clear;
 sql.add('select ���,��λ,��� from bhb where ����=:mc');
 Parameters.ParamByName('mc').Value:=DBGrid1.Fields[1].AsString;
 open;
  DBGrid1.Fields[2].AsString:=fieldbyname('���').AsString;
  DBGrid1.Fields[4].AsString:=fieldbyname('��λ').AsString;
  DBGrid1.Fields[8].AsString:=fieldbyname('���').AsString;
  vbh:=fieldbyname('���').AsString;
  end;
  if (DBGrid1.Fields[3].AsString<>'') and (DBGrid1.Fields[5].AsString<>'') then
   DBGrid1.Fields[6].AsString:=floattostr(strtofloat(DBGrid1.Fields[3].AsString)*strtofloat(DBGrid1.Fields[5].AsString));
   DBGrid1.Fields[9].AsString:=djbh.Caption;
   DBGrid1.Fields[10].AsString:='';
   with adoquery do
     begin
       close;
       sql.Clear;
       sql.Add('select * from ckb where ���=:vbh order by ��� desc');
       Parameters.ParamByName('vbh').Value:=vbh;
       open;
       first;
       DBGrid1.Fields[5].AsString:=fieldbyname('����').AsString;
     end; }
end;

procedure Tcprkfm.bcbtClick(Sender: TObject);
var
str:string;
vbh,vmc,vgg:string;
ibqjh,iqmkc:integer;
fzje:double;
begin
adoquery1.Edit;
 if kg.Text='' then
 begin
   showmessage('��ѡ��������������Ա��');
   exit;
 end;

 if   (DBGrid1.Fields[1].AsString='')   then
   begin
     showmessage('�������Ʒ���ƣ�');
     exit;
   end;
   if   (DBGrid1.Fields[2].AsString='')   then
   begin
     showmessage('��������');
     exit;
   end;
    if   (DBGrid1.Fields[3].AsString='')   then
   begin
     showmessage('������������');
     exit;
   end;
   {if  (DBGrid1.Fields[1].AsString='')  or (DBGrid1.Fields[3].AsString='') or (DBGrid1.Fields[5].AsString='') or (DBGrid1.Fields[6].AsString='') then
  begin
    str1:='��ʾ��������¼�д��ڲ�������Ϣ,'+chr(13)+chr(13)+'������"����"����"����"����"����"����"�ܽ��"Ϊ��';
    str1:=str1+chr(13)+chr(13)+'1.���"����"Ϊ���뵥��"����"��������������������ѡ������';
    str1:=str1+chr(13)+chr(13)+'2.���"�����ߵ�λΪ��"Ϊ���뵥��"�����ߵ�λ"����������';
    str1:=str1+chr(13)+chr(13)+'3.���"�������ߵ���Ϊ��"Ϊ��������"�������ߵ���"';
    str1:=str1+chr(13)+chr(13)+'4.���"�ϼ�Ϊ��"Ϊ����ȷ�������������͵��۵�����µ���"�ϼ�"����������';
    showmessage(str1);
     exit;
 end; }
 if  (DBGrid1.Fields[1].AsString<>'') and  (DBGrid1.Fields[3].AsString<>'') then
 adoquery1.Post;
 with adoquery do
   begin
    close;
    sql.Clear;
    sql.Add('select * from cprkb where ���ݱ��=:djbh');
    Parameters.ParamByName('djbh').Value:=trim(djbh.Caption);
    open;
    if recordcount<1 then
      begin
       showmessage('�Բ����㻹û��¼������,����ʧ��');
       exit;
      end;
   end;

   with adoquery do
     begin
       close;
       sql.clear;
       sql.Add('insert into cprkdb(���ݱ��,������,������,������� ) values(:djbh,:bgr,:jsr,:rkrq)');
        Parameters.ParamByName('djbh').Value:=trim(djbh.Caption);
        Parameters.ParamByName('bgr').Value:=trim(kg.Text);
        Parameters.ParamByName('jsr').Value:=mainfm.username;
        Parameters.ParamByName('rkrq').Value:=datetostr(date());
        try
         execsql;
          bsave:=true;
          except
        showmessage('��Ʒ��ⵥ����ʧ��');
    end;
    end;

   //���¿���

with adoquery2 do
 begin
    close;
    sql.Clear;
    sql.Add('select * from cprkb where ���ݱ��=:djbh');
    Parameters.ParamByName('djbh').Value:=trim(djbh.Caption);
    open;
     if recordcount>=1 then
        begin
          first;
            while not eof do
               begin
                  vmc:=fieldbyname('����').AsString;
                  vgg:=fieldbyname('���').AsString;
                  ibqjh:=fieldbyname('����').AsInteger;
                  str:='select * from cpkcb where ����=:vmc and ���=:vgg';
                   with adoquery3 do
                       begin
                          close;
                          sql.Clear;
                          sql.Add(str);
                          Parameters.ParamByName('vmc').Value:=vmc;
                          Parameters.ParamByName('vgg').Value:=vgg;
                          open;
                          if recordcount=1 then
                            begin
                            ibqjh:=ibqjh+fieldbyname('����').asinteger;
                            str:='update cpkcb set ����=:ibqjh where ����=:vmc and ���=:vgg';
                              with adoquery do
                                begin
                                 close;
                                 sql.Clear;
                                 sql.Add(str);
                                 Parameters.ParamByName('ibqjh').Value:=ibqjh;
                                  Parameters.ParamByName('vmc').Value:=vmc;
                                  Parameters.ParamByName('vgg').Value:=vgg;
                                execsql;
                               end;
                             end
                           else
                             begin
                               str:='insert into cpkcb(����,���,��λ,����,id) select';
                               str:=str+' ����,���,��λ,����,id from cprkb where ���ݱ��=:djbh and ����=:vmc and ���=:vgg';
                               with adoquery do
                                  begin
                                   close;
                                   sql.Clear;
                                   sql.Add(str);
                                   Parameters.ParamByName('djbh').Value:=trim(djbh.Caption);
                                  Parameters.ParamByName('vmc').Value:=vmc;
                                  Parameters.ParamByName('vgg').Value:=vgg;
                                  execsql;
                                  end;
                             end;
               end;
           next;
          end
       end;
       end;
    showmessage('��Ʒ��ⵥ����ɹ�');
    sxbt.Click;
end;

procedure Tcprkfm.gbbtClick(Sender: TObject);
begin
if  not bsave  then
begin
if messagedlg('�㻹û�б����Ʒ��ⵥ!ȷ���ر���,����ر����ݽ��ᶪʧ��',mtconfirmation,[mbyes,mbno],0)=mryes then
close;
end
else
close;
end;


procedure Tcprkfm.FormShow(Sender: TObject);
begin
bsave:=false;
end;

end.
