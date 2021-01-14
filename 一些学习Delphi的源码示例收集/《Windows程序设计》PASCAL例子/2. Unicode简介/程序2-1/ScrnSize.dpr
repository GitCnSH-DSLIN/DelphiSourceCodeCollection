program  ScrnSize;

uses
  Windows;

  // ��ʽ���������        {����}   {�����ʽ}     {��������б�}
procedure MessageBoxPrintf(Caption, Format: PChar; const Args: array of const);
var
  OutBuff: array[0..100] of Char; // �����������
  OutList: array of LongWord;     // ��������б�
  J: Integer;
begin
  SetLength(OutList, 0);
  for J := Low(Args) to High(Args) do // Args -> OutList
  begin
    case Args[J].VType of  // �������������������
      vtInteger: begin
                   SetLength(OutList, Length(OutList)+1);
                   OutList[High(OutList)] := Args[J].VInteger;
                 end;
                 
      vtString : begin
                   SetLength(OutList, Length(OutList)+1);
                   OutList[High(OutList)] := LongWord(Args[J].VString);
                 end;
    end;
  end;
  if Length(OutList) = Length(Args) then // �б��Ա���Ϸ�
  begin
    wvsprintf(OutBuff, Format, @OutList[0]);  // ת��
    MessageBox(0, OutBuff, Caption, 0);       // ���
  end;
end;

var
  cxScreen, cyScreen: Integer;

begin
  cxScreen := GetSystemMetrics(SM_CXSCREEN); // ��Ļ���
  cyScreen := GetSystemMetrics(SM_CYSCREEN); // ��Ļ�߶�
  MessageBoxPrintf('ScrnSize',               
                   'The screen is %i pixels wide by %i pixels high.',
                   [cxScreen, cyScreen]);
end.
