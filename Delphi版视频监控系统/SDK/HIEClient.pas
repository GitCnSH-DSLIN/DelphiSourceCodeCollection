Unit HIEClient;
////////////////////////////////////////////////
//VERSION:      3.5                           //
//COPYRIGHT:    High-Easy                     //
////////////////////////////////////////////////
Interface

Uses
  Windows;

Const
  SUPPORT_DDRAW = 1;                    //֧��DIRECTDRAW��
  SUPPORT_BLT = 2;                      //�Կ�֧��BLT������
  SUPPORT_BLTFOURCC = 4;                //�Կ�BLT֧����ɫת����
  SUPPORT_BLTSHRINKX = 8;               //�Կ�BLT֧��X����С��
  SUPPORT_BLTSHRINKY = 16;              //�Կ�BLT֧��Y����С��
  SUPPORT_BLTSTRETCHX = 32;             //�Կ�BLT֧��X��Ŵ�
  SUPPORT_BLTSTRETCHY = 64;             //�Կ�BLT֧��Y��Ŵ�
  SUPPORT_CPU = 128;                    //CPU��֧�֣�

  //�ͻ����յ�����Ϣ
  RECDATAERR = 0;                       //�������������쳣
  PLAYERR = 1;                          //�ͻ��˲��ų����쳣
  REFUSED = 2;                          //�ͻ������ӱ��ܾ�
  GETSTRING = 3;                        //�ͻ����յ���Ϣ�ַ���
  SERVERCLOSE = 4;                      //�������˳�
  NETFAILED = 5;                        //�������ͨ�ų����쳣
  RECVFRAME = 6;                        //�ͻ����յ�һ֡����

  //�ͻ���״̬
  MP4Net_S_INVALID = -1;
  MP4Net_S_CONNECTING = 1;
  MP4Net_S_RECEIVING = 2;
  MP4Net_S_HALT = 3;
  MP4Net_S_FINISH = 4;
  MP4Net_S_UNREACHABLE = 5;
  MP4Net_S_REFUSE = 6;

Type
  PCLIENT_VIDEOINFO = ^TCLIENT_VIDEOINFO;
  TCLIENT_VIDEOINFO = Record
    m_bytRemoteChannel: BYTE;           //��Ӧ������ͨ��
    m_bytSendMode: BYTE;                //���䷽ʽ(TCP/UDP/MULTIMODE)
    m_bytLinkType: BYTE;                //Զ�̽��뷽ʽ(ADSL/PSTN/LAN/ISDN)
    /////////////////////////////////////////////////////
    // ADSL: 1M ~ 2M
    // PSTN: <56k
    // ISDN: >64k < 128K
    // LAN:  >10M
    /////////////////////////////////////////////////////
    m_bytPlayMode: BYTE;                //���ŷ�ʽ(STREAM/TOKEN)
    ////////////////////////////////////////////////////
    // STREAM : �����ڿ����·����
    // TOKEN  : ������խ����·����
    ////////////////////////////////////////////////////
    m_sIP: PChar;                       //��Ӧ������IP
    m_sUserName: PChar;                 //�û���
    m_sUserPassWord: PChar;             //�û�����
    m_bUserCheck: BOOL;                 //�Ƿ���Ҫ�����û���������
    m_hShowVideo: HWND;                 //��Ƶ��ʾ����
    m_bytDecodeMode: BYTE;              //��������(SOFTDEC(Default) / HARDDEC)
  End;

  PVoiceComInfo = ^TVoiceComInfo;
  TVoiceComInfo = Record
    m_sIP: PChar;                       //��Ӧ������IP
    m_sUserName: PChar;                 //�û���
    m_sUserPassWord: PChar;             //�û�����
    m_bytSendMode: BYTE;                //���䷽ʽ(TCP/UDP/MULTIMODE)
    m_bUserCheck: BOOL;                 //�Ƿ���Ҫ�����û���������
  End;

  PVideoStandard = ^TVideoStandard;
  TVideoStandard = LongWord;

