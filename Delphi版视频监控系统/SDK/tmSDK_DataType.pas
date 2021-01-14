unit tmSDK_DataType;

interface

Uses Windows;

Type
  TPictureFormat = LongWord;            //ͼ���ʽ
  TTypeVideoFormat = LongWord;
  TBitrateControlType = LongWord;
  PFrameType = ^TFrameType;
  TFrameType = LongWord;
  PVideoStandard = ^TVideoStandard;
  TVideoStandard = LongWord;

Const
  MAX_CHANNELS = 16;
  End_Code = $00000002;

  PAL_QCIF_WIDTH = 176;
  PAL_QCIF_HIGHT = 144;
  PAL_CIF_WIDTH = 352;
  PAL_CIF_HIGHT = 288;
  PAL_TWOCIF_WIDTH = 704;
  PAL_TWOCIF_HIGHT = 288;
  PAL_MD_WIDTH = 512;
  PAL_MD_HIGHT = 288;
  PAL_D1_WIDTH = 704;
  PAL_D1_HIGHT = 576;

  NTSC_QCIF_WIDTH = 160;
  NTSC_QCIF_HIGHT = 120;
  NTSC_CIF_WIDTH = 320;
  NTSC_CIF_HIGHT = 240;
  NTSC_TWOCIF_WIDTH = 640;
  NTSC_TWOCIF_HIGHT = 240;
  NTSC_MD_WIDTH = 416;
  NTSC_MD_HIGHT = 240;
  NTSC_D1_WIDTH = 640;
  NTSC_D1_HIGHT = 480;

  StandardNone: TVideoStandard = $80000000; //����Ƶ�ź�
  StandardNTSC: TVideoStandard = $00000001; //NTSC ��ʽ
  StandardPAL: TVideoStandard = $00000002; //PAL ��ʽ
  StandardSECAM: TVideoStandard = $00000004; //SECAM ��ʽ

  vdfRGB8A_233: TTypeVideoFormat = $00000001;
  vdfRGB8R_332: TTypeVideoFormat = $00000002;
  vdfRGB15Alpha: TTypeVideoFormat = $00000004;
  vdfRGB16: TTypeVideoFormat = $00000008; //16 λ RGB ��Ƶѹ����ʽ
  vdfRGB24: TTypeVideoFormat = $00000010; //24 λ RGB ��Ƶѹ����ʽ
  vdfRGB24Alpha: TTypeVideoFormat = $00000020;
  vdfYUV420Planar: TTypeVideoFormat = $00000040;
  vdfYUV422Planar: TTypeVideoFormat = $00000080; //YUV422 ��Ƶѹ����ʽ
  vdfYUV411Planar: TTypeVideoFormat = $00000100;
  vdfYUV420Interspersed: TTypeVideoFormat = $00000200;
  vdfYUV422Interspersed: TTypeVideoFormat = $00000400;
  vdfYUV411Interspersed: TTypeVideoFormat = $00000800;
  vdfYUV422Sequence: TTypeVideoFormat = $00001000;
  vdfYUV422SequenceAlpha: TTypeVideoFormat = $00002000;
  vdfMono: TTypeVideoFormat = $00004000;
  vdfYUV444Planar: TTypeVideoFormat = $00008000;

  brCBR: TBitrateControlType = 0;
  brVBR: TBitrateControlType = 1;

  PktError = $0000;                     //֡��Ϣ����
  PktIFrames = $0001;                   //I ֡
  PktPFrames = $0002;                   //P ֡
  PktBBPFrames = $0004;                 //B ֡
  PktDspStatus = $0020;                 //DSP ��Ϣ֡
  PktAudioFrames = $0008;               //��Ƶ֡
  PktQCIFIFrames = $0010;               //�˶����֡
  PktQCIFPFrames = $0040;               //ԭʼͼ��֡
  PktBIFrames = $0090;
  PktBBIFrames = $00C0;
  PktSysHeader = $0080;                 //ϵͳͷ
  PktSFrames = $0200;                   //��̬֡
  PktBPFrames = $0100;                  //BP ֡

  PktAimDetection = $0400;
  PktOrigImage = $0800;
  PktMotionDetection = $1000;

  //�ɼ����ֱ���(ֵԽ��ֱ���Խ�ߣ�ͼ��������Խ�ã�
  ENC_CIF_FORMAT: TPictureFormat = 0;
  ENC_QCIF_FORMAT: TPictureFormat = 1;
  ENC_2CIF_FORMAT: TPictureFormat = 2;
  ENC_MD_FORMAT: TPictureFormat = 3;
  //ENC_QQCIF_FORMAT  : TPictureFormat = 4;
  //ENC_CIFQCIF_FORMAT: TPictureFormat = 5;
  //ENC_CIFQQCIF_FORMAT: TPictureFormat = 6;
  //ENC_DCIF_FORMAT   : TPictureFormat = 7;

  _OSD_BASE = $9000;
  _OSD_YEAR4 = _OSD_BASE + 0;
  _OSD_YEAR2 = _OSD_BASE + 1;
  _OSD_MONTH3 = _OSD_BASE + 2;
  _OSD_MONTH2 = _OSD_BASE + 3;
  _OSD_DAY = _OSD_BASE + 4;
  _OSD_WEEK3 = _OSD_BASE + 5;
  _OSD_CWEEK1 = _OSD_BASE + 6;
  _OSD_HOUR24 = _OSD_BASE + 7;
  _OSD_HOUR12 = _OSD_BASE + 8;
  _OSD_MINUTE = _OSD_BASE + 9;
  _OSD_SECOND = _OSD_BASE + 10;

  STREAM_TYPE_VIDEO = 1;                //��Ƶ��
  STREAM_TYPE_AUDIO = 2;                //��Ƶ��
  STREAM_TYPE_AVSYNC = 3;               //����Ƶͬ����

Type
  PFRAMES_STATISTICS = ^TFRAMES_STATISTICS;
  TFRAMES_STATISTICS = Record
    VideoFrames: ULong;                 //��Ƶ֡
    AudioFrames: ULong;                 //��Ƶ֡
    FramesLost: ULong;                  //��ʧ֡
    QueueOverflow: ULong;               //�������
  End;

  PCHANNEL_CAPABILITY = ^TChannelCapability;
  TChannelCapability = Record
    bAudioPreview: UCHAR;               //��ƵԤ��
    bAlarmIO: UCHAR;                    //�����ź�
    bWatchDog: UCHAR;                   //���Ź�
  End;

  PVERSION_INFO = ^TVERSION_INFO;
  TVERSION_INFO = Record
    DspVersion: ULong;                  //DSP�汾��
    DspBuildNum: ULong;                 //������
    DriverVersion: ULong;               //�����汾��
    DriverBuildNum: ULong;              //����������
    SDKVersion: ULong;                  //SDK�汾��
    SDKBuildNum: ULong;                 //SDK������
  End;

  PCHANNEL_INFO = ^TCHANNEL_INFO;
  TCHANNEL_INFO = Record
    PictureFormat: TPictureFormat;
    Reserved: Array[0..5] Of ULong;
  End;

  PMOTION_DATA_HEADER = ^TMotionData;
  TMotionData = Record
    PicFormat: TPictureFormat;
    HorizeBlocks: ULong;
    VerticalBlocks: ULong;
    BlockSize: ULong;
  End;

  TLogrecord_CallBack = Procedure(Str: PChar; Context: Pointer); cdecl;
  TStream_Read_CallBack = Function(ChannelNumber: UINT; Context: Pointer): Integer; cdecl;

implementation

end.
 