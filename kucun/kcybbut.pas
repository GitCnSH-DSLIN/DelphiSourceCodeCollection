unit kcybbut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, QRCtrls, QuickRpt, ExtCtrls;

type
  Tkcybbfm = class(TForm)
    Panel1: TPanel;
    kcybb: TQuickRep;
    TitleBand1: TQRBand;
    QRLabel10: TQRLabel;
    zbrq: TQRLabel;
    DetailBand1: TQRBand;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    clmc: TQRMemo;
    gg: TQRMemo;
    zje: TQRMemo;
    PageHeaderBand1: TQRBand;
    bt: TQRLabel;
    ADOQuery: TADOQuery;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    dw: TQRMemo;
    qqkc: TQRMemo;
    bqjh: TQRMemo;
    bqxh: TQRMemo;
    qmkc: TQRMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  kcybbfm: Tkcybbfm;

implementation

{$R *.dfm}

procedure Tkcybbfm.FormCreate(Sender: TObject);
var
mypath:string;
sumje,sumsl:integer;
Present: TDateTime;
  Year, Month, Day: Word;
begin
sumje:=0;
sumsl:=0;
present:=now;
DecodeDate(Present, Year, Month, Day);
bt.Caption:=inttostr(Month)+'�·ݿ�������̴汨��';
mypath:=extractfilepath(paramstr(0));
ADOquery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+mypath+'data\kcgl.mdb;Persist Security Info=False';
//ADOquery.active:=true;
zbrq.Caption:=datetostr(date());

with adoquery do
begin
close;
sql.Clear;
sql.Add('select * from kcb');
//Parameters.ParamByName('rq').Value:=datetostr(date());
open;
first;
while not eof do
begin

//clbh.Lines.Add(fieldbyname('���').AsString);
//clmc.Lines.Add(fieldbyname('����').AsString);
//pl.Lines.Add(fieldbyname('Ʒ��').AsString);
//sl.Lines.Add(fieldbyname('��ĩ���').AsString);
zje.Lines.Add(fieldbyname('�ܽ��').AsString);
//hw.Lines.Add(fieldbyname('��λ').AsString);
//sumje:=sumje+fieldbyname('�ܽ��').AsInteger;
//sumsl:=sumsl+fieldbyname('��ĩ���').AsInteger;

next;
end;
//zsl.Caption:='��������'+inttostr(sumsl);
//zgje.Caption:='�ܽ�'+inttostr(sumje);
end;
end;

end.
