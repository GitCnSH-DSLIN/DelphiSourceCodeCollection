Unit tmSDK;

Interface

Uses Windows, tmSDK_DataType;

  {��ʼ�����а忨,�ú���Ӧ��Ӧ���������ʱ����,�������ֵΪ 0 ��ʾ��ʼ��ʧ��}
Function InitDSPs(): Integer; cdecl;

{�ر����а忨�� DSP ����,�ú���Ӧ��Ӧ������˳�ʱ����}
Function DeInitDSPs(): Integer; cdecl;

{��λĳ DSP ϵͳ��ע����������øú���ʱ����ȷ�� DSP �����޷�����ָ�ʱ�ٹر���ص���Դ��λ DSP}
Function ResetDSP(DspNumber {DSP ��������}: Integer): Integer; cdecl;

{�� 16 λ(BCD ��)���,�� 8 λΪ���汾, �� 8 λΪ�ΰ汾, ���Ϊ 32 λ�� BUILD ��,�����������ʱ�����ð汾������޸�ʱ��}
Function GetSDKVersion(VersionInfo: PVERSION_INFO): Integer; cdecl;

{��ȡ�忨�����⹦����Ϣ}
Function GetCapability(hChannelHandle: THandle;
  Capability: PCHANNEL_CAPABILITY       //ָ�� CHANNEL_CAPABILITY �Ĳ���ָ��
  ): Integer; cdecl;

{��ȡ SDK �� DSP ���󱨸�}
Function GetLastErrorNum(hChannelHandle: THandle;
  DspError,                             //DSP ����
  SdkError: PULONG                      //SDK ����
  ): Integer; cdecl;

{��ȡ�忨Ӳ����Ϣ}
Function GetBoardInfo(hChannelHandle: THandle;
  BoardType,                            //�忨�ͺ�
  SerialNo: PULONG                      //�忨 ID ��
  ): Integer; cdecl;

{�򿪶�Ӧͨ��,��ȡ��Ӧͨ���Ĳ������,���Ӧͨ������صĲ�������ʹ�øþ��}
Function ChannelOpen(ChannelNum: Integer): THandle; cdecl;

{�رն�Ӧͨ��,�ͷ������Դ}
Function ChannelClose(hChannelHandle: THandle): Integer; cdecl;

{��ȡĿǰ�Ѵ򿪵�ͨ����}
Function GetTotalChannels(): Integer; cdecl;

{��ȡ��ʹ�õ���Ƶ DSP ����,��С��ϵͳ�а�װ�� DSP ����,�������һ DSP ��ʼ��ʧ��}
Function GetTotalDSPs(): Integer; cdecl;

{������Ӧͨ����ƵԤ��,����� VideoFormat ������Ϊ YUV ����,����Ƶ����������֧��Ӳ��
Overlay ����,��Ƶ��������������Ϊ 16 λɫ�� 32 λɫ.��� VideoFormat ����Ϊ RGB ����,��
���� DDRAW ģʽ��ʾ,��Ƶ���ڻḲ������λ�ڴ��ڷ�Χ�ڵ�����}
Function StartVideoPreview(hChannelHandle: THandle;
  WndHandle: HWND;                      //��ʾ���ھ��
  RECT: PRECT;                          //��ʾ��������ʾλ��
  bOverlay: Boolean;                    //�򿪻�ر� Overlay ģʽԤ��
  VideoFormat: TTypeVideoFormat;        //��Ƶ��ʽ
  FrameRate: Integer                    //��Ƶ֡��
  ): Integer; cdecl;

{ֹͣ��Ӧͨ����ƵԤ��}
Function StopVideoPreview(hChannelHandle: THandle): Integer; cdecl;

{���ڵ��ú��� StartVideoPreview֮ǰ���øú�����������Ӧ�Ĵ�����ɫ����Ϊһ������ɫ��}
Function SetOverlayColorKey(DestColorKey: COLORREF): Integer; cdecl;

