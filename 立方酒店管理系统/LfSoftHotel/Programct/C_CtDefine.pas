unit C_CtDefine;

interface
uses
  Graphics, ComCtrls, DB, DBTables, SysUtils, DateUtils, Windows, Forms, Classes,
  DBGrids;
const
  //����������Ŀ
  XMBH_SP = '00001';
  XMBH_JS = '00002';
  XMBH_XY = '00003';
  XMBH_CJ = '00004';
  XMBH_FWF= '00005';
  
  XMBH_FJ  = '00001';
  XMBH_CF  = '00002';
  XMBH_HCF = '00003';
  XMBH_DHF = '00004';
  XMBH_YJK = '00005';
  XMBH_EWF = '00006';

  //�˵����ϵͳ����
  CDBH_BZ = '00000'; //��׼��
  CDMC_BZ = '��׼��';
  //�������
  CTLB_CT = '����';
  CTLB_TH = '̨��';
  //����״̬
  CTZT_OK = 'O';
  CTZT_USE= 'U';
  CTZT_JZ = 'J';
  //ʱ�����
  Morning = '����';
  Noon    = '����';
  Night   = '����';
  //�������
  DCLB_YC = 'C';
  DCLB_QT = 'Q';
  //�Ƿ����
  JZ_YES   = '2';
  JZ_NO    = '1';
  JZ_YX    = '3';

  //�Ƿ����
  JS_YES   = '2';
  JS_NO    = '1';
  JS_WJ    = '3';//δ���ʽ���
  //
  //���ǰ׺
  PREV_YDBH= 'Y';
  PREV_YJBH= 'J';
  PREV_KRBH= 'K';
  PREV_ZDBH= 'Z';
  PREV_JZBH= 'B';
  PREV_DCBH = 'D';

  //�ʵ����
  ZDLB_YK  = 'Y';
  ZDLB_TD  = 'T';
  ZDLB_SYS = 'S';
  ZDLB_FYK = 'F';
  ZDLB_MF  = 'M';

  //�ʵ���ע
  ZDBZ_SK  = 'ɢ��';
  ZDBZ_TD  = '�Ŷ�';
  ZDBZ_JZ  = '����';
  ZDBZ_GZ  = '����';
  ZDBZ_WJZ = 'δ����';
  ZDBZ_SYS = '�����';
  ZDBZ_FYK = '��Ԣ��';
  ZDBZ_YX  = 'Ԥ�Ƚ�';

  //���ʱ�ע
  JZBZ_SK  = 'ɢ�ͽ�';
  JZBZ_TD  = '�Ŷӽ�';
  JZBZ_GSK = '��ɢ��';
  JZBZ_GTD = '���Ŷ�';
  JZBZ_FYK = '��Ԣ��';
  JZBZ_WJZ = 'δ����';
  JZBZ_JZ  = '��  ��';
  JZBZ_GBK = '�����';
  JZBZ_YX  = 'Ԥ�Ƚ�';
  JZBZ_YJK = 'Ԥ����';
  JZBZ_YSK = 'Ӧ�տ�';
  
  //���ʷ�ʽ
  JZFS_RMB = '�����';
  JZFS_XYK = '���ÿ�';
  JZFS_ZP  = '֧Ʊ';
  JZFS_JZ  = '����';
  JZFS_GSK = '��ɢ��';
  JZFS_GTD = '���Ŷ�';
  JZFS_ZD  = '�д�';
  JZFS_GBK = '�����';
  JZFS_WJZ = 'δ����';

  //��������
  JZLX_YK  = 'Y';//Ԣ��
  JZLX_FYK = 'F';//��Ԣ��
  JZLX_YSK = 'K';//Ӧ�տ�
  JZLX_YJK = 'J';//Ԥ����
  
  //�ͷ�״̬
  KFZT_BF  = 'F';
  KFZT_BC  = 'C';
  KFZT_OK  = 'O';
  KFZT_WX  = 'R';
  KFZT_ZK  = 'D';
  KFZT_MF  = 'M';
  KFZT_KM  = 'U';
  KFZT_TD  = 'T';

  //Ԥ������
  YDCY_SK = 'P';
  YDCY_TD = 'T';


  //��ӡ��ʽ
  PRN_Portrait = 0;
  PRN_LandScape= 1;

  //ϵͳ�����ļ�
  INI_FILENAME = 'LFHOTEL.ini';
  
type

  TCZY = record
    CzyBh : string;
    CzyXm : string;
  end;

  TPrintStru = record
    AFs      : Integer;
    ATitle   : string;
    ASub     : string;
    ADataSet : TDataSet;
    AColumns : TStringList;
    AFields  : TStringList;
    APosition: TStringList;
  end;

  TCtzt = record
    ACtbh: string;
    ACtmc: string;
    ACtzt: string;
    ADcbh: string;
    AKrxm: string;
    AKrsl: Integer;
    AXfrq: TDateTime;
    AXfsj: TDateTime;
    AJzrq: TDateTime;
    AJzsj: TDateTime;
    AXfje: Currency;
    AColor: TColor;
    AImage: Integer;
    AYdbz : string;
    ASjdm : string;
  end;

  TCtzts = array of TCtzt;
  
  TDcmx = record
    ACdbh: string;
    ACdmc: string;
    AXfsl: Double;
    AThsl: Double;
    ADj  : Currency;
    AXmbh: string;
  end;

  //�������������Ϣ
  TGbkJzxx = record
    AKcje : Currency;
    AJzfs : string;
    AXykbh: string;
    AKhbh : string;
  end;
  
var
  CZY: TCZY;
  PORTNUM: Integer;
  APP_DIR: string;
  IS_YDXS: Boolean;

