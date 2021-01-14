{Ϊ���ӹ��ܴ������в����̵꣬�ײ�, ���͹���ȣ����У�������ô洢���� builder  WangGang}
unit Public_Data;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, GD_Chain_Server_TLB, StdVcl, DB, ADODB, Provider,variants,forms;

type
  TPublicServer = class(TRemoteDataModule, IPublicServer)
    DSPqr: TDataSetProvider;
    ADOQ: TADOQuery;
    ADOQcheck: TADOQuery;
    DScheck: TDataSetProvider;
    ADOQcheckdetail: TADOQuery;
    DScheckdetail: TDataSetProvider;
    aqupdate: TADOQuery;
    ADOQyyzcheck: TADOQuery;
    DSyyzcheck: TDataSetProvider;
    ADOQyyzcheckdetail: TADOQuery;
    DSyyzcheckdetail: TDataSetProvider;
    Dscheckquery: TDataSetProvider;
    aqmain: TADOQuery;
    AQpay: TADOQuery;   //   �ո�������
    dsppay: TDataSetProvider;
    AQPAYDETAIL: TADOQuery; //    �ո�����ϸ
    dspPAYDETAIL: TDataSetProvider;
    amoneyinput: TADOQuery;
    dspmoney: TDataSetProvider;
    amoneydetail: TADOQuery;
    dspmoneydetail: TDataSetProvider;
    aqinfo: TADOQuery;
    aqout: TADOQuery;
    dspstockwarning: TDataSetProvider;
    aqstockwarn: TADOQuery;
    aqstorage: TADOQuery;
    dspstorage: TDataSetProvider;
    aqrscrap: TADOQuery;
    dspcrap: TDataSetProvider;
    dspscrapDetail: TDataSetProvider;
    aqrscrapDetail: TADOQuery;
    aqrOverflow: TADOQuery;
    aqrOverflowdetail: TADOQuery;
    DspOverflow: TDataSetProvider;
    dspOverflowdetail: TDataSetProvider;
    AReceipt: TADOQuery;
    aoutstrip: TADOQuery;
    aoutstripdetail: TADOQuery;
    dspoutstrip: TDataSetProvider;
    dspoutdetail: TDataSetProvider;
    aqflat: TADOQuery;
    aqflatdetail: TADOQuery;
    dspflat: TDataSetProvider;
    dspflatdetail: TDataSetProvider;
    AQWRITEMAINTABLE: TADOStoredProc; //д��������
    AQtotalmoney: TADOStoredProc;
    aqbatchguest: TADOQuery;
    dspbatchguest: TDataSetProvider;
    aqprices: TADOQuery;
    dspprice: TDataSetProvider;
    aqSupply_Company: TADOQuery;
    dspSupply_Company: TDataSetProvider;
    aqbajg: TADOQuery;
    dspbcjg: TDataSetProvider;
    dspbcap: TDataSetProvider;
    aqbcap: TADOQuery;
    aqstorage_join: TADOQuery;
    dspstoagemaster: TDataSetProvider;
    dspstoagedetail: TDataSetProvider;
    aqstorage_detail: TADOQuery;
    Aqpresent: TADOQuery;
    aqpresent_detail: TADOQuery;
    Dsppresent: TDataSetProvider;
    dsppresent_detail: TDataSetProvider;
    InsertProc: TADOStoredProc; //����ͳ�ƹ���;
  private
    { Private declarations }
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    procedure quedetail(const checkcode: WideString; out values: OleVariant);
      safecall;
    procedure returedate(out begindate, enddate, checkcode: OleVariant;
      const shopID: WideString); safecall;
    procedure ty_query(const t_sql: WideString; out t_rs: OleVariant);
      safecall;
    procedure updatecheck(const fieldnames, numbers, checkcode,
      goodsno: WideString); safecall;
    procedure autoid(const sql, maks: WideString; out outid: OleVariant);
      safecall;
    procedure stock(flag: Integer; const shopID, operater,
      officeid: WideString); safecall;
    procedure scrapsate(const sql: WideString); safecall;
    function inputFlat(const no, shopid: WideString): OleVariant; safecall;
    procedure Gether(const G_no: WideString; money: Double; flag, bz: Integer);
      safecall;
    function MoneyTable(index: Integer; const no: WideString;
      totalmoneys: Double; const billid, checkid, passid, wldwno, wldwname,
      shopid, remark: WideString): OleVariant; safecall;
    function batchstock(const stock_no: WideString;
      typed: Integer): OleVariant; safecall;
    function PubBacth(const sqltemp: WideString): OleVariant; safecall;
    function Updatebatch(const stock_no, part_no: WideString): OleVariant;
      safecall;
    function OutNewShop(const no: WideString): OleVariant; safecall;
      safecall;
    function MZSGOODS(const no: WideString; Flag: Integer): OleVariant;
      safecall;
    procedure LQ_WriteFinanceBill(billid, BillType: Integer;
      BillDate: OleVariant; const AccountId, AccountName, AccountId2,
      AccountName2: WideString; Total: Double; const Comment: WideString;
      ord: Integer; out nRet: Integer; const ShopNo: WideString;
      EditMode: Integer); safecall;
    procedure WriteMainBill(const BillCode: WideString; BillType: Integer;
      BillDate: OleVariant; const BillEId, CheckEid, PassEid, UnitId,
      UnitName: WideString; Total: Double; IsCheck, Red: Integer;
      const PosId, Explain: WideString; out ret: Integer; EditMode,
      Billid: Integer); safecall;
    function EditMoney(Main_no: Integer; const CheckID: WideString): Integer;
      safecall;
  public
    { Public declarations }
  end;

implementation

uses Chain_Data, Unitpubsub, func;

{$R *.DFM}

class procedure TPublicServer.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
begin
  if Register then
  begin
    inherited UpdateRegistry(Register, ClassID, ProgID);
    EnableSocketTransport(ClassID);
    EnableWebTransport(ClassID);
  end else
  begin
    DisableSocketTransport(ClassID);
    DisableWebTransport(ClassID);
    inherited UpdateRegistry(Register, ClassID, ProgID);
  end;
end;

procedure TPublicServer.quedetail(const checkcode: WideString;
  out values: OleVariant);
begin

end;

procedure TPublicServer.returedate(out begindate, enddate,
  checkcode: OleVariant; const shopID: WideString); //��ѯӪҵ���̵㵥���
begin

end;

procedure TPublicServer.ty_query(const t_sql: WideString;
  out t_rs: OleVariant);   //��ѯ
begin
  if queryrecord(ADOQ,t_sql) then  //select
  begin
    t_rs:=DSPqr.Data;
  end else
  begin
    t_rs:=null;
  end;
  ADOQ.Close;
end;

procedure TPublicServer.updatecheck(const fieldnames, numbers, checkcode,
  goodsno: WideString); //����Ӫҵ���̵㵥ʱ�䡣
begin
  aqupdate.Close;
  aqupdate.SQL.Clear;
  aqupdate.SQL.Text:='update dp_shortcheckdetail  set '+trim(fieldnames)+'='+trim(fieldnames)+'+'+trim(numbers)+' where scd_checkcode=:code and scd_goodsno=:goodsno';
  aqupdate.Parameters[0].Value :=trim(checkcode);
  aqupdate.Parameters[1].Value :=trim(goodsno);
  aqupdate.Prepared;
  aqupdate.ExecSQL;
  aqupdate.Close;
