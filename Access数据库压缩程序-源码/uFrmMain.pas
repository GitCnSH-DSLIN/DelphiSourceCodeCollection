unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComObj, ActiveX, bsSkinData, BusinessSkinForm, bsSkinCtrls,
  StdCtrls, Mask, bsSkinBoxCtrls, bsSkinShellCtrls, bsMessages;

type
  TfrmMain = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinData1: TbsSkinData;
    bsCompressedStoredSkin1: TbsCompressedStoredSkin;
    bsSkinLabel1: TbsSkinLabel;
    edtDatabaseFile: TbsSkinFileEdit;
    bsSkinLabel2: TbsSkinLabel;
    edtPassword: TbsSkinPasswordEdit;
    bsSkinButton1: TbsSkinButton;
    bsSkinButton2: TbsSkinButton;
    SkinMessage: TbsSkinMessage;
    procedure bsSkinButton2Click(Sender: TObject);
    procedure bsSkinButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function CompactDatabase(const AFileName, APassWord: string): Boolean;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

function TfrmMain.CompactDatabase(const AFileName, APassWord: string): Boolean;
const
  SConnectionString = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%s;'
    + 'Jet OLEDB:Database Password=%s;';
var
  SPath: string;
  SFile: array[0..254] of Char;
  STempFileName: string;
  JE: OleVariant;

  function GetTempDir: string;
  var
    Buffer: array[0..MAX_PATH] of Char;
  begin
    ZeroMemory(@Buffer, MAX_PATH);
    GetTempPath(MAX_PATH, Buffer);
    Result := IncludeTrailingBackslash(StrPas(Buffer));
  end;

begin
  Result := False;
  SPath := GetTempDir; //ȡ��Windows��Temp·��
  GetTempFileName(PChar(SPath), '~ACP', 0, SFile); //ȡ��Temp�ļ���,Windows���Զ�����0�ֽ��ļ�
  STempFileName := SFile; //PChar->String
  if not DeleteFile(STempFileName) then Exit; //ɾ��Windows������0�ֽ��ļ�
  try
    JE := CreateOleObject('JRO.JetEngine'); //����OLE����,��������OLE���󳬹��������Զ��ͷ�
    OleCheck(JE.CompactDatabase(Format(SConnectionString, [AFileName, APassWord]),
      Format(SConnectionString, [STempFileName, APassWord]))); //ѹ�����ݿ�
    //���Ʋ�����Դ���ݿ��ļ�,�������ʧ���������ؼ�,ѹ���ɹ���û�е������Ĺ���
    Result := CopyFile(PChar(STempFileName), PChar(AFileName), False);
    DeleteFile(STempFileName); //ɾ����ʱ�ļ�
  except
    //ѹ��ʧ��
  end;
end;

procedure TfrmMain.bsSkinButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.bsSkinButton1Click(Sender: TObject);
begin
  if Trim(edtDatabaseFile.Text) <> '' then
    if SkinMessage.MessageDlg('ѹ�����ݿ�������ܻ���Ҫ�ܳ�ʱ�䣬�ڼ��벻Ҫ�رձ�����',
      mtWarning, [mbOK, mbCancel], 0) = idOK then
    if CompactDatabase(edtDatabaseFile.Text, edtPassword.Text) then
      SkinMessage.MessageDlg('ѹ�����ݿ�ɹ�', mtInformation, [mbOK], 0)
    else
      SkinMessage.MessageDlg('ѹ��ʧ�ܣ����������ļ������û�а�װ ADO ���棬���������ݿ��ļ��������������',
        mtError, [mbOK], 0);

end;

end.
