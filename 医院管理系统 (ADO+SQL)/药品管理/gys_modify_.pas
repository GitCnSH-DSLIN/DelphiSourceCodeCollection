unit gys_modify_;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Mask, DBCtrls, XPMenu;

type
  TFgys_modify = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    DBEgysbh: TDBEdit;
    Label2: TLabel;
    DBEgysmc: TDBEdit;
    Label3: TLabel;
    DBElxrxm: TDBEdit;
    Label4: TLabel;
    DBElxrtx: TDBEdit;
    Label5: TLabel;
    DBEdz: TDBEdit;
    Label6: TLabel;
    DBEcs: TDBEdit;
    Label7: TLabel;
    DBEdq: TDBEdit;
    Label8: TLabel;
    DBEyp: TDBEdit;
    Label9: TLabel;
    DBEgj: TDBEdit;
    Label10: TLabel;
    DBEdh: TDBEdit;
    Label11: TLabel;
    DBEcz: TDBEdit;
    BTgys_modify: TBitBtn;
    BTgys_YESmodify: TBitBtn;
    BTgys_NOmodify: TBitBtn;
    XPMenu1: TXPMenu;
    procedure BTgys_modifyClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BTgys_YESmodifyClick(Sender: TObject);
    procedure BTgys_NOmodifyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fgys_modify: TFgys_modify;

implementation

uses DMypgl_;

{$R *.dfm}

procedure TFgys_modify.BTgys_modifyClick(Sender: TObject);
begin
//����޸İ�ť����dbedit���ڿɱ༭״̬
  dbegysmc.ReadOnly:=false;
  dbelxrxm.ReadOnly:=false;
  dbelxrtx.ReadOnly:=false;
  dbedz.ReadOnly:=false;
  dbecs.ReadOnly:=false;
  dbedq.ReadOnly:=false;
  dbeyp.ReadOnly:=false;
  dbegj.ReadOnly:=false;
  dbedh.ReadOnly:=false;
  dbecz.ReadOnly:=false;
end;

procedure TFgys_modify.FormActivate(Sender: TObject);
begin
//BTgys_modify��ý���

  BTgys_modify.SetFocus;
end;

procedure TFgys_modify.BTgys_YESmodifyClick(Sender: TObject);
begin
  try
    begin
     DMypgl.ADOTgys2.Edit;
     //����޸ĵļ�¼
     DMypgl.ADOTgys2.fieldvalues['��Ӧ������']:=dbegysmc.Text;
     DMypgl.ADOTgys2.fieldvalues['��ϵ������']:=dbelxrxm.Text;
     DMypgl.ADOTgys2.fieldvalues['��ϵ��ͷ��']:=dbelxrtx.Text;
     DMypgl.ADOTgys2.fieldvalues['��ַ']:=dbedz.Text;
     DMypgl.ADOTgys2.fieldvalues['����']:=dbecs.Text;
     DMypgl.ADOTgys2.fieldvalues['����']:=dbedq.Text;
     DMypgl.ADOTgys2.fieldvalues['�ʱ�']:=dbeyp.Text;
     DMypgl.ADOTgys2.fieldvalues['����']:=dbegj.Text;
     DMypgl.ADOTgys2.fieldvalues['�绰']:=dbedh.Text;
     DMypgl.ADOTgys2.fieldvalues['����']:=dbecz.Text;
     DMypgl.ADOTgys2.Post;//�ύ����
 //�������ݼ�
                DMypgl.ADOTypgl.Close;
                DMypgl.ADOTypgl.Open;

                DMypgl.adotgys.Close;
                DMypgl.ADOTgys.Open;

                Dmypgl.ADOQypgq.Close;
                Dmypgl.ADOQypgq.Open;

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
                
     //��ʾ��Ϣ��
     showmessage('�����޸ĳɹ�!!');
    end;
  except
     showmessage('�в��Ϸ������룬����������');
  end;
end;

procedure TFgys_modify.BTgys_NOmodifyClick(Sender: TObject);
begin
DMypgl.ADOTgys2.Cancel;
end;

end.
