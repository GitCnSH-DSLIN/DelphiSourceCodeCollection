unit PopPrnt;

interface

   // ��ӡ�ļ�
function PopPrntPrintFile(hInst, hWnd, hWndEdit: LongWord; const pstrTitleName: PChar): Boolean;

implementation

   // ��ӡ�ļ�
function PopPrntPrintFile(hInst, hWnd, hWndEdit: LongWord; const pstrTitleName: PChar): Boolean;
begin
  Result := FALSE;
end; 

end.
