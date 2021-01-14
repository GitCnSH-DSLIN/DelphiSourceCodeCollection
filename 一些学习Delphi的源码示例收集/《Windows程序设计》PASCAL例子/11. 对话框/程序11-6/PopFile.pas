unit PopFile;

interface

   // ��ʼ��'�ļ�ѡ��Ի���'�ṹ��
procedure PopFileInitialize(hWnd: LongWord);
   // '���ļ�'�Ի���
function PopFileOpenDlg(hWnd: LongWord; const pstrFileName, pstrTitleName: PChar): Boolean;
   // '�����ļ�'�Ի���
function PopFileSaveDlg(hWnd: LongWord; const pstrFileName, pstrTitleName: PChar): Boolean;
   // �ļ�װ��Edit�ؼ�
function PopFileRead(hWndEdit: LongWord; const pstrFileName: PChar): Boolean;
   // Edit���ݱ������ļ�
function PopFileWrite(hWndEdit: LongWord; const pstrFileName: PChar): Boolean;

implementation

uses
  Windows, CommDlg;

var
  ofn: TOpenFilename;

   // ��ʼ��'�ļ�ѡ��Ի���'�ṹ��
procedure PopFileInitialize(hWnd: LongWord);
const
  szFilter = 'Text Files (*.TXT)'#0'*.txt'#0'ASCII Files (*.ASC)'#0'*.asc'#0'All Files (*.*)'#0'*.*'#0#0;
begin
  ofn.lStructSize := SizeOf(TOpenFilename);
  ofn.hwndOwner := hWnd;
  ofn.hInstance := 0;
  ofn.lpstrFilter := szFilter;
  ofn.lpstrCustomFilter := nil;
  ofn.nMaxCustFilter := 0;
  ofn.nFilterIndex := 0;
  ofn.lpstrFile := nil;
  ofn.nMaxFile := MAX_PATH;
  ofn.lpstrFileTitle := nil;
  ofn.nMaxFileTitle := MAX_PATH;
  ofn.lpstrInitialDir := nil;
  ofn.lpstrTitle := nil;
  ofn.Flags := 0;
  ofn.nFileOffset := 0;
  ofn.nFileExtension := 0;
  ofn.lpstrDefExt := 'txt';
  ofn.lCustData := 0;
  ofn.lpfnHook := nil;
  ofn.lpTemplateName := nil;
end;

   // '���ļ�'�Ի���
function PopFileOpenDlg(hWnd: LongWord; const pstrFileName, pstrTitleName: PChar): Boolean;
begin
  ofn.hWndOwner := hWnd;
  ofn.lpstrFile := pstrFileName;
  ofn.lpstrFileTitle := pstrTitleName;
  ofn.Flags := OFN_HIDEREADONLY or OFN_CREATEPROMPT;
  Result := GetOpenFileName(ofn);
end;

   // '�����ļ�'�Ի���
function PopFileSaveDlg(hWnd: LongWord; const pstrFileName, pstrTitleName: PChar): Boolean;
begin
  ofn.hWndOwner := hWnd;
  ofn.lpstrFile := pstrFileName;
  ofn.lpstrFileTitle := pstrTitleName;
  ofn.Flags := OFN_OVERWRITEPROMPT;
  Result := GetSaveFileName(ofn);
end;

   // �ļ�װ��Edit�ؼ�
function PopFileRead(hWndEdit: LongWord; const pstrFileName: PChar): Boolean;
const
  IS_TEXT_UNICODE_SIGNATURE = $08;
  IS_TEXT_UNICODE_REVERSE_SIGNATURE = $80;
var
  bySwap: Char;
  dwBytesRead, hFile: DWORD;
  i, iFileLength, iUniTest: Integer;
  pBuffer, pText, pConv: PChar;
begin
  Result := FALSE;   
 // ���ļ�    
  hFile := CreateFile(pstrFileName, GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0);
  if (hFile = INVALID_HANDLE_VALUE) then Exit;
 // ����ռ�
  iFileLength := GetFileSize(hFile, nil);
  GetMem(pBuffer, iFileLength + 2);
 // �����ļ�
  ReadFile(hFile, pBuffer^, iFileLength, dwBytesRead, nil);
  CloseHandle(hFile);
 // ��ӽ����� 
  pBuffer[iFileLength] := #0;
  pBuffer[iFileLength + 1] := #0;
 // ���Ա���
  iUniTest := IS_TEXT_UNICODE_SIGNATURE or IS_TEXT_UNICODE_REVERSE_SIGNATURE;
  if (IsTextUnicode(pBuffer, iFileLength, @iUniTest)) then // �ļ�������Unicode
  begin
   // ȥ��UNICODE��־ͷ
    pText := pBuffer + 2;
    Dec(iFileLength, 2);
   // �����ߵ��ֽ� 
    if (iUniTest and IS_TEXT_UNICODE_REVERSE_SIGNATURE) <> 0 then
    begin
      for i := 0 to iFileLength div 2 - 1 do
      begin
        bySwap := pText[2 * i];
        pText[2 * i] := pText[2 * i + 1];
        pText[2 * i + 1] := bySwap;
      end;
    end;
   // �����ڴ� .. 
    GetMem(pConv, iFileLength + 2);
{$ifndef UNICODE} // ������Unicode��
    WideCharToMultiByte(CP_ACP, 0, PWideChar(pText), -1, pConv, iFileLength + 2, nil, nil); // ת��
{$else}
    lstrcpy(pConv, pText); // ֱ�ӿ���
{$endif}
  end else // ����,�ļ����ݲ���Unicode
  begin
    pText := pBuffer;
    GetMem(pConv, 2 * iFileLength + 2);
{$ifdef UNICODE} // ������Unicode��
    MultiByteToWideChar(CP_ACP, 0, pText, -1, PWideChar(pConv), iFileLength + 1); // ת��
{$else}
    lstrcpy(pConv, pText); // ֱ�ӿ���
{$endif}
  end;    
  SetWindowText(hWndEdit, pConv);
  FreeMem(pBuffer);
  FreeMem(pConv);
  Result := TRUE;
end;     

   // Edit���ݱ������ļ�
function PopFileWrite(hWndEdit: LongWord; const pstrFileName: PChar): Boolean;
const
  wByteOrderMark: WORD = $FEFF; // ע��,���ڴ��е�˳���� FFFE
var
  dwBytesWritten: DWORD;
  hFile: LongWord;
  iLength: Integer;
  pstrBuffer: PChar;
begin
  Result := FALSE;
 // ���ļ�
  hFile := CreateFile(pstrFileName, GENERIC_WRITE, 0, nil, CREATE_ALWAYS, 0, 0);
  if (hFile = INVALID_HANDLE_VALUE) then Exit;
 // �����ڴ�
  iLength := GetWindowTextLength(hWndEdit);
  GetMem(pstrBuffer, iLength + 1);
  if (pstrBuffer = nil) then
  begin
    CloseHandle(hFile);  Exit;
  end;
 // Unicode ��־
{$ifdef UNICODE}
  WriteFile(hFile, wByteOrderMark, 2, dwBytesWritten, nil);
{$endif}
 // ȡ��Edit�ؼ����ݲ�д���ļ���
  GetWindowText(hWndEdit, pstrBuffer, iLength + 1);
  WriteFile(hFile, pstrBuffer^, iLength, dwBytesWritten, nil);
  CloseHandle(hFile);
  FreeMem(pstrBuffer);
  if (iLength = dwBytesWritten) then Result := TRUE;
end;   

end.
