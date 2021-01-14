unit C_Ydcysk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C_StdJd, DosMove, StdCtrls, Buttons, ExtCtrls, DB, DBTables,
  Mask, DBCtrls, ComCtrls, C_Define, DateUtils;

type
  TYdcyskForm = class(TStdJdForm)
    tblYdcy: TTable;
    dsYdcy: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBComboBox1: TDBComboBox;
    ListView1: TListView;
    tblCtzt: TTable;
    Label10: TLabel;
    lblKrxm: TLabel;
    Label12: TLabel;
    lblLxr: TLabel;
    btnYdqr: TBitBtn;
    btnYdqx: TBitBtn;
    lblState: TStaticText;
    Label11: TLabel;
    Label13: TLabel;
    RadioGroup1: TRadioGroup;
    Label6: TLabel;
    DBMemo1: TDBMemo;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    edtCtbh: TEdit;
    btnSelect: TBitBtn;
    tblYdcyD_YDBH: TStringField;
    tblYdcyD_CTBH: TStringField;
    tblYdcyD_CTMC: TStringField;
    tblYdcyD_KRBH: TStringField;
    tblYdcyD_KRXM: TStringField;
    tblYdcyD_YDRQ: TDateTimeField;
    tblYdcyD_SYRQ: TDateTimeField;
    tblYdcyD_SYSJ: TDateTimeField;
    tblYdcyD_SJDM: TStringField;
    tblYdcyD_YCBZ: TStringField;
    tblYdcyD_YCLX: TIntegerField;
    tblYdcyD_RS: TIntegerField;
    tblYdcyD_XFSL: TFloatField;
    tblYdcyD_XFJE: TFloatField;
    tblYdcyD_YDBZ: TStringField;
    tblYdcyD_RZBZ: TStringField;
    tblYdcyD_KTBZ: TStringField;
    tblYdcyD_JSBZ: TStringField;
    tblYdcyD_BZ: TBlobField;
    tblYdcyD_CZYXM: TStringField;
    tblYdcyD_DJ: TFloatField;
    btnPrint: TBitBtn;
    Label8: TLabel;
    lblLxdh: TLabel;
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure tblYdcyNewRecord(DataSet: TDataSet);
    procedure btnOKClick(Sender: TObject);
    procedure tblYdcyBeforePost(DataSet: TDataSet);
    procedure btnCancClick(Sender: TObject);
    procedure DBEdit3Exit(Sender: TObject);
    procedure btnYdqrClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnYdqxClick(Sender: TObject);
  private
    { Private declarations }
    FKrbh: string;
    FYdbh: string;
    FYdrq: TDateTime;
    FSyrq: TDateTime;
    FSysj: TDateTime;
    FSjdm: string;
    FXfje: Currency;
    FYcbz: string;
    FRzbz: string;
    FBz  : TStringList;
    IsAppend: Boolean;
    procedure ShowCtbh;
    procedure ShowYdctbh;
    procedure ShowState;
    function  GetCtbh(const s: string): string;
    function  GetCtmc(const s: string): string;
    procedure UpdateCtbh(const ACtbh,ACtmc: string);
    function  IsValid: Boolean;
  public
    { Public declarations }
  end;

var
  YdcyskForm: TYdcyskForm;

procedure YdcyskNew(const AKrbh: string);
procedure YdcyskEdit(const AKrbh,AYdbh: string);

implementation

uses C_HotelData, C_YdcyskPrint;

{$R *.dfm}

//����Ԥ��
procedure YdcyskNew(const AKrbh: string);
begin
  YdcyskForm := TYdcyskForm.Create(Application);
  try
    with YdcyskForm do
    begin
      //��ʼ��
      FKrbh    := AKrbh;
      FYdrq    := Date;
      FSyrq    := Today;
      FSysj    := Time;//EnCodeTime(7,0,0,0);
      FSjdm    := Morning;
      IsAppend := True;
      lblKrxm.Caption := HotelData.FindUserBh('YDXX','D_KRXM','D_KRBH',FKrbh);
      lblLxr.Caption  := HotelData.FindUserBh('YDXX','D_DWMC','D_KRBH',FKrbh);
      lblLxdh.Caption := HotelData.FindUserBh('YDXX','D_LXDH','D_KRBH',FKrbh);
      //��ʾ�������
      ShowCtbh;

      try
        tblYdcy.Open;
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

      tblYdcy.Insert;

      //��ʾԤ��״̬
      ShowState;

      ShowModal;
    end;
  finally
    YdcyskForm.tblYdcy.Close;
    YdcyskForm.Free;
  end;
