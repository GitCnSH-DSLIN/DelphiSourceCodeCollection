unit gzdagl_department_;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, Mask, DBCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TForm_department = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit_no: TEdit;
    Edit_name: TEdit;
    Edit_man: TEdit;
    BTadddepartment: TBitBtn;
    BTcanceldepartment: TBitBtn;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    MaskEdit_yusuan: TMaskEdit;
    Label5: TLabel;
    DBNavigator1: TDBNavigator;
    procedure Edit_noChange(Sender: TObject);
    procedure BTadddepartmentClick(Sender: TObject);
    procedure BTcanceldepartmentClick(Sender: TObject);
 
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_department: TForm_department;

implementation

uses gzdagl_DM_;

{$R *.dfm}

procedure TForm_department.Edit_noChange(Sender: TObject);
begin
  if length(edit_no.Text)>0 then
  //���������ַ�����������enabled
    BTadddepartment.Enabled:=true
  else
    BTadddepartment.Enabled:=false;
end;

procedure TForm_department.BTadddepartmentClick(Sender: TObject);
begin
//�жϿ��ұ���Ƿ��Ѿ�����
  DMgzdagl.ADOTdepartment.Open;
  if DMgzdagl.ADOTdepartment.Locate('���ұ��',edit_no.text,[])=true then
     showmessage('���ұ���Ѿ����ڣ����������룡')
   else
     with DMgzdagl.ADOTdepartment do
       begin
         append;
         DMgzdagl.ADOTdepartment.FieldByName('���ұ��').AsString:=edit_no.Text;
         DMgzdagl.ADOTdepartment.FieldByName('��������').AsString:=edit_name.Text;
         DMgzdagl.ADOTdepartment.FieldByName('��������').AsString:=edit_man.Text;
         DMgzdagl.ADOTdepartment.FieldByName('����Ԥ��').Asstring:=maskEdit_yusuan.Text;
         post;
         refresh;
         messagedlg('¼��ɹ���',mtinformation,[mbok],0);
         form_department.BTcanceldepartment.OnClick(self);
       end;  
end;

procedure TForm_department.BTcanceldepartmentClick(Sender: TObject);
begin
//��������
edit_no.Clear;
edit_name.Clear;
edit_man.Clear;
maskedit_yusuan.Clear;
edit_no.SetFocus;//��ý���
end;


end.