function GetSjdm(ATime: TDateTime): string;
function AddDH(DH: string) : string;
procedure ShowWarning(AMessage: string);
function Confirm(AMessage: string): Boolean;
function GetMc(const AMc: string): string;
procedure ShowInfo(AMessage: string);

procedure PrintLb(APrintStru: TPrintStru;ADBGrid: TDBGrid);
function GetPYIndexChar( hzchar:string):char;
function GetIndexStr(hzchar:Widestring):string;
function GetHh: string;

implementation

uses C_Sysprint;

function GetHh: string;
begin
  Result := IntToHex(Trunc(TimeStampToMSecs(DateTimeToTimeStamp(Now))),12);
end;

//�������ִ���ƴ����ͷ��д��ĸ�����ú��֣���ʱ��ȷ���Ƿ������д��ĸ��
//�˺���Ƕ����GetPYIndexChar()����
function GetPYIndexChar( hzchar:string):char;
begin
  case WORD(hzchar[1]) shl 8 + WORD(hzchar[2]) of
    $B0A1..$B0C4 : result := 'A';
    $B0C5..$B2C0 : result := 'B';
    $B2C1..$B4ED : result := 'C';
    $B4EE..$B6E9 : result := 'D';
    $B6EA..$B7A1 : result := 'E';
    $B7A2..$B8C0 : result := 'F';
    $B8C1..$B9FD : result := 'G';
    $B9FE..$BBF6 : result := 'H';
    $BBF7..$BFA5 : result := 'J';
    $BFA6..$C0AB : result := 'K';
    $C0AC..$C2E7 : result := 'L';
    $C2E8..$C4C2 : result := 'M';
    $C4C3..$C5B5 : result := 'N';
    $C5B6..$C5BD : result := 'O';
    $C5BE..$C6D9 : result := 'P';
    $C6DA..$C8BA : result := 'Q';
    $C8BB..$C8F5 : result := 'R';
    $C8F6..$CBF9 : result := 'S';
    $CBFA..$CDD9 : result := 'T';
    $CDDA..$CEF3 : result := 'W';
    $CEF4..$D188 : result := 'X';
    $D1B9..$D4D0 : result := 'Y';
    $D4D1..$D7F9 : result := 'Z';
  else
    result := char(0);
  end;
end;

//GetPYIndexChar()����
//�������ֵ�ƴ����ͷ��д��ĸ�����ú��֣���ʱ��ȷ���Ƿ������д��ĸ��
function GetIndexStr(hzchar:Widestring):string;
var
    i:      integer;
    tStr:   WideString;
begin
    for i := 1 to length(hzchar) do
    begin
        tStr := GetPYIndexChar(hzchar[i]);
        if tStr = #0 then
            result := result + UPPERCASE(hzchar[i])
        else
            result := result + LOWERCASE(tStr);
    end
end;

procedure PrintLb(APrintStru: TPrintStru;ADBGrid: TDBGrid);
var
  I,Pos     : Integer;
  AColumns  : TStringList;
  APosition : TStringList;
  AFields   : TStringList;
begin
  AColumns := TStringList.Create;
  try
    APosition := TStringList.Create;
    try
      AFields := TStringList.Create;
      try
        Pos := 10;
        for I:= 0 to ADBGrid.Columns.Count-1 do
        begin
          AColumns.Add(ADBGrid.Columns[I].Title.Caption);
          AFields.Add(ADBGrid.Columns[I].FieldName);
          APosition.Add(IntToStr(Pos));
          Pos := Pos + ADBGrid.Columns[i].Width;
        end;

        APrintStru.AColumns := AColumns;
        APrintStru.AFields  := AFields;
        APrintStru.APosition:= APosition;
        if Pos > 700 then
          APrintStru.AFs      := PRN_LandScape
        else
          APrintStru.AFs      := PRN_Portrait;
        SysPrint(APrintStru);
      finally
        AFields.Free;
      end;
    finally
      APosition.Free;
    end;
  finally
    AColumns.Free;
  end;
end;

procedure ShowInfo(AMessage: string);
begin
  Application.MessageBox(PChar(AMessage),'��ʾ',MB_OK);
end;

function GetMc(const AMc: string): string;
var
  p: Integer;
begin
  p := Pos('|',AMc);
  Result := Copy(AMc,p+1,Length(AMc)-p);
end;


function GetSjdm(ATime: TDateTime): string;
begin
  if (ATime>EnCodeTime(5,0,0,0))and(ATime<EnCodeTime(10,0,0,0)) then
    Result := Morning
  else
  if (ATime>EnCodeTime(10,0,0,0))and(ATime<EnCodeTime(16,0,0,0)) then
    Result := Noon
  else
    Result := Night;
end;

function AddDH(DH: string) : string;
var
  d,s:string;
  n:integer;
begin
  d:= Copy(DH,2,8);
  s:= Copy(DH,10,3);
  n:= StrToInt(s)+1;
  if d <> FormatDateTime('yyyymmdd',Date) then
  begin
    d:= FormatDateTime('yyyymmdd',Date);
    n:= 1;
  end;
  if (n>0) and (n<10) then s:= '00';
  if (n>9) and (n<100) then s:= '0';
  if (n>99) and (n<1000) then s:= '';
  s:= s+IntToStr(n);
  Result:= d+s;
end;

procedure ShowWarning(AMessage: string);
begin
  Application.MessageBox(PChar(AMessage),'����',MB_OK);
end;

function Confirm(AMessage: string): Boolean;
begin
  Result := Application.MessageBox(PChar(AMessage),'����',MB_YESNO) = IDYES;
end;

end.
