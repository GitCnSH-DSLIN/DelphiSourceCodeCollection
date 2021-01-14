unit photo_cateloge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, DB, ADODB,mmsystem;

type
  Tcateloge_photo = class(TForm)
    Edit1: TEdit;
    Bevel1: TBevel;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ADOQuery1: TADOQuery;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cateloge_photo: Tcateloge_photo;

implementation
   uses main,pic;
{$R *.dfm}


{�Զ����������ź���}
function PlayWav(const FileName: string): Boolean;
begin
Result := PlaySound(PChar(FileName), 0, SND_ASYNC);
end;

procedure Tcateloge_photo.BitBtn1Click(Sender: TObject);
var text:string;
begin
text:=trim(edit1.Text);
if text='' then
begin
playwav('sound\error.wav');
messagebox(handle,'Ŀ¼����Ϊ�գ�','����',MB_OK+MB_ICONERROR);
exit;
end;
with ADOQuery1 do
begin
  close;
  sql.Clear;
  sql.Add('select * from photo_cateloge where dir="'+text+'"');
  prepared;
  open;
end;
if  ADOQuery1.RecordCount<>0 then
begin
playwav('sound\error.wav');
messagebox(handle,'��Ŀ¼�Ѿ����ڣ���ѡ���������ƣ�' ,'����',MB_OK+MB_ICONERROR);
exit;
end
else
begin
 with ADOQuery1 do
begin
  close;
  sql.Clear;
  sql.Add('select * from  photo_cateloge');
  prepared;
  open;
  append;
  edit;
  FieldValues['dir']:=text;
  post;
end;
pic_form.Button2click(self);
edit1.Text:='';
playwav('sound\sucess.wav');
IF messagebox(handle,'Ŀ¼�����ɹ����Ƿ����������' ,'��ʾ',MB_YESNO+MB_ICONINFORMATION)=ID_NO then
close;
end;
end;

end.
