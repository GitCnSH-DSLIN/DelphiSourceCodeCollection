unit jianyaoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ComCtrls, ExtCtrls, Menus,
  Mask, BusinessSkinForm;

type
  Tjianyaoform = class(TForm)
    StatusBar1: TStatusBar;
    PopupMenu1: TPopupMenu;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label15: TLabel;
    ComboBox1: TComboBox;
    DBGrid1: TDBGrid;
    yuanxigro: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    yuanxidaima: TEdit;
    yuanximingcheng: TEdit;
    Panel1: TPanel;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    banjigro: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ebjdm: TEdit;
    ebjmc: TEdit;
    ebzr: TEdit;
    ComboBox2: TComboBox;
    cssyx: TComboBox;
    xuezhileixing: TComboBox;
    xueshenggro: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    exsbh: TEdit;
    exsxm: TEdit;
    cxsxb: TComboBox;
    cssbj: TComboBox;
    minzu: TComboBox;
    chusheng: TMaskEdit;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    PopupMenu2: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    procedure ComboBox1Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cssyxEnter(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure cssbjEnter(Sender: TObject);
    procedure exsbhKeyPress(Sender: TObject; var Key: Char);
    procedure ebjdmKeyPress(Sender: TObject; var Key: Char);
    procedure yuanxidaimaKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure cxsxbKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox2KeyPress(Sender: TObject; var Key: Char);
    procedure xuezhileixingKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cssyxKeyPress(Sender: TObject; var Key: Char);
    procedure cssbjKeyPress(Sender: TObject; var Key: Char);
    procedure chushengExit(Sender: TObject);
    procedure minzuKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn5Click(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure ComboBox3Enter(Sender: TObject);
    procedure ComboBox4Enter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure exsbhKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxsxbKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chushengKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure minzuKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure exsxmKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cssbjKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ebjdmKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ebjmcKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure xuezhileixingKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ebzrKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cssyxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure yuanxidaimaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure yuanximingchengKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure yuanxidaimaEnter(Sender: TObject);
    procedure ebjdmEnter(Sender: TObject);
    procedure yuanximingchengKeyPress(Sender: TObject; var Key: Char);
    procedure ebjmcKeyPress(Sender: TObject; var Key: Char);
    procedure ebzrKeyPress(Sender: TObject; var Key: Char);
    procedure exsxmKeyPress(Sender: TObject; var Key: Char);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
  private
    procedure wmgetminmaxinfo(var msg :TWMGetMinMaxInfo);message wm_getminmaxinfo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  jianyaoform: Tjianyaoform;
  leixingtag:integer;

implementation
uses dataunit, DB, Math,mainunit;

{$R *.dfm}

procedure Tjianyaoform.ComboBox1Change(Sender: TObject);
begin
DBGrid1.DataSource.DataSet.Filtered:=false;
BitBtn1.Enabled:=true;
if ComboBox1.Text='�༶��Ϣ����' then
  begin
    DBGrid1.DataSource:=DataModule1.Dbanjixinxi;
    yuanxigro.Visible:=false;
    xueshenggro.Visible:=false;
    leixingtag:=1;
    banjigro.Visible:=true;
    ComboBox3.Visible:=true;
    ComboBox3.Text:='Ժϵѡ��';
    ComboBox4.Visible:=false;
  end
else if  combobox1.Text='ѧ����Ϣ����' then
  begin
    DBGrid1.DataSource:=DataModule1.Dxueshengxinxi;
    yuanxigro.Visible:=false;
    banjigro.Visible:=false;
    leixingtag:=2;
    xueshenggro.Visible:=true;
    ComboBox3.Visible:=false;
    ComboBox4.Visible:=true;
    ComboBox4.Text:='�༶ѡ��';
  end
else
  begin
    DBGrid1.DataSource:=DataModule1.Dxibie;
    banjigro.Visible:=false;
    xueshenggro.Visible:=false;
    leixingtag:=0;
    yuanxigro.Visible:=true;
    ComboBox3.Visible:=false;
    ComboBox4.Visible:=false;
  end;
BitBtn6.Click;
end;

procedure Tjianyaoform.BitBtn1Click(Sender: TObject);
begin
if leixingtag=0 then                    //Ժϵ��Ϣ���
  begin
    if (yuanxidaima.Text<>'')and(yuanximingcheng.Text<>'') then
      begin
        with DBGrid1.DataSource.DataSet do
          begin
            if (Locate('Ժϵ����',yuanxidaima.Text,[])=false)and(Locate('Ժϵ����',yuanximingcheng.Text,[])=false) then
              begin
                Append;
                FieldByName('Ժϵ����').AsString:=yuanxidaima.Text;
                FieldByName('Ժϵ����').AsString:=yuanximingcheng.Text;
                Post;
                BitBtn6.Click;
              end
            else
              application.MessageBox('����Ϣ�Ѿ����ڣ�','��ʾ');
          end;
      end
    else
      application.MessageBox('���벻��Ϊ�գ�','��ʾ');
  end
else if leixingtag=1 then                 //�༶��Ϣ���
  begin
    if (ebjdm.Text<>'')and(ebjmc.Text<>'')and(cssyx.Text<>'')and(ComboBox2.Text<>'')and(xuezhileixing.Text<>'') then
      begin
        with DBGrid1.DataSource.DataSet do
          begin
            if (Locate('�༶����',ebjdm.Text,[])=false)and(Locate('�༶����',ebjmc.Text,[])=false) then
              begin
                Append;
                FieldByName('�༶����').AsString:=ebjdm.Text;
                FieldByName('�༶����').AsString:=ebjmc.Text;
                FieldByName('������ʦ').AsString:=ebzr.Text;
                FieldByName('��ѧ����').AsString:=ComboBox2.Text;
                FieldByName('ѧ������').AsString:=xuezhileixing.Text;
                FieldByName('����Ժϵ����').AsString:=cssyx.Text;
                Post;
                BitBtn6.Click;
              end
            else
              application.MessageBox('����Ϣ�Ѿ����ڣ�','��ʾ');
          end;
      end
    else
      application.MessageBox('�������벻������','��ʾ');
  end
else                                      //ѧ����Ϣ���
  begin
    if (exsbh.Text<>'')and(exsxm.Text<>'')and(cxsxb.Text<>'')and(cssbj.Text<>'')and(chusheng.Text<>'') then
      begin
        with DBGrid1.DataSource.DataSet do
          begin
            if Locate('ѧ�����',exsbh.Text,[])=false then
              begin
                Append;
                FieldByName('ѧ�����').AsString:=exsbh.Text;
                FieldByName('ѧ������').AsString:=exsxm.Text;
                FieldByName('ѧ���Ա�').AsString:=cxsxb.Text;
                FieldByName('��������').AsString:=chusheng.Text;
                if minzu.Text<>'' then
                  FieldByName('��������').AsString:=minzu.Text
                else FieldByName('��������').AsString:='ȱ';
                FieldByName('�����༶����').AsString:=cssbj.Text;
                Post;
                BitBtn6.Click;
              end
            else
              application.MessageBox('�Ѿ����ڸ���Ϣ��','��ʾ');
          end;
      end
    else
      application.MessageBox('�������ݲ�������','��ʾ');
  end;
end;

procedure Tjianyaoform.FormCreate(Sender: TObject);
begin
mainform.dataref;
jianyaoform.Left:=GetSystemMetrics(SM_CXSCREEN)div 2-jianyaoform.Width div 2;
jianyaoform.Top:=GetSystemMetrics(SM_CYSCREEN)div 2-jianyaoform.Height div 2;
end;


procedure Tjianyaoform.cssyxEnter(Sender: TObject);
begin
with DataModule1 do
begin
cssyx.Clear;
if xibie.RecordCount<>0 then
  begin
    xibie.First;
    while xibie.Eof<>true do
      begin
        cssyx.Items.Add(xibie.FieldValues['Ժϵ����']);
        xibie.Next;
      end;
    xibie.First;
  end
else
  abort;
end;
end;

procedure Tjianyaoform.BitBtn7Click(Sender: TObject);
begin
Close;
mainform.Show;
end;

procedure Tjianyaoform.cssbjEnter(Sender: TObject);
begin
with DataModule1 do
begin
cssbj.Clear;
  if banjixinxi.RecordCount<>0 then
    begin
      banjixinxi.First;
      while banjixinxi.Eof<>true do
        begin
          cssbj.Items.Add(banjixinxi.FieldValues['�༶����']);
          banjixinxi.Next;
        end;
      banjixinxi.First;
    end
  else
    abort;
end;
end;

procedure Tjianyaoform.exsbhKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8]) then
  begin
    key:=#0;
  end;
