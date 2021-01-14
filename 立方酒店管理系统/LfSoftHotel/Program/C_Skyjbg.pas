{�����Ƶ����ϵͳ v1.0
 Copyright by CubicSoft
 program by ls.
 Date:20020301-20020601
 20020627 ����ע��
}
unit C_Skyjbg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C_StdJd, DosMove, StdCtrls, Buttons, ExtCtrls, Mask, C_Define,
  DB, DBTables;

type
  TSkyjbgForm = class(TStdJdForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtJzrq: TMaskEdit;
    edtJzsj: TMaskEdit;
    radJzfs: TRadioGroup;
    cmbJz: TComboBox;
    edtKfh: TLabeledEdit;
    edtFkfs: TLabeledEdit;
    tblKryj: TTable;
    edtYfje: TLabeledEdit;
    edtTdmc: TLabeledEdit;
    tblKryjD_YJBH: TStringField;
    tblKryjD_HH: TIntegerField;
    tblKryjD_FKFS: TStringField;
    tblKryjD_XYKBH: TStringField;
    tblKryjD_KHBH: TStringField;
    tblKryjD_YFJE: TFloatField;
    tblKryjD_YFRQ: TDateTimeField;
    tblKryjD_YFSJ: TDateTimeField;
    tblKryjD_BZ: TStringField;
    procedure radJzfsClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtKfhExit(Sender: TObject);
    procedure edtJzrqExit(Sender: TObject);
    procedure edtJzsjExit(Sender: TObject);
    procedure edtYfjeExit(Sender: TObject);
    procedure edtKfhKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FJzfs: string;
    FXykbh: string;
    FKhbh: string;
    FYjxx: TYjxx;
    FKfxx: TKfxx;
    FJzrq: TDateTime;
    FJzsj: TDateTime;
    FYjbh: string;
    FYfje: Currency;
    FTdxx: TTdxx;
    function IsValid: Boolean;
    procedure ShowYjxx;
    procedure UpdateKryj;
  public
    { Public declarations }
  end;

var
  SkyjbgForm: TSkyjbgForm;

procedure Skyjbg;
procedure Tdyjbg(const AKrbh: string);

implementation

uses C_HotelData;

{$R *.dfm}

//ɢ��Ѻ����
procedure Skyjbg;
begin
  SkyjbgForm := TSkyjbgForm.Create(Application);
  try
    with SkyjbgForm do
    begin
      //��ʼ��
      edtJzrq.Text := FormatDateTime('yyyy-mm-dd',Date);
      edtJzsj.Text := FormatDateTime('hh:mm',Time);
      FJzrq := Date;
      FJzsj := Time;
      FJzfs := JZFS_RMB;
      FYfje := 0;

      ShowModal;
    end;
  finally
    SkyjbgForm.Free;
  end;
end;

//�Ŷ�Ѻ����
procedure Tdyjbg(const AKrbh: string);
begin
  SkyjbgForm := TSkyjbgForm.Create(Application);
  try
    with SkyjbgForm do
    begin
      edtKfh.Visible  := False;
      edtTdmc.Visible := True;

      //��ȡ�Ŷ���Ϣ
      FTdxx           := HotelData.GetTdxx(AKrbh);
      edtTdmc.Text := FTdxx.AKrxm;
      FYjbh           := FTdxx.AYjbh;

      //��ʾѺ����Ϣ
      ShowYjxx;

      //��ʼ��
      edtJzrq.Text := FormatDateTime('yyyy-mm-dd',Date);
      edtJzsj.Text := FormatDateTime('hh:mm',Time);
      FJzrq        := Date;
      FJzsj        := Time;
      FJzfs        := JZFS_RMB;
      FYfje        := 0;

      ShowModal;
    end;
  finally
    SkyjbgForm.Free;
  end;
end;

//��ʾѺ����Ϣ
procedure TSkyjbgForm.ShowYjxx;
begin
  FYjxx        := HotelData.GetYjxx(FYjbh);
  edtFkfs.Text := FYjxx.AFkfs;

  if FYjxx.AFkfs=FKFS_RMB then
    edtFkfs.Text := edtFkfs.Text + ' ' + CurrToStr(FYjxx.AYfje)+'Ԫ';
end;

//Ѻ��ʽ���
procedure TSkyjbgForm.radJzfsClick(Sender: TObject);
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
        HotelData.ListDM(cmbJz,'KHDA','D_KHMC');
        FJzfs := JZFS_JZ;
      end;
  end;
end;

//����Ѻ����Ϣ
procedure TSkyjbgForm.UpdateKryj;
begin
  try
    try
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

    tblKryj.Filter   := 'D_YJBH='''+FYjbh+'''';
    tblKryj.Filtered := True;

    tblKryj.First;
    while not tblKryj.Eof do
      tblKryj.Delete;

    tblKryj.Insert;
    tblKryjD_YJBH.Value := FYjbh;
    tblKryjD_HH.Value   := 0;
    tblKryjD_FKFS.Value := FJzfs;
    tblKryjD_YFJE.Value := FYfje;
    tblKryjD_XYKBH.Value:= FXykbh;
    tblKryjD_KHBH.Value := FKhbh;
    tblKryjD_YFRQ.Value := FJzrq;
    tblKryjD_YFSJ.Value := FJzsj;
    tblKryjD_BZ.Value   := YJBZ_BG;
    tblKryj.Post;

  finally
    tblKryj.Filter   := '';
    tblKryj.Filtered := False;
    tblKryj.Close;
  end;
end;

//�Ƿ���Ч
function TSkyjbgForm.IsValid: Boolean;
var
  s: string;
begin
  Result := False;
  case radJzfs.ItemIndex of
    0:
      begin
        if edtYfje.Text <> '' then
          Result := True
        else
          ShowInfo('������Ԥ����');
      end;
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

  if FJzfs=FYjxx.AFkfs then
  begin
    Result := False;
    ShowInfo('��û�б��Ѻ��ʽ��');
  end;

end;

//ȷ��
procedure TSkyjbgForm.btnOKClick(Sender: TObject);
begin
  inherited;

  if (edtKfh.Visible)and(edtKfh.Text='') then
  begin
    ShowWarning('��ѡ����Ҫ���Ѻ��ʽ�Ŀͷ��ţ�');
    Exit;
  end;

  if not IsValid then Exit;
  if not Confirm('��ȷ��Ѻ������') then Exit;
  if edtYfje.Text <> '' then
    FYfje := StrToCurr(edtYfje.Text);

  //��������
  HotelData.DatabaseUser.StartTransaction;
  try
    UpdateKryj;

    //�����ύ
    HotelData.DatabaseUser.Commit;
  except
    //����ع�
    HotelData.DatabaseUser.Rollback;
    raise;
  end;

  Close;
end;

procedure TSkyjbgForm.edtKfhExit(Sender: TObject);
begin
  inherited;
  if edtKfh.Text<>'' then
  begin
    if (HotelData.CheckKfzt(edtKfh.Text)=KFZT_BF) then
    begin
      FKfxx := HotelData.GetKfxx(edtKfh.Text);
      FYjbh := FKfxx.AYjbh;
      ShowYjxx;
    end
    else
    begin
      ShowInfo('�ÿͷ����ܱ����');
      edtKfh.Text := '';
      edtKfh.SetFocus;
    end;
  end;
end;

procedure TSkyjbgForm.edtJzrqExit(Sender: TObject);
begin
  inherited;
  FJzrq := StrToDate(edtJzrq.Text);
end;

procedure TSkyjbgForm.edtJzsjExit(Sender: TObject);
begin
  inherited;
  FJzsj := StrToTime(edtJzsj.Text);
end;

procedure TSkyjbgForm.edtYfjeExit(Sender: TObject);
begin
  inherited;
  if edtYfje.Text<>'' then
    FYfje := StrToCurr(edtYfje.Text);
end;

procedure TSkyjbgForm.edtKfhKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (not(Key in ['0'..'9']))and(Ord(Key)<>VK_BACK) then
  begin
    Key := #0;
    Beep;
  end;
end;

end.
