//����Ԫ���泣�ú���
unit Unit_utils;

interface
uses
	fmain,db,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls,DateUtils;

  Function DaysInMonth(ADate:TDateTime):Integer;
	Function CurrTranfer(currstr:String):Double;
	Function ReadPriorStr(var templine:string;searchtext:string):String;
	Function ReadNextStr(templine:string;searchtext:string):String;
  Function ReadPriorStrOnly(templine:string;searchtext:string):String;
  function ScanStr(ToScan: PChar; Sign: Char):PChar;
  function IsDigit(ch: char): boolean;
implementation

//----------�����·���������Ĳ���-----------//
function DaysInMonth(ADate:TDateTime):Integer;
var
MyMonth,
MyYear,
MyDay : Word;
MyDayTable : TDayTable;
tmpBool : Boolean;
begin
DecodeDate(ADate, MyYear, MyMonth, MyDay);
tmpBool := IsLeapYear(MyYear);
MyDayTable := MonthDays[tmpBool];
Result := MyDayTable[MyMonth];
end;
//-------------------End---------------------//
//ת��������ݵĸ�ʽ��ǧ��λ��ʽת��Ϊ˫�����͡�
Function CurrTranfer(currstr:String):double;
var SearchText,Tmpstr:string;
    AllLenth,FoundPos:Integer;
begin
        //AllLenth:=length(currstr);
        Tmpstr:='';
        repeat
			SearchText:=',';
			FoundPos:=Pos(SearchText,currstr);
			if FoundPos>0 then
			begin
				tmpstr:=tmpstr+copy(currstr,1,FoundPos-1);
				currstr:=copy(currstr,FoundPos+1,length(currstr)-FoundPos);
				//AllLenth:=length(currstr);
			end
        until FoundPos<=0;
        Tmpstr:=Tmpstr+currstr;
        if Tmpstr='' then
	        Result:=0.00
        else
    	    Result :=strtofloat(Tmpstr);
end;

//����ָ���֮ǰ��һ�����ݡ�����Ϊ���ô���,�ָ���֮����ַ�����Ϊ�������ַ�����
Function ReadPriorStr(var templine:string;searchtext:string):String;
var FoundPos:Integer;
   //searchtext,templine:string;
begin
		FoundPos:=Pos(searchtext,templine);
		if FoundPos>0 then
		begin
			result:=trim(copy(templine,1,FoundPos-1));
			templine:=copy(templine,FoundPos+1,length(templine)-FoundPos);
		end
		else
			result:='';
end;

//����ָ���֮����ַ�����
Function ReadNextStr(templine:string;searchtext:string):String;
var FoundPos:Integer;
begin
		FoundPos:=Pos(searchtext,templine);
		if FoundPos>0 then
			result:=trim(copy(templine,FoundPos+1,length(templine)-FoundPos))
		else
			result:='';
end;

//����ָ���֮ǰ��һ�����ݡ����ظ��ַ�����ԭ�ַ������޸ġ�
Function ReadPriorStrOnly(templine:string;searchtext:string):String;
var FoundPos:Integer;
   //searchtext,templine:string;
begin
		FoundPos:=Pos(searchtext,templine);
		if FoundPos>0 then
		begin
			result:=trim(copy(templine,1,FoundPos-1));
			//templine:=copy(templine,FoundPos+1,length(templine)-FoundPos);
		end
		else
			result:='';
end;


//--ת��Ϊ��д�ַ�
function ToUpper(ch: char): char;  
begin
  Result := chr(ord(ch) and $DF);
end;


//--�ж��ַ����Ƿ����ת��������
function IsIntStr(const S: string): boolean;
begin
  Result:=StrToIntDef(S,0)=StrToIntDef(S,1);
end;


//--�ַ�����ѯ����
function ScanStr(ToScan:pchar; Sign: char):pchar;  
begin
  Result:= nil;
  if ToScan <> nil then
    while (ToScan^ <> #0) do begin
      if ToScan^ = Sign then begin
        Result:= ToScan;
        break;
       end;
     inc(ToScan);
    end;
end;


//--�ж��ַ����Ƿ�Ϊ����
function IsDigit(ch: char): boolean;
begin
  //Result := ch in ['0'..'9'];
  if ch in ['0'..'9'] then
    result:=true
    else
    result:=false;
end;


end.