end;

procedure TPublicServer.autoid(const sql, maks: WideString;
  out outid: OleVariant);
var
  id:string;
begin
  id:=addID(aqmain,sql,maks);
  outid:=id;
  aqmain.Close;
end;

procedure TPublicServer.stock(flag: Integer; const shopID, operater,
  officeid: WideString);
var
  id,sql,make:string;
  i:integer;
begin
  if flag=1 then
  begin
    aqinfo.Close; //������ⵥ��
    aqinfo.SQL.Clear;
    aqinfo.SQL.Text:='select  b.od_ccode as code,b.od_cname as names,b.od_ccount as count,c.baseprice as price from dp_overflow as a,dp_overflowdetail as b,goods_prices as c where a.o_shop=:shopid and a.o_state=:state and b.od_ccode=c.goods_no and a.o_code=b.od_ocode';
    aqinfo.Parameters[0].Value:=trim(officeid);  //5-19 edit
    aqinfo.Parameters[1].Value:=trim('0'); //�ύ��־;
    aqinfo.Open;
    aqinfo.First;
    if not aqinfo.IsEmpty  then
    begin
      id:='';
      sql:='select max(right(stock_no,4)) from stock_jion where copy_date='+''''+formatdatetime('yyyy''-''mm''-''dd',date)+''''+' and part_no='+''''+trim(officeid)+'''';
      make:='ISK-'+trim(shopid)+formatdatetime('yymmdd',date);
      id:=addid(aqout,sql,make);
      aqmain.Close;  //*  д������ⵥ
      aqmain.SQL.Clear;
      aqmain.SQL.Text:='insert into  stock_jion (stock_no,storage_no,transactor,copy_date,proposer,part_no,resume,Stock_Name) values (:code,:shop,:operater,:newdate,:newman,:part,:resumes,:names)';
      aqmain.Parameters[0].Value:=trim(id);
      aqmain.Parameters[1].Value:=trim(shopid);
      aqmain.Parameters[2].Value:=trim(operater);
      aqmain.Parameters[3].Value:=strtodate(formatdatetime('yyyy''-''mm''-''dd',date));
      aqmain.Parameters[4].Value:=trim(operater);
      aqmain.Parameters[5].Value:=trim(shopid);
      aqmain.Parameters[6].Value:='�ŵ�:'+shopid+' �������';
      aqmain.Parameters[7].Value:='������ⵥ';
      aqmain.Prepared;
      aqmain.ExecSQL;
      i:=1;
      while not aqinfo.Eof do
      begin
        aqout.Close;  //д�����ϸ
        aqout.SQL.Clear;
        aqout.SQL.Text:='insert into stock_jion_detail (stock_no,goods_no,goods_name,amount,price,Total_Money,ord) values (:id_icode,:id_ccode,:iod_cname,:id_count,:id_cprice,:id_money,:ord)';
        aqout.Parameters[0].Value:=trim(id);
        aqout.Parameters[1].Value:=trim(aqinfo.fieldbyname('code').AsString);
        aqout.Parameters[2].Value:=trim(aqinfo.fieldbyname('names').AsString);
        aqout.Parameters[3].Value:=aqinfo.fieldbyname('count').AsInteger;
        aqout.Parameters[4].Value:=aqinfo.fieldbyname('price').AsFloat;
        aqout.Parameters[5].Value:=aqinfo.fieldbyname('count').asfloat*aqinfo.fieldbyname('price').AsFloat;
        aqout.Parameters[6].Value:=i;
        aqout.Prepared;
        aqout.ExecSQL;
        //////////////����ʵ�ʿ��/////////////////
        aqmain.Close;
        aqmain.SQL.Clear;
        aqmain.SQL.Text:='update stock_states set in_amount=in_amount+'+trim(aqinfo.fieldbyname('count').AsString)+' where Storage_NO=:shopid and goods_no=:goodsno';
        aqmain.Parameters[0].Value:=trim(shopid);
        aqmain.Parameters[1].Value:=trim(aqinfo.fieldbyname('code').AsString);
        aqmain.Prepared;
        aqmain.ExecSQL;
        ///////////////////////
        aqinfo.Next;
        inc(i);
      end;
      aqinfo.Close; //������ⵥ��
      aqinfo.SQL.Clear;
      aqinfo.SQL.Text:='update dp_overflow  set o_state=:state where o_shop=:shopid and o_state=:state ';
      aqinfo.Parameters[0].Value:=trim('4');
      aqinfo.Parameters[1].Value:=trim(officeid); //5-19 edit;
      aqinfo.Parameters[2].Value:=trim('0'); //�ύ��־;
      aqinfo.ExecSQL;
    end;
  end;
  if flag=2 then //������ⵥ
  begin
    aqinfo.Close;
    aqinfo.SQL.Clear;
    aqinfo.SQL.Text:='select b.sd_ccode as code,b.sd_cname as names,b.sd_ccount as count,c.baseprice as price from dp_scrap as a,dp_scrapdetail as b,goods_prices as c where s_shop=:shopid and a.s_code=b.sd_scode and b.sd_ccode=c.goods_no and a.s_state=:state';
    aqinfo.Parameters[0].Value:=trim(officeid);//5-19 edit
    aqinfo.Parameters[1].Value:='0';
    aqinfo.Prepared;
    aqinfo.Open;
    aqinfo.First;
    if not aqinfo.IsEmpty  then
    begin
      id:='';
      sql:='select max(right(Out_NO,4)) from out_strip where copy_date='+''''+formatdatetime('yyyy''-''mm''-''dd',date)+''''+' and part_no='+''''+trim(officeid)+'''';
      make:='OSK-'+trim(shopid)+formatdatetime('yymmdd',date);
      id:=addid(aqout,sql,make);
      aqmain.Close;  //*  д���ⵥ
      aqmain.SQL.Clear;
      aqmain.SQL.Text:='insert into  out_strip (out_no,storage_no,transactor,copy_date,proposer,part_no,condense,out_name) values (:code,:shop,:operater,:newdate,:newman,:part,:resume,:names)';
      aqmain.Parameters[0].Value:=trim(id);
      //aqmain.Parameters[1].Value:=trim('1');
      aqmain.Parameters[1].Value:=trim(shopid);
      aqmain.Parameters[2].Value:=trim(operater);
      aqmain.Parameters[3].Value:=formatdatetime('yyyy''-''mm''-''dd',date);
      aqmain.Parameters[4].Value:=trim(operater);
      aqmain.Parameters[5].Value:=trim(shopid);// bumen
      aqmain.Parameters[6].Value:='�ŵ�:'+shopid+'�������';
      aqmain.Parameters[7].Value:='������ⵥ';
      aqmain.Prepared;
      aqmain.ExecSQL;
      i:=1;
      while not aqinfo.Eof do
      begin
        aqout.Close;  //д������ϸ
        aqout.SQL.Clear;
        aqout.SQL.Text:='insert into out_strip_detail (out_no,goods_no,goods_name,amount,price,money,ord) values (:od_ocode,:od_ccode,:od_cname,:od_count,:od_cprice,:od_money,:ord)';
        aqout.Parameters[0].Value:=trim(id);
        aqout.Parameters[1].Value:=aqinfo.fieldbyname('code').AsString;
        aqout.Parameters[2].Value:=aqinfo.fieldbyname('names').AsString;
        aqout.Parameters[3].Value:=aqinfo.fieldbyname('count').AsInteger;
        aqout.Parameters[4].Value:=aqinfo.fieldbyname('price').AsString;
        aqout.Parameters[5].Value:=aqinfo.fieldbyname('count').Asfloat*aqinfo.fieldbyname('price').Asfloat;
        aqout.Parameters[6].Value:=i;
        aqout.Prepared;
        aqout.ExecSQL;
        aqmain.Close;  //*
        aqmain.SQL.Clear;
        aqmain.SQL.Text:='update stock_states set out_amount=out_amount+'+trim(aqinfo.fieldbyname('count').AsString)+' where  goods_no=:no and Storage_NO=:shopid ';  //ȡ�����޸Ķ���״̬
        aqmain.Parameters[0].Value:=trim(aqinfo.fieldbyname('code').AsString);
        aqmain.Parameters[1].Value:=trim(shopid);
        aqmain.Prepared;
        aqmain.ExecSQL;
        aqinfo.Next;
        inc(i);
      end;
    end;
    aqinfo.Close; //������ⵥ��
    aqinfo.SQL.Clear;
    aqinfo.SQL.Text:='update dp_scrap  set s_state=:state where s_shop=:shopid and s_state=:state ';
    aqinfo.Parameters[0].Value:=trim('4');
    aqinfo.Parameters[1].Value:=trim(officeid);
    aqinfo.Parameters[2].Value:=trim('0'); //�ύ��־;
    aqinfo.ExecSQL;
  end;
  aqinfo.Close;
  aqmain.Close;
  aqout.Close;
