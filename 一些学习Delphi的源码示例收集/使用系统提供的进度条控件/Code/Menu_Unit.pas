unit Menu_Unit;

interface

procedure Create_Menu;
procedure PopupTheMenu;
procedure MenuCommand(MenuID: integer);

implementation

uses
  Windows, Messages, Public_Unit;
  
var
  hPopupMenu: Longword; // �˵����

   // �����˵�
procedure Create_Menu;
begin
  hPopupMenu := CreatePopupMenu;
  AppendMenu(hPopupMenu, MF_STRING, 1, '��ͣ');
  AppendMenu(hPopupMenu, MF_GRAYED or MF_STRING, 2, '����');
  AppendMenu(hPopupMenu, MF_STRING, 3, '���');
  AppendMenu(hPopupMenu, MF_STRING, 4, '�˳�');
  AppendMenu(hPopupMenu, MF_GRAYED or MF_SEPARATOR, 5, '');
  AppendMenu(hPopupMenu, MF_STRING, 6, '����');
end;

   // �����˵�
procedure PopupTheMenu;
var
  CurMousePos: TPoint;
begin
  SetForegroundWindow(WindowHandle);
  GetCursorPos(CurMousePos);
  TrackPopupMenu(hPopupMenu, TPM_RIGHTALIGN or TPM_LEFTBUTTON or TPM_RIGHTBUTTON,
                 CurMousePos.X, CurMousePos.Y, 0, WindowHandle, nil);
end;

   // �˵������
procedure MenuCommand(MenuID: Integer);
begin
  case MenuID of
    1: begin
         ContinueAdd := False;
         EnableMenuItem(hPopupMenu, 1, MF_GRAYED);   //����
         EnableMenuItem(hPopupMenu, 2, MF_ENABLED);  //����
       end;
    2: begin
         ContinueAdd := True;
         EnableMenuItem(hPopupMenu, 2, MF_GRAYED);   //����
         EnableMenuItem(hPopupMenu, 1, MF_ENABLED);  //����
       end;
    3: SendMessage(StatusHandle, PBM_SETPOS, 0, 0);
    4: PostQuitMessage(0);
    6: ShellExecute(0, 'open', 'http://www.2ccc.com', nil, nil, SW_SHOW);
  end;
end;

end.
