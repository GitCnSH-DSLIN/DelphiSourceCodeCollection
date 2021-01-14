unit CommonLib;

interface

uses
  Classes, Windows, Messages, Graphics;

const
  {������������}
  TOPAREACODE = '32%';
  {��������}
  PROVINCELEVEL = 1;
  CITYLEVEL = 2;
  BOROUTHLEVEL = 3;
  RESERVEDLEVEL = 4;

  {����������ʴ���}
  SUPERVISOR_SIGN   = $0001; {���}
  MANU_SIGN         = $0002; {����}
  INST_SIGN         = $0004; {��װ}
  REPAIR_SIGN       = $0008; {ά��}
  VERIFY_SIGN       = $0010; {����}
  VERIFYACCEPT_SIGN = $0020; {����}
  BUILDER_SIGN      = $0040; {����ʩ��}
  BUILDVERIFY_SIGN  = $0080; {��������}
  ASSES_SIGN        = $0100; {����}
  RINSE_SIGN        = $0200; {��ϴ}
  FILL_SIGN         = $0400; {��װ}
  USER_SIGN         = $0800; {ʹ��}
  PROPERTY_SIGN     = $1000; {��Ȩ}
  DESIGN_SIGN       = $2000; {���}
  AUDITOR_SIGN      = $4000; {��ͼ}

  CATEGORY_IDS: array[1..15] of Integer = (SUPERVISOR_SIGN, MANU_SIGN,
    INST_SIGN, REPAIR_SIGN, VERIFY_SIGN, VERIFYACCEPT_SIGN, BUILDER_SIGN,
    BUILDVERIFY_SIGN, ASSES_SIGN, RINSE_SIGN, FILL_SIGN, USER_SIGN,
    PROPERTY_SIGN, DESIGN_SIGN, AUDITOR_SIGN);
  CATEGORY_NAMES: array[1..15] of string = ('���', '����', '��װ', 'ά��',
    '����', '����', '����ʩ��', '��������', '����', '��ϴ', '��װ', 'ʹ��',
    '��Ȩ', '���', '��ͼ');

  {����״̬}
  OS_NORMAL = '01'; {����}

  {�������֤״̬}
  OCS_NORMAL = '01'; {����}
  OCS_TIMEOUT = '02'; {����}
  OCS_LOGOUT = '03'; {ע��}

  {��Ա����״̬}
  PLS_LICNSSTATE = '01';{֤������}
  PLS_LICNSKILL = '02'; {֤�鱻����}
  PLS_NORMAL = '01'; {��Ŀ����}
  PLS_APPLY = '02'; {��Ŀ����}
  PLS_RETEST = '03'; {��Ŀ�ؿ�}
  PLS_LOGOUT = '04'; {��Ŀע��}
  PLS_WELDER = '0113'; {����}

  {�豸״̬��DevState}
  DS_INUSE = '01'; {����}
  DS_STOP = '02'; {ͣ��}
  DS_USELESS = '03'; {����}

  {������ڴ���}
  AM_OCMVIEW = $0001; {���֤�������֤�鿴}
  AM_OCMADD = $0002; {���֤����ȡ֤�Ǽ�}
  AM_OCMCHANGE = $0003; {���֤�������}
  AM_OCMEXCHANGE = $0004; {���֤������֤}
  AM_OCMLOGOUT = $0005; {���֤����ע��}

  AM_PLMVIEW = $0001; {�鿴}
  AM_PLMAPPL = $0002; {����}
  AM_PLMUPDA = $0003; {���}
  AM_PLMCHEC = $0004; {��֤}
  AM_PLMLOGO = $0005; {ע��}
  AM_PLMENGA = $0006; {Ƹ�����}
  AM_PLMISSU = $0007; {��֤}
  AM_PLMLOGI = $0008; {ȡ֤�Ǽ�}

  AM_DMADDDEVICE = $0001; {�豸��������豸}
  AM_DMEDITDEVICE = $0002; {�豸�����޸�/�鿴�豸}
  AM_DMBROWSEDEVICE = $0003; {�豸��������豸}

  AM_VMADDREPORT = $0001; {�������棭��ӱ���}
  AM_VMEDITREPORT = $0002; {�������棭�޸ı���}
  AM_VMDELETEREPORT = $0003; {�������棭ɾ������}

  {�������ܿ��¼�}
  CM_FORCECLOSE = WM_USER + 5000; {ǿ�ƹر��¼��������˳�ʱ����ÿ�����ŵ��Ӵ�
    �壻Ҳ�ɷ���������}
  MSGWP_FORCECLOSE = $1357; {ǿ�ƹر��¼���־�Բ���һ}
  MSGLP_FORCECLOSE = $7531; {ǿ�ƹر��¼���־�Բ�����}

  CM_MENUITEMCLICK = WM_USER + 5002; {�˵�����¼������ɳ����������巢��������
    �Ӷ�ִ����Ӧ���룻�¼�����һ���£�������ΪĿ��˵���Common Bridge�е����}
  MSGWP_MENUITEMCLICK = $2468;

  CM_MFLOADPLUGIN = WM_USER + 5003; {��������¼�����Ϊ������ʱ�������¼�
    ����һ���£�������Ϊ������}
  MSGWP_MFLOADPLUGIN = $1579;

  CM_MFUNLOADPLUGIN = WM_USER + 5004; {���ж���¼�����Ϊж�ز��ǰ�������¼�
    ����һ���£�������Ϊ������}
  MSGWP_MFUNLOADPLUGIN = $9751;

  {ϵͳ�����ʶ��}
  PLUGIN_INTQUERY = 'BPAIntQuerySpr';
  PLUGIN_EXTQUERY = 'BPAExtQuerySpr';
  PLUGIN_COMM = 'PlgBpaComm';

  {ϵͳ�ļ�·��}
  PLUGIN_DIR = 'plugin';
  PLUGIN_PATH = 'plugin\';
  SYSFILES_DIR = 'sysfiles';
  REPORTS_DIR = 'reports';
  SYSFILES_PATH = 'sysfiles\';
  REPORTS_PATH = 'reports\';
  TECHINFO_NAME = 'techinfo.ini';
  USERCONFIG_NAME = 'bpaspruc.ini';

  {ϵͳע���ڵ���}
  RK_ROOT = 'Software\RHXINXI\BpaSpr';
  RK_MENUOPTION = RK_ROOT + '\MenuOption';

  {ϵͳ��ɫ����}
  CL_OCSLOGOUT = clRed;

  CL_DSSTOP = clBlue;
  CL_DSUSELESS = clRed;

  CL_CONFIRM = clMedGray;
  
