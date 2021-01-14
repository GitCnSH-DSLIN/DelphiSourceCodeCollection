unit RegSearchForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, StdCtrls, DB, ADODB, Buttons;

type
  TRegSearch = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Edit2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RegSearch: TRegSearch;

implementation

{$R *.dfm}

//---------�������룬��ѯ����Һ���Ϣ ----------
procedure TRegSearch.BitBtn1Click(Sender: TObject);
var
time1,time2:string;
begin
   if trim(edit1.Text)='' then
    time1:='1900-1-1 01:00:00'
    else
    time1:=edit1.Text;

   if trim(edit2.Text)='' then
    time2:='2099-1-1 01:00:00'
   else
    time2:=edit2.Text;

   adoquery1.Close;
   adoquery1.SQL.Clear;
   adoquery1.SQL.Add('select �Һſ���,count(���) ����,sum(�Һŷ���) �ҺŽ�� from ����Һ�');
   adoquery1.SQL.Add('where (ʱ��>'''+time1+''')and(ʱ��<'''+time2+''')');
   adoquery1.SQL.Add('group by �Һſ���');
   adoquery1.Open;



end;

//----˫���ı�����ʾǰһ���ʱʱ��͵�ǰʱ��--------
procedure TRegSearch.Edit1Click(Sender: TObject);
begin
edit1.Text:=datetostr(date-1)+' '+timetostr(time);
end;

procedure TRegSearch.Edit2Click(Sender: TObject);
begin
edit2.Text:=datetostr(date)+' '+timetostr(time);
end;

//-----��ʼ������ʱ��ʾ���йҺſ��ҵ������͹ҺŽ��---------
procedure TRegSearch.FormShow(Sender: TObject);
begin
   //�����ע��sql���group by���÷�
   adoquery1.Close;
   adoquery1.SQL.Clear;
   adoquery1.SQL.Add('select �Һſ���,count(���) ����,sum(�Һŷ���) �ҺŽ�� from ����Һ�');
   adoquery1.SQL.Add('where ʱ��>''1900-1-1 01:00:00''');
   adoquery1.SQL.Add('group by �Һſ���');
   adoquery1.Open;
end;

procedure TRegSearch.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;

end.
