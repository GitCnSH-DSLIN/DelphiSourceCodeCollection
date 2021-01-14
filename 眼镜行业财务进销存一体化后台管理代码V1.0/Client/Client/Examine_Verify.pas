unit Examine_Verify;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ExtCtrls, ComCtrls, Buttons, StdCtrls, Grids, DBGrids,
  ToolWin, ImgList;

type
  Tfrm_Examine_Verify = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TLabeledEdit;
    Edit2: TLabeledEdit;
    Edit3: TLabeledEdit;
    Edit4: TLabeledEdit;
    Edit5: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    ListBox1: TListBox;
    Edit11: TLabeledEdit;
    SPB1: TSpeedButton;
    Edit22: TLabeledEdit;
    SPB2: TSpeedButton;
    Edit33: TLabeledEdit;
    SPB3: TSpeedButton;
    Edit44: TLabeledEdit;
    SPB4: TSpeedButton;
    Edit55: TLabeledEdit;
    SPB5: TSpeedButton;
    Cmd_OK: TSpeedButton;
    Cmd_Edit: TSpeedButton;
    Cmd_Delete: TSpeedButton;
    Cmd_No: TSpeedButton;
    ComboBox1: TComboBox;
    procedure ListBox1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Cmd_OKClick(Sender: TObject);
    procedure SPB1Click(Sender: TObject);
    procedure SPB2Click(Sender: TObject);
    procedure SPB3Click(Sender: TObject);
    procedure SPB4Click(Sender: TObject);
    procedure SPB5Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Cmd_EditClick(Sender: TObject);
    procedure Cmd_DeleteClick(Sender: TObject);
    procedure Cmd_NoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    //procedure ViewVerify(LISTv:TLISTVIEW;Sno:STRING);
  public
    { Public declarations }
  end;

var
  frm_Examine_Verify: Tfrm_Examine_Verify;

implementation

uses Data, Man_Check, func, untdatadm;

{$R *.dfm}
//�Զ����ı����Ƿ��ܹ�����
//////////////////////////////////////
function Edit_Visbale:boolean;
begin
    if frm_Examine_Verify.Edit1.Visible=true then
    begin
        frm_Examine_Verify.Edit11.Visible:=true;
        frm_Examine_Verify.SPB1.Visible:=True;
    end
    else
    begin
        frm_Examine_Verify.Edit11.Visible:=False;
        frm_Examine_Verify.SPB1.Visible:=False;
    end;
    if frm_Examine_Verify.Edit2.Visible=true then
    begin
        frm_Examine_Verify.Edit22.Visible:=true;
        frm_Examine_Verify.SPB2.Visible:=True;
    end
    else
    begin
        frm_Examine_Verify.Edit22.Visible:=False;
        frm_Examine_Verify.SPB2.Visible:=False;
    end;
    if frm_Examine_Verify.Edit3.Visible=true then
    begin
        frm_Examine_Verify.Edit33.Visible:=true;
        frm_Examine_Verify.SPB3.Visible:=True;
    end
    else
    begin
        frm_Examine_Verify.Edit33.Visible:=False;
        frm_Examine_Verify.SPB3.Visible:=False;
    end;
    if frm_Examine_Verify.Edit4.Visible=true then
    begin
        frm_Examine_Verify.Edit44.Visible:=true;
        frm_Examine_Verify.SPB4.Visible:=True;
    end
    else
    begin
        frm_Examine_Verify.Edit44.Visible:=False;
        frm_Examine_Verify.SPB4.Visible:=False;
    end;
    if frm_Examine_Verify.Edit1.Visible=true then
    begin
        frm_Examine_Verify.Edit55.Visible:=true;
        frm_Examine_Verify.SPB5.Visible:=True;
    end
    else
    begin
        frm_Examine_Verify.Edit55.Visible:=False;
        frm_Examine_Verify.SPB5.Visible:=False;
    end;
