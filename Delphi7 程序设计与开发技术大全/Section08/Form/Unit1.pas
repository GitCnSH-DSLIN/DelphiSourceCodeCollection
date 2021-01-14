unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button2: TButton;
    Button3: TButton;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation


{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  rgn:HRGN;
begin
  BeginPath(Canvas.Handle);//���ƵĿ�ʼ·��
  SetBkMode(Canvas.Handle,TRANSPARENT);
  Canvas.Font.Name:='����';
  Canvas.Font.Size:=60;
  Canvas.Font.Style:=[fsBold];
  Canvas.Font.Color:=clBlue;
  Canvas.TextOut(1,1,'���ִ���');//�á����ִ��塱��ΪForm����״
  EndPath(Canvas.Handle);//����·��
  rgn:=PathToRegion(Canvas.Handle);
  SetWindowRgn(Handle,rgn,True);//���ô������״
end;

procedure TForm1.FormDblClick(Sender: TObject);
var
  rgn:HRGN;
begin
  rgn:=PathToRegion(Form1.Handle);
  SetWindowRgn(Handle,rgn,True);//���ô������״
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  rgn:HRGN;
begin
  rgn:=CreateEllipticRgn(0,0,150,150);
  SetWindowRgn(self.Handle, rgn, true);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
if Form1.FormStyle=fsNormal then
  Form1.FormStyle:=fsStayOnTop
else
  Form1.FormStyle :=fsNormal;
end;

end.
