unit  Buttons;

interface

    // ---- ����ȫ����ť ---- //
procedure Create_Buttons;

implementation

uses
  Windows, Messages, PublicUnit;

    // ---- ����������ť ---- //
function Create_Button(hParent, Left, Top, Width, Height, ID: LongWord; Text: PChar): LongWord;
begin
  Result := CreateWindowEx(0, 'BUTTON', Text, WS_CHILD or WS_VISIBLE or BS_FLAT,
                           Left, Top, Width, Height, hParent, ID, hInstance, nil);
  if (Result = 0) then
  begin
    MessageBox(0, 'Create Button Error !!', nil, MB_SETFOREGROUND);  Halt;
  end;
end;

    // ---- ����ȫ����ť ---- //
procedure Create_Buttons;
begin
  hButton1 := Create_Button(hPanel1, 148, 110, 85, 25, Button1ID, '��ʼ�ָ�');
  hButton2 := Create_Button(hPanel1, 251, 110, 85, 25, Button2ID, 'ȡ���ָ�');
  hButton3 := Create_Button(hPanel1, 318, 13, 18, 18, Button3ID, '..');
  hButton4 := Create_Button(hPanel1, 318, 43, 18, 18, Button4ID, '..');

  hButton5 := Create_Button(hPanel2, 318, 13, 18, 18, Button5ID, '..');
  hButton6 := Create_Button(hPanel2, 5, 40, 70, 23, Button6ID, '����ļ�');
  hButton7 := Create_Button(hPanel2, 5, 65, 70, 23, Button7ID, 'ɾ���ļ�');
  hButton8 := Create_Button(hPanel2, 5, 90, 70, 23, Button8ID, '��ʼ�ϲ�');
  hButton9 := Create_Button(hPanel2, 5, 115, 70, 23, Button9ID, 'ȡ���ϲ�');

  SendMessage(hButton1, WM_SETFONT, hSmallFont, 0);
  SendMessage(hButton2, WM_SETFONT, hSmallFont, 0);
  
  SendMessage(hButton6, WM_SETFONT, hSmallFont, 0);
  SendMessage(hButton7, WM_SETFONT, hSmallFont, 0);
  SendMessage(hButton8, WM_SETFONT, hSmallFont, 0);
  SendMessage(hButton9, WM_SETFONT, hSmallFont, 0);
end;

end.
