unit UKqdatamanager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fm_Base, DB, StdCtrls, Grids, DBGrids, ExtCtrls, DBClient,DateUtils,
  ComCtrls;

type
  TfmKqManager = class(TfmBase)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    Mmsg: TMemo;
    DBGrid2: TDBGrid;
    dsbasedata: TDataSource;
    dsKqdata: TDataSource;
    cdsdata1: TClientDataSet;
    cdsdata2: TClientDataSet;
    TreeBase: TTreeView;
    cdsdata: TClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure TreeBaseDblClick(Sender: TObject);
  private
    { Private declarations }
     cd,cd1,cd2,cd3,cd4,cd5,cd6,cd7,zt,zt1,zt2,zt3,zt4,zt5,zt6,zt7,kg1,kg2,kg3,kg4,kg5,kg6,kg7,kg8:string; ///�ٵ������ˣ�����
   cdtj,zttj,dtj,cou:real; //�ٵ������ˣ���
   bz:integer;//��־λ
    function binddata():boolean;
    function readdata(E_no:string):boolean;
    function Total_Kq(e_no:string):string;
    procedure add_data(cdsNO:tclientdataset;sql:string);
    function ReadTree(Bm:string='';Tnode:TTreeNode=nil):integer;//(1�������ݣ�2�������ݣ�3���쳣);
  public
    { Public declarations }
  end;

var
  fmKqManager: TfmKqManager;

implementation

uses untdatadm, func;

{$R *.dfm}
///////////////////////////////////////////
function TfmKqManager.ReadTree(Bm:string='';Tnode:TTreeNode=nil):integer;
var
  sql:widestring;
  node:ttreenode;
  datas:olevariant;
  f:integer;
begin
  f:=1;
  if trim(bm)='' then
  begin
    sql:='select part_name as name,part_no as no from part where isnull(one_partno,'+''''+'0'+''''+')='+''''+'0'+'''';
  end else
  begin
    sql:='select p_no as no,employe_name as name from chang where part='+''''+trim(bm)+'''';
  end;
  datas:=null;
  cdsdata.Close;
  cdsdata.Data:=null;
  try
    ipubtemp.ty_query(sql,datas);
    if not varisnull(datas) then
    begin
      cdsdata.Data:=datas;
      datas:=null;
      cdsdata.Open;
      if not cdsdata.IsEmpty then
      begin
        while not cdsdata.Eof do
        begin
          if trim(bm)='' then
          begin
           node:=treebase.Items.add(tnode,trim(cdsdata.fieldbyname('no').AsString)+'_'+trim(cdsdata.fieldbyname('name').AsString));
          end else
          begin
            if (tnode.Count<cdsdata.RecordCount) and (tnode.Parent=nil) then
            node:=treebase.Items.AddChild(tnode,trim(cdsdata.fieldbyname('no').AsString)+'_'+trim(cdsdata.fieldbyname('name').AsString));
          end;
          cdsdata.Next;
        end;
      end else
      begin
        f:=2;
      end;
    end;
  except
    f:=3;
  end;
  cdsdata.Close;
  cdsdata.Data:=null;
  result:=f;
end;
procedure tfmKqManager.add_data(cdsNO:tclientdataset;sql:string);
var
  datas:olevariant;
  sqlpub:widestring;
begin
  sqlpub:=sql;
  cdsNO.Close;
  cdsNO.Data:=null;
  try
    datas:=null;
    ipubtemp.ty_query(sqlpub,datas); 
    if not varisnull(datas) then
    begin
      cdsNO.Data:=datas;
      cdsNO.Open;
      datas:=null;
    end;
  except
  end;
end;


function tfmKqManager.binddata():boolean;
var
  sqlpub:widestring;
  datas:olevariant;
begin
  result:=false;
  sqlpub:=' select p_no,p_name from dp_person';
  dmmain.CDSquery2.Close;
  dmmain.CDSquery2.Data:=null;
  try
    datas:=null;
    datas:=adisp.resultrecord(sqlpub);
    if not varisnull(datas) then
    begin
      dmmain.CDSquery2.Data:=datas;
      dmmain.CDSquery2.Open;
      datas:=null;
      result:=true;
    end;
  except
  end;
end;

function tfmKqManager.readdata(E_no:string):boolean;
var
  sqlpub:widestring;
  datas:olevariant;
