unit zygl_;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, StdCtrls, Mask, ExtCtrls, ComCtrls, Grids, DBGrids,
  Buttons, XPMenu;

type
  Tzygl = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    Label10: TLabel;
    DBEdit10: TDBEdit;
    Label11: TLabel;
    DBEdit11: TDBEdit;
    Label12: TLabel;
    DBEdit12: TDBEdit;
    Label13: TLabel;
    DBEdit13: TDBEdit;
    Label14: TLabel;
    DBEdit14: TDBEdit;
    Label15: TLabel;
    DBEdit15: TDBEdit;
    Label16: TLabel;
    DBEdit16: TDBEdit;
    Label17: TLabel;
    DBEdit17: TDBEdit;
    Label18: TLabel;
    DBEdit18: TDBEdit;
    Label19: TLabel;
    DBEdit19: TDBEdit;
    Label20: TLabel;
    DBEdit20: TDBEdit;
    Label21: TLabel;
    DBEdit21: TDBEdit;
    Label22: TLabel;
    DBEdit22: TDBEdit;
    Label23: TLabel;
    DBEdit23: TDBEdit;
    Label24: TLabel;
    Label25: TLabel;
    DBEdit25: TDBEdit;
    Label26: TLabel;
    Label27: TLabel;
    DBEdit27: TDBEdit;
    Label28: TLabel;
    Label29: TLabel;
    DBEdit29: TDBEdit;
    Label30: TLabel;
    Label31: TLabel;
    DBEdit31: TDBEdit;
    Label32: TLabel;
    DBEdit32: TDBEdit;
    Label33: TLabel;
    DBEdit33: TDBEdit;
    Label34: TLabel;
    DBEdit34: TDBEdit;
    Label35: TLabel;
    DBEdit35: TDBEdit;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    DBMemo3: TDBMemo;
    DBEdit24: TDBEdit;
    Panel5: TPanel;
    Button1: TButton;
    Erycx_id: TEdit;
    Label36: TLabel;
    Label37: TLabel;
    DBGrid1: TDBGrid;
    Label38: TLabel;
    Erycx_xm: TEdit;
    Button2: TButton;
    Label39: TLabel;
    Panel6: TPanel;
    Ebrid: TEdit;
    Label40: TLabel;
    Exmfymc: TEdit;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Esl: TEdit;
    Edw: TEdit;
    Efy: TEdit;
    Erq: TEdit;
    Label46: TLabel;
    Eyjsy: TEdit;
    Label47: TLabel;
    Button4: TButton;
    Panel7: TPanel;
    DBGqdXG: TDBGrid;
    Button5: TButton;
    Button6: TButton;
    Edwfy: TEdit;
    Label48: TLabel;
    Label49: TLabel;
    DBGrid3: TDBGrid;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label55: TLabel;
    Button7: TButton;
    EbridXG: TEdit;
    ExmfymcXG: TEdit;
    EfyXG: TEdit;
    EslXG: TEdit;
    Label54: TLabel;
    Label56: TLabel;
    DTPrqXG: TDateTimePicker;
    Button8: TButton;
    EdwXG: TEdit;
    Label57: TLabel;
    ControlBar1: TControlBar;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label58: TLabel;
    Ebz: TEdit;
    EbzXG: TEdit;
    Label59: TLabel;
    XPMenu1: TXPMenu;
    DBNavigator1: TDBNavigator;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ExmfymcKeyPress(Sender: TObject; var Key: Char);
    procedure EslKeyPress(Sender: TObject; var Key: Char);
    procedure Button4Click(Sender: TObject);
    procedure EbridKeyPress(Sender: TObject; var Key: Char);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure DBGqdXGCellClick(Column: TColumn);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure EbridChange(Sender: TObject);
    procedure EbridXGKeyPress(Sender: TObject; var Key: Char);
    procedure EslChange(Sender: TObject);
    procedure Erycx_idKeyPress(Sender: TObject; var Key: Char);
    procedure Erycx_xmKeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  zygl: Tzygl;

implementation

uses DM_zygl_, xmmx_, zycsf_, rygl_bb_, yrqd_bbgl, denglu_;

{$R *.dfm}

