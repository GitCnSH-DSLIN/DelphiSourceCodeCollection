unit U_Bmda;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, Buttons, Db, DBClient, ImgList, Menus, StdCtrls,
  Mask, DBCtrls, Grids, DBGrids, ADODB;

type
  TfrmBmda = class(TForm)
    pmOperate: TPopupMenu;
    N_insert: TMenuItem;
    N_delete: TMenuItem;
    N_edit: TMenuItem;
    N_cancel: TMenuItem;
    N_save: TMenuItem;
    N7: TMenuItem;
    N_refresh: TMenuItem;
    ImageList1: TImageList;
    DataSource: TDataSource;
    ImageList2: TImageList;
    aqBMDA: TADOQuery;
    Panel1: TPanel;
    Splitter1: TSplitter;
    TreeView: TTreeView;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel3: TPanel;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBEdt_Bmbm: TDBEdit;
    DBEdt_Bmmc: TDBEdit;
    DBEdt_Fzrxm: TDBEdit;
    DBEdt_Bmsx: TDBEdit;
    DBEdt_Lxdh: TDBEdit;
    DBEdt_DZ: TDBEdit;
    DBEdt_BZ: TDBEdit;
    TabSheet2: TTabSheet;
    DBGrid: TDBGrid;
    Label9: TLabel;
    btnCancel: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N_insertClick(Sender: TObject);
    procedure N_saveClick(Sender: TObject);
    procedure N_refreshClick(Sender: TObject);
    procedure N_editClick(Sender: TObject);
    procedure N_cancelClick(Sender: TObject);
    procedure N_deleteClick(Sender: TObject);
    procedure TreeViewClick(Sender: TObject);
    procedure N_OrderClick(Sender: TObject);
    procedure DBGridTitleClick(Column: TColumn);
    procedure btnCancelClick(Sender: TObject);

  private
    Node_Parent: TTreeNode; //�洢���ڵ�
    Node_Child: TTreeNode; //�洢��ǰ�ڵ�
    b_pd: bool; //�����жϵ��������ӻ��Ǳ༭
    //����ӡ��༭�����״̬���ð�ť����Ч��
    procedure button_valid;
    //RefreshTree�������ڽ����ŵ����Ĳ��ű���ֲ��������Ŀ¼����ʽ��ʾ����
    procedure refreshTree;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  frmBmda: TfrmBmda;

implementation

uses  uPublic,uDB;

{$R *.DFM}

//����ӡ��༭�����״̬�����������Ч��
procedure TfrmBmda.button_valid;
begin
  DBEdt_Bmbm.enabled := not DBEdt_Bmbm.enabled;
  DBEdt_Bmmc.enabled := not DBEdt_Bmmc.enabled;
  DBEdt_Fzrxm.enabled := not DBEdt_Fzrxm.enabled;
  DBEdt_Bmsx.enabled := not DBEdt_Bmsx.enabled;
  DBEdt_Lxdh.enabled := not DBEdt_Lxdh.enabled;
  DBEdt_DZ.enabled := not DBEdt_DZ.enabled;
  DBEdt_BZ.enabled := not DBEdt_BZ.enabled;
  n_insert.enabled := not n_insert.enabled;
  n_delete.enabled := not n_delete.enabled;
  n_edit.enabled := not n_edit.enabled;
  n_cancel.enabled := not n_cancel.enabled;
  n_save.enabled := not n_save.enabled;
  n_refresh.enabled := not n_refresh.enabled;
  Treeview.enabled := not Treeview.Enabled;
end;

//RefreshTree�������ڽ����ŵ����Ĳ��ű���ֲ��������Ŀ¼����ʽ��ʾ����
procedure TfrmBmda.refreshTree;
var
  mynode_1, mynode_2, mynode_3: Ttreenode;
  s_bm_1: string;
  s_mc_1: string;
begin
  treeview.Items.clear;
  //��Ӹ�Ŀ¼��
  mynode_1 := Treeview.Items.Add(Treeview.topitem, '���ŵ���');
  mynode_1.imageindex := 0;
  mynode_1.stateindex := -1;
  mynode_1.selectedindex := 1;
  //ָ�����ű��¼˳��

  aqBMDA.SQL.Text :='select * from BMDA order by DepCode ';
  aqBMDA.Open;
  //aqBMDA.indexname := 'DepCode';
  //aqBMDA.First;
  while not aqBMDA.Eof do
  begin
    s_bm_1 := aqBMDA.fieldbyname('DepCode').asstring;
    s_mc_1 := aqBMDA.fieldbyname('DepName').asstring;
    //��ӵ�һ��������
    if length(trim(s_bm_1)) = 2 then
    begin
      mynode_2 := Treeview.items.addchild(mynode_1, '(' + s_bm_1 + ') ' + s_mc_1);
      mynode_2.imageindex := 0;
      mynode_2.stateindex := -1;
      mynode_2.selectedindex := 1;
    end;
    //��ӵڶ���������
    if length(trim(s_bm_1)) = 5 then
    begin
      mynode_3 := Treeview.items.addchild(mynode_2, '(' + s_bm_1 + ') ' + s_mc_1);
      mynode_3.imageindex := 0;
      mynode_3.stateindex := -1;
      mynode_3.selectedindex := 1;
    end;
    aqBMDA.next;
  end;
