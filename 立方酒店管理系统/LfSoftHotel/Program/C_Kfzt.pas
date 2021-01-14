{�����Ƶ����ϵͳ v1.0
 Copyright by CubicSoft
 program by ls.
 Date:20020301-20020601
 20020627 ����ע��
}
unit C_Kfzt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, C_Stand, DosMove, StdCtrls, Buttons, ExtCtrls, DB, DBTables,
  ComCtrls, ImgList, Grids, DBGrids, TeeProcs, TeEngine, Chart, Series,
  Menus, ToolWin, TFlatHintUnit;

type
  //�ͷ�״̬
  TKfzt = record
    AKfbh: string;
    AKfzt: string;
    AKrbh: string;
    AKrxm: string;
    AZdbh: string;
    AYjbh: string;
    ASjfj: Currency;
    AColor:TColor;
    AImage:Integer;
    AYdbz: string;
    ACjbz: string;
  end;
  //Ԥ���᳡
  TYdhc = record
    AYdbh: string;
    AKrbh: string;
    AKrxm: string;
    ASyrq: TDateTime;
    ASjdm: string;
    AHcdm: string;
    AHcmc: string;
    AHczj: Currency;
    ARzbz: Boolean;
    AJsbz: string;
    ASjgq: Boolean;
    AColor: TColor;
    AImage: Integer;
  end;
  //Ԥ������
  TYdcy = record
    AYdbh: string;
    AKrbh: string;
    AKrxm: string;
    ASyrq: TDateTime;
    ASjdm: string;
    ACtbh: string;
    ACtmc: string;
    AXfje: Currency;
    ARzbz: Boolean;
    AJsbz: string;
    ASjgq: Boolean;
    AYcbz: string;
    AColor: TColor;
    AImage: Integer;
  end;
  //Ԥ���ͷ�
  TYdkf = record
    AYdbh: string;
    AKrbh: string;
    AKrxm: string;
    ADdrq: TDateTime;
    ADdsj: TDateTime;
    ALdrq: TDateTime;
    ALdsj: TDateTime;
    AKfbh: string;
    AXfje: Currency;
    ARzbz: Boolean;
    AJsbz: string;
    AYdbz: string;
    ASjgq: Boolean;
    AColor: TColor;
    AImage: Integer;
  end;


  TKfztForm = class(TStandForm)
    tblKfzt: TTable;
    ImageList1: TImageList;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    ImageList2: TImageList;
    DBGrid1: TDBGrid;
    Chart1: TChart;
    Series1: TPieSeries;
    PopupMenu1: TPopupMenu;
    menuNbdj: TMenuItem;
    menuWbdj: TMenuItem;
    menuMfdj: TMenuItem;
    menuTddj: TMenuItem;
    N5: TMenuItem;
    menuXxxg: TMenuItem;
    N7: TMenuItem;
    menuCyxf: TMenuItem;
    tblKfztD_KFBH: TStringField;
    tblKfztD_KRBH: TStringField;
    tblKfztD_YJBH: TStringField;
    tblKfztD_SJFJ: TCurrencyField;
    tblKfztD_KFZT: TStringField;
    tblKfztD_KFBZ: TStringField;
    tblKfztD_KRSL: TSmallintField;
    tblKfztD_DHKT: TBooleanField;
    tblKfztD_BZFJ: TCurrencyField;
    tblKfztD_CWS: TSmallintField;
    tblKfztD_BJS: TIntegerField;
    tblKfztD_QJS: TIntegerField;
    tblKfztD_JJFJ: TCurrencyField;
    tblKfztD_FXBH: TStringField;
    tblKfztD_LCBH: TStringField;
    dsKfzt: TDataSource;
    tblKfztD_KRXM: TStringField;
    tblKfztD_DDRQ: TDateField;
    tblKfztD_DDSJ: TTimeField;
    tblKfztD_ZDBH: TStringField;
    menuDhfj: TMenuItem;
    menuYksy: TMenuItem;
    menuJz: TMenuItem;
    N1: TMenuItem;
    menuOkf: TMenuItem;
    menuWxf: TMenuItem;
    Timer1: TTimer;
    TabSheet5: TTabSheet;
    DBGrid2: TDBGrid;
    Panel4: TPanel;
    qryTd: TQuery;
    dsQryTd: TDataSource;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn7: TBitBtn;
    tblKrxx: TTable;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    Panel5: TPanel;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn15: TBitBtn;
    Label7: TLabel;
    btnFtdh: TBitBtn;
    btnRefresh: TBitBtn;
    BitBtn16: TBitBtn;
    lblTime: TStaticText;
    Chart2: TChart;
    Series2: TBarSeries;
    TabSheet4: TTabSheet;
    DBGrid3: TDBGrid;
    tblXxbd: TTable;
    dsXxbd: TDataSource;
    TabSheet6: TTabSheet;
    Panel6: TPanel;
    btnYdhc: TBitBtn;
    PageControl2: TPageControl;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    sgdYdhc: TStringGrid;
    qryYdhc: TQuery;
    btnYdRefresh: TBitBtn;
    ImageList3: TImageList;
    btnYdxx: TBitBtn;
    btnHcjs: TBitBtn;
    qryYdcy: TQuery;
    sgdYdcy: TStringGrid;
    btnYdClear: TBitBtn;
    btnYdcysk: TBitBtn;
    btnYdcytd: TBitBtn;
    btnYdkfsk: TBitBtn;
    btnYdkftd: TBitBtn;
    sgdYdkf: TStringGrid;
    qryYdkf: TQuery;
    BitBtn17: TBitBtn;
    Panel7: TPanel;
    sgdKfzt: TStringGrid;
    Panel8: TPanel;
    lblTdmc1: TStaticText;
    lblTdmc2: TStaticText;
    lblTdmc3: TStaticText;
    lblTdmc4: TStaticText;
    lblTdmc5: TStaticText;
    lblTdmc6: TStaticText;
    lblTdmc7: TStaticText;
    lblTdmc8: TStaticText;
    lblTdmc9: TStaticText;
    lblTdmc10: TStaticText;
    tblFt: TTable;
    tblXxbdD_KRBH: TStringField;
    tblXxbdD_KRXM: TStringField;
    tblXxbdD_KRLX: TStringField;
    tblXxbdD_DDRQ: TDateField;
    tblXxbdD_DDSJ: TTimeField;
    tblXxbdD_LDRQ: TDateField;
    tblXxbdD_LDSJ: TTimeField;
    tblXxbdD_YWX: TStringField;
    tblXxbdD_YWM: TStringField;
    tblXxbdD_XB: TStringField;
    tblXxbdD_MZBH: TStringField;
    tblXxbdD_DQBH: TStringField;
    tblXxbdD_GBBH: TStringField;
    tblXxbdD_NZTS: TSmallintField;
    tblXxbdD_TLSY: TStringField;
    tblXxbdD_ZJBH: TStringField;
    tblXxbdD_ZJHM: TStringField;
    tblXxbdD_CSNY: TDateField;
    tblXxbdD_HCL: TStringField;
    tblXxbdD_HCQ: TStringField;
    tblXxbdD_QZBH: TStringField;
    tblXxbdD_QZYXQ: TDateField;
    tblXxbdD_ZY: TStringField;
    tblXxbdD_LXDH: TStringField;
    tblXxbdD_DWMC: TStringField;
    tblXxbdD_JTDZ: TStringField;
    tblXxbdD_JDR: TStringField;
    tblXxbdD_JDDW: TStringField;
    tblXxbdD_QDR1: TStringField;
    tblXxbdD_QDR2: TStringField;
    tblXxbdD_QDR3: TStringField;
    tblXxbdD_QDR4: TStringField;
    tblXxbdD_BZ: TStringField;
    tblXxbdD_KFBH: TStringField;
    procedure PopupMenu1Popup(Sender: TObject);
    procedure menuNbdjClick(Sender: TObject);
    procedure menuXxxgClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure menuWbdjClick(Sender: TObject);
    procedure menuTddjClick(Sender: TObject);
    procedure menuDhfjClick(Sender: TObject);
    procedure menuCyyjClick(Sender: TObject);
    procedure menuCyxfClick(Sender: TObject);
    procedure menuYksyClick(Sender: TObject);
    procedure menuJzClick(Sender: TObject);
    procedure menuOkfClick(Sender: TObject);
    procedure menuWxfClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnFtdhClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure tblKfztD_KFZTGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure sgdKfztDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgdKfztSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure menuMfdjClick(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure BitBtn16Click(Sender: TObject);
    procedure sgdKfztDblClick(Sender: TObject);
    procedure DBGrid3DblClick(Sender: TObject);
    procedure btnYdRefreshClick(Sender: TObject);
    procedure btnYdhcClick(Sender: TObject);
    procedure sgdYdhcDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnYdxxClick(Sender: TObject);
    procedure sgdYdhcDblClick(Sender: TObject);
    procedure sgdYdhcSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgdYdcyDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgdYdcySelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgdYdcyDblClick(Sender: TObject);
    procedure btnHcjsClick(Sender: TObject);
    procedure btnYdClearClick(Sender: TObject);
    procedure btnYdcyskClick(Sender: TObject);
    procedure btnYdcytdClick(Sender: TObject);
    procedure sgdYdkfDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgdYdkfDblClick(Sender: TObject);
    procedure btnYdkfskClick(Sender: TObject);
    procedure sgdYdkfSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnYdkftdClick(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FKfNum: Integer;
    FHcNum: Integer;
    FCyNum: Integer;
    FYdkfNum: Integer;
    FSelect: Integer;
    FHcSelect: Integer;
    FCySelect: Integer;
    FKfSelect: Integer;
    FKfzt: array of TKfzt;
    FYdhc: array of TYdhc;
    FYdcy: array of TYdcy;
    FYdkf: array of TYdkf;
    procedure KfztInit;
    procedure ShowKfzt;

    procedure ShowYjxf;

    procedure ShowRzl;
    procedure ShowYdhc;
    procedure ShowYdcy;
    procedure ShowYdkf;
  public
    { Public declarations }
    procedure Ftdh;
  end;

const
  ColNum   = 21;//�ͷ�״̬��
  HcColNum = 5; //�᳡״̬��
  CyColNum = 5; //����״̬��
  KfColNum = 5; //Ԥ���ͷ�״̬��
var
  KfztForm: TKfztForm;

procedure KfztShow;

implementation

uses C_Define,
     C_Nbjd,
     C_Xxxg,
     C_Wbjd,
     C_Tdjd,
     C_Sktf,
     C_Zdcx,
     C_ZdcxTd,
     C_Yksy,
     C_Skjz,
     C_Zd,
     C_HotelData,
     C_Ftdh,
     C_Main,
     C_Tdbd,
     C_Tdtf,
     C_Tdjz,
     C_Tdzd,
     C_Bjyj,
     C_Skyjbg,
     C_YxjzTd,
     C_Tdyfcx,
     C_Fjbg,
     C_Dtbqj,
     C_Yjcj,
     C_Mfjd,
     C_Ftsm,
     C_YdxxSel,
     C_Ydhc,
     C_Ydxx,
     C_Ydcysk,
     C_Ydcytd,
     C_Ydkfsk,
     C_Ydkftd,
     C_Ydsm;

{$R *.dfm}

procedure KfztShow;
begin
  with KfztForm do
  begin
    KfztInit;
    Show;
  end;
end;

//�ͷ�״̬��ʼ��
procedure TKfztForm.KfztInit;
begin
  PageControl1.ActivePageIndex := 0;

  try
    tblKfzt.Open;
    tblXxbd.Open;
    qryTd.Open;
    qryYdhc.Open;
    qryYdcy.Open;
    qryYdkf.Open;
    qryYdhc.Open;
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

  ShowKfzt;
  ShowRzl;
  ShowYdhc;
  ShowYdcy;
  ShowYdkf;
  ShowYjxf;
end;

//��ʾѺ�������
procedure TKfztForm.ShowYjxf;
var
  I: Integer;
  AKfxx: TKfxx;
  AYfje,AXfje,ADtfj: Currency;
begin
  for i:=0 to FKfNum-1 do
  begin
    //��ʾ�����Ԥ���ͷ�
    if qryYdkf.Locate('D_KFBH',FKfzt[i].AKfbh,[]) then
      if qryYdkf.FieldByName('D_DDRQ').AsString=DateToStr(Date) then
        FKfzt[i].AYdbz := '��'
      else
        FKfzt[i].AYdbz := '';

    //��Ҫ�߽�Ѻ��Ŀͷ�
    if (FKfzt[i].AKfzt=KFZT_BF)or(FKfzt[i].AKfzt=KFZT_TD) then
    begin
      AKfxx := HotelData.GetKfxx(FKfzt[i].AKfbh);

      ADtfj := GetDtfj(AKfxx.ADdsj,Time,AKfxx.AKfbz,AKfxx.ASjfj);

      AYfje := HotelData.SumJe('select sum(D_YFJE) from KRYJ where (D_YJBH="'
                               +AKfxx.AYjbh+'")and(D_FKFS="'+FKFS_RMB+'")');
      AXfje := HotelData.SumJe('select sum(D_XFJE) from KRZD where (D_ZDBH="'
                               +AKfxx.AZdbh+'")and(D_HH<>0)');
      if (AYfje<>0)and((AXfje+ADtfj)>(AYfje-100)) then
        FKfzt[i].ACjbz := '��'
      else
        FKfzt[i].ACjbz := '';
    end;
  end;
  sgdKfzt.Refresh;
end;

//��ʾ�ͷ�״̬
procedure TKfztForm.ShowKfzt;
var
  I: Integer;
begin
  Screen.Cursor := crHourGlass;
  tblKfzt.DisableControls;
  tblKfzt.Refresh;

  FKfNum := tblKfzt.RecordCount;//�ͷ�����
  SetLength(FKfzt,FKfNum);
  sgdKfzt.ColCount := ColNum;
  sgdKfzt.RowCount := (FKfNum div ColNum) + 1;

  tblKfzt.First;
  i := 0;
  while not tblKfzt.Eof do
  begin
    FKfzt[i].AKfbh := tblKfztD_KFBH.Value;
    FKfzt[i].AKfzt := tblKfztD_KFZT.Value;
    FKfzt[i].AKrbh := tblKfztD_KRBH.Value;
    FKfzt[i].AKrxm := tblKfztD_KRXM.Value;
    FKfzt[i].ASjfj := tblKfztD_SJFJ.Value;
    FKfzt[i].AYjbh := tblKfztD_YJBH.Value;
    FKfzt[i].AYdbz := '';
    FKfzt[i].ACjbz := '';

    if tblKfztD_KFZT.Value=KFZT_OK then
    begin
      FKfzt[i].AColor := COLOR_OK;
      FKfzt[i].AImage := 0;
    end;

    if tblKfztD_KFZT.Value=KFZT_BF then
    begin
      FKfzt[i].AColor := COLOR_BF;
      FKfzt[i].AImage := 1;
    end;

    if tblKfztD_KFZT.Value=KFZT_TD then
    begin
      FKfzt[i].AColor := COLOR_TD;
      FKfzt[i].AImage := 2;
    end;

    if tblKfztD_KFZT.Value=KFZT_WX then
    begin
      FKfzt[i].AColor := COLOR_WX;
      FKfzt[i].AImage := 3;
    end;

    if tblKfztD_KFZT.Value=KFZT_ZK then
    begin
      FKfzt[i].AColor := COLOR_ZK;
      FKfzt[i].AImage := 5;
    end;

    if tblKfztD_KFZT.Value=KFZT_MF then
    begin
      FKfzt[i].AColor := COLOR_MF;
      FKfzt[i].AImage := 4;
    end;
    Inc(i);
    tblKfzt.Next;
  end;

  tblKfzt.EnableControls;

  //�Ŷ���Ϣˢ��
  with qryTd do
  begin
    DisableControls;
    for i:=1 to 10 do
      (KfztForm.FindComponent('lblTdmc'+IntToStr(i)) as TStaticText).Caption := '';
    Close;
    Open;
    First;
    while not Eof do
    begin
      (KfztForm.FindComponent('lblTdmc'+IntToStr(qryTd.RecNo)) as TStaticText).Caption := qryTd.FieldbyName('D_KRXM').AsString;
      for i:=0 to FKfNum-1 do
        if FKfzt[i].AKrxm = qryTd.FieldByName('D_KRXM').AsString then
          FKfzt[i].AColor := (KfztForm.FindComponent('lblTdmc'+IntToStr(qryTd.RecNo)) as TStaticText).Color;
      Next;
    end;
    EnableControls;
  end;

  sgdKfzt.Refresh;
  tblXxbd.Refresh;

  Screen.Cursor := crDefault;
end;

//��ס��ͼ����ʾ
procedure TKfztForm.ShowRzl;
var
  AOk,ABf,ATd,AWx,AMf,AZk: Integer;
  ACzl: Double;
begin
  tblkfzt.DisableControls;
  AOk := 0;ABf := 0;ATd := 0;AWx := 0;AMf := 0;AZk := 0;
  with tblKfzt do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('D_KFZT').AsString = KFZT_OK then Inc(AOk)
      else
      if FieldByName('D_KFZT').AsString = KFZT_BF then Inc(ABf)
      else
      if FieldByName('D_KFZT').AsString = KFZT_TD then Inc(ATd)
      else
      if FieldByName('D_KFZT').AsString = KFZT_WX then Inc(AWx)
      else
      if FieldByName('D_KFZT').AsString = KFZT_MF then Inc(AMf)
      else
      if FieldByName('D_KFZT').AsString = KFZT_ZK then Inc(AZk);
      Next;
    end;
  end;
  with Series1 do
  begin
    Clear;
    AddPie(AOk,'�շ�',clWhite);
    AddPie(ABf,'ɢ��',clGreen);
    AddPie(ATd,'�Ŷ�',clBlue);
    AddPie(AWx,'ά��',clRed);
    AddPie(AMf,'���',clYellow);
    AddPie(AZk,'���',clBlack);
  end;
  with Series2 do
  begin
    Clear;
    if (AOk+ABf+ATd+AMf+AZk)=0 then ACzl := 0
    else
      ACzl := (ABf+ATd+AMf)/(AOk+ABf+ATd+AMf+AZk);
    AddBar(AOk+ABf+ATd+AMf+AZk,'�ͷ�����',clBlue);
    AddBar(ABf+ATd+AMf,'������',clGreen);
    AddBar(ACzl*100,'������%',clRed)
  end;
  tblKfzt.EnableControls;
end;

//�Ҽ��˵�
procedure TKfztForm.PopupMenu1Popup(Sender: TObject);
var
  Enable: Boolean;
  AKfzt : string;
begin
  inherited;
  Enable := False;

  menuNbdj.Enabled := Enable;
  menuWbdj.Enabled := Enable;
  menuMfdj.Enabled := Enable;
  menuTddj.Enabled := Enable;
  menuXxxg.Enabled := Enable;
  menuCyxf.Enabled := Enable;
  menuDhfj.Enabled := Enable;
  menuYksy.Enabled := Enable;
  menuJz.Enabled   := Enable;
  menuOkf.Enabled  := Enable;
  menuWxf.Enabled  := Enable;

  if FSelect >= FKfNum then Exit;

  AKfzt := FKfzt[FSelect].AKfzt;

  if (AKfzt<>KFZT_WX)and(AKfzt<>KFZT_MF)and(AKfzt<>KFZT_ZK) then
  begin
    Enable := AKfzt<> KFZT_OK;
    menuNbdj.Enabled := not Enable;
    menuWbdj.Enabled := not Enable;
    menuMfdj.Enabled := not Enable;
    menuTddj.Enabled := not Enable;
    menuXxxg.Enabled := Enable;
    menuDhfj.Enabled := Enable;
    menuYksy.Enabled := Enable;
    menuCyxf.Enabled := Enable;
    menuJz.Enabled   := Enable and (AKfzt<>KFZT_TD);
  end;

  if AKfzt=KFZT_OK then menuWxf.Enabled := True;

  if  (AKfzt=KFZT_ZK)
    or(AKfzt=KFZT_WX)
    or(AKfzt=KFZT_MF) then
      menuOkf.Enabled := True;

end;

//�ڱ��Ӵ�
procedure TKfztForm.menuNbdjClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'�Ӵ�') then Exit;
  NbjdEnter(tblKfztD_KFBH.Value);

  //ˢ��
  ShowKfzt;
  ShowRzl;
end;

//��Ϣ�޸�
procedure TKfztForm.menuXxxgClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'�Ӵ�') then Exit;
  XxxgEnter(tblKfztD_KRBH.Value);

  ShowKfzt;
