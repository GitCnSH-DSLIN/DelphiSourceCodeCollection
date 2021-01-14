unit ypgl_xg_tj_;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, ComCtrls, XPMenu;

type
  Typgl_xg_tj = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    DBEbh: TDBEdit;
    Label2: TLabel;
    DBEmc: TDBEdit;
    Label5: TLabel;
    DBEzxjg: TDBEdit;
    Label3: TLabel;
    DBEjj: TDBEdit;
    Label4: TLabel;
    DBEsj: TDBEdit;
    Label9: TLabel;
    DateTimerk: TDateTimePicker;
    Label8: TLabel;
    DateTimedg: TDateTimePicker;
    DateTimegq: TDateTimePicker;
    Label7: TLabel;
    Label6: TLabel;
    DBEdgl: TDBEdit;
    Label10: TLabel;
    DBEgg: TDBEdit;
    Label11: TLabel;
    DBEdwsl: TDBEdit;
    Label13: TLabel;
    DBEzxdw: TDBEdit;
    Label12: TLabel;
    DBEgysbh: TDBEdit;
    BitBtn1: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn_cancel: TBitBtn;
    XPMenu1: TXPMenu;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn_cancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ypgl_xg_tj: Typgl_xg_tj;

implementation

uses DMypgl_;

{$R *.dfm}

procedure Typgl_xg_tj.BitBtn1Click(Sender: TObject);
begin
  //ʹedit,datetimeΪ���޸�״̬
  dbebh.ReadOnly:=false;
  dbemc.ReadOnly:=false;
  dbejj.ReadOnly:=false;
  dbesj.ReadOnly:=false;
  dbezxjg.ReadOnly:=false;
  dbedgl.ReadOnly:=false;
  dbegg.ReadOnly:=false;
  dbedwsl.ReadOnly:=false;
  dbegysbh.ReadOnly:=false;
  Datetimedg.Enabled:=true;
  Datetimegq.Enabled:=true;
  Datetimerk.Enabled:=true;
end;

procedure Typgl_xg_tj.BitBtn5Click(Sender: TObject);
begin
 try
  begin
  DMypgl.ADOTypgl.Edit;
  //����޸ĵļ�¼
  DMypgl.ADOTypgl.FieldValues['���']:=DBebh.Text;
  DMypgl.ADOTypgl.FieldValues['ҩƷ����']:=DBemc.Text;
  DMypgl.ADOTypgl.FieldValues['����']:=strtofloat(DBejj.Text);
  DMypgl.ADOTypgl.FieldValues['�ۼ�']:=strtofloat(DBesj.Text);
  DMypgl.ADOTypgl.FieldValues['��С�۸�']:=strtofloat(DBezxjg.Text);
  DMypgl.ADOTypgl.FieldValues['������']:=strtoint(DBedgl.Text);
  DMypgl.ADOTypgl.FieldValues['����ʱ��']:=DateTimegq.date;
  DMypgl.ADOTypgl.FieldValues['����ʱ��']:=DateTimedg.date;
  DMypgl.ADOTypgl.FieldValues['���']:=DBEgg.text;
  DMypgl.ADOTypgl.FieldValues['���ʱ��']:=DateTimerk.date;
  DMypgl.ADOTypgl.FieldValues['��λ����']:=DBEdwsl.text;
  DMypgl.ADOTypgl.FieldValues['��Ӧ�̱��']:=DBegysbh.text;
  Dmypgl.ADOTypgl.FieldValues['��С��λ']:=DBEzxdw.Text;
  DMypgl.ADOTypgl.FieldValues['�����']:=strtoint(DBedgl.Text);
  DMypgl.ADOTypgl.Post;
 //�������ݼ�
                DMypgl.adotgys.Close;
                DMypgl.ADOTgys.Open;

                Dmypgl.ADOQypgq.Close;
                Dmypgl.ADOQypgq.Open;

                DMypgl.ADOTypgl.Close;
                DMypgl.ADOTypgl.Open;


                DMypgl.ADOQyp_xg_tj.Close;
                DMypgl.ADOQyp_xg_tj.Open;

                DMYpgl.ADOQgys.Close;
                DMypgl.adoqgys.Open;

                DMypgl.ADOTyp.Close;
                DMypgl.ADOTyp.Open;

                DMypgl.ADOTgys2.Close;
                DMypgl.ADOTgys2.Open;

                DMypgl.ADOQgys_modify.Close;
                DMypgl.ADOQgys_modify.Open;

                DMypgl.ADOQqhgys.Close;
                DMypgl.adoqqhgys.Open;
                
  showmessage('�����޸ĳɹ�����');
  end;
 except
  showmessage('��ƥ�������');
 end;
end;


procedure Typgl_xg_tj.BitBtn_cancelClick(Sender: TObject);
begin
DMypgl.ADOTypgl.Cancel;
end;

end.
