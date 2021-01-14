unit  ListUnit;

interface

uses  Windows;

const
  ListHeight = 98;              // ListBox�ؼ��߶�

var
  Enter_List: Boolean = FALSE;  // �����ListBox ��
  FixedCount: Integer=0;        // �����ͣ�ۼƱ���
  FixTimerID: LongWord;         // �����ͣ��ʱ��ID

  OnDraging: Boolean = FALSE;   // ��ǰ������ק״̬
  PriorRect: TRECT;             // �ϴ���ק��Χ
  DragMoved: Boolean;           // ���Ҽ�������ק��


procedure Delete_ListItem;  // ɾ��ListBox�����б�ѡ�еĽ��
procedure FileList2ListBox; // ��FileList����������ݵ�ListBox�ؼ�
procedure ListBox2FileList; // ��ListBox�ؼ�ȡ���ݷŵ�FileList����
procedure Exchange_List(iInsert: Integer);// ��ѡ�н������iInsert
  
function GetCur_ItemRect(X, Y: Integer): TRect;  // ������ק��λ��
function GetCur_ItemIndex(X, Y: Integer): Integer; // ������ڽ��

procedure ListBox_StopDrap; // ListBoxֹͣ�����קʱ����
procedure ReTest_Enter_List;// ���԰�װʱ��(��������Ƿ���ListBox��)

implementation

uses
  Messages, PublicUnit, HintForm;

    // ---- ɾ����ѡ����Ŀ ---- //
procedure Delete_ListItem;
var
  I: Integer;
begin
  I := SendMessage(hListBox, LB_GETCOUNT, 0, 0)-1;
  while (I >= 0) do
  begin
    if SendMessage(hListBox, LB_GETSEL, I, 0)>0 then
    begin
      SendMessage(hListBox, LB_DELETESTRING, I, 0);
    end;
    Dec(I);
  end;
end;

    // -- FileList���鵽ListBox�ؼ� -- //
procedure FileList2ListBox;
var
  j: Integer;
begin
  for j:=0 to High(FileList) do
    SendMessage(hListBox, LB_ADDSTRING, 0, Integer(PChar(FileList[j])));
end;

    // -- ListBox�ؼ���FileList���� -- //
procedure ListBox2FileList;
var
  I: Integer;
  Tmp: string;
begin
  SetLength(FileList, 0);   I := 0;
 // ���һ���ļ��Ƿ���Ȼ����
  while (I < SendMessage(hListBox, LB_GETCOUNT, 0, 0)) do
  begin
    SetLength(Tmp, SendMessage(hListBox, LB_GETTEXTLEN, I, 0)+1);
    SendMessage(hListBox, LB_GETTEXT, I, LongWord(@Tmp[1]));
    Tmp := string( PChar(Tmp) );

    if FileExists(Tmp) then
    begin
      SetLength(FileList, Length(FileList)+1);
      FileList[High(FileList)] := Tmp; Inc(I);
    end else
      SendMessage(hListBox, LB_DELETESTRING, I, 0);
  end;
 // ֻ��ͷ��,���Զ���Ӻ�����
  if (Length(FileList)=1)and(ExtractExteName(FileList[0])='.001') then
  begin
    Tmp := Copy(FileList[0], 1, Length(FileList[0])-3);
    I := 2;
    while FileExists( Tmp + Int2Hex(I) ) do
    begin
      SetLength(FileList, I);
      FileList[I-1] := Tmp + Int2Hex(I);
      SendMessage(hListBox, LB_ADDSTRING, 0, Integer(PChar(FileList[I-1])));
      Inc(I);
    end;
  end;
end;

   // ---- ��ѡ�н���Ƶ�iInsert�� ---- //
procedure Exchange_List(iInsert: Integer);
var
  I: Integer;
  S: string;
begin
 // ɾ����ѡ�еĽ��
  SetLength(FileList, 0);   I := 0; 
  while (I < SendMessage(hListBox, LB_GETCOUNT, 0, 0)) do
  begin
    if (SendMessage(hListBox, LB_GETSEL, I, 0) > 0) then
    begin
      if (I < iInsert) then  Dec(iInsert);
      SetLength(S, SendMessage(hListBox, LB_GETTEXTLEN, I, 0)+1);
      SendMessage(hListBox, LB_GETTEXT, I, LongWord(@S[1]));
      S := string( PChar(S) );
      SetLength(FileList, Length(FileList)+1);
      FileList[High(FileList)] := S;
      SendMessage(hListBox, LB_DELETESTRING, I, 0);
    end else
      Inc(I);
  end;
 // ����ǰ��ɾ���Ľ��
  for I := High(FileList) downto 0 do
  begin            
    SendMessage(hListBox, LB_INSERTSTRING, iInsert, Integer(PChar(FileList[I])));
    SendMessage(hListBox, LB_SETSEL, 1, iInsert);
  end;  
