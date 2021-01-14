unit ghsut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ExtCtrls, DB, ADODB, Buttons;

type
  Tghsglfm = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ghsmcedit: TEdit;
    cpzledit: TEdit;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    ADOQuery: TADOQuery;
    DataSource1: TDataSource;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Label3: TLabel;
    dzedit: TEdit;
    Label4: TLabel;
    dhedit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ghsglfm: Tghsglfm;

implementation

{$R *.dfm}

procedure Tghsglfm.FormCreate(Sender: TObject);
var
mypath:string;
begin
//mypath:=extractfilepath(paramstr(0));
//ADOquery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+mypath+'data\kcgl.mdb;Persist Security Info=False';
//ADOquery.active:=true;
with adoquery do
begin
close;
sql.Clear;
sql.Add('select * from ghdwb');
open;
end;
end;

procedure Tghsglfm.DBGrid1CellClick(Column: TColumn);
begin
with adoquery do
begin
ghsmcedit.Text:=fieldbyname('������').asstring;
cpzledit.Text:=fieldbyname('����Ʒ��').asstring;
dzedit.Text:=fieldbyname('��ַ').AsString;
dhedit.Text:=fieldbyname('�����绰').AsString;
end;
end;

procedure Tghsglfm.SpeedButton1Click(Sender: TObject);
begin
if ghsmcedit.Text='' then
begin
showmessage('������������Ϊ��!');
exit;
end;
try
with adoquery do
begin
close;
sql.Clear;
sql.Add('insert into  ghdwb (������,����Ʒ��,�����绰,��ַ) values(:ghs,:pl,:dgdh,:dz)');
Parameters.ParamByName('ghs').Value:=trim(ghsmcedit.Text);
Parameters.ParamByName('pl').Value:=trim(cpzledit.Text);
Parameters.ParamByName('dgdh').Value:=trim(dhedit.Text);
Parameters.ParamByName('dz').Value:=trim(dzedit.Text);
execsql;
showmessage('��ӳɹ�!');
ghsmcedit.Text:='';
cpzledit.Text:='';
dhedit.Text:='';
dzedit.Text:='';
end;
except
showmessage('���ʧ��!');
end;
with adoquery do
begin
close;
sql.Clear;
sql.Add('select * from ghdwb');
open;
end;
end;

procedure Tghsglfm.SpeedButton4Click(Sender: TObject);
begin
ghsmcedit.Text:='';
cpzledit.Text:='';
dhedit.Text:='';
dzedit.Text:='';
end;

procedure Tghsglfm.SpeedButton2Click(Sender: TObject);
begin
try
with adoquery do
begin
close;
sql.Clear;
sql.Add('update ghdwb set ����Ʒ��=:pl,�����绰=:dgdh,��ַ=:dz where ������=:ghs');
Parameters.ParamByName('ghs').Value:=trim(ghsmcedit.Text);
Parameters.ParamByName('pl').Value:=trim(cpzledit.Text);
Parameters.ParamByName('dgdh').Value:=trim(dhedit.Text);
Parameters.ParamByName('dz').Value:=trim(dzedit.Text);
execsql;
showmessage('�޸ĳɹ�!');
ghsmcedit.Text:='';
cpzledit.Text:='';
dhedit.Text:='';
dzedit.Text:='';
end;
 except
showmessage('�޸�ʧ��!');
end;
with adoquery do
begin
close;
sql.Clear;
sql.Add('select * from ghdwb');
open;
end;
end;

procedure Tghsglfm.SpeedButton3Click(Sender: TObject);
begin
if messagedlg('ȷ��ɾ����?',mtconfirmation,[mbyes,mbno],0)=mryes then
begin
try
with adoquery do
begin
close;
sql.Clear;
sql.Add('delete from ghdwb where ������=:ghs');
Parameters.ParamByName('ghs').Value:=trim(ghsmcedit.Text);
execsql;
showmessage('ɾ���ɹ�!');
ghsmcedit.Text:='';
cpzledit.Text:='';
dhedit.Text:='';
dzedit.Text:='';
end;
except
showmessage('ɾ��ʧ��!');
end;
with adoquery do
begin
close;
sql.Clear;
sql.Add('select * from ghdwb');
open;
end;
end;
end;

procedure Tghsglfm.SpeedButton5Click(Sender: TObject);
begin
close;
end;

end.
