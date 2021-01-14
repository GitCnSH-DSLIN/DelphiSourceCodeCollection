unit  MainForm;

interface

    // ---- ���������� ---- //
procedure Create_MainForm;

implementation

uses
  Windows, CommCtrl, ShellAPI, Messages, ListUnit, PublicUnit;  

    // ---- ��������� ---- //
function FormProc(hForm, MsgID, WParam, LParam: LongWord): LongWord; stdcall;
var
  DragSum: Integer;
begin        
  if (CurState <> 0) and (MsgID = WM_NOTIFY) and //  �������ݲ������л�ҳ��
     (PNMHdr(LParam).code = TCN_SELCHANGING) then Result := 1
  else begin
    if (CurState <> 0) and (MsgID = WM_CLOSE) and // �����йرմ�����Ҫȷ��
       ( MessageBox(hForm, '��δ��ɴ���, ȷ���˳�����?  ', '��ʾ',
        MB_YESNO or MB_DEFBUTTON2 or MB_SETFOREGROUND) = ID_NO ) then Result := 1
    else begin

      if (MsgID = WM_NOTIFY) and (WParam = TabCtrlID) // �л�ҳ�������Ӧ����
         and (PNMHdr(LParam).code = TCN_SELCHANGE) then
      begin
        ShowWindow(hPanel1, SW_HIDE);
        ShowWindow(hPanel2, SW_HIDE);
        ShowWindow(hPanel3, SW_HIDE);
        Result := SendMessage(hTabCtrl, TCM_GETCURSEL, 0, 0);
        case Result of
          0: ShowWindow(hPanel1, SW_SHOW);
          1: ShowWindow(hPanel2, SW_SHOW);
          2: ShowWindow(hPanel3, SW_SHOW);
        end;         // ........ end case ........ ^^
      end else
        if (MsgID = WM_DROPFILES) then // ��������������ļ��Ϸ�
        begin
         // �ļ��б����FileList
          SetLength(FileList, 0);
          DragSum := DragQueryFile(WParam, $FFFFFFFF, nil ,1)-1;
          for Result := 0 to DragSum do
          begin
            DragQueryFile(WParam, Result, FilesBuf, MAX_LENGTH);
            if DirectoryExists(FilesBuf) then Continue; // �޳�Ŀ¼
            SetLength(FileList, Length(FileList) + 1);
            FileList[ High(FileList) ] := FilesBuf;
          end;
          DragFinish(WParam);
        // ���ݵ�ǰҳ������ͬ����
          if (Length(FileList) > 0) then
          begin
            Result := SendMessage(hTabCtrl, TCM_GETCURSEL, 0, 0);
            if (Result = 1) then FileList2ListBox
            else if (Result = 0) then
                 begin
                   SetCaption(hEdit1, FileList[0]);
                   SetCaption(hEdit2, FileList[0]+'.001');
                 end;
          end;
        end else
          if (MsgID=WM_DESTROY) then // ����ע����������߳���Ϣѭ�� 
            PostQuitMessage(0);

      Result := DefWindowProc(hForm, MsgID, WParam, LParam);
    end;
  end;      
end;

    // ---- ע�ᴰ���� ---- //
function RegisterForm: Boolean;
var
  FormClass: TWndClass;
begin
  with FormClass do
  begin
    Style := CS_HREDRAW or CS_VREDRAW;
    lpfnWndProc := @FormProc;
    cbClsExtra := 0;
    cbWndExtra := 0;
    hInstance := SysInit.hInstance;
    hIcon := LoadIcon(hInstance, 'Cool');
    hCursor :=  hArrowCursor;
    hbrBackground := COLOR_WINDOW;
    lpszMenuName := nil;
    lpszClassName := 'Splitter_MainForm_Mazi';
  end; 
  Result := RegisterClass(FormClass) <> 0;
end;

    // ---- ���������� ---- //
procedure Create_MainForm;
begin               
  if (RegisterForm = FALSE) then
  begin
    MessageBox(0, 'RegisterForm Error !!' , nil, MB_SETFOREGROUND);  Halt;
  end;
  hMainForm := CreateWindowEx(WS_EX_ACCEPTFILES or WS_EX_TOPMOST,
                              'Splitter_MainForm_Mazi', FormTitle,
                              WS_VISIBLE or WS_TILED or WS_SYSMENU
                              or WS_MINIMIZEBOX or WS_CLIPCHILDREN,
                              200, 200, 350, 200, 0, 0, hInstance, nil);
  if (hMainForm = 0) then
  begin
    MessageBox(0, 'Create MainForm Error !!', nil, MB_SETFOREGROUND);  Halt;
  end;
  SendMessage(hMainForm, WM_SETFONT, hSmallFont, 0);    
end;  

end.    
