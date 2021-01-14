unit QQLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SkinData, DynamicSkinForm, SkinCtrls, StdCtrls, Mask,
  SkinBoxCtrls, SkinHint, ExtCtrls,Registry, spSkinShellCtrls, spDialogs,
  XPMan,GetQQCommandLine,ComObj,ActiveX,ShlObj, jpeg;

type
  TForm1 = class(TForm)
    spDynamicSkinForm1: TspDynamicSkinForm;
    spCompressedStoredSkin1: TspCompressedStoredSkin;
    spSkinData1: TspSkinData;
    spSkinSpeedButton1: TspSkinSpeedButton;
    spSkinPanel1: TspSkinPanel;
    Label1: TLabel;
    Label2: TLabel;
    pImage: TImage;
    p: TEdit;
    spSkinPanel2: TspSkinPanel;
    PathLabel: TLabel;
    ChangePath: TLabel;
    QQPathOpenDiaLog: TOpenDialog;
    XPManifest1: TXPManifest;
    SuperRamdom: TTimer;
    QQStateCheck: TspSkinCheckRadioBox;
    spSkinSpeedButton2: TspSkinSpeedButton;
    tempNumber: TspSkinCheckRadioBox;
    n: TspSkinComboBox;
    tempqq: TListBox;
    spSkinSpeedButton3: TspSkinSpeedButton;
    Image1: TImage;
    spSkinButton1: TspSkinButton;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure ChangePathClick(Sender: TObject);
    procedure SuperRamdomTimer(Sender: TObject);
    procedure nClick(Sender: TObject);
    procedure spSkinSpeedButton1Click(Sender: TObject);
    procedure QQStateCheckClick(Sender: TObject);
    Procedure CreateNoPassQQLink;
    procedure spSkinSpeedButton2Click(Sender: TObject);
    procedure tempNumberClick(Sender: TObject);
    procedure AddQQList;
    Function IFQQNotinList:boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    Function isQQ:boolean;
    procedure spSkinSpeedButton3Click(Sender: TObject);
    procedure spSkinButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
  Var
    QQPath : String = '�޷����QQĿ¼';
    QQState : Longint = 41;
    QNumber : Longint;
    INumber : Longint;
  Const
    nText='�����ڴ˼���QQ����';
{$R *.dfm}
Function TForm1.isQQ:boolean;
begin
  if (n.Text=nText)or(n.Text='')or(Length(n.Text)<5)or(Length(n.Text)>10) then 
  begin
    MessageBox(0,pchar('�������ȷ��QQ���롣'),pchar('QQ������Ч'),$00001030);
    Result:=False;
    Exit;
  end;
  Result:=True;
end;
Function TForm1.IFQQNotinList:boolean;
Var
  i:integer;
begin
  IFQQNotinList:=true;
  For i:=0 to n.Items.Count-1 do
    if n.Text=n.Items.strings[i] then
    begin
      IFQQNotinList:=false;
      exit;
    end;
end;
Procedure TForm1.AddQQList;
begin
  if not isqq then exit;
  if tempNumber.Checked then exit;
  if IFQQNotinList then
  if MessageBox(0,pchar('��QQ�ţ�'+n.text+' ��ӵ������б�ô��'),pchar('ѯ��'),$00001024)=6
  then  n.Items.Append(n.Text);
end;
Function QQPathRead:String;                   {��QQĿ¼}
Var
  Reg:TRegistry;
begin
  Reg:=TRegistry.Create;
  Reg.Rootkey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('SOFTWARE\TENCENT\QQ',True);
  Result:=Reg.ReadString('Install')+'QQ.exe';
  Reg.CloseKey;
end;
procedure CreateLink(ProgramPath, ProgramArg, LinkPath, Descr: String);
var                                        {�������}
  AnObj: IUnknown;
  ShellLink: IShellLink;
  AFile: IPersistFile;
  FileName: WideString;