end;
//�Զ��������˼������ж��ı������ʾ�����
function ComboBox_Edit_Visbale:boolean;
begin
    if StrToInt(Trim(frm_Examine_Verify.ComboBox1.Text))=1 then
    begin
        frm_Examine_Verify.Edit1.Visible:=True;  frm_Examine_Verify.Edit11.Visible:=True;
        frm_Examine_Verify.Edit2.Visible:=False;
        frm_Examine_Verify.Edit3.Visible:=False;frm_Examine_Verify.Edit4.Visible:=False;
        frm_Examine_Verify.Edit5.Visible:=False;
        Edit_Visbale;
    end;
    if StrToInt(Trim(frm_Examine_Verify.ComboBox1.Text))=2 then
    begin
        frm_Examine_Verify.Edit1.Visible:=True;frm_Examine_Verify.Edit2.Visible:=True;
        frm_Examine_Verify.Edit11.Visible:=True;frm_Examine_Verify.Edit22.Visible:=True;
        frm_Examine_Verify.Edit3.Visible:=False;frm_Examine_Verify.Edit4.Visible:=False;
        frm_Examine_Verify.Edit5.Visible:=False;
        Edit_Visbale;
    end;
    if StrToInt(Trim(frm_Examine_Verify.ComboBox1.Text))=3 then
    begin
        frm_Examine_Verify.Edit1.Visible:=True;frm_Examine_Verify.Edit2.Visible:=True;
        frm_Examine_Verify.Edit3.Visible:=True;
        frm_Examine_Verify.Edit11.Visible:=True;frm_Examine_Verify.Edit22.Visible:=True;
        frm_Examine_Verify.Edit33.Visible:=True;
        frm_Examine_Verify.Edit4.Visible:=False;frm_Examine_Verify.Edit5.Visible:=False;
        Edit_Visbale;
    end;
    if StrToInt(Trim(frm_Examine_Verify.ComboBox1.Text))=4 then
    begin
        frm_Examine_Verify.Edit1.Visible:=True;frm_Examine_Verify.Edit2.Visible:=True;
        frm_Examine_Verify.Edit3.Visible:=True;frm_Examine_Verify.Edit4.Visible:=True;
        frm_Examine_Verify.Edit11.Visible:=True;frm_Examine_Verify.Edit22.Visible:=True;
        frm_Examine_Verify.Edit33.Visible:=True;frm_Examine_Verify.Edit44.Visible:=True;
        frm_Examine_Verify.Edit5.Visible:=False;
        Edit_Visbale;
    end;
    if StrToInt(Trim(frm_Examine_Verify.ComboBox1.Text))=5 then
    begin
        frm_Examine_Verify.Edit1.Visible:=True;frm_Examine_Verify.Edit2.Visible:=True;
        frm_Examine_Verify.Edit3.Visible:=True;frm_Examine_Verify.Edit4.Visible:=True;
        frm_Examine_Verify.Edit5.Visible:=True;
        frm_Examine_Verify.Edit11.Visible:=True;frm_Examine_Verify.Edit22.Visible:=True;
        frm_Examine_Verify.Edit33.Visible:=True;frm_Examine_Verify.Edit44.Visible:=True;
        frm_Examine_Verify.Edit55.Visible:=True;
        Edit_Visbale;
    end;
