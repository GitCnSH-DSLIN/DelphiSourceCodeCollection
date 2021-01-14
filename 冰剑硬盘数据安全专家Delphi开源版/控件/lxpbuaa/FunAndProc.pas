unit FunAndProc;

interface

  uses Windows, Classes, SysUtils;

const   
  DefaultPort = 5643;           //������ȱʡ�����˿�
  KEY_Clt: Array[1..4] of String =      //�ӿͻ��˷�����������
    ('AskForFilesName',         //�����ļ���
     'AskForFilesLength',       //�����ļ�����
     'AskForFilesData',         //�������ļ�
     'WanttoDisConnect');       //�ļ�������ɣ���֪��������ӿ��Թر���
  KEY_Srv: Array[1..2] of String =      //�ӷ���˷����������ƣ�
    ('Return1',         //��������������ļ������ļ���֮����FilesNameSepStr�ָ�
     'Return2');        //��������������ļ����ȣ��ļ�����֮����FilesLengthSepStr�ָ�
  FilesNameSepStr = '|';
  FilesLengthSepStr = ',';


function StringToStrings(SepStr: String; S: String): TStrings;

function StringsToString(SepStr: String; Strs: TStrings; GetFileName: Boolean = False): String;

function Get_ComputerName: String;

implementation

function StringToStrings(SepStr: String; S: String): TStrings;
var
  P: Integer;  
begin
  Result := TStringList.Create;
  P := Pos(SepStr, S);
  while P <> 0 do
  begin
    Result.Add(Copy(S, 1, P-1));
    Delete(S, 1, P-1+Length(SepStr));
    P := Pos(SepStr,S);
  end;
  Result.Add(S);
end;

function StringsToString(SepStr: String; Strs: TStrings; GetFileName: Boolean = False): String;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to Strs.Count-1 do
  if not GetFileName then
    Result := Result + SepStr + Strs[I]
  else
    Result := Result + SepStr + ExtractFileName(Strs[I]);
  Delete(Result, 1, Length(SepStr));
end;

function Get_ComputerName: String;
var
  iSize: LongWord;
  ComputerName: PChar;
begin
  iSize := MAX_COMPUTERNAME_LENGTH + 1;
  GetMem(ComputerName,iSize);
  GetComputerName(ComputerName,iSize);
  Result := ComputerName;
  FreeMem(ComputerName);
end;



end.
 