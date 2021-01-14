unit MedSendForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, ExtCtrls, ImgList,
  ComCtrls, ToolWin, Buttons;

type
  TMedSend = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Edit4: TEdit;
    DataSource1: TDataSource;
    ADOConnection1: TADOConnection;
    DBGrid1: TDBGrid;
    ADODataSet1: TADODataSet;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    ADOQuery1: TADOQuery;
    BitBtn1: TBitBtn;
    ADOCommand1: TADOCommand;
    BitBtn2: TBitBtn;
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure DataSource2DataChange(Sender: TObject; Field: TField);



    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit3DblClick(Sender: TObject);
    procedure Edit4DblClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MedSend: TMedSend;

implementation

{$R *.dfm}
//-----������ʾ�Ĳ��˵����ﻮ�۵���ʾ�仮��ҩƷ��ҽ����Ŀ��ϸ-----
procedure TMedSend.DataSource1DataChange(Sender: TObject; Field: TField);
var
num:string;//���滮�۱��
begin
 //�������ﵥ����ֶο��
 dbgrid1.Columns[0].Width:=80;
 dbgrid1.Columns[1].Width:=48;
 dbgrid1.Columns[2].Width:=32;
 dbgrid1.Columns[3].Width:=48;
 dbgrid1.Columns[4].Width:=48;
 dbgrid1.Columns[5].Width:=48;
 dbgrid1.Columns[6].Width:=48;
 dbgrid1.Columns[7].Width:=80;
 dbgrid1.Columns[8].Width:=48;
 dbgrid1.Columns[9].Width:=48;
 dbgrid1.Columns[10].Width:=80;
 dbgrid1.Columns[11].Width:=48;
 num:=trim(dbgrid1.Fields[0].Text);

 adoquery1.Close;
 adoquery1.SQL.Clear;
 adoquery1.SQL.Add('select distinct a.���,a.ҩƷ���,b.����,a.����,a.����,a.��� from ���ﻮ����ϸ a,v�շ���Ŀ��ҩƷ b');
 adoquery1.SQL.Add(' where (a.ҩƷ���=b.���)and(a.���۱��='''+num+''')');
 adoquery1.Open;
end;

//-----����ҩƷ��������ֶο��-----
procedure TMedSend.DataSource2DataChange(Sender: TObject; Field: TField);
var
i:integer;
begin
 for i:=0 to 5 do
  dbgrid2.Columns[i].Width:=80;
end;



procedure TMedSend.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;

//--------��ѯ�������շѵ����ﵥ----------
procedure TMedSend.BitBtn1Click(Sender: TObject);
var
time1,time2:string;
begin
   //���շѴ����й�����ͬ���������ò�ѯʱ���Ĭ��ֵ
   if trim(edit3.Text)='' then
    time1:='1900-1-1 01:00:00'
    else
    time1:=edit3.Text;

   if trim(edit4.Text)='' then
    time2:='2099-1-1 01:00:00'
   else
    time2:=edit4.Text;

   adoquery1.Close;
   adoquery1.SQL.Clear;
   adoquery1.SQL.Add('select a.* ,b.����,b.�Ա� from ���ﻮ�� a, ����Һ� b');
   adoquery1.SQL.Add(' where (a.�Һű��=b.���)and(a.�Ƿ��շ�=''��'')and(a.�Ƿ�ҩ=''��'')');
   adoquery1.SQL.Add('and(a.��� like ''%'+edit1.Text+'%'')');
   adoquery1.SQL.Add('and(b.���� like ''%'+edit2.Text+'%'')');
   adoquery1.SQL.Add('and(a.����ʱ��>'''+time1+''')and(a.����ʱ��<'''+time2+''')');
   adoquery1.Open;
   //����ѯ�õ�������ͨ��clone����Ƶ�����ȥ
   adodataset1.Clone(adoquery1,ltUnspecified);
end;

//----˫���ı�����ʾ֮ǰ8Сʱʱ��͵�ǰʱ��------
procedure TMedSend.Edit3DblClick(Sender: TObject);
begin
edit3.Text:=datetostr(date)+' '+timetostr(time-0.5);
end;

procedure TMedSend.Edit4DblClick(Sender: TObject);
begin
edit4.Text:=datetostr(date)+' '+timetostr(time);
end;

//-----ѡ��ĳ�����ˣ�ִ�з�ҩ�������-------
procedure TMedSend.BitBtn2Click(Sender: TObject);
var
id:string;
begin
 id:=trim(dbgrid1.Fields[0].Text);
 if id='' then
  begin
   showmessage('��ѡ��һ�������ٷ�ҩ');
   exit;
  end;
  adocommand1.CommandText:='exec sf_ҩƷ���� '+id;
  adocommand1.Execute;
  adodataset1.Active:=false;
  adodataset1.Active:=true;


end;

end.
