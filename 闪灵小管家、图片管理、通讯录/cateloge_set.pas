unit cateloge_set;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, DB, ADODB,mmsystem;

type
  Tset_cateloge = class(TForm)
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    ADOQuery2: TADOQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  set_cateloge: Tset_cateloge;

implementation
   uses main,notebook;
{$R *.dfm}
{�Զ����������ź���}
function PlayWav(const FileName: string): Boolean;
begin
Result := PlaySound(PChar(FileName), 0, SND_ASYNC);
end;

procedure Tset_cateloge.BitBtn1Click(Sender: TObject);
begin
if trim(edit1.Text)='' then
begin
 edit1.Text:='';
 playwav('sound\error.wav');
 messagebox(handle,'����д����,���ñ������','��ʾ',MB_OK+MB_ICONERROR);
 exit;
end;
with ADOQuery1 do
begin
  close;
  sql.Clear;
  sql.Add('select cateloge from cateloge where cateloge="'+trim(edit1.Text)+'"');
  open;
end;
if not ADOQuery1.Eof then
begin
 playwav('sound\error.wav');
 messagebox(handle,'�˷����Ѵ���','��ʾ',MB_OK+MB_ICONERROR);
 exit;
end;
with ADOQuery1 do
begin
  close;
  sql.Clear;
  sql.Add('insert  into cateloge (cateloge) values("'+trim(edit1.Text)+'")');
  Execsql;
  close;
  sql.Clear;
  sql.Add('select * from cateloge');
  open;
end;
edit1.Text:='';
end;

procedure Tset_cateloge.BitBtn2Click(Sender: TObject);
begin
if not ADOQuery1.Eof then
begin
playwav('sound\info.wav');
if  messagebox(handle,'ɾ�����ཫɾ���˷����µ��������ݣ�'+#13#10+'��ȷ��Ҫɾ����������','����',MB_YESNO+MB_ICONQUESTION)=ID_YES then
begin
with ADOQuery2 do
begin
close;
sql.Clear;
sql.Add('delete * from notebook where cateloge="'+ADOQuery1.FieldValues['cateloge']+'"');
prepared;
Execsql;
end;
ADOQuery1.Delete;
end;
 end;
end;

procedure Tset_cateloge.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
notebook_form.showdataclick(self);
end;

end.