end;
//�Զ��庯����������Ͽ��index�������ж��ı������ʾ����
function ComboBox_Index:boolean;
begin
    if frm_Examine_Verify.ComboBox1.ItemIndex=0 then
    begin
        frm_Examine_Verify.Edit1.Visible:=False;  frm_Examine_Verify.Edit2.Visible:=False;  frm_Examine_Verify.Edit3.Visible:=False;  frm_Examine_Verify.Edit4.Visible:=False;  frm_Examine_Verify.Edit5.Visible:=False;
        frm_Examine_Verify.Edit11.Visible:=False; frm_Examine_Verify.Edit22.Visible:=False; frm_Examine_Verify.Edit33.Visible:=False; frm_Examine_Verify.Edit44.Visible:=False; frm_Examine_Verify.Edit55.Visible:=False;
        frm_Examine_Verify.SPB1.Visible:=False;   frm_Examine_Verify.SPB2.Visible:=False;   frm_Examine_Verify.SPB3.Visible:=False;   frm_Examine_Verify.SPB4.Visible:=False;   frm_Examine_Verify.SPB5.Visible:=False;
        frm_Examine_Verify.Edit1.Clear;           frm_Examine_Verify.Edit2.Clear;           frm_Examine_Verify.Edit3.Clear;           frm_Examine_Verify.Edit4.Clear;           frm_Examine_Verify.Edit5.Clear;
        frm_Examine_Verify.Edit1.Clear;           frm_Examine_Verify.Edit22.Clear;          frm_Examine_Verify.Edit33.Clear;          frm_Examine_Verify.Edit44.Clear;          frm_Examine_Verify.Edit55.Clear;
        frm_Examine_Verify.Cmd_OK.Enabled:=False;frm_Examine_Verify.Cmd_Edit.Enabled:=False;frm_Examine_Verify.Cmd_Delete.Enabled:=False;
    end;
    if frm_Examine_Verify.ComboBox1.ItemIndex=1 then
    begin
        frm_Examine_Verify.Edit1.Visible:=True;  frm_Examine_Verify.Edit2.Visible:=False;  frm_Examine_Verify.Edit3.Visible:=False;  frm_Examine_Verify.Edit4.Visible:=False;  frm_Examine_Verify.Edit5.Visible:=False;
        frm_Examine_Verify.Edit11.Visible:=True; frm_Examine_Verify.Edit22.Visible:=False; frm_Examine_Verify.Edit33.Visible:=False; frm_Examine_Verify.Edit44.Visible:=False; frm_Examine_Verify.Edit55.Visible:=False;
        frm_Examine_Verify.SPB1.Visible:=True;   frm_Examine_Verify.SPB2.Visible:=False;   frm_Examine_Verify.SPB3.Visible:=False;   frm_Examine_Verify.SPB4.Visible:=False;   frm_Examine_Verify.SPB5.Visible:=False;
        frm_Examine_Verify.Edit1.Clear;          frm_Examine_Verify.Edit2.Clear;           frm_Examine_Verify.Edit3.Clear;           frm_Examine_Verify.Edit4.Clear;           frm_Examine_Verify.Edit5.Clear;
        frm_Examine_Verify.Edit11.Clear;         frm_Examine_Verify.Edit22.Clear;          frm_Examine_Verify.Edit33.Clear;          frm_Examine_Verify.Edit44.Clear;          frm_Examine_Verify.Edit55.Clear;
        frm_Examine_Verify.Cmd_OK.Enabled:=true;
    end;
    if frm_Examine_Verify.ComboBox1.ItemIndex=2 then
    begin
        frm_Examine_Verify.Edit1.Visible:=True;  frm_Examine_Verify.Edit2.Visible:=True;  frm_Examine_Verify.Edit3.Visible:=False;  frm_Examine_Verify.Edit4.Visible:=False;  frm_Examine_Verify.Edit5.Visible:=False;
        frm_Examine_Verify.Edit11.Visible:=True; frm_Examine_Verify.Edit22.Visible:=True; frm_Examine_Verify.Edit33.Visible:=False; frm_Examine_Verify.Edit44.Visible:=False; frm_Examine_Verify.Edit55.Visible:=False;
        frm_Examine_Verify.SPB1.Visible:=True;   frm_Examine_Verify.SPB2.Visible:=True;   frm_Examine_Verify.SPB3.Visible:=False;   frm_Examine_Verify.SPB4.Visible:=False;   frm_Examine_Verify.SPB5.Visible:=False;
        frm_Examine_Verify.Edit1.Clear;          frm_Examine_Verify.Edit2.Clear;          frm_Examine_Verify.Edit3.Clear;           frm_Examine_Verify.Edit4.Clear;           frm_Examine_Verify.Edit5.Clear;
        frm_Examine_Verify.Edit11.Clear;         frm_Examine_Verify.Edit22.Clear;         frm_Examine_Verify.Edit33.Clear;          frm_Examine_Verify.Edit44.Clear;          frm_Examine_Verify.Edit55.Clear;
        frm_Examine_Verify.Cmd_OK.Enabled:=true;
    end;
    if frm_Examine_Verify.ComboBox1.ItemIndex=3 then
    begin
        frm_Examine_Verify.Edit1.Visible:=True;  frm_Examine_Verify.Edit2.Visible:=True;  frm_Examine_Verify.Edit3.Visible:=True;  frm_Examine_Verify.Edit4.Visible:=False;  frm_Examine_Verify.Edit5.Visible:=False;
        frm_Examine_Verify.Edit11.Visible:=True; frm_Examine_Verify.Edit22.Visible:=True; frm_Examine_Verify.Edit33.Visible:=True; frm_Examine_Verify.Edit44.Visible:=False; frm_Examine_Verify.Edit55.Visible:=False;
        frm_Examine_Verify.SPB1.Visible:=True;   frm_Examine_Verify.SPB2.Visible:=True;   frm_Examine_Verify.SPB3.Visible:=True;   frm_Examine_Verify.SPB4.Visible:=False;   frm_Examine_Verify.SPB5.Visible:=False;
        frm_Examine_Verify.Edit1.Clear;          frm_Examine_Verify.Edit2.Clear;          frm_Examine_Verify.Edit3.Clear;          frm_Examine_Verify.Edit4.Clear;           frm_Examine_Verify.Edit5.Clear;
        frm_Examine_Verify.Edit11.Clear;         frm_Examine_Verify.Edit22.Clear;         frm_Examine_Verify.Edit33.Clear;         frm_Examine_Verify.Edit44.Clear;          frm_Examine_Verify.Edit55.Clear;
        frm_Examine_Verify.Cmd_OK.Enabled:=true;
    end;
    if frm_Examine_Verify.ComboBox1.ItemIndex=4 then
    begin
        frm_Examine_Verify.Edit1.Visible:=True;  frm_Examine_Verify.Edit2.Visible:=True;  frm_Examine_Verify.Edit3.Visible:=True;  frm_Examine_Verify.Edit4.Visible:=True;  frm_Examine_Verify.Edit5.Visible:=False;
        frm_Examine_Verify.Edit11.Visible:=True; frm_Examine_Verify.Edit22.Visible:=True; frm_Examine_Verify.Edit33.Visible:=True; frm_Examine_Verify.Edit44.Visible:=True; frm_Examine_Verify.Edit55.Visible:=False;
        frm_Examine_Verify.SPB1.Visible:=True;   frm_Examine_Verify.SPB2.Visible:=True;   frm_Examine_Verify.SPB3.Visible:=True;   frm_Examine_Verify.SPB4.Visible:=True;   frm_Examine_Verify.SPB5.Visible:=False;
        frm_Examine_Verify.Edit1.Clear;          frm_Examine_Verify.Edit2.Clear;          frm_Examine_Verify.Edit3.Clear;          frm_Examine_Verify.Edit4.Clear;         frm_Examine_Verify.Edit5.Clear;
        frm_Examine_Verify.Edit11.Clear;         frm_Examine_Verify.Edit22.Clear;         frm_Examine_Verify.Edit33.Clear;         frm_Examine_Verify.Edit44.Clear;        frm_Examine_Verify.Edit55.Clear;
        frm_Examine_Verify.Cmd_OK.Enabled:=true;
    end;
    if frm_Examine_Verify.ComboBox1.ItemIndex=5 then
    begin
        frm_Examine_Verify.Edit1.Visible:=True;  frm_Examine_Verify.Edit2.Visible:=True;  frm_Examine_Verify.Edit3.Visible:=True;  frm_Examine_Verify.Edit4.Visible:=True;  frm_Examine_Verify.Edit5.Visible:=True;
        frm_Examine_Verify.Edit11.Visible:=True; frm_Examine_Verify.Edit22.Visible:=True; frm_Examine_Verify.Edit33.Visible:=True; frm_Examine_Verify.Edit44.Visible:=True; frm_Examine_Verify.Edit55.Visible:=True;
        frm_Examine_Verify.SPB1.Visible:=True;   frm_Examine_Verify.SPB2.Visible:=True;   frm_Examine_Verify.SPB3.Visible:=True;   frm_Examine_Verify.SPB4.Visible:=True;   frm_Examine_Verify.SPB5.Visible:=True;
        frm_Examine_Verify.Edit1.Clear;          frm_Examine_Verify.Edit2.Clear;          frm_Examine_Verify.Edit3.Clear;          frm_Examine_Verify.Edit4.Clear;          frm_Examine_Verify.Edit5.Clear;
        frm_Examine_Verify.Edit11.Clear;         frm_Examine_Verify.Edit22.Clear;         frm_Examine_Verify.Edit33.Clear;         frm_Examine_Verify.Edit44.Clear;         frm_Examine_Verify.Edit55.Clear;
        frm_Examine_Verify.Cmd_OK.Enabled:=true;
    end;
