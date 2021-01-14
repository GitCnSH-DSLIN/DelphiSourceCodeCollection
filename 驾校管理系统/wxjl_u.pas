unit wxjl_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, DBCtrls, ExtCtrls, Grids, DBGrids, DB,
  DBTables, Menus,ComObj, ComCtrls, TabNotBk;

type
  Twxjl = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    Database1: TDatabase;
    Label13: TLabel;
    Table2: TTable;
    DataSource2: TDataSource;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Query1: TQuery;
    DataSource3: TDataSource;
    Table1BDEDesigner: TStringField;
    Table1BDEDesigner2: TStringField;
    Table1BDEDesigner3: TStringField;
    Table1BDEDesigner4: TStringField;
    Table1BDEDesigner5: TStringField;
    Table1BDEDesigner6: TStringField;
    Table1BDEDesigner7: TStringField;
    Table1BDEDesigner8: TStringField;
    Table1BDEDesigner9: TStringField;
    Table1BDEDesigner10: TDateTimeField;
    Table1BDEDesigner11: TStringField;
    Table1BDEDesigner12: TStringField;
    Table3: TTable;
    Table3wxjl: TIntegerField;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit12: TDBEdit;
    DBComboBox2: TDBComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBComboBox1: TDBComboBox;
    DBComboBox3: TDBComboBox;
    DBComboBox4: TDBComboBox;
    BitBtn3: TBitBtn;
    TabSheet2: TTabSheet;
    DBGrid2: TDBGrid;
    GroupBox2: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    ComboBox2: TComboBox;
    CheckBox1: TCheckBox;
    DBNavigator2: TDBNavigator;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    BitBtn14: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure DBComboBox1DropDown(Sender: TObject);
    procedure DBComboBox2DropDown(Sender: TObject);
    procedure DBComboBox3DropDown(Sender: TObject);
    procedure DBComboBox4DropDown(Sender: TObject);
    procedure Table1AfterInsert(DataSet: TDataSet);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure Query1AfterEdit(DataSet: TDataSet);
    procedure Query1BeforeInsert(DataSet: TDataSet);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Table1AfterCancel(DataSet: TDataSet);
    procedure Table1AfterPost(DataSet: TDataSet);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  wxjl: Twxjl;
  dropdownflag:integer;

implementation

{$R *.dfm}
uses xyda_u;
procedure Twxjl.FormCreate(Sender: TObject);
begin
  //��ʼ����ѯ��¼¼��Ŀؼ�
  table1.Close;  //����
  table1.Open;
  table2.Close; //combobox��Ӧ�ı�
  table2.Open;
  dbedit1.Enabled:=false; //�ɺ�
  dbedit10.Enabled:=false; //��������
  dbedit12.Enabled:=false; //������
  //��ʼ����ѯ��¼��ѯ�Ŀؼ�
  bitbtn5.Enabled:=false;  //��ӡ
  bitbtn7.Enabled:=false;  //�޸�
  bitbtn8.Enabled:=false;  //���
  bitbtn9.Enabled:=false;  //����
  bitbtn10.Enabled:=false; //ɾ��
  bitbtn11.Enabled:=false; //ȡ��
  bitbtn12.Enabled:=false; //ˢ��
  bitbtn13.Enabled:=false; //����
  bitbtn14.Enabled:=false; //����EXCLE
    //dbgrid1.Columns[2].PickList.add('��');
    //dbgrid1.Columns[2]PickList[1]:='Ů';
end;

procedure Twxjl.DBComboBox1DropDown(Sender: TObject);
begin
    with dbcombobox1 do
    if Items.count<=0 then
      begin
       items.Add('��');
       items.Add('Ů');
      end;
end;

procedure Twxjl.DBComboBox2DropDown(Sender: TObject);
begin
    with dbcombobox2 do
    begin
     if items.count<=0 then
       begin
         with table2 do
         begin
          table2.First;
           while (fieldvalues['ѧϰ����']<>null) and (not eof) do
           begin
              items.Add(fieldvalues['ѧϰ����']);
              next;
           end;
          end;
        end;
     end;
end;

procedure Twxjl.DBComboBox3DropDown(Sender: TObject);
begin
    with dbcombobox3 do
    begin
     if items.count<=0 then
       begin
        with table2 do
        begin
         first;
          while (fieldvalues['������']<>null) and (not eof) do
           begin
              items.Add(fieldvalues['������']);
              next;
           end;
          end;
        end;
     end;
end;

procedure Twxjl.DBComboBox4DropDown(Sender: TObject);
begin
    with dbcombobox4 do
    begin
     if items.count<=0 then
       begin
        with table2 do
        begin
          first;
           while (fieldvalues['������']<>null) and (not eof) do
            begin
              items.Add(fieldvalues['������']);
              next;
            end;
          end;
        end;
     end;
