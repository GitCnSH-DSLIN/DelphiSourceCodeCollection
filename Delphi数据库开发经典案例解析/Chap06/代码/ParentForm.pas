unit ParentForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ToolWin, StdCtrls, Buttons, ExtCtrls, DB,
  ADODB, Grids, DBGrids;

type
  TParent = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    BitBtn1: TBitBtn;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ImageList1: TImageList;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    ADOTable1: TADOTable;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetButton(val:integer);
  end;

var
  Parent: TParent;

implementation

{$R *.dfm}
//��ʾ���ݱ��е�ǰ���ݵ�����
procedure TParent.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  //��ʾ��������
  label2.Caption:=inttostr(adotable1.RecordCount);
end;


//----------------ת����һ����¼------------------------
procedure TParent.ToolButton1Click(Sender: TObject);
begin
 datasource1.DataSet.First;
end;
//----------------ת����һ����¼------------------------
procedure TParent.ToolButton2Click(Sender: TObject);
begin
 datasource1.DataSet.Prior;
end;
//----------------ת����һ����¼------------------------
procedure TParent.ToolButton3Click(Sender: TObject);
begin
 datasource1.DataSet.Next;
end;
//----------------ת�����һ����¼------------------------
procedure TParent.ToolButton4Click(Sender: TObject);
begin
 datasource1.DataSet.Last;
end;
//----------------������¼------------------------
procedure TParent.ToolButton6Click(Sender: TObject);
begin
 datasource1.DataSet.Append;
 SetButton(0);

end;
//----------------�༭��¼------------------------
procedure TParent.ToolButton7Click(Sender: TObject);
begin
 datasource1.Edit;
 SetButton(0);
end;
//----------------ɾ����¼------------------------
procedure TParent.ToolButton8Click(Sender: TObject);
begin
 if application.MessageBox('�Ƿ�ɾ����¼��','ȷ��',MB_OKCANCEL)=IDOK then
  datasource1.DataSet.Delete;
end;
//----------------�ύ����------------------------
procedure TParent.ToolButton10Click(Sender: TObject);
begin
 if datasource1.DataSet.State in [dsEdit,dsInsert] then
   begin
   datasource1.DataSet.Post;
   SetButton(1);
   end;


end;
//----------------ȡ������------------------------
procedure TParent.ToolButton11Click(Sender: TObject);
begin
 datasource1.DataSet.Cancel;
 SetButton(1);
end;
//----------------�رմ���------------------------
procedure TParent.ToolButton13Click(Sender: TObject);
begin
 close;
end;
//----------------���ð�ť״̬------------------------
procedure TParent.SetButton(val: integer);
begin
if val=0 then
 (*���������޸ģ�ɾ���Լ��׼�¼���ϼ�¼���¼�¼��β��¼�Ȱ�ťenable����Ϊfalse
 �������棬ȡ������ťenable��������Ϊtrue*)
 begin
  toolbutton1.Enabled:=false;
  toolbutton2.Enabled:=false;
  toolbutton3.Enabled:=false;
  toolbutton4.Enabled:=false;
  toolbutton6.Enabled:=false;
  toolbutton7.Enabled:=false;
  toolbutton8.Enabled:=false;
  toolbutton10.Enabled:=true;
  toolbutton11.Enabled:=true;
  //�򿪰������ݿ�ؼ���enable����
  panel2.Enabled:=true;
  //�������ݱ�
  dbgrid1.Enabled:=false;
  
 end
else
 (*���������޸ģ�ɾ���Լ��׼�¼���ϼ�¼���¼�¼��β��¼�Ȱ�ťenable����Ϊtrue
 �������棬ȡ������ťenable��������Ϊfalse*)
 begin
    toolbutton1.Enabled:=true;
    toolbutton2.Enabled:=true;
    toolbutton3.Enabled:=true;
    toolbutton4.Enabled:=true;
    toolbutton6.Enabled:=true;
    toolbutton7.Enabled:=true;
    toolbutton8.Enabled:=true;
    toolbutton10.Enabled:=false;
    toolbutton11.Enabled:=false;
    //�رհ������ݿ�ؼ���enable����
    panel2.Enabled:=false;
    dbgrid1.Enabled:=true;

  end;

end;
//----------���ùرմ���ʱ�Ķ���--------------
procedure TParent.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;

//----------���ݴ����в�ѯ��������������ѯ--------------
procedure TParent.BitBtn1Click(Sender: TObject);
var
(*����һ��������������Ƶ���λ�ֱ�����ѯ����1��3
��ĳһ����ѯ�����ɼ���Ҳ����Ҫʹ���������ʱ����Ӧ��λ��Ϊ1��������0
�����1��2������Ҫʹ�ö���3����ʹ��ʱ�������������Ƶ�ֵΪ110��Ҳ����6*)
condition:integer;
begin

//��ʼ���ò�������Ϊ7����������Ϊ111
 condition:=7;
//�����1�����������ã��򽫸�λ��0�������Ǻ�����3��������011�����������
if label3.Visible=false then
 condition:=(condition)and(3);

 //�����2�����������ã��򽫸�λ��0�������Ǻ�����5��������101�����������
if label4.Visible=false then
 condition:=(condition)and(5);

 //�����3�����������ã��򽫸�λ��0�������Ǻ�����6��������110�����������
if label5.Visible=false then
 condition:=(condition)and(6);

if condition=7 then//������ѯ���������ڵ����
 begin
   adoquery1.Close;
   adoquery1.SQL.Clear;
   adoquery1.SQL.Add('select * from '+adotable1.TableName);
   adoquery1.SQL.Add(' where('+label3.Caption+' like ''%'+edit1.Text+'%'')');
   adoquery1.SQL.Add('and('+label4.Caption+' like ''%'+edit2.Text+'%'')');
   adoquery1.SQL.Add('and('+label5.Caption+' like ''%'+edit3.Text+'%'')');
   adoquery1.Open;
   //����ѯ�õ�������ͨ��clone����Ƶ�adotable��ȥ
   adotable1.Clone(adoquery1,ltUnspecified);

 end;

if condition=6 then//ֻ����������ѯ���������
 begin
   adoquery1.Close;
   adoquery1.SQL.Clear;
   adoquery1.SQL.Add('select * from '+adotable1.TableName);
   adoquery1.SQL.Add(' where('+label3.Caption+' like ''%'+edit1.Text+'%'')');
   adoquery1.SQL.Add('and('+label4.Caption+' like ''%'+edit2.Text+'%'')');
   adoquery1.Open;
   //����ѯ�õ�������ͨ��clone����Ƶ�adotable��ȥ
   adotable1.Clone(adoquery1,ltUnspecified);

 end;

if condition=4 then //ֻ����һ����ѯ���������
 begin
   adoquery1.Close;
   adoquery1.SQL.Clear;
   adoquery1.SQL.Add('select * from '+adotable1.TableName);
   adoquery1.SQL.Add(' where('+label3.Caption+' like ''%'+edit1.Text+'%'')');
   adoquery1.Open;
   //����ѯ�õ�������ͨ��clone����Ƶ�adotable��ȥ
   adotable1.Clone(adoquery1,ltUnspecified);
 end;
end;

end.
