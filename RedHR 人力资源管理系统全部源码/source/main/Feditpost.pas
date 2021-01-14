unit Feditpost;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  Teditpost = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    etype:integer;//1.����ͬ�� 2.��������  3.�༭
  end;

var
  editpost: Teditpost;

implementation

uses Fpostedit;

{$R *.dfm}

procedure Teditpost.Button1Click(Sender: TObject);
begin
  close
end;

procedure Teditpost.Button2Click(Sender: TObject);
begin
  if trim(self.Edit1.Text)='' then
    begin
      MessageBox(handle,'���������ƣ�','����',MB_ICONERROR or MB_OK);
      self.Edit1.SetFocus;
      exit;
    end;
  if self.etype=1 then     //���Ӳ���
    begin
      postedit.dxDBTreeView1.Items.Add(postedit.dxDBTreeView1.Selected, self.Edit1.Text);
      postedit.ADOTable1.Edit;
      postedit.ADOTable1.FieldByName('postmemo').AsVariant:=self.Memo1.Lines.Text;
      postedit.ADOTable1.Post;
    end;
  if self.etype=2 then
    begin
      if (postedit.dxDBTreeView1.Selected <> Nil) then
        begin
          postedit.dxDBTreeView1.Items.AddChild(postedit.dxDBTreeView1.Selected,self.Edit1.Text);
          postedit.ADOTable1.Edit;
          postedit.ADOTable1.FieldByName('postmemo').AsVariant:=self.Memo1.Lines.Text;
          postedit.ADOTable1.Post;
        end;
    end;
  if self.etype=3 then
    begin
      postedit.ADOTable1.Edit;
      postedit.ADOTable1.FieldByName('postname').AsString:=self.Edit1.Text;
      postedit.ADOTable1.FieldByName('postmemo').AsVariant:=self.Memo1.Lines.Text;
      postedit.ADOTable1.Post;
    end;
  self.Close;  
end;

end.
