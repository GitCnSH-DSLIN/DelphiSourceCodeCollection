unit function_1;

interface

uses  Windows, Classes, SysUtils, SyncObjs, StdCtrls, Dialogs, winsock, ping, forms,
  Controls;

const
  conSymbol = '~ !@#$%^&*(){}[],.?/;+-';
  conNeedCarry = #1;
  conNoCarry = #0;

var
  //ȫ�ֱ���
  Version : integer  = 98;//�汾����

  ping_ip_start : LongWord;
  ping_ip_stop : LongWord;//��ʼ,������ip

  cur_ip: integer;//�ѹ�����ip��
  ping_thread_no: integer=0;//ping�߳�����,
  share_thread_no: integer=0;//share�߳�����
  share_ip_no: integer=0;//share������λ��ָʾ
  scan_thread_no: integer=0;//scan�߳�����
  scan_port_ip: integer=0;//scan��ǰ��IP
  scan_port_no: integer=0;//scan��ǰ�Ķ˿ں�
  thread_type: integer=0;//ָ����ǰ�˵��߳���ɶ����
  pass_no: integer=0;//�����ڶ������λ��

  thread_run: Boolean=false;//��ֹ�߳�
  only_ping: Boolean=true;
  lookup_name: Boolean=false;//��������
  lookup_user: Boolean=true;//�����û���Ϣ
  lookup_system: Boolean=false;//����ϵͳ��Ϣ
  lookup_Services: Boolean=false;//����ϵͳ��Ϣ
  do_select: Boolean=false;//�Ƿ�ֻ��ѡ��Ĺ���
  report_show: Boolean=false;//ָʾreport_f�����Ƿ���ʾ
  const_pass: Boolean=true;//�Ƿ�ʹ���ڶ�����

  main_list :TStringList;//���õ�IP��ַ�б�(����Ϊ:ItemsId��IP),
  port_lists:TStringList;//���ö˿��б�
  ping_CriticalSection : TCriticalSection;//ȫ���ٽ����
  strPassStore : String;

procedure creat_share_pass;//�ҹ��������߳�
procedure creat_share; //�ҹ�����Ϣ�߳�
procedure creat_ping(number: integer);
procedure creat_scan_ping(number: integer);
procedure creat_scan_port(number: integer);//ɨ��˿��߳�
procedure get_port_list;
procedure creat_sql_ping(number: integer);
procedure creat_sql_pass;//���SQL������
procedure init_frmMain;//��ʼ������
procedure save_frmMain;//���洰��Ĳ���
procedure creat_pop3_scan(number: integer);//�����������
procedure creat_pop3_detect;//�������

function iptostr(ip : LongWord): AnsiString;
function NameToPass(var str: AnsiString;var i: integer): AnsiString;//������������Ӧ�ĳ�������;
function gethostbyip(ip : AnsiString) : AnsiString;
function get_intstr(var str : AnsiString) : AnsiString;//ȡ���ֲ���
function check_ip(str : AnsiString): Boolean;
function strtoip(str : AnsiString): LongWord;

function LookupService(const Service: string): Integer;
function LookupName(const Name: string): string;
procedure RunDosCommand(Command : string; Output : TStrings);
function ReplaceStr(const S, Srch, Replace: string): string;
function DelSpace(const S: String): string;
function DelChars(const S: string; Chr: Char): string;
function intFloor(const X: Extended): Integer;

implementation

uses dict, thread_share,main,thread_ping,thread_scan_ping,
     thread_scan_port, thread_sql_ping,thread_sql_pass,share_pass,
     pop3_scan,pop3_detect,report;

function LookupName(const Name: string): string;
var
  sa: TInAddr;
  aHost: PHostEnt;
begin
  aHost := gethostbyname(PChar(Name));
  FillChar(sa, SizeOf(TInAddr), 0);
  if aHost <> nil then
  begin
    sa.S_addr :=   Dword((@aHost^.h_addr^[0])^);
    Result := IntToStr(Ord(sa.S_un_b.s_b1))+ '.'+ IntToStr(Ord(sa.S_un_b.s_b2))+ '.'+ IntToStr(Ord(sa.S_un_b.s_b3)) + '.' + IntToStr(Ord(sa.S_un_b.s_b4));
  end else Result := '[��֪��]'
end;

function LookupService(const Service: string): Integer;
var
  ServEnt: PServEnt;
begin
  ServEnt := getservbyname(PChar(Service), 'tcp');
  if ServEnt <> nil then
    Result := ntohs(ServEnt.s_port)
  else Result := 0;
end;

