unit Regist;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Registry;

type
  TRestForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure WriteReg;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RestForm: TRestForm;

implementation

{$R *.DFM}
uses XedUser;

procedure TRestForm.Button1Click(Sender: TObject);
begin
  if Edit2.Text = EncodeStr(Edit1.Text) then begin
    WriteReg;
    Registed := True;
    ShowMessage('���ע��ɹ�����л��λ֧���������');
    Exit;
  end;
  Registed := False;
  Screen.Cursor := crHourGlass;
  Sleep(5000);
  Screen.Cursor := crDefault;
  ShowMessage('��Ч��ע���룬ϣ����֧������������ܾ��������');
end;

procedure TRestForm.FormCreate(Sender: TObject);
begin
  Edit1.Text := DiskID('C:\');
  Edit2.Text := ''; //EncodeStr(Edit1.Text);
end;

procedure TRestForm.WriteReg;
var
  Reg: TRegistry;
  P: string;
  i: Word;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKey_Local_Machine;
  Reg.OpenKey(KeyPath + PassKey, True);
  P := Edit2.Text;
  for i := 1 to 10 do begin
    P := P + Chr(65 + Random(I + 26));
  end;
  Reg.WriteString('PassWord', P);
  Reg.CloseKey;
  Reg.Free;
end;

procedure TRestForm.Button2Click(Sender: TObject);
begin
  Registed := False;
end;

end.