end;

procedure Tjianyaoform.ebjdmKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8]) then
  begin
    key:=#0;
  end;
end;

procedure Tjianyaoform.yuanxidaimaKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8]) then
  begin
    key:=#0;
  end;
end;

procedure Tjianyaoform.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
key:=#0;
end;

procedure Tjianyaoform.cxsxbKeyPress(Sender: TObject; var Key: Char);
begin
key:=#0;
end;

procedure Tjianyaoform.ComboBox2KeyPress(Sender: TObject; var Key: Char);
begin
key:=#0;
end;

procedure Tjianyaoform.xuezhileixingKeyPress(Sender: TObject;
  var Key: Char);
begin
key:=#0;
end;

procedure Tjianyaoform.BitBtn6Click(Sender: TObject);
begin
if yuanxigro.Visible=true then
  begin
    yuanxidaima.Text:='';
    yuanximingcheng.Text:='';
    yuanxidaima.SetFocus;
  end
else if banjigro.Visible=true then
  begin
    ebjdm.Text:='';
    ebjmc.Text:='';
    ebzr.Text:='';
    ebjdm.SetFocus;
  end
else if xueshenggro.Visible=true then
  begin
    exsbh.Text:='';
    exsxm.Text:='';
    exsbh.SetFocus;
  end;