end;

    // ---- ������ק���߿�Χ ---- //
function GetCur_ItemRect(X, Y: Integer): TRect;
var
  ItemIndex: Integer;
begin
  ItemIndex := SendMessage(hListBox, LB_ITEMFROMPOINT, 0, MAKELPARAM(X,Y));
  if HIWORD(ItemIndex) = 0 then
  begin
    SendMessage(hListBox, LB_GETITEMRECT, ItemIndex, LongWord(@Result));
    if (Y <= 7) then     // ������ ..
    begin
      Result.Top := 0;
      Result.Bottom := 2;
      InvalidateRect(hListBox, @PriorRect, True);
      SendMessage(hListBox, WM_VSCROLL, SB_PAGEUP, 0);
    end else
      if (Y >= ListHeight-7) then // ������ ..
      begin
        Result.Top := ListHeight-4;
        Result.Bottom := ListHeight-2;
        InvalidateRect(hListBox, @PriorRect, True);
        SendMessage(hListBox, WM_VSCROLL, SB_PAGEDOWN, 0);
      end else           // ���� ..
        Result.Bottom := Result.Top + 2;
  end else
  begin  // û�н�� ..
    ItemIndex := SendMessage(hListBox, LB_GETCOUNT, 0, 0);
    SendMessage(hListBox, LB_GETITEMRECT, ItemIndex-1, LongWord(@Result));
    Result.Top := Result.Bottom - 1;
    Result.Bottom := Result.Bottom+1;
  end;
end;

    // ---- ��ǰ���ָ��Ľ�� ---- //
function GetCur_ItemIndex(X, Y: Integer): Integer;
begin
  Result := SendMessage(hListBox, LB_ITEMFROMPOINT, 0, MAKELPARAM(X,Y));
  if HIWORD(Result) = 0 then
  begin
    if (Y >= ListHeight-7) then Result := Result+1;
  end else
  begin
    Result := SendMessage(hListBox, LB_GETCOUNT, 0, 0);
  end;
end;

    // ---- �����קֹͣ ---- //
procedure ListBox_StopDrap;
begin
  SetCursor(hArrowCursor);
  OnDraging := FALSE;
  InvalidateRect(hListBox, @PriorRect, True);
  PriorRect.Left := 0;
  PriorRect.Top := 0;
  PriorRect.Bottom := 0;
  PriorRect.Right := 0;
  SendMessage(hListBox, WM_PAINT, 0, 0);
end;        

    // ---- �����ͣ��ʱ�� ---- //
procedure FixTimerProc(hwnd, uMsg, idEvent, dwTime: LongWord); stdcall;
var
  ItemPoint: TPoint;
  ItemIndex: Integer;
  ItemWidth: Word;
  ItemRect: TRECT;
  ItemText: string;
  hwCursor: LongWord;
begin
  GetCursorPos(ItemPoint);
  hwCursor := WindowFromPoint(ItemPoint);
  if (hwCursor = hListBox) then
  begin
    FixedCount := FixedCount + 1;
    if (FixedCount < 10) then Exit;  // �ۼ�ʱ��δ��2�� ..

    ScreenToClient(hListBox, ItemPoint);
    ItemIndex := SendMessage(hListBox, LB_ITEMFROMPOINT, 0, MAKELPARAM(ItemPoint.X, ItemPoint.Y));
    if HIWORD(ItemIndex)<>0 then Exit; // �����û�� Item ..

    SetLength(ItemText, SendMessage(hListBox, LB_GETTEXTLEN, ItemIndex, 0)+1);
    SendMessage(hListBox, LB_GETTEXT, ItemIndex, LongWord(@ItemText[1]));
    ItemText := string(PChar(ItemText)); // ��ǰ�������

    SendMessage(hListBox, LB_GETITEMRECT, ItemIndex, LongWord(@ItemRect));
    ItemWidth := LOWORD(GetTextExtent(ItemText)); // ���ֿ��

    if (ItemWidth > ItemRect.Right) then  // ��������ʾHint ..
    begin
      ItemPoint.X := ItemRect.Left;
      ItemPoint.Y := ItemRect.Top;
      ClientToScreen(hListBox, ItemPoint);
      Active_HintForm(ItemPoint.X-2, ItemPoint.Y-1, ItemText);
    end
  end else    // ��겻��ListBox��
  begin
    KillTimer(0, FixTimerID);
    FixedCount := 0;
    Enter_List := FALSE;
    if (hwCursor <> hHintForm) then ListBox_StopDrap;
  end;
end;

    // ---- ����װ����ʱ�� ---- //
procedure ReTest_Enter_List;
begin
  FixedCount := 0;
  if (Enter_List = FALSE) then // ֮ǰδ���� ListBox
  begin
    Enter_List := TRUE;
    FixTimerID := SetTimer(0, 0, 200, @FixTimerProc);
  end;
end;

end.
