program YLZP;
//----------------------------------------------------------//
//   ����ũ�����ҽ�����Բ�ҽ��֤����

//   �����ʵ��
//   ����ı���ģ�����
//   ��ӡ���״�

//   ���ݿ���� Access,�ļ����� : YLZ.mdb
//   ʹ�ÿؼ� ReportBuilder 7.03 for Delphi 7.0

//   ��һ���� ���� 2ccc.com �ϴ��Լ�����С����,��л���֧��.
//   �Ժ��ཻ��!

//   Author : thplus
//   Email  : thplus@sina.com
//   QQ     : 419157190
//   2008.06.15

//   ����ת��,�뱣��������Ϣ!лл!
//----------------------------------------------------------//

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����ũ�����ҽ�����Բ�ҽ��֤';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
