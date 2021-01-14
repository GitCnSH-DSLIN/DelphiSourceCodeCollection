unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, IdFTP, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdHTTPHeaderInfo, ExtCtrls;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    ProgressBar1: TProgressBar;
    Button2: TButton;
    IdHTTP1: TIdHTTP;
    IdFTP1: TIdFTP;
    Button3: TButton;
    ComboBox1: TComboBox;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure IdHTTP1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure Button3Click(Sender: TObject);
  private
    AbortTransfer: Boolean; //�Ƿ��ж�
    BytesToTransfer: LongWord; //�����ܴ�С
    procedure FtpDownLoad(aURL, aFile: string; bResume: Boolean);
    procedure HttpDownLoad(aURL, aFile: string; bResume: Boolean);
    procedure MyDownLoad(aURL, aFile: string; bResume: Boolean);
    function GetProt(aURL: string): Byte;
    function GetURLFileName(aURL: string): string;
    procedure GetFTPParams(aURL: string; var sName, sPass, sHost, sPort,
      sDir: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

var
  AverageSpeed: Double = 0;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
begin
  AbortTransfer := True;
end;

function TForm1.GetProt(aURL: string): Byte;
begin //������صĵ�ַ��http����ftp
  Result := 0;
  if Pos('http', LowerCase(aURL)) = 1 then
    Result := 1; //httpЭ��
  if Pos('ftp', LowerCase(aURL)) = 1 then
    Result := 2; //ftpЭ��
end;

function TForm1.GetURLFileName(aURL: string): string;
var
  i: integer;
  s: string;
begin //�������ص�ַ���ļ���
  s := aURL;
  i := Pos('/', s);
  while i <> 0 do //ȥ��"/"ǰ�������ʣ�µľ����ļ�����
  begin
    Delete(s, 1, i);
    i := Pos('/', s);
  end;
  Result := s;
end;

procedure TForm1.GetFTPParams(aURL: string; var sName, sPass, sHost, sPort, sDir: string);
var
  i, j: integer;
  s, tmp: string;
begin //����ftp��ַ�ĵ�½�û����������Ŀ¼
  s := aURL;
  if Pos('ftp://', LowerCase(s)) <> 0 then //ȥ��ftpͷ
    Delete(s, 1, 6);
  i := Pos('@', s);
  if i <> 0 then //��ַ���û�����Ҳ���ܺ�����
  begin
    tmp := Copy(s, 1, i - 1);
    s := copy(s, i+1, Length(s));
    j := Pos(':', tmp);
    if j <> 0 then //��������
    begin
      sName := Copy(tmp, 1, j - 1); //�õ��û���
      sPass := Copy(tmp, j + 1, i - j - 1); //�õ�����
    end else
    begin
      sName := tmp;
      sPass := Inputbox('�����','�������½ftp����','');
    end;
  end else //�����û�
  begin
    sName := 'anonymous';
    sPass := 'test@ftp.com';
  end;
  i := Pos(':', s);
  j := Pos('/', s);
  sHost := Copy(s, 1, j - 1); //����
  if i <> 0 then //���˿�
    sPort := Copy(s, i + 1, j - i - 1) else
    sPort := '21'; //Ĭ��21�˿�

  tmp := Copy(s, j + 1, Length(s));
  while j <> 0 do
  begin
    Delete(s, 1, j);
    j := Pos('/', s);
  end; //Ŀ¼
  sDir := '/' + Copy(tmp, 1, Length(tmp) - Length(s) - 1);
end;

procedure TForm1.FtpDownLoad(aURL, aFile: string; bResume: Boolean);
var
  tStream: TFileStream;
  sName, sPass, sHost, sPort, sDir: string;
begin //ftp��ʽ����
  if FileExists(aFile) then //�����ļ���
    tStream := TFileStream.Create(aFile, fmOpenWrite) else
    tStream := TFileStream.Create(aFile, fmCreate);

  GetFTPParams(aURL, sName, sPass, sHost, sPort, sDir);
  with IdFTP1 do
  try
    if Connected then Disconnect; //��������
    Username := sName;
    Password := sPass;
    Host := sHost;
    Port := StrToInt(sPort);
    Connect;
  except
    exit;
  end;

  IdFTP1.ChangeDir(sDir); //�ı�Ŀ¼
  BytesToTransfer := IdFTP1.Size(aFile);
  try
    if bResume then //����
    begin
      tStream.Position := tStream.Size;
      IdFTP1.Get(aFile, tStream, True);
    end else
    begin
      IdFTP1.Get(aFile, tStream, False);
    end;
  finally
    tStream.Free;
  end;
end;

procedure TForm1.HttpDownLoad(aURL, aFile: string; bResume: Boolean);
var
  tStream: TFileStream;
begin //Http��ʽ����
  if FileExists(aFile) then //����ļ��Ѿ�����
    tStream := TFileStream.Create(aFile, fmOpenWrite) else
    tStream := TFileStream.Create(aFile, fmCreate);

  if bResume then //������ʽ
  begin
    IdHTTP1.Request.ContentRangeStart := tStream.Size - 1;
    tStream.Position := tStream.Size - 1; //�ƶ�������������
    IdHTTP1.Head(aURL);
    IdHTTP1.Request.ContentRangeEnd := IdHTTP1.Response.ContentLength;
  end else //���ǻ��½���ʽ
  begin
    IdHTTP1.Request.ContentRangeStart := 0;
  end;

  try
    IdHTTP1.Get(aURL, tStream); //��ʼ����
  finally
    tStream.Free;
  end;
end;

procedure TForm1.MyDownLoad(aURL, aFile: string; bResume: Boolean);
begin
  case GetProt(aURL) of
    0: ShowMessage('����ʶ��ĵ�ַ��');
    1: HttpDownLoad(aURL, aFile, bResume);
    2: FtpDownLoad(aURL, aFile, bResume);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  aURL, aFile: string;
begin
  aURL := ComboBox1.Text; //���ص�ַ������"http://www.2ccc.com/update/demo.exe"
  aFile := GetURLFileName(aURL); //�õ��ļ���������"demo.exe"
  if FileExists(aFile) then
  begin
    case MessageDlg('�ļ��Ѿ����ڣ��Ƿ�������', mtConfirmation, mbYesNoCancel, 0) of
      mrYes: MyDownLoad(aURL, aFile, True); //����
      mrNo: MyDownLoad(aURL, aFile, False); //����
      mrCancel: Exit; //ȡ��
    end;
  end else MyDownLoad(aURL, aFile, False); //�������ļ�����
end;

procedure TForm1.IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
  if AbortTransfer then
  begin //�ж�����
    IdHTTP1.Disconnect;
    IdFTP1.Abort;
  end;
  ProgressBar1.Position := AWorkCount;
  Application.ProcessMessages;
end;

procedure TForm1.IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: Integer);
begin
  AbortTransfer := False;
  if AWorkCountMax > 0 then
    ProgressBar1.Max := AWorkCountMax else
    ProgressBar1.Max := BytesToTransfer;
end;

procedure TForm1.IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
  ProgressBar1.Position := 0;
end;

procedure TForm1.IdHTTP1Status(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
  ListBox1.ItemIndex := ListBox1.Items.Add(AStatusText);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Close;
end;

end.

