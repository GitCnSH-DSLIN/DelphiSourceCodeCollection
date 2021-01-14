unit lltkut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, ComCtrls, DBCtrls, StdCtrls,
  ExtCtrls, Buttons;

type
  Tlltkfm = class(TForm)
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
    dy: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure bcbtClick(Sender: TObject);
    procedure gbbtClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  lltkfm: Tlltkfm;
   bsave:boolean;
implementation

uses mainut, inut, tldyut;

{$R *.dfm}

procedure Tlltkfm.FormCreate(Sender: TObject);
var
 Present: TDateTime;
 Year, Month, Day: Word;//����ʱ�����
 sno,cno,vno:string;//���ݱ�ű���
 llen:integer; //��ȡ���ȵı���
  sbh,sgg,sdw:TStringList;//�������ƻ�ȡ���
 i:integer;
 vmc:string;
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
   sql.Add('select * from tldb');
   open;
   if recordcount<1 then
     begin
     cno:='00001';
     vno:='ZDTL'+inttostr(Year)+inttostr(Month)+inttostr(Day)+cno;
     end
     else
     begin
      close;
      sql.Clear;
      sql.Add('select max(���ݱ��) as maxno  from tldb');
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
        vno:='ZDTL'+inttostr(Year)+inttostr(Month)+inttostr(Day)+cno;

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
  sql.add('select * from tlb where ���ݱ��=:djbh');
  Parameters.ParamByName('djbh').Value:=trim(djbh.Caption);
  open;
end; 

DBGrid1.Columns[0].Width:=30;
DBGrid1.Columns[1].Width:=100;
DBGrid1.Columns[2].Width:=70;
DBGrid1.Columns[3].Width:=130;
DBGrid1.Columns[4].Width:=70;
DBGrid1.Columns[5].Width:=70;
DBGrid1.Columns[6].Width:=70;
DBGrid1.Columns[7].Width:=70;
DBGrid1.Columns[8].Width:=150;
DBGrid1.Columns[9].Width:=0;
DBGrid1.Columns[10].Width:=0;
DBGrid1.Columns[11].Width:=0;
i:=0;
with adoquery do
  begin
    close;
    sql.Clear;
    sql.Add('select ���� from ckb group by ����');
    open;
    first;
    vmc:='';
    while not eof do
      begin
      if (vmc<>fieldbyname('����').asstring) and (fieldbyname('����').asstring<>'') and (i<=400) then
        DBGrid1.Columns[1].PickList.Strings[i]:=fieldbyname('����').asstring;
        inc(i);
        next;
    end;
end;
end;

procedure Tlltkfm.DBGrid1CellClick(Column: TColumn);
var
vbh:string;
i:integer;
begin
adoquery1.edit;
 with adoquery do
 begin
 close;
 sql.clear;
 sql.add('select ���,��λ,��� from bhb where ����=:mc');
 Parameters.ParamByName('mc').Value:=DBGrid1.Fields[1].AsString;
 open;
  DBGrid1.Fields[2].AsString:=fieldbyname('���').AsString;
  DBGrid1.Fields[5].AsString:=fieldbyname('��λ').AsString;
  DBGrid1.Fields[9].AsString:=fieldbyname('���').AsString;
  vbh:=fieldbyname('���').AsString;
  end;
  if  DBGrid1.Fields[1].AsString<>'' then
  begin
    with adoquery do
   begin
    close;
    sql.Clear;
    sql.Add('select ���ݱ�� from ckb  where ����=:vmc order by ��� desc');
    Parameters.ParamByName('vmc').Value:=trim(DBGrid1.Fields[1].AsString);
    open;
    first;
     while not eof do
      begin
      if (fieldbyname('���ݱ��').asstring<>'') and (i<=400) then
        DBGrid1.Columns[3].PickList.Strings[i]:=fieldbyname('���ݱ��').asstring;
        inc(i);
        next;
    end;