end;

//��̬ˢ��
procedure TKfztForm.btnRefreshClick(Sender: TObject);
begin
  inherited;
  ShowKfzt;
  ShowRzl;
  ShowYjxf;
end;

//����Ӵ�
procedure TKfztForm.menuWbdjClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'�Ӵ�') then Exit;
  WbjdEnter(tblKfztD_KFBH.Value);

  ShowKfzt;
  ShowRzl;
end;

//�ŶӽӴ�
procedure TKfztForm.menuTddjClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'�Ӵ�') then Exit;
  Tdjd;
  
  ShowKfzt;
  ShowRzl;
end;

//��������
procedure TKfztForm.menuDhfjClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'�Ӵ�') then Exit;
  SktfEnter(tblKfztD_KFBH.Value);

  ShowKfzt;
  ShowRzl;
end;

//Ѻ���ѯ
procedure TKfztForm.menuCyyjClick(Sender: TObject);
begin
  inherited;
end;

//�ʵ���ѯ
procedure TKfztForm.menuCyxfClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'��ѯ') then Exit;
  if tblKfztD_KFZT.Value=KFZT_BF then
    ZdcxEnter(tblKfztD_KFBH.Value);
  if tblKfztD_KFZT.Value=KFZT_TD then
    ZdcxtdEnter(tblKfztD_KRBH.Value);
