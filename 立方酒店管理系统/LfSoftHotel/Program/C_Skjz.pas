{�����Ƶ����ϵͳ v1.0
 Copyright by CubicSoft
 program by ls.
 Date:20020301-20020601
 20020627 ����ע��
}
unit C_Skjz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C_StdJd, DosMove, StdCtrls, Buttons, ExtCtrls, Mask, DB,
  DBTables, C_Define;

type
  TSkjzForm = class(TStdJdForm)
    edtKfh: TLabeledEdit;
    btnInsert: TBitBtn;
    ListBox1: TListBox;
    Label1: TLabel;
    edtJzrq: TMaskEdit;
    edtJzsj: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    radJzfs: TRadioGroup;
    cmbJz: TComboBox;
    chkYjtf: TCheckBox;
    Bevel2: TBevel;
    tblKfzt: TTable;
    tblKrxx: TTable;
    Label4: TLabel;
    ListBox2: TListBox;
    procedure radJzfsClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtJzrqExit(Sender: TObject);
    procedure edtJzsjExit(Sender: TObject);
    procedure chkYjtfClick(Sender: TObject);
    procedure cmbJzDblClick(Sender: TObject);
  private
    { Private declarations }
    FJzfs: string;
    FXykbh: string;
    FKhbh: string;
    FKrbh: string;
    FKfbh: string;
    FYjtf: Boolean;
    FJzrq: TDateTime;
    FJzsj: TDateTime;
    FJzxx: TJZXX;
    procedure GetTdmc;
    function IsValid: Boolean;
  public
    { Public declarations }
  end;

var
  SkjzForm: TSkjzForm;

function Skjz: TJZXX;
function SkjzEnter(const AKfbh: string): TJZXX;

implementation

uses C_HotelData, C_KhdaSel, C_Zd;

{$R *.dfm}

//ɢ�ͽ���
function Skjz: TJZXX;
begin
  SkjzForm := TSkjzForm.Create(Application);
  try
    with SkjzForm do
    begin

      //��ʼ��
      edtJzrq.Text := FormatDateTime('yyyy-mm-dd',Date);
      edtJzsj.Text := FormatDateTime('hh:mm',Time);
      FJzrq := Date;
      FJzsj := Time;
      FJzfs := JZFS_RMB;
      FYjtf := True;

      try
        tblKfzt.Open;
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

      ShowModal;
      if ModalResult = mrOK then
        FJzxx.AJzfs := '';
      Result := FJzxx;
    end;
  finally
    SkjzForm.tblKfzt.Close;
    SkjzForm.tblKrxx.Close;
    SkjzForm.Free;
  end;
end;

//ɢ�ͽ���
function SkjzEnter(const AKfbh: string): TJZXX;
begin
  SkjzForm := TSkjzForm.Create(Application);
  try
    with SkjzForm do
    begin
      if (HotelData.CheckKfzt(AKfbh)=KFZT_BF) then
      begin
        ListBox1.Items.Add(AKfbh);
        ListBox2.Items.Add(HotelData.FindMc('KFZT','D_KFBH','D_KRXM',aKfbh));
      end
      else
        raise Exception.Create('�ÿͷ����ܽ��ʣ���ˢ�·�̬��');

      //��ʼ��
      edtJzrq.Text := FormatDateTime('yyyy-mm-dd',Date);
      edtJzsj.Text := FormatDateTime('hh:mm',Time);
      FJzrq := Date;
      FJzsj := Time;
      FJzfs := JZFS_RMB;
      FYjtf := True;

      try
        tblKfzt.Open;
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

      ShowModal;
      if ModalResult = mrOK then
        FJzxx.AJzfs := '';
      Result := FJzxx;
    end;
  finally
    SkjzForm.tblKfzt.Close;
    SkjzForm.tblKrxx.Close;
    SkjzForm.Free;
  end;
end;

//����Ŷ�����
procedure TSkjzForm.GetTdmc;
begin
  tblKrxx.Filter   := 'D_KRLX=''T''';
  tblKrxx.Filtered := True;
  tblKrxx.First;
  while not tblKrxx.Eof do
  begin
    cmbJz.Items.Add(tblKrxx.FieldByName('D_KRXM').AsString);
    tblKrxx.Next;
  end;
  tblKrxx.Filter   := '';
  tblKrxx.Filtered := False;
end;

