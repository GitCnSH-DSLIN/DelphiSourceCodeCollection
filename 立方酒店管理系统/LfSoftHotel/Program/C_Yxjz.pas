{�����Ƶ����ϵͳ v1.0
 Copyright by CubicSoft
 program by ls.
 Date:20020301-20020601
 20020627 ����ע��
}
unit C_Yxjz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C_StdJd, DosMove, StdCtrls, Buttons, ExtCtrls, Mask, C_Define,
  DB, DBTables;

type
  TYxjzForm = class(TStdJdForm)
    Label2: TLabel;
    edtJzrq: TMaskEdit;
    Label3: TLabel;
    edtJzsj: TMaskEdit;
    edtKfh: TLabeledEdit;
    edtJzje: TLabeledEdit;
    radJzfs: TRadioGroup;
    Label4: TLabel;
    cmbJz: TComboBox;
    edtTfje: TLabeledEdit;
    chkYjtf: TCheckBox;
    edtFkfs: TLabeledEdit;
    tblKrzd: TTable;
    tblKrjz: TTable;
    tblKryj: TTable;
    tblKrzdD_ZDBH: TStringField;
    tblKrzdD_HH: TIntegerField;
    tblKrzdD_ZDLB: TStringField;
    tblKrzdD_KRBH: TStringField;
    tblKrzdD_YJBH: TStringField;
    tblKrzdD_KFBH: TStringField;
    tblKrzdD_SJFJ: TFloatField;
    tblKrzdD_XMBH: TStringField;
    tblKrzdD_XFDJ: TFloatField;
    tblKrzdD_XFSL: TFloatField;
    tblKrzdD_XFJE: TFloatField;
    tblKrzdD_XFRQ: TDateTimeField;
    tblKrzdD_XFSJ: TDateTimeField;
    tblKrzdD_YHJE: TFloatField;
    tblKrzdD_JZRQ: TDateTimeField;
    tblKrzdD_JZSJ: TDateTimeField;
    tblKrzdD_JZBZ: TStringField;
    tblKrzdD_JSBZ: TStringField;
    tblKrzdD_DLR1: TStringField;
    tblKrzdD_DLR2: TStringField;
    tblKrzdD_DLR3: TStringField;
    tblKrzdD_DLR4: TStringField;
    tblKrzdD_CZYXM: TStringField;
    tblKrzdD_JZYXM: TStringField;
    tblKrzdD_TYR: TStringField;
    tblKrzdD_BZ: TStringField;
    tblKrzdD_YSRQ: TStringField;
    tblKrzdD_JZBH: TStringField;
    tblKrjzD_JZBH: TStringField;
    tblKrjzD_HH: TIntegerField;
    tblKrjzD_XMBH: TStringField;
    tblKrjzD_XFDJ: TFloatField;
    tblKrjzD_XFSL: TFloatField;
    tblKrjzD_XFGG: TStringField;
    tblKrjzD_XFJE: TFloatField;
    tblKrjzD_YJJE: TFloatField;
    tblKrjzD_YHJE: TFloatField;
    tblKrjzD_JZFS: TStringField;
    tblKrjzD_JZLX: TStringField;
    tblKrjzD_KHBH: TStringField;
    tblKrjzD_XYKBH: TStringField;
    tblKrjzD_JZRQ: TDateTimeField;
    tblKrjzD_JZSJ: TDateTimeField;
    tblKrjzD_CZYXM: TStringField;
    tblKrjzD_BZ: TStringField;
    tblKrjzD_YSRQ: TStringField;
    tblKrjzD_BMBH: TStringField;
    tblKrzdD_BMBH: TStringField;
    cmbXfxm: TComboBox;
    Label1: TLabel;
    procedure radJzfsClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtJzrqExit(Sender: TObject);
    procedure edtJzsjExit(Sender: TObject);
    procedure edtKfhKeyPress(Sender: TObject; var Key: Char);
    procedure edtKfhExit(Sender: TObject);
    procedure chkYjtfClick(Sender: TObject);
    procedure edtJzjeExit(Sender: TObject);
    procedure cmbXfxmExit(Sender: TObject);
  private
    { Private declarations }
    FBmbh: string;
    FJzrq: TDateTime;
    FJzsj: TDateTime;
    FTfje: Currency;
    FJzje: Currency;
    FJzfs: string;
    FXykbh: string;
    FKfxx: TKFXX;
    FYjxx: TYjxx;
    FXmbh: string;
    function IsValid: Boolean;
    procedure ShowYjxx;
    procedure UpdateKrzd;
    procedure UpdateKrjz;
    procedure UpdateKryj;
  public
    { Public declarations }
  end;

