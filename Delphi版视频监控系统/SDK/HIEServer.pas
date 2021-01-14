Unit HIEServer;
////////////////////////////////////////////////
//VERSION:      3.4.1.0                       //
//COPYRIGHT:    High-Easy                     //
////////////////////////////////////////////////
Interface

Uses
  Windows;

Const
  MAX_SERVER_CHANNEL = 64;
  GETSTRING = 3;

Type
  //���������������˵Ĳ����ṹ
  PHIE_SERVER_VIDEOINFO = ^THIE_SERVER_VIDEOINFO;
  THIE_SERVER_VIDEOINFO = Record
    m_bytDataType: Array[0..MAX_SERVER_CHANNEL - 1] Of Byte; //ͨ����������(�Ƿ�֧�ֵ绰�����ӷ�ʽ)
    m_bytChannelNum: Byte;              //�ܵ�ͨ����
    m_dwWaitTime: DWORD;                //��ʱ�ȴ�ʱ��(1 - 300 , ��λ:����)
    m_dwReserved: DWORD;                //������
  End;

  //ͨ����������
  //enum { NORMAL = 50 , DIALING };
  TConnectType = (NORMAL = 50, DIALING);

  TCheckIPCallBack = Function(nChannel: DWORD; sIP: PChar): Integer; stdcall;
  TCheckPassWordCallBack = Function(UserName: PChar; NameLen: WORD; PassWord: PChar; PassLen: WORD): Integer; stdcall;
  TStartCapCallBack = Procedure(nChannel: Integer); stdcall;
  TStopCapCallBack = Procedure(nChannel: Integer); stdcall;
  TVoiceDataCallBack = Procedure(pRecvDataBuffer: PChar; dwBufSize, dwUser: DWORD); stdcall;
  TStartVoiceCallBack = Procedure(); stdcall;
  TStopVoiceCallBack = Procedure(); stdcall;
  //����ӿں���

  //ȡ�ð汾��Ϣ
Function ServerGetSDKVersion(): DWORD; stdcall;

//������������
Function ServerStart(VideoInfo: PHIE_SERVER_VIDEOINFO): BOOL; stdcall;

//ֹͣ��������
Function ServerStop(): BOOL; stdcall;

//��ȡ��������״̬
Function ServerGetState(ClientNum: PWORD): BOOL; stdcall;

//IP��֤����
Function ServerCheckIP(CallBack: TCheckIPCallBack): BOOL; stdcall;

//�����֤����
Function ServerCheckPassword(CallBack: TCheckPassWordCallBack): BOOL; stdcall;

//�������ݺ���
Procedure ServerWriteData(nChannel: DWORD; pPacketBuffer: PUCHAR; nPacketSize: DWORD; FrameType: Integer); stdcall;

//��������ص�
Procedure ServerSetStart(CallBack: TStartCapCallBack); stdcall;

//ֹͣ����ص�
Procedure ServerSetStop(CallBack: TStopCapCallBack); stdcall;

//���ý������������ز���
Procedure ServerSetMessage(nMessage: UINT; HWND: HWND); stdcall;

//��������ͨ��cChannel�ϵ����пͻ��˷���������
Function ServerCommandToClient(cCommand: Char; cChannel: Char): BOOL; stdcall;

//��ָ���ͻ��˷�����Ϣ�ַ���
Function ServerStringToClient(m_lAddrIP: PAnsiChar; m_sCommand: PChar; m_wLen: WORD): BOOL; stdcall;

//��ȡ�ͻ�����Ϣ
Procedure ServerReadLastMessage(m_sIP, m_sCommand: PChar; m_wLen: PWORD); stdcall;

//��nChannelͨ�����������ӽ��г�ʼ��
Procedure ServerResetChannel(nChannel: DWORD); stdcall;

//��������˿ں�
Function ServerSetNetPort(wServerPort, wClientPort: WORD): BOOL; stdcall;

//���÷��ͻ������Ĵ�С(��λ��8K , ��Χ�� 10 - 100 )
Function ServerSetBufNum(nChannel: DWORD; wBufNum: WORD): BOOL; stdcall;

