unit Unit1;

interface

uses
  unit2,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, ComCtrls, Grids, DBGrids, StdCtrls, Mask, DB;

type
  Tmzsf = class(TForm)
    DBNavigator1: TDBNavigator;
    Panel1: TPanel;
    bh: TEdit;
    rq: TEdit;
    fy: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    DBGrid2: TDBGrid;
    Label9: TLabel;
    Label10: TLabel;
    sl: TEdit;
    Label6: TLabel;
    mc: TEdit;
    Label11: TLabel;
    ss: TEdit;
    Label12: TLabel;
    zb: TEdit;
    Button1: TButton;
    Label13: TLabel;
    zj: TEdit;
    Button2: TButton;
    Mdtzj: TEdit;
    Label8: TLabel;
    RichEdit1: TRichEdit;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure bhKeyPress(Sender: TObject; var Key: Char);
    procedure slKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure ssKeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
 private
    { Private declarations }
   
  public
    { Public declarations }
  end;

var
  mzsf: Tmzsf;

implementation

uses Unit3, Unit4;

{$R *.dfm}


procedure Tmzsf.FormCreate(Sender: TObject);
begin
mzsf.WindowState:=wsmaximized;
button2.Enabled:=false;//button2״̬�����ã�ֱ���������շ�ֵ
end;

procedure Tmzsf.Edit1Change(Sender: TObject);
begin
DMmzsf.ADOTyp.filtered:=false;
DMmzsf.ADOTyp.filtered:=true;
button2.Enabled:=false;//button2״̬�����ã�ֱ���������շ�ֵ
end;



procedure Tmzsf.bhKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
begin
   if trim(mzsf.bh.Text)<>'' then
      begin
           DMmzsf.ADOQmzsf.Close;
           //��������ֵ
           DMmzsf.ADOQmzsf.Parameters.ParamByName('���').Value:=trim(mzsf.bh.Text)+'%';
           //ִ��sql
           DMmzsf.ADOQmzsf.open;
           ypjgview.ShowModal;
           bh.ReadOnly:=true;//���edit״̬Ϊֻ��
           button2.Enabled:=false;//button2״̬�����ã�ֱ���������շ�ֵ
      end;
end;
end;

procedure Tmzsf.slKeyPress(Sender: TObject; var Key: Char);
var
 strA,strB:string;
begin
  if key=#13 then
     begin
      try
     //���������������
       if bh.Text<>'' then
         fy.text:=floattostr(strtofloat(sl.Text)*strtofloat(ypjgview.DBEsj.Text));
         fy.Enabled:=false;
         fy.ReadOnly:=true;
      //�ۼ��ܷ���
         strA:=fy.Text;
         strB:=zj.text;
         zj.Text:=floattostr(strtofloat(strB)+strtofloat(strA));
         //����edit״̬
         zj.Enabled:=false;
         zj.ReadOnly:=true;
         sl.enabled:=false;
         sl.ReadOnly:=true;
         button2.Enabled:=false;//button2״̬�����ã�ֱ���������շ�ֵ
       except
         begin
         sl.Text:='';
         showmessage('�������벻��ȷ����������');
         end;
       end;
     end;
 end;

procedure Tmzsf.Button1Click(Sender: TObject);
begin
 try
//������ݿ�
        DMmzsf.ADOTmzsf.Append;
        DMmzsf.ADOTmzsf.FieldByName('���').AsString:=bh.Text;
        DMmzsf.ADOTmzsf.FieldByName('����').asinteger:=strtoint(sl.Text);
        DMmzsf.ADOTmzsf.FieldByName('����').asfloat:=strtofloat(fy.Text);
        DMmzsf.ADOTmzsf.FieldByName('����').asdatetime:=strtodate(rq.Text);
        DMmzsf.ADOTmzsf.Post;
        //Ϊ��ӡ�������
       richedit1.Lines.Add('ҩƷ���ƣ�'+mc.text+'  �ۼۣ�$'+fy.text);
  except
        showmessage('���Ϸ�������');
  end;
        //ˢ��
        DMmzsf.ADOTmzsf.Close;
        DMmzsf.ADOTmzsf.Open;
        //���edit�е�ֵ
        bh.Text:='';
        fy.Text:='';
        mc.Text:='';
        sl.text:='';
        bh.SetFocus;
        bh.Enabled:=true;
        bh.ReadOnly:=false;
        sl.Enabled:=true;
        sl.ReadOnly:=false;
        button2.Enabled:=false;//button2״̬�����ã�ֱ���������շ�ֵ
end;

procedure Tmzsf.ssKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
    begin
     try
        zb.Text:=floattostr(strtofloat(ss.Text)-strtofloat(zj.Text));
        zb.Enabled:=false;
        zb.ReadOnly:=true;
        button2.Enabled:=true;//button2״̬�����ã�ֱ���������շ�ֵ
          //�������շѺ�,button1������
         button1.Enabled:=false;
      except
         showmessage('���Ϸ������룬����������');
         ss.Text:='';
         ss.SetFocus;
      end;
   end;
end;


procedure Tmzsf.Button2Click(Sender: TObject);
var
sum:real;
begin
//ͳ�Ƶ�������
     richedit1.lines.add('�ܼƣ�$'+zj.Text);
     richedit1.lines.add('ʵ�գ�$'+ss.Text+'    ���㣺$'+zb.text);
     richedit1.Lines.add(datetostr(date()));
if  DMmzsf.ADOQdtzj.Active then
   DMmzsf.ADOQdtzj.Active:=false;
   //��������ֵ
DMmzsf.ADOQdtzj.Parameters.ParamByName('����').value:=date();
   //ִ��sql���
   DMmzsf.ADOQdtzj.Active:=true;
   if DMmzsf.ADOQdtzj.recordcount=0 then
     showmessage('û���κ�����')
   else
      begin
        sum:=0.00;
        DMmzsf.ADOQdtzj.First;
        while not DMmzsf.ADOQdtzj.Eof do
          begin
            sum:=sum+strtofloat(DMmzsf.ADOQdtzj.Fields.Fields[2].asstring);
            DMmzsf.ADOQdtzj.Next;
           end;
           Mdtzj.Text:=floattostr(sum);
           //����ʾͳ��ֵ��edit�ָ�Ϊ��
           zj.Text:='';
           ss.text:='';
           zb.Text:='';
           ss.Enabled:=true;
           ss.ReadOnly:=false;
            button3.SetFocus;//��ӡ��ť��ý���
            //��zj.text��ֵ����Ϊ��
            zj.Text:='0';
           //�ָ�button2��ִ��״̬
           button2.Enabled:=false;
           //button1�����ã�ֱ����ӡ��
           button1.Enabled:=true;
       end;
end;


procedure Tmzsf.Button3Click(Sender: TObject);
begin
        //��ӡԤ��
        mzsfbb.QuickRep1.preview;
        //���richedit1
        richedit1.Lines.Clear;
        //���㷵��bh.edit
        bh.SetFocus;
        //button1����
    end;
end.
