unit u_public;


interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, DBGrids, DBClient, DB, Registry, winsock;
type
  TCurrentParam = record
    userAliasName: string;
    LoginTime: string;
    Host: string;
    IP: string;
    userBH: string;
    userName: string;
    userZH: string;
  end;
//=====
function ShowMDIForm(aFormClass: TFormClass): TForm;

//===
procedure ShowModalForm(aFormClass: TFormClass);

//==
procedure DbGridSort(dbgrid: TDBGrid; Column: TColumn);

//===
function ConnectAppServ: boolean;

//==
function GetComputerName: string;

//==
function GetComputerIP: string;

//===����¼�봰�ڣ��õ�ְ��������
function GetEmployeeName: string;


//==����¼�봰�ڣ��õ���������
function GetDeptName: string;

//==����¼�봰�ڣ��õ�������Ŀ����
function GetProjectName: string;

var
  CurrentParam: TCurrentParam;
  psIndexName: string; //
  plAscend: Boolean;
implementation

uses main, WzglDB;

function showMDIForm(aFormClass: TFormClass): TForm;
begin
{  frmMain.statusbar1.Panels[0].text := '���ڴ򿪴���,���Ժ�...';
  frmMain.statusbar1.refresh;
  screen.Cursor := crHourGlass;
  lockwindowupdate(frmMain.handle);
  result := aFormClass.Create(Application);
  with result do
  begin
    WindowState := wsMaximized;
    frmMain.statusbar1.Panels[0].text := '';
    frmMain.statusbar1.refresh;
    show;
    lockwindowupdate(0);
    screen.Cursor := crDefault;
  end;     }
end;

procedure ShowModalForm(aFormClass: TFormClass);
begin
{  frmMain.statusbar1.Panels[0].text := '���ڴ򿪴���,���Ժ�...';
  frmMain.statusbar1.refresh;
  screen.Cursor := crHourGlass;
  with aFormClass.Create(Application) do
  begin
    frmMain.statusbar1.Panels[0].text := '';
    frmMain.statusbar1.refresh;
    screen.Cursor := crDefault;
    try
      showModal;
    finally
      free;
    end;
  end;   }
end;

function ConnectAppServ: boolean; //�ж��Ƿ���������Ӧ�÷�����
var
  vs_Host, vs_Address, vs_Port: string;
  reg: TRegistry;
begin
{  Result := True;
  reg := Tregistry.create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  frmMain.SocketConnection.Connected := false;
  //��ȡע������õ�Ӧ�÷�������Ϣ
  if Reg.OpenKey('\Software\���ʹ���', False) then
  begin
    vs_Host := reg.ReadString('Host');
    vs_Address := reg.ReadString('Address');
    vs_Port := reg.readstring('Port');
    try
      //��������
      with frmMain do
      begin
        SocketConnection.Address := vs_Address;
        SocketConnection.Host := vs_Host;
        SocketConnection.Port := strtoint(vs_Port);
        SocketConnection.Connected := true;
      end;
      reg.closekey;
    except //δ�����ϣ��������ô���
      reg.closekey;
      if not LjszExecute(TfrmLjsz) then
        Result := False;
    end;
  end
  else
  begin
    if not LjszExecute(TfrmLjsz) then //���û��ע����Ϣ���������ô���
      Result := False;
  end;    }
end;


procedure DbGridSort(dbgrid: TDBGrid; Column: TColumn);
var
//��ģ��ʹ�õ���psIndexName, plAscend�����������϶���
  mode: char; //��¼�ǡ����򡱻��ǡ�����
  ColName: string; //��¼��ǰ�ֶ���
  iCol: Integer; //��¼��ǰ�к�
begin
  with dbgrid.DataSource.DataSet as Tclientdataset do //Table0
  begin
//��⵱ǰ�������Ƿ��Ѵ�
    if not Active
      then begin
      Application.MessageBox('��������δ�򿪣�', 'ֹͣ', MB_OK + MB_ICONSTOP);
      Abort
    end;
