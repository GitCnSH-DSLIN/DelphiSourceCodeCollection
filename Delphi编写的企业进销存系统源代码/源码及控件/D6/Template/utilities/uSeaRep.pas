unit uSeaRep;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, QuickRpt, ExtCtrls, Db, DBTables;

type
  TF_SeaRep = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    procedure QuickRep1BeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
    FQry : TQuery;
    FPSelR: Boolean; // �Ƿ�ѡȡ�˼�¼����ӡ��Χ
    FRecord: array of integer;  // Ҫ��ӡ�ļ�¼�� (FPSelR Ϊ True ʱ����ֵ)
    FFieldCount: integer;     //Ҫ��ӡ����λ��Ŀ
    FField: array of integer; //Ҫ��ӡ����λ˳��
  public
    { Public declarations }
    qrlFieldName : array [0..12] of TQRLabel;
    qrdbtFData: array [0..12] of TQRDBText;
    Property FPQry: TQuery read FQry write FQry;
    procedure QRCreate;
  end;

var
  F_SeaRep: TF_SeaRep;
  nRec : integer;  (* ��ӡ�ļ�¼��, ���ѡȡ����ӡ�ļ�¼��Χʱ *)

procedure SearchRepExc(const RepQry: TQuery; PSelR: Boolean; PSelRang: array of integer);


implementation

{$R *.DFM}

procedure SearchRepExc(const RepQry: TQuery; PSelR: Boolean; PSelRang: array of integer);
var
  i : integer;
begin
  if RepQry = nil then begin
     Application.MessageBox(PChar('û������Ҫ��ӡ�����ϱ�!'),PChar('����'),MB_ICONERROR+MB_OK);
     Exit;
  end;

  F_SeaRep := TF_SeaRep.Create(Application);
  With F_SeaRep do begin
    FPSelR := PSelR;
    FPQry := RepQry;
    QuickRep1.DataSet := FPQry;
    if FPSelR then begin       (* ��ѡȡ��ӡ���Ǽ�¼��Χ, ��ȡ���е���λ *)
       FFieldCount := FPQry.FieldCount;
       SetLength(FField, FFieldCount);
       for i := 0 to FFieldCount-1 do FField[i] := i;
       (* ȡ����ѡ�ļ�¼�� *)
       SetLength(FRecord,High(PSelRang)+1);
       for i := 0 to High(PSelRang) do FRecord[i] := PSelRang[i];
    end
    else begin                 (* ��ѡȡ��ӡ������λ��Χ, ��ȡ��ѡ����λ *)
       FFieldCount := High(PSelRang) + 1;
       SetLength(FField, FFieldCount);
       for i := 0 to High(PSelRang) do FField[i] := PSelRang[i];
    end;
    QuickRep1.Preview;
    Free;
  end;
end;



procedure TF_SeaRep.QRCreate;
var
  RWidth,
  nIdx: integer;
begin
  RWidth := Trunc(QRBand1.Width / (FFieldCount));
  for nIdx := 0 to FFieldCount-1 do begin
    qrlFieldName[nIdx] := TQRLabel.Create(F_SeaRep);
    qrdbtFData[nIdx] := TQRDBText.Create(F_SeaRep);
    with qrlFieldName[nIdx] do begin
      Parent := QRBand2;
      AutoSize := True;
      Top := 15;
      if nIdx = 0 then      begin
        Left := 0;
        Width := RWidth+6; end
      else begin
        Left := RWidth * nIdx + 6;
        Width := RWidth - 6;
      end;
      Font.Style := [fsBold];

      Caption := FPQry.Fields[FField[nIdx]].FieldName;


    end;  // end of with
    qrdbtFData[nIdx].Parent := QRBand3;
    qrdbtFData[nIdx].AutoSize := True;
    qrdbtFData[nIdx].Top := 8;
    qrdbtFData[nIdx].Left := qrlFieldName[nIdx].Left;
    qrdbtFData[nIdx].DataSet := FPQry;

    qrdbtFData[nIdx].DataField := qrlFieldName[nIdx].Caption;
    
  end;   // end of for
end;



procedure TF_SeaRep.QuickRep1BeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  QRCreate;
  nRec := 0;    // ��ʼ����ӡ�ļ�¼��
end;

procedure TF_SeaRep.FormDestroy(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to FFieldCount-1 do begin
    qrlFieldName[i].Free;
    qrdbtFData[i].Free;
  end;
end;

procedure TF_SeaRep.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin                             
  if not FPSelR then exit;    // ��ѡȡ��ӡ������λ��Χ, ���˳�
  PrintBand := ((FPQry.RecNo-1) = FRecord[nRec]);  // �����ж��Ƿ�ѡȡ�˸ü�¼
  if PrintBand then Inc(nRec); 
end;

end.
