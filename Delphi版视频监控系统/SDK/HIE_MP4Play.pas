Unit HIE_MP4Play;
////////////////////////////////////////////////
//VERSION:      3.0                           //
//COPYRIGHT:    High-Easy                     //
////////////////////////////////////////////////
Interface

Uses
  Windows;

Const
  //���֧��ͨ����
  MP4Play_MAX_SUPPORTS = 20;

  MP4Play_NOERROR = 0;                  //û�д���
  MP4Play_PARA_OVER = 1;                //��������Ƿ���
  MP4Play_ORDER_ERROR = 2;              //����˳�򲻶ԣ�
  MP4Play_DEC_VIDEO_ERROR = 4;          //��Ƶ����ʧ�ܣ�
  MP4Play_DEC_AUDIO_ERROR = 5;          //��Ƶ����ʧ�ܣ�
  MP4Play_ALLOC_MEMORY_ERROR = 6;       //�����ڴ�ʧ�ܣ�
  MP4Play_OPEN_FILE_ERROR = 7;          //�ļ�����ʧ�ܣ�
  MP4Play_CREATE_OBJ_ERROR = 8;         //�����߳��¼���ʧ�ܣ�
  MP4Play_CREATE_DDRAW_ERROR = 9;       //����directDrawʧ�ܣ�
  MP4Play_CREATE_OFFSCREEN_ERROR = 10;  //������˻���ʧ�ܣ�
  MP4Play_BUF_OVER = 11;                //����������������ʧ�ܣ�
  MP4Play_CREATE_SOUND_ERROR = 12;      //������Ƶ�豸ʧ�ܣ�
  MP4Play_SET_VOLUME_ERROR = 13;        //��������ʧ�ܣ�
  MP4Play_SUPPORT_FILE_ONLY = 14;       //ֻ���ڲ����ļ�ʱ����ʹ�ô˽ӿڣ�
  MP4Play_SUPPORT_STREAM_ONLY = 15;     //ֻ���ڲ�����ʱ����ʹ�ô˽ӿڣ�
  MP4Play_SYS_NOT_SUPPORT = 16;         //ϵͳ��֧�֣�������ֻ�ܹ�����Pentium 3���ϣ�
  MP4Play_FILEHEADER_UNKNOWN = 17;      //û���ļ�ͷ��
  MP4Play_VERSION_INCORRECT = 18;       //�������ͱ������汾����Ӧ��
  MP4Play_INIT_DECODER_ERROR = 19;      //��ʼ��������ʧ�ܣ�
  MP4Play_CHECK_FILE_ERROR = 20;        //�����ļ�ͷβ����ʱû���ҵ���Ч���ݣ��ļ�̫�̻������޷�ʶ��
  MP4Play_BLT_ERROR = 22;               //λ����ʧ�ܣ�
  MP4Play_UPDATE_ERROR = 23;            //��ʾoverlayʧ�ܣ�

  MAX_DISPLAY_WND = 4;

  //��ʾ����
  DISPLAY_NORMAL = 1;
  DISPLAY_QUARTER = 2;

  //�ж��Ƿ�֧��
  SUPPORT_DDRAW = 1;                    //֧��DIRECTDRAW��
  SUPPORT_BLT = 2;                      //�Կ�֧��BLT������
  SUPPORT_BLTFOURCC = 4;                //�Կ�BLT֧����ɫת����
  SUPPORT_BLTSHRINKX = 8;               //�Կ�BLT֧��X����С��
  SUPPORT_BLTSHRINKY = 16;              //�Կ�BLT֧��Y����С��
  SUPPORT_BLTSTRETCHX = 32;             //�Կ�BLT֧��X��Ŵ�
  SUPPORT_BLTSTRETCHY = 64;             //�Կ�BLT֧��Y��Ŵ�
  SUPPORT_SSE = 128;                    //CPU֧��SSEָ�
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

  //���ݻ�����С��
  SOURCE_BUF_MAX = 2048 * 1000;
  SOURCE_BUF_MIN = 1024 * 50;

  //����������
  STREAME_REALTIME = 0;                 //ʵʱ���룬�ʺϰ忨���ɵ�ʵʱ��������Ĭ��ֵ.
  STREAME_FILE = 1;                     //������룬�ʺ��ļ������룻

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

  PFRAME_TYPE = ^TFRAME_TYPE;
  TFRAME_TYPE = Record
    pDataBuf: PChar;                    //����֡�׵�ַ
    nSize: LongInt;                     //����֡�Ĵ�С
    nFrameNum: LongInt;                 //����֡�ĸ���
    bIsAudio: BOOL;                     //�Ƿ���Ƶ֡
    nReserved: LongInt;                 //����
  End;

  TDecCBFunCallBack = Procedure(nPort: LongInt; pBuf: PChar; nSize: LongInt; pFrameInfo: PFRAME_INFO; nReserved1, nReserved2: LongInt);
  TDisplayCBFunCallBack = Procedure(nPort: LongInt; pBuf: PChar; nSize, nWidth, nHeight, nStamp, nType, nReserved: LongInt); stdcall;
  TSourceBufCallBack = Procedure(nPort: LongInt; nBufSize, dwUser: DWORD; pResvered: Pointer); stdcall;
  TFileRefDoneCallBack = Procedure(nPort, nUser: DWORD); stdcall;
  TAudioCallBack = Procedure(nPort: LongInt; pAudioBuf: PChar; nSize, nStamp, nType, nUser: LongInt); stdcall;
  TDrawFunCallBack = Procedure(nPort: LongInt; HDC: HDC; nUser: LongInt); stdcall;
  TEnchangeCallBack = Procedure(nPort: LongInt; nUser: LongInt); stdcall;
  TGetOrignalFrameCallBack = Procedure(nPort: LongInt; FrameType: PFRAME_TYPE; nUser: LongInt); stdcall;
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //API

