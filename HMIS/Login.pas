unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ExtCtrls, DB, ADODB, Buttons;

type
  TF_Login = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TMaskEdit;
    E_Password: TEdit;
    Label3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure E_PasswordKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

  public
    { Public declarations }
  end;

var
  F_Login: TF_Login;

implementation

uses DataModule, Main, Crypt;

{$R *.dfm}

procedure TF_Login.BitBtn1Click(Sender: TObject);
var
  str :string;
begin  {*****��¼��ť����¼�******}
    if (Edit1.Text = '') then       //�û����������Ϊ���ж�
    begin
      Application.MessageBox('�������û�����','��ʾ',MB_ICONWARNING+MB_OK);
      Edit1.SetFocus;             //�������ڹ����������
      exit;
    end
    else
    with DM.AQ_SQL do
    begin                           //���´����ж��û��ĺϷ��Ժ�Ȩ��
      Close;
      SQL.Clear;        //���SQL���
      SQL.Add('SELECT * FROM Users'); //����SQL���
      SQL.Add('WHERE User_ID=:ID');  //����Ϊ�û����ŵ������빤��,����һ������ID
      Parameters.ParamByName('ID').Value := Edit1.Text; //����ID��ֵ
      Open;              //ִ��Add��SQL���
      if (RecordCount <>1) or (Trim(FieldByName('User_Password').AsString) <> Encrypt(E_Password.Text)) then //����û����Ż����벻������ʾ�����
      begin
        if (RecordCount <> 1) then
        begin
          Application.MessageBox('�û����Ų����ڣ�������������','����',MB_ICONERROR+MB_OK);
          Edit1.SetFocus;
          exit;
        end;
        str := Encrypt(E_Password.Text);
        str := Trim(FieldByName('User_Password').AsString);
        if (Encrypt(E_Password.Text) <> Trim(FieldByName('User_Password').AsString)) then
        begin
//          AnsiString str=DM.AQ_SQL.FieldByName("User_Password").AsString;
          Application.MessageBox('�û����벻��ȷ��������������','��ʾ',MB_ICONERROR+MB_OK+MB_TASKMODAL);
          E_Password.SetFocus;
          exit;
        end;
      end
      else
      begin
        F_Main.Operator := Trim(DM.AQ_SQL['User_Name']); //�û�����ֵ��DM.AQ_SQL['User_Name']����һ�ִ����ݱ���ȡ�ֶ�ֵ�ķ���
        if (Trim(FieldByName('User_Popedom').AsString) = '����Ա') then //����ԱȨ���ж�
        begin
          F_Main.Popedom := '����Ա';
          with F_Main.mxLBar.Header[5] do
          begin
            Button[1].Enabled := true; //����"�û�ע��"
            Button[3].Enabled := true; //����"��������"
            Button[4].Enabled := true; //����"��ԭ����"
          end;
//          F_Main.StatusBar1.Panels.Items[2].Text = "ĿǰȨ�ޣ�����Ա��Administrator��";
        end;
        if (Trim(FieldByName('User_Popedom').AsString) = '�û�') then //�ͻ�Ȩ���ж�
        begin
          F_Main.Popedom := '�û�';  //��Ȩ��ֵ
          with F_Main.mxLBar.Header[5] do
          begin
            Button[1].Enabled := false; //������"�û�ע��"
            Button[3].Enabled := false; //������"��������"
            Button[4].Enabled := false; //������"��ԭ����"
          end;
//          F_Main.StatusBar1.Panels.Items[2].Text = "ĿǰȨ�ޣ��û���User��";
        end;
      end;
    end;
    F_Login.Close; //�ر��û���¼����
    F_Login.Tag := 1;  //���ȷ����ť��־
end;

procedure TF_Login.BitBtn2Click(Sender: TObject);
begin  {*****ȡ����ť����¼�******}
    Close;  //�رմ���
end;

procedure TF_Login.E_PasswordKeyPress(Sender: TObject; var Key: Char);
begin  {*****���������KeyPress�¼�******}
    if (Key = #13) then        //���»س���ִ��
       BitBtn1Click(self);     //����BitBtn1��ť����¼�
end;

procedure TF_Login.FormClose(Sender: TObject; var Action: TCloseAction);
begin  {*****��¼���ڹر��¼�******}
    if(F_Login.Tag <> 1) then
      Application.Terminate;  //��ֹ��������
end;

end.