{��ָ�����ȵ��������������� StartVideoCapture �� StartMotionDetection
��SDK �̻߳�����ע����û�������Ϣ����������ָ������Ϣ�����ṩ��Ϣ��Դ��ͨ���š�
���û������յ�����Ϣʱ���ɵ��ñ���������ȡ���ݣ�Length ����Ϊ����ʱ�����ṩ����Ĵ�
С��ReadStreamData ���жϻ����Ƿ��㹻����������㹻����ǰ֡��ϢΪ I ֡����
1������֡��Ϣ���� 0������-1}
Function ReadStreamData(hChannelHandle: THandle;
  DataBuf: Pointer;                     //�Զ�������ݻ�����
  Length: PDWORD;                       //���룺����Ĵ�С�������һ֡���ݵĳ���
  FrameType: PInteger                   //���֡����
  ): Integer; cdecl;

{������׼����ʱ��SDK ����hWnd ���ڷ���MessageId ��Ϣ��Ŀ�괰���յ� Message ��ɵ���ReadStreamData ��ȡһ֡����}
Function RegisterMessageNotifyHandle(HWND {��Ӧ���ھ��}: HWND; MessageId {�Զ������Ϣ����}: UINT): Integer; cdecl;

{��һ����������ȡ��ʽ�����ô˺���ʱ���ṩͨ���ż� Context ָ��}
Function RegisterStreamReadCallback(StreamReadCallback: STREAM_READ_CALLBACK; Context: Pointer): Integer; cdecl;

{�������ݽ�ȡ�� SDK ���û��������� RegisterMessageNotifyHandle ��ע�����
Ϣ���û������ʹ�� ReadStreamData ����ȡ������}
Function StartVideoCapture(hChannelHandle: THandle): Integer; cdecl;

{ֹͣ���ݽ�ȡ}
Function StopVideoCapture(hChannelHandle: THandle): Integer; cdecl;

{���ö�Ӧͨ����Ƶ����(����,�Աȶ�,���Ͷ�,ɫ��)}
Function SetVideoPara(hChannelHandle: THandle;
  Brightness,                           //����ָ��ֵ( 0 �C 255 )
  Contrast,                             //�Աȶ�ָ��ֵ( 0 �C 127 )
  Saturation,                           // ���Ͷ�ָ��ֵ( 0 �C 127 )
  Hue: Integer                          //ɫ��ָ��ֵ( 0 �C 255 )
  ): Integer; cdecl;

{��ȡ��Ӧͨ������Ƶ����}
Function GetVideoPara(hChannelHandle: THandle;
  VideoStandard: PVideoStandard;
  Brightness,                           //����ָ��ֵ( 0 �C 255 )
  Contrast,                             //�Աȶ�ָ��ֵ( 0 �C 127 )
  Saturation,                           // ���Ͷ�ָ��ֵ( 0 �C 127 )
  Hue: PInteger                         //ɫ��ָ��ֵ( 0 �C 255 )
  ): Integer; cdecl;

{��ϵͳ���� CTRL+ALT+DEL ʱϵͳ�� OVERLAY ����ᱻǿ�ƹرգ����øú���ʱ���Իָ� OVERLAY ���档}
Function RestoreOverlay(): Integer;

{��ý�����Ƶ�ź������������Ƶ��ʧ����}
Function GetVideoSignal(hChannelHandle: THandle): Integer; cdecl;

{���֡ͳ����Ϣ}
Function GetFramesStatistics(hChannelHandle: THandle; FramesStatistics: PFRAMES_STATISTICS): Integer; cdecl;

{�� 24 λ bmp �ļ�ת�� yuv ��ʽ������}
Function LoadYUVFromBmpFile(FileName: PChar;
  yuv: PChar;                           //YUV422 ��ʽ��ͼ��ָ��
  BufLen: Integer;                      //yuv �����С
  Width,                                //���� yuv ͼ��Ŀ��
  Height: PInteger                      //���� yuv ͼ��ĸ߶�
  ): Integer; cdecl;

