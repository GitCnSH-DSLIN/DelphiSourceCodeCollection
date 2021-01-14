program SnowFall;

{$R 'LiuMazi.res' 'LiuMazi.txt'}

uses
  Windows, Messages;

const
  SnowNumber = 500; // ѩ������-1

type
  SnowNode = record
    Point: TPoint;  // ѩ��λ��
    Color: Integer; // ��ǰ��ɫ
    Speed: Integer; // ��������
    nMove: Integer; // �������
    Stick: Integer; // 'ճ��'��
  end;

var
  SnowNodes: array[0..SnowNumber] of SnowNode; // ѩ������
  hTimer: Integer; // '�������'ʱ�Ӿ��
  CrWind: Integer; // ��ǰ'����' ( -1 ~ 1 )
  CrStep: Integer; // ��ǰѭ������(��������) 
  ScreenWidth, ScreenHeight: Integer; // ��Ļ�ߴ�
  
  
  // ȡ��Ļ�ߴ� -> ScreenWidth, ScreenHeight
procedure GetScreenSize;
begin
  ScreenWidth := GetSystemMetrics(SM_CXSCREEN);
  ScreenHeight := GetSystemMetrics(SM_CYSCREEN);
end;

  // '�������'ʱ��
procedure TimerProc(hWnd: HWND; uMsg: UINT; idEvent: UINT; dwTime: DWORD); stdcall;
begin
  SetTimer(0, hTimer, (Random(27)+4) * 500, @TimerProc); // �����´η���ı�ʱ��
  if (CrWind <> 0) then CrWind := 0 else CrWind := Random(3) - 1; // �޸ķ���
end;

  // ��ʼ��ѩ������
procedure InitSnowNodes;
var
  hScreenDc, J: Integer;
begin
  hScreenDc := CreateDC('DISPLAY', nil, nil, nil);
  for J := 0 to SnowNumber do
  begin
    SnowNodes[J].Point.X := Random(ScreenWidth);
    SnowNodes[J].Point.Y := Random(ScreenHeight);
    SnowNodes[J].Color := GetPixel(hScreenDc, SnowNodes[J].Point.X, SnowNodes[J].Point.Y);
    SnowNodes[J].Speed := Random(5) + 1; // ����ѭ��������һ�� (1~5)
    SnowNodes[J].nMove := Random(SnowNodes[J].Speed)+1; // ÿ���������(1~5)
    SnowNodes[J].Stick := 30 - Random(SnowNodes[J].Speed); // 'ճ��'��(����ѭ����һ��ճ���ж�)
  end;
  DeleteDC(hScreenDc);
end;

  // �ƶ�ѩ�� ..
procedure MoveSnowNodes;
var
  hScreenDc, I, X, Y: Integer;
