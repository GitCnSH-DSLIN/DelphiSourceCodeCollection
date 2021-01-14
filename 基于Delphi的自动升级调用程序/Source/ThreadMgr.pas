
{*************************************************************************}
{ ��Ԫ����: �̹߳���Ԫ                                                  }
{ ��    ��: 1.3.4                                                         }
{ ��    ע: �˵�Ԫ�ṩ�̰߳�ȫ�˳����߳��¼���ȫ�ص��ȹ��ܡ�              }
{                                                                         }
{ ʹ��˵��:                                                               }
{   1. �����̴߳� TSafeThread �̳У��������˳�ǰ������ WaitForAllThread�� }
{   2. ���Ǵ��¼��ص����̲߳�����һ��Ϊ���������ģ�鷢���������߳�ִ�� }
{      �������յ�Ӧ��������¶����������յ�Ӧ��ʱ����Ҳ���Ѿ����û��رջ� }
{      ȡ�������п���������̻��ҡ�����Լ��Ӧ�����в���ִ�У�             }
{      a. �� TThreadOperator �̳г��µĲ����࣬���� DoSendRequest ��      }
{         DoRecvResponse�����麯�������߹����������ע�͡�����Ҫ���Ӳ�����}
{         �������� InitParameter ������                                   }
{      b. ��ִ���̲߳���ʱ������ȫ�ֺ��� ExecuteEventThread�������������� }
{         ��ָ�롢�µĲ��������ز�����֪�˺�����                        }
{      c. �ڲ���������(���壬����ģ���) ������������ϴη����������Ӧ�� }
{         ʱ��Ӧ���� EventThreadMgr.UnregisterThread��ע���̡߳�          }
{         UnregisterOwner ������ע���Լ���                                }
{      d. �ڲ��������߹ر�ʱ��Ӧ���� EventThreadMgr.UnregisterOwner ������}
{         ע���Լ���                                                      }
{*************************************************************************}

unit ThreadMgr;

interface

uses
  Windows, SysUtils, Classes, Controls, SyncObjs, Dialogs, Forms;

type

{ Classes }

  TSafeThread = class;
  TEventThread = class;
  TThreadOperator = class;
  TEventThreadMgr = class;

{ TSafeThread - ��ȫ�̻߳��� }

  TThreadSyncExEvent = procedure(Param: Pointer) of object;

  TSafeThread = class(TThread)
  private
    FSyncMethod: TThreadSyncExEvent;
    FSyncParam: Pointer;

    procedure DoSynchronizeEx;
  protected
    function GetTerminated: Boolean; virtual;
    procedure DoTerminate; override;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;

    //Ȱ���߳��˳�
    procedure Stop; virtual;
    //ǿ���߳��˳�
    procedure Kill; virtual;
    
    procedure Synchronize(Method: TThreadMethod); overload;
    procedure SynchronizeEx(Method: TThreadSyncExEvent; Param: Pointer);

    property Terminated read GetTerminated;
  end;

{ TThreadOperator - �̲߳����� }

  TThreadOprClass = class of TThreadOperator;
  TThreadOprOption = (tooChgCursor);
  TThreadOprOptions = set of TThreadOprOption;
  TResponseEvent = procedure(Operator: TThreadOperator) of object;

  TThreadOperator = class(TObject)
  protected
    FOwner: TObject;             //�̲߳��������ߣ���TEventThread����
    FThread: TEventThread;       //ִ�в������̣߳���TEventThread����
    FOptions: TThreadOprOptions; //ѡ��

    procedure DoBegin;
    procedure DoEnd;
  protected
    procedure InitParameter(const Params: array of const); virtual;
    function BeforeExecute: Boolean; virtual;
    procedure DoSendRequest; virtual;
    procedure DoRecvResponse; virtual;
  public
    constructor Create;
    destructor Destroy; override;

    procedure SendRequest;
    procedure RecvResponse;
    property Owner: TObject read FOwner;
  end;

{ TEventThread }

  TEventThread = class(TSafeThread)
  protected
    FOperator: TThreadOperator;
    procedure Execute; override;
  public
    constructor Create(AOwner: TObject; AOprClass: TThreadOprClass;
      const Params: array of const; Options: TThreadOprOptions);
    destructor Destroy; override;
  end;

