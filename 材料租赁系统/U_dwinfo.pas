unit U_dwinfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBClient, ImgList, Menus, ComCtrls, ExtCtrls, StdCtrls, Mask, DBCtrls,
  Grids, DBGrids, Buttons;

type
  TfrmDwinfo = class(TForm)
    Panel2: TPanel;
    ImageList1: TImageList;
    PopupMenu2: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    ImageList2: TImageList;
    N3: TMenuItem;
    N4: TMenuItem;
    Panel1: TPanel;
    Panel3: TPanel;
    btn_print: TSpeedButton;
    btn_refresh: TSpeedButton;
    N5: TMenuItem;
    N6: TMenuItem;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    Panel4: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBMemo1: TDBMemo;
    DBEdit5: TDBEdit;
    Label13: TLabel;
    DBEdit9: TDBEdit;
    Label14: TLabel;
    DBEdit10: TDBEdit;
    Label15: TLabel;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    Label20: TLabel;
    btn_insert: TSpeedButton;
    btn_edit: TSpeedButton;
    btn_cancel: TSpeedButton;
    btn_save: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure btn_printClick(Sender: TObject);
    procedure btn_refreshClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure btn_insertClick(Sender: TObject);
//    procedure btn_deleteClick(Sender: TObject);
    procedure btn_editClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure btn_saveClick(Sender: TObject);

  private
    { Private declarations }
    procedure btn_valid;
  public

    { Public declarations }
  end;

var
  frmDwinfo: TfrmDwinfo;
  gs_bmbm: string;
  gb_pd: bool;
implementation

uses main, u_public,u_dm;

{$R *.DFM}

procedure TfrmDwinfo.btn_valid;
begin
   Panel4.Enabled :=NOT Panel4.Enabled ;
//  DBNavigator.enabled := not dbnavigator.enabled;
  btn_insert.enabled := not btn_insert.enabled;
 // btn_delete.enabled := not btn_delete.enabled;
  btn_edit.enabled := not btn_edit.enabled;
  btn_cancel.enabled := not btn_cancel.enabled;
  btn_Save.enabled := not btn_Save.enabled;
 // btn_find.enabled := not btn_find.enabled;
  btn_refresh.enabled := not btn_refresh.enabled;
  btn_print.enabled := not btn_print.enabled;

end;


procedure TfrmDwinfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := cafree;
  frmDwinfo := nil;
 
end;

procedure TfrmDwinfo.N2Click(Sender: TObject);
begin
{  try
    application.createform(TfrmZgda_Kp, frmZgda_Kp);
    DM.CDS_ZGDA.edit;
    frmZgda_Kp.showmodal;
  finally
    frmZgda_Kp.free;
  end;}
end;

procedure TfrmDwinfo.N1Click(Sender: TObject);
begin
//  if DM.CDS_ZGDA.recordcount <> 0 then
 // begin
 //   if Application.messagebox('��ȷ���Ƿ�Ҫɾ��', '���ʹ���ϵͳ', mb_iconinformation + mb_yesno) = idyes then
 //   begin
 //     DM.CDS_ZGDA.delete;
 //     DM.CDS_ZGDA.applyupdates(0);
 //   end;
//  end
//  else
//  begin
//    Application.messagebox('��û�м�¼��ɾ������ȷ��!', '���ʹ���ϵͳ', mb_iconinformation + mb_defbutton1);
//  end;
end;


procedure TfrmDwinfo.N3Click(Sender: TObject);
//var
//  vs_value: string;
//  vi, i: integer;
begin
{  application.createform(TfrmSzcx, frmSzcx);
  frmSzcx.srclist.items.add('ְ�����');
  frmSzcx.srclist.items.add('ְ������');
  frmSzcx.srclist.items.add('�Ա�');
  frmSzcx.srclist.items.add('��������');
  frmSzcx.srclist.items.add('������ò');
  frmSzcx.srclist.items.add('ְ��');
  try
    frmSzcx.showmodal;
  finally
    if Ordered then
    begin
      vi := frmSzcx.DstList.Items.Count;
      if vi > 0 then
      begin
        vs_value := frmSzcx.dstlist.items[0];
      end;
      for i := 2 to vi do
      begin
        vs_value := vs_value + ';' + frmSzcx.dstlist.items[i - 1];
      end;
      DM.CDS_ZGDA.IndexFieldNames := vs_value;
    end;
    frmSzcx.free;
  end;     }
end;

procedure TfrmDwinfo.N4Click(Sender: TObject);
begin
{  application.createform(TfrmPrint, frmPrint);
  with frmPrint do
  begin
  srclist.items.add('ְ�����');
  srclist.items.add('ְ������');
  srclist.items.add('�Ա�');
  srclist.items.add('��������');
  srclist.items.add('������ò');
  srclist.items.add('ְ��');
  srclist.items.add('ְ��');
  srclist.items.add('ְ������');
  srclist.items.add('��ע');
  vps_tablename := 'CL_ZGDA';
  vps_filter := DM.CDS_ZGDA.Filter;
  vps_index := DM.CDS_ZGDA.IndexFieldNames;
  edtPrintTitle.Text := 'ְ������';
  try
    showmodal;
  finally
    free;
  end;
  end;  }
end;