Function InitDDraw(HWND: HWND): BOOL; stdcall;

Function RealeseDDraw(): BOOL; stdcall;

Function OpenFile(nPort: LongInt; sFileName: PAnsiChar): BOOL; stdcall;

Function CloseFile(nPort: LongInt): BOOL; stdcall;

Function Play(nPort: LongInt; HWND: HWND): BOOL; stdcall;

Function Stop(nPort: LongInt): BOOL; stdcall;

Function Pause(nPort: LongInt; nPause: DWORD): BOOL; stdcall;

Function Fast(nPort: LongInt): BOOL; stdcall;

Function Slow(nPort: LongInt): BOOL; stdcall;

Function OneByOne(nPort: LongInt): BOOL; stdcall;

Function SetPlayPos(nPort: LongInt; fRelativePos: Extended): BOOL; stdcall;

Function GetPlayPos(nPort: LongInt): Extended; stdcall;

Function SetFileEndMsg(nPort: LongInt; HWND: HWND; nMsg: UINT): BOOL; stdcall;

Function SetVolume(nPort: LongInt; nVolume: WORD): BOOL; stdcall;

Function StopSound(): BOOL; stdcall;

Function PlaySound(nPort: LongInt): BOOL; stdcall;

Function OpenStream(nPort: LongInt; pFileHeadBuf: PBYTE; nSize: DWORD; nBufPoolSize: DWORD): BOOL; stdcall;

Function InputData(nPort: LongInt; pBuf: PBYTE; nSize: DWORD): BOOL; stdcall;

Function CloseStream(nPort: LongInt): BOOL; stdcall;

Function GetCaps(): Integer; stdcall;

Function GetFileTime(nPort: LongInt): DWORD; stdcall;

Function GetPlayedTime(nPort: LongInt): DWORD; stdcall;

Function ChangeContrast(nPort: LongInt; degree: Integer): BOOL; stdcall;

Function ChangeBright(nPort: LongInt; degree: Integer): BOOL; stdcall;

Function LocalZoom(nPort: LongInt; bLocalZoom: BOOL; Left, Top, Width, Height: Integer): BOOL; stdcall;

////////////////////////////////////////////////////////////////////////////////////
Function SetDecCallBack(nPort: LongInt; CallBack: TDecCBFunCallBack): BOOL; stdcall;

Function SetDisplayCallBack(nPort: LongInt; CallBack: TDisplayCBFunCallBack): BOOL; stdcall;

Function ConvertToBmpFile(pBuf: PChar; nSize, nWidth, nHeight, nType: LongInt; sFileName: PChar): BOOL; stdcall;

Function GetFileTotalFrames(nPort: LongInt): DWORD; stdcall;

Function GetCurrentFrameRate(nPort: LongInt): DWORD; stdcall;

Function GetPlayedTimeEx(nPort: LongInt): DWORD; stdcall;

Function SetPlayedTimeEx(nPort: LongInt; nTime: DWORD): BOOL; stdcall;

Function GetCurrentFrameNum(nPort: LongInt): DWORD; stdcall;

Function SetStreamOpenMode(nPort: LongInt; nMode: DWORD): BOOL; stdcall;

Function GetFileHeadLength(): DWORD; stdcall;

Function GetSdkVersion(): DWORD; stdcall;
////////////////////////////////////////////////////////////////////////////////////

