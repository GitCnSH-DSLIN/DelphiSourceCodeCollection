unit UserDocuForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ParentForm, ADODB, DB, ImgList, Grids, DBGrids, ComCtrls,
  ToolWin, StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask;

type
  TUserDocu = class(TParent)
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBComboBox1: TDBComboBox;
    Label9: TLabel;
    Label10: TLabel;
    ADOQuery2: TADOQuery;
    Label11: TLabel;
    DBEdit4: TDBEdit;
    Label12: TLabel;
    DBComboBox3: TDBComboBox;
    Label13: TLabel;
    Label14: TLabel;
    DBComboBox5: TDBComboBox;
    MonthCalendar1: TMonthCalendar;
    Label15: TLabel;
    Label16: TLabel;
    DBEdit5: TDBEdit;
    Label17: TLabel;
    DBEdit6: TDBEdit;
    Label18: TLabel;
    DBEdit7: TDBEdit;
    Label19: TLabel;
    DBCheckBox1: TDBCheckBox;
    Label20: TLabel;
    DBMemo1: TDBMemo;
    DBComboBox6: TDBComboBox;
    DBComboBox7: TDBComboBox;
    DBEdit8: TDBEdit;
    DBComboBox2: TDBComboBox;
    procedure FormActivate(Sender: TObject);
    procedure DBComboBox5DropDown(Sender: TObject);
    procedure DBComboBox5Exit(Sender: TObject);
    procedure DBComboBox6DropDown(Sender: TObject);
    procedure DBComboBox6Exit(Sender: TObject);
    procedure DBComboBox7Exit(Sender: TObject);
    procedure DBComboBox7DropDown(Sender: TObject);
    procedure MonthCalendar1DblClick(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure ToolButton7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    
  end;

var
  UserDocu: TUserDocu;
  isChecked:integer;

implementation

{$R *.dfm}
//-----------���ݶ������ͱ��е����ݸ��±������С����͡��������б��------------
procedure TUserDocu.FormActivate(Sender: TObject);
var
 name:string;
begin
  inherited;
//��ö������ͱ��С����͡��ֶε���Ϣ
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select distinct ���� from ��������');
adoquery2.Open;
//��ձ������еġ����͡������б�������
dbcombobox2.Items.Clear;
//���ݲ�ѯ������Ϣ������������б��ѡ��
while not adoquery2.Eof do
 begin
  name:=adoquery2.fieldbyname('����').AsString;
  dbcombobox2.Items.Add(name);
  adoquery2.Next;
 end;

end;
//--------------��������������ʾ������--------------
procedure TUserDocu.DBComboBox5DropDown(Sender: TObject);
begin
  inherited;
 monthcalendar1.Date:=strtodate(dbcombobox5.Text);
 monthcalendar1.Top:=dbcombobox5.Top+panel2.Top-monthcalendar1.Height;
 monthcalendar1.Left:=dbcombobox5.Left;
 monthcalendar1.Visible:=true;
end;
//--------------�ر�������ʾ-----------------
procedure TUserDocu.DBComboBox5Exit(Sender: TObject);
begin
  inherited;
monthcalendar1.Visible:=false;

end;

procedure TUserDocu.DBComboBox6DropDown(Sender: TObject);
begin
  inherited;
  monthcalendar1.Date:=strtodate(dbcombobox6.Text);
 monthcalendar1.Top:=dbcombobox6.Top+panel2.Top-monthcalendar1.Height;
 monthcalendar1.Left:=dbcombobox6.Left;
 monthcalendar1.Visible:=true;
end;

procedure TUserDocu.DBComboBox6Exit(Sender: TObject);
begin
  inherited;
  monthcalendar1.Visible:=false;
end;



procedure TUserDocu.DBComboBox7DropDown(Sender: TObject);
begin
  inherited;
  monthcalendar1.Date:=strtodate(dbcombobox7.Text);
 monthcalendar1.Top:=dbcombobox7.Top+panel2.Top-monthcalendar1.Height;
 monthcalendar1.Left:=dbcombobox7.Left;
 monthcalendar1.Visible:=true;
end;
procedure TUserDocu.DBComboBox7Exit(Sender: TObject);
begin
  inherited;
  monthcalendar1.Visible:=false;
end;
//--------------˫�������ؼ�ʱѡ������----------------
procedure TUserDocu.MonthCalendar1DblClick(Sender: TObject);
begin
  inherited;
  if (panel2.Enabled=true) then
   begin
   //�ж������Ǹ������б����õ������ؼ����Ա������ֵ
     if dbcombobox5.Focused then
      dbcombobox5.Text:=datetostr(monthcalendar1.date);
     if dbcombobox6.Focused then
      dbcombobox6.Text:=datetostr(monthcalendar1.date);
     if dbcombobox6.Focused then
      dbcombobox6.Text:=datetostr(monthcalendar1.date);
   monthcalendar1.Visible:=false;
   end;
end;

procedure TUserDocu.ToolButton6Click(Sender: TObject);
var
maxnum:integer;
newnum:string;
begin
  inherited;
//��������ʾʱ��������б������Ϊ��ǰʱ��
dbcombobox5.Text:=datetostr(date);
dbcombobox6.Text:=datetostr(date);
dbcombobox7.Text:=datetostr(date);
//----------��������������¼ʱ��Ĭ������ֵ-----------
//��ʶ�û��Ƿ�ѡ���ˡ��Ƿ��ʧ����ѡ��
isChecked:=0;
//�Զ�ȷ�����û����
adoquery2.Close;
adoquery2.SQL.Clear;
adoquery2.SQL.Add('select max(���) ����� from ������Ϣ');
adoquery2.Open;
maxnum:=adoquery2.FieldByName('�����').AsInteger;
maxnum:=maxnum+1;
newnum:=inttostr(maxnum);
if length(newnum)=1 then
 dbedit2.Text:='000'+newnum;
if length(newnum)=2 then
 dbedit2.Text:='00'+newnum;
if length(newnum)=3 then
 dbedit2.Text:='0'+newnum;
//ȷ��Ĭ�ϵ�����
dbcombobox2.SelText:=dbcombobox2.Items.Strings[0];



end;

procedure TUserDocu.DBCheckBox1Click(Sender: TObject);
begin
  inherited;
isChecked:=(isChecked)or(1);//��ʾ�Ѿ�ѡ�����Ƿ��ʧ
end;

procedure TUserDocu.ToolButton10Click(Sender: TObject);
begin
 if isChecked=0 then
  begin
   showmessage('δѡ���Ƿ��ʧ��������ѡ��');
   exit;
  end;
  inherited;
  ischecked:=0;

end;

procedure TUserDocu.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  inherited;
  //���ñ���ֶο��
  dbgrid1.Columns[0].Width:=96;
  dbgrid1.Columns[1].Width:=48;
  dbgrid1.Columns[2].Width:=48;
  dbgrid1.Columns[3].Width:=32;
  dbgrid1.Columns[4].Width:=64;
  dbgrid1.Columns[5].Width:=64;
  dbgrid1.Columns[6].Width:=64;
  dbgrid1.Columns[7].Width:=80;
  dbgrid1.Columns[8].Width:=80;
  dbgrid1.Columns[9].Width:=80;
  dbgrid1.Columns[10].Width:=80;
  dbgrid1.Columns[11].Width:=80;
  dbgrid1.Columns[12].Width:=80;
  dbgrid1.Columns[13].Width:=64;
  dbgrid1.Columns[14].Width:=64;
  dbgrid1.Columns[15].Width:=64;



end;

procedure TUserDocu.ToolButton7Click(Sender: TObject);
begin
  inherited;
  //����Ҫ�ж��Ƿ�ѡ���ʧ
  ischecked:=1;

end;

end.