//����Ƿ�ѡ����Ч
function TSkjzForm.IsValid: Boolean;
var
  s: string;
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
    4:
      begin
        if HotelData.CheckKfzt(cmbJz.Text)=KFZT_BF then
        begin
          FKfbh := cmbJz.Text;
          if ListBox1.Items.IndexOf(FKfbh)<0 then
            Result := True
          else
            ShowInfo('�ÿͷ����ڽ��ʣ�');
        end
        else
          ShowInfo('��ѡ�����ɢ�ͣ�');
      end;
    5:
      begin
        if tblKrxx.Locate('D_KRXM',cmbJz.Text,[]) then
        begin
          FKrbh := tblKrxx.FieldByName('D_KRBH').AsString;
          Result := True;
        end
        else
          ShowInfo('��ѡ������Ŷӣ�');
      end;
    else
      Result := True;
  end;
end;

//ѡ����ʷ�ʽ
procedure TSkjzForm.radJzfsClick(Sender: TObject);
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
    4:
      begin
        cmbJz.Style := csDropDown;
        FJzfs := JZFS_GSK;
      end;
    5:
      begin
        GetTdmc;
        FJzfs := JZFS_GTD;
      end;
    6: FJzfs := JZFS_WJZ;
    7: FJzfs := JZFS_GBK;
  end;

  //�Ƿ�Ѻ���˸�
  chkYjtf.Visible := (radJzfs.ItemIndex=4)or(radJzfs.ItemIndex=5);
end;

//������ʷ���
procedure TSkjzForm.btnInsertClick(Sender: TObject);
begin
  inherited;
  if edtKfh.Text<>'' then
  begin
    if (HotelData.CheckKfzt(edtKfh.Text)=KFZT_BF)
      and(ListBox1.Items.IndexOf(edtKfh.Text)<0) then
    begin
      ListBox1.Items.Add(edtKfh.Text);
      ListBox2.Items.Add(HotelData.FindMc('KFZT','D_KFBH','D_KRXM',edtKfh.Text));
    end
    else
      ShowInfo('�ÿͷ����ܽ��ʣ�');

    edtKfh.Text := '';
    edtKfh.SetFocus;
  end;
end;

//ȷ��
procedure TSkjzForm.btnOKClick(Sender: TObject);
var
  I: Integer;
begin
  inherited;

  //���û��ѡ����ʷ���
  if ListBox1.Items.Count < 1 then
    raise Exception.Create('����ӽ��ʷ��ţ�');

  //�����Ч
  if not IsValid then Exit;

  //���ý��ʷ�����Ϣ
  SetLength(FJzxx.AJzfh,ListBox1.Items.Count);
  for I:=0 to ListBox1.Items.Count - 1 do
    FJzxx.AJzfh[I] := ListBox1.Items[I];

  FJzxx.AJzrq := FJzrq;
  FJzxx.AJzsj := FJzsj;
  FJzxx.AJzfs := FJzfs;
  FJzxx.AXykbh:= FXykbh;
  FJzxx.AKhbh := FKhbh;
  FJzxx.AKfbh := FKfbh;
  FJzxx.AKrbh := FKrbh;
  FJzxx.AYjtf := FYjtf;

  //edit by ls 20021102��������

  Zd(FJzxx);
  //��ʼ��
  edtJzrq.Text := FormatDateTime('yyyy-mm-dd',Date);
  edtJzsj.Text := FormatDateTime('hh:mm',Time);
  FJzrq := Date;
  FJzsj := Time;
  FJzfs := JZFS_RMB;
  FYjtf := True;
  radJzfs.ItemIndex := 0;
  ListBox1.Items.Clear;
  ListBox2.Items.Clear;
  cmbJz.Items.Clear;
  edtKfh.SetFocus;
  //Close;
end;

procedure TSkjzForm.edtJzrqExit(Sender: TObject);
begin
  inherited;
  FJzrq := StrToDate(edtJzrq.Text);
end;

procedure TSkjzForm.edtJzsjExit(Sender: TObject);
begin
  inherited;
  FJzsj := StrToTime(edtJzsj.Text);
end;

procedure TSkjzForm.chkYjtfClick(Sender: TObject);
begin
  inherited;
  FYjtf := chkYjtf.Checked;
end;

procedure TSkjzForm.cmbJzDblClick(Sender: TObject);
begin
  inherited;
  if FJzfs = JZFS_JZ then
    cmbJz.Text := KhdaSel1;
end;

end.
