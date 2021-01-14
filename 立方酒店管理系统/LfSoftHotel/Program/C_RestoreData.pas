unit C_RestoreData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ShellCtrls, Buttons, ExtCtrls;

type
  TRestoreDataForm = class(TForm)
    Panel1: TPanel;
    btnRestoreData: TBitBtn;
    btnCancel: TBitBtn;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblDatabase: TLabel;
    ShellTreeView1: TShellTreeView;
    edtDir: TEdit;
    procedure ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure OnRestore(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RestoreDataForm: TRestoreDataForm;

procedure RestoreData;

implementation

uses C_Define, C_PjglData, C_Wait;

{$R *.dfm}
procedure RestoreData;
begin
  if not PjglData.CheckQx(CZY,'01-XT05') then Exit;
  RestoreDataForm := TRestoreDataForm.Create(Application);
  try
    with RestoreDataForm do
    begin
      lblDatabase.Caption := DbfDir;
      edtDir.Text := BakDir;
      //ShellTreeView1.Path := BakDir;
      ShowModal;
    end;
  finally
    RestoreDataForm.Free;
  end;
end;

procedure TRestoreDataForm.ShellTreeView1Change(Sender: TObject;
  Node: TTreeNode);
begin
  edtDir.Text := ShellTreeView1.Path;
end;

procedure TRestoreDataForm.OnRestore(Sender: TObject);
var
  SDir,DDir : string;
begin
  if edtDir.Text = '' then Exit;
  if not Confirm('��ȷ�Ͽ�ʼ�ָ���������ر����������ϵĳ���') then Exit;
  DDir := DbfDir;
  SDir := edtDir.Text;
  WaitForm := TWaitForm.Create(Application);
  WaitForm.FTitle := '�ָ�����';
  WaitForm.FLen := 100;
  WaitForm.Show;
  WaitForm.Update;
  try
    CopyDir(SDir,DDir);
    WaitForm.FPos := 100;
  finally
    WaitForm.Hide;
    WaitForm.Free;
  end;
  ShowInfo('���ݿ�ָ��ɹ�������������������');
end;

end.
