unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    Modeless:TForm;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  ModalForm:TForm;
begin
  //����TModalForm��ʵ��
  ModalForm:=TForm.Create(Application);
  ModalForm.Caption:='ģʽ����';
  try
    if ModalForm.ShowModal=mrOk then     //��ʾ�������
      {ִ��һЩ����}
  finally
    ModalForm.Free;
    ModalForm:=nil;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if not Assigned(Modeless) then
    Modeless:=TForm.Create(Application);    //��������
  Modeless.Caption:='��ģʽ����';
  Modeless.Show;                            //��ʾ��ģʽ����
end;

end.