Const
  StandardNone: TVideoStandard = $80000000; //����Ƶ�ź�
  StandardNTSC: TVideoStandard = $00000001; //NTSC ��ʽ
  StandardPAL: TVideoStandard = $00000002; //PAL ��ʽ
  StandardSECAM: TVideoStandard = $00000004; //SECAM ��ʽ

Type
  PREGION_PARAM = ^TREGION_PARAM;
  TREGION_PARAM = Record
    left: Integer;
    top: Integer;
    width: Integer;
    height: Integer;
    Color: COLORREF;
    param: Integer;
  End;

  //���紫�����Э��
  TProtocol = (UDPMODE = 0, TCPMODE, MULTIMODE);

  //DirectDraw��ʾģʽ
  DirectDrawMode = (NORMALMODE = 0, OVERLAYMODE);

  //��Ƶ����
  TVideoQuality = (LOWQUALITY = 0, HIGHQUALITY);

  //���ŷ�ʽ
  TPlayMode = (STREAM = 0, TOKEN);

  //���紫�����
  TNetTranType = (LAN = 0, ADSL, ISDN, PSTN);

  //���뷽ʽ
  TDecMode = (SOFTDEC = 0, HARDDEC, MATRIXDEC);

  TReadDataCallBack = Procedure(nPort: DWORD; pPacketBuffer: PUCHAR; nPacketSize: DWORD; FrameType: Integer); stdcall;
  TDrawFunCallBack = Procedure(StockHandle: LongInt; Hdc: Hdc; nUser: LongInt); stdcall;
  TVoiceDataCallBack = Procedure(pRecvDatatBuffer: PChar; dwBufSize: DWORD; bytAudioFlag: BYTE; dwUser: DWORD); stdcall;

Function ClientGetSDKVersion(): DWORD; stdcall;

Function ClientStartup(nMessage: UINT; HWND: HWND): BOOL; stdcall;

Function ClientCleanup(): BOOL; stdcall;

Function ClientStart(pClientInfo: PCLIENT_VIDEOINFO; CallBack: TReadDataCallBack): LongInt; stdcall;

Function ClientStart_Card(pClientInfo: PCLIENT_VIDEOINFO; nChannelNum_HWCard: LongInt; CallBack: TReadDataCallBack): LongInt; stdcall;

Function ClientStop(StockHandle: LongInt): BOOL; stdcall;

Function ClientGetState(StockHandle: LongInt): LongInt; stdcall;

Function ClientStartCapture(StockHandle: LongInt): BOOL; stdcall;

Function ClientStartCaptureFile(StockHandle: LongInt; FileName: PAnsiChar): BOOL; stdcall;

Function ClientStopCapture(StockHandle: LongInt): BOOL; stdcall;

Function ClientGetServerChannelNum(m_sIPAddress: PAnsiChar): WORD; stdcall;

Function ClientCommandToServer(m_lAddrIP: PAnsiChar; m_sCommand: PChar; m_wLen: WORD): BOOL; stdcall;

Function ClientShut(m_lAddrIP: PAnsiChar; cChannel: char): BOOL; stdcall;

Function ClientAudioVolume(wVolume: WORD): BOOL; stdcall;

Function ClientAudioStart(StockHandle: LongInt): BOOL; stdcall;

Function ClientAudioStop(): BOOL; stdcall;

Function ClientCommandToServer_Handle(StockHandle: LongInt; m_sCommand: PChar; m_wLen: WORD): BOOL; stdcall;

Function ClientSetBufferNum(StockHandle: LongInt; wBufNum: WORD): BOOL; stdcall;

Function ClientSetNetPort(dServerPort, dClientPort: WORD): BOOL; stdcall;

Function ClientSetPlayDelay(StockHandle: LongInt; DelayLen: WORD): BOOL; stdcall;

Function ClientSetWait(dEachWaitTime, dTryNum: DWORD): BOOL; stdcall;

Function ClientSetShowMode(dwShowType: DWORD; ColorKey: COLORREF): BOOL; stdcall;