end;

procedure Tjianyaoform.BitBtn2Click(Sender: TObject);
var
  savestr:string;
  saveclass:string;
  strgread:string;
begin
if Application.MessageBox('�˲�����ɾ������������ݣ�'+#13+'�Ƿ�ȷ�ϸò�����','����',MB_YESNO)=6 then
begin
if DBGrid1.DataSource.DataSet.RecordCount<>0 then
  begin
    if leixingtag=0 then     //ɾ����Ӧ�İ༶��¼
       begin
         savestr:=DBGrid1.DataSource.DataSet.FieldValues['Ժϵ����'] ;
         with datamodule1 do
           begin
             banjixinxi.First;
             while (banjixinxi.RecordCount<>0)and(banjixinxi.Eof<>true) do
               begin
                 if banjixinxi.FieldByName('����Ժϵ����').AsString=savestr then
                   begin
                     saveclass:=banjixinxi.FieldValues['�༶����'];      //ɾ���༶��Ӧѧ��
                     xueshengxinxi.First;
                     while (xueshengxinxi.RecordCount<>0)and(xueshengxinxi.Eof<>true) do
                       begin
                         if xueshengxinxi.FieldByName('�����༶����').AsString=saveclass then
                            begin
                              strgread:=xueshengxinxi.FieldValues['ѧ�����'];
                              if dstugread.DataSet.Locate('ѧ�����',strgread,[])=true then
                                dstugread.DataSet.Delete;
                              if Ddengji.DataSet.Locate('ѧ�����',strgread,[])=true then
                                Ddengji.DataSet.Delete;
                              if Dstugreadinfo.DataSet.Locate('ѧ�����',strgread,[])=true then
                                Dstugreadinfo.DataSet.Delete;
                               xueshengxinxi.Delete;
                            end
                         else
                              xueshengxinxi.Next;
                       end;
                       banjixinxi.Delete;
                   end
                 else
                   banjixinxi.Next;
               end;
           end;
       end
    else if leixingtag=1 then    //ɾ����Ӧ��ѧ����¼
       begin
         savestr:=DBGrid1.DataSource.DataSet.FieldValues['�༶����'] ;
         with datamodule1 do
           begin
             xueshengxinxi.First;
             while (xueshengxinxi.RecordCount<>0)and(xueshengxinxi.Eof<>true) do
               begin
                 try
                   if xueshengxinxi.FieldByName('�����༶����').AsString=savestr then
                     begin
                     strgread:=xueshengxinxi.FieldValues['ѧ�����'];
                     if dstugread.DataSet.Locate('ѧ�����',strgread,[])=true then
                       dstugread.DataSet.Delete;
                     if Ddengji.DataSet.Locate('ѧ�����',strgread,[])=true then
                       Ddengji.DataSet.Delete;
                     if Dstugreadinfo.DataSet.Locate('ѧ�����',strgread,[])=true then
                       Dstugreadinfo.DataSet.Delete;
                     xueshengxinxi.Delete;
                     end
                   else
                     xueshengxinxi.Next;
                 except
                   abort;
                 end;
               end;
           end;
       end
    else          //ɾ����Ӧ�ĳɼ���¼
       begin
         savestr:=DBGrid1.DataSource.DataSet.FieldValues['ѧ�����'];
         if  DataModule1.dstugread.DataSet.Locate('ѧ�����',savestr,[])=true then
           DataModule1.dstugread.DataSet.Delete;
         if DataModule1.Ddengji.DataSet.Locate('ѧ�����',savestr,[])=true then
           DataModule1.Ddengji.DataSet.Delete;
         if DataModule1.Dstugreadinfo.DataSet.Locate('ѧ�����',savestr,[])=true then
           DataModule1.Dstugreadinfo.DataSet.Delete;
       end;
/////////////////////////////////////////////////////////////////////////////////////////
    try
      DBGrid1.DataSource.DataSet.Delete;
    except
      abort;
    end;
  end
else
  application.MessageBox('û�����ݴ��ڣ�','��ʾ');
end
else
  abort;
BitBtn6.Click;
end;

procedure Tjianyaoform.DBGrid1CellClick(Column: TColumn);
begin
if (DBGrid1.DataSource.DataSet.RecordCount<>0)and(DBGrid1.DataSource.DataSet.eof<>true) then
begin
  with DBGrid1.DataSource.DataSet do
    begin
      if yuanxigro.Visible=true then
        begin
          yuanxidaima.Text:=FieldValues['Ժϵ����'];
          yuanximingcheng.Text:=FieldValues['Ժϵ����'];
        end
      else if banjigro.Visible=true then
      begin
        ebjdm.Text:=FieldValues['�༶����'];
        ebjmc.Text:=FieldValues['�༶����'];
        ebzr.Text:=FieldValues['������ʦ'];
        ComboBox2.Text:=FieldValues['��ѧ����'];
        xuezhileixing.Text:=FieldValues['ѧ������'];
        cssyx.Text:=FieldValues['����Ժϵ����'];
      end
      else if xueshenggro.Visible=true then
      begin
        exsbh.Text:=FieldValues['ѧ�����'];
        exsxm.Text:=FieldValues['ѧ������'];
        cxsxb.Text:=FieldValues['ѧ���Ա�'];
        chusheng.Text:=FieldValues['��������'];
        minzu.Text:=FieldValues['��������'];
        cssbj.Text:=FieldValues['�����༶����'];
      end;
    end;
  end
else
  abort;
end;

procedure Tjianyaoform.BitBtn3Click(Sender: TObject);
begin
if Application.MessageBox('��ȷ���޸��Ƿ���룡 '+#13+'�ж����������Ƿ���ȷ��'+#13+'�������ĳЩ����ʧ�ܣ�'+#13+'�Ƿ�ȷ���޸ģ�','����',MB_YESNO)=6 then
begin
  with DBGrid1.DataSource.DataSet do
    begin
      if yuanxigro.Visible=true then
        begin
          if (yuanxidaima.Text<>'')and(yuanximingcheng.Text<>'')then
            begin
              Edit;
              FieldByName('Ժϵ����').AsString:=yuanxidaima.Text;
              FieldByName('Ժϵ����').AsString:=yuanximingcheng.Text;
              post;
            end
          else
            application.MessageBox('�������ݲ�������','��ʾ');
        end
      else if banjigro.Visible=true then
        begin
          if (ebjdm.Text<>'')and(ebjmc.Text<>'')and(ComboBox2.Text<>'')and(xuezhileixing.Text<>'')and(cssyx.Text<>'') then
            begin
              Edit;
              FieldByName('�༶����').AsString:=ebjdm.Text;
              FieldByName('�༶����').AsString:=ebjmc.Text;
              FieldByName('������ʦ').AsString:=ebzr.Text;
              FieldByName('��ѧ����').AsString:=ComboBox2.Text;
              FieldByName('ѧ������').AsString:=xuezhileixing.Text;
              FieldByName('����Ժϵ����').AsString:=cssyx.Text;
              Post;
            end
          else
            Application.MessageBox('�������ݲ�������','��ʾ');
        end
      else if xueshenggro.Visible=true then
        begin
          if (exsbh.Text<>'')and(exsxm.Text<>'')and(cxsxb.Text<>'')and(cssbj.Text<>'')and(chusheng.Text<>'') then
          begin
            edit;
            FieldByName('ѧ�����').AsString:=exsbh.Text;
            FieldByName('ѧ������').AsString:=exsxm.Text;
            FieldByName('ѧ���Ա�').AsString:=cxsxb.Text;
            FieldByName('��������').AsString:=chusheng.Text;
            FieldByName('��������').AsString:=minzu.Text;
            FieldByName('�����༶����').AsString:=cssbj.Text;
            post;
          end
          else
            Application.MessageBox('�������ݲ�������','��ʾ');
        end;
    end;
end
else
  abort;
end;




procedure Tjianyaoform.FormActivate(Sender: TObject);
begin
with DataModule1 do
  begin
    xibie.Filtered:=false;
    banjixinxi.Filtered:=false;
    xueshengxinxi.Filtered:=false;
  end;
end;

procedure Tjianyaoform.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
mainform.closetable;
DBGrid1.DataSource:=DataModule1.Dnull;
mainform.Show;
end;

procedure Tjianyaoform.cssyxKeyPress(Sender: TObject; var Key: Char);
begin
key:=#0;
end;

procedure Tjianyaoform.cssbjKeyPress(Sender: TObject; var Key: Char);
begin
key:=#0;
end;

procedure Tjianyaoform.chushengExit(Sender: TObject);
begin
if pos(' ',chusheng.Text)<>0 then
  begin
    chusheng.SetFocus;
    Application.MessageBox('��������ȷ�����ڸ�ʽ��'+#13+'xxxx-xx-xx��','��ʾ');
    abort;
  end;
if (StrToInt(copy(chusheng.Text,pos('-',chusheng.Text)+1,2))>12)or(StrToInt(copy(chusheng.Text,pos('-',chusheng.Text)+4,2))>31)or(StrToInt(copy(chusheng.Text,pos('-',chusheng.Text)+4,2))<1)or(StrToInt(copy(chusheng.Text,pos('-',chusheng.Text)+1,2))<1) then
  begin
    chusheng.SetFocus;
    Application.MessageBox('�������ڷ�Χ��','��ʾ');
  end;
end;

procedure Tjianyaoform.minzuKeyPress(Sender: TObject; var Key: Char);
begin
key:=#0;
end;

procedure Tjianyaoform.BitBtn5Click(Sender: TObject);
begin
if Application.MessageBox('��ȷ��Ҫ������������𣿰�������������ݣ�'+#13+'��պ����ݽ����ָܻ���','����',MB_YESNO)=6 then
begin
if leixingtag=0 then
  begin
    while (DataModule1.Dxibie.DataSet.RecordCount<>0)and(DataModule1.Dxibie.DataSet.Eof<>true) do
      begin
        DataModule1.Dxibie.DataSet.Delete;
      end;
    while (DataModule1.Dbanjixinxi.DataSet.RecordCount<>0)and(DataModule1.Dbanjixinxi.DataSet.Eof<>true) do
      begin
        DataModule1.Dbanjixinxi.DataSet.Delete;
      end;
    while (DataModule1.Dxueshengxinxi.DataSet.RecordCount<>0)and(DataModule1.Dxueshengxinxi.DataSet.Eof<>true) do
      begin
        DataModule1.Dxueshengxinxi.DataSet.Delete;
      end;
    while (DataModule1.dstugread.DataSet.RecordCount<>0)and(DataModule1.dstugread.DataSet.Eof<>true) do
      begin
        DataModule1.dstugread.DataSet.Delete;
      end;
    while (DataModule1.Ddengji.DataSet.RecordCount<>0)and(DataModule1.Ddengji.DataSet.Eof<>true) do
      begin
        DataModule1.Ddengji.DataSet.Delete;
      end;
    while (DataModule1.stugreadinfo.RecordCount<>0)and(DataModule1.Dstugreadinfo.DataSet.Eof<>true)do
      begin
        DataModule1.Dstugreadinfo.DataSet.Delete;
      end;
  end
else if leixingtag=1 then
  begin
    while (DataModule1.Dbanjixinxi.DataSet.RecordCount<>0)and(DataModule1.Dbanjixinxi.DataSet.Eof<>true) do
      begin
        DataModule1.Dbanjixinxi.DataSet.Delete;
      end;
    while (DataModule1.Dxueshengxinxi.DataSet.RecordCount<>0)and(DataModule1.Dxueshengxinxi.DataSet.Eof<>true) do
      begin
        DataModule1.Dxueshengxinxi.DataSet.Delete;
      end;
    while (DataModule1.dstugread.DataSet.RecordCount<>0)and(DataModule1.dstugread.DataSet.Eof<>true) do
      begin
        DataModule1.dstugread.DataSet.Delete;
      end;
    while (DataModule1.Ddengji.DataSet.RecordCount<>0)and(DataModule1.Ddengji.DataSet.Eof<>true) do
      begin
        DataModule1.Ddengji.DataSet.Delete;
      end;
    while (DataModule1.stugreadinfo.RecordCount<>0)and(DataModule1.Dstugreadinfo.DataSet.Eof<>true)do
      begin
        DataModule1.Dstugreadinfo.DataSet.Delete;
      end;
  end
else if leixingtag=2 then
  begin
    while (DataModule1.Dxueshengxinxi.DataSet.RecordCount<>0)and(DataModule1.Dxueshengxinxi.DataSet.Eof<>true) do
      begin
        DataModule1.Dxueshengxinxi.DataSet.Delete;
      end;
    while (DataModule1.dstugread.DataSet.RecordCount<>0)and(DataModule1.dstugread.DataSet.Eof<>true) do
      begin
        DataModule1.dstugread.DataSet.Delete;
      end;
    while (DataModule1.Ddengji.DataSet.RecordCount<>0)and(DataModule1.Ddengji.DataSet.Eof<>true) do
      begin
        DataModule1.Ddengji.DataSet.Delete;
      end;
    while (DataModule1.stugreadinfo.RecordCount<>0)and(DataModule1.Dstugreadinfo.DataSet.Eof<>true)do
      begin
        DataModule1.Dstugreadinfo.DataSet.Delete;
      end;        
  end;
BitBtn6.Click;
end;
end;



procedure Tjianyaoform.ComboBox3Change(Sender: TObject);
begin
DBGrid1.DataSource.DataSet.Filter:='����Ժϵ����='+QuotedStr(ComboBox3.Text);
DBGrid1.DataSource.DataSet.Filtered:=true;
BitBtn1.Enabled:=false;
Application.MessageBox('����ֻ���޸����ݣ�'+#13+'���Ҫ������� ������ѡ��������ͣ�','��ʾ');
end;

procedure Tjianyaoform.ComboBox4Change(Sender: TObject);
begin
DBGrid1.DataSource.DataSet.Filter:='�����༶����='+QuotedStr(ComboBox4.Text);
DBGrid1.DataSource.DataSet.Filtered:=true;
BitBtn1.Enabled:=false;
Application.MessageBox('����ֻ���޸����ݣ�'+#13+'���Ҫ������� ������ѡ��������ͣ�','��ʾ');
end;

procedure Tjianyaoform.ComboBox3Enter(Sender: TObject);
begin
ComboBox3.Items.Clear;
if DataModule1.xibie.RecordCount<>0 then
  begin
    DataModule1.xibie.First;
    while DataModule1.xibie.Eof<>true do
      begin
        ComboBox3.Items.Add(DataModule1.xibie.FieldValues['Ժϵ����']);
        DataModule1.xibie.Next;
      end;
    DataModule1.xibie.First;
  end;
end;

procedure Tjianyaoform.ComboBox4Enter(Sender: TObject);
begin
ComboBox4.Items.Clear;
if DataModule1.banjixinxi.RecordCount<>0 then
  begin
    DataModule1.banjixinxi.First;
    while DataModule1.banjixinxi.Eof<>true do
      begin
        ComboBox4.Items.Add(DataModule1.banjixinxi.FieldValues['�༶����']);
        DataModule1.banjixinxi.Next;
      end;
    DataModule1.banjixinxi.First;
  end;
end;

procedure Tjianyaoform.FormShow(Sender: TObject);
begin
mainform.dataref;
//��ʼ��
BitBtn1.Enabled:=true;
ComboBox4.Text:='�༶ѡ��';
ComboBox3.Text:='Ժϵѡ��';
DBGrid1.DataSource:=DataModule1.Dxibie;
xueshenggro.Visible:=false;
banjigro.Visible:=false;
yuanxigro.Visible:=true;
leixingtag:=0;
ComboBox4.Visible:=false;
ComboBox3.Visible:=false;
ComboBox1.Text:='Ժϵ��Ϣ����';
end;

procedure Tjianyaoform.exsbhKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=Vk_return) then
  begin
    BitBtn1.Click;
  end;
end;

procedure Tjianyaoform.cxsxbKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=Vk_return) then
  begin
    BitBtn1.Click;
  end;
end;

procedure Tjianyaoform.chushengKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=Vk_return) then
  begin
    BitBtn1.Click;
  end;
end;

procedure Tjianyaoform.minzuKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=Vk_return) then
  begin
    BitBtn1.Click;
  end;
end;

procedure Tjianyaoform.exsxmKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=Vk_return) then
  begin
    BitBtn1.Click;
  end;
end;

procedure Tjianyaoform.cssbjKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=Vk_return) then
  begin
    BitBtn1.Click;
  end;
