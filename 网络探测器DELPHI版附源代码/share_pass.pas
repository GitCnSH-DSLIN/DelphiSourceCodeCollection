unit share_pass;

interface

uses
  Classes, SysUtils, SyncObjs, Connection;

type
  tshare_pass = class(TThread)
  private
    { Private declarations }
    FNetConnection : TNetConnection;
    flist : TStringList;//���ڱ����û��б�
    state : integer;
    pass_no,user_no: longint;
  protected
    procedure ThreadDone_share(Sender : TObject);
    procedure set_list;
    procedure NetCon_Echoopen(Sender: TObject; IConnection: TObject; Error: integer);
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean);
  end;

implementation

{ Important: Methods and properties of objects in VCL or CLX can only be used
  in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure tshare_pass.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

uses function_1,report, main, dict;

{ tshare_pass }

procedure tshare_pass.ThreadDone_share(Sender : TObject);
begin
  FNetConnection.Free;
  flist.Free;
  Dec(share_thread_no); //�߳�������һ
  frmReport.Edit14.Text := IntToStr(share_thread_no);

  if (share_thread_no = 0) then
  begin
//    frmmain.Edit8.Text := '���ҹ������';
//    frmmain.BitBtn4.Enabled <> frmmain.share_check.Checked;
//    frmmain.BitBtn5.Enabled <> frmmain.share_check.Checked;
    frmMain.Bar.Position := 0;
  end;
end;

constructor tshare_pass.Create(CreateSuspended: Boolean);
begin
   FNetConnection := TNetConnection.Create(frmMain);
   flist := TStringList.Create;
   //   FNetConnection.OnEchoClose := NetCon_EchoClose;
   FNetConnection.OnEchoOpen := NetCon_Echoopen;
   FNetConnection.GetInfo := false;//��ϵͳ��Ϣ
   FNetConnection.AutoDo := false;//�����Զ�����
   OnTerminate := ThreadDone_share;
   FreeOnTerminate := True;
   inc(share_thread_no);//�̼߳�1
   frmReport.Edit14.Text := IntToStr(share_thread_no);
  inherited Create(CreateSuspended);

end;

procedure tshare_pass.Execute;
var
  ip_no, temp : Integer;
  temp_str,un : AnsiString;
begin
  { Place thread code here }
  temp := 0;
  temp_str := '';
  while (thread_run) do
  begin
    pass_no := 0;//����ָʾ����λ��
    user_no := 0;
    ping_CriticalSection.Enter;//�����ٽ�״̬
    ip_no := cur_ip;
    inc(cur_ip);
    ping_CriticalSection.Leave;//�����ٽ�״̬
    if (ip_no >= main_list.Count) then exit;

    FNetConnection.Address := main_list.Strings[ip_no];
    FNetConnection.get_user(1,flist);//���û�
    if (flist.Count = 0) then //��û���û���ȡĬ�ϵ��û�
        flist.AddStrings(frmDict.user_list.Lines)
      else temp := 0;

    while (thread_run) do
    begin
      if (pass_no >= port_lists.Count) then
      begin
        pass_no := 0;
        temp := 0;
        inc(user_no);//�û��б�λ�ü�һ
        if (user_no >= flist.Count)then
        begin
           user_no := 0;
           break;
        end;
      end;
      FNetConnection.UserName := flist.Strings[user_no];
      if (const_pass) then //ʹ���ڶ�����
      begin
        un := FNetConnection.UserName;
        temp_str := NameToPass(un,temp);
      end;

      if (temp_str <> '')then
          FNetConnection.PassWord := temp_str
         else
         begin
           FNetConnection.PassWord := port_lists.Strings[pass_no];
           inc(pass_no);
         end;

      FNetConnection.open;
      FNetConnection.close;
    end;
  end;

end;

procedure tshare_pass.NetCon_Echoopen(Sender, IConnection: TObject;
  Error: integer);
begin
  state := Error;
  Synchronize(set_list);//дȫ����Ϣ
  if ((Error=51)or (Error=53)or (Error=64)or (Error=1792)) then//Զ�̼����������/����·��������/��������/��¼��������
  begin
    user_no := flist.Count;
    pass_no := port_lists.Count;
  end;

end;

procedure tshare_pass.set_list;
begin
 if (state=0) then
 begin
//���ɹ���������һ���û�
    if (FNetConnection.UserName=flist.Strings[user_no]) then
       pass_no := port_lists.Count;

    Beep;
    frmReport.Edit1.Text := IntToStr(StrToInt(frmReport.Edit1.Text)+1);
    frmReport.all_info.Lines.Add('���:'+ FNetConnection.Address+ '->�û�:'+
          FNetConnection.UserName+'.����:'+FNetConnection.PassWord+'-------------[�ɹ�]');
    frmReport.ok_info.Lines.Add('����:['+FNetConnection.Address+'] �û�:['+
          FNetConnection.UserName+'] ����:['+FNetConnection.PassWord+']');
  end else
  begin
    frmReport.all_info.Lines.Add('���:'+FNetConnection.Address+'->�û�:'+
        FNetConnection.UserName+'->����:'+FNetConnection.PassWord+'-------------[ʧ��:'+IntToStr(state)+']');
    if (frmReport.all_info.Lines.Count>500) then
    begin
      frmReport.all_info.Lines.Clear;
    end;
 end;
 frmReport.Edit9.Text := IntToStr(StrToInt(frmReport.Edit9.Text)+1);

end;

end.

