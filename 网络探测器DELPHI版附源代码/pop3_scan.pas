unit pop3_scan;

interface
uses
  Classes, SysUtils, SyncObjs, pop_scan, forms, Dialogs, winsock;
type
  TPop3_scan = class(TThread)
  private
    { Private declarations }
    Fscan_type : integer;
  protected
    procedure Execute; override;
  public
    Fpop_scan : Tpop_scan;
    constructor Create(CreateSuspended: Boolean);
    procedure OnScan(Error : integer);
    procedure set_str;
    procedure ThreadDone(Sender : TObject);
  end;

implementation

uses function_1,report, main;

{ TPop3_Detect }

constructor TPop3_scan.Create(CreateSuspended: Boolean);
begin

  Fpop_scan := Tpop_scan.Create(frmMain);
  OnTerminate :=ThreadDone;
  FreeOnTerminate := True;
  Fpop_scan.Port:=frmMain.Edit44.Text;

  Fpop_scan.OnScan:=OnScan;//ֻ��POP3����
  inc(ping_thread_no);

  frmMain.Edit42.Text:=IntToStr(ping_thread_no);
  inherited Create(CreateSuspended);

end;

procedure TPop3_scan.Execute;
var
  no : integer;
begin
  inherited;

  while (thread_run)do
  begin
    ping_CriticalSection.Enter;//�����ٽ�״̬
    no:=cur_ip;
    inc(cur_ip);
    if ((ping_ip_start+no)>ping_ip_stop) then
    begin
       ping_CriticalSection.Leave();//�����ٽ�״̬
       break;
    end else
    frmMain.Edit38.Text:=iptostr(ping_ip_start+no);
    frmMain.Bar.Position:=frmMain.Bar.Position+1;

    ping_CriticalSection.Leave;//�����ٽ�״̬

    Fpop_scan.Address:=iptostr(ping_ip_start+no);
    Fpop_scan.scan;
  end;

end;

procedure TPop3_scan.OnScan(Error: integer);
begin
 if (Error=0)then
   Synchronize(set_str);

end;

procedure TPop3_scan.set_str;
begin
  frmMain.Edit40.Text:=IntToStr(StrToInt(frmMain.Edit40.Text)+1);
  frmMain.pop3_list.Items.Add(Fpop_scan.Address);
  if (frmMain.pop3_auto.Checked)then
  begin
   thread_type:=110;
   frmMain.thread_time.Enabled:=true;
//    creat_pop3_detect();//���������û��߳�
  end;
end;

procedure TPop3_scan.ThreadDone(Sender: TObject);
begin
  (TPop3_scan(Sender)).Fpop_scan.Free;

  Dec(ping_thread_no);//ֻ��POP3����
  frmMain.Edit42.Text:=IntToStr(ping_thread_no);
  if (ping_thread_no=0) then
  begin
     frmMain.Bar.Position:=0;
     frmMain.Bar.Max:=main_list.Count*port_lists.Count;
     frmMain.Edit38.Text:='ɨ�����,��鿴...';
  end;

end;

end.
