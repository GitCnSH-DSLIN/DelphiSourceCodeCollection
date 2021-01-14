unit C_Ydhc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C_StdJd, DosMove, StdCtrls, Buttons, ExtCtrls, DB, DBTables,
  Mask, DBCtrls, C_Define;

type
  TYdhcForm = class(TStdJdForm)
    tblYdhc: TTable;
    dsYdhc: TDataSource;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBComboBox1: TDBComboBox;
    Label3: TLabel;
    DBComboBox2: TDBComboBox;
    Label4: TLabel;
    lblHcmc: TLabel;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    Label6: TLabel;
    DBEdit4: TDBEdit;
    Label7: TLabel;
    DBEdit5: TDBEdit;
    Label8: TLabel;
    DBEdit6: TDBEdit;
    Label9: TLabel;
    DBEdit7: TDBEdit;
    Label10: TLabel;
    DBEdit8: TDBEdit;
    Label11: TLabel;
    DBEdit9: TDBEdit;
    Label12: TLabel;
    DBEdit10: TDBEdit;
    Label13: TLabel;
    DBEdit11: TDBEdit;
    Label14: TLabel;
    DBEdit12: TDBEdit;
    Label15: TLabel;
    DBEdit13: TDBEdit;
    Label16: TLabel;
    DBEdit14: TDBEdit;
    Label17: TLabel;
    DBEdit15: TDBEdit;
    Label18: TLabel;
    DBEdit16: TDBEdit;
    Label19: TLabel;
    DBEdit17: TDBEdit;
    Label20: TLabel;
    DBEdit18: TDBEdit;
    Label21: TLabel;
    Label22: TLabel;
    lblKrxm: TLabel;
    Label23: TLabel;
    lblLxr: TLabel;
    btnYdqr: TBitBtn;
    lblState: TStaticText;
    btnYdqx: TBitBtn;
    tblYdhcD_YDBH: TStringField;
    tblYdhcD_KRBH: TStringField;
    tblYdhcD_KRXM: TStringField;
    tblYdhcD_YDRQ: TDateTimeField;
    tblYdhcD_SYRQ: TDateTimeField;
    tblYdhcD_SYSJ: TDateTimeField;
    tblYdhcD_SJDM: TStringField;
    tblYdhcD_HCBH: TStringField;
    tblYdhcD_HCMC: TStringField;
    tblYdhcD_HCZJ: TFloatField;
    tblYdhcD_HCRS: TIntegerField;
    tblYdhcD_HCRS1: TIntegerField;
    tblYdhcD_HFSL: TFloatField;
    tblYdhcD_HFJE: TFloatField;
    tblYdhcD_HFBZ: TStringField;
    tblYdhcD_XHSL: TFloatField;
    tblYdhcD_XHJE: TFloatField;
    tblYdhcD_XHBZ: TStringField;
    tblYdhcD_SGSL: TFloatField;
    tblYdhcD_SGJE: TFloatField;
    tblYdhcD_SGBZ: TStringField;
    tblYdhcD_QTJE: TFloatField;
    tblYdhcD_QTBZ: TStringField;
    tblYdhcD_HTSL: TFloatField;
    tblYdhcD_HTBZ: TStringField;
    tblYdhcD_RZBZ: TStringField;
    tblYdhcD_JSBZ: TStringField;
    tblYdhcD_CZYXM: TStringField;
    tblYdhcD_BZ: TBlobField;
    DBMemo1: TDBMemo;
    btnPrint: TBitBtn;
    Label24: TLabel;
    lblLxdh: TLabel;
    procedure tblYdhcNewRecord(DataSet: TDataSet);
    procedure btnCancClick(Sender: TObject);
    procedure DBComboBox2Exit(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure tblYdhcBeforePost(DataSet: TDataSet);
    procedure btnYdqrClick(Sender: TObject);
    procedure btnYdqxClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure DBComboBox1Exit(Sender: TObject);
    procedure DBEdit2Exit(Sender: TObject);
  private
    { Private declarations }
    IsAppend: Boolean;
    IsHcjs: Boolean;
    FKrbh: string;
    FHcbh,FHcbhOld: string;
    FSyrq,FSyrqOld: TDateTime;
    FSjdm,FSjdmOld: string;

    FBz : TStringList;
    procedure ShowState;
  public
    { Public declarations }
  end;

var
  YdhcForm: TYdhcForm;

procedure YdhcNew(const AKrbh: string);
procedure YdhcEdit(const AKrbh,AYdbh: string);
procedure YdhcJs(const AKrbh,AYdbh: string);

implementation

uses C_HotelData, C_Hcjs, C_YdhcPrint;

{$R *.dfm}

//����Ԥ���᳡
procedure YdhcNew(const AKrbh: string);
begin
  YdhcForm := TYdhcForm.Create(Application);
  try
    with YdhcForm do
    begin
      //��ʼ��
      FKrbh           := AKrbh;
      lblKrxm.Caption := HotelData.FindUserBh('YDXX','D_KRXM','D_KRBH',FKrbh);
      lblLxr.Caption  := HotelData.FindUserBh('YDXX','D_LXR','D_KRBH',FKrbh);
      lblLxdh.Caption := HotelData.FindUserBh('YDXX','D_LXDH','D_KRBH',FKrbh);
      HotelData.ListDbDm(DBComboBox2,'HCDM','D_HCMC');

      //�Ƿ���������
      IsAppend := True;
      //�Ƿ�᳡����
      IsHcjs   := False;

      try
        tblYdhc.Open;
      except
        On E:Exception do
        begin
          ShowWarning('�����ݿ�����������������Ƿ�������'
                      +#13#10
                      +'������Ϣ:'
                      +E.Message);
          raise;
        end;
      end;

      tblYdhc.Insert;
      FHcbhOld := tblYdhcD_HCBH.Value;
      FSyrqOld := tblYdhcD_SYRQ.Value;
      FSjdmOld := tblYdhcD_SJDM.Value;

      //��ʾȷ��״̬
      ShowState;

      ShowModal;
    end;
  finally
    YdhcForm.tblYdhc.Close;
    YdhcForm.Free;
  end;
end;

//�޸Ļ᳡Ԥ��
procedure YdhcEdit(const AKrbh,AYdbh: string);
begin
  YdhcForm := TYdhcForm.Create(Application);
  try
    with YdhcForm do
    begin
      //��ʼ��
      FKrbh    := AKrbh;
      IsAppend := False;
      IsHcjs   := False;
      HotelData.ListDbDm(DBComboBox2,'HCDM','D_HCMC');
      lblKrxm.Caption := HotelData.FindUserBh('YDXX','D_KRXM','D_KRBH',FKrbh);
      lblLxr.Caption  := HotelData.FindUserBh('YDXX','D_LXR','D_KRBH',FKrbh);
      lblLxdh.Caption := HotelData.FindUserBh('YDXX','D_LXDH','D_KRBH',FKrbh);

      try
        tblYdhc.Open;
      except
        On E:Exception do
        begin
          ShowWarning('�����ݿ�����������������Ƿ�������'
                      +#13#10
                      +'������Ϣ:'
                      +E.Message);
          raise;
        end;
      end;

      //��λ
      tblYdhc.Locate('D_YDBH',AYdbh,[]);

      //��ʾ�᳡����
      lblHcmc.Caption := tblYdhcD_HCMC.Value;
      //�༭
      tblYdhc.Edit;

      ShowState;
      FHcbhOld := tblYdhcD_HCBH.Value;
      FSyrqOld := tblYdhcD_SYRQ.Value;
      FSjdmOld := tblYdhcD_SJDM.Value;

      ShowModal;
    end;
  finally
    YdhcForm.tblYdhc.Close;
    YdhcForm.Free;
  end;
end;

//�᳡����
procedure YdhcJs(const AKrbh,AYdbh: string);
begin
  YdhcForm := TYdhcForm.Create(Application);
  try
    with YdhcForm do
    begin
      //��ʼ��
      FKrbh    := AKrbh;
      IsAppend := False;
      IsHcjs   := True;
      lblTitile.Caption := '�᳡����';
      HotelData.ListDbDm(DBComboBox2,'HCDM','D_HCMC');
      lblKrxm.Caption := HotelData.FindUserBh('YDXX','D_KRXM','D_KRBH',FKrbh);
      lblLxr.Caption  := HotelData.FindUserBh('YDXX','D_LXR','D_KRBH',FKrbh);
      lblLxdh.Caption := HotelData.FindUserBh('YDXX','D_LXDH','D_KRBH',FKrbh);
      

      try
        tblYdhc.Open;
      except
        On E:Exception do
        begin
          ShowWarning('�����ݿ�����������������Ƿ�������'
                      +#13#10
                      +'������Ϣ:'
                      +E.Message);
          raise;
        end;
      end;

      tblYdhc.Locate('D_YDBH',AYdbh,[]);

      FHcbh := tblYdhcD_HCBH.Value;
      FSyrq := tblYdhcD_SYRQ.Value;
      FSjdm := tblYdhcD_SJDM.Value;

      lblKrxm.Caption := HotelData.FindUserBh('YDXX','D_KRXM','D_KRBH',FKrbh);
      lblLxr.Caption  := HotelData.FindUserBh('YDXX','D_LXR','D_KRBH',FKrbh);
      lblHcmc.Caption := tblYdhcD_HCMC.Value;

      tblYdhc.Edit;

      FHcbhOld := tblYdhcD_HCBH.Value;
      FSyrqOld := tblYdhcD_SYRQ.Value;
      FSjdmOld := tblYdhcD_SJDM.Value;

      ShowState;

      ShowModal;
    end;
  finally
    YdhcForm.tblYdhc.Close;
    YdhcForm.Free;
  end;
end;

//��ʾȷ��״̬
procedure TYdhcForm.ShowState;
begin
  if tblYdhcD_RZBZ.Value='T' then
  begin
    lblState.Caption    := '��ȷ��';
    lblState.Font.Color := clGreen;
  end
  else
  begin
    lblState.Caption    := 'δȷ��';
    lblState.Font.Color := clYellow;
  end;

  btnYdqr.Enabled := tblYdhcD_RZBZ.Value<>'T';
  //btnYdqx.Enabled := btnYdqr.Enabled;
end;

//������¼
procedure TYdhcForm.tblYdhcNewRecord(DataSet: TDataSet);
begin
  inherited;
  tblYdhcD_KRBH.Value := FKrbh;
  tblYdhcD_KRXM.Value := lblKrxm.Caption;
  tblYdhcD_YDRQ.Value := Date;
  tblYdhcD_SYRQ.Value := Date;
  tblYdhcD_SYSJ.Value := Time;
  tblYdhcD_SJDM.Value := 'ȫ��';
  //tblYdhcD_RZBZ.Value := RZ_NO;
  tblYdhcD_JSBZ.Value := JS_NO;
  tblYdhcD_CZYXM.Value:= CZY.CzyXm;
end;

procedure TYdhcForm.btnCancClick(Sender: TObject);
begin
  inherited;
  tblYdhc.Cancel;
end;

procedure TYdhcForm.DBComboBox2Exit(Sender: TObject);
var
  s: string;
  AHcbh,AHcmc: string;
begin
  inherited;
  with (Sender as TDBComboBox) do
  begin
    s := Items[ItemIndex];
    AHcmc := GetMc(s);
    AHcbh := HotelData.FindBh('HCDM','D_HCBH','D_HCMC',AHcmc);
    if AHcbh<>'' then
    begin
      tblYdhcD_HCBH.Value := AHcbh;
      lblHcmc.Caption     := AHcmc;
      FHcbh := AHcbh;
    end
    else
      SetFocus;
  end;
end;

//ȷ��
procedure TYdhcForm.btnOKClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'Ԥ���޸�') then Exit;
  if tblYdhcD_HCBH.Value='' then
  begin
    ShowMessage('��ѡ��Ԥ���᳡��ţ�');
    Exit;
  end;
  HotelData.DatabaseUser.StartTransaction;
  try
    if not IsHcjs then
    begin
    //���û���޸�
    if   (tblYdhcD_HCBH.Value=FHcbhOld)
      and(tblYdhcD_SJDM.Value=FSjdmOld)
      and(tblYdhcD_SYRQ.Value=FSYRQOld) then
    begin
      tblYdhcD_HCMC.Value := lblHcmc.Caption;
      tblYdhc.Post;
    end
    else
    begin
      //�ж��Ƿ�Ԥ��
      if HotelData.IsValidHcyd(tblYdhcD_HCBH.Value,tblYdhcD_SJDM.Value,tblYdhcD_SYRQ.Value) then
      begin
        tblYdhcD_HCMC.Value := lblHcmc.Caption;
        tblYdhc.Post;
      end
      else
      begin
        ShowWarning('�û᳡�Ѿ���Ԥ����');
        HotelData.DatabaseUser.Rollback;
        Exit;
      end;
    end;
    end
    else
    begin
    //����ǻ᳡����
      Hcjs(tblYdhcD_YDBH.Value);
    end;
    HotelData.DatabaseUser.Commit;
  except
    HotelData.DatabaseUser.Rollback;
    raise;
  end;

  Close;
