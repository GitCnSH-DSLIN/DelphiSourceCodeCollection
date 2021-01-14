unit fm_BaseQueryStr;
//YDY CREATE 2004-2-19
///ydy modify 2004-4-12 ���ڲ����µĲ�ѯ����dmmain.dsquery
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fm_Base,  StdCtrls, Buttons,
  ExtCtrls,  Grids, DBGrids, DBCtrls,DB, DBClient;

type
  TfmBaseQueryStr = class(TfmBase)
    Panel2: TPanel;
    btnExit: TBitBtn;
    btnQuery: TBitBtn;
    btnColumn: TBitBtn;
    btnPrivew: TBitBtn;
    btnChart: TBitBtn;
    DBGrid1: TDBGrid;
    btnpagedown: TBitBtn;
    Panel1: TPanel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    edtRecNo: TEdit;
    edtTime: TEdit;
    LblSort: TLabel;
    BtnSort: TBitBtn;
    Bevel1: TBevel;
    procedure btnQueryClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnColumnClick(Sender: TObject);
    procedure btnChartClick(Sender: TObject);
    procedure btnPrivewClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnSortClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
     function GetKeyFieldValue(sortField:string) : OleVariant;
  end;

var
  fmBaseQueryStr: TfmBaseQueryStr;
  LocalCount:integer;   //ֱ�Ӹ��ݱ��ص�ֵ�ϴ���ѯ
  Sqlstr:wideString;

implementation
uses
  fm_SetColumn ,untdatadm, func;
{$R *.dfm}

procedure TfmBaseQueryStr.btnQueryClick(Sender: TObject);
begin
  inherited;
  //�ȹر����ݼ�   YDY 2004-2-18��Ҫ��δ�˽��������������
  //���������  2004-2-19 һ��OK
  dmMain.dsquery.IndexName :='';
  dmMain.dsquery.IndexDefs.Update;
  dmMain.dsquery.Data := null;    //�ͻ����ڴ����
  dmmain.dsquery.Close;
//  dmMain.dsquery.Data := null;    //�ͻ����ڴ����
//  if dmmain.dsquery.Active then dmmain.dsquery.Close;

//ȫ������dmMain.dsquery����������

end;

procedure TfmBaseQueryStr.btnExitClick(Sender: TObject);
begin
  inherited;
  //ydy �˴����迼��

//ydy ע��  �Ⱥ���ٶȵ�Ӱ���൱��
   dmmain.dsquery.Data := null; //�ͻ����ڴ����
   dmMain.dsquery.Close;   //ydy add
   //���������  2004-2-19 һ��OK
   dmMain.dsquery.IndexName :='';
   dmMain.dsquery.IndexDefs.Update;

  close;

end;

//������
procedure TfmBaseQueryStr.btnColumnClick(Sender: TObject);
begin
  inherited;
  if not DBGrid1.DataSource.DataSet.Active then  exit;
  with TfmSetColumn.Create(Self) do
  try
    showmodal;
  finally
    free;
  end;
end;

//��ͼ��ͳ��
procedure TfmBaseQueryStr.btnChartClick(Sender: TObject);
begin
  inherited;
{
  with TfmSingleGuestChart.Create(Self) do
  try
    showmodal;
  finally
    free;
  end;
}
end;



//�����ӡԤ��
procedure TfmBaseQueryStr.btnPrivewClick(Sender: TObject);
begin
  inherited;
  {if not DBGrid1.DataSource.DataSet.Active then  exit;
  fastrepxf:=tfastrepxf.Create(nil);
  try
  fastrepxf.filenames:='singleguest.ini';
  fastrepxf.frReportxf.Dataset:=dmmain.frDBSingleGuest;
  fastrepxf.ShowModal;
  finally
  fastrepxf.Free;
  end;}
end;

//////////////////////////////////////
//ȡ��Ŀǰ��TCLIENTDATASET�����һ�����ݵļ�ֵ
function TfmBaseQueryStr.GetKeyFieldValue(sortField:string): OleVariant;
var
aCDS : TClientDataSet;
begin
aCDS:=TClientDataSet.Create(Self);
try
try
if not varisnull(dmmain.dsquery.Data) then
begin
///������°�����������󣬴˴����ܲ����� ����ydy
aCDS.Data:=dmmain.dsquery.Data;  //ClientDataSet1.Data;
//ydy 2004-2-18 add
    WITH acds do begin
        IndexName := '';
        IndexDefs.Update;
    end;
    with aCDs.IndexDefs.AddIndexDef do
        begin
          Fields := sortField;  //��ͬ��˴���ͬ'sg_id'; //AFields;
          Options := [];
        end;
aCDs.IndexDefs.Update;
///////////

aCDS.Last;
//Result:=aCDS.FieldByName('SG_id').Value;
Result:=aCDS.FieldByName(sortfield).Value;
end;
finally // wrap up
aCDS.Free ;
end; // try/finally
except
on e: Exception do
raise;
end; // try/except
end;

procedure TfmBaseQueryStr.FormActivate(Sender: TObject);
begin
  inherited;
  //ydy add   2004-2-18
  dbgCur:=dbgrid1;
    //�ȹر����ݼ�   YDY 2004-2-18��Ҫ��δ�˽��������������
//   dmmain.dsquery.Close;
   //���������  2004-2-19 һ��OK
//�˴���Ҫ����
   dmMain.dsquery.IndexName :='';
   dmMain.dsquery.IndexDefs.Update;

   dmMain.dsquery.Data := null;    //�ͻ����ڴ����


end;


//��������
procedure TfmBaseQueryStr.BtnSortClick(Sender: TObject);
begin
  inherited;
// if not (Screen.ActiveControl is TDBGrid) then exit;    //??

   {if not DBGrid1.DataSource.DataSet.Active then  exit;
   frmSetSort:= tfrmSetSort.Create(nil);
   try
   //����ִ��FORM�ı���
   frmsetSort.RunFormCaption := self.caption;
   frmSetSort.dbgSS := DBGRID1; //TDBGrid(Screen.ActiveControl);
   frmSetSort.ShowModal;
   finally
   frmsetsort.Free;
   end;
   Lblsort.Caption :=ReturnSortString; }

end;



procedure TfmBaseQueryStr.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
   if (dbgrid1.DataSource = nil) or
     (DBGrid1.DataSource.Dataset = nil) then exit;
  // ��ͬ�е���ɫ
  if (DBGrid1.DataSource.DataSet.RecNo mod 2) = 0 then
    DBGrid1.Canvas.Brush.Color := clSilver
  else
    DBGrid1.Canvas.Brush.Color := $00EAEAEA;//clgray;
    dbgrid1.DefaultDrawColumnCell(rect,datacol,column,state);
  //ѡ���е���ɫ
  with TDBGrid(Sender) do begin
    if gdSelected in State then Canvas.Brush.Color := clTeal;  //clBlue;
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
   end;
end;


end.
