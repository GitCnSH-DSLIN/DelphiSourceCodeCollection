unit U_bmlldcx;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, Grids, DBGrids, Db, DBClient, ImgList, ToolWin;

type
  TForm74 = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    ImageList1: TImageList;
    Timer1: TTimer;
    Panel2: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    procedure ToolButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form74: TForm74;

implementation

uses U_mainform, U_dwck, U_szcx, U_general_print;

{$R *.DFM}

procedure TForm74.ToolButton1Click(Sender: TObject);
begin
  application.createform(Tform77, form77);
  form77.combobox1.items.add('�����ֺ�');
  form77.combobox1.items.add('���ϱ���');
  form77.combobox1.items.add('��������');
  form77.combobox1.items.add('ʵ������');
  form77.combobox1.items.add('��������');
  form77.combobox1.items.add('����ͺ�');
  form77.combobox1.items.add('���ϵ�λ');
  form77.combobox1.items.add('������Ŀ');
  form77.combobox1.items.add('������;');
  form77.combobox1.items.add('�Ƶ�����');
  form77.combobox1.items.add('������');
  form77.combobox1.items.add('������');
  form77.combobox1.items.add('�Ƿ����');
  v_table := 'VIEW_CL_BMLLD';
  try
    form77.showmodal;
  finally
    form77.free;
    if sf_qr = 'yes' then
    begin
      clientdataset1.filter := xx401;
      clientdataset1.filtered := true;
    end;
  end;

end;

procedure TForm74.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ACTION := CAFREE;
  form74 := nil;
end;

procedure TForm74.ToolButton2Click(Sender: TObject);
var
  vs_value: string;
  vi, i: integer;
begin
  application.createform(Tform78, form78);
  form78.srclist.items.add('�����ֺ�');
  form78.srclist.items.add('���ϱ���');
  form78.srclist.items.add('��������');
  form78.srclist.items.add('ʵ������');
  form78.srclist.items.add('��������');
  form78.srclist.items.add('����ͺ�');
  form78.srclist.items.add('���ϵ�λ');
  form78.srclist.items.add('������Ŀ');
  form78.srclist.items.add('������;');
  form78.srclist.items.add('�Ƶ�����');
  form78.srclist.items.add('������');
  form78.srclist.items.add('������');
  form78.srclist.items.add('�Ƿ����');
  try
    form78.showmodal;
  finally
    if sf_qd1 = 'yes' then
    begin
      vi := form78.DstList.Items.Count;
      if vi > 0 then
      begin
        vs_value := form78.dstlist.items[0];
      end;
      for i := 2 to vi do
      begin
        vs_value := vs_value + ';' + form78.dstlist.items[i - 1];
      end;
      clientdataset1.IndexFieldNames := vs_value;
    end;
    form78.free;
  end;
end;

procedure TForm74.Timer1Timer(Sender: TObject);
begin
  statusbar1.Panels[2].text := '���У�' + inttostr(clientdataset1.recordcount) + '����¼';
  statusbar1.refresh;

end;

procedure TForm74.ToolButton4Click(Sender: TObject);
begin
  application.createform(Tform80, form80);
  form80.srclist.items.add('�����ֺ�');
  form80.srclist.items.add('���ϱ���');
  form80.srclist.items.add('��������');
  form80.srclist.items.add('ʵ������');
  form80.srclist.items.add('��������');
  form80.srclist.items.add('����ͺ�');
  form80.srclist.items.add('���ϵ�λ');
  form80.srclist.items.add('������Ŀ');
  form80.srclist.items.add('������;');
  form80.srclist.items.add('�Ƶ�����');
  form80.srclist.items.add('������');
  form80.srclist.items.add('������');
  form80.srclist.items.add('�Ƿ����');
  vps_tablename := 'view_cl_bmlld';
  vps_filter := clientdataset1.Filter;
  vps_index := clientdataset1.IndexFieldNames;
  Form80.Edit1.Text := '�������ϵ��ݴ�ӡ';
  try
    form80.showmodal;
  finally
    form80.free;
  end;
end;

procedure TForm74.ToolButton3Click(Sender: TObject);
begin
  clientdataset1.close;
  clientdataset1.filter:='';
  clientdataset1.Filtered := false;
  clientdataset1.open;
end;

procedure TForm74.DBGrid1TitleClick(Column: TColumn);
begin
  Form1.MySort(dbgrid1, column);
end;

end.
