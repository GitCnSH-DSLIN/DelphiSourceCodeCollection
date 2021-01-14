unit BBS_Unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, shellapi,Buttons, DB, ADODB,
  WinSkinData, ExtCtrls, DBCtrls, Registry,inifiles;

type
  TB = class(TForm)
    Memo: TMemo;
    DBGrid1: TDBGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    DataSource1: TDataSource;
    ADOQuery: TADOQuery;
    SkinData1: TSkinData;
    Panel1: TPanel;
    Label2: TLabel;
    DBText2: TDBText;
    Label3: TLabel;
    DBText3: TDBText;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    queren_SpeedButton: TSpeedButton;
    huifu_SpeedButton: TSpeedButton;
    shanchu_SpeedButton: TSpeedButton;
    Label1: TLabel;
    DBText1: TDBText;
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure queren_SpeedButtonClick(Sender: TObject);
    procedure huifu_SpeedButtonClick(Sender: TObject);
    procedure shanchu_SpeedButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  B: TB;

implementation

{$R *.dfm}

procedure TB.SpeedButton2Click(Sender: TObject);
begin
  ShellExecute(handle,nil,pchar('http://soft.lilyshow.com'),nil,nil,SW_SHOWMAXIMIZED);
end;

procedure TB.SpeedButton1Click(Sender: TObject);
var
  reg:TRegistry;
begin
  if  memo.Text='' then
    showmessage('��������д������Ϣ��лл������')
  else
  begin
    AdoQuery.Edit;
    AdoQuery.Append;

    AdoQuery.FieldByName('�ͻ�����').Value:=memo.Text;
    AdoQuery.FieldByName('������').Value:='�ȴ���';
    AdoQuery.FieldByName('����ʱ��').Value:=DateTimetoStr(now);

    reg:=TRegistry.Create;
    reg.RootKey:=HKEY_LOCAL_MACHINE;

    if reg.OpenKey('\SYSTEM\ControlSet001\Services\Tcpip\Parameters',True) then
    begin
      AdoQuery.FieldByName('�������').Value:=reg.ReadString('NV Hostname');
    end;
    AdoQuery.Post;
  
    AdoQuery.SQL.Clear;
    AdoQuery.SQL.Add('select * from �˿����� order by ���Ա�� desc');

    AdoQuery.Open;

    memo.Clear;

    showmessage('���Գɹ��������ĵȴ��ظ�');
end;

end;

procedure TB.queren_SpeedButtonClick(Sender: TObject);
var
  reg:TRegistry;
  name,FilePath:string;
  Config:Tinifile;
begin
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_LOCAL_MACHINE;

  FilePath:=ExtractFilePath(paramstr(0))+'config.ini';
  Config:=Tinifile.Create(FilePath);

  if reg.OpenKey('\SYSTEM\ControlSet001\Services\Tcpip\Parameters',True) then
  begin
    name:=reg.ReadString('NV Hostname');
    if  name = Config.ReadString('����','��������','server') then
    begin
      showmessage('���ȷ����ϣ��������ģʽ');

      huifu_SpeedButton.Enabled:=true;
      dbmemo2.ReadOnly:=false;

      queren_SpeedButton.Visible:=false;
      shanchu_SpeedButton.Visible:=true;
    end
    else  showmessage('��Ǹ�������֤����');
  end;

  Config.Destroy;
end;

procedure TB.huifu_SpeedButtonClick(Sender: TObject);
begin
  AdoQuery.Edit;
  AdoQuery.FieldByName('������').Value:='�Ѵ���';
  AdoQuery.Post;
  showmessage('�ظ��ɹ���');
end;

procedure TB.shanchu_SpeedButtonClick(Sender: TObject);
begin
  if MessageDlg('ȷ��Ҫɾ��������ô��',mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    AdoQuery.Edit;
    AdoQuery.Delete;
  end;
end;

procedure TB.FormShow(Sender: TObject);
var
  Config:Tinifile;
  FilePath,DataPath:string;
begin
  FilePath:=ExtractFilePath(paramstr(0))+'config.ini';
  Config:=Tinifile.Create(FilePath);

  DataPath := Config.ReadString('����','���ݿ�·��','');

  If Not FileExists(datapath) then
    ShowMessage('Զ�����ݿ�·�����ò���ȷ��')
  else
  begin
    ADOQuery.Close;
    ADOQuery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+pchar(DataPath)+';Persist Security Info=False';
    ADOQuery.Open;
  end;
end;

procedure TB.FormCreate(Sender: TObject);
begin
{
  CreateMutex(nil,False,'BBS.EXE');
  if GetLastError=ERROR_ALREADY_EXISTS then
  begin
    Halt(0);
  end;
}
end;

end.
