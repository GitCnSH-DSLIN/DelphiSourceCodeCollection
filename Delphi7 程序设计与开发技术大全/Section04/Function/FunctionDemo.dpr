program FunctionDemo;

{$APPTYPE CONSOLE}

uses
  SysUtils;

//���庯�������ڼ���a��b�����ĺ�
function Total(a,b:Integer):Integer;
begin
  Total:=a+b;
end;

var
  a,b,c:Integer;
begin
  try
    Writeln('������aֵ');
    Readln(a);
    Writeln('������bֵ');
    Readln(b);
    c:=Total(a,b);                //���ú���
    Write('a��b�ĺ�Ϊ��');
    Writeln(c);
    Readln;
  except
    Writeln('��������ݲ�������');
  end;
end.
