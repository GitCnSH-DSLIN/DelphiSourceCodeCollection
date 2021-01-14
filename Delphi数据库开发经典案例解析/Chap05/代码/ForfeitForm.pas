unit ForfeitForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ParentForm, ADODB, DB, ImgList, Grids, DBGrids, ComCtrls,
  ToolWin, StdCtrls, Buttons, ExtCtrls;

type
  TForFeit = class(TParent)
    ADOQuery2: TADOQuery;
    ADOCommand1: TADOCommand;
    BitBtn2: TBitBtn;
    Edit4: TEdit;
    Label6: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
   
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ForFeit: TForFeit;

implementation

{$R *.dfm}

procedure TForFeit.FormShow(Sender: TObject);
begin
  inherited;
  adotable1.Clone(adoquery2,ltunspecified);
end;


//--------------��ѯ������Ϣ------------------
procedure TForFeit.BitBtn1Click(Sender: TObject);
begin
  //ע�����Ӹ������м̳����Ĵ��룬��Ϊ���������Ǵ�һ�����в�ѯ��
  //inherited;
   adoquery1.Close;
   adoquery1.SQL.Clear;


   adoquery1.SQL.Add('select a.*,b.����,c.���� from ͼ�鷣�� a,������Ϣ b,ͼ����Ϣ c');
   adoquery1.SQL.Add('where (a.���߱��=b.���)and(a.�Ƿ񽻿�=0)and(a.ͼ����=c.���)');
   adoquery1.SQL.Add('and(a.���߱�� like ''%'+edit1.Text+'%'')');
   adoquery1.SQL.Add('and(a.ͼ���� like ''%'+edit2.Text+'%'')');
   adoquery1.SQL.Add('and(b.���� like ''%'+edit3.Text+'%'')');
   adoquery1.Open;
   //����ѯ�õ�������ͨ��clone����Ƶ�adotable��ȥ
   adotable1.Clone(adoquery1,ltUnspecified);


end;
//----------���ô�����̣��ջط���-------------
procedure TForFeit.BitBtn2Click(Sender: TObject);
begin
 //ʵ�ս��Ϊ��˵�������տ�򲻽��д���
 if edit4.Text='' then exit;
 adocommand1.CommandText:='update ͼ�鷣�� set ʵ�ս��=cast('''+edit4.Text+''' as money),�Ƿ񽻿�=1 where ������='''+dbgrid1.Fields[0].Text+'''';
 adocommand1.Execute;
 adoquery2.Active:=false;
 adoquery2.Active:=true;
 adotable1.Clone(adoquery2,ltunspecified);
end;

//------------���ñ��е��ֶο��-----------
procedure TForFeit.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  inherited;
  dbgrid1.Columns[0].Width:=64;
  dbgrid1.Columns[1].Width:=64;
  dbgrid1.Columns[2].Width:=64;
  dbgrid1.Columns[3].Width:=80;
  dbgrid1.Columns[4].Width:=164;
  dbgrid1.Columns[5].Width:=64;
  dbgrid1.Columns[6].Width:=64;
  dbgrid1.Columns[7].Width:=64;
  dbgrid1.Columns[8].Width:=48;
  dbgrid1.Columns[9].Width:=48;
  //��ʾʵ�ս��Ĭ��ֵ
  edit4.Text:=dbgrid1.Fields[6].Text;


end;
//���ơ�ʵ�ս��ı�����ֻ����������
procedure TForFeit.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
 if(key>=#30)and(key<=#39) then
  edit4.Text:=edit4.Text+key;
end;

end.
