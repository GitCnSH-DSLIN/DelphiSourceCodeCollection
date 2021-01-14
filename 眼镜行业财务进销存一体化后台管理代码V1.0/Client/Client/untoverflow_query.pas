unit untoverflow_query;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fm_Base, DB, Grids, DBGrids, StdCtrls, Mask, Buttons, ExtCtrls;

type
  Tfm_OverFlow_Query = class(TfmBase)
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    BtnClose: TBitBtn;
    Panel3: TPanel;
    js: TLabel;
    Label12: TLabel;
    Label7: TLabel;
    SpeedButton10: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    jsr: TComboBox;
    zdr: TComboBox;
    djbh: TComboBox;
    rq1: TMaskEdit;
    rq2: TMaskEdit;
    DB: TDBGrid;
    dscheck: TDataSource;
    dsdetail: TDataSource;
    DBGrid1: TDBGrid;
    edtpart: TLabeledEdit;
    BtnSelPayComponey: TSpeedButton;
    SPBDetail: TSpeedButton;
    DsDview: TDataSource;
    DBGrid2: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure DBDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSelPayComponeyClick(Sender: TObject);
    procedure DBGrid2TitleClick(Column: TColumn);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBTitleClick(Column: TColumn);
    procedure SPBDetailClick(Sender: TObject);
  private
    { Private declarations }
    bm:string;
  public
    { Public declarations }
  end;

var
  fm_OverFlow_Query: Tfm_OverFlow_Query;

implementation
uses untdatadm, Data, func, UntSQpspart;

{$R *.dfm}

procedure Tfm_OverFlow_Query.FormShow(Sender: TObject);
begin
  inherited;
  dmmain.CDSquery.Close;
end;

procedure Tfm_OverFlow_Query.SpeedButton10Click(Sender: TObject);
var
  sqlpub:widestring;
  T_date:Tdatetime;  //����¼��������
  i:integer;
begin
  inherited;
  dmmain.CDSquery.Close;
  dmmain.CDSquery.Data:=null;
  sqlpub:='select * from [DP_Overflow] where';
  if trim(djbh.Text)<>'' then sqlpub:=sqlpub+' O_Code='+''''+trim(djbh.Text)+''''+' and';
  //if trim(edtshr.Text)<>'' then sqlpub:=sqlpub+' O_Auditer='+''''+trim(edtshr.Text)+''''+' and';
  if trim(jsr.Text)<>'' then sqlpub:=sqlpub+' O_Operater='+''''+trim(jsr.Text)+''''+' and';
  if trim(zdr.Text)<>'' then sqlpub:=sqlpub+' O_NewMan='+''''+trim(zdr.Text)+''''+' and';
  if trim(edtpart.Text)<>'' then sqlpub:=sqlpub+' o_shop='+''''+trim(bm)+''''+' and';
  if (rq1.Text<>'    -  -  ') and (rq2.Text<>'    -  -  ') then
  begin
    try
      t_date:=strtodate(rq1.Text);
      t_date:=strtodate(rq2.Text);
      sqlpub:=sqlpub+' O_NewDate between '+''''+rq1.Text+''''+' and '+''''+rq2.Text+''''+' and';
    except
      showmessage('�������¼�������������������룡');
      exit;
    end;
  end else
  begin
    rq1.Text:='';
    rq2.Text:='';
  end;
  sqlpub:=copy(sqlpub,0,length(sqlpub)-4);
  dmmain.CDSquery.Close;
  dmmain.CDSquery.Data:=adisp.GetRecord(sqlpub);
  dmmain.CDSquery.Open;
   dbgrid1.Visible:=false;
  dbgrid2.Visible:=false;
  db.Visible:=true;
end;

procedure Tfm_OverFlow_Query.DBDblClick(Sender: TObject);
var
  sql:widestring;
begin
  inherited;
  if dmmain.CDSquery.IsEmpty then exit;
  sql:='select * from [DP_OverflowDetail] where OD_oCode='+''''+trim(dmmain.CDSquery.fieldbyname('O_Code').AsString)+'''';
  dmmain.CDSquery2.Close;
  dmmain.CDSquery2.Data:=null;
  try
    dmmain.CDSquery2.Data:=adisp.resultrecord(sql);
    dmmain.CDSquery2.Open;
    dbgrid1.Visible:=true;
  except
    application.MessageBox('��������ֹ����',pchar(application.Title),mb_iconwarning);
    exit;
  end;
end;

