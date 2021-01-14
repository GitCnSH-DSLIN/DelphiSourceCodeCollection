unit U_clsldcx;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, Grids, DBGrids, Db, DBClient, ImgList, ToolWin;

type
  TfrmClsld_CX = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    DBGrid: TDBGrid;
    Panel3: TPanel;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    btnLookUp: TToolButton;
    btnBrowseAll: TToolButton;
    btnOrder: TToolButton;
    btnPrint: TToolButton;
    DataSource: TDataSource;
    procedure btnBrowseAllClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLookUpClick(Sender: TObject);
    procedure btnOrderClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure DBGridTitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClsld_CX: TfrmClsld_CX;

implementation

uses U_mainform, U_szcx, U_general_print, WzglDB, GenQ3, u_public;

{$R *.DFM}

//==ȫ�������ťʵ��

procedure TfrmClsld_CX.btnBrowseAllClick(Sender: TObject);
begin
  //������������Ϊ��
  DM.CDS_CLSLD_CX.close;
  DM.CDS_CLSLD_CX.filter := '';
  DM.CDS_CLSLD_CX.filtered := false;
  DM.CDS_CLSLD_CX.open;
end;

//==�����屻�ر�ʱ

procedure TfrmClsld_CX.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := cafree;
  frmClsld_cx := nil; //��frmClsld_cx��ΪNIl��
end;

//==���Ұ�ť��ʵ�֣��ڴ˵��õ��߽ڣ�������TGenQ3�ؼ�
procedure TfrmClsld_CX.btnLookUpClick(Sender: TObject);
var
  GenQuery: TGenQ3;
begin
  GenQuery := TGenQ3.Create(self);
  GenQuery.v_TableName := 'WZ_View_CLSLD_CX'; //���ñ���
  GenQuery.v_AppServName := frmMain.SocketConnection; //����Ӧ�÷���������
  GenQuery.v_ProviderName := 'P_General'; //���û�ȡ���ݼ����ṩ��
  //==��Ӷ�λ�ֶΣ�������ǰ��ʾʵ���ֶ��������������ʾʵ���ֶεı���
  GenQuery.v_fieldsstrings.Add('�����ֺ�;�����ֺ�');
  GenQuery.v_fieldsstrings.Add('�ֿ�����;�ֿ�����');
  GenQuery.v_fieldsstrings.Add('�Ƶ�����;�Ƶ�����');
  GenQuery.v_fieldsstrings.Add('���ϱ��;���ϱ��');
  GenQuery.v_fieldsstrings.Add('��������;��������');
  GenQuery.v_fieldsstrings.Add('���λ��;���λ��');
  GenQuery.v_fieldsstrings.Add('��ⵥ��;��ⵥ��');
  GenQuery.v_fieldsstrings.Add('ƾ֤����;ƾ֤����');
  GenQuery.v_fieldsstrings.Add('ʵ������;ʵ������');
  GenQuery.v_fieldsstrings.Add('��Ӧ����;��Ӧ����');
  GenQuery.v_fieldsstrings.Add('�ɹ���;�ɹ���');
  GenQuery.v_fieldsstrings.Add('�Ƿ����;�Ƿ����');
  //�򿪴���
  if GenQuery.execute then
  begin
    //��CDS_CLSLD_CX�Ĺ���������ֵ
    DM.CDS_CLSLD_CX.filter := GenQuery.V_filtervalue;
    DM.CDS_CLSLD_CX.filtered := true;
  end;
end;

//==����ť��ʵ��

procedure TfrmClsld_CX.btnOrderClick(Sender: TObject);
var
  vs_value: string;
  vi, i: integer;
begin
  //����ͨ�õ�����Ĵ���
  application.createform(TfrmSzcx, frmSzcx);
  //���������ֶ�
  frmSzcx.SrcList.Items.add('�����ֺ�');
  frmSzcx.srclist.items.add('�ֿ�����');
  frmSzcx.srclist.items.add('�Ƶ�����');
  frmSzcx.srclist.items.add('���ϱ��');
  frmSzcx.srclist.items.add('���λ��');
  frmSzcx.srclist.items.add('��ⵥ��');
  frmSzcx.srclist.items.add('ƾ֤����');
  frmSzcx.srclist.items.add('ʵ������');
  frmSzcx.srclist.items.add('��������');
  frmSzcx.srclist.items.add('��Ӧ����');
  frmSzcx.srclist.items.add('�ɹ���');
  try
    frmSzcx.showmodal;
  finally
    if Ordered then
    begin
      vi := frmSzcx.DstList.Items.Count;
      if vi > 0 then
      begin
        vs_value := frmSzcx.dstlist.items[0];
      end;
      for i := 2 to vi do
      begin
        vs_value := vs_value + ';' + frmSzcx.dstlist.items[i - 1];
      end;
      //����������ֵ
      DM.CDS_CLSLD_CX.IndexFieldNames := vs_value;
    end;
    frmSzcx.free;
  end;
end;

//==��ӡ��ť��ʵ��
procedure TfrmClsld_CX.btnPrintClick(Sender: TObject);
begin
//==����ͨ�ô�ӡ����
  application.createform(TfrmPrint, frmPrint);
  with frmPrint do
  begin
    //��ӿɴ�ӡ���ֶ�
    srclist.items.add('�����ֺ�');
    srclist.items.add('�ֿ�����');
    srclist.items.add('�Ƶ�����');
    srclist.items.add('���ϱ��');
    srclist.items.add('���λ��');
    srclist.items.add('��ⵥ��');
    srclist.items.add('ƾ֤����');
    srclist.items.add('ʵ������');
    srclist.items.add('��������');
    srclist.items.add('��Ӧ����');
    srclist.items.add('�ɹ���');
    srclist.items.add('�Ƿ����');
    vps_tablename := 'WZ_View_Clsld_cx'; //���ñ���
    vps_filter := DM.CDS_CLSLD_CX.Filter; //��������
    vps_index := DM.CDS_CLSLD_CX.IndexFieldNames; //����
    EdtPrintTitle.Text := '���ϵ��ݴ�ӡ'; //�������
    try
      showmodal;
    finally
      free;
    end;
  end;

end;

//==������DBGrid�ı�����ʱ������DBGridSort���ж�Ӧ���������,DBGridSort��
//U_public��Ԫʵ��

procedure TfrmClsld_CX.DBGridTitleClick(Column: TColumn);
begin
  DBGridsort(dbgrid, column);
end;

end.

