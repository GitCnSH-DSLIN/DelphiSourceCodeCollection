unit Untfun;

interface

 uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, ComCtrls, ToolWin,WinSock,StdCtrls, jpeg,
  REGISTRY,ComObj, WordXP,inifiles,Math,ActiveX,ShlObj;


  const

  // ������Ϣ
{$IFDEF GB2312}
  SCnInformation = '��ʾ';
  SCnWarning = '����';
  SCnError = '����';
{$ELSE}
  SCnInformation = 'Information';
  SCnWarning = 'Warning';
  SCnError = 'Error';
{$ENDIF}

  C1=52845; //�ַ��������㷨�Ĺ���
  C2=22719; //�ַ��������㷨�Ĺ���



//��================1����չ��MDI�йز�������  ===================��//

  procedure OpenChildForm(FormClass: TFormClass; var Fm; AOwner:TComponent);
  procedure OpenForm(FormClass: TFormClass; var fm; AOwner: TComponent);

  function IsForm(formClass:TFormClass) : boolean; //�ж�ָ�����ڴ���û��
  function isapprun(str:string):boolean;//�ж�ָ����������û��
  function CloseApp(ClassName: String): Boolean;   //�ر��ⲿӦ�ó���

//��================2����չ�������йز�������  ===================��//



  function GetHostIP:string;   {* ��ȡ�������IP��ַ}
  function GetComputerName:string;  {* ��ȡ������������}
  function GetCurrentUserName : string;  //*��ȡ��ǰWindows��¼�����û�


