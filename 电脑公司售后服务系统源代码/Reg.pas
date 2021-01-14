unit Reg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, TFlatTitlebarUnit, ExtCtrls, TFlatPanelUnit,
  StdCtrls, TFlatEditUnit, DB, ADODB,shellapi;

type
  TFrmRegistry = class(TForm)
    RegistryTitlal: TFlatTitlebar;
    BtnExit: TFlatButton;
    Panel1: TFlatPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Shape1: TShape;
    Label4: TLabel;
    Label6: TLabel;
    EditName: TFlatEdit;
    EditRegCode: TFlatEdit;
    BtnReg: TFlatButton;
    BtnSendMail: TFlatButton;
    Label7: TLabel;
    Label8: TLabel;
    BtnDelRegInfo: TFlatButton;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    procedure BtnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditNameChange(Sender: TObject);
    procedure BtnRegClick(Sender: TObject);
    procedure BtnDelRegInfoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSendMailClick(Sender: TObject);
  private
    { Private declarations }
    procedure DBConnection;
    Procedure WriteRegCode;
    procedure ClearRegCode;
    procedure CheckRegCode;
  public
    { Public declarations }
  end;

var
  FrmRegistry: TFrmRegistry;

implementation

uses jm, Main,global;

{$R *.dfm}

procedure TFrmRegistry.BtnExitClick(Sender: TObject);
begin
close;
end;

procedure TFrmRegistry.FormCreate(Sender: TObject);
begin
EditName.Clear;  EditRegCode.Clear;
CheckRegCode;
end;

procedure TFrmRegistry.EditNameChange(Sender: TObject);
begin
if length(trim(editname.Text))<8 then BtnReg.Enabled :=False else Btnreg.Enabled :=True;
end;

procedure TFrmRegistry.BtnRegClick(Sender: TObject);
const
  my_key = 5741;
var
  RegCode:ansistring;
begin
  RegCode:=Encrypt(EditName.Text,my_key);
  if EditRegCode.Text = RegCode then
     begin
       WriteRegCode;  //ע��ɹ�����ע����д�����ݿ�;
       if MessageBox(Handle, PChar('��ɹ���ע���˱��������Ҫ�������������򷽿�����ʹ�á�������������'), PChar('ע��ɹ�'),MB_YESNO+MB_ICONEXCLAMATION)=IDyes then
          begin
          FrmRegistry.Close;
          frmMain.Close ;
          end;
     end
     else
       MessageBox(Handle, PChar('ע�������'), PChar('ע��ʧ��'),MB_OK+MB_ICONERROR);
end;

procedure TFrmRegistry.DBConnection;
var
  DataPath:string;
begin
  if ADOConnection1.Connected then ADOConnection1.Close;
  //��ֹ���ظ��򿪶������������Ӵ���
  DataPath:=ExtractFilePath(Application.ExeName)+'Data\mgr.db';
  {��¼���ܵ����ݿ�}
  ADOConnection1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+DataPath+';
  ADOConnection1.Open();
end;

procedure TFrmRegistry.WriteRegCode;
begin
DBConnection;
ADOQuery1.Close;
ADOQuery1.SQL.Clear;
ADOQuery1.SQL.Text :='select * from reg';
ADOQuery1.Open;
ADOQuery1.Edit;
ADOQuery1.FieldByName('IncName').AsString :=EditName.Text;
ADOQuery1.FieldByName('RegCode').AsString :=EditRegCode.Text;
ADOQuery1.Post;
ADOQuery1.Close;
end;

procedure TFrmRegistry.ClearRegCode;
begin
DBConnection;
ADOQuery1.Close;
ADOQuery1.SQL.Clear;
ADOQuery1.SQL.Text :='delete from reg';
ADOQuery1.ExecSQL;
end;

procedure TFrmRegistry.BtnDelRegInfoClick(Sender: TObject);
begin
  ClearRegCode;
  showmessage('ע����Ϣ�����ɹ�ɾ��');
  Checkreg:=0;   //����ɾ����ע����Ϣ; ����ֵ��Ϊ 0 ��ʾδע��״̬
  CheckRegCode;
end;

procedure TFrmRegistry.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
ADOQuery1.Close;
ADOConnection1.Close;
end;

procedure TFrmRegistry.CheckRegCode;
begin
if Checkreg=0 then
  begin
    EditName.Text:='������Ҫע��Ĺ�˾����';
    EditRegCode.Text :='δע��汾';
    BtnReg.Enabled :=True;
    BtnDelRegInfo.Enabled :=False;
    EditName.Enabled :=True;  EditRegCode.Enabled :=True;
  end
  else begin
         EditName.Text :=TempInc;
         EditRegCode.Text :=TempRegCode;
         BtnReg.Enabled :=False;
         BtnDelRegInfo.Enabled :=True;
         EditName.Enabled :=False;  EditRegCode.Enabled :=False;
       end;

ADOQuery1.Close;
end;

procedure TFrmRegistry.BtnSendMailClick(Sender: TObject);
begin
shellExecute(GetDesktopWindow,'Open',PChar('mailto:luozs168@163.net?subject='+ '��Ҫע�᡾���Թ�˾�ͻ�����ϵͳ��'),
              nil,
              nil,
              SW_ShowNormal);
end;

end.
