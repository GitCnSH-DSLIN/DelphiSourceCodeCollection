Unit HIE_MP4HDPlay;
///////////////////////////////////////////////////////////////////
//Version:		1.0
///////////////////////////////////////////////////////////////////
Interface
Uses
  Windows;

Const
  //���֧��ͨ����
  MP4Play_MAX_SUPPORTS = 32;

  //MP4Play������
  MP4Play_NOERROR = 0;                  //û�д���
  MP4Play_PARA_OVER = 1;                //��������Ƿ�
  MP4Play_ORDER_ERROR = 2;              //����˳�򲻶�
  MP4Play_DEC_VIDEO_ERROR = 4;          //��Ƶ����ʧ��
  MP4Play_DEC_AUDIO_ERROR = 5;          //��Ƶ����ʧ��
  MP4Play_ALLOC_MEMORY_ERROR = 6;       //�����ڴ�ʧ��
  MP4Play_OPEN_FILE_ERROR = 7;          //�ļ�����ʧ��
  MP4Play_CREATE_OBJ_ERROR = 8;         //�����߳��¼���ʧ��
  MP4Play_CREATE_DDRAW_ERROR = 9;       //����directDrawʧ��
  MP4Play_CREATE_OFFSCREEN_ERROR = 10;  //������˻���ʧ��
  MP4Play_BUF_OVER = 11;                //����������������ʧ��
  MP4Play_CREATE_SOUND_ERROR = 12;      //������Ƶ�豸ʧ��
  MP4Play_SET_VOLUME_ERROR = 13;        //��������ʧ��
  MP4Play_SUPPORT_FILE_ONLY = 14;       //ֻ���ڲ����ļ�ʱ����ʹ�ô˽ӿ�
  MP4Play_SUPPORT_STREAM_ONLY = 15;     //ֻ���ڲ�����ʱ����ʹ�ô˽ӿ�
  MP4Play_SYS_NOT_SUPPORT = 16;         //ϵͳ��֧�֣�������ֻ�ܹ�����Pentium 3����
  MP4Play_FILEHEADER_UNKNOWN = 17;      //û���ļ�ͷ
  MP4Play_VERSION_INCORRECT = 18;       //�������ͱ������汾����Ӧ
  MP4Play_INIT_DECODER_ERROR = 19;      //��ʼ��������ʧ��
  MP4Play_CHECK_FILE_ERROR = 20;        //�����ļ�ͷβ����ʱû���ҵ���Ч�����ļ�̫�̻������޷�ʶ��
  MP4Play_BLT_ERROR = 22;               //λ����ʧ��
  MP4Play_UPDATE_ERROR = 23;            //��ʾoverlayʧ��

  //�ж��Ƿ�֧��
  SUPPORT_DDRAW = 1;                    //֧��DIRECTDRAW
  SUPPORT_BLT = 2;                      //�Կ�֧��BLT����
  SUPPORT_BLTFOURCC = 4;                //�Կ�BLT֧����ɫת��
  SUPPORT_BLTSHRINKX = 8;               //�Կ�BLT֧��X����С
  SUPPORT_BLTSHRINKY = 16;              //�Կ�BLT֧��Y����С
  SUPPORT_BLTSTRETCHX = 32;             //�Կ�BLT֧��X��Ŵ�
  SUPPORT_BLTSTRETCHY = 64;             //�Կ�BLT֧��Y��Ŵ�
  SUPPORT_SSE = 128;                    //CPU֧��SSEָ��
  SUPPORT_MMX = 256;                    //CPU֧��MMX;

  //����֡��Ϣ
Type
  PFRAME_POS = ^TFRAME_POS;
  TFRAME_POS = Record
    nFrameNum: LongInt;                 //֡��
    nFrameTime: UINT;                   //��ʾʱ��
    nFilePos: ULONG;                    //֡���ļ��е�λ��
  End;

Const
  //���Ż��巶Χ
  MAX_DIS_FRAMES = 50;
  MIN_DIS_FRAMES = 6;
  //��������
  BY_FRAMENUM = 1;
  BY_FRAMETIME = 2;

  //���ݻ�����С
  SOURCE_BUF_MAX = 1024 * 1000;
  SOURCE_BUF_MIN = 1024 * 50;
  //����������
  STREAME_REALTIME = 0;                 //ʵʱ���룬�ʺϰ忨���ɵ�ʵʱ��������Ĭ��ֵ.
  STREAME_FILE = 1;                     //������룬�ʺ��ļ�������
  //�ص�������������
  T_AUDIO16 = 101;
  T_UYVY = 1;
  T_YV12 = 3;
  T_RGB32 = 7;

  //֡��Ϣ
