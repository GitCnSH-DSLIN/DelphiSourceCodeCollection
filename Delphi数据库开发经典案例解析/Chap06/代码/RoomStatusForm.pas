unit RoomStatusForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ImgList, ExtCtrls, DB, ADODB;

type
  TRoomStatus = class(TForm)
    ImageList1: TImageList;
    GroupBox1: TGroupBox;
    StringGrid1: TStringGrid;
    GroupBox2: TGroupBox;
    Button1: TButton;
    GroupBox3: TGroupBox;
    RadioButton1: TRadioButton;
    Image1: TImage;
    Image2: TImage;
    RadioButton2: TRadioButton;
    Image3: TImage;
    RadioButton3: TRadioButton;
    Image4: TImage;
    RadioButton4: TRadioButton;
    Image5: TImage;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Button2: TButton;
    ADOQuery1: TADOQuery;
    ADOCommand1: TADOCommand;
    Image6: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);

    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure RadioButton6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    preOrder:string;//������Ҫ��ʾ���з�����һ�����͵ķ���
    procedure SetIcon(index:integer;cellcol:integer;cellrow:integer);//��ͼ��
    procedure SetText(number:integer;cellcol:integer;cellrow:integer);//��ʾ����
    procedure ShowStatus();//��ͼ����ʾ���ݿ��з���״̬
   end;

 var
  RoomStatus: TRoomStatus;
  roomnum:integer;//ѡ�еķ���ı��
  isChosen:bool;//�ж��Ƿ�ѡ����һ����Ч����
  chosenIndex:integer;//ѡ�е�radiobutton�ı��
  chosenStatus:string;//ѡ�е�radiobutton��״̬



implementation

{$R *.dfm}
uses MainForm;

//------������ʾʱ���ñ��еķ���ź�¥���--------------
procedure TRoomStatus.FormCreate(Sender: TObject);
var
  i:integer;
begin
 for i:=1 to 16 do
   begin
    if i>=13 then
      stringgrid1.Cells[i,0]:='#'+inttostr(i+2)
      else
      stringgrid1.Cells[i,0]:='#'+inttostr(i);
   end;
  for i:=1 to 4 do
   stringgrid1.Cells[0,i]:=' '+inttostr(i+2)+'¥';
  //Ĭ���������ʾȫ�������
  preOrder:='no preorder';
end;

//---------------���·�̬ͼ----------------
procedure TRoomStatus.Button1Click(Sender: TObject);
begin
showstatus();
end;


//-------------------����ĳѡ�з����״̬--------------------
procedure TRoomStatus.Button2Click(Sender: TObject);
var
 status:string;
begin
if isChosen=false then
 begin
  showmessage('δѡ�񷿼�');
  exit;
 end;
//�������ݿ��е�����
adocommand1.CommandText:='update �ͷ���Ϣ set ״̬='''+chosenStatus+''' where �ͷ����=''0'+inttostr(roomnum)+'''';
adocommand1.Execute;
showstatus();
end;



//----��һ��stringgrid��Ԫ���л�ͼ��-----
procedure TRoomStatus.SetIcon(index, cellcol, cellrow: integer);
var
  bitmap:Tbitmap;
  rt:Trect;
begin
 //����Ĳ���Ϊimagelist�е�ͼ����Ԫ����кź��к�
 rt:=stringgrid1.CellRect(cellcol,cellrow);
 bitmap:=TBitmap.Create;
 imagelist1.GetBitmap(index,bitmap);
 stringgrid1.Canvas.Draw(rt.Left,rt.Top,bitmap);
 bitmap.Free;
end;

//----��ĳ��stringgrid��Ԫ������ʾ���ķ�����-----
procedure TRoomStatus.SetText(number, cellcol, cellrow: integer);
var
  rt:Trect;
begin
 //����Ĳ���Ϊ�����ţ���Ԫ����кź��к�
 rt:=stringgrid1.CellRect(cellcol,cellrow);
 stringgrid1.Canvas.Brush.Style:=bsClear;
 stringgrid1.Canvas.TextOut(rt.Left+5,rt.Top+20,inttostr(number));
end;

//---------------�������ݿ��еķ���״̬����ÿ����Ԫ������ʾ����״̬--------------
procedure TRoomStatus.ShowStatus;
var
  i,floor,room,num,index:integer;
  status:string;
