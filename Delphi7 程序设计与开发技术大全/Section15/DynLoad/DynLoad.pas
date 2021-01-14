unit DynLoad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  THandle = integer;
  TAdd10 = function(number:integer):integer; stdCall;
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
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
  temp:integer;
  handle:THandle ;
  FPointer: TFarProc;
  MyFunc : TAdd10 ;
begin
  try
    temp := StrToInt(Edit1.Text );
    handle := LoadLibrary('MyFirstDLL');                {װ��DLL���ڴ�}
    if handle <> 0 then
    try
      FPointer  := GetProcAddress(handle ,'Add10');     {��ú�������ڵ�ַ}
      if FPointer  <> nil then
      begin
        MyFunc := TAdd10(FPointer) ;
        temp := MyFunc(temp) ;                          {ʹ�ú�������}
        Edit1.Text := IntToStr(temp);
      end;
    finally
      FreeLibrary(handle);                              {�ͷ�DLL}
    end
    else
      ShowMessage('δ�ҵ���̬���ӿ�MyFirstDLL.dll');
  except
    ShowMessage('������һ��������');
  end;
end;

end.
