unit RoomTypeForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ParentForm, ADODB, DB, ImgList, Grids, DBGrids, ComCtrls,
  ToolWin, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  TRoomType = class(TParent)
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure ToolButton6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RoomType: TRoomType;

implementation

{$R *.dfm}

procedure TRoomType.ToolButton6Click(Sender: TObject);
var
code:integer;
begin
  inherited;
  //-------------Ϊ�����Ŀͷ����������µı��------------------
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select max(���ͱ��) ����� from �ͷ�����');
  adoquery1.Open;
  code:=adoquery1.FieldByName('�����').AsInteger;
  code:=code+1;
  dbedit1.Text:=inttostr(code);
end;

end.