end;

procedure Tjianyaoform.ebjdmKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=Vk_return) then
  begin
    BitBtn1.Click;
  end;
end;

procedure Tjianyaoform.ComboBox2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=Vk_return) then
  begin
    BitBtn1.Click;
  end;
end;

procedure Tjianyaoform.ebjmcKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=Vk_return) then
  begin
    BitBtn1.Click;
  end;
end;

procedure Tjianyaoform.xuezhileixingKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=Vk_return) then
  begin
    BitBtn1.Click;
  end;
end;

procedure Tjianyaoform.ebzrKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=Vk_return) then
  begin
    BitBtn1.Click;
  end;
end;

procedure Tjianyaoform.cssyxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=Vk_return) then
  begin
    BitBtn1.Click;
  end;
end;

procedure Tjianyaoform.yuanxidaimaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=Vk_return) then
  begin
    BitBtn1.Click;
  end;
end;

procedure Tjianyaoform.yuanximingchengKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if (key=Vk_return) then
  begin
    BitBtn1.Click;
  end;
end;

procedure Tjianyaoform.yuanxidaimaEnter(Sender: TObject);
begin
if DBGrid1.DataSource.DataSet.RecordCount<>0 then
  begin
    yuanxidaima.Text:=IntToStr(dBGrid1.DataSource.DataSet.RecordCount+1);
  end
