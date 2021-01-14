unit gzdagl_gongzi_;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons, Grids, DBGrids, DBCtrls;

type
  TForm_gongzi = class(TForm)
    pagecontrol1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit_no: TEdit;
    Edit_jbie: TEdit;
    Edit_gangwei: TEdit;
    Edit_base: TEdit;
    Edit_gongling: TEdit;
    Edit_other: TEdit;
    Edit_zhiwu: TEdit;
    Bevel1: TBevel;
    gongzi_BTyes: TBitBtn;
    gongzi_BTno: TBitBtn;
    gongzi_BTnext: TBitBtn;
    GroupBox1: TGroupBox;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    Label8: TLabel;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Edit_butie_no: TEdit;
    Edit_yiliao: TEdit;
    Edit_zonghe: TEdit;
    Edit_wucan: TEdit;
    Edit_fudong: TEdit;
    Edit_oth: TEdit;
    Edit_zhufang: TEdit;
    Edit_tebie: TEdit;
    butie_BTyes: TBitBtn;
    butie_BTno: TBitBtn;
    Bevel2: TBevel;
    butie_BTnext: TBitBtn;
    GroupBox2: TGroupBox;
    DBNavigator2: TDBNavigator;
    DBGrid2: TDBGrid;
    Label17: TLabel;
    TabSheet3: TTabSheet;
    Panel3: TPanel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Edit_kouchu_no: TEdit;
    Edit_yanglao: TEdit;
    Edit_kouchu_yiliao: TEdit;
    Edit_house: TEdit;
    Edit_kouchu_other: TEdit;
    kouchu_BTyes: TBitBtn;
    kouchu_BTno: TBitBtn;
    kouchu_BTnext: TBitBtn;
    Bevel3: TBevel;
    GroupBox3: TGroupBox;
    DBGrid3: TDBGrid;
    DBNavigator3: TDBNavigator;
    Label23: TLabel;
    TabSheet4: TTabSheet;
    Panel4: TPanel;
    Label24: TLabel;
    Edit_yggongzi_no: TEdit;
    yggongzi_BT_jisuan: TBitBtn;
    yggongzi_BT_add: TBitBtn;
    GroupBox4: TGroupBox;
    DBNavigator4: TDBNavigator;
    DBGrid4: TDBGrid;
    procedure gongzi_BTyesClick(Sender: TObject);
    procedure Edit_noChange(Sender: TObject);
    procedure gongzi_BTnoClick(Sender: TObject);
    
    procedure gongzi_BTnextClick(Sender: TObject);
    procedure butie_BTyesClick(Sender: TObject);
    procedure Edit_butie_noChange(Sender: TObject);
    procedure butie_BTnoClick(Sender: TObject);
    procedure butie_BTnextClick(Sender: TObject);
    procedure Edit_kouchu_noChange(Sender: TObject);
    procedure kouchu_BTyesClick(Sender: TObject);
    procedure kouchu_BTnoClick(Sender: TObject);
    procedure kouchu_BTnextClick(Sender: TObject);
    procedure yggongzi_BT_jisuanClick(Sender: TObject);
    procedure yggongzi_BT_addClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    function yggongzi_jisuan(const s_no:string):boolean;//����yggongzi_jisuan����
    function zq:boolean;//�����ж������Ƿ������ĺ���
  public
    { Public declarations }
  end;

var
  Form_gongzi: TForm_gongzi;

implementation

uses gzdagl_DM_;

{$R *.dfm}
//����zq����
  function Tform_gongzi.zq:boolean;
    var i:integer;//ѭ������
        t:boolean;//�м����
        bh:string;
    begin
      result:=false;   //��ʼ��Ϊ����������
      //Ч��Ԥ�㹤�ʺ�Ԥ�㲹����¼�Ƿ����
      t:=DMgzdagl.ADOTgongzi.RecordCount=DMgzdagl.ADOTbutie.RecordCount;
      //Ч��Ԥ�㹤�ʺ�Ԥ��۳���¼�Ƿ����
      t:=DMgzdagl.ADOTgongzi.RecordCount=DMgzdagl.ADOTkouchu.RecordCount;
      if not t then exit;//����ȣ��������ϲ�һ��
      DMgzdagl.ADOTgongzi.First;//�����һ���ж�
      for i:=0 to DMgzdagl.ADOTgongzi.RecordCount-1 do//˳��ɨ��нˮ����Ա�����
        begin  //��Ԥ�㲹�����Ԥ��۳������Ƿ񶼴���
          bh:=DMgzdagl.ADOTgongzi.Fields[0].Value;//��һ�������ڱ�ʾ���ϲ����룬�˳�
          if (DMgzdagl.ADOTbutie.Locate('Ա�����',bh,[])=false)or (DMgzdagl.ADOTkouchu.Locate('Ա�����',bh,[])=false) then exit;
             DMgzdagl.ADOTgongzi.Next;
        end;
        result:=true;//ͨ�����飬˵����������
     end;     