end;

procedure TPublicServer.scrapsate(const sql: WideString);
begin
  aqmain.Close;
  aqmain.SQL.Clear;
  aqmain.SQL.Text:=trim(sql);
  aqmain.Prepared;
  aqmain.ExecSQL;
  aqmain.Close;
end;

function TPublicServer.inputFlat(const no, shopid: WideString): OleVariant;
var
  shopno,id,sql,make:string;
  i,flag:integer;
begin  //�ײ͵Ķ���Ӱ�����ⲢӰ���������Ʒ������
  flag:=1;
  try
  aqinfo.Close;
  aqinfo.SQL.Clear;
  aqinfo.SQL.Text:='select a.tranman,a.operater,a.goods_no,a.amount as inamount,a.goods_name,a.totalmoney,a.price,b.goods_no as code,b.amount as outamount,b.goods_name as names,b.price as oprice from dp_flat as a,dp_flatdetail as b where a.stock_no=b.stock_no and a.stock_no='+''''+trim(no)+'''';
  aqinfo.Open;
  id:='';
  sql:='select max(right(stock_no,4)) from stock_jion where copy_date='+''''+formatdatetime('yyyy''-''mm''-''dd',date)+''''+' and part_no='+''''+trim(shopID)+'''';
  make:='ISK-'+trim(shopid)+formatdatetime('yymmdd',date);
  id:=addid(aqout,sql,make);
  aqmain.Close;  //*  д������ⵥ
  aqmain.SQL.Clear;
  aqmain.SQL.Text:='insert into  stock_jion (stock_no,storage_no,transactor,copy_date,proposer,part_no,resume,Stock_Name) values (:code,:shop,:operater,:newdate,:newman,:part,:resumes,:names)';
  aqmain.Parameters[0].Value:=trim(id);
  aqmain.Parameters[1].Value:=trim(shopid);
  aqmain.Parameters[2].Value:=trim(aqinfo.fieldbyname('tranman').AsString);
  aqmain.Parameters[3].Value:=strtodate(formatdatetime('yyyy''-''mm''-''dd',date));
  aqmain.Parameters[4].Value:=trim(aqinfo.fieldbyname('operater').AsString);
  aqmain.Parameters[5].Value:=trim(shopid);
  aqmain.Parameters[6].Value:='�ŵ�:'+shopid+'�ײ���Ʒ���';
  aqmain.Parameters[7].Value:='��Ӫҵ����ⵥ';
  aqmain.Prepared;
  aqmain.ExecSQL;
   /////////////////////////�ݸ�
  sql:='insert into receipt (receipt_no,receipt_name,copy_date,Check_Result,Flag_Sign,Condense) values('+''''+trim(id)+''''+','+''''+trim('�ײ���Ʒ���')+''''+','+''''+trim(formatdatetime('yyyy''-''mm''-''dd',date))+''''+','+trim('6')+','+''''+trim('����')+''''+','+''''+trim('�ײ���Ʒ���')+''''+')';
  executesql(aqupdate,sql);
  ////////////////////////
  i:=1;
  aqout.Close;  //д�����ϸ
  aqout.SQL.Clear;
  aqout.SQL.Text:='insert into stock_jion_detail (stock_no,goods_no,goods_name,amount,price,Total_Money,ord) values (:id_icode,:id_ccode,:iod_cname,:id_count,:id_cprice,:id_money,:ord)';
  aqout.Parameters[0].Value:=trim(id);
  aqout.Parameters[1].Value:=trim(aqinfo.fieldbyname('goods_no').AsString);
  aqout.Parameters[2].Value:=trim(aqinfo.fieldbyname('goods_name').AsString);
  aqout.Parameters[3].Value:=aqinfo.fieldbyname('inamount').AsInteger;
  aqout.Parameters[4].Value:=aqinfo.fieldbyname('price').AsFloat;
  aqout.Parameters[5].Value:=aqinfo.fieldbyname('totalmoney').asfloat;
  aqout.Parameters[6].Value:=i;
  aqout.Prepared;
  aqout.ExecSQL;
  //////////////����ʵ�ʿ��/////////////////
  aqmain.Close;
  aqmain.SQL.Clear;
  aqmain.SQL.Text:='select * from stock_states where Storage_NO=:shopid and goods_no=:goodsno';
  aqmain.Parameters[0].Value:=trim(shopid);
  aqmain.Parameters[1].Value:=trim(aqinfo.fieldbyname('goods_no').AsString);
  aqmain.Prepared;
  aqmain.Open;
  if aqmain.IsEmpty then //û�о�������
  begin
    aqmain.Insert;
    aqmain.FieldByName('goods_no').AsString:=trim(aqinfo.fieldbyname('goods_no').AsString);
    aqmain.FieldByName('STORAGE_no').AsString:=trim(shopid);
    aqmain.FieldByName('in_amount').AsString:=trim(aqinfo.fieldbyname('inamount').AsString);
    aqmain.FieldByName('remark').AsString:=trim('�ײ���Ʒ');
  end else  //�����޸�����;
  begin
    aqmain.Edit;
    aqmain.FieldByName('in_amount').Asinteger:=aqmain.FieldByName('in_amount').Asinteger+aqinfo.fieldbyname('inamount').AsInteger;
  end;
  aqmain.Post;
  ///////////////////////
  aqinfo.First;
  ////////////////////������Ʒ���⣻
  id:='';
  sql:='select max(right(Out_NO,4)) from out_strip where copy_date='+''''+formatdatetime('yyyy''-''mm''-''dd',date)+''''+' and part_no='+''''+trim(shopID)+'''';
  make:='OSK-'+trim(shopid)+formatdatetime('yymmdd',date);
  id:=addid(aqout,sql,make);
  aqmain.Close;  //*  д���ⵥ
  aqmain.SQL.Clear;
  aqmain.SQL.Text:='insert into  out_strip (out_no,storage_no,transactor,copy_date,proposer,part_no,condense,Out_Name) values (:code,:shop,:operater,:newdate,:newman,:part,:resume,:names)';
  aqmain.Parameters[0].Value:=trim(id);
  //aqmain.Parameters[1].Value:=trim('1');
  aqmain.Parameters[1].Value:=trim(shopid);
  aqmain.Parameters[2].Value:=trim(aqinfo.fieldbyname('tranman').AsString);
  aqmain.Parameters[3].Value:=formatdatetime('yyyy''-''mm''-''dd',date);
  aqmain.Parameters[4].Value:=trim(aqinfo.fieldbyname('operater').AsString);
  aqmain.Parameters[5].Value:=trim(shopid);// bumen
  aqmain.Parameters[6].Value:='�ŵ�:'+shopid+'����ײ���Ʒ����';
  aqmain.Parameters[7].Value:='��Ӫҵ�Գ��ⵥ';
  aqmain.Prepared;
  aqmain.ExecSQL;
   /////////////////////////�ݸ�
  sql:='insert into receipt (receipt_no,receipt_name,copy_date,Check_Result,Flag_Sign,Condense) values('+''''+trim(id)+''''+','+''''+trim('�ײ���Ʒ����')+''''+','+''''+trim(formatdatetime('yyyy''-''mm''-''dd',date))+''''+','+trim('6')+','+''''+trim('����')+''''+','+''''+trim('�ײ���Ʒ����')+''''+')';
  executesql(aqupdate,sql);
  ////////////////////////
  while not aqinfo.Eof do
  begin
    aqout.Close;  //д������ϸ
    aqout.SQL.Clear;
    aqout.SQL.Text:='insert into out_strip_detail (out_no,goods_no,goods_name,amount,price,money,ord) values (:od_ocode,:od_ccode,:od_cname,:od_count,:od_cprice,:od_money,:ord)';
    aqout.Parameters[0].Value:=trim(id);
    aqout.Parameters[1].Value:=aqinfo.fieldbyname('code').AsString;
    aqout.Parameters[2].Value:=aqinfo.fieldbyname('names').AsString;
    aqout.Parameters[3].Value:=aqinfo.fieldbyname('outamount').AsInteger;
    aqout.Parameters[4].Value:=aqinfo.fieldbyname('oprice').AsString;
    aqout.Parameters[5].Value:=aqinfo.fieldbyname('outamount').Asfloat*aqinfo.fieldbyname('oprice').Asfloat;
    aqout.Parameters[6].Value:=i;
    aqout.Prepared;
    aqout.ExecSQL;
    aqmain.Close;  //*
    aqmain.SQL.Clear;
    aqmain.SQL.Text:='update stock_states set out_amount=out_amount+'+trim(aqinfo.fieldbyname('outamount').AsString)+' where  goods_no=:no and Storage_NO=:shopid ';  //ȡ�����޸Ķ���״̬
    aqmain.Parameters[0].Value:=trim(aqinfo.fieldbyname('code').AsString);
    aqmain.Parameters[1].Value:=trim(shopid);
    aqmain.Prepared;
    aqmain.ExecSQL;
    aqinfo.Next;
    inc(i);
  end;
  flag:=3;
  except
  end;
   aqinfo.Close;
  aqmain.Close;
  aqout.Close;
  result:=flag;
  //////////////
