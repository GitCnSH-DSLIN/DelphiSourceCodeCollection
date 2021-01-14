unit Pass_Pope_Modify;    //�޸����롢Ȩ�޴��嵥Ԫ

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TF_PP_Modi = class(TForm)
    StaticText1: TStaticText;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    StaticText2: TStaticText;
    Edit2: TEdit;
    StaticText4: TStaticText;
    Edit4: TEdit;
    Edit3: TEdit;
    CheckBox1: TCheckBox;
    StaticText3: TStaticText;
    GroupBox2: TGroupBox;
    StaticText6: TStaticText;
    ComboBox1: TComboBox;
    CheckBox2: TCheckBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_PP_Modi: TF_PP_Modi;

implementation

uses DataModule, Crypt;

{$R *.dfm}

procedure TF_PP_Modi.FormCreate(Sender: TObject);
begin  {*****�����ʼ���¼�*****}
      Edit2.Visible := false;     //����Edit���󲻿ɼ�
      Edit3.Visible := false;
      Edit4.Visible := false;
      ComboBox1.Visible := false; //ComboBox1���󲻿ɼ�
end;

procedure TF_PP_Modi.CheckBox1Click(Sender: TObject);
begin  {*****�޸�����CheckBox����¼�*****}
    if CheckBox1.Checked then       //CheckBox1ѡ���ж�
      begin
      Edit2.Visible := true;        //����Edit����ɼ�
      Edit3.Visible := true;
      Edit4.Visible := true;
      end
    else
      begin
      Edit2.Visible := false;     //����Edit���󲻿ɼ�
      Edit3.Visible := false;
      Edit4.Visible := false;
      end;
end;

procedure TF_PP_Modi.CheckBox2Click(Sender: TObject);
begin  {*****�޸�Ȩ��CheckBox����¼�*****}
    if CheckBox2.Checked then        //CheckBox2ѡ���ж�
      ComboBox1.Visible := true   //ComboBox1����ɼ�
    else
      ComboBox1.Visible := false; //ComboBox1���󲻿ɼ�
end;

procedure TF_PP_Modi.BitBtn1Click(Sender: TObject);
begin  {*****ȷ����ť����¼�*****}
  if CheckBox1.Checked then         //�޸�����CheckBox1ѡ���ж�
    begin
    if (Edit1.Text = '')or(Edit3.Text <> Edit4.Text) then
      begin
      if Edit1.Text='' then  //���������Ϊ���ж�
        begin
        ShowMessage('�������û�����');
        Edit1.SetFocus;          //�������ڹ����������
        exit;
        end;
      if(Edit3.Text <> Edit4.Text)then //���������Ƿ�һ���ж�
        begin
        ShowMessage('���������벻һ�£�������������');
        Edit3.SetFocus;
        exit;
        end;
      end
    else                       //����û����ź������Ƿ���ȷ
    with DM.AQ_SQL do
      begin
        Close;
        SQL.Clear;  //���SQL���
        SQL.Add('SELECT User_ID,User_Password FROM Users');
        SQL.Add('WHERE User_ID=:ID_Val');  //���ò�ѯ�������ݵ���������ID_Val,Password
        SQL.Add('AND User_Password=:PassWord');
        Parameters.ParamByName('ID_Val').Value := Edit1.Text;  //����������ֵ
        Parameters.ParamByName('PassWord').Value := Encrypt(Edit2.Text);  //EncryptΪ�������㷨���ܺ���
        Open;       //ִ��SQL���
      if RecordCount<>1 then
        begin
        ShowMessage('���벻��ȷ������������');
        Edit2.SetFocus;
        exit;
        end
      else
        begin
          Edit;     //�����¼�༭״̬
          FieldByName('User_Password').Value := Encrypt(Edit3.Text);
          Post;
          Application.MessageBox('�����޸ĳɹ�', '��ʾ', MB_ICONINFORMATION+MB_OK);
        end;
      end;
    end;
  ////�޸�Ȩ���ⲿ�ֹ����Ѿ�����
  if CheckBox2.Checked then //�޸�Ȩ��CheckBox2ѡ���ж�
  begin
    if ComboBox1.Text='' then
      begin
      ShowMessage('����ѡ��Ȩ������');
      ComboBox1.SetFocus;
      exit;
      end
    else    //����û����ź������Ƿ���ȷ
    with DM.AQ_SQL do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT User_ID,User_Popedom FROM Users');
        SQL.Add('WHERE User_ID=:User_Val'); //���ò���
        Parameters.ParamByName('User_Val').Value := Edit1.Text;  //������ֵ
        Open;
      if(RecordCount <> 1)then
        begin
        ShowMessage('���û����Ų�����');
        Edit1.SetFocus();
        end
      else
        begin
          Edit;  //�����¼�༭״̬
          FieldByName('User_Popedom').Value := ComboBox1.Text;
          Post;
        ShowMessage('Ȩ���޸ĳɹ�');
        end;
      end;
  end;   
  F_PP_Modi.Close;
end;

procedure TF_PP_Modi.BitBtn2Click(Sender: TObject);
begin  {*****ȡ����ť����¼�*****}
    F_PP_Modi.Close;        
end;

procedure TF_PP_Modi.Edit4KeyPress(Sender: TObject; var Key: Char);
begin  {*****ȷ�����������KeyPress�¼�*****}
    if (Key = #13) then        //���»س���ִ��
      BitBtn1Click(self);      //����BitBtn1��ť����¼�
end;

end.