//�������ӿͻ��˵ĵȴ�ʱ��ͳ��Դ���(dwEachWaitTime �ȴ�ʱ�䵥λ���� , dwTryNum ���Դ�����Χ1-50)
Function ServerSetWait(dwEachWaitTime, dwTryNum: DWORD): BOOL; stdcall;

//��������ָ��ͨ���ϵ����пͻ��˷�����Ϣ�ַ���
Function ServerStringToClient_Other(cChannel: Char; cCommand: PChar; wLen: WORD): BOOL; stdcall;

//��ָ��IP��ַ��ָ��ͨ������һ֡����
Procedure ServerSendOneFrame(m_sIP: PChar; cChannel: Char); stdcall;

//Version 3.0.4 add
//����ϵͳ�ļ�ͷ,SDK �ᷢһ��������ÿһ���µ�Զ������
Function ServerWriteSysHeader(nChannel: DWORD; HeaderBuf: PByte; HeaderLen: Integer): BOOL; stdcall;
//add for voice
//1
Function ServerSetVoiceCom(CallBack: TVoiceDataCallBack; dwUser: DWORD): BOOL; stdcall;

//2
Function ServerSetVoiceStart(CallBack: TStartVoiceCallBack): BOOL; stdcall;

//3
Function ServerSetVoiceStop(CallBack: TStopVoiceCallBack): BOOL; stdcall;

//4
Function ServerStartVoiceCom(): BOOL; stdcall;

//5
Function ServerStopVoiceCom(): BOOL; stdcall;
Implementation

Const
  HIEServerDLL = 'hIEServer.dll';

Function ServerGetSDKVersion; External HIEServerDLL Name 'MP4Net_ServerGetSDKVersion';
Function ServerStart; External HIEServerDLL Name 'MP4Net_ServerStart';
Function ServerStop; External HIEServerDLL Name 'MP4Net_ServerStop';
Function ServerGetState; External HIEServerDLL Name 'MP4Net_ServerGetState';
Function ServerCheckIP; External HIEServerDLL Name 'MP4Net_ServerCheckIP';
Function ServerCheckPassword; External HIEServerDLL Name 'MP4Net_ServerCheckPassword';
Procedure ServerWriteData; External HIEServerDLL Name 'MP4Net_ServerWriteData';
Procedure ServerSetStart; External HIEServerDLL Name 'MP4Net_ServerSetStart';
Procedure ServerSetStop; External HIEServerDLL Name 'MP4Net_ServerSetStop';
Procedure ServerSetMessage; External HIEServerDLL Name 'MP4Net_ServerSetMessage';
Function ServerCommandToClient; External HIEServerDLL Name 'MP4Net_ServerCommandToClient';
Function ServerStringToClient; External HIEServerDLL Name 'MP4Net_ServerStringToClient';
Procedure ServerReadLastMessage; External HIEServerDLL Name 'MP4Net_ServerReadLastMessage';
Procedure ServerResetChannel; External HIEServerDLL Name 'MP4Net_ServerResetChannel';
Function ServerSetNetPort; External HIEServerDLL Name 'MP4Net_ServerSetNetPort';
Function ServerSetBufNum; External HIEServerDLL Name 'MP4Net_ServerSetBufNum';
Function ServerSetWait; External HIEServerDLL Name 'MP4Net_ServerSetWait';
Function ServerStringToClient_Other; External HIEServerDLL Name 'MP4Net_ServerStringToClient_Other';
Procedure ServerSendOneFrame; External HIEServerDLL Name 'MP4Net_ServerSendOneFrame';
Function ServerWriteSysHeader; External HIEServerDLL Name 'MP4Net_ServerWriteSysHeader';
Function ServerSetVoiceCom; External HIEServerDLL Name 'MP4Net_ServerSetVoiceCom';
Function ServerSetVoiceStart; External HIEServerDLL Name 'MP4Net_ServerSetVoiceStart';
Function ServerSetVoiceStop; External HIEServerDLL Name 'MP4Net_ServerSetVoiceStop';
Function ServerStartVoiceCom; External HIEServerDLL Name 'MP4Net_ServerStartVoiceCom';
Function ServerStopVoiceCom; External HIEServerDLL Name 'MP4Net_ServerStopVoiceCom';

End.

