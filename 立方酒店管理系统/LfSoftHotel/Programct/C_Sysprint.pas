unit C_Sysprint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, ExtCtrls, QRCtrls, C_CtDefine, Printers;

type
  TSysPrintForm = class(TForm)
    QuickRep1: TQuickRep;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    qrlTitle: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    qrlZbr: TQRLabel;
    qrlSub: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SysPrintForm: TSysPrintForm;

procedure SysPrint(APrintStru: TPrintStru);

implementation

{$R *.dfm}

procedure SysPrint(APrintStru: TPrintStru);
var
  I       : Integer;
  AColName: TQRLabel;
  AField  : TQRDBText;
begin
  SysPrintForm := TSysPrintForm.Create(Application);
  try
  with SysPrintForm do
  begin
    qrlTitle.Caption  := APrintStru.ATitle;
    qrlSub.Caption    := APrintStru.ASub;
    QuickRep1.DataSet := APrintStru.ADataSet;
    for I:=0 to APrintStru.AColumns.Count-1 do
    begin
      AColName := TQRLabel.Create(ColumnHeaderBand1);
      AColName.Parent  := ColumnHeaderBand1;
      AColName.Left    := StrToInt(APrintStru.APosition.Strings[I]);
      AColName.Caption := APrintStru.AColumns.Strings[I];
      AColName.Color   := clWhite;
      AColName.Top     := 4;
      AField := TQRDBText.Create(DetailBand1);
      AField.Parent    := DetailBand1;
      AField.Left      := AColName.Left;
      AField.DataSet   := QuickRep1.DataSet;
      AField.DataField := APrintStru.AFields.Strings[I];
      AField.Top       := 4;
    end;
    qrlZbr.Caption := '�Ʊ��ˣ�'+CZY.CzyXm;
    if APrintStru.AFs = PRN_Portrait then QuickRep1.Page.Orientation := poPortrait
    else QuickRep1.Page.Orientation := poLandScape;
    QuickRep1.Preview;
  end;
  finally
    SysPrintForm.Free;
  end;

end;

end.
