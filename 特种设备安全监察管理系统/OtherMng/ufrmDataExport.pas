unit ufrmDataExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleServer, pbplsrv_TLB, Buttons, ExtCtrls, DB, ADODB,
  CSADOQuery, CSPrgViewer;

const
  UNIT_NUM = 21;
  
type
  TfrmDataExport = class(TForm)
    DataExport: TCOCls_n_pbplsrv;
    Panel1: TPanel;
    bbtnExport: TBitBtn;
    Panel2: TPanel;
    bbtnHelp: TBitBtn;
    bbtnClose: TBitBtn;
    mLog: TMemo;
    SPExec: TCSADOQuery;
    PrgViewer: TCSPrgViewer;
    procedure bbtnExportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbtnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Fia_Counts: array[1..UNIT_NUM] of Integer;
    Fs_SysPath, Fs_ConnStr, Fs_TemplateFile, Fs_ExportFile,
    Fs_BufferFile: string;
    procedure prip_LogToMemo(const As_Msg: string;
      const Ab_BlankLine: Boolean = True);
    function prif_CreateLocalDB: Boolean;
    function prif_DeleteLocalDB: Boolean;
    function prif_CreateDataLinkFile(const As_FileName: string;
      const As_ConnStr: WideString): Boolean;
    procedure prip_DeleteDataLinkFile(const As_FileName: string);
    function prif_CreateBufferFile: Boolean;
    function prif_CopyBufferFileToExportFile: Boolean;
    procedure prip_Export;
    procedure prip_SendFile;
  public
    { Public declarations }
  end;

var
  frmDataExport: TfrmDataExport;

implementation

uses
  Registry, IniFiles, CSUtils, udmData, CommonLib, CommService,
  OtherMng_PBCCommon;

{$R *.dfm}

const
  START_DATE = 'START_DATE';
  END_DATE = 'END_DATE';

  TEMPLATE_FILE = 'jck001.mdb';
  EXPORT_FILE = 'ejck001%s%s.mdb';
  DATALINKFILESRC = 'srcdb.udl';
  DATALINKFILEDEST = 'destdb.udl';

  GET_SQL = 'device.xo01_usp_get_data';
  RESET_SQL = 'device.xo01_usp_reset_data';

  PL_OBJS: array[1..UNIT_NUM] of WideString = (
    'pl_xo01_equipment_info',
    'pl_xo01_organ_baseinfo',
    'pl_xo01_organ_contact',
    'pl_xo01_organ_cert',
    'pl_xo01_organ_cert_prj',
    'pl_xo01_organ_cert_prj_modal',
    'pl_xo01_organ_requirement',
    'pl_xo01_organ_authinfo',
    'pl_xo01_organ_cert_prd',
    'pl_xo01_organ_cert_dept',
    'pl_xo01_organ_cert_equip',
    'pl_xo01_organ_cert_const',
    'pl_xo01_organ_cert_doc',
    'pl_xo01_organ_cert_psn',
    'pl_xo01_person_baseinfo',
    'pl_xo01_person_test',
    'pl_xo01_person_engage_prj',
    'pl_xo01_person_check_prj',
    'pl_xo01_person_infract_info',
    'pl_xo01_person_license',
    'pl_xo01_person_license_prj');
  PL_TIPS: array[1..UNIT_NUM] of string = (
    '�豸������Ϣ',
    '��λ������Ϣ',
    '��λ��ϵ��Ϣ',
    '�������֤������Ϣ',
    '�������֤��Ŀ',
    '�������֤��Ŀ��ʽ',
    '�������֤������Ϣ',
    '������֤��Ϣ',
    '�����������',
    '�����������',
    '���������豸�������������',
    '�����ְ���Э���',
    '�����ļ��������',
    '������Ա���',
    '��Ա������Ϣ',
    '��Ա��ѵ������Ϣ',
    '��ԱƸ���ʸ���Ŀ',
    '��Ա��鱸��',
    '��Ա�ʸ�Υ���¼',
    '��Ա������Ϣ',
    '��Ա������Ŀ��Ϣ');

