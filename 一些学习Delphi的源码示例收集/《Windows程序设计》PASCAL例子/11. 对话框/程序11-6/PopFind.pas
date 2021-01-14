unit PopFind;

interface

uses
  CommDlg;

  // Ѱ���ı��Ի���
function PopFindFindDlg(hWnd: LongWord): LongWord;
  // �滻�ı��Ի���
function PopFindReplaceDlg(hWnd: LongWord): LongWord;
  // Ѱ��ƥ���ı�
function PopFindFindText(hWndEdit: LongWord; piSearchOffset: PInteger; pfr: PFindReplace): Boolean;
  // Ѱ����һ��
function PopFindNextText(hWndEdit: LongWord; piSearchOffset: PInteger): Boolean;
  // �滻ƥ���ı�
function PopFindReplaceText(hWndEdit: LongWord; piSearchOffset: PInteger; pfr: PFindReplace): Boolean;
  // ���в��ҹؼ���
function PopFindValidFind(): Boolean;

implementation

uses
  Windows, Messages;
  
const
  MAX_STRING_LEN = 256;

var
  szFindText: array[0..MAX_STRING_LEN] of Char;
  szReplText: array[0..MAX_STRING_LEN] of Char;

  // Ѱ���ı��Ի���
function PopFindFindDlg(hWnd: LongWord): LongWord;
const
{$J+}
 fr: TFindReplace =
  ( lStructSize: SizeOf(TFindReplace);
    hwndOwner: 0;
    hInstance: 0;
    Flags: FR_HIDEUPDOWN or FR_HIDEMATCHCASE or FR_HIDEWHOLEWORD;
    lpstrFindWhat: szFindText;
    lpstrReplaceWith: nil;
    wFindWhatLen: MAX_STRING_LEN;
    wReplaceWithLen: 0;
    lCustData: 0;
    lpfnHook: nil;
    lpTemplateName: nil );
{$J-}      
begin
  fr.hwndOwner := hWnd;
  fr.Flags := FR_HIDEUPDOWN or FR_HIDEMATCHCASE or FR_HIDEWHOLEWORD;
  Result := FindText(fr);
end;

  // �滻�ı��Ի���
function PopFindReplaceDlg(hWnd: LongWord): LongWord;
const
{$J+}
  fr: TFindReplace =
   ( lStructSize: SizeOf(TFindReplace);
     hwndOwner: 0;
     hInstance: 0;
     Flags: FR_HIDEUPDOWN or FR_HIDEMATCHCASE or FR_HIDEWHOLEWORD;
     lpstrFindWhat: szFindText;
     lpstrReplaceWith: szReplText;
     wFindWhatLen: MAX_STRING_LEN;
     wReplaceWithLen: MAX_STRING_LEN;
     lCustData: 0;
     lpfnHook: nil;
     lpTemplateName: nil );
{$J-}
begin
  fr.hwndOwner := hWnd;
  fr.Flags := FR_HIDEUPDOWN or FR_HIDEMATCHCASE or FR_HIDEWHOLEWORD;
  Result := ReplaceText(fr);
end;

  // Ѱ��ƥ���ı�
function PopFindFindText(hWndEdit: LongWord; piSearchOffset: PInteger; pfr: PFindReplace): Boolean;
var
  iLength, iPos, j: Integer;
  pstrDoc, pstrPos: PChar;
begin
  Result := FALSE;
 // ȡ��Edit�ؼ�����
  iLength := GetWindowTextLength(hWndEdit);
  GetMem(pstrDoc, iLength + 1);
  if (pstrDoc = nil) then Exit;
  GetWindowText(hWndEdit, pstrDoc, iLength + 1);
 // ��piSearchOffset֮��Ѱ��
  pstrPos := pstrDoc + piSearchOffset^;
  while (pstrPos^ <> #0) do
  begin
    j := 0;
    while (pstrPos[j] <> #0)and
          (pfr.lpstrFindWhat[j] <> #0)and
          (pfr.lpstrFindWhat[j] = pstrPos[j])
      do Inc(j);
    if (pstrPos[j] = #0)or(pfr.lpstrFindWhat[j] = #0) then
      Break
    else
      Inc(pstrPos, J+1);
  end;
  if (pfr.lpstrFindWhat[j] = #0) then // �ҵ�
  begin
   // ���ش�ƥ��λ��
    iPos := pstrPos - pstrDoc;
    piSearchOffset^ := iPos + j;
    Result := TRUE;
   // ѡ���ҵ����ı�
    SendMessage(hWndEdit, EM_SETSEL, iPos, piSearchOffset^);
    SendMessage(hWndEdit, EM_SCROLLCARET, 0, 0);
  end;
  FreeMem(pstrDoc);
end;

  // Ѱ����һ��
function PopFindNextText(hWndEdit: LongWord; piSearchOffset: PInteger): Boolean;
var
  fr: TFindReplace;
begin
  fr.lpstrFindWhat := szFindText;
  Result := PopFindFindText(hWndEdit, piSearchOffset, @fr);
end;

  // �滻ƥ���ı�
function PopFindReplaceText(hWndEdit: LongWord; piSearchOffset: PInteger; pfr: PFindReplace): Boolean;
begin
  if (not PopFindFindText(hWndEdit, piSearchOffset, pfr)) then
    Result := FALSE
  else begin
    SendMessage(hWndEdit, EM_REPLACESEL, 0, Integer(pfr.lpstrReplaceWith));
    Result := TRUE;
  end;
end;

  // ���в��ҹؼ���
function PopFindValidFind(): Boolean;
begin
  Result := (szFindText[0] <> #0);
end;

end.