end;
  end;

  if  (DBGrid1.Fields[3].AsString<>'') and (DBGrid1.Fields[1].AsString<>'') then
  begin
   with adoquery do
     begin
       close;
       sql.Clear;
       sql.Add('select ���� from ckb where ���ݱ��=:djbh  and ����=:vmc');
       Parameters.ParamByName('vmc').Value:=trim(DBGrid1.Fields[1].AsString);
       Parameters.ParamByName('djbh').Value:=trim(DBGrid1.Fields[3].AsString);
       open;
       DBGrid1.Fields[6].AsString:=fieldbyname('����').AsString;
     end;
     end;


  if (DBGrid1.Fields[4].AsString<>'') and (DBGrid1.Fields[6].AsString<>'') then
   DBGrid1.Fields[7].AsString:=floattostr(strtofloat(DBGrid1.Fields[4].AsString)*strtofloat(DBGrid1.Fields[6].AsString));
   DBGrid1.Fields[10].AsString:=djbh.Caption;
   DBGrid1.Fields[11].AsString:='';

end;

procedure Tlltkfm.bcbtClick(Sender: TObject);
var
str:string;
vbh:string;
ibqjh,iqmkc,ibqjh1,iqmkc1:integer;
fzje,fzje1:double;
vckdh:string;
begin
 if kg.Text='' then
 begin
   showmessage('��ѡ��������������Ա��');
   exit;
 end;
 adoquery1.Edit;
 if   (DBGrid1.Fields[1].AsString='')   then
   begin
     showmessage('��ѡ��������ƣ�');
     exit;
   end;
   if   (DBGrid1.Fields[2].AsString='')   then
   begin
     showmessage('�뵥������µ������');
     exit;
   end;
    if   (DBGrid1.Fields[4].AsString='')   then
   begin
     showmessage('������������');
     exit;
   end;
   if   (DBGrid1.Fields[6].AsString='')   then
   begin
     showmessage('��ѡ�����ϵ���Ȼ���������µ������');
     exit;
   end;
   if   (DBGrid1.Fields[7].AsString='')   then
   begin
     showmessage('�뵥���ϼ��µ�����񣡣�');
     exit;
   end;
{if  (DBGrid1.Fields[1].AsString='')  or (DBGrid1.Fields[4].AsString='') or (DBGrid1.Fields[6].AsString='') or (DBGrid1.Fields[7].AsString='') then
  begin
    str1:='��ʾ��������¼�д��ڲ�������Ϣ,'+chr(13)+chr(13)+'������"����"����"����"����"����"����"�ܽ��"Ϊ��';
    str1:=str1+chr(13)+chr(13)+'1.���"����"Ϊ���뵥��"����"��������������������ѡ������';
    str1:=str1+chr(13)+chr(13)+'2.���"�����ߵ�λΪ��"Ϊ���뵥��"�����ߵ�λ"����������';
    str1:=str1+chr(13)+chr(13)+'3.���"�������ߵ���Ϊ��"Ϊ��������"�������ߵ���"';
    str1:=str1+chr(13)+chr(13)+'4.���"�ϼ�Ϊ��"Ϊ����ȷ�������������͵��۵�����µ���"�ϼ�"����������';
    showmessage(str1);
     exit;
 end; }
 adoquery1.Edit;
 if  (DBGrid1.Fields[1].AsString<>'') and  (DBGrid1.Fields[4].AsString<>'') and (DBGrid1.Fields[6].AsString<>'') and (DBGrid1.Fields[7].AsString<>'') then
 adoquery1.Post;
 with adoquery do
   begin
    close;
    sql.Clear;
    sql.Add('select * from tlb where ���ݱ��=:djbh');
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
       sql.Add('insert into tldb(���ݱ��,��������,������,������,������� ) values(:djbh,:jhrq,:bgr,:jsr,:rkrq)');
        Parameters.ParamByName('djbh').Value:=trim(djbh.Caption);
        Parameters.ParamByName('jhrq').Value:=datetostr(jhrqbox.Date);
        Parameters.ParamByName('bgr').Value:=trim(kg.Text);
        Parameters.ParamByName('jsr').Value:=mainfm.username;
        Parameters.ParamByName('rkrq').Value:=datetostr(date());
        try
        execsql;
          bsave:=true;
          mainfm.sdjbh:=trim(djbh.Caption);
        except
        showmessage('���ϵ�����ʧ��');
    end;
    end;
   //���¿���
