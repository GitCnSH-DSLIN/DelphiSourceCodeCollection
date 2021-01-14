unit gdstype;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, fcCombo, fctreecombo, Grids, Wwdbigrd, Wwdbgrid, wwSpeedButton,
  wwDBNavigator, ExtCtrls, wwclearpanel, ComCtrls, Buttons,
  fcdbtreeview, TFlatPanelUnit, ImgList, fcTreeView, TFlatButtonUnit, jpeg,
  Menus, Db, DBTables, Wwquery, Variants, RegControls, ADODB;

type
  TfrmType = class(TForm)
    FlatPanel1: TFlatPanel;
    TreeView1: TfcTreeView;
    stateImage: TImageList;
    Panel1: TPanel;
    btnNew: TFlatButton;
    bntModify: TFlatButton;
    btnDelete: TFlatButton;
    Image1: TImage;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    RegForm1: TRegForm;
    procedure FormShow(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure bntModifyClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure TreeView1Editing(TreeView: TfcCustomTreeView;
      Node: TfcTreeNode; var AllowEdit: Boolean);
    procedure TreeView1Edited(TreeView: TfcCustomTreeView;
      Node: TfcTreeNode; var S: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure LoadTree();
    function NextID(current: string): string;
    { Private declarations }
  public
    { Public declarations }
  end;

const selectedindex = 1;
  unselectedinex = 0;
var
  frmType: TfrmType;

implementation

uses data;

{$R *.DFM}


procedure TfrmType.LoadTree();
var Level: integer;
  preNode: TfcTreeNode;
  CurNode: TfcTreeNode;
  tmpstr: string;
begin
  Treeview1.Items.BeginUpdate;
  Treeview1.Items.Clear;
  prenode := treeview1.items.add(nil, '��Ʒ���� ');
  prenode.StringData := 'all';
  prenode.ImageIndex := 0; //
  prenode.Selectedindex := 1; //
  dm.tabtype.First;
  with dm.tabtype do
    with TreeView1 do
      while not eof do
        begin
          level := length(trim(fieldbyname('typeid').asstring)) div 4;
          tmpstr := fieldbyname('typeName').asstring + '  ';
          if preNode.level = level then
            CurNode := items.addchild(prenode.parent, tmpstr);
          if level < preNode.level then
            CurNode := items.addchild(treeview1.items[0], tmpstr);
          if level > preNode.level then
            CurNode := items.addchild(prenode, tmpstr);
          CurNode.ImageIndex := 2;
          curNode.SelectedIndex := 3;
          curNode.StringData := trim(fieldbyname('typeid').asstring);
          next;
          preNode := CurNode;
        end;
  Treeview1.Items.EndUpdate;
end;

procedure TfrmType.FormShow(Sender: TObject);
begin
  if not dm.tabtype.active then dm.tabtype.open;
  Dm.tabType.First;
  LoadTree();
end;

//���ܣ����ַ�+1

function plusone(tmp: string): string;
var sb, st: string;
begin
  sb := copy(tmp, 0, length(tmp) - 4);
  st := copy(tmp, length(tmp) - 4 + 1, 4);
  if sb = '9999' then result := '-1'
  else result := sb + format('%4.4d', [strtoint(st) + 1]);
end;

//���ܣ����뵱Ȼ��ID������������������һ�����һ�����,��һ���ID������Ҫ��current=''����

function TfrmType.NextID(current: string): string;
var tmpSql: TADOQuery;
  tmpbegin: string;
  tmpEnd: string;
begin
  tmpSql := TadoQuery.create(self);
  tmpSql.connection := dm.db;
  if trim(current) = 'all' then //�ײ�ȡTABLE���ļ�¼���ɡ� �����һ��
    with tmpsql do
      begin
        close;
        sql.clear;
        //��ʼ��select Max(typeid) as tmpmax FROM gdsType
        //��Ȼ���ݿ��ǿ�ʱ�ͻ����ġ���
        sql.Add('select Max(typeid) as tmpmax FROM gdsType'); //ʼ��ֻ�᷵��һ����¼����������û��recordcount��û���ˡ�
        open;
        if length(trim(fieldbyname('tmpmax').asstring)) < 1 then //if use isempty , error , i don't know why ???? ���ݿ�Ϊ��ʱ�����㲻��
          result := '0001'
        else
          begin
            last;
            result := plusone(copy(fieldbyname('tmpmax').asstring, 0, 4));
          end;
      end

  else //�����׽��Ļ���
    begin
      tmpbegin := trim(current);
      tmpend := plusone(tmpbegin);
      if tmpend = '-1' then raise exception.Create('����������ѵ����9999�� :(');
      with tmpSql do
        begin
          close;
          sql.clear;
          sql.Add('SELECT  MAX( typeID ) as tmpmax');
          sql.add('FROM gdsType');
          sql.add('WHERE (typeID > :tmpbegin)'); //attion : �����õ��ڣ�or .������Եġ�
          sql.add('AND  (typeID < :tmpend)'); //��Ҳһ�������˺ܾò�֪������
          Parameters.parambyname('tmpbegin').value := tmpbegin;
          Parameters.parambyname('tmpend').value := tmpend;
          open;
          if trim(fieldbyname('tmpmax').asstring) = '' then //00-9-20 ����Ҳ������ͬ�������ã���select max һ���᷵��1����¼
            //������if recordcount = 0 then ���Ը����������

            result := tmpbegin + '0001'
          else
            result := plusone(fieldbyname('tmpmax').asstring);
        end;
    end; //end of else
  tmpsql.Free; //�ͷſռ�
  tmpsql := nil;
end;


procedure TfrmType.btnNewClick(Sender: TObject);
var myNode: TfcTreeNode;
  tmpnextid: string;
begin
  if treeview1.selected.level >= 5 then
    begin
      showmessage('���ֻ�����! *_*');
      exit;
    end;
  if Treeview1.Selected.Level < 1 then //���׽�㽨��
    begin
      myNode := Treeview1.items.GetFirstNode;
      tmpnextid := NextID('all');
    end
  else //not create at the firs node
    begin
      MyNode := treeview1.Selected;
      tmpNextId := nextid(mynode.StringData);
    end;
  myNode := Treeview1.items.addChild(myNode, '�½�');
  myNode.StringData := tmpNextId;
  mynode.ImageIndex := 2;
  mynode.SelectedIndex := 3;
  treeview1.Selected := mynode;
  with dm.tabType do
    begin
      append;
      fieldbyname('TypeId').asstring := tmpNextID;
      fieldbyname('TypeName').asstring := mynode.Text;
      post;
    end;
  myNode.EditText;
end;

procedure TfrmType.bntModifyClick(Sender: TObject);
begin
  if treeview1.Selected.StringData <> null then
    treeview1.Selected.EditText;
end;

procedure TfrmType.btnDeleteClick(Sender: TObject);
var tmpSQL: TADOQuery;
  isall: boolean;
  tmpbegin: string;
  tmpend: string;
begin
  if Application.MessageBox('�����Ҫɾ�����ּ���������Ʒ����', '�����',
    MB_YESNO + MB_ICONINFORMATION + MB_DEFBUTTON2) <> IDYes
    then exit;
  tmpSQL := TADOQuery.create(self);
  tmpSql.connection := dm.db;
  isall := (treeview1.selected.level = 0);
  if isAll then // ѡ�����ȫ��ɾ������
    begin
      tmpbegin := '0000';
      tmpend := '9999';
    end //ɾ����㼰�����㡣
  else
    begin
      tmpbegin := treeview1.selected.StringData;
      tmpend := plusone(tmpbegin);
    end;
  with tmpsql do
    begin
      close;
      sql.clear;
      sql.Add('delete FROM gdsType');
      sql.add('where (typeid >= :tmpbegin)');
      sql.add('and (typeid <:tmpend)');
      Parameters.parambyname('tmpbegin').value := tmpbegin;
      Parameters.parambyname('tmpend').value := tmpend;
      execsql;
      treeview1.items.BeginUpdate;
      treeview1.selected.Delete;
      if isALL then
        begin
          treeview1.Items.Add(nil, '��Ʒ����');
          treeview1.TopItem.ImageIndex := 0;
          treeview1.TopItem.Selectedindex := 1;
        end;
      treeview1.Items.EndUpdate;
    end;
  tmpSQl.free;
  tmpsql := nil;
end;

procedure TfrmType.TreeView1Editing(TreeView: TfcCustomTreeView;
  Node: TfcTreeNode; var AllowEdit: Boolean);
begin
  if node.Level = 0 then
    begin
      showmessage('�ⲻ�ɸ��ĵ�! @_@');
      allowedit := false;
    end;
end;

procedure TfrmType.TreeView1Edited(TreeView: TfcCustomTreeView;
  Node: TfcTreeNode; var S: string);
begin
  with dm.tabtype do
    begin
      locate('typeid', node.StringData, []);
      edit;
      fieldbyname('typename').asstring := S;
      post;
    end;
end;

procedure TfrmType.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
