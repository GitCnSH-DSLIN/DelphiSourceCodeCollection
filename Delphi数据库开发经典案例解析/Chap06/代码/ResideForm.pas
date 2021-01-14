unit ResideForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ParentForm, ADODB, DB, ImgList, Grids, DBGrids, ComCtrls,
  ToolWin, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  TReside = class(TParent)
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
    DBComboBox3: TDBComboBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBEdit13: TDBEdit;
    BitBtn3: TBitBtn;
    Label27: TLabel;
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
    procedure BitBtn3Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

   
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Reside: TReside;

implementation

{$R *.dfm}
uses RoomStatusForm,MainForm,ReservationForm;

//----���ݿͷ������ͱ����ʾ�ͷ���������-----------
procedure TReside.DataSource1DataChange(Sender: TObject;
  Field: TField);
var
i:integer;
begin
  inherited;

  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select �������� from �ͷ����� where ���ͱ��='''+dbedit2.Text+'''');
  adoquery1.Open;
  combobox1.Text:=adoquery1.fieldbyname('��������').AsString;
  //���ñ����
  dbgrid1.Columns[0].Width:=100;
  dbgrid1.Columns[1].Width:=100;
  for i:=2 to 31 do
   dbgrid1.Columns[i].Width:=64;
end;


//----------����ѡ��Ŀͷ��������Ʒ��鲢�޸Ŀͷ����ͱ��---------
procedure TReside.ComboBox1Select(Sender: TObject);
begin
  inherited;
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select ���ͱ�� from �ͷ����� where ��������='''+combobox1.Text+'''');
  adoquery1.Open;
  dbedit2.Text:=adoquery1.fieldbyname('���ͱ��').AsString;
end;

//-------------------------------------------------------------
//-----------���´��봦��ֵ�ʱ������ʱ����������ʾ-----------
procedure TReside.MonthCalendar1DblClick(Sender: TObject);
begin
  inherited;
  //���ݵ����������б����ȷ����ѡ���ʱ�����뵽�Ǹ��б����
  if dbcombobox1.Focused then
    dbcombobox1.SelText:=datetostr(monthcalendar1.Date);
  if dbcombobox2.Focused then
    dbcombobox2.SelText:=datetostr(monthcalendar1.Date);
  monthcalendar1.Visible:=false;

end;

procedure TReside.DBComboBox1DropDown(Sender: TObject);
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

procedure TReside.DBComboBox2DropDown(Sender: TObject);
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

procedure TReside.DBComboBox1Exit(Sender: TObject);
begin
  inherited;
  monthcalendar1.Visible:=false;
end;

procedure TReside.DBComboBox2Exit(Sender: TObject);
begin
  inherited;
  monthcalendar1.Visible:=false;
end;
//-----------------------------------------------------------

//--------------------�༭ʱ��ֻ��ѡ���˼Ӵ���������Ӵ��۸�-------------------------
procedure TReside.DBCheckBox1Click(Sender: TObject);
begin
  inherited;
  if dbcheckbox1.Checked then
   dbedit10.Enabled:=true
   else
   dbedit10.Enabled:=false;
end;

//--------------������ס��-------------------------
procedure TReside.ToolButton6Click(Sender: TObject);
var
  maxnum,num:string;
  newnum:integer;
begin
  inherited;
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Add('select max(��ס����) ����� from ��ס��');
  adoquery1.Open;
  maxnum:=trim(adoquery1.fieldbyname('�����').AsString);
  if maxnum='' then maxnum:='RZ0'; //�����ǰ��ס��Ϊ�յĻ������ʼ��һ�����
  //��Ԥ����ǰ���RZ������ĸɾ����תΪ����
  Delete(maxnum,1,2);
  newnum:=strtoint(maxnum)+1;
  //���±�Ų������µ���ס����
  if length(inttostr(newnum))=1 then num:='RZ0000000'+inttostr(newnum);
  if length(inttostr(newnum))=2 then num:='RZ000000'+inttostr(newnum);
  if length(inttostr(newnum))=3 then num:='RZ00000'+inttostr(newnum);
  //����������ס��Ĭ��ֵ
  dbedit1.Text:=num;
  dbcombobox1.SelText:=datetostr(date);
  dbcombobox2.SelText:=datetostr(date);
  dbedit12.Text:='��ס';
  //����ֱ�����뷿�Ż��Ԥ�����е���
  bitbtn2.Enabled:=true;
  bitbtn3.Enabled:=true;
end;

//-----------ѡ��ͷ����----------
procedure TReside.BitBtn2Click(Sender: TObject);
var
 newform:Troomstatus;
