unit khthut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, DB, ADODB, Buttons;

type
  Tkhthfm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    clmcbox: TComboBox;
    clbhedit: TEdit;
    clplbox: TComboBox;
    sledit: TEdit;
    dwbox: TComboBox;
    zjeedit: TEdit;
    clggbox: TComboBox;
    cldjedit: TEdit;
    clksbox: TComboBox;
    ADOQuery: TADOQuery;
    rkbt: TSpeedButton;
    qxbt: TSpeedButton;
    gbbt: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure clmcboxChange(Sender: TObject);
    procedure clmcboxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure clggboxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure clksboxChange(Sender: TObject);
    procedure clksboxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  khthfm: Tkhthfm;

implementation

{$R *.dfm}

procedure Tkhthfm.FormCreate(Sender: TObject);
var
mypath:string;
gg,ks,mc:string;
begin
//mypath:=extractfilepath(paramstr(0));
//ADOquery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+mypath+'data\kcgl.mdb;Persist Security Info=False';
//ADOquery.active:=true;

with adoquery do
begin
close;
sql.Clear;
sql.Add('select * from bhb');
open;
first;
gg:='';
ks:='';
mc:='';
while not eof do
begin
if (mc<>fieldbyname('����').AsString) then
clmcbox.Items.Add(fieldbyname('����').AsString);
if (gg<>fieldbyname('���').AsString) then
clggbox.Items.Add(fieldbyname('���').AsString);
if ks<>fieldbyname('��ʽ').AsString then
clksbox.Items.Add(fieldbyname('��ʽ').AsString);
mc:=fieldbyname('����').AsString;
gg:=fieldbyname('���').AsString;
ks:=fieldbyname('��ʽ').AsString;
next;
end;
end;
end;

procedure Tkhthfm.clmcboxChange(Sender: TObject);
begin
with adoquery do
begin
close;
sql.Clear;
sql.Add('select * from bhb where ����=:mc');
Parameters.ParamByName('mc').Value:=trim(clmcbox.Text);
open;
if recordcount>=1 then
begin
first;
clggbox.Clear;
clksbox.Clear;
while not eof do
begin
clggbox.Items.Add(fieldbyname('���').AsString);
clksbox.Items.Add(fieldbyname('��ʽ').AsString);
next;
end;
end;
end;
end;

procedure Tkhthfm.clmcboxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
 var
  str:string;
begin
if key=13 then
begin
if (clmcbox.Text='') then
 begin
  showmessage('�������������!');
  clmcbox.SetFocus;
  exit;
 end;
str:='select * from bhb where ����=:bm or ����=:mc';
with ADOQuery do
  begin
    close;
    sql.Clear;
    sql.Add(str);
    Parameters.ParamByName('bm').Value:=trim(clmcbox.Text);
    Parameters.ParamByName('mc').Value:=trim(clmcbox.Text);
    open;
   if recordcount>=1 then
     begin
       //if recordcount>=2 then
         //begin
           //clmcbox.Clear;
            //first;
         //  while not eof do
              //begin
                clmcbox.Items.Add(fieldbyname('����').AsString);
               // next;
              //end;
                 //clmcbox.SetFocus;
                // clmcbox.DroppedDown:=true;
                // clmcbox.AutoDropDown:=true;

//   end
        //else
           //begin
             clmcbox.AutoDropDown:=false;
             clmcbox.text:=fieldbyname('����').AsString;
             clggbox.SetFocus;
          // end;
        end
      else
     begin
     if (clmcbox.Text>='0') and (clmcbox.Text<='z') then
     begin
       showmessage('������������Ĳ��ϱ�������!');
       clmcbox.SetFocus;
    end
     else
      clggbox.SetFocus;
  end;
    end;
    end;
end;

procedure Tkhthfm.clggboxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then
if (clggbox.Text='') then
 begin
  showmessage('��ѡ����!');
  clggbox.SetFocus;
  exit;
 end
else
clksbox.SetFocus;
end;

procedure Tkhthfm.clksboxChange(Sender: TObject);
begin
if (clksbox.Text='') then
 begin
  showmessage('��ѡ���ʽ!');
  clksbox.SetFocus;
  exit;
 end;
with adoquery do
begin
close;
sql.Clear;
sql.Add('select * from bhb where ����=:mc and ���=:gg and ��ʽ=:ks');
Parameters.ParamByName('mc').Value:=trim(clmcbox.Text);
Parameters.ParamByName('gg').Value:=trim(clggbox.Text);
Parameters.ParamByName('ks').Value:=trim(clksbox.Text);
open;
clbhedit.Text:=fieldbyname('���').AsString;
clplbox.Text:=fieldbyname('Ʒ��').AsString;
dwbox.Text:=fieldbyname('��λ').AsString;
//hwedit.Text:=fieldbyname('��λ').AsString;
end;

end;

procedure Tkhthfm.clksboxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then
begin
if (clksbox.Text='') then
 begin
  showmessage('��ѡ���ʽ!');
  clksbox.SetFocus;
  exit;
 end
else
clbhedit.SetFocus;
//jhdwbox.Clear;
with adoquery do
begin
close;
sql.Clear;
sql.Add('select * from bhb where ����=:mc and ���=:gg and ��ʽ=:ks');
Parameters.ParamByName('mc').Value:=trim(clmcbox.Text);
Parameters.ParamByName('gg').Value:=trim(clggbox.Text);
Parameters.ParamByName('ks').Value:=trim(clksbox.Text);
open;
if recordcount=1 then
begin
clbhedit.Text:=fieldbyname('���').AsString;
clplbox.Text:=fieldbyname('Ʒ��').AsString;
dwbox.Text:=fieldbyname('��λ').AsString;
end
else
 showmessage('����������������ƺ͹���ʽ�ı��,��˶Ի����Լ������ţ�');
end;

end;
end;

end.