//����yggongzi_jisuan����
     function Tform_gongzi.yggongzi_jisuan(const s_no:string):boolean;//������Ա�����
    var
    syz,syb,syk:real;//�м����������Ԥ�����ܹ��ʣ�Ԥ�����ܲ������ܿ۳�
     begin
      result:=false;//��ʼ�����
      if DMgzdagl.ADOTemployee.Locate('Ա�����',s_no,[])=false then//�����źϷ���
         begin
         messagedlg('��Ų�����',mterror,[mbok],0);
         exit;
         end;
      if DMgzdagl.ADOTgongzi.Locate('Ա�����',s_no,[])=false then //�鿴�Ƿ���Ԥ���ڹ���
         begin
         messagedlg('ȱԤ���ڹ������ϣ�',mterror,[mbok],0);
         pagecontrol1.ActivePageIndex :=0;//���ص�һҳ
         exit;
         end;
         syz:=DMgzdagl.ADOTgongzi.fieldbyname('С��').asfloat;//ȡԤ���ڹ��ʣ�����ֵ������syz
      if DMgzdagl.ADOTbutie.Locate('Ա�����',s_no,[])=false then//�鿴�Ƿ��и�Ա����Ԥ���ڲ�������
         begin
         messagedlg('ȱ��Ԥ���ڲ�������',mterror,[mbok],0);
         pagecontrol1.Activepageindex:=1;//���صڶ�ҳ
         exit;
         end;
         syb:=DMgzdagl.ADOTbutie.Fieldbyname('С��').asfloat;//ȡ�������ܹ���
      if DMgzdagl.ADOTkouchu.locate('Ա�����',s_no,[])=false then//�鿴�Ƿ��п۳���������
         begin
         messagedlg('ȱ�ٿ۳��������ϣ�',mterror,[mbok],0);
         pagecontrol1.ActivePageIndex:=2;//���ص���ҳ
         exit;
         end;
         syk:=DMgzdagl.ADOTkouchu.Fieldbyname('С��').asfloat;//ȡ�۳��ܹ���
         //����ʵ�ʹ���
      if DMgzdagl.ADOTemployee.Locate('Ա�����',s_no,[])=true then//����и�Ա�����
         begin
         DMgzdagl.ADOTemployee.edit;
         DMgzdagl.ADOTemployee.Fieldbyname('����').asfloat:=syz+syb-syk;
         DMgzdagl.ADOTemployee.post;
         result:=true;
         end;
       end;

procedure TForm_gongzi.gongzi_BTyesClick(Sender: TObject);
var
s:real;//ͳ���м����
begin
   //�ж�Ա����ű��벻����нˮ���У�����Ҫ������Ա����Ϣ����
   //ȷ���и�Ա���Ļ������ϣ����ڼ��㹤�ʣ�������¼��
   if (DMgzdagl.ADOTgongzi.Locate('Ա�����',edit_no.Text,[])=false) and  (DMgzdagl.ADOTemployee.Locate('Ա�����',edit_no.Text,[])=true) then
      with DMgzdagl.ADOTgongzi do
      begin
        append;
        DMgzdagl.ADOTgongzi.FieldByName('Ա�����').asstring:=edit_no.Text;
        DMgzdagl.ADOTgongzi.FieldByName('��������').AsString:=edit_base.text;
        DMgzdagl.ADOTgongzi.FieldByName('ְλ����').asstring:=edit_zhiwu.Text;
        DMgzdagl.ADOTgongzi.FieldByName('������').asstring:=edit_jbie.Text;
        DMgzdagl.ADOTgongzi.FieldByName('���乤��').asstring:=edit_gongling.Text;
        DMgzdagl.ADOTgongzi.FieldByName('��λ����').asstring:=edit_gangwei.Text;
        DMgzdagl.ADOTgongzi.FieldByName('����').asstring:=edit_other.Text;
        //ͳ��
        s:=strtofloat(edit_base.Text)+strtofloat(edit_zhiwu.Text)+
        strtofloat(edit_jbie.Text)+strtofloat(edit_gongling.Text)+
        strtofloat(edit_gangwei.Text)+strtofloat(edit_other.Text);
        //¼��С��
        DMgzdagl.ADOTgongzi.FieldByName('С��').asfloat:=s;
        Post;
        Refresh;
        messagedlg('Ԥ�㹤�������Ѿ��ɹ�¼�룡',mtinformation,[mbok],0);
        gongzi_BTnext.Enabled:=true; //gongzi_BTnext��ťenabled���Կ���
        end
     else
         messagedlg('��¼�Ѿ����ڻ���Ա����Ų����ڣ����������룡',mtError,[mbok],0);