begin
  inherited;
   bitbtn3.Enabled:=false;//ֱ��ѡ�񷿼��򲻿����ٴ�Ԥ�����е���
  newform:=Troomstatus.Create(application);
  newform.Button2.Enabled:=false;
  newform.Caption:='˫����̬ͼѡ�񷿼��';
    if combobox1.Text<>'' then//����ͻ�����˿ͷ�����Ҫ��
    newform.preOrder:=dbedit2.Text
    else
    newform.preOrder:='no preorder';
  //ֻ��˫��ĳ������ź�����˳���ѡ����
  newform.BorderIcons:=newform.BorderIcons-[biSystemMenu];
  dbedit13.Text:='';//ֱ��ѡ��ͷ�������Ҫ��Ԥ�����е���
end;

//------------------���������޸�ʱ������˫��ѡ����õ�����Ϣ------------------
procedure TReside.FormActivate(Sender: TObject);
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
      if bitbtn3.Enabled=true then
      begin
      //����ѡ���Ԥ������
      dbedit13.Text:=trim(main.YDNum);
      adoquery1.Close;
      adoquery1.SQL.Clear;
      adoquery1.SQL.Add('select * from Ԥ���� where Ԥ������='''+trim(main.YDNum)+'''');
      adoquery1.Open;
      dbcombobox1.Text:=datetostr(adoquery1.FieldByName('�ֵ�ʱ��').AsDateTime);
      //����Ԥ�����е���Ϣ
      dbcombobox2.Text:=datetostr(adoquery1.FieldByName('���ʱ��').AsDateTime);
      dbedit3.Text:=trim(adoquery1.FieldByName('��ϵ�绰').AsString);
      dbedit6.Text:=trim(adoquery1.FieldByName('��ס�۸�').AsString);
      dbedit7.Text:=trim(adoquery1.FieldByName('�ۿ�').AsString);
      dbedit8.Text:=trim(adoquery1.FieldByName('�ۿ�ԭ��').AsString);
      dbedit9.Text:=trim(adoquery1.FieldByName('��ס����').AsString);
      dbcheckbox1.Checked:=adoquery1.FieldByName('�Ƿ�Ӵ�').AsBoolean;
      dbedit10.Text:=trim(adoquery1.FieldByName('�Ӵ��۸�').AsString);
      dbedit11.Text:=trim(adoquery1.FieldByName('Ԥ�տ�').AsString);
      dbedit14.Text:=trim(adoquery1.FieldByName('ҵ��Ա').AsString);
      dbedit15.Text:=trim(adoquery1.FieldByName('����Ա').AsString);
      dbedit16.Text:=trim(adoquery1.FieldByName('��Ա���').AsString);
      dbedit17.Text:=trim(adoquery1.FieldByName('Ԥ����˾').AsString);
      end;
    end;
end;


//--------------------������ס��-------------------
procedure TReside.ToolButton10Click(Sender: TObject);
begin

  if dbedit4.Text='' then
   begin
    showmessage('�ͷ���Ų�����Ϊ��');
    exit;
   end;

    inherited;
   //�Ȱ�����״̬Ϊ�Ѿ���ס�ķ����Ϊ�շ�
   adocommand1.CommandText:='update �ͷ���Ϣ set ״̬=''�շ�'' where ״̬=''ס��''';
   adocommand1.Execute;
   //Ȼ�������ס���е���Ϣ�����ô�����̣�������ס��������Ѿ���ס��Ԥ����
   datasource1.DataSet.First;
   while not datasource1.DataSet.Eof do
    begin
      adocommand1.CommandText:='exec sf_������ס�� '''+dbedit1.Text+'''';
      adocommand1.Execute;
      datasource1.DataSet.Next;
    end;
    
end;

//---------------��Ԥ�����е���------------------
procedure TReside.BitBtn3Click(Sender: TObject);
var
  newform:Treservation;
begin
  inherited;
  //��Ԥ�����е���Ԥ��������������ָ������
  bitbtn2.Enabled:=false;
  newform:=Treservation.Create(application);
  newform.Caption:='˫�����ѡ��Ԥ������';
  newform.BorderIcons:=newform.BorderIcons-[biSystemMenu];//������δѡ��͹ر�
  //ֻ��ʹ�õ�������ѡ������
  newform.ToolButton6.Enabled:=false;
  newform.ToolButton7.Enabled:=false;
  newform.ToolButton8.Enabled:=false;
  newform.ToolButton10.Enabled:=false;
  newform.ToolButton11.Enabled:=false;
end;

//-----------�޸���ס��-----------------
procedure TReside.ToolButton7Click(Sender: TObject);
begin
  inherited;
  //�Ѿ���ס�Ŀ����޸�ʱ�����ٴ�Ԥ��������
  bitbtn3.Enabled:=false;
  //��������ı���ס����
  bitbtn2.Enabled:=true;
end;

//-----------�������������ѡ����ס�����-----------------
procedure TReside.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if (toolbutton6.Enabled=false)and(toolbutton10.Enabled=false) then
   if dbgrid1.Fields[0].Text<>'' then
    begin
      main.RZNum:=trim(dbgrid1.Fields[0].Text);
      close;
    end;
end;

//----------������ʾʱ�������������Ƶ������б�ѡ��-------------
procedure TReside.FormCreate(Sender: TObject);
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

end.