end;

procedure TPublicServer.Gether(const G_no: WideString; money: Double; flag,
  bz: Integer);
begin  //�޸Ĺ�Ӧ�̵�Ӧ��Ӧ��
  aqmain.Close;
  aqmain.SQL.Clear;
  aqmain.SQL.Text:=' select * from supply_company where supply_NO='+''''+trim(G_no)+'''';
  aqmain.Open;
  if flag=1 then  //Ӧ��  (flag:1,Ӧ����0��Ӧ�գ�bz(0,1):�ۼӣ�����
  begin
    if not aqmain.IsEmpty then
    begin
      aqmain.Edit;
      if bz=1 then
      begin
        aqmain.FieldByName('totalrise').Asfloat:=aqmain.FieldByName('totalrise').Asfloat+money;
      end else
      begin
        if aqmain.FieldByName('totalrise').Asfloat>=money then
        begin
          aqmain.FieldByName('totalrise').Asfloat:=aqmain.FieldByName('totalrise').Asfloat-money;
        end else
        begin
          aqmain.FieldByName('receivables').Asfloat:=aqmain.FieldByName('receivables').Asfloat+(money-aqmain.FieldByName('totalrise').Asfloat);
          aqmain.FieldByName('totalrise').Asfloat:=0;
        end;
      end;

      aqmain.Post;
    end;
  end else
  begin
    if not aqmain.IsEmpty then
    begin
      aqmain.Edit;
      if bz=1 then
      begin
        aqmain.FieldByName('receivables').Asfloat:=aqmain.FieldByName('receivables').Asfloat+money;
      end else
      begin
        if aqmain.FieldByName('receivables').Asfloat>=money then
        begin
          aqmain.FieldByName('receivables').Asfloat:=aqmain.FieldByName('receivables').Asfloat-money;
        end else
        begin
          aqmain.FieldByName('totalrise').Asfloat:=aqmain.FieldByName('totalrise').Asfloat+(money-aqmain.FieldByName('receivables').Asfloat);
          aqmain.FieldByName('receivables').Asfloat:=0;
        end;
      end;
    aqmain.Post;
    end;
  end;
  aqmain.Close;
end;
function TPublicServer.MoneyTable(index: Integer; const no: WideString;
  totalmoneys: Double; const billid, checkid, passid, wldwno, wldwname,
  shopid, remark: WideString): OleVariant;  //д�������� ;
var
  b:boolean;
begin
  b:=INSERTmantable(index,no,totalmoneys,passid,checkid,billid,wldwno,wldwname,shopid,remark,aqwritemaintable,AQtotalmoney);
  if b then
   begin
     result:='1';
   end else
   begin
     result:='0';
   end;
end;

function TPublicServer.batchstock(const stock_no: WideString;
  typed: Integer): OleVariant;
var
  sqlpub,id,sql,make:string;
  flag,i:integer;