Type
  PFRAME_INFO = ^TFRAME_INFO;
  TFRAME_INFO = Record
    nWidth: LongInt;
    nHeight: LongInt;
    nStamp: LongInt;
    nType: LongInt;
    nFrameRate: LongInt;
  End;

  TSourceBufCallBack = Procedure(nPort: LongInt; nBufSize, dwUser: DWORD; pResvered: Pointer); stdcall;
  TFileRefDoneCallBack = Procedure(nPort, nUser: DWORD); stdcall;
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //API
Function SetOverlayColorKey(DestColorKey: COLORREF; Const bUseOverlay: BOOL = TRUE): BOOL; stdcall;

//�򿪲����ļ�
Function OpenFile(nPort: LongInt; sFileName: PAnsiChar): BOOL; stdcall;

//�رղ����ļ�
Function CloseFile(nPort: LongInt): BOOL; stdcall;

//���ſ�ʼ
Function Play(nPort: LongInt; HWND: HWND): BOOL; stdcall;
//���Ž���
Function Stop(nPort: LongInt): BOOL; stdcall;

//������ͣ��nPause=TRUE��ͣ�������
Function Pause(nPort: LongInt; nPause: DWORD): BOOL; stdcall;

//��֡����
Function OneByOne(nPort: LongInt): BOOL; stdcall;

//��֡�ط�
Function OneByOneBack(nPort: LongInt): BOOL; stdcall;

//�����ļ�����ʱ���͵���Ϣ��Ϣ���͵�PLAY����
Function SetFileEndMsg(nPort: LongInt; HWND: HWND; nMsg: UINT): BOOL; stdcall;

//���ò����ļ����λ�÷�Χ0-100%
Function SetPlayPos(nPort: LongInt; fRelativePos: Extended): BOOL; stdcall;

//��ò����ļ����λ�÷�Χ0-100%
Function GetPlayPos(nPort: LongInt): Extended; stdcall;

//������
Function PlaySound(nPort: LongInt): BOOL; stdcall;

//�ر�����
Function StopSound(): BOOL; stdcall;

//��������
Function SetVolume(nPort: LongInt; nVolume: WORD): BOOL; stdcall;

//��ȡ����
Function GetVolume(nPort: LongInt): WORD; stdcall;

//������������ʽ
Function PlaySoundShare(nPort: LongInt): BOOL; stdcall;

//�رձ�·����������ʽ
Function StopSoundShare(nPort: LongInt): BOOL; stdcall;

//����������ģʽ
Function SetStreamOpenMode(nPort: LongInt; nMode: DWORD): BOOL; stdcall;

//����
Function OpenStream(nPort: LongInt; pFileHeadBuf: PBYTE; nSize, nBufPoolSize: DWORD): BOOL; stdcall;

//����������
Function InputData(nPort: LongInt; pBuf: PBYTE; nSize: DWORD): BOOL; stdcall;

//������
Function CloseStream(nPort: LongInt): BOOL; stdcall;

//���ϵͳ��Ϣ
Function GetCaps(): Integer; stdcall;

//�õ��ļ��ܵ�ʱ��
Function GetFileTime(nPort: LongInt): DWORD; stdcall;

//�õ����ڲ��ŵ��ļ�ʱ��
Function GetPlayedTime(nPort: LongInt): DWORD; stdcall;

Function LocalZoom(nPort: LongInt; bLocalZoom: BOOL; Left, Top, Width, Height: Integer): BOOL; stdcall;
////////////////////////////////////////////////////////////////////////////////////
//ת����BMP�ļ�
Function ConvertToBmpFile(pBuf: Pchar; nSize, nWidth, nHeight, nType: LongInt; sFileName: Pchar): BOOL; stdcall;

//�����֡��
Function GetFileTotalFrames(nPort: LongInt): DWORD; stdcall;

//��õ�ǰ����ʱ�䣬��λms
Function GetPlayedTimeEx(nPort: LongInt): DWORD; stdcall;

//����ʱ�����õ�ǰ����λ��
Function SetPlayedTimeEx(nPort: LongInt; nTime: DWORD): BOOL; stdcall;

//��õ�ǰ���ŵ�֡���
Function GetCurrentFrameNum(nPort: LongInt): DWORD; stdcall;
//��õ�ǰ�汾���ļ�ͷ����
Function GetFileHeadLength(): DWORD; stdcall;

//��õ�ǰSDK�汾��Build��
Function GetSdkVersion(): DWORD; stdcall;
////////////////////////////////////////////////////////////////////////////////////

 //��ô����
Function GetLastError(nPort: LongInt): DWORD; stdcall;

//ˢ����ʾ
Function RefreshPlay(nPort: LongInt): BOOL; stdcall;

//��û����С
Function GetPictureSize(nPort: LongInt; pWidth, pHeight: PLongint): BOOL; stdcall;
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

//���Դ����ʣ������
Function GetSourceBufferRemain(nPort: LongInt): DWORD; stdcall;

//���Դ����ʣ������
Function ResetSourceBuffer(nPort: LongInt): BOOL; stdcall;