{ TEventThreadMgr }

  PEventThreadItem = ^TEventThreadItem;
  TEventThreadItem = record
    Owner: TObject;
    Thread: TEventThread;
  end;

  TEventThreadMgr = class(TObject)
  private
    FItems: TList;
    FCSect: TCriticalSection;

    procedure Clear;
    procedure Lock;
    procedure Unlock;
    function FindOwner(AOwner: TObject): Integer;
    function FindThread(AThread: TEventThread): Integer;
    procedure Delete(Index: Integer);
  public
    constructor Create;
    destructor Destroy; override;

    procedure RegisterThread(AOwner: TObject; AThread: TEventThread);
    procedure UnregisterThread(AThread: TEventThread);
    procedure UnregisterOwner(AOwner: TObject);
  end;

var
  ThreadList: TThreadList;
  EventThreadMgr: TEventThreadMgr;

function ExecuteEventThread(AOwner: TObject; AOprClass: TThreadOprClass;
  const Params: array of const; Options: TThreadOprOptions = [tooChgCursor]): TEventThread;
procedure WaitForAllThread;
procedure WaitForThread(Thread: TThread);
procedure SleepThread(Thread: TSafeThread; MSeconds: Integer);

implementation

//-----------------------------------------------------------------------------
// ����: ִ��һ�����¼����߳�
// ����:
//   AOwner       - �̲߳��������� (����TForm, TDataModule, TObject ��)
//   AOprClass    - �¼��̲߳�����
//   Params       - ��Ҫ����������Ĳ���
//   Options      - �̲߳���ѡ��
// ����:
//   ִ�д˴β������߳�
//-----------------------------------------------------------------------------
function ExecuteEventThread(AOwner: TObject; AOprClass: TThreadOprClass;
  const Params: array of const; Options: TThreadOprOptions): TEventThread;
begin
  Result := TEventThread.Create(AOwner, AOprClass, Params, Options);
  Result.Resume;
end;

//-----------------------------------------------------------------------------
// ����: �ȴ������̰߳�ȫ�˳�
// ��ע: �� Application �˳�ǰ��Ӧ���ô˺�����
//-----------------------------------------------------------------------------
procedure WaitForAllThread;
const
  TerminateWaitTime: Integer = 5*1000;   //�ܹ��ȴ��೤ʱ��(����)
  SleepTime: Integer = 250;              //���ʱ����(����)
var
  I, J: Integer;
  List: TList;
begin
  for I := 1 to (TerminateWaitTime div SleepTime) do
  begin
    List := ThreadList.LockList;
    try
      if List.Count = 0 then Break;
      for J := List.Count - 1 downto 0 do
      begin
        if TObject(List[J]) is TSafeThread then
          try
            TSafeThread(List[J]).Stop;
          except
          end
        else
          TThread(List[J]).Terminate;
      end;
      Classes.CheckSynchronize;
    finally
      ThreadList.UnlockList;
    end;
    Sleep(SleepTime);
  end;

  //ǿ����ֹ�߳�
  List := ThreadList.LockList;
  try
    for I := 0 to List.Count - 1 do
      TerminateThread(TThread(List[I]).Handle, 0);
  finally
    ThreadList.UnlockList;
  end;
  ThreadList.Clear;
end;

//-----------------------------------------------------------------------------
// ����: �ȴ�ĳ���̰߳�ȫ�˳�
//-----------------------------------------------------------------------------
procedure WaitForThread(Thread: TThread);
const
  SleepTime: Integer = 250;             //���ʱ����(����)
var
  List: TList;
begin
  if Thread = nil then Exit;
  while True do
  begin
    List := ThreadList.LockList;
    try
      if List.IndexOf(Pointer(Thread)) = -1 then Break;
      if Thread is TSafeThread then
        try
          TSafeThread(Thread).Stop
        except
        end
      else
        Thread.Terminate;
      Classes.CheckSynchronize;
    finally
      ThreadList.UnlockList;
    end;
    Sleep(SleepTime);
  end;
end;

//-----------------------------------------------------------------------------
// ����: ���߳̽���˯��
// ��ע: 1. �˹��̱������̵߳��á� 2. ˯�߻���Terminated���жϡ�
//-----------------------------------------------------------------------------
procedure SleepThread(Thread: TSafeThread; MSeconds: Integer);
const
  Interval = 100;
