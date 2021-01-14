unit rysc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, Buttons, StdCtrls, ExtCtrls, DB;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DataSource1: TDataSource;
    Edit1: TEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation
   uses dataa;
{$R *.dfm}

procedure TForm3.BitBtn2Click(Sender: TObject);
begin
  DataSource1.DataSet := Nil;
  Edit1.Clear;
  BitBtn1.Enabled := False;
end;

procedure TForm3.SpeedButton1Click(Sender: TObject);
begin
  if Trim(Edit1.Text)<>'' then
  begin
    with Data3.ADOQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from Ա��������Ϣ�� where Ա������= :a');
      Parameters.ParamByName('a').Value := Trim(Edit1.Text);
      Open;
      if Data3.ADOQuery1.RecordCount>0 then
      begin
        BitBtn1.Enabled := True;
        DataSource1.DataSet := Data3.ADOQuery1;
      end
      else
      begin
        Application.MessageBox('����Ա�����ڣ����������롣','��ʾ',64);
        BitBtn2.OnClick(Sender);
      end;
    end;
  end;
end;

procedure TForm3.BitBtn1Click(Sender: TObject);
begin
  if Data3.ADOQuery1.Active = True then
    if Application.MessageBox('ȷʵҪɾ����ǰ��¼��','��ʾ',MB_YesNo)= ID_Yes then
    begin
      Try
        Data3.ADOConnection1.BeginTrans;
        With Data3.ADOQuery2 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('delete Ա���������ʱ� where Ա����� = :a');
          Parameters.ParamByName('a').Value := Trim(Data3.ADOQuery1.FieldByName('Ա�����').AsString);
          ExecSQL;
        end;
        With Data3.ADOQuery2 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('delete Ա������������Ŀ�� where Ա����� = :a');
          Parameters.ParamByName('a').Value := Trim(Data3.ADOQuery1.FieldByName('Ա�����').AsString);
          ExecSQL;
        end;
        Data3.ADOQuery1.Delete;
        Data3.ADOConnection1.CommitTrans;
        BitBtn2.OnClick(Sender);
        Application.MessageBox('�����ɹ���','��ʾ',64);
     
      Except
        Data3.ADOConnection1.RollbackTrans;
        Application.MessageBox('ϵͳ����','��ʾ',64);
        Close;
      end;
    end;
end;

procedure TForm3.BitBtn1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  TBitBtn(Sender).Font.Color := clRed;
end;

procedure TForm3.BitBtn1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  TBitBtn(Sender).Font.Color := clBlue;
end;

end.
