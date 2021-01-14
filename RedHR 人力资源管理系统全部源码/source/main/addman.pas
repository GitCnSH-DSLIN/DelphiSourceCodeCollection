unit addman;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, DB, ADODB, dxdbtrel, ExtCtrls;

type
  Tfaddman = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label6: TLabel;
    ComboBox2: TComboBox;
    TabSheet4: TTabSheet;
    Label7: TLabel;
    ComboBox3: TComboBox;
    Label8: TLabel;
    Edit4: TEdit;
    Label9: TLabel;
    Edit5: TEdit;
    GroupBox2: TGroupBox;
    Label10: TLabel;
    ComboBox4: TComboBox;
    Label11: TLabel;
    Edit6: TEdit;
    Label12: TLabel;
    ComboBox5: TComboBox;
    Label13: TLabel;
    ComboBox6: TComboBox;
    GroupBox3: TGroupBox;
    Label14: TLabel;
    DateTimePicker2: TDateTimePicker;
    Label15: TLabel;
    DataSource1: TDataSource;
    cxLookupComboBox1: TcxLookupComboBox;
    Memo1: TMemo;
    ADOTable1: TADOTable;
    GroupBox4: TGroupBox;
    Label16: TLabel;
    Edit7: TEdit;
    Label17: TLabel;
    Edit8: TEdit;
    GroupBox5: TGroupBox;
    Label18: TLabel;
    Edit9: TEdit;
    Label19: TLabel;
    Edit10: TEdit;
    Label20: TLabel;
    Edit11: TEdit;
    Label21: TLabel;
    dxLookupTreeView1: TdxLookupTreeView;
    Label22: TLabel;
    DateTimePicker3: TDateTimePicker;
    Label23: TLabel;
    Edit12: TEdit;
    Image1: TImage;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    etype:integer;      //1.����  2.�༭
    bmchange:integer;   //ԭ����ID
    bmname:string;      //ԭ��������
  end;

var
  faddman: Tfaddman;

implementation

uses fmain;

{$R *.dfm}

procedure Tfaddman.Button2Click(Sender: TObject);
begin
  close
end;

procedure Tfaddman.FormShow(Sender: TObject);
begin
  self.Edit1.SetFocus;
end;

procedure Tfaddman.FormCreate(Sender: TObject);
begin
  self.DateTimePicker2.Date:=now;
  self.DateTimePicker3.Date:=now;
end;

