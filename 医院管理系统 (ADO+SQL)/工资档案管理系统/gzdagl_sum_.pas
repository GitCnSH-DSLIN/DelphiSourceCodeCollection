unit gzdagl_sum_;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, DbChart, Grids,
  DBGrids, ComCtrls, MXDB, MXGRID, DB, DBTables, MXTABLES, Mxstore,
  StdCtrls, Buttons;

type
  TForm_sum = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBChart1: TDBChart;
    Series1: TBarSeries;
    TabSheet2: TTabSheet;
    DBGrid2: TDBGrid;
    DBChart2: TDBChart;
    Series2: TPieSeries;
    DBGrid1: TDBGrid;
    TabSheet3: TTabSheet;
    DBGrid3: TDBGrid;
    DBChart3: TDBChart;
    Series3: THorizBarSeries;
    BTbutie_view: TBitBtn;
    BTfenglei_view: TBitBtn;
    procedure BTbutie_viewClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure BTfenglei_viewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_sum: TForm_sum;

implementation

uses gzdagl_DM_;

{$R *.dfm}

procedure TForm_sum.BTbutie_viewClick(Sender: TObject);
begin
//ͳ�Ʋ���������
DMgzdagl.ADOQsum_butie.Open;
series2.Add(trunc(DMgzdagl.ADOQsum_butie.FieldValues['�ۺϲ����ܺ�']),'�ۺϲ����ܺ�',clskyblue);
series2.Add(trunc(DMgzdagl.ADOQsum_butie.FieldValues['��Ͳ����ܺ�']),'��Ͳ����ܺ�',clred);
series2.Add(trunc(DMgzdagl.ADOQsum_butie.FieldValues['ס�������ܺ�']),'ס�������ܺ�',clyellow);
series2.Add(trunc(DMgzdagl.ADOQsum_butie.FieldValues['ҽ�Ʋ����ܺ�']),'ҽ�Ʋ����ܺ�',clgreen);
series2.Add(trunc(DMgzdagl.ADOQsum_butie.FieldValues['���������ܺ�']),'���������ܺ�',clblue);
series2.Add(trunc(DMgzdagl.ADOQsum_butie.FieldValues['��������ܺ�']),'��������ܺ�',clbtnface);
series2.Add(trunc(DMgzdagl.ADOQsum_butie.FieldValues['�����ܺ�']),'�����ܺ�',cllime);
BTbutie_view.Enabled:=false;
end;

procedure TForm_sum.PageControl1Change(Sender: TObject);
begin
if pagecontrol1.ActivePageIndex=0 then
   series2.Clear;
   series3.Clear;
   BTbutie_view.Enabled:=true;
   BTfenglei_view.Enabled:=true;
if pagecontrol1.ActivePageIndex=1 then
   series3.Clear;
   BTbutie_view.Enabled:=true;
if pagecontrol1.ActivePageIndex=2 then
   series2.Clear;
   BTfenglei_view.Enabled:=true;
end;

procedure TForm_sum.BTfenglei_viewClick(Sender: TObject);
begin
form_sum.series3.Add(trunc(DMgzdagl.ADOQsum_xingshui.FieldValues['���������ܺ�']),'���������ܺ�');
form_sum.series3.Add(trunc(DMgzdagl.ADOQsum_xingshui.FieldValues['ְλ�����ܺ�']),'ְλ�����ܺ�');
form_sum.series3.Add(trunc(DMgzdagl.ADOQsum_xingshui.FieldValues['�������ܺ�']),'�������ܺ�');
form_sum.series3.Add(trunc(DMgzdagl.ADOQsum_xingshui.FieldValues['���乤���ܺ�']),'���乤���ܺ�');
form_sum.series3.Add(trunc(DMgzdagl.ADOQsum_xingshui.FieldValues['��λ�����ܺ�']),'��λ�����ܺ�');
form_sum.series3.Add(trunc(DMgzdagl.ADOQsum_xingshui.FieldValues['�����ܺ�']),'�����ܺ�');
 btfenglei_view.Enabled:=false;
end;

end.
