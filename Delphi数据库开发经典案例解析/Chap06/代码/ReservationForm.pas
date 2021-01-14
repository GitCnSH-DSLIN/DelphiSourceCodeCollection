unit ReservationForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ParentForm, ADODB, DB, ImgList, Grids, DBGrids, ComCtrls,
  ToolWin, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  TReservation = class(TParent)
    Label9: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    DBEdit6: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit1: TDBEdit;
    ComboBox1: TComboBox;
    Label8: TLabel;
    Label14: TLabel;
    DBEdit7: TDBEdit;
    Label15: TLabel;
    Label16: TLabel;
    DBEdit8: TDBEdit;
    Label17: TLabel;
    DBEdit9: TDBEdit;
    Label13: TLabel;
    DBEdit10: TDBEdit;
    Label18: TLabel;
    DBEdit11: TDBEdit;
    Label19: TLabel;
    DBEdit12: TDBEdit;
    Label20: TLabel;
    DBEdit13: TDBEdit;
    Label21: TLabel;
    DBEdit14: TDBEdit;
    Label22: TLabel;
    DBEdit15: TDBEdit;
    Label23: TLabel;
    DBEdit16: TDBEdit;
    Label24: TLabel;
    DBEdit17: TDBEdit;
    Label25: TLabel;
    Label26: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBComboBox1: TDBComboBox;
    DBComboBox2: TDBComboBox;
    BitBtn2: TBitBtn;
    MonthCalendar1: TMonthCalendar;
    ADOCommand1: TADOCommand;
    DBEdit18: TDBEdit;
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    
    procedure ComboBox1Select(Sender: TObject);
    procedure MonthCalendar1DblClick(Sender: TObject);
    procedure DBComboBox1DropDown(Sender: TObject);
    procedure DBComboBox2DropDown(Sender: TObject);
    procedure DBComboBox1Exit(Sender: TObject);
    procedure DBComboBox2Exit(Sender: TObject);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
   
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Reservation: TReservation;

implementation

{$R *.dfm}
uses RoomStatusForm,MainForm;

//----------������ʾʱ�������������Ƶ������б�ѡ��-------------
procedure TReservation.FormCreate(Sender: TObject);
begin
  inherited;
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select distinct �������� from �ͷ�����');
  adoquery1.Open;
  combobox1.Items.Clear;
  while not adoquery1.Eof do
   begin
    combobox1.Items.Add(adoquery1.fieldbyname('��������').AsString);
    adoquery1.Next
   end;
end;

//----------------���ñ���Ⱥ���ʾ�ͷ���������--------------------
procedure TReservation.DataSource1DataChange(Sender: TObject;
  Field: TField);
var
 i:integer;
begin
  inherited;
  //���ݿͷ������ͱ����ʾ�ͷ���������
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select �������� from �ͷ����� where ���ͱ��='''+dbedit2.Text+'''');
  adoquery1.Open;
  combobox1.Text:=adoquery1.fieldbyname('��������').AsString;

  //���ñ����
  dbgrid1.Columns[0].Width:=100;
  for i:=1 to 20 do
   dbgrid1.Columns[i].Width:=64;
end;


//----------����ѡ��Ŀͷ��������Ʒ��鲢�޸Ŀͷ����ͱ��---------
procedure TReservation.ComboBox1Select(Sender: TObject);
begin
  inherited;
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select ���ͱ�� from �ͷ����� where ��������='''+combobox1.Text+'''');
  adoquery1.Open;
  dbedit2.Text:=adoquery1.fieldbyname('���ͱ��').AsString;
end;

//-------------------------------------------------------------
//------------���´��봦��ֵ�ʱ������ʱ����������ʾ------
procedure TReservation.MonthCalendar1DblClick(Sender: TObject);
begin
  inherited;
  //���ݵ����������б����ȷ����ѡ���ʱ�����뵽�Ǹ��б����
  if dbcombobox1.Focused then
    dbcombobox1.SelText:=datetostr(monthcalendar1.Date);
  if dbcombobox2.Focused then
    dbcombobox2.SelText:=datetostr(monthcalendar1.Date);
    monthcalendar1.Visible:=false;
end;

procedure TReservation.DBComboBox1DropDown(Sender: TObject);
begin
  inherited;
  //�������ı����е�ʱ�丳������
  if dbcombobox1.Text<>'' then
    monthcalendar1.Date:=strtodate(dbcombobox1.Text);
  //ȷ��������ʾ��λ��
    monthcalendar1.Top:=dbcombobox1.Top+panel2.Top-monthcalendar1.Height;
    monthcalendar1.Left:=dbcombobox1.Left;
    monthcalendar1.Visible:=true;
end;

procedure TReservation.DBComboBox2DropDown(Sender: TObject);
begin
  inherited;
    //�������ı����е�ʱ�丳������
    if dbcombobox2.Text<>'' then
    monthcalendar1.Date:=strtodate(dbcombobox2.Text);
    //ȷ��������ʾ��λ��
    monthcalendar1.Top:=dbcombobox2.Top+panel2.Top-monthcalendar1.Height;
    monthcalendar1.Left:=dbcombobox2.Left;
    monthcalendar1.Visible:=true;
end;

procedure TReservation.DBComboBox1Exit(Sender: TObject);
begin
  inherited;
  monthcalendar1.Visible:=false;
end;

procedure TReservation.DBComboBox2Exit(Sender: TObject);
begin
  inherited;
  monthcalendar1.Visible:=false;
