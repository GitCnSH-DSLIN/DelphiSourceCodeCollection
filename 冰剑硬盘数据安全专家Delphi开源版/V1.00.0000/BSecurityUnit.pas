unit BSecurityUnit;
{BY MooHyu devh.net at 2007
123bd123@163.com QQ 360888822}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dcInternal, dcFileInfo, lxpDraggingFilesMonitor, StdCtrls,
  Menus, ExtCtrls, dcEdits, ComCtrls, XPMan, Core, StringsUnit,
  dcBrowseDialog, dcStdDialogs, RegShell, FileCtrl;

type
  TForm1 = class(TForm)
    FilesMonitor1: TlxpDraggingFilesMonitor;
    FileInfo: TdcFileInfo;
    FileEdit: TdcFileEdit;
    Panel1: TPanel;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    Panel2: TPanel;
    Info: TLabel;
    Img: TImage;
    Shape1: TShape;
    FilesMonitor2: TlxpDraggingFilesMonitor;
    Panel4: TPanel;
    PWEdit: TLabeledEdit;
    EBtn: TButton;
    Dbtn: TButton;
    XPManifest1: TXPManifest;
    FileListBox: TFileListBox;
    SaveDlg: TdcSaveDialog;
    BrowseDlg: TdcBrowseDialog;
    Panel3: TPanel;
    DelCheck: TCheckBox;
    p: TPanel;
    N2: TMenuItem;
    C1: TMenuItem;
    A1: TMenuItem;
    SHELL1: TMenuItem;
    ShellI1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FilesMonitor1DropFiles(Receiver: TWinControl;
      const FileNames: TStrings; const FilesCount: Integer;
      const DropPoint: TPoint);
    procedure FilesMonitor2DropFiles(Receiver: TWinControl;
      const FileNames: TStrings; const FilesCount: Integer;
      const DropPoint: TPoint);
    procedure FileEditDlgOk(Sender: TObject);
    procedure EBtnClick(Sender: TObject);
    procedure DbtnClick(Sender: TObject);
    Procedure Enabled;
    procedure A1Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure ShellI1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.Caption:=Form1.Caption+Versoin;
  if ParamCount>0 then
    if FileExists(ParamStr(1)) then begin
      FileEdit.Text:=ParamStr(1);
      FileInfo.FILENAME:=FileEdit.Text;
      Info.Caption:= '�ļ����� '+FileInfo.FileType+ #13 +
                     '�ļ����� '+IntToStr(FileInfo.FileSize div 1000)+' KB' + #13 +
                     '����ʱ�� '+DateToStr(FileInfo.TimeCreated)+' '+
                     TimeToStr(FileInfo.TimeCreated);
      Img.Picture.Icon:=FileInfo.LargeIcon;
      Enabled;
   end;
end;
Procedure TForm1.Enabled;
begin
  Ebtn.Enabled:=true;
  Dbtn.Enabled:=true;
  DelCheck.Enabled:=true;
  pwedit.Enabled:=true;
end;
procedure TForm1.FilesMonitor1DropFiles(Receiver: TWinControl;
  const FileNames: TStrings; const FilesCount: Integer;
  const DropPoint: TPoint);
begin
  if FileExists(FileNames[0]) then begin
   FileEdit.Text:=FileNames[0];
   FileInfo.FILENAME:=FileEdit.Text;
   Info.Caption:= '�ļ����� '+FileInfo.FileType+ #13 +
                  '�ļ����� '+IntToStr(FileInfo.FileSize div 1000)+' KB' + #13 +
                  '����ʱ�� '+DateToStr(FileInfo.TimeCreated)+' '+
                  TimeToStr(FileInfo.TimeCreated);
   Img.Picture.Icon:=FileInfo.LargeIcon;
   Enabled;
   end;
end;

procedure TForm1.FilesMonitor2DropFiles(Receiver: TWinControl;
  const FileNames: TStrings; const FilesCount: Integer;
  const DropPoint: TPoint);