Function GetLastError(nPort: LongInt): DWORD; stdcall;

Function RefreshPlay(nPort: LongInt): BOOL; stdcall;

Function SetOverlayMode(nPort: LongInt; bOverlay: BOOL; colorKey: COLORREF): BOOL; stdcall;

Function GetPictureSize(nPort: LongInt; pWidth: PLongInt; pHeight: PLongInt): BOOL; stdcall;

Function SetPicQuality(nPort: LongInt; bHighQuality: BOOL): BOOL; stdcall;

Function PlaySoundShare(nPort: LongInt): BOOL; stdcall;

Function StopSoundShare(nPort: LongInt): BOOL; stdcall;

Function WaterMarkIsRight(nPort: LongInt): BOOL; stdcall;
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
Function GetOverlayMode(nPort: LongInt): LongInt; stdcall;

Function GetColorKey(nPort: LongInt): COLORREF; stdcall;

Function GetVolume(nPort: LongInt): WORD; stdcall;

Function GetPictureQuality(nPort: LongInt; bHighQuality: PBOOL): BOOL; stdcall;

Function GetSourceBufferRemain(nPort: LongInt): DWORD; stdcall;

Function ResetSourceBuffer(nPort: LongInt): BOOL; stdcall;

Function SetSourceBufCallBack(nPort: LongInt; nThreShold: DWORD; CallBack: TSourceBufCallBack; dwUser: DWORD; pReserved: Pointer): BOOL; stdcall;

Function ResetSourceBufFlag(nPort: LongInt): BOOL; stdcall;

Function SetDisplayBuf(nPort: LongInt; nNum: DWORD): BOOL; stdcall;

Function GetDisplayBuf(nPort: LongInt): DWORD; stdcall;

Function OneByOneBack(nPort: LongInt): BOOL; stdcall;

Function SetFileRefCallBack(nPort: LongInt; CallBack: TFileRefDoneCallBack; nUser: DWORD): BOOL; stdcall;

Function SetCurrentFrameNum(nPort: LongInt; nFrameNum: DWORD): BOOL; stdcall;

Function GetKeyFramePos(nPort: LongInt; nValue, nType: DWORD; pFramePos: PFRAME_POS): BOOL; stdcall;

Function GetNextKeyFramePos(nPort: LongInt; nValue, nType: DWORD; pFramePos: PFRAME_POS): BOOL; stdcall;

Function ThrowBFrameNum(nPort: LongInt; nNum: DWORD): BOOL; stdcall;

Function SetPlaySpeed(nPort: LongInt; nSpeed: Integer): BOOL; stdcall;

Function GetStreamOpenMode(nPort: LongInt): LongInt; stdcall;

Function GetFilePos(nPort: LongInt): ULONG; stdcall;

Function SetAudioCallBack(nPort: LongInt; CallBack: TAudioCallBack; nUser: LongInt): BOOL; stdcall;

Function RigisterDrawFun(nPort: LongInt; CallBack: TDrawFunCallBack; nUser: LongInt): BOOL; stdcall;

Function SetDisplayRegion(nPort: LongInt; nRegionNum: DWORD; pSrcRect: PRECT; hDestWnd: HWND; bEnable: BOOL): BOOL; stdcall;

Function GetRefValue(nPort: LongInt; pBuffer: PBYTE; pSize: PDWORD): BOOL; stdcall;

Function SetRefValue(nPort: LongInt; pBuffer: PBYTE; nSize: DWORD): BOOL; stdcall;

Function SetEncChangeMsg(nPort: LongInt; HWND: HWND; nMsg: UINT): BOOL; stdcall;

Function SetEncTypeChangeCallBack(nPort: LongInt; CallBack: TEnchangeCallBack; nUser: LongInt): BOOL; stdcall;

Function SetColor(nPort: LongInt; nRegionNum: DWORD; nBrightness, nContrast, nSaturation, nHue: Integer): BOOL; stdcall;

Function GetColor(nPort: LongInt; nRegionNum: DWORD; pBrightness, pContrast, pSaturation, pHue: PInteger): BOOL; stdcall;

Function SetDecCBStream(nPort: LongInt; nStream: DWORD): BOOL; stdcall;

Function GetOriginalFrameCallBack(nPort: LongInt; bIsChange, bNormalSpeed: BOOL; nStartFrameNum, nStartStamp, nFileHeader: LongInt;
  CallBack: TGetOrignalFrameCallBack; nUser: LongInt): BOOL; stdcall;

Function GetFileSpecialAttr(nPort: LongInt; pTimeStamp, pFileNum, nFileHeader: PDWORD): BOOL; stdcall;

