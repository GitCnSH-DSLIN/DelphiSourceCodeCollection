unit Global;

interface

uses
  Windows, Messages;

type

  // �����в���
  TCmdParams = record
    ScriptURL: string;          // �����ű��ļ���URL
    CurVersion: string;         // ��������ĵ�ǰ�汾��
    SoftName: string;           // ����������������
    WinHandle: THandle;         // ������������������Ϣ�Ĵ��ھ��
    ExitMsgID: Cardinal;        // ���������յ�����Ϣ��Ӧ�˳�����
    ProcessID: Cardinal;        // ��������Ľ���ID (GetCurrentProcessID)
  end;

  // ����������ļ�
  TSelfUpgFiles = record
    SrcFileName: string;
    DestFileName: string;
  end;

  // ����״̬
  TDownloadState = (dsWait, dsDownloading, dsFinished);

const
  // �Զ���������������
  SSoftName = '�Զ���������';

  // ����״̬�ַ���
  SDnStateStrings: array[TDownloadState] of string =
    ('�ȴ�', '��������', '���');

var
  CmdParams: TCmdParams;        // �����в���
  SelfUpgFiles: TSelfUpgFiles;  // ����������ļ�

implementation

end.
