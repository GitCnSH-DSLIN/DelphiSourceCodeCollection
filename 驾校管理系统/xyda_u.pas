unit xyda_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask, DB, DBTables,
  ComCtrls, sCustomComboEdit, sTooledit, ExtDlgs,jpeg,
  ADODB;

type
  Txyda = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    DBEdit11: TDBEdit;
    Label12: TLabel;
    Label13: TLabel;
    DBEdit13: TDBEdit;
    Label14: TLabel;
    Label15: TLabel;
    DBEdit15: TDBEdit;
    Label16: TLabel;
    DBEdit16: TDBEdit;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    DBCheckBox1: TDBCheckBox;
    Label20: TLabel;
    DBCheckBox4: TDBCheckBox;
    Label21: TLabel;
    Label22: TLabel;
    DBEdit22: TDBEdit;
    Label23: TLabel;
    DBEdit23: TDBEdit;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    DBEdit32: TDBEdit;
    Label33: TLabel;
    DBEdit33: TDBEdit;
    Label34: TLabel;
    DBEdit34: TDBEdit;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    DBEdit37: TDBEdit;
    Label38: TLabel;
    DBEdit38: TDBEdit;
    Label39: TLabel;
    Label40: TLabel;
    DBEdit40: TDBEdit;
    Label41: TLabel;
    DBEdit41: TDBEdit;
    Label42: TLabel;
    DBEdit42: TDBEdit;
    Label43: TLabel;
    Label44: TLabel;
    DBEdit44: TDBEdit;
    Label45: TLabel;
    DBEdit45: TDBEdit;
    Label46: TLabel;
    DBEdit46: TDBEdit;
    Label47: TLabel;
    Label48: TLabel;
    DBEdit48: TDBEdit;
    Label49: TLabel;
    DBEdit49: TDBEdit;
    Label52: TLabel;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    Label24: TLabel;
    DBEdit24: TDBEdit;
    Label25: TLabel;
    DBEdit25: TDBEdit;
    Label26: TLabel;
    DBEdit26: TDBEdit;
    Label27: TLabel;
    DBEdit27: TDBEdit;
    Label28: TLabel;
    DBEdit28: TDBEdit;
    Label29: TLabel;
    DBEdit29: TDBEdit;
    GroupBox2: TGroupBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    GroupBox3: TGroupBox;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    DBCheckBox11: TDBCheckBox;
    DBCheckBox12: TDBCheckBox;
    DBCheckBox13: TDBCheckBox;
    DBCheckBox14: TDBCheckBox;
    DBCheckBox15: TDBCheckBox;
    Label51: TLabel;
    DBEdit50: TDBEdit;
    Label50: TLabel;
    Label53: TLabel;
    DBEdit51: TDBEdit;
    Label54: TLabel;
    Label55: TLabel;
    DBEdit53: TDBEdit;
    Label56: TLabel;
    Label57: TLabel;
    DBNavigator1: TDBNavigator;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    sDateEdit1: TsDateEdit;
    Database1: TDatabase;
    DBComboBox1: TDBComboBox;
    Table1BDEDesigner: TStringField;
    Table1BDEDesigner2: TStringField;
    Table1BDEDesigner3: TStringField;
    Table1BDEDesigner4: TDateTimeField;
    Table1BDEDesigner5: TStringField;
    Table1BDEDesigner6: TStringField;
    Table1BDEDesigner7: TStringField;
    Table1BDEDesigner8: TStringField;
    Table1BDEDesigner9: TStringField;
    Table1BDEDesigner10: TStringField;
    Table1BDEDesigner11: TStringField;
    Table1BDEDesigner12: TStringField;
    Table1BDEDesigner13: TStringField;
    Table1BDEDesigner14: TDateTimeField;
    Table1BDEDesigner15: TStringField;
    Table1BDEDesigner16: TStringField;
    Table1BDEDesigner17: TDateTimeField;
    Table1BDEDesigner18: TDateTimeField;
    Table1BDEDesigner19: TStringField;
    Table1BDEDesigner20: TBooleanField;
    Table1IC: TBooleanField;
    Table1BDEDesigner21: TBooleanField;
    Table1BDEDesigner22: TIntegerField;
    Table1BDEDesigner23: TBooleanField;
    Table1BDEDesigner24: TIntegerField;
    Table1BDEDesigner25: TFloatField;
    Table1BDEDesigner26: TFloatField;
    Table1BDEDesigner27: TIntegerField;
    Table1BDEDesigner28: TIntegerField;
    Table1BDEDesigner29: TIntegerField;
    Table1BDEDesigner30: TIntegerField;
    Table1BDEDesigner31: TIntegerField;
    Table1BDEDesigner32: TIntegerField;
    Table1BDEDesigner33: TDateTimeField;
    Table1BDEDesigner34: TDateTimeField;
    Table1BDEDesigner35: TBooleanField;
    Table1BDEDesigner36: TBooleanField;
    Table1BDEDesigner37: TBooleanField;
    Table1BDEDesigner38: TBooleanField;
    Table1BDEDesigner39: TFloatField;
    Table1BDEDesigner40: TFloatField;
    Table1BDEDesigner41: TFloatField;
    Table1BDEDesigner42: TDateTimeField;
    Table1BDEDesigner43: TStringField;
    Table1BDEDesigner44: TBooleanField;
    Table1BDEDesigner45: TBooleanField;
    Table1BDEDesigner46: TBooleanField;
    Table1BDEDesigner47: TBooleanField;
    Table1BDEDesigner48: TBooleanField;
    Table1BDEDesigner49: TBooleanField;
    Table1BDEDesigner50: TBooleanField;
    Table1BDEDesigner51: TIntegerField;
    Table1BDEDesigner52: TIntegerField;
    Table1BDEDesigner53: TDateTimeField;
    Table1BDEDesigner54: TIntegerField;
    Table1BDEDesigner55: TIntegerField;
    Table1BDEDesigner56: TIntegerField;
    Table1BDEDesigner57: TDateTimeField;
    Table1BDEDesigner58: TIntegerField;
    Table1BDEDesigner59: TIntegerField;
    Table1BDEDesigner60: TIntegerField;
    Table1BDEDesigner61: TDateTimeField;
    Table1BDEDesigner62: TIntegerField;
    Table1BDEDesigner63: TIntegerField;
    Table1BDEDesigner64: TIntegerField;
    Table1BDEDesigner66: TDateTimeField;
    Label58: TLabel;
    DBEdit3: TDBEdit;
    DBComboBox3: TDBComboBox;
    DBComboBox4: TDBComboBox;
    DBComboBox5: TDBComboBox;
    sDateEdit2: TsDateEdit;
    sDateEdit3: TsDateEdit;
    sDateEdit4: TsDateEdit;
    sDateEdit5: TsDateEdit;
    sDateEdit6: TsDateEdit;
    sDateEdit7: TsDateEdit;
    sDateEdit8: TsDateEdit;
    sDateEdit9: TsDateEdit;
    sDateEdit10: TsDateEdit;
    DBEdit52: TDBEdit;
    Table1BDEDesigner65: TBlobField;
    Table1BDEDesigner67: TStringField;
    Table2: TTable;
    DBComboBox2: TDBComboBox;
    DBComboBox6: TDBComboBox;
    DBComboBox7: TDBComboBox;
    DBComboBox8: TDBComboBox;
    Table1isbmp: TSmallintField;
    savetofile: TBitBtn;
    OpenPictureDialog1: TOpenPictureDialog;
    Image1: TImage;
    savetodb: TBitBtn;
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    Image2: TImage;
    clear_btn: TBitBtn;
    procedure Table1AfterScroll(DataSet: TDataSet);
    procedure Table1BeforePost(DataSet: TDataSet);
    procedure Table1AfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure DBComboBox1DropDown(Sender: TObject);
    procedure sDateEdit1AcceptDate(Sender: TObject; var aDate: TDateTime;
      var CanAccept: Boolean);
    procedure DBComboBox2DropDown(Sender: TObject);
    procedure DBComboBox3DropDown(Sender: TObject);
    procedure DBComboBox4DropDown(Sender: TObject);
    procedure DBComboBox5DropDown(Sender: TObject);
    procedure sDateEdit2AcceptDate(Sender: TObject; var aDate: TDateTime;
      var CanAccept: Boolean);
    procedure DBComboBox6DropDown(Sender: TObject);
    procedure DBComboBox7DropDown(Sender: TObject);
    procedure DBComboBox8DropDown(Sender: TObject);
    procedure savetofileClick(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure savetodbClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure clear_btnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure Table1BeforeInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  xyda: Txyda;
  xybh:integer;

implementation

uses jlyda_u;

{$R *.dfm}

procedure Txyda.Table1AfterScroll(DataSet: TDataSet);
var
i:string;
//locatesuccess:string;
strm:tadoblobstream;
jpegimage:tjpegimage;
bitmap:tbitmap;
begin
    if table1.FieldValues['��������']<>null then
       sdateedit1.text:=datetostr(table1.FieldValues['��������'])
    else
       sdateedit1.text:='    -  -  ';
    if table1.FieldValues['׼��֤����']<>null then
       sdateedit2.text:=datetostr(table1.FieldValues['׼��֤����'])
    else
       sdateedit2.text:='    -  -  ';
    if table1.FieldValues['����ʱ��']<>null then
       sdateedit3.text:=datetostr(table1.FieldValues['����ʱ��'])
    else
       sdateedit3.text:='    -  -  ';
    if table1.FieldValues['����ʱ��']<>null then
       sdateedit4.text:=datetostr(table1.FieldValues['����ʱ��'])
    else
       sdateedit4.text:='    -  -  ';
    if table1.FieldValues['ԤԼ��׮ʱ��']<>null then
       sdateedit5.text:=datetostr(table1.FieldValues['ԤԼ��׮ʱ��'])
    else
       sdateedit5.text:='    -  -  ';
    if table1.FieldValues['ԤԼ��·ʱ��']<>null then
       sdateedit6.text:=datetostr(table1.FieldValues['ԤԼ��·ʱ��'])
    else
       sdateedit6.text:='    -  -  ';
    if table1.FieldValues['�ڶ��θ�������']<>null then
       sdateedit7.text:=datetostr(table1.FieldValues['�ڶ��θ�������'])
    else
       sdateedit7.text:='    -  -  ';
    if table1.FieldValues['��Ŀһʱ��']<>null then
       sdateedit8.text:=datetostr(table1.FieldValues['��Ŀһʱ��'])
    else
       sdateedit8.text:='    -  -  ';
    if table1.FieldValues['��Ŀ��ʱ��']<>null then
       sdateedit9.text:=datetostr(table1.FieldValues['��Ŀ��ʱ��'])
    else
       sdateedit9.text:='    -  -  ';
    if table1.FieldValues['��Ŀ��ʱ��']<>null then
       sdateedit10.text:=datetostr(table1.FieldValues['��Ŀ��ʱ��'])
    else
       sdateedit10.text:='    -  -  ';
  i:= table1.Fieldbyname('ѧ��').AsString;
  adotable1.Open;
  adotable1.Locate('ѧ��',i,[loCaseInsensitive]);
///������ʾ������������paradox�е�graphic�ֶε���ʾ��
  strm:= tadoblobstream.Create(tblobfield(adotable1.fieldbyname('��Ƭ')),bmread);
  try    //try1
  strm.position :=0;
  image1.Picture.Graphic:= nil;
  //DBIMAGE1.DataField := '';
  //��ʾʱ��BMP��JPEG����ͼ�����ݱ���ֱ���
  if adotable1.fieldbyname('isbmp').asstring ='1' then
    begin    //begin11
    bitmap := tbitmap.Create ;
    try     //try11
    bitmap.LoadFromStream(strm);
    image1.Picture.Graphic := bitmap;
    //DBIMAGE1.DataField := '��Ƭ';
    finally
    bitmap.Free;
    end;    //end try11
    end     //end begin11
    else if adotable1.fieldbyname('isbmp').asstring ='0' then
    begin   //begin12
    jpegimage := tjpegimage.Create ;
    try     //try12
    jpegimage.LoadFromStream(strm);
    image1.Picture.Graphic := jpegimage;
    finally
    jpegimage.Free ;
    end;    //end try12
    end;    //end begin12
  finally
  strm.Free ;
  end;     //end try1
end;

procedure Txyda.Table1BeforePost(DataSet: TDataSet);
begin
     if sdateedit1.text<>'    -  -  ' then
        table1.FieldValues['��������']:=strtodate(sdateedit1.text);
     if sdateedit2.text<>'    -  -  ' then
        table1.FieldValues['׼��֤����']:=strtodate(sdateedit2.text);
     if sdateedit3.text<>'    -  -  ' then
        table1.FieldValues['����ʱ��']:=strtodate(sdateedit3.text);
     if sdateedit4.text<>'    -  -  ' then
        table1.FieldValues['����ʱ��']:=strtodate(sdateedit4.text);
     if sdateedit5.text<>'    -  -  ' then
        table1.FieldValues['ԤԼ��׮ʱ��']:=strtodate(sdateedit5.text);
     if sdateedit6.text<>'    -  -  ' then
        table1.FieldValues['ԤԼ��·ʱ��']:=strtodate(sdateedit6.text);
     if sdateedit7.text<>'    -  -  ' then
        table1.FieldValues['�ڶ��θ�������']:=strtodate(sdateedit7.text);
     if sdateedit8.text<>'    -  -  ' then
        table1.FieldValues['��Ŀһʱ��']:=strtodate(sdateedit8.text);
     if sdateedit9.text<>'    -  -  ' then
        table1.FieldValues['��Ŀ��ʱ��']:=strtodate(sdateedit9.text);
     if sdateedit10.text<>'    -  -  ' then
        table1.FieldValues['��Ŀ��ʱ��']:=strtodate(sdateedit10.text);

     table1.FieldValues['�Ƿ���Ч']:=DBCheckBox1.Checked;
     table1.FieldValues['IC��']:=DBCheckBox2.checked;
     table1.FieldValues['���ٱ���']:=dbcheckbox3.Checked;
     table1.FieldValues['��ǿ�Գ�ѵ']:=dbcheckbox4.Checked;
     table1.FieldValues['��ʳ��']:=dbcheckbox5.Checked;
     table1.FieldValues['�ϳ���ʳ��']:=dbcheckbox6.Checked;
     table1.FieldValues['������']:=dbcheckbox7.Checked;
     table1.FieldValues['�����']:=dbcheckbox8.Checked;
     table1.FieldValues['����ѵ��']:=dbcheckbox9.Checked;
     table1.FieldValues['�ڼ���ѵ��']:=dbcheckbox10.Checked;
     table1.FieldValues['��ʱѵ��']:=dbcheckbox11.Checked;
     table1.FieldValues['ҹѵ']:=dbcheckbox12.Checked;
     table1.FieldValues['ֻҪ���ղ�Ҫ����']:=dbcheckbox13.Checked;
     table1.FieldValues['��Ҫ������Ҫ����']:=dbcheckbox14.Checked;
     table1.FieldValues['ֻҪ������Ҫ����']:=dbcheckbox15.Checked;
end;

procedure Txyda.Table1BeforeInsert(DataSet: TDataSet);
begin
     table1.DisableControls; //��ֹ�ؼ����ƶ���¼ʱˢ��
     table1.Last;
     table1.Edit;
     xybh:=table1.Fieldbyname('ѧ��').AsInteger+1;
     table1.EnableControls;
end;

procedure Txyda.Table1AfterInsert(DataSet: TDataSet);
begin
     //table1.FieldValues['ѧ��']:=inttostr(i);
     dbedit1.Text:=inttostr(xybh);
     //dbedit1.Text:=formatfloat('100000',xybh); //����6λѧ��
     Dbedit2.setfocus;
     DBCheckBox1.Checked:=false;
     DBCheckBox2.Checked:=false;
     DBCheckBox3.Checked:=false;
     DBCheckBox4.Checked:=false;
     DBCheckBox5.Checked:=false;
     DBCheckBox6.Checked:=false;
     DBCheckBox7.Checked:=false;
     DBCheckBox8.Checked:=false;
     DBCheckBox9.checked:=false;
     DBCheckBox10.Checked:=false;
     DBCheckBox11.Checked:=false;
     DBCheckBox12.Checked:=false;
     DBCheckBox13.Checked:=false;
     DBCheckBox14.Checked:=false;
     DBCheckBox15.Checked:=false;
     sdateedit1.text:='    -  -  ';
     dbedit52.Text:=datetostr(now);
end;

procedure Txyda.FormCreate(Sender: TObject);
begin
  table1.Close;
  table1.Open;
  table2.Close;
  table2.Open;
  adoconnection1.Connected := true;
  adoconnection1.LoginPrompt := false;
  adotable1.Open;
end;

procedure Txyda.DBComboBox1DropDown(Sender: TObject);
begin
    with dbcombobox1 do
     begin
     if Items.Count<=0 then
        begin
          Items.Add('��');
          Items.Add('Ů');
        end;
     end;
end;

procedure Txyda.sDateEdit1AcceptDate(Sender: TObject;
  var aDate: TDateTime; var CanAccept: Boolean);
begin
  table1.Edit;
end;

procedure Txyda.DBComboBox2DropDown(Sender: TObject);
var
   i:string;
begin
  if dbcombobox2.Items.Count<=0 then
   begin
    with dbcombobox2 do
     begin
     table2.First;
     //while table2.FieldValues['ѧԱ״̬']<>null and (not table2.Eof) do
     while not table2.Eof and (table2.FieldValues['ѧԱ״̬']<>null) do
        begin
          i:=table2.FieldValues['ѧԱ״̬'];
          Items.Add(i);
          table2.Next;

        end;
     end;
  end;
end;

procedure Txyda.DBComboBox3DropDown(Sender: TObject);
var
   i:string;
begin
  if dbcombobox3.Items.Count<=0 then
   begin
    with dbcombobox3 do
     begin
     table2.First;
     while (table2.FieldValues['ѧϰ����']<>null) and (not table2.Eof) do
        begin
          i:=table2.FieldValues['ѧϰ����'];
          Items.Add(i);
          table2.Next;
        end;
     end;
  end;
end;

procedure Txyda.DBComboBox4DropDown(Sender: TObject);
var
   i:string;
begin
  if dbcombobox4.Items.Count<=0 then
   begin
    with dbcombobox4 do
     begin
     table2.First;
     while (table2.FieldValues['ԭ��֤��']<>null) and (not table2.Eof) do
        begin
          i:=table2.FieldValues['ԭ��֤��'];
          Items.Add(i);
          table2.Next;
        end;
     end;
  end;
end;

procedure Txyda.DBComboBox5DropDown(Sender: TObject);
var
   i:string;
begin
  if dbcombobox5.Items.Count<=0 then
   begin
    with dbcombobox5 do
     begin
     table2.First;
     while (table2.FieldValues['ѧ��״̬']<>null) and (not table2.Eof) do
        begin
          i:=table2.FieldValues['ѧ��״̬'];
          Items.Add(i);
          table2.Next;
        end;
     end;
  end;
end;

procedure Txyda.DBComboBox6DropDown(Sender: TObject);
var
   i:string;
begin
  if dbcombobox6.Items.Count<=0 then
   begin
    with dbcombobox6 do
     begin
     table2.First;
     while (table2.FieldValues['������']<>null) and (not table2.Eof) do
        begin
          i:=table2.FieldValues['������'];
          Items.Add(i);
          table2.Next;
        end;
     end;
  end;
end;

procedure Txyda.DBComboBox7DropDown(Sender: TObject);
var
   i:string;
begin
  if dbcombobox7.Items.Count<=0 then
   begin
    with dbcombobox7 do
     begin
     table2.First;
     while (table2.FieldValues['��׼�Գ�ѵ']<>null) and (not table2.Eof) do
        begin
          i:=table2.FieldValues['��׼�Գ�ѵ'];
          Items.Add(i);
          table2.Next;
        end;
     end;
  end;
end;

procedure Txyda.DBComboBox8DropDown(Sender: TObject);
var
   i:string;
begin
  if dbcombobox8.Items.Count<=0 then
   begin
    with dbcombobox8 do
     begin
     table2.First;
     while (table2.FieldValues['��ѵ']<>null) and (not table2.Eof) do
        begin
          i:=table2.FieldValues['��ѵ'];
          Items.Add(i);
          table2.Next;
        end;
     end;
  end;
end;

procedure Txyda.sDateEdit2AcceptDate(Sender: TObject;
  var aDate: TDateTime; var CanAccept: Boolean);
begin
  table1.Edit;
end;

////��ʾʱ�����bmp and jpeg ������������������ͳһ��
procedure Txyda.savetofileClick(Sender: TObject);
var
  tmpstr:string;
begin
   if image1.Picture.Graphic <> nil then
   begin
   tmpstr := openpicturedialog1.Filter;
   if adotable1.fieldbyname('isbmp').asstring ='1' then
   begin
   openpicturedialog1.Filter := 'Bitmaps (*.bmp)|*.bmp';
   if openpicturedialog1.Execute then
  image1.Picture.SaveToFile(openpicturedialog1.FileName+'.bmp');
  end
  else
  begin
   openpicturedialog1.Filter := 'JPEG Image File (*.jpg)|*.jpg';
   if openpicturedialog1.Execute then
  image1.Picture.SaveToFile(openpicturedialog1.FileName+'.jpg');
  end;
  openpicturedialog1.Filter := tmpstr;
  end;
end;

procedure Txyda.Image1DblClick(Sender: TObject);
begin
 if openpicturedialog1.Execute then
   image1.Picture.LoadFromFile(openpicturedialog1.FileName );
end;

 ////���±��淽��only to sql and access'data
procedure Txyda.savetodbClick(Sender: TObject);  //����ͼ��
var
  strm:tmemorystream;
  ext:string;
begin
   if image1.picture.Graphic <> nil then  //����image1����ͼ�񱣴����
   begin
   ext:=extractfileext(openpicturedialog1.FileName );
   strm := tmemorystream.Create ;
   try
   image1.Picture.Graphic.SaveToStream(strm);
   adotable1.Edit ;
   strm.Position :=0;
   //DBImage1.dataField :='';  //dbimageֻ����ʾBMP��������Ƭ��BMP��Ϊjpegʱ�����
   tblobfield(adotable1.FieldByName('��Ƭ')).LoadFromStream(strm);
   //����ֱ�����ļ����� TBlobField(adotable1.FieldByName('��Ƭ')).LoadFromFile(OpenPictureDialog1.FileName);
   //���¼�¼���浽���ݿ��ͼ���ʽ
   if uppercase(ext) = '.BMP' then
   begin
   adotable1.FieldByName('isbmp').Value := 1;
   //dbimage1.dataField := '��Ƭ';
   end
   else if (uppercase(ext) = '.JPG') OR ( uppercase(ext) = '.JPEG') THEN
   adotable1.FieldByName('isbmp').Value := 0;
   adotable1.Post ;
   finally
   strm.Free ; //�����ѡ��TBLOBSTREAM��,�������е�����������ɸ����ǰ����adotable1.edit
   end;
   end;

end;

procedure Txyda.Button1Click(Sender: TObject);
begin
  image1.Picture.Graphic := nil;
end;

procedure Txyda.clear_btnClick(Sender: TObject);
begin
    image1.Picture.Graphic:= nil;
end;

procedure Txyda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    self.Destroy;
end;

procedure Txyda.BitBtn2Click(Sender: TObject);
begin
  self.Close;
end;

end.
