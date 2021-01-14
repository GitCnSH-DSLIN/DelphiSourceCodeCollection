unit C_Klsz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C_StdJd, DosMove, StdCtrls, Buttons, ExtCtrls, DB, DBTables, C_Define;

type
  TKlszForm = class(TStdJdForm)
    edtOldPass: TLabeledEdit;
    edtNewPass: TLabeledEdit;
    tblYgda: TTable;
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
    FYgbh: string;
  public
    { Public declarations }
  end;

var
  KlszForm: TKlszForm;

procedure Klsz(const AYgbh: string);

implementation

uses C_HotelData;

{$R *.dfm}

procedure Klsz(const AYgbh: string);
begin
  KlszForm := TKlszForm.Create(Application);
  try
    with KlszForm do
    begin
      FYgbh := AYgbh;
      try
        tblYgda.Open;
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
    end;
  finally
    KlszForm.tblYgda.Close;
    KlszForm.Free;
  end;
end;

//ȷ��
procedure TKlszForm.btnOKClick(Sender: TObject);
var
  OldPass,NewPass: string;
begin
  inherited;
  OldPass := edtOldPass.Text;
  NewPass := edtNewPass.Text;

  HotelData.DatabaseUser.StartTransaction;
  try
    if tblYgda.FindKey([FYgbh]) then
    begin
      if OldPass = tblYgda.FieldByName('D_KL').AsString then
      begin
        tblYgda.Edit;
        tblYgda.FieldByName('D_KL').AsString := NewPass;
        tblYgda.Post;
        ShowInfo('�������óɹ���');
        Close;
      end
      else
        ShowWarning('�ɿ����ȷ��');
    end;

    HotelData.DatabaseUser.Commit;
  except
    HotelData.DatabaseUser.Rollback;
    raise;
  end;
end;

end.