begin //���ͳ���⣬Ӱ����仯����Ӱ������   (д�������ⵥ)
  flag:=2;//
  if typed =1 then     //���ͳ���
   begin
    aqmain.Close;
    aqmain.SQL.Clear;
    aqmain.SQL.Text:='select a.*,b.*,c.baseprice from SendDetailTable as a,SendmasterTable as b,goods_prices as c where a.vcSendBillId=b.vcSendBillId and a.vcPtypeid=c.goods_no and b.BillNo='+''''+trim(stock_no)+'''';
    aqmain.Open;
    if not aqmain.IsEmpty then
    begin
      ///////////////д��������///////////////
      id:='';
      sql:='select max(right(Out_NO,4)) from out_strip where copy_date='+''''+formatdatetime('yyyy''-''mm''-''dd',date)+''''+' and part_no='+''''+trim(aqmain.fieldbyname('vcsendstockID').AsString)+'''';
      make:='OSK-'+trim(aqmain.fieldbyname('vcsendstockID').AsString)+formatdatetime('yymmdd',date);
      id:=addid(aqout,sql,make);
      aqinfo.Close;  //*  д���ⵥ
      aqinfo.SQL.Clear;
      aqinfo.SQL.Text:='insert into  out_strip (out_no,storage_no,transactor,copy_date,proposer,part_no,condense,Out_Name) values (:code,:shop,:operater,:newdate,:newman,:part,:resume,:names)';
      aqinfo.Parameters[0].Value:=trim(id);
      //aqmain.Parameters[1].Value:=trim('1');
      aqinfo.Parameters[1].Value:=trim(aqmain.fieldbyname('vcsendstockID').AsString);
      aqinfo.Parameters[2].Value:=trim(aqmain.fieldbyname('vcListerid').AsString);
      aqinfo.Parameters[3].Value:=formatdatetime('yyyy''-''mm''-''dd',date);
      aqinfo.Parameters[4].Value:=trim(aqmain.fieldbyname('vcEid').AsString);
      aqinfo.Parameters[5].Value:=trim(aqmain.fieldbyname('vcsendstockID').AsString);// bumen
      aqinfo.Parameters[6].Value:='�ֿ�:'+trim(aqmain.fieldbyname('vcsendstockID').AsString)+'���ͳ���';
      aqinfo.Parameters[7].Value:='���ͳ��ⵥ';
      aqinfo.Prepared;
      aqinfo.ExecSQL;
      aqmain.First;
      i:=1;
      ////////////////////////////////////
      while not aqmain.Eof do
      begin
        aqinfo.Close;  //д������ϸ
        aqinfo.SQL.Clear;
        aqinfo.SQL.Text:='insert into out_strip_detail (out_no,goods_no,goods_name,amount,price,money,ord) values (:od_ocode,:od_ccode,:od_cname,:od_count,:od_cprice,:od_money,:ord)';
        aqinfo.Parameters[0].Value:=trim(id);
        aqinfo.Parameters[1].Value:=aqmain.fieldbyname('VcPtypeid').AsString;
        aqinfo.Parameters[2].Value:=trim('');
        aqinfo.Parameters[3].Value:=aqmain.fieldbyname('nuoutquantity').AsInteger;
        aqinfo.Parameters[4].Value:=aqmain.fieldbyname('baseprice').AsString;
        aqinfo.Parameters[5].Value:=aqmain.fieldbyname('nuoutquantity').Asfloat*aqmain.fieldbyname('baseprice').Asfloat;
        aqinfo.Parameters[6].Value:=i;
        aqinfo.Prepared;
        aqinfo.ExecSQL;
        /////////////////////////////////////////////////
        sqlpub:='update stock_states set out_amount=out_amount+'+aqmain.fieldbyname('nuOutQuantity').AsString+' where storage_no='+''''+trim(aqmain.fieldbyname('VcSendStockID').AsString)+''''+' and goods_no='+''''+trim(aqmain.fieldbyname('vcPtypeid').AsString)+'''';
        ///////////////////////////
        executesql(aqout,sqlpub);  //�޸Ĵֻ���λ������
        ///////////////////////////
         //�����ջ���λ���Ϳ��;
         AQOUT.Close;
         AQOUT.SQL.Clear;
         AQOUT.SQL.Text:='select * from stock_states where goods_no='+''''+trim(aqmain.fieldbyname('vcPtypeid').AsString)+''''+' and storage_no='+''''+trim(aqmain.fieldbyname('vcRecvStockID').AsString)+'''';
         AQOUT.Open;
         if AQOUT.IsEmpty then
         begin
           AQOUT.Insert;
           AQOUT.FieldByName('storage_no').AsString:=trim(aqmain.fieldbyname('vcRecvStockID').AsString);
           AQOUT.FieldByName('goods_no').AsString:=trim(aqmain.fieldbyname('vcPtypeid').AsString);
           AQOUT.FieldByName('PS_amount').Asinteger:=aqmain.fieldbyname('nuOutQuantity').AsInteger;
         end else
         begin
           AQOUT.Edit;
           AQOUT.FieldByName('PS_amount').Asinteger:=AQOUT.FieldByName('PS_amount').Asinteger+aqmain.fieldbyname('nuOutQuantity').AsInteger;
         end;
         AQOUT.Post;  //��������
        ////////////////////////
        aqmain.Next;
      end;
      flag:=3;
    end;
  end;
  if typed=2 then   //�ջ�
  begin
    aqmain.Close;
    aqmain.SQL.Clear;
    aqmain.SQL.Text:='select a.*,b.*,c.baseprice from SendDetailTable as a,SendmasterTable as b,goods_prices as c where a.vcSendBillId=b.vcSendBillId and a.vcPtypeid=c.goods_no and b.BillNo='+''''+trim(stock_no)+'''';
    aqmain.Open;
    if not aqmain.IsEmpty then
    begin
      ///////////////////////////// �������///////
      id:='';
      sql:='select max(right(stock_no,4)) from stock_jion where copy_date='+''''+formatdatetime('yyyy''-''mm''-''dd',date)+''''+' and part_no='+''''+trim(aqmain.fieldbyname('vcRecvStockID').AsString)+'''';
      make:='ISK-'+trim(aqmain.fieldbyname('vcRecvStockID').AsString)+formatdatetime('yymmdd',date);
      id:=addid(aqout,sql,make);
      aqinfo.Close;  //*  д������ⵥ
      aqinfo.SQL.Clear;
      aqinfo.SQL.Text:='insert into  stock_jion (stock_no,storage_no,transactor,copy_date,proposer,part_no,resume,Stock_Name) values (:code,:shop,:operater,:newdate,:newman,:part,:resumes,:names)';
      aqinfo.Parameters[0].Value:=trim(id);
      aqinfo.Parameters[1].Value:=trim(aqmain.fieldbyname('vcRecvStockID').AsString);
      aqinfo.Parameters[2].Value:=trim(aqmain.fieldbyname('vcListerid').AsString);
      aqinfo.Parameters[3].Value:=strtodate(formatdatetime('yyyy''-''mm''-''dd',date));
      aqinfo.Parameters[4].Value:=trim(aqmain.fieldbyname('vcEid').AsString);
      aqinfo.Parameters[5].Value:=trim(aqmain.fieldbyname('vcRecvStockID').AsString);
      aqinfo.Parameters[6].Value:='�ֿ�:'+trim(aqmain.fieldbyname('vcRecvStockID').AsString)+'������Ʒ���';
      aqinfo.Parameters[7].Value:='�����ջ���ⵥ';
      aqinfo.Prepared;
      aqinfo.ExecSQL;
      aqmain.First;
      i:=1;
      //////////////////////////////
      while not aqmain.Eof do
      begin
        aqout.Close;  //д�����ϸ
        aqout.SQL.Clear;
        aqout.SQL.Text:='insert into stock_jion_detail (stock_no,goods_no,goods_name,amount,price,Total_Money,ord) values (:id_icode,:id_ccode,:iod_cname,:id_count,:id_cprice,:id_money,:ord)';
        aqout.Parameters[0].Value:=trim(id);
        aqout.Parameters[1].Value:=trim(aqmain.fieldbyname('VcPtypeid').AsString);
        aqout.Parameters[2].Value:=trim('');
        aqout.Parameters[3].Value:=aqmain.fieldbyname('nuoutquantity').AsInteger;
        aqout.Parameters[4].Value:=aqmain.fieldbyname('baseprice').AsFloat;
        aqout.Parameters[5].Value:=aqmain.fieldbyname('nuoutquantity').Asfloat*aqmain.fieldbyname('baseprice').Asfloat;
        aqout.Parameters[6].Value:=i;
        aqout.Prepared;
        aqout.ExecSQL;
        sqlpub:='update stock_states set in_amount=in_amount+'+aqmain.fieldbyname('nuOutQuantity').AsString+' where storage_no='+''''+trim(aqmain.fieldbyname('vcRecvStockID').AsString)+''''+' and goods_no='+''''+trim(aqmain.fieldbyname('vcPtypeid').AsString)+'''';
        ///////////////////////////
        executesql(aqout,sqlpub);  //�޸��ջ���λ������
        ///////////////////////////
        sqlpub:='update stock_states set ps_amount=ps_amount-'+aqmain.fieldbyname('nuOutQuantity').AsString+' where storage_no='+''''+trim(aqmain.fieldbyname('vcRecvStockID').AsString)+''''+' and goods_no='+''''+trim(aqmain.fieldbyname('vcPtypeid').AsString)+'''';
        ////////////////////////////////
        executesql(aqout,sqlpub);  //�����ջ���λ���Ϳ��;
        ////////////////////////
        aqmain.Next;
      end;
    end;
    flag:=3;
  end;
  if typed=3 then   //�˻�
  begin
    aqmain.Close;
    aqmain.SQL.Clear;
    aqmain.SQL.Text:='select a.*,b.*,c.baseprice from SendDetailTable as a,SendmasterTable as b,goods_prices as c where a.vcSendBillId=b.vcSendBillId and a.vcPtypeid=c.goods_no and b.BillNo='+''''+trim(stock_no)+'''';
    aqmain.Open;
    if not aqmain.IsEmpty then
    begin
       ///////////////д��������///////////////
      id:='';
      sql:='select max(right(Out_NO,4)) from out_strip where copy_date='+''''+formatdatetime('yyyy''-''mm''-''dd',date)+''''+' and part_no='+''''+trim(aqmain.fieldbyname('vcsendstockID').AsString)+'''';
      make:='OSK-'+trim(aqmain.fieldbyname('vcRecvstockID').AsString)+formatdatetime('yymmdd',date);
      id:=addid(aqout,sql,make);
      aqinfo.Close;  //*  д���ⵥ
      aqinfo.SQL.Clear;
      aqinfo.SQL.Text:='insert into  out_strip (out_no,storage_no,transactor,copy_date,proposer,part_no,condense,Out_Name) values (:code,:shop,:operater,:newdate,:newman,:part,:resume,:names)';
      aqinfo.Parameters[0].Value:=trim(id);
      //aqmain.Parameters[1].Value:=trim('1');
      aqinfo.Parameters[1].Value:=trim(aqmain.fieldbyname('vcRecvstockID').AsString);
      aqinfo.Parameters[2].Value:=trim(aqmain.fieldbyname('vcListerid').AsString);
      aqinfo.Parameters[3].Value:=formatdatetime('yyyy''-''mm''-''dd',date);
      aqinfo.Parameters[4].Value:=trim(aqmain.fieldbyname('vcEid').AsString);
      aqinfo.Parameters[5].Value:=trim(aqmain.fieldbyname('vcRecvstockID').AsString);// bumen
      aqinfo.Parameters[6].Value:='�ֿ�:'+trim(aqmain.fieldbyname('vcsendstockID').AsString)+'���ͳ���';
      aqinfo.Parameters[7].Value:='�����˻����ⵥ';
      aqinfo.Prepared;
      aqinfo.ExecSQL;
      aqmain.First;
      i:=1;
      ////////////////////////////////////
      while not aqmain.Eof do
      begin
        aqinfo.Close;  //д������ϸ
        aqinfo.SQL.Clear;
        aqinfo.SQL.Text:='insert into out_strip_detail (out_no,goods_no,goods_name,amount,price,money,ord) values (:od_ocode,:od_ccode,:od_cname,:od_count,:od_cprice,:od_money,:ord)';
        aqinfo.Parameters[0].Value:=trim(id);
        aqinfo.Parameters[1].Value:=aqmain.fieldbyname('VcPtypeid').AsString;
        aqinfo.Parameters[2].Value:=trim('');
        aqinfo.Parameters[3].Value:=aqmain.fieldbyname('nuoutquantity').AsInteger;
        aqinfo.Parameters[4].Value:=aqmain.fieldbyname('baseprice').AsString;
        aqinfo.Parameters[5].Value:=aqmain.fieldbyname('nuoutquantity').Asfloat*aqmain.fieldbyname('baseprice').Asfloat;
        aqinfo.Parameters[6].Value:=i;
        aqinfo.Prepared;
        aqinfo.ExecSQL;
        /////////////////////////////////////////////
        sqlpub:='update stock_states set in_amount=in_amount+'+aqmain.fieldbyname('nuOutQuantity').AsString+' where storage_no='+''''+trim(aqmain.fieldbyname('VcSendStockID').AsString)+''''+' and goods_no='+''''+trim(aqmain.fieldbyname('vcPtypeid').AsString)+'''';
        ///////////////////////////
        executesql(aqout,sqlpub);  //�޸��ջ���λ�����
        ///////////////////////////
        sqlpub:='update stock_states set out_amount=out_amount+'+aqmain.fieldbyname('nuOutQuantity').AsString+' where storage_no='+''''+trim(aqmain.fieldbyname('vcRecvStockID').AsString)+''''+' and goods_no='+''''+trim(aqmain.fieldbyname('vcPtypeid').AsString)+'''';
        ////////////////////////////////
        executesql(aqout,sqlpub);  //�����ջ���λ���Ϳ��;
        ////////////////////////
        aqmain.Next;
      end;
    end;
    flag:=3;
  end;
  aqmain.Close;
  aqout.Close;
  result:=flag;
