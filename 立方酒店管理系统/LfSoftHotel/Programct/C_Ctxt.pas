unit C_Ctxt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, C_CtDefine, DosMove;

type
  TCtxtForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    lblTitle: TLabel;
    btnOk: TBitBtn;
    btnCanc: TBitBtn;
    Bevel1: TBevel;
    Label1: TLabel;
    edtCtbh: TEdit;
    Label2: TLabel;
    lblCtmc: TLabel;
    DosMove1: TDosMove;
    procedure edtCtbhExit(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancClick(Sender: TObject);
  private
    { Private declarations }
    FCtzt: TCtzt;
    FCzlx: Integer;
    FCtbh: string;
  public
    { Public declarations }
  end;

var
  CtxtForm: TCtxtForm;

function Ctxt: TCtzt;
function Ctzt: string;
function Ctbt: string;

implementation

uses C_CtData, C_Ctkt, C_ctdc, C_ctmain;

{$R *.dfm}

function Ctbt: string;
begin
  CtxtForm := TCtxtForm.Create(Application);
  try
    with CtxtForm do
    begin
      FCzlx := 2;
      Caption := '��̨';
      lblTitle.Caption := '������̨';
      lblCtmc.Caption := '';
      edtCtbh.Text := '';
      FCtbh := '';
      ShowModal;
      Result := FCtbh;
    end;
  finally
    CtxtForm.Free;
  end;
end;

function Ctzt: string;
begin
  CtxtForm := TCtxtForm.Create(Application);
  try
    with CtxtForm do
    begin
      FCzlx := 1;
      Caption := 'ת̨';
      lblTitle.Caption := '����ת̨';
      lblCtmc.Caption := '';
      edtCtbh.Text := '';
      FCtbh := '';
      ShowModal;
      Result := FCtbh;
    end;
  finally
    CtxtForm.Free;
  end;
end;

function Ctxt: TCtzt;
begin
  CtxtForm := TCtxtForm.Create(Application);
  try
    with CtxtForm do
    begin
      FCzlx := 0;
      Caption := 'ѡ̨';
      lblTitle.Caption := '����ѡ̨';
      lblCtmc.Caption := '';
      edtCtbh.Text := '';
      FCtzt.ACtbh := '';
      ShowModal;
      Result := FCtzt;
    end;
  finally
    CtxtForm.Free;
  end;
end;

procedure TCtxtForm.edtCtbhExit(Sender: TObject);
var
  ACtbh: string;
  ACtmc: string;
begin
  if edtCtbh.Text<>'' then
  begin
    ACtbh := UpperCase(edtCtbh.Text);
    ACtmc := CtData.IsValidCtbh(ACtbh);
    if ACtmc='' then
    begin
      ShowWarning('��������ȷ�Ĳ�����ţ�');
      edtCtbh.SetFocus;
    end
    else
    begin
      FCtbh := UpperCase(edtCtbh.Text);
      lblCtmc.Caption := ACtmc;
    end;
  end;
end;

procedure TCtxtForm.btnOkClick(Sender: TObject);
begin
  if edtCtbh.Text='' then
  begin
    ShowWarning('�������̨��ţ�');
    Exit;
  end;
  case FCzlx of
    0:
      begin
        FCtzt := CtData.GetCtzt(FCtbh);
      end;
    1:
      begin
        FCtzt := CtData.GetCtzt(FCtbh);
        if FCtzt.ACtzt<>CTZT_OK then
        begin
          ShowWarning('�ò�̨����ʹ���У�����ѡ��');
          FCtbh := '';
          Exit;
        end;
      end;
    2:
      begin
        FCtzt := CtData.GetCtzt(FCtbh);
        if FCtzt.ACtzt<>CTZT_USE then
        begin
          ShowWarning('�ò�̨û�п��ˣ�����ѡ��');
          FCtbh := '';
          Exit;
        end;
      end;
  end;
  Close;
end;

procedure TCtxtForm.FormShow(Sender: TObject);
begin
  edtCtbh.SetFocus;
end;

procedure TCtxtForm.btnCancClick(Sender: TObject);
begin
  FCtbh := '';
end;

end.
