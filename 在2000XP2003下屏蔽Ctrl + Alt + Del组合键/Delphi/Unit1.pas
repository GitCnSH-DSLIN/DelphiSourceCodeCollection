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
//�����ʽ��  EnabledKey: function (DllFileName: PChar): BOOL; stdcall;
//              DisabledKey: function (DllFileName: PChar): BOOL; stdcall;
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
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    DllHandle: Cardinal;
    DllFileName: PChar;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  EnabledKey: function (DllFileName: PChar): BOOL; stdcall;
  DisabledKey: function (DllFileName: PChar): BOOL; stdcall;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
    DllHandle := LoadLibrary('RunDLL.dll');
    DllFileName := PChar(ExtractFilePath(Application.ExeName )+'SASHOOK.dll');
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    FreeLibrary(DllHandle);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     if DllHandle <> 0 then
      begin
           EnabledKey := GetProcAddress(DllHandle, 'EnabledKey');
           if @EnabledKey <> nil then
           begin
             if EnabledKey(DllFileName) then
                ShowMessage('�ɹ�����');
           end;
        end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   if DllHandle <> 0 then
      begin
           DisabledKey := GetProcAddress(DllHandle, 'DisabledKey');
           if @DisabledKey <> nil then
           begin
             if DisabledKey(DllFileName) then
                ShowMessage('����ɹ�');
           end;
        end;
end;

end.