end;

//Ԣ������
procedure TKfztForm.menuYksyClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'����') then Exit;
  YksyEnter(tblKfztD_KFBH.Value);
end;

//ɢ�ͽ���
procedure TKfztForm.menuJzClick(Sender: TObject);
var
  AJzxx: TJZXX;
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'����') then Exit;
  AJzxx := SkjzEnter(tblKfztD_KFBH.Value);
  if AJzxx.AJzfs<>'' then
    Zd(AJzxx);
    
  ShowKfzt;
  ShowRzl;
end;

//����OK��
procedure TKfztForm.menuOkfClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'�Ӵ�') then Exit;

  //�������ѷ�
  if tblKfztD_KFZT.Value = KFZT_MF then
  begin
    //20020627 edit by ls.
    HotelData.EmptyData('select * from KRXX where D_KRBH="'+tblKfztD_KRBH.Value+'"');
    tblKfzt.Edit;
    tblKfztD_KRBH.Value := '';
    tblKfzt.Post;
  end;

  HotelData.SetKfzt(tblKfztD_KFBH.Value,KFZT_OK);

  ShowKfzt;
  ShowRzl;
end;

//����ά�޷�
procedure TKfztForm.menuWxfClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'�Ӵ�') then Exit;

  HotelData.SetKfzt(tblKfztD_KFBH.Value,KFZT_WX);

  ShowKfzt;
  ShowRzl;