begin
  //��ѯ�ͷ�״̬
  adoquery1.Close;
  adoquery1.SQL.Clear;

  //�ж��Ƿ�̬����״̬����ѡ�񷿼�״̬
  if (button2.Enabled=true)or(preOrder='no preorder') then//δԤѡ���ͣ�����ʾȫ������
  adoquery1.SQL.Add('select �ͷ����,״̬ from �ͷ���Ϣ order by �ͷ����');
  if button2.Enabled=false then
  adoquery1.SQL.Add('select �ͷ����,״̬ from �ͷ���Ϣ where ���ͱ��='''+preOrder+''' order by �ͷ����');
  adoquery1.Open;

  //�����������״̬��ʾ��stringgrid��
  while not adoquery1.Eof do
   begin
    num:=adoquery1.FieldByName('�ͷ����').AsInteger;
    status:=adoquery1.FieldByName('״̬').AsString;
    floor:=round(num/100);//��¥��
    room:=num mod (100*floor);//�󷿼��
    if room>=13 then room:=room-2;
    if status='�շ�' then index:=0;
    if status='ס��' then index:=1;
    if status='����' then index:=2;
    if status='ά��' then index:=3;
    if status='����' then index:=4;
    if status='����' then index:=5;
    SetIcon(index,room,floor-2);
    SetText(num,room,floor-2);
    adoquery1.Next;
   end;
end;

//---------------��StringGrid�ػ�ʱ���ַ���״̬�ĸ���--------------------------
procedure TRoomStatus.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  showstatus();
end;

//---------------�رմ���--------------
procedure TRoomStatus.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;
//------------------ѡ��һ����Ԫ�񣬲���ѯ��״̬-----------------------
procedure TRoomStatus.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  status:string;
begin
  if (ARow>0)and(ACol>0) then
    begin
    if ACol>=13 then//���ڷ����û��13��14�����������Ҫת��һ�±��
      roomnum:=100*(2+ARow)+ACol+2
      else
      roomnum:=100*(2+ARow)+ACol;

     adoquery1.Close;
     adoquery1.SQL.Clear;
     adoquery1.SQL.Add('select ״̬ from �ͷ���Ϣ where �ͷ����=''0'+inttostr(roomnum)+'''');
     adoquery1.Open;
     status:=trim(adoquery1.fieldbyname('״̬').AsString);
     //�ж���ѡ��ĵ�Ԫ���Ƿ�Ϊ�ո�
     if status<>'' then
      isChosen:=true
      else
      isChosen:=false;
     //���ݷ����װ�������õ�ѡ��ť
     if status='�շ�' then radiobutton1.Checked:=true;
     if status='ס��' then radiobutton2.Checked:=true;
     if status='����' then radiobutton3.Checked:=true;
     if status='ά��' then radiobutton4.Checked:=true;
     if status='����' then radiobutton5.Checked:=true;
     if status='����' then radiobutton6.Checked:=true;
    end;
end;

//-----------�ڵ�����ѡ��ťʱ��������ѡ��״̬--------------
procedure TRoomStatus.RadioButton1Click(Sender: TObject);
begin
if radiobutton1.Checked then//�շ�
  begin
    chosenIndex:=0;
    chosenStatus:=radiobutton1.Caption;
  end;
end;

procedure TRoomStatus.RadioButton2Click(Sender: TObject);
begin
if radiobutton2.Checked then//ס��
  begin
    chosenIndex:=1;
    chosenStatus:=radiobutton2.Caption;
  end;
end;

procedure TRoomStatus.RadioButton3Click(Sender: TObject);
begin
if radiobutton3.Checked then//����
  begin
    chosenIndex:=2;
    chosenStatus:=radiobutton3.Caption;
  end;
end;

procedure TRoomStatus.RadioButton4Click(Sender: TObject);
begin
if radiobutton4.Checked then//ά��
  begin
    chosenIndex:=3;
    chosenStatus:=radiobutton4.Caption;
  end;
end;

procedure TRoomStatus.RadioButton5Click(Sender: TObject);
begin
if radiobutton5.Checked then//����
  begin
    chosenIndex:=4;
    chosenStatus:=radiobutton5.Caption;
  end;
end;

procedure TRoomStatus.RadioButton6Click(Sender: TObject);
begin
if radiobutton6.Checked then//����
  begin
    chosenIndex:=5;
    chosenStatus:=radiobutton6.Caption;
  end;
end;



//----------------�������������ʱ˫��ѡ�񷿼�-----------------
procedure TRoomStatus.StringGrid1DblClick(Sender: TObject);
begin
  if button2.Enabled=false then
    if (isChosen=true)and(radiobutton1.Checked) then
      begin
       adoquery1.Close;
       adoquery1.SQL.Clear;
       adoquery1.SQL.Add('select * from �ͷ���Ϣ where (�ͷ����=''0'+inttostr(roomNum)+''')and(���ͱ��='''+preOrder+''')');
       adoquery1.Open;
       if (adoquery1.FieldByName('�ͷ����').AsString<>'')or(preOrder='no preorder') then
        begin
        //���ѡ��ķ����Ƿ���Ҫ��Ŀշ����򱣴淿��Ų��رմ���
        main.RoomNum:=roomNum;
        close;
        end
        else
         begin
          showmessage('��ѡ���䲢��Ԥ������');
          exit;
         end;
      end
     else
       begin
        showmessage('��ѡ�ķ��䲻�ǿշ�');
        exit;
       end;
end;

end.
