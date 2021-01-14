unit RoomInfoForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ParentForm, ADODB, DB, ImgList, Grids, DBGrids, ComCtrls,
  ToolWin, StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask;

type
  TRoomInfo = class(TParent)
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    DBCheckBox1: TDBCheckBox;
    Label12: TLabel;
    Label13: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure ComboBox2Select(Sender: TObject);
    
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    optype:string;//��ʶ�����������޸�
  end;

var
  RoomInfo: TRoomInfo;

implementation

{$R *.dfm}

procedure TRoomInfo.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  inherited;
  //���ݿͷ������ͱ����ʾ�ͷ���������
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select �������� from �ͷ����� where ���ͱ��='''+dbedit2.Text+'''');
  adoquery1.Open;
  combobox1.Text:=adoquery1.fieldbyname('��������').AsString;
   //����¥��ı����ʾ¥������
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select ¥������ from ¥����Ϣ where ¥����='''+dbedit3.Text+'''');
  adoquery1.Open;
  combobox2.Text:=adoquery1.fieldbyname('¥������').AsString;



end;
//------------��������ʱ����������ƺ�¥�����Ƶ������б����-----------------
procedure TRoomInfo.FormCreate(Sender: TObject);
begin
  inherited;
  //��ӿͷ���������������
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select distinct �������� from �ͷ�����');
  adoquery1.Open;
  combobox1.Items.Clear;
  while not adoquery1.Eof do
   begin
    combobox1.Items.Add(adoquery1.fieldbyname('��������').AsString);
    adoquery1.Next;
   end;

   //���¥������������
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select distinct ¥������ from ¥����Ϣ');
  adoquery1.Open;
  combobox2.Items.Clear;
  while not adoquery1.Eof do
   begin
    combobox2.Items.Add(adoquery1.fieldbyname('¥������').AsString);
    adoquery1.Next;
   end;
end;

//----------����ѡ��Ŀͷ��������Ʒ��鲢�޸Ŀͷ����ͱ��---------
procedure TRoomInfo.ComboBox1Select(Sender: TObject);
begin
  inherited;
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select ���ͱ�� from �ͷ����� where ��������='''+combobox1.Text+'''');
  adoquery1.Open;
  dbedit2.Text:=adoquery1.fieldbyname('���ͱ��').AsString;

end;
//----------����ѡ���¥�����Ʒ��鲢�޸�¥����---------
procedure TRoomInfo.ComboBox2Select(Sender: TObject);
begin
  inherited;
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select ¥���� from ¥����Ϣ where ¥������='''+combobox2.Text+'''');
  adoquery1.Open;
  dbedit3.Text:=adoquery1.fieldbyname('¥����').AsString;

end;

//----------����������������޸ģ�������ֶ�---------
procedure TRoomInfo.ToolButton10Click(Sender: TObject);
var
code:integer;
begin
if optype='insert' then
 begin
  if dbedit2.Text='' then
   begin
    showmessage('��������ͷ������ͱ��');
    exit;
   end;
  if dbedit3.Text='' then
    begin
     showmessage('��������ͷ�������¥��');
     exit;
    end;
   //���������¥�㣬��ѯ��¥�����󷿼��ţ����Զ������µķ�����
   adoquery1.Close;
   adoquery1.SQL.Clear;
   adoquery1.SQL.Add('select max(�ͷ����) ������󷿼�� from �ͷ���Ϣ where ¥����='''+dbedit3.Text+'''');
   adoquery1.Open;
   code:=adoquery1.FieldByName('������󷿼��').AsInteger;
   code:=code+1;
   if code mod 100>18 then//����һ�����ķ������ܴ���16
    begin
     showmessage('һ�����ֻ����16�䷿');
     toolbutton11.Click;
     exit;
    end;

   //�ܿ����Ǽɻ������13��14
   if code mod 100=13 then code:=code+2;
   if code mod 100=14 then code:=code+2;

   //�ͷ���ŵĺϳ�
   if code<999 then
     dbedit1.Text:='0'+inttostr(code)
   else
     dbedit1.Text:=inttostr(code);
 end;

  //ע�⺯���м̳е�parent��������λ�ã�������ŵ���post����
  inherited;
  //�����־
  optype:='';

end;

//------------�����ͷ���Ϣ------------------
procedure TRoomInfo.ToolButton6Click(Sender: TObject);
begin
  inherited;
  optype:='insert';//��ʾ���������������õı��水ť
  dbedit7.Text:='�շ�';

end;

//------------�޸Ŀͷ���Ϣ------------------
procedure TRoomInfo.ToolButton7Click(Sender: TObject);
begin
  inherited;
  optype:='edit';//��ʾ���������������õı��水ť

end;

//----------------ȡ������-----------------------
procedure TRoomInfo.ToolButton11Click(Sender: TObject);
begin
  inherited;
  //�����־
  optype:='';
end;

end.
