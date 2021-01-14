unit C_Zdcx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C_Stand, DosMove, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids,
  DB, DBTables, C_Define;

type
  TZdcxForm = class(TStandForm)
    lblYfje: TLabel;
    lblXfje: TLabel;
    lblYjje: TLabel;
    lblWjje: TLabel;
    lblYjye: TLabel;
    Label1: TLabel;
    btnQuery: TBitBtn;
    edtKfh: TEdit;
    lblKrxm: TLabel;
    dsKryj: TDataSource;
    qryKryj: TQuery;
    qryKrzdcx: TQuery;
    DBGrid1: TDBGrid;
    qryKrzdcxD_XMMC: TStringField;
    btnYjbj: TBitBtn;
    Bevel1: TBevel;
    qryKryjD_YJBH: TStringField;
    qryKryjD_HH: TIntegerField;
    qryKryjD_FKFS: TStringField;
    qryKryjD_XYKBH: TStringField;
    qryKryjD_KHBH: TStringField;
    qryKryjD_YFJE: TFloatField;
    qryKryjD_YFRQ: TDateTimeField;
    qryKryjD_YFSJ: TDateTimeField;
    qryKryjD_BZ: TStringField;
    dsKrzdcx: TDataSource;
    DBGrid2: TDBGrid;
    qryKrzdcxD_XMBH: TStringField;
    qryKrzdcxSUM: TFloatField;
    qryKrzdcxSUM_1: TFloatField;
    btnFjmx: TBitBtn;
    btnZdmx: TBitBtn;
    procedure btnQueryClick(Sender: TObject);
    procedure btnYjbjClick(Sender: TObject);
    procedure btnZdmxClick(Sender: TObject);
    procedure btnFjmxClick(Sender: TObject);
  private
    { Private declarations }
    FKfbh: string;
    FKfxx: TKfxx;
    FYjxx: TYjxx;
    FXfxx: TXfxx;
    FYfje: Currency;
    FXfje: Currency;
    FYjje: Currency;
    FDtfj: Currency;
    FDhf : Currency;

    procedure ShowXx;
    procedure ShowXfxx;
    procedure ShowYjxx;
  public
    { Public declarations }
  end;

var
  ZdcxForm: TZdcxForm;

procedure Zdcx;
procedure ZdcxEnter(const AKfbh: string);

implementation

uses C_HotelData, C_Bjyj, C_Zdmx, C_Fjmx;

{$R *.dfm}

procedure Zdcx;
begin
  ZdcxForm := TZdcxForm.Create(Application);
  try
    with ZdcxForm do
    begin
      ShowXx;
      ShowModal;
    end;
  finally
    ZdcxForm.Free;
  end;
end;

procedure ZdcxEnter(const AKfbh: string);
begin
  ZdcxForm := TZdcxForm.Create(Application);
  try
    with ZdcxForm do
    begin
      edtKfh.Text := AKfbh;
      ShowXx;
      btnQueryClick(nil);
      ShowModal;
    end;
  finally
    ZdcxForm.Free;
  end;
end;

procedure TZdcxForm.ShowXx;
begin
  lblYfje.Caption := 'Ѻ���'+FormatFloat('#.##',FYfje);
  lblXfje.Caption := '���ѽ�'+FormatFloat('#.##',FXfje);
  lblYjje.Caption := '�ѽ��'+FormatFloat('#.##',FYjje);
  lblWjje.Caption := 'δ���'+FormatFloat('#.##',FXfje-FYjje);
  lblYjye.Caption := 'Ѻ����'+FormatFloat('#.##',FYfje-FXfje+FYjje);
end;

procedure TZdcxForm.ShowXfxx;
var
  AHh   : Integer;
  s : string;