var
  YxjzForm: TYxjzForm;

procedure Yxjz;

implementation

uses C_HotelData;

{$R *.dfm}

//ɢ��Ԥ�Ƚ���
procedure Yxjz;
begin
  YxjzForm := TYxjzForm.Create(Application);
  try
    with YxjzForm do
    begin
      //��ȡ���ű��
      FBmbh := HotelData.FindBh('YGDA','D_BMBH','D_YGBH',CZY.CzyBh);
      //��ʼ��
      edtJzrq.Text := FormatDateTime('yyyy-mm-dd',Date);
      edtJzsj.Text := FormatDateTime('hh:mm',Time);
      HotelData.ListDm(cmbXfxm,'XMDM','D_XMMC');
      cmbXfxm.ItemIndex := 0;
      FXmbh := XMBH_FJ;
      FJzrq        := Date;
      FJzsj        := Time;
      FJzfs        := JZFS_RMB;

      ShowModal;
    end;
  finally
    YxjzForm.Free;
  end;
end;

//ѡ����ʷ�ʽ
procedure TYxjzForm.radJzfsClick(Sender: TObject);
begin
  inherited;
  cmbJz.Items.Clear;
  cmbJz.Style := csDropDownList;

  case radJzfs.ItemIndex of
    0: FJzfs := JZFS_RMB;
    1:
      begin
        HotelData.ListMc(cmbJz,'XYK','D_XYKMC');
        FJzfs := JZFS_XYK;
      end;
    2: FJzfs := JZFS_ZP;
  end;
end;

//�����Ч��
function TYxjzForm.IsValid: Boolean;
begin
  Result := False;
  case radJzfs.ItemIndex of
    1:
      begin
        FXykbh := HotelData.FindBh('XYK','D_XYKBH','D_XYKMC',cmbJz.Text);
        if FXykbh<>'' then
          Result := True
        else
          ShowInfo('��ѡ�����ÿ���');
      end;
    else
      Result := True;
  end;
end;

//���¿����ʵ�
procedure TYxjzForm.UpdateKrzd;
begin
  tblKrzd.Insert;
  tblKrzdD_ZDBH.Value := FKfxx.AZdbh;
  tblKrzdD_HH.Value   := FKFxx.AZdhh;
  tblKrzdD_KRBH.Value := FKfxx.AKrbh;
  tblKrzdD_YJBH.Value := FKfxx.AYjbh;
  tblKrzdD_KFBH.Value := FKfxx.AKfbh;
  tblKrzdD_ZDLB.Value := ZDLB_YK;
  //tblKrzdD_XMBH.Value := XMBH_YJK;
  tblKrzdD_XMBH.Value := FXmbh;
  tblKrzdD_XFJE.Value := 0-FJzje;
  tblKrzdD_XFRQ.Value := FJzrq;
  tblKrzdD_XFSJ.Value := FJzsj;
  tblKrzdD_JZBZ.Value := JZ_YX;
  tblKrzdD_JSBZ.Value := JS_NO;
  tblKrzdD_BMBH.Value := FBmbh;
  tblKrzdD_BZ.Value   := ZDBZ_YX+edtKfh.Text;
  tblKrzdD_CZYXM.Value:= CZY.CzyXm;
  tblKrzdD_JZYXM.Value := CZY.CzyXm;
  tblKrzd.Post;
end;

//���½��ʿ�
procedure TYxjzForm.UpdateKrjz;
var
  AJzbh: string;