//------------------------------------------------------------------------
procedure RunDosCommand(Command : string; Output : TStrings);
var
  hReadPipe : THandle;
  hWritePipe : THandle;
  SI : TStartUpInfo;
  PI : TProcessInformation;
  SA : TSecurityAttributes;
//  SD : TSecurityDescriptor;
  BytesRead : DWORD;
  Dest : array[0..1023] of char;
  CmdLine : array[0..512] of char;
  TmpList : TStringList;
  Avail, ExitCode, wrResult : DWORD;
  osVer : TOSVERSIONINFO;
  tmpstr :AnsiString;
begin
  osVer.dwOSVersionInfoSize := Sizeof(TOSVERSIONINFO);
  GetVersionEX(osVer);

  if osVer.dwPlatformId = VER_PLATFORM_WIN32_NT then
  begin
//    InitializeSecurityDescriptor(@SD, SECURITY_DESCRIPTOR_REVISION);
//    SetSecurityDescriptorDacl(@SD, True, nil, False);
    SA.nLength := SizeOf(SA);
    SA.lpSecurityDescriptor := nil;//@SD;
    SA.bInheritHandle := True;
    CreatePipe(hReadPipe, hWritePipe, @SA, 0);
  end
  else
    CreatePipe(hReadPipe, hWritePipe, nil, 1024);
  try
    Screen.Cursor := crHourglass;
    FillChar(SI, SizeOf(SI), 0);
    SI.cb := SizeOf(TStartUpInfo);
    SI.wShowWindow := SW_HIDE;
    SI.dwFlags := STARTF_USESHOWWINDOW;
    SI.dwFlags := SI.dwFlags or STARTF_USESTDHANDLES;
    SI.hStdOutput := hWritePipe;
    SI.hStdError := hWritePipe;
    StrPCopy(CmdLine, Command);
    if CreateProcess(nil, CmdLine, nil, nil, True, NORMAL_PRIORITY_CLASS, nil, nil, SI, PI) then
    begin
       ExitCode := 0;
       while ExitCode = 0 do
       begin
          wrResult := WaitForSingleObject(PI.hProcess, 500);
//        if PeekNamedPipe(hReadPipe, nil, 0, nil, @Avail, nil) then
          if PeekNamedPipe(hReadPipe, @Dest[0], 1024,  @Avail, nil, nil) then
          begin
             if Avail > 0 then
             begin
               TmpList := TStringList.Create;
               try
                 FillChar(Dest, SizeOf(Dest), 0);
                 ReadFile(hReadPipe, Dest[0], Avail, BytesRead, nil);
                 TmpStr := Copy(Dest,0 , BytesRead-1);
                 TmpList.Text := TmpStr;
                 Output.AddStrings(TmpList);
               finally
                 TmpList.Free;
               end;
             end;
          end;
            if wrResult <> WAIT_TIMEOUT then ExitCode := 1;
       end;
       GetExitCodeProcess(PI.hProcess, ExitCode);
       CloseHandle(PI.hProcess);
       CloseHandle(PI.hThread);
     end;
     finally
       CloseHandle(hReadPipe);
       CloseHandle(hWritePipe);
       Screen.Cursor := crDefault;
   end;
end;

function ReplaceStr(const S, Srch, Replace: string): string;
var
  I: Integer;
  Source: string;
begin
  Source := S;
  Result := '';
  repeat
    I := Pos(Srch, Source);
    if I > 0 then begin
      Result := Result + Copy(Source, 1, I - 1) + Replace;
      Source := Copy(Source, I + Length(Srch), MaxInt);
    end
    else Result := Result + Source;
  until I <= 0;
end;

function DelSpace(const S: String): string;
begin
  Result := DelChars(S, ' ');
end;

function DelChars(const S: string; Chr: Char): string;
var
  I: Integer;
begin
  Result := S;
  for I := Length(Result) downto 1 do begin
    if Result[I] = Chr then Delete(Result, I, 1);
  end;
end;

function intFloor(const X: Extended): Integer;
begin
  Result := Integer(Trunc(X));
  if Frac(X) < 0 then
    Result:= Result -1 ;
end;

//------------------------------------------------------------------------
procedure creat_ping(number: integer);
var
  bubble: Tmy_thread1;
  i : integer;
  temp_ping : TPing;
begin
 ping_thread_no:=0;//ping�߳�����
 frmMain.Edit10.Text:='0';
 share_thread_no:=0;

 for i:=0 to number-1 do
 begin
   temp_ping:= TPing.Create(frmMain);