begin
  hScreenDc := CreateDC('DISPLAY', nil, nil, nil);
  for I := 0 to SnowNumber do
  begin
   // ����ѩ���½�����
    if (CrStep mod SnowNodes[I].Speed) <> 0 then Continue;
   // �ָ��ϴα����ǵ�
    if GetPixel(hScreenDc, SnowNodes[I].Point.X, SnowNodes[I].Point.Y) = $FFFFFF then
      SetPixel(hScreenDc, SnowNodes[I].Point.X, SnowNodes[I].Point.Y, SnowNodes[I].Color);
   // ���ݷ��������Ʈ��
    X := SnowNodes[I].Point.X + Random(3) - 1 + CrWind;
    Y := SnowNodes[I].Point.Y + SnowNodes[I].nMove;
   // ��ѩ(ͣ��)Ч������
    if ( (CrStep mod SnowNodes[I].Stick) = 0 ) // ���ͻ�ѩ���� ..
       and ( GetPixel(hScreenDc, X, Y) <> GetPixel(hScreenDc, X, Y+1) ) // '��Ե'�ж�
       and ( GetPixel(hScreenDc, X-1, Y) <> GetPixel(hScreenDc, X-1, Y+1) )
       and ( GetPixel(hScreenDc, X+1, Y) <> GetPixel(hScreenDc, X+1, Y+1) ) then
    begin
     // ��΢��������
      if GetPixel(hScreenDc, X, Y-1) = GetPixel(hScreenDc, X, Y-2) then Dec(Y) // �ϱ�Ե
      else if GetPixel(hScreenDc, X, Y+1) = GetPixel(hScreenDc, X, Y+2) then Inc(Y); // �±�Ե
      Inc(X, CrWind);
     // ��������(ѩ��)
      SetPixel(hScreenDc, X, Y, $FFFFFF);
      SetPixel(hScreenDc, X+1, Y+1, $FFFFFF);
      SetPixel(hScreenDc, X-1, Y+1, $FFFFFF);
     // ����ѩ��
      SnowNodes[I].Point.Y := Random(10);
      SnowNodes[I].Point.X := Random(ScreenWidth);
      SnowNodes[I].Color := GetPixel(hScreenDc, SnowNodes[I].Point.X, SnowNodes[I].Point.Y);
    end else
    begin
      if (X < 0) or (X > ScreenWidth) or (Y > ScreenHeight) then // ������Χ������ѩ��
      begin
        SnowNodes[I].Point.Y := Random(10);
        SnowNodes[I].Point.X := Random(ScreenWidth);
        SnowNodes[I].Color := GetPixel(hScreenDc, SnowNodes[I].Point.X, SnowNodes[I].Point.Y);
      end else
      begin
       // ������ɫ������ѩ��
        SnowNodes[I].Color := GetPixel(hScreenDc, X, Y);
        SetPixel(hScreenDc, X, Y, $FFFFFF);
       // ��ʱ������ѩ��λ��
        SnowNodes[I].Point.X := X;
        SnowNodes[I].Point.Y := Y;
      end;
    end;
  end;
  DeleteDC(hScreenDc);
  Inc(CrStep);
end;  

var
  ThreadMsg: TMsg;  // ��׼��Ϣ�ṹ��
  Frequency: Int64; // �����ܶ�ʱ��Ƶ��
  StartCt, EndCt: Int64; // �����ܶ�ʱ������
  ElapsedTime: Extended; // ʱ����
begin
  Randomize;  GetScreenSize;  InitSnowNodes; // ��ʼ��
  QueryPerformanceFrequency(Frequency); // �����ܶ�ʱ��Ƶ��
  hTimer := SetTimer(0, 0, Random(5)*500, @TimerProc); // ��װ�������ʱ��
  RegisterHotKey(0, 0, MOD_CONTROL, ORD('L')); // ע���˳��ȼ� Ctrl+L
  while TRUE do // ��Ϣѭ��
  begin
    QueryPerformanceCounter(StartCt); // ִ������ǰ ����ֵ
    if PeekMessage(ThreadMsg, 0, 0, 0, PM_REMOVE) then // ȡ����Ϣ
    begin
      case ThreadMsg.message of
        WM_TIMER:
          TimerProc(0, 0, 0, 0); // Ԥ�����ı�ʱ���ѵ�

        WM_HOTKEY:
          begin
            KillTimer(0, hTimer); // ɾ���������ʱ��
            UnregisterHotKey(0, 0); // ɾ���˳��ȼ� Ctrl+L
            InvalidateRect(0, nil, TRUE); // ˢ����Ļ
            Break; // ������Ϣѭ��
          end;

        WM_DISPLAYCHANGE:
          begin
            GetScreenSize; // ����ȡ��Ļ�ߴ�
            InitSnowNodes; // ��ʼ��ѩ������
          end;
      end;
    end;
    MoveSnowNodes; // �ƶ�ѩ��
    QueryPerformanceCounter(EndCt); // ִ����������ֵ
    ElapsedTime := (EndCt-StartCt)/Frequency; 
    if (ElapsedTime < 0.0005) then Sleep(2) // ������
    else if (ElapsedTime < 0.0010) then Sleep(1)
         else if (ElapsedTime < 0.0015) then Sleep(0);
  end;
end.