type
  TCSComnBridge = class
  private
    F_Handle: HWND;
    Fs_Tag: string;
    Fc_Process: TNotifyEvent;
    procedure SetProc(const Value: TNotifyEvent);
  public
    constructor Create(const A_Handle: HWND; const As_Tag: string;
      const Ac_Proc: TNotifyEvent);
    property Handle: HWND read F_Handle;
    property Tag: string read Fs_Tag;
    property Proc: TNotifyEvent read Fc_Process write SetProc;
  end;
  TCSComnBridges = class
  private
    Fc_Items: TList;
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(const A_Handle: HWND; const As_Tag: string;
      const Ac_Proc: TNotifyEvent): TCSComnBridge;
    procedure Delete(const A_Handle: HWND; const As_Tag: string);
    function Items(const A_Handle: HWND; const As_Tag: string): TCSComnBridge;
      overload;
    function Items(const Ai_Index: Integer): TCSComnBridge; overload;
    function IndexOf(const A_Handle: HWND; const As_Tag: string): Integer;
    property Count: Integer read GetCount;
  end;

procedure Gp_LoadUserConfig;
procedure Gp_SaveUserConfig;
procedure Gp_ProgressHint(const As_Hint: string = '');
procedure Gp_EhGrdNoExportSelectMsg;
procedure Gp_NCAddCompleteMsg(const As_Caption: string);

function Gf_GenSysId: string;

var
  Gs_AppDir: string;
  Gs_AppPath: string;
  Gs_DBMS: string;
  Gs_DBDRV: string;
  Gc_ComnBridges: TCSComnBridges;

  {���Զ�������}
  //TODO: To be modified in future
  SYSIDHEAD: string; //ϵͳ��ʶͷ
  MAXIMIZEDBYDEFAULT: Boolean; //�Ӵ����ʱĬ�����
  MAXIMIZEMODALBYDEF: Boolean; //ģʽ�����ʱĬ�����
  GENDEVCIDBYARITHMETIC: Boolean; //ʹ���㷨�����豸�û����

implementation

uses
  Controls, Forms, SysUtils, IniFiles;

const
  GBS = 'General Behaviour';

{ Gp_LoadUserConfig }

procedure Gp_LoadUserConfig;
var
  lc_IniFile: TIniFile;
begin
  lc_IniFile := TIniFile.Create(Gs_AppPath + USERCONFIG_NAME);
  with lc_IniFile do
    try
      //TODO: To be modified in future
      SYSIDHEAD := ReadString(GBS, 'SYSIDHEAD', '');
      if Length(Trim(SYSIDHEAD)) <> 3 then
        raise Exception.Create('ϵͳ��ʶ�����ʧ');
      MAXIMIZEDBYDEFAULT := ReadBool(GBS, 'MAXIMIZEDBYDEFAULT', False);
      MAXIMIZEMODALBYDEF := ReadBool(GBS, 'MAXIMIZEMODALBYDEF', False);
      GENDEVCIDBYARITHMETIC := ReadBool(GBS, 'GENDEVCIDBYARITHMETIC', False);
    finally
      Free;
    end;
end;

{ Gp_SaveUserConfig }

procedure Gp_SaveUserConfig;
var
  lc_IniFile: TIniFile;
