unit Cgth;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComDj, Menus, DBCtrls, ComCtrls, ToolWin, ExtCtrls, StdCtrls, Mask,
  Grids, DBGrids, Buttons, Db, CheckLst, ActnList, Variants;

type
  TfrmCgth = class(TfrmComDj)
    Label4: TLabel;
    DBEdit2: TDBEdit;
    Label9: TLabel;
    Label7: TLabel;
    DBText1: TDBText;
    btnGysHelp: TSpeedButton;
    DBEdit7: TDBEdit;
    DBEdit6: TDBEdit;
    Label14: TLabel;
    DBEdit12: TDBEdit;
    Label5: TLabel;
    DBComboBox1: TDBComboBox;
    DBLookupComboBox1: TDBLookupComboBox;
    Label6: TLabel;
    ToolButton1: TToolButton;
    aShd: TAction;
    ToolButton4: TToolButton;
    N7: TMenuItem;
    N8: TMenuItem;
    DBEdit3: TDBEdit;
    Label11: TLabel;
    DBLookupComboBox2: TDBLookupComboBox;
    Label12: TLabel;
    DBLookupComboBox3: TDBLookupComboBox;
    Label8: TLabel;
    DBComboBox2: TDBComboBox;
    Label10: TLabel;
    procedure IniRecord;override;
    procedure TotalField(Kind: char; Field: TField);override;
    procedure ZbOnNewRecord(DataSet: TDataSet);override;
    procedure sZbDataChange(Sender: TObject; Field: TField);override;
    procedure sMxDataChange(Sender: TObject; Field: TField);override;
    procedure btnGysHelpClick(Sender: TObject);
    procedure DBGrid1EditButtonClick(Sender: TObject);override;
    procedure FormShow(Sender: TObject);override;
    procedure aShdExecute(Sender: TObject);
    procedure ZbBeforePost(DataSet: TDataSet);override;
    procedure DBEdit3Exit(Sender: TObject);
  private
    { private declarations }
    procedure SetZt;
  public
    { Public declarations }
  end;

var
  frmCgth: TfrmCgth;

implementation

uses Dm, Common, Main, MyLib, GysHelp, HpHelp, ComFun, CgddHelp, CgshHelp;

{$R *.DFM}

procedure TfrmCgth.FormShow(Sender: TObject);
begin
  strZbMxKey := 'ID,ZBID; RQ,RQ; CKID,CKID';
  strZbKeyFields := 'DJBH; RQ; AGYSBH; CKID; ATHLX';
  strMxKeyFields := 'ABH';
  strZbHelpFields := 'AGYSBH';
  strMxHelpFields := 'ABH';
  strMxHh := 'HH';
  blnSetZbID := True;
  strAutoScale := 'DBGrid1';
  ValuesToStrings(DBComboBox1.Items, 'select XM from YG where YWYBZ order by BH');
  inherited;
  SetZt;
end;

procedure TfrmCgth.IniRecord;
begin
  //ͬʱ���� frmZB.dsAfterScroll
  dsMx.CommandText :=
    'select M.*, ' +
    'H.BH as aBH, H.PM as aPM, H.DW as aDW ' +
    'from CGTH M, HP H, M inner join H on M.HPID=H.ID ' +
    'where ZBID = ' + Float2Str(dsZb['ID']);
  inherited;
end;

procedure TfrmCgth.ZbOnNewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet['RQ'] := Date;
  DataSet['CKID'] := pintCKID;
  DataSet['ATHLX'] := DBComboBox2.Items[0];
  DataSet['SFKFSID'] := Data.Sfkfs['ID'];
  DataSet['YWY'] := '';
  DataSet['CZY'] := pstrUserName;
end;

procedure TfrmCgth.btnGysHelpClick(Sender: TObject);
begin
  frmGysHelp := TFrmGysHelp.Create(Application);
  with frmGysHelp do
  begin
    strEditFieldName := 'aGYSBH';
    strHelpFieldName := 'BH';
    dsEditing := self.dsZb;
    Edit1.Text := self.DBEdit2.Text;
    ShowModal;
    if ModalResult = MROK then
      self.Perform(WM_KEYDOWN, VK_RETURN, 0);
    Free;
  end;
