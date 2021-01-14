unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, ComCtrls, DB, ADODB, Menus, Grids,
  DBGrids, DBCtrls;

type
  Toutfm = class(TForm)
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
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    jhrqbox: TDateTimePicker;
    khmc: TComboBox;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    ADOQuery: TADOQuery;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    ADOQuery3: TADOQuery;
    dy: TSpeedButton;
    procedure gbbtClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure bcbtClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dyClick(Sender: TObject);
   
  private
  price:integer;
     { Private declarations }
  public
    { Public declarations }
    sdjbh:string;
  end;

var
  outfm: Toutfm;
  vsysl:integer;
  vnum:integer;
  bsave:boolean;
  vxh:string;
 
implementation

uses mainut, ckdjut, fhdaut, clthut, lldyut;

{$R *.dfm}

procedure Toutfm.gbbtClick(Sender: TObject);
begin
if  not bsave  then
begin
if messagedlg('�㻹û�б������ϵ�!ȷ���ر���,����ر����ݽ��ᶪʧ��',mtconfirmation,[mbyes,mbno],0)=mryes then
//bcbt.Click;
outfm.close;
end
else
close;

end;

procedure Toutfm.FormCreate(Sender: TObject);
var
 Present: TDateTime;
 Year, Month, Day: Word;//����ʱ�����
 sno,cno,vno:string;//���ݱ�ű���
 llen:integer; //��ȡ���ȵı���
  sbh,sgg,sdw:TStringList;//�������ƻ�ȡ���
 i:integer;
begin
khmc.Text:='';
kg.Text:='';

//ADOTable1.Active:=true;
//�Զ���ȡ�����󵥾ݺ�
present:=now;
DecodeDate(Present, Year, Month, Day);

with adoquery do
  begin
   close;
   sql.Clear;
   sql.Add('select * from ckdb');
   open;
   if recordcount<1 then
     begin
     cno:='00001';
     vno:='ZDCK'+inttostr(Year)+inttostr(Month)+inttostr(Day)+cno;
     end
     else
     begin
      close;
      sql.Clear;
      sql.Add('select max(���ݱ��) as maxno from ckdb');
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
        vno:='ZDCK'+inttostr(Year)+inttostr(Month)+inttostr(Day)+cno;

    end;
  end;
  djbh.Caption:=vno;
jhrqbox.Date:=date(); //��ȡ��ǰ����
khmc.Clear;
with adoquery do
  begin
  close;
  sql.clear;
  sql.add('select �ͻ����� from ckdb');
  open;
  first;
  while not eof do
  begin
  khmc.Items.Add(fieldbyname('�ͻ�����').AsString);
  next;
  end;
end;
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
  sql.add('select * from ckb where ���ݱ��=:djbh');
  Parameters.ParamByName('djbh').Value:=trim(djbh.Caption);
  open;
end; 

DBGrid1.Columns[0].Width:=30;
DBGrid1.Columns[1].Width:=100;
DBGrid1.Columns[2].Width:=70;
DBGrid1.Columns[3].Width:=70;
DBGrid1.Columns[4].Width:=70;
DBGrid1.Columns[5].Width:=70;
DBGrid1.Columns[6].Width:=70;
DBGrid1.Columns[7].Width:=150;
DBGrid1.Columns[8].Width:=0;
DBGrid1.Columns[9].Width:=0;
DBGrid1.Columns[10].Width:=0;
i:=0;
with adoquery do
  begin
    close;
    sql.Clear;
    sql.Add('select ���� from kcb');
    open;
    first;
    while not eof do
      begin
        DBGrid1.Columns[1].PickList.Strings[i]:=fieldbyname('����').asstring;
        inc(i);
        next;
    end;
end;

end;

procedure Toutfm.DBGrid1CellClick(Column: TColumn);
var
 vbh:string;
 vsysl:integer;
 vdj:double;
 vsl:integer;
