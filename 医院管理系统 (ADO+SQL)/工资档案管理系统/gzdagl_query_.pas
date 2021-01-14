unit gzdagl_query_;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, DBCtrls, Grids, DBGrids, Buttons;

type
  TForm_query = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Bevel1: TBevel;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    RadioButton_bh: TRadioButton;
    RadioButton_name: TRadioButton;
    RadioButton_bm: TRadioButton;
    Label1: TLabel;
    Edit_query: TEdit;
    query_BTquery: TBitBtn;
    query_BTdy: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox6: TCheckBox;
    query_BTxz: TBitBtn;
    TabSheet2: TTabSheet;
    GroupBox4: TGroupBox;
    Label2: TLabel;
    Edit_gzxx_no: TEdit;
    gzxx_BTquery: TBitBtn;
    gzxx_BTprint: TBitBtn;
    Bevel2: TBevel;
    DBGrid2: TDBGrid;
    DBNavigator2: TDBNavigator;
    TabSheet3: TTabSheet;
    GroupBox5: TGroupBox;
    Label3: TLabel;
    Edit_btxx_no: TEdit;
    btxx_BTquery: TBitBtn;
    btxx_BTprint: TBitBtn;
    Bevel3: TBevel;
    DBGrid3: TDBGrid;
    DBNavigator3: TDBNavigator;
    procedure RadioButton_bhClick(Sender: TObject);
    procedure RadioButton_nameClick(Sender: TObject);
    procedure RadioButton_bmClick(Sender: TObject);
    procedure query_BTqueryClick(Sender: TObject);
    procedure query_BTxzClick(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure query_BTdyClick(Sender: TObject);
    procedure gzxx_BTqueryClick(Sender: TObject);
    procedure gzxx_BTprintClick(Sender: TObject);
    procedure btxx_BTqueryClick(Sender: TObject);
    procedure btxx_BTprintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_query: TForm_query;
   selectstr:string;// ����һ��ȫ�ֱ���selectstr�����ڱ����ѯ����
implementation

uses gzdagl_DM_, gzdagl_yg_print_, gzdagl_yggongzi_print_,
  gzdagl_ygbt_print_;



{$R *.dfm}

procedure TForm_query.RadioButton_bhClick(Sender: TObject);
begin
label1.Caption:='Ա�����';           //��ʾ��Ա����Ų�
selectstr:='from ְԱ�� where Ա�����=';
end;

procedure TForm_query.RadioButton_nameClick(Sender: TObject);
begin
label1.Caption:='Ա������';
selectstr:='from ְԱ�� where Ա������=';
end;

procedure TForm_query.RadioButton_bmClick(Sender: TObject);
begin
label1.Caption:='��������';
selectstr:='from ְԱ�� where ��������=';
end;

procedure TForm_query.query_BTqueryClick(Sender: TObject);
var
sqlstr:string;
begin
sqlstr:='';//��ʼ��
  if checkbox1.Checked then sqlstr:=sqlstr+'Ա������,';
  if checkbox2.Checked then sqlstr:=sqlstr+'ְλ,';
  if checkbox3.Checked then sqlstr:=sqlstr+'�绰,';
  if checkbox4.Checked then sqlstr:=sqlstr+'�Ա�,';
  if checkbox5.Checked then sqlstr:=sqlstr+'��������,';
  if checkbox6.Checked then sqlstr:=sqlstr+'����,';
  if checkbox7.Checked then sqlstr:=sqlstr+'ѧ��,';
  //�����û��ѡ�����ѡ���ˡ�ȫ����Ϣ�������ѯȫ����Ϣ
  if (checkbox8.Checked) or (sqlstr='') then sqlstr:='*';
  if sqlstr<>'*' then delete(sqlstr,length(sqlstr),1);//ɾ������
  DMgzdagl.ADOQemployee.Close;
  DMgzdagl.ADOQemployee.SQL.Clear;//�����
  if edit_query.text<>''then
    begin
      selectstr:=selectstr+''''+edit_query.Text+'''';
      DMgzdagl.ADOQemployee.SQL.Add('select '+sqlstr+' '+selectstr);
    end
   else
      DMgzdagl.ADOQemployee.SQL.Add('select '+sqlstr+' from ְԱ��');//���û���������ѯȫ��
      DMgzdagl.ADOQemployee.Open;//ִ�в�ѯ

   //���û���ҵ���¼
   if DMgzdagl.ADOQemployee.RecordCount=0 then showmessage('û���ҵ��κμ�¼');

end;

procedure TForm_query.query_BTxzClick(Sender: TObject);
var
i:integer;
begin
  for i:=0 to GroupBox3.ControlCount-1 do  //groupbox3�ȡ��鿴���ݡ�
   //groupbox3��Ŀؼ�������Tcheckbox
     if (groupbox3.Controls[i] is Tcheckbox) then begin
       (groupbox3.Controls[i] as Tcheckbox).Enabled:=true;
       (groupbox3.Controls[i] as Tcheckbox).Checked:=false;
end;

end;

procedure TForm_query.CheckBox8Click(Sender: TObject);
var
i:integer;
begin
  for i:=0 to groupbox3.ControlCount-1 do
   if (groupbox3.Controls[i] is Tcheckbox) then
    //�ܿ�checkbox8
     if (groupbox3.Controls[i] as Tcheckbox).name<>'checkbox8' then
     if not checkbox8.Checked then begin
     (groupbox3.Controls[i] as tcheckbox).Enabled:=true;
     (groupbox3.Controls[i] as tcheckbox).Checked:=false;
     end
     else begin
       (groupbox3.Controls[i] as Tcheckbox).Enabled:=false;
       (groupbox3.Controls[i] as Tcheckbox).Checked:=true;
       end;
end;

procedure TForm_query.FormCreate(Sender: TObject);
begin
selectstr:='from ְԱ�� where Ա�����=';

end;

procedure TForm_query.query_BTdyClick(Sender: TObject);
begin
form_yg_print.QuickRep1.Preview;
end;

procedure TForm_query.gzxx_BTqueryClick(Sender: TObject);
var
str:string;
begin
  str:='';
  if (length(edit_gzxx_no.Text)=0) then
    str:='select * from нˮ��'
  else
    str:='select * from нˮ�� where Ա�����='+''''+edit_gzxx_no.Text+'''';
    DMgzdagl.ADOQgongzi.Close;
    DMgzdagl.ADOQgongzi.SQL.Clear;
    DMgzdagl.ADOQgongzi.SQL.Add(str);
    DMgzdagl.ADOQgongzi.Open;
    if DMgzdagl.ADOQgongzi.RecordCount=0 then
      showmessage('û���ҵ��κ��Ǻ͵ļ�¼');
end;

procedure TForm_query.gzxx_BTprintClick(Sender: TObject);
begin
form_yggongzi_print.QuickRep1.Preview;
end;

procedure TForm_query.btxx_BTqueryClick(Sender: TObject);
var
str:string;
begin
  str:='';
  if (length(edit_btxx_no.Text)=0) then
    str:='select * from ������'
  else
    str:='select * from ������ where Ա�����='+''''+edit_btxx_no.Text+'''';
    DMgzdagl.ADOQbutie .Close;
    DMgzdagl.ADOQbutie .SQL.Clear;
    DMgzdagl.ADOQbutie .SQL.Add(str);
    DMgzdagl.ADOQbutie .Open;
    if DMgzdagl.ADOQbutie .RecordCount=0 then
      showmessage('û���ҵ��κ��Ǻ͵ļ�¼');
end;

procedure TForm_query.btxx_BTprintClick(Sender: TObject);
begin
form_ygbt_print.QuickRep1.Preview;
end;

end.
