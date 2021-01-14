{�����Ƶ����ϵͳ v1.0
 Copyright by CubicSoft
 program by ls.
 Date:20020301-20020601
 20020627 ����ע��
}
unit C_Yksy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C_StdJd, DosMove, StdCtrls, Buttons, ExtCtrls, DB, DBTables,
  Mask, DBCtrls, Grids, DBGrids, C_Define;

type
  TYksyForm = class(TStdJdForm)
    tblKrxx: TTable;
    edtKfh: TLabeledEdit;
    edtCzyxm: TLabeledEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Bevel2: TBevel;
    DBGrid1: TDBGrid;
    dsKrzd: TDataSource;
    dsKrxx: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    qryKrzd: TQuery;
    qryKrzdD_XFXM: TStringField;
    edtXfrq: TMaskEdit;
    edtXfsj: TMaskEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lblHj: TLabel;
    tblKrzd: TTable;
    qryKrzdD_ZDBH: TStringField;
    qryKrzdD_HH: TIntegerField;
    qryKrzdD_ZDLB: TStringField;
    qryKrzdD_KRBH: TStringField;
    qryKrzdD_YJBH: TStringField;
    qryKrzdD_KFBH: TStringField;
    qryKrzdD_SJFJ: TFloatField;
    qryKrzdD_XMBH: TStringField;
    qryKrzdD_XFDJ: TFloatField;
    qryKrzdD_XFSL: TFloatField;
    qryKrzdD_XFJE: TFloatField;
    qryKrzdD_XFRQ: TDateTimeField;
    qryKrzdD_XFSJ: TDateTimeField;
    qryKrzdD_YHJE: TFloatField;
    qryKrzdD_JZRQ: TDateTimeField;
    qryKrzdD_JZSJ: TDateTimeField;
    qryKrzdD_JZBZ: TStringField;
    qryKrzdD_JSBZ: TStringField;
    qryKrzdD_DLR1: TStringField;
    qryKrzdD_DLR2: TStringField;
    qryKrzdD_DLR3: TStringField;
    qryKrzdD_DLR4: TStringField;
    qryKrzdD_CZYXM: TStringField;
    qryKrzdD_JZYXM: TStringField;
    qryKrzdD_TYR: TStringField;
    qryKrzdD_BZ: TStringField;
    qryKrzdD_YSRQ: TStringField;
    qryKrzdD_JZBH: TStringField;
    qryKrzdD_BMBH: TStringField;
    procedure edtKfhExit(Sender: TObject);
    procedure qryKrzdAfterPost(DataSet: TDataSet);
    procedure qryKrzdBeforePost(DataSet: TDataSet);
    procedure edtXfrqExit(Sender: TObject);
    procedure edtXfsjExit(Sender: TObject);
    procedure btnCancClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1ColEnter(Sender: TObject);
    procedure qryKrzdD_XFJEValidate(Sender: TField);
    procedure qryKrzdD_XMBHValidate(Sender: TField);
  private
    { Private declarations }
    FIsTd: Boolean;
    FKey: string;
    FItemNo: Integer;
    FZdbh: string;
    FKrbh: string;
    FYjbh: string;
    FZdlb: string;
    FXfrq: TDateTime;
    FXfsj: TDateTime;
    FTotals: Currency;
    FKfxx: TKfxx;
    FBmbh: string;
    procedure UpdateTotals;
    procedure UpdateZd;
  public
    { Public declarations }
  end;

var
  YksyForm: TYksyForm;

procedure Yksy;
procedure YksyTd(const AKrbh: string);
procedure YksyEnter(const AKfbh: string);

implementation

uses C_HotelData;

{$R *.dfm}

//Ԣ������
procedure Yksy;
begin
  YksyForm := TYksyForm.Create(Application);
  try
    with YksyForm do
    begin
      FBmbh := HotelData.FindBh('YGDA','D_BMBH','D_YGBH',CZY.CzyBh);
      //��ʼ��
      FIsTd := False;
      edtXfrq.Text := FormatDateTime('yyyy-mm-dd',Date);
      edtXfsj.Text := FormatDateTime('hh:mm',Time);
      FXfrq        := Date;
      FXfsj        := Time;
      edtCzyxm.Text:= CZY.CzyXm;

      ShowModal;
    end;
  finally
    YksyForm.Free;
  end;
end;

