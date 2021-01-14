{�����Ƶ����ϵͳ v1.0
 Copyright by CubicSoft
 program by ls.
 Date:20020301-20020601
 20020627 ����ע��
}
unit C_Skqx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C_StdJd, DosMove, StdCtrls, Buttons, ExtCtrls, DB, DBTables, C_Define;

type
  TSkqxForm = class(TStdJdForm)
    edtKfh: TLabeledEdit;
    edtFkfs: TLabeledEdit;
    lblKrxm: TLabel;
    Edit1: TEdit;
    tblBqj: TTable;
    procedure edtKfhExit(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
    FKfxx: TKFXX;
    FYjxx: TYjxx;
    procedure ShowYjxx;
  public
    { Public declarations }
  end;

var
  SkqxForm: TSkqxForm;

procedure Skqx;

implementation

uses C_HotelData;

{$R *.dfm}

//ɢ��ȡ���ͷ�
procedure Skqx;
begin
  if CZY.CzyXm <> '������' then Exit;
  SkqxForm := TSkqxForm.Create(Application);
  try
    with SkqxForm do
    begin
      ShowModal;
    end;
  finally
    SkqxForm.Free;
  end;
end;

//��ʾѺ����Ϣ
procedure TSkqxForm.ShowYjxx;
begin
  FYjxx := HotelData.GetYjxx(FKfxx.AYjbh);

  edtFkfs.Text := FYjxx.AFkfs;
  if FYjxx.AFkfs=FKFS_RMB then
    edtFkfs.Text := edtFkfs.Text + ' ' + CurrToStr(FYjxx.AYfje)+'Ԫ';
end;

procedure TSkqxForm.edtKfhExit(Sender: TObject);
begin
  inherited;
  if edtKfh.Text<>'' then
  begin
    if (HotelData.CheckKfzt(edtKfh.Text)=KFZT_BF) then
    begin
      FKfxx := HotelData.GetKfxx(edtKfh.Text);
      Edit1.Text := FKfxx.AKrxm;
      ShowYjxx;
    end
    else
    begin
      ShowInfo('�ÿͷ�����ȡ����');
      edtKfh.Text := '';
      edtKfh.SetFocus;
    end;
  end;
end;

//ȷ��
procedure TSkqxForm.btnOKClick(Sender: TObject);
var
  s: string;
begin
  inherited;
  //edit by ls .20021120
  if edtKfh.Text = '' then
  begin
    ShowMessage('�����뷿��ţ�');
    Exit;
  end;
  if FKfxx.AKfbz=KFBZ_FT then
  begin
    ShowWarning('�˷���Ŀ��˲��ǵ������Ŀ��ˣ�����ȡ��');
    Exit;
  end;

  s := 'select sum(D_XFJE) from KRZD where D_ZDBH="'+FKfxx.AZdbh+'"';
  if HotelData.SumJe(s)<>0 then
  begin
    ShowWarning('�÷��Ѿ������������ʣ��㲻��ȡ��');
    Exit;
  end;
  if not Confirm('��ȷ��ȡ�����䣺'+edtKfh.Text+'?') then Exit;

  //��������
  HotelData.DatabaseUser.StartTransaction;
  try
    tblBqj.Open;
    if tblBqj.Locate('D_KFBH',FKfxx.AKfbh,[]) then
    begin
      tblBqj.Edit;
      tblBqj.FieldByName('D_SJFJ').AsCurrency := 0;
      tblBqj.Post;
    end;
    tblBqj.Close;
    //��տ����ʵ�
    //s := 'select * from KRZD where D_ZDBH="'+FKfxx.AZdbh+'"';
    s := 'delete from KRZD where D_ZDBH="'+FKfxx.AZdbh+'"';
    HotelData.EmptyData(s);

    //��տ�����Ϣ
    //s := 'select * from KRXX where D_KRBH="'+FKfxx.AKrbh+'"';
    s := 'delete from KRXX where D_KRBH="'+FKfxx.AKrbh+'"';
    HotelData.EmptyData(s);

    //��տ���Ѻ��
    //s := 'select * from KRYJ where D_YJBH="'+FKfxx.AYjbh+'"';
    s := 'delete from KRYJ where D_YJBH="'+FKfxx.AYjbh+'"';
    HotelData.EmptyData(s);

    
    //��ʼ���ͷ�״̬
    HotelData.ClearKfzt(FKfxx.AKfbh);//20020626 �޸� by ls.

    ShowInfo('����ȡ���ɹ���');

    //�����ύ
    HotelData.DatabaseUser.Commit;
  except
    //����ع�
    HotelData.DatabaseUser.Rollback;
    raise;
  end;

  Close;
end;

end.
