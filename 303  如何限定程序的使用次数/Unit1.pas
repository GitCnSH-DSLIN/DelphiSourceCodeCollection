unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Registry;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var 
    re_id:integer;
    registerTemp : TRegistry;
    inputstr,get_id:string;
    dy,clickedok:boolean; 
begin
  dy:=false; //����Ƿ��ѵ�ע���ڡ����Ƿ��������ʹ�õı�־����ֵΪFALSE��Ϊ����ʹ�á�
  registerTemp := TRegistry.Create; //׼��ʹ��ע���
  with registerTemp do
  begin
    RootKey:=HKEY_LOCAL_MACHINE; //����ڴ˸���
    if OpenKey('Software\Microsoft\Windows\CurrentVersion\Mark',True) then
     // ��һĿ¼����ű�־ֵ��
      begin
          if valueexists('gc_id') then begin //��gc_id��ֵ��Ϊ��־�������ж����Ƿ����
              re_id:=readinteger('gc_id');//������־ֵ
              if (re_id<>0) and (re_id<>100) then begin //����־ֵΪ0����˵����ע�ᡣ
              //����Ϊ0��ֵ����100,˵����δע�ᣬ������ʹ�õĴ�����δ�ﵽ��
                re_id:=re_id+5; //�����־�����ֵΪ100��ÿ�μ�5�������ֻ����20�Ρ�
                Writeinteger('gc_id',re_id);//�����º�ı�־ֵд��ע����С�
          end;
          if re_id=100 then dy:=true; //����ֵ�ѵ�100����Ӧע�ᡣ
        end
      else Writeinteger('gc_id',5);//������־�����ó�ʼ��־ֵ��
    end;
    if dy then begin //��dyֵΪTRUE����Ӧ��ʾ�û�����ע���룬����ע�ᡣ
        clickedok:=InputQuery('��ʹ�õ���ע�����,������ע���룺',' ',inputstr);
        if clickedok then begin
            get_id:=inttostr(27593758*2);//ע����Ϊ55187516
            if get_id=inputstr then begin
                Writeinteger('gc_id',0);//�������ע������ȷ���򽫱�־ֵ��Ϊ0,����ע�ᡣ
                CloseKey;
                Free;
              end
            else begin //�������ע�������Ӧ������ʾ���ܾ��������ʹ��
                application.messagebox('ע�������!����������ϵ!','�����',mb_ok);
                CloseKey;
                Free;
                application.terminate; //��ֹ�������У��ܾ��������ʹ��
            end;
            end
        else begin //���û�������ע���룬ҲӦ������ʾ���ܾ��������ʹ��
            application.messagebox('����������ϵ��ʹ��ע�����!','�����',mb_ok);
            CloseKey;
            Free;
            application.terminate;
        end;
    end;
  end;
end;


end.
