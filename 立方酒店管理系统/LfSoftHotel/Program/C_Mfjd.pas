{�����Ƶ����ϵͳ v1.0
 Copyright by CubicSoft
 program by ls.
 Date:20020301-20020601
 20020627 ����ע��
}
unit C_Mfjd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C_StdJd, DosMove, StdCtrls, Buttons, ExtCtrls, DB, DBTables,
  Mask, DBCtrls;

type
  TMfjdForm = class(TStdJdForm)
    tblKrxx: TTable;
    dsKrxx: TDataSource;
    tblKfzt: TTable;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    edtFjh: TEdit;
    tblKrxxD_KRBH: TStringField;
    tblKrxxD_KRXM: TStringField;
    tblKrxxD_KRLX: TStringField;
    tblKrxxD_DDRQ: TDateTimeField;
    tblKrxxD_DDSJ: TDateTimeField;
    tblKrxxD_LDRQ: TDateTimeField;
    tblKrxxD_LDSJ: TDateTimeField;
    tblKrxxD_YWX: TStringField;
    tblKrxxD_YWM: TStringField;
    tblKrxxD_XB: TStringField;
    tblKrxxD_MZBH: TStringField;
    tblKrxxD_DQBH: TStringField;
    tblKrxxD_GBBH: TStringField;
    tblKrxxD_NZTS: TIntegerField;
    tblKrxxD_TLSY: TStringField;
    tblKrxxD_ZJBH: TStringField;
    tblKrxxD_ZJHM: TStringField;
    tblKrxxD_CSNY: TDateTimeField;
    tblKrxxD_HCL: TStringField;
    tblKrxxD_HCQ: TStringField;
    tblKrxxD_QZBH: TStringField;
    tblKrxxD_QZYXQ: TDateTimeField;
    tblKrxxD_ZY: TStringField;
    tblKrxxD_LXDH: TStringField;
    tblKrxxD_DWMC: TStringField;
    tblKrxxD_JTDZ: TStringField;
    tblKrxxD_JDR: TStringField;
    tblKrxxD_JDDW: TStringField;
    tblKrxxD_BZ: TStringField;
    tblKfztD_KFBH: TStringField;
    tblKfztD_ZDBH: TStringField;
    tblKfztD_KRBH: TStringField;
    tblKfztD_YJBH: TStringField;
    tblKfztD_SJFJ: TFloatField;
    tblKfztD_KFZT: TStringField;
    tblKfztD_KFBZ: TStringField;
    tblKfztD_KRSL: TIntegerField;
    tblKfztD_DHKT: TStringField;
    tblKfztD_BZFJ: TFloatField;
    tblKfztD_CWS: TIntegerField;
    tblKfztD_BJS: TIntegerField;
    tblKfztD_QJS: TIntegerField;
    tblKfztD_JJFJ: TFloatField;
    tblKfztD_FXBH: TStringField;
    tblKfztD_LCBH: TStringField;
    tblKfztD_KRXM: TStringField;
    procedure btnCancClick(Sender: TObject);
    procedure tblKrxxNewRecord(DataSet: TDataSet);
    procedure btnOKClick(Sender: TObject);
    procedure edtFjhExit(Sender: TObject);
    procedure tblKrxxBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    FKrbh: string;
    procedure UpdateKfzt;
  public
    { Public declarations }
  end;

var
  MfjdForm: TMfjdForm;

procedure Mfjd;
procedure MfjdEnter(const AKfbh: string);

implementation

uses C_Define, C_HotelData;

{$R *.dfm}

//��ѽӴ�
procedure Mfjd;
begin
  MfjdForm := TMfjdForm.Create(Application);
  try
    with MfjdForm do
    begin
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

      tblKrxx.Insert;
      ShowModal;
    end;
  finally
    MfjdForm.tblKrxx.Close;
    MfjdForm.Free;
  end;
end;

//��ѽӴ�
procedure MfjdEnter(const AKfbh: string);
begin

  if (HotelData.CheckKfzt(AKfbh)<>KFZT_OK) then
    raise Exception.Create('�ÿͷ����ǿշ�����ˢ�·�̬��');

  MfjdForm := TMfjdForm.Create(Application);
  try
    with MfjdForm do
    begin
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

      tblKrxx.Insert;
      edtFjh.Text := AKfbh;
      ShowModal;
    end;
  finally
    MfjdForm.tblKrxx.Close;
    MfjdForm.Free;
  end;
end;

//���¿ͷ�״̬
procedure TMfjdForm.UpdateKfzt;
begin
  try

    try
      tblKfzt.Open;
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

    if tblKfzt.FindKey([edtFjh.Text]) then
    begin
      tblKfzt.Edit;
      tblKfztD_KFZT.Value := KFZT_MF;
      tblKfztD_KRBH.Value := FKrbh;
      tblKfztD_KRXM.Value := tblKrxxD_KRXM.Value;
      tblKfzt.Post;
    end;
  finally
    tblKfzt.Close;
  end;
end;

//ȡ��
procedure TMfjdForm.btnCancClick(Sender: TObject);
begin
  inherited;
  tblKrxx.CancelUpdates;
end;

procedure TMfjdForm.tblKrxxNewRecord(DataSet: TDataSet);
begin
  inherited;
  tblKrxxD_KRLX.Value := KRLX_MF;
  tblKrxxD_DDRQ.Value := Date;
  tblKrxxD_DDSJ.Value := Time;
end;

//ȷ��
procedure TMfjdForm.btnOKClick(Sender: TObject);
begin
  inherited;
  if edtFjh.Text = '' then
    raise Exception.Create('�����뷿��ţ�');

  tblKrxx.Post;
  //��������
  HotelData.DatabaseUser.StartTransaction;
  try
    tblKrxx.ApplyUpdates;
    //���¿ͷ�״̬
    UpdateKfzt;

    //�����ύ
    HotelData.DatabaseUser.Commit;
  except
    //����ع�
    HotelData.DatabaseUser.Rollback;
    raise;
  end;
  tblKrxx.CommitUpdates;
  Close;
end;

//���ͷ���Ч��
procedure TMfjdForm.edtFjhExit(Sender: TObject);
begin
  inherited;
  if edtFjh.Text<>'' then
  begin
    if HotelData.CheckKfzt(edtFjh.Text)<>KFZT_OK then
    begin
      ShowWarning('��ѡ���������䣡');
      edtFjh.SetFocus;
    end;
  end;
end;

//��ȡ���˱��
procedure TMfjdForm.tblKrxxBeforePost(DataSet: TDataSet);
begin
  inherited;
  FKrbh := HotelData.GetBh('D_KRBH',PREV_KRBH);
  tblKrxxD_KRBH.Value := FKrbh;
end;

end.
