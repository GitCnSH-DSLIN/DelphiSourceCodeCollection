unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,DB, DBTables,ComCtrls, Grids, DBGrids;

type
  TForm5 = class(TForm)
    RadioGroup1: TRadioGroup;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm5.BitBtn1Click(Sender: TObject);
var s: string;
locOp:TlocateOptions;
begin
if edit2.Text=edit1.Text then {��������һ��ʱ}
begin
case radiogroup1.ItemIndex of{�ж���Ͽ��ѡ�����}
0: s:='stu' ;
1: s:='adm' ;
end ;
DataModule2.usertable.Locate('Userid',s,locop);
DataModule2.usertable.Edit;
DataModule2.usertable['passwd']:=edit1.text;
DataModule2.usertable.Post;
modalresult:=mrok;
end
else
begin
showmessage('���ε��������벻һ�£����������룡');
edit1.SetFocus;
end;
end;

end.
