unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Shift>=[ssShift] then // ���������S h i f t�����ڵ�һ���������ʾS h i f t
     StatusBar1.Panels[0].Text:='Shift';
   if Shift>=[ssAlt] then // ���������A l t�����ڵڶ����������ʾA l t
     StatusBar1.Panels[1].Text:='Alt';
   if shift>=[ssCtrl] then // ���������C t r l�����ڵ������������ʾC t r l
     StatusBar1.Panels[2].Text:='Ctrl';
end;

end.