end;

function TPublicServer.PubBacth(const sqltemp: WideString): OleVariant;
begin
 
end;

function TPublicServer.Updatebatch(const stock_no,
  part_no: WideString): OleVariant;
var
 goods_no,tempsql:string;
 flag:integer;
begin            //�޸�Ҫ���ƻ�������������
  flag:=2;
  aqmain.Close;
  aqmain.SQL.Clear;
  aqmain.SQL.Text:='select a.vcPtypeid,a.nuOutQuantity from SendDetailTable as a,sendmastertable as b where a.vcSendBillId=b.vcSendBillId and b.BillNo='+''''+trim(stock_no)+'''';
  aqmain.Open;
  while not aqmain.Eof do
  begin
    goods_no:=aqmain.fieldbyname('vcPtypeid').AsString;
    AQinfo.Close;
    AQinfo.SQL.Clear;
    aqinfo.SQL.Text:='select b.VcGetGoodsPlanID from getgoodsplan as a,GetGoodsPlanMaster as b where a.VcGetGoodsPlanID=b.VcGetGoodsPlanID and a.totalamount >0 and b.VCOfficeID='+''''+trim(part_no)+''''+' and a.VCPtyieID='+''''+trim(goods_no)+'''';
    aqinfo.Open;//�ҵ������ţ�
    ///////////////////////////////
    tempsql:='update getgoodsplan set NSendQty= NSendQty +'+aqmain.FieldByName('nuOutQuantity').AsString+' where  totalamount >0 and VCPtyieID ='+''''+trim(goods_no)+''''+' and VcGetGoodsPlanID='+''''+trim(aqinfo.fieldbyname('VcGetGoodsPlanID').AsString)+'''';
    executesql(aqout,tempsql);
    //////////////////////////
    aqmain.Next;
  end;
  flag:=3;
   aqinfo.Close;
  aqmain.Close;
  result:=flag;
