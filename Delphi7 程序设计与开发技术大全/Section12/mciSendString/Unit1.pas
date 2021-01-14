unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MMSystem;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ListBox1: TListBox;
    Label1: TLabel;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    RetBuf:array[0..1024]of char;    //����mciSendString������ȡ����Ϣ
    mciErr:MCIERROR;                 //����mciSendString�����ķ���ֵ
    ComStr:array[0..256]of char;     //����mciSendString������ָ���ַ���
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  TrackNum,i:Integer;
begin
  //��CD
  mciErr:=mciSendString('opencdaudio',RetBuf,1024,0);
  if mciErr=0 then
  begin
    //��ȡCD������
    mciErr:=mciSendString('statuscdaudionumberoftracks',RetBuf,1024,0);
    if mciErr=0 then
    begin
      TrackNum:=StrToInt(RetBuf);
      Edit1.Text:=RetBuf;
      ListBox1.Clear;
      //����ʱ���ʽ
      mciErr:=mciSendString('setcdaudiotimeformatTMSF',nil,0,0);
      if mciErr=0 then
      begin
        for i:=1 to TrackNum do
        begin
          //��ȡÿ�������ʱ�䳤��
          StrFmt(ComStr,'statuscdaudiolengthtrack%d',[i]);
          mciErr:=mciSendString(ComStr,RetBuf,1024,0);
          if mciErr=0 then
          begin
            ListBox1.Items.Add(RetBuf);
            Button2.Enabled:=True;
          end;
        end;
      end;
    end
    else
      MessageBox(Handle,'��ȡCD�����ʧ�ܡ�','����',MB_OK+MB_ICONERROR);
  end
  else
    MessageBox(Handle,'CDû��׼���á�','����',MB_OK+MB_ICONERROR);
End;

procedure TForm1.Button2Click(Sender: TObject);
begin
  //�ж��Ƿ������һ�׸���
  if(ListBox1.ItemIndex+1)=StrToInt(Edit1.Text)then
    //���һ�׵����
    StrFmt(ComStr,'playcdaudiofrom%dnotify',[ListBox1.ItemIndex+1])
  else//ͨ�������
    StrFmt(ComStr,'playcdaudiofrom%dto%dnotify',
            [ListBox1.ItemIndex+1,ListBox1.ItemIndex+2]);
  //����ָ������Ŀ
  mciErr:=mciSendString(ComStr,RetBuf,1024,0);
  if mciErr<>0 then
    MessageBox(Handle,'����ʧ�ܡ�','����',MB_OK+MB_ICONERROR)
  else
    Button3.Enabled:=True;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  //ֹͣ���ŵ�ǰ����Ŀ
  mciErr:=mciSendString('stopcdaudio',nil,0,Handle);
  if mciErr<>0 then
    MessageBox(Handle,'ֹͣ����ʧ�ܡ�','����',MB_OK+MB_ICONERROR);
  Button3.Enabled:=False;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  //ֹͣ���ŵ�ǰ����Ŀ
  mciSendString('stopcdaudio',nil,0,Handle);
  //�ر�CD
  mciSendString('closecdaudio',nil,0,Handle);
end;

end.
