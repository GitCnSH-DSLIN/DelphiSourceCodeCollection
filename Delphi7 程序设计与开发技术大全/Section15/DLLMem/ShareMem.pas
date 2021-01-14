unit ShareMem;

interface

uses windows;

type
  TShareData = Integer ;
  PShareData = ^TShareData;

const
  SHAREDATA_SIZE = SizeOf(TShareData);
  MapFileNamw = 'DLLMemTest';

var

  MapHandle:THandle ;
  ShareData:PShareData ;

  procedure DLLEntryPoint(Reason:DWord);
  procedure OpenShareData;
  procedure CloseShareData;
  procedure SetShareData(value:TShareData);stdcall;
  function GetShareData:TShareData ;stdcall;

implementation

uses SysUtils;

procedure DLLEntryPoint(Reason:DWord);
begin
  case Reason of
    DLL_PROCESS_ATTACH:OpenSharedata;
    DLL_PROCESS_DETACH:CloseShareData ;
  end;
end;

procedure OpenShareData;
begin
  MapHandle := CreateFileMapping($FFFFFFFF,nil,
    PAGE_READWRITE,0,SHAREDATA_SIZE,MapFileNamw); {�����ڴ�ӳ���ļ�}
  if MapHandle = 0 then                           {�������}
    Raise Exception.Create('�����������ݵ�Buffer���ɹ�!');
  ShareData := MapViewOfFile ( MapHandle, File_Map_Write,
    0, 0, SHAREDATA_SIZE );                       {����ڴ�ӳ���ļ��ľ��}
end;

procedure CloseShareData;
begin
  UnMapViewOfFile(ShareData);  {�ͷ��ڴ�ӳ���ļ�}
  CloseHandle(MapHandle );
end;

procedure SetShareData(value:TShareData);stdcall;
begin
  ShareData^ := value ;
end;

function GetShareData:TShareData ;stdcall;
begin
  Result := ShareData^; 
end;   

end.
