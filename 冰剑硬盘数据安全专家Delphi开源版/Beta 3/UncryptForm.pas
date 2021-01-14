unit UncryptForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FlatUtils, FlatBtns, FlatBars, StdCtrls, ExtCtrls, jpeg,
  ComCtrls, dcComCtrls, dcFolderView, dcEdits, VCLUnZip, VCLZip,Aes,
  FlatBoxs;

type
  TUNForm = class(TForm)
    SavePanel: TPanel;
    Panel: TPanel;
    Pwedit: TLabeledEdit;
    log: TMemo;
    UN: TFlatButton;
    Image1: TImage;
    FlatTitlebar1: TFlatTitlebar;
    FlatTitlebar2: TFlatTitlebar;
    PATHEdit: TdcFolderEdit;
    Label1: TLabel;
    ReadZIP: TVCLZip;
    List: TFlatListBox;
    procedure UNClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UNForm: TUNForm;

implementation

uses Experts;
const
  GKEY='#LoveSYCheng$';
  KB=KB256;
var
  TempPath,Path:String;

{$R *.dfm}
Procedure MSBOX(S:string);
begin
  With UnForm do log.Lines.Append(s);
end;
Procedure MSFBOX;
begin
  MSBOX('--------------------------------------------');
end;
Procedure ERRBOX(S:String);
begin
  if S<>'' then MSBOX(S);
  MSFBOX;
  MSBOX('ִ������ָ�� ���� ʧ���� '+Datetostr(now)+' '+Timetostr(now));
End;
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
Procedure Uncrypt(BSEFileName{���ͷ��ļ�·��},Path{�ͷŵ�}:string);
  var
    TempS:TStrings;
    i:Longint;
begin
  if DirectoryExists(Path)=False then MkDir(Path);
  UnZipFile(TempPath,BSEFileName,GKey+UnForm.Pwedit.Text);
  UnForm.ReadZIP.ZipName:=BSEFileName;
  UnForm.ReadZIP.ReadZip;
  UnForm.List.Items.BeginUpdate;
  UNForm.ReadZIP.FillList(UnForm.List.Items);
  UnForm.List.Items.EndUpdate;
  for i:=0 to UnForm.List.Items.Count-1 do
    DecryptFile(temppath+UnForm.List.Items.Strings[i],UNForm.PathEdit.Text+'\'+UnForm.List.Items.Strings[i],GKey+UnForm.Pwedit.Text,KB);
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
Function DelTemp:boolean;
begin
  deltemp:=Deltree(temppath);
  if  (not DirectoryExists(temppath)) then
  MkDir(temppath);
end;
procedure TUNForm.UNClick(Sender: TObject);
begin
 MSBOX('ִ������ָ�� ���� ��ʼ�� '+datetostr(now)+' '+timetostr(now));
  MSFBOX;
  if Pwedit.Text='' then
  begin
    ERRBOX('���벻����Ϊ��!!');
    exit;
  end;
  if PathEdit.Text='' then
  begin
    ERRBOX('��ָ���洢λ��!!');
    exit;
  end;
  MSBox('�������� Core Engine 0.00.0610 ��������');
  MSBox('��Կ�㷨 PKI Algorithm 0.3');
  Uncrypt(Form1.DeFileEdit.Text,PathEdit.Text);
  MSBOX('�������� Core Engine 0.00.0610 ��������');
  MSBOX('����������ʱ�ļ�����');
  if DelTemp then MSBOX('������ʱ�ļ���ϣ������������') else
  MSBOX('������ʱ�ļ�ʧ�ܣ������������');
  MSFBOX;
  MSBOX('ִ������ָ�� ���� �ɹ��� '+datetostr(now)+' '+timetostr(now));
end;

procedure TUNForm.FormCreate(Sender: TObject);
begin
  tempPath:=ExtractFilePath(ParamStr(0))+'temp\';
  Path:=ExtractFilePath(ParamStr(0));
  if  (not DirectoryExists(temppath)) then
  MkDir(temppath);
end;

end.
