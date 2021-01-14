Unit tmSDK_Dynamic;

Interface

Uses Windows, tmSDK_DataType;

Var
  {��ʼ�����а忨,�ú���Ӧ��Ӧ���������ʱ����,�������ֵΪ 0 ��ʾ��ʼ��ʧ��}
  InitDSPs: Function(): Integer; cdecl;

  {�ر����а忨�� DSP ����,�ú���Ӧ��Ӧ������˳�ʱ����}
  DeInitDSPs: Function(): Integer; cdecl;

  {��λĳ DSP ϵͳ��ע����������øú���ʱ����ȷ�� DSP �����޷�����ָ�ʱ�ٹر���ص���Դ��λ DSP}
  ResetDSP: Function(DspNumber {DSP ��������}: Integer): Integer; cdecl;

  {�� 16 λ(BCD ��)���,�� 8 λΪ���汾, �� 8 λΪ�ΰ汾, ���Ϊ 32 λ�� BUILD ��,�����������ʱ�����ð汾������޸�ʱ��}
  GetSDKVersion: Function(VersionInfo: PVERSION_INFO): Integer; cdecl;

  {��ȡ�忨�����⹦����Ϣ}
  GetCapability: Function(hChannelHandle: THandle;
    Capability: PCHANNEL_CAPABILITY     //ָ�� CHANNEL_CAPABILITY �Ĳ���ָ��
    ): Integer; cdecl;

  {��ȡ SDK �� DSP ���󱨸�}
  GetLastErrorNum: Function(hChannelHandle: THandle;
    DspError,                           //DSP ����
    SdkError: PULONG                    //SDK ����
    ): Integer; cdecl;

  {��ȡ�忨Ӳ����Ϣ}
  GetBoardInfo: Function(hChannelHandle: THandle;
    BoardType,                          //�忨�ͺ�
    SerialNo: PULONG                    //�忨 ID ��
    ): Integer; cdecl;

  {�򿪶�Ӧͨ��,��ȡ��Ӧͨ���Ĳ������,���Ӧͨ������صĲ�������ʹ�øþ��}
  ChannelOpen: Function(ChannelNum: Integer): THandle; cdecl;

  {�رն�Ӧͨ��,�ͷ������Դ}
  ChannelClose: Function(hChannelHandle: THandle): Integer; cdecl;

  {��ȡĿǰ�Ѵ򿪵�ͨ����}
  GetTotalChannels: Function(): Integer; cdecl;

  {��ȡ��ʹ�õ���Ƶ DSP ����,��С��ϵͳ�а�װ�� DSP ����,�������һ DSP ��ʼ��ʧ��}
  GetTotalDSPs: Function(): Integer; cdecl;

  {������Ӧͨ����ƵԤ��,����� VideoFormat ������Ϊ YUV ����,����Ƶ����������֧��Ӳ��
Overlay ����,��Ƶ��������������Ϊ 16 λɫ�� 32 λɫ.��� VideoFormat ����Ϊ RGB ����,��
���� DDRAW ģʽ��ʾ,��Ƶ���ڻḲ������λ�ڴ��ڷ�Χ�ڵ�����}
  StartVideoPreview: Function(hChannelHandle: THandle;
    WndHandle: HWND;                    //��ʾ���ھ��
    RECT: PRECT;                        //��ʾ��������ʾλ��
    bOverlay: Boolean;                  //�򿪻�ر� Overlay ģʽԤ��
    VideoFormat: TTypeVideoFormat;      //��Ƶ��ʽ
    FrameRate: Integer                  //��Ƶ֡��
    ): Integer; cdecl;

  {ֹͣ��Ӧͨ����ƵԤ��}
  StopVideoPreview: Function(hChannelHandle: THandle): Integer; cdecl;

  {���ڵ��ú��� StartVideoPreview֮ǰ���øú�����������Ӧ�Ĵ�����ɫ����Ϊһ������ɫ��}
  SetOverlayColorKey: Function(DestColorKey: COLORREF): Integer; cdecl;

  {��ָ�����ȵ��������������� StartVideoCapture �� StartMotionDetection
��SDK �̻߳�����ע����û�������Ϣ����������ָ������Ϣ�����ṩ��Ϣ��Դ��ͨ���š�
���û������յ�����Ϣʱ���ɵ��ñ���������ȡ���ݣ�Length ����Ϊ����ʱ�����ṩ����Ĵ�
С��ReadStreamData ���жϻ����Ƿ��㹻����������㹻����ǰ֡��ϢΪ I ֡����
1������֡��Ϣ���� 0������-1}
  ReadStreamData: Function(hChannelHandle: THandle;
    DataBuf: Pointer;                   //�Զ�������ݻ�����
    Length: PDWORD;                     //���룺����Ĵ�С�������һ֡���ݵĳ���
    FrameType: PInteger                 //���֡����
    ): Integer; cdecl;

  {������׼����ʱ��SDK ����hWnd ���ڷ���MessageId ��Ϣ��Ŀ�괰���յ� Message ��ɵ���ReadStreamData ��ȡһ֡����}
  RegisterMessageNotifyHandle: Function(HWND {��Ӧ���ھ��}: HWND; MessageId {�Զ������Ϣ����}: UINT): Integer; cdecl;

  {��һ����������ȡ��ʽ�����ô˺���ʱ���ṩͨ���ż� Context ָ��}
  RegisterStreamReadCallback: Function(StreamReadCallback: STREAM_READ_CALLBACK; Context: Pointer): Integer; cdecl;

  {�������ݽ�ȡ�� SDK ���û��������� RegisterMessageNotifyHandle ��ע�����
Ϣ���û������ʹ�� ReadStreamData ����ȡ������}
  StartVideoCapture: Function(hChannelHandle: THandle): Integer; cdecl;

  {ֹͣ���ݽ�ȡ}
  StopVideoCapture: Function(hChannelHandle: THandle): Integer; cdecl;

  {���ö�Ӧͨ����Ƶ����(����,�Աȶ�,���Ͷ�,ɫ��)}
  SetVideoPara: Function(hChannelHandle: THandle;
    Brightness,                         //����ָ��ֵ( 0 �C 255 )
    Contrast,                           //�Աȶ�ָ��ֵ( 0 �C 127 )
    Saturation,                         // ���Ͷ�ָ��ֵ( 0 �C 127 )
    Hue: Integer                        //ɫ��ָ��ֵ( 0 �C 255 )
    ): Integer; cdecl;

  {��ȡ��Ӧͨ������Ƶ����}
  GetVideoPara: Function(hChannelHandle: THandle;
    VideoStandard: PVideoStandard;
    Brightness,                         //����ָ��ֵ( 0 �C 255 )
    Contrast,                           //�Աȶ�ָ��ֵ( 0 �C 127 )
    Saturation,                         // ���Ͷ�ָ��ֵ( 0 �C 127 )
    Hue: PInteger                       //ɫ��ָ��ֵ( 0 �C 255 )
    ): Integer; cdecl;

  {��ϵͳ���� CTRL+ALT+DEL ʱϵͳ�� OVERLAY ����ᱻǿ�ƹرգ����øú���ʱ���Իָ� OVERLAY ���档}
  RestoreOverlay: Function(): Integer;

  {��ý�����Ƶ�ź������������Ƶ��ʧ����}
  GetVideoSignal: Function(hChannelHandle: THandle): Integer; cdecl;

  {���֡ͳ����Ϣ}
  GetFramesStatistics: Function(hChannelHandle: THandle; FramesStatistics: PFRAMES_STATISTICS): Integer; cdecl;

  {�� 24 λ bmp �ļ�ת�� yuv ��ʽ������}
  LoadYUVFromBmpFile: Function(FileName: PChar;
    yuv: PChar;                         //YUV422 ��ʽ��ͼ��ָ��
    BufLen: Integer;                    //yuv �����С
    Width,                              //���� yuv ͼ��Ŀ��
    Height: PInteger                    //���� yuv ͼ��ĸ߶�
    ): Integer; cdecl;

  {�� yuv ͼ��ת�� 24 λ bmp �ļ�}
  SaveYUVToBmpFile: Function(FileName: PChar;
    yuv: PChar;                         //YUV422 ��ʽ��ͼ��ָ��
    Width,                              //yuv ͼ��Ŀ��
    Height: Integer                     //yuv ͼ��ĸ߶�
    ): Integer; cdecl;

  {��������������}
  SetupMosaic: Function(hChannelHandle: THandle;
    RectList: PRECT;                    //������������
    NumberOfAreas: Integer              //�����������
    ): Integer; cdecl;

  {������Ӧͨ�������˹���}
  StartMosaic: Function(hChannelHandle: THandle): Integer; cdecl;

  {ֹͣ��Ӧͨ�������˹���}
  StopMosaic: Function(hChannelHandle: THandle): Integer; cdecl;

  {���� OSD ��ʾ���ڵ�ǰ��ϵͳʱ������������ʱ���������Ԥ����Ƶ֮�ϣ�����͸���������Ե�����ֱ�����λ��}
  SetOsd: Function(hChannelHandle: THandle; Enable: BOOL): Integer; cdecl;

  SetOsdDisplayMode: Function(hChannelHandle: THandle;
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
  SetLogo: Function(hChannelHandle: THandle;
    x,                                  //���Ͻ�λ�� x(0-351)
    y,                                  //���Ͻ�λ�� y(0-287)
    w,                                  //���(0-128)
    h: Integer;                         //�߶�(0-64)
    yuv: PChar                          //YUV422 ��ʽ��ͼ��ָ��
    ): Integer; cdecl;

  {ֹͣ OSD ��ʾ}
  StopLogo: Function(hChannelHandle: THandle): Integer;

  {��ͨ���ú��������� LOGO ����ʾģʽ}
  SetLogoDisplayMode: Function(hChannelHandle: THandle;
    ColorKey: COLORREF;                 //LOGO ͼ�����ɫ������ʾʱ��ȫ͸��
    Translucent: BOOL;                  //LOGO ͼ���Ƿ�����͸������
    TwinkleInterval: Integer            //��˸��ʱ�����ã��� 16��������ʾΪ 0xXXYY,����XX Ϊ��ʾ��������YY Ϊֹͣ��ʾ��������XXYY ��Ϊ 0 ʱ������ʾ
    ): Integer; cdecl;

  {������Ƶ��׼����ĳһ��ʽ������ͷ�Ѿ��Ӻõ����������ϵͳʱ�ɲ��ص��øú��������
û�н�����ͷ�����������ϵͳȻ���ٽ� NTSC ��ʽ������ͷ�������øú�����������;����
��ͬ��ʽ������ͷҲ������øú���}
  SetVideoStandard: Function(hChannelHandle: THandle; VideoStandard: TVideoStandard): Integer; cdecl;

  {����������}
  SetStreamType: Function(hChannelHandle: THandle; StreamType {������}: Word): Integer; cdecl;

  {��ȡ������}
  GetStreamType: Function(hChannelHandle: THandle; StreamType {ָ��������ָ��}: PWORD): Integer; cdecl;

  {����֡�ṹ���ؼ�֡�����B ֡��Ŀ��֡�ʣ����йؼ�֡�������С�� 1��B֡��Ŀ����Ϊ 0��
1 �� 2��P ֡��ʱ��Ϊ��Ч��֡�ʷ�Χ 1-25����������ʱ�趨�� }
  SetIBPMode: Function(hChannelHandle: THandle; KeyFrameIntervals {�ؼ�֡�����Ĭ��ֵΪ 100��}, BFrames {B ֡����Ĭ��ֵΪ 2��}, PFrames {P ֡��}, FrameRate {֡�ʣ�Ĭ��ֵΪ 25��}: Integer): Integer; cdecl;

  {����ͼ������ϵ�������ڵ���ͼ��������ϵ��Խ������Խ�ã�ȡֵ��Χ��12-30����һ��ȡֵ
��Ϊ��ȡ I֡�� P ֡һ����B ֡�����Ǵ� 3 ��5�����磺15��15��20�� 18��18��23������ϵͳ
Ĭ��ֵΪ 18��18��23��}
  SetDefaultQuant: Function(hChannelHandle: THandle; IQuantVal, PQuantVal, BQuantVal: Integer): Integer; cdecl;

  {�����������������ʣ�MaxBps ��Ϊ0 ʱ���ʿ�����Ч��������Ϊĳһ��������ʱ������
��������������ֵʱ��DSP ���Զ�����������������ֲ������������ʣ������ʵ���������
��ʱ��DSP �����и��棬�������Ϊ<10%�� bCbr }
  SetupBitrateControl: Function(hChannelHandle: THandle; MaxBps {�������ʣ�10000 ���ϣ�}: ULong; bCbr {�Ƿ���ú㶨����}: BOOL): Integer; cdecl;

  {���õ�ǰͨ���ı����ʽ��������¼��ֹͣʱ����}
  SetEncoderPictureFormat: Function(hChannelHandle: THandle; PictureFormat {����ͼ���С��CIF ��QCIF��}: TPictureFormat): Integer; cdecl;

  {��Ŀǰ����֡ǿ���趨Ϊ I ֡ģʽ���ɴ���������ȡ��֡�����������紫��}
  CaptureIFrame: Function(hChannelHandle: THandle): Integer; cdecl;

  SetupAimDetectArea: Function(hChannelHandle: THandle; RectList: PRECT; NumberOfAreas: Integer): Integer; cdecl;
  StartAimDetect: Function(hChannelHandle: THandle): Integer; cdecl;
  StopAimDetect: Function(hChannelHandle: THandle): Integer; cdecl;
  RegisterLogRecordCallback: Function(LogRecordFunc: LOGRECORD_CALLBACK; Context: Pointer): Integer; cdecl;

  {�����˶�������򣬵��յ��˶���Ϣ������֡��PktMotionDetection��ʱ,����
MotionAnalyzer, MotionAnalyzer ������� SetupMotionDetection �е�
����������ÿ����Ҫ�������򣬵�ĳ������˶���ֵ(MotionAnalyzer �����еĽӿڲ�
��iThreshold)����ʱ�����ڷ��ص��������飨MotionAnalyzer�����еĽӿڲ���iResult��
���������ж�}
  SetupMotionDetection: Function(hChannelHandle: THandle; RectList {������������}: PRECT; iAreas {�����������}: Integer): Integer; cdecl;

  {�����˶���⣬�˶������Ϣ��ͨ�����������ͣ��û��������� PktMotionDetection ֡��
��ʱ���ɵ��� MotionAnalyzer �������˶���Ϣ������� MotionAnalyzer ��
iResult �з��ء�Ҳ���԰��� SDK �ṩ�����ݸ�ʽ���Լ�������ע�⣺�˶����������໥������
�û�������ڲ��������������½����˶����}
  StartMotionDetection: Function(hChannelHandle: THandle): Integer; cdecl;

  {ֹͣ�˶����}
  StopMotionDetection: Function(hChannelHandle: THandle): Integer; cdecl;

  {�˶������ DSP ��ɣ�DSP �ͳ��� IPktMotionData ֡�����Ѿ������õ��˶���Ϣ���������
�˶�������������ɣ�����Դ�������е� PktMotionData ֡�ṩ���� Demo Դ��� OndataReady
���֣�������� iResult ��˵�����û������ʹ���������ṩ���˶�ǿ����Ϣ���Լ����������
�ú����������������}
  MotionAnalyzer: Function(hChannelHandle: THandle;
    MotionData: PChar;                  //�˶�ʸ��ָ��
    iThreshold: Integer;                //�ж��Ƿ��˶���һ���˶���ֵ( 0 �C 100 )
    iResult: PInteger                   //�����˶���ֵָ����ǿ�ȷ�����Ľ������һ������,��С�� SetupMotionDetection �� numberOfAreas ָ���� ���ĳ���鵥Ԫ��ֵ��������������������˶��Ҹ�ֵ�����˶�ǿ��
    ): Integer; cdecl;

  {�����˶����������ȣ����ڱ���ʱ��̬�����˶����������ȣ����� DSP ȫ���˶���������
���ȣ��� MotionAnalyzer �� iThreshold ��ͬ��������Ҫ������������ָ��������˶�
ͳ�ƽ�����ȼ� 0 ��������6 ��ٶۣ��Ƽ�ֵΪ 2}
  AdjustMotionDetectPrecision: Function(hChannelHandle: THandle;
    iGrade,                             //�˶����������ȵȼ���0-6��
    iFastMotionDetectFps,               //�����˶�����֡�����ȡֵ��Χ 0-12��0 ��ʾ���������˶���⣬ͨ��ֵΪ 2
    iSlowMotionDetectFps: Integer       //�����˶���⣬�ʺ��������˶������ͨ��ȡֵ 13 ���ϣ���ȡֵΪ 0 ʱ ���������˶����
    ): Integer; cdecl;

  {������ƵԤ�����򿪻�رգ�ϵͳֻ����һ·��}
  SetAudioPreview: Function(hChannelHandle: THandle; bEnable: BOOL): Integer; cdecl;

  {��ȡ��ǰͨ�����ֳ��������ȣ�ע�⵱����������ʱ�򱳾�������ԭ�򷵻�ֵ����Ϊ 0}
  GetSoundLevel: Function(hChannelHandle: THandle): Integer; cdecl;

  {���õ�ǰͨ�����ֳ���������}
  SetSoundLevel: Function(hChannelHandle: THandle): Integer; cdecl;

  {���ԭʼͼ��ԭʼͼ���Ǳ�׼�� CIF ͼ���ʽ(���� QCIF ����)���û�����ɵ���
SaveYUVToBmpFile ������ 24 λ�� bmp �ļ�}
  GetOriginalImage: Function(hChannelHandle: THandle;
    ImageBuf: PUCHAR;                   //ԭʼͼ��ָ�� YUV ����
    Size: PULONG                        //ԭʼͼ��Ĵ�С��ע������ǰ�� Imagebuf �Ĵ�С�����ú���ʵ��ͼ����ʹ�õ��ֽ�����
    ): Integer; cdecl;

  SetHorOffset: Function(hChannelHandle: THandle; HorOffset: Integer): Integer; cdecl;

  SetAuxCodecMode: Function(hChannelHandle: THandle; KeyFrameIntervals, FrameRate, BitRate: Integer): Integer; cdecl;
  StartAuxCodec: Function(hChannelHandle: THandle): Integer; cdecl;
  StopAuxCodec: Function(hChannelHandle: THandle): Integer; cdecl;

  {��������Ƶ�ź���ʾ����}
  SetLanguage: Function(hChannelHandle: THandle;
    Language: Integer                   //0   ����[����Ƶ�ź�]  1 Ӣ��[No Video]
    ): Integer; cdecl;

  DumpDebug: Function(hChannelHandle: THandle): Integer; cdecl;

  GetChannelInfo: Function(hChannelHandle: THandle; pChannelInfo: PCHANNEL_INFO): Integer; cdecl;

Function InitLib(FileName: String): Boolean;
Procedure FreeLib;
Implementation

Uses SysUtils;

Const
  tmSDKName = 'tmSDK.DLL';
Var
  DllHandle: THandle = 0;

Function InitLib(FileName: String): Boolean;
  Function SDKGetProcAddress(FuncName: String): Pointer;
  Begin
    Result := GetProcAddress(DllHandle, PChar(FuncName));
  End;

Begin
  If DllHandle <> 0 Then Result := True
  Else
  Begin
    If Not FileExists(FileName) Then FileName := tmSDKName;
    DllHandle := LoadLibrary(PChar(FileName));
    If DllHandle <> 0 Then
    Begin
      @InitDSPs := SDKGetProcAddress('MP4Sys_InitDSPs');
      @DeInitDSPs := SDKGetProcAddress('MP4Sys_DeInitDSPs');
      @ResetDSP := SDKGetProcAddress('MP4Sys_ResetDSP');

      @GetSDKVersion := SDKGetProcAddress('MP4Sys_GetSDKVersion');
      @GetCapability := SDKGetProcAddress('MP4Sys_GetCapability');
      @GetLastErrorNum := SDKGetProcAddress('MP4Sys_GetLastErrorNum');
      @GetBoardInfo := SDKGetProcAddress('MP4Sys_GetBoardInfo');

      @ChannelOpen := SDKGetProcAddress('MP4Sys_ChannelOpen');
      @ChannelClose := SDKGetProcAddress('MP4Sys_ChannelClose');
      @GetTotalChannels := SDKGetProcAddress('MP4Sys_GetTotalChannels');
      @GetTotalDSPs := SDKGetProcAddress('MP4Sys_GetTotalDSPs');

      @StartVideoPreview := SDKGetProcAddress('MP4Sys_StartVideoPreview');
      @StopVideoPreview := SDKGetProcAddress('MP4Sys_StopVideoPreview');
      @SetOverlayColorKey := SDKGetProcAddress('MP4Sys_SetOverlayColorKey');

      @ReadStreamData := SDKGetProcAddress('MP4Sys_ReadStreamData');
      @RegisterMessageNotifyHandle := SDKGetProcAddress('MP4Sys_RegisterMessageNotifyHandle');
      @RegisterStreamReadCallback := SDKGetProcAddress('MP4Sys_RegisterStreamReadCallback');

      @StartVideoCapture := SDKGetProcAddress('MP4Sys_StartVideoCapture');
      @StopVideoCapture := SDKGetProcAddress('MP4Sys_StopVideoCapture');

      @SetVideoPara := SDKGetProcAddress('MP4Sys_SetVideoPara');
      @GetVideoPara := SDKGetProcAddress('MP4Sys_GetVideoPara');
      @RestoreOverlay := SDKGetProcAddress('MP4Sys_RestoreOverlay');

      @GetVideoSignal := SDKGetProcAddress('MP4Sys_GetVideoSignal');
      @GetFramesStatistics := SDKGetProcAddress('MP4Sys_GetFramesStatistics');
      @LoadYUVFromBmpFile := SDKGetProcAddress('MP4Sys_LoadYUVFromBmpFile');
      @SaveYUVToBmpFile := SDKGetProcAddress('MP4Sys_SaveYUVToBmpFile');

      @SetupMosaic := SDKGetProcAddress('MP4Sys_SetupMosaic');
      @StartMosaic := SDKGetProcAddress('MP4Sys_StartMosaic');
      @StopMosaic := SDKGetProcAddress('MP4Sys_StopMosaic');

      @SetOsd := SDKGetProcAddress('MP4Sys_SetOsd');
      @SetOsdDisplayMode := SDKGetProcAddress('MP4Sys_SetOsdDisplayMode');
      @SetLogo := SDKGetProcAddress('MP4Sys_SetLogo');
      @StopLogo := SDKGetProcAddress('MP4Sys_StopLogo');
      @SetLogoDisplayMode := SDKGetProcAddress('MP4Sys_SetLogoDisplayMode');

      @SetVideoStandard := SDKGetProcAddress('MP4Sys_SetVideoStandard');

      @SetStreamType := SDKGetProcAddress('MP4Sys_SetStreamType');
      @GetStreamType := SDKGetProcAddress('MP4Sys_GetStreamType');

      @SetIBPMode := SDKGetProcAddress('MP4Sys_SetIBPMode');
      @SetDefaultQuant := SDKGetProcAddress('MP4Sys_SetDefaultQuant');
      @SetupBitrateControl := SDKGetProcAddress('MP4Sys_SetupBitrateControl');
      @SetEncoderPictureFormat := SDKGetProcAddress('MP4Sys_SetEncoderPictureFormat');
      @CaptureIFrame := SDKGetProcAddress('MP4Sys_CaptureIFrame');
      @SetupAimDetectArea := SDKGetProcAddress('MP4Sys_SetupAimDetectArea');
      @StartAimDetect := SDKGetProcAddress('MP4Sys_StartAimDetect');
      @StopAimDetect := SDKGetProcAddress('MP4Sys_StopAimDetect');
      @RegisterLogRecordCallback := SDKGetProcAddress('MP4Sys_RegisterLogRecordCallback');

      @SetupMotionDetection := SDKGetProcAddress('MP4Sys_SetupMotionDetection');
      @StartMotionDetection := SDKGetProcAddress('MP4Sys_StartMotionDetection');
      @StopMotionDetection := SDKGetProcAddress('MP4Sys_StopMotionDetection');
      @MotionAnalyzer := SDKGetProcAddress('MP4Sys_MotionAnalyzer');
      @AdjustMotionDetectPrecision := SDKGetProcAddress('MP4Sys_AdjustMotionDetectPrecision');

      @SetAudioPreview := SDKGetProcAddress('MP4Sys_SetAudioPreview');
      @GetSoundLevel := SDKGetProcAddress('MP4Sys_GetSoundLevel');
      @SetSoundLevel := SDKGetProcAddress('MP4Sys_SetSoundLevel');
      @GetOriginalImage := SDKGetProcAddress('MP4Sys_GetOriginalImage');

      @SetHorOffset := SDKGetProcAddress('MP4Sys_SetHorOffset');

      @SetAuxCodecMode := SDKGetProcAddress('MP4Sys_SetAuxCodecMode');
      @StartAuxCodec := SDKGetProcAddress('MP4Sys_StartAuxCodec');
      @StopAuxCodec := SDKGetProcAddress('MP4Sys_StopAuxCodec');
      @SetLanguage := SDKGetProcAddress('MP4Sys_SetLanguage');
      @DumpDebug := SDKGetProcAddress('MP4Sys_DumpDebug');

      @GetChannelInfo := SDKGetProcAddress('MP4Sys_GetChannelInfo');
    End;
    Result := DllHandle <> 0;
  End;
End;

Procedure FreeLib;
Begin
  If DllHandle <> 0 Then
    FreeLibrary(DllHandle);
  DllHandle := 0;
End;

Initialization
  //InitLib('');
Finalization
  //FreeLib;

End.