//����Դ�������޻ص�
Function SetSourceBufCallBack(nPort: LongInt; nThreShold: DWORD; CallBack: TSourceBufCallBack; dwUser: DWORD; pReserved: Pointer): BOOL; stdcall;

//���ñ�־λ���´δﵽ��ֵʱ�ص�
Function ResetSourceBufFlag(nPort: LongInt): BOOL; stdcall;

//���ò��Ż���������֡��
Function SetDisplayBuf(nPort: LongInt; nNum: DWORD): BOOL; stdcall;

//��ò��Ż���������֡��
Function GetDisplayBuf(nPort: LongInt): DWORD; stdcall;

//���ļ�����
Function SetFileRefCallBack(nPort: LongInt; CallBack: TFileRefDoneCallBack; nUser: DWORD): BOOL; stdcall;

//���õ�ǰ����֡��
Function SetCurrentFrameNum(nPort: LongInt; nFrameNum: DWORD): BOOL; stdcall;

//���ҹؼ�֡λ��
Function GetKeyFramePos(nPort: LongInt; nValue, nType: DWORD; pFramePos: PFRAME_POS): BOOL; stdcall;

//������һ���ؼ�֡λ��
Function GetNextKeyFramePos(nPort: LongInt; nValue, nType: DWORD; pFramePos: PFRAME_POS): BOOL; stdcall;

//�����ӿ� ֱ�����ò����ٶ� nSpeed >= -4 && nSpeed <= 4 ,mSpeed = 0 Ϊ�����ٶȲ���//////
Function SetPlaySpeed(nPort: LongInt; nSpeed: Integer): BOOL; stdcall;

Function SnapShot(nPort: LongInt; pBuf: PUCHAR; bufSize: Integer; size, Width, Height: Pinteger): Integer; stdcall;

Function GetAvailableDecoderChannel(): UINT; stdcall;

Implementation

Const
  hIE_Mp4HDPlayDLL = 'HIE_MP4HDPlay.DLL';

Function SetOverlayColorKey; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_SetOverlayColorKey';
Function OpenFile; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_OpenFile';
Function CloseFile; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_CloseFile';
Function Play; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_Play';
Function Stop; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_Stop';
Function Pause; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_Pause';
Function OneByOne; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_OneByOne';
Function OneByOneBack; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_OneByOneBack';
Function SetFileEndMsg; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_SetFileEndMsg';
Function SetPlayPos; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_SetPlayPos';
Function GetPlayPos; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_GetPlayPos';
Function PlaySound; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_PlaySound';
Function StopSound; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_StopSound';
Function SetVolume; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_SetVolume';
Function GetVolume; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_GetVolume';
Function PlaySoundShare; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_PlaySoundShare';
Function StopSoundShare; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_StopSoundShare';
Function SetStreamOpenMode; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_SetStreamOpenMode';
Function OpenStream; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_OpenStream';
Function InputData; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_InputData';
Function CloseStream; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_CloseStream';
Function GetCaps; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_GetCaps';
Function GetFileTime; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_GetFileTime';
Function GetPlayedTime; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_GetPlayedTime';
Function LocalZoom; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_LocalZoom';
////////////////////////////////////////////////////////////////////////////////////
Function ConvertToBmpFile; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_ConvertToBmpFile';
Function GetFileTotalFrames; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_GetFileTotalFrames';
Function GetPlayedTimeEx; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_GetPlayedTimeEx';
Function SetPlayedTimeEx; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_SetPlayedTimeEx';
Function GetCurrentFrameNum; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_GetCurrentFrameNum';
Function GetFileHeadLength; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_GetFileHeadLength';
Function GetSdkVersion; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_GetSdkVersion';
////////////////////////////////////////////////////////////////////////////////////
Function GetLastError; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_GetLastError';
Function RefreshPlay; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_RefreshPlay';
Function GetPictureSize; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_GetPictureSize';
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
Function GetSourceBufferRemain; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_GetSourceBufferRemain';
Function ResetSourceBuffer; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_ResetSourceBuffer';
Function SetSourceBufCallBack; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_SetSourceBufCallBack';
Function ResetSourceBufFlag; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_ResetSourceBufFlag';
Function SetDisplayBuf; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_SetDisplayBuf';
Function GetDisplayBuf; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_GetDisplayBuf';
Function SetFileRefCallBack; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_SetFileRefCallBack';
Function SetCurrentFrameNum; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_SetCurrentFrameNum';
Function GetKeyFramePos; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_GetKeyFramePos';
Function GetNextKeyFramePos; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_GetNextKeyFramePos';
Function SetPlaySpeed; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_SetPlaySpeed';
Function SnapShot; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_SnapShot';
Function GetAvailableDecoderChannel; External hIE_Mp4HDPlayDLL Name 'MP4HDPlay_GetAvailableDecoderChannel';

End.

 