end;

//�༭
procedure YdcyskEdit(const AKrbh,AYdbh: string);
begin
  YdcyskForm := TYdcyskForm.Create(Application);
  try
    with YdcyskForm do
    begin
      //��ʼ��
      FKrbh    := AKrbh;
      FYdrq    := Date;
      FSyrq    := Date;
      FSysj    := Time;
      FSjdm    := Morning;
      FYdbh    := AYdbh;
      IsAppend := False;
      lblKrxm.Caption := HotelData.FindUserBh('YDXX','D_KRXM','D_KRBH',FKrbh);
      lblLXr.Caption  := HotelData.FindUserBh('YDXX','D_DWMC','D_KRBH',FKrbh);
      lblLxdh.Caption := HotelData.FindUserBh('YDXX','D_LXDH','D_KRBH',FKrbh);

      ShowCtbh;

      try
        tblYdcy.Open;
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

      tblYdcy.Filter   := 'D_YDBH='''+AYdbh+'''';
      tblYdcy.Filtered := True;

      //��ʾ�Ѿ�Ԥ���Ĳ���
      ShowYdctbh;

      //��λ���ܵ�
      if tblYdcy.FindKey([AYdbh,'0']) then
        tblYdcy.Edit;

      ShowState;

      //���ͱ�׼
      RadioGroup1.ItemIndex := tblYdcyD_YCLX.Value;
      RadioGroup1Click(nil);

      ShowModal;
    end;
  finally
    YdcyskForm.tblYdcy.Filter   := '';
    YdcyskForm.tblYdcy.Filtered := False;
    YdcyskForm.tblYdcy.Close;
    YdcyskForm.Free;
  end;
end;

//��ʾԤ��״̬
procedure TYdcyskForm.ShowState;
begin
  if tblYdcyD_RZBZ.AsBoolean then
  begin
    lblState.Caption    := '��ȷ��';
    lblState.Font.Color := clGreen;
    FRzbz := 'T';
  end
  else
  begin
    lblState.Caption    := 'δȷ��';
    lblState.Font.Color := clYellow;
    FRzbz := 'F';
  end;

  btnYdqr.Enabled := not tblYdcyD_RZBZ.AsBoolean;
  //btnYdqx.Enabled := btnYdqr.Enabled;
end;


//��ʾ�Ѿ�Ԥ���Ĳ���
procedure TYdcyskForm.ShowYdctbh;
var
  i: Integer;
begin
  tblYdcy.First;
  while not tblYdcy.Eof do
  begin
    for i:=0 to ListView1.Items.Count - 1 do
      if GetCtbh(ListView1.Items[i].Caption)=tblYdcyD_CTBH.Value then
        ListView1.Items[i].Checked := True;
    tblYdcy.Next;
  end;
end;

//��ʾ�������
procedure TYdcyskForm.ShowCtbh;
var
  ListItem: TListItem;
  aCtmc : string;
begin
  try
    try
      tblCtzt.Open;
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

    ListView1.Items.BeginUpdate;
    ListView1.Items.Clear;

    tblCtzt.First;
    while not tblCtzt.Eof do
    begin
      //edit by ls .20021210
      aCtmc := tblCtzt.FieldbyName('D_CTMC').AsString;
      if (Copy(tblCtzt.FieldByName('D_CTMC').AsString,1,6)='�Ǻ���') then
      begin
         aCtmc := '�Ǻ���';
         if tblCtzt.FieldByName('D_CTMC').AsString > '�Ǻ���01' then
         begin
           tblCtzt.Next;
           Continue;
         end;
      end else
      if (Copy(tblCtzt.FieldByName('D_CTMC').AsString,1,6)='������') then
      begin
         aCtmc := '������';
         if tblCtzt.FieldByName('D_CTMC').AsString > '������01' then
         begin
           tblCtzt.Next;
           Continue;
         end;
      end else
      if (Copy(tblCtzt.FieldByName('D_CTMC').AsString,1,6)='ǧ����') then
      begin
         aCtmc := 'ǧ����';
         if tblCtzt.FieldByName('D_CTMC').AsString > 'ǧ����01' then
         begin
           tblCtzt.Next;
           Continue;
         end;
      end;

      ListItem := ListView1.Items.Add;
      //ListItem.Caption := tblCtzt.FieldByName('D_CTBH').AsString
        //                  +'|'+tblCtzt.FieldByName('D_CTMC').AsString;
      ListItem.Caption := tblCtzt.FieldByName('D_CTBH').AsString
                          +'|'+aCtmc;

      tblCtzt.Next;
    end;

  finally
    tblCtzt.Close;
    ListView1.Items.EndUpdate;
  end;
end;

procedure TYdcyskForm.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  inherited;
  if Selected then
    Item.Checked := True;
end;

procedure TYdcyskForm.tblYdcyNewRecord(DataSet: TDataSet);
begin
  inherited;
  tblYdcyD_KRBH.Value := FKrbh;
  tblYdcyD_YDRQ.Value := FYdrq;
  tblYdcyD_SYRQ.Value := FSyrq;
  tblYdcyD_SYSJ.Value := FSysj;
  tblYdcyD_SJDM.Value := FSjdm;
  tblYdcyD_JSBZ.Value := JS_NO;
  tblYdcyD_YDBZ.Value := YDCY_SK;
  tblYdcyD_XFSL.Value := 1;
  tblYdcyD_KRXM.Value := lblKrxm.Caption;
  tblYdcyD_CZYXM.Value:= CZY.CzyXm;
end;

//��ȡ�������
function TYdcyskForm.GetCtbh(const s: string): string;
var
  p: Integer;
begin
  p := Pos('|',s);
  Result := Copy(s,1,p-1);
end;

//��ȡ��������
function TYdcyskForm.GetCtmc(const s: string): string;
var
  p: Integer;
begin
  p := Pos('|',s);
  Result := Copy(s,p+1,Length(s));
end;

//����Ԥ������
procedure TYdcyskForm.UpdateCtbh(const ACtbh,ACtmc: string);
begin
  //�����ɾ��
  //if not tblYdcy.FindKey([FYdbh,ACtbh]) then
    //tblYdcy.Delete
  //else
  //begin
    tblYdcy.Insert;
    tblYdcyD_YDBH.Value := FYdbh;
    tblYdcyD_CTBH.Value := ACtbh;
    tblYdcyD_CTMC.Value := ACtmc;
    //tblYdcyD_XFJE.Value := FXfje;
    tblYdcyD_YCBZ.Value := FYcbz;
    tblYdcyD_RZBZ.Value := FRzbz;
    tblYdcy.Post;
  //end;
end;

//�ж��òͱ�׼����Ч��
function TYdcyskForm.IsValid: Boolean;
begin
  Result              := False;
  tblYdcyD_YCLX.Value := RadioGroup1.ItemIndex;

  case RadioGroup1.ItemIndex of
    0:
    begin
      {if (tblYdcyD_XFSL.IsNull)
       or(tblYdcyD_DJ.IsNull)
       or(tblYdcyD_XFSL.Value<=0)
       or(tblYdcyD_DJ.Value<=0) then}
      if (tblYdcyD_XFSL.IsNull)
       or(tblYdcyD_XFSL.Value<=0) then
      begin
        ShowWarning('�������òͱ�׼��');
        Exit;
      end;
      if tblYdcyD_DJ.IsNull then
        tblYdcyD_DJ.Value := 0;
      tblYdcyD_XFJE.Value := tblYdcyD_DJ.Value*tblYdcyD_XFSL.Value;
      if tblYdcyD_XFJE.Value <> 0 then
        tblYdcyD_YCBZ.Value := tblYdcyD_XFSL.AsString+' �� �� '+tblYdcyD_DJ.AsString+' Ԫ'
      else
        tblYdcyD_YCBZ.Value := tblYdcyD_XFSL.AsString+' ��';
      Result              := True;
    end;
    1:
    begin

      {if (tblYdcyD_XFSL.IsNull)
       or(tblYdcyD_DJ.IsNull)
       or(tblYdcyD_XFSL.Value<=0)
       or(tblYdcyD_DJ.Value<=0) then}
      if (tblYdcyD_XFSL.IsNull)
       or(tblYdcyD_XFSL.Value<=0) then
      begin
        ShowWarning('�������òͱ�׼��');
        Exit;
      end;
      if tblYdcyD_DJ.IsNull then
        tblYdcyD_DJ.Value := 0;
      tblYdcyD_XFJE.Value := tblYdcyD_XFSL.Value*tblYdcyD_DJ.Value;
      if tblYdcyD_XFJE.Value<>0 then
        tblYdcyD_YCBZ.Value := tblYdcyD_XFSL.AsString +'�� �� '+tblYDcyD_DJ.AsString+' Ԫ'
      else
        tblYdcyD_YCBZ.Value := tblYdcyD_XFSL.AsString +'��';
      Result              := True;
    end;
    2:
    begin
      if (tblYdcyD_XFSL.IsNull)or(tblYdcyD_XFSL.Value<=0) then
      begin
        ShowWarning('�������òͱ�׼��');
        Exit;
      end;
      tblYdcyD_DJ.Value   := 0;
      tblYdcyD_XFJE.Value := 0;
      tblYdcyD_YCBZ.Value := tblYdcyD_XFSL.AsString+' �� �� ���';
      Result              := True;
    end;
  end;
end;

//ȷ��
procedure TYdcyskForm.btnOKClick(Sender: TObject);
var
  ACtbh,ACtmc,s: string;
  i            : Integer;
  //CanPost      : Boolean;
begin
  inherited;

  if not HotelData.CheckYgqx(CZY.CzyBh,'Ԥ���޸�') then Exit;

  //CanPost := False;

  //���
  if not IsValid then Exit;

  //����ӵ�
  //s := 'select * from YDCY where (D_YDBH="'+FYdbh+'")and(D_CTBH<>"0")';
  s := 'delete from YDCY where (D_YDBH="'+FYdbh+'")and(D_KRBH="'+FKrbh+'")and(D_CTBH<>"0")';
  HotelData.EmptyData(s);

  //�ж���Ч��
  for i:=0 to ListView1.Items.Count - 1 do
  begin
    if ListView1.Items[i].Checked then
    begin
      //CanPost := True;//�в�����ѡ��
      ACtbh   := GetCtbh(ListView1.Items[i].Caption);
      ACtmc   := GetCtmc(ListView1.Items[i].Caption);

      //�ж��Ƿ�Ԥ��
      if not HotelData.IsValidCyyd(ACtbh,tblYdcyD_SJDM.Value,tblYdcyD_SYRQ.Value) then
      begin
        ShowWarning('�ò���̨���Ѿ���Ԥ����');
        Exit;
      end;
    end;
  end;

  {//���û��ѡ�����
  if not CanPost then
  begin
    ShowWarning('��ѡ�����̨�ţ�');
    Exit;
  end;
  }

  tblYdcyD_CTBH.Value := '0';
  tblYdcyD_CTMC.Value := '0';

  FXfje := tblYdcyD_XFJE.Value;
  FYcbz := tblYdcyD_YCBZ.Value;
  FYdrq := tblYdcyD_YDRQ.Value;
  FSyrq := tblYdcyD_SYRQ.Value;
  FSysj := tblYdcyD_SYSJ.Value;
  FSjdm := tblYdcyD_SJDM.Value;
  //FRzbz := tblYdcyD_RZBZ.Value;

  HotelData.DatabaseUser.StartTransaction;
  try
    //�����ܵ�
    tblYdcy.Post;


    //��������ӵ�
    IsAppend := False;
    for i:=0 to ListView1.Items.Count - 1 do
    begin
      if ListView1.Items[i].Checked then
      begin
        ACtbh := GetCtbh(ListView1.Items[i].Caption);
        ACtmc := GetCtmc(ListView1.Items[i].Caption);
        UpdateCtbh(ACtbh,ACtmc);
      end;
    end;

    HotelData.DatabaseUser.Commit;
  except
    HotelData.DatabaseUser.Rollback;
    raise;
  end;

  Close;
end;

procedure TYdcyskForm.tblYdcyBeforePost(DataSet: TDataSet);
begin
  inherited;
  if IsAppend then
  begin
    FYdbh := HotelData.GetBh('D_YDBH',PREV_YDBH);
    tblYdcyD_YDBH.Value := FYdbh;
  end;
end;

procedure TYdcyskForm.btnCancClick(Sender: TObject);
begin
  inherited;
  tblYdcy.Cancel;
end;

procedure TYdcyskForm.DBEdit3Exit(Sender: TObject);
begin
  inherited;
  tblYdcyD_SJDM.Value := GetSjdm(tblYdcyD_SYSJ.Value);
end;

procedure TYdcyskForm.btnYdqrClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'Ԥ��ȷ��') then Exit;
  if Confirm('��ȷ�ϸò�����Ԥ����') then
  begin
    tblYdcyD_RZBZ.Value := 'T';
    //ShowState;
    FRzbz := 'T';
    btnOkClick(nil);
  end;
end;

procedure TYdcyskForm.RadioGroup1Click(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  i := RadioGroup1.ItemIndex;
  case i of
    0:
    begin
      DBEdit6.Visible := True;
      Label13.Visible := True;
      Label11.Caption := '��';
    end;
    1:
    begin
      DBEdit6.Visible := True;
      Label13.Visible := True;
      Label11.Caption := '��';
    end;
    2:
    begin
      DBEdit6.Visible := False;
      Label13.Visible := False;
      Label11.Caption := '��';
    end;
  end;
{  DBEdit4.Visible := (i=0)and(i<>2);
  Label5.Visible  := (i=0)and(i<>2);
  DBEdit5.Visible := (i=1)and(i<>2);
  DBEdit6.Visible := (i=1)and(i<>2);
  Label11.Visible := (i=1)and(i<>2);
  Label13.Visible := (i=1)and(i<>2);}
end;

//�ֹ�¼�����
procedure TYdcyskForm.btnSelectClick(Sender: TObject);
var
  s,ACtbh: string;
  i,j,Len: Integer;
begin
  inherited;
  s   := edtCtbh.Text;
  Len := Length(s);

  while (Len>0) do
  begin
    i := Pos(' ',s);

    if i=0 then Break;

    ACtbh := Copy(s,1,i-1);

    for j:=0 to ListView1.Items.Count - 1 do
      if GetCtbh(ListView1.Items[j].Caption)=ACtbh then
      begin
        ListView1.Items[j].Checked := True;
        Break;
      end;

    s   := Copy(s,i+1,Len-i);
    Len := Len - i;
  end;
end;

procedure TYdcyskForm.btnPrintClick(Sender: TObject);
var
  i : Integer;
  ACtmc : string;
begin
  if not HotelData.CheckYgqx(CZY.CzyBh,'Ԥ��ȷ��') then Exit;
  if Confirm('��ȷ�ϸò�����Ԥ����') then
  begin
    tblYdcyD_RZBZ.Value := 'T';
    FRzbz := 'T';
    //ShowState;
    FBz := TStringList.Create;
    FBz.AddStrings(DBMemo1.Lines);
    btnOkClick(nil);
  end
  else
    Exit;

  YdcyskPrintForm := TYdcyskPrintForm.Create(Application);
  try
    with YdcyskPrintForm do
    begin
      qrlSub.Caption  := '��ӡʱ�䣺'+DateTimeToStr(Now)+' '+'֪ͨ�ˣ�'+CZY.CzyXm;
      qrlKrxm.Caption := lblKrxm.Caption;
      qrlLxr.Caption  := lblLxr.Caption;
      qrlLxdh.Caption := lblLxdh.Caption;
      qrlYcsj.Caption := tblYdcyD_SYRQ.AsString + ' '
                       + tblYdcyD_SJDM.AsString + FormatDateTime('hh:nn',tblYdcyD_SYSJ.AsDateTime);
      qrlYcbz.Caption := tblYdcyD_YCBZ.Value;
      ACtmc := '';
      for i:=0 to ListView1.Items.Count - 1 do
        if ListView1.Items[i].Checked then
          ACtmc := ACtmc + GetCtmc(ListView1.Items[i].Caption)+' ';
      qrlCtmc.Caption := ACtmc;
      //qrlBz.DataSet := tblYdcy;
      //qrlBz.DataField := 'D_BZ';
      //qrlBz.Lines.AddStrings(DBMemo1.Lines);
      qrlBz.Lines.AddStrings(FBz);
      QRLabel14.Caption := qrlSub.Caption;
      QRLabel15.Caption := qrlKrxm.Caption;
      QRLabel16.Caption := qrlLxr.Caption;
      QRLabel23.Caption := qrlLxdh.Caption;
      QRLabel17.Caption := qrlYcsj.Caption;
      QRLabel19.Caption := qrlYcbz.Caption;
      QRLabel20.Caption := qrlCtmc.Caption;
      QRMemo1.Lines.AddStrings(FBz);
      //QRMemo1.Lines := qrlBz.Lines;

      YdcyskPrint;
    end;
  finally
    YdcyskPrintForm.Free;
  end;

  //btnOkClick(nil);
end;

procedure TYdcyskForm.btnYdqxClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'Ԥ��ȷ��') then Exit;
  if Confirm('��ȡ���ò�����ȷ����') then
  begin
    tblYdcyD_RZBZ.Value := 'F';
    ShowState;
    //btnOkClick(nil);
  end;
end;

end.