{ TfrmDataExport }

procedure TfrmDataExport.FormCreate(Sender: TObject);
var
  li_i: Integer;
begin
  for li_i := 1 to UNIT_NUM do Fia_Counts[li_i] := 0;
  Fs_SysPath := GetWinSysPath;
  Fs_TemplateFile := Gs_AppPath + 'Template\' + TEMPLATE_FILE;
  Fs_ExportFile := Gs_AppPath + 'Data\' + Format(EXPORT_FILE,
    [LowerCase(SYSIDHEAD), FormatDateTime('yyyymmdd', Now)]);
  Fs_BufferFile := Gs_AppPath + 'Buffer\' + Format(EXPORT_FILE,
    [LowerCase(SYSIDHEAD), FormatDateTime('yyyymmdd', Now)]);
  Fs_ConnStr := dmData.adocon.ConnectionString;
end;

function TfrmDataExport.prif_CreateLocalDB: Boolean;
var
  li_i: Integer;
begin
  Screen.Cursor := crHourGlass;
  prip_LogToMemo('�����ռ�����...');
  try
    with SPExec do
    begin
      if Active then Close;
      SQL.Text := GET_SQL;
      Open;
      for li_i := 1 to UNIT_NUM do
        Fia_Counts[li_i] := Fields[li_i - 1].AsInteger;
    end;
    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
      Application.MessageBox(PChar(E.Message), PChar(Caption),
        MB_OK + MB_ICONERROR);
      prip_LogToMemo(E.Message);
    end;
  end;
  Screen.Cursor := crDefault;
end;

function TfrmDataExport.prif_DeleteLocalDB: Boolean;
begin
  Screen.Cursor := crHourGlass;
  try
    dmData.adocon.Execute(RESET_SQL);
    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
      Application.MessageBox(PChar(E.Message), PChar(Caption),
        MB_OK + MB_ICONERROR);
      prip_LogToMemo(E.Message);
    end;
  end;
  Screen.Cursor := crDefault;
end;

function TfrmDataExport.prif_CreateBufferFile: Boolean;
var
  ls_SrcFile, ls_ErrMsg: string;
begin
  if FileExists(Fs_ExportFile) then ls_SrcFile := Fs_ExportFile
  else ls_SrcFile := Fs_TemplateFile;
  Result := CopyFile(PChar(ls_SrcFile), PChar(Fs_BufferFile), False);
  if not Result then
  begin
    ls_ErrMsg := SysErrorMessage(GetLastError) + '  ' + ls_SrcFile +
      ' => ' + Fs_BufferFile;
    Application.MessageBox(PChar(ls_ErrMsg), PChar(Caption),
      MB_OK + MB_ICONERROR);
  end;
end;

function TfrmDataExport.prif_CopyBufferFileToExportFile: Boolean;
var
  ls_ErrMsg: string;
begin
  Result := CopyFile(PChar(Fs_BufferFile), PChar(Fs_ExportFile), False);
  if not Result then
  begin
    ls_ErrMsg := SysErrorMessage(GetLastError) + '  ' + Fs_BufferFile +
      ' => ' + Fs_ExportFile;
    Application.MessageBox(PChar(ls_ErrMsg), PChar(Caption),
      MB_OK + MB_ICONERROR);
  end;
end;

procedure Gp_MsgHandler(Ac_MsgReciever: TComponent; const Ai_Msg: Integer;
  Ac_Args: TStrings);
