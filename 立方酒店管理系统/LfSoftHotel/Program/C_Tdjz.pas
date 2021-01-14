{�����Ƶ����ϵͳ v1.0
 Copyright by CubicSoft
 program by ls.
 Date:20020301-20020601
 20020627 ����ע��
}
unit C_Tdjz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C_StdJd, DosMove, StdCtrls, Buttons, ExtCtrls, Mask, C_Define;

type
  TTdjzForm = class(TStdJdForm)
    Label2: TLabel;
    edtJzrq: TMaskEdit;
    Label3: TLabel;
    edtJzsj: TMaskEdit;
    radJzfs: TRadioGroup;
    Label4: TLabel;
    cmbJz: TComboBox;
    procedure edtJzrqExit(Sender: TObject);
    procedure edtJzsjExit(Sender: TObject);
    procedure radJzfsClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure cmbJzDblClick(Sender: TObject);
  private
    { Private declarations }
    FKrbh: string;
    FJzrq: TDateTime;
    FJzsj: TDateTime;
    FJzxx: TTdJzxx;
    FTdxx: TTdxx;
    FJzfs: string;
    FXykbh:string;
    FKhbh: string;
    function IsValid: Boolean;
  public
    { Public declarations }
  end;

var
  TdjzForm: TTdjzForm;

function Tdjz(const AKrbh: string): TTdJzxx;

implementation

uses C_HotelData, C_KhdaSel;

{$R *.dfm}

//�Ŷӽ���
function Tdjz(const AKrbh: string): TTdJzxx;
begin
  TdjzForm := TTdjzForm.Create(Application);
  try
    with TdjzForm do
    begin
      //�ж��Ƿ�ȫ���˷�
      if HotelData.IsTdtf(AKrbh) then
      begin
        ShowInfo('�����˷��ٽ��ʣ�');
        Exit;
      end;

      //��ȡ�Ŷ���Ϣ
      FKrbh := AKrbh;
      FTdxx := HotelData.GetTdxx(AKrbh);

      //��ʼ��
      edtJzrq.Text := FormatDateTime('yyyy-mm-dd',Date);
      edtJzsj.Text := FormatDateTime('hh:mm',Time);
      FJzrq := Date;
      FJzsj := Time;
      FJzfs := JZFS_RMB;

      ShowModal;
      if ModalResult = mrOK then
        FJzxx.AJzfs := '';
      Result := FJzxx;
    end;
  finally
    TdjzForm.Free;
  end;
end;

//�ж���Ч��
function TTdjzForm.IsValid: Boolean;
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
    else
      Result := True;
  end;
end;

procedure TTdjzForm.edtJzrqExit(Sender: TObject);
begin
  inherited;
  FJzrq := StrToDate(edtJzrq.Text);
end;

procedure TTdjzForm.edtJzsjExit(Sender: TObject);
begin
  inherited;
  FJzsj := StrToTime(edtJzsj.Text);
end;

//ѡ����ʷ�ʽ
procedure TTdjzForm.radJzfsClick(Sender: TObject);
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
        HotelData.ListDm(cmbJz,'KHDA','D_KHMC');
        FJzfs := JZFS_JZ;
      end;
    4: FJzfs := JZFS_GBK;
  end;
end;

//ȷ��
procedure TTdjzForm.btnOKClick(Sender: TObject);
begin
  inherited;
  if not IsValid then Exit;

  //��ȡ������Ϣ
  FJzxx.AJzrq := FJzrq;
  FJzxx.AJzsj := FJzsj;
  FJzxx.AJzfs := FJzfs;
  FJzxx.AXykbh:= FXykbh;
  FJzxx.AKhbh := FKhbh;
  FJzxx.AKrbh := FTdxx.AKrbh;
  FJzxx.AZdbh := FTdxx.AZdbh;
  FJzxx.AYjbh := FTdxx.AYjbh;
  FJzxx.AKrxm := FTdxx.AKrxm;
  Close;
end;

procedure TTdjzForm.cmbJzDblClick(Sender: TObject);
begin
  inherited;
  if FJzfs = JZFS_JZ then
    cmbJz.Text := KhdaSel1;
end;

end.
