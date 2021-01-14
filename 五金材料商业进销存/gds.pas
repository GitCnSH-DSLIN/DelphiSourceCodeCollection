unit gds;

//����ִ�к���tabGoods�ϵ�selected�Ϲ�����ѡ
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, TFlatPanelUnit, TFlatSplitterUnit, fcTreeView, Grids, DBGrids,
  ComCtrls, Db, Wwdatsrc, DBTables, Wwtable, Wwdbigrd, Wwdbgrid, common,
  Wwquery, Buttons, TFlatRadioButtonUnit, TFlatGroupBoxUnit, StdCtrls,
  TFlatEditUnit, TFlatButtonUnit, KvLabel, RegControls, ImgList, ADODB,
  Menus, wwDBGridEx, ActnList, XPMenu, Variants;

type
  TfrmGDS = class(TForm)
    Treeview1: TfcTreeView;
    FlatSplitter1: TFlatSplitter;
    FlatPanel1: TFlatPanel;
    FlatSplitter2: TFlatSplitter;
    panSearch: TPanel;
    edSearch: TFlatEdit;
    Label9: TLabel;
    gbSearchType: TFlatGroupBox;
    rbShort: TFlatRadioButton;
    rbName: TFlatRadioButton;
    btnSearch: TFlatButton;
    KvLabel10: TKvLabel;
    labSelectedCount: TKvLabel;
    RegForm1: TRegForm;
    ImageList1: TImageList;
    qryFilter: TADOQuery;
    dsFilter: TwwDataSource;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    ActionList1: TActionList;
    actNewType: TAction;
    actDeleType: TAction;
    actModifyType: TAction;
    actSetFirst: TAction;
    actGdsDelete: TAction;
    actGdsAdd: TAction;
    actGdsEdit: TAction;
    popGds: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    FlatSplitter3: TFlatSplitter;
    panStore: TPanel;
    dbgStore: TDBGrid;
    panGDS: TPanel;
    wwDBGridEx1: TwwDBGridEx;
    dsFirstStore: TwwDataSource;
    qryGdsStore: TADOQuery;
    labNoRecord: TKvLabel;
    popStore: TPopupMenu;
    N6: TMenuItem;
    actAddStore: TAction;
    panSum: TPanel;
    labQua: TKvLabel;
    labAmo: TKvLabel;
    qrySum: TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure Treeview1Change(TreeView: TfcCustomTreeView;
      Node: TfcTreeNode);
    procedure btnSearchClick(Sender: TObject);
    procedure rbShortKeyPress(Sender: TObject; var Key: Char);
    procedure edSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actDeleTypeExecute(Sender: TObject);
    procedure actModifyTypeExecute(Sender: TObject);
    procedure actNewTypeExecute(Sender: TObject);
    procedure actSetFirstExecute(Sender: TObject);
    procedure actGdsDeleteExecute(Sender: TObject);
    procedure actGdsAddExecute(Sender: TObject);
    procedure wwDBGridEx1DblClick(Sender: TObject);
    procedure wwDBGridEx1RowChanged(Sender: TObject);
    procedure dbgStoreDblClick(Sender: TObject);
    procedure labNoRecordDblClick(Sender: TObject);

  private
    procedure LoadTree();
    function NextID(current: string): string;
    procedure UpdateGoodsList(Node: TfcTreeNode);
    procedure FormShow(Sender: TObject);
    procedure TreeView1Edited(TreeView: TfcCustomTreeView; Node: TfcTreeNode; var S: string);
    procedure TreeView1Editing(TreeView: TfcCustomTreeView; Node: TfcTreeNode; var AllowEdit: Boolean);

    { Private declarations }
  public
    { Public declarations }
  end;