procedure Tzygl.Button1Click(Sender: TObject);
begin
 if Erycx_id.Text<>'' then
  begin
   DMzygl.ADOTbab.Locate('����id',Erycx_id.Text,[]);  //��ѯid
     if DBEdit1.Text <> Erycx_id.Text then
       begin
         showmessage('û���ҵ����id');
       end;
   Erycx_id.Text:='';
   Erycx_id.SetFocus;    //��ȡ����
  end
 else
  begin
   showmessage('û���ѯֵ');
   Erycx_id.SetFocus;   //��ȡ����
  end;
end;

procedure Tzygl.Button2Click(Sender: TObject);
begin
 if Erycx_xm.Text<>'' then
  begin
   DMzygl.ADOTbab.Locate('����',Erycx_xm.Text,[]);  //��ѯid
     if DBEdit4.Text <> Erycx_xm.Text then
       begin
         showmessage('û���ҵ��������');
       end;
   Erycx_xm.Text:='';
   Erycx_xm.SetFocus;    //��ȡ����
  end
 else
  begin
   showmessage('û���ѯֵ');
   Erycx_xm.SetFocus;   //��ȡ����
  end;
end;

procedure Tzygl.ExmfymcKeyPress(Sender: TObject; var Key: Char);
begin
 if key=#13 then
   begin
      xmmx.ShowModal;
   end;
end;

procedure Tzygl.EslKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
    begin
     try
      Efy.Text:=floattostr(strtofloat(Esl.Text)*strtofloat(xmmx.DBEfy.Text));
      Efy.Enabled:=true;
      Efy.ReadOnly:=true;
      button4.Enabled:=true;
      button4.SetFocus;//�ύ��Ŧ��ý���

     except
      begin
        DMzygl.ADOQxmfymxb.Locate('��Ŀ��������',Exmfymc.Text,[]);
        Esl.Text:='';
        showmessage('����ȷ��д����');
      end;
     end;
    end;


end;

procedure Tzygl.Button4Click(Sender: TObject);
begin

  //���һ���嵥
 try
  DMzygl.ADOTmrqdb.Append;
  DMzygl.ADOTmrqdb.FieldByName('����id').AsString:=Ebrid.Text;
  DMzygl.ADOTmrqdb.FieldByName('��Ŀ��������').AsString:=Exmfymc.Text;
  DMzygl.ADOTmrqdb.FieldByName('����').AsString:=Esl.Text;
  DMzygl.ADOTmrqdb.FieldByName('��λ').AsString:=Edw.Text;
  DMzygl.ADOTmrqdb.FieldByName('����').AsString:=Efy.Text;
  DMzygl.ADOTmrqdb.FieldByName('����').AsString:=Erq.Text;
  DMzygl.ADOTmrqdb.FieldByName('��ע').AsString:=Ebz.Text;
  DMzygl.ADOTmrqdb.Post;
 except
   showmessage('������д�д�����');
 end;

  //����Ѻ��
  Eyjsy.Text:=floattostr(strtofloat(Eyjsy.Text)-strtofloat(Efy.Text));
  DMzygl.ADOTbab.Edit;
  DMzygl.ADOTbab.FieldByName('Ѻ��').AsString:=Eyjsy.Text;
  DMzygl.ADOTbab.UpdateBatch;

  //ˢ��DBgrid3
  DMzygl.ADOQyrqdXG.Close;
  DMzygl.ADOQyrqdXG.Open;

  Exmfymc.Text:='';
  Esl.Text:='';
  Edw.Text:='';
  Efy.Text:='';
  Ebz.Text:='';
  zygl.Exmfymc.ReadOnly:=false;
  Exmfymc.SetFocus;

end;

procedure Tzygl.EbridKeyPress(Sender: TObject; var Key: Char);
var
  STRyjsy:string;
begin

  if key=#13 then
   begin
     try
       STRyjsy:='';
       DMzygl.ADOTbab.Locate('����id',Ebrid.Text,[]);   //��λ������
       STRyjsy:=DMzygl.ADOTbab.Lookup('����id',Ebrid.Text,'Ѻ��'); //ȡ��Ѻ��
       Eyjsy.Text:=STRyjsy; //��ʾѺ��

       //��ѯһ���嵥�û�
       DMzygl.ADOQyrqdXG.Close;
       DMzygl.ADOQyrqdXG.Parameters.ParamByName('����id').Value:=Ebrid.Text;
       DMzygl.ADOQyrqdXG.Open;
       //ʹ����
       Exmfymc.Enabled:=true;
       Edw.Enabled:=true;
       Efy.Enabled:=true;
       Exmfymc.SetFocus;


     except
       begin
         showmessage('û���������');
         Ebrid.Text:='';
         Ebrid.SetFocus;
       end;
     end;
   end;


