unit DqRqd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, CheckLst, dbgrids, ExtCtrls, Mask, DBCtrls, ComCtrls,
  DB, DBClient, ComForm;

type
  TfrmDqRqd = class(TfrmComForm)
    btnOk: TBitBtn;                       
    btnCancel: TBitBtn;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel2: TBevel;
    labRq: TLabel;
    dtpRqa: TDateTimePicker;
    Label3: TLabel;
    dtpRqb: TDateTimePicker;
    ComboBox1: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure ComboBox1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strMC: string;
  end;

var
  frmDqRqd: TfrmDqRqd;

implementation

uses Main, Dm, MyLib, ComFun, Common;

{$R *.DFM}

procedure TfrmDqRqd.FormShow(Sender: TObject);
begin
  dtpRqa.Date := BOFM(Date);
  dtpRqb.Date := Date;
  ValuesToStrings(ComboBox1.Items, 'select MC from DQ');
  ComboBox1.SetFocus;
  if ComboBox1.Text <> '' then
    self.Perform(WM_KEYDOWN, VK_RETURN, 0);
end;

procedure TfrmDqRqd.ComboBox1Exit(Sender: TObject);
begin
  if Screen.ActiveControl = btnCancel then Exit;
  strMC := ComboBox1.Text;
end;

procedure TfrmDqRqd.btnOkClick(Sender: TObject);
begin
  if ComboBox1.Text = '' then
  begin
    Application.MessageBox('��Ч�ĵ��������������룡', '��ʾ', MB_OK + MB_ICONWARNING);
    ComboBox1.SetFocus;
    Exit;
  end;
  if dtpRqb.Date < dtpRqa.Date then
  begin
    Application.MessageBox('�������ڲ��ܴ�����ʼ���ڣ����������룡', '��ʾ', MB_OK + MB_ICONWARNING);
    dtpRqb.SetFocus;
    abort;
  end;
  Close;
  self.ModalResult := MROK;
end;

end.
