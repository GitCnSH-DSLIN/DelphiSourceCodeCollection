unit ufrmDevReplaceDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, dxmdaset, Mask, DBCtrlsEh,
  ufrmDeviceManage;

type
  TfrmDevReplaceDlg = class(TForm)
    Panel11: TPanel;
    bbtnConfirm: TBitBtn;
    bbtnCancel: TBitBtn;
    memSrc: TdxMemData;
    memSrcid: TStringField;
    memSrcname: TStringField;
    memDest: TdxMemData;
    StringField1: TStringField;
    StringField2: TStringField;
    memSrcd: TDataSource;
    memDestd: TDataSource;
    bbtnClose: TBitBtn;
    StaticText1: TStaticText;
    rdgSelected: TRadioGroup;
    eSrc: TDBEditEh;
    eDest: TDBEditEh;
    memSrccustom_id: TStringField;
    memSrcdev_code_id: TStringField;
    memSrcdev_code_name: TStringField;
    memSrcdev_type: TStringField;
    memSrcmanu_no: TStringField;
    memDestcustom_id: TStringField;
    memDestdev_code_id: TStringField;
    memDestdev_code_name: TStringField;
    memDestdev_type: TStringField;
    memDestmanu_no: TStringField;
    memSrcdesc: TStringField;
    memDestdesc: TStringField;
    memSrcuser_name: TStringField;
    memDestuser_name: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bbtnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbtnCloseClick(Sender: TObject);
    procedure bbtnConfirmClick(Sender: TObject);
    procedure memCalcFields(DataSet: TDataSet);
    procedure memSrcAfterPost(DataSet: TDataSet);
    procedure memDestAfterPost(DataSet: TDataSet);
  private
    Fc_Requestor: TfrmDeviceManage;
    procedure prip_SetHint(Ac_Target: TDBEditEh; Ac_DataSet: TDataSet);
    procedure prip_Confirm;
    procedure prip_Cancel;
  public
    procedure pubp_Ini(Ac_Requestor: TfrmDeviceManage);
  end;

var
  frmDevReplaceDlg: TfrmDevReplaceDlg;

implementation

uses
  udmData, CommonLib;

{$R *.dfm}

procedure TfrmDevReplaceDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  frmDevReplaceDlg := nil;
end;

procedure TfrmDevReplaceDlg.bbtnCancelClick(Sender: TObject);
begin
  prip_Cancel;
end;

procedure TfrmDevReplaceDlg.pubp_Ini(Ac_Requestor: TfrmDeviceManage);
begin
  Fc_Requestor := Ac_Requestor;
  Show;
end;

procedure TfrmDevReplaceDlg.FormCreate(Sender: TObject);
begin
  Fc_Requestor := nil;
end;

procedure TfrmDevReplaceDlg.bbtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDevReplaceDlg.prip_Cancel;
begin
  with memSrc do
  begin
    Close;
    Open;
  end;
  with memDest do
  begin
    Close;
    Open;
  end;
  eSrc.Hint := '';
  eDest.Hint := '';
  rdgSelected.ItemIndex := 0;
end;

procedure TfrmDevReplaceDlg.prip_Confirm;
var
  ls_SrcId, ls_DestId, ls_SrcDevCodeId, ls_DestDevCodeId: string;
begin
  ls_SrcId := VarToStr(memSrc.FieldValues['id']);
  ls_DestId := VarToStr(memDest.FieldValues['id']);

  if ls_SrcId = '' then
  begin
    MessageBox(Self.Handle, '��ѡ�񽫱��滻���豸', PChar(Caption),
      MB_OK + MB_ICONWARNING);
    Exit;
  end;

  if ls_DestId = '' then
  begin
    MessageBox(Self.Handle, '��ѡ���滻���ĸ��豸', PChar(Caption),
      MB_OK + MB_ICONWARNING);
    Exit;
  end;

  ls_SrcDevCodeId := Copy(memSrc.FieldByName('dev_code_id').AsString, 1, 1);
  ls_DestDevCodeId := Copy(memDest.FieldByName('dev_code_id').AsString, 1, 1);
  if ls_SrcDevCodeId <> ls_DestDevCodeId then
  begin
    MessageBox(Self.Handle, '��̨�豸����ͬһ������ģ������滻��',
      PChar(Caption), MB_OK + MB_ICONWARNING);
    Exit;
  end;

  if MessageBox(Self.Handle, '��ȷ��Ҫ�滻��?', PChar(Caption),
    MB_OKCANCEL + MB_ICONQUESTION + MB_DEFBUTTON2) = IDCANCEL then Exit;
    
  Gp_ProgressHint('�����滻�豸�����Ժ�...');
  dmData.adocon.BeginTrans;
  try
    dmData.adocon.Execute(Format('device.usp_replacedeviceinfo ''%s'', ''%s''',
      [ls_SrcId, ls_DestId]));

    dmData.adocon.Execute(Format('device.usp_deletedeviceinfo ''%s'', ''%s''',
      [ls_SrcId, ls_SrcDevCodeId]));

    dmData.adocon.CommitTrans;
    Gp_ProgressHint;
    Close;
    PostMessage(Fc_Requestor.Handle, CM_REFRESHDEVICEINFO, 0, 0);
  except
    on E: Exception do
    begin
      with Fc_Requestor.BaseInfo do if State <> dsBrowse then Cancel;
      dmData.adocon.RollbackTrans;
      Gp_ProgressHint;
      MessageBox(Self.Handle, PChar('�ϲ��豸ʱ����������Ϣ��' +
        E.Message), PChar(Caption), MB_OK + MB_ICONERROR);
    end;
  end;
end;

procedure TfrmDevReplaceDlg.bbtnConfirmClick(Sender: TObject);
begin
  prip_Confirm;
end;

procedure TfrmDevReplaceDlg.memCalcFields(DataSet: TDataSet);
begin
  with DataSet do
    FieldByName('desc').AsString := 'ע����룺' +
      VarToStr(FieldValues['reg_id']) + ' ��ˮ��ţ�' +
      VarToStr(FieldValues['custom_id']);
end;

procedure TfrmDevReplaceDlg.prip_SetHint(Ac_Target: TDBEditEh;
  Ac_DataSet: TDataSet);
var
  ls_Hint: string;
begin
  with Ac_DataSet do
    ls_Hint := 'ע����룺' + VarToStr(FieldValues['reg_id']) + #13#10 +
      '��ˮ��ţ�' + VarToStr(FieldValues['custom_id']) + #13#10 +
      '�豸���' + VarToStr(FieldValues['dev_code_name']) + #13#10 +
      'ʹ�õ�λ��' + VarToStr(FieldValues['user_name']) + #13#10 +
      '�豸�ͺţ�' + VarToStr(FieldValues['dev_type']) + #13#10 +
      '������ţ�' + VarToStr(FieldValues['manu_no']);
  Ac_Target.Hint := ls_Hint;
end;

procedure TfrmDevReplaceDlg.memSrcAfterPost(DataSet: TDataSet);
begin
  prip_SetHint(eSrc, DataSet);
end;

procedure TfrmDevReplaceDlg.memDestAfterPost(DataSet: TDataSet);
begin
  prip_SetHint(eDest, DataSet);
end;

initialization
frmDevReplaceDlg := nil;

end.
