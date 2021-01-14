unit ufrmSaleItemView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmViewDataBase, dxExEdtr, DB, ADODB, CSADOQuery, ActnList,
  ImgList, dxCntner, dxTL, dxDBCtrl, dxDBGrid, ComCtrls, ToolWin, dxEditor,
  dxEdLib, StdCtrls, ExtCtrls, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg,
  dxBkgnd, dxWrap, dxPrnDev, dxPSCore;

type
  TfrmSaleItemView = class(TfrmViewDataBase)
    ViewqI_ITEM_CD: TStringField;
    ViewqI_ITEM_NAME: TStringField;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    eItemCD: TdxEdit;
    eItemName: TdxEdit;
    spColor: TShape;
    grdListI_ITEM_CD: TdxDBGridMaskColumn;
    grdListI_ITEM_NAME: TdxDBGridMaskColumn;
    grdListI_ITEM_COLOR: TdxDBGridColumn;
    ViewqI_ITEM_COLOR: TStringField;
    procedure atNewExecute(Sender: TObject);
    procedure atEditExecute(Sender: TObject);
    procedure atSaveExecute(Sender: TObject);
    procedure atDelExecute(Sender: TObject);
    procedure ViewqAfterScroll(DataSet: TDataSet);
    procedure ViewqBeforePost(DataSet: TDataSet);
    procedure spColorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    function prif_CanSave: Boolean;
  protected
    procedure prop_IniData; override;
  public
    { Public declarations }
  end;

var
  frmSaleItemView: TfrmSaleItemView;

implementation

uses udmData, upubCommon;

{$R *.dfm}

{ TfrmSaleItemView }

procedure TfrmSaleItemView.prop_IniData;
begin
  inherited;
  //Viewq.AfterScroll := nil;
  with Viewq do
  begin
    if Active then Close;
    Connection := dmData.adocon;
    SQL.Text := 'SELECT * FROM T_SALE_ITME_MS';
    Open;
  end; 
  //Viewq.AfterScroll := ViewqAfterScroll;
end;

procedure TfrmSaleItemView.atNewExecute(Sender: TObject);
begin
  inherited;
  if Viewq.State <> dsBrowse then
  begin
    AppMsg('��ǰ���ڱ༭���ݣ�������ӣ�', '��Ʒ�������');
    Exit;
  end;
  Viewq.Append;
  eItemCD.SetFocus;
  eItemCD.SelectAll;
end;

procedure TfrmSaleItemView.atEditExecute(Sender: TObject);
begin
  inherited;
  if Viewq.IsEmpty then Exit;
  if Viewq.State in [dsBrowse] then
  begin
    try
      Viewq.Edit;
    except
      Abort;
    end;
  end else
    AppMsg('��ǰ���ڱ༭���ݣ������ٱ༭��', '��Ʒ�������');
end;

procedure TfrmSaleItemView.atSaveExecute(Sender: TObject);
begin
  inherited;
  if Viewq.State in [dsEdit, dsInsert] then
  begin
    try
      Viewq.Post;
      AppMsg('���ݱ������!', '��Ʒ����', 1);
    except
      Abort;
    end;
  end;
end;

procedure TfrmSaleItemView.atDelExecute(Sender: TObject);
begin
  inherited;
  if Viewq.IsEmpty then Exit; 
  if Viewq.State in [dsBrowse] then
  begin
    if AppMsg('���Ƿ����Ҫɾ����ǰ����?', '��Ʒ����', 2) <> IDYES then Exit;
    try
      Viewq.Delete; 
    except
      Abort;
    end;
    prop_IniData;
  end;
end;

procedure TfrmSaleItemView.ViewqAfterScroll(DataSet: TDataSet);
begin
  inherited;
  with Viewq do
  begin
    //ShowMessage(IntToStr(FieldByName('I_ITEM_COLOR').AsInteger));
    eItemCD.Text := FieldByName('I_ITEM_CD').AsString;
    eItemName.Text := FieldByName('I_ITEM_NAME').AsString;
    spColor.Brush.Color := TColor(StrToInt64(FieldByName('I_ITEM_COLOR').AsString));
  end;
end;

function TfrmSaleItemView.prif_CanSave: Boolean;
begin
  if Length(Trim(eItemCD.Text)) = 0 then
  begin
    AppMsg('��Ų���Ϊ��!', '��Ʒ����', 0);
    Result := False;
    Exit;
  end; 
  if Length(Trim(eItemName.Text)) = 0 then
  begin
    AppMsg('���Ʋ���Ϊ��!', '��Ʒ����', 0);
    Result := False;
    Exit;
  end;
  Result := True;
end;

procedure TfrmSaleItemView.ViewqBeforePost(DataSet: TDataSet);
begin
  inherited;
  if not prif_CanSave then Exit;
  with Viewq do
  begin
    FieldValues['I_ITEM_CD'] := eItemCD.Text;
    FieldValues['I_ITEM_NAME'] := eItemName.Text;
    FieldByName('I_ITEM_COLOR').AsString := IntToStr(ColorToRGB(spColor.Brush.Color));
    //FieldValues['I_ITEM_COLOR']
    //ShowMessage(IntToStr(ColorToRGB(spColor.Brush.Color)));
  end;
end;

procedure TfrmSaleItemView.spColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  lc_ColorDlg: TColorDialog;
begin
  inherited;
  lc_ColorDlg := TColorDialog.Create(nil);
  try
    lc_ColorDlg.Options := [cdPreventFullOpen];
    if lc_ColorDlg.Execute then
      spColor.Brush.Color := lc_ColorDlg.Color;
  finally
    lc_ColorDlg.Free;
  end;
end;

procedure TfrmSaleItemView.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmSaleItemView := nil;
end;

end.