{�� yuv ͼ��ת�� 24 λ bmp �ļ�}
Function SaveYUVToBmpFile(FileName: PChar;
  yuv: PChar;                           //YUV422 ��ʽ��ͼ��ָ��
  Width,                                //yuv ͼ��Ŀ��
  Height: Integer                       //yuv ͼ��ĸ߶�
  ): Integer; cdecl;

{��������������}
Function SetupMosaic(hChannelHandle: THandle;
  RectList: PRECT;                      //������������
  NumberOfAreas: Integer                //�����������
  ): Integer; cdecl;

{������Ӧͨ�������˹���}
Function StartMosaic(hChannelHandle: THandle): Integer; cdecl;

{ֹͣ��Ӧͨ�������˹���}
Function StopMosaic(hChannelHandle: THandle): Integer; cdecl;

{���� OSD ��ʾ���ڵ�ǰ��ϵͳʱ������������ʱ���������Ԥ����Ƶ֮�ϣ�����͸���������Ե�����ֱ�����λ��}
Function SetOsd(hChannelHandle: THandle; Enable: BOOL): Integer; cdecl;

Function SetOsdDisplayMode(hChannelHandle: THandle;
  osdColor: COLORREF;                   //OSD ��ʾ��ɫ
  Translucent: BOOL;                    //OSD ͼ���Ƿ�����͸������
  TwinkleInterval: Integer;             //��˸��ʱ�����ã��� 16��������ʾΪ 0xXXYY,����XX Ϊ��ʾ��������YY Ϊֹͣ��ʾ��������XXYY ��Ϊ 0 ʱ������ʾ
  Format1, Format2: PWORD {�����ַ����ӵ�λ�úʹ���ĸ�ʽ�������嶨���£�
  USHORT X�� USHORT Y�� CHAR0�� CHAR1�� CHAR2��? CHARN, NULL������X��Y
  �Ǹ��ִ��ڱ�׼ CIF ͼ�����ʼλ�ã�X ������ 8 �ı�����Y ������ͼ��߶���
  ȡֵ����0-287��PAL ����0-239��NTSC��CHARN Ҳ�� USHORT �͵Ĳ����������� ASCII
  ��Ҳ�����Ǻ��֣�����Ҫ��ʾ��ǰʱ��ʱ������ָ��Ϊ�̶���ʱ�䶨��ֵ����ֵ
  ���£� _OSD_YEAR4 ��λ������ʾ���� 2002�� _OSD_YEAR2 ��λ������ʾ����
  02��_OSD_MONTH3 Ӣ�ĵ�����ʾ���� Jan��_OSD_MONTH2 ��λ���������ֵ�����
  ʾ���� 07��_OSD_DAY ��λ�İ��������ֵ�����ʾ���� 31��_OSD_WEEK3 Ӣ�ĵ�
  ������ʾ���� Tue��_OSD_CWEEK1 ���ĵ�������ʾ�������ڶ���_OSD_HOUR24 24
  Сʱ��ʱ����ʾ���� 18��_OSD_HOUR12 12 Сʱ��ʱ����ʾ���� AM09 �� PM09��
  _OSD_MINUTE ��λ���ӵ���ʾ��_OSD_SECOND ��λ�����ʾ��
  �ڸ�ʽ�ַ������������� NULL��0����β���������ʾ��������ݡ� �ַ���
  ��ʱ����ʾ������ FORMAT1 Ҳ������FORAMT2��Ҳ���Ի����һ�𣬵����ó���
  һ�� CIF ͼ��Ŀ��}
  ): Integer; cdecl;

{����OSD ��Ļͼ��λ�ü����ݣ��û�����ɵ��� LoadYUVFromBmpFile ��ȡ 24 λ bmp
�ļ��л�ȡ YUV ���ݣ��� 4.32��,͸�������� DSP ���}
Function SetLogo(hChannelHandle: THandle;
  x,                                    //���Ͻ�λ�� x(0-351)
  y,                                    //���Ͻ�λ�� y(0-287)
  w,                                    //���(0-128)
  h: Integer;                           //�߶�(0-64)
  yuv: PChar                            //YUV422 ��ʽ��ͼ��ָ��
  ): Integer; cdecl;