begin
 adoquery1.edit;
 with adoquery do
 begin
 close;
 sql.clear;
 sql.add('select ���,��λ,���,��ĩ��� from kcb where ����=:mc');
 Parameters.ParamByName('mc').Value:=DBGrid1.Fields[1].AsString;
 open;
  DBGrid1.Fields[2].AsString:=fieldbyname('���').AsString;
  DBGrid1.Fields[4].AsString:=fieldbyname('��λ').AsString;
  DBGrid1.Fields[8].AsString:=fieldbyname('���').AsString;
  //DBGrid1.Fields[5].AsFloat:=0;
  vsl:=fieldbyname('��ĩ���').AsInteger;
  vbh:=fieldbyname('���').AsString;
  end;
  if (DBGrid1.Fields[3].AsString<>'') and (DBGrid1.Fields[5].AsString<>'') then
   begin
   DBGrid1.Fields[6].AsString:=floattostr(strtofloat(DBGrid1.Fields[3].AsString)*strtofloat(DBGrid1.Fields[5].AsString));
   DBGrid1.Fields[9].AsString:=trim(djbh.Caption);
   DBGrid1.Fields[10].AsString:='';
   end;
  if (DBGrid1.Fields[1].AsString<>'') then
  begin
  with adoquery do
   begin
    close;
    sql.clear;
    sql.add('select ����,���,ʣ������,��� from rkb where ���=:vbh and ʣ������<>0 order by ���');
    Parameters.ParamByName('vbh').Value:=vbh;
    open;
    first;
    DBGrid1.Fields[5].AsString:=fieldbyname('����').AsString;
    vxh:=fieldbyname('���').AsString;
    vsysl:=fieldbyname('ʣ������').AsInteger;
    vdj:=fieldbyname('����').AsFloat;
   end;
   end;
    if (DBGrid1.Fields[3].AsString<>'')  then
      begin
         if (vsl=0) then
         begin
             showmessage('�������Ϊ'+inttostr(vsl)+'��治��!');
             exit;
        end;

        if (strtoint(DBGrid1.Fields[3].AsString)>vsl) then
         begin
             showmessage('���ʣ������Ϊ'+inttostr( vsl)+'��治��!');
             DBGrid1.Fields[3].AsString:=inttostr(vsl);
             DBGrid1.Fields[6].AsString:=floattostr(strtofloat(DBGrid1.Fields[3].AsString)*strtofloat(DBGrid1.Fields[5].AsString));
             exit;
        end;

       if (strtoint(DBGrid1.Fields[3].AsString)>vsysl) then
        begin
          showmessage('����Ϊ'+floattostr(vdj)+'��ʣ������Ϊ'+inttostr(vsysl)+'������γ���!');
          DBGrid1.Fields[3].AsString:=inttostr(vsysl);
          DBGrid1.Fields[6].AsString:=floattostr(strtofloat(DBGrid1.Fields[3].AsString)*strtofloat(DBGrid1.Fields[5].AsString));
         exit;
        end;


      end;
  end;