end;
//�Զ��庯�������������Ϣ��׼ȷ��
function CheckData:boolean;
begin
    if frm_Examine_Verify.ComboBox1.ItemIndex=1 then
    begin
        if Trim(frm_Examine_Verify.Edit1.Text)='' then
        begin
            frm_Examine_Verify.Edit1.SetFocus;
            Application.MessageBox('����ʧ��,�ۼ�������һ�ݲ���Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
            frm_Examine_Verify.Edit1.SetFocus;
            Exit;
        end;
        if Trim(frm_Examine_Verify.Edit11.Text)='' then
        begin
            frm_Examine_Verify.Edit1.SetFocus;
            Application.MessageBox('����ʧ��,�ۼ�������һ�������Ա�ݲ���Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
            Exit;
        end;
    end;
    if frm_Examine_Verify.ComboBox1.ItemIndex=2 then
    begin
        if ((Trim(frm_Examine_Verify.Edit1.Text)='') or (Trim(frm_Examine_Verify.Edit2.Text)='')) then
        begin
            frm_Examine_Verify.Edit1.SetFocus;
            Application.MessageBox('����ʧ��,�ۼ�������һ�ݻ�ۼ������ƶ��ݲ���Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
            Exit;
        end;
        if ((Trim(frm_Examine_Verify.Edit11.Text)='') or(Trim(frm_Examine_Verify.Edit22.Text)='')) then
        begin
            frm_Examine_Verify.Edit1.SetFocus;
            Application.MessageBox('����ʧ��,�ۼ�������һ�������Ա�ݻ�ۼ������ƶ��������Ա�ݲ���Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
            Exit;
        end;
    end;
    if frm_Examine_Verify.ComboBox1.ItemIndex=3 then
    begin
        if ((Trim(frm_Examine_Verify.Edit1.Text)='') or (Trim(frm_Examine_Verify.Edit2.Text)='') or (Trim(frm_Examine_Verify.Edit3.Text)='')) then
        begin
            frm_Examine_Verify.Edit1.SetFocus;
            Application.MessageBox('����ʧ��,�ۼ�������һ�ݻ�ۼ������ƶ��ݻ�ۼ����������ݲ���Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
            Exit;
        end;
        if ((Trim(frm_Examine_Verify.Edit11.Text)='') or(Trim(frm_Examine_Verify.Edit22.Text)='') or(Trim(frm_Examine_Verify.Edit33.Text)='')) then
        begin
            frm_Examine_Verify.Edit1.SetFocus;
            Application.MessageBox('����ʧ��,�ۼ�������һ�������Ա�ݻ�ۼ������ƶ��������Ա�ݻ�ۼ����������������Ա�ݲ���Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
            Exit;
        end;
    end;
    if frm_Examine_Verify.ComboBox1.ItemIndex=4 then
    begin
        if ((Trim(frm_Examine_Verify.Edit1.Text)='') or (Trim(frm_Examine_Verify.Edit2.Text)='') or (Trim(frm_Examine_Verify.Edit3.Text)='') or (Trim(frm_Examine_Verify.Edit4.Text)='')) then
        begin
            frm_Examine_Verify.Edit1.SetFocus;
            Application.MessageBox('����ʧ��,�ۼ�������һ�ݻ�ۼ������ƶ��ݻ�ۼ����������ݻ�ۼ��������ģݲ���Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
            Exit;
        end;
        if ((Trim(frm_Examine_Verify.Edit11.Text)='') or(Trim(frm_Examine_Verify.Edit22.Text)='') or(Trim(frm_Examine_Verify.Edit33.Text)='') or(Trim(frm_Examine_Verify.Edit44.Text)='')) then
        begin
            frm_Examine_Verify.Edit1.SetFocus;
            Application.MessageBox('����ʧ��,�ۼ�������һ�������Ա�ݻ�ۼ������ƶ��������Ա�ݻ�ۼ����������������Ա�ݻ�ۼ��������ĵ������Ա�ݲ���Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
            Exit;
        end;
    end;
    if frm_Examine_Verify.ComboBox1.ItemIndex=5 then
    begin
        if ((Trim(frm_Examine_Verify.Edit1.Text)='') or (Trim(frm_Examine_Verify.Edit2.Text)='') or (Trim(frm_Examine_Verify.Edit3.Text)='') or (Trim(frm_Examine_Verify.Edit4.Text)='')or (Trim(frm_Examine_Verify.Edit5.Text)='')) then
        begin
            frm_Examine_Verify.Edit1.SetFocus;
            Application.MessageBox('����ʧ��,�ۼ�������һ�ݻ�ۼ������ƶ��ݻ�ۼ����������ݻ�ۼ��������ģݻ�ۼ���������ݲ���Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
            Exit;
        end;
        if ((Trim(frm_Examine_Verify.Edit11.Text)='') or(Trim(frm_Examine_Verify.Edit22.Text)='') or(Trim(frm_Examine_Verify.Edit33.Text)='') or(Trim(frm_Examine_Verify.Edit44.Text)='')) then
        begin
            frm_Examine_Verify.Edit1.SetFocus;
            Application.MessageBox('����ʧ��,�ۼ�������һ�������Ա�ݻ�ۼ������ƶ��������Ա�ݻ�ۼ����������������Ա�ݻ�ۼ��������ĵ������Ա�ݻ�ۼ���������������Ա�ݲ���Ϊ�գ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
            Exit;
        end;
    end;
    if ((Trim(frm_Examine_Verify.Edit1.Text)=Trim(frm_Examine_Verify.Edit2.Text)) or (Trim(frm_Examine_Verify.Edit1.Text)=Trim(frm_Examine_Verify.Edit3.Text)) or (Trim(frm_Examine_Verify.Edit1.Text)=Trim(frm_Examine_Verify.Edit4.Text))or (Trim(frm_Examine_Verify.Edit1.Text)=Trim(frm_Examine_Verify.Edit5.Text))) then
    begin
        Application.MessageBox('����ʧ��,�ۼ�������һ�ݺͣۼ������ƶ��ݲ�����ͬ����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
        Exit;
    end;
end;

procedure Tfrm_Examine_Verify.ListBox1Click(Sender: TObject);
var
    i:integer;
    tempstr:string;
    sql:widestring;
begin
    if listbox1.Count>0 then
    begin
        ComboBox1.Enabled:=True;
        for i:=Listbox1.Items.Count-1 downto 0 do
        begin
            if Listbox1.Selected[i] then
            begin
                ComboBox1.ItemIndex:=0; //�Ȱ���Ͽ��ֵ��Ϊ1
                ComboBox_Index;
                Edit_Visbale;
                Cmd_OK.Enabled:=False;
                tempstr:=Listbox1.Items.Strings[i]; //ѡ��ĵ�������
                TabSheet1.Caption:='��'+tempstr+'��';
                LabeledEdit1.Text:=tempstr; //ѡ��ĵ�������

                with frm_data.ClientDataSet_Add do
                begin
                    {Close;
                    CommandText:='';
                    CommandText:='Select * from [Level_Set] where Receipt_Name='''+Trim(LabeledEdit1.Text)+'''';
                    Open;}
                    sql:='Select * from [Level_Set] where Receipt_Name='+''''+Trim(LabeledEdit1.Text)+'''';
                    dmmain.CDSquery.Close;
                    dmmain.CDSquery.Data:=null;
                    dmmain.CDSquery.Data:=adisp.GetRecord(sql);
                    dmmain.CDSquery.Open;
                    //���ѡ��ĵ����Ѿ����ڡ������ж��������
                    if (dmmain.CDSquery.RecordCount)>0 then
                    begin
                       { if Application.MessageBox('�õ��ݵ���˼��������Ѿ����ڣ�ȷ����Ҫ����������'+#13#10+'�������ú�ԭ�������ý�������ɾ������ȷ�ϣ�',pchar(application.Title),mb_okcancel)=idok then
                        begin
                            Combobox1.Enabled:=True;
                            try
                              dmmain.CDSquery.Delete;
                              dmmain.CDSquery.ApplyUpdates(-1);
                            except
                                Application.MessageBox('����ʧ��,��������������������Ƿ�ɹ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                                Exit;
                            end;
                        end }
                       // else
                       // begin
                            Combobox1.Enabled:=True;
                            Cmd_Edit.Enabled:=True;
                            Cmd_Delete.Enabled:=True;
                            ComboBox1.ItemIndex:=dmmain.CDSquery.FieldValues['Level_Count'];
                            ComboBox_Index;

                            Edit1.Text:=dmmain.CDSquery.FieldValues['Level_Name1'];
                            Edit11.Text:=dmmain.CDSquery.FieldValues['Examine_Man1'];

                            Edit2.Text:=dmmain.CDSquery.FieldValues['Level_Name2'];
                            Edit22.Text:=dmmain.CDSquery.FieldValues['Examine_Man2'];

                            Edit3.Text:=dmmain.CDSquery.FieldValues['Level_Name3'];
                            Edit33.Text:=dmmain.CDSquery.FieldValues['Examine_Man3'];

                            Edit4.Text:=dmmain.CDSquery.FieldValues['Level_Name4'];
                            Edit44.Text:=dmmain.CDSquery.FieldValues['Examine_Man4'];

                            Edit5.Text:=dmmain.CDSquery.FieldValues['Level_Name5'];
                            Edit55.Text:=dmmain.CDSquery.FieldValues['Examine_Man5'];
                        //end;
                    end
                    else
                    begin
                        Cmd_Edit.Enabled:=False;
                        Cmd_Delete.Enabled:=False;
                    end;
                    if (dmmain.CDSquery.RecordCount)=0 then
                    begin
                        Edit1.Visible:=False; Edit2.Visible:=False;Edit3.Visible:=False;
                        Edit4.Visible:=False; Edit5.Visible:=False;
                        Edit11.Visible:=False; Edit22.Visible:=False;Edit33.Visible:=False;
                        Edit44.Visible:=False; Edit55.Visible:=False;
                        Edit1.Visible:=False; Edit1.Visible:=False;Edit1.Visible:=False;
                        Edit1.Text:='';Edit2.Text:='';Edit3.Text:='';Edit4.Text:='';Edit5.Text:='';
                        Edit11.Text:='';Edit22.Text:='';Edit33.Text:='';Edit44.Text:='';Edit55.Text:='';
                    end;
                end;
            end;
        end;
    end
    else
    begin
        Exit;
    end;
end;

procedure Tfrm_Examine_Verify.ComboBox1Change(Sender: TObject);
begin
    ComboBox_Index;
end;

procedure Tfrm_Examine_Verify.Cmd_OKClick(Sender: TObject);
begin

    try
    CheckData;
    if dmmain.CDSquery.IsEmpty  then
    begin
      dmmain.CDSquery.Insert;
      dmmain.CDSquery.FieldByName('receipt_name').AsString:=Trim(LabeledEdit1.Text);
      dmmain.CDSquery.FieldByName('Level_Count').AsString:=Trim(ComboBox1.Text);
      dmmain.CDSquery.FieldByName('Level_Name1').AsString:=Trim(Edit1.Text);
      dmmain.CDSquery.FieldByName('Examine_Man1').AsString:=Trim(Edit11.Text);
      dmmain.CDSquery.FieldByName('Level_Name2').AsString:=Trim(Edit2.Text);
      dmmain.CDSquery.FieldByName('Examine_Man2').AsString:=Trim(Edit22.Text);
      dmmain.CDSquery.FieldByName('Level_Name3').AsString:=Trim(Edit3.Text);
      dmmain.CDSquery.FieldByName('Examine_Man3').AsString:=Trim(Edit33.Text);
      dmmain.CDSquery.FieldByName('Level_Name4').AsString:=Trim(Edit4.Text);
      dmmain.CDSquery.FieldByName('Examine_Man4').AsString:=Trim(Edit44.Text);
      dmmain.CDSquery.FieldByName('Level_Name5').AsString:=Trim(Edit5.Text);
      dmmain.CDSquery.FieldByName('Examine_Man5').AsString:=Trim(Edit55.Text);
      dmmain.CDSquery.Post;
    end else
    begin
      exit;
    end;
    dmmain.CDSquery.ApplyUpdates(-1);
      Application.MessageBox('�õ��ݵĸü�����ˣ����ò����ɹ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
    except
        Application.MessageBox('����ʧ��,��������������������Ƿ�ɹ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
        Exit;
    end;
end;

procedure Tfrm_Examine_Verify.SPB1Click(Sender: TObject);
begin
    frm_Man_Check:=Tfrm_Man_Check.Create(self);
    man_Select:='';
    Man_Public_Code:='';
    Man_Public_Code:='SH_01';
    LevelName1:='';
    LevelName1:=Trim(Edit1.Text);
    frm_Man_Check.Sno:=trim(edit11.Text);
    frm_Man_Check.ShowModal;
    frm_Man_Check.Free;
end;

procedure Tfrm_Examine_Verify.SPB2Click(Sender: TObject);
begin
    frm_Man_Check:=Tfrm_Man_Check.Create(self);
    man_Select:='';
    Man_Public_Code:='';
    Man_Public_Code:='SH_02';
    frm_Man_Check.Sno:=trim(edit22.Text);
    frm_Man_Check.ShowModal;
    frm_Man_Check.Free;
end;

procedure Tfrm_Examine_Verify.SPB3Click(Sender: TObject);
begin
    frm_Man_Check:=Tfrm_Man_Check.Create(self);
    man_Select:='';
    Man_Public_Code:='';
    Man_Public_Code:='SH_03';
    frm_Man_Check.Sno:=trim(edit33.Text);
    frm_Man_Check.ShowModal;
    frm_Man_Check.Free;
end;

procedure Tfrm_Examine_Verify.SPB4Click(Sender: TObject);
begin
    frm_Man_Check:=Tfrm_Man_Check.Create(self);
    man_Select:='';
    Man_Public_Code:='';
    Man_Public_Code:='SH_04';
    frm_Man_Check.Sno:=trim(edit44.Text);
    frm_Man_Check.ShowModal;
    frm_Man_Check.Free;
end;

procedure Tfrm_Examine_Verify.SPB5Click(Sender: TObject);
begin
    frm_Man_Check:=Tfrm_Man_Check.Create(self);
    man_Select:='';
    Man_Public_Code:='';
    Man_Public_Code:='SH_05';
    frm_Man_Check.Sno:=trim(edit55.Text);
    frm_Man_Check.ShowModal;
    frm_Man_Check.Free;
end;

procedure Tfrm_Examine_Verify.SpeedButton2Click(Sender: TObject);
begin
    if Edit11.Visible=true then
    begin
        if Trim(Edit11.Text)='' then
        begin
            //Application.MessageBox('����ʧ�ܣ���Ϊ��'+Edit11.EditLabel.Caption+'��'+#13#10+'ѡ�������Ա����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
            ShowMessage('����ʧ�ܣ���Ϊ��'+Edit11.EditLabel.Caption+'��'+#13#10+'ѡ�������Ա����ȷ�ϣ�');
            Exit;
        end;
    end;
    if Edit22.Visible=true then
    begin
        if Trim(Edit11.Text)='' then
        begin
            //Application.MessageBox('����ʧ��,����ѡ�������Ա����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
            ShowMessage('����ʧ�ܣ���Ϊ��'+Edit22.EditLabel.Caption+'��'+#13#10+'ѡ�������Ա����ȷ�ϣ�');
            Exit;
        end;
    end;
    if Edit33.Visible=true then
    begin
        if Trim(Edit11.Text)='' then
        begin
            //Application.MessageBox('����ʧ��,����ѡ�������Ա����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
            ShowMessage('����ʧ�ܣ���Ϊ��'+Edit33.EditLabel.Caption+'��'+#13#10+'ѡ�������Ա����ȷ�ϣ�');
            Exit;
        end;
    end;
    if Edit44.Visible=true then
    begin
        if Trim(Edit11.Text)='' then
        begin
            //Application.MessageBox('����ʧ��,����ѡ�������Ա����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
            ShowMessage('����ʧ�ܣ���Ϊ��'+Edit44.EditLabel.Caption+'��'+#13#10+'ѡ�������Ա����ȷ�ϣ�');
            Exit;
        end;
    end;
    if Edit55.Visible=true then
    begin
        if Trim(Edit11.Text)='' then
        begin
            //Application.MessageBox('����ʧ��,����ѡ�������Ա����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
            ShowMessage('����ʧ�ܣ���Ϊ��'+Edit55.EditLabel.Caption+'��'+#13#10+'ѡ�������Ա����ȷ�ϣ�');
            Exit;
        end;
    end;

    dmmain.CDSquery.Active:=False;
    dmmain.CDSquery.Close;
    Close;
end;

procedure Tfrm_Examine_Verify.Cmd_EditClick(Sender: TObject);
begin
    if Application.MessageBox('ע�⣺�޸ĸõ��ݵ���˼������ã�'+#13#10+'ֻ���޸ļ������ƺͼ�����������Ӧ�������Ա��ѡ��'+#13#10+'ȷ����Ҫ�޸ĸõ��������������ȷ�ϣ�',pchar(application.Title),mb_okcancel)=idok then
    begin
      try
        if not dmmain.CDSquery.IsEmpty  then
        begin
          dmmain.CDSquery.edit;
          dmmain.CDSquery.FieldByName('receipt_name').AsString:=Trim(LabeledEdit1.Text);
          dmmain.CDSquery.FieldByName('Level_Count').AsString:=Trim(ComboBox1.Text);
          dmmain.CDSquery.FieldByName('Level_Name1').AsString:=Trim(Edit1.Text);
          dmmain.CDSquery.FieldByName('Examine_Man1').AsString:=Trim(Edit11.Text);
          dmmain.CDSquery.FieldByName('Level_Name2').AsString:=Trim(Edit2.Text);
          dmmain.CDSquery.FieldByName('Examine_Man2').AsString:=Trim(Edit22.Text);
          dmmain.CDSquery.FieldByName('Level_Name3').AsString:=Trim(Edit3.Text);
          dmmain.CDSquery.FieldByName('Examine_Man3').AsString:=Trim(Edit33.Text);
          dmmain.CDSquery.FieldByName('Level_Name4').AsString:=Trim(Edit4.Text);
          dmmain.CDSquery.FieldByName('Examine_Man4').AsString:=Trim(Edit44.Text);
          dmmain.CDSquery.FieldByName('Level_Name5').AsString:=Trim(Edit5.Text);
          dmmain.CDSquery.FieldByName('Examine_Man5').AsString:=Trim(Edit55.Text);
          dmmain.CDSquery.Post;
        end else
        begin
          exit;
        end;
        dmmain.CDSquery.ApplyUpdates(-1);
      except
          Application.MessageBox('����ʧ��,��������������������Ƿ�ɹ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
          Exit;
      end;
    end;
end;

procedure Tfrm_Examine_Verify.Cmd_DeleteClick(Sender: TObject);
begin
    if Application.MessageBox('ȷ����Ҫɾ���õ��ݵ���˼���������'+#13#10+'��ȷ�ϣ�',pchar(application.Title),mb_okcancel)=idok then
    begin
      try
        dmmain.CDSquery.Delete;
        dmmain.CDSquery.ApplyUpdates(-1);
        Application.MessageBox('���ݵģ���˼������ã�ɾ�������ɹ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
        ComboBox1.ItemIndex:=0;
        ComBoBox_index;;
      except
          Application.MessageBox('����ʧ��,��������������������Ƿ�ɹ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
          Exit;
      end;
    end;
end;

procedure Tfrm_Examine_Verify.Cmd_NoClick(Sender: TObject);
begin
    Close;
end;

procedure Tfrm_Examine_Verify.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    Action:=cafree;
end;

end.
