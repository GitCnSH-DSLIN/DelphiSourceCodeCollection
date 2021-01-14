{�����Ƶ����ϵͳ v1.0
 Copyright by CubicSoft
 program by ls.
 Date:20020301-20020601
 20020627 ����ע��
}
unit C_Tdtf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C_StdJd, DosMove, StdCtrls, Buttons, ExtCtrls, Mask, ComCtrls,
  DB, DBTables, C_Define;

type
  TTdtfForm = class(TStdJdForm)
    Label2: TLabel;
    edtJzrq: TMaskEdit;
    Label3: TLabel;
    edtJzsj: TMaskEdit;
    ListView1: TListView;
    qryKfzt: TQuery;
    btnSelAll: TBitBtn;
    btnSelCanc: TBitBtn;
    qryKrzd: TQuery;
    edtTdmc: TLabeledEdit;
    Bevel2: TBevel;
    qryKrzdKf: TQuery;
    tblBqj: TTable;
    procedure btnSelAllClick(Sender: TObject);
    procedure btnSelCancClick(Sender: TObject);
    procedure edtJzrqExit(Sender: TObject);
    procedure edtJzsjExit(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure qryKrzdNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    FQxbz: Integer;
    FHh  : Integer;
    FKrbh: string;
    FZdbh: string;
    FJzrq: TDateTime;
    FJzsj: TDateTime;
    FDtfj: Currency;
    FDhf : Currency;
    FKfxx: TKfxx;
    procedure AddKfbh;
    procedure AddDhf;
    //procedure AddDtfj(const AKfbh: string;ADtfj: Currency);
    procedure UpdateKrzdTf;
    procedure UpdateKrzdQx;
  public
    { Public declarations }
  end;

var
  TdtfForm: TTdtfForm;

procedure Tdtf(const AKrbh: string);
procedure Tdqx(const AKrbh: string);

implementation

uses C_HotelData, C_Wait;

{$R *.dfm}

//�Ŷ��˷�
procedure Tdtf(const AKrbh: string);
begin
  TdtfForm := TTdtfForm.Create(Application);
  try
    with TdtfForm do
    begin
      //�˷�
      FQxbz := 0;

      FKrbh := AKrbh;
      FZdbh := HotelData.GetZdbh(AKrbh);

      //��ʼ��
      edtJzrq.Text := FormatDateTime('yyyy-mm-dd',Date);
      edtJzsj.Text := FormatDateTime('hh:mm',Time);
      FJzrq := Date;
      FJzsj := Time;
      edtTdmc.Text := HotelData.FindUserBh('KRXX','D_KRXM','D_KRBH',FKrbh);

      //��ӿͷ����
      AddKfbh;

      {if qryKrzd.Active then qryKrzd.Active := False;
      qryKrzd.Params[0].Value := FZdbh;
      try
        qryKrzd.Open;
      except
        On E:Exception do
        begin
          ShowWarning('�����ݿ�����������������Ƿ�������'
                      +#13#10
                      +'������Ϣ:'
                      +E.Message);
          raise;
        end;
      end;}

      ShowModal;
    end;
  finally
    TdtfForm.Free;
  end;
end;

//�Ŷ�ȡ������
procedure Tdqx(const AKrbh: string);
begin
  TdtfForm := TTdtfForm.Create(Application);
  try
    with TdtfForm do
    begin
      //ȡ��
      FQxbz := 1;
      lblTitile.Caption := '�Ŷ�ȡ��';

      FKrbh := AKrbh;
      FZdbh := HotelData.GetZdbh(AKrbh);

      //��ʼ��
      edtJzrq.Text := FormatDateTime('yyyy-mm-dd',Date);
      edtJzsj.Text := FormatDateTime('hh:mm',Time);
      FJzrq := Date;
      FJzsj := Time;
      edtTdmc.Text := HotelData.FindUserBh('KRXX','D_KRXM','D_KRBH',FKrbh);
      
      //��ӿ��˷���
      AddKfbh;

      {if qryKrzd.Active then qryKrzd.Active := False;
      qryKrzd.Params[0].Value := FZdbh;
      try
        qryKrzd.Open;
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
      }
      ShowModal;
    end;
  finally
    TdtfForm.qryKrzd.Close;
    TdtfForm.Free;
  end;
end;

//��ӿ��˷���
procedure TTdtfForm.AddKfbh;
var
  ListItem: TListItem;
  s       : string;
begin
  if FQxbz = 0 then
    s := 'select * from KFZT where D_KRBH=:KRBH'
  else
    s := 'select * from KFZT where (D_KRBH=:KRBH)and(D_KFBZ="'+KFBZ_DT+'")';

  if qryKfzt.Active then qryKfzt.Active := False;
  qryKfzt.SQL.Clear;
  qryKfzt.SQL.Add(s);
  qryKfzt.Params[0].Value := FKrbh;
  try
    qryKfzt.Open;
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

  qryKfzt.First;
  while not qryKfzt.Eof do
  begin
    ListItem := ListView1.Items.Add;
    ListItem.Caption := qryKfzt.FieldByName('D_KFBH').AsString;
    qryKfzt.Next;
  end;

  qryKfzt.Close;
end;

//ȫѡ
procedure TTdtfForm.btnSelAllClick(Sender: TObject);
var
  I: Integer;
begin
  inherited;
  for I:=0 to ListView1.Items.Count - 1 do
    ListView1.Items[I].Checked := True;
end;

//ȫ��ѡ
procedure TTdtfForm.btnSelCancClick(Sender: TObject);
var
  I: Integer;
begin
  inherited;
  for I:=0 to ListView1.Items.Count - 1 do
    ListView1.Items[I].Checked := False;
end;

procedure TTdtfForm.edtJzrqExit(Sender: TObject);
begin
  inherited;
  FJzrq := StrToDate(edtJzrq.Text);
end;

procedure TTdtfForm.edtJzsjExit(Sender: TObject);
begin
  inherited;
  FJzsj := StrToTime(edtJzsj.Text);
end;

//��ӵ绰�Ѽ�¼
procedure TTdtfForm.AddDhf;
begin
  qryKrzd.Insert;
  qryKrzd.FieldByName('D_ZDBH').AsString   := FKfxx.AZdbh;
  qryKrzd.FieldByName('D_HH').AsInteger    := FHh;
  qryKrzd.FieldByName('D_KRBH').AsString   := FKfxx.AKrbh;
  qryKrzd.FieldByName('D_YJBH').AsString   := FKfxx.AYjbh;
  qryKrzd.FieldByName('D_ZDLB').AsString   := ZDLB_TD;
  qryKrzd.FieldByName('D_XMBH').AsString   := XMBH_DHF;
  qryKrzd.FieldByName('D_XFJE').AsCurrency := FDhf;
  qryKrzd.FieldByName('D_JZBZ').AsString   := JZ_NO;
  qryKrzd.FieldByName('D_JSBZ').AsString   := JS_NO;
  qryKrzd.FieldByName('D_XFRQ').AsDateTime := FJzrq;
  qryKrzd.FieldByName('D_XFSJ').AsDateTime := FJzsj;
  qryKrzd.Post;
end;
{
//��ӵ��췿��
procedure TTdtfForm.AddDtfj(const AKfbh: string;ADtfj: Currency);
begin
  if qryKrzd.Locate('D_KFBH',AKfbh,[]) then
  begin
    qryKrzd.Edit;
    qryKrzd.FieldByName('D_XFJE').AsCurrency := qryKrzd.FieldByName('D_XFJE').AsCurrency+ADtfj;
    qryKrzd.Post;
  end;
  {qryKrzd.Insert;
  qryKrzd.FieldByName('D_ZDBH').AsString   := FKfxx.AZdbh;
  qryKrzd.FieldByName('D_HH').AsInteger    := FHh;
  qryKrzd.FieldByName('D_KFBH').AsString   := AKfbh;
  qryKrzd.FieldByName('D_KRBH').AsString   := FKfxx.AKrbh;
  qryKrzd.FieldByName('D_YJBH').AsString   := FKfxx.AYjbh;
  qryKrzd.FieldByName('D_ZDLB').AsString   := ZDLB_TD;
  qryKrzd.FieldByName('D_XMBH').AsString   := XMBH_FJ;
  qryKrzd.FieldByName('D_XFJE').AsCurrency := ADtfj;
  qryKrzd.FieldByName('D_JZBZ').AsString   := JZ_YES;
  qryKrzd.FieldByName('D_JSBZ').AsString   := JS_NO;
  qryKrzd.FieldByName('D_XFRQ').AsDateTime := FJzrq;
  qryKrzd.FieldByName('D_XFSJ').AsDateTime := FJzsj;
  qryKrzd.FieldByName('D_JZRQ').AsDateTime := FJzrq;
  qryKrzd.FieldByName('D_JZSJ').AsDateTime := FJzsj;
  qryKrzd.FieldByName('D_CZYXM').AsString  := CZY.CzyXm;
  qryKrzd.FieldByName('D_JZYXM').AsString  := CZY.CzyXm;
  qryKrzd.FieldByName('D_BZ').AsString     := ZDBZ_TD+AKfbh+FKfxx.AKrxm;
  qryKrzd.Post;
end;
}
procedure TTdtfForm.UpdateKrzdTf;
var
  I     : Integer;
  AKfbh : string;
  ABqj  : Integer;
  ADtfj : Currency;
  ADhf  : Currency;
  ADdrq : TDateTime;
  ADdsj : TDateTime;
begin
  FDtfj := 0;
  FDhf  := 0;
  //FHh   := HotelData.GetMaxZdhh(FZdbh)-1;
  with qryKrzdKf do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from KRZD where (D_ZDBH="'+FZdbh+'")and(D_XMBH="'+XMBH_FJ+'")and(D_JZBZ="1")');
    Open;
  end;

  for I:=0 to ListView1.Items.Count - 1 do
    if ListView1.Items[i].Checked then
    begin
      AKfbh := ListView1.Items[i].Caption;
      if qryKrzdKf.Locate('D_KFBH',AKfbh,[]) then
      begin
        //��ȡ�ͷ���Ϣ
        FKfxx := HotelData.GetKfxx(AKfbh);
        ADdrq := qryKrzdKf.FieldByName('D_XFRQ').AsDateTime;
        //����ʱ��
        ADdsj := qryKrzdKf.FieldByName('D_XFSJ').AsDateTime;

        //��ȡ���췿�ۡ���ȫ��
        ADtfj := GetDtfj(ADdsj,FJzsj,FKfxx.AKfbz,FKfxx.ASjfj);
        ABqj  := CheckLdsj(ADdsj,FJzsj,FKfxx.AKfbz);

        //����а�ȫ��
        if ABqj<>BQJ_ZC then
          HotelData.UpdateBqj(AKfbh,ABqj,0,ADtfj)
        else
          HotelData.UpdateBqj(AKfbh,ABqj,0,0);

        //��ȡ�绰��
        //edit by ls.20021102
        //ADhf  := HotelData.GetDhf(FKfxx.AKfbh,FKfxx.ADdrq,FKfxx.ADdsj);
        ADhf  := HotelData.GetDhf(AKfbh,ADdrq,ADdsj);
        //�ۼ�
        FDtfj := FDtfj + ADtfj;
        FDhf  := FDhf + ADhf;

        qryKrzdKf.Edit;
        if ADtfj<>0 then
        begin
          qryKrzdKf.FieldByName('D_XFJE').AsCurrency := qryKrzdKf.FieldByName('D_XFJE').AsCurrency+ADtfj;
        end;
        qryKrzdKf.FieldByName('D_JZBZ').AsString   := JZ_YES;
        qryKrzdKf.FieldByName('D_JZRQ').AsDateTime := FJzrq;
        qryKrzdKf.FieldByName('D_JZSJ').AsDateTime := FJzsj;
        qryKrzdKf.Post;

        //��ӵ��췿��
        if ADtfj<>0 then
        begin
          //AddDtfj(AKfbh,ADtfj);
          HotelData.UpdateJjfj(AKfbh,ABqj,ADtfj);
        end;
        //��ʼ���ͷ�
        HotelData.InitKfzt(AKfbh);
      end;
    end;

  with qryKrzd do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from KRZD where D_ZDBH="'+FZdbh+'"');
    Prepare;
    Open;
  end;
  //����绰�Ѳ�������
  if FDhf<>0 then
  begin
    FHh := HotelData.GetMaxZdhh(FZdbh);
    AddDhf;
  end;

  //�޸��ܵ�
  if (FDtfj+FDhf)<>0 then
    if qryKrzd.Locate('D_HH',0,[]) then
    begin
      qryKrzd.Edit;
      qryKrzd.FieldByName('D_XFJE').AsCurrency :=
        qryKrzd.FieldByName('D_XFJE').AsCurrency + FDtfj + FDhf;
      qryKrzd.Post;
    end;

end;

//ȡ������
procedure TTdtfForm.UpdateKrzdQx;
var
  I     : Integer;
  AKfbh : string;
begin
  with qryKrzdKf do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from KRZD where (D_ZDBH="'+FZdbh+'")and(D_XMBH="'+XMBH_FJ+'")and(D_JZBZ="1")');
    Open;
  end;
  tblBqj.Open;
  for I:=0 to ListView1.Items.Count - 1 do
  begin
    if ListView1.Items[i].Checked then
    begin
      AKfbh := ListView1.Items[i].Caption;
      if qryKrzdKf.Locate('D_KFBH',AKfbh,[]) then
        qryKrzdKf.Delete;
      if tblBqj.FindKey([AKfbh]) then
      begin
        tblBqj.Edit;
        tblBqj.FieldByName('D_SJFJ').AsCurrency := 0;
        tblBqj.Post;
      end;
      //���
      HotelData.ClearKfzt(AKfbh);
    end;
  end;
  tblBqj.Close;
end;

//ȷ���˷�
procedure TTdtfForm.btnOKClick(Sender: TObject);
begin
  inherited;
  if not Confirm('��ȷ�ϸò�����') then Exit;
  WaitForm := TWaitForm.Create(Application);
  try
    WaitForm.FTitle := '�Ŷ��˷�';
    WaitForm.Show;
    WaitForm.Update;

  //��������
  HotelData.DatabaseUser.StartTransaction;
  try
    //������˷�
    if FQxbz=0 then
      UpdateKrzdTf
    else
      UpdateKrzdQx;

    //�����ύ
    HotelData.DatabaseUser.Commit;
  except
    //����ع�
    HotelData.DatabaseUser.Rollback;
    raise;
  end;
  //qryKrzd.CommitUpdates;

  finally
    WaitForm.Hide;
    WaitForm.Free;
  end;

  Close;
end;

procedure TTdtfForm.qryKrzdNewRecord(DataSet: TDataSet);
begin
  inherited;
  Inc(FHh);
end;

end.
