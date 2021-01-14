unit Window_Unit;

interface

  //----����������------
procedure Create_Window;  

implementation

uses
  Windows, Public_Unit;

const
  WM_DESTROY = $0002;    // ����ע����Ϣ
  WM_PAINT   = $000F;    // ����ˢ����Ϣ

var
  WindowIconH: LongWord; //������ͼ����

  //----��������Ϣ�������-----
function WindowProc(WinHanlde, MessageID, WParam, LParam : Longword):Longint; stdcall;
begin
        //---Ĭ�ϴ������---
  Result := DefWindowProc(WinHanlde, MessageID, WParam, LParam);
          //--ˢ��--            //--����ͼ��--
  if (MessageID = WM_PAINT) then DrawIconToForm
              //--ȡͼ��--
  else if (MessageID = WM_GETICON) then Result:=WindowIconH
                   //--�ر�--
       else if (MessageID = WM_DESTROY) then PostQuitMessage(0); 
end;

  //----ע�ᴰ����----
function RegWindowClass: Boolean;
var
  WindowClass: TWndClass;
begin
  WindowIconH := LoadIcon(hInstance, 'LiuMazi');
 {--���ṹ��--}
  WindowClass.Style := CS_HREDRAW or CS_VREDRAW;     // ��������
  WindowClass.lpfnWndProc := @WindowProc;            // ָ���������
  WindowClass.cbClsExtra := 0;                       // �޶�������Ϣ
  WindowClass.cbWndExtra := 0;                       // �޶��ⴰ����Ϣ
  WindowClass.hInstance := hInstance;                // ʵ�����
  WindowClass.hIcon := WindowIconH;                  // ָ��ͼ��
  WindowClass.hCursor := LoadCursor(0, IDC_ARROW);   // û�й��
  WindowClass.hbrBackground := COLOR_WINDOW;         // Ԥ������ɫ
  WindowClass.lpszMenuName := nil;                   // û�в˵�
  WindowClass.lpszClassName := 'EnumDemo_Mazi';          // ��ע�������
 {--ע�ᴰ����--}
  Result := RegisterClass(WindowClass) <> 0;
end;

  //----����������------
procedure Create_Window;
begin      
  if (not RegWindowClass) then
  begin
    MessageBox(0, 'ע�ᴰ����ʧ��' , nil, 0);
    Halt;
  end;
  WindowHanlde := CreateWindowEx(0,
                                'EnumDemo_Mazi',
                                '  ö�ٴ��ڼ�����      By ����',
                                WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU or WS_MINIMIZEBOX or WS_VISIBLE,
                                100,
                                100,
                                455,
                                236,
                                0,
                                0,
                                hInstance,
                                nil);
  if (WindowHanlde = 0) then
  begin
    MessageBox(0, '����������ʧ��', nil, 0);
    Halt;
  end;
 //--��������--
  MyFont_Hanlde := CreateFont(12, 6, 0, 0, FW_EXTRALIGHT, Byte(FALSE),
                              Byte(FALSE), Byte(FALSE), GB2312_CHARSET,
                              OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
                              DEFAULT_QUALITY, DEFAULT_PITCH, '����');
 //--��������--
  SendMessage(WindowHanlde, WM_SETFONT, MyFont_Hanlde, 0);
 //--�豸����--
  Window_hdc := GetDC(WindowHanlde);
end;  

end.
