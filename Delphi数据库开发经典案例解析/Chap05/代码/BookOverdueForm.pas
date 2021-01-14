unit BookOverdueForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ParentForm, ADODB, DB, ImgList, Grids, DBGrids, ComCtrls,
  ToolWin, StdCtrls, Buttons, ExtCtrls;

type
  TBookOverdue = class(TParent)
    ADOQuery2: TADOQuery;
    ADOCommand1: TADOCommand;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
   
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BookOverdue: TBookOverdue;

implementation

{$R *.dfm}

procedure TBookOverdue.FormShow(Sender: TObject);
begin
  inherited;
adotable1.Clone(adoquery2,ltunspecified);
end;


//--------------��ѯ���ڵ������Ϣ------------------
procedure TBookOverdue.BitBtn1Click(Sender: TObject);
begin
  //ע�����Ӹ������м̳����Ĵ��룬��Ϊ���������Ǵ�һ�����в�ѯ��
  //inherited;
   adoquery1.Close;
   adoquery1.SQL.Clear;
   adoquery1.SQL.Add('select a.*,b.*,c.* from ͼ����� a,ͼ����Ϣ b,������Ϣ c');
   adoquery1.SQL.Add('where (a.ͼ����=b.���)and(a.���߱��=c.���)and(״̬=''δ��'')');
   adoquery1.SQL.Add('and(c.��� like ''%'+edit1.Text+'%'')');
   adoquery1.SQL.Add('and(a.ͼ���� like ''%'+edit2.Text+'%'')');
   adoquery1.SQL.Add('and(c.���� like ''%'+edit3.Text+'%'')');
   adoquery1.Open;
   //����ѯ�õ�������ͨ��clone����Ƶ�adotable��ȥ
   adotable1.Clone(adoquery1,ltUnspecified);


end;


//------------���ñ��е��ֶο��-----------
procedure TBookOverdue.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  inherited;
  dbgrid1.Columns[0].Width:=64;
  dbgrid1.Columns[1].Width:=64;
  dbgrid1.Columns[2].Width:=166;
  dbgrid1.Columns[3].Width:=80;
  dbgrid1.Columns[4].Width:=64;
  dbgrid1.Columns[5].Width:=64;
  dbgrid1.Columns[6].Width:=64;
  dbgrid1.Columns[7].Width:=64;
  dbgrid1.Columns[8].Width:=48;
  dbgrid1.Columns[9].Width:=48;


end;

end.
