unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,ShellApi;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure WMDROPFILES(var Message: TWMDROPFILES);message WM_DROPFILES;    
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  DragAcceptFiles(Form1.Handle, True);
end;

procedure TForm1.WMDROPFILES(var Message: TWMDROPFILES);
var
  NumFiles : longint;
  i : longint;
  buffer : array[0..255] of char;
begin
  NumFiles := DragQueryFile(Message.Drop,$FFFFFFFF,nil,0);
  //�ж����ļ�������
  for i := 0 to (NumFiles - 1) do begin
  //ѭ��������µ��ļ����˴�ֻ����ʾ���ļ���
    DragQueryFile(Message.Drop,
                  i,
                  @buffer,
                  sizeof(buffer));
   //��ȡ�ļ��������浽buffer
    Form1.Memo1.Lines.Add(buffer);
  //��ʾ�ļ���
  end;
  DragFinish(Message.Drop);
//�Ϸ���ϣ��ͷ�ϵͳ�ڴ����ļ���ʱ������ڴ档
end;

end.