Function ClientSetQuality(StockHandle: LongInt; wPicQuality: WORD): BOOL; stdcall;

Function ClientIsSupport(): Integer; stdcall;

Procedure ClientReadLastMessage(m_sIP, m_sCommand: PChar; m_wLen: PWORD); stdcall;

Procedure ClienSetThrowBFrame(StockHandle: LongInt; nFrameNum: Integer); stdcall;

Function ClienSetBright(StockHandle: LongInt; nBright: Integer): BOOL; stdcall;

Function ClienSetContrast(StockHandle: LongInt; nContrast: Integer): BOOL; stdcall;

Function ClientResume(StockHandle: LongInt; HWND: HWND): BOOL; stdcall;

Function ClientSuspend(StockHandle: LongInt): BOOL; stdcall;

{ Ver3.0.4 add
  Default: bDisable = FALSE
\param
  bDisable = TRUE: Disable Client Video Play(Decode & Display)
bDisable = FALSE: Enable Clisne Video Play(Decode & Display
  \return
  SUCCESS Or FAILED
}
Function ClientDisableVideoPlay(StockHandle: LongInt; bDisable: BOOL): BOOL; stdcall;

{ Ver3.0.4 add
  Get Remote Channel MP4 Header
  \param
  StockHandle: Channel Index(returned by ClientStart)
HeaderBuf: Buf To store File Header
FileHeaderLen: Buf To store File Header Length
\return
  SUCCESS Or FAILED
  }
Function ClientGetFileHeader(StockHandle: LongInt; HeaderBuf: PUCHAR; FileHeaderLen: PSmallint): BOOL; stdcall;

{ Ver3.0.5 add
  Remote Capture Image
  \
  StockHandle: Channel Index(returned by ClientStart)
sFileName: Iparammage File Name
\return
  SUCCESS Or FAILED
  }
Function ClientCapImage(StockHandle: LongInt; sImageFileName: PChar): BOOL; stdcall;

{ \brief
  * Version 3.1.4 add
  * Register a DrawFun CallBack Function To retrive the DC Of the clientwindow
  * This Function can be used To draw user data On the Client Video window.
  *
  * \param StockHandle
  * Channel Index(returned by ClientStart)
  * \param DrawFun
  * CallBack fucntion
  * \param nUser
  * user specified private data
  * \return
  * SUCCESS Or FAILED
  }
Function ClientRegisterDrawFun(StockHandle: LongInt; CallBack: TDrawFunCallBack; nUser: LongInt): BOOL; stdcall;

//---------------------add for matrix------------------------------------------
//1
Function ClientMatrixInit(): Integer; stdcall;
//2
Function ClientMatrixDeInit(): Integer; stdcall;
//3
Function ClientStart_Matrix(pClientInfo: PCLIENT_VIDEOINFO; nDecChannel: LongInt; CallBack: TReadDataCallBack): LongInt; stdcall;
//4
Function ClientMatrixSetDisplayRegion(nDisplayChannel: Integer; nRegionCount: Integer; pParam: PREGION_PARAM): Integer; stdcall;
//5
Function ClientMatrixGetTotalDecChannels(): Integer; stdcall;
//6
Function ClientMatrixGetDisplayChannelCount(): Integer; stdcall;
//7
Function ClientMatrixSetDecVideoOut(StockHandle: LongInt; nPort: Integer; bOpen: BOOL; nDisplayChannel, nDisplayRegion: Integer): Integer; stdcall;
//8
Function ClientMatrixClearDisplayRegion(nDisplayChannel, nRegionCount: Integer): Integer; stdcall;
//9
Function ClientMatrixFillDisplayRegion(nDisplayChannel, nRegionCount: Integer; FileName: PChar): Integer; stdcall;
//10
Function ClientMatrixSetDisplayStandard(nDisplayChannel: Integer; VideoStandard: TVideoStandard): Integer; stdcall;
//11
Function ClientMatrixSetDisplayRegionPosition(nDisplayChannel: Integer; nRegionCount, nLeft, nTop: Integer): Integer; stdcall;
//12
Function ClientMatrixSetBright(StockHandle: LongInt; degree: Integer): Integer; stdcall;
//13
Function ClientMatrixSetContrast(StockHandle: LongInt; degree: Integer): Integer; stdcall;
//14
Function ClientMatrixPlaySound(StockHandle: LongInt; AudioOutputChannel: Integer): Integer; stdcall;
//15
Function ClientMatrixSetVolume(StockHandle: LongInt; nVolume: WORD): Integer; stdcall;
//16
Function ClientMatrixGetVolume(StockHandle: LongInt): Integer; stdcall;
//17
Function ClientMatrixStopSound(StockHandle: LongInt): Integer; stdcall;
//18
Function ClientMatrixSetPicQuality(StockHandle: LongInt; bHighQuality: BOOL): BOOL; stdcall;
//19
Function ClientMatrixGetPicQuality(StockHandle: LongInt; bHighQuality: PBOOL): BOOL; stdcall;

//add for voice
//1
Function ClientStartVoiceCom(PVoiceComInfo: PVoiceComInfo; CallBack: TVoiceDataCallBack; dwUser: DWORD): LongInt; stdcall;
//2
Function ClientSetVoiceComClientVolume(lComHandle: LongInt; wVolume: WORD): BOOL; stdcall;
//3
Function ClientStopVoiceCom(lComHandle: LongInt): BOOL; stdcall;
Implementation

Const
  hIEClientDLL = 'HIEClient.dll';

Function ClientGetSDKVersion; External hIEClientDLL Name 'MP4Net_ClientGetSDKVersion';
Function ClientStartup; External hIEClientDLL Name 'MP4Net_ClientStartup';
Function ClientCleanup; External hIEClientDLL Name 'MP4Net_ClientCleanup';
Function ClientStart; External hIEClientDLL Name 'MP4Net_ClientStart';
Function ClientStart_Card; External hIEClientDLL Name 'MP4Net_ClientStart_Card';
Function ClientStop; External hIEClientDLL Name 'MP4Net_ClientStop';
Function ClientGetState; External hIEClientDLL Name 'MP4Net_ClientGetState';
Function ClientStartCapture; External hIEClientDLL Name 'MP4Net_ClientStartCapture';
Function ClientStartCaptureFile; External hIEClientDLL Name 'MP4Net_ClientStartCaptureFile';
Function ClientStopCapture; External hIEClientDLL Name 'MP4Net_ClientStopCapture';
Function ClientGetServerChannelNum; External hIEClientDLL Name 'MP4Net_ClientGetServerChannelNum';
Function ClientCommandToServer; External hIEClientDLL Name 'MP4Net_ClientCommandToServer';
Function ClientShut; External hIEClientDLL Name 'MP4Net_ClientShut';
Function ClientAudioVolume; External hIEClientDLL Name 'MP4Net_ClientAudioVolume';
Function ClientAudioStart; External hIEClientDLL Name 'MP4Net_ClientAudioStart';
Function ClientAudioStop; External hIEClientDLL Name 'MP4Net_ClientAudioStop';
Function ClientCommandToServer_Handle; External hIEClientDLL Name 'MP4Net_ClientCommandToServer_Handle';
Function ClientSetBufferNum; External hIEClientDLL Name 'MP4Net_ClientSetBufferNum';
Function ClientSetNetPort; External hIEClientDLL Name 'MP4Net_ClientSetNetPort';
Function ClientSetPlayDelay; External hIEClientDLL Name 'MP4Net_ClientSetPlayDelay';
Function ClientSetWait; External hIEClientDLL Name 'MP4Net_ClientSetWait';
Function ClientSetShowMode; External hIEClientDLL Name 'MP4Net_ClientSetShowMode';
Function ClientSetQuality; External hIEClientDLL Name 'MP4Net_ClientSetQuality';
Function ClientIsSupport; External hIEClientDLL Name 'MP4Net_ClientIsSupport';
Procedure ClientReadLastMessage; External hIEClientDLL Name 'MP4Net_ClientReadLastMessage';
Procedure ClienSetThrowBFrame; External hIEClientDLL Name 'MP4Net_ClienSetThrowBFrame';
Function ClienSetBright; External hIEClientDLL Name 'MP4Net_ClienSetBright';
Function ClienSetContrast; External hIEClientDLL Name 'MP4Net_ClienSetContrast';
Function ClientResume; External hIEClientDLL Name 'MP4Net_ClientResume';
Function ClientSuspend; External hIEClientDLL Name 'MP4Net_ClientSuspend';
Function ClientDisableVideoPlay; External hIEClientDLL Name 'MP4Net_ClientDisableVideoPlay';
Function ClientGetFileHeader; External hIEClientDLL Name 'MP4Net_ClientGetFileHeader';
Function ClientCapImage; External hIEClientDLL Name 'MP4Net_ClientCapImage';
Function ClientRegisterDrawFun; External hIEClientDLL Name 'MP4Net_ClientRegisterDrawFun';
Function ClientMatrixInit; External hIEClientDLL Name 'MP4Net_ClientMatrixInit';
Function ClientMatrixDeInit; External hIEClientDLL Name 'MP4Net_ClientMatrixDeInit';
Function ClientStart_Matrix; External hIEClientDLL Name 'MP4Net_ClientStart_Matrix';
Function ClientMatrixSetDisplayRegion; External hIEClientDLL Name 'MP4Net_ClientMatrixSetDisplayRegion';
Function ClientMatrixGetTotalDecChannels; External hIEClientDLL Name 'MP4Net_ClientMatrixGetTotalDecChannels';
Function ClientMatrixGetDisplayChannelCount; External hIEClientDLL Name 'MP4Net_ClientMatrixGetDisplayChannelCount';
Function ClientMatrixSetDecVideoOut; External hIEClientDLL Name 'MP4Net_ClientMatrixSetDecVideoOut';
Function ClientMatrixClearDisplayRegion; External hIEClientDLL Name 'MP4Net_ClientMatrixClearDisplayRegion';
Function ClientMatrixFillDisplayRegion; External hIEClientDLL Name 'MP4Net_ClientMatrixFillDisplayRegion';
Function ClientMatrixSetDisplayStandard; External hIEClientDLL Name 'MP4Net_ClientMatrixSetDisplayStandard';
Function ClientMatrixSetDisplayRegionPosition; External hIEClientDLL Name 'MP4Net_ClientMatrixSetDisplayRegionPosition';
Function ClientMatrixSetBright; External hIEClientDLL Name 'MP4Net_ClientMatrixSetBright';
Function ClientMatrixSetContrast; External hIEClientDLL Name 'MP4Net_ClientMatrixSetContrast';
Function ClientMatrixPlaySound; External hIEClientDLL Name 'MP4Net_ClientMatrixPlaySound';
Function ClientMatrixSetVolume; External hIEClientDLL Name 'MP4Net_ClientMatrixSetVolume';
Function ClientMatrixGetVolume; External hIEClientDLL Name 'MP4Net_ClientMatrixGetVolume';
Function ClientMatrixStopSound; External hIEClientDLL Name 'MP4Net_ClientMatrixStopSound';
Function ClientMatrixSetPicQuality; External hIEClientDLL Name 'MP4Net_ClientMatrixSetPicQuality';
Function ClientMatrixGetPicQuality; External hIEClientDLL Name 'MP4Net_ClientMatrixGetPicQuality';
Function ClientStartVoiceCom; External hIEClientDLL Name 'MP4Net_ClientStartVoiceCom';
Function ClientSetVoiceComClientVolume; External hIEClientDLL Name 'MP4Net_ClientSetVoiceComClientVolume';
Function ClientStopVoiceCom; External hIEClientDLL Name 'MP4Net_ClientStopVoiceCom';

End.