end;

procedure Tzygl.Button5Click(Sender: TObject);
var
 STRyjsy:string;
begin
  STRyjsy:='';

     try
      begin
         DMzygl.ADOTbab.Locate('����id',EbridXG.Text,[]);//��λ������
         STRyjsy:=DMzygl.ADOTbab.Lookup('����id',EbridXG.Text,'Ѻ��');//ȡ��Ѻ��
         Eyjsy.Text:=STRyjsy;

         DMzygl.ADOQyrqdXG.Close;
         DMzygl.ADOQyrqdXG.Parameters.ParamByName('����id').Value:=EbridXG.Text;
         DMzygl.ADOQyrqdXG.Open;


         DBGrid3.DataSource.Enabled:=false;//ʹDBgrid3������
         DBGqdXG.DataSource.Enabled:=true;// ʹ DBGqdXG ������

         if DMzygl.ADOQyrqdXG.RecordCount=0 then
           begin
             showmessage('�ò���û�м�¼');
             EbridXG.SetFocus;
             exit;
           end
         else
           begin
              button5.Enabled:=false;
              button6.Enabled:=true;
              
              button8.Enabled:=true;
              Exmfymc.Enabled:=false;
              Esl.Enabled:=false;
              Efy.Enabled:=false;
              Erq.Enabled:=false;
              EbridXG.Enabled:=false;



           end;
      end;
     except
       begin
         showmessage('û���������');
         EbridXG.Text:='';
         EbridXG.SetFocus;
       end;
     end;
  
end;

procedure Tzygl.Button6Click(Sender: TObject);
begin
   DMzygl.ADOQyrqdXG.Active:=false;
   button5.Enabled:=true;
   button6.Enabled:=false;
   button7.Enabled:=false;
   button8.Enabled:=false;
   EbridXG.Text:='';
   ExmfymcXG.Text:='';
   EslXG.Text:='';
   EdwXG.Text:='';
   EfyXG.Text:='';

   DBGrid3.DataSource.Enabled:=true;//ʹDBgrid3������
   DBGqdXG.DataSource.Enabled:=false;// ʹ DBGqdXG ������

   Exmfymc.Enabled:=true;
   Esl.Enabled:=true;
   Efy.Enabled:=true;
   Erq.Enabled:=true;
   EbridXG.Enabled:=true;

end;

procedure Tzygl.DBGqdXGCellClick(Column: TColumn);
begin
  ExmfymcXG.Enabled:=true;
  EslXG.Enabled:=true;
  EdwXG.Enabled:=true;
  EfyXG.Enabled:=true;
  DTPrqXG.Enabled:=true;
  button7.Enabled:=true;

  ExmfymcXG.Text:=DMzygl.ADOQyrqdXG.Fields.Fields[1].AsString;//��Exmfymc�м�����Ŀ
  EslXG.Text:=DMzygl.ADOQyrqdXG.Fields.Fields[2].AsString;
  EdwXG.Text:=DMzygl.ADOQyrqdXG.Fields.Fields[3].AsString;
  EfyXG.Text:=DMzygl.ADOQyrqdXG.Fields.Fields[4].AsString;
  DTPrqXG.Date:=DMzygl.ADOQyrqdXG.Fields.Fields[5].AsDateTime;
  EbzXG.Text:=DMzygl.ADOQyrqdXG.Fields.Fields[6].AsString;

end;

procedure Tzygl.Button7Click(Sender: TObject);
var
  STRyfy,STRhfy,STRzfy,STRdj,STRyj,STRrq:string; //ԭ�����ã��������ã����շ��� ,ҩƷ���� ,����Ѻ�� ,����
