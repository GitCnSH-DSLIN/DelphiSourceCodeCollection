unit HphsffEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComEdit, StdCtrls, Buttons, Mask, DBCtrls, ExtCtrls, db;

type
  TfrmHphsffEdit = class(TfrmComEdit)
    Label3: TLabel;
    ComboBox1: TComboBox;
    procedure FormShow(Sender: TObject);override;
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHphsffEdit: TfrmHphsffEdit;

implementation

uses dm;
{$R *.DFM}

procedure TfrmHphsffEdit.FormShow(Sender: TObject);
begin
  blnSetID := True;
  strKeyFields := 'MC;LB';
  inherited;
  with ComboBox1 do
  begin
    Items.Add('�����Ʒ');
    Items.Add('����/����');
    Items.Add('��������');
    Items.Add('����֧��');
    Items.Add('�ۿ�');
    ItemIndex := dsEdits.FieldByName('LB').AsInteger - 1;
    if ItemIndex < 0 then ItemIndex := 0;
  end;
end;

procedure TfrmHphsffEdit.ComboBox1Change(Sender: TObject);
begin
  dsEdits.Edit;
  dsEdits.FieldByName('LB').AsInteger := ComboBox1.ItemIndex + 1;
end;

end.