Function SetDisplayType(nPort: LongInt; nType: LongInt): BOOL; stdcall;

Function GetDisplayType(nPort: LongInt): LongInt; stdcall;

Implementation

Const
  hIE_Mp4PlayDLL = 'HIE_MP4Play.dll';

Function InitDDraw; External hIE_Mp4PlayDLL Name 'MP4Play_InitDDraw';
Function RealeseDDraw; External hIE_Mp4PlayDLL Name 'MP4Play_RealeseDDraw';
Function OpenFile; External hIE_Mp4PlayDLL Name 'MP4Play_OpenFile';
Function CloseFile; External hIE_Mp4PlayDLL Name 'MP4Play_CloseFile';
Function Play; External hIE_Mp4PlayDLL Name 'MP4Play_Play';
Function Stop; External hIE_Mp4PlayDLL Name 'MP4Play_Stop';
Function Pause; External hIE_Mp4PlayDLL Name 'MP4Play_Pause';
Function Fast; External hIE_Mp4PlayDLL Name 'MP4Play_Fast';
Function Slow; External hIE_Mp4PlayDLL Name 'MP4Play_Slow';
Function OneByOne; External hIE_Mp4PlayDLL Name 'MP4Play_OneByOne';
Function SetPlayPos; External hIE_Mp4PlayDLL Name 'MP4Play_SetPlayPos';
Function GetPlayPos; External hIE_Mp4PlayDLL Name 'MP4Play_GetPlayPos';
Function SetFileEndMsg; External hIE_Mp4PlayDLL Name 'MP4Play_SetFileEndMsg';
Function SetVolume; External hIE_Mp4PlayDLL Name 'MP4Play_SetVolume';
Function StopSound; External hIE_Mp4PlayDLL Name 'MP4Play_StopSound';
Function PlaySound; External hIE_Mp4PlayDLL Name 'MP4Play_PlaySound';
Function OpenStream; External hIE_Mp4PlayDLL Name 'MP4Play_OpenStream';
Function InputData; External hIE_Mp4PlayDLL Name 'MP4Play_InputData';
Function CloseStream; External hIE_Mp4PlayDLL Name 'MP4Play_CloseStream';
Function GetCaps; External hIE_Mp4PlayDLL Name 'MP4Play_GetCaps';
Function GetFileTime; External hIE_Mp4PlayDLL Name 'MP4Play_GetFileTime';
Function GetPlayedTime; External hIE_Mp4PlayDLL Name 'MP4Play_GetPlayedTime';
Function ChangeContrast; External hIE_Mp4PlayDLL Name 'MP4Play_ChangeContrast';
Function ChangeBright; External hIE_Mp4PlayDLL Name 'MP4Play_ChangeBright';
Function LocalZoom; External hIE_Mp4PlayDLL Name 'MP4Play_LocalZoom';
////////////////////////////////////////////////////////////////////////////////////
Function SetDecCallBack; External hIE_Mp4PlayDLL Name 'MP4Play_SetDecCallBack';
Function SetDisplayCallBack; External hIE_Mp4PlayDLL Name 'MP4Play_SetDisplayCallBack';
Function ConvertToBmpFile; External hIE_Mp4PlayDLL Name 'MP4Play_ConvertToBmpFile';
Function GetFileTotalFrames; External hIE_Mp4PlayDLL Name 'MP4Play_GetFileTotalFrames';
Function GetCurrentFrameRate; External hIE_Mp4PlayDLL Name 'MP4Play_GetCurrentFrameRate';
Function GetPlayedTimeEx; External hIE_Mp4PlayDLL Name 'MP4Play_GetPlayedTimeEx';
Function SetPlayedTimeEx; External hIE_Mp4PlayDLL Name 'MP4Play_SetPlayedTimeEx';
Function GetCurrentFrameNum; External hIE_Mp4PlayDLL Name 'MP4Play_GetCurrentFrameNum';
Function SetStreamOpenMode; External hIE_Mp4PlayDLL Name 'MP4Play_SetStreamOpenMode';
Function GetFileHeadLength; External hIE_Mp4PlayDLL Name 'MP4Play_GetFileHeadLength';
Function GetSdkVersion; External hIE_Mp4PlayDLL Name 'MP4Play_GetSdkVersion';
////////////////////////////////////////////////////////////////////////////////////
Function GetLastError; External hIE_Mp4PlayDLL Name 'MP4Play_GetLastError';
Function RefreshPlay; External hIE_Mp4PlayDLL Name 'MP4Play_RefreshPlay';
Function SetOverlayMode; External hIE_Mp4PlayDLL Name 'MP4Play_SetOverlayMode';
Function GetPictureSize; External hIE_Mp4PlayDLL Name 'MP4Play_GetPictureSize';
Function SetPicQuality; External hIE_Mp4PlayDLL Name 'MP4Play_SetPicQuality';
Function PlaySoundShare; External hIE_Mp4PlayDLL Name 'MP4Play_PlaySoundShare';
Function StopSoundShare; External hIE_Mp4PlayDLL Name 'MP4Play_StopSoundShare';
Function WaterMarkIsRight; External hIE_Mp4PlayDLL Name 'MP4Play_WaterMarkIsRight';
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
Function GetOverlayMode; External hIE_Mp4PlayDLL Name 'MP4Play_GetOverlayMode';
Function GetColorKey; External hIE_Mp4PlayDLL Name 'MP4Play_GetColorKey';
Function GetVolume; External hIE_Mp4PlayDLL Name 'MP4Play_GetVolume';
Function GetPictureQuality; External hIE_Mp4PlayDLL Name 'MP4Play_GetPictureQuality';
Function GetSourceBufferRemain; External hIE_Mp4PlayDLL Name 'MP4Play_GetSourceBufferRemain';
Function ResetSourceBuffer; External hIE_Mp4PlayDLL Name 'MP4Play_ResetSourceBuffer';
Function SetSourceBufCallBack; External hIE_Mp4PlayDLL Name 'MP4Play_SetSourceBufCallBack';
Function ResetSourceBufFlag; External hIE_Mp4PlayDLL Name 'MP4Play_ResetSourceBufFlag';
Function SetDisplayBuf; External hIE_Mp4PlayDLL Name 'MP4Play_SetDisplayBuf';
Function GetDisplayBuf; External hIE_Mp4PlayDLL Name 'MP4Play_GetDisplayBuf';
Function OneByOneBack; External hIE_Mp4PlayDLL Name 'MP4Play_OneByOneBack';
Function SetFileRefCallBack; External hIE_Mp4PlayDLL Name 'MP4Play_SetFileRefCallBack';
Function SetCurrentFrameNum; External hIE_Mp4PlayDLL Name 'MP4Play_SetCurrentFrameNum';
Function GetKeyFramePos; External hIE_Mp4PlayDLL Name 'MP4Play_GetKeyFramePos';
Function GetNextKeyFramePos; External hIE_Mp4PlayDLL Name 'MP4Play_GetNextKeyFramePos';
Function ThrowBFrameNum; External hIE_Mp4PlayDLL Name 'MP4Play_ThrowBFrameNum';
Function SetPlaySpeed; External hIE_Mp4PlayDLL Name 'MP4Play_SetPlaySpeed';
Function GetStreamOpenMode; External hIE_Mp4PlayDLL Name 'MP4Play_GetStreamOpenMode';
Function GetFilePos; External hIE_Mp4PlayDLL Name 'MP4Play_GetFilePos';
Function SetAudioCallBack; External hIE_Mp4PlayDLL Name 'MP4Play_SetAudioCallBack';
Function RigisterDrawFun; External hIE_Mp4PlayDLL Name 'MP4Play_RigisterDrawFun';
Function SetDisplayRegion; External hIE_Mp4PlayDLL Name 'MP4Play_SetDisplayRegion';
Function GetRefValue; External hIE_Mp4PlayDLL Name 'MP4Play_GetRefValue';
Function SetRefValue; External hIE_Mp4PlayDLL Name 'MP4Play_SetRefValue';
Function SetEncChangeMsg; External hIE_Mp4PlayDLL Name 'MP4Play_SetEncChangeMsg';
Function SetEncTypeChangeCallBack; External hIE_Mp4PlayDLL Name 'MP4Play_SetEncTypeChangeCallBack';
Function SetColor; External hIE_Mp4PlayDLL Name 'MP4Play_SetColor';
Function GetColor; External hIE_Mp4PlayDLL Name 'MP4Play_GetColor';
Function SetDecCBStream; External hIE_Mp4PlayDLL Name 'MP4Play_SetDecCBStream';
Function GetOriginalFrameCallBack; External hIE_Mp4PlayDLL Name 'MP4Play_GetOriginalFrameCallBack';
Function GetFileSpecialAttr; External hIE_Mp4PlayDLL Name 'MP4Play_GetFileSpecialAttr';
Function SetDisplayType; External hIE_Mp4PlayDLL Name 'MP4Play_SetDisplayType';
Function GetDisplayType; External hIE_Mp4PlayDLL Name 'MP4Play_GetDisplayType';
End.

