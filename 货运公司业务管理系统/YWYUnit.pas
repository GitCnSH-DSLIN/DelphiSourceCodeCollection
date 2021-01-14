unit YWYUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, StdCtrls, TFlatComboBoxUnit, AAFont,
  AACtrls, TFlatButtonUnit, TFlatPanelUnit,DB;

type
  TYWYForm = class(TForm)
    FlatPanel1: TFlatPanel;
    FlatButton1: TFlatButton;
    FlatButton2: TFlatButton;
    FlatButton3: TFlatButton;
    FlatButton4: TFlatButton;
    AALabel1: TAALabel;
    AALabel2: TAALabel;
    AALabel3: TAALabel;
    AALabel4: TAALabel;
    FlatComboBox1: TFlatComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Shape1: TShape;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure FlatButton4Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure FlatComboBox1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  YWYForm: TYWYForm;

implementation

uses DMUnit, MainUnit;

{$R *.dfm}

procedure TYWYForm.FormCreate(Sender: TObject);
begin
  if DM.YWYQuery.Active=false then
    DM.YWYQuery.Active:=true;
end;

procedure TYWYForm.FormShow(Sender: TObject);
begin
  DM.YWYQuery.Close;
  DM.YWYQuery.SQL.Clear;
  DM.YWYQuery.SQL.Add('select * from YWY_XX');
  DM.YWYQuery.Open;
end;

procedure TYWYForm.FlatButton1Click(Sender: TObject);
begin
   if MainForm.QuanXian=2 then
    begin
      ShowMessage('���Ȩ�޲�����');
      exit;
    end;
  if DM.YWYQuery.State=dsbrowse then
    begin
      Edit1.Text:='';
      Edit2.Text:='';
      Edit3.Text:='';
      Flatcombobox1.text:='';
      Edit1.Color:=clmoneyGreen;
      Edit2.Color:=clmoneyGreen;
      FlatComBoBox1.Color:=clMoneyGreen;
      Edit3.Color:=clMoneyGreen;
      DM.YWYQuery.Append;
      Edit1.SetFocus;
    end;
end;

procedure TYWYForm.FlatButton2Click(Sender: TObject);
begin
   if MainForm.QuanXian=2 then
    begin
      ShowMessage('���Ȩ�޲�����');
      exit;
    end;
  if DM.YWYQuery.RecordCount=0 then
   begin
     ShowMessage('����������!�޷��޸�!');
     Exit;
   end;
   if DM.YWYQuery.State=dsBrowse then
     try
      Edit1.Color:=clmoneygreen;
      Edit2.Color:=clMoneyGreen;
      Edit3.Color:=clMoneyGreen;
      FlatComBoBox1.Color:=clMoneyGreen;
      DM.YWYQuery.Edit;
      Edit1.SetFocus;
     except
     showmessage('��������,�޷��޸�!');
     end;
end;

procedure TYWYForm.FlatButton3Click(Sender: TObject);
begin
   if MainForm.QuanXian=2 then
    begin
      ShowMessage('���Ȩ�޲�����');
      exit;
    end;
  if DM.YWYQuery.RecordCount=0 then
    begin
     showmessage('����������,�޷�ɾ��!');
     Exit;
    end;
  if Application.MessageBox('�Ƿ�ɾ��������¼!','ϵͳ��ʾ',mb_yesno)=mryes then
    try
      DM.YWYQuery.Delete;
      Edit1.Text:='';
      Edit2.Text:='';
      Edit3.Text:='';
    except
     showmessage('��������,ɾ��ʧ��!');
    end;
end;

procedure TYWYForm.FlatButton4Click(Sender: TObject);
begin
   if (Edit1.Text='') or (Edit2.Text='') then
     begin
       showmessage('���ݲ�����,��¼����������!');
       Exit;
     end;
  if (DM.YWYQuery.State=dsinsert) or (DM.YWYQuery.State=dsEdit) then
    try
     DM.YWYQuery.FieldByName('YWYID').AsString:=Edit1.Text;
     DM.YWYQuery.FieldByName('YWYNAME').AsString:=Edit2.Text;
     DM.YWYQuery.FieldByName('YWYSEX').AsString:=FlatComBoBOx1.Text;
     if Edit3.Text='' then
     DM.YWYQuery.FieldByName('YWYBZ').AsString:=' '
     else
     DM.YWYQuery.FieldByName('YWYBZ').AsString:=Edit3.Text;
     DM.YWYQuery.Post;
     Edit1.Color:=clwindow;
     Edit2.Color:=clwindow;
     Edit3.Color:=clwindow;
     FlatComBoBox1.Color:=clwindow;
     Edit1.Text:='';
     Edit2.Text:='';
     Edit3.Text:='';
    except
    showMessage('��������,����ʧ��!');
    end;
end;

procedure TYWYForm.DBGrid1CellClick(Column: TColumn);
begin
  Edit1.Text:=DM.YWYQuery.FieldByName('YWYID').AsString;
  Edit2.Text:=DM.YWYQuery.FieldByName('YWYNAME').AsString;
  if DM.YWYQuery.FieldByName('YWYSEX').AsString='��' then
  FlatComBoBOx1.ItemIndex:=0;
  if DM.YWYQuery.FieldByName('YWYSEX').AsString='Ů' then
  Flatcombobox1.ItemIndex:=1;
  Edit3.Text:=DM.YWYQuery.FieldByName('YWYBZ').AsString;
end;

procedure TYWYForm.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Edit1.Text:=DM.YWYQuery.FieldByName('YWYID').AsString;
  Edit2.Text:=DM.YWYQuery.FieldByName('YWYNAME').AsString;
  if DM.YWYQuery.FieldByName('YWYSEX').AsString='��' then
  FlatComBoBOx1.ItemIndex:=0;
  if DM.YWYQuery.FieldByName('YWYSEX').AsString='Ů' then
  Flatcombobox1.ItemIndex:=1;
  Edit3.Text:=DM.YWYQuery.FieldByName('YWYBZ').AsString;
end;

procedure TYWYForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
   Edit2.SetFocus;
end;

procedure TYWYForm.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
   Flatcombobox1.SetFocus;
end;

procedure TYWYForm.FlatComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
    Edit3.SetFocus;
end;

end.