end;

//��ʾʱ��
procedure TKfztForm.Timer1Timer(Sender: TObject);
begin
  inherited;
  lblTime.Caption := DateToStr(Date)+' '+TimeToStr(Time);
end;

//��̬����
procedure TKfztForm.btnFtdhClick(Sender: TObject);
begin
  inherited;
  FtdhForm.Show;
end;

//��̬��������
procedure TKfztForm.Ftdh;
begin
  ShowKfzt;
end;

//�ŶӲ���
procedure TKfztForm.BitBtn1Click(Sender: TObject);
var
  AKrbh: string;
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'�Ӵ�') then Exit;

  AKrbh := qryTd.FieldByName('D_KRBH').AsString;
  if AKrbh<>'' then
  begin
    Tdbd(AKrbh);
    ShowKfzt;
  end;
end;

//�Ŷ��˷�
procedure TKfztForm.BitBtn2Click(Sender: TObject);
var
  AKrbh: string;
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'����') then Exit;

  AKrbh := qryTd.FieldByName('D_KRBH').AsString;
  if AKrbh<>'' then
  begin
    Tdtf(AKrbh);
    ShowKfzt;
  end;
end;

//�Ŷӽ���
procedure TKfztForm.BitBtn3Click(Sender: TObject);
var
  AKrbh: string;
  AJzxx: TTdJzxx;
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'����') then Exit;

  AKrbh := qryTd.FieldByName('D_KRBH').AsString;
  if AKrbh<>'' then
  begin
    AJzxx := Tdjz(AKrbh);
    if AJzxx.AJzfs<>'' then
    begin
      Tdzd(AJzxx);
      ShowKfzt;
    end;
  end;