const divsign = '''';
  selectedindex = 1;
  unselectedinex = 0;
  //   divsign = '%' ; //��MS SQL Server�����������Ϊͨ����ġ� ��MS Access �����������Ϊͨ����ġ�

var
  frmGDS: TfrmGDS;

implementation

uses data, firstStore, goods;

{$R *.DFM}


procedure TfrmGDS.LoadTree();
var Level: integer;
  preNode: TfcTreeNode;
  CurNode: TfcTreeNode;
  tmpstr: string;
begin
  TreeView1.Items.BeginUpdate;
  prenode := Treeview1.items.add(nil, '��Ʒ����');
  prenode.StringData := 'none';
  prenode.ImageIndex := 0; //
  prenode.Selectedindex := 1; //

  prenode := Treeview1.items.AddChild(prenode, '������Ʒ');
  prenode.StringData := 'all';
  prenode.ImageIndex := 0; //
  prenode.Selectedindex := 1; //

  if not dm.tabtype.active then dm.tabtype.open;
  dm.tabtype.first;
  dm.tabtype.disablecontrols;
  with dm.tabtype do
    with TreeView1 do
      while not eof do
        begin
          level := length(trim(fieldbyname('typeid').asstring)) div 4;
          tmpstr := fieldbyname('typeName').asstring;
          if preNode.level = level then
            CurNode := items.addchild(prenode.parent, tmpstr);
          if level < preNode.level then
            CurNode := items.addchild(Treeview1.items[0], tmpstr);
          if level > preNode.level then
            CurNode := items.addchild(prenode, tmpstr);
          CurNode.ImageIndex := 2;
          curNode.SelectedIndex := 3;
          curNode.StringData := trim(fieldbyname('typeid').asstring);
          next;
          preNode := CurNode;
        end;
  dm.tabtype.enablecontrols;
  Treeview1.Items.EndUpdate;
end;

procedure TfrmGDS.FormShow(Sender: TObject);
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

function TfrmGDS.NextID(current: string): string;
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


procedure TfrmGDS.TreeView1Editing(TreeView: TfcCustomTreeView;
  Node: TfcTreeNode; var AllowEdit: Boolean);
begin
  if (node.Level = 0) or (Node.StringData = 'all') then
    begin
      showmessage('�ⲻ�ɸ��ĵ�! @_@');
      allowedit := false;
    end;
end;

procedure TfrmGDS.TreeView1Edited(TreeView: TfcCustomTreeView;
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


procedure TfrmGDS.FormCreate(Sender: TObject);
begin
  LoadTree;
  UpdateGoodsList(Treeview1.TopItem);
end;

procedure TfrmGDS.UpdateGoodsList(Node: TfcTreeNode);
var tmpbegin: string;
  tmpend: string;
  ListItem: TListItem;
begin
  if node = Treeview1.TopItem then exit;
  if Node.StringData = 'all' then //���׽�㣬�����е���Ʒ����ʾ����
    begin
      tmpbegin := '0000';
      tmpend := '9999';
    end
  else
    begin
      tmpbegin := trim(node.stringData);
      tmpEnd := plusone(tmpbegin);
    end;

  with qryFilter do
    begin
      close;
      sql.clear;
      sql.add('select a.gdsid,gdsname,unit,amoqua,amoamo,outprice1 from goods as a  ');
      sql.add('  left join  (select gdsid,sum(qua) as amoqua,sum(amo) as amoamo  ');
      sql.add('                      from firststore group by gdsid)  as b       ');
      sql.add('  on a.gdsid=b.gdsid                                              ');
      sql.add('where (gdstypeid >=:tmpBegin) and (gdstypeid < :tmpend)           ');
      sql.add('order by b.amoamo desc ,a.gdsid                     ');

      Parameters.parambyname('tmpBegin').value := tmpbegin;
      Parameters.parambyname('tmpend').value := tmpend;
   //   showmessage(sql.text);
      open;
      fieldbyname('gdsid').displayLabel := '��Ʒ���';
      fieldbyname('gdsid').displaywidth := 8;
      fieldbyname('gdsName').displayLabel := '��Ʒ����';
      fieldbyname('gdsName').displaywidth := 20;
      fieldbyname('unit').displayLabel := '��Ʒ����';
      fieldbyname('amoamo').displayLabel := '�����';
      fieldbyname('amoqua').displayLabel := '�����';
      fieldbyname('outprice1').displayLabel := '���ۼ�1';
    end;
end;


procedure TfrmGDS.Treeview1Change(TreeView: TfcCustomTreeView;
  Node: TfcTreeNode);
begin
  UpdateGoodsList(Node);
end;

procedure TfrmGDS.btnSearchClick(Sender: TObject);
begin
  if trim(edSearch.text) <> '' then
    with qryFilter do
      begin
        close;
        sql.clear;
        sql.add('select a.gdsid,gdsname,unit,amoqua,amoamo,outprice1 from goods as a  ');
        sql.add('  left join  (select gdsid,sum(qua) as amoqua,sum(amo) as amoamo  ');
        sql.add('                      from firststore group by gdsid)  as b       ');
        sql.add('  on a.gdsid=b.gdsid                                              ');

        if rbShort.Checked then
          sql.add('where a.gdsid like ''%' + trim(edSearch.text) + '%''')
        else
          sql.add('where a.gdsname like ''%' + trim(edSearch.text) + '%''');
        sql.add('order by b.amoamo desc , a.gdsid                                    ');

        open;
        fieldbyname('gdsid').displayLabel := '��Ʒ���';
        fieldbyname('gdsid').displaywidth := 8;
        fieldbyname('gdsName').displayLabel := '��Ʒ����';
        fieldbyname('gdsName').displaywidth := 20;
        fieldbyname('unit').displayLabel := '��Ʒ����';
        fieldbyname('amoamo').displayLabel := '����ܼ�';
        fieldbyname('amoqua').displayLabel := '�����';
        fieldbyname('outprice1').displayLabel := '���ۼ�1';
      end;
