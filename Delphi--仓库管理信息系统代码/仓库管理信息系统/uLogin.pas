unit uLogin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons,DB, DBTables,AdoDB;

type
  TfrmLogin = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    edtPassword: TEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    cmbUserName: TComboBox;
    btnOK: TSpeedButton;
    btnCancel: TSpeedButton;

    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses Main,uPublic,uDB;

{$R *.DFM}

//��ȷ�ϰ�ť������󣬼������߱����Ƿ���Ӧ�Ĳ�����Ա�Ϳ���
procedure TfrmLogin.btnOKClick(Sender: TObject);
var
    Query : TADOQuery;
begin
    //�����֤����Ŀ�����ȷ�����������������
    try
        //��������Ա�����Ƿ���ƥ���¼
        Query := TADOQuery.Create(nil);
        Query.Connection := dmWarehouse.ACWarehouse ;
        Query.SQL.Add('select * from Operator where UserName=:UserName and userpwd=:userpwd');

        Query.Parameters.ParamByName('UserName').Value := cmbUsername.Text ;
        Query.Parameters.ParamByName('userpwd').Value := edtpassword.Text ;

        Query.Open;
        if Query.RecordCount = 0 then
        begin
            MessageDlg('��������ȷ���û���������',mtError,[mbok],0);
            Exit;
        end;
        //���ݲ�ͬ�Ĳ���Ա����������в�ͬ�Ĺ��ܲ���
        if query.FieldByName('class').AsInteger =0 then
        begin
            //�����û�ӵ��ȫ��Ȩ��
            mainform.menuSRight.Enabled :=true;
            mainform.menuSWarehouse.Enabled := true;
            mainform.menuWSld.Enabled :=true;
            mainform.menuWBMLL.Enabled:=true;
            mainform.menuWBmda.Enabled:=true;
            mainform.menuWZGDA.Enabled:=true;
            mainform.menuWKCPD.Enabled:=true;
            mainform.menuWCLGL.Enabled:=true;
        end;

        if  query.FieldByName('class').AsInteger =1 then
        begin
             //����Ա�û�ӵ�г�"Ȩ�޹���"���ȫ��Ȩ��
            mainform.menuSRight.Enabled :=false;
            mainform.menuSWarehouse.Enabled := true;
            mainform.menuWSld.Enabled :=true;
            mainform.menuWBMLL.Enabled:=true;
            mainform.menuWBmda.Enabled:=true;
            mainform.menuWZGDA.Enabled:=true;
            mainform.menuWKCPD.Enabled:=true;
            mainform.menuWCLGL.Enabled:=true;
        end;
         
        edtpassword.Text :='';     //������ϢҪ���
        Query.Close;
        Query.Free;

        mainform.Show;
        frmLogin.close;
    except
        MessageDlg('�������ݿ����!',mtError,[mbok],0);
    end;
end;

procedure TfrmLogin.btnCancelClick(Sender: TObject);
begin
    ModalResult := mrCancel;
    frmLogin.Close ;
end;

//��½������ʾʱ������༭���ý���
procedure TfrmLogin.FormShow(Sender: TObject);
begin
    edtPassword.SetFocus ;
end;

//���崴��ʱ����ȡ�����߱��еĲ���������
procedure TfrmLogin.FormCreate(Sender: TObject);
var
    Query : TADOQuery;
begin
    cmbusername.Clear ;
    try
        Query := TADOQuery.Create(nil);
        Query.Connection := dmWarehouse.ACWarehouse ;
        Query.SQL.Add('select username from Operator ');
        Query.Open;
        if Query.RecordCount = 0 then
        begin
            MessageDlg('û�п��Ե�½���û���',mtError,[mbok],0);
            Exit;
        end else
        begin
            Query.First ;
            while Query.Eof =false do
            begin
                cmbUserName.items.add(query.FieldByName('Username').asstring );
                Query.next;
            end
        end;
        Query.Close;
        Query.Free;
        cmbusername.ItemIndex  :=0 ;
    except
        MessageDlg('�������ݿ����!',mtError,[mbok],0);
    end;
end;

procedure TfrmLogin.edtPasswordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = 13 then
        btnOKClick(Sender);
end;

end.