end;

//�ŶӲ���Ѻ��
procedure TKfztForm.BitBtn4Click(Sender: TObject);
var
  AKrbh: string;
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'����') then Exit;

  AKrbh := qryTd.FieldByName('D_KRBH').AsString;
  if AKrbh<>'' then
  begin
    Bjyjtd(AKrbh);
  end;
end;

//�Ŷӱ��Ѻ��
procedure TKfztForm.BitBtn5Click(Sender: TObject);
var
  AKrbh: string;
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'����') then Exit;

  AKrbh := qryTd.FieldByName('D_KRBH').AsString;
  if AKrbh<>'' then
  begin
    Tdyjbg(AKrbh);
  end;
end;

//�Ŷ�Ѻ���ѯ

//�Ŷ�Ԥ�Ƚ���
procedure TKfztForm.BitBtn7Click(Sender: TObject);
var
  AKrbh: string;
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'����') then Exit;
  
  AKrbh := qryTd.FieldByName('D_KRBH').AsString;
  if AKrbh<>'' then
  begin
    YxjzTd(AKrbh);
  end;
end;

//�Ŷ��÷�
procedure TKfztForm.BitBtn8Click(Sender: TObject);
var
  AKrbh: string;
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'��ѯ') then Exit;

  AKrbh := qryTd.FieldByName('D_KRBH').AsString;
  if AKrbh<>'' then
  begin
    Tdyfcx(AKrbh);
  end;
end;

//�ŶӽӴ�
procedure TKfztForm.BitBtn9Click(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'�Ӵ�') then Exit;

  Tdjd;
  ShowKfzt;
end;

//���۱��
procedure TKfztForm.BitBtn10Click(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'���۱��') then Exit;
  Fjbg;
end;

//�����ȫ��
procedure TKfztForm.BitBtn11Click(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'��ѯ') then Exit;
  Dtbqj;
end;

//�Ŷ���Ϣ�޸�
procedure TKfztForm.BitBtn12Click(Sender: TObject);
var
  AKrbh: string;
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'�Ӵ�') then Exit;
  AKrbh := qryTd.FieldByName('D_KRBH').AsString;
  if AKrbh<>'' then
  begin
    XxxgEnter(AKrbh);
  end;
end;

//Ѻ������
procedure TKfztForm.tblKfztD_KFZTGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  inherited;
  if DisplayText then
  begin
    if Sender.AsString=KFZT_BF then Text := '����';
    if Sender.AsString=KFZT_TD then Text := '�Ŷ�';
    if Sender.AsString=KFZT_MF then Text := '���';
    if Sender.AsString=KFZT_WX then Text := 'ά��';
    if Sender.AsString=KFZT_OK then Text := '�շ�';
    if Sender.AsString=KFZT_ZK then Text := '���';
  end;
end;

//ˢ�¿ͷ�ʱ
procedure TKfztForm.sgdKfztDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  i : Integer;
begin
  inherited;
  i := ARow*sgdKfzt.ColCount + ACol;

  if i<FKfNum then
  begin
    with sgdKfzt do
    begin
      Canvas.Brush.Color := FKfzt[i].AColor;
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left,Rect.Top,FKfzt[i].AKfbh);
      Canvas.TextOut(Rect.Left,Rect.Top+13,FKfzt[i].ACjbz+FKfzt[i].AYdbz);
      //20020627 edit by ls.
      {if FKfzt[i].ASjfj<>0 then
        Canvas.TextOut(Rect.Left,Rect.Top+13,CurrToStr(FKfzt[i].ASjfj)+'Ԫ');
      if IS_SHOWIMAGE then
        ImageList1.Draw(Canvas,Rect.Left,Rect.Top+13,FKfzt[i].AImage);}
    end;
  end;
end;

//��ѡ��ͷ�ʱ
procedure TKfztForm.sgdKfztSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  inherited;
  sgdKfzt.ShowHint := False;
  FSelect := ARow*sgdKfzt.ColCount + ACol;
  if FSelect < FKfnum then
  begin
    tblKfzt.Locate('D_KFBH',FKfzt[FSelect].AKfbh,[]);
    sgdKfzt.Hint :=  '����������' + tblKfztD_KRXM.Value+#13#10
                   + 'ʵ�ʷ��ۣ�' + CurrToStr(tblKfztD_SJFJ.Value);
    sgdKfzt.ShowHint := True;
  end;
end;

//��ѵǼ�
procedure TKfztForm.menuMfdjClick(Sender: TObject);
var
  AKfbh: string;
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'�Ӵ�') then Exit;
  AKfbh := tblKfztD_KFBH.Value;
  MfjdEnter(AKfbh);
  ShowKfzt;
  ShowRzl;
end;

//���ʲ�ѯ
procedure TKfztForm.BitBtn14Click(Sender: TObject);
var
  AKrbh: string;
begin
  inherited;
  AKrbh := qryTd.FieldByName('D_KRBH').AsString;
  if AKrbh<>'' then
    ZdcxTdEnter(AKrbh);
end;

//�Ŷ�ȡ���ͷ�
procedure TKfztForm.BitBtn15Click(Sender: TObject);
var
  AKrbh: string;
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'�Ӵ�') then Exit;
  AKrbh := qryTd.FieldByName('D_KRBH').AsString;
  if AKrbh<>'' then
    Tdqx(AKrbh);