begin
  with Ac_MsgReciever as TfrmDataExport do
    case Ai_Msg of
      BPACOMM_MSG_CLNWB:
        begin
          PrgViewer.Start(0, Integer(Ac_Args.Strings[0]), '���ڷ����ļ�...');
          mLog.Lines.Add(Ac_Args.Strings[0]);
        end;
      BPACOMM_MSG_CLNWK:
        PrgViewer.MainStep := Integer(Ac_Args.Strings[0]);
      BPACOMM_MSG_CLNWE:
        begin
          PrgViewer.MainStep := PrgViewer.MainMax;
          mLog.Lines.Add('EndWork recieved');
        end;
    end;
end;

procedure TfrmDataExport.prip_Export;
var
  li_i, li_rc: Integer;
  ls_ErrMsg: string;
  ls_Path, ls_Msg: WideString;
begin
  mLog.Clear;

  li_rc := -1;
  ls_Msg := ' ';
  with DataExport do
  begin
    Connect;
    try
      if not prif_CreateLocalDB then Exit;
      if not prif_CreateBufferFile then Exit;

      ls_Path := Gs_AppPath;
      if not initialize(ls_Path, ls_Path) then
      begin
        ls_Msg := '��ʼ��ʧ��';
        Exit;
      end;

      setprogressmodetext;

      setconnoledbsrc(WideFormat('DATALINK=''%s'',' +
        'INIT_PROMPT=''DBPROMPT_NOPROMPT''', [Gs_AppPath + DATALINKFILESRC]),
        False, ' ', ' ');
      setconnoledbdest(WideFormat('DATALINK=''%s'',' +
        'INIT_PROMPT=''DBPROMPT_NOPROMPT''', [Gs_AppPath + DATALINKFILEDEST]),
        False, ' ', ' ');

      prip_LogToMemo('��Դ����...', False);
      if not prif_CreateDataLinkFile(DATALINKFILESRC, WideFormat(
        '%s;Password=%s', [dmData.adocon.ConnectionString,
        dmData.pubf_GetConnPwd])) then Exit;
      try
        if not opensrcwithmsg(ls_Msg) then Exit;
      finally
        prip_DeleteDataLinkFile(DATALINKFILESRC);
      end;

      prip_LogToMemo('��Ŀ������...');
      if not prif_CreateDataLinkFile(DATALINKFILEDEST, WideFormat('Provider=' +
        'Microsoft.Jet.OLEDB.4.0;Data Source=%s;User ID=Admin',
        [Fs_BufferFile])) then Exit;
      try
        if not opendestwithmsg(ls_Msg) then Exit;
      finally
        prip_DeleteDataLinkFile(DATALINKFILEDEST);
      end;

      prip_LogToMemo('��������...');
      for li_i := 1 to UNIT_NUM do
      begin
        loaddataobject(PL_OBJS[li_i]);
        setparams(PL_TIPS[li_i], 0);
        prip_LogToMemo(Format('���ڵ���%s...', [PL_TIPS[li_i]]), False);
        li_rc := startwithmsg(ls_Msg);
        if li_rc <> 1 then Break;
        prip_LogToMemo(Format('����%s��ɣ�%d����¼', [PL_TIPS[li_i],
          Fia_Counts[li_i]]));
      end;

      closeprogress;
      closedest;
      closesrc;

      if not prif_CopyBufferFileToExportFile then Exit;
    finally
      try
        closeprogress;
        closedest;
        closesrc;
      except
      end;

      if li_rc = 1 then
      begin
        Application.MessageBox('���ݵ����ɹ�', PChar(Caption),
          MB_OK + MB_ICONINFORMATION);
      end else if ls_Msg <> ' ' then begin
        ls_ErrMsg := ls_Msg;
        Application.MessageBox(PChar(ls_ErrMsg), PChar(Caption),
          MB_OK + MB_ICONERROR);
        prip_LogToMemo(ls_ErrMsg);
      end;

      prif_DeleteLocalDB;

      Disconnect;
    end;
  end;

  if li_rc = 1 then
  begin
    if Application.MessageBox('�Ƿ��������͵������ļ�?', '��������',
      MB_YESNO + MB_ICONQUESTION) = IDNO then Exit;

    prip_SendFile;
  end;
