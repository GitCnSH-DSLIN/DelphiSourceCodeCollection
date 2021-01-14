{�����Ƶ����ϵͳ v1.0
 Copyright by CubicSoft
 program by ls.
 Date:20020301-20020601
 20020627 ����ע��
}
unit C_Zd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C_StdJd, DosMove, StdCtrls, Buttons, ExtCtrls, C_Define, Grids,
  DBGrids, DBTables, DB;

type
  TZdForm = class(TStdJdForm)
    Label1: TLabel;
    lblXfje: TLabel;
    Label3: TLabel;
    lblJsje: TLabel;
    Label5: TLabel;
    lblYjje: TLabel;
    Label7: TLabel;
    lblTfje: TLabel;
    Label9: TLabel;
    lblYfje: TLabel;
    Label11: TLabel;
    lblYhje: TLabel;
    dbgZd: TDBGrid;
    qryZd: TQuery;
    dsKrjz: TDataSource;
    Label2: TLabel;
    edtSjje: TEdit;
    tblKrjz: TTable;
    tblKrjzD_XFXM: TStringField;
    Label4: TLabel;
    lblJzfs: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    lblJzrq: TLabel;
    lblJzsj: TLabel;
    Label6: TLabel;
    Bevel2: TBevel;
    qryKrzd: TQuery;
    qryGz: TQuery;
    tblKryj: TTable;
    tblYsk: TTable;
    btnPrint: TBitBtn;
    lblJzfh: TLabel;
    tblKrjzD_JZBH: TStringField;
    tblKrjzD_HH: TIntegerField;
    tblKrjzD_XMBH: TStringField;
    tblKrjzD_XFDJ: TFloatField;
    tblKrjzD_XFSL: TFloatField;
    tblKrjzD_XFGG: TStringField;
    tblKrjzD_XFJE: TFloatField;
    tblKrjzD_YJJE: TFloatField;
    tblKrjzD_YHJE: TFloatField;
    tblKrjzD_JZFS: TStringField;
    tblKrjzD_JZLX: TStringField;
    tblKrjzD_KHBH: TStringField;
    tblKrjzD_XYKBH: TStringField;
    tblKrjzD_JZRQ: TDateTimeField;
    tblKrjzD_JZSJ: TDateTimeField;
    tblKrjzD_CZYXM: TStringField;
    tblKrjzD_BZ: TStringField;
    tblKrjzD_YSRQ: TStringField;
    qryKrzdD_ZDBH: TStringField;
    qryKrzdD_HH: TIntegerField;
    qryKrzdD_ZDLB: TStringField;
    qryKrzdD_KRBH: TStringField;
    qryKrzdD_YJBH: TStringField;
    qryKrzdD_KFBH: TStringField;
    qryKrzdD_SJFJ: TFloatField;
    qryKrzdD_XMBH: TStringField;
    qryKrzdD_XFDJ: TFloatField;
    qryKrzdD_XFSL: TFloatField;
    qryKrzdD_XFJE: TFloatField;
    qryKrzdD_XFRQ: TDateTimeField;
    qryKrzdD_XFSJ: TDateTimeField;
    qryKrzdD_YHJE: TFloatField;
    qryKrzdD_JZRQ: TDateTimeField;
    qryKrzdD_JZSJ: TDateTimeField;
    qryKrzdD_JZBZ: TStringField;
    qryKrzdD_JSBZ: TStringField;
    qryKrzdD_DLR1: TStringField;
    qryKrzdD_DLR2: TStringField;
    qryKrzdD_DLR3: TStringField;
    qryKrzdD_DLR4: TStringField;
    qryKrzdD_CZYXM: TStringField;
    qryKrzdD_JZYXM: TStringField;
    qryKrzdD_TYR: TStringField;
    qryKrzdD_BZ: TStringField;
    qryKrzdD_YSRQ: TStringField;
    qryKrzdD_JZBH: TStringField;
    tblKrjzD_BMBH: TStringField;
    qryKrzdD_BMBH: TStringField;
    qryYsk: TQuery;
    procedure tblKrjzNewRecord(DataSet: TDataSet);
    procedure tblKrjzAfterPost(DataSet: TDataSet);
    procedure tblKrjzBeforeInsert(DataSet: TDataSet);
    procedure tblKrjzBeforeDelete(DataSet: TDataSet);
    procedure tblKrjzD_YHJEValidate(Sender: TField);
    procedure btnCancClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtSjjeExit(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
  private
    { Private declarations }
    FBmbh: string;
    FJzxx: TJZXX;
    FKfxx: TKfxxArray;
    FGzxx: TKFXX;
    FItemNo: Integer;
    FYfje: Currency;
    FXfje: Currency;
    FYjje: Currency;
    FYhje: Currency;
    FJsje: Currency;
    FTfje: Currency;
    FSjje: Currency;
    FDtfj: Currency;
    FDhf : Currency;
    FEwf : Currency;
    FJzbh: string;
    FHh: Integer;
    IsAppend: Boolean;
    FJzfhs: string;
    procedure GetKfxx;
    procedure GetKfxxWjz;
    procedure ShowJzxx;
    procedure UpdateKrzd(const ABz: string);
    procedure UpdateKfzt;
    procedure UpdateKrxx;
    procedure UpdateEwf;
    procedure UpdateBqj;
    procedure AddKrzd(AHh: Integer;const AXmbh: string;AXfje: Currency;AKfxx: TKFXX);
    procedure AddKrjz;
    procedure UpdateKrjz;
    procedure AddDtfj;
    procedure AddDhf;
    procedure AddEwf;
    procedure ShowJzfs;
    function SumYfje: Currency;
    function SumXfje: Currency;
    function SumYjje: Currency;
    function SumDtfj: Currency;
    function SumDhf : Currency;
    function SumEwf : Currency;
    procedure GetGzxx;
    procedure SumYhje;
    procedure BakKrxx;
    procedure BakKrzd;
    procedure EmptyKrxx;
    procedure EmptyKryj;
    procedure EmptyKrzd;
    procedure UpdateGz;
    procedure UpdateYsk;
    procedure CanYh;
    procedure AddYjk(AGbkJzxx: TGbkJzxx);
    procedure AddYsk(const AKhbh,AZdbh,AXmbh: string;AHh: Integer;AXfje: Currency);
    procedure UpdateXxdc;
  public
    { Public declarations }
  end;

var
  ZdForm: TZdForm;

procedure Zd(AJzxx: TJZXX);
procedure WjzZd(AJzxx: TJZXX);

implementation

uses C_HotelData, C_Sysprint, C_CardXf, C_Zdcx;

{$R *.dfm}

//ɢ�ͽ����ʵ�
procedure Zd(AJzxx: TJZXX);
begin
  ZdForm := TZdForm.Create(Application);
  try
    with ZdForm do
    begin
      //��ȡ���ű��
      FBmbh := HotelData.FindBh('YGDA','D_BMBH','D_YGBH',CZY.CzyBh);

      //��ȡ������Ϣ
      FJzxx := AJzxx;
      //�Ƿ����Ż�
      CanYh;
      //��ȡ�ͷ���Ϣ
      GetKfxx;
      //��ʾ���ʷ�ʽ
      ShowJzfs;
      //���㵱�췿��
      FDtfj := SumDtfj;
      //����绰��
      FDhf  := SumDhf;
      //����Ѻ����
      FYfje := SumYfje;
      //�����ѽ���
      FYjje := SumYjje;
      //�������ѽ��
      FXfje := SumXfje;
      if (FDtfj<>0)or(FDhf<>0) then
        FXfje := FXfje + FDtfj + FDhf;
      //��ʾ������Ϣ
      ShowJzxx;
      //��ʾ�ʵ�
      AddKrjz;
      ShowModal;
    end;
  finally
    ZdForm.Free;
  end;
end;

//δ���ʽ���
procedure WjzZd(AJzxx: TJZXX);
begin
  ZdForm := TZdForm.Create(Application);
  try
    with ZdForm do
    begin
      FBmbh := HotelData.FindBh('YGDA','D_BMBH','D_YGBH',CZY.CzyBh);

      FJzxx := AJzxx;
      //�Ƿ����Ż�
      CanYh;
      //��ȡ�ͷ���Ϣ
      GetKfxxWjz;
      //��ʾ���ʷ�ʽ
      ShowJzfs;
      FJzfhs := FJzxx.AKfbh;
      lblJzfh.Caption := '���ʷ��ţ�' + FJzfhs;
      //���㵱�췿��
      FDtfj := 0;
      //����绰��
      FDhf  := 0;
      //����Ѻ����
      FYfje := SumYfje;
      //�����ѽ���
      FYjje := SumYjje;
      //�������ѽ��
      FXfje := SumXfje;
      {if (FDtfj<>0)or(FDhf<>0) then
        FXfje := FXfje + FDtfj + FDhf;}
      //��ʾ������Ϣ
      ShowJzxx;
      //��ʾ�ʵ�
      AddKrjz;
      ShowModal;
    end;
  finally
    ZdForm.Free;
  end;
end;

//�ж��Ƿ��ܹ��Ż� ֻ������ҡ����ÿ���֧Ʊ�ſ����Ż�
procedure TZdForm.CanYh;
begin
  dbgZd.Columns[2].ReadOnly := not((FJzxx.AJzfs=JZFS_RMB)
                                 or(FJzxx.AJzfs= JZFS_ZP)
                                 or(FJzxx.AJzfs=JZFS_XYK));
end;

//��ÿͷ���Ϣ
procedure TZdForm.GetKfxx;
var
  I: Integer;
begin
  FItemNo := High(FJzxx.AJzfh);
  SetLength(FKfxx,FItemNo+1);
  for I:=0 to FItemNo do
    FKfxx[i] := HotelData.GetKfxx(FJzxx.AJzfh[i]);
end;

//���δ���ʿͷ���Ϣ
procedure TZdForm.GetKfxxWjz;
begin
  FItemNo := 0;
  SetLength(FKfxx,FItemNo+1);
  FKfxx[0].AKfbh := FJzxx.AKfbh;
  FKfxx[0].AKrxm := FJzxx.AKfbh;
  FKfxx[0].AZdbh := FJzxx.AJzfh[0];
  FKfxx[0].AKrbh := FJzxx.AKrbh;
  FKfxx[0].AYjbh := FJzxx.AYjbh;
  FKfxx[0].ADtfj := 0;
  FKfxx[0].ADhf  := 0;
  FKfxx[0].AZdhh := 9999;//?
end;

//��ʾ���ʷ�ʽ
procedure TZdForm.ShowJzfs;
var
  I : Integer;
begin
  FJzfhs := '';
  for i := 0 to FItemNo do
    FJzfhs := FJzfhs + FJzxx.AJzfh[i] + ' ';
  lblJzfh.Caption := '���ʷ��� ' + FJzfhs;
  //edit by ls. 2002/09/02
  if FJzxx.AJzfs = JZFS_JZ then
    lblJzfs.Caption := FJzxx.AJzfs+'��'+FJzxx.AKhbh+'��'
  else if FJzxx.AJzfs = JZFS_XYK then
    lblJzfs.Caption := FJzxx.AJzfs+'��'+HotelData.FindMc('XYK','D_XYKBH','D_XYKMC',FJzxx.AXykbh)+'��'
  else if FJzxx.AJzfs = JZFS_GSK then
    lblJzfs.Caption := FJzxx.AJzfs+'��'+FJzxx.AKfbh+'��'
  else if FJzxx.AJzfs = JZFS_GTD then
    lblJzfs.Caption := FJzxx.AJzfs+'��'+HotelData.FindMc('KRXX','D_KRBH','D_KRXM',FJzxx.AKrbh)+'��'
  else
    lblJzfs.Caption := FJzxx.AJzfs;
  lblJzrq.Caption := FormatDateTime('yyyy-mm-dd',FJzxx.AJzrq);
  lblJzsj.Caption := FormatDateTime('hh:mm',FJzxx.AJzsj);
end;

//��ö����
function TZdForm.SumEwf: Currency;
begin
  Result := FSjje-FJsje;
end;

//��õ绰��
function TZdForm.SumDhf: Currency;
var
  I: Integer;
begin
  Result := 0;
  for I:=0 to FItemNo do
  begin
    FKfxx[i].ADhf := HotelData.GetDhf(FKfxx[i].AKfbh,FKfxx[i].ADdrq,FKfxx[i].ADdsj);
    Result := Result + FKfxx[i].ADhf;
  end;
end;

//���°�ȫ��
procedure TZdForm.UpdateBqj;
var
 i: Integer;
begin
  for i:=0 to FItemNo do
  if FKfxx[i].ABqj<>BQJ_ZC then
    HotelData.UpdateBqj(FKfxx[i].AKfbh,FKfxx[i].ABqj,0,FKfxx[i].ADtfj)
  else
    HotelData.UpdateBqj(FKfxx[i].AKfbh,FKfxx[i].ABqj,0,0);
end;
//��õ��췿��
function TZdForm.SumDtfj: Currency;
var
  I,ABqj: Integer;
begin
  Result := 0;
  for I:=0 to FItemNo do
  begin
    FKfxx[i].ADtfj := GetDtfj(FKfxx[i].ADdsj,FJzxx.AJzsj,FKfxx[i].AKfbz,FKfxx[i].ASjfj);
    ABqj           := CheckLdsj(FKfxx[i].ADdsj,FJzxx.AJzsj,FKfxx[i].AKfbz);
    FKfxx[i].ABqj  := ABqj;

    {if ABqj<>BQJ_ZC then
      HotelData.UpdateBqj(FKfxx[i].AKfbh,ABqj,0,FKfxx[i].ADtfj)
    else
      HotelData.UpdateBqj(FKfxx[i].AKfbh,ABqj,0,0);}
    Result := Result + FKfxx[i].ADtfj;
  end;
end;

//�ۼ��Żݽ��
procedure TZdForm.SumYhje;
var
  PrevRecord: TBookMark;
begin
  PrevRecord := tblKrjz.GetBookmark;
  try
    tblKrjz.DisableControls;
    FYhje := 0;
    tblKrjz.First;
    while not tblKrjz.Eof do
    begin
      FYhje := FYhje + tblKrjzD_YHJE.Value;
      tblKrjz.Next;
    end;
  finally
    tblKrjz.EnableControls;
    if PrevRecord<>nil then
    begin
      tblKrjz.GotoBookmark(PrevRecord);
      tblKrjz.FreeBookmark(PrevRecord);
    end;
    ShowJzxx;
  end;
end;

//���Ԥ�����
function TZdForm.SumYfje: Currency;
var
  I: Integer;
  SqlStr: string;
begin
  SqlStr := '';

  for I:= 0 to FItemNo do
  begin
    if I>0 then SqlStr := SqlStr + 'or';
    SqlStr := SqlStr + '(D_YJBH="'+FKfxx[i].AYjbh+'")';
  end;

  SqlStr := 'select sum(D_YFJE) from KRYJ where (D_FKFS="'
            +FKFS_RMB+'")and('+SqlStr+')';
  Result := HotelData.SumJe(SqlStr);
end;

//����ѽ���
function TZdForm.SumYjje: Currency;
var
  I: Integer;
  SqlStr: string;
begin
  SqlStr := '';
  for I:= 0 to FItemNo do
  begin
    if I>0 then SqlStr := SqlStr + 'or';
    SqlStr := SqlStr + '(D_ZDBH="'+FKfxx[i].AZdbh+'")';
  end;
  //SqlStr := 'select sum(D_XFJE) from KRZD where (D_JZBZ="'
    //        +JZ_YX+'")and('+SqlStr+')';
  SqlStr := 'select sum(D_XFJE) from KRZD where ((D_XMBH="'
            +XMBH_YJK+'")or(D_JZBZ="'+JZ_YX+'"))and('+SqlStr+')';

  Result := 0-HotelData.SumJe(SqlStr);
end;

//������ѽ��
function TZdForm.SumXfje: Currency;
var
  I: Integer;
  SqlStr: string;
begin
  SqlStr := '';
  
  for I:= 0 to FItemNo do
  begin
    if I>0 then SqlStr := SqlStr + 'or';
    SqlStr := SqlStr + '(D_ZDBH="'+FKfxx[i].AZdbh+'")';
  end;

  //edit by ls. 20020729
  {SqlStr := 'select sum(D_XFJE) from KRZD where (D_HH=0)'
            +'and('+SqlStr+')';}
  SqlStr := 'select sum(D_XFJE) from KRZD where (D_HH<>0)and(D_XMBH<>"'+XMBH_YJK+'")'
            +'and(D_JZBZ<>"'+JZ_YX+'")and('+SqlStr+')';

  Result := HotelData.SumJe(SqlStr);
end;

//������Ϣ����
procedure TZdForm.UpdateXxdc;
var
  I: Integer;
begin
  try
    try
      HotelData.tblXxdc.Open;
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

    for I:=0 to FItemNo do
    begin
      if HotelData.tblXxdc.FindKey([FKfxx[i].AKrbh]) then
      begin
        HotelData.tblXxdc.Edit;
        HotelData.tblXxdc.FieldByName('D_LDRQ').AsString := FormatDateTime('yyyymmdd',Date);
        HotelData.tblXxdc.Post;
      end;
    end;
  finally
    HotelData.tblXxdc.Close;
  end;
end;

//��ʾ������Ϣ
procedure TZdForm.ShowJzxx;
begin
  FJsje := FXfje-FYjje-FYhje;

  if FJsje>=0 then
    FSjje := Trunc(FJsje+0.99)
  else
    FSjje := Trunc(FJsje-0.99);

  //20020627 edit by ls. �����������ҽ��� �˻�ȫ��Ѻ��  
  if FJzxx.AJzfs = JZFS_RMB then
  begin
    if FYfje>0 then
      FTfje := FYfje-FSjje
    else
      FTfje := 0;
  end
  else
    FTfje := FYfje;

  lblYfje.Caption := FormatFloat('#.##',FYfje);//CurrToStr(FYfje)+'Ԫ';
  lblXfje.Caption := FormatFloat('#.##',FXfje);//CurrToStr(FXfje)+'Ԫ';
  lblYjje.Caption := FormatFloat('#.##',FYjje);//CurrToStr(FYjje)+'Ԫ';
  lblYhje.Caption := FormatFloat('#.##',FYhje);//CurrToStr(FYhje)+'Ԫ';
  lblJsje.Caption := FormatFloat('#.##',FJsje);//CurrToStr(FJsje)+'Ԫ';
  lblTfje.Caption := FormatFloat('#.##',FTfje);//CurrToStr(FTfje)+'Ԫ';
  edtSjje.Text := FormatFloat('#.##',FSjje);//CurrToStr(FSjje);
end;

//���ʿ�����Ӷ����
procedure TZdForm.AddEwf;
begin
  IsAppend := True;
  tblKrjz.Insert;
  tblKrjzD_XMBH.Value := XMBH_EWF;
  tblKrjzD_XFJE.Value := FEwf;
  tblKrjz.Post;
  IsAppend := False;
end;

//���ʿ�����ӵ��췿��
procedure TZdForm.AddDtfj;
begin
  IsAppend := True;
  if tblKrjz.Locate('D_XMBH',XMBH_FJ,[]) then
  begin
    tblKrjz.Edit;
    tblKrjzD_XFJE.Value := tblKrjzD_XFJE.Value + FDtfj;
    tblKrjz.Post;
  end
  else
  begin
    tblKrjz.Insert;
    tblKrjzD_XMBH.Value := XMBH_FJ;
    tblKrjzD_XFJE.Value := FDtfj;
    tblKrjz.Post;
  end;
  IsAppend := False;
end;

//���ʿ�����ӵ绰��
procedure TZdForm.AddDhf;
begin
  IsAppend := True;
  if tblKrjz.Locate('D_XMBH',XMBH_DHF,[]) then
  begin
    tblKrjz.Edit;
    tblKrjzD_XFJE.Value := tblKrjzD_XFJE.Value + FDhf;
    tblKrjz.Post;
  end
  else
  begin
    tblKrjz.Insert;
    tblKrjzD_XMBH.Value := XMBH_DHF;
    tblKrjzD_XFJE.Value := FDhf;
    tblKrjz.Post;
  end;
  IsAppend := False;
end;

//�ʵ�����Ӽ�¼
procedure TZdForm.AddKrzd(AHh: Integer;const AXmbh: string;AXfje: Currency;AKfxx: TKFXX);
begin
  qryKrzd.Insert;
  qryKrzdD_ZDBH.Value := AKfxx.AZdbh;
  qryKrzdD_HH.Value   := AHh;
  qryKrzdD_KRBH.Value := AKfxx.AKrbh;
  qryKrzdD_YJBH.Value := AKfxx.AYjbh;
  qryKrzdD_ZDLB.Value := AKfxx.AZdlb;
  qryKrzdD_XMBH.Value := AXmbh;
  qryKrzdD_XFJE.Value := AXfje;
  qryKrzdD_XFRQ.Value := FJzxx.AJzrq;
  qryKrzdD_XFSJ.Value := FJzxx.AJzsj;
  qryKrzdD_JZBZ.Value := JZ_YES;
  qryKrzdD_JSBZ.Value := JS_YES;
  qryKrzdD_CZYXM.Value:= CZY.CzyXm;
  qryKrzdD_JZYXM.Value:= CZY.CzyXm;
  qryKrzdD_BMBH.Value := FBmbh;
  qryKrzd.Post;
end;

//���¿����ʵ�
procedure TZdForm.UpdateKrzd(const ABz: string);
var
  I,AHh: Integer;
  SqlStr: string;
begin

  SqlStr := '';
  for I:= 0 to FItemNo do
  begin
    if I>0 then SqlStr := SqlStr + 'or';
    SqlStr := SqlStr + '(D_ZDBH="'+FKfxx[i].AZdbh+'")';
  end;
  SqlStr := 'select * from KRZD where '+SqlStr;

  //����
  with qryKrzd do
  begin
    if Active then Active := False;
    SQL.Clear;
    SQL.Add(SqlStr);
    try
      Open;
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
  end;

  //����ʵ����
  for I:=0 to FItemNo do
  begin
    //����к�
    AHh := FKfxx[i].AZdhh;

    //������췿�۲�������
    if FDtfj<>0 then
    begin
      if FKfxx[i].ADtfj<>0 then
      begin
        AddKrzd(AHh,XMBH_FJ,FKfxx[i].ADtfj,FKfxx[i]);
        Inc(AHh);
      end;
    end;

    //����绰�Ѳ�������
    if FDhf<>0 then
    begin
      if FKfxx[i].ADhf<>0 then
      begin
        AddKrzd(AHh,XMBH_DHF,FKfxx[i].ADhf,FKfxx[i]);
        Inc(AHh);
      end;
    end;

    //�������Ѳ������㣬��ӵ���һ���ʵ���
    if (FEwf<>0)and(i=0) then
      AddKrzd(AHh,XMBH_EWF,FEwf,FKfxx[i]);

    //�ۼ��ܵ������ѽ��
    qryKrzd.Filter   := 'D_ZDBH='''+FKfxx[i].AZdbh+'''';
    qryKrzd.Filtered := True;
    if qryKrzd.Locate('D_HH',0,[]) then
    begin
      qryKrzd.Edit;
      qryKrzdD_XFJE.Value := qryKrzdD_XFJE.Value + FDtfj + FDhf + FEwf;
      qryKrzd.Post;
    end;
    qryKrzd.Filter   := '';
    qryKrzd.Filtered := False;
  end;

  //�޸������ʵ�
  qryKrzd.First;
  while not qryKrzd.Eof do
  begin
    qryKrzd.Edit;

    //����/δ����
    if FJzxx.AJzfs<>JZFS_WJZ then
      qryKrzdD_JSBZ.Value := JS_YES
    else
      qryKrzdD_JSBZ.Value := JS_WJ;

    qryKrzdD_JZRQ.Value := FJzxx.AJzrq;
    qryKrzdD_JZSJ.Value := FJzxx.AJzsj;
    qryKrzdD_JZBH.Value := FJzbh;
    //edit by ls. 20020824
    if qryKrzdD_JZBZ.Value = JZ_NO then
      qryKrzdD_JZBZ.Value := JZ_YES;
    //qryKrzdD_JSBZ.Value := JS_YES;
    if qryKrzdD_JZYXM.Value = '' then
      qryKrzdD_JZYXM.Value := CZY.CzyXm;
    qryKrzdD_BZ.Value   := qryKrzdD_BZ.Value+' '+ABz;
    qryKrzdD_BMBH.Value := FBmbh;
    //qryKrzdD_JZYXM.Value:= CZY.CzyXm;
    qryKrzd.Post;
    qryKrzd.Next;
  end;
end;

//������ʿ��ܵ� �к�=0
procedure TZdForm.UpdateKrjz;
begin
  IsAppend := True;
  FHh := 0;
  tblKrjz.Insert;
  //edit by ls.20021020
  tblKrjzD_XFJE.Value := FSjje+FYhje+FYjje;//????????
  tblKrjzD_YJJE.Value := 0-FYjje;
  tblKrjzD_YHJE.Value := FYhje;
  tblKrjz.Post;
  IsAppend := False;
end;

//�г������ʵ�
procedure TZdForm.AddKrjz;
var
  I: Integer;
  SqlStr: string;
begin
  SqlStr := '';

  for I:= 0 to FItemNo do
  begin
    if I>0 then SqlStr := SqlStr + 'or';
    SqlStr := SqlStr + '(D_ZDBH="'+FKfxx[i].AZdbh+'")';
  end;

  SqlStr := 'select D_XMBH,sum(D_XFJE) as XFJE from KRZD where (D_HH<>0)'
            +'and('+SqlStr+') group by D_XMBH';

  //ͳ��������Ŀ
  with qryZd do
  begin
    SQL.Clear;
    SQL.Add(SqlStr);
    try
      Open;
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
  end;

  //��ӵ����ʿ���
  tblKrjz.DisableControls;
  try
    IsAppend := True;
    //��ý��ʱ��
    FJzbh := HotelData.GetBh('D_JZBH',PREV_JZBH);
    //�к�=1
    FHh := 1;

    try
      tblKrjz.Open;
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

    tblKrjz.Filter   := 'D_JZBH='''+FJzbh+'''';
    tblKrjz.Filtered := True;

    qryZd.First;
    while not qryZd.Eof do
    begin
      if qryZd.FieldByName('D_XMBH').AsString<>'' then
      begin
        tblKrjz.Insert;
        tblKrjzD_XMBH.Value := qryZd.FieldByName('D_XMBH').AsString;
        tblKrjzD_XFJE.Value := qryZd.FieldByName('XFJE').AsCurrency;
        tblKrjz.Post;
      end;
      qryZd.Next;
    end;

    //������췿�۲�������
    if FDtfj<>0 then AddDtfj;

    //����绰�Ѳ�������
    if FDhf <>0 then AddDhf;
  finally
    IsAppend := False;
    tblKrjz.First;
    tblKrjz.EnableControls;
  end;
end;

procedure TZdForm.tblKrjzNewRecord(DataSet: TDataSet);
begin
  inherited;
  if IsAppend then
  begin
    tblKrjzD_JZBH.Value := FJzbh;
    tblKrjzD_HH.Value   := FHh;
    tblKrjzD_JZRQ.Value := FJzxx.AJzrq;
    tblKrjzD_JZSJ.Value := FJzxx.AJzsj;
    tblKrjzD_JZFS.Value := FJzxx.AJzfs;
    tblKrjzD_XYKBH.Value:= FJzxx.AXykbh;
    tblKrjzD_KHBH.Value := FJzxx.AKhbh;
    tblKrjzD_JZLX.Value := JZLX_YK;
    tblKrjzD_CZYXM.Value:= CZY.CzyXm;
    tblKrjzD_BMBH.Value := FBmbh;
    tblKrjzD_BZ.Value   := JZBZ_SK+FJzfhs ;
  end;
end;

procedure TZdForm.tblKrjzAfterPost(DataSet: TDataSet);
begin
  inherited;
  if not IsAppend then
    SumYhje
  else
    Inc(FHh);
end;

procedure TZdForm.tblKrjzBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if not IsAppend then
    Abort;
end;

procedure TZdForm.tblKrjzBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  Abort;
end;

//����Żݽ��
procedure TZdForm.tblKrjzD_YHJEValidate(Sender: TField);
begin
  inherited;
  if tblKrjzD_XMBH.Value <> XMBH_YJK then
  begin
    if tblKrjzD_YHJE.AsCurrency>tblKrjzD_XFJE.AsCurrency then
    begin
      //tblKrjzD_YHJE.Value := tblKrjzD_XFJE.Value;
      raise Exception.Create('�Żݽ��ܴ������ѽ�');
    end
  end
  else
  begin
    if tblKrjzD_YHJE.Value <> 0 then
      raise Exception.Create('Ԥ������Żݣ�');
  end;
end;

//ȡ��
procedure TZdForm.btnCancClick(Sender: TObject);
begin
  inherited;
  tblKrjz.CancelUpdates;
end;

//���¿ͷ�״̬ ��ӷ���
procedure TZdForm.UpdateKfzt;
var
  I: Integer;
begin
  for I:=0 to FItemNo do
  begin
    //��ʼ���ͷ�
    HotelData.InitKfzt(FKFxx[i].AKfbh);
    //���¼�ӷ���
    if FKfxx[i].ADtfj<>0 then
      HotelData.UpdateJjfj(FKfxx[i].AKfbh,FKfxx[i].ABqj,FKfxx[i].ADtfj);
  end;
end;

//���¿�����Ϣ���������
procedure TZdForm.UpdateKrxx;
var
  I: Integer;
begin
  for I:=0 to FItemNo do
    HotelData.UpdateKrxxJz(FKfxx[i].AKrbh,FJzxx.AJzrq,FJzxx.AJzsj);
end;

//���ݿ�����Ϣ
procedure TZdForm.BakKrxx;
var
  I: Integer;
begin
  for I:=0 to FItemNo do
    HotelData.BakData('select * from KRXX where D_KRBH="'+FKfxx[i].AKrbh+'"','KRXXDA');
end;

//���ݿ����ʵ�
procedure TZdForm.BakKrzd;
var
  I: Integer;
begin
  for I:=0 to FItemNo do
    HotelData.BakData('select * from KRZD where D_ZDBH="'+FKfxx[i].AZdbh+'"','KRZDDA');
end;

//��տ����ʵ�
procedure TZdForm.EmptyKrzd;
var
  I: Integer;
begin
  for I:=0 to FItemNo do
    //HotelData.EmptyData('select * from KRZD where D_ZDBH="'+FKfxx[i].AZdbh+'"');
    HotelData.EmptyData('delete from KRZD where D_ZDBH="'+FKfxx[i].AZdbh+'"');
end;

//��տ�����Ϣ
procedure TZdForm.EmptyKrxx;
var
  I: Integer;
begin
  for I:=0 to FItemNo do
    HotelData.EmptyData('delete from KRXX where D_KRBH="'+FKfxx[i].AKrbh+'"');
    //HotelData.EmptyData('select * from KRXX where D_KRBH="'+FKfxx[i].AKrbh+'"');
end;

//��տ���Ѻ��
procedure TZdForm.EmptyKryj;
var
  I: Integer;
begin
  //������ʷ�ʽΪ���ʣ�Ѻ���ˣ���Ѻ��ת�����ʶ����� ��������
  if not FJzxx.AYjtf then
  begin
    try
      tblKryj.Open;
      if tblKryj.FindKey([FGzxx.AYjbh,0]) then
        if tblKryj.FieldByName('D_FKFS').AsString=FKFS_RMB then
        begin
          tblKryj.Edit;
          tblKryj.FieldByName('D_YFJE').AsCurrency :=
            tblKryj.FieldByName('D_YFJE').AsCurrency + FYfje;
          tblKryj.Post;
        end;
    finally
      tblKryj.Close;
    end;
  end;
  //���Ѻ����Ϣ
  for I:=0 to FItemNo do
    //HotelData.EmptyData('select * from KRYJ where D_YJBH="'+FKfxx[i].AYjbh+'"');
    HotelData.EmptyData('delete from KRYJ where D_YJBH="'+FKfxx[i].AYjbh+'"');
end;

//���¶����
procedure TZdForm.UpdateEwf;
begin
  //��ö����
  FEwf := SumEwf;

  //����������㣬д����ʿ���
  if FEwf<>0 then
  begin
    //д����ʿ�
    AddEwf;
    //д�����ѿ�
    HotelData.UpdateEwfDbf(FJzbh,FKfxx[0].AKrxm,FEwf,FJzxx.AJzrq,FJzxx.AJzsj);
  end;
end;

//��ȡ������Ϣ
procedure TZdForm.GetGzxx;
var
  aTdxx : TTdxx;
begin
  if FJzxx.AJzfs=JZFS_GSK then
    FGzxx := HotelData.GetKfxx(FJzxx.AKfbh);
  if FJzxx.AJzfs=JZFS_GTD then//edit by ls.2002.12.01
  begin
    aTdxx := HotelData.GetTdxx(FJzxx.AKrbh);
    FGzxx.AZdbh := aTdxx.AZdbh;
    FGzxx.AKrbh := aTdxx.AKrbh;
    FGzxx.AYjbh := aTdxx.AYjbh;
    FGzxx.AZdlb := aTdxx.AZdlb;
    FGzxx.AZdhh := aTdxx.AZdhh;
    //FGzxx := HotelData.GetKfxx(HotelData.GetKfbh(FJzxx.AKrbh));
  end;
end;

//���¹��ʶ�����Ϣ
procedure TZdForm.UpdateGz;
var
  AHh: Integer;
begin
  //��ȡ������Ϣ
  GetGzxx;

  qryGz.Close;
  qryGz.Params[0].Value := FGzxx.AZdbh;
  try
    qryGz.Open;
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

  //����к�
  AHh := FGzxx.AZdhh;

  try
    tblKrjz.DisableControls;
    //���������ϸ
    tblKrjz.First;
    while not tblKrjz.Eof do
    begin
      qryGz.Insert;
      qryGz.FieldByName('D_ZDBH').AsString := FGzxx.AZdbh;
      qryGz.FieldByName('D_HH').AsInteger  := AHh;
      qryGz.FieldByName('D_ZDLB').AsString := FGzxx.AZdlb;
      qryGz.FieldByName('D_KRBH').AsString := FGzxx.AKrbh;
      qryGz.FieldByName('D_YJBH').AsString := FGzxx.AYjbh;
      qryGz.FieldByName('D_XMBH').AsString := tblKrjzD_XMBH.Value;
      qryGz.FieldByName('D_XFJE').AsCurrency := tblKrjzD_XFJE.Value;
      qryGz.FieldByName('D_XFRQ').AsDateTime := FJzxx.AJzrq;
      qryGz.FieldByName('D_XFSJ').AsDateTime := FJzxx.AJzsj;
      qryGz.FieldByName('D_JZBZ').AsString := JZ_NO;
      qryGz.FieldByName('D_JSBZ').AsString := JS_NO;
      qryGz.FieldByName('D_BZ').AsString   := ZDBZ_GZ+FJzfhs;
      qryGz.Post;
      Inc(AHh);
      tblKrjz.Next;
    end;

    //�޸��ܵ�
    if qryGz.Locate('D_HH',0,[]) then
    begin
      qryGz.Edit;
      qryGz.FieldByName('D_XFJE').AsCurrency :=
        qryGz.FieldByName('D_XFJE').AsCurrency + FXfje;
      qryGz.Post;
    end;
  finally
    qryGz.Close;
    tblKrjz.EnableControls;
  end;
end;

//����Ӧ�տ�
procedure TZdForm.UpdateYsk;
var
  i: Integer;
  SqlStr : string;
begin
  try
    try
      tblYsk.Open;
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
  //edit by ls.2002.12.15 ���ʰ���Ŀ����
  SqlStr := '';
  for I:= 0 to FItemNo do
  begin
    if I>0 then SqlStr := SqlStr + 'or';
    SqlStr := SqlStr + '(D_ZDBH="'+FKfxx[i].AZdbh+'")';
  end;
  SqlStr := 'select D_XMBH,sum(D_XFJE) from KRZD where (D_HH<>0) and ('+SqlStr+ ') group by D_XMBH';

  //����
  with qryYsk do
  begin
    Close;
    SQL.Clear;
    SQL.Add(SqlStr);
    try
      Open;
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
  end;

    qryYsk.First;
    i := 1;
    while not qryYsk.Eof do
    begin
        tblYsk.Insert;
        tblYsk.FieldByName('D_KHBH').AsString   := FJzxx.AKhbh;
        tblYsk.FieldByName('D_ZDBH').AsString   := HotelData.GetBh('','');//qryKrzdD_ZDBH.Value;
        tblYsk.FieldByName('D_HH').AsInteger    := i;//qryKrzdD_HH.Value;
        tblYsk.FieldByName('D_XMBH').AsString   := qryYsk.FieldByName('D_XMBH').AsString;//qryKrzdD_XMBH.Value;
        tblYsk.FieldByName('D_XFDJ').AsCurrency := 0;//qryKrzdD_XFDJ.Value;
        tblYsk.FieldByName('D_XFSL').AsFloat    := 0;//qryKrzdD_XFSL.Value;
        tblYsk.FieldByName('D_XFJE').AsCurrency := qryYsk.FieldByName('SUM').AsCurrency;//qryKrzdD_XFJE.Value;
        tblYsk.FieldByName('D_XFRQ').AsDateTime := Date;//qryKrzdD_XFRQ.Value;
        tblYsk.FieldByName('D_XFSJ').AsDateTime := Time;//qryKrzdD_XFSJ.Value;
        tblYsk.FieldByName('D_CZYXM').AsString  := CZY.CzyXm;
        tblYsk.FieldByName('D_BZ').AsString     := ZDBZ_JZ+FJzfhs;//qryKrzdD_BZ.Value;
        tblYsk.Post;

      {if qryKrzdD_HH.Value <> 0 then
      begin
        tblYsk.Insert;
        tblYsk.FieldByName('D_KHBH').AsString   := FJzxx.AKhbh;
        tblYsk.FieldByName('D_ZDBH').AsString   := qryKrzdD_ZDBH.Value;
        tblYsk.FieldByName('D_HH').AsInteger    := qryKrzdD_HH.Value;
        tblYsk.FieldByName('D_XMBH').AsString   := qryKrzdD_XMBH.Value;
        tblYsk.FieldByName('D_XFDJ').AsCurrency := qryKrzdD_XFDJ.Value;
        tblYsk.FieldByName('D_XFSL').AsFloat    := qryKrzdD_XFSL.Value;
        tblYsk.FieldByName('D_XFJE').AsCurrency := qryKrzdD_XFJE.Value;
        tblYsk.FieldByName('D_XFRQ').AsDateTime := Date;//qryKrzdD_XFRQ.Value;
        tblYsk.FieldByName('D_XFSJ').AsDateTime := Time;//qryKrzdD_XFSJ.Value;
        tblYsk.FieldByName('D_CZYXM').AsString  := CZY.CzyXm;
        tblYsk.FieldByName('D_BZ').AsString     := qryKrzdD_BZ.Value;
        tblYsk.Post;
      end;}
      qryYsk.Next;
      Inc(i);
    end;
  finally
    tblYsk.Close;
  end;
end;

procedure TZdForm.AddYsk(const AKhbh,AZdbh,AXmbh: string;AHh: Integer;AXfje: Currency);
begin
  try
    try
      tblYsk.Open;
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

    tblYsk.Insert;
    tblYsk.FieldByName('D_KHBH').AsString   := AKhbh;
    tblYsk.FieldByName('D_ZDBH').AsString   := AZdbh;
    tblYsk.FieldByName('D_HH').AsInteger    := AHh;
    tblYsk.FieldByName('D_XMBH').AsString   := AXmbh;
    //tblYsk.FieldByName('D_XFDJ').AsCurrency := qryKrzdD_XFDJ.Value;
    //tblYsk.FieldByName('D_XFSL').AsFloat    := qryKrzdD_XFSL.Value;
    tblYsk.FieldByName('D_XFJE').AsCurrency := AXfje;
    tblYsk.FieldByName('D_XFRQ').AsDateTime := FJzxx.AJzrq;
    tblYsk.FieldByName('D_XFSJ').AsDateTime := FJzxx.AJzsj;
    tblYsk.FieldByName('D_CZYXM').AsString  := CZY.CzyXm;
    //tblYsk.FieldByName('D_BZ').AsString     := qryKrzdD_BZ.Value;
    tblYsk.Post;

  finally
    tblYsk.Close;
  end;
end;

//���ʿ������Ԥ���� ���������
procedure TZdForm.AddYjk(AGbkJzxx: TGbkJzxx);
var
  AYe,ACe: Currency;
  AXmbh,AZdbh: string;
  AHh: Integer;
begin
  IsAppend := True;

  if (AGbkJzxx.AJzfs=JZFS_RMB)
   or(AGbkJzxx.AJzfs=JZFS_XYK)
   or(AGbkJzxx.AJzfs=JZFS_ZP )  then
  begin
    //��������ʣ�ʣ��Ľ��
    AYe := FSjje - AGbkJzxx.AKcje;
    tblKrjz.First;
    while not tblKrjz.Eof do
    begin
      if AYe = 0 then Break;
      //�������Ԥ����
      if tblKrjzD_XMBH.Value <> XMBH_YJK then
      begin
        //��������ڵ�ǰ���ѽ��޸ĵ�ǰ���ʷ�ʽ
        if AYe >= tblKrjzD_XFJE.Value then
        begin
          tblKrjz.Edit;
          tblKrjzD_JZFS.Value := AGbkJzxx.AJzfs;
          tblKrjzD_XYKBH.Value:= AGbkJzxx.AXykbh;
          AYe := AYe - tblKrjzD_XFJE.Value;
          tblKrjz.Post;
        end
        else //������С�ڵ�ǰ���ѽ��޸ĵ�ǰ���ѽ��Ϊ�����Ӳ��
        begin
          ACe   := tblKrjzD_XFJE.Value - AYe;
          AXmbh := tblKrjzD_XMBH.Value;

          tblKrjz.Edit;
          tblKrjzD_XFJE.Value := AYe;
          tblKrjzD_JZFS.Value := AGbkJzxx.AJzfs;
          tblKrjzD_XYKBH.Value:= AGbkJzxx.AXykbh;
          AYe := AYe - tblKrjzD_XFJE.Value;
          tblKrjz.Post;
          tblKrjz.Insert;
          tblKrjzD_XMBH.Value := AXmbh;
          tblKrjzD_XFJE.Value := ACe;
          tblKrjzD_YJJE.Value := 0;
          tblKrjzD_YHJE.Value := 0;
          tblKrjz.Post;
        end;
      end;
      tblKrjz.Next;
    end;
  end;
  //����Ǽ���
  if (AGbkJzxx.AJzfs = JZFS_JZ) then
  begin
    //��������ʣ�ʣ��Ľ��
    AZdbh := HotelData.GetBh('D_ZDBH',PREV_ZDBH);
    AHh := 0;
    AYe := FSjje - AGbkJzxx.AKcje;
    tblKrjz.First;
    while not tblKrjz.Eof do
    begin
      if AYe = 0 then Break;
      //�������Ԥ����
      if tblKrjzD_XMBH.Value <> XMBH_YJK then
      begin
        //��������ڵ�ǰ���ѽ���ǰ���ѽ�����
        if AYe >= tblKrjzD_XFJE.Value then
        begin
          AYe := AYe - tblKrjzD_XFJE.Value;

          Inc(AHh);

          AddYsk(AGbkJzxx.AKhbh,AZdbh,tblKrjzD_XMBH.Value,AHh,tblKrjzD_XFJE.Value);

          tblKrjz.Delete;
        end
        else //������С�ڵ�ǰ���ѽ��޸ĵ�ǰ���ѽ��Ϊ���,������
        begin
          ACe   := tblKrjzD_XFJE.Value - AYe;
          AXmbh := tblKrjzD_XMBH.Value;

          Inc(AHh);

          AddYsk(AGbkJzxx.AKhbh,AZdbh,tblKrjzD_XMBH.Value,AHh,AYe);

          tblKrjz.Edit;
          tblKrjzD_XFJE.Value := ACe;
          AYe := AYe - tblKrjzD_XFJE.Value;
          tblKrjz.Post;
          tblKrjz.Next;
        end;
      end;
    end;
  end;

  tblKrjz.Insert;
  tblKrjzD_XMBH.Value := XMBH_YJK;
  tblKrjzD_XFJE.Value := 0-AGbkJzxx.AKcje;
  tblKrjzD_YJJE.Value := 0;
  tblKrjzD_YHJE.Value := 0;
  tblKrjz.Post;
  IsAppend := False;
end;

//ȷ�Ͻ���
procedure TZdForm.btnOKClick(Sender: TObject);
var
  AGbkJzxx: TGbkJzxx;
  ASjje : Currency;
begin
  inherited;
  ASjje := StrToCurr(edtSjje.Text);
  if Abs(ASjje-FJsje)<=10 then FSjje := ASjje
  else
  begin
    ShowWarning('ʵ���������С��10Ԫ��');
    edtSjje.SetFocus;
    Exit;
  end;

  if not Confirm('��ȷ�ϸÿ��˵����ѽ�����') then
    Exit;

  try
    tblKrjz.DisableControls;

    tblKrjzD_YHJE.OnValidate := nil;

    //��������
    HotelData.DatabaseUser.StartTransaction;
    try

      //���������
      if (FJzxx.AJzfs=JZFS_GBK) then
      begin
        AGbkJzxx := CardXf(FSjje,True);
        if AGbkJzxx.AKcje = 0 then
          Exit;

        AddYjk(AGbkJzxx);

        //���¶���ѣ�д����ʿ⡢����ѿ���
        UpdateEwf;

        //���¿����ʵ����������췿�ۡ��绰�ѡ�����ѡ�������Ϣ
        UpdateKrzd(JZBZ_SK+JZBZ_GBK+FJzfhs);

        //���ӽ��ʿ��е��ܵ� �к�=0
        UpdateKrjz;

        tblKrjz.ApplyUpdates;
        qryKrzd.ApplyUpdates;

        //���¿ͷ�״̬����ȫ��
        UpdateKfzt;

        //���¿�����Ϣ���������
        UpdateKrxx;

        //���ݿ�����Ϣ
        BakKrxx;

        //��տ�����Ϣ
        EmptyKrxx;

        //��տ���Ѻ��
        EmptyKryj;

        //���ݿ����ʵ�
        BakKrzd;
        //����տ����ʵ���ҹ��������

      end;

      //����ҡ�֧Ʊ�����ÿ�����
      if (FJzxx.AJzfs=JZFS_RMB)
        or(FJzxx.AJzfs=JZFS_ZP)
        or(FJzxx.AJzfs=JZFS_XYK) then
      begin

        //���¶���ѣ�д����ʿ⡢����ѿ���
        UpdateEwf;

        //���¿����ʵ����������췿�ۡ��绰�ѡ�����ѡ�������Ϣ
        UpdateKrzd(JZBZ_SK+FJzxx.AJzfs+FJzfhs);

        //���ӽ��ʿ��е��ܵ� �к�=0
        UpdateKrjz;

        tblKrjz.ApplyUpdates;
        qryKrzd.ApplyUpdates;

        //���¿ͷ�״̬����ȫ��
        UpdateKfzt;

        //���¿�����Ϣ���������
        UpdateKrxx;

        //���ݿ�����Ϣ
        BakKrxx;

        //��տ�����Ϣ
        EmptyKrxx;

        //��տ���Ѻ��
        EmptyKryj;

        //���ݿ����ʵ�
        BakKrzd;
        //����տ����ʵ���ҹ��������

        //EmptyKrzd;
      end;

      //��ɢ�͡����Ŷ�
      if (FJzxx.AJzfs=JZFS_GSK)or(FJzxx.AJzfs=JZFS_GTD) then
      begin
        //���¹��ʶ���
        UpdateGz;

        //���¿ͷ�״̬����ȫ��
        UpdateKfzt;

        //���¿�����Ϣ���������
        UpdateKrxx;

        //���ݿ�����Ϣ
        BakKrxx;

        //��տ�����Ϣ
        EmptyKrxx;

        //��տ���Ѻ��
        EmptyKryj;

        //��տ����ʵ�
        EmptyKrzd;

        //����ʱ��ȡ�����ʿ��еļ�¼
        tblKrjz.CancelUpdates;
      end;
      //δ����
      if (FJzxx.AJzfs=JZFS_WJZ) then
      begin
        UpdateKrzd(JZBZ_WJZ+FJzfhs);
        qryKrzd.ApplyUpdates;
        UpdateKfzt;
        UpdateKrxx;
        tblKrjz.CancelUpdates;
        //BakKrxx;
        //EmptyKrxx;
        //BakKrzd;
        //EmptyKrzd;
      end;
      //�ͻ�����
      if (FJzxx.AJzfs=JZFS_JZ) then
      begin
        UpdateEwf;
        UpdateKrzd(ZDBZ_JZ+HotelData.FindMc('KHDA','D_KHBH','D_KHMC',FJzxx.AKhbh));

        //����Ӧ�տ�
        qryKrzd.ApplyUpdates;
        UpdateYsk;
        UpdateKfzt;
        UpdateKrxx;
        BakKrxx;
        EmptyKrxx;
        EmptyKryj;
        BakKrzd;
        //EmptyKrzd;
        //�ͻ����ˣ�ȡ�����ʿ��еļ�¼
        tblKrjz.CancelUpdates;
      end;
      UpdateBqj;
      UpdateXxdc;

      {if Confirm('�Ƿ��ӡ�ʵ���') then
        btnPrintClick(nil);}

      //�����ύ
      HotelData.DatabaseUser.Commit;
    except
      //����ع�
      HotelData.DatabaseUser.Rollback;
      raise;
    end;
    //�������
    tblKrjz.CancelUpdates;
    tblKrjz.CommitUpdates;

  finally
    tblKrjz.EnableControls;
  end;
  Close;
end;

//�ж�ʵ����
procedure TZdForm.edtSjjeExit(Sender: TObject);
var
  ASjje: Currency;
begin
  inherited;
  ASjje := StrToCurr(edtSjje.Text);
  if Abs(ASjje-FJsje)<=10 then FSjje := ASjje
  else
  begin
    ShowWarning('ʵ���������С��10Ԫ��');
    edtSjje.SetFocus;
  end;
end;

procedure TZdForm.btnPrintClick(Sender: TObject);
var
  APrintStru: TPrintStru;
begin
  APrintStru.ATitle := '�ʵ������ʷ�ʽ��'+lblJzfs.Caption+'��';
  APrintStru.ASub := '���ѽ�'+lblXfje.Caption+' '
                    +'�ѽ��'+lblYjje.Caption+' '
                    +'Ѻ���'+lblYfje.Caption+' '
                    +'�����'+lblJsje.Caption+' '+#13#10
                    +'�˸���'+lblTfje.Caption+' '
                    +'�Żݽ�'+lblYhje.Caption+' '
                    +'ʵ���'+edtSjje.Text+'Ԫ';

  APrintStru.ADataSet := tblKrjz;
  PrintLb(APrintStru,dbgZd);  
end;

end.