end;

//��̬˵��
procedure TKfztForm.BitBtn16Click(Sender: TObject);
begin
  inherited;
  Ftsm;
end;

//˫���ͷ�
procedure TKfztForm.sgdKfztDblClick(Sender: TObject);
begin
  inherited;
  if FSelect < FKfNum then
  begin
    //�����OK������Ǽ�
    if FKfzt[FSelect].AKfzt=KFZT_OK then
    begin
      if not HotelData.CheckYgqx(CZY.CzyBh,'�Ӵ�') then Exit;
      NbjdEnter(tblKfztD_KFBH.Value);
      ShowKfzt;
      ShowRzl;
      Exit;
    end;

    //�����ɢ��
    if FKfzt[FSelect].AKfzt = KFZT_BF then
      ZdcxEnter(tblKfztD_KFBH.Value);
      //20020630 edit by ls.
      //YjxfEnter(tblKfztD_KFBH.Value);

    //������Ŷ�
    if FKfzt[FSelect].AKfzt = KFZT_TD then
      ZdcxTdEnter(tblKfztD_KRBH.Value);
      //YjxfEnter1(tblKfztD_KRBH.Value);

  end;
end;

//��Ϣ����
procedure TKfztForm.DBGrid3DblClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'�Ӵ�') then Exit;
  XxxgEnter(tblXxbd.FieldByName('D_KRBH').AsString);
end;

//ˢ��Ԥ������
procedure TKfztForm.ShowYdcy;
var
  i: Integer;
begin
  FCyNum := qryYdcy.RecordCount; //Ԥ������
  SetLength(FYdcy,FCyNum);
  sgdYdcy.ColCount := CyColNum;
  sgdYdcy.RowCount := (FCyNum div CyColNum)+1;

  qryYdcy.First;
  i := 0;
  while not qryYdcy.Eof do
  begin
    FYdcy[i].AYdbh := qryYdcy.FieldByName('D_YDBH').AsString;
    FYdcy[i].AKrbh := qryYdcy.FieldByName('D_KRBH').AsString;
    FYdcy[i].AKrxm := qryYdcy.FieldByName('D_KRXM').AsString;
    FYdcy[i].ASyrq := qryYdcy.FieldByName('D_SYRQ').AsDateTime;
    FYdcy[i].ASjdm := qryYdcy.FieldByName('D_SJDM').AsString;
    FYdcy[i].ACtbh := qryYdcy.FieldByName('D_CTBH').AsString;
    FYdcy[i].ACtmc := qryYdcy.FieldByName('D_CTMC').AsString;
    FYdcy[i].AXfje := qryYdcy.FieldByName('D_XFJE').AsCurrency;
    FYdcy[i].ARzbz := qryYdcy.FieldByName('D_RZBZ').AsBoolean;
    FYdcy[i].AJsbz := qryYdcy.FieldByName('D_JSBZ').AsString;
    FYdcy[i].AYcbz := qryYdcy.FieldbyName('D_YCBZ').AsString;
    FYdcy[i].AColor := cl3DLight;

    //�������
    if FYdcy[i].ASyrq < Date then FYdcy[i].ASjgq := True
    else FYdcy[i].ASjgq := False;
    if FYdcy[i].ASjgq then FYdcy[i].AColor := clYellow;

    //�������ȷ��
    if FYdcy[i].ARzbz then FYdcy[i].AColor := clGreen;

    //�������
    if FYdcy[i].AJsbz = JS_YES then FYdcy[i].AColor := clRed;

    FYdcy[i].AImage := 0;
    if FYdcy[i].ARzbz          then FYdcy[i].AImage := 1;
    if FYdcy[i].AJsbz = JS_YES then FYdcy[i].AImage := 2;
    if FYdcy[i].ASjgq          then FYdcy[i].AImage := 3;

    qryYdcy.Next;
    Inc(i);
  end;
  sgdYdcy.Refresh;
end;

//ˢ��Ԥ���ͷ�
procedure TKfztForm.ShowYdkf;
var
  i: Integer;
begin
  FYdkfNum := qryYdkf.RecordCount;//Ԥ������
  SetLength(FYdkf,FYdkfNum);
  sgdYdkf.ColCount := KfColNum;
  sgdYdkf.RowCount := (FYdkfNum div KfColNum)+1;

  qryYdkf.First;
  i := 0;
  while not qryYdkf.Eof do
  begin
    FYdkf[i].AYdbh := qryYdkf.FieldByName('D_YDBH').AsString;
    FYdkf[i].AKrbh := qryYdkf.FieldByName('D_KRBH').AsString;
    FYdkf[i].AKrxm := qryYdkf.FieldByName('D_KRXM').AsString;
    FYdkf[i].ADdrq := qryYdkf.FieldByName('D_DDRQ').AsDateTime;
    FYdkf[i].ADdsj := qryYdkf.FieldByName('D_DDSJ').AsDateTime;
    FYdkf[i].ALdrq := qryYdkf.FieldByName('D_LDRQ').AsDateTime;
    FYdkf[i].ALdsj := qryYdkf.FieldByName('D_LDSJ').AsDateTime;
    FYdkf[i].AKfbh := qryYdkf.FieldByName('D_KFBH').AsString;
    FYdkf[i].AXfje := qryYdkf.FieldByName('D_XFJE').AsCurrency;
    FYdkf[i].ARzbz := qryYdkf.FieldByName('D_RZBZ').AsBoolean;
    FYdkf[i].AJsbz := qryYdkf.FieldByName('D_JSBZ').AsString;
    FYdkf[i].AYdbz := qryYdkf.FieldByName('D_YDBZ').AsString;
    FYdkf[i].AColor := cl3DLight;

    //�������
    if FYdkf[i].ADdrq < Date then FYdkf[i].ASjgq := True
    else FYdkf[i].ASjgq := False;
    if FYdkf[i].ASjgq then FYdkf[i].AColor := clYellow;

    //���ȷ��
    if FYdkf[i].ARzbz then FYdkf[i].AColor := clGreen;

    //�������
    if FYdkf[i].AJsbz = JS_YES then FYdkf[i].AColor := clRed;

    FYdkf[i].AImage := 0;
    if FYdkf[i].ARzbz          then FYdkf[i].AImage := 1;
    if FYdkf[i].AJsbz = JS_YES then FYdkf[i].AImage := 2;
    if FYdkf[i].ASjgq          then FYdkf[i].AImage := 3;

    qryYdkf.Next;
    Inc(i);
  end;
  sgdYdkf.Refresh;
