program Exe2bat;
(*********************************************************
               By Hke Wwww.WuHansen.Com
       QQ:21764538   Email: wuhansen@wuhansen.com

Exe2Bat��ͦ���һ��С������(��ASMԴ��) �ܰ������ļ�ת����bat
 ��ϧ���⻹�ǲ���  ����Delphiд����(�����ƺ���VC/VB��Դ��)
                  �����ʵ�ֵ�Demo
          ��������ף��       2006.11.20 20:33
     ��лchinasf�ṩ��˼· ����ת��64K���ϵ��ļ���
                  2006.11.29 19:14
**********************************************************
      ����ԭ��ת���ٶ�������������
      ����ԭ����NT�²�������
      ����ԭ��ת����Bat���� (Ҳ����ʲô������)

      �������ϸ��汾����ת��64K���ϵ��ļ�������
**********************************************************)

{$APPTYPE CONSOLE}

uses
  Windows, SysUtils, Exe2BatUnit; //����SysUtils���������Ƚϴ�

Var MyExeName,MyPath,ExeName:string;
begin
  Writeln('Exe2Bat By Hke (Www.WuHansen.Com) QQ:21764538');
  Writeln;
  if (paramstr(1)='') or (paramstr(2)='') then  //����һ������û��
    begin
      Writeln('You must run as that: Exe2Bat InputFileName OutputFileName');
      Writeln('Example: C:\>Exe2Bat Test.Exe Test.Bat');
    end
  else
    begin
      MyExeName:=Pchar(paramstr(0)); //paramstr(0)���Լ����ļ���
      MyPath:=ExtractFilePath(MyExeName);
      if MyPath[Length(MyPath)] <> '\' then MyPath:=MyPath+'\';
      ExeName:=paramstr(1);
      Writeln('Wait..');
      if Bat2Exe(ExeName,MyPath+ExeName,MyPath+paramstr(2)) then
        Writeln('Done')
      else
        Writeln('Error');  
    end;
end.