{ֹͣ OSD ��ʾ}
Function StopLogo(hChannelHandle: THandle): Integer;

{��ͨ���ú��������� LOGO ����ʾģʽ}
Function SetLogoDisplayMode(hChannelHandle: THandle;
  ColorKey: COLORREF;                   //LOGO ͼ�����ɫ������ʾʱ��ȫ͸��
  Translucent: BOOL;                    //LOGO ͼ���Ƿ�����͸������
  TwinkleInterval: Integer              //��˸��ʱ�����ã��� 16��������ʾΪ 0xXXYY,����XX Ϊ��ʾ��������YY Ϊֹͣ��ʾ��������XXYY ��Ϊ 0 ʱ������ʾ
  ): Integer; cdecl;

{������Ƶ��׼����ĳһ��ʽ������ͷ�Ѿ��Ӻõ����������ϵͳʱ�ɲ��ص��øú��������
û�н�����ͷ�����������ϵͳȻ���ٽ� NTSC ��ʽ������ͷ�������øú�����������;����
��ͬ��ʽ������ͷҲ������øú���}
Function SetVideoStandard(hChannelHandle: THandle; VideoStandard: TVideoStandard): Integer; cdecl;

{����������}
Function SetStreamType(hChannelHandle: THandle; StreamType {������}: Word): Integer; cdecl;

{��ȡ������}
Function GetStreamType(hChannelHandle: THandle; StreamType {ָ��������ָ��}: PWORD): Integer; cdecl;

{����֡�ṹ���ؼ�֡�����B ֡��Ŀ��֡�ʣ����йؼ�֡�������С�� 1��B֡��Ŀ����Ϊ 0��
1 �� 2��P ֡��ʱ��Ϊ��Ч��֡�ʷ�Χ 1-25����������ʱ�趨�� }
Function SetIBPMode(hChannelHandle: THandle; KeyFrameIntervals {�ؼ�֡�����Ĭ��ֵΪ 100��}, BFrames {B ֡����Ĭ��ֵΪ 2��}, PFrames {P ֡��}, FrameRate {֡�ʣ�Ĭ��ֵΪ 25��}: Integer): Integer; cdecl;

{����ͼ������ϵ�������ڵ���ͼ��������ϵ��Խ������Խ�ã�ȡֵ��Χ��12-30����һ��ȡֵ
��Ϊ��ȡ I֡�� P ֡һ����B ֡�����Ǵ� 3 ��5�����磺15��15��20�� 18��18��23������ϵͳ
Ĭ��ֵΪ 18��18��23��}
Function SetDefaultQuant(hChannelHandle: THandle; IQuantVal, PQuantVal, BQuantVal: Integer): Integer; cdecl;

{�����������������ʣ�MaxBps ��Ϊ0 ʱ���ʿ�����Ч��������Ϊĳһ��������ʱ������
��������������ֵʱ��DSP ���Զ�����������������ֲ������������ʣ������ʵ���������
��ʱ��DSP �����и��棬�������Ϊ<10%�� bCbr }
Function SetupBitrateControl(hChannelHandle: THandle; MaxBps {�������ʣ�10000 ���ϣ�}: ULong; bCbr {�Ƿ���ú㶨����}: BOOL): Integer; cdecl;

{���õ�ǰͨ���ı����ʽ��������¼��ֹͣʱ����}
Function SetEncoderPictureFormat(hChannelHandle: THandle; PictureFormat {����ͼ���С��CIF ��QCIF��}: TPictureFormat): Integer; cdecl;

{��Ŀǰ����֡ǿ���趨Ϊ I ֡ģʽ���ɴ���������ȡ��֡�����������紫��}
Function CaptureIFrame(hChannelHandle: THandle): Integer; cdecl;