procedure TfrmDwinfo.N5Click(Sender: TObject);
begin
{  application.CreateForm(TfrmZgda_Kp, frmZgda_Kp);
  try
    DM.CDS_ZGDA.insert;
    frmZgda_Kp.showmodal;
  finally
    frmZgda_Kp.free;
  end;     }
end;

procedure TfrmDwinfo.SpeedButton1Click(Sender: TObject);
begin
  N5.click;
end;

procedure TfrmDwinfo.SpeedButton2Click(Sender: TObject);
begin
  N1.click;
end;

procedure TfrmDwinfo.SpeedButton3Click(Sender: TObject);
begin
  N2.click;
end;

procedure TfrmDwinfo.btn_printClick(Sender: TObject);
begin
  N4.click;
end;

procedure TfrmDwinfo.btn_refreshClick(Sender: TObject);
begin
DM.ADO_DWINFO.Close ;
close;
//   DM.tbrsxxb.Refresh;
end;

procedure TfrmDwinfo.DBGrid1TitleClick(Column: TColumn);
begin
//  DbGridSort(dbgrid1, column);
end;

procedure TfrmDwinfo.FormCreate(Sender: TObject);
var
s_value:string;
begin
  with DM do
  begin
    ADO_DWINFO.Active := True;
    ADO_DWINFO.First ;
    s_value:=ADO_DWINFO.Fieldbyname('dwcode').AsString ;
    if length(s_value)=0 then
    begin
      ADO_DWINFO.Filter := '';
      ADO_DWINFO.Filtered := true;
  //���ݼ��������״̬
      ADO_DWINFO.Insert;
      ADO_DWINFO.FieldByName('dwcode').AsString:='01' ;
     // ADO_DWINFO.Post;
      btn_valid;
    end;
  end;

end;




procedure TfrmDwinfo.btn_insertClick(Sender: TObject);
begin
  //ȡ������
  DM.ADO_DWINFO.Filter := '';
  DM.ADO_DWINFO.Filtered := true;
  //���ݼ��������״̬
 DM.ADO_DWINFO.Insert;
  //�ı��������Ч��
  btn_valid;
  dbedit1.SetFocus;
end;
    {
procedure TfrmDwinfo.btn_deleteClick(Sender: TObject);
begin
  //�ж��Ƿ��м�¼��ɾ��
DM.tbdwinfo.Close ;
DM.tbdwinfo.Open;
  if DM.tbdwinfo.recordcount = 0 then
  begin
    application.MessageBox('û�м�¼��ɾ��', '��������ϵͳ', mb_iconinformation + mb_defbutton1);
    exit;
  end;
  //ȷ��ɾ��
  if application.messagebox('��ȷ���Ƿ�Ҫɾ��', '��������ϵͳ', mb_iconinformation + mb_yesno) = idyes then
  begin
  if frmmain.findundo('sp_kscode','spmx',trim(dbedit1.Text)) then
    begin
      application.MessageBox('���̱����Ѵ�����ҵ��������,�޷�ɾ������', '��������ϵͳ', mb_iconinformation + mb_defbutton1);
      dbedit1.SetFocus;
      exit;
    end;

    if frmmain.findundo('ksbm','djmx',trim(dbedit1.Text)) then
    begin
      application.MessageBox('���̱����Ѵ�����ҵ��������,�޷�ɾ������', '��������ϵͳ', mb_iconinformation + mb_defbutton1);
      dbedit1.SetFocus;
      exit;
    end;


    DM.tbkhks.delete;
  end;
end;          }

procedure TfrmDwinfo.btn_editClick(Sender: TObject);
begin
  //���ж��Ƿ��м�¼�ɱ༭
  DM.ADO_DWINFO.Close ;
  DM.ADO_DWINFO.Open ;
  if DM.ADO_DWINFO.recordcount = 0 then
  begin
    application.MessageBox('û�м�¼���ܱ༭', '��������ϵͳ', mb_iconinformation + mb_defbutton1);
    exit;
  end;
    //ʹ���ݼ����ڱ༭״̬
  DM.ADO_DWINFO.edit;
  //���������Ч��
  btn_valid;
  dbedit1.setfocus;
end;

procedure TfrmDwinfo.btn_cancelClick(Sender: TObject);
begin
  //�����ղŵĲ���
  DM.ADO_DWINFO.CancelUpdates;
  //����������ʾ���Ϊ������״̬
  btn_valid;
end;

procedure TfrmDwinfo.btn_saveClick(Sender: TObject);
var
  s_slzh: string;
begin
  //������ݵ���Ч��
  if (dbedit1.text = '') or (dbedit2.Text ='') then
  begin
    application.MessageBox('��λ��������Ʋ���Ϊ��', '��������ϵͳ', mb_iconinformation + mb_defbutton1);
    dbedit1.SetFocus;
    exit;
  end;
  //�жϹؼ����Ƿ��ظ�
  s_slzh := dbedit1.Text;
{  if DM.tbkhks.state = dsinsert then
  begin
   if frmmain.findundo('kscode','khks',s_slzh) then
    begin
      application.MessageBox('��λ�������ظ�,�����������µı��룡��', '��������ϵͳ', mb_iconinformation + mb_defbutton1);
      dbedit1.SetFocus;
      exit;
    end;
  end;   }
  //�ύ���������ݿ�


  DM.ADO_DWINFO.Post;
  //����������ʾ���Ϊ������״̬
  btn_valid;


end;

end.

