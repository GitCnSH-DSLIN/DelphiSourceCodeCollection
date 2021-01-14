unit tjyusc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, DB;

type
  TForm4 = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Panel3: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    Edit1: TEdit;
    Label2: TLabel;
    Label4: TLabel;
    ComboBox1: TComboBox;
    Edit2: TEdit;
    DataSource1: TDataSource;
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn5Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
Const
  a = 2;
var
  Form4: TForm4;

implementation
  uses  Dataa;
{$R *.dfm}

procedure TForm4.BitBtn4Click(Sender: TObject);
begin
  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  ComboBox1.ItemIndex:= 0;
end;

procedure TForm4.BitBtn1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  TBitBtn(Sender).Font.Color := clRed;
  Screen.Cursor := a;
end;

procedure TForm4.Panel2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  BitBtn1.Font.Color := clBlue;
  BitBtn2.Font.Color := clBlue;
  BitBtn3.Font.Color := clBlue;
  BitBtn4.Font.Color := clBlue;
  BitBtn5.Font.Color := clBlue;
  Screen.Cursor := -2;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Screen.Cursor := -2;
end;

procedure TForm4.DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Screen.Cursor := -2;
end;

procedure TForm4.BitBtn1Click(Sender: TObject);
var
  s,m: String;
  i: integer;
begin
  s:= 'CY'+ FormatDateTime('yyyymmdd',Now());
  With data3.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select max(����Ա���) as ss From ����Ա��Ϣ�� ');
    Open;
  end;
  If data3.ADOQuery1.FieldByName('ss').Value = null then
    s := s + '001'
  else
  begin
    m:= Trim(data3.ADOQuery1.FieldByName('ss').Value) ;
    i:= StrToInt(Trim(Copy(m,11,5))) ;
    if i<9 then
      s:= s + '00'+ InttoStr(i +1)
    else if i<99 then
      s:= s + '0'+ InttoStr(i +1)
    else
      s:= s +InttoStr(i +1);
  end;
  Edit1.Text := s;
  Edit2.Clear;
  Edit3.Clear ;
  Edit2.SetFocus;

end;

procedure TForm4.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then
    Edit2.SetFocus;
end;

procedure TForm4.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then
    Edit3.SetFocus;
  if key = vk_up then
    Edit1.SetFocus;
end;

procedure TForm4.Edit3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then
    ComboBox1.SetFocus;
  if Key = vk_up then
    Edit2.SetFocus;
end;

procedure TForm4.ComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = vk_return)and(BitBtn5.Enabled = True) then
    BitBtn5.SetFocus;
end;

procedure TForm4.BitBtn5Click(Sender: TObject);
begin
  with data3.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from ����Ա��Ϣ�� where ����Ա���= :a');
    Parameters.ParamByName('a').Value  := Trim(Edit1.Text);
    Open;
  end;
  If data3.ADOQuery1.RecordCount >0 then
  begin
    Application.MessageBox('����Ա�Ѿ����ڣ����������롣','��ʾ',0+64);
    BitBtn4.OnClick(Sender);
    Exit;
  end;
  Try
  with data3.ADOQuery2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Insert  ����Ա��Ϣ�� Values(:a , :b , :c , :d ,Default)');
    Parameters.ParamByName('a').Value := Trim(Edit1.Text);
    Parameters.ParamByName('b').Value := Trim(Edit2.Text);
    Parameters.ParamByName('c').Value := Trim(Edit3.Text);
    if Trim(ComboBox1.Text) ='ϵͳ����Ա' then
      Parameters.ParamByName('d').Value := '1'
    else
      Parameters.ParamByName('d').Value := '2';
    ExecSQL;
  end;
    Application.MessageBox(Pchar('��ӳɹ�������Ա����Ϊ��'+ Trim(Edit3.Text)+'��'),'��ʾ',0+64);
    BitBtn4.OnClick(Sender);
  Except
  begin
    Application.MessageBox('ϵͳ����','��ʾ',0+64);
    Close;
  end;
  end;
  with data3.ADOQuery2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from ����Ա��Ϣ��' );
    Open;
  end;
end;

procedure TForm4.Edit2Change(Sender: TObject);
begin
  if (Trim(Edit1.Text)<>'')and(Trim(Edit2.Text)<>'')and(Trim(Edit3.Text)<>'')
    and(Trim(ComboBox1.Text )<>'')then
    begin
      BitBtn2.Enabled := True;
      BitBtn5.Enabled := True;
    end
  else
    begin
    BitBtn5.Enabled := False;
    BitBtn2.Enabled := False;
  end;
end;

procedure TForm4.DBGrid1CellClick(Column: TColumn);
begin
  if data3.ADOQuery2.RecordCount>0 then
  begin
    Edit1.Text := data3.ADOQuery2.FieldByName('����Ա���').AsString;
    Edit2.Text := data3.ADOQuery2.FieldByName('����Ա����').AsString;
    Edit3.Text := data3.ADOQuery2.FieldByName('����Ա����').AsString;
    ComboBox1.Text := data3.ADOQuery2.FieldByName('����Ա����').AsString;
  end;
end;

procedure TForm4.BitBtn2Click(Sender: TObject);
begin
  with data3.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from ����Ա��Ϣ�� where ����Ա���= :a');
    Parameters.ParamByName('a').Value  := Trim(Edit1.Text);
    Open;
  end;
  If data3.ADOQuery1.RecordCount <1 then
  begin
    Application.MessageBox('����Ա�����ڣ������б���ѡ�����Ա��','��ʾ',0+64);
    BitBtn4.OnClick(Sender);
    Exit;
  end
  Else
  begin
    Try
    with data3.ADOQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('Delete  ����Ա��Ϣ�� where ����Ա��� = :a');
      Parameters.ParamByName('a').Value := Trim(Edit1.Text);
      if Application.MessageBox(pchar('ȷʵҪɾ�����Ϊ'+ Edit1.Text + '�Ĳ���Ա��?'),'��ʾ',MB_YESNO )= ID_Yes then
      begin
        ExecSQL;
        Application.MessageBox('ɾ���ɹ���','��ʾ',0+64);
        BitBtn4.OnClick(Sender);
      end
      else
      begin
        Close;
        SQL.Clear;
        BitBtn4.OnClick(Sender);
      end;
    end;
    Except
    begin
      Application.MessageBox('ϵͳ����','��ʾ',0+64);
      Self.Close;
    end;
    end;
  end;
  with data3.ADOQuery2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from ����Ա��Ϣ��');
    Open;
  end;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  with data3.ADOQuery2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select ����Ա���,����Ա����,����Ա����,����Ա���� = Case ����Ա���� when 1 then ''ϵͳ����Ա'' when 2 then ''��ͨ����Ա'' end from ����Ա��Ϣ��');
    Open;
  end;
  if Data3.ADOQuery2.RecordCount>0 then
    DataSource1.DataSet := Data3.ADOQuery2
  else
    DataSource1.DataSet := Nil;
  Combobox1.ItemIndex := 0 ;
  Screen.Cursors[a]:= LoadCursorFromFile('C:\My Documents\Cur1.cur');
  BitBtn1.SetFocus;
end;
   
procedure TForm4.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

end.