Function SetupAimDetectArea(hChannelHandle: THandle; RectList: PRECT; NumberOfAreas: Integer): Integer; cdecl;
Function StartAimDetect(hChannelHandle: THandle): Integer; cdecl;
Function StopAimDetect(hChannelHandle: THandle): Integer; cdecl;
Function RegisterLogRecordCallback(LogRecordFunc: LOGRECORD_CALLBACK; Context: Pointer): Integer; cdecl;

{�����˶�������򣬵��յ��˶���Ϣ������֡��PktMotionDetection��ʱ,����
MotionAnalyzer, MotionAnalyzer ������� SetupMotionDetection �е�
����������ÿ����Ҫ�������򣬵�ĳ������˶���ֵ(MotionAnalyzer �����еĽӿڲ�
��iThreshold)����ʱ�����ڷ��ص��������飨MotionAnalyzer�����еĽӿڲ���iResult��
���������ж�}
Function SetupMotionDetection(hChannelHandle: THandle; RectList {������������}: PRECT; iAreas {�����������}: Integer): Integer; cdecl;

{�����˶���⣬�˶������Ϣ��ͨ�����������ͣ��û��������� PktMotionDetection ֡��
��ʱ���ɵ��� MotionAnalyzer �������˶���Ϣ������� MotionAnalyzer ��
iResult �з��ء�Ҳ���԰��� SDK �ṩ�����ݸ�ʽ���Լ�������ע�⣺�˶����������໥������
�û�������ڲ��������������½����˶����}
Function StartMotionDetection(hChannelHandle: THandle): Integer; cdecl;

{ֹͣ�˶����}
Function StopMotionDetection(hChannelHandle: THandle): Integer; cdecl;

{�˶������ DSP ��ɣ�DSP �ͳ��� IPktMotionData ֡�����Ѿ������õ��˶���Ϣ���������
�˶�������������ɣ�����Դ�������е� PktMotionData ֡�ṩ���� Demo Դ��� OndataReady
���֣�������� iResult ��˵�����û������ʹ���������ṩ���˶�ǿ����Ϣ���Լ����������
�ú����������������}
Function MotionAnalyzer(hChannelHandle: THandle;
  MotionData: PChar;                    //�˶�ʸ��ָ��
  iThreshold: Integer;                  //�ж��Ƿ��˶���һ���˶���ֵ( 0 �C 100 )
  iResult: PInteger                     //�����˶���ֵָ����ǿ�ȷ�����Ľ������һ������,��С�� SetupMotionDetection �� numberOfAreas ָ���� ���ĳ���鵥Ԫ��ֵ��������������������˶��Ҹ�ֵ�����˶�ǿ��
  ): Integer; cdecl;

{�����˶����������ȣ����ڱ���ʱ��̬�����˶����������ȣ����� DSP ȫ���˶���������
���ȣ��� MotionAnalyzer �� iThreshold ��ͬ��������Ҫ������������ָ��������˶�
ͳ�ƽ�����ȼ� 0 ��������6 ��ٶۣ��Ƽ�ֵΪ 2}
Function AdjustMotionDetectPrecision(hChannelHandle: THandle;
  iGrade,                               //�˶����������ȵȼ���0-6��
  iFastMotionDetectFps,                 //�����˶�����֡�����ȡֵ��Χ 0-12��0 ��ʾ���������˶���⣬ͨ��ֵΪ 2
  iSlowMotionDetectFps: Integer         //�����˶���⣬�ʺ��������˶������ͨ��ȡֵ 13 ���ϣ���ȡֵΪ 0 ʱ ���������˶����
  ): Integer; cdecl;

{������ƵԤ�����򿪻�رգ�ϵͳֻ����һ·��}
Function SetAudioPreview(hChannelHandle: THandle; bEnable: BOOL): Integer; cdecl;

{��ȡ��ǰͨ�����ֳ��������ȣ�ע�⵱����������ʱ�򱳾�������ԭ�򷵻�ֵ����Ϊ 0}
Function GetSoundLevel(hChannelHandle: THandle): Integer; cdecl;

{���õ�ǰͨ�����ֳ���������}
Function SetSoundLevel(hChannelHandle: THandle): Integer; cdecl;

