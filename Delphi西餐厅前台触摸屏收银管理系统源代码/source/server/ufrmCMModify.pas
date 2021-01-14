unit ufrmCMModify;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmModifyDataBase, ImgList, StdCtrls, Buttons, DB, ADODB,
  CSADOQuery, dxExEdtr, dxEdLib, dxDBELib, dxEditor, dxCntner,
  CSCustomdxDateEdit, CSdxDBDateEdit;

type
  TfrmCMModify = class(TfrmModifyDataBase)
    Viewq: TCSADOQuery;
    Viewd: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label11: TLabel;
    eCMId: TdxDBEdit;
    eCMName: TdxDBEdit;
    eCMTel: TdxDBEdit;
    Label16: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    eCMMail: TdxDBEdit;
    Label8: TLabel;
    Viewqcm_id: TStringField;
    Viewqcm_name: TStringField;
    Viewqcm_old: TIntegerField;
    Viewqcm_sex: TStringField;
    Viewqcm_address: TStringField;
    Viewqcm_tel: TStringField;
    Viewqcm_mail: TStringField;
    Viewqcm_onlyno: TStringField;
    Viewqcm_date: TStringField;
    Viewqcm_time: TStringField;
    Viewqlast_time: TDateTimeField;
    Viewqlogin_id: TStringField;
    Label5: TLabel;
    eCMOnlyNo: TdxDBEdit;
    Label9: TLabel;
    eCMDate: TCSdxDBDateEdit;
    Label6: TLabel;
    eCMOld: TdxDBSpinEdit;
    eCMSex: TdxDBPickEdit;
    eCMAddRess: TdxDBEdit;
    eCMTime: TdxDBEdit;
    Label7: TLabel;
    eBirthday: TCSdxDBDateEdit;
    Viewqcm_birthday: TStringField;
    procedure bbtnConfirmClick(Sender: TObject);
    procedure bbtnCancelClick(Sender: TObject);
  private
    function prif_CanSave: Boolean;
  protected
    procedure prop_IniData; override;
  public
    { Public declarations }
  end;

var
  frmCMModify: TfrmCMModify;

implementation
uses udmData, ufrmBase;
{$R *.dfm}

{ TfrmCMModify }

procedure TfrmCMModify.prop_IniData;
begin
  inherited;
  case Ri_Flag of
    2:
    begin
      with Viewq do
      begin
        if Active then Close;
        Connection := dmData.adocon;
        SQL.Text := Format('SELECT * FROM customerinfo WHERE cm_id = ''%s''',
          [Rs_Id]);
        Open;
        Caption := Format(Caption, ['[�޸�]']);
        Edit;
      end;
    end;  
    3:
    begin
      with Viewq do
      begin
        if Active then Close;
        Connection := dmData.adocon;
        SQL.Text := Format('SELECT * FROM customerinfo WHERE cm_id = ''%s''',
          [Rs_Id]);
        Open;  
        Caption := Format(Caption, ['[ɾ��]']);
      end;
    end;
    1:
    begin
      with Viewq do
      begin
        if Active then Close;
        Connection := dmData.adocon;
        SQL.Text := 'SELECT * FROM customerinfo WHERE 1 = 2';
        Open;    
        Caption := Format(Caption, ['[���]']);
        Append;
        FieldByName('cm_id').AsString := dmData.pubf_GetCustomerId;
        FieldByName('cm_date').AsString := FormatDateTime('YYYY-MM-DD', Date);
        FieldByName('cm_time').AsString := FormatDateTime('HH:MM:SS', Time);
      end;
    end;
  end;
end;

procedure TfrmCMModify.bbtnConfirmClick(Sender: TObject);
begin
  inherited;
  case Ri_Flag of
    1:
    begin
      if not prif_CanSave then Exit;
      Viewq.FieldByName('login_id').AsString := dmData.As_OptName;
      Viewq.Post;
      if DispInfo('��ӷ�����Ŀ��ɣ��Ƿ������ӣ�', 3) = 'y' then
      begin
        Viewq.Append;
        Viewq.FieldByName('cm_id').AsString := dmData.pubf_GetCustomerId;
      end else ModalResult := mrOk;
    end;
    2:
    begin
      if not prif_CanSave then Exit;   
      Viewq.FieldByName('login_id').AsString := dmData.As_OptName;
      Viewq.Post;
      DispInfo('������Ŀ�����޸����', 2);
      ModalResult := mrOk;
    end;
    3:
    begin
      if DispInfo('���Ƿ�Ҫȷ��ɾ����ǰ���ݣ�', 3) = 'y' then
      begin
        Viewq.Delete;
        ModalResult := mrOk;
      end;
    end;
  end;
end;

function TfrmCMModify.prif_CanSave: Boolean;
begin 
  Result := True;
end;

procedure TfrmCMModify.bbtnCancelClick(Sender: TObject);
begin
  Viewq.Cancel;
  inherited;
end;

end.
