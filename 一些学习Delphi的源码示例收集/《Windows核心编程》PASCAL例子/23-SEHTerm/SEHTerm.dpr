program SEHTerm;

{$R 'SEHTerm.res' 'SEHTerm.rc'}

uses Windows;

type
  TExceptionDisposition = DWORD; // �쳣�ص�����ֵ����(C�����е�ö����ռ4�ֽ�, ��PASCALֻռ1�ֽ�)
  
  PExceptionFrame = ^TExceptionFrame; // ��չ���쳣֡�ṹ(������FinallyAddress�ֶ���ʵ��Finally)
  TExceptionFrame = record
    PrevStruct: PExceptionFrame; // ��һ�ڵ�λ��(�߳��쳣֡����)
    ExceptionHandler: Pointer;   // �쳣�ص���ַ(�ɲ���ϵͳ����)
    FinallyAddress: procedure;   // ����ִ�е�ַ(�������Լ�����)
  end;

  // �쳣�ص�
function FinallyHandler(var ExceptionRecord: TExceptionRecord; var EstablisherFrame: TExceptionFrame;
  var ContextRecord: TContext; DispatcherContext: Pointer): TExceptionDisposition; Cdecl;
const
  ExceptionContinueSearch = $00000001;
  StatusUnwind = $C0000027;
  ExceptionUnwinding = $00000002;
  ExceptionUnwindingForExit = $00000004;
begin
  if (ExceptionRecord.ExceptionCode = StatusUnwind) or
     (ExceptionRecord.ExceptionFlags = ExceptionUnwinding) or
     (ExceptionRecord.ExceptionFlags = ExceptionUnwindingForExit) then
  begin
    EstablisherFrame.FinallyAddress();
  end;

  Result := ExceptionContinueSearch;
end;

  // �������
const
  lpText1: PChar = 'Perform invalid memory access?';
  lpCaption1: PChar = 'SEHTerm: In try block';

  lpText2: PChar = 'Abnormal termination';
  lpText3: PChar = 'Normal termination';
  lpCaption2: PChar = 'SEHTerm: In finally block';

  lpText4: PChar = 'Normal process termination';
  lpCaption4: PChar = 'SEHTerm: After finally block';

asm
  // ����TExceptionFrame�������������
  PUSH OFFSET  @@Finally     // TExceptionFrame.FinallyAddress
  PUSH OFFSET  FinallyHandler// TExceptionFrame.ExceptionHandler
  PUSH FS:[0]                // TExceptionFrame.PrevStruct
  MOV  FS:[0], ESP           // FS:[0]��TIB.ExceptionList(����ͷ)

  // MessageBox(0, 'Perform invalid memory access?', 'SEHTerm: In try block', MB_YESNO);
  PUSH $00000004             // MB_YESNO
  PUSH lpCaption1            // 'SEHTerm: In try block'
  PUSH lpText1               // 'Perform invalid memory access?'
  PUSH $00000000
  CALL MessageBox

  // if (n = IDYES) then PByte(0)^ := 5;
  CMP  EAX, $00000006        // (n = ID_YES) ???
  JNZ  @@NoAccess            // ����ֵ����IDYES
  MOV  [0], $00000005        // ������ʷǷ���ַ

@@NoAccess:

  // �����ִ�е�����˵��û�г���, ^.^
  POP  FS:[0]                // �����ǽڵ���쳣֡����ժ��
  ADD  ESP, $00000008        // �޸�ջ��ָ��(��ջ�򻯶���)
  PUSH OFFSET @@Other        // ׼������RETָ�����ת��ַ

@@Finally:

  // 1.���û�г���, ���˳��ִ�е�����, :-)
  // 2.�������, Ҳ���ExceptHandler()ת����

  // if AbnormalTermination() then .. ;
  CMP [ESP], OFFSET @@Other  // ����ջ�������Ƿ����@@Other, �ж�֮ǰ�Ƿ����
  JNZ @@Abnormal             // (�Ӷ�ʹ��MessageBox()��ʾ��ͬ����)

  // MessageBox(0, 'Normal termination', 'SEHTerm: In finally block', MB_OK)
  PUSH $00000000             // MB_OK
  PUSH lpCaption2            // 'SEHTerm: In finally block'
  PUSH lpText3               // 'Normal termination'
  PUSH $00000000
  CALL MessageBox

  JMP @@Return

@@Abnormal:

  // MessageBox(0, 'Abnormal termination', 'SEHTerm: In finally block', MB_OK)
  PUSH $00000000             // MB_OK
  PUSH lpCaption2            // 'SEHTerm: In finally block'
  PUSH lpText2               // 'Abnormal termination'
  PUSH $00000000
  CALL MessageBox

@@Return:

  RET                        // û�����쳣��˳��ִ��, ���򷵻�ExceptHandler()

@@Other:

  // MessageBox(0, 'Normal process termination', 'SEHTerm: After finally block', MB_OK);
  PUSH $00000000             // MB_OK
  PUSH lpCaption4            // 'SEHTerm: After finally block'
  PUSH lpText4               // 'Normal process termination'
  PUSH $00000000
  CALL MessageBox
end.
