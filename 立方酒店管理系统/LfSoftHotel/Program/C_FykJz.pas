{�����Ƶ����ϵͳ v1.0
 Copyright by CubicSoft
 program by ls.
 Date:20020301-20020601
 20020627 ����ע��
}
unit C_FykJz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C_StdJd, DosMove, StdCtrls, Buttons, ExtCtrls, Mask, Grids,
  DBGrids, C_Define, DB, DBTables;

type
  TFykJzForm = class(TStdJdForm)
    Label2: TLabel;
    edtJzrq: TMaskEdit;
    Label3: TLabel;
    edtJzsj: TMaskEdit;
    radJzfs: TRadioGroup;
    cmbJz: TComboBox;
    Label1: TLabel;
    lblXfje: TLabel;
    Label11: TLabel;
    lblYhje: TLabel;
    DBGrid1: TDBGrid;
    tblKrjz: TTable;
    dsKrjz: TDataSource;
    tblKrjzD_XFXM: TStringField;
    Label5: TLabel;
    lblJsje: TLabel;
    tblKrzd: TTable;
    btnPrint: TBitBtn;
    Bevel2: TBevel;
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
    tblYsk: TTable;
    procedure radJzfsClick(Sender: TObject);
    procedure edtJzrqExit(Sender: TObject);
    procedure edtJzsjExit(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure tblKrjzNewRecord(DataSet: TDataSet);
    procedure tblKrjzAfterPost(DataSet: TDataSet);
    procedure btnCancClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1ColEnter(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure tblKrjzD_XFJEValidate(Sender: TField);
    procedure tblKrjzD_YHJEValidate(Sender: TField);
    procedure tblKrjzD_XMBHValidate(Sender: TField);
    procedure cmbJzDblClick(Sender: TObject);
  private
    { Private declarations }
    FBmbh: string;
    FKey: string;
    FJzrq: TDateTime;
    FJzsj: TDateTime;
    FJzfs: string;
    FXykbh: string;
    FXfje: Currency;
    FYhje: Currency;
    FJsje: Currency;
    FJzbh: string;
    FKhbh: string;
    FHh: Integer;
    IsUpdate: Boolean;
    IsSum   : Boolean;
    function IsValid: Boolean;
    procedure ShowJzxx;
    procedure ShowZd;
    procedure SumXfje;
    procedure UpdateKrjz;
    procedure UpdateKrzd;
    procedure AddYjk(AGbkJzxx: TGbkJzxx);
    procedure UpdateYsk;
  public
    { Public declarations }
  end;

var
  FykJzForm: TFykJzForm;

procedure Fykjz;

implementation

uses C_HotelData, C_Sysprint, C_CardXf, C_KhdaSel;

{$R *.dfm}

//��Ԣ�ͽ���
procedure Fykjz;
begin
  FykjzForm := TFykjzForm.Create(Application);
  try
    with FykjzForm do
    begin
      //��ȡ���ű��
      FBmbh := HotelData.FindBh('YGDA','D_BMBH','D_YGBH',CZY.CzyBh);

      //��ʼ��
      edtJzrq.Text := FormatDateTime('yyyy-mm-dd',Date);
      edtJzsj.Text := FormatDateTime('hh:mm',Time);
      FJzrq        := Date;
      FJzsj        := Time;
      FJzfs        := JZFS_RMB;
      IsUpdate     := True;
      IsSum        := True;

      //���ʵ�
      ShowZd;
      ShowModal;
    end;
  finally
    FykjzForm.Free;
  end;
end;

//���ʵ�
procedure TFykJzForm.ShowZd;
begin
  //��ȡ���ʱ��
  FJzbh := HotelData.GetBh('D_JZBH',PREV_JZBH);

  tblKrjz.Filter   := 'D_JZBH='''+FJzbh+'''';
  tblKrjz.Filtered := True;
  try
    tblKrjz.Close;
    tblKrjz.Open;
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

  FHh := 1;
end;

//���ѽ��Żݽ��
procedure TFykJzForm.SumXfje;
var
  PrevRecord: TBookMark;
begin
  PrevRecord := tblKrjz.GetBookmark;
  try
    tblKrjz.DisableControls;
    FXfje := 0;
    FYhje := 0;
    tblKrjz.First;
    while not tblKrjz.Eof do
    begin
      FXfje := FXfje + tblKrjzD_XFJE.Value;
      FYhje := FYhje + tblKrjzD_YHJE.Value;
      tblKrjz.Next;
    end;
  finally
    tblKrjz.EnableControls;
    if PrevRecord<>nil then
    begin
      tblKrjz.GotoBookmark(PrevRecord);
      tblKrjz.FreeBookmark(PrevRecord);
    end;
    ShowJzxx;
  end;
end;

//��ʾ������Ϣ
procedure TFykJzForm.ShowJzxx;
begin
  //������
  FJsje := FXfje-FYhje;

  lblXfje.Caption := CurrToStr(FXfje)+'Ԫ';
  lblYhje.Caption := CurrToStr(FYhje)+'Ԫ';
  lblJsje.Caption := CurrToStr(FJsje)+'Ԫ';
end;

//ѡ����ʷ�ʽ
procedure TFykJzForm.radJzfsClick(Sender: TObject);
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
    3:
      begin
        cmbJz.Style := csDropDown;
        HotelData.ListDm(cmbJz,'KHDA','D_KHMC');
        FJzfs := JZFS_JZ;
      end;

    4: FJzfs := JZFS_GBK;
  end;
end;


procedure TFykJzForm.edtJzrqExit(Sender: TObject);
begin
  inherited;
  FJzrq := StrToDate(edtJzrq.Text);
end;

procedure TFykJzForm.edtJzsjExit(Sender: TObject);
begin
  inherited;
  FJzsj := StrToTime(edtJzsj.Text);
end;

//�����Ч��
function TFykjzForm.IsValid: Boolean;
var
  s : string;
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
    3:
      begin
        s := GetMc(cmbJz.Text);
        FKhbh := HotelData.FindBh('KHDA','D_KHBH','D_KHMC',s);
        if FKhbh<>'' then
          Result := True
        else
          ShowInfo('��ѡ����ʿͻ���');
      end;

    else
      Result := True;
  end;
end;

//��ӽ����ܵ� �к�=0
procedure TFykJzForm.UpdateKrjz;
begin
  IsUpdate := True;
  IsSum    := False;
  FHh      := 0;

  tblKrjz.Insert;
  tblKrjzD_XFJE.Value := FXfje;
  tblKrjzD_YHJE.Value := FYhje;
  tblKrjzD_JZFS.Value := FJzfs;
  tblKrjzD_XYKBH.Value:= FXykbh;
  tblKrjzD_JZRQ.Value := FJzrq;
  tblKrjzD_JZSJ.Value := FJzsj;
  tblKrjzD_CZYXM.Value:= CZY.CzyXm;
  tblKrjzD_BMBH.Value := FBmbh;
  tblKrjzD_BZ.Value   := JZBZ_FYK;
  tblKrjz.Post;
  //�޸Ľ�����Ϣ
  tblKrjz.First;
  while not tblKrjz.Eof do
  begin
    tblKrjz.Edit;
    tblKrjzD_JZFS.Value := FJzfs;
    tblKrjzD_XYKBH.Value:= FXykbh;
    tblKrjzD_JZRQ.Value := FJzrq;
    tblKrjzD_JZSJ.Value := FJzsj;
    tblKrjz.Post;
    tblKrjz.Next;
  end;
  IsUpdate := False;
  IsSum    := True;
end;

//����Ӧ�տ�
procedure TFykjzForm.UpdateYsk;
var
  AZdbh: string;
begin
  try
    try
      tblYsk.Open;
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
    AZdbh := HotelData.GetBh('D_ZDBH',PREV_ZDBH);
    tblKrjz.First;
    while not tblKrjz.Eof do
    begin
        tblYsk.Insert;
        tblYsk.FieldByName('D_KHBH').AsString   := FKhbh;
        tblYsk.FieldByName('D_ZDBH').AsString   := AZdbh;
        tblYsk.FieldByName('D_HH').AsInteger    := tblKrjzD_HH.Value;
        tblYsk.FieldByName('D_XMBH').AsString   := tblKrjzD_XMBH.Value;
        tblYsk.FieldByName('D_XFDJ').AsCurrency := 0;
        tblYsk.FieldByName('D_XFSL').AsFloat    := 1;
        tblYsk.FieldByName('D_XFJE').AsCurrency := tblKrjzD_XFJE.Value-tblKrjzD_YHJE.Value;
        tblYsk.FieldByName('D_XFRQ').AsDateTime := Date;
        tblYsk.FieldByName('D_XFSJ').AsDateTime := Time;
        tblYsk.FieldByName('D_CZYXM').AsString  := CZY.CzyXm;
        tblYsk.FieldByName('D_BZ').AsString     := ZDBZ_JZ+HotelData.FindMc('KHDA','D_KHBH','D_KHMC',FKhbh);
        tblYsk.Post;
      tblKrjz.Next;
    end;
  finally
    tblYsk.Close;
  end;
end;

//���¿����ʵ�
procedure TFykJzForm.UpdateKrzd;
var
  AZdbh: string;
begin
  if tblKrjz.IsEmpty then Exit;
  //��ȡ�ʵ����
  AZdbh := HotelData.GetBh('D_ZDBH',PREV_ZDBH);
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

    tblKrjz.DisableControls;
    tblKrjz.First;
    while not tblKrjz.Eof do
    begin
      tblKrzd.Insert;
      tblKrzd.FieldByName('D_ZDBH').AsString   := AZdbh;
      tblKrzd.FieldByName('D_HH').AsInteger    := tblKrjzD_HH.Value;
      tblKrzd.FieldByName('D_ZDLB').AsString   := ZDLB_FYK;
      tblKrzd.FieldByName('D_XMBH').AsString   := tblKrjzD_XMBH.Value;
      tblKrzd.FieldByName('D_XFJE').AsCurrency := tblKrjzD_XFJE.Value;
      tblKrzd.FieldByName('D_YHJE').AsCurrency := tblKrjzD_YHJE.Value;
      tblKrzd.FieldByName('D_XFRQ').AsDateTime := tblKrjzD_JZRQ.Value;
      tblKrzd.FieldByName('D_XFSJ').AsDateTime := tblKrjzD_JZSJ.Value;
      tblKrzd.FieldByName('D_JZRQ').AsDateTime := tblKrjzD_JZRQ.Value;
      tblKrzd.FieldByName('D_JZSJ').AsDateTime := tblKrjzD_JZSJ.Value;
      tblKrzd.FieldByName('D_JZBZ').AsString   := JZ_YES;
      tblKrzd.FieldByName('D_JSBZ').AsString   := JS_YES;
      tblKrzd.FieldByName('D_CZYXM').AsString  := CZY.CzyXm;
      tblKrzd.FieldByName('D_JZYXM').AsString  := CZY.CzyXm;
      tblKrzd.FieldByName('D_BMBH').AsString   := FBmbh;
      if FJzfs=JZFS_JZ then
        tblKrzd.FieldByName('D_BZ').AsString     := ZDBZ_FYK+' '+ZDBZ_JZ+' '+FKhbh
      else
        tblKrzd.FieldByName('D_BZ').AsString     := ZDBZ_FYK;
      tblKrzd.FieldByName('D_JZBH').AsString   := FJzbh;
      tblKrzd.Post;
      tblKrjz.Next;
    end;
  finally
    tblKrjz.EnableControls;
    tblKrzd.Close;
  end;
end;

//���Ԥ����
//���ʿ������Ԥ���� ���������
procedure TFYkjzForm.AddYjk(AGbkJzxx: TGbkJzxx);
var
  AYe,ACe: Currency;
  AXmbh: string;
begin
  IsUpdate := True;
  IsSum    := False;
  tblKrjzD_XMBH.OnValidate := nil;
  tblKrjzD_YHJE.OnValidate := nil;
  tblKrjzD_XFJE.OnValidate := nil;

  if (AGbkJzxx.AJzfs=JZFS_RMB)
   or(AGbkJzxx.AJzfs=JZFS_XYK)
   or(AGbkJzxx.AJzfs=JZFS_ZP )  then
  begin
    //��������ʣ�ʣ��Ľ��
    AYe := FJsje - AGbkJzxx.AKcje;
    tblKrjz.First;
    while not tblKrjz.Eof do
    begin
      if AYe = 0 then Break;
      //�������Ԥ����
      if tblKrjzD_XMBH.Value <> XMBH_YJK then
      begin
        //��������ڵ�ǰ���ѽ��޸ĵ�ǰ���ʷ�ʽ
        if AYe >= tblKrjzD_XFJE.Value then
        begin
          tblKrjz.Edit;
          tblKrjzD_JZFS.Value := AGbkJzxx.AJzfs;
          tblKrjzD_XYKBH.Value:= AGbkJzxx.AXykbh;
          AYe := AYe - tblKrjzD_XFJE.Value;
          tblKrjz.Post;
        end
        else //������С�ڵ�ǰ���ѽ��޸ĵ�ǰ���ѽ��Ϊ�����Ӳ��
        begin
          ACe   := tblKrjzD_XFJE.Value - AYe;
          AXmbh := tblKrjzD_XMBH.Value;

          tblKrjz.Edit;
          tblKrjzD_XFJE.Value := AYe;
          tblKrjzD_JZFS.Value := AGbkJzxx.AJzfs;
          tblKrjzD_XYKBH.Value:= AGbkJzxx.AXykbh;
          AYe := AYe - tblKrjzD_XFJE.Value;
          tblKrjz.Post;
          tblKrjz.Insert;
          tblKrjzD_XMBH.Value := AXmbh;
          tblKrjzD_XFJE.Value := ACe;
          tblKrjzD_YJJE.Value := 0;
          tblKrjzD_YHJE.Value := 0;
          tblKrjz.Post;
        end;
      end;
      tblKrjz.Next;
    end;
  end;
  tblKrjz.Insert;
  tblKrjzD_XMBH.Value := XMBH_YJK;
  tblKrjzD_XFJE.Value := 0-AGbkJzxx.AKcje;
  tblKrjzD_YJJE.Value := 0;
  tblKrjzD_YHJE.Value := 0;
  tblKrjz.Post;
  tblKrjzD_XMBH.OnValidate := tblKrjzD_XMBHValidate;
  tblKrjzD_YHJE.OnValidate := tblKrjzD_YHJEValidate;
  tblKrjzD_XFJE.OnValidate := tblKrjzD_XFJEValidate;
  IsUpdate := False;
  IsSum    := True;
end;

//����ȷ��
procedure TFykJzForm.btnOKClick(Sender: TObject);
var
  AGbkJzxx: TGbkJzxx;
begin
  inherited;
  //�ж���Ч��
  if not IsValid then Exit;

  if tblKrjz.IsEmpty then
  begin
    ShowInfo('��¼��������Ŀ��');
    Exit;
  end;
  if not Confirm('��ȷ�ϸÿ��˵����ѽ�����') then
    Exit;
  if tblKrjz.State in [dsInsert,dsEdit] then
  begin
    if tblKrjzD_XMBH.Value = '' then
      tblKrjz.Cancel
    else
      tblKrjz.Post;
  end;
  //��������
  tblKrjz.DisableControls;
  HotelData.DatabaseUser.StartTransaction;
  try

    //������ʷ�ʽ�ǹ����
    if FJzfs=JZFS_GBK then
    begin
      AGbkJzxx := CardXf(FJsje,False);
      if AGbkJzxx.AKcje = 0 then
      begin
        HotelData.DatabaseUser.Rollback;
        Exit;
      end;
      AddYjk(AGbkJzxx);
      UpdateKrjz;
      UpdateKrzd;
    end;
    //������ʷ�ʽ������ҡ����ÿ���֧Ʊ
    if (FJzfs=JZFS_RMB)or(FJzfs=JZFS_XYK)or(FJzfs=JZFS_ZP) then
    begin
      UpdateKrjz;
      UpdateKrzd;
    end;
    //������ʷ�ʽ�Ǽ���
    if FJzfs=JZFS_JZ then
    begin
      UpdateKrzd;
      UpdateYsk;
      tblKrjz.CancelUpdates;
    end;
    tblKrjz.ApplyUpdates;
    tblKrjz.CommitUpdates;


    //�����ύ
    HotelData.DatabaseUser.Commit;
  except
    //����ع�
    HotelData.DatabaseUser.Rollback;
    raise;
  end;

  {if Confirm('�Ƿ��ӡ�ʵ���') then
    btnPrintClick(nil);}

  tblKrjz.EnableControls;
      //��ʼ��
      edtJzrq.Text := FormatDateTime('yyyy-mm-dd',Date);
      edtJzsj.Text := FormatDateTime('hh:mm',Time);
      FJzrq        := Date;
      FJzsj        := Time;
      FJzfs        := JZFS_RMB;
      IsUpdate     := True;
      IsSum        := True;
      radJzfs.ItemIndex := 0;
      cmbJz.Items.Clear;
      edtJzrq.SetFocus;
      lblXfje.Caption := '0Ԫ';
      lblYhje.Caption := '0Ԫ';
      lblJsje.Caption := '0Ԫ';
      ShowZd;
  //Close;
end;

procedure TFykJzForm.tblKrjzNewRecord(DataSet: TDataSet);
begin
  inherited;
  tblKrjzD_JZBH.Value := FJzbh;
  tblKrjzD_HH.Value   := FHh;
  tblKrjzD_JZLX.Value := JZLX_FYK;
  tblKrjzD_CZYXM.Value:= CZY.CzyXm;
  tblKrjzD_BMBH.Value := FBmbh;
  tblKrjzD_BZ.Value   := JZBZ_FYK;
  tblKrjzD_JZRQ.Value := Date;
  tblKrjzD_JZSJ.Value := Now;
end;

procedure TFykJzForm.tblKrjzAfterPost(DataSet: TDataSet);
begin
  inherited;
  if IsUpdate then Inc(FHh);
  if IsSum then  SumXfje;
end;

//ȡ��
procedure TFykJzForm.btnCancClick(Sender: TObject);
begin
  inherited;
  tblKrjz.CancelUpdates;
end;

procedure TFykJzForm.DBGrid1KeyPress(Sender: TObject; var Key: Char);
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
        tblKrjz.Edit;
        tblKrjzD_XMBH.Value := HotelData.tblXMDM.FieldByName('D_XMBH').AsString;
      end;
    end;
  end;
end;

procedure TFykJzForm.DBGrid1ColEnter(Sender: TObject);
begin
  inherited;
  if DBGrid1.SelectedIndex=0 then FKey := '';
end;

procedure TFykJzForm.btnPrintClick(Sender: TObject);
var
  APrintStru: TPrintStru;
begin
  APrintStru.ATitle := '�ʵ������ʷ�ʽ��'+FJzfs+'��';
  APrintStru.ASub := '���ѽ�'+lblXfje.Caption+' '
                    +'�����'+lblJsje.Caption+' '
                    +'�Żݽ�'+lblYhje.Caption+' ';

  APrintStru.ADataSet := tblKrjz;
  PrintLb(APrintStru,DBGrid1);
end;

procedure TFykJzForm.tblKrjzD_XFJEValidate(Sender: TField);
begin
  inherited;
  if tblKrjzD_XFJE.IsNull or (tblKrjzD_XFJE.Value<=0) then
    raise Exception.Create('�����������Ľ��');
end;

procedure TFykJzForm.tblKrjzD_YHJEValidate(Sender: TField);
begin
  inherited;
  if tblKrjzD_YHJE.Value < 0 then
    raise Exception.Create('�Żݽ���С���㣡');
end;

procedure TFykJzForm.tblKrjzD_XMBHValidate(Sender: TField);
begin
  inherited;
  if tblKrjzD_XMBH.Value = XMBH_YJK then
  raise Exception.Create('Ԥ����ܽ��ˣ�');
  if tblKrjzD_XMBH.Value = XMBH_CF then
    raise Exception.Create('���ڲ�������ϵͳ->�ǲͷѽ�����¼��');

end;

procedure TFykJzForm.cmbJzDblClick(Sender: TObject);
begin
  inherited;
  if FJzfs = JZFS_JZ then
    cmbJz.Text := KhdaSel1; 
end;

end.
