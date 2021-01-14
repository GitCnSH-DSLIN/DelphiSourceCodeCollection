unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

const
  WM_DATA = WM_USER + 1024;      //�Զ�����Ϣ
type
  PShareMem = ^TShareMem;
  TShareMem = record
    Data: array[0..255] of char;  //�����ڴ棬ע��Ҫ�뷢�����ݶ˵Ķ�����ͬ
  end;
  TMyForm = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure getShareInfo(var Msg: TMessage); message WM_DATA; {����WM_DATA}
  end;

var
  MyForm: TMyForm;
  PShare: PShareMem;
  MapHandle: THandle;

implementation

{$R *.DFM}

procedure TMyForm.getShareInfo(var Msg: TMessage); {����WM_DATA}
begin
  if msg.LParam=1 then {���Զ������Ϣ����}
    Memo1.Lines.Add(PShare^.Data);
end;

procedure TMyForm.FormCreate(Sender: TObject);
begin
  MapHandle := OpenFileMapping(FILE_MAP_WRITE, {��ȡ��ȫ����ӳ���ļ�}
    False, {���ɼ̳е�}
    pchar('Map Name')); {ӳ���ļ�����}
  if MapHandle = 0 then
  begin
    ShowMessage('���ܶ�λ�ڴ�ӳ���ļ��飡');
    Halt;
  end;
  PShare := PShareMem(MapViewOfFile(MapHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0));
  if PShare = nil then
  begin
    CloseHandle(MapHandle);
    ShowMessage('Can''t View Memory Map');
    Application.Terminate;
    Exit;
  end;
  FillChar(PShare^, SizeOf(TShareMem), 0);
end;

procedure TMyForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseHandle(MapHandle);
end;

end.

