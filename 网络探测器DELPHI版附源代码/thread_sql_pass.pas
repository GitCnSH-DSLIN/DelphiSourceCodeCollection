unit thread_sql_pass;

interface

uses
  Classes, Windows, SysUtils, Connection, forms, ADODB, Db, syncobjs, ole2;
type
  Tsql_pass = class(TThread)
  private
    fado_con : TADOConnection;
    state,temp_pass : AnsiString;
    ip_no,user_no,Fpass_no : integer;
    run_count : integer;//�����й���ô��κ���˳�,���ͷ��ڴ�
  protected
    procedure Execute; override;
    procedure ThreadDone_pass(Sender: TObject);
    procedure set_list;
    procedure first_run;
    procedure NetCon_Echoopen(Sender : TObject; IConnection: TObject;Error: integer);

    procedure FAfterConnect(Sender : TObject);
    procedure adoConnectComplete(Connection: TADOConnection; const  Error : Error;
       var EventStatus: TEventStatus);
  public
    constructor Create(CreateSuspended: Boolean);
  end;

implementation

uses function_1, main, report, dict;

{ Tsql_pass }

procedure Tsql_pass.adoConnectComplete(Connection: TADOConnection;
  const Error: Error; var EventStatus: TEventStatus);
begin
 state:=Error.Description;
 Synchronize(set_list);//д������Ϣ
// first_run;
end;

constructor Tsql_pass.Create(CreateSuspended: Boolean);
begin
   OnTerminate := ThreadDone_pass;

   fado_con:= TADOConnection.Create(frmMain);
   fado_con.AfterConnect:=FAfterConnect;
   fado_con.OnConnectComplete:=adoConnectComplete;
   fado_con.ConnectionTimeout:=StrToInt(frmMain.Edit28.Text);
   fado_con.LoginPrompt:=false;
   fado_con.KeepConnection:=false;

   ip_no:=0;
   user_no:=0;
   Fpass_no:=0;
   run_count:=0;
   state:='';
   FreeOnTerminate := True;
   inc(share_thread_no);//�̼߳�1
   frmReport.Edit14.Text:=IntToStr(share_thread_no);
   frmMain.Edit25.Text:=IntToStr(share_thread_no);
   inherited Create(CreateSuspended);

end;

procedure Tsql_pass.Execute;
begin
  inherited;
  try
    CoInitialize(nil);//���߳���һ��Ҫ��ʼ��
    first_run;
  finally
    CoUninitialize;//���߳���һ��Ҫ��ʼ��
  end;
end;

procedure Tsql_pass.FAfterConnect(Sender: TObject);
begin
  state:='';
  Synchronize(set_list);//�ҵ�����
  fado_con.Close;
// first_run;

end;

procedure Tsql_pass.first_run;
var
  temp_str : AnsiString;
  po :integer;
  uo : AnsiString;
begin
  temp_str:='';

  inc(run_count);//��¼���еĴ���
  if (run_count>=50) then exit;
  Application.ProcessMessages;

  ping_CriticalSection.Enter;//�����ٽ�״̬
  Fpass_no:=scan_port_ip;//����ָʾ����λ��
  user_no:=share_ip_no; //�û�λ��
  ip_no:=cur_ip;
  if (ip_no>=main_list.Count)then
  begin
    ping_CriticalSection.Leave;//�����ٽ�״̬
    exit;
  end;

  if (const_pass) then //ʹ���ڶ�����
  begin
     uo := frmDict.user_list.Lines.Strings[user_no];
     temp_str:=NameToPass(uo,pass_no);
  end;
  if (temp_str='') then
  begin
    inc(scan_port_ip);
    if (scan_port_ip>=port_lists.Count)then
    begin
      scan_port_ip:=0;
      inc(share_ip_no);//�û��б�λ�ü�һ
      pass_no:=0;
      if (share_ip_no>=frmDict.user_list.Lines.Count) then
      begin
        share_ip_no:=0;
        inc(cur_ip);
        frmMain.Edit20.Text:=main_list.Strings[ip_no];//ʾ��ʾ����IP
      end;
    end;
  end;
  ping_CriticalSection.Leave;//�����ٽ�״̬
  if not (thread_run) then exit;
  fado_con.ConnectionString:='Provider=SQLOLEDB.1;Persist Security Info=True;Data Source='+main_list.Strings[ip_no];
  if (temp_str='') then//�����ڶ�����?
    temp_pass:=port_lists.Strings[Fpass_no]
  else
    temp_pass:=temp_str;

  fado_con.Open(frmDict.user_list.Lines.Strings[user_no],temp_pass);

end;

procedure Tsql_pass.NetCon_Echoopen(Sender, IConnection: TObject;
  Error: integer);
begin

end;

procedure Tsql_pass.set_list;
begin
  if (state='')then
  begin
//���ɹ���������һ���û�
     if (user_no=share_ip_no)then
     begin
       inc(share_ip_no);
       scan_port_ip:=0;
     end;
     frmReport.Edit1.Text:=IntToStr(StrToInt(frmReport.Edit1.Text)+1);
     frmMain.Edit22.Text:=IntToStr(StrToInt(frmMain.Edit22.Text)+1);
     frmMain.Edit3.Text:=port_lists.Strings[Fpass_no];//����
     if (report_show) then//����������ⴰ��д�¼�,ֻд�ɹ���
       frmReport.all_info.Lines.Add('���:'+main_list.Strings[ip_no]+'->�û�:'+
       frmDict.user_list.Lines.Strings[user_no]+'->����:'+temp_pass+'-------------[�ɹ�]');
     frmReport.ok_info.Lines.Add('����:['+main_list.Strings[ip_no]+'] �û�:['+
       frmDict.user_list.Lines.Strings[user_no]+'] ����:['+temp_pass+']');
  end else
  if (report_show)then //����������ⴰ��д�¼�,ֻд�ɹ���
  begin
    frmReport.all_info.Lines.Add('���:'+main_list.Strings[ip_no]+'->�û�:'+
         frmDict.user_list.Lines.Strings[user_no]+'->����:'+temp_pass+'-------------[ʧ��:'+state+']');
    if (frmReport.all_info.Lines.Count>500) then
    begin
      frmReport.all_info.Lines.Clear();
    end;
  end;

  frmReport.Edit9.Text:=IntToStr(StrToInt(frmReport.Edit9.Text)+1);

end;

//---------------------------------------------------------------------------
//���ڲ�ͣ��Ӧ�¼����ٴ����ӵĹ�����ʽ,���������һ��ʱ����ڴ�ջ��ܶ�,
//�ʴﵽһ���̶�Ҫ�ͷ�,���˳�!
procedure Tsql_pass.ThreadDone_pass(Sender: TObject);
begin
  fado_con.Free;
  Dec(share_thread_no); //�߳�������һ
  frmReport.Edit14.Text:=IntToStr(share_thread_no);
  frmMain.Edit25.Text:=IntToStr(share_thread_no);
//  if (run_count>=50) then
    frmMain.thread_time.Enabled:=true;//�����ⲿʱ��,
  if (share_thread_no=0)then
  begin
    frmMain.Bar.Position:=0;
  end;

end;

end.