end;


procedure Twxjl.Table1AfterInsert(DataSet: TDataSet); //�Զ����ɱ��
var
  i:integer;
begin
   table3.Open;
   table3.Edit;
   i:=table3.FieldValues['wxjl']+1;
   table1.FieldByName('���').AsString:=formatfloat('300000',i);
   table1.FieldByName('��ѯʱ��').AsDateTime:=now;
end;


procedure Twxjl.N2Click(Sender: TObject);
begin
    table1.Insert;
end;

procedure Twxjl.N3Click(Sender: TObject);
begin
   table1.Append;
end;

procedure Twxjl.N5Click(Sender: TObject);
begin
   table1.Delete;
end;

procedure Twxjl.N6Click(Sender: TObject);
begin
   table1.Cancel;
end;

procedure Twxjl.N1Click(Sender: TObject);
begin
   Application.CreateForm(Txyda, xyda);
   xyda.ShowModal;
end;

{
������������DBGrid�����Excel���֧�ֶ�Sheet��
���ø�ʽ��CopyDbDataToExcel([DBGrid1, DBGrid2]);
}
procedure CopyDbDataToExcel(Args: array of const);
var
  iCount, jCount: Integer;
  XLApp: Variant;
  Sheet: Variant;
  I: Integer;
begin
  Screen.Cursor := crHourGlass;
  if not VarIsEmpty(XLApp) then
  begin
    XLApp.DisplayAlerts := False;
    XLApp.Quit;
    VarClear(XLApp);
  end;

  try
    XLApp := CreateOleObject('Excel.Application');
  except
    Screen.Cursor := crDefault;
    Exit;
  end;

  XLApp.WorkBooks.Add;
  XLApp.SheetsInNewWorkbook := High(Args) + 1;

  for I := Low(Args) to High(Args) do
  begin
    XLApp.WorkBooks[1].WorkSheets[I+1].Name := TDBGrid(Args[I].VObject).Name;
    Sheet := XLApp.Workbooks[1].WorkSheets[TDBGrid(Args[I].VObject).Name];

    if not TDBGrid(Args[I].VObject).DataSource.DataSet.Active then
    begin
      Screen.Cursor := crDefault;
      Exit;
    end;

    TDBGrid(Args[I].VObject).DataSource.DataSet.first;
    for iCount := 0 to TDBGrid(Args[I].VObject).Columns.Count - 1 do
      Sheet.Cells[1, iCount + 1] :=
    TDBGrid(Args[I].VObject).Columns.Items[iCount].Title.Caption;

    jCount := 1;
    while not TDBGrid(Args[I].VObject).DataSource.DataSet.Eof do
    begin
      for iCount := 0 to TDBGrid(Args[I].VObject).Columns.Count - 1 do
        Sheet.Cells[jCount + 1, iCount + 1] :=
      TDBGrid(Args[I].VObject).Columns.Items[iCount].Field.AsString;

      Inc(jCount);
      TDBGrid(Args[I].VObject).DataSource.DataSet.Next;
    end;
    XlApp.Visible := True;
  end;
  Screen.Cursor := crDefault;
end;

procedure Twxjl.BitBtn3Click(Sender: TObject);
begin
    CopyDbDataToExcel([DBGrid1]);
end;

procedure Twxjl.BitBtn4Click(Sender: TObject);
var
wherestr:string;
begin
  if trim(combobox1.Text)<>'' then  //��ѯ��������Ϊ��
  begin
      with query1 do
      begin
        Close;
        SQL.Clear;
        if edit1.text<>'' then   //��ѯ������ֵ����Ϊ��
        begin
          {
           wherestr:='where '+combobox1.Text+combobox2.text+':name';
           SQL.Add('select * from ��ѯ��¼');
           SQL.Add(wherestr);
           ParamByName('name').AsString:=trim(edit1.Text);
          }
          sql.Add('select * from ��ѯ��¼');
          sql.add(format('where '+combobox1.Text+combobox2.Text+'''%s''',[edit1.text]));
        end
        else
        begin
          SQL.Add('select * from ��ѯ��¼');
        end;
        if not Prepared then
        Prepare;
        Open;
        if query1.recordcount=0 then   //�����ѯ�޼�¼������ʾ�޼�¼��
        begin
          bitbtn5.Enabled:=false;
          bitbtn7.Enabled:=false;
          bitbtn8.Enabled:=false;
          bitbtn9.Enabled:=false;
          bitbtn10.Enabled:=false;
          bitbtn12.Enabled:=false;
          bitbtn14.Enabled:=false;
           showmessage('����ؼ�¼');
        end
        else
        begin
          bitbtn5.Enabled:=true;
          bitbtn7.Enabled:=true;
          bitbtn8.Enabled:=true;
          bitbtn9.Enabled:=true;
          bitbtn10.Enabled:=true;
          bitbtn12.Enabled:=true;
          bitbtn14.Enabled:=true;
        end;
      end;
  end
  else
    showmessage('û��ѡ���ѯ������');
