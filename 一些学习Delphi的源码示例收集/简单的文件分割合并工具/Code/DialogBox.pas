unit  DialogBox;

interface

    // ---- ѡ���ļ��Ի��� ---- //
function OpenFile_Dialog(OpenFileName, OpenFilter, OpenDefExt: string; MultiSelect: Boolean): Boolean;
    // ---- �����ļ��Ի��� ---- //
function SaveFile_Dialog(SaveFileName, SaveFilter, SaveDefExt: string; OverPrompt: Boolean): Boolean;

implementation

uses
  Windows, CommDlg, PublicUnit; 
  
    // FilesBuf ת�� FileList ..
procedure FilesBuf2FileList(MultiSelect: Boolean);
var
  TmpPChar: PChar;
  FilePath: string;
begin
  TmpPChar := @FilesBuf[0];
  if (not MultiSelect) or (TmpPChar[StrLen(TmpPChar)+1] = #0) then
  begin
    SetLength(FileList, 1);
    FileList[0] := StrPas(TmpPChar);
  end else
  begin
    SetLength(FileList, 0);   FilePath := StrPas(TmpPChar);
    TmpPChar := TmpPChar + StrLen(TmpPChar) + 1 ;
    if (FilePath[Length(FilePath)]<>'\') then FilePath := FilePath+'\';
    while (TmpPChar[0] <> #0) do
    begin
      SetLength(FileList, Length(FileList)+1);
      FileList[High(FileList)] := FilePath + StrPas(TmpPChar);
      TmpPChar := TmpPChar + StrLen(TmpPChar) + 1 ;
    end;
  end;
end;    

   // '���ļ�'�Ի���   Ĭ���ļ���..  ��������..  Ĭ����չ��..        �����ѡ..             �ɹ���..
function OpenFile_Dialog(OpenFileName, OpenFilter, OpenDefExt: string; MultiSelect: Boolean): Boolean;
var
  ofnStruct: TOpenFilename;
begin
  StrCopy(@FilesBuf[0], PChar(OpenFileName));            // ��Ĭ���ļ���..
  with ofnStruct do
  begin
    lStructSize := SizeOf(TOpenFilename)-SizeOf(DWORD)*3; // ����9x, ��12..
    hwndOwner := hMainForm;                               // �������ھ��..
    hInstance := 0;
    lpstrFilter := PChar(OpenFilter);                     // �������ַ���..
    lpstrCustomFilter:= nil;
    nMaxCustFilter := 0;
    nFilterIndex := 1;                                    // Ĭ�Ϲ�����..
    lpstrFile := @FilesBuf[0];                            // ����ѡ�ļ��б�..
    nMaxFile := MAX_LENGTH;                               // lpstrFile����..
    lpstrFileTitle := nil;
    nMaxFileTitle := 0;
    lpstrInitialDir := nil;
    lpstrTitle := nil;
    Flags := OFN_EXPLORER or OFN_HIDEREADONLY or OFN_NODEREFERENCELINKS or
             OFN_FILEMUSTEXIST or OFN_PATHMUSTEXIST;
    if MultiSelect then Flags := Flags or OFN_ALLOWMULTISELECT;
    nFileOffset := 0;
    nFileExtension := 0;
    lpstrDefExt := PChar(OpenDefExt);                     // Ĭ����չ��..
    lCustData := 0;
    lpfnHook := nil;
    lpTemplateName := nil;
    pvReserved:=nil;                                      // 3��������Ա..
    dwReserved:=0;
    FlagsEx:=0;
  end;       // ............ end with .............   ^^
  Result := GetOpenFileName(ofnStruct);
  if Result then FilesBuf2FileList(MultiSelect);
end;       

   // '�����ļ�'�Ի���   Ĭ���ļ���..  ��������..  Ĭ����չ��..        ������ʾ..            �ɹ���..
function SaveFile_Dialog(SaveFileName, SaveFilter, SaveDefExt: string; OverPrompt: Boolean): Boolean;
var
  ofnStruct: TOpenFilename;
begin
  StrCopy(@FilesBuf[0], PChar(SaveFileName));            // ��Ĭ���ļ���..
  with ofnStruct do
  begin
    lStructSize := SizeOf(TOpenFilename)-SizeOf(DWORD)*3; // ����9x, ��12..
    hwndOwner := hMainForm;                               // �������ھ��..
    hInstance := 0;
    lpstrFilter := PChar(SaveFilter);                     // �������ַ���..
    lpstrCustomFilter:= nil;
    nMaxCustFilter := 0;
    nFilterIndex := 1;                                    // Ĭ�Ϲ�����..
    lpstrFile := @FilesBuf[0];                            // �������ļ��� ..
    nMaxFile := MAX_LENGTH;                               // lpstrFile����..
    lpstrFileTitle := nil;
    nMaxFileTitle := 0;
    lpstrInitialDir := nil;
    lpstrTitle := nil;
    Flags := OFN_EXPLORER or OFN_PATHMUSTEXIST or OFN_HIDEREADONLY or OFN_NODEREFERENCELINKS;
    if OverPrompt then Flags := Flags or OFN_OVERWRITEPROMPT;
    nFileOffset := 0;
    nFileExtension := 0;
    lpstrDefExt := PChar(SaveDefExt);                     // Ĭ����չ��..
    lCustData := 0;
    lpfnHook := nil;
    lpTemplateName := nil;
    pvReserved:=nil;                                      // 3��������Ա..
    dwReserved:=0;
    FlagsEx:=0;
  end;       // ............ end with .............   ^^
  Result := GetSaveFileName(ofnStruct);
  if Result then FilesBuf2FileList(FALSE);
end;

end.  
