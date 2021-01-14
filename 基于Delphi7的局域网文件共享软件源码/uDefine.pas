unit uDefine;

interface

uses windows;

type
  //��������
  TRequestType = (RT_Info,RT_Block);

  //������Ϣ
  TInfo = Record
    FileName: Array [0..255] of Char;
    Size: Integer;
    BlockPostion: Integer;
    BlockCount: Integer;
    FindData: TWin32FindData;
  end;

  //����
  TRequest = Record
    RequestType: TRequestType;
    Info: TInfo;
  end;

  //�ļ���
  TBlock =  Record
    Data: Array [0..4095] of Byte;
    DataSize: Integer;
  end;

  //��Ӧ�ļ���Ϣ
  TResponseBlock = Record
    Info: TInfo;
    Block: TBlock;
  end;

  function GetBlockCount(Size:Integer;BlockSize:Integer):Integer;

implementation

function GetBlockCount(Size:Integer;BlockSize:Integer):Integer;
begin
  Result := (Size div BlockSize);
  if (Size mod BlockSize) > 0 then
    Inc(Result);
end;

end.
