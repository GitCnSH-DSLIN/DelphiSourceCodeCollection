unit BookReturnForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ParentForm, ADODB, DB, ImgList, Grids, DBGrids, ComCtrls,
  ToolWin, StdCtrls, Buttons, ExtCtrls;

type
  TBookReturn = class(TParent)
    ADOQuery2: TADOQuery;
    ADOCommand1: TADOCommand;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
   
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BookReturn: TBookReturn;

implementation

{$R *.dfm}

procedure TBookReturn.FormShow(Sender: TObject);
begin
  inherited;
adotable1.Clone(adoquery2,ltunspecified);
end;


//--------------��ѯδ�黹�������Ϣ------------------
procedure TBookReturn.BitBtn1Click(Sender: TObject);
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
//----------���ô�����̣��黹ͼ��-------------
procedure TBookReturn.BitBtn2Click(Sender: TObject);
var
 returndate:TDateTime;
 money:double;
 forfeit,num:string;
begin
  inherited;
  returndate:=adotable1.FieldByName('Ӧ��ʱ��').AsDateTime;
  num:=adotable1.FieldByName('���ı��').AsString;
  //�����ѯ�޽�������ܹ黹ͼ��
  if num='' then exit;
  if (date+time-returndate)>0 then
   begin
     //���㷣���ÿ��0.2Ԫ����ȻҲ�����������㷨
     money:=0.2*(date-returndate);
     //�����޸ķ����ֵ
     forfeit:= InputBox('�����Ѿ����ڣ��轻�ɷ���', 'Ӧ���ɵķ�������', floattostr(money));
     adocommand1.CommandText:='exec sf_ͼ��黹 '+num+','+forfeit;
   end
   else
    adocommand1.CommandText:='exec sf_ͼ��黹 '+num+',0';
   adocommand1.Execute;
  //ˢ������
  adoquery2.Active:=false;
  adoquery2.Active:=true;
  adotable1.Clone(adoquery2,ltunspecified);
end;

//------------���ñ��е��ֶο��-----------
procedure TBookReturn.DataSource1DataChange(Sender: TObject; Field: TField);
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
