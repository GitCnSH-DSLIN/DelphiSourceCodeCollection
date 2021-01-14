unit Unit1;

interface

uses
  ComCtrls, StdCtrls, Controls, Forms, ZnMD5, Classes;

type
  TForm1 = class(TForm)  
    Edit1: TEdit;
    znMD51: TznMD5;
    Button1: TButton;
    PBar1: TProgressBar;
    procedure Button1Click(Sender: TObject);
    procedure znMD51Begin(const nMaxSize: Cardinal);
    procedure znMD51End(const nNormal: Boolean; const nMD5String: String);
    procedure znMD51Process(const nHasDone: Cardinal);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.znMD51Begin(const nMaxSize: Cardinal);
begin
  PBar1.Max := nMaxSize;
end;

procedure TForm1.znMD51End(const nNormal: Boolean;
  const nMD5String: String);
begin
  if nNormal then
  begin
     PBar1.Position := 0;
     Edit1.Text := nMD5String;
  end else Edit1.Text := 'Md5����Ϊ���';
end;

procedure TForm1.znMD51Process(const nHasDone: Cardinal);
begin
  PBar1.Position := nHasDone;
  {ע��: ���Ǵ�ŵĽ���,����ȷ}
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ZnMd51.SourceFile := Application.ExeName;
  ZnMd51.MD5_File;
end;

{-----------------------------  ����˵��----------------------------------------
  ����:
  &.SourceFile,SourceStr: ��Md5������ļ�,�ַ���
  &.Busy: ZnMd5�Ƿ���������,True/False

  ����:
  &.MD5_File: ��SourceFile��������
  &.MD5_String: ��SourceStr��������
  &.StopZnMD5: ��Busy=Trueʱ,�жϲ���
  &.GetMD5String: ��ȡ���һ��MD5�����ֵ

  ����: dmzn dmzn@163.com 2006-02-08
--------------------------------------------------------------------------------}

end.
