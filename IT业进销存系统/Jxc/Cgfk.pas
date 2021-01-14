unit Cgfk;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComDj, Menus, DBCtrls, ComCtrls, ToolWin, ExtCtrls, StdCtrls, Mask,
  Grids, DBGrids, Buttons, Db, CheckLst, ActnList, Variants;

type
  TfrmCgfk = class(TfrmComDj)
    Label4: TLabel;
    DBEdit2: TDBEdit;
    Label9: TLabel;
    Label7: TLabel;
    btnGysHelp: TSpeedButton;
    DBEdit7: TDBEdit;
    DBEdit6: TDBEdit;
    Label14: TLabel;
    DBEdit12: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    Label6: TLabel;
    ToolButton1: TToolButton;
    aZdfk: TAction;
    aCKGJD: TAction;
    N7: TMenuItem;
    N8: TMenuItem;
    N12: TMenuItem;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    labJEA: TLabel;
    labJEB: TLabel;
    labJEC: TLabel;
    labJED: TLabel;
    Shape1: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    ToolButton2: TToolButton;
    Label8: TLabel;
    DBEdit3: TDBEdit;
    DBComboBox2: TDBComboBox;
    Label13: TLabel;
    Label15: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBLookupComboBox2: TDBLookupComboBox;
    pnlHint: TPanel;
    Label16: TLabel;
    Label20: TLabel;
    Label17: TLabel;
    aZdfkB: TAction;
    N13: TMenuItem;
    labJYJ: TLabel;
    labKYZJE: TLabel;
    labFKHYE: TLabel;
    DBCheckBox2: TDBCheckBox;
    pnlTs: TPanel;
    Panel5: TPanel;
    SpeedButton1: TSpeedButton;
    btnCloseTs: TButton;
    Label18: TLabel;
    Label19: TLabel;
    aTs: TAction;
    N14: TMenuItem;
    N15: TMenuItem;
    procedure IniRecord;override;
    procedure TotalField(Kind: char; Field: TField);override;
    procedure ZbOnNewRecord(DataSet: TDataSet);override;
    procedure MxBeforeInsert(DataSet: TDataSet);override;
    procedure sZbDataChange(Sender: TObject; Field: TField);override;
    procedure sMxDataChange(Sender: TObject; Field: TField);override;
    procedure btnGysHelpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);override;
    procedure aZdfkExecute(Sender: TObject);
    procedure aCKGJDExecute(Sender: TObject);
    procedure aZdfkBExecute(Sender: TObject);
    procedure DBGrid1EditButtonClick(Sender: TObject);override;
    procedure aSaveExecute(Sender: TObject);override;
    procedure btnCloseTsClick(Sender: TObject);
    procedure aTsExecute(Sender: TObject);
    procedure DBComboBox2Change(Sender: TObject);
    procedure DBCheckBox2Click(Sender: TObject);
  private
    { private declarations }
    blnCanInsert: boolean;
    procedure SetMx;
    procedure SetJEABCD;
    procedure SetJYJ;
    procedure SetKYZJE;
    procedure SetFKHYE;
  public
    { Public declarations }
  end;

var
  frmCgfk: TfrmCgfk;

implementation

uses Dm, Common, Main, MyLib, GysHelp, HpHelp, ComFun;

{$R *.DFM}

procedure TfrmCgfk.FormShow(Sender: TObject);
begin
  strZbMxKey := 'ID,ZBID; RQ,RQ';
  strZbKeyFields := 'DJBH; RQ; AFKLX; AGYSBH; SFKFSID; ZHID';
  strZbHelpFields := 'AGYSBH';
  strMxHh := 'HH';
  blnSetZbID := True;
  strAutoScale := 'DBGrid1';
  inherited;
end;

procedure TfrmCgfk.IniRecord;
begin
  //ͬʱ���� frmZB.dsAfterScroll
  dsMx.CommandText :=
    'select M.*, ' +
    'D.DJBH as aDDBH, D.RQ as aDDRQ, D.JE as aDDJE, ' +
    'D.YFJE - M.JE as aYFJE, D.JE - D.YFJE + M.JE as aMFJE ' +
    'from CGFK M, CGSHZB D, M inner join D on M.DDID=D.ID ' +
    'where M.ZBID = ' + Float2Str(dsZb['ID']);
  inherited;
  //INI LABEL
  labJYJ.Caption := '0.00';
  labKYZJE.Caption := '0.00';
  labFKHYE.Caption := '0.00';
  labJEA.Caption := '0.00';
  labJEB.Caption := '0.00';
  labJEC.Caption := '0.00';
  labJED.Caption := '0.00';
  //SetJYJ
  SetJYJ;
  //SetJEABCD
  SetJEABCD;
  //SetFKHYE
  SetFKHYE;
  //
  DBCheckBox2.Enabled := dsZb.FieldByName('FKLX').AsInteger = 1;
