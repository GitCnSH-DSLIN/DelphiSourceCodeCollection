unit Public_Unit;

interface

const
{----��������Ϣ----}  
  PBM_SETRANGE    = $0401;  // ���÷�Χ
  PBM_SETPOS      = $0402;  // ������ֵ
  PBM_SETSTEP     = $0404;  // ���ò���
  PBM_STEPIT      = $0405;  // ����һ��
  PBM_GETPOS      = $0408;  // ȡ����ֵ
  PBM_SETBARCOLOR = $0409;  // ������ɫ
  PBM_SETBKCOLOR  = $2001;  // ������ɫ
  WindowClassName = 'Progress_Mazi'; //��������

var
  WindowHandle: LongWord;   // ��������
  StatusHandle: LongWord;   // ���������
  ContinueAdd: Boolean=True;   // ��ͣ���־

  //����˺���,ʹcomctl32.dll��ͬ����װ��,DLL��ʼ�����뽫ע�����пؼ�������
procedure InitCommonControls; stdcall; external 'ComCtl32.dll' name 'InitCommonControls';

function ShellExecute(hWnd: integer; Operation, FileName, Parameters,Directory: PAnsiChar;
           ShowCmd: Integer):longword; stdcall;external 'shell32.dll' name 'ShellExecuteA';

implementation

end.