//��================3�� ��չ��ע���йز�������  ===================��//

  function getzcm:string;
  function readzcm_ini(s:string):Integer ;
  function writezcm_ini(i:Integer;s:string):Boolean ;
  function readzcm_reg(s:string):integer;
  function writezcm_reg(s:string):Boolean;

  function GetHDNumber(Drv : String): DWORD; //�õ�Ӳ�����к�
  function Serial(Num:DWORD):string; //����������û���������ע����ģ���ͨ����Ӳ�����кű��������
  
  function StrToHex(AStr: string): string; {* �ַ�ת����ʮ������}
  function HexToStr(AStr: string): string; {* ʮ������ת�����ַ�}
  function TransChar(AChar: Char): Integer;

  function Encrypt(const S: String; Key: Word): String;//�ַ������ܺ���
  function Decrypt(const S: String; Key: Word): String; //�ַ������ܺ���

 //��================4�� ��չ���ļ�·������  ===================��//

 function PathWithSlash(const Path: string): string;
 {���ܣ���·����Ϊ��\���ŵ�·��}

 function PathGetWindowsPath: string;  //WINDOWS·��\
 function PathGetSystemPath: string;   //SYSTEM32·��\
 function getsyspath:string;          //SYSTEM·��\
 function getAppPath : string;        //����·��   ��"\"
 function GetTempDirectory: String;    //��ʱĿ¼\

 function shFileCopy(srcFile,destFile:String;bDelDest:boolean=true):boolean;// ���ܣ���ȫ�ĸ����ļ�
  { ���ܣ���ȫ�ĸ����ļ� ,srcFile��destFile��Դ�ļ���Ŀ���ļ� ,
 bDelDest�����Ŀ���ļ��Ѿ����ڣ��Ƿ񸲸� ,����ֵ��true�ɹ���falseʧ��}

 procedure DelTree(DirName:String);
 {��C:\123  ��C:\123\����,�ڲ��Ჹ�� }

 function EmptyDirectory(TheDirectory :String ; Recursive : Boolean):Boolean;
 {ɾ��Ŀ¼�ڵ��ļ�����Ŀ¼;��:"C:\123\" }

 procedure creatdesktoplink(Linkname:string);
 {���������ݷ�ʽ��LinknameΪ��������Ҫ��ʾ���ַ�}


//��================5 ��չ���ַ�����������  ===================��//

function InStr(const sShort: string; const sLong: string): Boolean;     {����ͨ��}
{* �ж�s1�Ƿ������s2��}

function IntToStrEx(Value: Integer; Len: Integer; FillChar: Char = '0'): string;  {����ͨ��}
{* ��չ����ת�ַ�������  Example:   IntToStrEx(1,5,'0');   ���أ�"00001"}

function IntToStrSp(Value: Integer; SpLen: Integer = 3; Sp: Char = ','): string;  {����ͨ��}
{* ���ָ������������ַ�ת��}

function ByteToBin(Value: Byte): string; {����ͨ��}
{* �ֽ�ת�����ƴ�}

function StrRight(Str: string; Len: Integer): string;  {����ͨ��}
{* �����ַ����ұߵ��ַ�   Examples: StrRight('ABCEDFG',3);   ����:'DFG' }

function StrLeft(Str: string; Len: Integer): string; {����ͨ��}
{* �����ַ�����ߵ��ַ�}

function Spc(Len: Integer): string;  {����ͨ��}
{* ���ؿո�}

function Replace(Str,s1,s2:string;CaseSensitive:Boolean):string;  {����ͨ��}
{* ���ؽ�ָ���ַ�s1���ַ���s2�滻����ַ�������֧�ִ�Сд������CaseSensitive����}
{example: replace('We know what we want','we','I',false) = 'I Know what I want'}

function Replicate(pcChar:Char; piCount:integer):string;
{��һ���ַ����в���ĳ���ַ�����λ��}

function StrNum(ShortStr:string;LongString:string):Integer;     {����ͨ��}
{* ����ĳ���ַ�����ĳ���ַ����г��ֵĴ���}


function PadLStr(psInput:String; piWidth:Integer; pcPadWith:Char):String;        {����ͨ��}
{* ���ش�psInput�ַ�����߿�ʼ��pcPadWith�����ܳ���ΪPiWidth���ַ���}

function PadRStr(psInput:String; piWidth:Integer; pcPadWith:Char):String;       {����ͨ��}
{* ���ش�psInput�ַ����ұ߿�ʼ��pcPadWith�����ܳ���ΪPiWidth���ַ���}

function PadCStr(psInput:String; piWidth:Integer; pcPadWith:Char):String;        {����ͨ��}
{* ���ش�psInput�ַ������߿�ʼ��pcPadWith�����ܳ���ΪPiWidth���ַ���}

function ChrTran(psInput:String; pcSearch:Char; pcTranWith:Char):String;        {����ͨ��}
{* �����滻���ַ���[�滻�����ַ�] Examples: ChrTran('abCdEgdlkh','d','#')�� ����'abC#Eg#lkh'}

function StrTran(psInput:String; psSearch:String; psTranWith:String):String;        {����ͨ��}
{* �����滻���ַ���[�滻�ַ���] Examples: StrTran('aruyfbn','ruy','=====');�� ����'a=====fbn'}

function Stuff(psInput:String; piBeginPlace,piCount:Integer; psStuffWith:String):String;
{ *�����滻���ַ���[�滻�ַ���] Examples: Stuff('ABCDEFGHI',3,4,'12345')������'AB12345GHI'}

function IsDigital(Value: string): boolean;
{����˵�����ж�string�Ƿ�ȫ������}

function RandomStr(aLength : Longint) : String;
{����ַ�������}

procedure TxttoWords(const S: string; words: TstringList);  
{����˵�����ֽ�ɵ������֣�û�����룬����ͨ��}

function tx(i: integer): string;      
{����˵���������ֱ�ɺ��֣���1��һ}

 //==================================== �Զ�����ַ���
  function deleleftdot(str:string):string;   //ɾ�����׵��
  function deleleftdun(str:string):string; //ɾ�����׶ٺ�
  function deleleftdigital(str:string;partstr:string):string;

  function replacing(S,source,target:string):string;   
  {����:��S����target���滻source,�ܹ���ȫȥ��}

  function balancerate(source,target:string;pdxz:Boolean):Real;
  {����:���������������ͬ�ľ���,pdxzΪ�ǲ����ж�ѡ��,����ʱ�в��,�Զ���}

 //����Ϊ    ����ʱ��
 function TimeToSecond(const H, M, S: Integer): Integer;
 function TimeSecondToTime(const secs: Integer):string;
 //��================6 ��չ��WORD��������  ===================��//

 function CONNECTWORD: Boolean;
 {���ܣ�����������}

 procedure addstrtoword(text:string;align:Boolean;fontname:WideString;fontsize:integer);
 {��WORD��׷���ַ���˳��Ϊ׷�����ݡ����뷽ʽ�����塢�����С}

 procedure Addbmptoword(STR:string);
 {���ܣ���WORD����ͼƬ��STRΪ�ļ�·��}
 
 procedure addstrtorich(s, fontname: string; fontsize,alimen: Integer; Richedit: TRichEdit);
 {���ܣ���RICHEDIT�ؼ���׷�����ݣ�˳��Ϊ���ݡ����塢�����С�����뷽ʽ��OΪ��1Ϊ�У�2Ϊ�У����ؼ�NAME}

 procedure  loadpicture(str:string;var image:TImage);
 {���ܣ���ͼ���ļ���STRΪ·�ۣ�IMAGEΪ��ʾ�Ŀؼ�}

 //��================7 ��չ�Ķ�ȡƤ���ļ��ĺ���  ===================��//
  function  readskinfile(Keyname:string):string;
  {���ܣ�����Ƥ��·�ۣ�Keynameһ�����Ϊ�������ƣ�����ʶ��}

  procedure writeskinfile(keyname,filename:string);
  {���ܣ�д��Ƥ��·�ۣ�Keynameһ�����Ϊ�������ƣ�����ʶ��}

//===================8.ado===========
  function setadoaccess(mdbpath:string;passwd:string):string;
  // ��������
 


 var
   msword: Variant;


  implementation

procedure OpenChildForm(FormClass: TFormClass; var Fm; AOwner:TComponent);
var
  I: Integer;
  Child: TForm;
begin
  for I := 0 to Screen.FormCount - 1 do
   if Screen.Forms[I].ClassType = FormClass then
     begin
       Child := Screen.Forms[I];
       if Child.WindowState = wsMinimized then
       ShowWindow(Child.Handle, SW_SHOWNORMAL)
       else
       ShowWindow(Child.handle,SW_SHOWNA);
       if (not Child.Visible) then Child.Visible := True;
        Child.BringToFront;
        Child.Setfocus;
        TForm(Fm) := Child;
        Exit;
     end;
    Child := TForm(FormClass.NewInstance);
    TForm(Fm) := Child;
    Child.Create(AOwner);
end;


procedure OpenForm(FormClass: TFormClass; var fm; AOwner: TComponent);
var
  i: integer;
  Child: TForm;
begin
  for i := 0 to Screen.FormCount - 1 do
    if screen.Forms[i].Owner = Aowner then
     begin
        //����һ���ڴ�,�������µĴ���
        if Screen.Forms[i].ClassType = FormClass then
          begin
            Child := Screen.Forms[i];
            if Child.WindowState = wsMinimized then    //���Ѵ��ڵ����ٻ��Ĵ���,����ԭ��ʾ
            ShowWindow(Child.handle, SW_SHOWNORMAL)
            else
            ShowWindow(Child.handle, SW_SHOWNA);
            if (not Child.Visible) then Child.Visible := True;
            Child.BringToFront;
            Child.Setfocus;
            TForm(fm) := Child;
            exit;
          end;

      exit;
   end;


  Child := TForm(FormClass.NewInstance);
  TForm(fm) := Child;
  Child.Create(AOwner);
end;

function readzcm_reg(s:string):integer;
var
  re_id:integer;
  registerTemp : TRegistry;
  re_code:string;
  ini_num:Integer;
  Temres:Integer;
begin
  Temres:=0;
  registerTemp := TRegistry.Create;
    with registerTemp do
    begin
      RootKey:=HKEY_LOCAL_MACHINE;
       try
       if OpenKey('Software\Microsoft\Windows\'+s,True) then// ��һĿ¼
          begin                               //wwwwwwwwwwwwwwwww 
            if ValueExists('reg_code') then  //�������
            begin
              re_code:=ReadString('reg_code');
              if re_code=getzcm then Temres:=0;// ��ע��
            end
            else
            begin  //���ע�����ֵ������      //eeeeeeeeeeeee

              ini_num:=readzcm_ini('xlxt');   //����INI��¼�����д���

              //�������϶��Ƿ�ע���û�
              if valueexists('gc_id')=False then   //��NOT������
              begin //�ж�����ڷ�     //ggggggggggggggg
                if ini_num =0 then
                begin
                  Writeinteger('gc_id',1);//�粻��������
                  writezcm_ini(1,'xlxt');
                  Temres:=1;
                end
                else
                Writeinteger('gc_id',ini_num);
              END                     //gggggggggggggg
              else
              begin //�ж�����ڷ�   rrrrrrrrrrrrrrrrrr
                re_id:=readinteger('gc_id');//������־ֵ
                re_id:=max(re_id,ini_num);
                if (re_id>500) or (re_id<1) then  Temres :=1000//����1000����Ӧע�ᡣ
                else
                begin
                  re_id:=re_id+1; //���ֵΪ500 ,������
                  Writeinteger('gc_id',re_id);
                  writezcm_ini(re_id,'xlxt');
                  Temres :=re_id;
                end;
              end;  //IF  EXSIT      rrrrrrrrrrrrrrrrrrrr
         end;//�����ֵ������        eeeeeeeeeeeeeeeeeeee
       end;    //      wwwwwwwwwww
       
     finally
     CloseKey;
     Free;
   end;
 Result :=Temres;
end; //with registerTemp do

end;


function writezcm_reg(s:string):Boolean;
VAR
  REG:TREGISTRY;
  str:string;
begin
   Result :=False;
   str:=getzcm;
   REG:=TREGISTRY.Create ;
      WITH REG DO
        BEGIN
          ROOTKEY:=HKEY_LOCAL_MACHINE;
          TRY
          if OpenKey('Software\Microsoft\Windows\'+s,True) then
            begin
              WriteString('reg_code',str);
              Writeinteger('gc_id',0);//�������ע������ȷ���򽫱�־ֵ��Ϊ0 ����ע�ᡣ
              Result :=True;
            end;
          FINALLY
          CloseKey;
          Free;
          END;
       end;
end;

function getzcm:string;
var
  str,temstr:string;
  i:Integer;
begin
  str:=Trim(Serial(GetHDNumber('C:')));
  temstr:=Copy(str,1,10);
  i:=Length(temstr);
  if i<10 then temstr:=temstr+copy('luzhenfeng',1,10-i);
  Result :=temstr ;
end;

function readzcm_ini(s:string):Integer ;
var
  inifile:TIniFile ;
  IniFileName:string;
  num:Integer ;
begin
  IniFileName:= PathGetWindowsPath+'myset.ini' ;
  inifile:=TInifile.Create(IniFileName);
  try
  num:=inifile.ReadInteger(s,'recorder',0);
  finally
  inifile.Free;
  end;

  Result :=num;  
end;

function writezcm_ini(i:integer;s:string):Boolean ;
var
  inifile:TIniFile ;
  IniFileName:string;
  BB:Boolean ;
begin

  IniFileName:= PathGetWindowsPath+'myset.ini' ;
  inifile:=TInifile.Create(IniFileName);
  try
    inifile.WriteInteger(s,'recorder',i);
    BB :=True;
  finally
    inifile.Free ;
  end;
  result:=BB;
end;

 //-------------------------------------  ����ע����
function GetHDNumber(Drv : String): DWORD; //�õ�Ӳ�����к�
var
 VolumeSerialNumber : DWORD;
 MaximumComponentLength : DWORD;
 FileSystemFlags : DWORD;
begin
 if Drv[Length(Drv)] =':' then Drv := Drv + '\';
 GetVolumeInformation(pChar(Drv),
            nil,
            0,
            @VolumeSerialNumber,
            MaximumComponentLength,
            FileSystemFlags,
            nil,
            0);
 Result:= (VolumeSerialNumber);
 //GetVolumeInformation("C:\\",NULL,NULL,&dwIDESerial,NULL,NULL,NULL,NULL);
end;

function Serial(Num:DWORD):string; //����������û���������ע����ģ���ͨ����Ӳ�����кű��������
var sNum:string; inChar:array[1..4]of char;
begin 

 Num:=Num xor 8009211011;
 sNum:=inttostr(Num);
 inChar[1]:=char(((integer(sNum[1])+integer(sNum[2]))mod 5)+integer('a'));
 inChar[2]:=char(((integer(sNum[3])+integer(sNum[4]))mod 5)+integer('a'));
 inChar[3]:=char(((integer(sNum[5])+integer(sNum[6]))mod 5)+integer('a'));
 inChar[4]:=char(((integer(sNum[7])+integer(sNum[8])+integer(sNum[9]))mod 5)+integer('a'));
 insert(inChar[1],sNum,1);
 insert(inChar[4],sNum,3);
 insert(inChar[2],sNum,5);
 insert(inChar[3],sNum,9);
 Result:=sNum;
end;

//��======================�Ͻ��ƺ���������======================��//

function TransChar(AChar: Char): Integer;
begin
   if AChar in ['0'..'9'] then
      Result := Ord(AChar) - Ord('0')
   else
      Result := 10 + Ord(AChar) - Ord('A');
   end;


//�ַ�ת����ʮ������
function StrToHex(AStr: string): string;
var
   I : Integer;
//   Tmp: string;
   begin
      Result := '';
      For I := 1 to Length(AStr) do
      begin
         Result := Result + Format('%2x', [Byte(AStr[I])]);
      end;
      I := Pos(' ', Result);
      While I <> 0 do
      begin
         Result[I] := '0';
         I := Pos(' ', Result);
      end;
end;

//ʮ������ת�����ַ�
function HexToStr(AStr: string): string;
var
   I : Integer;
   CharValue: Word;
   begin
   Result := '';
   for I := 1 to Trunc(Length(Astr)/2) do
   begin
      Result := Result + ' ';
      CharValue := TransChar(AStr[2*I-1])*16 + TransChar(AStr[2*I]);
      Result[I] := Char(CharValue);
   end;
end;

//��======================�ַ������ܺͽ���======================��//

//�ַ������ܺ���
function Encrypt(const S: String; Key: Word): String;
var
   I : Integer;
begin
      Result := S;
      for I := 1 to Length(S) do
      begin
         Result[I] := char(byte(S[I]) xor (Key shr 8));
         Key := (byte(Result[I]) + Key) * C1 + C2;
         if Result[I] = Chr(0) then
            Result[I] := S[I];
      end;
      Result := StrToHex(Result);
end;


//�ַ������ܺ���
function Decrypt(const S: String; Key: Word): String;
var
   I: Integer;
   S1: string;
begin
   S1 := HexToStr(S);
   Result := S1;
   for I := 1 to Length(S1) do
   begin
      if char(byte(S1[I]) xor (Key shr 8)) = Chr(0) then
         begin
            Result[I] := S1[I];
            Key := (byte(Chr(0)) + Key) * C1 + C2; //��֤Key����ȷ�ԡ���
         end
      else
         begin
            Result[I] := char(byte(S1[I]) xor (Key shr 8));
            Key := (byte(S1[I]) + Key) * C1 + C2;
         end;
   end;
end;
//==========================================     �ļ�·��
function PathWithSlash(const Path: string): string;       //��\����
begin
 Result := Path;
 if (Length(Result) > 0) and (Result[Length(Result)] <> '\') then Result := Result + '\';
end;

function PathGetSystemPath: string;   //SYSTEM32·��
var
 Buf: array[0..255] of Char;
begin
 GetSystemDirectory(@Buf, 255);
 Result := PathWithSlash(StrPas(@Buf));
end;

function PathGetWindowsPath: string;  //WINDOWS·��
var
 Buf: array[0..255] of Char;
begin
 GetWindowsDirectory(@Buf, 255);
 Result := PathWithSlash(StrPas(@Buf));
end;

function getsyspath:string; //  ע:MySysPathΪSYSTEM·��
var
MySysPath : PCHAR ;
  begin
  GetMem(MySysPath,255);
  GetSystemDirectory(MySysPath,255);
  result:=PathWithSlash(strpas(mysyspath));
 end;

function getAppPath : string;   //����Ŀ¼��\
var
  strTmp : string;
begin
  strTmp :=ExtractFilePath(application.Exename);
  result := PathWithSlash(strTmp);
end;

function GetTempDirectory: String;    //��ʱĿ¼\
var
TempDir: array[0..255] of Char;
begin
GetTempPath(255, @TempDir);
result:=PathWithSlash(strpas(TempDir));
end; 


//��============================================================��//
//��==================����չ���ַ�����������====================��//
//��============================================================��//
 // �ж�s1�Ƿ������s2��
function InStr(const sShort: string; const sLong: string): Boolean;
var
  s1, s2: string;
begin
  s1 := LowerCase(sShort);
  s2 := LowerCase(sLong);
  Result := Pos(s1, s2) > 0;
end;

// ��չ����ת�ַ��������������ֱ�ΪĿ���������ȡ�����ַ���Ĭ��Ϊ����
function IntToStrEx(Value: Integer; Len: Integer; FillChar: Char = '0'): string;
begin
  Result := IntToStr(Value);
  while Length(Result) < Len do
    Result := FillChar + Result;
end;

// ���ָ������������ַ�ת��
function IntToStrSp(Value: Integer; SpLen: Integer = 3; Sp: Char = ','): string;
var
  s: string;
  i, j: Integer;
begin
  s := IntToStr(Value);
  Result := '';
  j := 0;
  for i := Length(s) downto 1 do
  begin
    Result := s[i] + Result;
    Inc(j);
    try
       if ((j mod SpLen) = 0) and (i <> 1) then
          Result := Sp + Result;
    except
       MessageBox(Application.Handle,' IntToStrSp�����ĵڶ�������ֵ����Ϊ����0 ��',SCnError,16);
       exit;
    end
  end;
end;

// �����ַ����ұߵ��ַ�
function StrRight(Str: string; Len: Integer): string;
begin
  if Len >= Length(Str) then
    Result := Str
  else
    Result := Copy(Str, Length(Str) - Len + 1, Len);
end;

// �����ַ�����ߵ��ַ�
function StrLeft(Str: string; Len: Integer): string;
begin
  if Len >= Length(Str) then
    Result := Str
  else
    Result := Copy(Str, 1, Len);
end;

// �ֽ�ת�����ƴ�
function ByteToBin(Value: Byte): string;
const
  V: Byte = 1;
var
  i: Integer;
begin
  for i := 7 downto 0 do
    if (V shl i) and Value <> 0 then
      Result := Result + '1'
    else
      Result := Result + '0';
end;

// ���ؿո�
function Spc(Len: Integer): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to Len - 1 do
    Result := Result + ' ';
end;

// ���ؽ�ָ���ַ�s1���ַ���s2�滻����ַ�������֧�ִ�Сд������CaseSensitive����}
function Replace(Str,s1,s2:string;CaseSensitive:Boolean):string;
var
   i:integer;
   s,t:string;
begin
   s:='';
   t:=str;
   repeat
      if casesensitive then
         i:=pos(s1,t)
      else
         i:=pos(lowercase(s1),lowercase(t));
         if i>0 then
            begin
               s:=s+Copy(t,1,i-1)+s2;
               t:=Copy(t,i+Length(s1),MaxInt);
            end
         else
            s:=s+t;
   until i<=0;
   result:=s;
end;

function Replicate(pcChar:Char; piCount:integer):string;
begin
	Result:='';
	SetLength(Result,piCount);
	fillChar(Pointer(Result)^,piCount,pcChar)
end;

// ����ĳ���ַ�����ĳ���ַ����г��ֵĴ���}
function StrNum(ShortStr:string;LongString:string):Integer;     {����ͨ��}
var
   i:Integer;
begin
   i:=0;
   while pos(ShortStr,LongString)>0 do
      begin
         i:=i+1;
         LongString:=Copy(LongString,(pos(ShortStr,LongString))+1,Length(LongString)-pos(ShortStr,LongString))
      end;
   Result:=i;
end;


{* ���ش�psInput�ַ�����߿�ʼ��pcPadWith�����ܳ���ΪPiWidth���ַ���}
function PadLStr(psInput:String; piWidth:Integer; pcPadWith:Char):String;
begin
	Result:=Replicate(pcPadWith,piWidth-Length(psInput))+psInput
end;

{* ���ش�psInput�ַ����ұ߿�ʼ��pcPadWith�����ܳ���ΪPiWidth���ַ���}
function PadRStr(psInput:String; piWidth:Integer; pcPadWith:Char):String;
begin
	Result:=psInput+Replicate(pcPadWith,piWidth-Length(psInput))
end;

{* ���ش�psInput�ַ������߿�ʼ��pcPadWith�����ܳ���ΪPiWidth���ַ���}
function PadCStr(psInput:String; piWidth:Integer; pcPadWith:Char):String;
var
	liHalf :integer;
begin
	liHalf:=(piWidth-Length(psInput))div 2;
	Result:=Replicate(pcPadWith,liHalf)+psInput+Replicate(pcPadWith,piWidth-Length(psInput)-liHalf)
end;

{* �����滻���ַ��� Examples: ChrTran('abCdEgdlkh','d','#')�� ����'bC#Eg#lkh'}
function ChrTran(psInput:String; pcSearch:Char; pcTranWith:Char):String;
var
	i,j:integer;
begin
	j:=Length(psInput);
	for i:=1 to j do
  begin
		if psInput[i]=pcSearch then
			psInput[i]:=pcTranWith
  end;
	Result:=psInput
end;

{* �����滻���ַ��� Examples: StrTran('aruyfbn','ruy','====='); ����'a=====fbn'}
function StrTran(psInput:String; psSearch:String; psTranWith:String):String;
var
	liPosition,liLenOfSrch,liLenOfIn:integer;
begin
	liPosition:=Pos(psSearch,psInput);
	liLenOfSrch:=Length(psSearch);
	liLenOfIn:=Length(psInput);
	while liPosition>0 do
	begin
		psInput:=Copy(psInput,1,liPosition-1)
			+psTranWith
      +Copy(psInput,liPosition+liLenOfSrch,liLenOfIn);
		liPosition:=Pos(psSearch,psInput)
	end;
	Result:=psInput
end;

{ *�����滻���ַ���[�滻�ַ���] Examples: Stuff('ABCDEFGHI',3,4,'12345')������'AB12345GHI'}
function Stuff(psInput:String; piBeginPlace,piCount:Integer; psStuffWith:String):String;
begin
	Result:=Copy(psInput,1,piBeginPlace-1)+
		psStuffWith+
    Copy(psInput,piBeginPlace+piCount,Length(psInput))
end;


{����˵�����ж�string�Ƿ�ȫ������}
function IsDigital(Value: string): boolean;
var
  i, j: integer;
  str: char;
begin
  result := true;
  Value := trim(Value);
  j := Length(Value);
  if j = 0 then
  begin
    result := false;
    exit;
  end;
  for i := 1 to j do
  begin
    str := Value[i];
    if not (str in ['0'..'9']) then
    begin
      result := false;
      exit;
    end;
  end;
end;

{����ַ�������}
function RandomStr(aLength : Longint) : String;
var
  X : Longint;
begin
  if aLength <= 0 then exit;
  SetLength(Result, aLength);
  for X:=1 to aLength do
    Result[X] := Chr(Random(26) + 65);
end;


//=============================================

function tx(i: integer): string;
begin
 case i of
 0:RESULT:='һ';
 1:RESULT:='��';
 2:result:='��';
 3:result:='��';
 4:result:='��';
 5:result:='��';
 6:result:='��';
 7:result:='��';
 8:result:='��';
 9:result:='ʮ';
  ELSE
   result:='̫����';
 end;

end;


function deleleftdigital(str:string;partstr:string):string;
var
  i,j:integer  ;
  s:string;
begin
  
  j:=Length(partstr);

  i:=pos(partstr,str);
  s:=StrLeft(str,i-1);

  if IsDigital(s) then
  begin
    if j=1 then delete(str,1,i)
    else
    Delete(str,1,i+j-1)
  end;
  result:=trim(str);
end;


function deleleftdot(str:string):string; //ɾ�����׵��
var
  I:integer  ;
  s:string;
begin
  str:=Trim(str);
  i:=pos('.',str);
  s:=StrLeft(str,i-1);

  if IsDigital(s) then delete(str,1,i);
  result:=trim(str);
end;

function deleleftdun(str:string):string;    //ɾ�����׶ٺ�
var
  I:integer  ;
  s:string;
begin
  str:=Trim(str);
  i:=pos('��',str);
  s:=StrLeft(str,i-1);

  if IsDigital(s) then delete(str,1,i+1);  // �ٺ���2���ֽ�
  result:=trim(str);
end;

 //�ַ�������,�ֳɵ�����,û������
procedure TxttoWords(const S: string; words: TstringList);
var
  j:Integer ;
  sCuted{ ���̶����ȷָ�����Ĳ����ַ��� }: string;
  iCutLength{ ���̶����ȷָ�����Ĳ����ַ����ĳ��� }: integer;
  bIsDBCS{ �Ƿ��Ǻ��ֵ�ǰ���ֽ� }: boolean;
  sline:string;
begin
  sline:=s;
  if Length(sline)=0 then words.Add(#13#10)
  else
  repeat ;
  iCutLength :=2;
  sCuted :=Copy(sline,1,iCutLength );
  bIsDBCS:=False ;
  for j:=1 to icutlength do
    begin
      if bIsDBCS then
        bIsDBCS :=False
        else
          if Windows.IsDBCSLeadByte(Byte(sCuted[j])) then
            bIsDBCS :=True;

    end; //end of for

    if bIsDBCS then Dec(iCutLength);
    if Copy(sline,1,iCutLength)<>#13#10 then   //ȥ���س�
    words.Add(Copy(sline,1,iCutLength));
    sline :=Copy(sline,iCutLength +1,Length(sline )-icutlength);
    until Length (sline)<=0 ;
end;

function replacing(S,source,target:string):string;    //��ȫȥ��
var
  site,StrLen:integer;
begin
  {source��S�г��ֵ�λ��}
  site:=pos(source,s);
  {source�ĳ���}
  StrLen:=length(source);
  {ɾ��source�ַ���}
  delete(s,site,StrLen);
  {����target�ַ�����S��}
  insert(target,s,site);
 {�����´�}

 site:=pos(source,s);
  IF site >0 then
      S:=replacing(S,source,target) ;
  Result :=S;
end;

 function balancerate(source,target:string;pdxz:Boolean):Real;
 var
   str1,str2:string;
   sourcelist,targetlist: TstringList;
   i,df:Integer;
   Temstr:string;
   maxcount:Integer ;
 begin
   source :=Trim(source);    //ȥ��ǰ��ո�
   target :=Trim(target);

   if Trim(source)=Trim(target ) then    //   �����ȾͶ���
      begin
        Result :=1;
        Exit;
      end;

   source:=replacing(source,'��',''); //ȥ������
   source:=replacing(source,',','');  //ȥ����ǣ�
   source:=replacing(source,'��',''); //ȥ�����
   source:=replacing(source,'��',''); //ȥ���ʺ�
   source:=replacing(source,'��',''); //ȥ����
   source:=replacing(source,':','');  //ȥ�����:
   source:=replacing(source,';','');  //ȥ���ֺ�
   source:=replacing(source,'��','');  //ȥ����Ƿֺ�
   source:=replacing(source,' ','');  //ȥ���ո�
   source:=replacing(source,'��','');  //ȥ��������
   source:=replacing(source,'��','');  //ȥ��������

//=======================
   target:=replacing(target,'��',''); //ȥ������
   target:=replacing(target,',','');  //ȥ����ǣ�
   target:=replacing(target,'��',''); //ȥ�����
   target:=replacing(target,'��',''); //ȥ���ʺ�
   target:=replacing(target,'��',''); //ȥ����
   target:=replacing(target,':','');  //ȥ�����:
   target:=replacing(target,';','');  //ȥ���ֺ�
   target:=replacing(target,'��','');  //ȥ����Ƿֺ�
   target:=replacing(target,' ','');  //ȥ���ո�
   target:=replacing(target,'��','');  //ȥ��������
   target:=replacing(target,'��','');  //ȥ��������

 
    if Trim(source)=Trim(target ) then    //   ȥ�����ź������ȾͶ���
      begin
        Result :=1;
        Exit;
      end;

     df :=0;
     
  if pdxz then  //if is �ж�\ѡ������
    begin
      target:=replacing(target,'.','');  //ȥ��.
      source:=replacing(source,'.','');  //ȥ��.

        // source�����,targe�����Ĵ���
       if Length(target)>Length(source) then
        begin
          Result :=0 ; //��ѡ���÷�;
          Exit;
        end;

      str2:=target;
        for i:=1 to Length(source) do
          begin
            str1:=Copy(source,i,1) ;
            if InStr(str1,str2) then
            df:=df+1;  //����Եĸ���
          end;

      Result :=df/length(source);
   
     end//��������ж�/ѡ����
     else
     begin
       sourcelist :=TStringList.Create ;
       targetlist :=TStringList.Create ;
       TxttoWords(source,sourcelist);
       TxttoWords(target,targetlist);

        if sourcelist.Count >targetlist.Count then
        maxcount :=sourcelist.Count
        else
        maxcount :=targetlist.Count ;//���ֵ


       str2 :=target ;
       for i:=0 to sourcelist.Count -2 do
         begin
           Temstr:=sourcelist.Strings[i+1];
           str1:=sourcelist.Strings[i]+temstr;
           if InStr(str1,str2) then
              df:=df+1;
         end;

       if df>0 then df:=df+1;
       Result :=df/maxcount;        //������
       // Result :=df/sourcelist.count;
      sourcelist.Free ;  //����ڴ�
      targetlist.Free ;
     end;

end;



//=========================
function IsForm(FormClass: TFormClass) : boolean; //�ж�ָ�����ڴ���û��
var
i : integer;
begin
result := False;
for i := 0 to screen.FormCount -1 do
begin
if (screen.Forms[i].ClassType = formClass) then
begin
result := True;
Break;
end;
end;
end;

function isapprun(str:string):boolean; //�ж�ָ����������û��
var
HWndCalculator : HWnd;
begin
result:=false;

HWndCalculator := FindWindow(nil, pchar(str));
if HWndCalculator <> 0 then
    result:=true;

end;

function CloseApp(ClassName: String): Boolean;
//�ر��ⲿӦ�ó���
var Exehandle: THandle;
begin
  //ExeHandle := FindWindow(nil, Pchar(Caption));
  ExeHandle := FindWindow(Pchar(ClassName),nil);
  if ExeHandle <> 0
  then
   begin
     PostMessage(ExeHandle, WM_Quit, 0, 0);
     Result:=True;
   end
  else
   begin
     Result:=False;
   end;
end;


{* ��ȡ�������IP��ַ}
function GetHostIP:string;
var
   wVersionRequested : WORD;
   wsaData : TWSAData;
   p : PHostEnt; s : array[0..128] of char; p2 : pchar;
begin
   try
      wVersionRequested := MAKEWORD(1, 1); //���� WinSock
      WSAStartup(wVersionRequested, wsaData); //���� WinSock
      GetHostName(@s,128);
      p:=GetHostByName(@s);
      p2 := iNet_ntoa(PInAddr(p^.h_addr_list^)^);
      Result:= P2;
   finally
      WSACleanup; //�ͷ� WinSock
   end;
end;

 {* ��ȡ������������}
function GetComputerName:string;
var
   wVersionRequested : WORD;
   wsaData : TWSAData;
   p : PHostEnt; s : array[0..128] of char;
begin
   try
      wVersionRequested := MAKEWORD(1, 1); //���� WinSock
      WSAStartup(wVersionRequested, wsaData); //���� WinSock
      GetHostName(@s,128);
      p:=GetHostByName(@s);
      Result:=p^.h_Name;
   finally
      WSACleanup; //�ͷ� WinSock
   end;
end;

//*��ȡ��ǰWindows��¼�����û�
function GetCurrentUserName : string;
const
   cnMaxUserNameLen = 254;
var
   sUserName : string;
   dwUserNameLen : Dword;
begin
   dwUserNameLen := cnMaxUserNameLen-1;
   SetLength( sUserName, cnMaxUserNameLen );
   GetUserName(Pchar( sUserName ), dwUserNameLen );
   SetLength( sUserName, dwUserNameLen );
   Result := sUserName;
end;

//===================================ʱ�䴦��
function TimeToSecond(const H, M, S: Integer): Integer;
begin
Result := H * 3600 + M * 60 + S;
end;

function TimeSecondToTime(const secs: Integer):string;
var
  H, M, S: Word;
begin
H := secs div 3600;
M := (secs mod 3600) div 60;
S := secs mod 60;

Result :=format('%-.2d', [h])+'��'+format('%-.2d', [m])+ '��'+format('%-.2d', [s]);

end; 


function CONNECTWORD: Boolean;
var
  template:OleVariant ;
  newtemplate:OleVariant ;
  docutype:OleVariant ;
  visible:OleVariant ;

begin
  template:=EmptyParam ;
 // newtemplate :=TRUE;  //ģ��ʽ
  //docutype:=0;   //ģ��ʽ
   newtemplate :=False;
   docutype :=wdNewBlankDocument ;    //�ĵ�ʽ
   visible :=True;
  try
   begin
    MSWord := CreateOLEObject('Word.Application');//����Word
    msword.visible:=True;
    msword.Documents.Add(template,newtemplate,docutype ,visible );
    Result:=True;
    END;
  except
    begin
     application.MessageBox('Word�ĵ�����ʧ��','��ʾ',MB_OK+  MB_ICONEXCLAMATION);
     Result :=False ;
     END;
  END;
end;


procedure addstrtoword(text:string;align:Boolean;fontname:WideString;fontsize:integer);
begin
  MSWord.Selection.Font.Size:=fontsize ;
  MSWord.Selection.Font.Name := fontname ;
  if  align then
  MSWord.Selection.ParagraphFormat.Alignment:= wdAlignParagraphCenter
  else
   BEGIN
   MSWord.Selection.ParagraphFormat.Alignment:= wdAlignParagraphLEFT;
   MSWord.Selection.ParagraphFormat.FirstLineIndent:=30;
   end;

  MSWord.Selection.TypeText(text);
  MSWord.Selection.TypeParagraph;
end;

procedure Addbmptoword(str:string );
begin  //str:ͼƬ����·��;
    msword.Selection.InlineShapes.AddPicture(str,False, True);
end;
{s:������ַ�;FONTNAME:��������,FONTSIZE:�����С;ALIGENM:���뷽ʽ0Ϊ��2Ϊ��1Ϊ��,RICHEDITΪ������������}

procedure addstrtorich(s, fontname: string; fontsize,alimen: Integer; Richedit: TRichEdit);
begin
  try
    Richedit.Lines.Add(s) ;
    Richedit.SelLength :=-length(s)-2;
    Richedit.SelAttributes.Size :=fontsize ;
    Richedit.SelAttributes.Name :=fontname ;
    Richedit.Paragraph.Alignment :=talignment(alimen) ;
  //  Richedit.SelStart:=Length(Richedit.Lines.Text);
  except
    Exit ;
  END;  
end;

//��ȡƤ���ļ�========================================================
function readskinfile(keyname:string):string;
var
 IniFileName:string;
 inifile:TInifile;
 str:string;
 ML:string;
 
begin
  ml:= getapppath+'ini';
  if Not DirectoryExists(ml) then CreateDir(ml);

  IniFileName:=getapppath+'ini\skin.ini';
  inifile:=TInifile.Create(IniFileName);
  str:=inifile.ReadString(Keyname,'skinfiles','');
  inifile.Free;

  Result :=str;

end;

procedure writeskinfile(keyname,filename:string);
var
  inifile:TInifile;
  IniFileName:string;
  ML:string;

begin
  ml:= getapppath+'ini';
  if Not DirectoryExists(ml) then CreateDir(ml);

  IniFileName:=GETAPPPath+'ini\Skin.ini';
  inifile:=TInifile.Create(IniFileName);
    try
       inifile.WriteString(keyname,'skinfiles',filename);
    finally
      inifile.Free;
    end;
end;

{ 
���ܣ���ȫ�ĸ����ļ� 
srcFile��destFile��Դ�ļ���Ŀ���ļ� 
bDelDest�����Ŀ���ļ��Ѿ����ڣ��Ƿ񸲸� 
����ֵ��true�ɹ���falseʧ�� 
} 
function shFileCopy(srcFile,destFile:String;bDelDest:boolean=true):boolean; 
begin
  result:=false;
  if not FileExists(srcFile) then
  begin
    Application.MessageBox ('Դ�ļ������ڣ����ܸ���','��ʾ',MB_OK+MB_ICONEXCLAMATION);
    exit;
  end;

  if srcFile=destFile then
  begin
    Application.MessageBox ('Դ�ļ���Ŀ���ļ���ͬ�����ܸ���','��ʾ',MB_OK+MB_ICONEXCLAMATION);
    exit;
  end;
  
  if FileExists(destFile) then
  begin
  if not bDelDest then
      begin
       Application.MessageBox ('Ŀ���ļ��Ѿ����ڣ����ܸ���','��ʾ',MB_OK+MB_ICONEXCLAMATION);
       exit;
       end
  else
  begin
    if Application.MessageBox('Ŀ���ļ�������,Ҫ������?','��ʾ',MB_OK+MB_ICONQUESTION)=IDOK then
    begin
      FileSetAttr(destFile,FileGetAttr(destFile) and not $00000001);
      
      if not DeleteFile(PChar(destFile)) then
      begin
        Application.MessageBox ('Ŀ���ļ��Ѿ����ڣ����Ҳ��ܱ�ɾ��������ʧ��','��ʾ',MB_OK+MB_ICONEXCLAMATION);
        exit;
      end;
    END;
  END;
  end; //END IF FILEEXISTS
     if not CopyFile(PChar(srcFile),PChar(destFile),False ) then     //COPY
     begin
       Application.MessageBox ('����δ֪�Ĵ��󣬸����ļ�ʧ��','��ʾ',MB_OK+MB_ICONEXCLAMATION);
       exit;
     end;
//Ŀ���ļ�ȥ��ֻ������ 
    FileSetAttr(destFile,FileGetAttr(destFile) and not $00000001);
    result:=true;
end;

procedure loadpicture(str:string;var image:TImage);
var
 ms: tmemorystream;
 mJPeg: TJPegImage;
 sType:String ;
begin
   sType:=ExtractFileExt(str) ;
   ms:=TMemoryStream.Create ;
   mJpeg:=TJpegImage.Create ;
    Try
     ms.LoadFromFile(str ) ;
     ms.Position:=0 ;
    If (UpperCase(sType)='.JPEG') or (UpperCase(sType)='.JPG') Then
      Begin
        mJpeg.LoadFromStream(ms) ;    //��JPG������
        Image.Picture.Bitmap.Assign(mJpeg) ;
     End
     Else
      if UpperCase(sType)='.BMP' then
        Image.Picture.Bitmap.LoadFromStream(ms) ;    //����BMP��
   Finally
   ms.Free ;
   mJpeg.Free ;
   End ;
 
End ;

//======================   Ŀ¼����
procedure DelTree(DirName:String); 
var 
hFindFile:Cardinal; 
FileName: String; 
FindFileData:WIN32_FIND_DATA; 
begin 
if DirName[Length(DirName)]<>'\' then 
  DirName:= DirName + '\'; 
hFindFile:= FindFirstFile(PChar(DirName + '*.*'), FindFileData); 
if hFindFile <> INVALID_HANDLE_VALUE then 
begin 
  repeat 
   FileName:= FindFileData.cFileName; 
   if (FileName <> '.') and (FileName <> '..') then 
   begin 
    if (FindFileData.dwFileAttributes = FILE_ATTRIBUTE_DIRECTORY) then 
     DelTree(DirName + FileName) 
    else 
     DeleteFile(PChar(DirName + FileName)); 
   end; 
  until FindNextFile(hFindFile, FindFileData) = false; 
  Windows.FindClose(hFindFile); 
  RmDir(DirName); 
end; 
end;   

function EmptyDirectory(TheDirectory :String ; Recursive : Boolean):Boolean;
var
SearchRec : TSearchRec; 
Res : Integer; 
begin 
Result := False; 
TheDirectory := Trim(TheDirectory);
Res := FindFirst(TheDirectory + '*.*', faAnyFile, SearchRec); 
try 
while Res = 0 do 
begin 
if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then 
begin 
if ((SearchRec.Attr and faDirectory) > 0) and Recursive 
then begin 
EmptyDirectory(TheDirectory + SearchRec.Name, True); 
RemoveDirectory(PChar(TheDirectory + SearchRec.Name)); 
end 
else begin 
DeleteFile(PChar(TheDirectory + SearchRec.Name)) 
end; 
end; 
Res := FindNext(SearchRec); 
end;
Result := True;
finally
FindClose(SearchRec);
//FindClose(SearchRec.FindHandle);
end;
end;

procedure creatdesktoplink(Linkname:string);
var
 tmpObject: IUnknown;
 tmpSLink: IShellLink;
 tmpPFile: IPersistFile;
 PIDL: PItemIDList;
 StartupDirectory: array[0..MAX_PATH] of Char;
 StartupFilename: string;
 LinkFilename: WideString;
 Tempstr:string ;
begin
 //StartupFilename := ExtractFilePath(Application.ExeName) + 'xlxt.exe';
 StartupFilename :=Application.ExeName;

 if not FileExists(StartupFilename) then Exit;
 tmpObject := CreateComObject(CLSID_ShellLink);
 tmpSLink := tmpObject as IShellLink;
 tmpPFile := tmpObject as IPersistFile;
 tmpSLink.SetPath(pChar(StartupFilename));
 tmpSLink.SetWorkingDirectory(pChar(ExtractFilePath(StartupFilename)));
 SHGetSpecialFolderLocation(0,CSIDL_DESKTOPDIRECTORY,PIDL);
 SHGetPathFromIDList(PIDL,StartupDirectory);

 Tempstr :='\'+ Linkname+'.lnk' ;

 LinkFilename := StartupDirectory + Tempstr ;
 

 if FileExists(LinkFileName) then

  begin
  application.MessageBox('��ݷ�ʽ������,�����ظ�����','��ʾ',MB_OK+  MB_ICONEXCLAMATION);
  Exit;
  end
  else
  begin
   tmpPFile.Save(pWChar(LinkFilename), FALSE);
   application.MessageBox('��ݷ�ʽ������','��ʾ',MB_OK+MB_ICONinformation);
  END;
end;



function setadoaccess(mdbpath:string;passwd:string):string;
Const
  SConnectionString       = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%s;'
                                +'Jet OLEDB:Database Password=%s;';
begin
  mdbpath:=trim(mdbpath);
  passwd:=trim(passwd);
  result:=format(SConnectionString,[mdbpath,passwd]);
end;




end.
