//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//����    ���踻ƽ
//�����سƣ��ϴ�
//Home Page  ��http://www.soft520.com
//E-Mail  ��admin@soft520.com
//����    ��2004-8-23
//����    ������BCB_FANS(�Ĵ�����֮׷ɱ��)��2000������Ctrl + Alt + Del��ϼ���
//          ��������Borland C++Builder 6.0 Patch4�±�дԶ���߳�ע��Ĵ��룬��װ
//          ��DLL�����EnabledKey��DisabledKey����������ʹ�ÿ�����Delphi,VB�ȳ�
//          �п���ʹ�ã���������Windows Server 2003���İ�ƽ̨�������ͨ��
//�������ԣ�Borland C++Builder 6.0 Patch4

//��л    ��BCB_FANS(�Ĵ�����֮׷ɱ��)
//��Ȩ    ��ת����ע��ԭ���ߣ���

//        ������Ϊ BCB_FANS(�Ĵ�����֮׷ɱ��)��2000������Ctrl + Alt + Del��ϼ���
//          ����˵��
//ԭ��    ������Զ���߳�ע�뼼����װ��һ��DLL��Winlogon���̣�Ȼ��ػ�SAS���ڵĴ�
//          �ڹ��̣��ӹ�WM_HOTKEY��Ϣ���Դﵽ����Ctrl + Alt + Del֮Ŀ�ġ�
//�����Ƚϣ�������2000�����������Ctrl + Alt + Del��ϼ���һ�ֳ����ᵽ�Ľ��������
//	    ��ʹ���Լ�д��GINAȥ�滻MSGINA.DLL��Ȼ����WlxLoggedOnSAS���ֱ�ӷ���
//	    WLX_SAS_ACTION_NONE���ٺ٣�˵�����Ⲣ���������������������ϼ���ֻ��
//	    ֱ�ӷ���WLX_SAS_ACTION_NONEʱ��Winlogon�������Զ���"Winlogon"�����л�
//	    ��ԭ����"Default"�����ˣ���������ʾ��ȫ�Ի������Կ������������ˣ�����
//	    ʹ�����ַ������Եؿ�����������˸������ʹ�ñ��ĵķ���ʱ���㲻�ῴ����
//	    ����˸��

#include <vcl.h>
#pragma hdrstop

#include "RunMain.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender)
{
     hDLLInst = LoadLibrary("RunDLL.dll");        
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{
    if(hDLLInst)
        {
           EnabledKey=(_EnabledKey)GetProcAddress(hDLLInst, "EnabledKey");
           if(EnabledKey){
               DLLPath=ExtractFilePath(Application->ExeName) + "SASHOOK.dll";
               if (EnabledKey(DLLPath.c_str())) ShowMessage("�ɹ�����");
           }

        }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button2Click(TObject *Sender)
{
   if(hDLLInst)
        {
           DisabledKey=(_EnabledKey)GetProcAddress(hDLLInst, "DisabledKey");
           if(DisabledKey){
               DLLPath=ExtractFilePath(Application->ExeName) + "SASHOOK.dll";
               if (DisabledKey(DLLPath.c_str()))
               ShowMessage("����ɹ�");
           }

        }
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormDestroy(TObject *Sender)
{
    FreeLibrary(hDLLInst);        
}
//---------------------------------------------------------------------------

