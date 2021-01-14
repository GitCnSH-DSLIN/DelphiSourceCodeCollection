unit EncryptForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FlatUtils, FlatBtns, FlatBars, StdCtrls, ExtCtrls, jpeg, Aes, VCLZip, VCLUnZip;

type
  TENForm = class(TForm)
    SavePanel: TPanel;
    SaveEdit: TLabeledEdit;
    Panel: TPanel;
    Pwedit: TLabeledEdit;
    FlatButton1: TFlatButton;
    log: TMemo;
    UN: TFlatButton;
    FlatTitlebar1: TFlatTitlebar;
    FlatTitlebar2: TFlatTitlebar;
    SaveDialog: TSaveDialog;
    Image1: TImage;
    procedure UNClick(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ENForm: TENForm;

implementation

uses Experts;
const
  GKEY='#LoveSYCheng$';
  KB=KB256;
var
  tempPath,Path:string;

{$R *.dfm}
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
Function NoFoundFile(Files:string):integer;
begin
  NoFoundFile:=Messagebox(0,pchar('�ļ� '+Files+' �����ڣ��Ƿ����?'+#13+'�����ǡ����ԣ���������ֹ!'),pchar('���汨�� �ļ�δ�ҵ�'),MB_YESNO+MB_DEFBUTTON1+MB_ICONERROR+MB_APPLMODAL);
end;
Function ZipFile(SrcPathName{��ѹ��Ŀ¼}, ZipFileName: string; OverWrite: Boolean;
  IsDir: Boolean; sPwd: string): Boolean;         {ѹ�����涯̬����}
var
  VCLZip: TVCLZip;
  ZFileList: TStringList;
begin
  Result := False;
  ZFileList := TStringList.Create;
  VCLZip := TVCLZip.Create(nil);
  try
    if IsDir and (not DirectoryExists(SrcPathName)) then
      MkDir(SrcPathName);
    ZFileList.Text := SrcPathName;
    with VCLZip do
    try
      Password := sPwd;
      DoProcessMessages := True;
      DoAll := True;
      if OverWrite then
      begin
        OverwriteMode := Always;
        ZipAction := zaReplace;
      end else begin
        OverwriteMode := Never;
        ZipAction := zaUpdate;
      end;
      FlushFilesOnClose := True;
      if IsDir then
        RootDir := SrcPathName
      else
        RootDir := ExtractFilePath(SrcPathName);
      FilesList.Clear;
      if IsDir then
        FilesList.Add('*.*')
      else
        FilesList.Assign(ZFileList);
      RelativePaths := True;
      ZipName := ZipFileName;
      Zip;
      Result := True;
    except
      Result := False;
    end;
  finally
    VCLZip.Free;
    ZFileList.Free;
  end;
end;
Function Encrypt(EFileList:TStrings;ESaveFile:String):boolean;
var
  i:longint;
begin
  For i:=0 to EFileList.Count-1 do
  begin
    if FileExists(EFileList.Strings[i]) then
    EncryptFile(EFileList.Strings[i],TempPath+ExtractFileName(EFileList.Strings[i]),GKEY+EnForm.Pwedit.Text,KB)
    else
  end;
  ZipFile(TempPath,EnForm.SaveEdit.Text,True,True,GKEY+EnForm.Pwedit.Text);
end;

Procedure MSBOX(S:string);
begin
  With EnForm do log.Lines.Append(s);
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
procedure TENForm.UNClick(Sender: TObject);
begin
  MSBOX('ִ������ָ�� ���� ��ʼ�� '+datetostr(now)+' '+timetostr(now));
  MSFBOX;
  if Pwedit.Text='' then
  begin
    ERRBOX('���벻����Ϊ��!!');
    exit;
  end;
  if SaveEdit.Text='' then
  begin
    ERRBOX('��ָ���洢λ��!!');
    exit;
  end;
  MSBox('�������� Core Engine 0.00.0610 ��������');
  MSBox('��Կ�㷨 PKI Algorithm 0.3');
  Encrypt(Form1.ENFilelist.Items,SaveEdit.Text);
  MSBOX('�������� Core Engine 0.00.0610 ��������');
  MSBOX('����������ʱ�ļ�����');
  if DelTemp then MSBOX('������ʱ�ļ���ϣ������������') else
  MSBOX('������ʱ�ļ�ʧ�ܣ������������');
  MSFBOX;
  MSBOX('ִ������ָ�� ���� �ɹ��� '+datetostr(now)+' '+timetostr(now));
end;

procedure TENForm.FlatButton1Click(Sender: TObject);
begin
  if SaveDialog.Execute then
  SaveEdit.Text:=SaveDialog.FileName;
end;

procedure TENForm.FormCreate(Sender: TObject);
begin
  tempPath:=ExtractFilePath(ParamStr(0))+'temp\';
  Path:=ExtractFilePath(ParamStr(0));
  if  (not DirectoryExists(temppath)) then
  MkDir(temppath);
end;

end.