procedure YksyTd(const AKrbh: string);
begin
  YksyForm := TYksyForm.Create(Application);
  try
    with YksyForm do
    begin
      FBmbh := HotelData.FindBh('YGDA','D_BMBH','D_YGBH',CZY.CzyBh);
      //��ʼ��
      FIsTd := True;
      edtKfh.Text  := AKrbh;
      edtKfh.EditLabel.Caption := '�Ŷӱ��';
      edtKfh.ReadOnly := True;
      FKrbh := AKrbh;
      edtXfrq.Text := FormatDateTime('yyyy-mm-dd',Date);
      edtXfsj.Text := FormatDateTime('hh:mm',Time);
      FXfrq        := Date;
      FXfsj        := Time;
      edtCzyxm.Text:= CZY.CzyXm;

      ShowModal;
    end;
  finally
    YksyForm.Free;
  end;

end;

//Ԣ������
procedure YksyEnter(const AKfbh: string);
begin
  YksyForm := TYksyForm.Create(Application);
  try
    with YksyForm do
    begin
      FBmbh := HotelData.FindBh('YGDA','D_BMBH','D_YGBH',CZY.CzyBh);
      //��ʼ��
      FIsTd := False;
      edtKfh.Text  := AKfbh;
      edtXfrq.Text := FormatDateTime('yyyy-mm-dd',Date);
      edtXfsj.Text := FormatDateTime('hh:mm',Time);
      FXfrq        := Date;
      FXfsj        := Time;
      edtCzyxm.Text:= CZY.CzyXm;

      ShowModal;
    end;
  finally
    YksyForm.Free;
  end;
end;

//�����ʵ��ܵ�
procedure TYksyForm.UpdateZd;
begin
  try
    try
      tblKrzd.Open;
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

    if tblKrzd.FindKey([FZdbh,0]) then
    begin
      tblKrzd.Edit;
      tblKrzd.FieldByName('D_XFJE').AsCurrency :=
        tblKrzd.FieldByName('D_XFJE').AsCurrency + FTotals;
      tblKrzd.Post;
    end;
  finally
    tblKrzd.Close;
  end;
end;

//�ۼ�����
procedure TYksyForm.UpdateTotals;
var
  PrevRecord: TBookMark;
begin
  PrevRecord := qryKrzd.GetBookmark;
  try
    qryKrzd.DisableControls;
    FTotals := 0;
    qryKrzd.First;
    while not qryKrzd.Eof do
    begin
      FTotals := FTotals + qryKrzdD_XFJE.Value;
      qryKrzd.Next;
    end;
    lblHj.Caption := CurrToStr(FTotals)+'Ԫ';
  finally
    qryKrzd.EnableControls;
    if PrevRecord<>nil then
    begin
      qryKrzd.GotoBookmark(PrevRecord);
      qryKrzd.FreeBookmark(PrevRecord);
    end;
  end;
end;

//ѡ��ͷ����
procedure TYksyForm.edtKfhExit(Sender: TObject);
var
  AKfzt,AKfbh: string;
  ATdxx : TTdxx;
begin
  inherited;
  if not FIsTd then
  begin
  AKfbh := edtKfh.Text;
  AKfzt := HotelData.CheckKfzt(AKfbh);

  if (AKfzt=KFZT_BF)or(AKfzt=KFZT_TD) then
  begin
    FKfxx := HotelData.GetKfxx(AKfbh);
    FZdbh := FKfxx.AZdbh;
    FKrbh := FKfxx.AKrbh;
    FYjbh := FKfxx.AYjbh;

    if AKfzt=KFZT_BF then FZdlb := ZDLB_YK;
    if AKfzt=KFZT_TD then FZdlb := ZDLB_TD;
  end
  else
  begin
    ShowInfo('�ÿͷ�����������');
    edtKfh.SetFocus;
    Exit;
  end;
  end
  else
  begin
    ATdxx := HotelData.GetTdxx(FKrbh);
    FZdbh := ATdxx.AZdbh;
    FKrbh := ATdxx.AKrbh;
    FYjbh := ATdxx.AYjbh;
    FZdlb := ZDLB_TD;
  end;

  try
    tblKrxx.Open;
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

  //��ʾ������Ϣ
  tblKrxx.Locate('D_KRBH',FKrbh,[]);

  //��ȡ�ʵ�����к�
  FItemNo := HotelData.GetMaxZdhh(FZdbh);
  with qryKrzd do
  begin
    if Active then Active := False;
    Params[0].Value := FZdbh;
    Params[1].Value := FItemNo;
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
end;

procedure TYksyForm.qryKrzdAfterPost(DataSet: TDataSet);
begin
  inherited;
  Inc(FItemNo);
  UpdateTotals;