end;

procedure TfrmDataExport.bbtnExportClick(Sender: TObject);
begin
  prip_Export;
end;

procedure WriteWideStringLine(const Ac_File: TFileStream; As_Line: WideString);
const
  BUFSIZE = 64;
var
  li_i, li_j, li_Length, li_BufLen, li_Times, li_PassLen: Integer;
  lc_Line: PChar;
  lc_Buf: array[1..BUFSIZE] of Char;
begin
  As_Line := As_Line + WideFormat('%s', [#13#10]);
  li_Length := Length(As_Line) * 2;
  lc_Line := Pointer(As_Line);

  li_Times := li_Length div BUFSIZE;
  if li_Length mod BUFSIZE <> 0 then Inc(li_Times);

  for li_i := 1 to li_Times do
  begin
    li_PassLen := (li_i - 1) * BUFSIZE;
    
    if li_i = li_Times then li_BufLen := li_Length - li_PassLen
    else li_BufLen := BUFSIZE;

    for li_j := 1 to li_BufLen do
      lc_Buf[li_j] := (lc_Line + li_PassLen + li_j - 1)^;

    Ac_File.Write(lc_Buf, li_BufLen);
  end;
end;

function TfrmDataExport.prif_CreateDataLinkFile(const As_FileName: string;
  const As_ConnStr: WideString): Boolean;
var
  lc_Buf: array[1..2] of Char;
  lc_File: TFileStream;
begin
  lc_File := TFileStream.Create(Gs_AppPath + As_FileName, fmCreate);
  try
    lc_Buf[1] := Char(255);
    lc_Buf[2] := Char(254);
    lc_File.Write(lc_Buf, 2);
    WriteWideStringLine(lc_File, '[oledb]');
    WriteWideStringLine(lc_File,
      '; Everything after this line is an OLE DB initstring');
    WriteWideStringLine(lc_File, As_ConnStr);
    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
      Application.MessageBox(PChar(E.Message), PChar(Caption),
        MB_OK + MB_ICONERROR);
    end;
  end;
  lc_File.Free;
end;

procedure TfrmDataExport.bbtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDataExport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TfrmDataExport.prip_DeleteDataLinkFile(const As_FileName: string);
begin
  if FileExists(Gs_AppPath + As_FileName) then
    DeleteFile(Gs_AppPath + As_FileName);
end;

procedure TfrmDataExport.prip_SendFile;
var
  li_rc: Integer;
  ls_ErrMsg: string;
begin
  prip_LogToMemo('�������ӷ����������Ժ�...');

  li_rc := Gc_ClientService.pubf_Connect(ls_ErrMsg, False, False, Self,
    Gp_MsgHandler);
  if li_rc = PLGBPACOMM_RTC_CLNCNERR then
  begin
    prip_LogToMemo(Format('���ӷ�����ʧ�ܣ�%s', [ls_ErrMsg]));
    Exit;
  end;

  prip_LogToMemo('��ʼ�����ļ�...');
  try
    li_rc := Gc_ClientService.pubf_SendFile(Fs_ExportFile, ls_ErrMsg);
    if li_rc = PLGBPACOMM_RTC_CLNSFERR then
      prip_LogToMemo(Format('�����ļ�ʧ�ܣ�%s', [ls_ErrMsg]))
    else prip_LogToMemo('�����ļ��ɹ�');
  finally
    try
      prip_LogToMemo('�Ͽ��������������...');
      Gc_ClientService.pubp_DisConnect;
      prip_LogToMemo('��������������ѶϿ�');
    except
    end;
    PrgViewer.Finish;
  end;
end;

procedure TfrmDataExport.prip_LogToMemo(const As_Msg: string;
  const Ab_BlankLine: Boolean);
begin
  mLog.Lines.Add(As_Msg);
  if Ab_BlankLine then mLog.Lines.Add('');
  mLog.Update;
end;

end.
