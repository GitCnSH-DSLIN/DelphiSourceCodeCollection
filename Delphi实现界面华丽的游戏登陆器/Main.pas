unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, RzForms, Buttons, RzButton, shellapi, RzBmpBtn,
  StdCtrls, RzCmboBx, IniFiles, RzLabel, winsock, Sockets, OleCtrls, SHDocVw,
  ComCtrls, ShlObj, ComObj, ActiveX, Registry, RzRadChk, Mask, RzEdit, JSocket,
  RzLstBox, Grobal2, Share, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP;
////////////////////////////////�������Ƿ��Ѿ����й������ݶ���////////////////
const
  MI_QUERYWINDOWHANDLE = 1;
  MI_RESPONDWINDOWNHANDLE = 2;
  MI_ERROR_NONE = 0;
  MI_ERROR_FAILSUBCLASS = 1;
  MI_ERROR_CREATINGMUTEX = 2;
  ////////////////////////////////////////////////////////////////////////////////
type
  TMainForm = class(TForm)
    WebBrowser1: TWebBrowser;
    Image1: TImage;
    ClientSocket: TClientSocket;
    MsgLabel: TLabel;
    ButtonNewAccount: TRzButton;
    StartMirButton: TRzButton;
    ListBoxServerList: TRzListBox;
    ClientTimer: TTimer;
    RzFormShape1: TRzFormShape;
    ButtonMin: TRzToolButton;
    ButtonClose: TRzToolButton;
    ButtonGetBackPassword: TRzButton;
    ButtonChgPassword: TRzButton;
    ButtonLocalStart: TRzButton;
    ButtonHomePage: TRzButton;
    ButtonAddGame: TRzButton;
    TimerGetGameList: TTimer;
    IdHTTP: TIdHTTP;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ButtonMinClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure CreateUlr;
    procedure ButtonNewAccountClick(Sender: TObject);
    procedure ClientTimerTimer(Sender: TObject);
    procedure ButtonChgPasswordClick(Sender: TObject);
    procedure ButtonGetBackPasswordClick(Sender: TObject);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);

    procedure SendUpdateAccount(ue: TUserEntry; ua: TUserEntryAdd);
    procedure SendGetBackPassword(sAccount, sQuest1, sAnswer1,
      sQuest2, sAnswer2, sBirthDay: string);
    procedure SendChgPw(sAccount, sPasswd, sNewPasswd: string);
    procedure DecodeMessagePacket(datablock: string);
    procedure SendCSocket(sendstr: string);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketConnecting(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ButtonLocalStartClick(Sender: TObject);
    procedure ListBoxServerListClick(Sender: TObject);
    procedure ListBoxServerListDblClick(Sender: TObject);
    procedure StartMirButtonClick(Sender: TObject);
    procedure ButtonAddGameClick(Sender: TObject);
    procedure TimerGetGameListTimer(Sender: TObject);
    procedure ListBoxServerListDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure IdHTTPWork(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure ButtonHomePageClick(Sender: TObject);
  private
    HotKeyId: Integer;
    dwClickTick: LongWord;
    procedure HotKeyDown(var Msg: Tmessage); message WM_HOTKEY;
    function GetDownFileName1(DownAddr: string): string;
    function WriteMirInfo(MirPath: string; GameZone: pTGameZone): Boolean;
    procedure LoadGameList();
    procedure UnLoadGameList();
  public
    procedure LoadLocalGameList;
    procedure UnLoadLocalGameList;
    procedure LoadGameListToBox;
    procedure GetServerInfo(sLineText: string; var g_GameZone: pTGameZone);
  end;
var
  MainForm: TMainForm;
  MakeNewAccount: string;
  code: byte = 1;
  SocStr, BufferStr: string;
  Myself: TObject = nil;
  Myinifile: TInIFile;
  ////////////////////////////////�������Ƿ��Ѿ����й������ݶ���///////////
  MessageId: Integer;
  WProc: TFNWndProc;
  MutHandle: THandle;
  MIERROR: Integer;
implementation
uses
  Common, EDecode, HUtil32,
  LNewAccount, LChgPassword, LGetBackPassword, SecrchInfoMain, CMain, LEditGame;
var
  busy: Boolean = FALSE;
const
  UniqueAppStr = 'http://www.51ggame.com';
{$R *.dfm}
{$R ��Դ�ļ�\Mir\Mir.res}
{$R ��Դ�ļ�\mClient\mClient.res}
procedure TMainForm.HotKeyDown(var Msg: Tmessage);
begin
  if (Msg.LparamLo = MOD_CONTROL) and (Msg.LParamHi = ord('j')) then begin
    // ʲôҲ����
    //showmessage('');
  end;
end;

procedure TMainForm.CreateUlr; //������ݷ�ʽ
var
  ShLink: IShellLink;
  PFile: IPersistFile;
  FileName: string;
  WFileName: WideString;
  Reg: TRegIniFile;
  AnObj: IUnknown;
  UrlName: string;
begin
  UrlName := Trim(CreateUlrName);
  if UrlName = '' then Exit;
  AnObj := CreateComObject(CLSID_ShellLink);
  ShLink := AnObj as IShellLink;
  PFile := AnObj as IPersistFile;
  FileName := ParamStr(0);
  ShLink.SetPath(PChar(FileName));
  ShLink.SetWorkingDirectory(PChar(ExtractFilePath(FileName)));
  Reg := TRegIniFile.Create('Software\MicroSoft\Windows\CurrentVersion\Explorer');
  WFileName := Reg.ReadString('Shell Folders', 'Desktop', '') + '\' + UrlName + '.lnk';
  PFile.Save(PWChar(WFileName), true);
end;

function TMainForm.WriteMirInfo(MirPath: string; GameZone: pTGameZone): Boolean;
var
  MirRes, mClientRes, nClientRes: TResourceStream;
  sIpAddr: string;
begin
  if CheckIsIpAddr(GameZone.sGameIPaddr) then begin
    sIpAddr := GameZone.sGameIPaddr;
  end else begin
    sIpAddr := CheckHostToIP(GameZone.sGameIPaddr);
  end;
  FileSetAttr(MirPath + mClientName, 0);
  FileSetAttr(MirPath + sProgamFile, 0);
  MirRes := TResourceStream.Create(HInstance, 'exeClient', PChar('Dat'));
  try
    mClientRes := TResourceStream.Create(HInstance, 'mClient', PChar('dll'));
    mClientRes.SaveToFile(MirPath + mClientName); //����Դ����Ϊ�ļ�������ԭ�ļ�
    MirRes.SaveToFile(MirPath + sProgamFile); //����Դ����Ϊ�ļ�������ԭ�ļ�
    MirRes.Free;
    mClientRes.Free;
  except
  end;
  Myinifile := TInIFile.Create(MirPath + 'mir.ini');
  if Myinifile <> nil then begin
    Myinifile.WriteString('Setup', 'FontName', '����');
    Myinifile.WriteString('Setup', 'Serveraddr', sIpAddr); //IP��ַ
    Myinifile.WriteString('Setup', 'Param1', sIpAddr); //IP��ַ
    Myinifile.WriteInteger('Setup', 'Param2', GameZone.nGameIPPort); //�˿�
    Myinifile.WriteString('Setup', 'Param3', '');
    Myinifile.WriteString('Setup', 'Param4', '');
    Myinifile.WriteString('Setup', 'Param5', '');
    Myinifile.Free;
    Result := true;
  end;
  if Result then begin
    Myinifile := TInIFile.Create(MirPath + 'ftp.ini');
    if Myinifile <> nil then begin
      Myinifile.WriteInteger('Server', 'Servercount', 1);
      Myinifile.WriteString('Server', 'server1caption', GameZone.sServerName); //��������
      Myinifile.WriteString('Server', 'server1name', GameZone.sServerName); //����������
      Myinifile.Free;
      FileSetAttr(MirPath + mClientName, 2);
      FileSetAttr(MirPath + sProgamFile, 2);
      Result := true;
    end else Result := FALSE;
  end else Result := FALSE;
end;
//==============================================================================
function TMainForm.GetDownFileName1(DownAddr: string): string;
begin
  while Pos('\', DownAddr) <> 0 do {//�����ļ�����}  begin
    Application.ProcessMessages; //��Ӧһ����Ϣ
    DownAddr := Copy(DownAddr, Pos('\', DownAddr) + 1, Length(DownAddr));
  end;
  Result := DownAddr;
end;

function RunApp(AppName: string; I: Integer): Integer; //���г���
var
  Sti: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  FillMemory(@Sti, SizeOf(Sti), 0);
  Sti.wShowWindow := I;
  Sti.dwFlags := STARTF_USEFILLATTRIBUTE;
  Sti.dwFillAttribute := FOREGROUND_INTENSITY or BACKGROUND_BLUE;
  if CreateProcess(PChar(AppName), nil,
    nil, nil, FALSE,
    0, nil, PChar(ExtractFilePath(AppName)),
    Sti, ProcessInfo) then begin
    Result := ProcessInfo.dwProcessId;
  end
  else
    Result := -1;
end;
procedure TMainForm.StartMirButtonClick(Sender: TObject);
var
  sClient, sCopyFile: string;
  SecrchFrm: TSecrchFrm;
begin
  if not m_boClientSocketConnect then begin
    Application.MessageBox('��ѡ����Ҫ��½����Ϸ��������', '��ʾ��Ϣ', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;
  if (not DirectoryExists(ExtractFilePath(ParamStr(0)) + 'Data')) or
    (not DirectoryExists(ExtractFilePath(ParamStr(0)) + 'Map')) or
    (not DirectoryExists(ExtractFilePath(ParamStr(0)) + 'Wav')) then begin
    //if Application.MessageBox('��ǰĿ¼��û�з��ִ���ͻ��ˣ�����ȷ���Զ������ͻ��˷����ȡ��������',
      //'��ʾ��Ϣ',
     // MB_YESNO + MB_ICONQUESTION) = IDYES then begin
    SecrchFrm := TSecrchFrm.Create(Owner);
    SecrchFrm.ShowModal; //��ʼ����
    SecrchFrm.Free;
    if not m_BoSearchFinish then begin
      Application.MessageBox('û���Ҵ���ͻ������ֹ����ң�����', '��ʾ��Ϣ', MB_OK + MB_ICONINFORMATION);
      Exit;
    end else begin
      sCopyFile := GetDownFileName1(Application.ExeName);
      CopyFile(PChar(sCopyFile), PChar(m_sMirClient + sCopyFile), FALSE); //�����Լ�
      RunApp(m_sMirClient + sCopyFile, 1); //����
      Application.Terminate;
      Exit;
    end;
    //end else Exit;
  end else begin
    sClient := ExtractFilePath(ParamStr(0));
  end;
  if m_SelGameZone <> nil then begin
    if not WriteMirInfo(sClient, m_SelGameZone) then begin //д����Ϸ��
      Application.MessageBox('�ļ�����ʧ���޷������ͻ��ˣ�����', '��ʾ��Ϣ', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;
    Application.Minimize; //��С������
    RunApp(sClient + sProgamFile, 1); //�����ͻ���
  end;
end;
//==============================================================================
procedure TMainForm.GetServerInfo(sLineText: string; var g_GameZone: pTGameZone);
var
  sShowName, sServerName, sServeraddr, sServerPort, sNoticeUrl: string;
begin
  sLineText := GetValidStr3(sLineText, sShowName, [#9, '|']);
  sLineText := GetValidStr3(sLineText, sServerName, [#9, '|']);
  sLineText := GetValidStr3(sLineText, sServeraddr, [#9, '|']);
  sLineText := GetValidStr3(sLineText, sServerPort, [#9, '|']);
  sLineText := GetValidStr3(sLineText, sNoticeUrl, [#9, '|']);
  if (sShowName <> '') and (sServerName <> '') and
    (sServeraddr <> '') and (sServerPort <> '') and (sNoticeUrl <> '') then begin
    New(g_GameZone);
    g_GameZone.sShowName := sShowName;
    g_GameZone.sServerName := sServerName;
    g_GameZone.sGameIPaddr := sServeraddr;
    g_GameZone.nGameIPPort := Str_ToInt(sServerPort, 7000);
    g_GameZone.sNoticeUrl := sNoticeUrl;
  end;
end;

procedure TMainForm.LoadGameList;
var
  SectionsList: TStringlist;
  I: Integer;
  sLineText, sShowName, sServerName, sServeraddr, sServerPort, sNoticeUrl: string;
  GameZone: pTGameZone;
begin
  if m_GameList <> nil then begin
    UnLoadGameList();
  end;
  m_GameList := TList.Create;
  if FileExists(ExtractFilePath(ParamStr(0)) + m_sGameListName) then begin
    SectionsList := TStringlist.Create;
    SectionsList.LoadFromFile(ExtractFilePath(ParamStr(0)) + m_sGameListName);
    for I := 0 to SectionsList.Count - 1 do begin
      sLineText := Trim(SectionsList.Strings[I]);
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        GetServerInfo(sLineText, GameZone);
        if GameZone <> nil then begin
          m_GameList.Add(GameZone);
        end;
      end;
    end;
    SectionsList.Free;
  end;
end;

procedure TMainForm.LoadLocalGameList;
var
  SectionsList: TStringlist;
  I: Integer;
  sLineText, sShowName, sServerName, sServeraddr, sServerPort, sNoticeUrl: string;
  GameZone: pTGameZone;
begin
  if m_LocalGameList <> nil then begin
    UnLoadLocalGameList;
  end;
  m_LocalGameList := TList.Create;
  if FileExists(ExtractFilePath(ParamStr(0)) + m_sLocalGameListName) then begin
    SectionsList := TStringlist.Create;
    SectionsList.LoadFromFile(ExtractFilePath(ParamStr(0)) + m_sLocalGameListName);
    for I := 0 to SectionsList.Count - 1 do begin
      sLineText := Trim(SectionsList.Strings[I]);
      if (sLineText[1] <> ';') and (sLineText <> '') then begin
        GetServerInfo(sLineText, GameZone);
        if GameZone <> nil then begin
          m_LocalGameList.Add(GameZone);
        end;
      end;
    end;
    SectionsList.Free;
  end;
end;

procedure TMainForm.UnLoadLocalGameList;
var
  I: Integer;
begin
  for I := 0 to m_LocalGameList.Count - 1 do begin
    Dispose(pTGameZone(m_LocalGameList.Items[I]));
  end;
  m_LocalGameList.Free;
  m_LocalGameList := nil;
end;

procedure TMainForm.UnLoadGameList();
var
  I: Integer;
begin
  for I := 0 to m_GameList.Count - 1 do begin
    Dispose(pTGameZone(m_GameList.Items[I]));
  end;
  m_GameList.Free;
  m_GameList := nil;
end;

procedure TMainForm.LoadGameListToBox;
var
  I: Integer;
  nItemIndex: Integer;
  GameZone: pTGameZone;
begin
  nItemIndex := ListBoxServerList.ItemIndex;
  ListBoxServerList.Items.Clear;
  for I := 0 to m_GameList.Count - 1 do begin
    GameZone := pTGameZone(m_GameList.Items[I]);
    ListBoxServerList.Items.AddObject(GameZone.sShowName, TObject(GameZone));
  end;
  for I := 0 to m_LocalGameList.Count - 1 do begin
    GameZone := pTGameZone(m_LocalGameList.Items[I]);
    ListBoxServerList.Items.AddObject(GameZone.sShowName, TObject(GameZone));
  end;
  if (ListBoxServerList.Items.Count > nItemIndex) and (nItemIndex >= 0) then
    ListBoxServerList.ItemIndex := nItemIndex;
end;

//==============================================================================
procedure TMainForm.FormCreate(Sender: TObject);
begin
  CreateUlr;
  dwClickTick := 0;
  //==============================================================================
  HotKeyId := GlobalAddAtom('HotKey') - $C000; //
  //RegisterHotKey(Handle, hotkeyid, Mod_Alt, VK_F4); //       // ע�� Ctrl + J
  RegisterHotKey(Handle, HotKeyId, MOD_CONTROL, ord('J')); //
  //==============================================================================
  TimerGetGameList.Enabled := true;
end;

procedure TMainForm.ListBoxServerListClick(Sender: TObject);
var
  GameZone: pTGameZone;
  nItemIndex: Integer;
begin
  if GetTickCount - dwClickTick > 500 then begin
    dwClickTick := GetTickCount;
    try
      nItemIndex := ListBoxServerList.ItemIndex;
      m_SelGameZone := pTGameZone(ListBoxServerList.Items.Objects[nItemIndex]);
    except
      m_SelGameZone := nil;
    end;
    if m_SelGameZone = nil then Exit;
    ClientSocket.Active := FALSE;
    ClientSocket.Host := '';
    ClientSocket.Address := '';
    if CheckIsIpAddr(m_SelGameZone.sGameIPaddr) then begin
      ClientSocket.Address := m_SelGameZone.sGameIPaddr;
    end else begin
      ClientSocket.Host := m_SelGameZone.sGameIPaddr;
    end;
    ClientSocket.Port := m_SelGameZone.nGameIPPort;
    ClientSocket.Active := true;
    WebBrowser1.Navigate(WideString(m_SelGameZone.sNoticeUrl));
  end;
end;

procedure TMainForm.ListBoxServerListDblClick(Sender: TObject);
begin
  if m_SelGameZone <> nil then begin
    ShellExecute(0, 'open', PChar(string(m_SelGameZone.sNoticeUrl)), nil, nil, SW_SHOWNORMAL);
  end;
end;

procedure TMainForm.ButtonHomePageClick(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar(HomePage), nil, nil, SW_SHOWNORMAL);
end;

procedure TMainForm.ButtonLocalStartClick(Sender: TObject);
begin
  try
    if m_SelGameZone <> nil then begin
      frmCMain := TfrmCMain.Create(Owner);
      frmCMain.Open;
      Application.Minimize;
    end;
  except
  end;
end;

procedure TMainForm.ButtonAddGameClick(Sender: TObject);
begin
  frmEditGame := TfrmEditGame.Create(Owner);
  frmEditGame.Open();
  frmEditGame.Free;
end;

procedure TMainForm.TimerGetGameListTimer(Sender: TObject);
var
  s: TStringlist;
begin
  TimerGetGameList.Enabled := FALSE;
  IdHTTP.ReadTimeout := 1500; //�˴����������Ƶõ��������б����õ�ʱ��,�ô��������о�,������Ϊ1500���ҽϺ�
  try
    s := TStringlist.Create;
    s.Text := IdHTTP.Get(m_sRemoteAddress);
    s.SaveToFile(m_sGameListName); //��ȡ��Ϸ�������б�
    //s.Clear;
    {s.Add(IdHTTP.Get('http://'+ConfigList+'/config.txt'));    //��ȡ�����ļ�
    s.SaveToFile(Config);}
    s.Free;
  except
    TimerGetGameList.Enabled := FALSE;
  end;
  TimerGetGameList.Enabled := FALSE;
  LoadGameList;
  LoadLocalGameList;
  LoadGameListToBox;
  WebBrowser1.Navigate(Trim(HomePage));
end;

procedure TMainForm.ListBoxServerListDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  nIdx: Integer;
begin
  ListBoxServerList.Canvas.FillRect(Rect);
  nIdx := Index mod 2;
  if nIdx = 0 then ListBoxServerList.Canvas.Font.Color := clRed
  else ListBoxServerList.Canvas.Font.Color := clBlue;
  ListBoxServerList.Canvas.TextOut(Rect.Left + 5, Rect.top + ((Rect.Bottom - Rect.top) - ListBoxServerList.Canvas.TextHeight('A')) div 2, ListBoxServerList.Items[Index]);
end;

procedure TMainForm.IdHTTPWork(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
  //Application.ProcessMessages;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  UnLoadGameList;
  UnLoadLocalGameList;
  UnRegisterHotKey(Handle, HotKeyId); //ע��CTRL+J
  DeleteFile(ExtractFilePath(ParamStr(0)) + sProgamFile); //ɾ���ļ�
  DeleteFile(ExtractFilePath(ParamStr(0)) + mClientName); //ɾ���ļ�
end;

procedure TMainForm.ButtonMinClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TMainForm.ButtonCloseClick(Sender: TObject);
begin
  close;
end;
//==============================================================================
procedure TMainForm.SendCSocket(sendstr: string);
var
  sSendText: string;
begin
  if ClientSocket.Socket.Connected then begin
    sSendText := '#' + IntToStr(code) + sendstr + '!';
    ClientSocket.Socket.SendText('#' + IntToStr(code) + sendstr + '!');
    Inc(code);
    if code >= 10 then code := 1;
  end;
end;

procedure TMainForm.SendChgPw(sAccount, sPasswd, sNewPasswd: string); //�����޸�����
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_CHANGEPASSWORD, 0, 0, 0, 0);
  SendCSocket(EncodeMessage(Msg) + EncodeString(sAccount + #9 + sPasswd + #9 + sNewPasswd));
end;

procedure TMainForm.SendGetBackPassword(sAccount, sQuest1, sAnswer1,
  sQuest2, sAnswer2, sBirthDay: string); //�����һ�����
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GETBACKPASSWORD, 0, 0, 0, 0);
  SendCSocket(EncodeMessage(Msg) + EncodeString(sAccount + #9 + sQuest1 + #9 + sAnswer1 + #9 + sQuest2 + #9 + sAnswer2 + #9 + sBirthDay));
end;

procedure TMainForm.SendUpdateAccount(ue: TUserEntry; ua: TUserEntryAdd); //�����½��˺�
var
  Msg: TDefaultMessage;
begin
  MakeNewAccount := ue.sAccount;
  Msg := MakeDefaultMsg(CM_ADDNEWUSER, 0, 0, 0, 0);
  SendCSocket(EncodeMessage(Msg) + EncodeBuffer(@ue, SizeOf(TUserEntry)) + EncodeBuffer(@ua, SizeOf(TUserEntryAdd)));
end;

procedure TMainForm.ClientTimerTimer(Sender: TObject);
var
  str, data: string;
  len, I, n, mcnt: Integer;
begin
  if busy then Exit;
  busy := true;
  try
    BufferStr := BufferStr + SocStr;
    SocStr := '';
    if BufferStr <> '' then begin
      mcnt := 0;
      while Length(BufferStr) >= 2 do begin
        if Pos('!', BufferStr) <= 0 then break;
        BufferStr := ArrestStringEx(BufferStr, '#', '!', data);
        if data <> '' then begin
          DecodeMessagePacket(data);
        end else
          if Pos('!', BufferStr) = 0 then
          break;
      end;
    end;
  finally
    busy := FALSE;
  end;
end;

procedure TMainForm.DecodeMessagePacket(datablock: string);
var
  head, body, body2, tagstr, data, rdstr, str: string;
  Msg: TDefaultMessage;
  smsg: TShortMessage;
  mbw: TMessageBodyW;
  desc: TCharDesc;
  wl: TMessageBodyWL;
  featureEx: word;
  L, I, j, n, BLKSize, param, sound, cltime, svtime: Integer;
  tempb: Boolean;
begin
  if datablock[1] = '+' then begin
    Exit;
  end;
  if Length(datablock) < DEFBLOCKSIZE then begin
    Exit;
  end;
  head := Copy(datablock, 1, DEFBLOCKSIZE);
  body := Copy(datablock, DEFBLOCKSIZE + 1, Length(datablock) - DEFBLOCKSIZE);
  Msg := DecodeMessage(head);
  case Msg.Ident of
    SM_NEWID_SUCCESS: begin
        Application.MessageBox('�����ʺŴ����ɹ���' + #13 +
          '�����Ʊ��������ʺź����룬' + #13 + '���Ҳ�Ҫ���κ�ԭ����ʺź���������κ������ˡ�' + #13 +
          '�������������,�����ͨ�����ǵ���ҳ�����һء�', '��ʾ��Ϣ', MB_OK);
        frmNewAccount.close;
      end;
    SM_NEWID_FAIL: begin
        case Msg.Recog of
          0: begin
              Application.MessageBox(PChar('�ʺ� "' + MakeNewAccount + '" �ѱ����������ʹ���ˡ�' + #13 +
                '��ѡ�������ʺ���ע�ᡣ'), '��ʾ��Ϣ', MB_OK);
            end;
          -2: Application.MessageBox('���ʺ�������ֹʹ�ã�', '��ʾ��Ϣ', MB_OK);
          else Application.MessageBox(PChar('�ʺŴ���ʧ�ܣ���ȷ���ʺ��Ƿ�����ո񡢼��Ƿ��ַ���Code: ' + IntToStr(Msg.Recog)), '��ʾ��Ϣ', MB_OK);
        end;
        frmNewAccount.ButtonOK.Enabled := true;
        Exit;
      end;
    ////////////////////////////////////////////////////////////////////////////////
    SM_CHGPASSWD_SUCCESS: begin
        Application.MessageBox('�����޸ĳɹ���', '��ʾ��Ϣ', MB_OK);
        {frmChangePassword.ChgEditAccount.Text:='';
        frmChangePassword.ChgEditPassword.Text:='';
        frmChangePassword.ChgEditConfirm.Text:='';
        frmChangePassword.ChgEditNewPassword.Text:='';}
        frmChangePassword.ButtonOK.Enabled := FALSE;
        //frmNewAccount.Close;
        Exit;
      end;
    SM_CHGPASSWD_FAIL: begin
        case Msg.Recog of
          0: Application.MessageBox('������ʺŲ����ڣ�����', '��ʾ��Ϣ', MB_OK);
          -1: Application.MessageBox('�����ԭʼ���벻��ȷ��', '��ʾ��Ϣ', MB_OK);
          -2: Application.MessageBox('���ʺű�������', '��ʾ��Ϣ', MB_OK);
          else Application.MessageBox('����������볤��С����λ��', '��ʾ��Ϣ', MB_OK);
        end;
        frmChangePassword.ButtonOK.Enabled := true;
        Exit;
      end;
    SM_GETBACKPASSWD_SUCCESS: begin
        frmGetBackPassword.EditPassword.Text := DecodeString(body);
        Application.MessageBox(PChar('�����һسɹ���'), '��ʾ��Ϣ', MB_OK);
        Exit;
      end;
    SM_GETBACKPASSWD_FAIL: begin
        case Msg.Recog of
          0: Application.MessageBox('������ʺŲ����ڣ�����', '��ʾ��Ϣ', MB_OK + MB_ICONERROR);
          -1: Application.MessageBox('����𰸲���ȷ������', '��ʾ��Ϣ', MB_OK + MB_ICONERROR);
          -2: Application.MessageBox(PChar('���ʺű�����������' + #13 + '���Ժ��������������һء�'), '��ʾ��Ϣ', MB_OK + MB_ICONERROR);
          -3: Application.MessageBox('�����벻��ȷ������', '��ʾ��Ϣ', MB_OK + MB_ICONERROR);
          else Application.MessageBox('δ֪����', '��ʾ��Ϣ', MB_OK + MB_ICONERROR);
        end;
        frmGetBackPassword.ButtonOK.Enabled := true;
        Exit;
      end;
  end;
end;

procedure TMainForm.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  n: Integer;
  data, data2: string;
begin
  data := Socket.ReceiveText;
  n := Pos('*', data);
  if n > 0 then begin
    data2 := Copy(data, 1, n - 1);
    data := data2 + Copy(data, n + 1, Length(data));
    ClientSocket.Socket.SendText('*');
  end;
  SocStr := SocStr + data;
end;

procedure TMainForm.ButtonNewAccountClick(Sender: TObject);
begin
  ClientTimer.Enabled := true;
  frmNewAccount.LabelStatus.Caption := MsgLabel.Caption;
  frmNewAccount.Open;
end;

procedure TMainForm.ButtonChgPasswordClick(Sender: TObject);
begin
  ClientTimer.Enabled := true;
  frmChangePassword.LabelStatus.Caption := MsgLabel.Caption;
  frmChangePassword.Open;
end;

procedure TMainForm.ButtonGetBackPasswordClick(Sender: TObject);
begin
  ClientTimer.Enabled := true;
  frmGetBackPassword.LabelStatus.Caption := MsgLabel.Caption;
  frmGetBackPassword.Open;
end;

procedure TMainForm.ClientSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  m_boClientSocketConnect := FALSE;
  ErrorCode := 0;
  Socket.close;
end;

procedure TMainForm.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  m_boClientSocketConnect := true;
  MsgLabel.Caption := '������״̬����...';
  frmGetBackPassword.LabelStatus.Caption := MsgLabel.Caption;
  frmNewAccount.LabelStatus.Caption := MsgLabel.Caption;
  frmChangePassword.LabelStatus.Caption := MsgLabel.Caption;
end;

procedure TMainForm.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  m_boClientSocketConnect := FALSE;
  MsgLabel.Font.Color := clLime;
  MsgLabel.Caption := '���������ӹر�...';
  frmGetBackPassword.LabelStatus.Caption := MsgLabel.Caption;
  frmNewAccount.LabelStatus.Caption := MsgLabel.Caption;
  frmChangePassword.LabelStatus.Caption := MsgLabel.Caption;
end;

procedure TMainForm.ClientSocketConnecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Application.ProcessMessages;
  MsgLabel.Font.Color := clLime;
  MsgLabel.Caption := '���ڲ��Է�����״̬...';
end;
//==============================================================================
///////////////////�������Ƿ��Ѿ����У�����Ѿ���������ʾ����/////////////////
function GetMIError: Integer;
begin
  Result := MIERROR;
end;

function NewWndProc(Handle: HWND; Msg: Integer; wParam, lParam: Longint): Longint; stdcall;
begin
  Result := 0;
  if Msg = MessageId then begin
    case wParam of
      MI_QUERYWINDOWHANDLE: begin
          if IsIconic(Application.Handle) then begin
            Application.MainForm.WindowState := wsNormal;
            Application.Restore;
          end;
          PostMessage(HWND(lParam), MessageId, MI_RESPONDWINDOWNHANDLE, Application.MainForm.Handle);
        end;
      MI_RESPONDWINDOWNHANDLE: begin
          SetForegroundWindow(HWND(lParam));
          Application.Terminate;
        end;
    end;
  end
  else
    Result := CallWindowProc(WProc, Handle, Msg, wParam, lParam);
end;

procedure SubClassApplication;
begin
  WProc := TFNWndProc(SetWindowLong(Application.Handle, GWL_WNDPROC, Longint(@NewWndProc)));
  if WProc = nil then
    MIERROR := MIERROR or MI_ERROR_FAILSUBCLASS;
end;

procedure DoFirstinstance;
begin
  MutHandle := CreateMutex(nil, FALSE, UniqueAppStr);
  if MutHandle = 0 then
    MIERROR := MIERROR or MI_ERROR_CREATINGMUTEX;
end;

procedure BroadcastFocusMessage;
var
  BSMRecipients: DWORD;
begin
  Application.ShowMainForm := FALSE;
  BSMRecipients := BSM_APPLICATIONS;
  BroadCastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE, @BSMRecipients,
    MessageId, MI_QUERYWINDOWHANDLE, Application.Handle);
end;

procedure initInstance;
begin
  SubClassApplication;
  MutHandle := OpenMutex(MUTEX_ALL_ACCESS, FALSE, UniqueAppStr);
  if MutHandle = 0 then
    DoFirstinstance
  else
    BroadcastFocusMessage;
end;

initialization
  begin
    MessageId := RegisterWindowMessage(UniqueAppStr);
    initInstance;
    Move(ColorArray, ColorTable, SizeOf(ColorArray));
  end;

finalization
  begin
    if WProc <> nil then
      SetWindowLong(Application.Handle, GWL_WNDPROC, Longint(WProc));
    if MutHandle <> 0 then
      CloseHandle(MutHandle);
  end;

end.