begin
   STRyfy:='';
   STRhfy:='';
   STRzfy:='';
   STRdj:='';
   STRyj:='';
   STRrq:='';


   
   try
     STRdj:=DMzygl.ADOTxmfymxb.Lookup('��Ŀ��������',ExmfymcXG.Text,'��Ŀ����');// ҩƷ����
     EfyXG.Text:=floattostr(strtofloat(STRdj)*strtofloat(EslXG.Text)); //����۸�
   except
     showmessage('ҩƷ�Ա�ɾ��,�������ݿ����Ա��ϵ');
   end;


   STRyfy:=DMzygl.ADOQyrqdXG.fieldbyname('����').AsString;//ԭ������
   STRhfy:=EfyXG.Text;  //��������
   STRzfy:=floattostr(strtofloat(STRyfy)-strtofloat(STRhfy));//���
   
   DMzygl.ADOTbab.Locate('����id',EbridXG.Text,[]);  //��λ������
   STRyj:=DMzygl.ADOTbab.FieldByName('Ѻ��').AsString; //ԭ��Ѻ��

   //Ѻ���޸�
   DMzygl.ADOTbab.Edit;
   DMzygl.ADOTbab.FieldByName('Ѻ��').AsString:=floattostr(strtofloat(STRyj)+strtofloat(STRzfy));//Ѻ�����
   DMzygl.ADOTbab.UpdateBatch;

   //һ���嵥�޸�
   try
     DMzygl.ADOQyrqdXG.Edit;
     DMzygl.ADOQyrqdXG.FieldByName('����').AsString:=EslXG.Text;
     DMzygl.ADOQyrqdXG.FieldByName('����').AsString:=EfyXG.Text;
     DMzygl.ADOQyrqdXG.FieldByName('����').AsString:=datetostr(DTPrqXG.Date);
     DMzygl.ADOQyrqdXG.FieldByName('��ע').AsString:=EbzXG.Text;
     DMzygl.ADOQyrqdXG.UpdateBatch;
   except
   end;
   button6.Click;
   showmessage('�ɹ��޸�����');


   




end;

procedure Tzygl.Button8Click(Sender: TObject);
var
  STRyj:string;//Ѻ��
begin

   STRyj:=EfyXG.Text;
   Eyjsy.Text:=floattostr(strtofloat(Eyjsy.Text)+strtofloat(STRyj));//���޸� �����嵥 ��ť���Ѿ���λ�˲�����

   DMzygl.ADOTbab.Edit;
   DMzygl.ADOTbab.FieldByName('Ѻ��').AsString:=Eyjsy.Text;
   DMzygl.ADOTbab.UpdateBatch;

   DMzygl.ADOQyrqdXG.Edit;
   DMzygl.ADOQyrqdXG.Delete;
   DMzygl.ADOQyrqdXG.UpdateBatch;

   ExmfymcXG.Text:='';
   EslXG.Text:='';
   EdwXG.Text:='';
   EfyXG.Text:='';

   ExmfymcXG.Enabled:=false;
   EslXG.Enabled:=false;
   EdwXG.Enabled:=false;
   EfyXG.Enabled:=false;
   DTPrqXG.Enabled:=false;
   showmessage('�Ѿ�ɾ����������');
   
end;

procedure Tzygl.EbridChange(Sender: TObject);
begin
       Exmfymc.Enabled:=false;
       Esl.Enabled:=false;
       Edw.Enabled:=false;
       Efy.Enabled:=false;
       Erq.Enabled:=false;
end;

procedure Tzygl.EbridXGKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
       button5.Click;
end;

procedure Tzygl.EslChange(Sender: TObject);
begin
  button4.Enabled:=false;
end;

procedure Tzygl.Erycx_idKeyPress(Sender: TObject; var Key: Char);
begin
   if key=#13 then
     button1.Click;
end;

procedure Tzygl.Erycx_xmKeyPress(Sender: TObject; var Key: Char);
begin
   if key=#13 then
     button2.Click;
end;

procedure Tzygl.Button3Click(Sender: TObject);
begin
   rygl_bb.QuickRep1.Preview;
end;

procedure Tzygl.BitBtn3Click(Sender: TObject);
begin
   yiqd_bb.ShowModal;
end;

procedure Tzygl.PageControl1Change(Sender: TObject);
begin
  //���Ƶ�½
  if denglu.DBEszzw.Text='��Ժ����' then PageControl1.ActivePageIndex:=0;
  if denglu.DBEszzw.Text='סԺ������' then PageControl1.ActivePageIndex:=1;
end;

procedure Tzygl.FormActivate(Sender: TObject);
begin
   if denglu.DBEszzw.Text='��Ժ����' then
     PageControl1.ActivePageIndex:=0;
   if denglu.DBEszzw.Text='סԺ������' then
     PageControl1.ActivePageIndex:=1;
   if denglu.DBEszzw.Text='סԺ���շ�' then
    begin
     BitBtn2.Visible:=true;
     PageControl1.Visible:=false;
    end;
   

end;

procedure Tzygl.BitBtn2Click(Sender: TObject);
begin
  zycsf.ShowModal;
end;

end.
