unit UpdateCourseUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls;

type
  TUpdateCourseForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UpdateCourseForm: TUpdateCourseForm;

implementation

uses UpDateDataModuleUnit;

{$R *.dfm}

procedure TUpdateCourseForm.Button4Click(Sender: TObject);
begin
  UpDateDataModule.CourseTable.Prior;
  button1.Enabled:=true;
end;

procedure TUpdateCourseForm.Button5Click(Sender: TObject);
begin
  UpDateDataModule.CourseTable.Next;
 button1.Enabled:=true;
end;

procedure TUpdateCourseForm.Button1Click(Sender: TObject);
begin
   With UpDateDataModule.CourseTable  do
 begin
  Insert;
  button2.Enabled:=true;
  button1.Enabled:=false;
  end;
end;

procedure TUpdateCourseForm.Button2Click(Sender: TObject);
begin
  if((DBEdit2.Text='')or(DBEdit1.Text='')) then
 begin
   ShowMessage('�γ����ƺͿγ̱�Ų���Ϊ��!');
   Exit;
 end;
 With UpDateDataModule.CourseTable  do
 begin
  try
    Post;
    ShowMessage('��ӳɹ�!');
    button2.Enabled:=false;
    button1.Enabled:=true;
  except
  begin
    Active:=false;
    Active:=true;
    Insert;
    button1.Enabled:=true;
    button2.Enabled:=false;
    ShowMessage('���ʧ��!');
    Exit;
  end;
 end;
 end;
end;

procedure TUpdateCourseForm.Button3Click(Sender: TObject);
begin
 With UpDateDataModule.CourseTable  do
 begin
  if DBEdit2.Text='' then
  begin
   ShowMessage('������γ̵ı��!');
   exit;
  end;
  try
   Delete;
   ShowMessage('ɾ���ɹ�!');
  except
  begin
   Active:=true;
   Insert;
   ShowMessage('ɾ��ʧ��!');
   Exit;
  end;
 end;
 end;
end;

procedure TUpdateCourseForm.Button6Click(Sender: TObject);
begin
  close;
end;

end.
