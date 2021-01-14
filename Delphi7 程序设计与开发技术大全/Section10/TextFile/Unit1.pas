unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  MyTextFile:TextFile;
begin
  AssignFile(MyTextFile,'TextFile.txt');
  Reset(MyTextFile);
  try
    Writeln(MyTextFile,'����д�롣');
  except
    ShowMessage('����д�롣');
  end;
  CloseFile(MyTextFile);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  MyTextFile:TextFile;
begin
  AssignFile(MyTextFile,'TextFile.txt');
  Rewrite(MyTextFile);
  try
    Writeln(MyTextFile,Memo1.Lines.Text); //��Memo1������д���ı��ļ�
  finally
    CloseFile(MyTextFile);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  MyTextFile:TextFile;
begin
  AssignFile(MyTextFile,'TextFile.txt');
  Append(MyTextFile);
  try
    Writeln(MyTextFile,'���ļ�ĩβ׷�����֡�');
    Flush(MyTextFile);  //ȷ���ı��ļ��Ѿ���д��
  finally
    CloseFile(MyTextFile);
  end;
end;

end.