end;

function TPublicServer.OutNewShop(const no: WideString): OleVariant;
var
  shopno,id,sql,make,restock:string;
  i,flag:integer;
begin  //�µ��̻�
  flag:=1;
  try
  aqinfo.Close;
  aqinfo.SQL.Clear;
  aqinfo.SQL.Text:=' select a.transactor,a.proposer,b.goods_no as code,b.amount as outamount,c.goods_name as names,c.baseprice as oprice,sendstock_no,retailstock_no from storage_jion as a,storage_jion_detail as b,[Vgoodscodeprice] as c where a.stock_no=b.stock_no and'+
  ' b.goods_no=c.goods_no and  A.stock_no='+''''+trim(no)+'''';
  aqinfo.Open;
  shopno:=trim(aqinfo.fieldbyname('sendstock_no').AsString);
  restock:= trim(aqinfo.fieldbyname('retailstock_no').AsString);
  ////////////////////������Ʒ���⣻
  id:='';
  sql:='select max(right(Out_NO,4)) from out_strip where copy_date='+''''+formatdatetime('yyyy''-''mm''-''dd',date)+''''+' and part_no='+''''+trim(shopno)+'''';
  make:='OSK-'+trim(shopno)+formatdatetime('yymmdd',date);
  id:=addid(aqout,sql,make);
  aqmain.Close;  //*  д���ⵥ
  aqmain.SQL.Clear;
  aqmain.SQL.Text:='insert into  out_strip (out_no,storage_no,transactor,copy_date,proposer,part_no,condense,Out_Name) values (:code,:shop,:operater,:newdate,:newman,:part,:resume,:names)';
  aqmain.Parameters[0].Value:=trim(id);
  aqmain.Parameters[1].Value:=trim(shopno);
  aqmain.Parameters[2].Value:=trim(aqinfo.fieldbyname('transactor').AsString);
  aqmain.Parameters[3].Value:=formatdatetime('yyyy''-''mm''-''dd',date);
  aqmain.Parameters[4].Value:=trim(aqinfo.fieldbyname('proposer').AsString);
  aqmain.Parameters[5].Value:=trim(shopno);// bumen
  aqmain.Parameters[6].Value:='�ֿ�:'+shopno+'��ֿ� '+restock+'�µ��̻�';
  aqmain.Parameters[7].Value:='��Ӫҵ�Գ��ⵥ';
  aqmain.Prepared;
  aqmain.ExecSQL;
  /////////////////////////�ݸ�
  sql:='insert into receipt (receipt_no,receipt_name,copy_date,Check_Result,Flag_Sign,Condense) values('+''''+trim(id)+''''+','+''''+trim('�µ��̻�����')+''''+','+''''+trim(formatdatetime('yyyy''-''mm''-''dd',date))+''''+','+trim('6')+','+''''+trim('����')+''''+','+''''+trim('�µ��̻�����')+''''+')';
  executesql(aqupdate,sql);
  i:=1;
  ////////////////////////
  while not aqinfo.Eof do
  begin
    aqout.Close;  //д������ϸ
    aqout.SQL.Clear;
    aqout.SQL.Text:='insert into out_strip_detail (out_no,goods_no,goods_name,amount,price,money,ord) values (:od_ocode,:od_ccode,:od_cname,:od_count,:od_cprice,:od_money,:ord)';
    aqout.Parameters[0].Value:=trim(id);
    aqout.Parameters[1].Value:=aqinfo.fieldbyname('code').AsString;
    aqout.Parameters[2].Value:=aqinfo.fieldbyname('names').AsString;
    aqout.Parameters[3].Value:=aqinfo.fieldbyname('outamount').AsInteger;
    aqout.Parameters[4].Value:=aqinfo.fieldbyname('oprice').AsString;
    aqout.Parameters[5].Value:=aqinfo.fieldbyname('outamount').Asfloat*aqinfo.fieldbyname('oprice').Asfloat;
    aqout.Parameters[6].Value:=i;
    aqout.Prepared;
    aqout.ExecSQL;
    aqmain.Close;  //*  ��������λ���
    aqmain.SQL.Clear;
    aqmain.SQL.Text:='update stock_states set out_amount=out_amount+'+trim(aqinfo.fieldbyname('outamount').AsString)+' where  goods_no=:no and Storage_NO=:shopid ';  //ȡ�����޸Ķ���״̬
    aqmain.Parameters[0].Value:=trim(aqinfo.fieldbyname('code').AsString);
    aqmain.Parameters[1].Value:=trim(shopno);
    aqmain.Prepared;
    aqmain.ExecSQL;
    /////////////////////////////
    ///////////////////////////
    aqinfo.Next;
    inc(i);
  end;
  aqinfo.First;
  ///////////////////////// �µ��ջ�
  id:='';
  sql:='select max(right(stock_no,4)) from stock_jion where copy_date='+''''+formatdatetime('yyyy''-''mm''-''dd',date)+''''+' and part_no='+''''+trim(restock)+'''';
  make:='ISK-'+trim(restock)+formatdatetime('yymmdd',date);
  id:=addid(aqout,sql,make);
  aqmain.Close;  //*  д��Ӫҵ����ⵥ
  aqmain.SQL.Clear;
  aqmain.SQL.Text:='insert into  stock_jion (stock_no,storage_no,transactor,copy_date,proposer,part_no,resume,Stock_Name) values (:code,:shop,:operater,:newdate,:newman,:part,:resumes,:names)';
  aqmain.Parameters[0].Value:=trim(id);
  aqmain.Parameters[1].Value:=trim(restock);
  aqmain.Parameters[2].Value:=trim(aqinfo.fieldbyname('transactor').AsString);
  aqmain.Parameters[3].Value:=strtodate(formatdatetime('yyyy''-''mm''-''dd',date));
  aqmain.Parameters[4].Value:=trim(aqinfo.fieldbyname('proposer').AsString);
  aqmain.Parameters[5].Value:=trim(restock);
  aqmain.Parameters[6].Value:='�ֿ�:'+restock+' �յ� �ɷ����ֿ�'+shopno+' ����Ʒ���';
  aqmain.Parameters[7].Value:='��Ӫҵ����ⵥ';
  aqmain.Prepared;
  aqmain.ExecSQL;
  ///////////////////////// �ݸ�
  sql:='insert into receipt (receipt_no,receipt_name,copy_date,Check_Result,Flag_Sign,Condense) values('+''''+trim(id)+''''+','+''''+trim('�µ��̻����')+''''+','+''''+trim(formatdatetime('yyyy''-''mm''-''dd',date))+''''+','+trim('6')+','+''''+trim('����')+''''+','+''''+trim('�µ��̻����')+''''+')';
 executesql(aqupdate,sql);
  /////////////////////////////////
  i:=1;
  while not aqinfo.Eof do
  begin
    aqout.Close;  //д�����ϸ
    aqout.SQL.Clear;
    aqout.SQL.Text:='insert into stock_jion_detail (stock_no,goods_no,goods_name,amount,price,Total_Money,ord) values (:id_icode,:id_ccode,:iod_cname,:id_count,:id_cprice,:id_money,:ord)';
    aqout.Parameters[0].Value:=trim(id);
    aqout.Parameters[1].Value:=trim(aqinfo.fieldbyname('code').AsString);
    aqout.Parameters[2].Value:=trim(aqinfo.fieldbyname('names').AsString);
    aqout.Parameters[3].Value:=aqinfo.fieldbyname('outamount').AsInteger;
    aqout.Parameters[4].Value:=aqinfo.fieldbyname('oprice').AsFloat;
    aqout.Parameters[5].Value:=aqinfo.fieldbyname('outamount').asfloat*aqinfo.fieldbyname('oprice').AsFloat;
    aqout.Parameters[6].Value:=i;
    aqout.Prepared;
    aqout.ExecSQL;
    //////////////����ʵ�ʿ��/////////////////
   aqmain.Close;
    aqmain.SQL.Clear;
    aqmain.SQL.Text:='select * from stock_states where Storage_NO=:shopid and goods_no=:goodsno';
    aqmain.Parameters[0].Value:=trim(restock);
    aqmain.Parameters[1].Value:=trim(aqinfo.fieldbyname('code').AsString);
    aqmain.Prepared;
    aqmain.Open;
    if aqmain.IsEmpty then //û�о�������
    begin
      aqmain.Insert;
      aqmain.FieldByName('goods_no').AsString:=trim(aqinfo.fieldbyname('code').AsString);
      aqmain.FieldByName('STORAGE_no').AsString:=trim(restock);
      aqmain.FieldByName('in_amount').AsString:=trim(aqinfo.fieldbyname('outamount').AsString);
    end else  //�����޸�����;
    begin
      aqmain.Edit;
      aqmain.FieldByName('in_amount').Asinteger:=aqmain.FieldByName('in_amount').Asinteger+aqinfo.fieldbyname('outamount').AsInteger;
    end;
    aqmain.Post;
    ///////////////////////
    aqinfo.Next;
    inc(i);
  end;
  //////////////////////////
  flag:=3;
  except
  end;
 aqinfo.Close;
  aqmain.Close;
  aqout.Close;
  result:=flag;
