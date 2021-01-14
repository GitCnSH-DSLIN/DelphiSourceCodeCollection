unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

const
  WM_DATA = WM_USER + 1024;
type
  PShareMem = ^TShareMem;
  TShareMem = record
    Data: array[0..255] of char;
  end;
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Form1: TForm1;
  PShare: PShareMem;
implementation

{$R *.DFM}
var
  HMapping: THandle;
  HMapMutex: THandle;
const
  MAPFILESIZE = 1000;
  REQUEST_TIMEOUT = 1000;

procedure OpenMap;  //�򿪽��������ڴ�
begin
   {����һ���ļ�ӳ���ں˶���}
  HMapping := CreateFileMapping(
    $FFFFFFFF,
    nil,
    PAGE_READWRITE,
    0,
    SizeOf(TShareMem),
  pchar('Map Name')  {ӳ���ļ���������'Map Name'}
    );
  if (hMapping = 0) then
  begin
    ShowMessage('���ܴ����ڴ�ӳ���ļ�');
    Application.Terminate;
    exit;
  end;
  {��ӳ���ļ�ӳ�䵽���̵ĵ�ַ�ռ�}
  PShare := PShareMem(MapViewOfFile(HMapping, FILE_MAP_ALL_ACCESS, 0, 0, 0));
  if PShare = nil then
  begin
    CloseHandle(HMapping);
    ShowMessage('Can''t View Memory Map');
    Application.Terminate;
    exit;
  end;
end;

procedure CloseMap; //�رչ����ڴ�
begin
  if PShare <> nil then
    {�ӽ��̵ĵ�ַ�ռ��г����ļ����ݵ�ӳ��}
    UnMapViewOfFile(PShare);
  if HMapping <> 0 then
    CloseHandle(HMapping);    //�ر�ӳ���ļ�
end;

function LockMap: Boolean;     //�����������
begin
  Result := true;
   {�����������}
  HMapMutex := CreateMutex(nil, false,
    pchar('MY MUTEX NAME GOES HERE'));
  if HMapMutex = 0 then
  begin
    ShowMessage('���ܴ����������');
    Result := false;
  end else begin
    if WaitForSingleObject(HMapMutex, REQUEST_TIMEOUT)
      = WAIT_FAILED then
    begin
      ShowMessage('���ܶԻ���������!');
      Result := false;
    end
  end
end;

procedure UnlockMap;  //�ͷŻ������
begin
  ReleaseMutex(HMapMutex);
  CloseHandle(HMapMutex);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  str: pchar;
begin
  str := pchar('�򵥵Ĺ����ڴ������');
  CopyMemory(@(pShare^.data), Str, Length(str));
  {������Ϣ����������}
  PostMessage(FindWindow(nil, 'ӳ���ڴ���ն�'), WM_DATA, 1, 1)
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  UnlockMap;
  CloseMap;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  OpenMap;
  LockMap;
end;

end.