begin
   if FileExists(FileNames[0]) then begin
   FileEdit.Text:=FileNames[0];
   FileInfo.FILENAME:=FileEdit.Text;
   Info.Caption:= '�ļ����� '+FileInfo.FileType+ #13 +
                  '�ļ����� '+IntToStr(FileInfo.FileSize div 1000)+' KB' + #13 +
                  '����ʱ�� '+DateToStr(FileInfo.TimeCreated)+' '+
                  TimeToStr(FileInfo.TimeCreated);
   Img.Picture.Icon:=FileInfo.LargeIcon;
   Enabled;
   end;
end;

procedure TForm1.FileEditDlgOk(Sender: TObject);
begin
    if FileExists(FileEdit.Text)
  then
  begin
    FileInfo.FILENAME:=FileEdit.Text;
    Info.Caption:='�ļ����� '+FileInfo.FileType+ #13 +
                  '�ļ����� '+IntToStr(FileInfo.FileSize div 1000)+' KB' + #13 +
                  '����ʱ�� '+DateToStr(FileInfo.TimeCreated)+' '+
                  TimeToStr(FileInfo.TimeCreated);

    Img.Picture.Icon:=FileInfo.LargeIcon;
    Enabled;
  end;
end;

procedure TForm1.EBtnClick(Sender: TObject);
begin

  if (pwedit.Text<>'')and(FileExists(FileEdit.Text))and(SaveDlg.Execute) then
  begin
  p.Caption:='�����С���'+FileEdit.Text;
  Encrity(FileEdit.Text,UpperCase(pwedit.Text),SaveDlg.FileName);
  if DelCheck.Checked then
  deletefile(FileEdit.Text);
  p.Caption:='�����! ^_^';
  end;
end;

procedure TForm1.DbtnClick(Sender: TObject);
begin
  if (pwedit.Text<>'')and(FileExists(FileEdit.Text))and(BrowseDlg.Execute) then
  begin
  p.Caption:='�����С���'+FileEdit.Text;
  Decrity(FileEdit.Text,UpperCase(pwedit.Text),BrowseDlg.Folder);
  if DelCheck.Checked then
  deletefile(FileEdit.Text);
  p.Caption:='�����! ^_^';
  end;
end;

procedure TForm1.A1Click(Sender: TObject);
 var
  S: string;
begin
  S := 'BinJian Security Experts (BSE)                                      ' + #13 + #13 +
    '���β���' + #13 +
    '    http://www.cnare.cn/' + #13 +
    '    http://www.cnare.com.cn/' + #13 +  #13 +
    '��������' + #13 +
    '    123bd123@163.com'+ #13 +
    '    188959995@qq.com'+ #13 + #13 +
    'Copyright (c) 1998-2001 Eldos,Alexander Ionov.' + #13 + #13 +
    'Copyright (c) 2007-2046 BinJian & cnare.cn' + #13 + #13 +
    'UpDate 2007.6.29 8.47 by BinJian (����)' ;
  MessageBox(Handle, PChar(S),Pchar('���� BinJian Security Experts (BSE) '), MB_ICONINFORMATION);
end;

procedure TForm1.C1Click(Sender: TObject);
begin
  Close;
end;
Function GetWinDir:String;        {ȡ�� Windows/System32 ϵͳ·��}
var
  Buf:array[0..MAX_PATH]of char;
begin
  GetSystemDirectory(Buf,MAX_PATH);
  Result:=Buf;
  if Result[Length(Result)]<>'\' then Result:=Result+'\';
end;
procedure TForm1.ShellI1Click(Sender: TObject);

Var
  SysDir:pchar;
  Shellname:string;
begin
  If FileExists(GetWinDir+'BSE.exe')=false then
  if Messagebox(0,pchar('.BSE ��չ����δ�������Ƿ���������?'),pchar('��ʾ!'),MB_YESNO+MB_DEFBUTTON1+MB_APPLMODAL+MB_ICONWARNING)=6
  then begin
    deletefile(Pchar(GetWinDir+'BSE.exe'));
    CopyFile(Pchar(Application.ExeName),Pchar(GetWinDir+'BSE.exe'),false);
    Rshell('.BSE',GetWinDir+'BSE.exe');
  end else else Messagebox(0,pchar('.BSE ��չ���Ѿ�����!'),pchar('��ʾ!'),MB_OK+MB_DEFBUTTON1+MB_APPLMODAL+MB_ICONWARNING);


end;

end.
