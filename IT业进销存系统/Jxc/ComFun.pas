unit ComFun;

interface

uses Variants, BDE, Windows, Dialogs, SysUtils, DBCtrls, DB, DBGrids, DBTables, Grids,
  stdctrls,clipbrd, menus,comctrls,Forms, Messages, Classes, Graphics, Controls,
  ExtCtrls, ImgList, ToolWin, Mask, Buttons, DBClient, syncobjs ;


{ ���� }
function IIF(Expression: Boolean; TruePart: Variant; FalsePart: Variant ): Variant;  //IIf
{ ���� }
function  DayofMonth(year,month:integer):integer;  //ȡĳ�µ��������
function  BOFM(date1:TDateTime):TDateTime;  //�³�
function  EOFM(date1:TDateTime):TDateTime;  //��ĩ
function  Year(date1:TDateTime):integer;  //��
function  Month(date1:TDateTime):integer;  //��
function  Day(date1:TDateTime):integer;  //��
{ ת�� }
function  QtyToChar(Qty:Double):string;  //��ֵתΪ��д
function  VarToFloat(v:Variant):Double;  //����ת������ֵ, nullΪ0
function  VarToInt(v:Variant):Int64;  //����ת��������, nullΪ0
function  Float2Str(v:Variant):string;  //��ֵת�����ַ���, nullΪ0
function  Str2Float(s:string):Double;  //�ַ���ת������ֵ, ''Ϊ0
function  RoundPlus(v: Variant; Length: Integer): Double;  //���������ǿ�棬��ָ����С����λ
{ �ַ��� }
function  PosPlus(SubStr1, Str1: string; num1: integer): integer;  //POS�����ļ�ǿ��
function  Repl(str1:string; intCount:integer):string; //�ظ��ַ���
{ ȡϵͳ��Ϣ }
function  GetComputerName: AnsiString;  //ȡ�����ļ��������
function GetDiskVolumeLable(DiskVolume:char):string;//ȡ�ñ���Ӳ�̵ľ��
//��ʾ����
function MessageForm(const Msg, Caption: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DefButton: Longint=1): Word;

implementation

//iif
function IIF(Expression: Boolean; TruePart: Variant; FalsePart: Variant ): Variant;
begin
	if Expression then
    Result := TruePart
  else
    Result := FalsePart;
end;

//ȡ�µ�����
function DayofMonth(year,month:integer):integer;
const
	DaysInMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result := DaysInMonth[Month];
  if (Month = 2) and IsLeapYear(Year) then Inc(Result);
end;

//�³�
function BOFM(Date1:TDateTime):TDateTime;
var
	Year1,Month1,Day1:word;
begin
  DecodeDate(Date1, Year1, Month1, Day1);
  Result := EncodeDate(Year1, Month1, 1);
end;

//��ĩ
function EOFM(Date1:TDateTime):TDateTime;
var
	Year1,Month1,Day1:word;
begin
	DecodeDate(Date1, Year1, Month1, Day1);
  Result := EncodeDate(Year1, Month1, DayOfMonth(Year1,Month1) );
end;

function  Year(date1:TDateTime):integer;  //��
var
	Year1,Month1,Day1:word;
begin
	DecodeDate(Date1, Year1, Month1, Day1);
  Result := Year1;
end;

function  Month(date1:TDateTime):integer;  //��
var
	Year1,Month1,Day1:word;
begin
	DecodeDate(Date1, Year1, Month1, Day1);
  Result := Month1;
end;

function  Day(date1:TDateTime):integer;  //��
var
	Year1,Month1,Day1:word;
begin
	DecodeDate(Date1, Year1, Month1, Day1);
  Result := Day1;
end;

//�ظ��ַ���
function Repl(str1:string;intCount:integer):string;
var
  i: integer;
begin
  Result := '';
  for i := 1 to intCount do
    Result := Result + str1;
end;

//��ֵתΪ��д
Function QtyToChar(Qty:Double):String;
Const Con :Array [0..3] Of  String[2] =('','ʰ','��','Ǫ');
   DD :Array [0..9] Of String[2] =('��','Ҽ','��','��','��','��','½','��','��','��');
Var  Str  :String;
     i,r:Byte;
Begin
	If qty < 0 Then qty := -qty;
  Str:=FormatFloat('#',Qty*100);
  Result := '';
  For  R:=1 to Length(Str) Do
    Begin
       i:=StrToInt(Str[Length(Str)-r+1]);
			 Case R OF
            1: Result:=DD[i]+'��';
            2: Result:=DD[i]+'��'+Result;
            Else
              IF  i>0 then
                 Result:=DD[i]+Con[(r-3) Mod 4]+Result
                 Else
                   Begin
                   if   (Copy(Result,1,2)<>'��') Then  Result:='��'+Result;
                   End;
              End;
       IF R<Length(Str) Then
       CASE R OF
          2 :  Result:='Ԫ'+Result;
          6 :  Result:='��'+Result;
         10 :  Result:='��'+Result;
            End;
		End;
  While Pos('��Ԫ',Result)>0 Do Delete(Result,Pos('��Ԫ',Result),2);
	While Pos('����',Result)>0 Do Delete(Result,Pos('����',Result),2);
  While Pos('����',Result)>0 Do Delete(Result,Pos('����',Result),2);
  Result:=Result+'��';