end;

procedure TfrmCgth.sZbDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if (Field <> nil) and (TDataSource(Sender).State in [dsInsert, dsEdit]) then
  begin
    if (UpperCase(Field.FieldName) = 'RQ') then
      dsZb['DJBH'] := GetDjbh('CT', Field.AsDateTime, 'CGTHZB');
    if (UpperCase(Field.FieldName) = 'AGYSBH') then
      with CurDs do
      begin
        CommandText := 'select * from GYS where BH = ''' + Field.AsString + '''';
        Open;
        if not IsEmpty then
        begin
          dsZb['GYSID'] := FieldValues['ID'];
          dsZb['aGYSMC'] := FieldValues['MC'];
        end
        else
          Screen.ActiveControl.Perform(WM_LBUTTONDBLCLK, 0, 0);
        Close;
      end;
    if (UpperCase(Field.FieldName) = 'ATHLX') then
    begin
      dsZb['THLX'] := DBComboBox2.ItemIndex + 1;
      SetZt;
    end;
    if (UpperCase(Field.FieldName) = 'CKID') then
      dsZb['aCKMC'] := DBLookupComboBox1.Text;
    if (UpperCase(Field.FieldName) = 'SFKFSID') then
    begin
      dsZb['aSFKFSMC'] := DBLookupComboBox2.Text;
      dsZb['ZHID'] := DBLookupComboBox2.ListSource.DataSet['ZHID'];
    end;
    if (UpperCase(Field.FieldName) = 'ZHID') then
      dsZb['aZHMC'] := DBLookupComboBox2.Text;
    if (UpperCase(Field.FieldName) = 'YWY') and (Field.AsString <> '') then
      with CurDs do
      begin
        CommandText := 'select XM from YG where BH = ''' + Field.AsString + '''';
        Open;
        if not IsEmpty then
        begin
          dsZb['YWY'] := Fields[0].AsString;
          DBComboBox1.Text := Fields[0].AsString;
        end;
        Close;
      end;
  end;
end;

procedure TfrmCgth.TotalField(Kind: char; Field: TField);
var
  dblOld, dblNew: Double;
begin
  dblOld := RoundPlus(arMx('SL') * arMx('DJ') * (1 + arMx('NSL') / 100), 2);
  if Kind <> 'D' then
    dblNew := RoundPlus(dsMx['SL'] * dsMx['DJ'] * (1 + dsMx['NSL'] / 100), 2)
  else
    dblNew := 0;
  if Kind = 'E' then
    if (Field = nil) or (Pos(UpperCase(Field.FieldName) + ';', 'SL; DJ; NSL;') = 0) then
      Exit
    else
      arrMx[Field.Index] := dsMx[Field.FieldName];
  dsZb.Edit;
  case Kind of
    'E', 'C': dsZb['JE'] := dsZb['JE'] - dblOld + dblNew;
    'D':      dsZb['JE'] := dsZb['JE'] - dblOld;
  end;
end;

procedure TfrmCgth.sMxDataChange(Sender: TObject; Field: TField);
var
  dblXX, dblZKCL: double;
begin
  inherited;
  if (Field <> nil) and (TDataSource(Sender).State in [Dsinsert,Dsedit]) then
  begin
    if (UpperCase(Field.FieldName) = 'ABH') and (Field.AsString <> '') then
      with CurDs do
      begin
        CommandText := 'select * from HP where BH = ''' + Field.AsString + '''';
        Open;
        if not IsEmpty then
        begin
          dsMx['HPID'] := FieldValues['ID'];
          dsMx['aPM'] := FieldValues['PM'];
          dsMx['aDW'] := FieldValues['DW'];
          if dsMx['DJ'] = 0 then
            dsMx['DJ'] := FieldValues['JJ'];
        end
        else
          DBGrid1EditButtonClick(nil);
        Close;
      end;
    if (UpperCase(Field.FieldName) = 'SL') and (Field.AsFloat <> 0)
      and (dsMx.State in [dsInsert]) then
    begin
      dblZKCL := VarToFloat(GetFieldValue('select sum(JCS) from HPKC where HPID = ' + Float2Str(dsMx['HPID'])));
      if dblZKCL - Field.AsFloat < 0 then
        Application.MessageBox(Pchar('�˻��󣬻�Ʒ''' + VarToStr(dsMx['aPM']) + '''���ܿ���������ָ�����'), '������', MB_OK + MB_ICONWARNING)
      else
      begin
        dblXX := VarToFloat(GetFieldValue('select XX from HP where ID = ' + Float2Str(dsMx['HPID'])));
        if dblXX <> 0 then
          if dblZKCL - Field.AsFloat < dblXX then
            Application.MessageBox(Pchar('�˻��󣬻�Ʒ''' + VarToStr(dsMx['aPM']) + '''���ܿ�����Ѿ������趨�Ŀ�����ޡ�'), '������', MB_OK + MB_ICONWARNING);
      end;
    end;
  end;
end;

procedure TfrmCgth.DBGrid1EditButtonClick(Sender: TObject);
begin
  if UpperCase(DBGrid1.SelectedField.FieldName) = 'ABH' then
  begin
    frmHpHelp := TfrmHpHelp.Create(Application);
    with frmHpHelp do
    begin
      strEditFieldName := 'aBH';
      strHelpFieldName := 'BH';
      dsEditing := self.dsMx;
      Edit1.Text := self.DBGrid1.Fields[0].Text;
      ShowModal;
      Free;
    end;
  end;
end;

//�����ջ���
procedure TfrmCgth.aShdExecute(Sender: TObject);
begin
  if dsZb.FieldByName('aGYSBH').AsString = '' then
  begin
    Application.MessageBox('����¼�빩Ӧ�����ϡ�', '������', MB_OK + MB_ICONWARNING);
    DBEdit2.SetFocus;
    Exit;
  end;
  frmCgshHelp := TFrmCgshHelp.Create(Application);
  with frmCgshHelp do
  begin
    dsEditing := self.dsMx;
    Edit1.Text := self.DBEdit7.Text;
    dtpRqa.Date := StrToDate(DBEdit1.Text) - 30;
    dtpRqb.Date := StrToDate(DBEdit1.Text);
    ShowModal;
    if dsZb['aGYSBH'] <> dsHelp['aGYSBH'] then
      dsZb['aGYSBH'] := dsHelp['aGYSBH'];
    Free;
  end;
end;

procedure TfrmCgth.SetZt;
begin
  //Ʊ�ţ��տʽ��ȥ��
  Label10.Enabled := DBComboBox2.ItemIndex = 0;
  Label11.Enabled := DBComboBox2.ItemIndex = 0;
  Label12.Enabled := DBComboBox2.ItemIndex = 0;
  DBEdit3.Enabled := DBComboBox2.ItemIndex = 0;
  DBLookupComboBox2.Enabled := DBComboBox2.ItemIndex = 0;
  DBLookupComboBox3.Enabled := DBComboBox2.ItemIndex = 0;
  if dsZb.State in [dsInsert, dsEdit] then
    if DBComboBox2.ItemIndex = 1 then
    begin
      DBLookupComboBox2.Field.Value := 0;
      DBLookupComboBox3.Field.Value := 0;
    end;
  if DBLookupComboBox2.Enabled and not Data.SFKFS.Active then
    Data.SFKFS.Open;
  if DBLookupComboBox3.Enabled and not Data.ZH.Active then
    Data.ZH.Open;
end;

procedure TfrmCgth.ZbBeforePost(DataSet: TDataSet);
begin
  if (dsZb.FieldByName('THLX').AsInteger = 1) and
    ((dsZb.FieldByName('SFKFSID').AsInteger = 0) or
    (dsZb.FieldByName('ZHID').AsInteger = 0))then
  begin
    Application.MessageBox('''�տʽ''��''�տ��ʻ�''δ¼��, �����¼��!', '¼�����', MB_OK + MB_ICONWARNING);
    DBLookupComboBox2.SetFocus;
    Abort;
  end;
  inherited;
end;

procedure TfrmCgth.DBEdit3Exit(Sender: TObject);
begin
  if not Label11.Enabled then
    DBGrid1.SetFocus; 
end;

end.