procedure Tfaddman.Button1Click(Sender: TObject);
var tmpid:string;
begin
  if trim(self.Edit1.Text)='' then
    begin
      MessageBox(handle,'���Ƿ���������ְ��������','����',MB_ICONERROR or MB_OK);
      self.PageControl1.ActivePageIndex:=0;
      self.Edit1.SetFocus;
      exit;
    end;
  if trim(self.Edit3.Text)='' then
    begin
      MessageBox(handle,'���֤���벻��Ϊ�գ�','����',MB_ICONERROR or MB_OK);
      self.PageControl1.ActivePageIndex:=0;
      self.Edit3.SetFocus;
      exit;
    end;
  if trim(self.cxLookupComboBox1.Text)='' then
    begin
      MessageBox(handle,'��ѡ��ְ�����ͣ�','����',MB_ICONERROR or MB_OK);
      self.PageControl1.ActivePageIndex:=1;
      self.cxLookupComboBox1.SetFocus;
      exit;
    end;
  if trim(self.dxLookupTreeView1.Text)='' then
    begin
      MessageBox(handle,'��ѡ�����ڲ��ţ�','����',MB_ICONERROR or MB_OK);
      self.PageControl1.ActivePageIndex:=1;
      self.dxLookupTreeView1.SetFocus;
      exit;
    end;
  if self.etype=1 then  //..����
    begin
      self.ADOTable1.Close;
      self.ADOTable1.Open;
      self.ADOTable1.Append;
      self.ADOTable1.FieldByName('name').AsString:=self.Edit1.Text;                     //����
      self.ADOTable1.FieldByName('sex').AsString:=self.ComboBox1.Text;                  //�Ա�
      self.ADOTable1.FieldByName('ename').AsString:=self.Edit2.Text;                    //Ӣ����
      self.ADOTable1.FieldByName('idnum').AsString:=self.Edit3.Text;                    //���֤����
      self.ADOTable1.FieldByName('ifmarriage').AsString:=self.ComboBox2.Text;           //���
      self.ADOTable1.FieldByName('birthday').AsDateTime:=self.DateTimePicker1.Date;     //����
      self.ADOTable1.FieldByName('Nationality').AsString:=self.ComboBox3.Text;          //����
      self.ADOTable1.FieldByName('Nativeplace').AsString:=self.Edit4.Text;              //����
      self.ADOTable1.FieldByName('Residence').AsString:=self.Edit5.Text;                //�������ڵ�
      self.ADOTable1.FieldByName('knowledge').AsString:=self.ComboBox4.Text;            //ѧ��
      self.ADOTable1.FieldByName('School').AsString:=self.Edit6.Text;                   //��ҵԺУ
      self.ADOTable1.FieldByName('forlang').AsString:=self.ComboBox5.Text;              //��������
      self.ADOTable1.FieldByName('howforlang').AsString:=self.ComboBox6.Text;           //�����̶�
      self.ADOTable1.FieldByName('intime').AsDateTime:=self.DateTimePicker2.Date;       //��ְ����
      self.ADOTable1.FieldByName('exigenceman').AsString:=self.Edit7.Text;              //������ϵ��
      self.ADOTable1.FieldByName('exigencephone').AsString:=self.Edit8.Text;            //������ϵ�绰����
      self.ADOTable1.FieldByName('Telephone').AsString:=self.Edit9.Text;//��ϵ�绰
      self.ADOTable1.FieldByName('Address').AsString:=self.Edit10.Text;//ͨѶ��ַ
      self.ADOTable1.FieldByName('Email').AsString:=self.Edit11.Text;//�����ʼ�
      self.ADOTable1.FieldByName('branchid').AsInteger:=self.dxLookupTreeView1.ListSource.DataSet.fieldbyname('id').AsInteger;//���ڲ���
      self.ADOTable1.FieldByName('imemo').AsVariant:=self.Memo1.Lines.Text;//��ע
      self.ADOTable1.FieldByName('classcodeID').AsInteger:=self.cxLookupComboBox1.EditValue;//ְ�����
      self.ADOTable1.FieldByName('delrecy').AsString:='0';  //ɾ�����
      self.ADOTable1.FieldByName('staffid').AsString:=self.Edit12.Text;
      self.ADOTable1.Post;
      tmpid:=self.ADOTable1.fieldbyname('id').AsString;
          self.ADOTable1.Close;
          self.ADOTable1.TableName:='r_staffbranchedit';
          self.ADOTable1.IndexName:='id';
          self.ADOTable1.Open;
          self.ADOTable1.Append;
          self.ADOTable1.FieldByName('staffid').AsString:=tmpid;
          self.ADOTable1.FieldByName('indate').AsDateTime:=self.DateTimePicker3.Date;
          self.ADOTable1.FieldByName('branchid').AsInteger:=self.dxLookupTreeView1.ListSource.DataSet.fieldbyname('id').AsInteger;
          self.ADOTable1.Post;
    end;
  if self.etype>=2 then  //..�༭
    begin
      tmpid:= main.staffinfo.fieldbyname('r_staffinfo.id').AsString;
      if self.etype=3 then tmpid:= main.Noset.fieldbyname('id').AsString;
      self.ADOTable1.Close;
      self.ADOTable1.Filtered:=false;
      self.ADOTable1.Filter:=format('id'+'='+'''%s''',[tmpid]);
      self.ADOTable1.Filtered:=true;
      self.ADOTable1.Open;
      self.ADOTable1.Edit; 
      self.ADOTable1.FieldByName('name').AsString:=self.Edit1.Text;                     //����
      self.ADOTable1.FieldByName('sex').AsString:=self.ComboBox1.Text;                  //�Ա�
      self.ADOTable1.FieldByName('ename').AsString:=self.Edit2.Text;                    //Ӣ����
      self.ADOTable1.FieldByName('idnum').AsString:=self.Edit3.Text;                    //���֤����
      self.ADOTable1.FieldByName('ifmarriage').AsString:=self.ComboBox2.Text;           //���
      self.ADOTable1.FieldByName('birthday').AsDateTime:=self.DateTimePicker1.Date;     //����
      self.ADOTable1.FieldByName('Nationality').AsString:=self.ComboBox3.Text;          //����
      self.ADOTable1.FieldByName('Nativeplace').AsString:=self.Edit4.Text;              //����
      self.ADOTable1.FieldByName('Residence').AsString:=self.Edit5.Text;                //�������ڵ�
      self.ADOTable1.FieldByName('knowledge').AsString:=self.ComboBox4.Text;            //ѧ��
      self.ADOTable1.FieldByName('School').AsString:=self.Edit6.Text;                   //��ҵԺУ
      self.ADOTable1.FieldByName('forlang').AsString:=self.ComboBox5.Text;              //��������
      self.ADOTable1.FieldByName('howforlang').AsString:=self.ComboBox6.Text;           //�����̶�
      self.ADOTable1.FieldByName('intime').AsDateTime:=self.DateTimePicker2.Date;       //��ְ����
      self.ADOTable1.FieldByName('exigenceman').AsString:=self.Edit7.Text;              //������ϵ��
      self.ADOTable1.FieldByName('exigencephone').AsString:=self.Edit8.Text;            //������ϵ�绰����
      self.ADOTable1.FieldByName('Telephone').AsString:=self.Edit9.Text;//��ϵ�绰
      self.ADOTable1.FieldByName('Address').AsString:=self.Edit10.Text;//ͨѶ��ַ
      self.ADOTable1.FieldByName('Email').AsString:=self.Edit11.Text;//�����ʼ�
      self.ADOTable1.FieldByName('branchid').AsInteger:=self.dxLookupTreeView1.ListSource.DataSet.fieldbyname('id').AsInteger;//���ڲ���
      self.ADOTable1.FieldByName('imemo').AsVariant:=self.Memo1.Lines.Text;//��ע
      self.ADOTable1.FieldByName('classcodeID').AsInteger:=self.cxLookupComboBox1.EditValue;//ְ�����
      self.ADOTable1.FieldByName('staffid').AsString:=self.Edit12.Text;
      self.ADOTable1.Post;
      //----------����Ϊ�鿴�Ƿ��в��ű䶯------------//
      if (self.bmchange<>self.dxLookupTreeView1.ListSource.DataSet.fieldbyname('id').AsInteger) or (self.bmname<>self.dxLookupTreeView1.Text) then
        begin
          self.ADOTable1.Close;
          self.ADOTable1.TableName:='r_staffbranchedit';
          self.ADOTable1.IndexName:='id';
          self.ADOTable1.Open;
          self.ADOTable1.Append;
          self.ADOTable1.FieldByName('staffid').AsString:=tmpid;
          self.ADOTable1.FieldByName('indate').AsDateTime:=self.DateTimePicker3.Date;
          self.ADOTable1.FieldByName('branchid').AsInteger:=self.dxLookupTreeView1.ListSource.DataSet.fieldbyname('id').AsInteger;
          self.ADOTable1.Post;
        end;
    end;
  self.Close;
end;

procedure Tfaddman.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
if not (Key in ['0'..'9', DecimalSeparator,#8]) then
  begin
    key:=#0;     // ǿ��������ַ�����
    beep;
  end;
end;

end.