var
  I: Integer;
begin
  for I := 1 to MSeconds div Interval do
  begin
    if Thread.Terminated then Break;
    Sleep(Interval);
  end;
end;

{ TSafeThread }

constructor TSafeThread.Create(CreateSuspended: Boolean);
begin
  inherited;
  FreeOnTerminate := True;
  ThreadList.Add(Self);
end;

destructor TSafeThread.Destroy;
begin
  ThreadList.Remove(Self);
  inherited;
end;

function TSafeThread.GetTerminated: Boolean;
begin
  Result := inherited Terminated or Application.Terminated;
end;

procedure TSafeThread.DoTerminate;
begin
  ThreadList.Remove(Self);
  inherited;
end;

procedure TSafeThread.Stop;
begin
  inherited Terminate;
end;

procedure TSafeThread.Kill;
begin
  ThreadList.Remove(Self);
  TerminateThread(Handle, 0);
end;

procedure TSafeThread.DoSynchronizeEx;
begin
  FSyncMethod(FSyncParam);
end;

procedure TSafeThread.Synchronize(Method: TThreadMethod);
begin
  inherited Synchronize(Method);
end;

procedure TSafeThread.SynchronizeEx(Method: TThreadSyncExEvent; Param: Pointer);
begin
  if Assigned(Method) then
  begin
    FSyncMethod := Method;
    FSyncParam := Param;
    Synchronize(DoSynchronizeEx);
  end;
end;

{ TThreadOperator }

//-----------------------------------------------------------------------------
// ����: ���캯��
//-----------------------------------------------------------------------------
constructor TThreadOperator.Create;
begin
  inherited;
end;

destructor TThreadOperator.Destroy;
begin
  inherited;
end;

procedure TThreadOperator.DoBegin;
begin
  if tooChgCursor in FOptions then
    Screen.Cursor := crAppStart;
end;

procedure TThreadOperator.DoEnd;
begin
  if tooChgCursor in FOptions then
    Screen.Cursor := crDefault;
end;

//-----------------------------------------------------------------------------
// ����: ��ʼ������
//-----------------------------------------------------------------------------
procedure TThreadOperator.InitParameter(const Params: array of const);
begin
end;

//-----------------------------------------------------------------------------
// ����: �� SendRequest ֮ǰ������
// ����:
//   True  - ��������ִ��
//   False - ������ִ�У�ʹ�߳��˳�
//-----------------------------------------------------------------------------
function TThreadOperator.BeforeExecute: Boolean;
begin
  Result := True;
end;

//-----------------------------------------------------------------------------
// ����: ��������
// ��ע: �˺���ͨ������������ύ����Ĳ�����
//-----------------------------------------------------------------------------
procedure TThreadOperator.DoSendRequest;
begin
end;

//-----------------------------------------------------------------------------
// ����: �յ�Ӧ��
// ��ע: �˺���ͨ������ִ�����յ�Ӧ���Ĳ�����������½���ȡ�
// ע��: �˺��������̵߳�Synchronize������ִ�С�
//-----------------------------------------------------------------------------
procedure TThreadOperator.DoRecvResponse;
begin
end;

//-----------------------------------------------------------------------------
// ����: �������� (���߳� TEventThread ����)
//-----------------------------------------------------------------------------
procedure TThreadOperator.SendRequest;
begin
  FThread.Synchronize(DoBegin);
  //ע���̲߳��������ߺ�����ID
  EventThreadMgr.RegisterThread(FOwner, FThread);
  DoSendRequest;
end;

//-----------------------------------------------------------------------------
// ����: �յ�Ӧ�� (���߳� TEventThread ����)
//-----------------------------------------------------------------------------
procedure TThreadOperator.RecvResponse;
var
  Found: Boolean;
begin
  EventThreadMgr.Lock;
  try
    //����߳��Ƿ���ע��
    Found := (EventThreadMgr.FindThread(FThread) <> -1);
  finally
    EventThreadMgr.Unlock;
  end;

  try
    if Found then
      FThread.Synchronize(DoRecvResponse);
  finally
    FThread.Synchronize(DoEnd);
  end;
end;

{ TEventThread }

