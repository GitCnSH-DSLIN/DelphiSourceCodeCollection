unit  ListMouse;

interface

   // ---- ����ListBox��궯�� ---- //
procedure Dispose_List_MouseMsg(MsgID, LParam: LongWord);

implementation

uses
  Windows, Messages, ListUnit, PublicUnit;

   // ---- ������ƶ�ʱ���� ---- //
procedure On_List_MouseMove(lParam: LongWord);
var
  CurRect: TRect;
begin
  if not OnDraging then Exit; // ����ק״̬ ..
  DragMoved := TRUE;           // ��'��ק'�� ..
  CurRect := GetCur_ItemRect( LOWORD(lParam), HIWORD(lParam) );
  if (CurRect.Top <> PriorRect.Top) then
  begin
    InvalidateRect(hListBox, @PriorRect, True);
    PriorRect := CurRect;
    PriorRect.Bottom := PriorRect.Top + 2;
    SendMessage(hListBox, WM_PAINT, 0, 0);
  end;
end;

   // ---- ���Ҽ�����ʱ���� ---- //
procedure On_List_rButtonDown(lParam: LongWord);
var
  CurIndex: Integer;
begin
  CurIndex := SendMessage(hListBox, LB_ITEMFROMPOINT, 0, lParam);
    // ���´��н�� ���� ����ѡ��״̬ ..
  if (HIWORD(CurIndex) = 0)and(SendMessage(hListBox, LB_GETSEL, CurIndex, 0) > 0) then
  begin
    OnDraging := TRUE;  // ������ק״̬
    DragMoved := FALSE;  // δ�Ϲ�(���)
  end;
end;

   // ---- ���Ҽ�̧��ʱ���� ---- //
procedure On_List_rButtonUp(lParam: LongWord);
begin
  if OnDraging then    // ��ListBox���µ��Ҽ� ..
  begin
    ListBox_StopDrap;   // ��קֹͣ ..
    if DragMoved then   // ����ק�� ..
      Exchange_List( GetCur_ItemIndex(LOWORD(lParam), HIWORD(lParam)) );
  end;
end;

   // ---- ����ListBox��궯�� ---- //
procedure Dispose_List_MouseMsg(MsgID, LParam: LongWord);
begin
  ReTest_Enter_List;  // ���԰�װ����ʱ�� ..
  case MsgId of
    WM_MOUSEMOVE   :  On_List_MouseMove(LParam);
    WM_RBUTTONDOWN :  On_List_rButtonDown(LParam);
    WM_RBUTTONUP   :  On_List_rButtonUp(LParam);
  end;
  if OnDraging then SetCursor(hDrapCursor);   
end;

end.
