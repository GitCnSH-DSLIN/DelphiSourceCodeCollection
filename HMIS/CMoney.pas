unit CMoney;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Grids, DBGrids, Mask, StdCtrls, Buttons, DBCtrls,
  ExtCtrls, ComCtrls, ToolWin;

type
  TF_CMoney = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Panel2: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    StaticText1: TStaticText;
    DBEdit11: TDBEdit;
    MaskEdit1: TMaskEdit;
    DBEdit12: TDBEdit;
    DBGrid2: TDBGrid;
    ImageList1: TImageList;
    DBLookupComboBox1: TDBLookupComboBox;
    ListBox1: TListBox;
    DBGrid1: TDBGrid;
    MaskEdit2: TMaskEdit;
    procedure ToolButton1Click(Sender: TObject);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure DBLookupComboBox1Enter(Sender: TObject);
    procedure DBLookupComboBox1Exit(Sender: TObject);
    procedure DBLookupComboBox1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure MaskEdit2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure ButtonState(iState : integer);  //�û��Զ��幤������ť״̬���ù���
  public
    { Public declarations }
  end;

var
  F_CMoney: TF_CMoney;

implementation

uses DataModule, DB;  //����DB�Լ�����

{$R *.dfm}

procedure TF_CMoney.ButtonState(iState : integer);
begin
  if iState = 0 then
  begin
    ToolButton1.Enabled := false;
    ToolButton2.Enabled := false;
    ToolButton3.Enabled := false;
    ToolButton4.Enabled := true;
    ToolButton5.Enabled := true;
    ToolButton6.Enabled := false;
    ToolButton7.Enabled := false;
    ToolButton8.Enabled := false;
    ToolButton9.Enabled := false;
    ToolButton10.Enabled := false;
    ToolButton11.Enabled := false;
    DBEdit3.Enabled := true;
    DBEdit4.Enabled := true;
    DBEdit5.Enabled := true;
    Panel2.Enabled := true;
    DBGrid1.Enabled := false;
    DBGrid2.Enabled := true;
  end
  else if iState = 1 then
  begin
    ToolButton1.Enabled := true;
    ToolButton2.Enabled := true;
    ToolButton3.Enabled := true;
    ToolButton4.Enabled := false;
    ToolButton5.Enabled := false;
    ToolButton6.Enabled := true;
    ToolButton7.Enabled := true;
    ToolButton8.Enabled := true;
    ToolButton9.Enabled := true;
    ToolButton10.Enabled := true;
    ToolButton11.Enabled := true;
    DBEdit3.Enabled := false;
    DBEdit4.Enabled := false;
    DBEdit5.Enabled := false;
    Panel2.Enabled := false;
    DBGrid1.Enabled := true;
    DBGrid2.Enabled := false;
  end
  else if iState = 2 then
  begin
    BitBtn1.Enabled := false;
    BitBtn2.Enabled := false;
    BitBtn3.Enabled := true;
    BitBtn4.Enabled := true;
  end
  else if iState = 3 then
  begin
    BitBtn1.Enabled := true;
    BitBtn2.Enabled := true;
    BitBtn3.Enabled := false;
    BitBtn4.Enabled := false;
  end;
end;

