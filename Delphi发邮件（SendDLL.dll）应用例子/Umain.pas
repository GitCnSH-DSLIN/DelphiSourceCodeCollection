{*******************************************************}
{                                                       }
{       �����ʼ�                                        }
{                                                       }
{       ��Ȩ���� (C) 2010 Tefsoft                       }
{                                                       }
{*******************************************************}


unit Umain;
//download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    btn1: TButton;
    lbl7: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    edt5: TEdit;
    edt6: TEdit;
    edt7: TEdit;
    lbl8: TLabel;
    lbl9: TLabel;
    edt8: TEdit;
    mmo1: TMemo;
    lbl10: TLabel;
    edt9: TEdit;
    btn2: TButton;
    dlgOpen1: TOpenDialog;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  Function SendMSN(Topic: string;  //����
                   Content: string; //����
                   MailAddr: string; //�ռ��˵�ַ
                   CCMailAddr: string; //���͵�ַ
                   AttachFiles: string; //����
                   SmtpMailName: string;//������
                   SmtpServer: string;   //����������
                   SmtpUser: string;     //�����ʻ�
                   SmtpPass: string;     //��������
                   SmtpPort: string = '25';     //�˿�
                   TestMail: Boolean =true):Boolean;Stdcall; external 'SendDLL.dll';
var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
  SendMSN(edt8.text,mmo1.text,edt6.text,edt7.Text ,edt9.Text,edt1.text,edt2.text,edt4.text,edt5.text,edt3.text);
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  if dlgOpen1.Execute() then
    edt9.Text :=dlgOpen1.FileName; 
end;

end.