end;
//-----------------------------------------------------------

//--------------------�༭ʱ��ֻ��ѡ���˼Ӵ���������Ӵ��۸�-------------------------
procedure TReservation.DBCheckBox1Click(Sender: TObject);
begin
  inherited;
  if dbcheckbox1.Checked then
   dbedit10.Enabled:=true
   else
   dbedit10.Enabled:=false;
end;

//--------------����Ԥ����-------------------------
procedure TReservation.ToolButton6Click(Sender: TObject);
var
  maxnum,num:string;
  newnum:integer;
begin
  inherited;
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select max(Ԥ������) ����� from Ԥ����');
  adoquery1.Open;
  maxnum:=trim(adoquery1.fieldbyname('�����').AsString);
  if maxnum='' then maxnum:='YD0';
  //��Ԥ����ǰ���YD������ĸɾ����תΪ����
  Delete(maxnum,1,2);
  newnum:=strtoint(maxnum)+1;
  //���±�Ų������µ�Ԥ������
  if length(inttostr(newnum))=1 then num:='YD0000000'+inttostr(newnum);
  if length(inttostr(newnum))=2 then num:='YD000000'+inttostr(newnum);
  if length(inttostr(newnum))=3 then num:='YD00000'+inttostr(newnum);
  //��������������Ĭ��ֵ
  dbedit1.Text:=num;
  dbcombobox1.SelText:=datetostr(date);
  dbcombobox2.SelText:=datetostr(date);
  dbedit12.Text:='Ԥ��';
  dbedit13.Text:=' ';
end;

//-----------ѡ��ͷ����----------
procedure TReservation.BitBtn2Click(Sender: TObject);
var
 newform:Troomstatus;
begin
  inherited;
  newform:=Troomstatus.Create(application);
  newform.Button2.Enabled:=false;
  newform.Caption:='˫����̬ͼѡ�񷿼��';
  if combobox1.Text<>'' then//����ͻ�����˿ͷ�����Ҫ��
    newform.preOrder:=dbedit2.Text
    else
    newform.preOrder:='no preorder';
  //ֻ��˫��ĳ������ź�����˳���ѡ����
  newform.BorderIcons:=newform.BorderIcons-[biSystemMenu]

end;

//--------------��ѡ��ͷ�ʱ����˫��ѡ��Ŀͷ����---------------
procedure TReservation.FormActivate(Sender: TObject);
begin
  inherited;
  if panel2.Enabled=true then
    begin
      //����ѡ��ķ����
      dbedit4.Text:='0'+inttostr(main.RoomNum);
      //���ݷ���ţ�ȷ���������ͣ��۸�
      adoquery1.Close;
      adoquery1.SQL.Clear;
      adoquery1.SQL.Add('select a.�۸�,a.��������,a.���ͱ�� from �ͷ����� a,�ͷ���Ϣ b');
      adoquery1.SQL.Add(' where (a.���ͱ��=b.���ͱ��)and(b.�ͷ����='''+dbedit4.Text+''')');
      adoquery1.Open;
      dbedit2.Text:=trim(adoquery1.fieldbyname('���ͱ��').AsString);
      combobox1.Text:=trim(adoquery1.fieldbyname('��������').AsString);
      dbedit5.Text:=trim(adoquery1.fieldbyname('�۸�').AsString);
      dbedit6.Text:=dbedit5.Text;
    end;
end;


//--------------�������ݣ������һЩ����������ֶ�--------------------
procedure TReservation.ToolButton10Click(Sender: TObject);
begin
  if dbedit4.Text='' then
   begin
    showmessage('�ͷ���Ų�����Ϊ��');
    exit;
   end;

   //��ע����д����λ�ã��˴����ύ����
   inherited;

   //�Ȱ�����״̬Ϊ�����ķ����Ϊ�շ�
   adocommand1.CommandText:='update �ͷ���Ϣ set ״̬=''�շ�'' where ״̬=''����''';
   adocommand1.Execute;
   //Ȼ�����Ԥ�����е���Ϣ������Ԥ���ķ���״̬��Ϊ����
   datasource1.DataSet.First;
   while not datasource1.DataSet.Eof do
    begin
      adocommand1.CommandText:='update �ͷ���Ϣ set ״̬=''����'' where �ͷ����='''+dbedit4.Text+'''';
      adocommand1.Execute;
      datasource1.DataSet.Next;
    end;
end;

//--------------------ɾ��Ԥ����--------------------
procedure TReservation.ToolButton8Click(Sender: TObject);
begin
  if application.MessageBox('�Ƿ�ɾ��Ԥ������','ȷ��',MB_OKCANCEL)=IDOK then
    begin
    //�Ƚ��ö�����Ӧ�ķ���״̬�Ļؿշ�״̬����ɾ������
    adocommand1.CommandText:='update �ͷ���Ϣ set ״̬=''�շ�'' where �ͷ����='''+dbedit4.Text+'''';
    adocommand1.Execute;
    datasource1.DataSet.Delete;
    end;
  //inherited; ��ִ�и������еĴ���

end;
//-------------------�������������ʱѡ��Ԥ�����źͿͷ����--------------------
procedure TReservation.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if self.Caption='˫�����ѡ��Ԥ������' then
    if dbgrid1.Fields[0].Text<>'' then
    begin
      main.YDNum:=dbgrid1.Fields[0].Text;
      main.RoomNum:=strtoint(trim(dbgrid1.Fields[1].Text));
      close;
    end;
end;



end.
