unit Public;

interface

uses Windows, Messages;

var Window_Handle, Button1Handle, Button2Handle: HWND;      

procedure HookOn ; external '..\DLL\Hook.dll';
procedure HookOff; external '..\DLL\Hook.dll';
procedure TheInitialize;
procedure DoCommand(W, L: DWORD);

implementation

procedure TheInitialize;
var
  FontHanlde: HFONT;
begin
  FontHanlde := CreateFont(12, 6, 0, 0, FW_EXTRALIGHT, Byte(FALSE), Byte(FALSE),
    Byte(FALSE), GB2312_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
    DEFAULT_QUALITY, DEFAULT_PITCH, '����');
  SendMessage(Window_Handle, WM_SETFONT, FontHanlde, 0);
  SendMessage(Button1Handle, WM_SETFONT, FontHanlde, 0);
  SendMessage(Button2Handle, WM_SETFONT, FontHanlde, 0);
  EnableWindow(Button2Handle, FALSE);  
end;

    //����WM_COMMAND��Ϣ
procedure DoCommand(W, L: DWORD);
begin
  if (HIWORD(W) <> BN_CLICKED) then Exit;

  if(LOWORD(W) = 1) and (L = Button1Handle) then     //����HookOn��ť
  begin
    EnableWindow(Button1Handle, FALSE);
    EnableWindow(Button2Handle, TRUE);
    HookOn;
  end else
  begin
    if(LOWORD(W) = 2) and (L = Button2Handle) then   //����HookOff��ť
    begin
      EnableWindow(Button1Handle, TRUE);
      EnableWindow(Button2Handle, FALSE);
      HookOff;
    end;
  end;
end;

end.
