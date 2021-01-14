unit anquanUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, Buttons, ExtCtrls, BusinessSkinForm,
  ComCtrls, bsSkinCtrls, Mask, bsSkinBoxCtrls, Menus;

type
  Tanquanform = class(TForm)
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    ComboBox1: TComboBox;
    GroupBox3: TGroupBox;
    Panel1: TPanel;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    StatusBar1: TStatusBar;
    BitBtn5: TbsSkinButton;
    bitbtn4: TbsSkinButton;
    BitBtn3: TbsSkinButton;
    BitBtn2: TbsSkinButton;
    BitBtn1: TbsSkinButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    procedure wmgetminmaxinfo( var msg:Twmgetminmaxinfo); message wm_getminmaxinfo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  anquanform: Tanquanform;

implementation
uses dataunit, DB,mainunit;

{$R *.dfm}

procedure Tanquanform.BitBtn1Click(Sender: TObject);
begin
if (edit1.Text<>'')and(edit2.Text<>'')and(edit2.Text=edit3.Text)and(ComboBox1.Text<>'') then
  begin
    if DataModule1.Dyonghu.DataSet.Locate('�û���',edit1.Text,[])=false then
      begin
        DBGrid1.DataSource.DataSet.Append;
        DBGrid1.DataSource.DataSet.FieldByName('�û���').AsString:=edit1.Text;
        DBGrid1.DataSource.DataSet.FieldByName('����').AsString:=edit3.Text;
        DBGrid1.DataSource.DataSet.FieldByName('Ȩ��').AsString:=ComboBox1.Text;
        DBGrid1.DataSource.DataSet.post;
        edit1.Text:='';
        edit2.Text:='';
        edit3.Text:='';
        ComboBox1.Text:='';
      end
    else
      Application.MessageBox('���û��Ѿ����ڣ�','��ʾ');
  end
else
  Application.MessageBox('���������Ƿ���ȷ��','��ʾ');
end;

procedure Tanquanform.Edit3Exit(Sender: TObject);
begin
if edit3.Text<>'' then
if edit3.Text<>edit2.Text then
  begin
    Application.MessageBox('ȷ���������','��ʾ');
    edit3.SetFocus;
    edit3.SelectAll;
  end;
end;

procedure Tanquanform.BitBtn2Click(Sender: TObject);
begin
if DBGrid1.DataSource.DataSet.RecordCount<>0 then
  DBGrid1.DataSource.DataSet.Delete
else
  Application.MessageBox('û���κ��û����ڣ�','��ʾ');
end;

procedure Tanquanform.BitBtn3Click(Sender: TObject);
begin
with DBGrid1.DataSource.DataSet do
  begin
    if Locate('�û���',edit1.Text,[])=true then
      begin
        if (edit2.Text<>'')and(edit3.Text<>'') then
          begin
            Edit;
            FieldByName('����').AsString:=Edit3.Text;
            Post;
            Refresh;
            Application.MessageBox('�����Ѿ��޸ģ�','��ʾ');
          end
        else
          Application.MessageBox('���������룡','��ʾ');
      end
    else
      Application.MessageBox('û�и��û���Ϣ��','��ʾ');
end;
end;

procedure Tanquanform.BitBtn4Click(Sender: TObject);
begin
with DBGrid1.DataSource.DataSet do
  begin
    if Locate('�û���',edit1.Text,[])=true then
      begin
        if ComboBox1.Text<>'' then
          begin
            Edit;
            FieldByName('Ȩ��').AsString:=ComboBox1.Text;
            Post;
            Refresh;
            Application.MessageBox('Ȩ���޸ĳɹ���','��ʾ');
          end
        else
          Application.MessageBox('��ѡ��Ȩ�ޣ�','��ʾ');
      end
    else
      Application.MessageBox('û�и��û���Ϣ��','��ʾ');
end;
end;

procedure Tanquanform.BitBtn5Click(Sender: TObject);
begin
Close;
end;

procedure Tanquanform.FormCreate(Sender: TObject);
begin
anquanform.Left:=GetSystemMetrics(SM_CXSCREEN) div 2-anquanform.Width div 2;
anquanform.Top:=GetSystemMetrics(SM_CYSCREEN)div 2-anquanform.Height div 2;
end;

procedure Tanquanform.ComboBox1Change(Sender: TObject);
begin
if DBGrid1.DataSource.DataSet.RecordCount=0 then
  begin
    if ComboBox1.Text<>'���Ȩ��' then
      begin
        Application.MessageBox('���������һ�����Ȩ�ޣ�','��ʾ');
        ComboBox1.ItemIndex:=0;
      end;
  end;
end;


procedure Tanquanform.wmgetminmaxinfo( var msg:Twmgetminmaxinfo);

begin
  
 with msg.minmaxinfo^ do
   
    begin
      ptMinTrackSize:=point(676,336);  //�޶���С
      ptMaxTrackSize:=point(676,336);  //�޶���С

    end;

end;

procedure Tanquanform.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
mainform.Show;
end;

procedure Tanquanform.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=Vk_return) then
  begin
    BitBtn1.Click;
  end;
end;

procedure Tanquanform.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=Vk_return) then
  begin
    BitBtn1.Click;
  end;
end;

procedure Tanquanform.Edit3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=Vk_return) then
  begin
    BitBtn1.Click;
  end;
end;

procedure Tanquanform.ComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=Vk_return) then
  begin
    BitBtn1.Click;
  end;
end;

procedure Tanquanform.DBGrid1CellClick(Column: TColumn);
begin
edit1.Text:='';
if (DBGrid1.DataSource.DataSet.RecordCount<>0)and(DBGrid1.DataSource.DataSet.Eof<>true) then
  begin
    edit1.Text:=DBGrid1.DataSource.DataSet.FieldValues['�û���'];
  end;
end;

end.