{���ԭʼͼ��ԭʼͼ���Ǳ�׼�� CIF ͼ���ʽ(���� QCIF ����)���û�����ɵ���
SaveYUVToBmpFile ������ 24 λ�� bmp �ļ�}
Function GetOriginalImage(hChannelHandle: THandle;
  ImageBuf: PUCHAR;                     //ԭʼͼ��ָ�� YUV ����
  Size: PULONG                          //ԭʼͼ��Ĵ�С��ע������ǰ�� Imagebuf �Ĵ�С�����ú���ʵ��ͼ����ʹ�õ��ֽ�����
  ): Integer; cdecl;

Function SetHorOffset(hChannelHandle: THandle; HorOffset: Integer): Integer; cdecl;

Function SetAuxCodecMode(hChannelHandle: THandle; KeyFrameIntervals, FrameRate, BitRate: Integer): Integer; cdecl;
Function StartAuxCodec(hChannelHandle: THandle): Integer; cdecl;
Function StopAuxCodec(hChannelHandle: THandle): Integer; cdecl;

{��������Ƶ�ź���ʾ����}
Function SetLanguage(hChannelHandle: THandle;
  Language: Integer                     //0   ����[����Ƶ�ź�]  1 Ӣ��[No Video]
  ): Integer; cdecl;

Function DumpDebug(hChannelHandle: THandle): Integer; cdecl;

Function GetChannelInfo(hChannelHandle: THandle; pChannelInfo: PCHANNEL_INFO): Integer; cdecl;

Implementation

Const
  tmSdkDLL = 'tmSDK.DLL';

Function InitDSPs; External tmSdkDLL Name 'MP4Sys_InitDSPs';
Function DeInitDSPs; External tmSdkDLL Name 'MP4Sys_DeInitDSPs';
Function ResetDSP; External tmSdkDLL Name 'MP4Sys_ResetDSP';

Function GetSDKVersion; External tmSdkDLL Name 'MP4Sys_GetSDKVersion';
Function GetCapability; External tmSdkDLL Name 'MP4Sys_GetCapability';
Function GetLastErrorNum; External tmSdkDLL Name 'MP4Sys_GetLastErrorNum';
Function GetBoardInfo; External tmSdkDLL Name 'MP4Sys_GetBoardInfo';

Function ChannelOpen; External tmSdkDLL Name 'MP4Sys_ChannelOpen';
Function ChannelClose; External tmSdkDLL Name 'MP4Sys_ChannelClose';
Function GetTotalChannels; External tmSdkDLL Name 'MP4Sys_GetTotalChannels';
Function GetTotalDSPs; External tmSdkDLL Name 'MP4Sys_GetTotalDSPs';

Function StartVideoPreview; External tmSdkDLL Name 'MP4Sys_StartVideoPreview';
Function StopVideoPreview; External tmSdkDLL Name 'MP4Sys_StopVideoPreview';
Function SetOverlayColorKey; External tmSdkDLL Name 'MP4Sys_SetOverlayColorKey';

Function ReadStreamData; External tmSdkDLL Name 'MP4Sys_ReadStreamData';
Function RegisterMessageNotifyHandle; External tmSdkDLL Name 'MP4Sys_RegisterMessageNotifyHandle';
Function RegisterStreamReadCallback; External tmSdkDLL Name 'MP4Sys_RegisterStreamReadCallback';

Function StartVideoCapture; External tmSdkDLL Name 'MP4Sys_StartVideoCapture';
Function StopVideoCapture; External tmSdkDLL Name 'MP4Sys_StopVideoCapture';

Function SetVideoPara; External tmSdkDLL Name 'MP4Sys_SetVideoPara';
Function GetVideoPara; External tmSdkDLL Name 'MP4Sys_GetVideoPara';
Function RestoreOverlay; External tmSdkDLL Name 'MP4Sys_RestoreOverlay';

