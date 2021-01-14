unit zfcxtj_;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, TeEngine, Series, Buttons,
  TeeProcs, Chart, XPMenu;

type
  Tzfcxtj = class(TForm)
    Panel1: TPanel;
    Button2: TButton;
    Emsr: TEdit;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ChartYear: TChart;
    BitBtn1: TBitBtn;
    Eyear: TEdit;
    Series1: TBarSeries;
    Label5: TLabel;
    XPMenu1: TXPMenu;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  zfcxtj: Tzfcxtj;

implementation

uses DMyzcx_;

{$R *.dfm}

procedure Tzfcxtj.Button1Click(Sender: TObject);
begin
  dmyzcx.ADOSPMoneyAll.Parameters.ParamByName('@StartTime').Value:=DateTimePicker1.DateTime;
  dmyzcx.ADOSPMoneyAll.Parameters.ParamByName('@EndTime').Value:=DateTimePicker2.DateTime;
  dmyzcx.ADOSPMoneyAll.Parameters.ParamByName('@MoneyAll').Value:=0;
  DMyzcx.ADOSPMoneyAll.ExecProc;

  Emsr.Text:=floattostr(DMyzcx.ADOSPMoneyAll.Parameters.parambyname('@MoneyAll').Value);

end;

procedure Tzfcxtj.BitBtn1Click(Sender: TObject);
var
  IntMonth:ARRAY[1..12] OF integer;//����һ����12���µ�����
  i:integer;
begin
  if Eyear.Text='' then
  begin
    showmessage('���������');
    Eyear.SetFocus;
    exit;
  end;

  try
     DMyzcx.ADOSPMonthMoneyAll.Parameters.ParamByName('@year').Value:=Eyear.Text;
  except
     showmessage('����ȷ�������');
     Eyear.SetFocus;
     exit;
  end;

  DMyzcx.ADOSPMonthMoneyAll.ExecProc;//ִ��

  //���鸶ֵ
  for i:=1 to 12 do
    IntMonth[i]:=DMyzcx.ADOSPMonthMoneyAll.Parameters.ParamByName('@Month'+inttostr(i)).Value;


  ChartYear.Title.Text.Text:=Eyear.Text+'�� ë��������ͳ��ͼ';//char�ı���
  series1.Clear;
  series1.AddArray([0,IntMonth[1],IntMonth[2],IntMonth[3],IntMonth[4],IntMonth[5],IntMonth[6],IntMonth[7],IntMonth[8],IntMonth[9],IntMonth[10],IntMonth[11],IntMonth[12]]);


end;

end.