begin
  result:=false;
  sqlpub:=' select * from dp_kqdocument where person_no ='+''''+trim(e_no)+'''';
  dmmain.CDSexecsql .Close;
  dmmain.CDSexecsql .Data:=null;
  try
    datas:=null;
    datas:=adisp.execSql(sqlpub);
    if not varisnull(datas) then
    begin
      dmmain.CDSexecsql .Data:=datas;
      dmmain.CDSexecsql .Open;
      datas:=null;
      if  not dmmain.CDSexecsql.IsEmpty then
      begin
        result:=true;
      end;
    end
  except
  end;

end;

function tfmKqManager.Total_Kq(e_no:string):string;
var
 yy,mm,dd:word;
 hh,ff,ss,msec:word;
 xxts,ts:INTEGER;
 tt:Smallint;
 sqls,tj:string;
begin
  //////////////////////////////////////////////////
  sqls:= 'select * from dp_bcap where person_no='+''''+trim(e_no)+'''';
  add_data(cdsdata1,sqls);
  tj:='';
  dtj:=0;
  while not dmmain.CDSexecsql.Eof do
  begin
    /////////////////////////////////////////////////////ˢ�����ڶ�Ӧ�İ��ʱ��//////////////////////////////////////////
    decodedate(dmmain.CDSexecsql.fieldbyname('newdate').AsDateTime,yy,mm,dd);
    tj:='T'+inttostr(dd);

    sqls:='select * from dp_bcjg where bc_no='+''''+trim(cdsdata1.fieldbyname(tj).AsString)+'''';
    add_data(cdsdata2,sqls);
    /////////////////////////////////////////////////////////////////////////////////////////
    bz:=0;//ÿ����ֻ��־
    if dmmain.CDSexecsql.FieldByName('m_up').AsDateTime<>0 then
    begin
      cd:=formatdatetime('hh'':''mm',dmmain.CDSexecsql.FieldByName('m_up').AsDateTime); //ʱ��Աȣ�
      decodetime(cdsdata2.FieldByName('swsb').AsDateTime,hh,ff,ss,msec);////*
      ff:=ff+5;
      cd1:=formatdatetime('hh'':''mm',encodetime(hh,ff,ss,msec)); ////*/////////�ٵ�ʱ��

      ff:=ff+30-5;//***************************//
      if ff>=60 then //��60���л�ΪСʱ;
      begin
        hh:=hh+1;
        ff:=ff-60;
      end;
      kg1:=formatdatetime('hh'':''mm',encodetime(hh,ff,ss,msec)); //************����ʱ��
    end else
    begin
      kg1:='00:00:00';
      cd:='00:00:00';
      cd1:='00:00:00';
    end;
    if dmmain.CDSexecsql.FieldByName('a_up').AsDateTime<>0 then
    begin
      cd2:=formatdatetime('hh'':''mm',dmmain.CDSexecsql.FieldByName('a_up').AsDateTime);
      decodetime(cdsdata2.FieldByName('xwsb').AsDateTime,hh,ff,ss,msec);
      ff:=ff+5;
      cd3:=formatdatetime('hh'':''mm',encodetime(hh,ff,ss,msec)); ////////////////
      ff:=ff+30-5;//***************************//
      if ff>=60 then //��60���л�ΪСʱ;
      begin
        hh:=hh+1;
        ff:=ff-60;
      end;
      kg2:=formatdatetime('hh'':''mm',encodetime(hh,ff,ss,msec)); //************����ʱ��
    end else
    begin
      kg2:='00:00:00';
      cd2:='00:00:00';
      cd3:='00:00:00';
    end;
    if dmmain.CDSexecsql.FieldByName('n_up').AsDateTime<>0 then
    begin
      cd4:=formatdatetime('hh'':''mm',dmmain.CDSexecsql.FieldByName('n_up').AsDateTime);
      decodetime(cdsdata2.FieldByName('wssb').AsDateTime,hh,ff,ss,msec);
      ff:=mm+5;
      cd5:=formatdatetime('hh'':''mm',encodetime(hh,ff,ss,msec));///////////////////�ٵ�

      ff:=ff+30-5;//***************************//
      if ff>=60 then //��60���л�ΪСʱ;
      begin
        hh:=hh+1;
        ff:=ff-60;
      end;
      kg3:=formatdatetime('hh'':''mm',encodetime(hh,ff,ss,msec)); //************����ʱ��
    end else
    begin
      kg3:='00:00:00';
      cd4:='00:00:00';
      cd5:='00:00:00';
    end;
    if dmmain.CDSexecsql.FieldByName('add_up').AsDateTime<>0 then
    begin
      cd6:=formatdatetime('hh'':''mm',dmmain.CDSexecsql.FieldByName('add_up').AsDateTime);
      decodetime(cdsdata2.FieldByName('jbsb').AsDateTime,hh,ff,ss,msec);
      ff:=ff+5;
      cd7:=formatdatetime('hh'':''mm',encodetime(hh,ff,ss,msec));

      ff:=ff+30-5;//***************************//
      if ff>=60 then //��60���л�ΪСʱ;
      begin
        hh:=hh+1;
        ff:=ff-60;
      end;
      kg4:=formatdatetime('hh'':''mm',encodetime(hh,ff,ss,msec)); //************����ʱ��
    end else
    begin
      kg4:='00:00:00';
      cd6:='00:00:00';
      cd7:='00:00:00';
    end;
