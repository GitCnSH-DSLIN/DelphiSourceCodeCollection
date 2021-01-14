//*******************һ���򵥵ļ��ܺͽ��ܺ���*******************//
//��������ʱ�䣺2004��7��28��

unit Myjiami;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, StdCtrls;
  function editstrtomd(s:string; strkey:char ):string;//ԭ�ַ�ת���ɼ����ַ���
  function mdtoeditstr(s:string; strkey:char ):string;//�����ַ�������ԭ�ַ�ת
  function db_idtoadd(s:string; int_leg:integer):string; //���ݿ�ID����Լ�
  Function int_to_str(s:string):string;    //ע����Ϣ����ת�����ַ�    2005/01/27
  Function str_to_int(s:string):string;    //ע����Ϣ�ַ�ת��������    2005/01/27
  procedure str_intercept(s: string; Separator: char; Terms: TStringList); //�ַ�����ȡ�Ĺ���  2005/02/05
  //function myHextoStr(S: string): string;//16�����ַ���תԭ�ַ���
implementation
//
function editstrtomd(s:string; strkey:char ):string;//ԭ�ַ�ת���ɼ����ַ���
var
  str:string;         //���������ַ���������ʱ����
  str1:string;        //���������ַ���������ʱ����
  i:integer;          //ѭ�����ܱ���
  j:integer;          //���ܹؼ���
begin
  str:=s;             //�洢������ַ���
  str1:='';           //��ʼ��ת������ַ���
  j:= integer(strkey);//�����ܹؼ���ת��������
  for i:=1 to length(str) do   //�ַ�����ѭ������
  begin
  str1:=str1+char(integer(str[i])+j);//����ת��������ֵ��ż��
  end;
  result := str1;     //���ؼ��ܺ�Ľ��
end;

function mdtoeditstr(s:string; strkey:char ):string;//�����ַ�������ԭ�ַ�ת
var
  str:string;         //���������ַ���������ʱ����
  str1:string;        //���������ַ���������ʱ����
  i:integer;          //ѭ�����ܱ���
  j:integer;          //���ܹؼ���
begin
  str1:=s;            //�洢������ַ���
  str:='';            //��ʼ��ת������ַ���
  j:= integer(strkey);//�����ܹؼ���ת��������
  for  i:=1 to length(str1) do  //�ַ�����ѭ������
  begin
    str:=str+char(integer(str1[i])-j);
  end;
  result := str;      //���ؽ��ܺ�Ľ��
end;

function db_idtoadd(s:string; int_leg:integer):string;    //���ݿ�ID����Լ�
var
  str:string;
  str_id:string;
  int_id:integer;
  i:integer;
begin
  str := s;                     //�洢װ���ֵ
  int_id:=strtoint(str)+1;      //ʹ��ż�1
  str_id:='';                   //��ʹ��ת������ַ���
  for i:=1 to (int_leg-length(inttostr(int_id))) do     //ѭ����ʹ��0�ĸ���
  begin
    str_id:=str_id+'0';
  end;
  str_id:=str_id+inttostr(int_id);                 //����ת��Ϊ����ַ���
  result := str_id;             //���ؽ��
end;
function int_to_str(s: string): string;
var
  turn:array [0..9] of char;
  i:integer;
  re_str:string;
begin
  turn[0]:='A';
  turn[1]:='X';
  turn[2]:='F';
  turn[3]:='H';
  turn[4]:='M';
  turn[5]:='j';
  turn[6]:='a';
  turn[7]:='e';
  turn[8]:='p';
  turn[9]:='l';
  re_str:='';
  for i:=1 to length(s) do
  begin
    re_str:=re_str + turn[strtoint(s[i])];
  end;
  result := re_str;
end;
function str_to_int(s: string): string;
var
  i:integer;
  re_str:string;
begin
  re_str:='';
  for i:=1 to length(s) do
  begin
    case char(s[i]) of
    'A': re_str :=re_str +'0';
    'X': re_str :=re_str +'1';
    'F': re_str :=re_str +'2';
    'H': re_str :=re_str +'3';
    'M': re_str :=re_str +'4';
    'j': re_str :=re_str +'5';
    'a': re_str :=re_str +'6';
    'e': re_str :=re_str +'7';
    'p': re_str :=re_str +'8';
    'l': re_str :=re_str +'9';
    end;
  end;
  result := re_str;
end;
//�ַ�����ȡ�Ĺ���
procedure str_intercept(s: string; Separator: char;
  Terms: TStringList);
  var
  hs : string;
  p : integer;
begin
  Terms.Clear;           // ���StringList�е���������
  if Length(s)=0 then   // �ִ�����0���˳�
  begin
    Exit;
  end;
  p:=Pos(Separator,s);
  while P<>0 do
  begin
    hs:=Copy(s,1,p-1);   // �����ִ�
    Terms.Add(hs);       // ��ӵ�LIST��
    Delete(s,1,p);       // ɾ���տ������ִ�
    p:=Pos(Separator,s); // Ѱ����һ����ָ���ַ����ִ�
  end;
  if Length(s)>0 then
    Terms.Add(s);        // ��ʢ�µ��ִ���ӵ�TERM��
end;
end.