Function GetVideoSignal; External tmSdkDLL Name 'MP4Sys_GetVideoSignal';
Function GetFramesStatistics; External tmSdkDLL Name 'MP4Sys_GetFramesStatistics';
Function LoadYUVFromBmpFile; External tmSdkDLL Name 'MP4Sys_LoadYUVFromBmpFile';
Function SaveYUVToBmpFile; External tmSdkDLL Name 'MP4Sys_SaveYUVToBmpFile';

Function SetupMosaic; External tmSdkDLL Name 'MP4Sys_SetupMosaic';
Function StartMosaic; External tmSdkDLL Name 'MP4Sys_StartMosaic';
Function StopMosaic; External tmSdkDLL Name 'MP4Sys_StopMosaic';

Function SetOsd; External tmSdkDLL Name 'MP4Sys_SetOsd';
Function SetOsdDisplayMode; External tmSdkDLL Name 'MP4Sys_SetOsdDisplayMode';
Function SetLogo; External tmSdkDLL Name 'MP4Sys_SetLogo';
Function StopLogo; External tmSdkDLL Name 'MP4Sys_StopLogo';
Function SetLogoDisplayMode; External tmSdkDLL Name 'MP4Sys_SetLogoDisplayMode';

Function SetVideoStandard; External tmSdkDLL Name 'MP4Sys_SetVideoStandard';

Function SetStreamType; External tmSdkDLL Name 'MP4Sys_SetStreamType';
Function GetStreamType; External tmSdkDLL Name 'MP4Sys_GetStreamType';

Function SetIBPMode; External tmSdkDLL Name 'MP4Sys_SetIBPMode';
Function SetDefaultQuant; External tmSdkDLL Name 'MP4Sys_SetDefaultQuant';
Function SetupBitrateControl; External tmSdkDLL Name 'MP4Sys_SetupBitrateControl';
Function SetEncoderPictureFormat; External tmSdkDLL Name 'MP4Sys_SetEncoderPictureFormat';
Function CaptureIFrame; External tmSdkDLL Name 'MP4Sys_CaptureIFrame';
Function SetupAimDetectArea; External tmSdkDLL Name 'MP4Sys_SetupAimDetectArea';
Function StartAimDetect; External tmSdkDLL Name 'MP4Sys_StartAimDetect';
Function StopAimDetect; External tmSdkDLL Name 'MP4Sys_StopAimDetect';
Function RegisterLogRecordCallback; External tmSdkDLL Name 'MP4Sys_RegisterLogRecordCallback';

Function SetupMotionDetection; External tmSdkDLL Name 'MP4Sys_SetupMotionDetection';
Function StartMotionDetection; External tmSdkDLL Name 'MP4Sys_StartMotionDetection';
Function StopMotionDetection; External tmSdkDLL Name 'MP4Sys_StopMotionDetection';
Function MotionAnalyzer; External tmSdkDLL Name 'MP4Sys_MotionAnalyzer';
Function AdjustMotionDetectPrecision; External tmSdkDLL Name 'MP4Sys_AdjustMotionDetectPrecision';

Function SetAudioPreview; External tmSdkDLL Name 'MP4Sys_SetAudioPreview';
Function GetSoundLevel; External tmSdkDLL Name 'MP4Sys_GetSoundLevel';
Function SetSoundLevel; External tmSdkDLL Name 'MP4Sys_SetSoundLevel';
Function GetOriginalImage; External tmSdkDLL Name 'MP4Sys_GetOriginalImage';

Function SetHorOffset; External tmSdkDLL Name 'MP4Sys_SetHorOffset';

Function SetAuxCodecMode; External tmSdkDLL Name 'MP4Sys_SetAuxCodecMode';
Function StartAuxCodec; External tmSdkDLL Name 'MP4Sys_StartAuxCodec';
Function StopAuxCodec; External tmSdkDLL Name 'MP4Sys_StopAuxCodec';
Function SetLanguage; External tmSdkDLL Name 'MP4Sys_SetLanguage';
Function DumpDebug; External tmSdkDLL Name 'MP4Sys_DumpDebug';

Function GetChannelInfo; External tmSdkDLL Name 'MP4Sys_GetChannelInfo';
End.

