unit Unit1;

interface

uses
  Windows, Messages,mmsystem, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var 
  i: Integer; 
  C: String; 
  DType: Integer; 
  DriveString: String; 
  driver:pchar;
  sec1, byt1, cl1, cl2:longword;
begin
  //ͨ��ѭ�������жϸ��̷�������
  for i := 65 to 90 do
  begin
    C := chr(i)+':\'; 
    DType := GetDriveType(PChar(C));
    case DType of
      0: DriveString := C+' �����жϵ�����������.';
      1: if chr(i)>'C' then
           Exit
         else
           DriveString := C+' ��Ŀ¼������.';
      DRIVE_REMOVABLE: DriveString :=
         C+' ����һ�����ƶ�������';
      DRIVE_FIXED: DriveString :=
         C+' ����Ӳ��������.';
      DRIVE_REMOTE: DriveString := 
         C+' ����һ������������.';
      DRIVE_CDROM: DriveString := C+' ����һ������������.';
      DRIVE_RAMDISK: DriveString := C+' ����һ������Ӳ��.';
    end;
    Memo1.Lines.Add(DriveString);
    driver:=pchar(c);//Ҫ��ʾ����������
    GetDiskFreeSpace(driver, sec1, byt1, cl1, cl2);
    cl1 := cl1*sec1 * byt1;
    cl2 := cl2*sec1 * byt1;
    Memo1.Lines.add('���������ܹ�����' + Formatfloat('###,##0',cl2) + '�ֽ�');
    Memo1.Lines.add('����������������' + Formatfloat('###,##0',cl1) + '�ֽ�');
    Memo1.Lines.Add('');
  end;
end; 


end.
