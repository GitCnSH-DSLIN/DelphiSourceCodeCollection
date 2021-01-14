unit uWarehouseSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons, Grids, DBGrids, DB, ADODB,
  Mask, DBCtrls;

type
  TfrmWarehouseSetting = class(TForm)
    Label1: TLabel;
    btnCancel: TSpeedButton;
    DataSourceCKDYB: TDataSource;
    btnAppend: TSpeedButton;
    btnDelete: TSpeedButton;
    btnModify: TSpeedButton;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Label2: TLabel;
    dbeName: TDBEdit;
    Label3: TLabel;
    dbePostion: TDBEdit;
    Label4: TLabel;
    dbeAdmin: TDBEdit;
    Label5: TLabel;
    dbePhone: TDBEdit;
    Label6: TLabel;
    dbeMemo: TDBEdit;
    aqWarehouse: TADOQuery;
    procedure btnCancelClick(Sender: TObject);
    procedure btnAppendClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnModifyClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWarehouseSetting: TfrmWarehouseSetting;

implementation

uses uDB;

{$R *.dfm}

procedure TfrmWarehouseSetting.btnCancelClick(Sender: TObject);
begin
  close;
  aqWarehouse.Free;
end;

//�����µĲֿ���Ϣ
procedure TfrmWarehouseSetting.btnAppendClick(Sender: TObject);
var
  queryc: TADOQuery;
begin
  if btnAppend.Caption = '�� ��' then
  begin

    dbeName.SetFocus;
    aqWarehouse.Append;
    btnAppend.Caption := '�� ��';
    btnModify.Caption := 'ȡ ��';
    btnDelete.Visible := false;
  end
  else
  begin
    if dbeName.Text <> '' then
    begin
      queryc := TADOquery.Create(self);
      queryc.Connection:= dmWarehouse.ACWarehouse;
      queryc.SQL.Text := 'select * from CKDYB where WName="' + dbeName.Text + '"' ;
      queryc.open;
      if not queryc.Eof then
      begin
        MessageBox(handle, '�˲ֿ������Ѵ���!', '��ʾ', mb_IconInformation + mb_Ok);
        aqWarehouse.Cancel;
        exit;
      end
      else
      begin
        aqWarehouse.Post;
        btnAppend.Caption := '�� ��';
        btnModify.Caption := '�� ��';
        btnDelete.Visible := true;
      end;
    end
    else
    begin
      MessageBox(handle, '������ֿ���!', '��ʾ', mb_IconInformation + mb_Ok);
      dbeName.SetFocus;
      exit
    end;
  end;
end;

//ɾ����¼
procedure TfrmWarehouseSetting.btnDeleteClick(Sender: TObject);
begin
  if aqWarehouse.recordcount = 0 then
  begin
    application.MessageBox('���޼�¼��ɾ��', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
    exit;
  end;
  if application.MessageBox('��ȷ���Ƿ�Ҫɾ��', '�ֿ����ϵͳ', mb_iconinformation + mb_yesno) = idyes then
  begin
    aqWarehouse.Delete;
    aqWarehouse.Close;
    aqWarehouse.SQL.clear;
    aqWarehouse.sql.Text := 'select * from CKDYB';
    aqWarehouse.Open;
  end;
end;

//�༭�ֿ���Ϣ
procedure TfrmWarehouseSetting.btnModifyClick(Sender: TObject);
begin
 
  if btnModify.Caption ='�� ��' then
  begin
    aqWarehouse.Edit;
    aqWarehouse.Post;
    aqWarehouse.sql.Text := 'select * from CKDYB';
    aqWarehouse.Open;
  end
  else
  begin
    aqWarehouse.Cancel;
    btnAppend.Caption := '�� ��';
    btnModify.Caption := '�� ��';
    btnDelete.Visible := true;
  end;
end;

procedure TfrmWarehouseSetting.FormShow(Sender: TObject);
begin
  aqWarehouse.sql.Text := 'select * from CKDYB';
  aqWarehouse.Open;
end;

end.