procedure Toutfm.bcbtClick(Sender: TObject);
var
str:string;
vbh:string;
ibqjh,iqmkc:integer;
fzje:double;
vsysl:integer;
vxh:string;
vsl:integer;
begin
adoquery1.Edit;
 if khmc.Text='' then
 begin
   showmessage('��ѡ���������ͻ����ƣ�');
   exit;
 end;
 if kg.Text='' then
 begin
   showmessage('��ѡ��������������Ա��');
   exit;
 end;

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
    if   (DBGrid1.Fields[3].AsString='')   then
   begin
     showmessage('������������');
     exit;
   end;
   if   (DBGrid1.Fields[5].AsString='')   then
   begin
     showmessage('�����뵥�ۣ�');
     exit;
   end;
   if   (DBGrid1.Fields[6].AsString='')   then
   begin
     showmessage('�뵥���ϼ��µ�����񣡣�');
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

  with adoquery do
 begin
  close;
  sql.Clear;
  sql.Add('select * from ckdb where �ͻ�����=:vkhmc');
  Parameters.ParamByName('vkhmc').Value:=trim(khmc.Text);
  open;
  if recordcount>=1 then
   begin
     if messagedlg('�˿ͻ������Ѿ�����,�������������ͬһ����Ŀ�������������"yes",�������ͬһ��Ŀ����"no",ϵͳ���Զ��ڿͻ����ƺ���ϵ�ǰ����������',mtconfirmation,[mbyes,mbno],0)=mrno then
      begin
     khmc.Text:=trim(khmc.Text)+datetimetostr(date());
     end
   end;
  end;
  
 if  (DBGrid1.Fields[1].AsString<>'') and  (DBGrid1.Fields[3].AsString<>'') and (DBGrid1.Fields[5].AsString<>'') and (DBGrid1.Fields[6].AsString<>'') then
 adoquery1.Post;
 with adoquery do
   begin
    close;
    sql.Clear;
    sql.Add('select * from ckb where ���ݱ��=:djbh');
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
       sql.Add('insert into ckdb(���ݱ��,�ͻ�����,�������,������,������,�������� ) values(:djbh,:jhdw,:jhrq,:bgr,:jsr,:rkrq)');
        Parameters.ParamByName('djbh').Value:=trim(djbh.Caption);
        Parameters.ParamByName('jhdw').Value:=trim(khmc.Text);
        Parameters.ParamByName('jhrq').Value:=datetostr(jhrqbox.Date);
        Parameters.ParamByName('bgr').Value:=trim(kg.Text);
        Parameters.ParamByName('jsr').Value:=mainfm.username;
        Parameters.ParamByName('rkrq').Value:=datetostr(date());
        try
        execsql;
       // showmessage('��ⵥ����ɹ�');
         mainfm.sdjbh:=trim(djbh.Caption);
        except
        showmessage('���ϵ�����ʧ��');
    end;
    end;
      //��������
with adoquery2 do
 begin
    close;
    sql.Clear;
    sql.Add('select * from ckb where ���ݱ��=:djbh');
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
                  vsl:=fieldbyname('����').AsInteger;
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
                          iqmkc:=fieldbyname('��ĩ���').AsInteger-iqmkc;
                          ibqjh:=ibqjh+fieldbyname('��������').asinteger;
                          fzje:=fieldbyname('�ܽ��').AsFloat-fzje;
                          str:='update kcb set ��������=:ibqjh,��ĩ���=:iqmkc,';
                           str:=str+'�ܽ��=:fzje where ���=:vbh';
                              with adoquery do
                                begin
                                 close;
                                 sql.Clear;
                                 sql.Add(str);
                                 //Parameters.ParamByName('djbh').Value:=trim(djbh.Caption);
                                 Parameters.ParamByName('vbh').Value:=vbh;
                                 Parameters.ParamByName('ibqjh').Value:=ibqjh;
                                 Parameters.ParamByName('fzje').Value:=fzje;
                                 Parameters.ParamByName('iqmkc').Value:=iqmkc;
                                 execsql;
                               end;
                             end;

               end;
                str:='select * from rkb where ���=:vbh and ʣ������<>0 order by ���';
                 with adoquery3 do
                       begin
                          close;
                          sql.Clear;
                          sql.Add(str);
                          Parameters.ParamByName('vbh').Value:=vbh;
                          open;
                          first;
                           begin
                            vsysl:=fieldbyname('ʣ������').AsInteger;
                            vsysl:=vsysl-vsl;
                            vxh:=fieldbyname('���').AsString;
                            str:='update rkb set ʣ������=:vsysl  where ���=:vxh';
                            with adoquery do
                                begin
                                 close;
                                 sql.Clear;
                                 sql.Add(str);
                                 Parameters.ParamByName('vsysl').Value:=vsysl;
                                 Parameters.ParamByName('vxh').Value:=vxh;
                                 execsql;
                               end;
                             end;
               end;
           next;
          end
       end;
       end;
     bsave:=true;
     showmessage('���ϵ�����ɹ�');
    sxbt.Click;
end;

procedure Toutfm.FormShow(Sender: TObject);
begin
bsave:=false;
end;

procedure Toutfm.dyClick(Sender: TObject);
begin
lldyfm:=Tlldyfm.create(self);
lldyfm.dy.preview;
lldyfm.free;
end;

end.
