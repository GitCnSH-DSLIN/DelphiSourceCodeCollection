(*********************************************************
               By Hke Wwww.WuHansen.Com
       QQ:21764538   Email: wuhansen@wuhansen.com

Exe2Bat��ͦ���һ��С������(��ASMԴ��) �ܰ������ļ�ת����bat
 ��ϧ���⻹�ǲ���  ����Delphiд����(�����ƺ���VC/VB��Դ��)
                  �����ʵ�ֵĺ��ĵ�Ԫ
          ��������ף��       2006.11.20 20:33
     ��лchinasf�ṩ��˼· ����ת��64K���ϵ��ļ���
                  2006.11.29 19:14
**********************************************************
      ����ԭ��ת���ٶ�������������
      ����ԭ����NT�²�������
      ����ԭ��ת����Bat���� (Ҳ����ʲô������)

      �������ϸ��汾����ת��64K���ϵ��ļ�������
**********************************************************)
unit Exe2BatUnit;

interface

uses
  Windows;
function Bat2exe(ExeName,ExePath,BatPath:string):boolean;

implementation





function Bat2exe(ExeName,ExePath,BatPath:string):boolean;

//ByteתHex ��InttoHexת�����Ĳ�����Ӱ������ �Լ�д��
  function DectoHex(a:integer):string;
    function Tostr(s:integer):string;
      begin
        if s<=9 then Result:=chr(ord('0')+s)
        else Result:=chr(ord('A')+s-10);
      end;
    var temp,b:integer;
    begin
      b:=a;
      Result:='';
      repeat
        temp:=a mod 16;
        a:=a div 16;
        Result:=Tostr(temp)+Result;
        if ((a<16) and(b>15)) then Result:=Tostr(a)+Result;
      until  (a<16) or (b<16);
      if Length(Result)=1 then Result:='0'+Result;
    end;

Function IntToStr(Code:LongWord):String;
begin
  Str(Code,Result);
end;

Const
  hke='>>hke';
  ECHO='Echo ';
  _63K=1024*63; //1024*63;
  _Tmp='.tmp';
Type
  PBuf=^Byte;
var
  hFile,BytesRead,Size,i,b,Offset,BufOffset: Cardinal;
  Count:integer;
  lpReOpenBuff:OFSTRUCT;
  F:text;
  Buf:pointer;
  BHex,TmpStr:String;
  //CanBreak:boolean;
procedure WritePart(PartStartBuf:pointer;PartSize,PartCount:LongWord);
Var j:LongWord;
begin
  Offset:=0; //���öμ�����Ϊ0
  i:=0;
  repeat
    write(f,ECHO+'e ',DectoHex(256+Offset*16),' '); //�ε�ַ
    inc(offset);
    for j:=0 to 15 do //���ж�ȡ�ڴ����� ��HEX����
      begin
        b:=PBuf(LongWord(PartStartBuf)+i)^;
        BHex:=DectoHex(b);
        Write(f,BHex,' ');
        inc(i);
        if i=PartSize then break;
      end;
     writeln(f,hke,PartCount,_Tmp);// echo XXX >>hke ��XXXд��hke
  until i=PartSize;
  //�������Debug����������ļ�
  writeln(f,echo,'rcx',hke,PartCount,_Tmp);
  writeln(f,echo,DecToHex(PartSize),hke,PartCount,_Tmp);
  writeln(f,echo,'n WHS',PartCount,_Tmp,hke,PartCount,_Tmp); //���뵽WuHansen����ļ�
  writeln(f,echo,'w',hke,PartCount,_Tmp);
  writeln(f,echo,'q',hke,PartCount,_Tmp);
  writeln(f,'debug<hke',PartCount,_Tmp,'>nul'); //����Ŷ
end;
begin
  result:=False;
  hFile := OpenFile(Pchar(ExePath),lpReOpenBuff,OF_READ);
  if (hFile = 0) or (hFile = $FFFFFFFF) then Exit; //�ļ�������
  Size:=GetFileSize(hFile,nil);
  if Size=0 then Exit; //�ļ��ǿյ�
  Getmem(Buf,Size);
  ReadFile(hFile,PBuf(Buf)^,Size, BytesRead, nil);
  CloseHandle(hFile);
  ///////��ʼд�ļ�///////
  assign(f,BatPath);
  rewrite(f);
  writeln(f,'@echo off');//�رջ���
  writeln(f,'rem By Hke Www.WuHansen.Com QQ:21764538');
  writeln(f,'echo By Hke Www.WuHansen.Com QQ:21764538');
  writeln(f,'echo Makeing file...');
  writeln(f,'echo Please Wait');
  if Size<=_63k then
    begin
      WritePart(Buf,Size,0);
      Count:=0;
    end
  else
    begin
      Count:=-1;
      Buf:=pointer(LongWord(buf)-_63K);
      BufOffset:=0;
      repeat
        Count:=Count+1;
        BufOffset:= BufOffset+_63K;
        if Size>= _63K then
          begin
            Size:=Size-_63K;
            WritePart(Pointer(LongWord(Buf)+BufOffset),_63K,Count)
          end;
      until Size<_63K;
      if  Size>0 then
        begin
          Count:=Count+1;
          WritePart(Pointer(LongWord(Buf)+BufOffset+_63K),Size,Count);
        end;
      Buf:=pointer(LongWord(buf)+_63K);
    end;
  TmpStr:='WHS0.tmp';
  if  Count>0 then
    For i:=1 to Count do  TmpStr:=TmpStr+'+WHS'+IntToStr(i)+_Tmp;

//  writeln(f,'ren WuHansen ',ExeName); //������
//  writeln(f,'del hke');  //ɾ����ʱ�ļ�
  writeln(f,'Copy /b /y ',TmpStr,' ',ExeName);
  writeln(f,'del hke*',_Tmp);
  writeln(f,'del WHS*',_Tmp);
  writeln(f,'cls');
  writeln(f,'start ',ExeName);  //���� ֱ��ExeName Dos���ڻῨ��ֱ��Exe�ر�
  close(f);
  FreeMem(Buf);
  result:=true;
end;

end.
 