End;

//����ת������ֵ, nullΪ0
function VarToFloat(v:Variant):Double;
begin
  if VarIsEmpty(v) then
    Result := 0
  else if v = null then
    Result := 0
  else
    Result := v;
end;

function VarToInt(v:Variant):int64;
begin
  if VarIsEmpty(v) then
    Result := 0
  else if v = null then
    Result := 0
  else
    Result := Round(v);
end;

//��ֵת�����ַ���, nullΪ0
function Float2Str(v:Variant):string;
begin
  if VarIsEmpty(v) then
    Result := '0'
  else if v = null then
    Result := '0'
  else
    Result := FloatToStr(v);
end;

//�ַ���ת������ֵ, ''Ϊ0
function Str2Float(s:string):Double;
begin
  if s = '' then
    Result := 0
  else
		Result := StrToFloat(StringReplace(s, ',', '', [rfReplaceAll]));
end;

//���������ǿ�棬��ָ����С����λ
function RoundPlus(v: Variant; Length: Integer): Double;
var
  s: string;
begin
  if Length = 0 then
    s := '0'
  else
    s := '0.' + Repl('0', Length);
  Result := StrToFloat(FormatFloat(s, VarToFloat(v)));
end;

//PosPlus(POS�����ļ�ǿ��)
//SubStr1 �Ӵ�
//Str1    ����
//num1    ��n�γ���
function PosPlus(SubStr1, Str1: string; num1: integer): integer;
var
	CutLen1,i:integer;
begin
  Result := 0;
  i := 0;
  CutLen1:=0;
  while str1 <> '' do
	begin
    i := i + 1;
    if i = num1 then
    begin
			if pos(SubStr1,str1)<>0 then Result := CutLen1 + pos(SubStr1,str1);
      break;
    end;
    CutLen1 := CutLen1 + pos(SubStr1,str1) + Length(SubStr1) - 1;  //�ۼƽ�ȥ�ַ��ĳ���
    str1 := copy(str1,pos(SubStr1,str1)+1,length(str1));
  end;
end;

//ȡ���������
function GetComputerName: AnsiString;
var lpBuffer: array[0..MAX_PATH] of char;
    dwSize: DWORD;
begin
  dwSize:= MAX_PATH;
  if not Windows.GetComputerName(lpBuffer, dwSize) then
    raise Exception.Create(SysErrorMessage(GetLastError()));
  Result:= StrPas(lpBuffer);
end;

//ȡ�ñ���Ӳ�̵ľ��
function GetDiskVolumeLable(DiskVolume:char):string;
var
  VolumeLabel, FileSystem: Array[0..$FF] of Char;
  SerialNumber, DW, SysFlags: DWord;
  function DecToHex(aValue: LongInt): String;
  var
    w: Array[1..2] of Word absolute aValue;
    function HexByte(b: Byte): String;
    const
      Hex: Array[$0..$F] of Char = '0123456789ABCDEF';
    begin
      HexByte := Hex[b shr 4] + Hex[b and $F];
    end;
    function HexWord(w: Word): String;
    begin
      HexWord := HexByte(Hi((w-3)*2)) + HexByte(Lo((w+3)*2));
    end;
  begin
    Result :=  HexWord(w[1]) + HexWord(w[2]);
  end;
begin
  Result := '';
  DiskVolume := UpCase(DiskVolume);
  if (DiskVolume >= 'A') and (DiskVolume <= 'Z') then
  begin
    GetVolumeInformation(PChar(DiskVolume + ':\'), VolumeLabel, SizeOf(VolumeLabel),
                         @SerialNumber, DW, SysFlags,
                         FileSystem, SizeOf(FileSystem));
    Result := DecToHex(SerialNumber);
//    Insert('-', Result, 5);
  end;
end;

function MessageForm(const Msg, Caption: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; DefButton: Longint=1): Word;
var
  Form1: TForm;
  i,j : integer;
begin
  Form1 := CreateMessageDialog( Msg, DlgType, Buttons);
  Form1.Caption := Caption;
  j := 1;
  for i := 0 to Form1.ComponentCount - 1 do
    if Form1.Components[i] is TButton then
    begin
      if j = DefButton then
        TButton(Form1.Components[i]).TabOrder := 0;
      if TButton(Form1.Components[i]).Caption = '&Yes' then
        TButton(Form1.Components[i]).Caption := '��(&Y)'
      else if TButton(Form1.Components[i]).Caption = '&No' then
        TButton(Form1.Components[i]).Caption := '��(&N)'
      else if TButton(Form1.Components[i]).Caption = 'Cancel' then
        TButton(Form1.Components[i]).Caption := 'ȡ��';
      inc(j);
    end;
  Form1.ShowModal;
  Result := Form1.ModalResult;
  Form1.Free;
end;

end.

