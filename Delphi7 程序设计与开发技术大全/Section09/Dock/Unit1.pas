unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    procedure Edit1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Memo1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Memo1DragDrop(Sender, Source: TObject; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Edit1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then   // ��ʼ�����϶�����
    (Sender As TEdit).BeginDrag(False);
end;

procedure TForm1.Memo1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if Source Is TEdit then   // ���Խ����϶�����
    Accept:=True;
end;

procedure TForm1.Memo1DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if(Sender Is TMemo) and (Source Is TEdit) then
    // ��Edit����е�������ӵ�Memo��������
    (Sender As TMemo).Lines.Add((Source As TEdit).Text);
end;

end.
