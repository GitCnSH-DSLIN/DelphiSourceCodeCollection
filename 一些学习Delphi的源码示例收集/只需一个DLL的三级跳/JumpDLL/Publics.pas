unit Publics;

interface

uses
  Windows;

type
  TNode = record        // �ڴ�ӳ������ṹ
    MainThread: DWORD;  // Start.exe�߳�ID
    ExplorerID: DWORD;  // Explorer ����ID
  end;
  PNode = ^TNode;

const
  DllMutex = 'JumpInsert_DllMutex_Mazi'; // ��ֻ֤����һ���߳�
  FileMapName = 'JumpInsert_FileMap_Mazi'; // �ڴ�ӳ���ļ���

var
  FileMap: THandle;
  PtNode: PNode;

implementation

end.