//  temp_ping.OnEchoReply=Form1.Ping1.OnEchoReply;
   temp_ping.Tag:=100;
   temp_ping.Timeout:=StrToInt(frmMain.Edit12.Text);
   bubble := Tmy_thread1.Create(temp_ping,false);
 end;
end;
//------------------------------------------------------------------------

procedure creat_scan_ping(number: integer);
var
  bubble: Tmy_scan_ping;
  i : integer;
begin
  ping_thread_no:=0;//ping�߳�����
  cur_ip:=0;
  scan_port_ip:=0;
  scan_port_no:=0;
  scan_thread_no:=0;

  main_list.Clear;//�����ǰ������
  get_port_list; //��ȡ�����б�

  frmMain.Bar.Max:=(integer(ping_ip_stop-ping_ip_start))*port_lists.Count;
  if (frmMain.Bar.Max=0) then
     frmMain.Bar.Max:=ping_ip_stop-ping_ip_start;
  for i:=0 to number-1 do
  begin
    bubble := Tmy_scan_ping.Create(false);
  end;
end;

//------------------------------------------------------------------------
procedure creat_scan_port(number: integer);
var
  i : integer;
  bubble : Tmy_scan_port;
begin

 if (port_lists.Count <= 0 )then exit;

 for i:=0 to number-1 do
   if ((scan_thread_no < StrToInt(frmMain.Edit26.Text)) and
       (scan_port_ip < main_list.Count)) then
   begin
     bubble := Tmy_scan_port.Create(false);
   end;
end;
//------------------------------------------------------------------------

procedure creat_sql_ping(number: integer);
var
  i : integer;
  bubble : Tmy_sql_ping;
begin
  ping_thread_no:=0;//ping�߳�����
  cur_ip:=0;

  for i:=0 to number-1 do
  begin
    bubble := Tmy_sql_ping.Create(false);
  end;
end;

//------------------------------------------------------------------------
procedure creat_share;
var
  bubble : myThread_share;
begin
 if ((share_thread_no<StrToInt(frmMain.Edit15.Text))and
    (share_ip_no<frmMain.tree_ping.Items.Count)) then
  begin
   bubble := myThread_share.Create(false);
  end;
end;
//------------------------------------------------------------------------

//�ҹ��������߳�
procedure creat_share_pass;
var
  bubble : tshare_pass;
begin
  bubble := tshare_pass.Create(false);
end;
//------------------------------------------------------------------------

procedure creat_sql_pass;//���SQL������
var
  bubble : Tsql_pass;
begin
  bubble := Tsql_pass.Create(false);
end;
//------------------------------------------------------------------------

function check_ip(str : AnsiString): Boolean;
begin
  if (inet_addr(pchar(str))=-1)then
   begin
     ShowMessage('�Ƿ���IP��ַ!');
     Result := false;
   end else Result := true;

end;

//------------------------------------------------------------------------
procedure creat_pop3_scan(number: integer);//�����������
var
  i : integer;
  bubble : TPop3_scan;
begin
  for i:=0 to number-1 do
  begin
    if (ping_thread_no < StrToInt(frmMain.Edit45.Text)) then
    begin
      bubble := TPop3_scan.Create(false);
    end else break;
  end;
end;
//------------------------------------------------------------------------

procedure creat_pop3_detect;//�������
var
  bubble : TPop3_Detect;
  i : integer;
begin
  for i:=0 to StrToInt(frmMain.Edit47.Text) -1 do
  begin
    if (share_thread_no < StrToInt(frmMain.Edit47.Text)) then
    begin
      bubble := TPop3_Detect.Create(false);
    end else break;
  end;
end;

//------------------------------------------------------------------------
//��XXX.XXX.XXX.XXX��ʽ���ַ����ֽ��IP����
function strtoip(str : AnsiString ) : Longword;
var
  f_ip : Longword;
  temp : AnsiString;
begin
//  f_ip := inet_addr(pchar(str));
  temp := str;
    f_ip := StrToInt(Copy(temp,1,AnsiPos('.', temp)-1))*256*256*256;
//  f_ip := StrToInt(temp.SubString(1,temp.AnsiPos('.')-1))*256*256*256;
  Delete(temp, 1, AnsiPos('.', temp));
  f_ip := f_ip+StrToInt(Copy(temp, 1, AnsiPos('.', temp)-1))*256*256;
  Delete(temp, 1,AnsiPos('.', temp));
  f_ip := f_ip+StrToInt(Copy(temp, 1, AnsiPos('.', temp)-1))*256;
  Delete(temp, 1, AnsiPos('.', temp));
  f_ip := f_ip+StrToInt(temp);
  Result := f_ip;