//��⵱ǰ�ֶ��Ƿ������򡱡������ֶ����Ͳ�������
    case Column.Field.DataType of
      ftBoolean,
        ftBytes,
        ftBlob, //Binary
        ftMemo,
        ftGraphic,
        ftFmtMemo, //Formatted memo
        ftParadoxOle: //OLE
        begin
          Abort
        end;
    end; //case
    mode := '0';
    iCol := Column.Field.FieldNo - 1;
    try
      ColName := Column.fieldname;
      if psIndexName = Column.fieldname then
      begin //��ԭ��ͬ��
        if plAscend //����
          then begin
          mode := '2';
          IndexName := ColName + '2'; //Ӧ������
        end
        else begin
          mode := '1';
          IndexName := ColName + '1'; //Ӧ������
        end;
        plAscend := not plAscend;
      end
      else begin //����
        IndexName := ColName + '2';
        plAscend := false;
        psIndexName := ColName;
      end;
    except
      on EDatabaseError do //��δ�������������½���
      begin
//�����½�����
        IndexName := '';
        if mode = '1'
          then AddIndex(ColName + '1', ColName, [], '', '', 0) //
        else //����'0'
          AddIndex(ColName + '2', ColName, [ixDescending], '', '', 0);
        try //try 1
          if mode <> '1'
            then begin
            mode := '2'; //ת��
            plAscend := false;
          end
          else plAscend := true;
          IndexName := ColName + mode;
          psIndexName := ColName;
        except
          IndexName := '';
        end //try 2
      end
    end;
    first;
  end; //with
  dbgrid.SelectedIndex := iCol;
end;


{��ȡ���ؼ����������}

function GetComputerName: string;
var
  pcComputer: PChar;
  dwCSize: DWORD;
begin
  dwCSize := MAX_COMPUTERNAME_LENGTH + 1;
  result := '';
  GetMem(pcComputer, dwCSize);
  try
    if Windows.GetComputerName(pcComputer, dwCSize) then
      Result := pcComputer;
  finally
    FreeMem(pcComputer);
  end;
end;

///////////////��ȡ���ؼ������IP��ַ

function GetComputerIP: string;
var
  ch: array[1..32] of Char;
  i: Integer;
  WSData: TWSAData;
  MyHost: PHostEnt;
  S_IP: string;
begin
  if WSAstartup(2, wsdata) <> 0 then
    EXIT;
  if getHostName(@ch[1], 32) <> 0 then
    EXIT;
  MyHost := GetHostByName(@ch[1]);
  if MyHost = nil then
    EXIT
  else
  begin
    for i := 1 to 4 do
    begin
      S_IP := S_IP + inttostr(Ord(MyHost.h_addr^[i - 1]));
      if i < 4 then
        S_IP := S_IP + '.';
    end;
  end;
  RESULT := S_IP;
end;
/////////////

//===����¼�봰�ڣ��õ�ְ��������

function GetEmployeeName: string;
begin
{  //����TfrmZgda_fzlr�������
  with TfrmZgda_fzlr.Create(Application) do
  begin
    pub_zgxm := '';
    try
      //ģʽ��ʾ����
      showModal;
    finally
      free;
    end;
    result := pub_zgxm;
  end;    }
end;


//===����¼�봰�ڣ��õ����ŵ�����

function GetDeptName: string;
begin
{  with TfrmBmda_fzlr.Create(Application) do
  begin
    pub_Bmmc := '';
    try
      showModal;
    finally
      free;
    end;
    result := pub_Bmmc;
  end;    }
end;

//==����¼�봰�ڣ��õ�������Ŀ����

function GetProjectName: string;
begin
 { with TfrmGcxmdy_fzlr.Create(Application) do
  begin
    pub_Gcxmmc := '';
    try
      showModal;
    finally
      free;
    end;
    result := pub_Gcxmmc;
  end;    }
end;


end.

