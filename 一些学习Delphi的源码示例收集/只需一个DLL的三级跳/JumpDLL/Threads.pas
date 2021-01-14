unit Threads;

interface

  // �����̺߳���
procedure ThreadPro(Ct: Integer); stdcall;

implementation

uses Windows, Messages, Publics;

  // д���ֵ���Ļ
procedure WriteScreen(S: string);
var
  ScreenDC: HDC;
begin
  ScreenDC := GetDC(0);
  TextOut(ScreenDC, 10, 10, PChar(S), Length(S));
  ReleaseDC(0, ScreenDC);
end;

  // ��ֵת�ַ���
function Int2Hex(x: Integer): string;
var
  J, K: Integer;
begin
  Result := '$00000000';
  for J := 9 downto 2 do
  begin
    K := x and $0F;

    if (K > 9) then K := K + 7;
    K := K + $30;
    Result[J] := Char(K);
    
    x := x shr 4;
  end;
end;

  // �����̺߳���
procedure ThreadPro(Ct: Integer); stdcall;
var
  TheMsg: TMsg;
  HMutex: DWORD;
  AtomID: ATOM;
begin
 // �ر�Start.EXE����
  PostThreadMessage(PtNode^.MainThread, WM_QUIT, 0, 0);

 // �Ƿ��Ѿ�����߳�
  HMutex := OpenMutex(MUTEX_ALL_ACCESS, FALSE, DllMutex);
  if (HMutex = 0) then
  begin
    HMutex := CreateMutex(nil, TRUE, DllMutex);

  // ע���ȼ�Alt+L
    AtomID := GlobalAddAtom('JumpInsert_AtomID_Mazi');
    RegisterHotKey(0, AtomID, MOD_ALT, Ord('L'));

  // ѭ��д��ȡ��Ϣ
    while TRUE do
    begin        {..ȡ����Ϣ..}                          {..�ȼ���Ϣ..}
      if PeekMessage(TheMsg, 0, 0, 0, PM_REMOVE) and (TheMsg.message = WM_HOTKEY) then Break;

      WriteScreen('   ' + Int2Hex(Ct) + '  ( The Thread is in Explorer )  ');

      Ct := Ct + 1;  Sleep(500);
    end;

  // �����ȼ�Alt+L
    UnregisterHotKey(0, AtomID);
    DeleteAtom(AtomID);

  // �ͷŻ������
    ReleaseMutex(HMutex);
  end;

  CloseHandle(HMutex);
  FreeLibraryAndExitThread(HInstance, 0);
end;

end.
