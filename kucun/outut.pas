unit outut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, DB, ADODB;

type
  Tinfm = class(TForm)
    inpl: TPanel;
    Label15: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    clmcbox: TComboBox;
    clbhedit: TEdit;
    clplbox: TComboBox;
    sledit: TEdit;
    dwbox: TComboBox;
    zjeedit: TEdit;
    jhdwbox: TComboBox;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    jhrbox: TComboBox;
    jhrqbox: TComboBox;
    jsrbox: TComboBox;
    rkrqbox: TComboBox;
    hwedit: TEdit;
    bgybox: TComboBox;
    djbhedit: TEdit;
    GroupBox3: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    ADOQuery: TADOQuery;
    Label16: TLabel;
    jyybox: TComboBox;
    procedure SpeedButton5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  infm: Tinfm;

implementation

{$R *.dfm}

procedure Tinfm.SpeedButton5Click(Sender: TObject);
begin
close;
end;

procedure Tinfm.FormCreate(Sender: TObject);
var
mypath:string;
begin
//mypath:=extractfilepath(paramstr(0));
//ADOquery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+mypath+'data\kcgl.mdb;Persist Security Info=False';
//ADOquery.active:=true;
end;

procedure Tinfm.SpeedButton1Click(Sender: TObject);
var
 str:string;
begin
if clmcbox.Text='' then
begin
showmessage('�������Ʋ���Ϊ��!');
exit;
end;
try
with adoquery do
begin
close;
sql.Clear;
str:='insert into  rkb (��������,���ϱ��,Ʒ��,����,��λ,�ܽ��,������λ';
str:=str+',������,��������,������,�������,��λ,����Ա,���ݱ��,������)';
str:=str+' values(:clmc,:clbh,:pl,:sl,:dw,:zje,:jhdw,:jhr,:jhrq,:jsr,:rkrq,:hw,:bgy,:djbh,jyr)';
sql.Add(str);
Parameters.ParamByName('clmc').Value:=trim(clmcbox.Text);
Parameters.ParamByName('clbh').Value:=trim(clbhedit.Text);
Parameters.ParamByName('pl').Value:=trim(clplbox.Text);
Parameters.ParamByName('sl').Value:=trim(sledit.Text);
Parameters.ParamByName('dw').Value:=trim(dwbox.Text);
Parameters.ParamByName('zje').Value:=trim(zjeedit.Text);
Parameters.ParamByName('jhdw').Value:=trim(jhdwbox.Text);
Parameters.ParamByName('jhr').Value:=trim(jhrbox.Text);
Parameters.ParamByName('jhrq').Value:=trim(jhrqbox.Text);
Parameters.ParamByName('jsr').Value:=trim(jsrbox.Text);
Parameters.ParamByName('rkrq').Value:=trim(rkrqbox.Text);
Parameters.ParamByName('hw').Value:=trim(hwedit.Text);
Parameters.ParamByName('bgy').Value:=trim(bgybox.Text);
Parameters.ParamByName('djbh').Value:=trim(djbhedit.Text);
Parameters.ParamByName('jyr').Value:=trim(jyybox.Text);
execsql;
showmessage('���ɹ�!');

end;
except
showmessage('���ʧ��!');
end;
with adoquery do
begin
close;
sql.Clear;
sql.Add('select * from rkb');
open;
end;
end;

end.
