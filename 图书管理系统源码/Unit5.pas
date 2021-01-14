unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, JPEG, StdCtrls;

type
  TForm5 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.FormShow(Sender: TObject);
begin
  //-----------����LABEL��ʾλ��--------
  Label1.Font.Color:=clFuchsia;
  Label1.Font.Size:=18;
  Label1.Transparent:=true;
  label1.Left:=(form5.Width-label1.Width) div 2;
end;

procedure TForm5.FormCreate(Sender: TObject);
var
  JPEG:TJPEGImage;     //JPEGͼƬ��
  Textfile1:Textfile;
  i:integer;
  s:string;
begin
//--------------������ͼƬ����--------
  JPEG:=TJPEGImage.Create ; //����TPicture�Ķ���ת��bitmap��JPEG
  //�������λͼ��ֱ������JPEG����
  JPEG.LoadFromFile(extractfilepath(application.ExeName)+'RES\BK.jpg');
  image1.Picture.Assign(JPEG);
  image1.stretch:=true;
  image1.Enabled:=true;
  JPEG.Free;
//-----------��ȡ�ı��ļ�-------------
  AssignFile(Textfile1, 'sys.txt');
  reset(Textfile1);       //���ļ�
  while not eof (Textfile1) do
  begin
    readln(Textfile1, s);
    Label1.Caption:=s+'         ';
  end;
  closefile(Textfile1);

end;

end.