procedure TF_CMoney.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin  {*****����༭���������OnKeyPress�¼�*****}
    if (Key = #13) then        //���»س���ִ��
       ToolButton1Click(self);     //����BitBtn1��ť����¼�
end;

procedure TF_CMoney.DBLookupComboBox1Enter(Sender: TObject);
begin  {*****�շ���ĿDBLookupComboBox�ؼ�OnEnter�¼�*****}
    DM.AT_Assis.Active := false;        //����T_Assis���ݱ�ؼ�
    DM.AT_Assis.TableName := 'ICure';  //�������ֵ
    DBLookupComboBox1.KeyField := 'ICure_Name';   //���շ���Ŀ����ֶ�
    DBLookupComboBox1.ListField := 'ICure_Name';  //���շ���Ŀ�����ֶ�
    DM.AT_Assis.Active := true;         //����T_Assis���ݱ�ؼ�
end;

procedure TF_CMoney.DBLookupComboBox1Exit(Sender: TObject);
begin  {*****�շ���ĿDBLookupComboBox�ؼ�OnExit�¼�*****}
    DBLookupComboBox1.KeyField := '';  //�ȸ���ֵ��Ŀ����Ϊ�˷�ֹϵͳ�׳��쳣
    DBLookupComboBox1.ListField := '';
end;

procedure TF_CMoney.DBLookupComboBox1Click(Sender: TObject);
var  {*****�շ���ĿDBLookupComboBox�ؼ�OnClick�¼�*****}
    i:integer;
begin
    if Trim(DBLookupComboBox1.Text) = 'ҩƷ' then
      begin
      DM.AQ_CDrug.Open;
      DM.AQ_CDrug.First;   //��ǰ��¼Ϊ��һ����¼
      for i:=0 to DM.AQ_CDrug.RecordCount-1 do
        begin
        ListBox1.Items.Add(TrimRight(DM.AQ_CDrug.FieldByName('CDrug_Name').Value)+'  '+TrimRight(DM.AQ_CDrug.FieldByName('CDrug_Unit').Value)+'  '+FloatToStr(DM.AQ_CDrug.FieldByName('CDrug_Money').Value));
        DM.AQ_CDrug.Next;  //��ǰ��¼����һ��
        end;
      end;
end;

procedure TF_CMoney.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if DM.DS_TCMoney.State in [dsInsert, dsEdit] then  //����շ���Ŀ�ܱ����ݼ����ڲ�����߱༭״̬ʱ
      DM.AQ_TCMoney.Cancel;  //ȡ�����ݼ��Ĳ��� 
    if DM.DS_CMoney.State in [dsInsert, dsEdit] then  //����շ���Ŀ��ϸ�����ݼ����ڲ�����߱༭״̬ʱ
      DM.AT_CMoney.Cancel;  //ȡ�����ݼ��Ĳ���
    Action := caFree;  //�ͷŴ������
    F_CMoney := nil;
end;

procedure TF_CMoney.ToolButton1Click(Sender: TObject);
var  {*****���ӿ�ݰ�ť�����¼�*****}
    RecordID:integer;
begin
    if Trim(MaskEdit2.Text) <> '' then
      begin
      try
        DM.AT_CReg.Close;
        DM.AT_CReg.Filter := 'CReg_ID=' + Trim(MaskEdit2.Text);  //���ù���������ȡ���˹Һű��
        DM.AT_CReg.Filtered := true;  //����������
        DM.AT_CReg.Open;
      except
        ShowMessage('������Һ����ݱ�ʱ����');
      end;
      if DM.AT_CReg.RecordCount <> 1 then
        begin
        ShowMessage('����������Ų����ڣ���ȷ��');
        exit;
        end;
      with DM.AT_Count do
      begin
        Close;   
        Filter := 'Count_Name=''POutputB'''; //���ù���������ȡҩƷ���ⵥ��Ϣ�����ֵ
        Filtered := true;               //����������
        Open;                           //�򿪼�¼��ż�����
        RecordID := DM.AT_CountCount_Value.Value;   //��ȡ����ֵ��ע��ʹ��AT_CountCount_Value��ȡ��¼ֵ����Ϊ��AT_Count�ؼ����ֶα༭�������������ֶ�
        Edit;
        DM.AT_CountCount_Value.Value := RecordID + 1;
        Post;
      end;  
      DM.AQ_TCMoney.Insert;  //����һ�������շѵ���¼
      DM.AQ_TCMoneyTCM_ID.Value := RecordID + 1;    //���ⵥ�༭��ֵ
      DM.AQ_TCMoneyTCM_RID.Value := DM.AT_CReg.FieldByName('CReg_ID').Value;  //����Һű�Ÿ�ֵ
      DM.AQ_TCMoneyTCM_Name.Value := DM.AT_CReg.FieldByName('CReg_Name').Value;  //����
      DM.AQ_TCMoneyTCM_Date.Value := DM.AT_CReg.FieldByName('CReg_Date').Value;  //����
      end
    else
    begin
      Application.MessageBox('�����Ų���Ϊ�գ�������', '��ʾ', MB_ICONINFORMATION + MB_OK);
      exit;
    end;
    ButtonState(0);  //��������ťʹ�����ù���
end;

procedure TF_CMoney.ToolButton2Click(Sender: TObject);
begin  {*****�༭��ݰ�ť�����¼�*****}
    if not DM.AQ_TCMoney.IsEmpty then  //�շѵ����ݱ�ǿ�
    begin
      DM.AQ_TCMoney.Edit;  //�༭һ�������շѵ���¼
      ButtonState(0);  //��������ťʹ�����ù���
    end;  
end;

procedure TF_CMoney.ToolButton3Click(Sender: TObject);
var
    iMsgFlag : integer;
begin  {*****ɾ����ݰ�ť�����¼�*****}
  iMsgFlag  := Application.MessageBox('��ȷ��Ҫɾ����ǰ������', 'ȷ��', MB_ICONQUESTION + MB_OKCANCEL +MB_DEFBUTTON2) ;
  if iMsgFlag  = IDOK then
    DM.AQ_TCMoney.Delete;
end;

procedure TF_CMoney.ToolButton4Click(Sender: TObject);
begin  {*****�ύ��ݰ�ť�����¼�*****}
    DM.AQ_TCMoney.Post;  //�ύ�����շѵ���¼���ݼ�
    ButtonState(1);  //��������ťʹ�����ù���
end;

procedure TF_CMoney.ToolButton5Click(Sender: TObject);
begin  {*****ȡ����ݰ�ť�����¼�*****}
    DM.AQ_TCMoney.Cancel;  //�ύ�����շѵ���¼���ݼ�
    ButtonState(1);  //��������ťʹ�����ù���
end;

procedure TF_CMoney.ToolButton6Click(Sender: TObject);
begin  {*****��ǰ����ݰ�ť�����¼�*****}
    DM.AQ_TCMoney.First;
end;

procedure TF_CMoney.ToolButton7Click(Sender: TObject);
begin  {*****ǰһ����ݰ�ť�����¼�*****}
    if not DM.AQ_TCMoney.Eof then
      DM.AQ_TCMoney.Prior;
end;

procedure TF_CMoney.ToolButton8Click(Sender: TObject);
begin  {*****��һ����ݰ�ť�����¼�*****}
    if not DM.AQ_TCMoney.Bof then
      DM.AQ_TCMoney.Next;
end;

procedure TF_CMoney.ToolButton9Click(Sender: TObject);
begin  {*****�������ݰ�ť�����¼�*****}
    DM.AQ_TCMoney.Last;
end;

procedure TF_CMoney.ToolButton10Click(Sender: TObject);
begin  {*****���ҿ�ݰ�ť�����¼�*****}

end;

procedure TF_CMoney.ToolButton11Click(Sender: TObject);
begin  {*****��ӡ��ݰ�ť�����¼�*****}

end;

procedure TF_CMoney.ToolButton12Click(Sender: TObject);
begin  {*****�˳���ݰ�ť�����¼�*****}
   Close;
end;


procedure TF_CMoney.BitBtn1Click(Sender: TObject);
begin  {*****���Ӱ�ť�����¼�*****}
    DM.AT_CMoney.Append;  //�����շ���Ŀ��¼
    DM.AT_CMoney['CM_ID'] := DM.AQ_TCMoneyTCM_ID.Value;
    ButtonState(2);
end;

procedure TF_CMoney.BitBtn2Click(Sender: TObject);
var
    iMsgFlag : integer;
begin  {*****ɾ���շ���Ŀ��ť�����¼�*****}
    iMsgFlag  := Application.MessageBox('��ȷ��Ҫɾ����ǰ������', 'ȷ��', MB_ICONQUESTION + MB_OKCANCEL +MB_DEFBUTTON2) ;
    if iMsgFlag  = IDOK then
      DM.AT_CMoney.Delete;
end;

procedure TF_CMoney.BitBtn3Click(Sender: TObject);
begin  {*****�ύ�շ���Ŀ���ݼ���ť�����¼�*****}
    DM.AT_CMoney.Post;
    ButtonState(3);
end;

procedure TF_CMoney.BitBtn4Click(Sender: TObject);
begin  {*****ȡ���ύ�շ���Ŀ���ݼ���ť�����¼�*****}
    DM.AT_CMoney.Cancel;
    ButtonState(3);    
end;

procedure TF_CMoney.MaskEdit2KeyPress(Sender: TObject; var Key: Char);
begin  {*****����༭���������OnKeyPress�¼�*****}
    if (Key = #13) then        //���»س���ִ��
       ToolButton1Click(self);     //����BitBtn1��ť����¼�
end;

end.