begin
  lc_IniFile := TIniFile.Create(Gs_AppPath + USERCONFIG_NAME);
  with lc_IniFile do
    try
      WriteBool(GBS, 'MAXIMIZEDBYDEFAULT', MAXIMIZEDBYDEFAULT);
      WriteBool(GBS, 'MAXIMIZEMODALBYDEF', MAXIMIZEMODALBYDEF);
      WriteBool(GBS, 'GENDEVCIDBYARITHMETIC', GENDEVCIDBYARITHMETIC);
    finally
      Free;
    end;
end;

{ Gp_ProgressHint }

var Gs_PrevHint: string;

//As_Hint = '' to set hint back
procedure Gp_ProgressHint(const As_Hint: string);
begin
  if As_Hint <> '' then Screen.Cursor := crHourGlass;
  with Application do
  begin
    if As_Hint <> '' then
    begin
      Gs_PrevHint := Hint;
      Hint := As_Hint;
    end else Hint := Gs_PrevHint;
    MainForm.Update;
  end;
  if As_Hint = '' then Screen.Cursor := crDefault;
end;

{ Gp_EhGrdNoExportSelectMsg }

procedure Gp_EhGrdNoExportSelectMsg;
begin
  Application.MessageBox(PChar('���б�����û��ѡ��Ҫ���������ݣ������б���' +
    '�ڰ�ס���������ţ�'#13#10'Ȼ���϶������ѡ��Ҫ���������ݣ�ѡ�е�����' +
    '����ɫ������ʾ��Ҳ'#13#10'���Ե����б��������Ͻ�С������ѡ��ȫ�����ݡ�'),
    PChar('���ݵ���'), MB_OK + MB_ICONWARNING);
end;

{ Gp_NCAddCompleteMsg }

procedure Gp_NCAddCompleteMsg(const As_Caption: string);
begin
  Application.MessageBox(PChar(Format('���������ϡ����������Լ���ѡ�����' +
    '����Ҫ��ӵ����ݣ�Ҫ�޸�����ӵ��������ڵ�� ȷ�� ��ť���� �ر� ��ť��' +
    '��%s�Ի���', [As_Caption])), '���', MB_OK + MB_ICONINFORMATION);
end;

{ Gf_GenSysId }

function Gf_GenSysId: string;
begin
  Result := SYSIDHEAD + FormatDateTime('yyyymmddhhnnsszzz', Now);
end;

{ TCSComnBridge }

constructor TCSComnBridge.Create(const A_Handle: HWND; const As_Tag: string;
  const Ac_Proc: TNotifyEvent);
begin
  F_Handle := A_Handle;
  Fs_Tag := As_Tag;
  Fc_Process := Ac_Proc;
end;

procedure TCSComnBridge.SetProc(const Value: TNotifyEvent);
begin
  Fc_Process := Value;
end;

{ TCSComnBridges }

function TCSComnBridges.Add(const A_Handle: HWND; const As_Tag: string;
  const Ac_Proc: TNotifyEvent): TCSComnBridge;
begin
  Result := TCSComnBridge.Create(A_Handle, As_Tag, Ac_Proc);
  Fc_Items.Add(Result);
end;

constructor TCSComnBridges.Create;
begin
  Fc_Items := TList.Create;
end;

procedure TCSComnBridges.Delete(const A_Handle: HWND; const As_Tag: string);
var
  li_Index: Integer;
  lc_Item: TCSComnBridge;
begin
  with Fc_Items do
    for li_index := 0 to Count - 1 do
    begin
      lc_Item := TCSComnBridge(Items[li_Index]);
      if (lc_Item.Handle = A_Handle) and (lc_Item.Tag = As_Tag) then
      begin
        lc_Item.Free;
        Delete(li_Index);
        Break;
      end;
    end;
end;

destructor TCSComnBridges.Destroy;
begin
  with Fc_Items do
    while Count > 0 do
    begin
      TCSComnBridge(Items[0]).Free;
      Delete(0);
    end;
  Fc_Items.Destroy;
  inherited;
end;

function TCSComnBridges.GetCount: Integer;
begin
  Result := Fc_Items.Count;
end;

function TCSComnBridges.IndexOf(const A_Handle: HWND;
  const As_Tag: string): Integer;
var
  li_Index: Integer;
  lc_Item: TCSComnBridge;
begin
  Result := -1;
  with Fc_Items do
    for li_Index := 0 to Count - 1 do
    begin
      lc_Item := TCSComnBridge(Items[li_Index]);
      if (lc_Item.Handle = A_Handle) and (lc_Item.Tag = As_Tag) then
      begin
        Result := li_Index;
        Break;
      end;
    end;
end;

function TCSComnBridges.Items(const A_Handle: HWND;
  const As_Tag: string): TCSComnBridge;
var
  li_Index: Integer;
begin
  li_Index := IndexOf(A_Handle, As_Tag);
  if li_Index >= 0 then Result := TCSComnBridge(Fc_Items.Items[li_Index])
  else Result := nil;
end;

function TCSComnBridges.Items(const Ai_Index: Integer): TCSComnBridge;
begin
  Result := TCSComnBridge(Fc_Items.Items[Ai_Index]);
end;

end.
