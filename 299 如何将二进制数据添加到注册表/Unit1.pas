unit Unit1;

interface

uses
  Windows, Registry,Messages,SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
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
  type
  TBinData = record
    Index : integer;
    Text : string[100];
  end;
  var
  Reg : TRegistry;
  BinData : TBinData;
begin
  BinData.Index:=7;
  BinData.Text:='This is just a text, index doesn''t mean anything';
  Reg := TRegistry.Create;
  //����ע������
  with Reg do begin
    OpenKey('\Software\MyCompany\MyApplication', true);
    //�򿪼�
    WriteBinaryData('BinData',BinData,SizeOf(TBinData));
    //�������
    Free;
  end;
end;

end.
