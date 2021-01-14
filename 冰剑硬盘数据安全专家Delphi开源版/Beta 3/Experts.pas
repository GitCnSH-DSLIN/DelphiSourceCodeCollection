unit Experts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Menus, StdCtrls, ExtCtrls ,AES,
  FlatUtils, FlatBoxs, FlatBtns,  FlatBars, VCLUnZip,
  VCLZip, FlatCtrls ,UncryptForm,EncryptForm, Buttons, dcStdDialogs,
  dcEdits, Tabs, cxControls, cxPC, lxpDraggingFilesMonitor;

type
  TForm1 = class(TForm)
    StatusBar: TStatusBar;
    zip: TVCLZip;
    PopupMenu1: TPopupMenu;
    N3: TMenuItem;
    Button1: TButton;
    BitBtn1: TBitBtn;
    OpenDialog: TdcOpenDialog;
    Page: TcxPageControl;
    EnFileList: TFlatListBox;
    EnPage: TcxTabSheet;
    DePage: TcxTabSheet;
    FileEdit: TdcFileEdit;
    AddBtn: TFlatButton;
    FlatButton2: TFlatButton;
    lxpDraggingFilesMonitor1: TlxpDraggingFilesMonitor;
    Erunbtn: TFlatButton;
    Titlebar: TFlatTitlebar;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    A2: TMenuItem;
    N2: TMenuItem;
    D1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    A1: TMenuItem;
    Drunbtn: TFlatButton;
    deFileEdit: TdcFileEdit;
    OpenBtn: TFlatButton;
    DeFileList: TFlatListBox;
    cxTabSheet1: TcxTabSheet;
    Text: TFlatMemo;
    TextEbtn: TFlatButton;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure addbtnClick(Sender: TObject);
    procedure lxpDraggingFilesMonitor1DropFiles(Receiver: TWinControl;
      const FileNames: TStrings; const FilesCount: Integer;
      const DropPoint: TPoint);
    procedure FlatButton2Click(Sender: TObject);
    procedure ErunbtnClick(Sender: TObject);
    procedure DrunbtnClick(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure D1Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure TextEbtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses TextPassEdit;

{$R *.dfm}
Var
  temppath,path:string;
Function NOfindbox(files:string):integer;
begin
  NOfindbox:=Messagebox(0,pchar('�ļ� '+Files+' �����ڣ��Ƿ����?'+#13+'�����ǡ����ԣ���������ֹ!'),pchar('���汨�� �ļ�δ�ҵ�'),MB_YESNO+MB_DEFBUTTON1+MB_ICONERROR+MB_APPLMODAL);
end;

Function Deltree(ASourceDir: string): Boolean ;
var
  FileRec:TSearchrec;
  Sour:String;
begin
  Sour:=ASourceDir;
  if Sour[Length(Sour)]<>'\' then Sour := Sour + '\';
  if not DirectoryExists(ASourceDir) then
    exit;
  if FindFirst(Sour+'*.*',faAnyfile,FileRec) = 0 then
    repeat
      if ((FileRec.Attr and faDirectory) <> 0) then
      begin
        if (FileRec.Name<>'.') and (FileRec.Name<>'..') then
          begin
            DelTree(Sour+FileRec.Name);
            FileSetAttr(Sour+FileRec.Name,faArchive);
            RemoveDir(Sour+FileRec.Name);
          end;
      end
      else
      begin
        FileSetAttr(Sour+FileRec.Name,faArchive);
        deletefile(Sour+FileRec.Name);
      end;
   until FindNext(FileRec)<>0;
   FindClose(FileRec);
   FileSetAttr(Sour,faArchive);
   RemoveDir(Sour);
end;

Function UnZipFile(DesPathName,ZipFileName,sPwd:string):Boolean;
begin
  Result := false;
  if (not DirectoryExists(DesPathName)) then
  MkDir(DesPathName);
  if IOResult <> 0 then Exit;
  if not FileExists(ZipFileName) then Exit;
  with Tvclunzip.Create(nil) do
  try
  try
  Password := sPwd;
  DoProcessMessages := True;
  ZipName := ZipFileName;
  ReadZip;
  if Count = 0 then Abort; // û���ļ�������˳�
    DestDir := DesPathName;
    DoAll := True;
    RecreateDirs := True;
   if UnZip=Count then Result:=true else Result:=false;

  except
   Result := false;
  end;
  finally
    Free;
  end;
end;
Function DelTemp:boolean;
begin
  deltemp:=Deltree(temppath);
  if  (not DirectoryExists(temppath)) then
  MkDir(temppath);
end; {
Function UnPack:boolean;
begin
  UnPack:=UnZipFile(temppath,Form1.OpenEdit.Text,SKEY);

end;  {
Procedure EnFile;         {����AES��������}      {
  var
    i:longint;
begin
  With Form1 do
  begin
    for i:=0 to TempList.Count-1 do
      if FileExists(TempList.Strings[i]) then
      begin   {����ļ�����?}
     {  EncryptFile(TempList.Strings[i],TempPath+ExtractFileName(TempList.Strings[i]),GFKEY+SKEY,KB);
        TempList.Strings[i]:=TempPath+ExtractFileName(TempList.Strings[i]);
      end;
  end;
end;     {
Function Pack:boolean;      {����zipѹ������}    {
begin
  with Form1 do
  begin
    zip.FilesList:=TempList;
    zip.zipname:=SaveEdit.Text;
    zip.Password:=SKEY;
    if (zip.zip-ErrWRFILEING)=(zip.FilesList.Count) then pack:=true else pack:=false;
  end;
end;
Procedure MSBOX(S:string);
begin
  with Form1 do begin
    log.Lines.Append(s);
    StatusBar.Panels.Items[0].Text:=s;
  end;
end;
procedure TForm1.addbtnClick(Sender: TObject);
begin
  if OpenDialog.Execute
  then if FileExists(OpenDialog.FileName) then
  Flist.Items.Append(OpenDialog.FileName) else
  Messagebox(0,pchar(#13+'�����·����Ч���ļ�·��Ϊ��!'+#13),pchar('��ʾ ·����Ч'),MB_OK+MB_DEFBUTTON1+MB_ICONERROR+MB_APPLMODAL);

end;
Procedure UnFile;
  var
    i:longint;
begin
  with Form1 do
  begin
    if DirectoryExists(SaveEdit.text)=false then MkDir(SaveEdit.text);
    for i:=0 to FFlist.Items.Count-1 do
    begin
      DecryptFile(temppath+FFlist.Items.Strings[i],SaveEdit.Text+'\'+FFlist.Items.Strings[i],GFKEY+SKEY,KB);
    end;
   end;
end;
procedure TForm1.clearbtnClick(Sender: TObject);
begin
  Flist.Items.Clear;
end;
Procedure MSFbox;
begin
  MSBOX('--------------------------------------------');
end;
Procedure ERRBOX(s:string);
begin
  if s<>'' then MSBOX(s);
  MSFBOX;
  MSBOX('ִ������ָ�� ���� ʧ���� '+datetostr(now)+' '+timetostr(now));
  TempList.Clear;
End;
Procedure ERRBOX2(s:string);
begin
  if s<>'' then MSBOX(s);
  MSFBOX;
  MSBOX('ִ������ָ�� ���� ʧ���� '+datetostr(now)+' '+timetostr(now));
  TempList.Clear;
End;
procedure TForm1.ebtnClick(Sender: TObject);
begin
  MSBOX('ִ������ָ�� ���� ��ʼ�� '+datetostr(now)+' '+timetostr(now));
  MSFBOX;
  TempList:=FList.Items; {�����ļ��б�TempList}   {
  if Pwedit.Text<>''
  then Skey:=Pwedit.Text
  else begin
    ERRBOX('���벻����Ϊ��!!');
    exit;
  end;
  if SaveEdit.Text='' then
  begin
    ERRBOX('��ָ���洢λ��!!');
    exit;
  end;
  Enfile;
  MSBox('������������ɼ��ܴ���!');
  MSBox('ѹ��������������');
  if Pack then MSBOX('ѹ����������ɴ������!') else
  begin
    ERRBOX('ѹ�����淢�������޷���������������ʧ��!');
    exit;
  end;
  MSBOX('����������ʱ�ļ�����');
  if deltemp then MSBOX('������ʱ�ļ���ϣ������������') else
  MSBOX('������ʱ�ļ�ʧ��(����������)�������������');
  MSFBOX;
  MSBOX('ִ������ָ�� ���� �ɹ��� '+datetostr(now)+' '+timetostr(now));
  TempList.Clear;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  tempPath:=ExtractFilePath(ParamStr(0))+'temp\';
  Path:=ExtractFilePath(ParamStr(0));
  if  (not DirectoryExists(temppath)) then
  MkDir(temppath);
  PageControl.ActivePageIndex:=0;
  SavePanel.Enabled:=false;
  Panel.Enabled:=false;
  ebtn.Enabled:=false;
  ubtn.Enabled:=false;
  N4.Enabled:=false;
  N5.Enabled:=false;
end;

procedure TForm1.llbtnClick(Sender: TObject);
begin
  if OpenDialogF.Execute then
  OpenEdit.Text:=OpenDialogF.FileName;
end;

procedure TForm1.FlatButton1Click(Sender: TObject);
begin
  if FileExists(openEdit.Text)=false then
  begin
    Messagebox(0,pchar(#13+'�����·����Ч���ļ�·��Ϊ��!'+#13),pchar('��ʾ ·����Ч'),MB_OK+MB_DEFBUTTON1+MB_ICONERROR+MB_APPLMODAL);
  end;
  Zip.ZipName:=OpenEdit.Text;
  if FileExists(Zip.ZipName) then Zip.ReadZip;
  FFlist.Items.BeginUpdate;
  ZIP.FillList(FFlist.Items);
  FFlist.Items.EndUpdate;
end;

procedure TForm1.ubtnClick(Sender: TObject);
begin
  MSBOX('ִ������ָ�� ���� ��ʼ�� '+datetostr(now)+' '+timetostr(now));
  MSFBOX;
  if Pwedit.Text<>'' then Skey:=Pwedit.Text else
  begin MSBox('���벻����Ϊ��!!');  msfbox;
    MSBOX('ִ������ָ�� ���� ʧ���� '+datetostr(now)+' '+timetostr(now));exit; end;
  if SaveEdit.Text='' then begin MSBox('��ָ���洢λ��!!');  msfbox;
    MSBOX('ִ������ָ�� ���� ʧ���� '+datetostr(now)+' '+timetostr(now));exit; end;
  if FileExists(openEdit.Text)=false then begin MSBox('�޷��򿪼���ѹ���ļ����ļ�·��Ϊ��!!');  msfbox;
    MSBOX('ִ������ָ�� ���� ʧ���� '+datetostr(now)+' '+timetostr(now));exit; end;
  MSBox('��ѹ������������');
  if Unpack then MSBox('��ѹ��������ɽ�ѹ����!') else
  begin
    MSBox('�����޷�ִ��Ԥ��ָ��ܳ״�����ļ����ƻ���');
    MSFbox;
    MSBOX('ִ������ָ�� ���� ʧ���� '+datetostr(now)+' '+timetostr(now));
    Exit;
  end;
  Zip.ZipName:=OpenEdit.Text;
  Zip.ReadZip;
  FFlist.Items.BeginUpdate;
  ZIP.FillList(FFlist.Items);
  FFlist.Items.EndUpdate;
{  for i:=0 to FFlist.Items.Count-1 do
  begin
    s:=FFlist.Items.Strings[i];
    if s[length(s)]='$' then Delete(s,length(s),1);
    renamefile(temppath+FFlist.Items.Strings[i],temppath+s);
    FFlist.Items.Strings[i]:=s;
  end;       }
{  MSBox('�ܳ�������������');
  if (FileExists(temppath+pwsfiles))and(readpws=EncryptString(SNKEY,Gkey+Skey,KB)) then
  begin
    MSBox('�ܳ�����������ܳ״���!');         }  {
    MSBox('����������������');
    unfile;
    MSBox('������������ɽ��ܴ���!');
{  end
    else
  begin
  MSBOX('��Կ�Աȴ���!��������룬����ʧ��!');
  MSFBOX;
  MSBOX('ִ������ָ�� ���� ʧ���� '+datetostr(now)+' '+timetostr(now));
  ListClear(2);exit;
  end;  }                         {
    MSBOX('����������ʱ�ļ�����');
  if deltemp then MSBOX('������ʱ�ļ���ϣ������������') else
  MSBOX('������ʱ�ļ�ʧ��(����������)�������������');
  MSFBOX;
  MSBOX('ִ������ָ�� ���� �ɹ��� '+datetostr(now)+' '+timetostr(now));
end;

procedure TForm1.OpenEditChange(Sender: TObject);
begin
   SaveEdit.Text:=ExtractFilePath(openedit.Text);
end;

procedure TForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if log.Lines.Strings[1]<>'' then
  log.Lines.SaveToFile(Path+'��־ '+datetostr(now)+' '+timetostr(now)[length(timetostr(now))]+'.log');
end;

procedure TForm1.PageControlChange(Sender: TObject);
begin
   if PageControl.ActivePage=Epage then
  begin
    N4.Enabled:=true;
    N5.Enabled:=false;
    ubtn.Enabled:=false;
    ebtn.Enabled:=true;
    SavePanel.Enabled:=true;
    Panel.Enabled:=true;
  end else
  if PageControl.ActivePage=Dpage then
  begin
    N4.Enabled:=false;
    N5.Enabled:=true;
    ubtn.Enabled:=true;
    ebtn.Enabled:=false;
    SavePanel.Enabled:=true;
    Panel.Enabled:=true;
  end else
  if PageControl.ActivePage=welcomepage
  then
  begin
    N4.Enabled:=false;
    N5.Enabled:=false;
    SavePanel.Enabled:=false;
    Panel.Enabled:=false;
    ebtn.Enabled:=false;
    ubtn.Enabled:=false;
  end;   }  {
end;
          }     {
procedure TForm1.N2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.H2Click(Sender: TObject);
begin
  PageControl.ActivePage:=welcomepage;
end;

procedure TForm1.A1Click(Sender: TObject);
var
  S: string;
begin
  S := 'Data Sercurity Experts (DSE) Beta 2                                     ' + #13 + #13 +
    '���β���' + #13 +
    '    http://www.Angella.cn/' + #13 +
    '    http://www.Angella.com.cn/' + #13 +  #13 +
    '��������' + #13 +
    '    123bd123@163.com'+ #13 +
    '    188959995@qq.com'+ #13 + #13 +
    'Copyright (c) 1998-2001 Eldos,Alexander Ionov.' + #13 + #13 +
    'Copyright (c) 2007-2046 BinJian & Angella.cn' + #13 + #13 +
    'UpDate 2007.5.19 17:11 by BinJian' ;
  MessageBox(Handle, PChar(S),Pchar('���� Data Sercurity Experts (DSE) '), MB_ICONINFORMATION);
end;
  {
procedure TForm1.zipFilePercentDone(Sender: TObject; Percent: Integer);
begin
  jdt.Progress:=Percent;
end;      }        {
procedure TForm1.UnZipBadPassword(Sender: TObject; FileIndex: Integer;
  var NewPassword: String);
begin
  MSBOX('�����������ʧ��!');
  MSFBOX;
  MSBOX('ִ������ָ�� ���� ʧ���� '+datetostr(now)+' '+timetostr(now));
end;
          }      {
procedure TForm1.N3Click(Sender: TObject);
begin
  log.Clear;
end;
                 }
procedure TForm1.Button1Click(Sender: TObject);
begin
  EnForm.Show;
end;


procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Unform.Show;
end;



procedure TForm1.N4Click(Sender: TObject);
begin
 { if OpenDialog.Execute then
  begin
  Zip.ZipName:=OpenDialog.FileName;
  if FileExists(Zip.ZipName) then Zip.ReadZip;
  Filelist.Items.BeginUpdate;
  ZIP.FillList(Filelist.Items);
  Filelist.Items.EndUpdate;
  FileEdit.Text:=Zip.ZipName;
  end;                      }
end;

procedure TForm1.OpenBtnClick(Sender: TObject);
begin
  if deFileEdit.Text='' then
  if OpenDialog.Execute then
  DeFileEdit.Text:=OpenDialog.FileName;
  if FileExists(deFileEdit.Text) then
  begin
  Zip.ZipName:=deFileEdit.Text;
  if FileExists(Zip.ZipName) then Zip.ReadZip;
  DEFilelist.Items.BeginUpdate;
  ZIP.FillList(DEFilelist.Items);
  DEFilelist.Items.EndUpdate;
  end else begin
    DEFileList.Items.Clear;
    Messagebox(0,pchar(#13+'�����·����Ч���ļ�·��Ϊ��!'+#13),pchar('��ʾ'),MB_OK+MB_DEFBUTTON1+MB_ICONERROR+MB_APPLMODAL);
  end;
end;

procedure TForm1.addbtnClick(Sender: TObject);
begin
  If FileExists(Fileedit.Text) then
  EnFileList.Items.Append(Fileedit.Text) else
  Messagebox(0,pchar(#13+'�����·����Ч���ļ�·��Ϊ��!'+#13),pchar('��ʾ'),MB_OK+MB_DEFBUTTON1+MB_ICONERROR+MB_APPLMODAL);
end;

procedure TForm1.lxpDraggingFilesMonitor1DropFiles(Receiver: TWinControl;
  const FileNames: TStrings; const FilesCount: Integer;
  const DropPoint: TPoint);
var
  i:longint;
begin
  for I:=0 to FileNames.Count-1 do
    begin
      if FileExists(FileNames.Strings[i]) then EnFileList.Items.Append(FileNames.Strings[i]);
    end;
end;

procedure TForm1.FlatButton2Click(Sender: TObject);
begin
  EnFileList.Items.Clear;
end;

procedure TForm1.ErunbtnClick(Sender: TObject);
begin
  if EnFileList.Items.Count<1 then
  Messagebox(0,pchar(#13+'�б��ǿյģ�û���ļ�!'+#13),pchar('��ʾ'),MB_OK+MB_DEFBUTTON1+MB_ICONERROR+MB_APPLMODAL)
  else EnForm.Show;
end;

procedure TForm1.DrunbtnClick(Sender: TObject);
begin
  if fileexists(defileedit.Text) then
  UNForm.Show else
  Messagebox(0,pchar(#13+'�����·����Ч���ļ�·��Ϊ��!!'+#13),pchar('��ʾ'),MB_OK+MB_DEFBUTTON1+MB_ICONERROR+MB_APPLMODAL)
end;

procedure TForm1.A1Click(Sender: TObject);
  var
  S: string;
begin
  S := 'BinJian Security Experts (BSE) Beta 3                                     ' + #13 + #13 +
    '���β���' + #13 +
    '    http://www.cnare.cn/' + #13 +
    '    http://www.cnare.com.cn/' + #13 +  #13 +
    '��������' + #13 +
    '    123bd123@163.com'+ #13 +
    '    188959995@qq.com'+ #13 + #13 +
   // 'Copyright (c) 1998-2001 Eldos,Alexander Ionov.' + #13 + #13 +
    'Copyright (c) 2007-2046 BinJian & cnare.cn' + #13 + #13 +
    'UpDate 2007.6.10 17:42 by BinJian' ;
  MessageBox(Handle, PChar(S),Pchar('���� BinJian Security Experts (BSE) '), MB_ICONINFORMATION);
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  Page.ActivePageIndex:=0;
end;

procedure TForm1.D1Click(Sender: TObject);
begin
  Page.ActivePageIndex:=1;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.TextEbtnClick(Sender: TObject);
begin
  TextForm.Show;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  text.Lines.Clear;
  text.Lines.Append('���Ǹ���ʾ�ı���');
  text.Lines.Append('by BinJian.');
end;

end.
