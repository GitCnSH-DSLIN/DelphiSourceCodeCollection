unit BookOrderForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ParentForm, ADODB, DB, ImgList, Grids, DBGrids, ComCtrls,
  ToolWin, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  TBookOrder = class(TParent)
    DBEdit1: TDBEdit;
    Label6: TLabel;
    DBEdit2: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit4: TDBEdit;
    Label9: TLabel;
    DBEdit5: TDBEdit;
    Label10: TLabel;
    Label11: TLabel;
    DBEdit6: TDBEdit;
    Label12: TLabel;
    DBEdit7: TDBEdit;
    Label13: TLabel;
    DBEdit8: TDBEdit;
    Label14: TLabel;
    DBEdit9: TDBEdit;
    Label15: TLabel;
    Edit4: TEdit;
    BitBtn2: TBitBtn;
    Label16: TLabel;
    DBComboBox1: TDBComboBox;
    BitBtn3: TBitBtn;
    ADOCommand1: TADOCommand;
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure ToolButton6Click(Sender: TObject);
    procedure DBEdit6KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit7KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBEdit2Change(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BookOrder: TBookOrder;

implementation

{$R *.dfm}

uses ChooseForm,MainForm;

procedure TBookOrder.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  inherited;

  //���ñ���ֶο��
  dbgrid1.Columns[0].Width:=80;
  dbgrid1.Columns[1].Width:=80;
  dbgrid1.Columns[2].Width:=80;
  dbgrid1.Columns[3].Width:=96;
  dbgrid1.Columns[4].Width:=80;
  dbgrid1.Columns[5].Width:=80;
  dbgrid1.Columns[6].Width:=96;
  dbgrid1.Columns[7].Width:=80;



end;

procedure TBookOrder.ToolButton6Click(Sender: TObject);
var
maxnum:integer;
newnum:string;
begin
  inherited;
  //�Զ�ȷ�����û����
adoquery1.Close;
adoquery1.SQL.Clear;
adoquery1.SQL.Add('select max(�������) ����� from ͼ������');
adoquery1.Open;
maxnum:=adoquery1.FieldByName('�����').AsInteger;
maxnum:=maxnum+1;
newnum:=inttostr(maxnum);
if length(newnum)=1 then
 dbedit1.Text:='000000'+newnum;
if length(newnum)=2 then
 dbedit1.Text:='00000'+newnum;
if length(newnum)=3 then
 dbedit1.Text:='0000'+newnum;
if length(newnum)=4 then
 dbedit1.Text:='000'+newnum;
if length(newnum)=5 then
 dbedit1.Text:='00'+newnum;
if length(newnum)=6 then
 dbedit1.Text:='0'+newnum;
//���뵱ǰʱ��
dbedit8.Text:=datetostr(date)+' '+timetostr(time);
//�¼����ͼ�鶼��δ���յģ����Դ��������false
dbcombobox1.SelText:='False';
end;


//----------------�����ڶ��������Ͷ��������ı�����ֻ����������------------------
procedure TBookOrder.DBEdit6KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
if(key<=#39)and(key>=#30) then
 dbedit6.Text:=dbedit6.Text+key;
end;

procedure TBookOrder.DBEdit7KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
if(key<=#39)and(key>=#30) then
 dbedit7.Text:=dbedit7.Text+key;
end;

procedure TBookOrder.BitBtn2Click(Sender: TObject);
var
newform:Tchoose;
begin
  inherited;
  newform:=Tchoose.Create(application);



end;



procedure TBookOrder.FormActivate(Sender: TObject);
begin
 if panel2.Enabled=true then
 dbedit2.Text:=main.storestr;
end;

procedure TBookOrder.DBEdit2Change(Sender: TObject);
begin
  inherited;
  //������������ʾ
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select ���� from ͼ����Ϣ where ���='''+dbedit2.Text+'''');
  adoquery1.Open;
  edit4.Text:=adoquery1.FieldByName('����').AsString;
end;

procedure TBookOrder.BitBtn3Click(Sender: TObject);
begin
  inherited;
  //�ύ����
  adocommand1.CommandText:='exec sf_ͼ������';
  adocommand1.Execute;
  //ˢ������

  adotable1.Active:=false;
  adotable1.Active:=true;
end;

end.