end;

procedure TForm_gongzi.Edit_noChange(Sender: TObject);
begin
//���ƽ���Ԥ�㹤��ҳʱ��ťgongzi_BTyes��enabled����
if length(edit_no.Text)>0 then
  gongzi_BTyes.Enabled:=true
else
  gongzi_BTyes.Enabled:=false;
end;

procedure TForm_gongzi.gongzi_BTnoClick(Sender: TObject);
begin
//�������򣬻�����
edit_no.Clear;
edit_base.Text:='0';
edit_zhiwu.Text:='0';
edit_jbie.Text:='0';
edit_gongling.Text:='0';
edit_gangwei.Text:='0';
edit_other.Text:='0';
edit_no.SetFocus;//��ý���
end;



procedure TForm_gongzi.gongzi_BTnextClick(Sender: TObject);
begin
//edit_butie_no�ǵڶ�ҳ��Ա����������
//�ѱ�ҳ��Ա����Ŵ��ݹ�ȥ�������������
edit_butie_no.Text:=edit_no.Text;
pagecontrol1.ActivePageIndex:=1;//����ڶ�ҳ���в�������
end;

procedure TForm_gongzi.butie_BTyesClick(Sender: TObject);
var
s:real;//ͳ���м����
begin
   //�ж�Ա����ű��벻���ڲ������У�����Ҫ������Ա����Ϣ����
   //ȷ���и�Ա���Ļ������ϣ����ڼ��㹤�ʣ�������¼��
   if (DMgzdagl.ADOTbutie.Locate('Ա�����',edit_butie_no.Text,[])=false) and  (DMgzdagl.ADOTemployee.Locate('Ա�����',edit_butie_no.Text,[])=true) then
      with DMgzdagl.ADOTbutie  do
      begin
        append;
        DMgzdagl.ADOTbutie.FieldByName('Ա�����').asstring:=edit_butie_no.Text;
        DMgzdagl.ADOTbutie.FieldByName('�ۺϲ���').AsString:=edit_zonghe.text;
        DMgzdagl.ADOTbutie.FieldByName('��Ͳ���').asstring:=edit_wucan.Text;
        DMgzdagl.ADOTbutie.FieldByName('ס������').asstring:=edit_zhufang.Text;
        DMgzdagl.ADOTbutie.FieldByName('ҽ�Ʋ���').asstring:=edit_yiliao.Text;
        DMgzdagl.ADOTbutie.FieldByName('��������').asstring:=edit_fudong.Text;
        DMgzdagl.ADOTbutie.FieldByName('�������').asstring:=edit_tebie.Text;
        DMgzdagl.ADOTbutie.FieldByName('����').asstring:=edit_oth.Text;
        //ͳ��
        s:=strtofloat(edit_zonghe.Text)+strtofloat(edit_wucan.Text)+
        strtofloat(edit_zhufang.Text)+strtofloat(edit_yiliao.Text)+
        strtofloat(edit_fudong.Text)+strtofloat(edit_tebie.Text)+strtofloat(edit_oth.Text);
        //¼��С��
        DMgzdagl.ADOTbutie.FieldByName('С��').asfloat:=s;
        Post;
        Refresh;
        messagedlg('Ԥ�㲹�������Ѿ��ɹ�¼�룡',mtinformation,[mbok],0);
         butie_BTnext.Enabled:=true; //butie_BTnext��ťenabled���Կ���
        end
     else
         messagedlg('��¼�Ѿ����ڻ���Ա����Ų����ڣ����������룡',mtError,[mbok],0);
end;

procedure TForm_gongzi.Edit_butie_noChange(Sender: TObject);
begin
//���ƽ���Ԥ���ڲ���ҳʱ��ťbutie_BTyes��enabled����
if length(edit_butie_no.Text)>0 then
  butie_BTyes.Enabled:=true
else
  butie_BTyes.Enabled:=false;
end;

procedure TForm_gongzi.butie_BTnoClick(Sender: TObject);
begin
//����
edit_butie_no.Clear;
edit_zonghe.Text:='0';
edit_wucan.Text:='0';
edit_zhufang.Text:='0';
edit_yiliao.Text:='0';
edit_fudong.Text:='0';
edit_tebie.Text:='0';
edit_oth.Text:='0';
edit_butie_no.SetFocus;//��ý���
end;