begin
  HotelData.EmptyData('delete from KRZDCX');
  s := 'select * from KRZD where D_ZDBH="'+FKfxx.AZdbh+'"';
  HotelData.BakData(s,'KRZDCX');
  with HotelData.tblKrzdcx do
  begin
    Open;
    Last;
    AHh := FieldByName('D_HH').AsInteger;
    Inc(AHh);
    if FDtfj <> 0 then
    begin
      Insert;
      FieldByName('D_ZDBH').AsString := FKfxx.AZdbh;
      FieldByName('D_HH').AsInteger := AHh;
      FieldByName('D_XMBH').AsString := XMBH_FJ;
      FieldByName('D_KFBH').AsString := edtKfh.Text;
      FieldByName('D_XFJE').AsCurrency := FDtfj;
      FieldByName('D_XFRQ').AsDateTime := Date;
      FieldByName('D_XFSJ').AsDateTime := Time;
      FieldByName('D_CZYXM').AsString := CZY.CzyXm;
      FieldByName('D_JZBZ').AsString  := JZ_NO;
      FieldByName('D_JSBZ').AsString  := JZ_NO;
      FieldByName('D_BZ').AsString := 'ɢ��'+edtKfh.Text;
      Post;
    end;
    Inc(AHh);
    if FDhf <> 0 then
    begin
      Insert;
      FieldByName('D_ZDBH').AsString := FKfxx.AZdbh;
      FieldByName('D_HH').AsInteger := AHh;
      FieldByName('D_XMBH').AsString := XMBH_DHF;
      FieldByName('D_KFBH').AsString := edtKfh.Text;
      FieldByName('D_XFJE').AsCurrency := FDhf;
      FieldByName('D_XFRQ').AsDateTime := Date;
      FieldByName('D_XFSJ').AsDateTime := Time;
      FieldByName('D_JZBZ').AsString  := JZ_NO;
      FieldByName('D_JSBZ').AsString  := JZ_NO;
      FieldByName('D_CZYXM').AsString := CZY.CzyXm;
      FieldByName('D_BZ').AsString := 'ɢ��'+edtKfh.Text;
      Post;
    end;
    Close;
  end;

  with qryKrzdcx do
  begin
    if Active then Active := False;
    ParamByName('ZDBH').AsString := FKfxx.AZdbh;
    try
      Open;
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
  end;
    {
    for i := 0 to StringGrid1.RowCount-1 do
      StringGrid1.Rows[i].Clear;

    StringGrid1.Cells[0,0] := '����ʱ��';
    StringGrid1.Cells[1,0] := '������Ŀ';
    StringGrid1.Cells[2,0] := '���ѽ��';
    StringGrid1.Cells[3,0] := '���ѱ�ע';
    First;
    i := 1;

    while not Eof do
    begin
      if FieldByName('D_XMBH').AsString = XMBH_FJ then
      begin
        StringGrid1.Cells[0,i] := FieldByName('D_XFRQ').AsString;
        StringGrid1.Cells[1,i] := FieldByName('D_XMMC').AsString;
        StringGrid1.Cells[2,i] := CurrToStr(FieldByName('D_XFJE').AsCurrency)+'Ԫ';
        StringGrid1.Cells[3,i] := FieldByName('D_BZ').AsString;
      end
      else
      begin
        StringGrid1.Cells[0,i] := FieldByName('D_XFRQ').AsString;
        StringGrid1.Cells[1,i] := FieldByName('D_XMMC').AsString;
        StringGrid1.Cells[2,i] := CurrToStr(FieldByName('D_XFJE').AsCurrency)+'Ԫ';
        StringGrid1.Cells[3,i] := FieldByName('D_BZ').AsString;
      end;
      Next;
      Inc(i);
    end;
    if FDtfj<>0 then
    begin
    StringGrid1.Cells[0,i] := DateToStr(Date);
    StringGrid1.Cells[1,i] := '����';
    StringGrid1.Cells[2,i] := CurrToStr(FDtfj)+'Ԫ';
    StringGrid1.Cells[3,i] := 'ɢ��'+edtKfh.Text;
    end;

    if FDhf<>0 then
    begin
    Inc(i);
    StringGrid1.Cells[0,i] := DateToStr(Date);
    StringGrid1.Cells[1,i] := '�绰��';
    StringGrid1.Cells[2,i] := CurrToStr(FDhf)+'Ԫ';
    StringGrid1.Cells[3,i] := 'ɢ��'+edtKfh.Text;
    end;

    StringGrid1.RowCount := i+1;
  end;}
end;

procedure TZdcxForm.ShowYjxx;
begin
  with qryKryj do
  begin
    DisableControls;
    if Active then Active := False;
    ParamByName('YJBH').AsString := FKfxx.AYjbh;
    try
      Open;
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

    EnableControls;
  end;
end;

procedure TZdcxForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  FKfbh := edtKfh.Text;
  
  if HotelData.CheckKfzt(FKfbh)<>KFZT_BF then
  begin
    ShowWarning('�ÿͷ�����ɢ�ͣ�');
    Exit;
  end;

  FKfxx := HotelData.GetKfxx(FKfbh);
  FYjxx := HotelData.GetYjxx(FKfxx.AYjbh);

  lblKrxm.Caption := '����������'+FKfxx.AKrxm;

  //��ȡ���췿��
  FDtfj := GetDtfj(FKfxx.ADdsj,Time,FKfxx.AKfbz,FKfxx.ASjfj);
  FDhf  := HotelData.GetDhf(FKfxx.AKfbh,FKfxx.ADdrq,FKfxx.ADdsj);

  FYfje := FYjxx.AYfje;
  FXfxx := HotelData.GetXfxx(FKfxx.AZdbh);

  FXfje := FXfxx.AXfje + FDtfj + FDhf;
  //FXfje := FXfxx.AXfje;
  FYjje := FXfxx.AYjje;

  ShowXx;
  ShowXfxx;
  ShowYjxx;
end;

procedure TZdcxForm.btnYjbjClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'����') then Exit;
  if FKfbh<>'' then
  begin
    BjyjEnter(FKfbh);
    btnQueryClick(nil);
  end;
end;

procedure TZdcxForm.btnZdmxClick(Sender: TObject);
begin
  inherited;
  Zdmx(FKfxx.AZdbh);
end;

procedure TZdcxForm.btnFjmxClick(Sender: TObject);
begin
  inherited;
  FJmx(FKfxx.AZdbh);
end;

end.
