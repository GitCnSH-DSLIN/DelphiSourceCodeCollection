unit  JoinFile;

interface

procedure Join_File;
procedure Stop_Join;

implementation

uses
  Windows, Messages, ListUnit, PublicUnit;

var
  sTargetFile: string;       // �ϲ�֮����λ��
  hJoinThread: LongWord = 0; // ��ǰ�ϲ��߳̾��
  

    // -- �ϲ��̻߳ص����� -- //
procedure JoinThread(x: Integer); stdcall;
var
  iCurStep,              // ��ǰ��ӿ��
  iSumStep: Integer;     // ����ӿ�����
  hTargetFile,           // Ŀ���ļ����
  hSourceFile: LongWord; // ��Դ�ļ����
  iSourceSize: Int64;    // ��Դ�ļ�����
  sFormText: string;     // ��ǰ���������
  MsgResult: LongWord;   // ��Ϣ������ֵ
begin
  CurState := 2;

  hTargetFile := CreateFile(PChar(sTargetFile), GENERIC_WRITE, 3, nil,
                          CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  if (hTargetFile = INVALID_HANDLE_VALUE) then
  begin
    MessageBox(hMainForm, '����Ŀ���ļ�����!!', '��ʾ', MB_SETFOREGROUND);
    CurState := 0;    Exit;
  end;

  iSumStep := High(FileList);
  iCurStep := 0;
  while (Continue_Run)and(iCurStep <= iSumStep) do
  begin
    sFormText := '  �ϲ��� . . . .    ������ӵ� '+Int2Hex(iCurStep+1)+' ��';
    SendMessageTimeout(hMainForm, WM_SETTEXT, 0, Integer(PChar(sFormText)),
                      SMTO_ABORTIFHUNG or SMTO_NORMAL, 1, MsgResult);

    hSourceFile := CreateFile(PChar(FileList[iCurStep]), GENERIC_READ, 3, nil,
                             OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
    if (hSourceFile = INVALID_HANDLE_VALUE) then
    begin
      MessageBox(hMainForm, PChar('��ӵ� '+Int2Hex(iCurStep+1)+' �����!!'), '��ʾ', MB_SETFOREGROUND);
      Break;
    end;

    iSourceSize := GetFileLength(hSourceFile);
    CopyFileBlock(hSourceFile, hTargetFile, iSourceSize);
    CloseHandle(hSourceFile);

    Inc(iCurStep);
  end;
  CloseHandle(hTargetFile);
  
     // �������˳�           // ȡ�������˳�
  if (iCurStep <= iSumStep) or (Continue_Run = FALSE) then DeleteFile( PChar(sTargetFile) );
  SendMessageTimeout(hMainForm, WM_SETTEXT, 0, Integer(PChar(FormTitle)),
                   SMTO_ABORTIFHUNG or SMTO_NORMAL, 1, MsgResult);
  CurState := 0;                   
end;

procedure Join_File;
var
  JoinThreadID: LongWord;
begin
// ���λ��
  sTargetFile := GetCaption(hEdit3);
  SetCaption(hEdit3, sTargetFile);

// �Ƿ�·��
  if (sTargetFile = '')or(DirectoryExists(ExtractFilePath(sTargetFile)) = FALSE)or
     (Trim(ExtractMainName(ExtractFileName(sTargetFile))) = '') then
  begin
    MessageBox(hMainForm, '��ȷ�����λ��..  ', '��ʾ', MB_SETFOREGROUND); Exit;
  end;
  
// ����ȷ��
  if FileExists(sTargetFile)and(MessageBox(hMainForm, '�ļ��Ѵ���,ȷ������?  ',
     '��ʾ', MB_YESNO or MB_DEFBUTTON2 or MB_SETFOREGROUND) = ID_NO) then Exit;

// �����б�
  ListBox2FileList;
  if (Length(FileList) = 0) then
  begin
    MessageBox(hMainForm, '��ȷ���ϲ��б�..  ', '��ʾ', MB_SETFOREGROUND); Exit;
  end;

// ȷ�Ϻϲ�
  if ( MessageBox(hMainForm, '���漴�����кϲ�,��ȷ����?', '��ʾ',
    MB_YESNO or MB_DEFBUTTON2 or MB_SETFOREGROUND) = ID_YES ) then
  begin
    if (hJoinThread <> 0) then Stop_Join;  // �ر��ϴ��߳̾��
    Continue_Run := TRUE;
    hJoinThread := CreateThread(nil, 0, @JoinThread, nil, 0, JoinThreadID);
  end;
end;

procedure Stop_Join;
begin
  if (hJoinThread <> 0) then
  begin
    SetCaption(hMainForm, '    ���ڳ����ϲ� . . . . ');
    Continue_Run := FALSE;
    WaitForSingleObject(hJoinThread, INFINITE);
    CloseHandle(hJoinThread);
    hJoinThread := 0;
    SetCaption(hMainForm, FormTitle);
  end;
end;

 { ע: ͬ��,�ϲ��߳�ҲӦ����SendMessageTimeout���������������. }
end.
