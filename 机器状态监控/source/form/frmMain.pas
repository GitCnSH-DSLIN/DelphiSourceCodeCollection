unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, IdBaseComponent,
  IdComponent, IdRawBase, IdRawClient, IdIcmpClient,unitPing,DateUtils;

type
  TfrmNetWatch = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    TaskList: TListBox;
    Splitter2: TSplitter;
    Panel2: TPanel;
    CurentTaskLog: TMemo;
    Splitter3: TSplitter;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    btnReadTask: TBitBtn;
    TaskLog: TMemo;
    ErrorLog: TMemo;
    Status: TStatusBar;
    PingTimer: TTimer;
    btnStartTask: TBitBtn;
    btnStopTask: TBitBtn;
    PingClient: TIdIcmpClient;
    btnClose: TBitBtn;
    procedure PingTimerTimer(Sender: TObject);
    procedure btnReadTaskClick(Sender: TObject);
    procedure btnStartTaskClick(Sender: TObject);
    procedure btnStopTaskClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PingClientReply(ASender: TComponent;
      const AReplyStatus: TReplyStatus);
  private
    { Private declarations }
  public
    { Public declarations }
    //�ֽ׶γ����֧�� ping ��������������� 
    PingTaskList : Tlist ;

    function AddMsg(ttMemo : TMemo ;msg : string ): boolean;

  end;

var
  frmNetWatch: TfrmNetWatch;

implementation

{$R *.dfm}
function TfrmNetWatch.AddMsg(ttMemo : TMemo;msg : string ): boolean;
var
  ttMsg,ttFileName : string ;
  ttTextFile : TextFile ;
begin
  if ttMemo.Lines.Count > 1000 then
    ttMemo.Lines.Clear;
  ttMsg := datetimetostr(now)+ ' : ' +msg ;
  ttMemo.Lines.Add(ttMsg);
  ttFileName :=  '.\log\' + ttMemo.Name + '_'+ inttostr(yearof(now))+'_'+ inttostr(monthof(now))+'_'+ inttostr(dayof(now)) + '.log';
  //����־д����־�ļ�
  try
    assignfile(ttTextFile,ttFileName);
    If FileExists(ttFileName) Then
      Reset(ttTextFile)
    Else
      Rewrite(ttTextFile);

    append(ttTextFile);
    WriteLn(ttTextFile, ttMsg);
  finally
    closefile(ttTextFile);
  end;
  result := true;
end;


procedure TfrmNetWatch.PingTimerTimer(Sender: TObject);
var
  tSeq ,tTotal : integer ;
  tPingTask : TstringList ;
  ttPing : TPing ;
  tStr : string ;
begin
  AddMsg(self.TaskLog,'��ʼִ������');
  self.Status.Panels[1].Text := datetimetostr(now);
  self.CurentTaskLog.Clear;
  //��� ��Ҫ���Ļ���
  tSeq := 0 ;
  tTotal := self.PingTaskList.Count;
  while tSeq < tTotal do
  begin
    sleep(1000);
    AddMsg(self.CurentTaskLog,'��⵽�� '+ inttostr(tSeq + 1)+' ������');
    AddMsg(self.TaskLog,'��⵽�� '+ inttostr(tSeq + 1)+' ������');

    tPingTask := TstringList.Create;
    tPingTask.AddStrings(TstringList(self.PingTaskList.List[tSeq]));
    AddMsg(self.CurentTaskLog,'�������ƣ�' + tPingTask.Strings[0] );
    AddMsg(self.CurentTaskLog,'����������' + tPingTask.Strings[1] );
    AddMsg(self.CurentTaskLog,'�������ࣺ' + tPingTask.Strings[2] );

    ttPing := tPing.create;
    try
        tStr := '';
        ttPing.pinghost(tPingTask.Strings[1],tStr);
        if pos('Can not find host',tStr) = 0 then
        begin
          AddMsg(self.CurentTaskLog,tPingTask.Strings[2]+'��������');
          AddMsg(self.CurentTaskLog,'���Խ����' + tStr );
        end
        else
        begin
          AddMsg(self.CurentTaskLog,tPingTask.Strings[2]+'�����Ѿ��ػ�');
          AddMsg(self.CurentTaskLog,'���Խ����' + tStr );
        end
    finally
      tPingTask.Free;
      ttPing.Free;

    end;

    tSeq := tSeq  + 1 ;
  end;

  AddMsg(self.TaskLog,'ִ���������');
end;

procedure TfrmNetWatch.btnReadTaskClick(Sender: TObject);
var
  tSeq,tTotal : integer ;
  tTask : TstringList;
begin
  //��������
  self.TaskList.Items.Clear;
  self.TaskList.Items.LoadFromFile('.\cfg\task.txt');

  //����   Ping ����
  //���Pingԭ������
  tSeq := 0 ;
  tTotal := self.PingTaskList.Count;
  while tSeq < tTotal do
  begin
    TstringList(self.PingTaskList.List[tSeq]).Free ;
    tSeq := tSeq + 1 ;
  end;
  self.PingTaskList.Clear;
  //����Ping�������
  tSeq := 0 ;
  tTotal := self.TaskList.Items.Count ;
  while tSeq < tTotal do
  begin
    //��ÿ��������н���
    if pos('ping', self.TaskList.Items.Strings[tSeq]) <> 0 then
    begin
      tTask := TstringList.Create;
      ExtractStrings([','],[' '],pchar(self.TaskList.Items.Strings[tSeq]),tTask);
      self.PingTaskList.Add(tTask);
    end;
    tSeq := tSeq  + 1 ;

  end;

  //������������� �ڴ����Խ���
  
end;

procedure TfrmNetWatch.btnStartTaskClick(Sender: TObject);
begin
  //��ʼ����
  self.btnReadTaskClick(Sender);  
  self.PingTimer.Enabled := true ;
end;

procedure TfrmNetWatch.btnStopTaskClick(Sender: TObject);
begin
  //��ʼ��������
  self.PingTimer.Enabled := false  ;
end;

procedure TfrmNetWatch.btnCloseClick(Sender: TObject);
begin
  //�˳�����
  self.Close;
end;

procedure TfrmNetWatch.FormCreate(Sender: TObject);
begin
  if self.PingTaskList = nil then
    self.PingTaskList := TList.Create;

  btnReadTaskClick(Sender);
end;

procedure TfrmNetWatch.PingClientReply(ASender: TComponent;
  const AReplyStatus: TReplyStatus);
begin
  //�ָ�����

end;

end.
