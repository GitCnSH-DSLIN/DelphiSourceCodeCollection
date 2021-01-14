unit passUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg, StdCtrls;

type
  Tpassform = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    Edit2: TEdit;
    Edit1: TEdit;
    Bevel3: TBevel;
    Bevel2: TBevel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    surelog: TButton;
    procedure FormCreate(Sender: TObject);
    procedure label3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure label3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label4Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure surelogClick(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    { Private declarations }
  public
    admin:integer;
    { Public declarations }
  end;

var
  passform: Tpassform;

implementation
uses mainunit,dataunit, DB;

{$R *.dfm}

procedure Tpassform.FormCreate(Sender: TObject);
begin
passform.Left:=GetSystemMetrics(SM_CXSCREEN) div 2-passform.Width div 2;
passform.Top:=GetSystemMetrics(SM_CYSCREEN) div 2-passform.Height div 2;
end;

procedure Tpassform.label3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
bevel2.Style:=bsLowered;
end;

procedure Tpassform.Label4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
bevel3.Style:=bsLowered;
end;

procedure Tpassform.label3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
bevel2.Style:=bsRaised;;
end;

procedure Tpassform.Label4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
bevel3.Style:=bsRaised;
end;

procedure Tpassform.Label4Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure Tpassform.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (key=vk_f4)and(shift=[ssalt])then
      begin
        abort;
      end;
if key=vk_return then
  begin
    surelog.Click;
  end;      
end;

procedure Tpassform.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (key=vk_f4)and(shift=[ssalt])then
      begin
        abort;
      end;
if key=vk_return then
  begin
    surelog.Click;
  end;
end;

procedure Tpassform.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (key=vk_f4)and(shift=[ssalt])then
      begin
        abort;
      end;
end;

procedure Tpassform.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
releasecapture;

perform(WM_SYSCOMMAND, SC_MOVE + 1, 0);

end;

procedure Tpassform.surelogClick(Sender: TObject);
begin
with DataModule1.Dyonghu.DataSet do
  begin
    if RecordCount<>0 then
      begin
        if Locate('�û���',edit1.Text,[])=true then
          begin
            if FieldByName('����').AsString=edit2.Text then
              begin
                if FieldByName('Ȩ��').AsString='���Ȩ��' then
                  admin:=0
                else if FieldByName('Ȩ��').AsString='����Ȩ��' then
                  admin:=1
                else if FieldByName('Ȩ��').AsString='һ��Ȩ��' then
                  admin:=2;
                passform.Hide;
                passform.Close;
                mainform.Show;
              end
            else
              begin
              Application.MessageBox('�����������','��ʾ');
              edit2.SetFocus;
              edit2.SelectAll;
              end;
          end
        else
          begin
          Application.MessageBox('�û������ڣ�','��ʾ');
          edit1.SetFocus;
          edit1.SelectAll;
          end;
      end
    else
      begin
        admin:=0;
        passform.Hide;
        passform.Close;
        mainform.Show;
      end;
  end;
end;

procedure Tpassform.Label3Click(Sender: TObject);
begin
surelog.Click;
end;

end.