end;

procedure TfrmCgfk.ZbOnNewRecord(DataSet: TDataSet);
begin
  inherited;
  DataSet['RQ'] := Date;
  DataSet['AFKLX'] := DBComboBox2.Items[0];
  DataSet['CZY'] := pstrUserName;
  DataSet['SFKFSID'] := Data.Sfkfs['ID'];
  DataSet['SYJY'] := False;
end;

procedure TfrmCgfk.btnGysHelpClick(Sender: TObject);
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

procedure TfrmCgfk.sZbDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if (Field <> nil) and (TDataSource(Sender).State in [dsInsert, dsEdit]) then
  begin
    if (UpperCase(Field.FieldName) = 'RQ') then
      dsZb['DJBH'] := GetDjbh('CF', Field.AsDateTime, 'CGFKZB');
    if (UpperCase(Field.FieldName) = 'AGYSBH') then
      with CurDs do
      begin
        CommandText := 'select * from GYS where BH = ''' + Field.AsString + '''';
        Open;
        if not IsEmpty then
        begin
          dsZb['GYSID'] := FieldValues['ID'];
          dsZb['aGYSMC'] := FieldValues['MC'];
          dsZb['JEA'] := FieldValues['YXJE'];
          SetMx;
          SetJYJ;
        end
        else
          Screen.ActiveControl.Perform(WM_LBUTTONDBLCLK, 0, 0);
        Close;
      end;
    if (UpperCase(Field.FieldName) = 'AFKLX') then
      dsZb['FKLX'] := DBComboBox2.ItemIndex + 1;
    if (UpperCase(Field.FieldName) = 'SFKFSID') then
    begin
      dsZb['aSFKFSMC'] := DBLookupComboBox1.Text;
      dsZb['ZHID'] := DBLookupComboBox1.ListSource.DataSet['ZHID'];
    end;
    if (UpperCase(Field.FieldName) = 'ZHID') then
      dsZb['aZHMC'] := DBLookupComboBox2.Text;
    if (UpperCase(Field.FieldName) = 'JE') then
      SetKYZJE;
  end;
end;

//sZbDataChange���ܼ��ø��£�������������
procedure TfrmCgfk.DBComboBox2Change(Sender: TObject);
begin
  DBCheckBox2.Enabled := True;
  if DBComboBox2.ItemIndex = 1 then
    DBCheckBox2.Enabled := False;
  if dsZb = nil then Exit;
  if (DBComboBox2.ItemIndex + 1) <> dsZb.FieldByName('FKLX').AsInteger then
    dsZb['FKLX'] := DBComboBox2.ItemIndex + 1;
  SetMx;
end;

//sZbDataChange���ܼ��ø��£�������������
procedure TfrmCgfk.DBCheckBox2Click(Sender: TObject);
begin
  if dsZb = nil then Exit;
  if dsZb.State in [dsInsert, dsEdit] then
    dsZb.FieldByName('SYJY').AsBoolean := DBCheckBox2.Checked;
  SetJYJ;
end;

procedure TfrmCgfk.MxBeforeInsert(DataSet: TDataSet);
begin
  if not blnCanInsert then
    abort;
end;

procedure TfrmCgfk.SetMx;
var
  dblJE: double;
  blnHaveOld: boolean;
  intDDID: integer;
begin
  screen.Cursor := crHourGlass;
  //Del
  with dsMx do
    while not IsEmpty do
      Delete;
  //Add
  if DBComboBox2.ItemIndex = 0 then
  begin
    blnCanInsert := True;
    blnHaveOld := False;
    if CheckRecord('select * from CGFKZB where ID = ' + Float2Str(dsZb['ID']) + ' and ' +
      'GYSID = ' + Float2Str(dsZb['GYSID'])) then
      with CurDs do
      begin
        CommandText := 'select F.DDID, F.JE as BDJE, S.DJBH, S.RQ, S.JE, S.YFJE ' +
          'from CGFK F, CGSHZB S ' +
          'where F.DDID = S.ID and ZBID = ' + Float2Str(dsZb['ID']);
        Open;
        blnHaveOld := not IsEmpty;
        while not Eof do
        begin
          dsMx.Append;
          dsMx['DDID'] := FieldValues['DDID'];
          dsMx['aDDBH'] := FieldValues['DJBH'];
          dsMx['aDDRQ'] := FieldValues['RQ'];
          dsMx['aDDJE'] := FieldValues['JE'];
          dsMx['aYFJE'] := FieldValues['YFJE'] - FieldValues['BDJE'];
          dsMx['aMFJE'] := FieldValues['JE'] - FieldValues['YFJE'] + FieldValues['BDJE'];
          dsMx['JE'] := FieldValues['BDJE'];
          Next;
        end;
        dsMx.First;
        DBGrid1.SelectedIndex := DBGrid1.FieldCount - 1;
        Close;
      end;
    //New Add
    if not blnHaveOld then
      with CurDs do
      begin
        CommandText := 'select * from CGSHZB ' +
          'where CGLX = 2 and GYSID = ' + VarToStr(dsZb['GYSID']) + ' and JE > YFJE ' +
          'order by ID';
        Open;
        while not Eof do
        begin
          intDDID := FieldByName('ID').AsInteger;
          dblJE := VarToFloat(GetFieldValue('select JE from CGFK ' +
            'where ZBID = ' + Float2Str(dsZb['ID']) + ' and ' +
            'DDID = ' + IntToStr(intDDID)));
          dsMx.Append;
          dsMx['DDID'] := FieldValues['ID'];
          dsMx['aDDBH'] := FieldValues['DJBH'];
          dsMx['aDDRQ'] := FieldValues['RQ'];
          dsMx['aDDJE'] := FieldValues['JE'];
          dsMx['aYFJE'] := FieldValues['YFJE'] - dblJE;
          dsMx['aMFJE'] := FieldValues['JE'] - FieldValues['YFJE'] + dblJE;
          dsMx['JE'] := dblJE;
          Next;
        end;
        dsMx.First;
        DBGrid1.SelectedIndex := DBGrid1.FieldCount - 1;
        Close;
      end;
    blnCanInsert := False;
  end;
  //SetJEABCD
  SetJEABCD;
  screen.Cursor := crDefault;
end;

procedure TfrmCgfk.TotalField(Kind: char; Field: TField);
var
  dblJED, dblOld, dblNew: Double;
begin
  dblJED := Str2Float(labJED.Caption);
  dblOld := RoundPlus(arMx('JE'), 2);
  if Kind <> 'D' then
    dblNew := RoundPlus(dsMx['JE'], 2)
  else
    dblNew := 0;
  if Kind = 'E' then
    if (Field = nil) or (Pos(UpperCase(Field.FieldName) + ';', 'JE;') = 0) then
      Exit
    else
      arrMx[Field.Index] := dsMx[Field.FieldName];

  dsZb.Edit;
  case Kind of
    'E', 'C': dblJED := dblJED - dblOld + dblNew;
    'D':      dblJED := dblJED - dblOld;
  end;
  labJED.Caption := FormatFloat('#,0.00', dblJED);
  SetFKHYE;
end;

procedure TfrmCgfk.sMxDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if (Field <> nil) and (TDataSource(Sender).State in [Dsinsert,Dsedit]) then
  begin
    if (UpperCase(Field.FieldName) = 'DDID') and (Field.AsString <> '') then
      with CurDs do
      begin
        CommandText := 'select * from CGSHZB where ID = ' + Field.AsString;
        Open;
        if not IsEmpty then
        begin
          dsMx['aDDBH'] := FieldValues['DJBH'];
          dsMx['aDDRQ'] := FieldValues['RQ'];
          dsMx['aDDJE'] := FieldValues['JE'];
          dsMx['aYFJE'] := FieldValues['YFJE'];
          dsMx['aMFJE'] := FieldValues['JE'] - FieldValues['YFJE'];
        end
        else
          DBGrid1EditButtonClick(nil);
        Close;
      end;
  end;
end;

//�Զ����� ����
procedure TfrmCgfk.aZdfkExecute(Sender: TObject);
var
  dblKYZJE: double;
begin
  dblKYZJE := Str2Float(labKYZJE.Caption);
  with dsMx do
  begin
    First;
    while not Eof do
    begin
      Edit;
      if FieldByName('aMFJE').AsFloat > dblKYZJE then
      begin
        FieldByName('JE').AsFloat := dblKYZJE;
        dblKYZJE := 0;
      end
      else
      begin
        FieldByName('JE').AsFloat := FieldByName('aMFJE').AsFloat;
        dblKYZJE := dblKYZJE - FieldByName('JE').AsFloat;
      end;
      Post;
      Next;
    end;
    First;
  end;
end;

//�Զ����� ��ǰ�ջ���
procedure TfrmCgfk.aZdfkBExecute(Sender: TObject);
var
  dblFKHYE: double;
begin
  dblFKHYE := Str2Float(labFKHYE.Caption);
  with dsMx do
    if not Eof then
      if FieldByName('JE').AsFloat <> 0 then
      begin
        Edit;
        FieldByName('JE').AsFloat := 0;
        Post;
      end
      else
      begin
        Edit;
        if FieldByName('aMFJE').AsFloat > dblFKHYE then
          FieldByName('JE').AsFloat := dblFKHYE
        else
          FieldByName('JE').AsFloat := FieldByName('aMFJE').AsFloat;
        Post;
      end;
end;

//�鿴������
procedure TfrmCgfk.aCKGJDExecute(Sender: TObject);
begin
  OpenCgsh(dsMx['DDID']);
end;

procedure TfrmCgfk.SetJYJ;
begin
  if dsZb = nil then exit;
  if DBCheckBox2.Checked then
    labJYJ.Caption := FormatFloat('#,0.00', dsZb.FieldByName('JEA').AsFloat)
  else
    labJYJ.Caption := '0.00';
  SetKYZJE;
  screen.Cursor := crDefault;
end;

procedure TfrmCgfk.SetKYZJE;
begin
  if (labJYJ.Caption = 'labJYJ') or (labJED.Caption = 'labJED') then Exit;
  labKYZJE.Caption := FormatFloat('#,0.00', Str2Float(labJYJ.Caption) + dsZb.FieldByName('JE').AsFloat);
  SetFKHYE;
end;

procedure TfrmCgfk.SetFKHYE;
begin
  labFKHYE.Caption := FormatFloat('#,0.00', Str2Float(labKYZJE.Caption) - Str2Float(labJED.Caption));
  if dsZb.State in [dsInsert, dsEdit] then
    dsZb['JEB'] := dsZb.FieldByName('JE').AsFloat - Str2Float(labJED.Caption);
end;

procedure TfrmCgfk.SetJEABCD;
var
  dblJEA, dblJEB, dblJEC, dblJED: double;
begin
  dblJEA := 0;
  dblJEB := 0;
  dblJEC := 0;
  dblJED := 0;
  with dsMx do
  begin
    First;
    while not Eof do
    begin
      dblJEA := dblJEA + dsMx['aDDJE'];
      dblJEB := dblJEB + dsMx['aYFJE'];
      dblJEC := dblJEC + dsMx['aMFJE'];
      dblJED := dblJED + dsMx['JE'];
      Next;
    end;
    First;
  end;
  labJEA.Caption := FormatFloat('#,0.00', dblJEA);
  labJEB.Caption := FormatFloat('#,0.00', dblJEB);
  labJEC.Caption := FormatFloat('#,0.00', dblJEC);
  labJED.Caption := FormatFloat('#,0.00', dblJED);
end;

procedure TfrmCgfk.DBGrid1EditButtonClick(Sender: TObject);
begin
  inherited;
  aZdfkB.Execute;
end;

procedure TfrmCgfk.aSaveExecute(Sender: TObject);
var
  blnErr: boolean;
begin
  if Str2Float(labKYZJE.Caption) = 0 then
  begin
    Application.MessageBox(Pchar('�����ܽ���Ϊ��, ������''������''��ѡ��''ʹ�ý����''!'), '¼�����', MB_OK + MB_ICONWARNING);
    abort;
  end;
  if (dsZb.FieldByName('FKLX').AsInteger = 1) and (Str2Float(labJED.Caption) = 0) then
  begin
    Application.MessageBox(Pchar('������û�и��κ�Ӧ�����ݡ������Ҫ����Ԥ�������ѡ��''��������''ΪԤ���'), '¼�����', MB_OK + MB_ICONWARNING);
    abort;
  end;
  if (dsZb.FieldByName('FKLX').AsInteger = 1) and
    (Str2Float(labJED.Caption) > Str2Float(labKYZJE.Caption)) then
  begin
    Application.MessageBox(Pchar('���θ����ܽ�Ӧ�ô��ڿ����ܽ������·��䱾�θ��'), '¼�����', MB_OK + MB_ICONWARNING);
    abort;
  end;
  blnErr := False;
  with dsMx do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('JE').AsFloat > FieldByName('aMFJE').AsFloat then
      begin
        blnErr := True;
        DBGrid1.SelectedIndex := DBGrid1.FieldCount - 1;
        Break;
      end;
      Next;
    end;
    if not blnErr then
      First;
  end;
  if blnErr then
  begin
    Application.MessageBox(Pchar('���θ��Ӧ�ô����ջ���ĩ����'), '¼�����', MB_OK + MB_ICONWARNING);
    abort;
  end;
  if (dsZb.FieldByName('FKLX').AsInteger = 1) and
    (Str2Float(labJED.Caption) < Str2Float(labKYZJE.Caption)) then
    if Application.MessageBox( '�����н��࣬������ת���Ӧ��Ӧ��Ԥ������?',
      'ѯ��', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON1 ) = IDNO then
      abort;
  inherited;
end;

procedure TfrmCgfk.btnCloseTsClick(Sender: TObject);
begin
  pnlTs.Visible := False;
end;

procedure TfrmCgfk.aTsExecute(Sender: TObject);
begin
  pnlTs.Top := (self.Height - pnlTs.Height) div 2; 
  pnlTs.Visible := True;
end;

end.