//-----------------------------------------------------------------------------
// ����: ���캯��
// ����:
//   AOwner    - �̲߳��������� (����TForm, TDataModule, TObject��)
//   AOprClass - �¼��̲߳�����
//   Params    - ����������Ĳ���
//   Options   - �̲߳���ѡ��
//-----------------------------------------------------------------------------
constructor TEventThread.Create(AOwner: TObject; AOprClass: TThreadOprClass;
  const Params: array of const; Options: TThreadOprOptions);
begin
  inherited Create(True);

  //��������ʼ����������
  FOperator := AOprClass.Create;
  FOperator.FOwner := AOwner;
  FOperator.FThread := Self;
  FOperator.FOptions := Options;
  FOperator.InitParameter(Params);

  FreeOnTerminate := True;
end;

destructor TEventThread.Destroy;
begin
  FOperator.Free;
  inherited;
end;

procedure TEventThread.Execute;
begin
  if not Terminated then
  begin
    if FOperator.BeforeExecute then
    begin
      FOperator.SendRequest;
      FOperator.RecvResponse;
    end;
  end;
end;

{ TEventThreadMgr }

constructor TEventThreadMgr.Create;
begin
  inherited;
  FItems := TList.Create;
  FCSect := TCriticalSection.Create;
end;

destructor TEventThreadMgr.Destroy;
begin
  Clear;
  FItems.Free;
  FCSect.Free;
  inherited;
end;

procedure TEventThreadMgr.Lock;
begin
  FCSect.Enter;
end;

procedure TEventThreadMgr.Unlock;
begin
  FCSect.Leave;
end;

procedure TEventThreadMgr.Clear;
var
  I: Integer;
begin
  Lock;
  try
    for I := 0 to FItems.Count - 1 do
      Dispose(PEventThreadItem(FItems[I]));
    FItems.Clear;
  finally
    Unlock;
  end;
end;

function TEventThreadMgr.FindOwner(AOwner: TObject): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FItems.Count - 1 do
    if PEventThreadItem(FItems[I]).Owner = AOwner then
    begin
      Result := I;
      Exit;
    end;
end;

function TEventThreadMgr.FindThread(AThread: TEventThread): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FItems.Count - 1 do
    if PEventThreadItem(FItems[I]).Thread = AThread then
    begin
      Result := I;
      Exit;
    end;
end;

procedure TEventThreadMgr.Delete(Index: Integer);
begin
  Dispose(PEventThreadItem(FItems[Index]));
  FItems.Delete(Index);
end;

//-----------------------------------------------------------------------------
// ����: ע������߳�
// ����:
//   AOwner  - ����������
//   AThread - �����߳�
//-----------------------------------------------------------------------------
procedure TEventThreadMgr.RegisterThread(AOwner: TObject; AThread: TEventThread);
var
  ItemPtr: PEventThreadItem;
begin
  New(ItemPtr);
  ItemPtr.Owner := AOwner;
  ItemPtr.Thread := AThread;

  Lock;
  try
    FItems.Add(ItemPtr);
  finally
    Unlock;
  end;
end;

//-----------------------------------------------------------------------------
// ����: ע�������߳�
// ����:
//   AThread - �����߳�
//-----------------------------------------------------------------------------
procedure TEventThreadMgr.UnregisterThread(AThread: TEventThread);
var
  I: Integer;
begin
  Lock;
  try
    while True do
    begin
      I := FindThread(AThread);
      if I <> -1 then Delete(I)
      else Break;
    end;
  finally
    Unlock;
  end;
end;

//-----------------------------------------------------------------------------
// ����: ע������������
// ����:
//   AOwner  - ����������
// ��ע:
//   �Ͳ�����������صĲ����߳̾���ע����
//-----------------------------------------------------------------------------
procedure TEventThreadMgr.UnregisterOwner(AOwner: TObject);
var
  I: Integer;
begin
  Lock;
  try
    while True do
    begin
      I := FindOwner(AOwner);
      if I <> -1 then Delete(I)
      else Break;
    end;
  finally
    Unlock;
  end;
end;

initialization
  ThreadList := TThreadList.Create;
  EventThreadMgr := TEventThreadMgr.Create;

finalization
  EventThreadMgr.Free;
  ThreadList.Free;

end.