end;

//ˢ��Ԥ���᳡
procedure TKfztForm.ShowYdhc;
var
  i: Integer;
begin
  FHcNum := qryYdhc.RecordCount;//Ԥ������
  SetLength(FYdhc,FHcNum);
  sgdYdhc.ColCount := HcColNum;
  sgdYdhc.RowCount := (FHcNum div HcColNum)+1;

  qryYdhc.First;
  i := 0;
  while not qryYdhc.Eof do
  begin
    FYdhc[i].AYdbh := qryYdhc.FieldByName('D_YDBH').AsString;
    FYdhc[i].AKrbh := qryYdhc.FieldByName('D_KRBH').AsString;
    FYdhc[i].AKrxm := qryYdhc.FieldByName('D_KRXM').AsString;
    FYdhc[i].ASyrq := qryYdhc.FieldByName('D_SYRQ').AsDateTime;
    FYdhc[i].ASjdm := qryYdhc.FieldByName('D_SJDM').AsString;
    FYdhc[i].AHcdm := qryYdhc.FieldByName('D_HCBH').AsString;
    FYdhc[i].AHcmc := qryYdhc.FieldByName('D_HCMC').AsString;
    FYdhc[i].AHczj := qryYdhc.FieldByName('D_HCZJ').AsCurrency;
    FYdhc[i].ARzbz := qryYdhc.FieldByName('D_RZBZ').AsBoolean;
    FYdhc[i].AJsbz := qryYdhc.FieldByName('D_JSBZ').AsString;
    FYdhc[i].AColor := cl3DLight;

    //�������
    if FYdhc[i].ASyrq < Date then FYdhc[i].ASjgq := True
    else FYdhc[i].ASjgq := False;
    if FYdhc[i].ASjgq then FYdhc[i].AColor := clYellow;

    //���ȷ��
    if FYdhc[i].ARzbz then FYdhc[i].AColor := clGreen;

    //�������
    if FYdhc[i].AJsbz = JS_YES then FYdhc[i].AColor := clRed;

    FYdhc[i].AImage := 0;
    if FYdhc[i].ARzbz          then FYdhc[i].AImage := 1;
    if FYdhc[i].ASjgq          then FYdhc[i].AImage := 3;
    if FYdhc[i].AJsbz = JS_YES then FYdhc[i].AImage := 2;
    
    qryYdhc.Next;
    Inc(i);
  end;
  sgdYdhc.Refresh;
end;

//Ԥ��ˢ��
procedure TKfztForm.btnYdRefreshClick(Sender: TObject);
begin
  inherited;
  ShowYdhc;
  ShowYdcy;
  ShowYdkf;
end;

//Ԥ���᳡
procedure TKfztForm.btnYdhcClick(Sender: TObject);
var
  AKrbh: string;
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'Ԥ��') then Exit;
  AKrbh := YdxxSel;
  if AKrbh<>'' then
  begin
    YdhcNew(AKrbh);
    ShowYdhc;
  end;
end;

procedure TKfztForm.sgdYdhcDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  i : Integer;
begin
  inherited;
  i := ARow*sgdYdhc.ColCount + ACol;

  if i<FHcNum then
  begin
    with sgdYdhc do
    begin
      Canvas.Brush.Color := FYdhc[i].AColor;
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left,Rect.Top,DateToStr(FYdhc[i].ASyrq)+FYdhc[i].ASjdm);
      Canvas.TextOut(Rect.Left,Rect.Top+20,FYdhc[i].AHcmc+' '+CurrToStr(FYdhc[i].AHczj)+'Ԫ');
      Canvas.TextOut(Rect.Left,Rect.Top+40,FYdhc[i].AKrxm);
      ImageList3.Draw(Canvas,Rect.Left,Rect.Top+60,FYdhc[i].AImage);
    end;
  end;
end;

//Ԥ����Ϣ
procedure TKfztForm.btnYdxxClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'Ԥ��') then Exit;
  Ydxx;
  ShowYdhc;
end;

procedure TKfztForm.sgdYdhcDblClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'Ԥ��') then Exit;
  if FHcSelect < FHcNum then
  begin
    if (not FYdhc[FHcSelect].ARzbz)and(FYdhc[FHcSelect].AJsbz=JS_NO) then
    begin
      YdhcEdit(FYdhc[FHcSelect].AKrbh,FYdhc[FHcSelect].AYdbh);
      ShowYdhc;
      Exit;
    end;
    if (FYdhc[FHcSelect].ARzbz)and(FYdhc[FHcSelect].AJsbz = JS_NO) then
    begin
      YdhcJs(FYdhc[FHcSelect].AKrbh,FYdhc[FHcSelect].AYdbh);
      ShowYdhc;
    end;
  end;
end;

procedure TKfztForm.sgdYdhcSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  inherited;
  FHcSelect := ARow*sgdYDhc.ColCount + ACol;
end;

procedure TKfztForm.sgdYdcyDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  i : Integer;
begin
  inherited;
  i := ARow*sgdYdcy.ColCount + ACol;
  if i<FCyNum then
  begin
    with sgdYdcy do
    begin
      Canvas.Brush.Color := FYdcy[i].AColor;
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left,Rect.Top,DateToStr(FYdcy[i].ASyrq)+FYdcy[i].ASjdm);
      Canvas.TextOut(Rect.Left,Rect.Top+20,FYdcy[i].ACtmc+' '+FYdcy[i].AYcbz);
      Canvas.TextOut(Rect.Left,Rect.Top+40,FYdcy[i].AKrxm);
      ImageList3.Draw(Canvas,Rect.Left,Rect.Top+60,FYdcy[i].AImage);
    end;
  end;
end;

