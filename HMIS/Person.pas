unit Person;          //ҽ����Ա�ǼǴ��嵥Ԫ

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, Mask, ExtCtrls, Grids, DBGrids;

type
  TF_Person = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit5: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    procedure DBLookupComboBox1Enter(Sender: TObject);
    procedure DBLookupComboBox2Enter(Sender: TObject);
    procedure DBLookupComboBox1Exit(Sender: TObject);
    procedure DBLookupComboBox2Exit(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Person: TF_Person;

implementation

uses DataModule, Query, DB;

{$R *.dfm}

procedure TF_Person.DBLookupComboBox1Enter(Sender: TObject);
begin  {*****����DBLookupComboBox1�ؼ�OnEnter�¼�*****}
    DM.AT_Assis.Active := false;        //����T_Assis���ݱ�ؼ�
    DM.AT_Assis.TableName := 'Branch';  //�������ֵ
    DBLookupComboBox1.KeyField := 'Bra_Name';   //�����ű���ֶ�
    DBLookupComboBox1.ListField := 'Bra_Name';  //�����������ֶ�
    DM.AT_Assis.Active := true;         //����T_Assis���ݱ�ؼ�
end;

procedure TF_Person.DBLookupComboBox2Enter(Sender: TObject);
begin  {*****ְ��DBLookupComboBox2�ؼ�OnEnter�¼�*****}
    DM.AT_Assis.Active := false;      //����T_Assis���ݱ�ؼ�
    DM.AT_Assis.TableName := 'Duty';  //�������ֵ
    DBLookupComboBox2.KeyField := 'Duty_Name';   //�����ű���ֶ�
    DBLookupComboBox2.ListField := 'Duty_Name';  //�����������ֶ�
    DM.AT_Assis.Active := true;         //����T_Assis���ݱ�ؼ�
end;

procedure TF_Person.DBLookupComboBox1Exit(Sender: TObject);
begin  {*****����DBLookupComboBox1�ؼ�OnExit�¼�*****}
    DBLookupComboBox1.KeyField := '';  //�ȸ���ֵ��Ŀ����Ϊ�˷�ֹϵͳ�׳��쳣
    DBLookupComboBox1.ListField := '';
end;

procedure TF_Person.DBLookupComboBox2Exit(Sender: TObject);
begin  {*****ְ��DBLookupComboBox2�ؼ�OnExit�¼�*****}
    DBLookupComboBox2.KeyField := '';    //�ȸ���ֵ��Ŀ����Ϊ�˷�ֹϵͳ�׳��쳣
    DBLookupComboBox2.ListField := '';
end;

procedure TF_Person.BitBtn6Click(Sender: TObject);
var  {*****���Ұ�ť�����¼�*****}
    str1,str2:TStringList;
begin
    str1 := TStringList.Create;
    str2 := TStringList.Create;
    F_Query.Q_Table := 'Person';  //�����ұ���
    str1.Add('���');            //���ҽ����Ա��Ų����ֶ�
    str2.Add('Per_ID');          //���ҽ����Ա��������ݱ��е��ֶ���
    F_Query.T_Field[0] := 0;      //���ҽ����Ա������ʹ��ţ�Ϊ��������
    str1.Add('����');            //��Ӳ��Ų����ֶ�
    str2.Add('Per_Bra');         //��Ӳ��������ݱ��е��ֶ���
    F_Query.T_Field[1] := 1;      //��Ӳ����ֶ����ʹ��ţ�Ϊ�ַ�������
    str1.Add('ְ��');            //���ְ������ֶ�
    str2.Add('Per_Duty');        //���ְ�������ݱ��е��ֶ���
    F_Query.T_Field[2] := 1;      //���ְ���ֶ����ʹ��ţ�Ϊ�ַ�������
    F_Query.S_Field := str1;      //��ѯ������S_Field���б�����ֵ
    F_Query.N_Field := str2;      //��ѯ������N_Field���б�����ֵ
    F_Query.Query := DM.AQ_Person;  //�趨�������ݼ�ΪԱ����Ϣ��
    F_Query.ShowModal;         //�����ݼ�¼��ѯ����
end;

procedure TF_Person.BitBtn5Click(Sender: TObject);
begin  {*****�˳���ť�����¼�*****}
    Close;
end;

procedure TF_Person.BitBtn1Click(Sender: TObject);
begin  {*****���Ӱ�ť�����¼�*****}
    DM.AQ_Person.Insert;  //�������һ����¼״̬
end;

procedure TF_Person.BitBtn2Click(Sender: TObject);
begin  {*****ɾ����ť�����¼�*****}
    if Application.MessageBox('��Ҫɾ��ѡ��ļ�¼','ȷ�϶Ի���',mrOk) = mrOk then
      DM.AQ_Person.Delete;   //ɾ��һ����¼
end;

procedure TF_Person.BitBtn3Click(Sender: TObject);
begin  {*****���水ť�����¼�*****}
    if(DM.DS_Person.State = dsEdit)or(DM.DS_Person.State = dsInsert) then
      DM.AQ_Person.Post;      //�ݽ����������ݼ�
end;

procedure TF_Person.BitBtn4Click(Sender: TObject);
begin  {*****ȡ����ť�����¼�*****}
    DM.AQ_Person.Cancel;      //ȡ���ظ���ǰһ�εݽ������ݼ�
end;

procedure TF_Person.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    DM.AT_Assis.Active := false;  //����T_Assis���ݱ�ؼ�
    Action := caFree;  //�ͷ�ҽ����Ա�ǼǴ������
    F_Person := nil;
end;

end.
