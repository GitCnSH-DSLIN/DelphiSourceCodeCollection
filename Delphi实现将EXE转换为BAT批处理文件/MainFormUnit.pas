{ KOL MCK } // Do not remove this line!
{$DEFINE KOL_MCK}
unit MainFormUnit;

interface

{$IFDEF KOL_MCK}
uses Windows, Messages, KOL {$IFNDEF KOL_MCK}, mirror, Classes, Controls, mckControls, mckObjs, Graphics,  mckCtrls {$ENDIF (place your units here->)}, Exe2BatUnit;
{$ELSE}
{$I uses.inc}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mirror;
{$ENDIF}
type
  {$IFDEF KOL_MCK}
  {$I MCKfakeClasses.inc}
  {$IFDEF KOLCLASSES} {$I Form1class.inc} {$ELSE OBJECTS} PForm1 = ^TForm1; {$ENDIF CLASSES/OBJECTS}
  {$IFDEF KOLCLASSES}{$I TForm1.inc}{$ELSE} TForm1 = object(TObj) {$ENDIF}
    Form: PControl;
  {$ELSE not_KOL_MCK}
  TForm1 = class(TForm)
  {$ENDIF KOL_MCK}
    HkeKOLProject: TKOLProject;
    KOLForm1: TKOLForm;
    ExeNameEdit: TKOLEditBox;
    BatNameEdit: TKOLEditBox;
    ExeNameButton: TKOLButton;
    BatNameButton: TKOLButton;
    StartButton: TKOLButton;
    OS: TKOLOpenSaveDialog;
    help: TKOLLabel;
    procedure ExeNameButtonClick(Sender: PObj);
    procedure BatNameButtonClick(Sender: PObj);
    procedure KOLForm1FormCreate(Sender: PObj);
    procedure StartButtonClick(Sender: PObj);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1 {$IFDEF KOL_MCK} : PForm1 {$ELSE} : TForm1 {$ENDIF} ;

{$IFDEF KOL_MCK}
procedure NewForm1( var Result: PForm1; AParent: PControl );
{$ENDIF}

implementation

{$IFNDEF KOL_MCK} {$R *.DFM} {$ENDIF}

{$IFDEF KOL_MCK}
{$I MainFormUnit_1.inc}
{$ENDIF}




procedure TForm1.ExeNameButtonClick(Sender: PObj);
begin
  OS.OpenDialog:=true;
  OS.Filter:='�����ļ�(*.*)|*.*|Ӧ�ó���(*.exe)|*.exe';
  os.Title:='��ѡ��Ҫת�����ļ� Exe2Bat By Hke WuHansen.Com';
  if OS.Execute then ExeNameEdit.Text:=OS.Filename;
end;

procedure TForm1.BatNameButtonClick(Sender: PObj);
begin
  OS.Filename:='';
  OS.OpenDialog:=False;
  OS.Filter:='�������ļ�(*.bat)|*.bat|�����ļ�(*.*)|*.*';
  os.Title:='��ѡ��Ҫ������ļ� Exe2Bat By Hke WuHansen.Com';
  if OS.Execute then BatNameEdit.Text:=OS.Filename;
end;

procedure TForm1.KOLForm1FormCreate(Sender: PObj);
var
  MyPath:string;
begin
  help.Caption:='�������ļ������������'+#10#13+'(*.bat)    By Hke Www.WuHansen.Com';
  MyPath:=ExtractFilePath(paramstr(0));
  if MyPath[Length(MyPath)] <> '\' then MyPath:=MyPath+'\';
  OS.InitialDir:=MyPath;
end;

procedure TForm1.StartButtonClick(Sender: PObj);
var i:integer;ExeName,ExePath:string;
begin
  ExePath:=ExeNameEdit.Text;
  if (ExePath='��ѡ���ļ�') or (BATNameEdit.Text='��ѡ���ļ�') then exit;
  for i:=length(ExePath) downto 1 do if ExePath[i]='\' then break;
  ExeName:=ExtractFileName(ExePath);
  StartButton.Enabled:=false;
  Bat2Exe(ExeName,ExePath,BatNameEdit.Text);
  StartButton.Enabled:=true;
  extractfilename
end;

end.