end;

procedure Twxjl.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    query1.Close;
    query1.UnPrepare;
    wxjl.Destroy;
end;

procedure Twxjl.BitBtn14Click(Sender: TObject);
begin
    CopyDbDataToExcel([DBGrid2]);
end;

procedure Twxjl.BitBtn7Click(Sender: TObject);
begin
   query1.Edit;
   dbgrid2.ReadOnly:=false;
   query1.RequestLive:=true;
end;

procedure Twxjl.BitBtn8Click(Sender: TObject);
begin
   dbgrid2.ReadOnly:=false;
   query1.RequestLive:=true;
   query1.Append;
end;

procedure Twxjl.BitBtn9Click(Sender: TObject);
var
  i:integer;
begin
   dbgrid2.ReadOnly:=false;
   query1.RequestLive:=true;
   query1.Insert;
   i:=query1.RecordCount;
   query1.FieldByName('���').AsString:=formatfloat('300000',i);
   query1.FieldByName('��ѯʱ��').AsDateTime:=now;
end;

procedure Twxjl.BitBtn10Click(Sender: TObject);
begin
   if application.MessageBox('�Ƿ����Ҫɾ���˼�¼��','����',mb_yesno)=idyes then
   begin
      //dbgrid2.ReadOnly:=false;
      query1.RequestLive:=true;
      query1.Delete;
   end;
end;

procedure Twxjl.BitBtn13Click(Sender: TObject);  //����
begin
   query1.Post;
   dbgrid2.ReadOnly:=true;
   query1.RequestLive:=false;
   BitBtn4Click(Sender);  //ˢ�±����ļ�¼
   bitbtn11.Enabled:=false; //����ؼ�
   bitbtn13.Enabled:=false; //ȡ���ؼ�
end;

procedure Twxjl.BitBtn11Click(Sender: TObject);
begin
    query1.Cancel;
    dbgrid2.ReadOnly:=true;
    query1.RequestLive:=false;
    bitbtn11.Enabled:=false; //����ؼ�
    bitbtn13.Enabled:=false; //ȡ���ؼ�
end;

procedure Twxjl.BitBtn12Click(Sender: TObject);
begin
    DBNavigator2.Refresh;
    //query1.refresh;
end;

procedure Twxjl.BitBtn6Click(Sender: TObject);
begin
   self.Close;
end;


procedure Twxjl.Query1AfterEdit(DataSet: TDataSet);
begin
   bitbtn11.Enabled:=true;  //����ؼ�
   bitbtn13.Enabled:=true;  //ȡ���ؼ�
end;

procedure Twxjl.Query1BeforeInsert(DataSet: TDataSet);
begin
   bitbtn11.Enabled:=true;  //����ؼ�
   bitbtn13.Enabled:=true;  //ȡ���ؼ�
end;

procedure Twxjl.DBGrid1CellClick(Column: TColumn);
begin
    with dbgrid1 do
    begin
     if Columns[2].picklist.count<=0 then
       begin
        with table2 do
        begin
         first;
          while (fieldvalues['�Ա�']<>null) and (not eof) do
           begin
              Columns[2].picklist.Add(fieldvalues['�Ա�']);
              next;
           end;
          end;
        end;
     end;

    with dbgrid1 do
    begin
     if Columns[5].picklist.count<=0 then
       begin
        with table2 do
        begin
         first;
          while (fieldvalues['ѧϰ����']<>null) and (not eof) do
           begin
              Columns[5].picklist.Add(fieldvalues['ѧϰ����']);
              next;
           end;
          end;
        end;
     end;

    with dbgrid1 do
    begin
     if Columns[8].picklist.count<=0 then
       begin
        with table2 do
        begin
         first;
          while (fieldvalues['��ѯ����']<>null) and (not eof) do
           begin
              Columns[8].picklist.Add(fieldvalues['��ѯ����']);
              next;
           end;
          end;
        end;
     end;

    with dbgrid1 do
    begin
     if Columns[10].picklist.count<=0 then
       begin
        with table2 do
        begin
         first;
          while (fieldvalues['������']<>null) and (not eof) do
           begin
              Columns[10].picklist.Add(fieldvalues['������']);
              next;
           end;
          end;
        end;
     end;

end;

procedure Twxjl.Table1AfterCancel(DataSet: TDataSet);
begin
   table3.Cancel;
end;

procedure Twxjl.Table1AfterPost(DataSet: TDataSet);
begin
   table3.Post;
end;

procedure Twxjl.BitBtn2Click(Sender: TObject);
begin
  close;
end;

end.
