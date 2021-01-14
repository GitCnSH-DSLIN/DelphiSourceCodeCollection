unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, XPMenu, ImgList, TFlatTitlebarUnit,
  ExtCtrls, TFlatPanelUnit, TFlatButtonUnit, StdCtrls, TFlatEditUnit,
  TFlatComboBoxUnit, Grids, DB, ADODB, TFlatCheckBoxUnit,shellapi,
  TFlatHintUnit,ComObj;

type
  TFrmMain = class(TForm)
    XPMenu1: TXPMenu;
    MainMenu1: TMainMenu;
    MainTitle: TFlatTitlebar;
    MenuSys: TMenuItem;
    SubCaoZuoRen: TMenuItem;
    SubSystemSetup: TMenuItem;
    N1: TMenuItem;
    SubModifyCaoZuo: TMenuItem;
    N2: TMenuItem;
    SubExit: TMenuItem;
    MenuMgr: TMenuItem;
    SubEnter: TMenuItem;
    SubQueryPT: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    SubQueryTB: TMenuItem;
    N5: TMenuItem;
    SubQueryAll: TMenuItem;
    MenuHelp: TMenuItem;
    SubHelp: TMenuItem;
    SubRegister: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    SubAbout: TMenuItem;
    SubLoginOff: TMenuItem;
    N8: TMenuItem;
    ImageList1: TImageList;
    BtnExit2: TFlatButton;
    SubZZ: TMenuItem;
    PanelTop: TFlatPanel;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    TBtnLogin: TToolButton;
    TBtnLoginOff: TToolButton;
    TBntExit: TToolButton;
    ToolBar3: TToolBar;
    TBtnEnter: TToolButton;
    TBtnPT: TToolButton;
    TBtnTS: TToolButton;
    TBtnAll: TToolButton;
    l3: TToolButton;
    TBtnSysTemSetup: TToolButton;
    PanelBottom: TFlatPanel;
    PanelClient: TFlatPanel;
    MenuSys1: TMenuItem;
    SubLogin: TMenuItem;
    SubExit1: TMenuItem;
    TBtnSys1: TToolButton;
    TBtnSys2: TToolButton;
    TBtnMgr: TToolButton;
    TBtnHelp: TToolButton;
    N9: TMenuItem;
    l2: TToolButton;
    l1: TToolButton;
    PanelLogin: TFlatPanel;
    PanelLevel: TFlatPanel;
    PanelDateTime: TFlatPanel;
    TBtnDataMgr: TToolButton;
    MenuDataMgr: TMenuItem;
    BtnDelAll: TMenuItem;
    N10: TMenuItem;
    SubOverRun: TMenuItem;
    N11: TMenuItem;
    SubCompress: TMenuItem;
    PanelData: TPanel;
    ListView1: TListView;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    S1: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    Panel2: TPanel;
    lblAmount: TLabel;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    BtnOverRun: TToolButton;
    ToolButton1: TToolButton;
    BtnWGB: TToolButton;
    lblVersion: TLabel;
    LblRegInfo: TLabel;
    lblsoft: TLabel;
    lblAuthor: TLabel;
    lblMail: TLabel;
    LblQQ: TLabel;
    FlatHint1: TFlatHint;
    Label1: TLabel;
    CmbSearchName: TFlatComboBox;
    CmbOperator: TFlatComboBox;
    EditTJ: TFlatEdit;
    BtnSearch: TFlatButton;
    BtnAdd: TFlatButton;
    BtnDel: TFlatButton;
    BtnView: TFlatButton;
    procedure SubExitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SubRegisterClick(Sender: TObject);
    procedure SubLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TBtnLoginOffClick(Sender: TObject);
    procedure SubModifyCaoZuoClick(Sender: TObject);
    procedure SubAboutClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SubCaoZuoRenClick(Sender: TObject);
    procedure SubSystemSetupClick(Sender: TObject);
    procedure SubEnterClick(Sender: TObject);
    procedure TBtnAllClick(Sender: TObject);
    procedure TBtnPTClick(Sender: TObject);
    procedure TBtnTSClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure CmbSearchNameChange(Sender: TObject);
    procedure ListView1CustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure N13Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure SubZZClick(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure SubHelpClick(Sender: TObject);
    procedure BtnDelAllClick(Sender: TObject);
    procedure SubOverRunClick(Sender: TObject);
    procedure SubCompressClick(Sender: TObject);
  private
    { Private declarations }
    procedure OgrSetup;
    procedure DBConnection;
    procedure ReadDate;
    Procedure CheckRegCode;
    Procedure DelAllData;
    procedure WriteDefUser;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;
  TempSearchName:string;   //����ת����ѯ��

implementation

uses Login, About, UserSetup, SystemSetup, InputInfo,Reg,global,jm,report;

{$R *.dfm}

procedure TFrmMain.SubExitClick(Sender: TObject);
begin
 close;
end;

procedure TFrmMain.FormActivate(Sender: TObject);
begin
XpMenu1.Active :=True;
if Checkreg=0 then
  LblRegInfo.Caption :='�����δע��'
  else
    LblRegInfo.Caption :=tempInc;  
end;

procedure TFrmMain.SubRegisterClick(Sender: TObject);
begin
  paneldata.Visible :=False;
  ADOConnection1.Close;
  lblAmount.Caption :='';
  FrmRegistry.showmodal;
end;

procedure TFrmMain.SubLoginClick(Sender: TObject);
begin
  frmLogin.ShowModal ;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  OgrSetup;
  PanelDateTime.Caption :='';
  CheckRegCode;  //����Ƿ�ע��Ĺ���
  ADOConnection1.Close;
  listview1.Columns[0].Width :=0;
end;

procedure TFrmMain.TBtnLoginOffClick(Sender: TObject);
begin
if messagebox(Handle,Pchar('��ȷ��ע����ǰ�û���¼��'),PChar('ע��ȷ��'),MB_YESNO+MB_ICONQUESTION)=IDYES then OgrSetup;
end;

procedure TFrmMain.OgrSetup;
begin
   TBtnLoginOff.Visible:=False;
   PanelLogin.Caption :='��δ��¼';
   PanelLevel.Caption :='�޲���Ȩ��';
   TBtnSys1.Visible :=True;
   TBtnSys2.Visible :=False;
   TBtnMgr.Visible :=False;
   TBtnDataMgr.Visible :=False;
   TBtnLogin.Visible :=True;
   TBtnLoginOff.Visible :=False;
   ToolBar3.Visible :=False;
   Paneltop.Height :=60;
end;

procedure TFrmMain.SubModifyCaoZuoClick(Sender: TObject);
begin
  paneldata.Visible :=False;
  ADOConnection1.Close;
  lblAmount.Caption :='';
  FrmLogin.ShowModal ;
end;

procedure TFrmMain.SubAboutClick(Sender: TObject);
begin
  paneldata.Visible :=False;
  ADOConnection1.Close;
  lblAmount.Caption :='';
  frmabout.showmodal;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if messagebox(Handle,Pchar('���Ҫ�˳�ϵͳ��'),PChar('�˳�ȷ��'),MB_YESNO+MB_ICONQUESTION)=IDNO then
  canclose:=False;
end;

procedure TFrmMain.SubCaoZuoRenClick(Sender: TObject);
begin
  paneldata.Visible :=False;
  ADOConnection1.Close;
  lblAmount.Caption :='';
  frmUserSetup.showmodal;
end;

procedure TFrmMain.SubSystemSetupClick(Sender: TObject);
begin
paneldata.Visible :=False;
ADOConnection1.Close;
lblAmount.Caption :='';
FrmSystemSetup.showmodal;
end;

procedure TFrmMain.SubEnterClick(Sender: TObject);
begin
  paneldata.Visible :=False;
  ADOConnection1.Close;
  lblAmount.Caption :='';
  frmInputinfo.Clear;
  frmInputInfo.BtnAdd.Visible :=True;
  frmInputInfo.BtnModify.Visible :=False;
  frmInputInfo.showmodal;

end;

procedure TFrmMain.TBtnAllClick(Sender: TObject);
begin
PanelData.Visible :=True;
DBConnection;
ADOQuery1.Close;
ADOQuery1.SQL.Clear;
ADOQuery1.SQL.Text :='select * from Userinfo order by id';
ADOQuery1.Open ;
Listview1.Clear;
  while not ADOQuery1.Eof do
    begin
       ReadDate;
       ADOQuery1.Next;
  end;
ADOQuery1.Close;
lblAmount.Caption :='���� ['+inttoStr(listview1.Items.Count)+'] ��' ;
end;

procedure TFrmMain.DBConnection;
var
  DataPath:string;
begin
  if ADOConnection1.Connected then ADOConnection1.Close;
  //��ֹ���ظ��򿪶������������Ӵ���

  DataPath:=ExtractFilePath(Application.ExeName)+'Data\mgr.db';
  {��¼���ܵ����ݿ�}

  ADOConnection1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+DataPath+';

  ADOConnection1.Open();

end;

procedure TFrmMain.TBtnPTClick(Sender: TObject);
begin
PanelData.Visible :=True;
DBConnection;
ADOQuery1.Close;
ADOQuery1.SQL.Clear;
ADOQuery1.SQL.Text :='select * from Userinfo order by id';
ADOQuery1.Open ;
Listview1.Clear;
 while not ADOQuery1.Eof do
    begin
    if ADOQuery1.FieldValues['TB']=0 then
      begin
        ReadDate;
      end;
  ADOQuery1.Next;
  end;
  ADOQuery1.Close;
  lblAmount.Caption :='���� ['+inttoStr(listview1.Items.Count)+'] ��' ;
end;

procedure TFrmMain.TBtnTSClick(Sender: TObject);
begin
PanelData.Visible :=True;
DBConnection;
ADOQuery1.Close;
ADOQuery1.SQL.Clear;
ADOQuery1.SQL.Text :='select * from Userinfo order by id';
ADOQuery1.Open ;
Listview1.Clear;
 while not ADOQuery1.Eof do
    begin
    if ADOQuery1.FieldValues['TB']=1 then
      begin
        ReadDate;
      end;
  ADOQuery1.Next;
  end;
ADOQuery1.Close;
lblAmount.Caption :='���� ['+inttoStr(listview1.Items.Count)+'] ��' ;
end;

procedure TFrmMain.ReadDate;
begin
  with Listview1.Items.Add do
  begin
    Caption :=ADOQuery1.FieldValues['ID'];
    SubItems.Add(ADOQuery1.FieldValues['Name']);
    SubItems.Add(ADOQuery1.FieldValues['Phone']);
    Subitems.Add(ADOQuery1.FieldValues['Fax']);
    Subitems.Add(ADOQuery1.FieldValues['Mobile']);
    Subitems.Add(ADOQuery1.FieldValues['addr']);
    Subitems.Add(ADOQuery1.FieldValues['BuyDate']);
    Subitems.Add(ADOQuery1.FieldValues['OverRun']);
    if ADOQuery1.FieldValues['TB']=0 then
      Subitems.Add('��')
        else
          subitems.Add('��');
   subitems.Add(ADOQuery1.FieldValues['BuyAmount']);
   subitems.Add(ADOQuery1.FieldValues['CPU']);
   subitems.Add(ADOQuery1.FieldValues['Memory']);
   subitems.Add(ADOQuery1.FieldValues['HD']);
   subitems.Add(ADOQuery1.FieldValues['displaycard']);
   subitems.Add(ADOQuery1.FieldValues['sound']);
   subitems.Add(ADOQuery1.FieldValues['mainboard']);
   subitems.Add(ADOQuery1.FieldValues['box']);
   subitems.Add(ADOQuery1.FieldValues['display']);
   subitems.Add(ADOQuery1.FieldValues['power']);
   subitems.Add(ADOQuery1.FieldValues['floppy']);
   subitems.Add(ADOQuery1.FieldValues['cdrom']);
   subitems.Add(ADOQuery1.FieldValues['mouse']);
   subitems.Add(ADOQuery1.FieldValues['keyboard']);
   subitems.Add(ADOQuery1.FieldValues['soundbox']);
   subitems.Add(ADOQuery1.FieldValues['network']);
   subitems.Add(ADOQuery1.FieldValues['modem']);
   subitems.Add(ADOQuery1.FieldValues['print']);
   subitems.Add(ADOQuery1.FieldValues['other']);
   subitems.Add(ADOQuery1.FieldValues['memo'])
  end;
end;

procedure TFrmMain.Timer1Timer(Sender: TObject);
//������ʾ��ǰϵͳ�����ڡ�ʱ�䡢���ڡ�
const
    Week:array[1..7] of string=('������','����һ','���ڶ�','������',
                                '������','������','������');
begin
    Paneldatetime.Caption :='��'+dateToStr(Date)+'��  ��'+TimeToStr(Time)+'��  ��'
                      + Week[DayOfWeek(Now)]+'��';

end;

procedure TFrmMain.BtnSearchClick(Sender: TObject);
begin
DBConnection;
ADOQuery1.Close;
ADOQuery1.SQL.Clear;
if (CmbSearchName.ItemIndex<>2) and (CmbSearchName.ItemIndex <>3) then
  ADOQuery1.SQL.Text :='select * from userinfo where '+TempSearchName+''+CmbOperator.Text+'"'+Edittj.Text+'"'
  else
    ADOQuery1.SQL.Text :='select * from userinfo where '+TempSearchName+''+CmbOperator.Text+'#'+Edittj.Text+'#';  //��ѯ���ڸ�ʽҪ���� # ��
ADOQuery1.Open ;
ADOQuery1.First ;
Listview1.Clear;
 while not ADOQuery1.Eof do
    begin
        ReadDate;
  ADOQuery1.Next;
  end;
ADOQuery1.Close;
end;

procedure TFrmMain.CmbSearchNameChange(Sender: TObject);
begin
case CmbSearchName.ItemIndex of
  0:TempSearchName:='name';
  1:TempSearchName:='addr';
  2:TempSearchName:='buydate';
  3:TempSearchName:='overrun';
  4:TempSearchName:='buyamount';
  5:TempSearchName:='CPU';
  6:TempSearchName:='Memory';
  7:TempSearchName:='hd';
  8:TempSearchName:='displaycard';
  9:TempSearchName:='sound';
  10:TempSearchName:='mainboard';
  11:TempSearchName:='box';
  12:TempSearchName:='display';
  13:TempSearchName:='power';
  14:TempSearchName:='Floppy';
  15:TempSearchName:='cdrom';
  16:TempSearchName:='mouse';
  17:TempSearchName:='keyboard';
  18:TempSearchName:='soundbox';
  19:TempSearchName:='network';
  20:TempSearchName:='modem';
  21:TempSearchName:='printer'
end;
end;

{������������ listview �е���ɫ��δ����~~~~~~~~~}
procedure TFrmMain.ListView1CustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin

  if strtodate(item.SubItems.Strings[6])<now then
    begin
      ListView1.Canvas.Brush.Color := clSkyBlue;
      listview1.Canvas.Font.Color :=clblue;
    end;

  if item.SubItems.Strings[7]='��' then
  begin
    ListView1.Canvas.Brush.Color := clRed;
    Listview1.Canvas.Font.Color:=clYellow;
  end;
end;

procedure TFrmMain.N13Click(Sender: TObject);
begin
PanelData.Visible :=True;
DBConnection;
ADOQuery1.Close;
ADOQuery1.SQL.Clear;
ADOQuery1.SQL.Text :='select * from Userinfo where overrun >=now order by id';
ADOQuery1.Open ;
Listview1.Clear;
 while not ADOQuery1.Eof do
    begin
      ReadDate;
      ADOQuery1.Next;
    end;
ADOQuery1.Close;
lblAmount.Caption :='���� ['+inttoStr(listview1.Items.Count)+'] ��' ;
end;

procedure TFrmMain.N15Click(Sender: TObject);
begin
PanelData.Visible :=True;
DBConnection;
ADOQuery1.Close;
ADOQuery1.SQL.Clear;
ADOQuery1.SQL.Text :='select * from Userinfo where overrun <=now order by id';
ADOQuery1.Open ;
Listview1.Clear;
 while not ADOQuery1.Eof do
    begin
      ReadDate;
      ADOQuery1.Next;
    end;
ADOQuery1.Close;
lblAmount.Caption :='���� ['+inttoStr(listview1.Items.Count)+'] ��' ;
end;

procedure TFrmMain.CheckRegCode;   //���ע������Ƿ���ȷ
const
  my_key = 5741;
var
  RegCode:ansistring;
begin
DBConnection;
ADOQuery1.Close;
ADOQuery1.SQL.Clear;
ADOQuery1.SQL.Text :='select * from reg';
ADOQuery1.Open;
if ADOQuery1.FieldValues['incname']<>null then
  Tempinc:=ADOQuery1.FieldValues['incname']
  else
    tempInc:='δע�����';
if ADOQuery1.FieldValues['regcode']<> null then
  TempRegCode:=ADOQuery1.FieldValues['regcode']
  else
    TempRegCode:='δע�����';
RegCode:=Encrypt(Tempinc,my_key);
if Tempregcode<>regcode then checkreg:=0 else checkreg:=1;
end;

procedure TFrmMain.SubZZClick(Sender: TObject);
begin
shellExecute(GetDesktopWindow,'Open',PChar('mailto:luozs168@163.net?subject='+ '�ԡ����Թ�˾�ͻ�����ϵͳ������ͽ���'),
              nil,
              nil,
              SW_ShowNormal);
end;

procedure TFrmMain.ListView1DblClick(Sender: TObject);
begin
if listview1.Selected <> nil then
begin
  with frmInputinfo do
    begin
      with Listview1.Selected do
        begin
          // �ͻ���Ϣ
          Euser.Text := SubItems[0];
          Ephone.Text :=SubItems[1];
          EFax.Text :=SubItems[2];
          EMobile.Text :=SubItems[3];
          Eaddr.Text :=SubItems[4];
          DateBuy.Date :=StrToDate(SubItems[5]);
          DateBao.Date :=StrToDate(SubItems[6]);
          if SubItems[7]='��' then
             CmbQuality.ItemIndex :=1
             else
               CmbQuality.ItemIndex :=0;
          EAmount.Text :=SubItems[8];

        // ����������Ϣ
          ECPU.Text :=SubItems[9];
          EMemory.Text :=SubItems[10];
          EHD.Text :=SubItems[11];
          Edisplaycard.Text :=SubItems[12];
          ESound.Text :=SubItems[13];
          EMainBoard.Text :=SubItems[14];
          EBox.Text :=SubItems[15];
          EDisplay.Text :=SubItems[16];
          Epower.Text :=SubItems[17];
          EFloppy.Text :=SubItems[18];
          ECDROM.Text :=SubItems[19];
          EMouse.Text :=SubItems[20];
          EKeyBoard.Text :=SubItems[21];
          ESoundBox.Text :=SubItems[22];
          ENetWork.Text :=SubItems[23];
          EModem.Text :=SubItems[24];
          EPrint.Text :=SubItems[25];
          EOther.Text :=SubItems[26];
          Memo.Text :=SubItems[27];
        end;
    end;
  frmInputInfo.BtnAdd.Visible :=False;
  frmInputInfo.BtnModify.Visible :=True;
  frminputinfo.ShowModal ;
end;
end;

procedure TFrmMain.BtnDelClick(Sender: TObject);
begin
if listview1.Selected =nil then exit;
if messagebox(handle,
              Pchar('��ȷ��Ҫɾ��������Ϣ��ɾ���������ǲ��ɻָ��ģ�'),
              Pchar('ȷ��ɾ��'),
              mb_YesNo+MB_ICONQUESTION	)=IDYes then
  begin
    DBConnection;
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Text :='delete from userinfo where id='+listview1.Selected.Caption+'';
    ADOQuery1.ExecSQL;
    listview1.Selected.Delete;
  end;
end;

procedure TFrmMain.SubHelpClick(Sender: TObject);
begin
shellExecute(GetDesktopWindow,'Open',PChar('help.chm'),
              nil,
              nil,
              SW_ShowNormal);
end;

//-----------------------------
//  ɾ�����е�����
//-----------------------------
procedure TFrmMain.DelAllData;
begin
  DBConnection;
  ADOConnection1.Execute('delete * from inc');
  ADOConnection1.Execute('delete * from login');
  ADOConnection1.Execute('delete * from UserInfo');
end;

procedure TFrmMain.BtnDelAllClick(Sender: TObject);
begin
if messagebox(handle,'�����������ճ�ע����Ϣ��ϵͳĬ���û���'+#13#10+#13#10
                    +'����������ݡ����ң����ݱ�ɾ�����ǲ��ɻ�'+#13#10+#13#10
                    +'����?��ȷ��Ҫɾ����',
                    '����ɾ��ȷ��',
                    MB_YESNO+MB_ICONQUESTION)=IDYes then
  begin
    DelAllData;  //ɾ�����е�����
    WriteDefUser; //��ɾ�����е������Ժ�д��ϵͳ�� Ĭ���˺� �� ����
    ADOConnection1.Close;
  end;
end;

procedure TFrmMain.WriteDefUser;
begin
//��ɾ�����е������Ժ�д��ϵͳ�� Ĭ���˺� �� ����
ADOQuery1.Close;
ADOQuery1.SQL.Clear;
ADOQuery1.SQL.Text :='Select * from login';
ADOQuery1.Open;
ADOQuery1.Edit;
ADOQuery1.FieldByName('user').AsString :='�����û�';
ADOQuery1.FieldByName('Pwd').AsString :='123';
ADOQuery1.FieldByName('level').AsInteger :=0;
ADOQuery1.Post;
ADOQuery1.Close;
end;

procedure TFrmMain.SubOverRunClick(Sender: TObject);
begin
if messagebox(handle,
              Pchar('��ȷ��Ҫɾ���������Ŀͻ�(���ر�ͻ���)��������ɾ���������ǲ��ɻָ��ģ�'),
              Pchar('ɾ���������û�����'),
              mb_YesNo+MB_ICONQUESTION	)=IDYes then
  begin
    DBConnection;
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Text :='delete from userinfo where overrun <=now and TB<>"1"';
    ADOQuery1.ExecSQL;
    showmessage('���ݼ����ɹ�ɾ����');
    ADOConnection1.Close;
  end;
end;



function CompressDB(Afile,APwd:string):boolean;
{���ݿ�ѹ������}
var
  DaoVar: OLEVariant;
begin
  try
  DaoVar := CreateOleObject('dao.DBEngine.36');
  if FileExists('db.tmp') then deletefile('db.tmp');
    DaoVar.CompactDatabase(afile,'db.tmp',';pwd='+apwd+'',0,';pwd='+apwd+'');
  if deletefile(afile) then RenameFile('db.tmp',Afile);
  except
    result:=False;
  end;
end;

procedure TFrmMain.SubCompressClick(Sender: TObject);
var
  DataPath,pwd:string;
begin
  DataPath:=ExtractFilePath(Application.ExeName)+'\data\mgr.db';
  pwd:='�����֡�';
  if ADOConnection1.Connected then ADOConnection1.Close ;
  if compressDB(DataPath,pwd) then
      ShowMessage('���ݿ�ѹ���ɹ���')
      else
        if Messagebox(handle,'����ѹ��ʱ����������رճ���'+#13#10+#13#10
                         +'�������������ٽ���ѹ������ȷ��Ҫ�˳�������',
                         'ѹ������',MB_YESNO+MB_ICONQUESTION)=IDYES then
           FrmMain.Close;

end;
end.
