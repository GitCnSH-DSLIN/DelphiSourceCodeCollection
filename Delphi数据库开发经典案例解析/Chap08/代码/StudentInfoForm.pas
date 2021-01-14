unit StudentInfoForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ParentForm, ADODB, DB, ImgList, Grids, DBGrids, ComCtrls,
  ToolWin, StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask;

type
  TStudentInfo = class(TParent)
    Label9: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label15: TLabel;
    Label14: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    DBEdit4: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit1: TDBEdit;
    DBComboBox1: TDBComboBox;
    DBEdit3: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure ComboBox2Select(Sender: TObject);
    procedure ComboBox3Select(Sender: TObject);
    procedure ComboBox4Select(Sender: TObject);
    procedure ComboBox5Select(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure setlist(fieldname,tablename:string;combo:Tcombobox);//���������б���ֵ�
  end;

var
  StudentInfo: TStudentInfo;

implementation

{$R *.dfm}
//-------------����ѧ����Ϣ���еı�ţ���ʾ�������Ӧ����Ϣ -------------
procedure TStudentInfo.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  //�������ݱ��еİ༶��ţ���ʾ�༶����
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select �༶���� from �༶��Ϣ where �༶���='''+dbedit5.Text+'''');
  adoquery1.Open;
  combobox1.Text:=trim(adoquery1.fieldbyname('�༶����').AsString);

  //����ʾ������ò
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select ������ò from ������ò����� where ������ò���='''+dbedit6.Text+'''');
  adoquery1.Open;
  combobox2.Text:=trim(adoquery1.fieldbyname('������ò').AsString);

  //��ʾ����
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select ���� from �������� where ������='''+dbedit7.Text+'''');
  adoquery1.Open;
  combobox3.Text:=trim(adoquery1.fieldbyname('����').AsString);

  //��ʾ����
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select ���� from �������� where ������='''+dbedit8.Text+'''');
  adoquery1.Open;
  combobox4.Text:=trim(adoquery1.fieldbyname('����').AsString);

  //��ʾѧ��
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select ѧ������ from ѧ������� where ѧ�����='''+dbedit9.Text+'''');
  adoquery1.Open;
  combobox5.Text:=trim(adoquery1.fieldbyname('ѧ������').AsString);


end;

//--------------���������ѯ�ֶΣ��������ƶ������б�������ѡ��-------------------
procedure TStudentInfo.setlist(fieldname,tablename: string; combo: Tcombobox);
begin
adoquery1.Close;
adoquery1.SQL.Clear;
adoquery1.SQL.Add('select distinct '+fieldname+' from '+tablename);
adoquery1.Open;
combo.Items.Clear;
while not adoquery1.Eof do
 begin
  combo.Items.Add(trim(adoquery1.fieldbyname(fieldname).AsString));
  adoquery1.Next;
 end;


end;

//-----������ʾʱ�����ø��������б�������ʵ�----------
procedure TStudentInfo.FormShow(Sender: TObject);
begin

  inherited;
  setlist('�༶����','�༶��Ϣ',combobox1);
  setlist('������ò','������ò�����',combobox2);
  setlist('����','��������',combobox3);
  setlist('����','��������',combobox4);
  setlist('ѧ������','ѧ�������',combobox5);
end;


//---------����5���������Ǹ���ѡ����ֶ������޸����ݱ��еĶ�Ӧ���-----------
procedure TStudentInfo.ComboBox1Select(Sender: TObject);
begin
  inherited;
   //����ѡ��İ༶���ƣ��޸İ༶���
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select �༶��� from �༶��Ϣ where �༶����='''+combobox1.Text+'''');
  adoquery1.Open;
  dbedit5.Text:=trim(adoquery1.fieldbyname('�༶���').AsString);
end;

procedure TStudentInfo.ComboBox2Select(Sender: TObject);
begin
  inherited;
   //����ѡ���������ò���ƣ��޸�������ò����
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select ������ò��� from ������ò����� where ������ò='''+combobox2.Text+'''');
  adoquery1.Open;
  dbedit6.Text:=trim(adoquery1.fieldbyname('������ò���').AsString);
end;

procedure TStudentInfo.ComboBox3Select(Sender: TObject);
begin
  inherited;
   //����ѡ����������ƣ��޸�������
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select ������ from �������� where ����='''+combobox3.Text+'''');
  adoquery1.Open;
  dbedit7.Text:=trim(adoquery1.fieldbyname('������').AsString);
end;

procedure TStudentInfo.ComboBox4Select(Sender: TObject);
begin
  inherited;
   //����ѡ��ļ������ƣ��޸ļ�����
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select ������ from �������� where ����='''+combobox4.Text+'''');
  adoquery1.Open;
  dbedit8.Text:=trim(adoquery1.fieldbyname('������').AsString);
end;

procedure TStudentInfo.ComboBox5Select(Sender: TObject);
begin
  inherited;
   //����ѡ���ѧ�����ƣ��޸�ѧ�����
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select ѧ����� from ѧ������� where ѧ������='''+combobox5.Text+'''');
  adoquery1.Open;
  dbedit9.Text:=trim(adoquery1.fieldbyname('ѧ�����').AsString);
end;

end.