end;

procedure TfrmGDS.rbShortKeyPress(Sender: TObject; var Key: Char);
begin
  btnSearchClick(Sender);
end;

procedure TfrmGDS.edSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    begin
      key := word(#0);
      btnSearchClick(Sender);
    end;
end;

procedure TfrmGDS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmGDS.actDeleTypeExecute(Sender: TObject);
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

procedure TfrmGDS.actModifyTypeExecute(Sender: TObject);
var
  NewString: string;
  ClickedOK: Boolean;
  tmpSql: TADOQuery;
begin
  if treeview1.Selected.StringData <> null then
    NewString := treeview1.Selected.Text;
  if not InputQuery('��������', '��������Ҫ���ĵĵ����� ��', NewString) then exit;
  newstring := trim(NewString); //ȥ��ǰ��ո� ��
  if newString = null then exit; //���ַ���ȡ��

  tmpSQL := TADOQuery.create(self);
  tmpSql.connection := dm.db;
  with tmpsql do
    begin
      close;
      sql.clear;
      sql.Add('update gdsType');
      sql.add('set typename = :typename');
      sql.add('where (typeid = :typeID)');
      Parameters.parambyname('typeID').value := treeview1.Selected.StringData;
      Parameters.parambyname('typename').value := NewString;
      execsql;
      treeview1.Selected.Text := NewString; //���ݿ�����ؼ�¼�����ˣ��ٸ��½���
      treeview1.Items.EndUpdate;
    end;
  tmpSQl.free;
  tmpsql := nil;
end;

procedure TfrmGDS.actNewTypeExecute(Sender: TObject);
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

procedure TfrmGDS.actSetFirstExecute(Sender: TObject);
var frmFirstStoreAdd: TfrmFirstStoreAdd;
begin
  frmFirstStoreAdd := TfrmFirstStoreAdd.Create(self);
  with frmFirstStoreAdd do
    begin
      tmpgdsid := qryFilter.Fieldbyname('gdsid').Value;
      tmpgdsname := qryFilter.Fieldbyname('gdsname').Value;
      showmodal;
      Free;
    end;
end;

procedure TfrmGDS.actGdsDeleteExecute(Sender: TObject);
begin
  if MessageDlg('��ȷ��Ҫɾ����ǰ��Ʒ�� ', mtConfirmation, [mbYes, mbNO], 0) = mrYes then
    try
      qryFilter.Delete;
    except
      ShowMessage('����ʧ�� !');
      abort;
    end; //end of try
end;

procedure TfrmGDS.actGdsAddExecute(Sender: TObject);
begin
  OpenForm(Tfrmgoods, frmgoods, self);
end;

procedure TfrmGDS.wwDBGridEx1DblClick(Sender: TObject);
begin
  with dm.tabgoods do
    begin
      if not active then open;
      locate('gdsid', qryFilter.Fieldbyname('gdsid').Value, []);
      dm.tmpgdstypeid := Fieldbyname('gdstypeid').Value ;
    end;
  OpenForm(Tfrmgoods, frmgoods, self);
end;

procedure TfrmGDS.wwDBGridEx1RowChanged(Sender: TObject);
begin
  with qryGdsStore do
    begin
      close;
      open;
      if isempty then
        begin
          //          dbgStore.Visible := false ;
          //          panSum.Visible   := false;
          labQua.Caption := '������� ��0 ';
          labAmo.Caption := '����ܼ� ��0 ';

        end
      else
        begin
          dbgStore.Visible := true;
          panSum.Visible := true;
          qrysum.close;
          qrySum.Parameters.ParamByName('gdsid').Value := qryFilter.Fieldbyname('gdsid').Value;
          qrysum.Open;
          if qrysum.IsEmpty then exit;
          labQua.Caption := '������� ��' + qrysum.fieldbyname('quaamo').asstring;
          labAmo.Caption := '����ܼ� ���� ' + qrysum.fieldbyname('amoamo').asstring;
        end; //end of if .. else
    end; // end of with qryGdsStore do
end;

procedure TfrmGDS.dbgStoreDblClick(Sender: TObject);
begin
  actSetFirstExecute(Sender);
end;

procedure TfrmGDS.labNoRecordDblClick(Sender: TObject);
begin
  actSetFirstExecute(Sender);
end;

end.