end;

procedure TYksyForm.qryKrzdBeforePost(DataSet: TDataSet);
begin
  inherited;
  qryKrzdD_ZDBH.Value := FZdbh;
  qryKrzdD_KRBH.Value := FKrbh;
  qryKrzdD_YJBH.Value := FYjbh;
  qryKrzdD_ZDLB.Value := FZdlb;
  qryKrzdD_HH.Value   := FItemNo;
  qryKrzdD_XFRQ.Value := FXfrq;
  qryKrzdD_KFBH.Value := FKfxx.AKfbh;
  qryKrzdD_XFSJ.Value := FXfsj;
  qryKrzdD_JZBZ.Value := JZ_NO;
  qryKrzdD_JSBZ.Value := JS_NO;
  qryKrzdD_CZYXM.Value:= CZY.CzyXm;
  qryKrzdD_BMBH.Value := FBmbh;
  if FZdlb = ZDLB_YK then
    qryKrzdD_BZ.Value   := '�ӵ�¼��'
  else
  if FZdlb = ZDLB_TD then
    qryKrzdD_BZ.Value   := '�ӵ�¼��';
end;

procedure TYksyForm.edtXfrqExit(Sender: TObject);
begin
  inherited;
  FXfrq := StrToDate(edtXfrq.Text);
end;

procedure TYksyForm.edtXfsjExit(Sender: TObject);
begin
  inherited;
  FXfsj := StrToTime(edtXfsj.Text);
  DBGrid1.SetFocus;
end;

procedure TYksyForm.btnCancClick(Sender: TObject);
begin
  inherited;
  qryKrzd.CancelUpdates;
end;

//ȷ��
procedure TYksyForm.btnOKClick(Sender: TObject);
begin
  inherited;
  if edtKfh.Text='' then
  begin
    ShowWarning('������ͷ��ţ�');
    Exit;
  end;

  if qryKrzd.IsEmpty then
  begin
    ShowWarning('��¼��������Ŀ��');
    Exit;
  end;

  if not Confirm('��ȷ�ϸÿ��˵�������') then
    Exit;

  if qryKrzd.State in [dsInsert,dsEdit] then
  begin
    if qryKrzd.FieldByName('D_XMBH').AsString = '' then
      qryKrzd.Cancel
    else
      qryKrzd.Post;
  end;

  //��������
  HotelData.DatabaseUser.StartTransaction;
  try
    qryKrzd.ApplyUpdates;
    UpdateZd;

    //�����ύ
    HotelData.DatabaseUser.Commit;
  except
    //����ع�
    HotelData.DatabaseUser.Rollback;
    raise;
  end;
  qryKrzd.CommitUpdates;
  //��ʼ��
  FIsTd := False;
  tblKrxx.Close;
  edtXfrq.Text := FormatDateTime('yyyy-mm-dd',Date);
  edtXfsj.Text := FormatDateTime('hh:mm',Time);
  FXfrq        := Date;
  FXfsj        := Time;
  edtCzyxm.Text:= CZY.CzyXm;
  edtKfh.Text := '';
  lblHj.Caption := '0Ԫ';
  edtKfh.SetFocus;

  //Close;
end;

procedure TYksyForm.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if DBGrid1.SelectedIndex=0 then
  begin
    if Ord(Key)=VK_BACK then FKey := ''
    else
    begin
      FKey := FKey + Key;
      if HotelData.tblXMDM.Locate('D_DM',FKey,[loPartialKey]) then
      begin
        qryKrzd.Edit;
        qryKrzdD_XMBH.Value := HotelData.tblXMDM.FieldByName('D_XMBH').AsString;
      end;
    end;
  end;
end;

procedure TYksyForm.DBGrid1ColEnter(Sender: TObject);
begin
  inherited;
  if DBGrid1.SelectedIndex=0 then FKey := '';
end;

procedure TYksyForm.qryKrzdD_XFJEValidate(Sender: TField);
begin
  inherited;
  if (qryKrzdD_XFJE.Value<=0)and(CZY.CzyXm <> '������') then
    raise Exception.Create('���ѽ���������㣡');
end;

procedure TYksyForm.qryKrzdD_XMBHValidate(Sender: TField);
begin
  inherited;
  if qryKrzdD_XMBH.Value = XMBH_YJK then
    raise Exception.Create('Ԥ�����������');
  if qryKrzdD_XMBH.Value = XMBH_CF then
    raise Exception.Create('���ڲ�������ϵͳ->�ǲͷѽ�����¼��');
end;

end.
