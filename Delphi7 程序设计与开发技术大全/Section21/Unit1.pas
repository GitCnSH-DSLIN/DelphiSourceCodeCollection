unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, DBTables;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edt_user: TEdit;
    Label2: TLabel;
    Edt_passwd: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Pwquery: TQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  times:Integer;

implementation

uses Unit2, Unit3, Unit8;

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
times := times+1;
//with DataModule2 do
//begin
  Pwquery.close;
  Pwquery.ParamByName('Userid').Value:=edt_user.Text;	//��query���������ֵ
  Pwquery.Open;										//�� query�����ѯ��¼
//end;
if Pwquery.Fields[0].value=null then				//�ж��û����Ƿ����
begin
Application.MessageBox('��ȷ���û����Ƿ���ȷ��','�û�������',mb_ok);
exit;
end;
if Pwquery.Fields[0].value=edt_passwd.Text then	//�ж������Ƿ���ȷ
begin
if Pwquery.Fields[1].value='1' then					//�ж��û�Ȩ���Ƿ���ȷ
begin
Form1.hide;									//���ص�¼����
form3.show;										//��ʾ������
end
else
begin
Form1.hide;									//���ص�¼����
form8.show;
end;
end
else
if MessageDlg('������������Ƿ��˳���',mtConfirmation,[mbYes,mbNo],0)
= mrYes then Close
else if times<3 then edt_passwd.SetFocus
else
begin
MessageDlg('�Բ��������������ش������˳���',mtInformation,[mbOk], 0);
application.Terminate ;
end;

end ;

{����ʼ����ʱ������г�ʼ����
��Edit_user��Edit_passwd�����������ա�
���ڴ����OnCreate�¼�ʵ�֡�}
procedure TForm1.FormCreate(Sender: TObject);
begin
edt_user.Text:='';									//����û��������
edt_passwd.Text:='';								//������������
times:=0;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
close;
end;

end.
