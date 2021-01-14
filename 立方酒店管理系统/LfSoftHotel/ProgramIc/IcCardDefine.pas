unit IcCardDefine;

interface

uses
  SysUtils, Classes, DB, DBTables, StdCtrls, DBCtrls, ComCtrls, Forms, Windows;

type
  TCard_Stru = record
    CardId : array[0..5] of Char;
    CardJe : array[0..3] of Char;
  end;
  TCzy = record
    CzyBh: string;
    CzyXm: string;
  end;
  //��ӡ�ṹ
  TPrintStru = record
    AFs      : Integer;
    ATitle   : string;
    ASub     : string;
    ADataSet : TDataSet;
    AColumns : TStringList;
    AFields  : TStringList;
    APosition: TStringList;
  end;

const
  //���ǰ׺
  PREV_YDBH= 'Y';
  PREV_YJBH= 'J';
  PREV_KRBH= 'K';
  PREV_ZDBH= 'Z';
  PREV_JZBH= 'B';

  //������Ŀ
  XMBH_FJ  = '00001';
  XMBH_CF  = '00002';
  XMBH_HCF = '00003';
  XMBH_DHF = '00004';
  XMBH_YJK = '00005';
  XMBH_EWF = '00006';
  
  //���ʷ�ʽ
  JZFS_RMB = '�����';
  JZFS_XYK = '���ÿ�';
  JZFS_ZP  = '֧Ʊ';
  JZFS_JZ  = '����';
  JZFS_GSK = '��ɢ��';
  JZFS_GTD = '���Ŷ�';
  JZFS_WJZ = 'δ����';
  JZFS_ZD  = '�д�';
  JZFS_GBK = '�����';

  //��������
  JZLX_YK  = 'Y';//Ԣ��
  JZLX_FYK = 'F';//��Ԣ��
  JZLX_YSK = 'K';//Ӧ�տ�
  JZLX_YJK = 'J';//Ԥ����

  //Ԥ�����ջ�����
  YJLX_KH = 'K';//�ͻ�Ԥ����
  YJLX_YX = 'J';//Ԥ�Ƚ���
  YJLX_GB = 'G';//�����Ԥ����
  YJLX_SJ = 'S';//��̨�Ͻ�Ԥ����

  //Ԥ���ע
  YJBZ_KH = '�ͻ�Ԥ����';
  YJBZ_YX = 'Ԥ�Ƚ���';
  YJBZ_GB = '�����Ԥ����';
  YJBZ_SJ = 'Ԥ�����Ͻ�';
  
  //��ӡ��ʽ
  PRN_Portrait = 0;
  PRN_LandScape= 1;
  
  //ϵͳ�����ļ�
  INI_FILENAME = 'LFHOTEL.ini';
  
var
  IcDev : Longint;
  OutBuf: PChar;
  InBuf : string;
  CardInfo : TCard_Stru;
  pCardInfo: ^TCard_Stru;
  CZY : TCzy;
  APP_DIR: string;
  PORTNUM : Integer;
  
procedure InitStatus(CommPort: Integer);
procedure ExitComm;
function IsCardExists: Boolean;
function CheckPass: Boolean;
procedure ICDown;
function AddDH(DH: string) : string;
procedure ShowWarning(AMessage: string);
procedure ShowInfo(AMessage: string);
function GetMc(const AMc: string): string;

implementation

uses drv_unit;

function GetMc(const AMc: string): string;
var
  p: Integer;
begin
  p := Pos('|',AMc);
  Result := Copy(AMc,p+1,Length(AMc)-p);
end;

procedure ShowWarning(AMessage: string);
begin
  Application.MessageBox(PChar(AMessage),'����',MB_OK);
end;

procedure ShowInfo(AMessage: string);
begin
  Application.MessageBox(PChar(AMessage),'��ʾ',MB_OK);
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


procedure ICDown;
var
  st: SmallInt;
begin
  st := IC_Down(IcDev);
  if st<>0 then
    raise Exception.Create('�µ�ʧ�ܣ�');
end;

function CheckPass: Boolean;
var
  st: SmallInt;
begin
  InBuf := 'FFFFFF';
  st := IC_CheckPass_4442hex(IcDev,PChar(InBuf));
  if st <> 0 then
    Result := False
  else
    Result := True;
end;

procedure InitStatus(CommPort: Integer);
var
  st: SmallInt;
begin
  IcDev := IC_InitComm(CommPort);
  if IcDev < 0 then
    raise Exception.Create('��ʼ������ʧ�ܣ�');
  st := IC_Status(IcDev);
  if st < 0 then
    raise Exception.Create('��д�����ڴ���');
  if st <> 1 then
  begin
    st := IC_InitType(IcDev,16); //4442
    if st <> 0 then
      raise Exception.Create('IC�����ʹ���');
  end;
end;

function IsCardExists: Boolean;
var
  st: SmallInt;
begin
  st := IC_Status(IcDev);
  if st < 0 then
    raise Exception.Create('��д�����ڴ���');
  if st = 1 then
    Result := False
  else
    Result := True;
end;

procedure ExitComm;
begin
  IC_ExitComm(IcDev);
end;

end.