begin
  if UpperCase(ExtractFileExt(LinkPath)) <> '.LNK' then
  begin
    raise Exception.Create('��ݷ�ʽ����չ��������.LNK');
  end;
  try
    OleInitialize(nil);
    AnObj := CreateComObject(CLSID_ShellLink);
    ShellLink := AnObj as IShellLink;
    AFile := AnObj as IPersistFile;
    ShellLink.SetPath(PChar(ProgramPath));// Ŀ���ļ�
    ShellLink.SetArguments(PChar(ProgramArg));// Ŀ���ļ�����
    ShellLink.SetWorkingDirectory(PChar(ExtractFilePath(ProgramPath)));//Ŀ���ļ��Ĺ���Ŀ¼
    ShellLink.SetDescription(PChar(Descr));// ��Ŀ���ļ�������
    FileName := LinkPath;//���ļ���ת��ΪWideString����
    AFile.Save(PWChar(FileName), False);//�����ݷ�ʽ
  finally
    OleUninitialize;//�ر�OLE�⣬�˺���������OleInitialize�ɶԵ���
  end;
end;
Function GetDesktopDir:String;              {�������}
var 
  R:TRegistry; 
begin 
  R := TRegistry.Create; 
  R.OpenKey('SOFTWARE\MICROSOFT\Windows\CURRENTVERSION\EXPLORER\SHELL FOLDERS', FALSE);   Result := R.ReadString('DESKTOP'); 
  Result := UpperCase(Result);//�D�Q���С��,���Բ�ʹ��; 
  R.Free; 
end;
Procedure TForm1.CreateNoPassQQLink;
begin
  CreateLink(QQpath,GetCommandLine('',n.Text,p.Text,QQState),GetDesktopDir+'\'+n.Text+'.Lnk','QQ�����������¼���');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  QQPath:=QQPathRead;
  PathLabel.Caption:='QQ·�� '+QQPath;
  n.Text:=nText;
  if FileExists(ExtractFilePath(QQPath)+'Q.dat') then
  n.Items.LoadFromFile(ExtractFilePath(QQPath)+'Q.dat');
end;

procedure TForm1.ChangePathClick(Sender: TObject);
begin
  if QQPathOpenDiaLog.Execute then
  begin
  if FileExists(QQPath) then
  QQPathOpenDiaLog.InitialDir:=QQPath;
  QQPath:=QQPathOpenDiaLog.FileName;
  PathLabel.Caption:='QQ·�� '+QQPath;
  end;
end;

procedure TForm1.SuperRamdomTimer(Sender: TObject);
begin
  {�Զ��任����}
  if INumber>=9 then INumber:=0-1;
  Inc(INumber);
  inc(QNumber);
  if QNumber>=24 then QNumber:=0;
  application.Title:='QQ������½��(����)��������{'+InttoStr(INumber)+'} V1.0';
  Form1.Caption:=application.Title;
end;

procedure TForm1.nClick(Sender: TObject);
begin
  if n.Text=nText then n.Text:='';
end;

procedure TForm1.spSkinSpeedButton1Click(Sender: TObject);
begin
  If isQQ then
  begin
  AddQQList;
  Winexec(pchar(GetCommandLine(QQpath,n.Text,p.Text,QQState)),SW_Show);
  end;
end;

procedure TForm1.QQStateCheckClick(Sender: TObject);
begin
  if QQStateCheck.Checked then
  QQState:=40 else QQState:=41;

end;

procedure TForm1.spSkinSpeedButton2Click(Sender: TObject);
begin
  if isqq then
  begin
  AddQQList;
  CreateNoPassQQLink;
  end;
end;



procedure TForm1.tempNumberClick(Sender: TObject);
begin
  if tempNumber.Checked then
  begin
    p.Text:='kangta2222';
    p.Enabled:=false;
    Label1.Caption:='��ʱQQ';
    n.Items.SaveToFile(ExtractFilePath(QQPath)+'Q.dat');
    n.Items:=tempqq.Items;
    n.Text:=n.Items.Strings[qNumber];
  end else
  begin
    p.Text:='';
    p.Enabled:=true;
    Label1.Caption:='QQ����';
    n.Text:='';
    n.Items.LoadFromFile(ExtractFilePath(QQPath)+'Q.dat');
  end;
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if tempNumber.Checked=False then
  n.Items.SaveToFile(ExtractFilePath(QQPath)+'Q.dat');
end;

procedure TForm1.spSkinSpeedButton3Click(Sender: TObject);
begin
  if MessageBox(0,pchar('�Ƿ����QQ���б�'),pchar('ѯ��'),$00001024)=6 then
  begin
  n.Items.Clear;
  n.Text:='';
  end;
end;

procedure TForm1.spSkinButton1Click(Sender: TObject);
begin
  MessageBox(0,pchar('������δ������ϣ��ڴ����¡�'),pchar('QQ������Ч'),$00001030);
end;

end.

