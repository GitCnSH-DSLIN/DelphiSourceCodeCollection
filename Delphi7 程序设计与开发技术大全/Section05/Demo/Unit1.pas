unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    UserTxt: TEdit;
    PSWTxt: TEdit;
    Panel1: TPanel;
    CancelBtn: TButton;
    OKBtn: TButton;
    Label3: TLabel;
    procedure UserTxtKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CancelBtnClick(Sender: TObject);
    procedure PSWTxtKeyPress(Sender: TObject; var Key: Char);
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.UserTxtKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=13 then         //����OnKeyDown�¼��е�Key�����ж��Ƿ��»س���
    PSWTxt.SetFocus;     //����SetFocus�����������ƶ��������롱�༭��
end;

procedure TForm1.CancelBtnClick(Sender: TObject);
begin
  UserTxt.Text:='';      //����Text���Խ����û������༭�����
  PSWTxt.Clear;          //����Clear�����������롱�༭�����
  UserTxt.SetFocus;      //����SetFocus�����������ƶ������û������༭��
end;

procedure TForm1.PSWTxtKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then        //����KeyPress�¼���Key�����ж��Ƿ��»س���
  begin
    OKBtn.SetFocus;      //����SetFocus�����������ƶ�����ȷ������ť
    Exit;                //�˳����¼�
  end;

  {����KeyPress�¼��е�Key�����ж��û�����ֵ������������ּ���
   ��Keyֵ����Ϊ#0���൱��û�м�����}
  if (Key<#48) or (Key>#57) then
    Key:=#0;
end;

procedure TForm1.OKBtnClick(Sender: TObject);
begin
  {�ж��û�������û����������Ƿ���ȷ�������ȷ����ʾ����¼�ɹ���������
   �������ȷ����ʾ�����������������á����á���ť��OnClick�¼����û�
   ��������༭�����}

  if (UserTxt.Text='Admin') and (PSWTxt.Text='123') then
    Label3.Caption:='��¼�ɹ���'+#13+'��ӭʹ��Delphi 7'
  else
  begin
    Label3.Caption:='���󣡡�'+#13+'�û���Ϊ��Admin'+#13
                    +'����Ϊ��123'+#13+'ע���Сд�����������ԡ�';
    CancelBtn.Click;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Label3.Caption:='�û�����Admin'+#13+'���룺123';    //����Label3��Caption����
end;

end.