with adoquery2 do
 begin
    close;
    sql.Clear;
    sql.Add('select * from tlb where ���ݱ��=:djbh');
    Parameters.ParamByName('djbh').Value:=trim(djbh.Caption);
    open;
     if recordcount>=1 then
        begin
          first;
            while not eof do
               begin
                  vbh:=fieldbyname('���').AsString;
                  ibqjh:=fieldbyname('����').AsInteger;
                  fzje:=fieldbyname('�ܽ��').AsFloat;
                  iqmkc:=fieldbyname('����').AsInteger;
                  vckdh:=fieldbyname('���ϵ���').AsString;
                  str:='select * from kcb where ���=:vbh';
                   with adoquery3 do
                       begin
                          close;
                          sql.Clear;
                          sql.Add(str);
                          Parameters.ParamByName('vbh').Value:=vbh;
                          open;
                          if recordcount=1 then
                            begin
                            iqmkc1:=iqmkc+fieldbyname('��ĩ���').AsInteger;
                            ibqjh1:=fieldbyname('��������').asinteger-ibqjh;
                            fzje1:=fzje+fieldbyname('�ܽ��').AsFloat;
                            str:='update kcb set ��������=:ibqjh,��ĩ���=:iqmkc,';
                            str:=str+'�ܽ��=:fzje where ���=:vbh';
                              with adoquery do
                                begin
                                 close;
                                 sql.Clear;
                                 sql.Add(str);
                                 //Parameters.ParamByName('djbh').Value:=trim(djbh.Caption);
                                 Parameters.ParamByName('vbh').Value:=vbh;
                                 Parameters.ParamByName('ibqjh').Value:=ibqjh1;
                                 Parameters.ParamByName('fzje').Value:=fzje1;
                                 Parameters.ParamByName('iqmkc').Value:=iqmkc1;
                                 execsql;
                               end;
                             end;
                       end;
             str:='select * from ckb where ���ݱ��=:vckdh and ���=:vbh';
              with adoquery3 do
                       begin
                          close;
                          sql.Clear;
                          sql.Add(str);
                           Parameters.ParamByName('vckdh').Value:=trim(vckdh);
                           Parameters.ParamByName('vbh').Value:=trim(vbh);
                          open;
                          if recordcount>=1 then
                            begin
                            iqmkc:=fieldbyname('����').AsInteger-iqmkc;
                            fzje:=fieldbyname('�ܽ��').AsFloat-fzje;
          str:='update ckb set ����=:iqmkc,�ܽ��=:fzje where ���ݱ��=:vckdh and ���=:vbh';
          with adoquery do
            begin
               close;
               sql.Clear;
               sql.Add(str);
               Parameters.ParamByName('vckdh').Value:=trim(vckdh);
               Parameters.ParamByName('vbh').Value:=trim(vbh);
                Parameters.ParamByName('iqmkc').Value:=iqmkc;
                 Parameters.ParamByName('fzje').Value:=fzje;
               execsql;
            end;
            end;
            end;
           next;
          end
       end;
       end;
       str:='insert into rkb(����,���,��λ,����,����,ʣ������,�ܽ��,���,���ݱ��,id) select';
       str:=str+' ����,���,��λ,����,����,����,�ܽ��,���,���ݱ��,id from tlb where ���ݱ��=:djbh';
          with adoquery do
            begin
               close;
               sql.Clear;
               sql.Add(str);
               Parameters.ParamByName('djbh').Value:=trim(djbh.Caption);
               execsql;
            end;



    showmessage('���ϵ�����ɹ�');
    sxbt.Click;
end;


{procedure Tlltkfm.FormShow(Sender: TObject);
begin
bsave:=false;
end;   }

procedure Tlltkfm.gbbtClick(Sender: TObject);
begin
if  not bsave  then
begin
if messagedlg('�㻹û�б������ϵ�!ȷ���ر���,����ر����ݽ��ᶪʧ��',mtconfirmation,[mbyes,mbno],0)=mryes then
close;
end
else
close;
end;


procedure Tlltkfm.FormShow(Sender: TObject);
begin
bsave:=false;
end;

procedure Tlltkfm.dyClick(Sender: TObject);
begin
tldyfm:=Ttldyfm.create(self);
tldyfm.qtldy.preview;
tldyfm.free;
end;

end.