end;

//------------------------------------------------------------------------
function iptostr(ip : LongWord): AnsiString;
var
  temp : AnsiString;
  i : LongWord;
  f : integer;
begin
  temp := '';
  i := ip;
  f := intFloor(i/(256*256*256));
  if ((f<0)or(f>255)) then begin ShowMessage('IPת������!');Result := '';end;
  temp := IntToStr(f)+'.';
  i:=i-f*(256*256*256);
  f:= intFloor(i/(256*256));
  if ((f<0)or(f>255)) then begin ShowMessage('IPת������!');Result := ''; end;
  temp:=temp+IntToStr(f)+'.';
  i:=i-f*(256*256);
  f:= intFloor(i/256);
  if ((f<0)or(f>255)) then begin ShowMessage('IPת������!'); Result := '';end;
  temp:=temp+IntToStr(f)+'.';
  i:=i-f*256;
  if ((i<0)or(i>255)) then begin ShowMessage('IPת������!'); Result := ''; end;
  temp:= temp+IntToStr(i);

  Result := temp;
end;

//------------------------------------------------------------------------
function gethostbyip(ip : AnsiString) : AnsiString;
var
  addr : sockaddr_in;
  host : Phostent;
begin
   addr.sin_addr.s_addr := inet_addr(pchar(ip));
   host := gethostbyaddr(pchar(@addr.sin_addr),4,AF_INET);
   if (host = nil) then
    Result := '[��֪]'
    else
    Result := host^.h_name;
end;

//------------------------------------------------------------------------
//ȡ���ֲ���
function get_intstr(var str : AnsiString) : AnsiString;
var
  i : integer;
begin
  i:=1;
  while (i <= Length(str))do
  begin
    if ((str[i]>='0') and (str[i]<='9')) then
       inc(i)
      else break;
  end;
  result := Copy(str,1, i-1);
end;

//------------------------------------------------------------------------
procedure get_port_list;
var
  i,start,stop,temp : integer;
  str,str1 : AnsiString;
begin
    i:=0;
    start:=StrToInt(frmMain.port_start.Text);
    stop:=StrToInt(frmMain.port_stop.Text);
    if (start>stop)then begin temp:=start;start:=stop;stop:=temp;end;

    port_lists.Clear;
    if (frmMain.port_option.Text='') then
    begin
      for i:=0 to frmMain.port_list.Items.Count-1 do
      begin
         if (frmMain.port_list.Checked[i]) then
           port_lists.Add(frmMain.port_list.Items.Strings[i]);
      end;
    end else
    case  frmMain.port_option.Text[1] of
      '1': port_lists.AddStrings(frmMain.port_list.Items);
      '2': for i:=0 to frmMain.port_list.Items.Count -1 do
           begin
             if (frmMain.port_list.Checked[i]) then
               port_lists.Add(frmMain.port_list.Items.Strings[i]);
           end;
      '3': while(i<frmMain.port_list.Items.Count)do
           begin
             str1 := frmMain.port_list.Items.Strings[i];
             temp := StrToInt(get_intstr(str1));
             if ((temp>=start) and (temp<=stop)) then
                port_lists.Add(frmMain.port_list.Items.Strings[i]);
             inc(i);
           end;
      '4': begin
             if (start>stop) then begin temp := start;start:=stop;stop:=temp;end;
             for i:=start to stop-1 do
             begin
               port_lists.Add(IntToStr(i));
             end;

             i:=0;
             while(i<frmMain.port_list.Items.Count) do
             begin
               str1 := frmMain.port_list.Items.Strings[i];
               str:=Trim(get_intstr(str1));
               start:=StrToInt(str);
               if (start>stop) then break;
               temp := port_lists.IndexOf(str);
               if (temp <> -1) then
                  port_lists.Strings[temp]:=frmMain.port_list.Items.Strings[i];
               inc(i);
             end;
           end;
      else
           for i:=0 to frmMain.port_list.Items.Count-1 do
           begin
              if (frmMain.port_list.Checked[i]) then
                port_lists.Add(frmMain.port_list.Items.Strings[i]);
           end;

    end;
end;

//------------------------------------------------------------------------
procedure init_frmMain;//��ʼ������
var
  str : AnsiString;
  com : TComponent;
  list : TStringList;
  i : integer;