begin
  //��ȡ���ʱ��
  AJzbh := HotelData.GetBh('D_JZBH',PREV_JZBH);

  //�����ܵ� �к�=0
  tblKrjz.Insert;
  tblKrjzD_JZBH.Value := AJzbh;
  tblKrjzD_HH.Value   := 0;
  tblKrjzD_JZRQ.Value := FJzrq;
  tblKrjzD_JZSJ.Value := FJzsj;
  tblKrjzD_JZFS.Value := FJzfs;
  tblKrjzD_XYKBH.Value:= FXykbh;
  //tblKrjzD_JZLX.Value := JZLX_YJK;
  tblKrjzD_JZLX.Value := JZLX_YK;
  tblKrjzD_XFJE.Value := FJzje;
  tblKrjzD_CZYXM.Value:= CZY.CzyXm;
  tblKrjzD_BMBH.Value := FBmbh;
  tblKrjzD_BZ.Value   := JZBZ_YX+edtKfh.Text;
  tblKrjz.Post;

  //�ӵ�
  tblKrjz.Insert;
  tblKrjzD_JZBH.Value := AJzbh;
  tblKrjzD_HH.Value   := 1;
  tblKrjzD_JZRQ.Value := FJzrq;
  tblKrjzD_JZSJ.Value := FJzsj;
  tblKrjzD_JZFS.Value := FJzfs;
  tblKrjzD_XYKBH.Value:= FXykbh;
  //tblKrjzD_JZLX.Value := JZLX_YJK;
  tblKrjzD_JZLX.Value := JZLX_YK;
  //tblKrjzD_XMBH.Value := XMBH_YJK;
  tblKrjzD_XMBH.Value := FXmbh;
  tblKrjzD_XFJE.Value := FJzje;
  tblKrjzD_CZYXM.Value:= CZY.CzyXm;
  tblKrjzD_BMBH.Value := FBmbh;
  tblKrjzD_BZ.Value   := JZBZ_YX+edtKfh.Text;
  tblKrjz.Post;
end;

//���¿���Ѻ��
procedure TYxjzForm.UpdateKryj;
begin
  tblKryj.Insert;
  tblKryj.FieldByName('D_YJBH').AsString   := FYjxx.AYjbh;
  tblKryj.FieldByName('D_HH').AsInteger    := FYjxx.AYjhh;
  tblKryj.FieldByName('D_FKFS').AsString   := FYjxx.AFkfs;
  tblKryj.FieldByName('D_YFRQ').AsDateTime := FJzrq;
  tblKryj.FieldByName('D_YFSJ').AsDateTime := FJzsj;
  tblKryj.FieldByName('D_YFJE').AsCurrency := 0-FTfje;
  tblKryj.FieldByName('D_BZ').AsString     := YJBZ_TF;
  tblKryj.Post;
end;

