unit ScriptExecutor;

interface

{$WARN SYMBOL_PLATFORM OFF}
  
uses
  Windows, Messages, Classes, SysUtils, Forms, Dialogs, ScriptParser,
  NetworkLayer, Global;

type

{ TScriptExecutor }

  TDnStateChangedEvent = procedure(Sender: TObject; FileIndex: Integer) of object;

  TScriptExecutor = class(TObject)
  private
    FHttpClient: THttpClient;
    FScriptResult: TScriptResult;
    FCheckedUpgrade: Boolean;
    FBeforeDownload: TDnStateChangedEvent;
    FAfterDownload: TDnStateChangedEvent;

    procedure DownloadFiles;
    procedure TerminateOwner;
    procedure PerformActions;
    procedure RunExeFile;
    function CheckSelfUpgrade(const SrcFileName, DestFileName: string): Boolean;
  public
    constructor Create(HttpClient: THttpClient; ScriptResult: TScriptResult);
    destructor Destroy; override;

    procedure CheckUpgrade;
    procedure Execute;

    property BeforeDownload: TDnStateChangedEvent read FBeforeDownload write FBeforeDownload;
    property AfterDownload: TDnStateChangedEvent read FAfterDownload write FAfterDownload;
  end;

implementation

uses PubUtils;

function MyMoveFile(const SrcFileName, DestFileName: string): Boolean;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    Result := MoveFileEx(PChar(SrcFileName), PChar(DestFileName),
      MOVEFILE_COPY_ALLOWED or MOVEFILE_REPLACE_EXISTING or MOVEFILE_WRITE_THROUGH);
  end else
  begin
    Result := MoveFile(PChar(SrcFileName), PChar(DestFileName));
    if not Result then
    begin
      Result := CopyFile(PChar(SrcFileName), PChar(DestFileName), False);
      if Result then DeleteFile(SrcFileName);
    end;
  end;
end;

{ TScriptExecutor }

constructor TScriptExecutor.Create(HttpClient: THttpClient;
  ScriptResult: TScriptResult);
begin
  inherited Create;
  FHttpClient := HttpClient; 
  FScriptResult := ScriptResult;
end;

destructor TScriptExecutor.Destroy;
begin
  inherited;
end;

//-----------------------------------------------------------------------------
// ����: �����°�����ļ�
//-----------------------------------------------------------------------------
procedure TScriptExecutor.DownloadFiles;
var
  I: Integer;
  FileStream: TFileStream;