begin
  str:=ChangeFileExt(ParamStr(0), '.INI');
  if (FileExists(str)) then
  begin
    list:= TStringList.Create;
   list.LoadFromFile(str);
   for i:=0 to list.Count-1 do
   begin
     str:=list.Strings[i];
     com:=frmMain.FindComponent(copy(str,1,(Pos('=',str)-1)));
     str:=list.Strings[i];
     if (com <> nil)then
     begin
        if AnsiString(com.ClassName)='TEdit' then
        begin
          Delete(str, 1,Pos('=',str));
          (TEdit(com)).Text := str;
        end
        else
          if (AnsiString(com.ClassName)='TMemo')then
          begin
            Delete(str, 1,Pos('=',str));
            (TMemo(com)).Lines.CommaText:= str;
          end
          else
          if (AnsiString(com.ClassName)='TCheckBox') then
          begin
            Delete(str,1,Pos('=',str));
            (TCheckBox(com)).Checked:= (str='true');
          end;
     end;
   end;
   list.Free;
  end;
end;

//------------------------------------------------------------------------
procedure save_frmMain;//���洰��Ĳ���
var
  str : AnsiString;
  com : TComponent;
  i : integer;
  list : TStringList;
begin
  list := TStringList.Create;
  for i:=0 to frmMain.ComponentCount-1 do
  begin
    str:='';
    if AnsiString(frmMain.Components[i].ClassName)='TEdit' then
       begin
        if  not (TEdit(frmMain.Components[i])).ReadOnly then
         str:=frmMain.Components[i].Name+ '=' + (TEdit(frmMain.Components[i])).Text;
       end
       else
       if AnsiString(frmMain.Components[i].ClassName)='TMemo' then
       begin
         if  not (TMemo(frmMain.Components[i])).ReadOnly then
           str:=frmMain.Components[i].Name+'='+(TMemo(frmMain.Components[i])).Lines.CommaText;
         end else
         if AnsiString(frmMain.Components[i].ClassName)='TCheckBox' then
           if (TCheckBox(frmMain.Components[i])).Checked then
             str:=frmMain.Components[i].Name+'=true'
           else str:=frmMain.Components[i].Name+'=false';
         if (str <> '') then list.Add(str);
       end;
  list.SaveToFile(ChangeFileExt(ParamStr(0), '.INI'));
  list.Free;
end;


//�ӳ��õ�����������Ĺ�ϵ��������
function  ABCToCBA(str: AnsiString): AnsiString;
var
  temp_str : AnsiString ;
  i,len : integer;
begin
  temp_str := str;
  len := Length(Str);
  for i:=1 to len do
  begin
    temp_str[i] := str[len+1-i];
  end;
  Result := temp_str;
end;

function NameToPass(var str: AnsiString;var i: integer): AnsiString;//������������Ӧ�ĳ�������;
var
  temp_str : AnsiString;
begin
  temp_str := ABCToCBA(str);//ȡ��
  inc(i);
  case i of
    1: result := str;// ��������ͬ
    2: result := temp_str;//�����෴
    3: result := str+temp_str;//����+�෴
    4: result := str+str;//����+����
    5: result := str+'123';//����+123
    6: result := str+'12345';//����+123345
    7: result := '123';
    8: result := '1234';
    9: result := '12345';
    10: result:= '123456';
    11: result:= '1234567';
    12: result:= '12345678';
    13: result:= '8888';
    14: result:= '88888888';
    15: begin
          temp_str := str;
          temp_str[1]:= UpCase(temp_str[1]);
          result := UpperCase(str+temp_str);//���Ƶ�һ����д
        end;
    16: result:='1111';
    17: result:='11111';
    18: result:='111111';
    19: result:='11111111';
    20: result:='0000';
    21: result:='00000000';
    22: result:='aaaa';
    23: result:='aaaaaaaa';
    else result := '';
  end;
end;
//test��,������һ����ʲô������
function NameToPass3(str : AnsiString; var i : integer) : AnsiString;
var
  test_str, temp_str : AnsiString;
begin
 test_str := ' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~!@#$%^&*(){}[],.?/;+-';
 inc(i);
 if i>Length(test_str) then
  result := ''
  else begin
   temp_str := test_str[i];
   result := temp_str + temp_str + temp_str + temp_str;
  end;
end;

//test��,������һ����ʲô������
function NameToPass2(str: AnsiString; var i : integer) : AnsiString;
var
  test_str, temp_str : AnsiString;
begin
 test_str := ' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~!@#$%^&*(){}[],.?/;+-';
 inc(i);

 if i> Length(test_str) then
  result := ''
  else begin
   temp_str := test_str[i];
   result := temp_str+temp_str+temp_str+temp_str+temp_str+temp_str+temp_str+temp_str;
  end;
end;

end.
