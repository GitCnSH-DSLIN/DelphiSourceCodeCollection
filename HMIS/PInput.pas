unit PInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids;

type
  TF_Input = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    DBGrid2: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Input: TF_Input;

implementation

uses DataModule, Main, Query ,DB;

{$R *.dfm}

procedure TF_Input.FormShow(Sender: TObject);
begin  {*****ҩƷ��������OnShow�¼�*****}
    DM.AT_Assis.Active := false;        //����T_Assis���ݱ�ؼ�
    DM.AT_Assis.TableName := 'Company';  //�������ֵ
//    DBLookupComboBox1.KeyField := 'CUnit_Name';   //��������λ����ֶ�
//    DBLookupComboBox1.ListField := 'CUnit_Name';  //��������λ�����ֶ�
    DM.AT_Assis.Active := true;         //����T_Assis���ݱ�ؼ�
end;

procedure TF_Input.BitBtn1Click(Sender: TObject);
var  {*****ҩƷ��ⵥ���Ӱ�ť�����¼�*****}
    RecordID:integer;
begin
    DM.AT_Count.Filter := 'Count_Name=''PInputB''';  //���ù���������ȡҩƷ��ⵥ��Ϣ�����ֵ
    DM.AT_Count.Filtered := true;                  //����������
    DM.AT_Count.Open;                           //�򿪼�¼��ż�����
    RecordID := DM.AT_CountCount_Value.Value;    //��ȡ����ֵ��ע��ʹ��AT_CountCount_Value��ȡ��¼ֵ����Ϊ��AT_Count�ؼ����ֶα༭�������������ֶ�
    DM.AQ_PInputB.Append;                       //ҩƷ��ⵥ��Ϣ�����������ݼ�¼״̬
    DM.AQ_PInputB.FieldByName('PINB_PID').Value := RecordID;  //��ⵥ����ֶθ�ֵ
    DM.AQ_PInputB.FieldByName('PINB_Operator').Value := F_Main.Operator; //����Ա�ֶθ�ֵ  
    DM.AQ_PInputB.FieldByName('PINB_Date').Value := Now;  //�����ֶθ�ֵ
    DM.AQ_PInputB.Post;   //ҩƷ��ⵥ��Ϣ���ύ���ݼ�
    DM.AT_Count.Edit;     //�༭��¼�ż������ݱ�
    DM.AT_CountCount_Value.Value := RecordID+1;  //��¼�ż�1�ٸ�ֵ
    DM.AT_Count.Post;     //�ύ�༭����
    DM.AT_Count.Close;    //�رռ�¼�ż������ݱ�
end;

procedure TF_Input.BitBtn2Click(Sender: TObject);
begin  {*****ҩƷ��ⵥɾ����ť�����¼�*****}
    if Application.MessageBox('��Ҫɾ��ѡ��ļ�¼','ȷ�϶Ի���',mrOk) = mrOk then
      DM.AQ_PInputB.Delete;   //ɾ��һ����¼
end;

procedure TF_Input.BitBtn6Click(Sender: TObject);
var  {*****���Ұ�ť�����¼�*****}
    str1,str2:TStringList;
begin
    str1 := TStringList.Create;
    str2 := TStringList.Create;
    F_Query.Q_Table := 'PInputB';   //�����ұ���
    str1.Add('ҩƷ��ⵥ���');    //���ҩƷ��ⵥ��Ų����ֶ�
    str2.Add('PINB_PID');          //���ҩƷ��ⵥ��������ݱ��е��ֶ���
    F_Query.T_Field[0] := 0;        //���ҩƷ������ʹ��ţ�Ϊ��������
    str1.Add('����Ա');            //��Ӳ���Ա�����ֶ�
    str2.Add('PINB_Operator');     //��Ӳ���Ա�����ݱ��е��ֶ���
    F_Query.T_Field[1] := 1;        //���ҩƷ�����ֶ����ʹ��ţ�Ϊ�ַ�������
    str1.Add('�������');          //���������ڲ����ֶ�
    str2.Add('PINB_Date');         //���������������ݱ��е��ֶ���
    F_Query.T_Field[2] := 2;        //�����������ֶ����ʹ��ţ�Ϊ��������
    F_Query.S_Field := str1;        //��ѯ������S_Field���б�����ֵ
    F_Query.N_Field := str2;        //��ѯ������N_Field���б�����ֵ
    F_Query.Query := DM.AQ_PInputB;  //�趨�������ݼ�ΪҩƷ��ⵥ��Ϣ��
    F_Query.ShowModal;           //�����ݼ�¼��ѯ����
end;

procedure TF_Input.BitBtn10Click(Sender: TObject);
begin  {*****��ӡ��ť�����¼�*****}

end;

procedure TF_Input.BitBtn9Click(Sender: TObject);
begin  {*****������ť�����¼�*****}
    ShowMessage('��һ�����������Ӱ�ť������һ��ҩƷ��ⵥ  �ڶ��������������ť������������߶�ӦҩƷ��ⵥ��ҩƷ����¼');
end;

procedure TF_Input.BitBtn5Click(Sender: TObject);
begin  {*****�˳���ť�����¼�*****}
    DM.AT_Assis.Active := false;  //����T_Assis���ݱ�ؼ�
    F_Input.Close;
//    F_Input.Free;     //�ͷ�ҩƷ�����������
//    F_Input := nil;
end;

procedure TF_Input.BitBtn7Click(Sender: TObject);
var  {*****���밴ť�����¼�*****}
    RecordID:integer;
begin
    with DM.AT_Count do
    begin
      Filter := 'Count_Name=''PInput''';   //���ù���������ȡҩƷ��ⵥ��Ϣ�����ֵ
      Filtered := true;                  //����������
      Open;                           //�򿪼�¼��ż�����
    end;
    RecordID := DM.AT_CountCount_Value.Value;    //��ȡ����ֵ��ע��ʹ��AT_CountCount_Value��ȡ��¼ֵ����Ϊ��AT_Count�ؼ����ֶα༭�������������ֶ�
    DM.AT_PInput.Append;                        //ҩƷ����¼��Ϣ�����������ݼ�¼״̬
    DM.AT_PInputPIN_ID.AsInteger := RecordID + 1;  //����¼����ֶθ�ֵ
    DM.AT_PInput.FieldByName('PIN_PID').Value := DM.AQ_PInputB.FieldByName('PINB_PID').Value;  //ҩƷ��ⵥ�ֶθ�ֵ�����ֶ���AQ_PInputB��PINB_PID�ֶι������ӹ�ϵ
    with DM.AT_Count do
    begin
      Edit;     //�༭��¼�ż������ݱ�
      FieldByName('Count_Value').Value := RecordID+1;  //��¼�ż�1�ٸ�ֵ
      Post;     //�ύ�༭����
      Close;    //�رռ�¼�ż������ݱ�
    end;  
end;

procedure TF_Input.BitBtn8Click(Sender: TObject);
begin  {*****ɾ����ť�����¼�*****}
    if Application.MessageBox('��Ҫɾ��ѡ��ļ�¼','ȷ�϶Ի���',mrOk) = mrOk then
      DM.AT_PInput.Delete;   //ɾ��һ����¼
end;

procedure TF_Input.BitBtn11Click(Sender: TObject);
begin  {*****���水ť�����¼�*****}
    if(DM.DS_PInput.State = dsEdit)or(DM.DS_PInput.State = dsInsert) then
      DM.AT_PInput.Post;      //�ݽ����������ݼ�
end;

procedure TF_Input.BitBtn12Click(Sender: TObject);
begin  {*****ȡ����ť�����¼�*****}
    DM.AT_PInput.Cancel;      //ȡ���ظ���ǰһ�εݽ������ݼ�
end;

end.