procedure TKfztForm.sgdYdcySelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  inherited;
  FCySelect := ARow*sgdYdcy.ColCount + ACol;
end;

procedure TKfztForm.sgdYdcyDblClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'Ԥ��') then Exit;
  if FCySelect < FCyNum then
  begin
    if FYdcy[FCySelect].ACtmc<>'�ŶӶ���' then
      YdcyskEdit(FYdcy[FCySelect].AKrbh,FYdcy[FCySelect].AYdbh)
    else
      YdcytdEdit(FYdcy[FCySelect].AKrbh,FYdcy[FCySelect].AYdbh);
    ShowYdcy;
  end;
end;

procedure TKfztForm.btnHcjsClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'����') then Exit;
  if (FHcSelect < FHcNum) then
  begin
    if (FYdhc[FHcSelect].ARzbz)and(FYdhc[FHcSelect].AJsbz = JS_NO) then
    begin
      YdhcJs(FYdhc[FHcSelect].AKrbh,FYdhc[FHcSelect].AYdbh);
      ShowYdhc;
    end;
  end;
end;

//Ԥ������
procedure TKfztForm.btnYdClearClick(Sender: TObject);
var
  s: string;
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'Ԥ��') then Exit;
  s := 'delete from YDHC where D_SYRQ<:D';
  with HotelData.qryUserData do
  begin
    if Active then Active := False;
    SQL.Clear;
    SQL.Add(s);
    Params[0].DataType := ftDate;
    Params[0].Value := Date;
    ExecSQL;
    Close;
  end;
  s := 'delete from YDCY where D_SYRQ<:D';
  with HotelData.qryUserData do
  begin
    if Active then Active := False;
    SQL.Clear;
    SQL.Add(s);
    Params[0].DataType := ftDate;
    Params[0].Value := Date;
    ExecSQL;
    Close;
  end;
  s := 'delete from YDKF where D_DDRQ<:D';
  with HotelData.qryUserData do
  begin
    if Active then Active := False;
    SQL.Clear;
    SQL.Add(s);
    Params[0].DataType := ftDate;
    Params[0].Value := Date;
    ExecSQL;
    Close;
  end;

  s := 'delete from YDXX '
      +'where (D_KRBH<>any(select D_KRBH from YDHC))'
      +'and(D_KRBH<>any(select D_KRBH from YDCY))';
  with HotelData.qryUserData do
  begin
    if Active then Active := False;
    SQL.Clear;
    SQL.Add(s);
    ExecSQL;
    Close;
  end;
  ShowYdhc;
  ShowYdcy;
  ShowYdkf;
end;

//ɢ��Ԥ������
procedure TKfztForm.btnYdcyskClick(Sender: TObject);
var
  AKrbh: string;
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'Ԥ��') then Exit;
  AKrbh := YdxxSel;
  if AKrbh<>'' then
  begin
    YdcyskNew(AKrbh);
    ShowYdcy;
  end;
end;

//�Ŷ�Ԥ������
procedure TKfztForm.btnYdcytdClick(Sender: TObject);
var
  AKrbh: string;
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'Ԥ��') then Exit;
  AKrbh := YdxxSel;
  if AKrbh<>'' then
  begin
    YdcytdNew(AKrbh);
    ShowYdcy;
  end;
end;

procedure TKfztForm.sgdYdkfDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  i : Integer;
begin
  inherited;
  i := ARow*sgdYdkf.ColCount + ACol;
  if i<FYdkfNum then
  begin
    with sgdYdkf do
    begin
      Canvas.Brush.Color := FYdkf[i].AColor;
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left,Rect.Top,DateToStr(FYdkf[i].ADdrq)+' '+FormatDateTime('hh:mm',FYdkf[i].ADdsj));
      Canvas.TextOut(Rect.Left,Rect.Top+15,DateToStr(FYdkf[i].ALdrq)+' '+FormatDateTime('hh:mm',FYdkf[i].ALdsj));
      Canvas.TextOut(Rect.Left,Rect.Top+30,FYdkf[i].AKfbh+'�� '+CurrToStr(FYdkf[i].AXfje)+'Ԫ');
      Canvas.TextOut(Rect.Left,Rect.Top+45,FYdkf[i].AKrxm);
      ImageList3.Draw(Canvas,Rect.Left,Rect.Top+60,FYdkf[i].AImage);
    end;
  end;
end;

procedure TKfztForm.sgdYdkfDblClick(Sender: TObject);
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'Ԥ��') then Exit;
  if FKfSelect < FYdkfNum then
  begin
    if FYdKf[FKfSelect].AKfbh<>'' then
    begin
      if FYdkf[FKfSelect].AYdbz = YDKF_SK then
        YdkfskEdit(FYdkf[FKfSelect].AKrbh,FYdkf[FKfSelect].AYdbh)
      else
        YdkftdEdit(FYdkf[FKfSelect].AKrbh,FYdkf[FKfSelect].AYdbh);
    end;
    ShowYdkf;
  end;
end;

//ɢ��Ԥ���ͷ�
procedure TKfztForm.btnYdkfskClick(Sender: TObject);
var
  AKrbh: string;
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'Ԥ��') then Exit;
  AKrbh := YdxxSel;
  if AKrbh<>'' then
  begin
    YdKfskNew(AKrbh);
    ShowYdkf;
  end;
end;


procedure TKfztForm.sgdYdkfSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  inherited;
  FKfSelect := ARow*sgdYdkf.ColCount + ACol;
end;


//�Ŷ�Ԥ���ͷ�
procedure TKfztForm.btnYdkftdClick(Sender: TObject);
var
  AKrbh: string;
begin
  inherited;
  if not HotelData.CheckYgqx(CZY.CzyBh,'Ԥ��') then Exit;
  AKrbh := YdxxSel;
  if AKrbh<>'' then
  begin
    YdKfTdNew(AKrbh);
    ShowYdkf;
  end;
end;

//Ԥ��˵��
procedure TKfztForm.BitBtn17Click(Sender: TObject);
begin
  inherited;
  Ydsm;
end;

procedure TKfztForm.FormCreate(Sender: TObject);
begin
  inherited;
  KfztInit;
end;

end.
