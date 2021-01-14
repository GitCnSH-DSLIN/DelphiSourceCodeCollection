unit C_Xmdy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C_Xtdy, DB, DBTables, DosMove, Grids, DBGrids, StdCtrls,
  Buttons, ExtCtrls;

type
  TXmdyForm = class(TXtdyForm)
    tblXtdyD_XMBH: TStringField;
    tblXtdyD_XMMC: TStringField;
    tblXtdyD_XFBZ: TStringField;
    tblXtdyD_DM: TStringField;
    procedure tblXtdyBeforeDelete(DataSet: TDataSet);
    procedure tblXtdyBeforeEdit(DataSet: TDataSet);
    procedure btnPrintClick(Sender: TObject);
    procedure tblXtdyBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  infoCannotDelete = '������ϵͳ�趨��������Ŀ���㲻��ɾ����';
  infoCannotEdit   = '������ϵͳ�趨��������Ŀ���㲻�ܱ༭��';

var
  XmdyForm: TXmdyForm;

procedure Xmdy;

implementation

uses C_Sysprint, C_Define;

{$R *.dfm}

procedure Xmdy;
begin
  XmdyForm := TXmdyForm.Create(Application);
  try
    with XmdyForm do
    begin
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
    XmdyForm.Free;
  end;
end;

procedure TXmdyForm.tblXtdyBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if tblXtdyD_XFBZ.Value = 'S' then
    raise Exception.Create(infoCannotDelete);
end;

procedure TXmdyForm.tblXtdyBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if tblXtdyD_XFBZ.Value = 'S' then
    raise Exception.Create(infoCannotEdit);
end;

procedure TXmdyForm.btnPrintClick(Sender: TObject);
var
  APrintStru: TPrintStru;
begin
  APrintStru.ATitle := '������Ŀ';
  APrintStru.ADataSet := tblXtdy;
  PrintLb(APrintStru,dbgXtdy);
end;

procedure TXmdyForm.tblXtdyBeforePost(DataSet: TDataSet);
begin
  if tblXtdyD_DM.Value = '' then
    tblXtdyD_DM.Value := GetIndexStr(tblXtdyD_XMMC.Value);
end;

end.