//����ȷ��
procedure TYxjzForm.btnOKClick(Sender: TObject);
begin
  inherited;
  FTfje := 0;

  if edtKfh.Text='' then
  begin
    ShowWarning('����ӽ��ʷ��ţ�');
    Exit;
  end;

  if edtJzje.Text='' then
  begin
    ShowWarning('��������ʽ�');
    Exit;
  end;
  FJzje := StrToCurr(edtJzje.Text);
  if not Confirm('��ȷ�ϸÿ��˵����ѽ�����') then
    Exit;

  if (FYjxx.AFkfs=FKFS_RMB)and chkYjtf.Checked then
  begin
    try
      FTfje := StrToCurr(edtTfje.Text);
      if FTfje>FYjxx.AYfje then
      begin
        ShowWarning('�˸����ܴ���Ѻ���');
        Exit;
      end;
    except
      raise Exception.Create('�������˸���');
    end;
  end;

  if not IsValid then Exit;

  try
    try
      tblKrzd.Open;
      tblKrjz.Open;
      tblKryj.Open;
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

    //��������
    HotelData.DatabaseUser.StartTransaction;
    try
      UpdateKrzd;
      UpdateKrjz;
      if FTfje<>0 then UpdateKryj;
      tblKrzd.ApplyUpdates;
      tblKrjz.ApplyUpdates;
      tblKryj.ApplyUpdates;

      //edit by ls. 20020824
      {if FJzfs = JZFS_RMB then
        HotelData.InsertYjk(YJLX_YX,YJBZ_YX+' '+edtKfh.Text,FJzje,0,0);
      if FJzfs = JZFS_XYK then
        HotelData.InsertYjk(YJLX_YX,YJBZ_YX+' '+edtKfh.Text,0,FJzje,0);
      if FJzfs = JZFS_ZP then
        HotelData.InsertYjk(YJLX_YX,YJBZ_YX+' '+edtKfh.Text,0,0,FJzje);}

      //�����ύ
      HotelData.DatabaseUser.Commit;
    except
      //����ع�
      HotelData.DatabaseUser.Rollback;
      raise;
    end;
    tblKrzd.CommitUpdates;
    tblKrjz.CommitUpdates;
    tblKryj.CommitUpdates;
  finally
    tblKrzd.Close;
    tblKrjz.Close;
    tblKryj.Close;
  end;
  //edit by ls.20021102��������
      //��ʼ��
      edtJzrq.Text := FormatDateTime('yyyy-mm-dd',Date);
      edtJzsj.Text := FormatDateTime('hh:mm',Time);
      HotelData.ListDm(cmbXfxm,'XMDM','D_XMMC');
      cmbXfxm.ItemIndex := 0;
      FXmbh := XMBH_FJ;
      FJzrq        := Date;
      FJzsj        := Time;
      FJzfs        := JZFS_RMB;
      radJzfs.ItemIndex := 0;
      edtKfh.Text := '';
      edtJzje.Text := '';
      cmbJz.Items.Clear;
      edtFkfs.Text := '';
      edtTfje.Text := '';
      chkYjtf.Checked := False;
      edtKfh.SetFocus;

  //cmbXfxm.SetFocus;
  //edtJzje.Text := '';
  //Close;
end;

procedure TYxjzForm.edtJzrqExit(Sender: TObject);
begin
  inherited;
  FJzrq := StrToDate(edtJzrq.Text);
end;

procedure TYxjzForm.edtJzsjExit(Sender: TObject);
begin
  inherited;
  FJzsj := StrToTime(edtJzsj.Text);
end;

procedure TYxjzForm.edtKfhKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (not(Key in ['0'..'9','.']))and(Ord(Key)<>VK_BACK) then
  begin
    Key := #0;
    Beep;
  end;
end;

//��ʾѺ����Ϣ
procedure TYxjzForm.ShowYjxx;
begin
  //��ȡѺ����Ϣ
  FYjxx := HotelData.GetYjxx(FKfxx.AYjbh);
  edtFkfs.Text := FYjxx.AFkfs;

  if FYjxx.AFkfs=FKFS_RMB then
    edtFkfs.Text := edtFkfs.Text + ' ' + CurrToStr(FYjxx.AYfje)+'Ԫ';

  chkYjtf.Visible := FYjxx.AFkfs=FKFS_RMB;
  edtTfje.Visible := chkYjtf.Visible;
end;

//�жϽ��ʷ���
procedure TYxjzForm.edtKfhExit(Sender: TObject);
begin
  inherited;
  if edtKfh.Text<>'' then
  begin
    if (HotelData.CheckKfzt(edtKfh.Text)=KFZT_BF) then
    begin
      FKfxx := HotelData.GetKfxx(edtKfh.Text);
      ShowYjxx;
    end
    else
    begin
      ShowInfo('�ÿͷ����ܽ��ʣ�');
      edtKfh.Text := '';
      edtKfh.SetFocus;
    end;
  end;
end;

procedure TYxjzForm.chkYjtfClick(Sender: TObject);
begin
  inherited;
  edtTfje.Enabled := chkYjtf.Checked;
  if edtTfje.Enabled  then edtTfje.SetFocus;
end;

procedure TYxjzForm.edtJzjeExit(Sender: TObject);
begin
  inherited;
  if edtJzje.Text<>'' then
    FJzje := StrToCurr(edtJzje.Text);
end;

procedure TYxjzForm.cmbXfxmExit(Sender: TObject);
begin
  inherited;
  FXmbh := HotelData.FindUserBh('XMDM','D_XMBH','D_XMMC',GetMc(cmbXfxm.Items[cmbXfxm.ItemIndex]));
  if FXmbh='' then
    cmbXfxm.SetFocus;
end;

end.