end;

function TPublicServer.MZSGOODS(const no: WideString;
  Flag: Integer): OleVariant;
var
  flags,sql:string;   //��Ʒת��ת��
begin
  flags:='2';
  sql:='select * from present_detail where present_no='+''''+trim(no)+'''';
  aqmain.Close;
  aqmain.SQL.Clear;
  aqmain.SQL.Text:=sql;
  aqmain.Open;
  try
    while not aqmain.Eof do
    begin
      if flag=1 then
      begin
        sql:=' update stock_states set in_amount=in_amount-(in_amount*'+aqmain.fieldbyname('amount_agion').AsString +'),award_amount=award_amount+(in_amount*'+aqmain.fieldbyname('amount_agion').AsString +') where goods_no='+''''+trim(aqmain.fieldbyname('goods_no').AsString)+'''';
      end else
      begin
        if aqmain.fieldbyname('amount_agion').Asfloat>0 then
        begin
          sql:=' update stock_states set in_amount=in_amount+(award_amount*'+aqmain.fieldbyname('amount_agion').AsString +'),award_amount=award_amount-(award_amount*'+aqmain.fieldbyname('amount_agion').AsString +') where award_amount >0 and goods_no='+''''+trim(aqmain.fieldbyname('goods_no').AsString)+'''';
        end else
        begin
          sql:=' update stock_states set in_amount=in_amount+award_amount,award_amount=0 where award_amount >0 and goods_no='+''''+trim(aqmain.fieldbyname('goods_no').AsString)+'''';
        end;
      end;
      aqinfo.Close;
      aqinfo.SQL.Clear;
      aqinfo.SQL.Text:=sql;
      aqinfo.ExecSQL;
      aqmain.Next;
    end;
    aqinfo.Close;
    flags:='3';
  except
  end;
   aqinfo.Close;
  aqmain.Close;
  result:=flags;
end;


procedure TPublicServer.LQ_WriteFinanceBill(billid, BillType: Integer;
  BillDate: OleVariant; const AccountId, AccountName, AccountId2,
  AccountName2: WideString; Total: Double; const Comment: WideString;
  ord: Integer; out nRet: Integer; const ShopNo: WideString;
  EditMode: Integer);
begin
   with InsertProc do
     begin
        ProcedureName:='LQ_WriteFinanceBill;1';
        Parameters.Clear;
        Parameters.Refresh;
        Parameters.ParamByName('@BillId').Value:=BillId;
        Parameters.ParamByName('@BillType').Value:=BillType;
        Parameters.ParamByName('@BillDate').Value:=BillDate;
        Parameters.ParamByName('@AccountId').Value:=AccountId;
        Parameters.ParamByName('@AccountName').Value:=AccountName;
        Parameters.ParamByName('@AccountId2').Value:=AccountId2;
        Parameters.ParamByName('@AccountName2').Value:=AccountName2;
        Parameters.ParamByName('@Total').Value:=Total;
        Parameters.ParamByName('@Comment').Value:=Comment;
        Parameters.ParamByName('@ord').Value:=ord;
        Parameters.ParamByName('@ShopNo').Value:=Shopno;
        Parameters.ParamByName('@EditMode').Value:=editmode;
        Prepared := false;  //ydy add
        ExecProc;
        nRet:=Parameters.ParamByName('@Return_Value').value;
     end;
end;

procedure TPublicServer.WriteMainBill(const BillCode: WideString;
  BillType: Integer; BillDate: OleVariant; const BillEId, CheckEid,
  PassEid, UnitId, UnitName: WideString; Total: Double; IsCheck,
  Red: Integer; const PosId, Explain: WideString; out ret: Integer;
  EditMode, Billid: Integer);
begin
   with InsertProc do
     begin
        ProcedureName:='WriteMainBill;1';
        Parameters.Clear;
        Parameters.Refresh;
        Parameters.ParamByName('@BillCode').Value:=BillCode;
        Parameters.ParamByName('@BillType').Value:=BillType;
        Parameters.ParamByName('@BillDate').Value:=BillDate;
        Parameters.ParamByName('@BillEId').Value:=BillEId;
        Parameters.ParamByName('@CheckEid').Value:=CheckEid;
        Parameters.ParamByName('@PassEid').Value:=PassEid;
        Parameters.ParamByName('@UnitId').Value:=UnitId;
        Parameters.ParamByName('@UnitName').Value:=UnitName;
        Parameters.ParamByName('@Total').Value:=Total;
        Parameters.ParamByName('@IsCheck').Value:=IsCheck;
        Parameters.ParamByName('@Red').Value:=Red;
        Parameters.ParamByName('@ShopNo').Value:=PosId;
        Parameters.ParamByName('@Explain').Value:=Explain;
        Parameters.ParamByName('@EditMode').Value:=editmode;
        Parameters.ParamByName('@Billid').Value:=Billid;
        Prepared := false;  //ydy add
        ExecProc;
        ret:=Parameters.ParamByName('@Return_Value').value;
     end;
end;

function TPublicServer.EditMoney(Main_no: Integer;
  const CheckID: WideString): Integer;
begin
  result:=TotalProcedure(main_no,checkid,AQtotalmoney);
end;

initialization
  TComponentFactory.Create(ComServer, TPublicServer,
    Class_PublicServer, ciMultiInstance, tmApartment);
end.