begin
  with FScriptResult do
  begin
    try
      for I := 0 to Length(DownloadItems) - 1 do
      begin
        ForceDirectories(ExtractFilePath(DownloadItems[I].DestFile));
        FileStream := TFileStream.Create(DownloadItems[I].DestFile, fmCreate or fmShareDenyWrite);
        try
          if Assigned(FBeforeDownload) then FBeforeDownload(Self, I);
          FHttpClient.Get(DownloadItems[I].SourceURL, FileStream);
          if Assigned(FAfterDownload) then FAfterDownload(Self, I);
        finally
          FileStream.Free;
        end;
      end;
    except
      on E: Exception do
      begin
        for I := 0 to Length(DownloadItems) - 1 do
          DeleteFile(DownloadItems[I].DestFile);
        raise Exception.CreateFmt('�����ļ�ʧ�ܡ�'#13#13'������Ϣ: '#13'%s', [E.Message]);
      end;
    end;
  end;
end;

//-----------------------------------------------------------------------------
// ����: ��ֹ��������
//-----------------------------------------------------------------------------
procedure TScriptExecutor.TerminateOwner;

  function WindowExists(WinHandle: THandle): Boolean;
  var
    Handle: THandle;
  begin
    Result := False;
    Handle := GetDesktopWindow;
    Handle := GetWindow(Handle, GW_CHILD);
    while IsWindow(Handle) do
    begin
      if Handle = WinHandle then
      begin
        Result := True;
        Break;
      end;
      Handle := GetWindow(Handle, GW_HWNDNEXT);
    end;
  end;

  // �ȴ����������˳��������˳��򷵻� True
  function WaitProgramExit(WinHandle: THandle): Boolean;
  const
    MaxWaitMSecs = 3000;   // ��ȴ�ʱ��(����)
    MSecsPerLoop = 200;    // ÿ��ѭ���ȴ�ʱ��(����)
  var
    I: Integer;
  begin
    Result := False;
    // �ȴ����������˳�
    for I := 1 to (MaxWaitMSecs div MSecsPerLoop) do
      if WindowExists(WinHandle) then
        Sleep(MSecsPerLoop)
      else begin
        Result := True;
        Break;
      end;
  end;

  // ǿ���˳���������
  procedure ForceProgramExit(ProcessID: Cardinal);
  var
    Handle: THandle;
    ExitCode: Cardinal;
  begin
    Handle := OpenProcess(PROCESS_ALL_ACCESS, True, ProcessID);
    GetExitCodeProcess(Handle, ExitCode);
    TerminateProcess(Handle, ExitCode);
  end;

var
  Exited: Boolean;
begin
  // ֪ͨ���������˳�
  SendMessage(CmdParams.WinHandle, CmdParams.ExitMsgID, 0, 0);
  // �ȴ����������˳�
  Exited := WaitProgramExit(CmdParams.WinHandle);
  // ǿ���˳���������
  if not Exited then ForceProgramExit(CmdParams.ProcessID);
end;

//-----------------------------------------------------------------------------
// ����: ִ����������
//-----------------------------------------------------------------------------
procedure TScriptExecutor.PerformActions;
var
  I, FileAttr: Integer;
begin
  with FScriptResult do
  begin
    for I := 0 to Length(ActionItems) - 1 do
    begin
      case ActionItems[I].ActionType of
        satExecute:
          begin
            ExecuteFile(ActionItems[I].FileName1, '', '', SW_SHOW);
          end;
        satReplace:
          begin
            ForceDirectories(ExtractFilePath(ActionItems[I].FileName2));
            if not CheckSelfUpgrade(ActionItems[I].FileName1, ActionItems[I].FileName2) then
            begin
              if not MyMoveFile(ActionItems[I].FileName1, ActionItems[I].FileName2) then
                raise Exception.Create('�޷������ļ������˳��ɰ����');
            end;
          end;
        satAdd:
          begin
            if not FileExists(ActionItems[I].FileName2) then
            begin
              ForceDirectories(ExtractFilePath(ActionItems[I].FileName2));
              if not MyMoveFile(ActionItems[I].FileName1, ActionItems[I].FileName2) then
                raise Exception.Create('�����ļ�ʧ�ܡ�');
            end;
          end;
        satDelete:
          begin
            // ȥ��Ŀ���ļ���ֻ��������
            FileAttr := FileGetAttr(ActionItems[I].FileName1);
            FileSetAttr(ActionItems[I].FileName1, FileAttr and not faReadOnly and not faHidden and not faSysFile);
            // ����ɾ���ļ�
            if not DeleteFile(ActionItems[I].FileName1) then
              raise Exception.Create('ɾ���ļ�ʧ�ܣ����˳��ɰ����');
          end;
      end;
    end;
  end;
end;

//-----------------------------------------------------------------------------
// ����: ������Ϻ�ִ��ָ�� exe �ļ�
//-----------------------------------------------------------------------------
procedure TScriptExecutor.RunExeFile;
begin
  with FScriptResult do
  begin
    if Length(RunFileName) > 0 then
      ExecuteFile(RunFileName, '', '', SW_SHOW);
  end;
end;

//-----------------------------------------------------------------------------
// ����: ����Ƿ���Ҫ������ (��������������Ҳ��Ҫ����)
// ����: ����Ҫ�������򷵻�True
//-----------------------------------------------------------------------------
function TScriptExecutor.CheckSelfUpgrade(const SrcFileName, DestFileName: string): Boolean;
begin
  Result := SameText(GetFullFileName(Application.ExeName), GetFullFileName(DestFileName));
  if Result then
  begin
    SelfUpgFiles.SrcFileName := GetFullFileName(SrcFileName);
    SelfUpgFiles.DestFileName := GetFullFileName(DestFileName);
  end;
end;

//-----------------------------------------------------------------------------
// ����: ����Ƿ���Ҫ���� �� �Ƿ�������
// ��ע: ������������������׳��쳣��
//-----------------------------------------------------------------------------
procedure TScriptExecutor.CheckUpgrade;
begin
  FCheckedUpgrade := True;
  if CmdParams.CurVersion >= FScriptResult.NewVersion then
    raise Exception.Create('��ǰ�汾������߰汾������������');

  if FScriptResult.SupportVer.IndexOf(CmdParams.CurVersion) = -1 then
    raise Exception.Create('�Բ��𣬵�ǰ�汾̫�ɣ����޷��������������¼�ٷ���վ�������°汾��');
end;

procedure TScriptExecutor.Execute;
begin
  if not FCheckedUpgrade then
    CheckUpgrade;
  DownloadFiles;
  TerminateOwner;
  PerformActions;
  RunExeFile;
end;

end.
