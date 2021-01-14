unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormPaint(Sender: TObject);
var
  FLogFont : tagLogFontA;         //�߼�����--�ṹ������
  hTempFont, hPrevFont: HFONT;    //������
  hTempDC: HDC;                   //�豸�������ͼ���豸���
  TempString: string;             //���������
begin
  FLogFont.lfHeight := 100;       //�ָ�
  FLogFont.lfWidth := 50;         //�ֿ�
  FLogFont.lfWeight := 5;         //����ʻ���ϸ�̶�
  FLogFont.lfUnderline := 0;      //û���»���
  FLogFont.lfStrikeOut := 0;      //û��ɾ����
  FLogFont.lfItalic := 0;         //б��Ч����
  FLogFont.lfCharSet := GB2312_CHARSET; //�ַ���
  FLogfont.lfEscapement := 450;   //��б��
  FLogFont.lfOrientation := 450;  //��������б��ȡֵͬ
  FLogFont.lfFaceName := '����';  //��������
  //�����߼�����
  hTempFont := CreateFontIndirect(FLogFont);
  TempString := '��б';
  //ȡ�ô��ڵ��豸���
  hTempDC := GetDC(Handle);
  //ȡ�������豸�ĵ�ǰ���壬���滻Ϊ������
  hPrevFont := SelectObject(hTempDC, hTempFont);
  //�����豸���ڵ�����ɫ��
  SetTextColor(hTempDc, clRed);
  //�������
  TextOut(hTempDc, 100 , 150, PChar(TempString), Length(TempString));
  //�ָ�ԭ�е�����
  SelectObject(hTempDc, hPrevFont);
  //ɾ���߼�����
  DeleteObject(hTempFont);
  //�ͷ��豸�ӿ�
  ReleaseDC(Handle, hTempDC);
end;

end.