/////////////////////////////////////////����////////////////////////////////////////////
    if dmmain.CDSexecsql.FieldByName('a_down').AsDateTime<>0 then
    begin
      zt:=formatdatetime('hh'':''mm',dmmain.CDSexecsql.FieldByName('a_down').AsDateTime);
      decodetime(cdsdata2.FieldByName('swxb').AsDateTime,hh,ff,ss,msec);
      tt:=ff;
      tt:=tt-5;
      zt1:=formatdatetime('hh'':''mm',encodetime(hh,ff,ss,msec));//����

      tt:=tt-30+5;//***************************//
      if tt<0 then //С��0��ȥСʱ;
      begin
        hh:=hh-1;
        tt:=tt+60;
      end;
      ff:=tt;
      kg5:=formatdatetime('hh'':''mm',encodetime(hh,ff,ss,msec)); //************����ʱ��
    end else
    begin
      kg5:='00:00:00';
      zt:='00:00:00';
      zt1:='00:00:00';
    end;
    if dmmain.CDSexecsql.FieldByName('a_down').AsDateTime<>0 then
    begin
      zt2:=formatdatetime('hh'':''mm',dmmain.CDSexecsql.FieldByName('a_down').AsDateTime );
      decodetime(cdsdata2.FieldByName('xwxb').AsDateTime,hh,ff,ss,msec);
      tt:=ff;
      tt:=tt-5;
      zt3:=formatdatetime('hh'':''mm',encodetime(hh,ff,ss,msec));//����

      tt:=tt-30+5;//***************************//
      if tt<0 then //С��0��ȥСʱ;
      begin
        hh:=hh-1;
        tt:=tt+60;
      end;
      ff:=tt;
      kg6:=formatdatetime('hh'':''mm',encodetime(hh,ff,ss,msec)); //************����ʱ��
    end else
    begin
      kg6:='00:00:00';
      zt2:='00:00:00';
      zt3:='00:00:00';
    end;
    if (dmmain.CDSexecsql.FieldByName('n_down').AsDateTime<>0) and (dmmain.CDSexecsql.FieldByName('n_down').AsString<>'1900-1-1')  then
    begin
      zt4:=formatdatetime('hh'':''mm',dmmain.CDSexecsql.FieldByName('n_down').AsDateTime);
      if cdsdata2.FieldByName('wsxb').AsDateTime=0 then  //�����°�Ϊ�ڶ���Ĵ�;
      begin
        decodedate(dmmain.CDSexecsql.fieldbyname('newdate').AsDateTime,yy,mm,dd);
        tj:='T'+inttostr(dd-1);//ǰһ�죻��

        sqls:='select * from dp_bcjg where bc_no='+''''+trim(cdsdata1.fieldbyname(tj).AsString)+'''';
        add_data(cdsdata2,sqls);
      end;
      decodetime(cdsdata2.FieldByName('wsxb').AsDateTime,hh,ff,ss,msec);
      tt:=ff;
      tt:=tt-5;
      zt5:=formatdatetime('hh'':''mm',encodetime(hh,ff,ss,msec));//����

      tt:=tt-30+5;//***************************//
      if tt<0 then //С��0��ȥСʱ;
      begin
        hh:=hh-1;
        tt:=tt+60;
      end;
      ff:=tt;
      kg7:=formatdatetime('hh'':''mm',encodetime(hh,ff,ss,msec)); //************����ʱ��
    end else
    begin
      kg7:='00:00:00';
      zt4:='00:00:00';
      zt5:='00:00:00';
    end;
    if (dmmain.CDSexecsql.FieldByName('add_down').AsDateTime<>0) and (dmmain.CDSexecsql.FieldByName('ADD_down').AsString<>'1900-1-1') then
    begin
      zt6:=formatdatetime('hh'':''mm',dmmain.CDSexecsql.FieldByName('add_down').AsDateTime);
      decodetime(cdsdata2.FieldByName('jbxb').AsDateTime,hh,ff,ss,msec);
      tt:=ff;
      tt:=tt-5;
      zt7:=formatdatetime('hh'':''mm',encodetime(hh,ff,ss,msec));

      tt:=tt-30+5;//***************************//
      if tt<0 then //С��0��ȥСʱ;
      begin
        hh:=hh-1;
        tt:=tt+60;
      end;
      ff:=tt;
      kg8:=formatdatetime('hh'':''mm',encodetime(hh,ff,ss,msec)); //************����ʱ��
    end else
    begin
      kg8:='00:00:00';
      zt6:='00:00:00';
      zt7:='00:00:00';
    end;
    /////////����ʱ���ж�////////////////////
    //***************�ٵ�ͳ��***************///////
    if cdsdata2.FieldByName('swsb').AsDateTime<>0 then
    begin
      if  (cd<>'00:00:00') then //����
      begin
        if  (strtotime(cd)<strtotime(kg1))  then
        begin
          if (strtotime(cd)>=strtotime(cd1))  then
          begin
            cdtj:=cdtj+1;
          end;
        end else
        begin
          cou:=cou+1;
          bz:=1;
        end;
      end else
      begin
        if bz<>1 then
        begin
          cou:=cou+1;
          bz:=1;
        end ;
      end;
    end;
    if cdsdata2.FieldByName('xwsb').AsDateTime<>0 then
    begin
      if  (cd2<>'00:00:00') then //����
      begin
        if  ((strtotime(cd2)<strtotime(kg2)) )and (bz<>1) then
        begin
          if (strtotime(cd2)>=strtotime(cd3))  then
          begin
            cdtj:=cdtj+1;
          end;
        end else
        begin
          if bz<>1 then
          begin
            cou:=cou+1;
            bz:=1;
          end ;
        end;
      end else
      begin
        if bz<>1 then
        begin
          cou:=cou+1;
          bz:=1;
        end ;
      end;
    end;
    if cdsdata2.FieldByName('wssb').AsDateTime<>0 then
    begin
      if  (cd4<>'00:00:00') then //����
      begin
        if  ((strtotime(cd4)<strtotime(kg3)) )and (bz<>1) then
        begin
          if (strtotime(cd4)>=strtotime(cd5))  then
          begin
            cdtj:=cdtj+1;
          end;
        end else
        begin
          if bz<>1 then
          begin
            cou:=cou+1;
            bz:=1;
          end ;
        end;
      end else
      begin
        if bz<>1 then
        begin
          cou:=cou+1;
          bz:=1;
        end ;
      end;
    end;
    if cdsdata2.FieldByName('jbsb').AsDateTime<>0 then
    begin
      if  (cd6<>'00:00:00') then //����
      begin
        if  ((strtotime(cd6)<strtotime(kg4)) )and (bz<>1) then
        begin
          if (strtotime(cd6)>=strtotime(cd7))  then
          begin
            cdtj:=cdtj+1;
          end;
        end else
        begin
          if bz<>1 then
          begin
            cou:=cou+1;
            bz:=1;
          end ;
        end;
      end else
      begin
        if bz<>1 then
        begin
          cou:=cou+1;
          bz:=1;
        end ;
      end;
    end;
    ///////////////////////////////////�ٵ�ͳ��///////////////////////////////
    //////////////////////////////////////////////////////////////////////////
    //*****************����****************************//
    if cdsdata2.FieldByName('swxb').AsDateTime<>0 then
    begin
      if  (zt<>'00:00:00') then //����
      begin
        if  ((strtotime(zt)>strtotime(kg5)) )and (bz<>1) then
        begin
          if (strtotime(zt)<=strtotime(zt1))  then
          begin
            zttj:=zttj+1;
          end;
        end else
        begin
          if bz<>1 then
          begin
            cou:=cou+1;
            bz:=1;
          end ;
        end;
      end else
      begin
        if bz<>1 then
        begin
          cou:=cou+1;
          bz:=1;
        end ;
      end;
    end;
    if cdsdata2.FieldByName('xwxb').AsDateTime<>0 then
    begin
      if  (zt2<>'00:00:00') then //����
      begin
        if  ((strtotime(zt2)>strtotime(kg6)) )and (bz<>1) then
        begin
          if (strtotime(zt2)<=strtotime(zt3))  then
          begin
            zttj:=zttj+1;
          end;
        end else
        begin
          if bz<>1 then
          begin
            cou:=cou+1;
            bz:=1;
          end ;
        end;
      end else
      begin
        if bz<>1 then
        begin
          cou:=cou+1;
          bz:=1;
        end ;
      end;
    end;
    if cdsdata2.FieldByName('wsxb').AsDateTime<>0 then
    begin
      if  (zt4<>'00:00:00') then //����
      begin
        if  ((strtotime(zt4)>strtotime(kg7)) )and (bz<>1) then
        begin
          if (strtotime(zt4)<=strtotime(zt5))  then
          begin
            zttj:=zttj+1;
          end;
        end else
        begin
          if bz<>1 then
          begin
            cou:=cou+1;
            bz:=1;
          end ;
        end;
      end else
      begin
        if bz<>1 then
        begin
          cou:=cou+1;
          bz:=1;
        end ;
      end;
    end;
    if cdsdata2.FieldByName('jbxb').AsDateTime<>0 then
    begin
      if  (zt6<>'00:00:00') then //����
      begin
        if  ((strtotime(zt6)>strtotime(kg8)) )and (bz<>1) then
        begin
          if (strtotime(zt6)<=strtotime(zt7))  then
          begin
            zttj:=zttj+1;
          end;
        end else
        begin
          if bz<>1 then
          begin
            cou:=cou+1;
            bz:=1;
          end ;
        end;
      end else
      begin
        if bz<>1 then
        begin
          cou:=cou+1;
          bz:=1;
        end ;
      end;
    end;
    ///////////////////////����ͳ��////////////////////////////////
    //////////
    dmmain.CDSexecsql.Next;
  end;
  decodedate(date,yy,mm,dd);
  for ts:=1 to DaysInAMonth(yy,mm) do
  begin
    TJ:='T'+INTTOSTR(TS);
    if trim(cdsdata1.FIELDBYNAME(TJ).AsString)='' then
    begin
      xxts:=xxts+1;
    end;
  end;
  ts:=DaysInAMonth(yy,mm);
  if dmmain.CDSexecsql.RecordCount>0 then
  begin
    cou:=cou+ts-dmmain.CDSexecsql.RecordCount-xxts;
  end;
  result:='�ٵ�'+floattostr(cdtj)+'��'+chr(13)+'����'+floattostr(zttj)+'��'+chr(13)+'����'+floattostr(cou)+'��';
  cdtj:=0;
  zttj:=0;
  cou:=0;
  dtj:=0;
end;
/////////////////////////////////
procedure TfmKqManager.FormShow(Sender: TObject);
var
  b:boolean;
begin
  inherited;
  b:=binddata;
  ReadTree('',nil);
end;

procedure TfmKqManager.TreeBaseDblClick(Sender: TObject);
var
  i:integer;
  rb:boolean;
begin
  inherited;
  if treebase.Selected<>nil then
  begin
    i:=ReadTree(copy(trim(treebase.Selected.Text),1,pos('_',trim(treebase.Selected.Text))-1),treebase.Selected);
    rb:=false;
    if treebase.Selected.Parent<>nil then
    begin
      Mmsg.Clear;
      rb:= readdata(trim(copy(treebase.Selected.Text,1,pos('_',trim(treebase.Selected.Text))-1)));
      if rb then
      Mmsg.Text:=TOtal_kq(trim(copy(treebase.Selected.Text,1,pos('_',trim(treebase.Selected.Text))-1)))
      else
      application.MessageBox('û�п������ݣ�',pchar(application.Title),mb_iconinformation);
    end;
  end;
end;

end.
