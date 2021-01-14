unit NetBBS_Unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, jpeg, Buttons, Grids, DBGrids, StdCtrls, DBCtrls, ComCtrls,Inifiles,
  Registry,Shellapi, WinSkinData, GIFImg;

type
  TBBS = class(TForm)
    Image1: TImage;
    Memo1: TMemo;
    DBGrid1: TDBGrid;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    DBGrid2: TDBGrid;
    Panel1: TPanel;
    DBMemo3: TDBMemo;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    SpeedButton7: TSpeedButton;
    SkinData: TSkinData;
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BBS: TBBS;

implementation

uses DataModule_Unit;

{$R *.dfm}

procedure TBBS.FormActivate(Sender: TObject);
var
  Config:Tinifile;
  FilePath,DataPath,BmpPath:string;
begin
  FilePath:=ExtractFilePath(paramstr(0))+'config.ini';
  Config:=Tinifile.Create(FilePath);

  DataPath := Config.ReadString('����','���ݿ�·��','');

  If Not FileExists(datapath) then
    ShowMessage('Զ�����ݿ�·�����ò���ȷ��')
  else
  begin
    NetBBS_DataModule.ADOConnection1.Connected:=false;
    NetBBS_DataModule.ADOConnection1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+pchar(DataPath)+';Persist Security Info=False';
    NetBBS_DataModule.ADOConnection1.Connected:=true;
    NetBBS_DataModule.ADOQuery1.open;
    NetBBS_DataModule.ADOQuery2.open;
  end;

  Config.Destroy;

  BmpPath:=ExtractFilePath(paramstr(0))+'Images\Button\';
  Image1.Picture.LoadFromFile(BmpPath+'Top.jpg');
end;

procedure TBBS.Image1Click(Sender: TObject);
var
  Config:Tinifile;
  FilePath,www:string;
begin
  FilePath:=ExtractFilePath(paramstr(0))+'config.ini';
  Config:=Tinifile.Create(FilePath);

  www := Config.ReadString('����','������','http://www.lilyshow.com');

  ShellExecute(handle,'open',pchar(www),nil,nil,SW_SHOWMAXIMIZED);

  Config.Destroy;
end;

procedure TBBS.SpeedButton1Click(Sender: TObject);
var
  reg:TRegistry;
begin
  if  memo1.Text='' then
    showmessage('��������д������Ϣ��лл������')
  else
  begin
    NetBBS_DataModule.ADOQuery1.Edit;
    NetBBS_DataModule.ADOQuery1.Append;

    NetBBS_DataModule.ADOQuery1.FieldByName('�ͻ�����').Value:=memo1.Text;
    NetBBS_DataModule.ADOQuery1.FieldByName('������').Value:='�ȴ���';
    NetBBS_DataModule.ADOQuery1.FieldByName('����ʱ��').Value:=DateTimetoStr(now);

    reg:=TRegistry.Create;
    reg.RootKey:=HKEY_LOCAL_MACHINE;

    if reg.OpenKey('\SYSTEM\ControlSet001\Services\Tcpip\Parameters',True) then
    begin
      NetBBS_DataModule.ADOQuery1.FieldByName('�������').Value:=reg.ReadString('NV Hostname');
    end;
    NetBBS_DataModule.ADOQuery1.Post;

    NetBBS_DataModule.AdoQuery1.Close;
    NetBBS_DataModule.AdoQuery1.SQL.Clear;
    NetBBS_DataModule.AdoQuery1.SQL.Add('select * from �˿����� order by ���Ա�� desc');
    NetBBS_DataModule.AdoQuery1.Open;
    
    memo1.Clear;

    Timer1.Enabled:=true;
    SpeedButton1.Enabled:=false;

    showmessage('���Գɹ��������ĵȴ��ظ�! �˺�"3����"���Ͻ��ظ�����');
  end;
end;

procedure TBBS.SpeedButton2Click(Sender: TObject);
begin
  ShellExecute(handle,nil,pchar('http://soft.lilyshow.com'),nil,nil,SW_SHOWMAXIMIZED);
end;

