unit Unit1;                      //��Ԫ�ļ���

interface                        //���ǽӿڹؼ��֣���������ʶ�ļ������õĵ�Ԫ�ļ�

uses                             //�����õ��Ĺ�����Ԫ
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type                              //���ﶨ���˳�����ʹ�õ�������Լ��������Ӧ���¼�
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private                         //����˽�б�����˽�й���
    { Private declarations }
  public                          //���幫�������͹�������
    { Public declarations }
  end;

var                               //�������ʹ�õĹ�������
  Form1: TForm1;

implementation                    //�������ʵ�ֲ���

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
ShowMessage('��ӭʹ��Delphi 7');  //��ʾ��ӭ��ʾ��
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
Close;									        	//�˳�Ӧ�ó���
end;

end.