procedure TForm_gongzi.butie_BTnextClick(Sender: TObject);
begin
//edit_kouchu_no�ǵ���ҳ��Ա����������
//�ѱ�ҳ��Ա����Ŵ��ݹ�ȥ�������������
edit_kouchu_no.Text:=edit_butie_no.Text;
pagecontrol1.ActivePageIndex:=2;//�������ҳ���п۳�����
end;

procedure TForm_gongzi.Edit_kouchu_noChange(Sender: TObject);
begin
//���ƽ���۳�����ҳʱ��ťkouchu_BTyes��enabled����
if length(edit_kouchu_no.Text)>0 then
  kouchu_BTyes.Enabled:=true
else
  kouchu_BTyes.Enabled:=false;
end;

procedure TForm_gongzi.kouchu_BTyesClick(Sender: TObject);
var
s1:real;
begin
      //�ж�Ա����ű��벻���ڿ۳����У�����Ҫ������Ա����Ϣ����
   //ȷ���и�Ա���Ļ������ϣ����ڼ��㹤�ʣ�������¼��
   if (DMgzdagl.ADOTkouchu.Locate('Ա�����',edit_kouchu_no.Text,[])=false) and  (DMgzdagl.ADOTemployee.Locate('Ա�����',edit_kouchu_no.Text,[])=true) then
      with DMgzdagl.ADOTkouchu  do
      begin
        append;
        DMgzdagl.ADOTkouchu .FieldByName('Ա�����').asstring:=edit_kouchu_no.Text;
        DMgzdagl.ADOTkouchu .FieldByName('ס������').AsString:=edit_house.text;
        DMgzdagl.ADOTkouchu .FieldByName('���ϻ���').asstring:=edit_yanglao.Text;
        DMgzdagl.ADOTkouchu .FieldByName('ҽ�ƻ���').asstring:=edit_kouchu_yiliao.Text;
        DMgzdagl.ADOTkouchu.FieldByName('����').asstring:=edit_kouchu_other.Text;
        //ͳ��
        s1:=strtofloat(edit_house.Text)+strtofloat(edit_yanglao.Text)+
        strtofloat(edit_kouchu_yiliao.Text)+strtofloat(edit_kouchu_other.Text);
        //¼��С��
        DMgzdagl.ADOTkouchu.FieldByName('С��').asfloat:=s1;
        Post;
        Refresh;
        messagedlg('�۳������Ѿ��ɹ�¼�룡',mtinformation,[mbok],0);
         kouchu_BTnext.Enabled:=true; //kouchu_BTnext��ťenabled���Կ���
        end
     else
         messagedlg('��¼�Ѿ����ڻ���Ա����Ų����ڣ����������룡',mtError,[mbok],0);
end;

procedure TForm_gongzi.kouchu_BTnoClick(Sender: TObject);
begin
//��'0'
edit_kouchu_no.Clear;
edit_house.Text:='0';
edit_yanglao.Text:='0';
edit_kouchu_yiliao.Text:='0';
edit_kouchu_other.Text:='0';
edit_kouchu_no.SetFocus;//��ý���
end;

procedure TForm_gongzi.kouchu_BTnextClick(Sender: TObject);
begin
edit_yggongzi_no.text:=edit_kouchu_no.Text;//����ҳ��'Ա�����'����ֵ
pagecontrol1.ActivePageIndex:=3;//ת������ҳ
end;

procedure TForm_gongzi.yggongzi_BT_jisuanClick(Sender: TObject);
begin
  if edit_yggongzi_no.text<>''then //����Ա����ż���
     if yggongzi_jisuan(edit_yggongzi_no.Text) then//���ú������������
        messagedlg('����Ա��������ϣ�',mtinformation,[mbok],0);
end;

procedure TForm_gongzi.yggongzi_BT_addClick(Sender: TObject);
begin
pagecontrol1.ActivePageIndex:=0;//���ص�һҳ
gongzi_BTno.OnClick(self);
edit_butie_no.Clear;
edit_kouchu_no.Clear;//��'0'
end;

procedure TForm_gongzi.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
if not zq then //����zq����������¼���Ƿ�����
 if messagedlg('Ա������δ������������ϲ�һ�£�ȷ��Ҫ�˳���',mtconfirmation,[mbyes,mbno],0)=mrno then
 canclose:=false;
end;

procedure TForm_gongzi.FormShow(Sender: TObject);
begin
if not zq then  //������ϲ���������ʾ�û�
messagedlg('Ա���������ϲ������������������ϣ�',mtinformation,[mbok],0);
end;

end.
