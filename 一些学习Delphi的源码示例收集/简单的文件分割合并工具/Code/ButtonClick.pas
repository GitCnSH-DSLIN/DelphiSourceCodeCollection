unit  ButtonClick;

interface

    // ---- ����Panel�ϰ�ť��Ϣ ---- //
procedure Do_Command(WParam, LParam: LongWord);

implementation

uses
  Windows, Messages, DialogBox, CutFile, JoinFile, ListUnit, PublicUnit;

procedure On_Chilck_Button1;  // '��ʼ�ָ�' ..
begin
  if (CurState = 0) then Cut_File;
end;

procedure On_Chilck_Button2; // 'ȡ���ָ�' ..
begin
  Stop_Cut;
end;

procedure On_Chilck_Button3; // ָ��׼���ָ���ļ� ..
begin
  if (CurState <> 0) then Exit;
  if OpenFile_Dialog('*.*', '�����ļ�'#0'*.*'#0, '', FALSE) then
  begin
    SetCaption(hEdit1, FileList[0]);
    SetCaption(hEdit2, FileList[0]+'.001');
  end;
end;

procedure On_Chilck_Button4; // ָ���ָ����λ�� ..
begin
  if (CurState <> 0) then Exit;
  if SaveFile_Dialog('*.001', '��һ��'#0'*.001'#0, '001', FALSE) then
  begin
    if ExtractExteName(FileList[0])<>'.001' then FileList[0] := FileList[0] + '.001';
    SetCaption(hEdit2, FileList[0]);
  end;
end;

procedure On_Chilck_Button5; // ָ���ϲ�����λ�� ..
begin
  if (CurState <> 0) then Exit;
  if SaveFile_Dialog('*.*', '�����ļ�'#0'*.*'#0, '', TRUE) then
    SetCaption(hEdit3, FileList[0]);
end;

procedure On_Chilck_Button6; // '����ļ�' ..
begin
  if (CurState <> 0) then Exit;
  if OpenFile_Dialog('*.*', '�����ļ�'#0'*.*'#0, '', TRUE) then FileList2ListBox;
end;

procedure On_Chilck_Button7; // 'ɾ���ļ�' ..
begin
  if (CurState <> 0) then Exit;
  Delete_ListItem;
end;

procedure On_Chilck_Button8;  // '��ʼ�ϲ�' ..
begin
  if (CurState = 0) then Join_File;
end;

procedure On_Chilck_Button9; // 'ȡ���ϲ�' ..
begin
  Stop_Join;
end;   

    // ---- ����Panel�ϰ�ť��Ϣ ---- //
procedure Do_Command(WParam, LParam: LongWord);
begin
  if (HIWORD(WParam)=BN_CLICKED) then
  begin
    case LOWORD(WParam) of
      Button1ID : if (LParam = hButton1) then On_Chilck_Button1;
      Button2ID : if (LParam = hButton2) then On_Chilck_Button2;
      Button3ID : if (LParam = hButton3) then On_Chilck_Button3;
      Button4ID : if (LParam = hButton4) then On_Chilck_Button4;
      Button5ID : if (LParam = hButton5) then On_Chilck_Button5;
      Button6ID : if (LParam = hButton6) then On_Chilck_Button6;
      Button7ID : if (LParam = hButton7) then On_Chilck_Button7;
      Button8ID : if (LParam = hButton8) then On_Chilck_Button8;
      Button9ID : if (LParam = hButton9) then On_Chilck_Button9;
    end;
  end;  
end;

end.
