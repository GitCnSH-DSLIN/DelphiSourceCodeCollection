unit toexcelUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, Excel2000, OleServer,
  Grids, DBGrids, DB, DBTables, BusinessSkinForm, bsSkinCtrls;

type
  Ttoexcel = class(TForm)
    ExcelApplication1: TExcelApplication;
    ExcelWorksheet1: TExcelWorksheet;
    ExcelWorkbook1: TExcelWorkbook;
    Query1: TQuery;
    DataSource1: TDataSource;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    GroupBox1: TGroupBox;
    ProgressBar1: TProgressBar;
    GroupBox3: TGroupBox;
    Bevel1: TBevel;
    SpeedButton1: TbsSkinSpeedButton;
    Panel3: TPanel;
    Bevel2: TBevel;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton9: TSpeedButton;
    ListBox7: TListBox;
    ListBox8: TListBox;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel3: TBevel;
    SpeedButton2: TSpeedButton;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    CheckBox2: TCheckBox;
    ComboBox2: TComboBox;
    Edit2: TEdit;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    DBGrid1: TDBGrid;
    procedure CheckBox1Click(Sender: TObject);
    procedure ComboBox1Enter(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure excsql(var classcom:string);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ComboBox2Enter(Sender: TObject);
    procedure panduant;
    procedure SpeedButton10Click(Sender: TObject);
    procedure ListBox7DblClick(Sender: TObject);
    procedure ListBox8DblClick(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  toexcel: Ttoexcel;

implementation
uses mainunit,dataunit,lujingunit;

{$R *.dfm}

procedure Ttoexcel.CheckBox1Click(Sender: TObject);
begin
if CheckBox1.Checked=true then
  begin
  CheckBox2.Enabled:=false;
  ComboBox2.Enabled:=false;
  ComboBox1.Enabled:=false;
  end
else
  begin
    CheckBox2.Enabled:=true;
    if not CheckBox2.Checked then
    ComboBox2.Enabled:=true;
    ComboBox1.Enabled:=true;
    CheckBox2.Enabled:=true;
  end;
end;

procedure Ttoexcel.ComboBox1Enter(Sender: TObject);
begin
ComboBox1.Clear;
if DataModule1.xibie.RecordCount<>0 then
  begin
    DataModule1.xibie.First;
    while not DataModule1.xibie.Eof do
      begin
        ComboBox1.Items.Add(DataModule1.xibie.FieldValues['Ժϵ����']);
        DataModule1.xibie.Next;
      end;
     DataModule1.xibie.First;
  end;
end;

procedure Ttoexcel.CheckBox2Click(Sender: TObject);
begin
if CheckBox2.Checked=true then
  ComboBox2.Enabled:=false
else
  ComboBox2.Enabled:=true;
end;



procedure ttoexcel.excsql(var classcom:string);
var
  count:integer;
  tagd:Boolean;
begin
count:=0;
tagd:=false;
///////////////////////////////ִ�����////////////////////
  if ListBox8.Count<>0 then
    begin
      with Query1 do
        begin
          Close;
          UnPrepare;
          SQL.Clear;
          sql.Add('select'+'');
           while ListBox8.Count-1<>count-1 do
             begin
               if (ListBox8.Items.Strings[count]='50����')or(ListBox8.Items.Strings[count]='���')or
                  (ListBox8.Items.Strings[count]='����')or(ListBox8.Items.Strings[count]='800����')or(ListBox8.Items.Strings[count]='�ȼ�����')or
                  (ListBox8.Items.Strings[count]='1000����')or(ListBox8.Items.Strings[count]='��������')or(ListBox8.Items.Strings[count]='��������ָ��')or
                  (ListBox8.Items.Strings[count]='�λ�������')or(ListBox8.Items.Strings[count]='�λ�������ָ��')or(ListBox8.Items.Strings[count]='������Զ')or
                  (ListBox8.Items.Strings[count]='��������')or(ListBox8.Items.Strings[count]='������ǰ��')or(ListBox8.Items.Strings[count]='�ܳɼ�')  then
                    begin
                      if tagd=true then
                        SQL.Add(',');
                      query1.SQL.Add('stugread.'+QuotedStr(ListBox8.Items.Strings[count]));
                      tagd:=true;
                    end
              else if (ListBox8.Items.Strings[count]='50���ܳɼ�')or(ListBox8.Items.Strings[count]='������سɼ�')or(ListBox8.Items.Strings[count]='800���ܳɼ�')or
                  (ListBox8.Items.Strings[count]='1000���ܳɼ�')or(ListBox8.Items.Strings[count]='��������ָ���ɼ�')or
                  (ListBox8.Items.Strings[count]='�λ�������ָ���ɼ�')or(ListBox8.Items.Strings[count]='������Զ�ɼ�')or
                  (ListBox8.Items.Strings[count]='���������ɼ�')or(ListBox8.Items.Strings[count]='������ǰ���ɼ�')  then
                    begin
                      if tagd=true then
                        SQL.Add(',');
                      query1.SQL.Add('stugreaninfo.'+QuotedStr(ListBox8.Items.Strings[count]));
                      tagd:=true;
                    end
              else
                begin
                  if Tagd=true then
                    SQL.Add(',');
                   SQL.Add(ListBox8.Items.Strings[count]);
                   tagd:=true;
                end;
               count:=count+1;
             end;
            SQL.Add(' from xueshengxinxi join stugread on xueshengxinxi.ѧ�����=stugread.ѧ����� join stugreaninfo on xueshengxinxi.ѧ�����=stugreaninfo.ѧ�����  where xueshengxinxi.�����༶����='+QuotedStr(classcom));
            Prepare;
            ExecSQL;
            Active:=true;
        end;
    end;
end;




procedure Ttoexcel.SpeedButton2Click(Sender: TObject);
begin
lujingform.ShowModal;
end;

procedure Ttoexcel.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
mainform.closetable;
Query1.Close;
Query1.UnPrepare;
mainform.Show;
end;

procedure Ttoexcel.ComboBox2Enter(Sender: TObject);
begin
ComboBox2.Items.Clear;
DataModule1.banjixinxi.Filtered:=false;
if ComboBox1.Text<>'' then
  begin
    if DataModule1.banjixinxi.RecordCount<>0 then
      begin
        DataModule1.banjixinxi.First;
        while DataModule1.banjixinxi.Eof<>true do
          begin
            if DataModule1.banjixinxi.FieldValues['����Ժϵ����']=ComboBox1.Text then
              ComboBox2.Items.Add(DataModule1.banjixinxi.FieldValues['�༶����']);
            DataModule1.banjixinxi.Next;
          end;
        DataModule1.banjixinxi.First;
      end;
  end
else
  begin
    if DataModule1.banjixinxi.RecordCount<>0 then
      begin
        DataModule1.banjixinxi.First;
        while DataModule1.banjixinxi.Eof<>true do
          begin
            ComboBox2.Items.Add(DataModule1.banjixinxi.FieldValues['�༶����']);
            DataModule1.banjixinxi.Next;
          end;
        DataModule1.banjixinxi.First;
      end;
  end;
end;

procedure ttoexcel.panduant;
var
  tag:integer;
begin
  tag:=0;
  if ListBox8.Count<>0 then
    begin
      while tag<>ListBox8.Count do
        begin
          if ListBox7.Items.Strings[integer(ListBox7.ItemIndex)]=ListBox8.Items.Strings[tag] then
            Abort;
          tag:=tag+1;
        end;
    end;
end;




procedure Ttoexcel.SpeedButton10Click(Sender: TObject);
begin
if ListBox8.Count<30 then
  begin
    panduant;
    ListBox8.Items.Add(ListBox7.Items.Strings[integer(ListBox7.ItemIndex)]);
    ListBox7.ItemIndex:=ListBox7.ItemIndex+1;
  end;
end;

procedure Ttoexcel.ListBox7DblClick(Sender: TObject);
begin
SpeedButton10.Click;
end;

procedure Ttoexcel.ListBox8DblClick(Sender: TObject);
begin
SpeedButton9.Click;
end;

procedure Ttoexcel.SpeedButton11Click(Sender: TObject);
begin
ListBox8.Clear;
if (ListBox7.Count<>0)and(ListBox8.Count<30) then
  begin
    ListBox7.ItemIndex:=0;
    while listBox7.Count-1<>ListBox7.ItemIndex do
      begin
        ListBox8.Items.Add(ListBox7.Items.Strings[integer(ListBox7.ItemIndex)]);
        ListBox7.ItemIndex:=ListBox7.ItemIndex+1;
      end;
      ListBox8.Items.Add(ListBox7.Items.Strings[integer(ListBox7.ItemIndex)]);
  end;
end;

procedure Ttoexcel.SpeedButton12Click(Sender: TObject);
begin
if ListBox8.Count<>0 then
  ListBox8.Clear;
  Query1.Close;
  Query1.UnPrepare;
  Query1.SQL.Clear;
  Query1.Active:=false;
end;

procedure Ttoexcel.SpeedButton9Click(Sender: TObject);
var
  itemindex:integer;
begin
if ListBox8.Count<>0 then
  begin
    itemindex:=ListBox8.ItemIndex;
    ListBox8.DeleteSelected;
    ListBox8.ItemIndex:=itemindex;
  end;
end;

procedure Ttoexcel.FormShow(Sender: TObject);
begin
mainform.dataref;
ListBox7.ItemIndex:=0;
end;

procedure Ttoexcel.SpeedButton1Click(Sender: TObject);
var
  xibiename,classname1:string;
  row,col:integer;
begin
try
if (edit2.Text<>'')and(ListBox8.Count<>0) then
  begin
    if CheckBox1.Checked=true then
      begin
        DataModule1.xibie.First;
        if edit1.Text<>'' then
          MkDir(edit2.Text+'\'+edit1.Text)
        else
          MkDir(edit2.Text+'\'+'�����ɼ���Ϣ����_����');
        while (DataModule1.xibie.RecordCount<>0)and(DataModule1.xibie.Eof<>true)do
          begin
            xibiename:=DataModule1.xibie.FieldValues['Ժϵ����'];
            if edit1.Text<>'' then
              MkDir(edit2.Text+'\'+edit1.Text+'\'+xibiename)
            else
              MkDir(edit2.Text+'\'+'�����ɼ���Ϣ����_����'+'\'+xibiename);
            DataModule1.banjixinxi.First;
            while (DataModule1.banjixinxi.RecordCount<>0)and(DataModule1.banjixinxi.Eof<>true)do
              begin
                if DataModule1.banjixinxi.FieldValues['����Ժϵ����']=xibiename then
                  begin
                    classname1:=DataModule1.banjixinxi.FieldValues['�༶����'];
                    if edit1.Text<>'' then
                      MkDir(edit2.Text+'\'+edit1.Text+'\'+xibiename+'\'+classname1)
                    else
                      MkDir(edit2.Text+'\'+'�����ɼ���Ϣ����_����'+'\'+xibiename+'\'+classname1);
                      excsql(classname1);
                    ///////////��ʼ�������ݵ�excel��//////////////////
                      col:=0;
                      ExcelApplication1.Connect;
                      ExcelApplication1.Workbooks.Add(EmptyParam,0);
                      ExcelWorkbook1.ConnectTo(ExcelApplication1.Workbooks[1]);
                      ExcelWorksheet1.ConnectTo(ExcelWorkbook1.Worksheets[1] as _worksheet);
                    while ListBox8.Count-1<>col-1 do     //////���ɵ������ı�����
                      begin
                        ExcelWorksheet1.Cells.Item[1,col+1]:=ListBox8.Items.Strings[col];
                        col:=col+1;
                      end;
                    with DBGrid1.DataSource.DataSet do
                      begin
                        First;
                        row:=2;
                        col:=0;
                        ProgressBar1.Min:=0;
                        ProgressBar1.Max:=RecordCount;
                        ProgressBar1.Position:=0;
                    while not Eof do
                      begin
                        while ListBox8.Count-1<>col-1 do
                        begin
                          ExcelWorksheet1.Cells.Item[Row,col+1]:=''''+DBGrid1.Fields[col].AsString;
                          col:=col+1;
                        end;
                        col:=0;
                        row:=row+1;
                        ProgressBar1.Position:=ProgressBar1.Position+1;
                        Next;
                      end;
                      ExcelWorksheet1.Columns.AutoFit;
                      end;
                      /////�����ļ�////
                      if edit1.Text<>'' then
                        ExcelWorksheet1.SaveAs(edit2.Text+'\'+edit1.Text+'\'+xibiename+'\'+classname1+'\'+'sport')
                      else
                        ExcelWorksheet1.SaveAs(edit2.Text+'\'+'�����ɼ���Ϣ����_����'+'\'+xibiename+'\'+classname1+'\'+'sport');
                      DBGrid1.DataSource.DataSet.First;
                      ProgressBar1.Position:=0;
                      try
                        ExcelApplication1.Quit;
                        ExcelWorksheet1.Disconnect;
                        ExcelWorkbook1.Disconnect;
                        ExcelApplication1.Disconnect;
                     Except on E: Exception do
                       ShowMessage(E.Message);
                     End;
                  end;
                DataModule1.banjixinxi.Next;
              end;
            DataModule1.banjixinxi.First;
            DataModule1.xibie.Next;
          end;
        DataModule1.xibie.First;
        Application.MessageBox('���ݵ�����ϣ�','��ʾ');
      end
    else
      begin
        if CheckBox2.Checked=true then
          begin
            if edit1.Text<>'' then
              MkDir(edit2.Text+'\'+edit1.Text)
            else
              MkDir(edit2.Text+'\'+'�����ɼ���Ϣ����_ϵ��');
            if DataModule1.banjixinxi.RecordCount<>0 then
              begin
                DataModule1.banjixinxi.First;
                if edit1.Text<>'' then
                  MkDir(edit2.Text+'\'+edit1.Text+'\'+ComboBox1.Text)
                else
                  MkDir(edit2.Text+'\'+'�����ɼ���Ϣ����_ϵ��'+'\'+ComboBox1.Text);

                while DataModule1.banjixinxi.Eof<>true do
                  begin

                    if DataModule1.banjixinxi.FieldValues['����Ժϵ����']=ComboBox1.Text then
                      begin

                             classname1:=DataModule1.banjixinxi.FieldValues['�༶����'];
                             if edit1.Text<>'' then
                               MkDir(edit2.Text+'\'+edit1.Text+'\'+ComboBox1.Text+'\'+classname1)
                             else
                               MkDir(edit2.Text+'\'+'�����ɼ���Ϣ����_ϵ��'+'\'+ComboBox1.Text+'\'+classname1);
                               excsql(classname1);
                              ///////////��ʼ�������ݵ�excel��//////////////////
                             col:=0;
                             ExcelApplication1.Connect;
                             ExcelApplication1.Workbooks.Add(EmptyParam,0);
                             ExcelWorkbook1.ConnectTo(ExcelApplication1.Workbooks[1]);
                             ExcelWorksheet1.ConnectTo(ExcelWorkbook1.Worksheets[1] as _worksheet);

                             while ListBox8.Count-1<>col-1 do     //////���ɵ������ı�����
                               begin
                                 ExcelWorksheet1.Cells.Item[1,col+1]:=ListBox8.Items.Strings[col];
                                 col:=col+1;
                               end;

                             with DBGrid1.DataSource.DataSet do
                               begin
                                 First;
                                 row:=2;
                                 col:=0;
                                 ProgressBar1.Min:=0;
                                 ProgressBar1.Max:=RecordCount;
                                 ProgressBar1.Position:=0;
                              while not Eof do
                                begin
                                  while ListBox8.Count-1<>col-1 do
                                    begin
                                      ExcelWorksheet1.Cells.Item[Row,col+1]:=''''+DBGrid1.Fields[col].AsString;
                                      col:=col+1;
                                    end;
                                  col:=0;
                                  row:=row+1;
                                  ProgressBar1.Position:=ProgressBar1.Position+1;
                                 Next;
                               end;
                               ExcelWorksheet1.Columns.AutoFit;
                             end;
                             /////�����ļ�////
                           if edit1.Text<>'' then
                             ExcelWorksheet1.SaveAs(edit2.Text+'\'+edit1.Text+'\'+ComboBox1.Text+'\'+classname1+'\'+'sport')
                           else
                             ExcelWorksheet1.SaveAs(edit2.Text+'\'+'�����ɼ���Ϣ����_ϵ��'+'\'+ComboBox1.Text+'\'+classname1+'\'+'sport');
                             DBGrid1.DataSource.DataSet.First;
                             ProgressBar1.Position:=0;

                             try
                               ExcelApplication1.Quit;
                               ExcelWorksheet1.Disconnect;
                               ExcelWorkbook1.Disconnect;
                               ExcelApplication1.Disconnect;
                             Except on E: Exception do
                               ShowMessage(E.Message);
                             End;

                      end;
                      DataModule1.banjixinxi.Next;
                    end;
                    DataModule1.banjixinxi.First;
                    Application.MessageBox('���ݵ�����ϣ�','��ʾ');
                  end;
          end
        else
          begin
            if edit1.Text<>'' then
              begin
              MkDir(edit2.Text+'\'+edit1.Text);
              MkDir(edit2.Text+'\'+edit1.Text+'\'+ComboBox1.Text);
              MkDir(edit2.Text+'\'+edit1.Text+'\'+ComboBox1.Text+'\'+ComboBox2.Text);
              end
            else
              begin
              MkDir(edit2.Text+'\'+'�����ɼ���Ϣ����_��');
              MkDir(edit2.Text+'\'+'�����ɼ���Ϣ����_��'+'\'+ComboBox1.Text);
              MkDir(edit2.Text+'\'+'�����ɼ���Ϣ����_��'+'\'+ComboBox1.Text+'\'+ComboBox2.Text);
              end;
              classname1:=ComboBox2.Text;
              excsql(classname1);
      //////////////////////////////
                             col:=0;
                             ExcelApplication1.Connect;
                             ExcelApplication1.Workbooks.Add(EmptyParam,0);
                             ExcelWorkbook1.ConnectTo(ExcelApplication1.Workbooks[1]);
                             ExcelWorksheet1.ConnectTo(ExcelWorkbook1.Worksheets[1] as _worksheet);

                             while ListBox8.Count-1<>col-1 do     //////���ɵ������ı�����
                               begin
                                 ExcelWorksheet1.Cells.Item[1,col+1]:=ListBox8.Items.Strings[col];
                                 col:=col+1;
                               end;

                             with DBGrid1.DataSource.DataSet do
                               begin
                                 First;
                                 row:=2;
                                 col:=0;
                                 ProgressBar1.Min:=0;
                                 ProgressBar1.Max:=RecordCount;
                                 ProgressBar1.Position:=0;
                              while not Eof do
                                begin
                                  while ListBox8.Count-1<>col-1 do
                                    begin
                                      ExcelWorksheet1.Cells.Item[Row,col+1]:=''''+DBGrid1.Fields[col].AsString;
                                      col:=col+1;
                                    end;
                                  col:=0;  
                                  row:=row+1;
                                  ProgressBar1.Position:=ProgressBar1.Position+1;
                                 Next;
                               end;
                               ExcelWorksheet1.Columns.AutoFit;
                             end;
                             /////�����ļ�////
                           if edit1.Text<>'' then
                             ExcelWorksheet1.SaveAs(edit2.Text+'\'+edit1.Text+'\'+ComboBox1.Text+'\'+classname1+'\'+'sport')
                           else
                             ExcelWorksheet1.SaveAs(edit2.Text+'\'+'�����ɼ���Ϣ����_��'+'\'+ComboBox1.Text+'\'+classname1+'\'+'sport');
                             DBGrid1.DataSource.DataSet.First;
                             ProgressBar1.Position:=0;

                             try
                               ExcelApplication1.Quit;
                               ExcelWorksheet1.Disconnect;
                               ExcelWorkbook1.Disconnect;
                               ExcelApplication1.Disconnect;
                             Except on E: Exception do
                               ShowMessage(E.Message);
                             End;
                    Application.MessageBox('���ݵ�����ϣ�','��ʾ');
      ////////////////////////////
          end;
      end;
  end
else
  Application.MessageBox('���������õ���ѡ�','��ʾ');
except
  ProgressBar1.Position:=0;
  Application.MessageBox('���������г��� �����ԣ�','��ʾ');
  abort;
end;
end;





procedure Ttoexcel.FormCreate(Sender: TObject);
begin
mainform.dataref;
end;

end.
