
// Module name: MultInst.C ->> MultInst.dpr
// Notices: Copyright (c) 1995-1997 Jeffrey Richter
// Translator: ������, Liu_mazi@126.com

program MultInst;

{$R 'MultInst.res' 'MultInst.rc'}

uses
  Windows, Messages, CmnHdr in '..\CmnHdr.pas', Other in '..\Other.pas';

const
  IDI_MULTINST = 101;

  // �������
var
  fFirstInstance: BOOL;
  g_lUsageCount: PINT;
begin
  chWARNIFUNICODEUNDERWIN95();

  // ��λ�ֹ��ӵĽ�
  g_lUsageCount := SectionVirualAddress(HInstance, '.Share', 4,
    IMAGE_SCN_MEM_SHARED or IMAGE_SCN_MEM_READ or IMAGE_SCN_MEM_WRITE);
  if (g_lUsageCount = nil) then
  begin
    chMB('SectionVirualAddress() failure ', 'Multiple Instance');
    Exit;
  end;

  // ��������Ӽ���  
  fFirstInstance := InterlockedIncrement(g_lUsageCount^) = 1;

  // �Ƿ��һ��ʵ��
  if (fFirstInstance = FALSE) then
  begin
    chMB('Application is already running - Terminating this instance ',
      'Multiple Instance', MB_OK or MB_ICONINFORMATION);
  end else
  begin
    chMB( 'Running first instance of application.'#13#10'Select OK to terminate ',
      'Multiple Instance', MB_OK or MB_ICONINFORMATION);
  end;

  // ����ؼ��ټ���
  InterlockedDecrement(g_lUsageCount^);
end.
