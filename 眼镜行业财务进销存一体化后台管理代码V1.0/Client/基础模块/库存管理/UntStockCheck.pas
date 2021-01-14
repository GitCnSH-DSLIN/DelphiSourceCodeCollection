unit UntStockCheck;
///2004-2-19 ���ݻ�������fm_basequery ��д�� ydy
//2004-3-23ydy �����µ���Ʒ������д
////2004-4-12 ydy create ����ѡ����Ʒ������������Ϣ ר�����ڶ�stringgrid�ĸ�ֵ

/////////���� UntgoodCodeSelStr�޸Ķ���
//////2004-4-14 ר���޸�������Ʒ����ѯ����������ʾ  ydy created



interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons,DB, fm_BaseQueryStr,
  FR_PTabl;


type
  TFmStockCheck = class(TfmBaseQueryStr)
    Panel3: TPanel;
    Label2: TLabel;
    CBType: TComboBox;
    Label4: TLabel;
    cbBrand: TComboBox;
    Label3: TLabel;
    CbBreed: TComboBox;
    DataSource1: TDataSource;
    frPrintGrid1: TfrPrintGrid;
    CopyCode: TBitBtn;
    Edit1: TEdit;
    procedure btnpagedownClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBTypeChange(Sender: TObject);
    procedure cbBrandChange(Sender: TObject);
    procedure CbBreedChange(Sender: TObject);
    procedure btnChartClick(Sender: TObject);
    procedure CopyCodeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    show_mode:string;
  end;

var
  FmStockCheck: TFmStockCheck;

implementation

uses func, untdatadm;

var
  LocalCount:integer;   //ֱ�Ӹ��ݱ��ص�ֵ�ϴ���ѯ
  Sqlstr:wideString;


{$R *.dfm}

procedure TFmStockCheck.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
//�������
CopyCodeClick(sender);
end;

procedure TFmStockCheck.FormActivate(Sender: TObject);
begin
  inherited;
end;

///
procedure TFmStockCheck.btnpagedownClick(Sender: TObject);
var
  i:Integer;
  t_sql,str1,strend:wideString;
  quedata:olevariant;
  //2004-2-10Ϊ���Ż���������   �ٶ�����ߵ�52��
  lStart, lEnd : Integer;
begin
  inherited;
//   lStart := GetTickCount;
     if not dmmain.DSquery.Active then exit;

    screen.Cursor := crhourglass;
   //�ص���DBGRID �Ļ���
   dmmain.dsquery.DisableControls;

    if combobox1.Text = 'ȫ��' then
    begin
    t_sql:='select  *  from  [VStockCheck] where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';
    T_sql := t_sql + ' and breed = ' + ''''+trim(cbbreed.text)+'''';
    end
    else
    begin
    t_sql:='select top ' + trim(ComboBox1.Text) +' *  from  [VStockCheck] where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';
    end;

    T_sql := t_sql + ' and breed = ' + ''''+trim(cbbreed.text)+'''';
    str1 := ' and  id > '+ inttostr(localcount);

    strend := T_sql + str1;

///getmore �����ж�LOCALCOUNT�Ƿ����RECORDCOUNT�����������ִ�С� ���������Ժ��������Ϊ0

  try
    //ydy add

//    if dmmain.dsquery.Active then dmmain.dsquery.Close;
      //ydy modify
    ipubtemp.ty_query(strend,quedata);
    //dmmain.SocketConn.AppServer.qurrecords(str,quedata);
    if not varisnull(quedata) then
    begin
     if dmmain.dsquery.Active then dmmain.dsquery.Close;
      dmmain.dsquery.Open;
      dmmain.dsquery.AppendData(quedata,true);

      ///ydy add
       dmmain.dsquery.Last;
    //  dmmain.dsquery.MergeChangeLog;
    //���´�
      dmmain.dsquery.EnableControls;
      //�õ��˴β�ѯ�ļ�ֵ
      LocalCount := GetKeyFieldValue('id');   //��������ֶ�
//   lEnd := GetTickCount;
//   edtRecNo.Text := '��ǰ��¼��Ϊ'+IntToStr(localCount)+'����'+inttostr(dmmain.dsquery.recordcount) +'��';
    edtRecNo.Text := '��ǰ����'+inttostr(dmmain.dsquery.recordcount) +'��';
