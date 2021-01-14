unit C_Tj;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ComCtrls, ExtCtrls, DB, DBTables,
  Grids, DBGrids;

type
  TTjForm = class(TForm)
    Panel1: TPanel;
    lblTitle: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtRoom: TLabeledEdit;
    dtpBd: TDateTimePicker;
    edtBt: TMaskEdit;
    dtpEd: TDateTimePicker;
    edtEt: TMaskEdit;
    btnQuery: TBitBtn;
    qryWork: TQuery;
    Panel2: TPanel;
    btnCanc: TBitBtn;
    btnPrint: TBitBtn;
    Panel3: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    lblFjh: TLabel;
    lblTjsj: TLabel;
    lblThcs: TLabel;
    lblHf: TLabel;
    lblFjf: TLabel;
    lblFwf: TLabel;
    lblZfy: TLabel;
    lblSh: TLabel;
    lblNh: TLabel;
    lblGn: TLabel;
    lblGj: TLabel;
    lblHj: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    procedure btnQueryClick(Sender: TObject);
  private
    { Private declarations }
    FLx: Integer;
    FFjh: string;
    FThcs: Integer;
    FTjsj: string;
    FHf: Currency;
    FFjf: Currency;
    FFwf: Currency;
    FZfy: Currency;
    FSh: Currency;
    FNh: Currency;
    FGn: Currency;
    FGj: Currency;
    FHj: Currency;
    procedure ShowHj;
    function SumHf(const s: string): Currency;
  public
    { Public declarations }
  end;

var
  TjForm: TTjForm;

procedure Tj(ALx: Integer);

implementation

{$R *.dfm}

procedure Tj(ALx: Integer);
begin
  TjForm := TTjForm.Create(Application);
  try
    with TjForm do
    begin
      FLx := ALx;
      if Flx=1 then lblTitle.Caption := '��ѯ�ֻ��¼�¼'
      else lblTitle.Caption := '��ѯ�ֻ��ɼ�¼';
      dtpBd.Date := Date;
      dtpEd.Date := Date;
      edtBt.Text := FormatDateTime('hh:nn:ss',EnCodeTime(8,0,0,0));
      edtEt.Text := edtBt.Text;
      ShowHj;
      ShowModal;
    end;
  finally
    TjForm.Free;
  end;
end;

procedure TTjForm.ShowHj;
begin
  lblFjh.Caption := FFjh;
  lblThcs.Caption := IntToStr(FThcs);
  lblTjsj.Caption := FTjsj;
  lblHf.Caption := CurrToStr(FHf)+'Ԫ';
  lblFjf.Caption := CurrToStr(FFjf)+'Ԫ';
  lblFwf.Caption := CurrToStr(FFwf)+'Ԫ';
  lblZfy.Caption := CurrToStr(FZfy)+'Ԫ';
  lblSh.Caption := CurrToStr(FSh)+'Ԫ';
  lblNh.Caption := CurrToStr(FNh)+'Ԫ';
  lblGn.Caption := CurrToStr(FGn)+'Ԫ';
  lblGj.Caption := CurrToStr(FGj)+'Ԫ';
  lblHj.Caption := CurrToStr(FHj)+'Ԫ';
end;

function TTjForm.SumHf(const s: string): Currency;
begin
  with qryWork do
  begin
    if Active then Active := False;
    SQL.Clear;
    SQL.Add(s);
    Open;
    if Fields[0].IsNull then Result :=0
    else Result := Fields[0].AsCurrency;
  end;
end;

procedure TTjForm.btnQueryClick(Sender: TObject);
var
  BDt,EDt,Room,s,DbfName: string;
begin
  if (edtRoom.Text='')or(edtBt.Text='')or(edtEt.Text='') then
    Exit;
  BDt := FormatDateTime('yyyymmdd',dtpBd.Date)+FormatDatetime('hhnnss',StrToTime(edtBt.Text));
  EDt := FormatDateTime('yyyymmdd',dtpEd.Date)+FormatDatetime('hhnnss',StrToTime(edtEt.Text));
  Room := edtRoom.Text;
  if FLx=1 then DbfName := 'NewData'
  else DbfName := 'OldData';
  FFjh := Room;
  FTjsj:= BDt+'-'+EDt;
  //ͳ�ƴ���
  s := 'select count(*) from '+DbfName+' where (Class="'+Room+'")and((SDate+STime)>"'+BDt+'")and((SDate+STime)<"'+EDt+'")';
  with qryWork do
  begin
    if Active then Active := False;
    SQL.Clear;
    SQL.Add(s);
    Open;
    if Fields[0].IsNull then FThcs :=0
    else FThcs := Fields[0].AsInteger;
  end;
  //ͳ�ƻ���
  s := 'select sum(FEE) from '+DbfName+' where (Class="'+Room+'")and((SDate+STime)>"'+BDt+'")and((SDate+STime)<"'+EDt+'")';
  FHf := SumHf(s);
  //ͳ�Ƹ��ӷ�
  s := 'select sum(ADDIFEE) from '+DbfName+' where (Class="'+Room+'")and((SDate+STime)>"'+BDt+'")and((SDate+STime)<"'+EDt+'")';
  FFjf := SumHf(s);
  //ͳ�Ʒ����
  s := 'select sum(SVCFEE) from '+DbfName+' where (Class="'+Room+'")and((SDate+STime)>"'+BDt+'")and((SDate+STime)<"'+EDt+'")';
  FFwf := SumHf(s);
  //ͳ���ܷ���
  s := 'select sum(TOTAL) from '+DbfName+' where (Class="'+Room+'")and((SDate+STime)>"'+BDt+'")and((SDate+STime)<"'+EDt+'")';
  FZfy := SumHf(s);
  //ͳ���л�
  s := 'select sum(TOTAL) from '+DbfName+' where (FLTY=1)and(Class="'+Room+'")and((SDate+STime)>"'+BDt+'")and((SDate+STime)<"'+EDt+'")';
  FSh := SumHf(s);
  //ͳ��ũ��
  s := 'select sum(TOTAL) from '+DbfName+' where (FLTY=2)and(Class="'+Room+'")and((SDate+STime)>"'+BDt+'")and((SDate+STime)<"'+EDt+'")';
  FNh := SumHf(s);
  //ͳ�ƹ���
  s := 'select sum(TOTAL) from '+DbfName+' where (FLTY=3)and(Class="'+Room+'")and((SDate+STime)>"'+BDt+'")and((SDate+STime)<"'+EDt+'")';
  FGn := SumHf(s);
  //ͳ�ƹ���
  s := 'select sum(TOTAL) from '+DbfName+' where (FLTY=4)and(Class="'+Room+'")and((SDate+STime)>"'+BDt+'")and((SDate+STime)<"'+EDt+'")';
  FGj := SumHf(s);
  FHj := FSh + FNh + FGn + FGj;
  ShowHj;

end;

end.
