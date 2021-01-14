unit StoreSearchForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ParentForm, ADODB, DB, ImgList, Grids, DBGrids, ComCtrls,
  ToolWin, StdCtrls, Buttons, ExtCtrls;

type
  TStoreSearch = class(TParent)
    procedure FormShow(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StoreSearch: TStoreSearch;

implementation

{$R *.dfm}

//----��ʾ����ʱ��ʾҩƷ������ƺ���ϸ��Ϣ -----
procedure TStoreSearch.FormShow(Sender: TObject);
begin
  inherited;
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select b.����,a.* from ҩƷ��� a,ҩƷ���� b');
  adoquery1.SQL.Add('where a.ҩƷ���=b.���');
  adoquery1.Open;
  adotable1.Clone(adoquery1,ltUnspecified);
end;

//�������ݱ��ֶο��
procedure TStoreSearch.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  inherited;
  dbgrid1.Columns[0].Width:=64;
  dbgrid1.Columns[1].Width:=128;
  dbgrid1.Columns[2].Width:=64;
  dbgrid1.Columns[3].Width:=64;
  dbgrid1.Columns[4].Width:=64;
  dbgrid1.Columns[5].Width:=256;

end;

//---��ʹ�ôӸ�����̳еĲ�ѯ���룬�Լ���д����ʵ�ֹ���----
procedure TStoreSearch.BitBtn1Click(Sender: TObject);
var
str:string;
begin
 //inherited;�ڱ�д����ʱ������ɾ��������
 str:='';
 if trim(edit1.Text)<>'' then
  str:=str+'�ⷿ like ''%'+edit1.Text+'%'' and ';
 if trim(edit2.Text)<>'' then
  str:=str+'ҩƷ��� like ''%'+edit2.Text+'%'' and ';
  if trim(edit3.Text)<>'' then
  str:=str+'���� like ''%'+edit3.Text+'%'' and ';

 str:=copy(str,1,length(str)-4);//ȥ����Ϻ����һ��and+�ո�
 adotable1.Filter:=str;
 adotable1.Filtered:=true;

end;

end.
