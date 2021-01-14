unit  CutFile;

interface

    // ---- �ָ��ļ� ---- //
procedure Cut_File;
    // ---- ֹͣ�ָ� ---- //
procedure Stop_Cut;

implementation

uses
  Windows, Messages, PublicUnit;

var
  sSourceFile, sDestFile: string;   // Դ�ļ���Ŀ���ļ� �ļ���
  iSourceSize, iDestSize: Int64;    // Դ�ļ���Ŀ���ļ� �ߴ�
  hCutThread: LongWord = 0;         // ��ǰ���зָ��߳�֮���
  

    // -- �ָ��̻߳ص����� -- //
procedure CutThread(x: Integer); stdcall;
var
  hSourceFile,          // ��Դ�ļ����
  hDestFile: LongWord;  // Ŀ���ļ����
  iCutSize: Int64;      // ��ǰ�ָ�ߴ�
  iCurStep: Integer;    // ��ǰ��(����ֵ)
  sCurStep: string;     // ��ǰ��(�ַ���)
  sFormText: string;    // ��ǰ���������
  MsgResult: LongWord;  // ��Ϣ������ֵ
begin
  CurState := 1;

  hSourceFile := CreateFile(PChar(sSourceFile), GENERIC_READ, 3, nil,
                         OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if (hSourceFile = INVALID_HANDLE_VALUE) then
  begin
    MessageBox(hMainForm, '��ȡԴ�ļ�����!!', '��ʾ', MB_SETFOREGROUND);
    CurState := 0;    Exit;
  end;

  Delete(sDestFile, Length(sDestFile)-2, 3);
  iCurStep := 1;

  while (Continue_Run)and(iSourceSize>0) do
  begin
    sCurStep := Int2Hex(iCurStep);
    sFormText := '  �ָ��� . . . .    �������ɵ� '+sCurStep+' ��';
    SendMessageTimeout(hMainForm, WM_SETTEXT, 0, Integer(PChar(sFormText)),
                       SMTO_ABORTIFHUNG or SMTO_NORMAL, 1, MsgResult);

    if iSourceSize > iDestSize then iCutSize := iDestSize else iCutSize := iSourceSize;

    hDestFile := CreateFile(PChar(sDestFile+sCurStep), GENERIC_WRITE, 3,
                           nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
    if (hDestFile = INVALID_HANDLE_VALUE) then
    begin
      MessageBox(hMainForm, PChar('���ɵ� '+sCurStep+' �����!!'), '��ʾ', MB_SETFOREGROUND);
      Break;
    end;

    CopyFileBlock(hSourceFile, hDestFile, iCutSize);
    CloseHandle(hDestFile);

    Dec(iSourceSize, iCutSize);
    Inc(iCurStep);
  end;

     // �������˳�      // ȡ�������˳�
  if (iSourceSize > 0) or (Continue_Run = FALSE) then
    for iCurStep := iCurStep downto 0 do DeleteFile(PChar(sDestFile+Int2Hex(iCurStep)));   

  CloseHandle(hSourceFile);
  SendMessageTimeout(hMainForm, WM_SETTEXT, 0, Integer(PChar(FormTitle)),
                  SMTO_ABORTIFHUNG or SMTO_NORMAL, 1, MsgResult);
  CurState := 0;                    
end;

    // ---- �ָ��ļ� ---- //
procedure Cut_File;
var
  fExt, fMain, fPath, fTmp: string;
  fNameError: Boolean;
  CutThreadID: LongWord;
begin
// �����ļ�
  sSourceFile := GetCaption(hEdit1);
  SetCaption(hEdit1, sSourceFile);
  if not FileExists(sSourceFile) then
  begin
    MessageBox(hMainForm, '��ȷ�������ļ�..  ', '��ʾ', MB_SETFOREGROUND);  Exit;
  end;

// Ŀ���ļ�
  sDestFile := GetCaption(hEdit2);
  fPath := ExtractFilePath(sDestFile);
  fTmp := ExtractFileName(sDestFile);
  fMain:= ExtractMainName(fTmp);
  fExt := ExtractExteName(fTmp);    
  fNameError := FALSE;
  if (not DirectoryExists(fPath)) then
  begin
    fNameError := TRUE;
    fPath := ExtractFilePath(sSourceFile);
  end;
  if (Trim(fMain)='') then
  begin
    fNameError := TRUE;
    fMain :=  ExtractFileName(sSourceFile);
  end;
  if (fExt<>'.001') then
  begin
    fNameError := TRUE;
    fExt := '.001';
  end;     
  if fNameError then
  begin
    sDestFile :=  fPath + fMain + fExt ;
    SetCaption(hEdit2, sDestFile);
    MessageBox(hMainForm, '��ȷ�����λ��..  ', '��ʾ', MB_SETFOREGROUND);
    Exit;
  end;

// �ļ��ߴ�
  iSourceSize := GetFileLength(0, sSourceFile);
  if (iSourceSize = 0) then
  begin
    MessageBox(hMainForm, 'ȡԴ�ļ����ȳ���..  ', '��ʾ', MB_SETFOREGROUND); Exit;
  end;

// �ָ�ߴ�  
  fTmp := GetCaption(hComboBox);
  iDestSize := StrToInt64(fTmp);

  if SendMessage(hRadioBtn2, BM_GETCHECK, 0, 0)=BST_CHECKED then iDestSize := iDestSize shl 10
  else if SendMessage(hRadioBtn3, BM_GETCHECK, 0, 0)=BST_CHECKED then iDestSize := iDestSize shl 20;

  if (iDestSize = 0)or(iSourceSize <= iDestSize) then
  begin
    MessageBox(hMainForm, '��ȷ���ָ�ߴ�..  ', '��ʾ', MB_SETFOREGROUND); Exit;
  end;

// ȷ�Ϸָ�
  if ( MessageBox(hMainForm, '���漴�����зָ�,��ȷ����?', '��ʾ',
    MB_YESNO or MB_DEFBUTTON2 or MB_SETFOREGROUND) = ID_YES ) then
  begin
    if (hCutThread <> 0) then Stop_Cut;  // �ر��ϴ��߳̾��
    Continue_Run := TRUE;  
    hCutThread := CreateThread(nil, 0, @CutThread, nil, 0, CutThreadID);
  end;
end;

    // ---- ֹͣ�ָ� ---- //
procedure Stop_Cut;
begin
  if (hCutThread <> 0) then
  begin
    SetCaption(hMainForm, '    ���ڳ����ָ� . . . . ');
    Continue_Run := FALSE;
    WaitForSingleObject(hCutThread, INFINITE);
    CloseHandle(hCutThread);
    hCutThread := 0;
    SetCaption(hMainForm, FormTitle);
  end;
end;

{ ע��ָ��̲߳�����SendMessage���ô������,����,���ܻ�������������:
  �����̵߳���WaitForSingleObject��������,�ȴ��ָ��߳̽���,���ָ��̵߳���
  SendMessage������������,�ȴ������̴߳�����Ϣ. ����,�ͻ�һֱ����ȴ�.. }
end.