else yuanxidaima.Text:='1';
end;

procedure Tjianyaoform.ebjdmEnter(Sender: TObject);
begin
if DBGrid1.DataSource.DataSet.RecordCount<>0 then
  begin
    ebjdm.Text:=IntToStr(dBGrid1.DataSource.DataSet.RecordCount+1);
  end
else ebjdm.Text:='1';
end;

procedure Tjianyaoform.yuanximingchengKeyPress(Sender: TObject;
  var Key: Char);
begin
if key=' 'then
key:=#0;
end;

procedure Tjianyaoform.ebjmcKeyPress(Sender: TObject; var Key: Char);
begin
if key=' 'then
key:=#0;
end;

procedure Tjianyaoform.ebzrKeyPress(Sender: TObject; var Key: Char);
begin
if key=' 'then
key:=#0;
end;

procedure Tjianyaoform.exsxmKeyPress(Sender: TObject; var Key: Char);
begin
if key=' 'then
key:=#0;
end;

procedure tjianyaoform.wmgetminmaxinfo(var msg :TWMGetMinMaxInfo);
begin
    with msg.minmaxinfo^ do

    begin
      ptMinTrackSize:=point(718,436);//  �޶���С
      ptMaxTrackSize:=point(718,436); // �޶���С
    end;
end;


procedure Tjianyaoform.N1Click(Sender: TObject);
begin
if BitBtn1.Enabled=true then
  bitbtn1.Click;
end;

procedure Tjianyaoform.N2Click(Sender: TObject);
begin
if bitbtn2.Enabled=true then
  bitbtn2.Click;
end;

procedure Tjianyaoform.N3Click(Sender: TObject);
begin
if bitbtn3.Enabled=true then
  bitbtn3.Click;
end;

procedure Tjianyaoform.N4Click(Sender: TObject);
begin
if bitbtn5.Enabled=true then
  bitbtn5.Click;
end;

end.