end;

procedure TfrmBmda.FormShow(Sender: TObject);
begin
  aqBMDA.Active := True;

  refreshTree; //����RefreshTree���������ŵ����Ĳ��ű���ֲ��������Ŀ¼����ʽ��ʾ����
  Treeview.topitem.Selected := true;
end;

procedure TfrmBmda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := cafree;
  frmBmda := nil;
end;

//���
procedure TfrmBmda.N_insertClick(Sender: TObject);
var
  gs_global: string; //�洢��ӵĸ��ڵ���⣻
begin
  b_pd := true;
  Node_Parent := Treeview.selected;
  if Node_Parent.level = 2 then
  begin
    Application.messagebox('��ײ㲻����ӣ������ϲ����', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
    exit;
  end;
  //���ð�Ť����Ч��
  button_valid;
  if Node_Parent.level = 0 then
  begin
    aqBMDA.Insert;
    aqBMDA.FieldByName('DepCode').editmask := '99;1;_';
    pagecontrol1.ActivePageIndex := 0;
    DBEdt_Bmbm.setfocus;
  end;
  if Node_Parent.level = 1 then
  begin
    gs_global := copy(Node_Parent.text, 2, 2);
    aqBMDA.insert;
    aqBMDA.FieldByName('DepCode').editmask := '99-99;1;_';
    pagecontrol1.ActivePageIndex := 0;
    DBEdt_Bmbm.setfocus;
    DBEdt_Bmbm.text := gs_global;
  end;
end;

procedure TfrmBmda.N_editClick(Sender: TObject);
begin
  b_pd := false;
  Node_Child := Treeview.selected;
  if Node_Child.level = 0 then
  begin
    Application.messagebox('��㲻�ܱ༭�������²�༭', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
    exit;
  end;
  //���ð�Ť��Ч��
  button_valid;
  Node_Parent := Node_Child.parent;
  if Node_Parent.level = 0 then
  begin
    aqBMDA.edit;
    aqBMDA.FieldByName('DepCode').editmask := '99;1;_';
    pagecontrol1.ActivePageIndex := 0;
    DBEdt_Bmbm.setfocus;
  end;
  if Node_Parent.level = 1 then
  begin
    aqBMDA.edit;
    aqBMDA.FieldByName('DepCode').editmask := '99-99;1;_';
    pagecontrol1.ActivePageIndex := 0;
    DBEdt_Bmbm.setfocus;
  end;
end;

//ɾ��

procedure TfrmBmda.N_deleteClick(Sender: TObject);
var
  mynode: Ttreenode;
begin
  mynode := Treeview.selected;
  //��Ŀ¼����ɾ��
  if mynode.level = 0 then
    exit;
  //���ɾ�����ǵڶ���Ŀ¼  
  if mynode.level = 2 then
  begin
    if aqBMDA.recordcount <> 0 then
    begin
      if Application.messagebox('��ȷ���Ƿ�Ҫɾ��,������Ŀ¼Ҳ����ɾ��', '�ֿ����ϵͳ', mb_iconinformation + mb_yesno) = idyes then
      begin
        aqBMDA.Delete;
        //DM.CDS_BMDA.applyupdates(0);
        Treeview.Items.delete(mynode);
      end;
    end
    else
    begin
      Application.messagebox('���޼�¼��ɾ��', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
      exit;
    end;
    EXIT;
  end;
  //���ɾ���ǵ�һ��Ŀ¼������ɾ���ڶ���Ŀ¼
  if mynode.level = 1 then
  begin
    aqBMDA.filter := 'substring(DepCode,1,2)=' + '''' + copy(mynode.text, 2, 2) + '''';
    aqBMDA.filtered := true;
    aqBMDA.first;
    if aqBMDA.recordcount <> 0 then
    begin
      if Application.messagebox('��ȷ���Ƿ�Ҫɾ��,������Ŀ¼Ҳ����ɾ��', '�ֿ����ϵͳ', mb_iconinformation + mb_yesno) = idyes then
      begin
        while not aqBMDA.eof do
        begin
          aqBMDA.Delete;
        end;
        //DM.CDS_BMDA.applyupdates(0);
        Treeview.Items.delete(mynode);
      end;
    end
    else
    begin
      Application.messagebox('���޼�¼��ɾ��', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
      exit;
    end;
    aqBMDA.filtered := false;
  end;
end;


//�ָ�
procedure TfrmBmda.N_cancelClick(Sender: TObject);
begin
  aqBMDA.cancel;
  //�����������Ч��
  button_valid;
end;

//����
procedure TfrmBmda.N_saveClick(Sender: TObject);
var
  s_bm, s_mc: string;
  query: TADOQuery;
begin
  if Node_Parent.level = 0 then
  begin
    if length(trim(DBEdt_Bmbm.text)) <> 2 then
    begin
      Application.messagebox('����ӦΪ��λ', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
      exit;
    end;
  end;
  if Node_Parent.level = 1 then
  begin
    if copy(DBEdt_Bmbm.text, 1, 2) <> copy(Node_Parent.text, 2, 2) then
    begin
      Application.messagebox('ǰ����λ���ܱ䣬��ȷ��!', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
      DBEdt_Bmbm.text := copy(Node_Parent.text, 2, 2);
      exit;
    end;
    if length(trim(DBEdt_Bmbm.text)) <> 5 then
    begin
      Application.messagebox('����ӦΪ��λ', '�ֿ����ϵͳ', mb_iconinformation + mb_defbutton1);
      exit;
    end;
  end;
  s_bm := DBEdt_Bmbm.text;
  s_mc := DBEdt_Bmmc.text;
  //�����ظ����
  //aqBMDA.IndexName := 'DepCode';
  //aqBMDA.Refresh;
  if aqBMDA.state =  dsinsert then
  begin
      query := TADOquery.Create(self);
      query.Connection:= dmWarehouse.ACWarehouse;
      query.SQL.Text := 'select * from BMDA where DepCode="' + s_bm + '"' ;
      query.open;
      if not query.Eof then
      begin
        MessageBox(handle, '�˲��ű����Ѵ���!', '��ʾ', mb_IconInformation + mb_Ok);
        aqBMDA.Cancel;
        pagecontrol1.ActivePageIndex := 0;
        DBEdt_Bmbm.SetFocus;
        exit;
      end
  end;
  //�ж���������ݵı��滹�Ǳ༭���ݱ���
  if b_pd = true then
    Treeview.items.addchild(Node_Parent, '(' + s_bm + ') ' + s_mc)
  else
    Node_Child.Text := '(' + s_bm + ') ' + s_mc;
  aqBMDA.post;
  //aqBMDA.applyupdates(0);
  //aqBMDA.Refresh;
  //���ð�Ť����Ч��
  button_valid;
end;

//ˢ��
procedure TfrmBmda.N_refreshClick(Sender: TObject);
begin
  refreshTree;
  Treeview.TopItem.selected := true;
end;

//TreeViewClick���ݲ��ű�������λ���ݼ����Ӷ�ʵ�����ݵ�����
procedure TfrmBmda.TreeViewClick(Sender: TObject);
var
  mynode: Ttreenode;
  s_value_1: string;
begin
  if Treeview.Items.Count = 0 then
    exit;
  mynode := Treeview.selected;
  //�������Ŀ¼���ĵ�һ���������ǵ�һ�����ţ����Ĳ��ű���ֻ����λ
  if mynode.Level = 1 then
  begin
    //��Ŀ¼���Ľڵ�����У���ȡ���ű���
    s_value_1 := copy(mynode.text, 2, 2);
    //aqBMDA.IndexName := 'DepCode ';
   // aqBMDA.findkey([s_value_1]);
    aqBMDA.FieldByName('DepCode').editmask := '99;1;_';
  end;
 //�������Ŀ¼���ĵڶ����������ǵڶ������ţ����Ĳ��ű�������λ
  if mynode.Level = 2 then
  begin
    //��Ŀ¼���Ľڵ�����У���ȡ���ű���
    s_value_1 := copy(mynode.text, 2, 5);
    //aqBMDA.IndexName := 'DepCode ';
    //aqBMDA.FindKey([s_value_1]);
    aqBMDA.FieldByName('DepCode').editmask := '99-999;1;_';
  end;
end;

procedure TfrmBmda.N_OrderClick(Sender: TObject);
begin
 
end;

//��ӡ
procedure TfrmBmda.DBGridTitleClick(Column: TColumn);
begin
  //����u_public��Ԫ��DBGridSort���������ֶ�����
  DBGridSort(dbgrid, column);
end;

procedure TfrmBmda.btnCancelClick(Sender: TObject);
begin
  close;
end;

end.

