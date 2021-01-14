unit OtherMng_PBCCommon;

interface

uses
  Classes;
  
const
  //������ָ��
  PLGBPACOMM_CMD_SRVSTR = $1001; //������������
  PLGBPACOMM_CMD_SRVSTP = $1002; //ֹͣ��������
  PLGBPACOMM_CMD_SRVCFG = $1003; //���÷�������

  PLGBPACOMM_CMD_CLNSTR = $2001; //�����ͻ���
  PLGBPACOMM_CMD_CLNSTP = $2002; //ֹͣ�ͻ���
  PLGBPACOMM_CMD_CLNSF = $2003; //�ͻ��˷����ļ�
  PLGBPACOMM_CMD_CLNRF = $2004; //�ͻ��˽����ļ�
  PLGBPACOMM_CMD_CLNCFG = $2005; //���ÿͻ���

  //���÷�����
  PLGBPACOMM_RTC_SRVSTROK = $010100; //�������������ɹ�
  PLGBPACOMM_RTC_SRVSTRERR = $0101FF; //������������ʧ��

  PLGBPACOMM_RTC_CLNCNOK = $020100; //�ͻ������ӳɹ�
  PLGBPACOMM_RTC_CLNCNERR = $0201FF; //�ͻ�������ʧ��
  PLGBPACOMM_RTC_CLNSFOK = $020200; //�ͻ��˷����ļ��ɹ�
  PLGBPACOMM_RTC_CLNSFERR = $0202FF; //�ͻ��˷����ļ�ʧ��

  //ͨѶ������Ϣ
  BPACOMM_MSG_CLNWB = $020101; //�ͻ���TCPClient����OnWorkBegin�¼�
  BPACOMM_MSG_CLNWK = $020102; //�ͻ���TCPClient����OnWork�¼�
  BPACOMM_MSG_CLNWE = $020103; //�ͻ���TCPClient����OnWorkEnd�¼�

  BPACOMM_MSG_CLNCL = $020201; //�ͻ���Socket���Ӷ�ʧ

type
  //ͨѶ������Ϣ���ԭ��
  TBpaCommMsgHandler = procedure(Ac_MsgReciever: TComponent;
    const Ai_Msg: Integer; Ac_Args: TStrings);

implementation

end.