//   edtTime.Text := FloatToStr((lEnd - lStart) / 1000.0) + '��';

    end else
    begin
       //����������
        dmmain.dsquery.EnableControls;        //ydy  ����Ҫ
       btnpagedown.Enabled := false;
       screen.Cursor :=  crdefault;
      exit;
    end;
  except
  end;

  screen.Cursor :=  crdefault;

end;


procedure TFmStockCheck.FormShow(Sender: TObject);
var
  t_sql:string;
begin
  inherited;
 ///////�����
  t_sql:='select * from  [goods_type]';
//  t_sql:='select distinct type  from  [goods_code]';
  GetDataToComBoX(cbtype,t_sql,'type');
  cbtype.ItemIndex := -1;
end;

procedure TFmStockCheck.CBTypeChange(Sender: TObject);
var
  t_sql:string;
begin
  inherited;
  if dmmain.DSquery.Active then dmmain.DSquery.Close;
  //��Ʒ��
  t_sql:='select  distinct brand from  [goods_code] where type ='+''''+trim(cbtype.text)+'''';
  GetDataToComBoX(cbBrand,t_sql,'brand');
  cbBrand.ItemIndex := -1;
  cbbreed.Clear;

end;

procedure TFmStockCheck.cbBrandChange(Sender: TObject);
var
  t_sql:string;
begin
  inherited;
  //��Ʒ��
  if dmmain.DSquery.Active then dmmain.DSquery.Close;
  if cbtype.Text = '' then exit;
  t_sql:='select distinct breed  from  [goods_code] where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';
  GetDataToComBoX(cbBreed,t_sql,'breed');
  cbBreed.ItemIndex := -1;
end;

procedure TFmStockCheck.CbBreedChange(Sender: TObject);
var
  t_sql:string;
  quedata:olevariant;
begin
  inherited;
////////////��ѯ����

    if cbbrand.Text = '' then exit;

    screen.Cursor := crhourglass;
   //�ص���DBGRID �Ļ���
   dmmain.dsquery.DisableControls;
   t_sql:='select top 20 *  from  [VStockCheck] where type ='+''''+trim(cbtype.text)+'''' +' and brand =' +''''+trim(cbbrand.text)+'''';
   T_sql := t_sql + ' and breed = ' + ''''+trim(cbbreed.text)+'''';

  try

//    dmmain.pd_socket.AppServer.ty_query(t_sql,quedata);
   ipubtemp.ty_query(t_sql,quedata);  //.qurrecords(t_sql,quedata);
   if not varisnull(quedata) then
    begin
     if dmmain.DSquery.Active then dmmain.dsquery.Close;
      dmmain.dsquery.Open;
      dmmain.dsquery.Data:=quedata;
      ///ydy add
       dmmain.dsquery.Last;
       edtRecNo.Text := '��ǰ������: '+inttostr(dmmain.dsquery.recordcount)+'��';

    //���´�
      dmmain.dsquery.EnableControls;
      dbgrid1.Refresh;
      //�õ��˴β�ѯ�ļ�ֵ
     LocalCount := GetKeyFieldValue('id');   //��������ֶ�

    end else
    begin
       //����������
        dmmain.dsquery.EnableControls;        //ydy  ����Ҫ
       btnpagedown.Enabled := false;
       screen.Cursor :=  crdefault;
      exit;
    end;
  except
  end;
  dbgrid1.Refresh;   //ydy add 2004-4-13
  screen.Cursor :=  crdefault;
end;

procedure TFmStockCheck.btnChartClick(Sender: TObject);
begin
  inherited;
{if  varisnull(dmmain.dsquery.Data) then exit;
frprintgrid1.DBGrid :=dbgrid1;
//ֱ����ȱʡ�Ĵ�ӡԤ������
//frprintgrid1.ShowReport;
//���Զ���Ĵ���
FrmMyPreview := TFrmMyPreview.Create(self);
frprintgrid1.Preview := FrmMyPreview.frPreview1;

frPrintGrid1.ShowReport;
try
FrmMyPreview.ShowModal;
finally
FrmMyPreview.free;
end;

frprintgrid1.DBGrid :=nil;}

end;

procedure TFmStockCheck.CopyCodeClick(Sender: TObject);
begin
  inherited;
   if not DBGrid1.DataSource.DataSet.Active then  exit;
//   if  varisnull(dmmain.cdsnewpub.Data) then exit;
  edit1.Text := trim(dbgrid1.Fields[0].AsString);
  edit1.SelectAll;
  edit1.CopyToClipboard;
end;

end.