procedure Tfm_OverFlow_Query.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  IF DBGRID1.Visible THEN
  BEGIN
    if key=vk_Escape then
    begin
      dbgrid1.Visible:=false;
      dbgrid2.Visible:=false;
      db.Visible:=true;
    end;
  END ELSE
  BEGIN
    IF (KEY=VK_F1) and (db.Visible) THEN
    begin
      DBDblClick(DB);
      db.Visible:=false;
      dbgrid2.Visible:=false;
    end;
    IF (KEY=VK_F2) and (db.Visible) THEN
    begin
      spbdetailclick(nil);
      db.Visible:=false;
      dbgrid1.Visible:=false;
      dbgrid2.Visible:=true;
    end;
     if (key=vk_Escape) and (dbgrid2.Visible) then
    begin
      dbgrid1.Visible:=false;
      dbgrid2.Visible:=false;
      db.Visible:=true;
    end;
  END;
end;

procedure Tfm_OverFlow_Query.BtnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure Tfm_OverFlow_Query.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMMAIN.CDSquery.Close;
  dmmain.CDSquery.Data:=null;
  DMMAIN.CDSquery2.Close;
  dmmain.CDSquery2.Data:=null;
  dmmain.CDSexecsql.Close;
  dmmain.CDSexecsql.Data:=null;
  inherited;

end;

procedure Tfm_OverFlow_Query.BtnSelPayComponeyClick(Sender: TObject);
begin
  inherited;
  dlgSQpspart:=tdlgSQpspart.Create(self);
  dlgSQpspart.Caption:='ѡ����';
  dlgSQpspart.ShowModal;
  dlgSQpspart.Free;
  if dmmain.CDSdata.IsEmpty  then exit;
  edtpart.Text:=trim(dmmain.CDSdata.fieldbyname('part_name').AsString);
  bm:=trim(dmmain.CDSdata.fieldbyname('part_no').AsString);
end;

procedure Tfm_OverFlow_Query.DBGrid2TitleClick(Column: TColumn);
begin
  inherited;
  if (not dbgrid2.DataSource.DataSet.Active ) then exit;
  if trim(column.Field.AsString)='' then exit;
  sortgrid(column.Field.FieldName,dmmain.CDSexecsql,dbgrid2,column);
end;

procedure Tfm_OverFlow_Query.DBGrid1TitleClick(Column: TColumn);
begin
  inherited;
   if (not dbgrid1.DataSource.DataSet.Active ) then exit;
  if trim(column.Field.AsString)='' then exit;
  sortgrid(column.Field.FieldName,dmmain.CDSquery2,dbgrid1,column);
end;

procedure Tfm_OverFlow_Query.DBTitleClick(Column: TColumn);
begin
  inherited;
  if (not db.DataSource.DataSet.Active ) then exit;
  if trim(column.Field.AsString)='' then exit;
  sortgrid(column.Field.FieldName,dmmain.CDSquery,db,column);
end;

procedure Tfm_OverFlow_Query.SPBDetailClick(Sender: TObject);
var
  sqlpub:widestring;
  T_date:Tdatetime;  //����¼��������
  i:integer;
begin
  inherited;
  dmmain.CDSexecsql.Close;
  dmmain.CDSexecsql.Data:=null;
  sqlpub:='select a.od_ccode  as cd_ccode,a.od_cname as cd_cname,sum(a.od_ccount) as cd_ccount,c.type,c.breed from [DP_Overflowdetail] as a,[DP_Overflow] as b,goods_code as c  where b.o_code=a.od_ocode and a.od_ccode=c.goods_no ';
  if trim(djbh.Text)<>'' then sqlpub:=sqlpub+' and b.O_Code='+''''+trim(djbh.Text)+'''';
  //if trim(edtshr.Text)<>'' then sqlpub:=sqlpub+' O_Auditer='+''''+trim(edtshr.Text)+''''+' and';
  if trim(jsr.Text)<>'' then sqlpub:=sqlpub+' and b.O_Operater='+''''+trim(jsr.Text)+'''';
  if trim(zdr.Text)<>'' then sqlpub:=sqlpub+' and b.O_NewMan='+''''+trim(zdr.Text)+''''+' and';
  if trim(edtpart.Text)<>'' then sqlpub:=sqlpub+' and b.o_shop='+''''+trim(bm)+''''+' and';
  if (rq1.Text<>'    -  -  ') and (rq2.Text<>'    -  -  ') then
  begin
    try
      t_date:=strtodate(rq1.Text);
      t_date:=strtodate(rq2.Text);
      sqlpub:=sqlpub+' and b.O_NewDate between '+''''+rq1.Text+''''+' and '+''''+rq2.Text+'''';
    except
      showmessage('�������¼�������������������룡');
      exit;
    end;
  end else
  begin
    rq1.Text:='';
    rq2.Text:='';
  end;
  sqlpub:= sqlpub+'group by a.od_ccode ,a.od_cname ,c.type,c.breed';
  dmmain.CDSexecsql.Close;
  dmmain.CDSexecsql.Data:=adisp.execSql(sqlpub);
  dmmain.CDSexecsql.Open;
  DB.Visible:=false;
  dbgrid1.Visible:=false;
  dbgrid2.Visible:=true;
end;

end.
