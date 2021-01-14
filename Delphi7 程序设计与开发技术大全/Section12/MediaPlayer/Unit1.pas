unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MPlayer, ExtCtrls;

type
  TForm1 = class(TForm)
    MediaPlayer1: TMediaPlayer;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    OpenDialog1: TOpenDialog;
    Label3: TLabel;
    Edit3: TEdit;
    Panel1: TPanel;
    procedure MediaPlayer1Click(Sender: TObject; Button: TMPBtnType;
      var DoDefault: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure MediaPlayer1Notify(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.MediaPlayer1Click(Sender: TObject; Button: TMPBtnType;
  var DoDefault: Boolean);
begin
  //���ݰ��µİ�ť����"״̬"��Ϣ
  case Button of
    btPlay:Edit3.Text:='���ڲ���...';
    btPause:Edit3.Text:='��ʱ�ж�';
    btStop:Edit3.Text:='ֹͣ';
    btNext:Edit3.Text:='���';
    btPrev:Edit3.Text:='��ǰ';
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  //�Դ򿪶Ի����ʼ��
  OpenDialog1.Filter:='�����ļ�(*.wav)|*.wav|Midifiles(*.mid)|*.mid|AVI�ļ�(*.avi)|*.avi';
  if OpenDialog1.Execute then
  begin
    Edit1.Text:=OpenDialog1.FileName;
    MediaPlayer1.FileName:=OpenDialog1.FileName;
    MediaPlayer1.AutoOpen:=True;//�Զ���
    MediaPlayer1.Open;
    MediaPlayer1.Notify:=True;
    //ָ�����ŵĴ��ڴ�С
    MediaPlayer1.DisplayRect:=Rect(3,3,Panel1.Width-6,Panel1.Height-6);
  end;
end;

procedure TForm1.MediaPlayer1Notify(Sender: TObject);
begin
  //����NotifyValue���Ե���ֵ������Ϣ֪ͨ��Ϣ
  case Mediaplayer1.NotifyValue of
    nvSuccessful:Edit2.Text:='�ɹ�';
    nvSuperseded:Edit2.Text:='�Ƴ�';
    nvAborted:Edit2.Text:='����';
    nvFailure:Edit2.Text:='ʧ��';
  end;
  MediaPlayer1.Notify:=True;
end;

end.