procedure TBBS.SpeedButton3Click(Sender: TObject);
var
  reg:TRegistry;
  name,FilePath:string;
  Config:Tinifile;
begin
  DBMemo3.SetFocus;
  DBMemo3.ReadOnly:=false;
  SpeedButton3.Enabled:=false;
  SpeedButton4.Enabled:=True;

    NetBBS_DataModule.ADOQuery2.Edit;
    NetBBS_DataModule.ADOQuery2.Append;
    NetBBS_DataModule.ADOQuery2.FieldByName('���Ա��').Value:=NetBBS_DataModule.ADOQuery1.FieldByName('���Ա��').Value;
    NetBBS_DataModule.ADOQuery2.FieldByName('�ظ���Ϣ').Value:=DBmemo3.Text;
    NetBBS_DataModule.ADOQuery2.FieldByName('����ʱ��').Value:=DateTimetoStr(now);

    reg:=TRegistry.Create;
    reg.RootKey:=HKEY_LOCAL_MACHINE;

    if reg.OpenKey('\SYSTEM\ControlSet001\Services\Tcpip\Parameters',True) then
    begin
      NetBBS_DataModule.ADOQuery2.FieldByName('�������').Value:=reg.ReadString('NV Hostname');
    end;
end;

procedure TBBS.SpeedButton4Click(Sender: TObject);
begin
  if  DBmemo3.Text='' then
    showmessage('��������д������Ϣ��лл������')
  else
  begin
    NetBBS_DataModule.ADOQuery2.Edit;
    NetBBS_DataModule.ADOQuery2.FieldByName('�ظ�¥��').Value:=NetBBS_DataModule.ADOQuery2.RecordCount+1;
    NetBBS_DataModule.ADOQuery2.Post;

    NetBBS_DataModule.AdoQuery2.Close;
    NetBBS_DataModule.AdoQuery2.SQL.Clear;
    NetBBS_DataModule.AdoQuery2.SQL.Add('select * from �˿ͻظ� where ���Ա��=:���Ա�� order by �ظ�¥�� desc');
    NetBBS_DataModule.AdoQuery2.Open;

    SpeedButton4.Enabled:=false;
    Timer2.Enabled:=true;

    showmessage('�����ɹ����˺�"10��"���Ͻ��ظ�����');
  end;
end;

procedure TBBS.SpeedButton5Click(Sender: TObject);
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
      DBMemo2.ReadOnly:=false;

      SpeedButton6.Visible:=true;
      SpeedButton6.Enabled:=true;
      SpeedButton7.Visible:=true;
      SpeedButton7.Enabled:=true;

      //�������ģʽ��ֹͣˢ�£���ֹ���뵽һ�����ʧ
      Timer3.Enabled:=false;
    end
    else  showmessage('��Ǹ�������֤����');
  end;

  Config.Destroy;
end;

procedure TBBS.SpeedButton6Click(Sender: TObject);
begin
  NetBBS_DataModule.AdoQuery1.Edit;
  NetBBS_DataModule.AdoQuery1.FieldByName('������').Value:='�Ѵ���';
  NetBBS_DataModule.AdoQuery1.Post;
  showmessage('�ظ��ɹ���');
end;

procedure TBBS.SpeedButton7Click(Sender: TObject);
begin
  if MessageDlg('ȷ��Ҫɾ��������ô��',mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    NetBBS_DataModule.AdoQuery1.Edit;
    NetBBS_DataModule.AdoQuery1.Delete;
  end;
end;

procedure TBBS.Timer1Timer(Sender: TObject);
begin
  SpeedButton1.Enabled:=true;
end;

procedure TBBS.Timer2Timer(Sender: TObject);
begin
  SpeedButton3.Enabled:=true;
end;

procedure TBBS.Timer3Timer(Sender: TObject);
begin
  NetBBS_DataModule.AdoQuery1.Close;
  NetBBS_DataModule.AdoQuery1.Open;

  NetBBS_DataModule.AdoQuery2.Close;
  NetBBS_DataModule.AdoQuery2.Open;
end;

end.
