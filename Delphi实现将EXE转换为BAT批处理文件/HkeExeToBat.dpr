{ KOL MCK } // Do not remove this line!
(*********************************************************
               By Hke Wwww.WuHansen.Com
       QQ:21764538   Email: wuhansen@wuhansen.com

Exe2Bat��ͦ���һ��С������(��ASMԴ��) �ܰ������ļ�ת����bat
 ��ϧ���⻹�ǲ���  ����Delphiд����(�����ƺ���VC/VB��Դ��)
                  �����ʵ�ֵĺ��ĵ�Ԫ
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
program HkeExeToBat;

uses
KOL,
  MainFormUnit in 'MainFormUnit.pas' {Form1};

//{$R *.res}

begin // PROGRAM START HERE -- Please do not remove this comment

{$IFDEF KOL_MCK} {$I HkeExeToBat_0.inc} {$ELSE}

  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

{$ENDIF}

end.