end;

procedure TYdhcForm.tblYdhcBeforePost(DataSet: TDataSet);
begin
  inherited;
  if IsAppend then
  begin
    tblYdhcD_YDBH.Value := HotelData.GetBh('D_YDBH',PREV_YDBH);
    tblYdhcD_HCMC.Value := lblHcmc.Caption;
  end;
end;

procedure TYdhcForm.btnYdqrClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'Ԥ��ȷ��') then Exit;
  if Confirm('��ȷ�ϸû᳡��Ԥ����') then
  begin
    tblYdhcD_RZBZ.Value := 'T';
    ShowState;
    btnOkClick(nil);
  end;
end;

procedure TYdhcForm.btnYdqxClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'Ԥ��ȷ��') then Exit;
  if Confirm('��ȡ���û᳡��ȷ����') then
  begin
    tblYdhcD_RZBZ.Value := 'F';
    ShowState;
    IsHcjs := False;
    //btnOkClick(nil);
  end;

  {if Confirm('��ȷ��ȡ����Ԥ����') then
  begin
    tblYdhc.Delete;
    Close;
  end; }
end;

procedure TYdhcForm.btnPrintClick(Sender: TObject);
begin
  if Confirm('��ȷ�ϸû᳡��Ԥ����') then
  begin
    tblYdhcD_RZBZ.Value := 'T';
    IsHcjs := False;
    //ShowState;
    FBz := TStringList.Create;
    FBz.AddStrings(DBMemo1.Lines);
    btnOkClick(nil);
  end
  else
    Exit;

  YdhcPrintForm := TYdhcPrintForm.Create(Application);
  try
    with YdhcPrintForm do
    begin
      qrlSub.Caption  := '��ӡʱ�䣺'+DateTimeToStr(Now)+' '+'֪ͨ�ˣ�'+CZY.CzyXm;
      qrlKrxm.Caption := lblKrxm.Caption;
      qrlLxr.Caption  := lblLxr.Caption;
      qrlLxdh.Caption := lblLxdh.Caption;

      qrlSysj.Caption := tblYdhcD_SYRQ.AsString + ' ' + tblYdhcD_SJDM.AsString+ ' '+ FormatDateTime('hh:nn',tblYdhcD_SYSJ.AsDateTime);
      qrlHcmc.Caption := lblHcmc.Caption;
      qrlHczj.Caption := tblYdhcD_HCZJ.AsString+'Ԫ';
      qrlHcrs.Caption := tblYdhcD_HCRS.AsString;
      qrlZxtrs.Caption:= tblYdhcD_HCRS1.AsString;
      qrlHf.Caption := tblYdhcD_HFSL.AsString+'��('+tblYdhcD_HFJE.AsString+'Ԫ)          '+tblYdhcD_HFBZ.AsString;
      qrlXh.Caption := tblYdhcD_XHSL.AsString+'��('+tblYdhcD_XHJE.AsString+'Ԫ)          '+tblYdhcD_XHBZ.AsString;
      qrlSg.Caption := tblYdhcD_SGSL.AsString+'  ('+tblYdhcD_SGJE.AsString+'Ԫ)          '+tblYdhcD_SGBZ.AsString;
      qrlQt.Caption := tblYdhcD_QTJE.AsString+'Ԫ          '+tblYdhcD_QTBZ.AsString;
      qrlHt.Caption := tblYdhcD_HTSL.AsString+'��          '+tblYdhcD_HTBZ.AsString;

      //qrlBz.Lines.AddStrings(DBMemo1.Lines);
      qrlBz.Lines.AddStrings(FBz);
      YdhcPrint;
    end;
  finally
    YdhcPrintForm.Free;
  end;
  //btnOkClick(nil);
end;

procedure TYdhcForm.DBEdit1Exit(Sender: TObject);
begin
  inherited;
  FSYRQ := tblYdhcD_SYRQ.Value;
end;

procedure TYdhcForm.DBComboBox1Exit(Sender: TObject);
begin
  inherited;
  FSJDM := tblYdhcD_SJDM.Value;
end;

procedure TYdhcForm.DBEdit2Exit(Sender: TObject);
begin
  inherited;
  tblYdhcD_SJDM.Value := GetSjdm1(tblYdhcD_SYSJ.Value);
end;

end.
