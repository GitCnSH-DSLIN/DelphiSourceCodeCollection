unit uFM_1091;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  US_FM, Grids, DBGrids, ComCtrls, ExtCtrls, StdCtrls, Db, DBTables,
  Buttons, ImgList, Menus, Mask, ToolEdit, RXDBCtrl, DBCtrls;

type
   PProd = ^TProd;


   TProd = Record
     No: string;
     PClass : string;
     ImageIdx : integer;
   end;

type
  TFM_1091 = class(TS_Form)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Table1: TTable;
    DataSource1: TDataSource;
    Table1F03: TFloatField;
    Table1Buser: TStringField;
    Table1Btime: TDateTimeField;
    Table1Euser: TStringField;
    Table1Etime: TDateTimeField;
    ImageList1: TImageList;
    Qry1: TQuery;
    Table1F01: TStringField;
    Table1F02: TStringField;
    Table1F04: TStringField;
    Table1F05: TStringField;
    PopupMenu1: TPopupMenu;
    N2: TMenuItem;
    Qry2: TQuery;
    TreeView1: TTreeView;
    Panel2: TPanel;
    Label15: TLabel;
    BtnAddA: TSpeedButton;
    BtnDel: TSpeedButton;
    btnClose: TSpeedButton;
    GpbSub: TGroupBox;
    BtnAddB: TSpeedButton;
    BtnAddC: TSpeedButton;
    DBEdit1: TDBEdit;
    Panel1: TPanel;
    TreeView2: TTreeView;
    Query1: TQuery;
    Query2: TQuery;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    Query2AutoNo: TIntegerField;
    Query2F01: TStringField;
    Query2F02: TStringField;
    Query2F03: TStringField;
    Query2F04: TStringField;
    Query2F05: TStringField;
    Query2F06: TFloatField;
    Query2F07: TFloatField;
    Query2F08: TStringField;
    Query2F09: TStringField;
    Query2F10: TStringField;
    Query2F12: TFloatField;
    Query2BUSER: TStringField;
    Query2BTIME: TDateTimeField;
    Query2EUSER: TStringField;
    Query2ETIME: TDateTimeField;
    Query1F032: TStringField;
    Query1F10: TStringField;
    TreeView3: TTreeView;
    Query3: TQuery;
    DataSource4: TDataSource;
    Query3AutoNo: TIntegerField;
    Query3F01: TStringField;
    Query3F02: TStringField;
    Query3F03: TStringField;
    Query3F04: TStringField;
    Query3F05: TStringField;
    Query3F06: TFloatField;
    Query3F07: TFloatField;
    Query3F08: TStringField;
    Query3F12: TFloatField;
    Query3BUSER: TStringField;
    Query3BTIME: TDateTimeField;
    Query3EUSER: TStringField;
    Query3ETIME: TDateTimeField;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    DBGrid3: TDBGrid;
    DBGrid2: TDBGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel6: TPanel;
    DBGrid4: TDBGrid;
    Panel7: TPanel;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Label12: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    BtnAddD: TSpeedButton;
    Label7: TLabel;
    procedure BtnAddAClick(Sender: TObject);
    procedure BtnAddCClick(Sender: TObject);
    procedure BtnAddDClick(Sender: TObject);
    procedure BtnAddBClick(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure Query2AfterScroll(DataSet: TDataSet);
    procedure Query3AfterScroll(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit4Exit(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure Edit6Exit(Sender: TObject);
    procedure Edit7Exit(Sender: TObject);
    procedure Edit8Exit(Sender: TObject);
    procedure Edit9Exit(Sender: TObject);
    procedure Edit10Exit(Sender: TObject);
    procedure Edit11Exit(Sender: TObject);
    procedure Table1AfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
  procedure ShowBom(ParNode: TTreeNode;PNo,PClass:string);
  procedure ShowBom2(ParNode: TTreeNode;PNo,PClass:string);
  procedure ShowBom1(xTreeView:TTreeView;ParNode: TTreeNode;PNo,PClass:string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FM_1091: TFM_1091;
  xData : PProd;
  xSNodeDel : TStrings;
procedure FreeNodeData(xNode: TTreeNode);
 
implementation

Uses utilities, uDM;

{$R *.DFM}


procedure NewProdData(VAR PData: PProd; sNo, sPClass: string);
begin
  New(PData);
  PData.No := sNo;
  PData.PClass := sPClass;
  
  if sPClass = '��Ʒ' then PData.ImageIdx := 1;
  if sPClass = '���Ʒ' then PData.ImageIdx := 2;
  if sPClass = '�ͻ�����' then PData.ImageIdx := 3;
  if sPClass = 'ԭ��' then PData.ImageIdx := 4;
end;

//������������Ʒ�Ľṹͼ,�����г�Ʒ��ʾ�е���
procedure TFM_1091.ShowBom1(xTreeView:TTreeView;ParNode: TTreeNode;PNo,PClass:string);
var
  xChiNode: TTreeNode;
  xQry1: TQuery;
  sNodeNo: String;
begin

  xQry1 := TQuery.Create(self);
  Try
    xQry1.DatabaseName := 'STK0311';
    //ѡ���ӽ�
    QryExec(xQry1,'Select F02, F05 From T1091 Where F01='''+PNo+''' and F04='''+PClass+'''');
      //����Ʒ�Ѵ����ӽ�
     // if xQry1.FieldByName('F05').AsString='��Ʒ'  then
     // begin
     //   QryExec(Qry2,'select T.F02,P.F01,P.F02,P.F03,P.F04,P.F05 from T1091 AS T Left join T1080 as P ON T.F02=P.AutoNo where T.F01='''+PNo+''' and T.F04='''+PClass+'''');
     //   sNodeNo := Qry2.Fields[1].asstring+' ; '+Qry2.Fields[2].asstring+' ; '+Qry2.Fields[3].asstring;
     //   if Qry2.FieldByName('F04').asstring<>'' then sNodeNo := sNodeNo+' ; '+Qry2.FieldByName('F04').asstring;
     //   if Qry2.FieldByName('F05').asstring<>'' then sNodeNo := sNodeNo+' ; '+Qry2.FieldByName('F05').asstring;
     // end;

    While not xQry1.Eof do
    begin
      if xQry1.FieldByName('F05').AsString='���Ʒ' then
      begin
        QryExec(Qry2,'select T.F02,s.F01,s.F02,s.F03,s.F04,S.F05 from T1091 AS T Left join T1070 as s ON T.F02=s.AutoNo where T.F02='''+xQry1.Fields[0].AsString+''' and T.F05='''+xQry1.Fields[1].AsString+'''');
        sNodeNo := Qry2.Fields[1].asstring+' ; '+Qry2.Fields[2].asstring+' ; '+Qry2.Fields[3].asstring;
        if Qry2.FieldByName('F04').asstring<>'' then sNodeNo := sNodeNo+' ; '+Qry2.FieldByName('F04').asstring;
        if Qry2.FieldByName('F05').asstring<>'' then sNodeNo := sNodeNo+' ; '+Qry2.FieldByName('F05').asstring;
      end;
      if xQry1.FieldByName('F05').AsString='ԭ��' then
      begin
        QryExec(Qry2,'select T.F02,M.F02,M.F03 from T1091 AS T Left join T1050 as M ON T.F02=M.F01 where T.F02='''+xQry1.Fields[0].AsString+''' and T.F05='''+xQry1.Fields[1].AsString+'''');
        sNodeNo := Qry2.Fields[1].asstring+' ; '+Qry2.Fields[2].asstring;
      end;
      if xQry1.FieldByName('F05').AsString='�ͻ�����' then
      begin
        QryExec(Qry2,'select T.F02,C.F01,C.F02,C.F03,C.F04,C.F05 from T1091 AS T Left join T1090 as C ON T.F02=C.AutoNo where T.F02='''+xQry1.Fields[0].AsString+''' and T.F05='''+xQry1.Fields[1].AsString+'''');
        sNodeNo := Qry2.Fields[1].asstring+' ; '+Qry2.Fields[2].asstring+' ; '+Qry2.Fields[3].asstring;
        if Qry2.FieldByName('F04').asstring<>'' then sNodeNo := sNodeNo+' ; '+Qry2.FieldByName('F04').asstring;
        if Qry2.FieldByName('F05').asstring<>'' then sNodeNo := sNodeNo+' ; '+Qry2.FieldByName('F05').asstring;
      end;


      //�����ӽ�
      xChiNode := xTreeView.Items.AddChild(ParNode, sNodeNo);
      NewProdData(xData, xQry1.Fields[0].AsString, xQry1.Fields[1].AsString);
      xChiNode.Data := xData;
      xData := nil;
      //ȡ�ø���Ʒ��ͼ
      xChiNode.ImageIndex := PProd(xChiNode.Data).ImageIdx;
      //ȡ�ø���Ʒ��ѡ��ʱ��ͼ
      xChiNode.SelectedIndex := PProd(xChiNode.Data).ImageIdx;
      ShowBom1(TreeView2,xChiNode,xQry1.Fields[0].AsString,xQry1.Fields[1].AsString);
      xQry1.Next;
    end;
  finally
    xQry1.Free;
  end;
end;



//������������Ʒ�Ľṹͼ
procedure TFM_1091.ShowBom(ParNode: TTreeNode;PNo,PClass:string);
var
  xChiNode: TTreeNode;
  xQry1: TQuery;
  sNodeNo: String;
begin

  xQry1 := TQuery.Create(self);
  Try
    xQry1.DatabaseName := 'STK0311';
    QryExec(xQry1,'Select F02, F05 From T1091 Where F01='''+PNo+''' and F04='''+PClass+'''');
    //����Ʒ�Ѵ����ӽ�
     // if xQry1.FieldByName('F05').AsString='��Ʒ'  then
     // begin
     //   QryExec(Qry2,'select T.F02,P.F01,P.F02,P.F03,P.F04,P.F05 from T1091 AS T Left join T1080 as P ON T.F02=P.AutoNo where T.F01='''+PNo+''' and T.F04='''+PClass+'''');
      //  sNodeNo := Qry2.Fields[1].asstring+' ; '+Qry2.Fields[2].asstring+' ; '+Qry2.Fields[3].asstring;
     //   if Qry2.FieldByName('F04').asstring<>'' then sNodeNo := sNodeNo+' ; '+Qry2.FieldByName('F04').asstring;
     //   if Qry2.FieldByName('F05').asstring<>'' then sNodeNo := sNodeNo+' ; '+Qry2.FieldByName('F05').asstring;
     // end;

    While not xQry1.Eof do
    begin
     if xQry1.FieldByName('F05').AsString='���Ʒ' then
      begin
        QryExec(Qry2,'select T.F02,s.F01,s.F02,s.F03,s.F04,S.F05 from T1091 AS T Left join T1070 as s ON T.F02=s.AutoNo where T.F02='''+xQry1.Fields[0].AsString+''' and T.F05='''+xQry1.Fields[1].AsString+'''');
        sNodeNo := Qry2.Fields[1].asstring+' ; '+Qry2.Fields[2].asstring+' ; '+Qry2.Fields[3].asstring;
        if Qry2.FieldByName('F04').asstring<>'' then sNodeNo := sNodeNo+' ; '+Qry2.FieldByName('F04').asstring;
        if Qry2.FieldByName('F05').asstring<>'' then sNodeNo := sNodeNo+' ; '+Qry2.FieldByName('F05').asstring;
      end;
      if xQry1.FieldByName('F05').AsString='ԭ��' then
      begin
        QryExec(Qry2,'select T.F02,M.F02,M.F03 from T1091 AS T Left join T1050 as M ON T.F02=M.F01 where T.F02='''+xQry1.Fields[0].AsString+''' and T.F05='''+xQry1.Fields[1].AsString+'''');
        sNodeNo := Qry2.Fields[1].asstring+' ; '+Qry2.Fields[2].asstring;
      end;
      if xQry1.FieldByName('F05').AsString='�ͻ�����' then
      begin
        QryExec(Qry2,'select T.F02,C.F01,C.F02,C.F03,C.F04,C.F05 from T1091 AS T Left join T1090 as C ON T.F02=C.AutoNo where T.F02='''+xQry1.Fields[0].AsString+''' and T.F05='''+xQry1.Fields[1].AsString+'''');
        sNodeNo := Qry2.Fields[1].asstring+' ; '+Qry2.Fields[2].asstring+' ; '+Qry2.Fields[3].asstring;
        if Qry2.FieldByName('F04').asstring<>'' then sNodeNo := sNodeNo+' ; '+Qry2.FieldByName('F04').asstring;
        if Qry2.FieldByName('F05').asstring<>'' then sNodeNo := sNodeNo+' ; '+Qry2.FieldByName('F05').asstring;
      end;

      //�����ӽ�
      xChiNode := TreeView1.Items.AddChild(ParNode, sNodeNo);
      NewProdData(xData, xQry1.Fields[0].AsString, xQry1.Fields[1].AsString);
      xChiNode.Data := xData;
      xData := nil;
      //ȡ�ø���Ʒ��ͼ
      xChiNode.ImageIndex := PProd(xChiNode.Data).ImageIdx;
      //ȡ�ø���Ʒ��ѡ��ʱ��ͼ
      xChiNode.SelectedIndex := PProd(xChiNode.Data).ImageIdx;
      ShowBom(xChiNode,xQry1.Fields[0].AsString,xQry1.Fields[1].AsString);
      xQry1.Next;
    end;
  finally
    xQry1.Free;
  end;
end;

//������������Ʒ�Ľṹͼ
procedure TFM_1091.ShowBom2(ParNode: TTreeNode;PNo,PClass:string);
var
  xChiNode: TTreeNode;
  xQry1: TQuery;
  sNodeNo: String;
begin

  xQry1 := TQuery.Create(self);
  Try
    xQry1.DatabaseName := 'STK0311';
    QryExec(xQry1,'Select F02, F05 From T1091 Where F01='''+PNo+''' and F04='''+PClass+'''');
    //����Ʒ�Ѵ����ӽ�
     // if xQry1.FieldByName('F05').AsString='��Ʒ'  then
     // begin
      //  QryExec(Qry2,'select T.F02,P.F01,P.F02,P.F03,P.F04,P.F05 from T1091 AS T Left join T1080 as P ON T.F02=P.AutoNo where T.F01='''+PNo+''' and T.F04='''+PClass+'''');
      //  sNodeNo := Qry2.Fields[1].asstring+' ; '+Qry2.Fields[2].asstring+' ; '+Qry2.Fields[3].asstring;
     //   if Qry2.FieldByName('F04').asstring<>'' then sNodeNo := sNodeNo+' ; '+Qry2.FieldByName('F04').asstring;
     //   if Qry2.FieldByName('F05').asstring<>'' then sNodeNo := sNodeNo+' ; '+Qry2.FieldByName('F05').asstring;
      //end;

    While not xQry1.Eof do
    begin
    if xQry1.FieldByName('F05').AsString='���Ʒ' then
      begin
        QryExec(Qry2,'select T.F02,s.F01,s.F02,s.F03,s.F04,S.F05 from T1091 AS T Left join T1070 as s ON T.F02=s.AutoNo where T.F02='''+xQry1.Fields[0].AsString+''' and T.F05='''+xQry1.Fields[1].AsString+'''');
        sNodeNo := Qry2.Fields[1].asstring+' ; '+Qry2.Fields[2].asstring+' ; '+Qry2.Fields[3].asstring;
        if Qry2.FieldByName('F04').asstring<>'' then sNodeNo := sNodeNo+' ; '+Qry2.FieldByName('F04').asstring;
        if Qry2.FieldByName('F05').asstring<>'' then sNodeNo := sNodeNo+' ; '+Qry2.FieldByName('F05').asstring;
      end;
      if xQry1.FieldByName('F05').AsString='ԭ��' then
      begin
        QryExec(Qry2,'select T.F02,M.F02,M.F03 from T1091 AS T Left join T1050 as M ON T.F02=M.F01 where T.F02='''+xQry1.Fields[0].AsString+''' and T.F05='''+xQry1.Fields[1].AsString+'''');
        sNodeNo := Qry2.Fields[1].asstring+' ; '+Qry2.Fields[2].asstring;
      end;
      if xQry1.FieldByName('F05').AsString='�ͻ�����' then
      begin
        QryExec(Qry2,'select T.F02,C.F01,C.F02,C.F03,C.F04,C.F05 from T1091 AS T Left join T1090 as C ON T.F02=C.AutoNo where T.F02='''+xQry1.Fields[0].AsString+''' and T.F05='''+xQry1.Fields[1].AsString+'''');
        sNodeNo := Qry2.Fields[1].asstring+' ; '+Qry2.Fields[2].asstring+' ; '+Qry2.Fields[3].asstring;
        if Qry2.FieldByName('F04').asstring<>'' then sNodeNo := sNodeNo+' ; '+Qry2.FieldByName('F04').asstring;
        if Qry2.FieldByName('F05').asstring<>'' then sNodeNo := sNodeNo+' ; '+Qry2.FieldByName('F05').asstring;
      end;

      //�����ӽ�
      xChiNode := TreeView3.Items.AddChild(ParNode, sNodeNo);
      NewProdData(xData, xQry1.Fields[0].AsString, xQry1.Fields[1].AsString);
      xChiNode.Data := xData;
      xData := nil;
      //ȡ�ø���Ʒ��ͼ
      xChiNode.ImageIndex := PProd(xChiNode.Data).ImageIdx;
      //ȡ�ø���Ʒ��ѡ��ʱ��ͼ
      xChiNode.SelectedIndex := PProd(xChiNode.Data).ImageIdx;
      ShowBom2(xChiNode,xQry1.Fields[0].AsString,xQry1.Fields[1].AsString);
      xQry1.Next;
    end;
  finally
    xQry1.Free;
  end;
end;

procedure FreeNodeData(xNode: TTreeNode);
var
  cNode : TTreeNode;
begin

  if xNode.Data <> nil then
  begin
    Dispose(xNode.Data);
    xNode.Data := nil;
  end;
  cNode := xNode.getFirstChild;
  While cNode<> nil do
  begin
    FreeNodeData(cNode);
    cNode := cNode.GetNext;
  end;
end;

procedure TFM_1091.BtnAddAClick(Sender: TObject);
var
  xNode: TTreeNode;
  sCNo: String;
begin
  inherited;
  if treeview1.Items.Count <> 0 then
  begin
    FreeNodeData(TreeView1.Items[0]);
    treeview1.Items.Clear;
  end;

  //��׼��������
  DBEdit1.Enabled := false;
  Label15.Enabled := false;

  if (Table1.State in [dsEdit, dsInsert]) then Table1.Post;
  {�� [��Ʒ�ṹ] ����, ����һ��Ʒ}

  // ����һ����¼
  Table1.Insert;
  // <������Ʒ���> = 'NIL', ��ʾ��Ϊ��Ʒ��¼
  Table1F01.AsString := 'NIL';
  // �� [��Ʒ�������ϱ�] ��ѡȡ��δ���뵽[�ṹ��]�еĳ�Ʒ
  if not Select_Data(DataSource1,'ѡ���Ʒ',
         'Select  T.AutoNo as ''��Ʒ���'',T.F10 as''�ͻ����'',C.F03 AS ''�ͻ����'',T.F01 as ''�ͺ�'',T.F02 as ''Ʒ��'','
         +' T.F03 as ''����'',T.F04 as ''���'',T.F05 as ''�Ŀ�'' from T1080 as T left join T1010 AS C on T.F10=C.F01' ,'STK0311',['F02'],[0],[0]) then
  begin

    Table1.Cancel;  // ���û�û�н���ѡȡ, ���˳��˴μ����Ʒ�Ĳ���
    Exit;
  end;
  //���ý�����,ֱ����ʾ����
  QryExec(Qry1,'select * from T1091 where F01=''nil'' and F02='''+Table1F02.AsString+''' and F04=''0'' and F05=''��Ʒ''');
  sCNo := Table1F02.AsString;
  if Qry1.Fields[0].AsString <> '' then
  begin
    Table1.Cancel;
    //��λ���ñ�����
    Table1.FindKey(['nil',sCNo,'0','��Ʒ']);
    //��ʾ�ý��
    QryExec(Qry1,'select T.F02,P.F01,P.F02,P.F03,P.F04,P.F05 from T1091 AS T left join T1080 as P on T.F02=P.AutoNo'
              +' where T.F01='''+Table1F01.AsString+''' and T.F02='''+Table1F02.AsString+''' and T.F04='''+Table1F04.AsString+''' and T.F05='''+Table1F05.AsString+'''');
    if (Qry1.FieldByName('F04').AsString='') and (Qry1.FieldByName('F05').AsString='') then
      xNode := TreeView1.Items.Add(nil,Qry1.Fields[1].AsString+' ; '+Qry1.Fields[2].AsString+' ; '+Qry1.Fields[3].AsString);
    if (Qry1.FieldByName('F04').AsString<>'') and (Qry1.FieldByName('F05').AsString='') then
      xNode := TreeView1.Items.Add(nil,Qry1.Fields[1].AsString+' ; '+Qry1.Fields[2].AsString+' ; '+Qry1.Fields[3].AsString+' ; '+Qry1.Fields[4].AsString);
    if (Qry1.FieldByName('F04').AsString='') and (Qry1.FieldByName('F05').AsString<>'') then
      xNode := TreeView1.Items.Add(nil,Qry1.Fields[1].AsString+' ; '+Qry1.Fields[2].AsString+' ; '+Qry1.Fields[3].AsString+' ; '+Qry1.Fields[5].AsString);
    if (Qry1.FieldByName('F04').AsString<>'') and (Qry1.FieldByName('F05').AsString<>'') then
      xNode := TreeView1.Items.Add(nil,Qry1.Fields[1].AsString+' ; '+Qry1.Fields[2].AsString+' ; '+Qry1.Fields[3].AsString+' ; '+Qry1.Fields[4].AsString+' ; '+Qry1.Fields[5].AsString);
    NewProdData(xData, Table1F02.AsString, Table1F05.AsString);
    xNode.Data := xData;
    xData := nil;
    xNode.ImageIndex := PProd(xNode.Data).ImageIdx;
    xNode.SelectedIndex := PProd(xNode.Data).ImageIdx;
    ShowBom(xNode,Table1F02.AsString,Table1F05.AsString);
    //ѡ�иý��
  end
  else
  begin
    Table1F04.AsString := '0'; // <������Ʒ��>='0', ��ʾ <������Ʒ���>='NIL'
    Table1F05.AsString := '��Ʒ'; // <�ӽ���Ʒ��>='A', ��ʾ <�ӽ���Ʒ> Ϊ '��Ʒ'
    Table1.Post;
    QryExec(Qry1,'select T.F02,P.F01,P.F02,P.F03,P.F04,P.F05 from T1091 AS T left join T1080 as P on T.F02=P.AutoNo'
                +' where T.F01='''+Table1F01.AsString+''' and T.F02='''+Table1F02.AsString+''' and T.F04='''+Table1F04.AsString+''' and T.F05='''+Table1F05.AsString+'''');
    if (Qry1.FieldByName('F04').AsString='') and (Qry1.FieldByName('F05').AsString='') then
      xNode := TreeView1.Items.Add(nil,Qry1.Fields[1].AsString+' ; '+Qry1.Fields[2].AsString+' ; '+Qry1.Fields[3].AsString);
    if (Qry1.FieldByName('F04').AsString<>'') and (Qry1.FieldByName('F05').AsString='') then
      xNode := TreeView1.Items.Add(nil,Qry1.Fields[1].AsString+' ; '+Qry1.Fields[2].AsString+' ; '+Qry1.Fields[3].AsString+' ;'+Qry1.Fields[4].AsString);
    if (Qry1.FieldByName('F04').AsString='') and (Qry1.FieldByName('F05').AsString<>'') then
      xNode := TreeView1.Items.Add(nil,Qry1.Fields[1].AsString+' ; '+Qry1.Fields[2].AsString+' ; '+Qry1.Fields[3].AsString+' ;'+Qry1.Fields[5].AsString);
    if (Qry1.FieldByName('F04').AsString<>'') and (Qry1.FieldByName('F05').AsString<>'') then
      xNode := TreeView1.Items.Add(nil,Qry1.Fields[1].AsString+' ; '+Qry1.Fields[2].AsString+' ; '+Qry1.Fields[3].AsString+' ;'+Qry1.Fields[4].AsString+' ;'+Qry1.Fields[5].AsString);
    NewProdData(xData, Table1F02.AsString, Table1F05.AsString);
    xNode.Data := xData;
    xData := nil;
    xNode.Selected := True;    //ѡ�иý��
    xNode.ImageIndex := PProd(xNode.Data).ImageIdx;
    xNode.SelectedIndex := PProd(xNode.Data).ImageIdx;
  end;
  TreeView1.FullExpand;
  TreeView1.Items[0].Selected := true;
  BtnAddA.Enabled := true;
  BtnAddC.Enabled := true;
  BtnAddB.Enabled := true;
  BtnAddD.Enabled := true;
end;

procedure TFM_1091.BtnAddCClick(Sender: TObject);
var
  PNo, PClass : String;
  xNode: TTreeNode;

  //ѭ���ж�
  function IsCyc(xNode: TTreeNode; AddProdNo,AddProdClass: String): Boolean;
  var
    xPNode: TTreeNode;
  begin

    Result := False;
    xPNode := xNode.Parent; //ȡ�ø��׽��
    While Assigned(xPNode) do
    begin
      if (PProd(xPNode.Data).No = AddProdNo) and (PProd(xPNode.Data).PClass=AddProdClass) then
      begin
        Result := True;
       // xPNode.Selected := True;
        exit;
      end;
      xPNode := xPNode.Parent;
    end;
  end;


  function IsCyc1(xPar,xChi: String): Boolean;     //��T_BOM���ϱ����ж��Ƿ���ѭ������
  var
    xQry1: TQuery;
  begin
    Result := False;
    xQry1 := TQuery.Create(self);
    Try                                                                    
      xQry1.DatabaseName := 'STK0311';
      QryExec(xQry1,'Select F01,F05 From T1091 Where F02='''+xPar+''' and F04=''���Ʒ'' and F05=''���Ʒ''');
      if (xQry1.RecordCount < 1) then begin
        result := false;
        Exit;
      end
      else
      begin
        While not xQry1.Eof do
        begin
          if (xQry1.Fields[0].AsString = xChi)  then
             begin Result := True; exit; end;
          if isCyc1(xQry1.Fields[0].AsString,xChi) then
            begin Result := True;
                  Exit;
            end;
          xQry1.Next;
        end;
      end;
    finally
      xQry1.Free;
    end;
  end;

begin
  inherited;

  if (Table1.State in [dsEdit, dsInsert]) then Table1.Post;
  //��׼��������
  DBEdit1.Enabled := true;
  Label15.Enabled := true;

  {�ڵ�ǰѡȡ�ĳ�Ʒ����Ʒ֮��, �����ӽ���Ʒ - '���Ʒ'}
  PNo := Table1F02.AsString;        // ��¼�µ�ǰ<�ӽ���Ʒ���>, ��ΪҪ�����ӽ׵�<������Ʒ���>
  PClass := Table1F05.AsString;  // ��¼�µ�ǰ<�ӽ���Ʒ��>, ��ΪҪ�����ӽ׵�<������Ʒ��>

  Table1.Insert;                      // ����һ����¼
  Table1F01.AsString := PNo;        // ��ԭ<�ӽ���Ʒ���>, ��ΪҪ�����ӽ׵�<������Ʒ���>
  Table1F04.AsString := PClass;  // ��ԭ<�ӽ���Ʒ��>, ��ΪҪ�����ӽ׵�<������Ʒ��>

  if PClass='���Ʒ'  then
  begin
    // ѡȡ�ø�����δ�����İ��Ʒ,(�ҳ�ȥ���ױ���İ��Ʒ)
    if not Select_Data(DataSource1,'ѡ����Ʒ',
          'Select AutoNo as ''���Ʒ���'',F01 as ''�ͺ�'',F02 as ''Ʒ��'',F03 as ''����'',F04 as ''���'',F05 as ''�Ŀ�'' From T1070 Where AutoNo <> '''+ PNo +''''
         +' And AutoNo not in (Select F02 From T1091 Where F01 ='''+ PNo +''' and F05=''���Ʒ'' ) order by F01',
          'STK0311',['F02'],[0],[0]) then
    begin
      Table1.Cancel;
      Exit;
    end;
  end
  else
  begin
    // ѡȡ�ø�����δ�����İ��Ʒ,(�ҳ�ȥ���ױ���İ��Ʒ)
    if not Select_Data(DataSource1,'ѡ����Ʒ',
          'Select AutoNo as ''���Ʒ���'',F01 as ''�ͺ�'',F02 as ''Ʒ��'',F03 as ''����'',F04 as ''���'',F05 as ''�Ŀ�'' From T1070 '
         +' Where AutoNo not in (Select F02 From T1091 Where F01 ='''+ PNo +''' and F05=''���Ʒ'' ) order by F01',
          'STK0311',['F02'],[0],[0]) then
    begin
      Table1.Cancel;
      Exit;
    end;

  end;

  Table1F05.AsString := '���Ʒ';  
  if IsCyc(TreeView1.Selected, Table1F02.AsString,Table1F05.AsString) then
  begin
    Table1.Cancel;
    Application.MessageBox('����ѭ������BOM','����', MB_ICONERROR+MB_OK);
    exit;
  end;

  if IsCyc1(PNo, Table1F02.AsString) then
  begin
    Application.MessageBox('����ѭ������BOM','����', MB_ICONERROR+MB_OK);
    Table1.Cancel;
    exit;
  end;


  Table1.Post;

  //���ӽ��
  QryExec(Qry1,'select T.F02,S.F01,S.F02,S.F03,S.F04,S.F05 from T1091 AS T left join T1070 as S on T.F02=S.AutoNo'
              +' where T.F01='''+Table1F01.AsString+''' and T.F02='''+Table1F02.AsString+''' and T.F04='''+Table1F04.AsString+''' and T.F05='''+Table1F05.AsString+'''');
  if (Qry1.FieldByName('F04').AsString='') and (Qry1.FieldByName('F05').AsString='') then
      xNode := TreeView1.Items.AddChild(TreeView1.Selected,Qry1.Fields[1].AsString+' ; '+Qry1.Fields[2].AsString+' ; '+Qry1.Fields[3].AsString);
  if (Qry1.FieldByName('F04').AsString<>'') and (Qry1.FieldByName('F05').AsString='') then
      xNode := TreeView1.Items.AddChild(TreeView1.Selected,Qry1.Fields[1].AsString+' ; '+Qry1.Fields[2].AsString+' ; '+Qry1.Fields[3].AsString+' ; '+Qry1.Fields[4].AsString);
  if (Qry1.FieldByName('F04').AsString='') and (Qry1.FieldByName('F05').AsString<>'') then
      xNode := TreeView1.Items.AddChild(TreeView1.Selected,Qry1.Fields[1].AsString+' ; '+Qry1.Fields[2].AsString+' ; '+Qry1.Fields[3].AsString+' ; '+Qry1.Fields[5].AsString);
  if (Qry1.FieldByName('F04').AsString<>'') and (Qry1.FieldByName('F05').AsString<>'') then
      xNode := TreeView1.Items.AddChild(TreeView1.Selected,Qry1.Fields[1].AsString+' ; '+Qry1.Fields[2].AsString+' ; '+Qry1.Fields[3].AsString+' ; '+Qry1.Fields[4].AsString+' ; '+Qry1.Fields[5].AsString);
  NewProdData(xData, Table1F02.AsString, Table1F05.AsString);
  xNode.Data := xData;
  xData := nil;
  xNode.ImageIndex := PProd(xNode.Data).ImageIdx;
  xNode.SelectedIndex := PProd(xNode.Data).ImageIdx;
  xNode.Selected := True;    //ѡ�иý��
  QryExec(Qry1,'select F02,F05 from T1091 where F01='''+Table1F01.AsString+''' and F02='''+Table1F02.AsString+''' and F04='''+Table1F04.AsString+''' and F05='''+Table1F05.AsString+'''' );
  ShowBom(xNode,Qry1.Fields[0].AsString,Qry1.Fields[1].AsString);
  xNode.Expand(False);//չ����ѡ�еĽ��

end;

procedure TFM_1091.BtnAddDClick(Sender: TObject);
var
  PNo, PClass : String;
  xNode : TTreeNode;
begin
  if (Table1.State in [dsEdit, dsInsert]) then Table1.Post;
  //��׼��������
  DBEdit1.Enabled := true;
  Label15.Enabled := true;
  {�ڵ�ǰѡȡ�ĳ�Ʒ����Ʒ֮��, �����ӽ���Ʒ - 'ԭ��'}

  PNo := Table1F02.AsString;     //���µ�ǰ��Ʒ���,��Ϊ�������丸�ױ��
  PClass := Table1F05.AsString;   //���µ�ǰ��Ʒ���,��Ϊ�������丸�����

  Table1.Insert;
  Table1F01.AsString := PNo;
  Table1F04.AsString := PClass;

  // ѡȡ�ø�����δ������ԭ��
  if not Select_Data(DataSource1,'ѡ��ԭ��',
         'Select F01 as ''ԭ�ϱ��'',F02 as ''Ʒ��'',F03 as ''���'' From T1050'
        +' where F01 not in (Select F02 From T1091 Where F01 ='''+PNo+''' and F05=''ԭ��'') order by F01',
        'STK0311',['F02'],[0],[]) then
  begin
    Table1.Cancel;
    Exit;
  end;
  Table1F05.AsString := 'ԭ��';  // <�ӽ���Ʒ��>='D', ��ʾ <�ӽ���Ʒ> Ϊ ԭ��

  Table1.Post;

  QryExec(Qry1,'select T.F02,M.F01,M.F02,M.F03 from T1091 AS T left join T1050 as M on T.F02=M.F01'
              +' where T.F01='''+Table1F01.AsString+''' and T.F02='''+Table1F02.AsString+''' and T.F04='''+Table1F04.AsString+''' and T.F05='''+Table1F05.AsString+'''');
  xNode := TreeView1.Items.AddChild(TreeView1.Selected,Qry1.Fields[2].AsString+' ; '+Qry1.Fields[3].AsString);
  NewProdData(xData, Table1F02.AsString, Table1F05.AsString);
  xNode.Data := xData;
  xData := nil;
  xNode.ImageIndex := PProd(xNode.Data).ImageIdx;
  xNode.SelectedIndex := PProd(xNode.Data).ImageIdx;
  xNode.Selected := True;    //ѡ�иý��

  QryExec(Qry1,'select F02,F05 from T1091 where F01='''+Table1F01.AsString+''' and F02='''+Table1F02.AsString+''' and F04='''+Table1F04.AsString+''' and F05='''+Table1F05.AsString+'''' );
  ShowBom(xNode,Table1F02.AsString,Table1F05.AsString);
  xNode.Expand(False);
  BtnAddB.Enabled := False;
  BtnAddC.Enabled := False;
  BtnAddD.Enabled := False; 
end;

procedure TFM_1091.BtnAddBClick(Sender: TObject);
var
  PNo, PClass : String;
  xNode : TTreeNode;
begin
  if (Table1.State in [dsEdit, dsInsert]) then Table1.Post;
  //��׼��������
  DBEdit1.Enabled := true;
  Label15.Enabled := true;
  {�ڵ�ǰѡȡ�ĳ�Ʒ����Ʒ֮��, �����ӽ���Ʒ - 'ԭ��'}
  

  PNo := Table1F02.AsString;     //���µ�ǰ��Ʒ���,��Ϊ�������丸�ױ��
  PClass := Table1F05.AsString;   //���µ�ǰ��Ʒ���,��Ϊ�������丸�����

  Table1.Insert;
  Table1F01.AsString := PNo;
  Table1F04.AsString := PClass;

  // ѡȡ�ø�����δ������ԭ��
  if not Select_Data(DataSource1,'ѡ��ͻ�����',
         'Select A.AutoNo,A.F03 as �ͻ����,B.F03 AS ���Ͽͻ�,A.F01 as �ͺ�,A.F02 as Ʒ��,'
        +' A.TF03 as ����,A.F04 as ���,A.F05 as �Ŀ� from '
        +' (Select AutoNo ,T.F10,C.F03 ,T.F01,T.F02 ,T.F03 as TF03,T.F04 ,T.F05 From T1090 as T'
        +' Left join T1010 AS C on T.F10=C.F01) as A Full join'
        +' (Select AutoNo ,T.F11,C.F03 , T.F01 ,T.F02 ,T.F04 ,T.F05'
        +' From T1090 as T Left join T1010 AS C on T.F11=C.F01) as B '
        +' on A.AutoNo=B.AutoNo'
        +' where A.AutoNo not in (Select F02 From T1091 Where F01 ='''+PNo+''' and F05=''�ͻ�����'') order by A.F03,B.F03,A.F01 ',
        'STK0311',['F02'],[0],[0]) then
  begin
    Table1.Cancel;
    Exit;
  end;
  Table1F05.AsString := '�ͻ�����';  // <�ӽ���Ʒ��>='D', ��ʾ <�ӽ���Ʒ> Ϊ ԭ��

  Table1.Post;
  QryExec(Qry1,'select T.F02,C.F01,C.F02,C.F03,C.F04,C.F05 from T1091 AS T left join T1090 as C on T.F02=C.AutoNo'
              +' where T.F01='''+Table1F01.AsString+''' and T.F02='''+Table1F02.AsString+''' and T.F04='''+Table1F04.AsString+''' and T.F05='''+Table1F05.AsString+'''');
  if (Qry1.FieldByName('F04').AsString='') and (Qry1.FieldByName('F05').AsString='') then
      xNode := TreeView1.Items.AddChild(TreeView1.Selected,Qry1.Fields[1].AsString+' ; '+Qry1.Fields[2].AsString+' ; '+Qry1.Fields[3].AsString);
  if (Qry1.FieldByName('F04').AsString<>'') and (Qry1.FieldByName('F05').AsString='') then
      xNode := TreeView1.Items.AddChild(TreeView1.Selected,Qry1.Fields[1].AsString+' ; '+Qry1.Fields[2].AsString+' ; '+Qry1.Fields[3].AsString+' ; '+Qry1.Fields[4].AsString);
  if (Qry1.FieldByName('F04').AsString='') and (Qry1.FieldByName('F05').AsString<>'') then
      xNode := TreeView1.Items.AddChild(TreeView1.Selected,Qry1.Fields[1].AsString+' ; '+Qry1.Fields[2].AsString+' ; '+Qry1.Fields[3].AsString+' ; '+Qry1.Fields[5].AsString);
  if (Qry1.FieldByName('F04').AsString<>'') and (Qry1.FieldByName('F05').AsString<>'') then
      xNode := TreeView1.Items.AddChild(TreeView1.Selected,Qry1.Fields[1].AsString+' ; '+Qry1.Fields[2].AsString+' ; '+Qry1.Fields[3].AsString+' ; '+Qry1.Fields[4].AsString+' ; '+Qry1.Fields[5].AsString);
  NewProdData(xData, Table1F02.AsString, Table1F05.AsString);
  xNode.Data := xData;
  xData := nil;
  xNode.ImageIndex := PProd(xNode.Data).ImageIdx;
  xNode.SelectedIndex := PProd(xNode.Data).ImageIdx;
  xNode.Selected := True;    //ѡ�иý��

  QryExec(Qry1,'select F02,F05 from T1091 where F01='''+Table1F01.AsString+''' and F02='''+Table1F02.AsString+''' and F04='''+Table1F04.AsString+''' and F05='''+Table1F05.AsString+'''' );
  ShowBom(xNode,Table1F02.AsString,Table1F05.AsString);
  xNode.Expand(False);
  BtnAddB.Enabled := False;
  BtnAddC.Enabled := False;
  BtnAddD.Enabled := False;

end;
//���ı�ʱ,��Ӧ��λ���ϱ�
procedure TFM_1091.TreeView1Change(Sender: TObject; Node: TTreeNode);
var
  sCNo,sClass,sPNo,sPClass : string;
begin
  if (Table1.State <> dsBrowse) then
  begin
    Table1.Post;
    Table1.Refresh;
 //   exit;
  end;  

  sCNo := PProd(TreeView1.Selected.Data).No;
  sClass := PProd(TreeView1.Selected.Data).PClass;
  if Assigned(Node.Parent) then
  begin
    sPNo := PProd(treeview1.Selected.Parent.data).No;
    sPClass := PProd(treeview1.Selected.Parent.data).PClass;
  end
  else
  begin
    sPNo := 'nil';
    sPClass := '0';
  end;
  if (Table1F01.AsString <> sPNo) or (Table1F02.AsString <> sCNo) or (Table1F04.AsString <> sPClass) or (Table1F05.AsString <> sClass) then
    Table1.FindKey([sPNo,sCNo,sPClass,sClass]);
end;

procedure TFM_1091.N1Click(Sender: TObject);
var
  xRootNode :TTreeNode;
begin
  new(xData);
  //������н��
  TreeView1.Items.Clear;
  QryExec(Qry1,'Select F02,F05 From T_Bom Where F01=''NIL'''); //ѡ�����и���
  While Not Qry1.Eof do
  begin
    //�������и���
    xRootNode := TreeView1.Items.Add(Nil, Qry1.Fields[0].AsString);
    xData.No := Qry1.Fields[0].AsString;
    xData.PClass := Qry1.Fields[1].AsString;
    xRootNode.Data := xData;


    //��ʾ�����ӽ�
    QryExec(Qry1,'select F02,F05 where F01='''+Table1F01.AsString+''' and F02='''+Table1F02.AsString+''' and F04='''+Table1F04.AsString+''' and F05='''+Table1F05.AsString+'''' );
    ShowBom(xRootNode,Qry1.Fields[0].AsString,Qry1.Fields[1].AsString);
    Qry1.Next;
  end;
  TreeView1.SetFocus;

end;

procedure TFM_1091.N2Click(Sender: TObject);
var
  xRootNode :TTreeNode;
  sNo: String;
begin
  inherited;
  if TreeView1.Items.Count = 0 then Exit;
  new(xData);
  sNo := PProd(TreeView1.TopItem.Data).No ;
  //������н��
  TreeView1.Items.Clear;
  QryExec(Qry1,'Select F02,F05 From T1091 Where F01=''NIL'' and F02='''+sNo+''''); //ѡ�����и���
  QryExec(Qry2,'select F01,F02,F03,F04,F05 from T1080 where AutoNo='+sNo);
  xRootNode := TreeView1.Items.Add(Nil, Qry2.Fields[0].AsString+';'+Qry2.Fields[1].AsString+';'+Qry2.Fields[2].AsString+';'+Qry2.Fields[3].AsString+';'+Qry2.Fields[4].AsString);

  xData.No := Qry1.Fields[0].AsString;
  xData.PClass := Qry1.Fields[1].AsString;
  xRootNode.Data := xData;

  ShowBom(xRootNode,Qry1.Fields[0].AsString,Qry1.Fields[1].AsString);

  TreeView1.SetFocus;
  TreeView1.FullExpand;

end;

procedure TFM_1091.BtnDelClick(Sender: TObject);
  //�Ƿ�����ͬ�ṹ�Ľ��
  function HaveOtherChi(PNo,PClass: string): Boolean;
  var
    xQry1: TQuery;
    isP : Boolean;
  begin
    isP := False;
    Result := False;

    xQry1 := TQuery.Create(self);
    Try
      xQry1.DatabaseName := 'STK0311';
      QryExec(xQry1,'Select F02 From T1091 Where F01='''+PNo+''' and F04='''+PClass+'''');
      if (xQry1.RecordCount>0) then isP := True;

      QryExec(xQry1,'Select F02 From T1091 Where F02='''+PNo+''' and F05='''+PClass+'''');
      if (xQry1.RecordCount>1) and isP then
        result := True
      else
      begin
        QryExec(xQry1,'Select F02,F05 From T1091 Where F01='''+PNo+''' and F04='''+PClass+'''');
        While not xQry1.Eof do
        begin
          if HaveOtherChi(xQry1.Fields[0].AsString,xQry1.Fields[1].AsString) then
             begin Result := True; exit; end;
          xQry1.Next;
        end;
      end;
    finally
      xQry1.Free;
    end;
  end;


    //ɾ����㺯��(�����в���ɾ���Ľ��)
  procedure DelChi1(PNo, CNo,PClass,CClass: string);
  var
    xQry1: TQuery;
    sCNo,sCClass: string;
  begin
    xQry1 := TQuery.Create(self);
    xQry1.DatabaseName := 'STK0311';
      try
        QryExec(xQry1,'select F02 from T1091 where F02='''+ CNo +''' and F05='''+CClass+'''');
        if (xSNodeDel.Values[CNo] <> inttostr(xQry1.RecordCount))  then
           begin
             QryExec(xQry1,'Delete From T1091 Where F01='''+PNo+''' And F02='''+CNo+''' and F04='''+PClass+''' and F05='''+CClass+'''',False);
             exit;
           end;

        QryExec(xQry1, 'Select F02,F05 From T1091 Where F01='''+CNo+''' and F04='''+CClass+''''); //ѡ���ӽ�
        if (xQry1.RecordCount > 0) then
        begin
          While not xQry1.Eof do
          begin
            sCNo := xQry1.Fields[0].AsString;
            sCClass := Qry1.Fields[1].AsString;
            QryExec(Qry1,'select F02 from T1091 where F02='''+ sCNo +''' F05='''+sCClass+'''');
            if (xSNodeDel.Values[sCNo] = inttostr(Qry1.RecordCount))  then
               DelChi1(CNo, sCNo,CClass,sCClass)
            else
               QryExec(Qry1,'Delete From T1091 Where F01='''+CNo+''' And F02='''+sCNo+''' and F04='''+CClass+''' and F05='''+sCClass+'''',False);
            xQry1.Next;
          end;
        end
        else
          QryExec(xQry1,'Delete From T1091 Where F01='''+PNo+''' And F02='''+CNo+''' and F04='''+CClass+''' and F05='''+sCClass+'''',False);
        QryExec(xQry1,'Delete From T1091 Where F01='''+PNo+''' And F02='''+CNo+''' and F04='''+CClass+''' and F05='''+sCClass+'''',False);
      finally
      xQry1.Free;
      end
  end;


  //ɾ���������н��
  procedure DelChi(PNo, CNo,PClass,CClass: string);
  var
    xQry1: TQuery;
    sCClass,sCNo: string;

  begin
    xQry1 := TQuery.Create(self);
    xQry1.DatabaseName := 'STK0311';
    try
      QryExec(xQry1, 'Select F02,F05 From T1091 Where F01='''+CNo+''' and F04='''+CClass+''''); //ѡ���ӽ�
      if (xQry1.RecordCount > 0) then   //���ӽ��
      begin
        While not xQry1.Eof do
        begin
          sCNo := xQry1.Fields[0].AsString;
          sCClass := xQry1.Fields[1].AsString;
          DelChi(CNo, sCNo,CClass,sCClass);
          xQry1.Next;
        end;
      end
      else  //���ӽ��
        //ɾ����ǰ���
        QryExec(xQry1,'Delete From T1091 Where F01='''+PNo+''' And F02='''+CNo+''' and F04='''+PClass+''' and F05='''+CClass+'''',False);
    //ɾ����ѡ�н��
     QryExec(xQry1,'Delete From T1091 Where F01='''+PNo+''' And F02='''+CNo+''' and F04='''+PClass+''' and F05='''+CClass+'''',False);
    finally
      xQry1.Free;
    end
  end;


  procedure GetChiCnt(PNode: TTreeNode);
  var
    yQry1: TQuery;
    CNode: TTreeNode;
    s: string;
  begin
    yQry1 := TQuery.Create(self);
    yQry1.DatabaseName := 'STK0311';
    Try
      //��ѡ��Ľ�㲻�Ǹ����
       QryExec(yQry1,'Select * from T1091 where F01=''' + PProd(PNode.Data).No +''' and F05='''+PProd(PNode.Data).PClass+'''');
      if (yQry1.Fields[0].asstring <> '') and PNode.HasChildren then
      begin
         xSNodeDel.Values[PProd(PNode.Data).No] := '1';

      end;
    finally
      yQry1.Free;
    end;

    CNode := PNode.getFirstChild; //ȡ�õ�һ���ӽ��
    While Assigned(CNode) do      //�ý�����
    begin
      if CNode.HasChildren then    //���ӽ��
      begin
        s := xSNodeDel.Values[PProd(CNode.Data).No]; //ȡ��listBox���ұߵ�ֵ
        if (s = '') then
         xSNodeDel.Values[PProd(CNode.Data).No] := '1'
        else
          xSNodeDel.Values[PProd(CNode.Data).No] := IntToStr(StrToInt(s)+1) ;
        GetChiCnt(CNode);
      end;
      CNode := PNode.GetNextChild(CNode);   //ȡ����һ���ӽ��
    end;
  end;


begin
  inherited;
   if (Table1.State in [dsEdit, dsInsert]) then Table1.Post;

  if not Assigned(TreeView1.Selected) then
  begin
    R_OkMessage(['��ѡȡҪɾ������Ʒ!']);
    exit;
  end;

  if HaveOtherChi(Table1F01.AsString,Table1F05.AsString) then
  begin
    getChiCnt(treeview1.selected);
    DelChi1(Table1F01.AsString,Table1F02.AsString,Table1F04.AsString,Table1F05.AsString);  //ɾ�������в���ֱ��ɾ���ӽ��Ľ��
    Treeview1.Selected.Delete;
  end
  else
  begin
    DelChi(Table1F01.AsString,Table1F02.AsString,Table1F04.AsString,Table1F05.AsString);   //ֱ��ɾ�����н��
    Treeview1.Selected.Delete;
  end;
  if TreeView1.Selected=nil then
  begin
    BtnAddA.Enabled := true;
    BtnAddC.Enabled := false;
    BtnAddB.Enabled := false;
    BtnAddD.Enabled := false;
  end;
end;

procedure TFM_1091.Query2AfterScroll(DataSet: TDataSet);
var
  xRootNode: TTreeNode;
  xNodeNo: String;
begin
  inherited;
  if treeview2.Items.Count <> 0 then
  begin
    FreeNodeData(TreeView2.Items[0]);
  end;
  Treeview2.Items.clear;
  xNodeNo := Query2.FieldByName('F01').asstring+' ; '+Query2.FieldByName('F02').asstring+' ; '+Query2.FieldByName('F03').asstring;
  if Query2.FieldByName('F04').asstring<>'' then xNodeNo := xNodeNo + ' ; '+Query2.FieldByName('F04').asstring;
  if Query2.FieldByName('F05').asstring<>'' then xNodeNo := xNodeNo + ' ; '+Query2.FieldByName('F05').asstring;

  QryExec(Qry1,'select F02,F05 from T1091 where F02='''+Query2.FieldbyName('AutoNo').asstring+''' and F05=''��Ʒ''');
  if Qry1.FieldByName('F02').AsString<>'' then
  begin
    xRootNode := TreeView2.Items.Add(nil,xNodeNo);
    NewProdData(xData, Qry1.Fields[0].AsString, Qry1.Fields[1].AsString);
    xRootNode.Data := xData;
    xData := nil;
    xRootNode.ImageIndex := PProd(xRootNode.Data).ImageIdx;
    xRootNode.SelectedIndex := PProd(xRootNode.Data).ImageIdx;
    showBom1(TreeView2,xRootNode,Qry1.Fields[0].AsString,Qry1.Fields[1].AsString);
    TreeView2.FullExpand;
  end;
end;

procedure TFM_1091.Query3AfterScroll(DataSet: TDataSet);
var
  xNodeNo:string;
  xRootNode:TTreeNode;
begin
  inherited;
    if treeview3.Items.Count <> 0 then
  begin
    FreeNodeData(TreeView3.Items[0]);
  end;
  Treeview3.Items.clear;
  xNodeNo := Query3.FieldByName('F01').asstring+' ; '+Query3.FieldByName('F02').asstring+' ; '+Query3.FieldByName('F03').asstring;
  if Query3.FieldByName('F04').asstring<>'' then xNodeNo := xNodeNo + ' ; '+Query3.FieldByName('F04').asstring;
  if Query3.FieldByName('F05').asstring<>'' then xNodeNo := xNodeNo + ' ; '+Query3.FieldByName('F05').asstring;

  QryExec(Qry1,'select F02,F05 from T1091 where F02='''+Query3.FieldbyName('AutoNo').asstring+''' and F05=''���Ʒ''');
  if Qry1.FieldByName('F02').AsString<>'' then
  begin
    xRootNode := TreeView3.Items.Add(nil,xNodeNo);
    NewProdData(xData, Qry1.Fields[0].AsString, Qry1.Fields[1].AsString);
    xRootNode.Data := xData;
    xData := nil;
    xRootNode.ImageIndex := PProd(xRootNode.Data).ImageIdx;
    xRootNode.SelectedIndex := PProd(xRootNode.Data).ImageIdx;
    showBom2(xRootNode,Qry1.Fields[0].AsString,Qry1.Fields[1].AsString);
    TreeView3.FullExpand;
  end;
end;

procedure TFM_1091.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  //�ͷ����н��

end;

procedure TFM_1091.btnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TFM_1091.FormShow(Sender: TObject);
begin
  inherited;
  if not Assigned(TreeView1.Selected) then
  begin
    BtnAddB.Enabled := False;
    BtnAddC.Enabled := False;
    BtnAddD.Enabled := False;
  end;
end;

procedure TFM_1091.Edit1Exit(Sender: TObject);
begin
  inherited;
  Query1.Locate('F03' , Edit1.text, [loCaseInsensitive]);
end;

procedure TFM_1091.Edit2Exit(Sender: TObject);
begin
  inherited;
  Query2.Locate('F01',Edit2.text,[loCaseInsensitive]) ;
end;

procedure TFM_1091.Edit3Exit(Sender: TObject);
begin
  inherited;
    Query2.Locate('F02',Edit3.text,[loCaseInsensitive]) ;
end;

procedure TFM_1091.Edit4Exit(Sender: TObject);
begin
  inherited;
    Query2.Locate('F03',Edit4.text,[loCaseInsensitive]) ;
end;

procedure TFM_1091.Edit5Exit(Sender: TObject);
begin
  inherited;
  Query2.Locate('F04',Edit5.text,[loCaseInsensitive]) ;
end;

procedure TFM_1091.Edit6Exit(Sender: TObject);
begin
  inherited;
    Query2.Locate('F05',Edit6.text,[loCaseInsensitive]) ;
end;

procedure TFM_1091.Edit7Exit(Sender: TObject);
begin
  inherited;
  Query3.Locate('F01',Edit7.text,[loCaseInsensitive]) ;
end;

procedure TFM_1091.Edit8Exit(Sender: TObject);
begin
  inherited;
  Query3.Locate('F02',Edit8.text,[loCaseInsensitive]) ;
end;

procedure TFM_1091.Edit9Exit(Sender: TObject);
begin
  inherited;
  Query3.Locate('F03',Edit9.text,[loCaseInsensitive]) ;
end;

procedure TFM_1091.Edit10Exit(Sender: TObject);
begin
  inherited;
  Query3.Locate('F04',Edit10.text,[loCaseInsensitive]) ;
end;

procedure TFM_1091.Edit11Exit(Sender: TObject);
begin
  inherited;
  Query3.Locate('F05',Edit11.text,[loCaseInsensitive]) ;
end;

procedure TFM_1091.Table1AfterScroll(DataSet: TDataSet);
begin
  inherited;
  DBEdit1.Enabled := not (Table1F04.AsString='0');
  Label15.Enabled := not (Table1F04.AsString='0');
  if (Table1F05.AsString='���Ʒ') or (Table1F05.AsString='��Ʒ') then
  begin
    BtnAddA.Enabled := true;
    BtnAddC.Enabled := true;
    BtnAddB.Enabled := true;
    BtnAddD.Enabled := true;
  end;
  if (TreeView1.Selected=nil) or (Table1F05.AsString='�ͻ�����') or (Table1F05.AsString='ԭ��') then
  begin
    BtnAddA.Enabled := true;
    BtnAddC.Enabled := false;
    BtnAddB.Enabled := false;
    BtnAddD.Enabled := false;
  end;



end;

procedure TFM_1091.FormCreate(Sender: TObject);
begin
  inherited;
  xSNodeDel := TStringList.Create;
end;

procedure TFM_1091.FormDestroy(Sender: TObject);
begin
  inherited;
  xSNodeDel.Free;
end;

end.

