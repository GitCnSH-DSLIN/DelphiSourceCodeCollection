unit C_Xtdy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C_Stand, Grids, DBGrids, DosMove, DB, DBTables, StdCtrls,
  Buttons, ExtCtrls, C_Define;

type
  TXtdyForm = class(TStandForm)
    tblXtdy: TTable;
    dsXtdy: TDataSource;
    dbgXtdy: TDBGrid;
    cmbOption: TComboBox;
    cmbExpress: TComboBox;
    edtValue: TEdit;
    btnLoca: TBitBtn;
    btnPrint: TBitBtn;
    lblState: TStaticText;
    procedure dsXtdyStateChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tblXtdyBeforeDelete(DataSet: TDataSet);
    procedure btnLocaClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure tblXtdyPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure tblXtdyBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    FTag: Integer;
  public
    { Public declarations }
  end;
const
  infoConfirmDelete = '������Ѿ�ʹ���˸ü�¼��ɾ������Ӱ������ͳ�Ƶ�׼ȷ�ԣ���ȷ��һ��Ҫɾ����';
  tagLC = 0;//¥�㶨��
  tagFX = 1;//���Ͷ���
  tagDQ = 2;//��������
  tagGB = 3;//������
  tagMZ = 4;//���嶨��
  tagZJ = 5;//֤������
  tagQZ = 6;//ǩ֤����
  tagFL = 7;//�ͻ�����
  tagCT = 8;//��������
  tagHC = 9;//�᳡����
  tagXYK=10;//���ÿ�
  tagBM =11;//��������

  TableName_XTDY : array[0..11] of string
                   = ('LCDM',
                      'FXDM',
                      'DQDM',
                      'GBDM',
                      'MZDM',
                      'ZJDM',
                      'QZDM',
                      'FLDM',
                      'CTDM',
                      'HCDM',
                      'XYK',
                      'BMDM');
  TitleName_XTDY : array[0..11] of string
                   = ('¥�㶨��',
                      '���Ͷ���',
                      '��������',
                      '������',
                      '���嶨��',
                      '֤������',
                      'ǩ֤����',
                      '�ͻ�����',
                      '��������',
                      '�᳡����',
                      '���ÿ�',
                      '��������');
  FieldName_XTDY : array[0..11,0..2] of string
                   = (('D_LCBH','D_LCMC','D_DM'),
                      ('D_FXBH','D_FXMC','D_DM'),
                      ('D_DQBH','D_DQMC','D_DM'),
                      ('D_GBBH','D_GBMC','D_DM'),
                      ('D_MZBH','D_MZMC','D_DM'),
                      ('D_ZJBH','D_ZJMC','D_DM'),
                      ('D_QZBH','D_QZMC','D_DM'),
                      ('D_FLBH','D_FLMC','D_DM'),
                      ('D_CTBH','D_CTMC','D_DM'),
                      ('D_HCBH','D_HCMC','D_DM'),
                      ('D_XYKBH','D_XYKMC','D_DM'),
                      ('D_BMBH','D_BMMC','D_DM'));

var
  XtdyForm: TXtdyForm;

procedure Xtdy(ATag: Integer);

implementation

uses C_Sysprint;

{$R *.dfm}

//ϵͳ����
procedure Xtdy(ATag: Integer);
var
  AColumn: TColumn;
  I      : Integer;
begin
  XtdyForm := TXtdyForm.Create(Application);
  try
    with XtdyForm do
    begin
      FTag := ATag;
      tblXtdy.TableName := TableName_XTDY[ATag];
      lblTitle.Caption  := TitleName_XTDY[ATag];
      for I:= 0 to 2 do
      begin
        AColumn := dbgXtdy.Columns.Add;
        AColumn.FieldName := FieldName_XTDY[ATag,I];
        AColumn.Title.Alignment := taCenter;
        AColumn.Alignment       := taRightJustify;
        AColumn.Width := (dbgXtdy.Width div 3) - 15;
        case I of
        0: AColumn.Title.Caption := '��      ��';
        1: AColumn.Title.Caption := '��      ��';
        2: AColumn.Title.Caption := '��      ��';
        end;
      end;
      try
        tblXtdy.Open;
      except
        On E:Exception do
        begin
          ShowWarning('�����ݿ�����������������Ƿ�������'
                      +#13#10
                      +'������Ϣ:'
                      +E.Message);
          raise;
        end;
      end;

      ShowModal;
    end;
  finally
    XtdyForm.Free;
  end;
end;

procedure TXtdyForm.dsXtdyStateChange(Sender: TObject);
begin
  inherited;
  btnClose.Enabled            := tblXtdy.State = dsBrowse;
  btnPrint.Enabled            := btnClose.Enabled;
  dbgXtdy.Columns[0].ReadOnly := not (tblXtdy.State = dsInsert);
  case tblXtdy.State of
    dsInsert:
    begin
      lblState.Caption := '����';
      lblState.Font.Color := clRed;
    end;
    dsEdit  :
    begin
      lblState.Caption := '�޸�';
      lblState.Font.Color := clBlue;
    end;
    dsBrowse:
    begin
      lblState.Caption := '���';
      lblState.Font.Color := clGreen;
    end;
    else      lblState.Caption := '';
  end;
end;

procedure TXtdyForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := tblXtdy.State = dsBrowse;
end;

procedure TXtdyForm.tblXtdyBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if not Confirm(infoConfirmDelete) then
    Abort;
end;

procedure TXtdyForm.btnLocaClick(Sender: TObject);
var
  LocaFieldName: string;
begin
  inherited;
  if cmbExpress.ItemIndex = 0 then
  begin
    if cmbOption.Text = '���' then
      LocaFieldName := tblXtdy.Fields[0].FieldName;
    if cmbOption.Text = '����' then
      LocaFieldName := tblXtdy.Fields[1].FieldName;
    tblXtdy.Locate(LocaFieldName,edtValue.Text,[])
  end;
end;

procedure TXtdyForm.btnPrintClick(Sender: TObject);
var
  APrintStru: TPrintStru;
begin
  APrintStru.ATitle := TitleName_XTDY[FTag];
  APrintStru.ADataSet := tblXtdy;
  PrintLb(APrintStru,dbgXtdy);
end;

procedure TXtdyForm.tblXtdyPostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
var
  iDBIError: Integer;
begin
  inherited;
  if (E is EDBEngineError) then
  begin
    iDBIError := (E as EDBEngineError).Errors[0].ErrorCode;
    case iDBIError of
      eKeyViol: raise Exception.Create('��ű���Ψһ��');
      eRequiredFieldMissing: raise Exception.Create('���ݲ�ȫ��');
    end;
  end;
end;

procedure TXtdyForm.tblXtdyBeforePost(DataSet: TDataSet);
begin
  inherited;
  if DataSet.Fields[2].AsString = '' then
    DataSet.Fields[2].AsString := GetIndexStr(DataSet.Fields[1].AsString);
end;

end.
