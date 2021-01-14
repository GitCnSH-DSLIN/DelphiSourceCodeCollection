unit chengjiunit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ComCtrls, ExtCtrls, Buttons, jpeg,
  Menus, BusinessSkinForm, bsSkinCtrls;

type
  Tchengjiform = class(TForm)
    StatusBar1: TStatusBar;
    PopupMenu1: TPopupMenu;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    ComboBox1: TComboBox;
    GroupBox3: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit6: TEdit;
    Panel1: TPanel;
    Bevel1: TBevel;
    BitBtn1: TbsSkinButton;
    BitBtn2: TbsSkinButton;
    BitBtn3: TbsSkinButton;
    BitBtn4: TbsSkinButton;
    BitBtn5: TbsSkinButton;
    BitBtn6: TbsSkinButton;
    BitBtn7: TbsSkinButton;
    Label14: TLabel;
    ComboBox2: TComboBox;
    procedure ComboBox1Enter(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure Edit8KeyPress(Sender: TObject; var Key: Char);
    procedure Edit9KeyPress(Sender: TObject; var Key: Char);
    procedure Edit10KeyPress(Sender: TObject; var Key: Char);
    procedure Edit11KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Edit12KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit7Exit(Sender: TObject);
    procedure Edit8Exit(Sender: TObject);
    procedure Edit10Exit(Sender: TObject);
    procedure Edit11Exit(Sender: TObject);
    procedure Edit4Exit(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure Edit6Exit(Sender: TObject);
    procedure Edit9Exit(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure ComboBox2Enter(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
  private
    procedure wmgetminmaxinfo(var msg :TWMGetMinMaxInfo);message wm_getminmaxinfo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  chengjiform: Tchengjiform;
  dj1,dj2,dj3,dj4,dj5,dj6,dj7,dj8:string;
  cg1,cg2,cg3,cg4,cg5,cg6,cg7,cg8,cg9:integer;    //��¼��ͬ��Ŀ�ĳɼ�
  woli:string;        //��������ָ��
  feihuoliang:string;  //�λ�������ָ��  

implementation
uses dataunit,mainunit, DBTables, DB, DateUtils,printunit;

{$R *.dfm}

procedure Tchengjiform.ComboBox1Enter(Sender: TObject);
begin
DataModule1.banjixinxi.Refresh;
if DataModule1.banjixinxi.RecordCount<>0 then
  begin
    ComboBox1.Items.Clear;
    DataModule1.banjixinxi.First;
    while (DataModule1.banjixinxi.Eof<>true) do
      begin
        if ComboBox2.Text<>'' then
          begin
            if DataModule1.banjixinxi.FieldValues['����Ժϵ����']=ComboBox2.Text then
               ComboBox1.Items.Add(DataModule1.banjixinxi.FieldValues['�༶����']);
          end
        else
        ComboBox1.Items.Add(DataModule1.banjixinxi.FieldValues['�༶����']);
        DataModule1.banjixinxi.Next;
      end;
    DataModule1.banjixinxi.First;
  end;
end;

procedure Tchengjiform.ComboBox1Change(Sender: TObject);
begin
BitBtn5.Click;
DBGrid1.DataSource:=DataModule1.Dxueshengxinxi;
DBGrid1.DataSource.DataSet.Filtered:=true;
DBGrid1.DataSource.DataSet.Filter:='�����༶����='+QuotedStr(ComboBox1.Text);
end;

procedure Tchengjiform.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
mainform.closetable;
DBGrid1.DataSource:=DataModule1.Dnull;
mainform.Show;
end;

procedure Tchengjiform.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
key:=#0;
end;

procedure Tchengjiform.FormShow(Sender: TObject);
begin
mainform.dataref;
if ComboBox1.Text<>'' then
  begin
    DBGrid1.DataSource:=DataModule1.Dxueshengxinxi;
    DBGrid1.DataSource.DataSet.Filtered:=true;
    DBGrid1.DataSource.DataSet.Filter:='�����༶����='+QuotedStr(ComboBox1.Text);
  end
else
  DBGrid1.DataSource:=DataModule1.Dnull;
BitBtn5.Click;
BitBtn2.Enabled:=false;
bitbtn3.Enabled:=false;
end;

procedure Tchengjiform.FormCreate(Sender: TObject);
begin
mainform.dataref;
chengjiform.Left:=GetSystemMetrics(SM_CXSCREEN)div 2-chengjiform.Width div 2;
chengjiform.Top:=GetSystemMetrics(SM_CYSCREEN)div 2-chengjiform.Height div 2;
end;

procedure Tchengjiform.BitBtn5Click(Sender: TObject);
begin
edit1.Text:='';
edit2.Text:='';
edit3.Text:='';
edit4.Text:='';
edit5.Text:='';
edit6.Text:='';
edit7.Text:='';
edit8.Text:='';
edit9.Text:='';
edit10.Text:='';
edit11.Text:='';
edit12.Text:='';
edit2.SetFocus;
dj1:='��';
dj2:='��';
dj3:='��';
dj4:='��';
dj5:='��';
dj6:='��';
dj7:='��';
dj8:='��';
woli:='';
feihuoliang:='';
end;

procedure Tchengjiform.BitBtn7Click(Sender: TObject);
begin
close;
end;

procedure Tchengjiform.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
key:=#0;
end;

procedure Tchengjiform.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then
  key:=#0;
if Pos('.',edit2.Text)<>0 then
  begin
    if key='.' then
      key:=#0;
  end;
end;

procedure Tchengjiform.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then
  key:=#0;
if Pos('.',edit3.Text)<>0 then
  begin
    if key='.' then
      key:=#0;
  end;
end;

procedure Tchengjiform.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then
  key:=#0;
if Pos('.',edit4.Text)<>0 then
  begin
    if key='.' then
      key:=#0;
  end;
end;

procedure Tchengjiform.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then
  key:=#0;
if Pos('.',edit5.Text)<>0 then
  begin
    if key='.' then
      key:=#0;
  end;
end;

procedure Tchengjiform.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then
  key:=#0;
if Pos('.',edit6.Text)<>0 then
  begin
    if key='.' then
      key:=#0;
  end;
end;

procedure Tchengjiform.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then
  key:=#0;
if pos('.',edit7.Text)<>0 then
  if key='.' then
    key:=#0;
end;

procedure Tchengjiform.Edit8KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then
  key:=#0;
if pos('.',edit8.Text)<>0 then
  if key='.' then
    key:=#0;
end;

procedure Tchengjiform.Edit9KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9','.',#8]) then
  key:=#0;
if Pos('.',edit9.Text)<>0 then
  begin
    if key='.' then
      key:=#0;
  end;
end;

procedure Tchengjiform.Edit10KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8]) then
  key:=#0;
end;

procedure Tchengjiform.Edit11KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8]) then
  key:=#0;
end;

procedure Tchengjiform.DBGrid1CellClick(Column: TColumn);
begin
edit1.Text:='';
edit2.Text:='';
edit3.Text:='';
edit4.Text:='';
edit5.Text:='';
edit6.Text:='';
edit7.Text:='';
edit8.Text:='';
edit9.Text:='';
edit10.Text:='';
edit11.Text:='';
edit12.Text:='';
if (ComboBox1.Text<>'')and(DBGrid1.DataSource.DataSet.RecordCount<>0)and(DBGrid1.DataSource.DataSet.eof<>true) then
  begin
  if (DataModule1.stugread.RecordCount<>0)and(DBGrid1.DataSource.DataSet.eof<>true) then
    begin
      with DataModule1.stugread do
        begin
          if Locate('ѧ�����',DBGrid1.DataSource.DataSet.FieldValues['ѧ�����'],[])=false then
            begin
              edit1.Text:=DBGrid1.DataSource.DataSet.FieldValues['ѧ�����'];
            end
          else
            begin
               edit1.Text:=FieldValues['ѧ�����'];
               if FieldValues['���']<>'��'  then
               edit2.Text:=FieldValues['���']
               else edit2.Text:='';
               if FieldValues['����']<>'��' then
               edit3.Text:=FieldValues['����']
               else edit3.Text:='';
               if FieldValues['50����']<>'��' then
               Edit4.Text:=FieldValues['50����']
               else Edit4.Text:='';
               if FieldValues['800����']<>'��' then
               edit5.Text:=FieldValues['800����']
               else edit5.Text:='';
               if FieldValues['1000����']<>'��' then
               edit6.Text:=FieldValues['1000����']
               else edit6.Text:='';
               if FieldValues['��������']<>'��'then
               edit7.Text:=FieldValues['��������']
               else edit7.Text:='';
               if FieldValues['�λ�������']<>'��'then
               edit8.Text:=FieldValues['�λ�������']
               else  edit8.Text:='';
               if FieldValues['������ǰ��']<>'��'then
               edit9.Text:=FieldValues['������ǰ��']
               else edit9.Text:='';
               if  FieldValues['������Զ']<>'��'then
               edit10.Text:=FieldValues['������Զ']
               else edit10.Text:='';
               if FieldValues['��������']<>'��'then
               edit11.Text:=FieldValues['��������']
               else edit11.Text:='';
               edit12.Text:=FieldValues['�ܳɼ�'];
            end;
        end;
    end
  else
    edit1.Text:=DBGrid1.DataSource.DataSet.FieldValues['ѧ�����'];
  end;  
end;

procedure Tchengjiform.Edit12KeyPress(Sender: TObject; var Key: Char);
begin
key:=#0;
end;

procedure Tchengjiform.BitBtn1Click(Sender: TObject);
var
  stuclass:string;    //����ѧ�����ڰ༶����
  sex:string;         //����ѧ���Ա�
  year:integer;        //��¼����ѧ��ʱ��
  grade:string;       //����ѧ������
  vheight:string;     //���泬�������
begin
  cg1:=0;
  cg2:=0;
  cg3:=0;
  cg4:=0;
  cg5:=0;
  cg6:=0;
  cg7:=0;
  cg8:=0;
  cg9:=0;
  dj1:='��';
  dj2:='��';
  dj3:='��';
  dj4:='��';
  dj5:='��';
  dj6:='��';
  dj7:='��';
  dj8:='��';
  year:=0;
  woli:='';
  feihuoliang:='';
  if edit1.Text<>'' then
    begin
      with DBGrid1.DataSource.DataSet do
        begin
          sex:=FieldValues['ѧ���Ա�'];
          stuclass:=FieldValues['�����༶����'];
          if DataModule1.banjixinxi.Locate('�༶����',stuclass,[])=true then
            begin
              if DataModule1.banjixinxi.FieldByName('��ѧ����').AsString='һ��' then
                year:=1
              else if DataModule1.banjixinxi.FieldByName('��ѧ����').AsString='����' then
                year:=2
              else if DataModule1.banjixinxi.FieldByName('��ѧ����').AsString='����' then
                year:=3
              else if DataModule1.banjixinxi.FieldByName('��ѧ����').AsString='����' then
                year:=4
              else if DataModule1.banjixinxi.FieldByName('��ѧ����').AsString='����' then
                year:=5;
              grade:=DataModule1.banjixinxi.FieldValues['ѧ������'];
            end
          else
            abort;
        end;
      if (grade='��ר')or(grade='��ѧ')or(grade='�����Ƹ�ְ')or((year>3)and(grade='�����Ƹ�ְ')) then
        begin
          if sex='��' then
            begin
            /////////////////////////////////////////////////
                   ///      ȡ50���ܷ�ֵ     ///
                   /////////////////////////////
              if edit4.Text<>'' then                     
                begin
                  with DataModule1.zdxbothstandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('50����');
                      Filtered:=true;
                      First;
                    if DataModule1.zdxbothstandboy.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit4.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg1:=FieldValues['�ɼ�'];
                           dj1:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit4.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg1:=FieldValues['�ɼ�'];
                               dj1:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit4.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg1:=FieldValues['�ɼ�'];
                          dj1:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg1:=0;
                    end;
                end
              else
                cg1:=0;
            /////////////////////////////////////////////////
                   ///     ȡ800���ܷ�ֵ    ///
                   /////////////////////////////
              if edit5.Text<>'' then                     
                begin
                  with DataModule1.zdxbothstandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('800����');
                      Filtered:=true;
                      First;
                    if DataModule1.zdxbothstandboy.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit5.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg2:=FieldValues['�ɼ�'];
                           dj2:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit5.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg2:=FieldValues['�ɼ�'];
                               dj2:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit5.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg2:=FieldValues['�ɼ�'];
                          dj2:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg2:=0;
                    end;
                end
              else
                cg2:=0;
            /////////////////////////////////////////////////
                   ///     ȡ1000���ܷ�ֵ    ///
                   /////////////////////////////
              if edit6.Text<>'' then                     
                begin
                  with DataModule1.zdxbothstandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('1000����');
                      Filtered:=true;
                      First;
                    if DataModule1.zdxbothstandboy.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit6.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg3:=FieldValues['�ɼ�'];
                           dj3:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit6.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg3:=FieldValues['�ɼ�'];
                               dj3:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit6.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg3:=FieldValues['�ɼ�'];
                          dj3:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg3:=0;
                    end;
                end
              else
                cg3:=0;
            /////////////////////////////////////////////////
                   ///      ȡ��������ָ��   ///
                   /////////////////////////////
              if edit7.Text<>'' then
                begin
                  if (edit3.Text<>'')and(StrToFloat(edit3.Text)<>0) then
                    begin
                      woli:=FloatToStr(StrToFloat(edit7.Text)/StrToFloat(edit3.Text)*100);
                      if pos('.',woli)<>0 then
                        delete(woli,pos('.',woli),length(woli)+1-pos('.',woli));  //ȡ����ֵ
                    end
                  else
                    begin
                      Application.MessageBox('û��������Ϣ�����������أ�','��ʾ');
                      abort;
                    end;
                  with DataModule1.zdxbothstandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('��������ָ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zdxbothstandboy.RecordCount<>0 then
                      begin
                       if (StrToint(woli)<StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg4:=FieldValues['�ɼ�'];
                           dj4:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(woli)<StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg4:=FieldValues['�ɼ�'];
                               dj4:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(woli)>StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg4:=FieldValues['�ɼ�'];
                          dj4:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg4:=0;
                    end;
                end
              else
                cg4:=0;
            /////////////////////////////////////////////////
                   ///     ȡ�λ�������ָ��  ///
                   /////////////////////////////
              if edit8.Text<>'' then                     
                begin
                  if (edit3.Text<>'')and(StrToFloat(edit3.Text)<>0) then
                    begin
                      feihuoliang:=FloatToStr(StrToFloat(edit8.Text)/StrToFloat(edit3.Text));
                      if pos('.',feihuoliang)<>0 then
                        delete(feihuoliang,pos('.',feihuoliang),length(feihuoliang)+1-pos('.',feihuoliang));  //ȡ����ֵ
                    end
                  else
                    begin
                      Application.MessageBox('û��������Ϣ�����������أ�','��ʾ');
                      abort;
                    end;
                  with DataModule1.zdxbothstandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('�λ�������ָ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zdxbothstandboy.RecordCount<>0 then
                      begin
                       if (StrToint(feihuoliang)<StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg5:=FieldValues['�ɼ�'];
                           dj5:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(feihuoliang)<StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg5:=FieldValues['�ɼ�'];
                               dj5:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(feihuoliang)>StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg5:=FieldValues['�ɼ�'];
                          dj5:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg5:=0;
                    end;
                end
              else
                cg5:=0;
            /////////////////////////////////////////////////
                   ///     ȡ������ǰ���ɼ�   ///
                   /////////////////////////////
              if edit9.Text<>'' then                     
                begin
                  with DataModule1.zdxbothstandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������ǰ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zdxbothstandboy.RecordCount<>0 then
                      begin
                       if (StrTofloat(edit9.Text)<StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                         begin
                           cg6:=FieldValues['�ɼ�'];
                           dj6:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrTofloat(edit9.Text)<StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                               begin
                               cg6:=FieldValues['�ɼ�'];
                               dj6:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrTofloat(edit9.Text)>StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                          begin
                          cg6:=FieldValues['�ɼ�'];
                          dj6:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg6:=0;
                    end;
                end
              else
                cg6:=0;
            /////////////////////////////////////////////////
                   ///     ȡ������Զ�ɼ�    ///
                   /////////////////////////////
              if edit10.Text<>'' then
                begin
                  with DataModule1.zdxbothstandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������Զ');
                      Filtered:=true;
                      First;
                    if DataModule1.zdxbothstandboy.RecordCount<>0 then
                      begin
                       if (StrToint(edit10.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg7:=FieldValues['�ɼ�'];
                           dj7:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(edit10.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg7:=FieldValues['�ɼ�'];
                               dj7:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(edit10.Text)>StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg7:=FieldValues['�ɼ�'];
                          dj7:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg7:=0;
                    end;
                end
              else
                cg7:=0;
            /////////////////////////////////////////////////
                   ///     ȡ���������ɼ�    ///
                   /////////////////////////////
              if edit11.Text<>'' then
                begin
                  with DataModule1.zdxbothstandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������Զ');
                      Filtered:=true;
                      First;
                    if DataModule1.zdxbothstandboy.RecordCount<>0 then
                      begin
                       if (StrToint(edit11.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg8:=FieldValues['�ɼ�'];
                           dj8:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(edit11.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg8:=FieldValues['�ɼ�'];
                               dj8:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(edit11.Text)>StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg8:=FieldValues['�ɼ�'];
                          dj8:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg8:=0;
                    end;
                end
              else
                cg8:=0;
////////////////////////////////////////////////////////////////////////////////
        ///              ȡ��ѧ������߱�׼���سɼ�                     ///
        ///////////////////////////////////////////////////////////////////
              if (edit2.Text<>'')and(edit3.Text<>'') then
                begin
                  with  DataModule1.zdxstandhboy do
                    begin
                      if DataModule1.zdxstandhboy.RecordCount<>0 then
                        begin
                          First;
                          if (StrToFloat(edit2.Text)<strtofloat(FieldValues['��߶�']))then
                            begin
                              if application.MessageBox('��ߵ������ֵ��'+#13+'����������׼�������أ�'+#13+'�Ƿ����ִ��','����',MB_YESNO)=6 then
                                vheight:=FloatToStr((StrToFloat(FieldValues['��߶�'])-StrToFloat(edit2.Text)) * 0.5+StrToFloat(edit3.Text))
                              else vheight:=edit3.Text;
                                  if (StrToFloat(vheight)<strtofloat(FieldValues['���ض�1'])) then
                                     cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�2'])) then
                                     cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�3'])) then
                                     cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�4'])) then
                                     cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                  else if  (StrToFloat(vheight)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�5'])) then
                                     cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                            end
                          else
                            while eof<>true do
                              begin
                                if (StrToFloat(edit2.Text)<StrToFloat(FieldValues['��߶�']))or(StrToFloat(edit2.Text)=strtofloat(FieldValues['��߶�'])) then
                                  begin
                                    if (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�1'])) then
                                       cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�2'])) then
                                       cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�3'])) then
                                       cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�4'])) then
                                       cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                    else if  (StrToFloat(edit3.Text)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�5'])) then
                                       cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                                    Last;
                                  end;
                                if Eof<>true then
                                  Next;
                              end;
                            if eof=True then
                            if (StrToFloat(edit2.Text)>StrToFloat(FieldValues['��߶�'])) then
                              begin
                                if application.MessageBox('��߳������ֵ�����ձ�׼���أ�'+#13+'�Ƿ����ִ�иò�����','����',MB_YESNO)=6 then
                                  vheight:=FloatToStr(strtofloat(edit3.Text)-(StrToFloat(edit2.Text)-StrToFloat(FieldValues['��߶�']))*0.9)
                                else vheight:=edit3.Text;  
                                    if (StrToFloat(vheight)<strtofloat(FieldValues['���ض�1'])) then
                                       cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�2'])) then
                                       cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�3'])) then
                                       cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�4'])) then
                                       cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                    else if  (StrToFloat(vheight)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�5'])) then
                                       cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                              end;
                        end
                      else
                        cg9:=0;
                    end;
                end
              else
                cg9:=0;
////////////////////////////////////////////////////////////////////////////////
//////////////                  ���������                   ///////////////////
////////////////////////////////////////////////////////////////////////////////
            end
          else if sex='Ů' then
            begin
            /////////////////////////////////////////////////
                   ///      ȡ50���ܷ�ֵ     ///
                   /////////////////////////////
              if edit4.Text<>'' then                     
                begin
                  with DataModule1.zdxbothstandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('50����');
                      Filtered:=true;
                      First;
                    if DataModule1.zdxbothstandgirl.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit4.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg1:=FieldValues['�ɼ�'];
                           dj1:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit4.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg1:=FieldValues['�ɼ�'];
                               dj1:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit4.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg1:=FieldValues['�ɼ�'];
                          dj1:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg1:=0;
                    end;
                end
              else
                cg1:=0;
            /////////////////////////////////////////////////
                   ///     ȡ800���ܷ�ֵ    ///
                   /////////////////////////////
              if edit5.Text<>'' then                     
                begin
                  with DataModule1.zdxbothstandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('800����');
                      Filtered:=true;
                      First;
                    if DataModule1.zdxbothstandgirl.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit5.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg2:=FieldValues['�ɼ�'];
                           dj2:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit5.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg2:=FieldValues['�ɼ�'];
                               dj2:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit5.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg2:=FieldValues['�ɼ�'];
                          dj2:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg2:=0;
                    end;
                end
              else
                cg2:=0;
            /////////////////////////////////////////////////
                   ///     ȡ1000���ܷ�ֵ    ///
                   /////////////////////////////
              if edit6.Text<>'' then                     
                begin
                  with DataModule1.zdxbothstandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('1000����');
                      Filtered:=true;
                      First;
                    if DataModule1.zdxbothstandgirl.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit6.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg3:=FieldValues['�ɼ�'];
                           dj3:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit6.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg3:=FieldValues['�ɼ�'];
                               dj3:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit6.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg3:=FieldValues['�ɼ�'];
                          dj3:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg3:=0;
                    end;
                end
              else
                cg3:=0;
            /////////////////////////////////////////////////
                   ///      ȡ��������ָ��   ///
                   /////////////////////////////
              if edit7.Text<>'' then                  
                begin
                  if (edit3.Text<>'')and(StrToFloat(edit3.Text)<>0) then
                    begin
                      woli:=FloatToStr(StrToFloat(edit7.Text)/StrToFloat(edit3.Text)*100);
                      if pos('.',woli)<>0 then
                        delete(woli,pos('.',woli),length(woli)+1-pos('.',woli));  //ȡ����ֵ
                    end
                  else
                    begin
                      Application.MessageBox('û��������Ϣ�����������أ�','��ʾ');
                      abort;
                    end;
                  with DataModule1.zdxbothstandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('��������ָ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zdxbothstandgirl.RecordCount<>0 then
                      begin
                       if (StrToint(woli)<StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg4:=FieldValues['�ɼ�'];
                           dj4:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(woli)<StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg4:=FieldValues['�ɼ�'];
                               dj4:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(woli)>StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg4:=FieldValues['�ɼ�'];
                          dj4:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg4:=0;
                    end;
                end
              else
                cg4:=0;
            /////////////////////////////////////////////////
                   ///     ȡ�λ�������ָ��  ///
                   /////////////////////////////
              if edit8.Text<>'' then                     
                begin
                  if (edit3.Text<>'')and(StrToFloat(edit3.Text)<>0) then
                    begin
                      feihuoliang:=FloatToStr(StrToFloat(edit8.Text)/StrToFloat(edit3.Text));
                      if pos('.',feihuoliang)<>0 then
                        delete(feihuoliang,pos('.',feihuoliang),length(feihuoliang)+1-pos('.',feihuoliang));  //ȡ����ֵ
                    end
                  else
                    begin
                      Application.MessageBox('û��������Ϣ�����������أ�','��ʾ');
                      abort;
                    end;
                  with DataModule1.zdxbothstandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('�λ�������ָ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zdxbothstandgirl.RecordCount<>0 then
                      begin
                       if (StrToint(feihuoliang)<StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg5:=FieldValues['�ɼ�'];
                           dj5:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(feihuoliang)<StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg5:=FieldValues['�ɼ�'];
                               dj5:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(feihuoliang)>StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg5:=FieldValues['�ɼ�'];
                          dj5:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg5:=0;
                    end;
                end
              else
                cg5:=0;
            /////////////////////////////////////////////////
                   ///     ȡ������ǰ���ɼ�   ///
                   /////////////////////////////
              if edit9.Text<>'' then                     
                begin
                  with DataModule1.zdxbothstandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������ǰ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zdxbothstandgirl.RecordCount<>0 then
                      begin
                       if (StrTofloat(edit9.Text)<StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                         begin
                           cg6:=FieldValues['�ɼ�'];
                           dj6:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrTofloat(edit9.Text)<StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                               begin
                               cg6:=FieldValues['�ɼ�'];
                               dj6:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrTofloat(edit9.Text)>StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                          begin
                          cg6:=FieldValues['�ɼ�'];
                          dj6:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg6:=0;
                    end;
                end
              else
                cg6:=0;
            /////////////////////////////////////////////////
                   ///     ȡ������Զ�ɼ�    ///
                   /////////////////////////////
              if edit10.Text<>'' then
                begin
                  with DataModule1.zdxbothstandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������Զ');
                      Filtered:=true;
                      First;
                    if DataModule1.zdxbothstandgirl.RecordCount<>0 then
                      begin
                       if (StrToint(edit10.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg7:=FieldValues['�ɼ�'];
                           dj7:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(edit10.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg7:=FieldValues['�ɼ�'];
                               dj7:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(edit10.Text)>StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg7:=FieldValues['�ɼ�'];
                          dj7:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg7:=0;
                    end;
                end
              else
                cg7:=0;
            /////////////////////////////////////////////////
                   ///     ȡ���������ɼ�    ///
                   /////////////////////////////
              if edit11.Text<>'' then
                begin
                  with DataModule1.zdxbothstandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������Զ');
                      Filtered:=true;
                      First;
                    if DataModule1.zdxbothstandgirl.RecordCount<>0 then
                      begin
                       if (StrToint(edit11.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg8:=FieldValues['�ɼ�'];
                           dj8:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(edit11.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg8:=FieldValues['�ɼ�'];
                               dj8:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(edit11.Text)>StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg8:=FieldValues['�ɼ�'];
                          dj8:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg8:=0;
                    end;
                end
              else
                cg8:=0;
////////////////////////////////////////////////////////////////////////////////
        ///              ȡ��ѧŮ����߱�׼���سɼ�                     ///
        ///////////////////////////////////////////////////////////////////
              if (edit2.Text<>'')and(edit3.Text<>'') then
                begin
                  with  DataModule1.zdxstandhgirl do
                    begin
                      if DataModule1.zdxstandhgirl.RecordCount<>0 then
                        begin
                          First;
                          if (StrToFloat(edit2.Text)<strtofloat(FieldValues['��߶�'])) then
                            begin
                              if application.MessageBox('��ߵ������ֵ��'+#13+'����������׼�������أ�'+#13+'�Ƿ����ִ��','����',MB_YESNO)=6 then
                                vheight:=FloatToStr((StrToFloat(FieldValues['��߶�'])-StrToFloat(edit2.Text)) * 0.5+StrToFloat(edit3.Text))
                              else vheight:=edit3.Text;
                                  if (StrToFloat(vheight)<strtofloat(FieldValues['���ض�1'])) then
                                     cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�2'])) then
                                     cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�3'])) then
                                     cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�4'])) then
                                     cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                  else if  (StrToFloat(vheight)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�5'])) then
                                     cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                            end
                          else
                            while eof<>true do
                              begin
                                if (StrToFloat(edit2.Text)<StrToFloat(FieldValues['��߶�']))or(StrToFloat(edit2.Text)=strtofloat(FieldValues['��߶�'])) then
                                  begin
                                    if (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�1'])) then
                                       cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�2'])) then
                                       cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�3'])) then
                                       cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�4'])) then
                                       cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                    else if  (StrToFloat(edit3.Text)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�5'])) then
                                       cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                                    Last;
                                  end;
                                if Eof<>true then
                                  Next;
                              end;
                            if eof=True then
                            if (StrToFloat(edit2.Text)>StrToFloat(FieldValues['��߶�'])) then
                              begin
                                if application.MessageBox('��߳������ֵ�����ձ�׼���أ�'+#13+'�Ƿ����ִ�иò�����','����',MB_YESNO)=6 then
                                  vheight:=FloatToStr(strtofloat(edit3.Text)-(StrToFloat(edit2.Text)-StrToFloat(FieldValues['��߶�']))*0.9)
                                else vheight:=edit3.Text;
                                    if (StrToFloat(vheight)<strtofloat(FieldValues['���ض�1'])) then
                                       cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�2'])) then
                                       cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�3'])) then
                                       cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�4'])) then
                                       cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                    else if  (StrToFloat(vheight)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�5'])) then
                                       cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                              end;
                        end
                      else
                        cg9:=0;
                    end;
                end
              else
                cg9:=0;
////////////////////////////////////////////////////////////////////////////////
            end;
////////////////////////////////////////////////////////////////////////////////
////////////                 ��ѧ������                     ////////////////////
////////////////////////////////////////////////////////////////////////////////
        end
      else if ((year<4)and(grade='��ר'))or((year<4)and(grade='����'))or((year<4)and(grade='�����Ƹ�ְ')) then
        begin
          if year=1 then
            begin
////////////////////////////////////////////////////////////////////////////////
////////////            ȡ��һ�������ɼ�����                       /////////////
////////////////////////////////////////////////////////////////////////////////
              if sex='��' then
                begin
            /////////////////////////////////////////////////
                   ///      ȡ50���ܷ�ֵ     ///
                   /////////////////////////////
              if edit4.Text<>'' then                     
                begin
                  with DataModule1.zgzonestandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('50����');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzonestandboy.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit4.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg1:=FieldValues['�ɼ�'];
                           dj1:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit4.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                                 cg1:=FieldValues['�ɼ�'];
                                 dj1:=FieldValues['�ȼ�'];
                                 Last;
                               end;
                               if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit4.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg1:=FieldValues['�ɼ�'];
                          dj1:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg1:=0;
                    end;
                end
              else
                cg1:=0;
            /////////////////////////////////////////////////
                   ///     ȡ800���ܷ�ֵ    ///
                   /////////////////////////////
              if edit5.Text<>'' then                     
                begin
                  with DataModule1.zgzonestandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('800����');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzonestandboy.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit5.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg2:=FieldValues['�ɼ�'];
                           dj2:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit5.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg2:=FieldValues['�ɼ�'];
                               dj2:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit5.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg2:=FieldValues['�ɼ�'];
                          dj2:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg2:=0;
                    end;
                end
              else
                cg2:=0;
            /////////////////////////////////////////////////
                   ///     ȡ1000���ܷ�ֵ    ///
                   /////////////////////////////
              if edit6.Text<>'' then                     
                begin
                  with DataModule1.zgzonestandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('1000����');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzonestandboy.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit6.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg3:=FieldValues['�ɼ�'];
                           dj3:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit6.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg3:=FieldValues['�ɼ�'];
                               dj3:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit6.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg3:=FieldValues['�ɼ�'];
                          dj3:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg3:=0;
                    end;
                end
              else
                cg3:=0;
            /////////////////////////////////////////////////
                   ///      ȡ��������ָ��   ///
                   /////////////////////////////
              if edit7.Text<>'' then                  
                begin
                  if (edit3.Text<>'')and(StrToFloat(edit3.Text)<>0) then
                    begin
                      woli:=FloatToStr(StrToFloat(edit7.Text)/StrToFloat(edit3.Text)*100);
                      if pos('.',woli)<>0 then
                        delete(woli,pos('.',woli),length(woli)+1-pos('.',woli));  //ȡ����ֵ
                    end
                  else
                    begin
                      Application.MessageBox('û��������Ϣ�����������أ�','��ʾ');
                      abort;
                    end;
                  with DataModule1.zgzonestandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('��������ָ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzonestandboy.RecordCount<>0 then
                      begin
                       if (StrToint(woli)<StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg4:=FieldValues['�ɼ�'];
                           dj4:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(woli)<StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg4:=FieldValues['�ɼ�'];
                               dj4:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(woli)>StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg4:=FieldValues['�ɼ�'];
                          dj4:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg4:=0;
                    end;
                end
              else
                cg4:=0;
            /////////////////////////////////////////////////
                   ///     ȡ�λ�������ָ��  ///
                   /////////////////////////////
              if edit8.Text<>'' then                     
                begin
                  if (edit3.Text<>'')and(StrToFloat(edit3.Text)<>0) then
                    begin
                      feihuoliang:=FloatToStr(StrToFloat(edit8.Text)/StrToFloat(edit3.Text));
                      if pos('.',feihuoliang)<>0 then
                        delete(feihuoliang,pos('.',feihuoliang),length(feihuoliang)+1-pos('.',feihuoliang));  //ȡ����ֵ
                    end
                  else
                    begin
                      Application.MessageBox('û��������Ϣ�����������أ�','��ʾ');
                      abort;
                    end;
                  with DataModule1.zgzonestandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('�λ�������ָ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzonestandboy.RecordCount<>0 then
                      begin
                       if (StrToint(feihuoliang)<StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg5:=FieldValues['�ɼ�'];
                           dj5:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(feihuoliang)<StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg5:=FieldValues['�ɼ�'];
                               dj5:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(feihuoliang)>StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg5:=FieldValues['�ɼ�'];
                          dj5:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg5:=0;
                    end;
                end
              else
                cg5:=0;
            /////////////////////////////////////////////////
                   ///     ȡ������ǰ���ɼ�   ///
                   /////////////////////////////
              if edit9.Text<>'' then                     
                begin
                  with DataModule1.zgzonestandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������ǰ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzonestandboy.RecordCount<>0 then
                      begin
                       if (StrTofloat(edit9.Text)<StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                         begin
                           cg6:=FieldValues['�ɼ�'];
                           dj6:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrTofloat(edit9.Text)<StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                               begin
                               cg6:=FieldValues['�ɼ�'];
                               dj6:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrTofloat(edit9.Text)>StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                          begin
                          cg6:=FieldValues['�ɼ�'];
                          dj6:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg6:=0;
                    end;
                end
              else
                cg6:=0;
            /////////////////////////////////////////////////
                   ///     ȡ������Զ�ɼ�    ///
                   /////////////////////////////
              if edit10.Text<>'' then
                begin
                  with DataModule1.zgzonestandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������Զ');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzonestandboy.RecordCount<>0 then
                      begin
                       if (StrToint(edit10.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg7:=FieldValues['�ɼ�'];
                           dj7:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(edit10.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg7:=FieldValues['�ɼ�'];
                               dj7:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(edit10.Text)>StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg7:=FieldValues['�ɼ�'];
                          dj7:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg7:=0;
                    end;
                end
              else
                cg7:=0;
            /////////////////////////////////////////////////
                   ///     ȡ���������ɼ�    ///
                   /////////////////////////////
              if edit11.Text<>'' then
                begin
                  with DataModule1.zgzonestandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������Զ');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzonestandboy.RecordCount<>0 then
                      begin
                       if (StrToint(edit11.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg8:=FieldValues['�ɼ�'];
                           dj8:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(edit11.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg8:=FieldValues['�ɼ�'];
                               dj8:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(edit11.Text)>StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg8:=FieldValues['�ɼ�'];
                          dj8:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg8:=0;
                    end;
                end
              else
                cg8:=0;
////////////////////////////////////////////////////////////////////////////////
        ///              ȡ��һ������߱�׼���سɼ�                     ///
        ///////////////////////////////////////////////////////////////////
              if (edit2.Text<>'')and(edit3.Text<>'') then
                begin
                  with  DataModule1.zgzstandhboy do
                    begin
                      if DataModule1.zgzstandhboy.RecordCount<>0 then
                        begin
                          First;
                          if (StrToFloat(edit2.Text)<strtofloat(FieldValues['��߶�'])) then
                            begin
                              if application.MessageBox('��ߵ������ֵ��'+#13+'����������׼�������أ�'+#13+'�Ƿ����ִ��','����',MB_YESNO)=6 then
                                vheight:=FloatToStr((StrToFloat(FieldValues['��߶�'])-StrToFloat(edit2.Text)) * 0.5+StrToFloat(edit3.Text))
                              else vheight:=edit3.Text;
                                  if (StrToFloat(vheight)<strtofloat(FieldValues['���ض�1'])) then
                                     cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�2'])) then
                                     cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�3'])) then
                                     cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�4'])) then
                                     cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                  else if  (StrToFloat(vheight)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�5'])) then
                                     cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                            end
                          else
                            while eof<>true do
                              begin
                                if (StrToFloat(edit2.Text)<StrToFloat(FieldValues['��߶�']))or(StrToFloat(edit2.Text)=strtofloat(FieldValues['��߶�'])) then
                                  begin
                                    if (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�1']))then
                                       cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�2'])) then
                                       cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�3'])) then
                                       cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�4'])) then
                                       cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                    else if  (StrToFloat(edit3.Text)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�5'])) then
                                       cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                                    Last;
                                  end;
                                if Eof<>true then
                                  Next;
                                  
                              end;
                            if eof=True then
                            if (StrToFloat(edit2.Text)>StrToFloat(FieldValues['��߶�'])) then
                              begin
                                if application.MessageBox('��߳������ֵ�����ձ�׼���أ�'+#13+'�Ƿ����ִ�иò�����','����',MB_YESNO)=6 then
                                  vheight:=FloatToStr(strtofloat(edit3.Text)-(StrToFloat(edit2.Text)-StrToFloat(FieldValues['��߶�']))*0.9)
                                else vheight:=edit3.Text;  
                                    if (StrToFloat(vheight)<strtofloat(FieldValues['���ض�1'])) then
                                       cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�2'])) then
                                       cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�3'])) then
                                       cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�4'])) then
                                       cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                    else if  (StrToFloat(vheight)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�5'])) then
                                       cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                              end;
                        end
                      else
                        cg9:=0;
                    end;
                end
              else
                cg9:=0;
                end
////////////////////////////////////////////////////////////////////////////////
////////////            ȡ��һ��Ů���ɼ�����                       /////////////
////////////////////////////////////////////////////////////////////////////////
              else if sex='Ů' then
                begin
            /////////////////////////////////////////////////
                   ///      ȡ50���ܷ�ֵ     ///
                   /////////////////////////////
              if edit4.Text<>'' then                     
                begin
                  with DataModule1.zgzonestandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('50����');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzonestandgirl.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit4.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg1:=FieldValues['�ɼ�'];
                           dj1:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit4.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg1:=FieldValues['�ɼ�'];
                               dj1:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit4.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg1:=FieldValues['�ɼ�'];
                          dj1:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg1:=0;
                    end;
                end
              else
                cg1:=0;
            /////////////////////////////////////////////////
                   ///     ȡ800���ܷ�ֵ    ///
                   /////////////////////////////
              if edit5.Text<>'' then                     
                begin
                  with DataModule1.zgzonestandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('800����');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzonestandgirl.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit5.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg2:=FieldValues['�ɼ�'];
                           dj2:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit5.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg2:=FieldValues['�ɼ�'];
                               dj2:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit5.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg2:=FieldValues['�ɼ�'];
                          dj2:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg2:=0;
                    end;
                end
              else
                cg2:=0;
            /////////////////////////////////////////////////
                   ///     ȡ1000���ܷ�ֵ    ///
                   /////////////////////////////
              if edit6.Text<>'' then                     
                begin
                  with DataModule1.zgzonestandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('1000����');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzonestandgirl.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit6.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg3:=FieldValues['�ɼ�'];
                           dj3:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit6.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg3:=FieldValues['�ɼ�'];
                               dj3:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit6.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg3:=FieldValues['�ɼ�'];
                          dj3:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg3:=0;
                    end;
                end
              else
                cg3:=0;
            /////////////////////////////////////////////////
                   ///      ȡ��������ָ��   ///
                   /////////////////////////////
              if edit7.Text<>'' then                  
                begin
                  if (edit3.Text<>'')and(StrToFloat(edit3.Text)<>0) then
                    begin
                      woli:=FloatToStr(StrToFloat(edit7.Text)/StrToFloat(edit3.Text)*100);
                      if pos('.',woli)<>0 then
                        delete(woli,pos('.',woli),length(woli)+1-pos('.',woli));  //ȡ����ֵ
                    end
                  else
                    begin
                      Application.MessageBox('û��������Ϣ�����������أ�','��ʾ');
                      abort;
                    end;
                  with DataModule1.zgzonestandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('��������ָ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzonestandgirl.RecordCount<>0 then
                      begin
                       if (StrToint(woli)<StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg4:=FieldValues['�ɼ�'];
                           dj4:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(woli)<StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg4:=FieldValues['�ɼ�'];
                               dj4:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(woli)>StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg4:=FieldValues['�ɼ�'];
                          dj4:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg4:=0;
                    end;
                end
              else
                cg4:=0;
            /////////////////////////////////////////////////
                   ///     ȡ�λ�������ָ��  ///
                   /////////////////////////////
              if edit8.Text<>'' then                     
                begin
                  if (edit3.Text<>'')and(StrToFloat(edit3.Text)<>0) then
                    begin
                      feihuoliang:=FloatToStr(StrToFloat(edit8.Text)/StrToFloat(edit3.Text));
                      if pos('.',feihuoliang)<>0 then
                        delete(feihuoliang,pos('.',feihuoliang),length(feihuoliang)+1-pos('.',feihuoliang));  //ȡ����ֵ
                    end
                  else
                    begin
                      Application.MessageBox('û��������Ϣ�����������أ�','��ʾ');
                      abort;
                    end;
                  with DataModule1.zgzonestandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('�λ�������ָ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzonestandgirl.RecordCount<>0 then
                      begin
                       if (StrToint(feihuoliang)<StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg5:=FieldValues['�ɼ�'];
                           dj5:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(feihuoliang)<StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg5:=FieldValues['�ɼ�'];
                               dj5:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(feihuoliang)>StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg5:=FieldValues['�ɼ�'];
                          dj5:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg5:=0;
                    end;
                end
              else
                cg5:=0;
            /////////////////////////////////////////////////
                   ///     ȡ������ǰ���ɼ�   ///
                   /////////////////////////////
              if edit9.Text<>'' then                     
                begin
                  with DataModule1.zgzonestandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������ǰ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzonestandgirl.RecordCount<>0 then
                      begin
                       if (StrTofloat(edit9.Text)<StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                         begin
                           cg6:=FieldValues['�ɼ�'];
                           dj6:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrTofloat(edit9.Text)<StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                               begin
                               cg6:=FieldValues['�ɼ�'];
                               dj6:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrTofloat(edit9.Text)>StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                          begin
                          cg6:=FieldValues['�ɼ�'];
                          dj6:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg6:=0;
                    end;
                end
              else
                cg6:=0;
            /////////////////////////////////////////////////
                   ///     ȡ������Զ�ɼ�    ///
                   /////////////////////////////
              if edit10.Text<>'' then
                begin
                  with DataModule1.zgzonestandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������Զ');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzonestandgirl.RecordCount<>0 then
                      begin
                       if (StrToint(edit10.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg7:=FieldValues['�ɼ�'];
                           dj7:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(edit10.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg7:=FieldValues['�ɼ�'];
                               dj7:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(edit10.Text)>StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg7:=FieldValues['�ɼ�'];
                          dj7:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg7:=0;
                    end;
                end
              else
                cg7:=0;
            /////////////////////////////////////////////////
                   ///     ȡ���������ɼ�    ///
                   /////////////////////////////
              if edit11.Text<>'' then
                begin
                  with DataModule1.zgzonestandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������Զ');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzonestandgirl.RecordCount<>0 then
                      begin
                       if (StrToint(edit11.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg8:=FieldValues['�ɼ�'];
                           dj8:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(edit11.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg8:=FieldValues['�ɼ�'];
                               dj8:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(edit11.Text)>StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg8:=FieldValues['�ɼ�'];
                          dj8:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg8:=0;
                    end;
                end
              else
                cg8:=0;
////////////////////////////////////////////////////////////////////////////////
        ///              ȡ��һŮ����߱�׼���سɼ�                     ///
        ///////////////////////////////////////////////////////////////////
              if (edit2.Text<>'')and(edit3.Text<>'') then
                begin
                  with  DataModule1.zgzstandhgirl do
                    begin
                      if DataModule1.zgzstandhgirl.RecordCount<>0 then
                        begin
                          First;
                          if (StrToFloat(edit2.Text)<strtofloat(FieldValues['��߶�']))then
                            begin
                              if application.MessageBox('��ߵ������ֵ��'+#13+'����������׼�������أ�'+#13+'�Ƿ����ִ��','����',MB_YESNO)=6 then
                                vheight:=FloatToStr((StrToFloat(FieldValues['��߶�'])-StrToFloat(edit2.Text)) * 0.5+StrToFloat(edit3.Text))
                              else vheight:=edit3.Text;
                                  if (StrToFloat(vheight)<strtofloat(FieldValues['���ض�1'])) then
                                     cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�2'])) then
                                     cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�3'])) then
                                     cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�4'])) then
                                     cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                  else if  (StrToFloat(vheight)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�5'])) then
                                     cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                            end
                          else
                            while eof<>true do
                              begin
                                if (StrToFloat(edit2.Text)<StrToFloat(FieldValues['��߶�']))or(StrToFloat(edit2.Text)=strtofloat(FieldValues['��߶�'])) then
                                  begin
                                    if (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�1'])) then
                                       cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�2'])) then
                                       cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�3'])) then
                                       cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�4'])) then
                                       cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                    else if  (StrToFloat(edit3.Text)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�5'])) then
                                       cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                                    Last;
                                  end;
                                if Eof<>true then
                                  Next;
                              end;
                            if eof=True then
                            if (StrToFloat(edit2.Text)>StrToFloat(FieldValues['��߶�'])) then
                              begin
                                if application.MessageBox('��߳������ֵ�����ձ�׼���أ�'+#13+'�Ƿ����ִ�иò�����','����',MB_YESNO)=6 then
                                  vheight:=FloatToStr(strtofloat(edit3.Text)-(StrToFloat(edit2.Text)-StrToFloat(FieldValues['��߶�']))*0.9)
                                else vheight:=edit3.Text;
                                    if (StrToFloat(vheight)<strtofloat(FieldValues['���ض�1'])) then
                                       cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�2'])) then
                                       cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�3'])) then
                                       cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�4'])) then
                                       cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                    else if  (StrToFloat(vheight)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�5'])) then
                                       cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                              end;
                        end
                      else
                        cg9:=0;
                    end;
                end
              else
                cg9:=0;
                end;
////////////////////////////////////////////////////////////////////////////////
///////////////////          ��һ�����                     ////////////////////
////////////////////////////////////////////////////////////////////////////////
            end
          else if year=2 then
            begin
////////////////////////////////////////////////////////////////////////////////
////////////            ȡ�߶��������ɼ�����                       /////////////
////////////////////////////////////////////////////////////////////////////////
              if sex='��' then
                begin
            /////////////////////////////////////////////////
                   ///      ȡ50���ܷ�ֵ     ///
                   /////////////////////////////
              if edit4.Text<>'' then
                begin
                  with DataModule1.zgztwostandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('50����');
                      Filtered:=true;
                      First;
                    if DataModule1.zgztwostandboy.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit4.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg1:=FieldValues['�ɼ�'];
                           dj1:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit4.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg1:=FieldValues['�ɼ�'];
                               dj1:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit4.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg1:=FieldValues['�ɼ�'];
                          dj1:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg1:=0;
                    end;
                end
              else
                cg1:=0;
            /////////////////////////////////////////////////
                   ///     ȡ800���ܷ�ֵ    ///
                   /////////////////////////////
              if edit5.Text<>'' then
                begin
                  with DataModule1.zgztwostandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('800����');
                      Filtered:=true;
                      First;
                    if DataModule1.zgztwostandboy.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit5.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg2:=FieldValues['�ɼ�'];
                           dj2:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit5.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg2:=FieldValues['�ɼ�'];
                               dj2:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit5.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg2:=FieldValues['�ɼ�'];
                          dj2:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg2:=0;
                    end;
                end
              else
                cg2:=0;
            /////////////////////////////////////////////////
                   ///     ȡ1000���ܷ�ֵ    ///
                   /////////////////////////////
              if edit6.Text<>'' then
                begin
                  with DataModule1.zgztwostandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('1000����');
                      Filtered:=true;
                      First;
                    if DataModule1.zgztwostandboy.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit6.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg3:=FieldValues['�ɼ�'];
                           dj3:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit6.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg3:=FieldValues['�ɼ�'];
                               dj3:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit6.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg3:=FieldValues['�ɼ�'];
                          dj3:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg3:=0;
                    end;
                end
              else
                cg3:=0;
            /////////////////////////////////////////////////
                   ///      ȡ��������ָ��   ///
                   /////////////////////////////
              if edit7.Text<>'' then
                begin
                  if (edit3.Text<>'')and(StrToFloat(edit3.Text)<>0) then
                    begin
                      woli:=FloatToStr(StrToFloat(edit7.Text)/StrToFloat(edit3.Text)*100);
                      if pos('.',woli)<>0 then
                        delete(woli,pos('.',woli),length(woli)+1-pos('.',woli));  //ȡ����ֵ
                    end
                  else
                    begin
                      Application.MessageBox('û��������Ϣ�����������أ�','��ʾ');
                      abort;
                    end;
                  with DataModule1.zgztwostandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('��������ָ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zgztwostandboy.RecordCount<>0 then
                      begin
                       if (StrToint(woli)<StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg4:=FieldValues['�ɼ�'];
                           dj4:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(woli)<StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg4:=FieldValues['�ɼ�'];
                               dj4:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(woli)>StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg4:=FieldValues['�ɼ�'];
                          dj4:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg4:=0;
                    end;
                end
              else
                cg4:=0;
            /////////////////////////////////////////////////
                   ///     ȡ�λ�������ָ��  ///
                   /////////////////////////////
              if edit8.Text<>'' then
                begin
                  if (edit3.Text<>'')and(StrToFloat(edit3.Text)<>0) then
                    begin
                      feihuoliang:=FloatToStr(StrToFloat(edit8.Text)/StrToFloat(edit3.Text));
                      if pos('.',feihuoliang)<>0 then
                        delete(feihuoliang,pos('.',feihuoliang),length(feihuoliang)+1-pos('.',feihuoliang));  //ȡ����ֵ
                    end
                  else
                    begin
                      Application.MessageBox('û��������Ϣ�����������أ�','��ʾ');
                      abort;
                    end;
                  with DataModule1.zgztwostandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('�λ�������ָ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zgztwostandboy.RecordCount<>0 then
                      begin
                       if (StrToint(feihuoliang)<StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg5:=FieldValues['�ɼ�'];
                           dj5:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(feihuoliang)<StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg5:=FieldValues['�ɼ�'];
                               dj5:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(feihuoliang)>StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg5:=FieldValues['�ɼ�'];
                          dj5:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg5:=0;
                    end;
                end
              else
                cg5:=0;
            /////////////////////////////////////////////////
                   ///     ȡ������ǰ���ɼ�   ///
                   /////////////////////////////
              if edit9.Text<>'' then
                begin
                  with DataModule1.zgztwostandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������ǰ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zgztwostandboy.RecordCount<>0 then
                      begin
                       if (StrTofloat(edit9.Text)<StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                         begin
                           cg6:=FieldValues['�ɼ�'];
                           dj6:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrTofloat(edit9.Text)<StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                               begin
                               cg6:=FieldValues['�ɼ�'];
                               dj6:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrTofloat(edit9.Text)>StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                          begin
                          cg6:=FieldValues['�ɼ�'];
                          dj6:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg6:=0;
                    end;
                end
              else
                cg6:=0;
            /////////////////////////////////////////////////
                   ///     ȡ������Զ�ɼ�    ///
                   /////////////////////////////
              if edit10.Text<>'' then
                begin
                  with DataModule1.zgztwostandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������Զ');
                      Filtered:=true;
                      First;
                    if DataModule1.zgztwostandboy.RecordCount<>0 then
                      begin
                       if (StrToint(edit10.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg7:=FieldValues['�ɼ�'];
                           dj7:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(edit10.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg7:=FieldValues['�ɼ�'];
                               dj7:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(edit10.Text)>StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg7:=FieldValues['�ɼ�'];
                          dj7:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg7:=0;
                    end;
                end
              else
                cg7:=0;
            /////////////////////////////////////////////////
                   ///     ȡ���������ɼ�    ///
                   /////////////////////////////
              if edit11.Text<>'' then
                begin
                  with DataModule1.zgztwostandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������Զ');
                      Filtered:=true;
                      First;
                    if DataModule1.zgztwostandboy.RecordCount<>0 then
                      begin
                       if (StrToint(edit11.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg8:=FieldValues['�ɼ�'];
                           dj8:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(edit11.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg8:=FieldValues['�ɼ�'];
                               dj8:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(edit11.Text)>StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg8:=FieldValues['�ɼ�'];
                          dj8:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg8:=0;
                    end;
                end
              else
                cg8:=0;
////////////////////////////////////////////////////////////////////////////////
        ///              ȡ�߶�������߱�׼���سɼ�                     ///
        ///////////////////////////////////////////////////////////////////
              if (edit2.Text<>'')and(edit3.Text<>'') then
                begin
                  with  DataModule1.zgzstandhboy do
                    begin
                      if DataModule1.zgzstandhboy.RecordCount<>0 then
                        begin
                          First;
                          if (StrToFloat(edit2.Text)<strtofloat(FieldValues['��߶�']))then
                            begin
                              if application.MessageBox('��ߵ������ֵ��'+#13+'����������׼�������أ�'+#13+'�Ƿ����ִ��','����',MB_YESNO)=6 then
                                vheight:=FloatToStr((StrToFloat(FieldValues['��߶�'])-StrToFloat(edit2.Text)) * 0.5+StrToFloat(edit3.Text))
                              else vheight:=edit3.Text;
                                  if (StrToFloat(vheight)<strtofloat(FieldValues['���ض�1'])) then
                                     cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�2'])) then
                                     cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�3'])) then
                                     cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�4'])) then
                                     cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                  else if  (StrToFloat(vheight)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�5'])) then
                                     cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                            end
                          else
                            while eof<>true do
                              begin
                                if (StrToFloat(edit2.Text)<StrToFloat(FieldValues['��߶�']))or(StrToFloat(edit2.Text)=strtofloat(FieldValues['��߶�'])) then
                                  begin
                                    if (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�1'])) then
                                       cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�2'])) then
                                       cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�3'])) then
                                       cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�4'])) then
                                       cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                    else if  (StrToFloat(edit3.Text)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�5'])) then
                                       cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                                    Last;
                                  end;
                                if Eof<>true then
                                  Next;
                              end;
                            if eof=True then
                            if (StrToFloat(edit2.Text)>StrToFloat(FieldValues['��߶�'])) then
                              begin
                                if application.MessageBox('��߳������ֵ�����ձ�׼���أ�'+#13+'�Ƿ����ִ�иò�����','����',MB_YESNO)=6 then
                                  vheight:=FloatToStr(strtofloat(edit3.Text)-(StrToFloat(edit2.Text)-StrToFloat(FieldValues['��߶�']))*0.9)
                                else vheight:=edit3.Text;
                                    if (StrToFloat(vheight)<strtofloat(FieldValues['���ض�1'])) then
                                       cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�2'])) then
                                       cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�3'])) then
                                       cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�4'])) then
                                       cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                    else if  (StrToFloat(vheight)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�5'])) then
                                       cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                              end;
                        end
                      else
                        cg9:=0;
                    end;
                end
              else
                cg9:=0;
                end
////////////////////////////////////////////////////////////////////////////////
////////////            ȡ�߶���Ů���ɼ�����                       /////////////
////////////////////////////////////////////////////////////////////////////////
              else if sex='Ů' then
                begin
            /////////////////////////////////////////////////
                   ///      ȡ50���ܷ�ֵ     ///
                   /////////////////////////////
              if edit4.Text<>'' then
                begin
                  with DataModule1.zgztwostandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('50����');
                      Filtered:=true;
                      First;
                    if DataModule1.zgztwostandgirl.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit4.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg1:=FieldValues['�ɼ�'];
                           dj1:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit4.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg1:=FieldValues['�ɼ�'];
                               dj1:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit4.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg1:=FieldValues['�ɼ�'];
                          dj1:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg1:=0;
                    end;
                end
              else
                cg1:=0;
            /////////////////////////////////////////////////
                   ///     ȡ800���ܷ�ֵ    ///
                   /////////////////////////////
              if edit5.Text<>'' then
                begin
                  with DataModule1.zgztwostandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('800����');
                      Filtered:=true;
                      First;
                    if DataModule1.zgztwostandgirl.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit5.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg2:=FieldValues['�ɼ�'];
                           dj2:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit5.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg2:=FieldValues['�ɼ�'];
                               dj2:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit5.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg2:=FieldValues['�ɼ�'];
                          dj2:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg2:=0;
                    end;
                end
              else
                cg2:=0;
            /////////////////////////////////////////////////
                   ///     ȡ1000���ܷ�ֵ    ///
                   /////////////////////////////
              if edit6.Text<>'' then
                begin
                  with DataModule1.zgztwostandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('1000����');
                      Filtered:=true;
                      First;
                    if DataModule1.zgztwostandgirl.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit6.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg3:=FieldValues['�ɼ�'];
                           dj3:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit6.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg3:=FieldValues['�ɼ�'];
                               dj3:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit6.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg3:=FieldValues['�ɼ�'];
                          dj3:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg3:=0;
                    end;
                end
              else
                cg3:=0;
            /////////////////////////////////////////////////
                   ///      ȡ��������ָ��   ///
                   /////////////////////////////
              if edit7.Text<>'' then
                begin
                  if (edit3.Text<>'')and(StrToFloat(edit3.Text)<>0) then
                    begin
                      woli:=FloatToStr(StrToFloat(edit7.Text)/StrToFloat(edit3.Text)*100);
                      if pos('.',woli)<>0 then
                        delete(woli,pos('.',woli),length(woli)+1-pos('.',woli));  //ȡ����ֵ
                    end
                  else
                    begin
                      Application.MessageBox('û��������Ϣ�����������أ�','��ʾ');
                      abort;
                    end;
                  with DataModule1.zgztwostandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('��������ָ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zgztwostandgirl.RecordCount<>0 then
                      begin
                       if (StrToint(woli)<StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg4:=FieldValues['�ɼ�'];
                           dj4:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(woli)<StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg4:=FieldValues['�ɼ�'];
                               dj4:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(woli)>StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg4:=FieldValues['�ɼ�'];
                          dj4:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg4:=0;
                    end;
                end
              else
                cg4:=0;
            /////////////////////////////////////////////////
                   ///     ȡ�λ�������ָ��  ///
                   /////////////////////////////
              if edit8.Text<>'' then
                begin
                  if (edit3.Text<>'')and(StrToFloat(edit3.Text)<>0) then
                    begin
                      feihuoliang:=FloatToStr(StrToFloat(edit8.Text)/StrToFloat(edit3.Text));
                      if pos('.',feihuoliang)<>0 then
                        delete(feihuoliang,pos('.',feihuoliang),length(feihuoliang)+1-pos('.',feihuoliang));  //ȡ����ֵ
                    end
                  else
                    begin
                      Application.MessageBox('û��������Ϣ�����������أ�','��ʾ');
                      abort;
                    end;
                  with DataModule1.zgztwostandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('�λ�������ָ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zgztwostandgirl.RecordCount<>0 then
                      begin
                       if (StrToint(feihuoliang)<StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg5:=FieldValues['�ɼ�'];
                           dj5:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(feihuoliang)<StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg5:=FieldValues['�ɼ�'];
                               dj5:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(feihuoliang)>StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg5:=FieldValues['�ɼ�'];
                          dj5:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg5:=0;
                    end;
                end
              else
                cg5:=0;
            /////////////////////////////////////////////////
                   ///     ȡ������ǰ���ɼ�   ///
                   /////////////////////////////
              if edit9.Text<>'' then
                begin
                  with DataModule1.zgztwostandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������ǰ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zgztwostandgirl.RecordCount<>0 then
                      begin
                       if (StrTofloat(edit9.Text)<StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                         begin
                           cg6:=FieldValues['�ɼ�'];
                           dj6:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrTofloat(edit9.Text)<StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                               begin
                               cg6:=FieldValues['�ɼ�'];
                               dj6:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrTofloat(edit9.Text)>StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                          begin
                          cg6:=FieldValues['�ɼ�'];
                          dj6:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg6:=0;
                    end;
                end
              else
                cg6:=0;
            /////////////////////////////////////////////////
                   ///     ȡ������Զ�ɼ�    ///
                   /////////////////////////////
              if edit10.Text<>'' then
                begin
                  with DataModule1.zgztwostandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������Զ');
                      Filtered:=true;
                      First;
                    if DataModule1.zgztwostandgirl.RecordCount<>0 then
                      begin
                       if (StrToint(edit10.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg7:=FieldValues['�ɼ�'];
                           dj7:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(edit10.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg7:=FieldValues['�ɼ�'];
                               dj7:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(edit10.Text)>StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg7:=FieldValues['�ɼ�'];
                          dj7:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg7:=0;
                    end;
                end
              else
                cg7:=0;
            /////////////////////////////////////////////////
                   ///     ȡ���������ɼ�    ///
                   /////////////////////////////
              if edit11.Text<>'' then
                begin
                  with DataModule1.zgztwostandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������Զ');
                      Filtered:=true;
                      First;
                    if DataModule1.zgztwostandgirl.RecordCount<>0 then
                      begin
                       if (StrToint(edit11.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg8:=FieldValues['�ɼ�'];
                           dj8:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(edit11.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg8:=FieldValues['�ɼ�'];
                               dj8:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(edit11.Text)>StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg8:=FieldValues['�ɼ�'];
                          dj8:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg8:=0;
                    end;
                end
              else
                cg8:=0;
////////////////////////////////////////////////////////////////////////////////
        ///              ȡ�߶�Ů����߱�׼���سɼ�                     ///
        ///////////////////////////////////////////////////////////////////
              if (edit2.Text<>'')and(edit3.Text<>'') then
                begin
                  with  DataModule1.zgzstandhgirl do
                    begin
                      if DataModule1.zgzstandhgirl.RecordCount<>0 then
                        begin
                          First;
                          if (StrToFloat(edit2.Text)<strtofloat(FieldValues['��߶�']))then
                            begin
                              if application.MessageBox('��ߵ������ֵ��'+#13+'����������׼�������أ�'+#13+'�Ƿ����ִ��','����',MB_YESNO)=6 then
                                vheight:=FloatToStr((StrToFloat(FieldValues['��߶�'])-StrToFloat(edit2.Text)) * 0.5+StrToFloat(edit3.Text))
                              else vheight:=edit3.Text;
                                  if (StrToFloat(vheight)<strtofloat(FieldValues['���ض�1'])) then
                                     cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�2'])) then
                                     cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�3'])) then
                                     cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�4'])) then
                                     cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                  else if  (StrToFloat(vheight)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�5'])) then
                                     cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                            end
                          else
                            while eof<>true do
                              begin
                                if (StrToFloat(edit2.Text)<StrToFloat(FieldValues['��߶�']))or(StrToFloat(edit2.Text)=strtofloat(FieldValues['��߶�'])) then
                                  begin
                                    if (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�1'])) then
                                       cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�2'])) then
                                       cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�3'])) then
                                       cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�4'])) then
                                       cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                    else if  (StrToFloat(edit3.Text)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�5'])) then
                                       cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                                    Last;
                                  end;
                                if Eof<>true then
                                  Next;
                              end;
                            if eof=True then
                            if (StrToFloat(edit2.Text)>StrToFloat(FieldValues['��߶�'])) then
                              begin
                                if application.MessageBox('��߳������ֵ�����ձ�׼���أ�'+#13+'�Ƿ����ִ�иò�����','����',MB_YESNO)=6 then
                                  vheight:=FloatToStr(strtofloat(edit3.Text)-(StrToFloat(edit2.Text)-StrToFloat(FieldValues['��߶�']))*0.9)
                                else vheight:=edit3.Text;
                                    if (StrToFloat(vheight)<strtofloat(FieldValues['���ض�1'])) then
                                       cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�2'])) then
                                       cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�3'])) then
                                       cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�4'])) then
                                       cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                    else if  (StrToFloat(vheight)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�5'])) then
                                       cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                              end;
                        end
                      else
                        cg9:=0;
                    end;
                end
              else
                cg9:=0;
                end;
            end
          else if year=3 then
            begin
////////////////////////////////////////////////////////////////////////////////
////////////            ȡ�����������ɼ�����                       /////////////
////////////////////////////////////////////////////////////////////////////////
              if sex='��' then
                begin
            /////////////////////////////////////////////////
                   ///      ȡ50���ܷ�ֵ     ///
                   /////////////////////////////
              if edit4.Text<>'' then
                begin
                  with DataModule1.zgzthreestandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('50����');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzthreestandboy.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit4.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg1:=FieldValues['�ɼ�'];
                           dj1:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit4.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg1:=FieldValues['�ɼ�'];
                               dj1:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit4.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg1:=FieldValues['�ɼ�'];
                          dj1:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg1:=0;
                    end;
                end
              else
                cg1:=0;
            /////////////////////////////////////////////////
                   ///     ȡ800���ܷ�ֵ    ///
                   /////////////////////////////
              if edit5.Text<>'' then
                begin
                  with DataModule1.zgzthreestandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('800����');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzthreestandboy.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit5.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg2:=FieldValues['�ɼ�'];
                           dj2:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit5.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg2:=FieldValues['�ɼ�'];
                               dj2:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit5.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg2:=FieldValues['�ɼ�'];
                          dj2:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg2:=0;
                    end;
                end
              else
                cg2:=0;
            /////////////////////////////////////////////////
                   ///     ȡ1000���ܷ�ֵ    ///
                   /////////////////////////////
              if edit6.Text<>'' then
                begin
                  with DataModule1.zgzthreestandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('1000����');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzthreestandboy.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit6.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg3:=FieldValues['�ɼ�'];
                           dj3:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit6.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg3:=FieldValues['�ɼ�'];
                               dj3:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit6.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg3:=FieldValues['�ɼ�'];
                          dj3:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg3:=0;
                    end;
                end
              else
                cg3:=0;
            /////////////////////////////////////////////////
                   ///      ȡ��������ָ��   ///
                   /////////////////////////////
              if edit7.Text<>'' then
                begin
                  if (edit3.Text<>'')and(StrToFloat(edit3.Text)<>0) then
                    begin
                      woli:=FloatToStr(StrToFloat(edit7.Text)/StrToFloat(edit3.Text)*100);
                      if pos('.',woli)<>0 then
                        delete(woli,pos('.',woli),length(woli)+1-pos('.',woli));  //ȡ����ֵ
                    end
                  else
                    begin
                      Application.MessageBox('û��������Ϣ�����������أ�','��ʾ');
                      abort;
                    end;
                  with DataModule1.zgzthreestandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('��������ָ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzthreestandboy.RecordCount<>0 then
                      begin
                       if (StrToint(woli)<StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg4:=FieldValues['�ɼ�'];
                           dj4:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(woli)<StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg4:=FieldValues['�ɼ�'];
                               dj4:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(woli)>StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg4:=FieldValues['�ɼ�'];
                          dj4:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg4:=0;
                    end;
                end
              else
                cg4:=0;
            /////////////////////////////////////////////////
                   ///     ȡ�λ�������ָ��  ///
                   /////////////////////////////
              if edit8.Text<>'' then
                begin
                  if (edit3.Text<>'')and(StrToFloat(edit3.Text)<>0) then
                    begin
                      feihuoliang:=FloatToStr(StrToFloat(edit8.Text)/StrToFloat(edit3.Text));
                      if pos('.',feihuoliang)<>0 then
                        delete(feihuoliang,pos('.',feihuoliang),length(feihuoliang)+1-pos('.',feihuoliang));  //ȡ����ֵ
                    end
                  else
                    begin
                      Application.MessageBox('û��������Ϣ�����������أ�','��ʾ');
                      abort;
                    end;
                  with DataModule1.zgzthreestandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('�λ�������ָ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzthreestandboy.RecordCount<>0 then
                      begin
                       if (StrToint(feihuoliang)<StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg5:=FieldValues['�ɼ�'];
                           dj5:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(feihuoliang)<StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg5:=FieldValues['�ɼ�'];
                               dj5:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(feihuoliang)>StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg5:=FieldValues['�ɼ�'];
                          dj5:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg5:=0;
                    end;
                end
              else
                cg5:=0;
            /////////////////////////////////////////////////
                   ///     ȡ������ǰ���ɼ�   ///
                   /////////////////////////////
              if edit9.Text<>'' then
                begin
                  with DataModule1.zgzthreestandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������ǰ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzthreestandboy.RecordCount<>0 then
                      begin
                       if (StrTofloat(edit9.Text)<StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                         begin
                           cg6:=FieldValues['�ɼ�'];
                           dj6:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrTofloat(edit9.Text)<StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                               begin
                               cg6:=FieldValues['�ɼ�'];
                               dj6:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrTofloat(edit9.Text)>StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                          begin
                          cg6:=FieldValues['�ɼ�'];
                          dj6:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg6:=0;
                    end;
                end
              else
                cg6:=0;
            /////////////////////////////////////////////////
                   ///     ȡ������Զ�ɼ�    ///
                   /////////////////////////////
              if edit10.Text<>'' then
                begin
                  with DataModule1.zgzthreestandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������Զ');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzthreestandboy.RecordCount<>0 then
                      begin
                       if (StrToint(edit10.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg7:=FieldValues['�ɼ�'];
                           dj7:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(edit10.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg7:=FieldValues['�ɼ�'];
                               dj7:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(edit10.Text)>StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg7:=FieldValues['�ɼ�'];
                          dj7:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg7:=0;
                    end;
                end
              else
                cg7:=0;
            /////////////////////////////////////////////////
                   ///     ȡ���������ɼ�    ///
                   /////////////////////////////
              if edit11.Text<>'' then
                begin
                  with DataModule1.zgzthreestandboy do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������Զ');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzthreestandboy.RecordCount<>0 then
                      begin
                       if (StrToint(edit11.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg8:=FieldValues['�ɼ�'];
                           dj8:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(edit11.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg8:=FieldValues['�ɼ�'];
                               dj8:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(edit11.Text)>StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg8:=FieldValues['�ɼ�'];
                          dj8:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg8:=0;
                    end;
                end
              else
                cg8:=0;
////////////////////////////////////////////////////////////////////////////////
        ///              ȡ����������߱�׼���سɼ�                     ///
        ///////////////////////////////////////////////////////////////////
              if (edit2.Text<>'')and(edit3.Text<>'') then
                begin
                  with  DataModule1.zgzstandhboy do
                    begin
                      if DataModule1.zgzstandhboy.RecordCount<>0 then
                        begin
                          First;
                          if (StrToFloat(edit2.Text)<strtofloat(FieldValues['��߶�']))then
                            begin
                              if application.MessageBox('��ߵ������ֵ��'+#13+'����������׼�������أ�'+#13+'�Ƿ����ִ��','����',MB_YESNO)=6 then
                                vheight:=FloatToStr((StrToFloat(FieldValues['��߶�'])-StrToFloat(edit2.Text)) * 0.5+StrToFloat(edit3.Text))
                              else vheight:=edit3.Text;
                                  if (StrToFloat(vheight)<strtofloat(FieldValues['���ض�1'])) then
                                     cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�2'])) then
                                     cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�3'])) then
                                     cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�4'])) then
                                     cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                  else if  (StrToFloat(vheight)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�5'])) then
                                     cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                            end
                          else
                            while eof<>true do
                              begin
                                if (StrToFloat(edit2.Text)<StrToFloat(FieldValues['��߶�']))or(StrToFloat(edit2.Text)=strtofloat(FieldValues['��߶�'])) then
                                  begin
                                    if (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�1'])) then
                                       cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�2'])) then
                                       cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�3'])) then
                                       cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�4'])) then
                                       cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                    else if  (StrToFloat(edit3.Text)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�5'])) then
                                       cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                                    Last;
                                  end;
                                if Eof<>true then
                                  Next;
                              end;
                            if eof=True then
                            if (StrToFloat(edit2.Text)>StrToFloat(FieldValues['��߶�'])) then
                              begin
                                if application.MessageBox('��߳������ֵ�����ձ�׼���أ�'+#13+'�Ƿ����ִ�иò�����','����',MB_YESNO)=6 then
                                  vheight:=FloatToStr(strtofloat(edit3.Text)-(StrToFloat(edit2.Text)-StrToFloat(FieldValues['��߶�']))*0.9)
                                else vheight:=edit3.Text;
                                    if (StrToFloat(vheight)<strtofloat(FieldValues['���ض�1'])) then
                                       cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�2'])) then
                                       cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�3'])) then
                                       cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�4'])) then
                                       cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                    else if  (StrToFloat(vheight)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�5'])) then
                                       cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                              end;
                        end
                      else
                        cg9:=0;
                    end;
                end
              else
                cg9:=0;
                end
////////////////////////////////////////////////////////////////////////////////
////////////            ȡ������Ů���ɼ�����                       /////////////
////////////////////////////////////////////////////////////////////////////////
              else if sex='Ů' then
                begin
            /////////////////////////////////////////////////
                   ///      ȡ50���ܷ�ֵ     ///
                   /////////////////////////////
              if edit4.Text<>'' then
                begin
                  with DataModule1.zgzthreestandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('50����');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzthreestandgirl.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit4.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg1:=FieldValues['�ɼ�'];
                           dj1:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit4.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg1:=FieldValues['�ɼ�'];
                               dj1:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit4.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit4.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg1:=FieldValues['�ɼ�'];
                          dj1:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg1:=0;
                    end;
                end
              else
                cg1:=0;
            /////////////////////////////////////////////////
                   ///     ȡ800���ܷ�ֵ    ///
                   /////////////////////////////
              if edit5.Text<>'' then
                begin
                  with DataModule1.zgzthreestandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('800����');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzthreestandgirl.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit5.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg2:=FieldValues['�ɼ�'];
                           dj2:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit5.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg2:=FieldValues['�ɼ�'];
                               dj2:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit5.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit5.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg2:=FieldValues['�ɼ�'];
                          dj2:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg2:=0;
                    end;
                end
              else
                cg2:=0;
            /////////////////////////////////////////////////
                   ///     ȡ1000���ܷ�ֵ    ///
                   /////////////////////////////
              if edit6.Text<>'' then
                begin
                  with DataModule1.zgzthreestandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('1000����');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzthreestandgirl.RecordCount<>0 then
                      begin
                       if (StrToFloat(edit6.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                         begin
                           cg3:=FieldValues['�ɼ�'];
                           dj3:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToFloat(edit6.Text)<StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                               begin
                               cg3:=FieldValues['�ɼ�'];
                               dj3:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToFloat(edit6.Text)>StrToFloat(FieldValues['����ֵ']))or(StrToFloat(edit6.Text)=StrToFloat(FieldValues['����ֵ'])) then
                          begin
                          cg3:=FieldValues['�ɼ�'];
                          dj3:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg3:=0;
                    end;
                end
              else
                cg3:=0;
            /////////////////////////////////////////////////
                   ///      ȡ��������ָ��   ///
                   /////////////////////////////
              if edit7.Text<>'' then
                begin
                  if (edit3.Text<>'')and(StrToFloat(edit3.Text)<>0) then
                    begin
                      woli:=FloatToStr(StrToFloat(edit7.Text)/StrToFloat(edit3.Text)*100);
                      if pos('.',woli)<>0 then
                        delete(woli,pos('.',woli),length(woli)+1-pos('.',woli));  //ȡ����ֵ
                    end
                  else
                    begin
                      Application.MessageBox('û��������Ϣ�����������أ�','��ʾ');
                      abort;
                    end;
                  with DataModule1.zgzthreestandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('��������ָ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzthreestandgirl.RecordCount<>0 then
                      begin
                       if (StrToint(woli)<StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg4:=FieldValues['�ɼ�'];
                           dj4:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(woli)<StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg4:=FieldValues['�ɼ�'];
                               dj4:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(woli)>StrToint(FieldValues['����ֵ']))or(StrToint(woli)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg4:=FieldValues['�ɼ�'];
                          dj4:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg4:=0;
                    end;
                end
              else
                cg4:=0;
            /////////////////////////////////////////////////
                   ///     ȡ�λ�������ָ��  ///
                   /////////////////////////////
              if edit8.Text<>'' then
                begin
                  if (edit3.Text<>'')and(StrToFloat(edit3.Text)<>0) then
                    begin
                      feihuoliang:=FloatToStr(StrToFloat(edit8.Text)/StrToFloat(edit3.Text));
                      if pos('.',feihuoliang)<>0 then
                        delete(feihuoliang,pos('.',feihuoliang),length(feihuoliang)+1-pos('.',feihuoliang));  //ȡ����ֵ
                    end
                  else
                    begin
                      Application.MessageBox('û��������Ϣ�����������أ�','��ʾ');
                      abort;
                    end;
                  with DataModule1.zgzthreestandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('�λ�������ָ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzthreestandgirl.RecordCount<>0 then
                      begin
                       if (StrToint(feihuoliang)<StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg5:=FieldValues['�ɼ�'];
                           dj5:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(feihuoliang)<StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg5:=FieldValues['�ɼ�'];
                               dj5:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(feihuoliang)>StrToint(FieldValues['����ֵ']))or(StrToint(feihuoliang)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg5:=FieldValues['�ɼ�'];
                          dj5:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg5:=0;
                    end;
                end
              else
                cg5:=0;
            /////////////////////////////////////////////////
                   ///     ȡ������ǰ���ɼ�   ///
                   /////////////////////////////
              if edit9.Text<>'' then
                begin
                  with DataModule1.zgzthreestandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������ǰ��');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzthreestandgirl.RecordCount<>0 then
                      begin
                       if (StrTofloat(edit9.Text)<StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                         begin
                           cg6:=FieldValues['�ɼ�'];
                           dj6:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrTofloat(edit9.Text)<StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                               begin
                               cg6:=FieldValues['�ɼ�'];
                               dj6:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrTofloat(edit9.Text)>StrTofloat(FieldValues['����ֵ']))or(StrTofloat(edit9.Text)=StrTofloat(FieldValues['����ֵ'])) then
                          begin
                          cg6:=FieldValues['�ɼ�'];
                          dj6:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg6:=0;
                    end;
                end
              else
                cg6:=0;
            /////////////////////////////////////////////////
                   ///     ȡ������Զ�ɼ�    ///
                   /////////////////////////////
              if edit10.Text<>'' then
                begin
                  with DataModule1.zgzthreestandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������Զ');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzthreestandgirl.RecordCount<>0 then
                      begin
                       if (StrToint(edit10.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg7:=FieldValues['�ɼ�'];
                           dj7:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(edit10.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg7:=FieldValues['�ɼ�'];
                               dj7:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(edit10.Text)>StrToint(FieldValues['����ֵ']))or(StrToint(edit10.Text)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg7:=FieldValues['�ɼ�'];
                          dj7:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg7:=0;
                    end;
                end
              else
                cg7:=0;
            /////////////////////////////////////////////////
                   ///     ȡ���������ɼ�    ///
                   /////////////////////////////
              if edit11.Text<>'' then
                begin
                  with DataModule1.zgzthreestandgirl do
                    begin
                      Filter:='��Ŀ='+QuotedStr('������Զ');
                      Filtered:=true;
                      First;
                    if DataModule1.zgzthreestandgirl.RecordCount<>0 then
                      begin
                       if (StrToint(edit11.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                         begin
                           cg8:=FieldValues['�ɼ�'];
                           dj8:=FieldValues['�ȼ�'];
                         end
                       else
                         while Eof<>true do
                           begin
                             if (StrToint(edit11.Text)<StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                               begin
                               cg8:=FieldValues['�ɼ�'];
                               dj8:=FieldValues['�ȼ�'];
                               Last;
                               end;
                             if Eof<>true then
                               Next;
                           end;
                      if Eof=true then
                        if (StrToint(edit11.Text)>StrToint(FieldValues['����ֵ']))or(StrToint(edit11.Text)=StrToint(FieldValues['����ֵ'])) then
                          begin
                          cg8:=FieldValues['�ɼ�'];
                          dj8:=FieldValues['�ȼ�'];
                          end;
                      end
                    else
                      cg8:=0;
                    end;
                end
              else
                cg8:=0;
////////////////////////////////////////////////////////////////////////////////
        ///              ȡ����Ů����߱�׼���سɼ�                     ///
        ///////////////////////////////////////////////////////////////////
              if (edit2.Text<>'')and(edit3.Text<>'') then
                begin
                  with  DataModule1.zgzstandhgirl do
                    begin
                      if DataModule1.zgzstandhgirl.RecordCount<>0 then
                        begin
                          First;
                          if (StrToFloat(edit2.Text)<strtofloat(FieldValues['��߶�']))then
                            begin
                              if application.MessageBox('��ߵ������ֵ��'+#13+'����������׼�������أ�'+#13+'�Ƿ����ִ��','����',MB_YESNO)=6 then
                                vheight:=FloatToStr((StrToFloat(FieldValues['��߶�'])-StrToFloat(edit2.Text)) * 0.5+StrToFloat(edit3.Text))
                              else vheight:=edit3.Text;
                                  if (StrToFloat(vheight)<strtofloat(FieldValues['���ض�1'])) then
                                     cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�2'])) then
                                     cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�3'])) then
                                     cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                  else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�4'])) then
                                     cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                  else if  (StrToFloat(vheight)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�5'])) then
                                     cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                            end
                          else
                            while eof<>true do
                              begin
                                if (StrToFloat(edit2.Text)<StrToFloat(FieldValues['��߶�']))or(StrToFloat(edit2.Text)=strtofloat(FieldValues['��߶�'])) then
                                  begin
                                    if (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�1'])) then
                                       cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�2'])) then
                                       cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�3'])) then
                                       cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                    else if  (StrToFloat(edit3.Text)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�4'])) then
                                       cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                    else if  (StrToFloat(edit3.Text)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(edit3.Text)=strtofloat(FieldValues['���ض�5'])) then
                                       cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                                    Last;
                                  end;
                                if Eof<>true then
                                  Next;
                              end;
                            if eof=True then
                            if (StrToFloat(edit2.Text)>StrToFloat(FieldValues['��߶�'])) then
                              begin
                                if application.MessageBox('��߳������ֵ�����ձ�׼���أ�'+#13+'�Ƿ����ִ�иò�����','����',MB_YESNO)=6 then
                                  vheight:=FloatToStr(strtofloat(edit3.Text)-(StrToFloat(edit2.Text)-StrToFloat(FieldValues['��߶�']))*0.9)
                                else vheight:=edit3.Text;
                                    if (StrToFloat(vheight)<strtofloat(FieldValues['���ض�1'])) then
                                       cg9:=strtoint(FieldValues['���ض�1��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�2']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�2'])) then
                                       cg9:=strtoint(FieldValues['���ض�2��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�3']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�3'])) then
                                       cg9:=strtoint(FieldValues['���ض�3��ֵ'])
                                    else if  (StrToFloat(vheight)<strtofloat(FieldValues['���ض�4']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�4'])) then
                                       cg9:=strtoint(FieldValues['���ض�4��ֵ'])
                                    else if  (StrToFloat(vheight)>strtofloat(FieldValues['���ض�5']))or(StrToFloat(vheight)=strtofloat(FieldValues['���ض�5'])) then
                                       cg9:=strtoint(FieldValues['���ض�5��ֵ']);
                              end;
                        end
                      else
                        cg9:=0;
                    end;
                end
              else
                cg9:=0;
                end;
            end;
        end
      else
        Application.MessageBox('���������Ϣ�����Ƿ���ȷ��','��ʾ');
    end;
if edit1.Text<>'' then
  begin
    edit12.Text:=IntToStr(cg1+cg2+cg3+cg4+cg5+cg6+cg7+cg8+cg9);
    BitBtn2.Enabled:=true;
    BitBtn3.Enabled:=true;
  end
else
  Application.MessageBox('�Ҳ��������Ϣ��','��ʾ');
end;

procedure Tchengjiform.Edit2Exit(Sender: TObject);
begin
if pos('.',edit2.Text)<>0 then
 if copy(edit2.Text,pos('.',edit2.Text)+1,1)='' then
   begin
     edit2.Text:=edit2.Text+'0';
   end;
if pos('.',edit2.Text)=1 then
  edit2.Text:='0'+edit2.Text;
if edit2.Text<>'' then
if StrToFloat(edit2.Text)>250 then
  if Application.MessageBox('����������������Ƿ����'+#13+'�Ƿ����ִ�У�','����',MB_YESNO)=7 then
    begin
      edit2.SetFocus;
      edit2.SelectAll;
    end;
end;

procedure Tchengjiform.Edit3Exit(Sender: TObject);
begin
if pos('.',edit3.Text)<>0 then
 if copy(edit3.Text,pos('.',edit3.Text)+1,1)='' then
   begin
     edit3.Text:=edit3.Text+'0';
   end;
if pos('.',edit3.Text)=1 then
  edit3.Text:='0'+edit3.Text;
if edit3.Text<>'' then
if StrTofloat(edit3.Text)>150 then
  if Application.MessageBox('����������������Ƿ����'+#13+'�Ƿ����ִ�У�','����',MB_YESNO)=7 then
    begin
      edit3.SetFocus;
      edit3.SelectAll;
    end;
end;

procedure Tchengjiform.Edit7Exit(Sender: TObject);
begin
if pos('.',edit7.Text)<>0 then
 if copy(edit7.Text,pos('.',edit7.Text)+1,1)='' then
   begin
     edit7.Text:=edit7.Text+'0';
   end;
if pos('.',edit7.Text)=1 then
  edit7.Text:='0'+edit7.Text;
if edit7.Text<>'' then
if StrTofloat(edit7.Text)>100 then
  if Application.MessageBox('����������������Ƿ����'+#13+'�Ƿ����ִ�У�','����',MB_YESNO)=7 then
    begin
      edit7.SetFocus;
      edit7.SelectAll;
    end;
end;

procedure Tchengjiform.Edit8Exit(Sender: TObject);
begin
if pos('.',edit8.Text)<>0 then
 if copy(edit8.Text,pos('.',edit8.Text)+1,1)='' then
   begin
     edit8.Text:=edit8.Text+'0';
   end;
if pos('.',edit8.Text)=1 then
  edit8.Text:='0'+edit8.Text;
if edit8.Text<>'' then
if StrTofloat(edit8.Text)>9999 then
  if Application.MessageBox('����������������Ƿ����'+#13+'�Ƿ����ִ�У�','����',MB_YESNO)=7 then
    begin
      edit8.SetFocus;
      edit8.SelectAll;
    end;
end;

procedure Tchengjiform.Edit10Exit(Sender: TObject);
begin
if edit10.Text<>'' then
if StrToInt(edit10.Text)>350 then
  if Application.MessageBox('����������������Ƿ����'+#13+'�Ƿ����ִ�У�','����',MB_YESNO)=7 then
    begin
      edit10.SetFocus;
      edit10.SelectAll;
    end;
end;

procedure Tchengjiform.Edit11Exit(Sender: TObject);
begin
if edit11.Text<>'' then
if StrToInt(edit11.Text)>100 then
  if Application.MessageBox('����������������Ƿ����'+#13+'�Ƿ����ִ�У�','����',MB_YESNO)=7 then
    begin
      edit11.SetFocus;
      edit11.SelectAll;
    end;
end;

procedure Tchengjiform.Edit4Exit(Sender: TObject);
begin
if pos('.',edit4.Text)<>0 then
 if copy(edit4.Text,pos('.',edit4.Text)+1,1)='' then
   begin
     edit4.Text:=edit4.Text+'0';
   end;
if pos('.',edit4.Text)=1 then
  edit4.Text:='0'+edit4.Text;
end;

procedure Tchengjiform.Edit5Exit(Sender: TObject);
begin
if (DBGrid1.DataSource<>DataModule1.Dnull)and(DBGrid1.DataSource.DataSet.RecordCount<>0 )and(edit5.Text<>'') then
  begin
    if DBGrid1.DataSource.DataSet.FieldValues['ѧ���Ա�']='��' then
      begin
        if Application.MessageBox('Ӧ����1000���������� �Ƿ������','��ʾ',MB_YESNO)=7 then
          begin
            edit5.Clear;
            edit6.SetFocus;
          end;
      end;
  end;
if pos('.',edit5.Text)<>0 then
 if copy(edit5.Text,pos('.',edit4.Text)+1,1)='' then
   begin
     edit5.Text:=edit5.Text+'0';
   end;
if pos('.',edit5.Text)=1 then
  edit5.Text:='0'+edit5.Text;
end;

procedure Tchengjiform.Edit6Exit(Sender: TObject);
begin
if (DBGrid1.DataSource<>DataModule1.Dnull)and(DBGrid1.DataSource.DataSet.RecordCount<>0 )and(edit6.Text<>'') then
  begin
    if DBGrid1.DataSource.DataSet.FieldValues['ѧ���Ա�']='Ů' then
      begin
        if Application.MessageBox('Ӧ����800���������� �Ƿ������','��ʾ',MB_YESNO)=7 then
          begin
            edit6.Clear;
            edit5.SetFocus;
          end;
      end;
  end;
if pos('.',edit6.Text)<>0 then
 if copy(edit6.Text,pos('.',edit4.Text)+1,1)='' then
   begin
     edit6.Text:=edit6.Text+'0';
   end;
if pos('.',edit6.Text)=1 then
  edit6.Text:='0'+edit6.Text;
end;

procedure Tchengjiform.Edit9Exit(Sender: TObject);
begin
if pos('.',edit9.Text)<>0 then
 if copy(edit9.Text,pos('.',edit9.Text)+1,1)='' then
   begin
     edit9.Text:=edit9.Text+'0';
   end;
if pos('.',edit9.Text)=1 then
  edit9.Text:='0'+edit9.Text;
end;

procedure Tchengjiform.BitBtn4Click(Sender: TObject);
begin
if (edit1.Text<>'')and(DataModule1.dstugread.DataSet.RecordCount<>0)then
  begin
    if DataModule1.Ddengji.DataSet.Locate('ѧ�����',edit1.Text,[])=true then
      begin
        DataModule1.Ddengji.DataSet.Delete;                                      //�ȼ���Ϣɾ��
      end;
    if DataModule1.Dstugreadinfo.DataSet.Locate('ѧ�����',edit1.Text,[])=true then
      begin
        DataModule1.Dstugreadinfo.DataSet.Delete;                                //�ɼ���Ϣɾ��
      end;
    if  DataModule1.dstugread.DataSet.Locate('ѧ�����',edit1.Text,[])=true then
      begin
         DataModule1.dstugread.DataSet.Delete;                                   //ԭʼ��Ϣɾ��
         BitBtn5.Click;
         Application.MessageBox('��ѧ���ɼ��Ա������','��ʾ');
      end;
      Refresh;
  end
else
  Application.MessageBox('û�д�ѧ���ɼ���¼��','��ʾ');
end;

procedure Tchengjiform.BitBtn2Click(Sender: TObject);
begin
if (edit1.Text<>'')and(edit12.Text<>'')and(DataModule1.dstugread.DataSet.Locate('ѧ�����',edit1.Text,[]))=false then
  begin
    with DataModule1.dstugread.DataSet do     //ԭʼ¼�������ύ
      begin
        Append;
        FieldByName('ѧ�����').AsString:=edit1.Text;
        if edit2.Text<>''then
        FieldByName('���').AsString:=edit2.Text
        else FieldByName('���').AsString:='��';
        if edit3.Text<>'' then
        FieldByName('����').AsString:=edit3.Text
        else FieldByName('����').AsString:='��';
        if edit4.Text<>'' then
        FieldByName('50����').AsString:=edit4.Text
        else  FieldByName('50����').AsString:='��';
        if edit5.Text<>'' then
        FieldByName('800����').AsString:=edit5.Text
        else FieldByName('800����').AsString:='��';
        if edit6.Text<>'' then
        FieldByName('1000����').AsString:=edit6.Text
        else FieldByName('1000����').AsString:='��';
        if edit7.Text<>'' then
          begin
            FieldByName('��������').AsString:=edit7.Text;
            FieldByName('��������ָ��').AsString:=woli;
          end
        else begin
             FieldByName('��������').AsString:='��';
             FieldByName('��������ָ��').AsString:='��';
        end;
        if edit8.Text<>''then
        begin
        FieldByName('�λ�������').AsString:=edit8.Text;
        FieldByName('�λ�������ָ��').AsString:=feihuoliang;
        end
        else  begin
          FieldByName('�λ�������').AsString:='��';
          FieldByName('�λ�������ָ��').AsString:='��';
        end;
        if edit9.Text<>'' then
        FieldByName('������ǰ��').AsString:=edit9.Text
        else  FieldByName('������ǰ��').AsString:='��';
        if edit10.Text<>'' then
        FieldByName('������Զ').AsString:=edit10.Text
        else FieldByName('������Զ').AsString:='��';
        if edit11.Text<>'' then
        FieldByName('��������').AsString:=edit11.Text
        else FieldByName('��������').AsString:='��';
        FieldByName('�ܳɼ�').AsString:=edit12.Text;
        case  StrToInt(edit12.Text) of
          0..59:  FieldByName('�ȼ�����').AsString:='������';
          60..75: FieldByName('�ȼ�����').AsString:='����';
          76..85: FieldByName('�ȼ�����').AsString:='��';
          86..100:FieldByName('�ȼ�����').AsString:='��';
        end;
        Post;
      end;
      With DataModule1.Ddengji.DataSet do                 //���ɵȼ���Ϣ�ύ
        begin
          Append;
          FieldByName('ѧ�����').AsString:=edit1.Text;
          FieldByName('50���ܵȼ�').AsString:=dj1;
          FieldByName('800���ܵȼ�').AsString:=dj2;
          FieldByName('1000���ܵȼ�').AsString:=dj3;
          FieldByName('��������ָ���ȼ�').AsString:=dj4;
          FieldByName('�λ�������ָ���ȼ�').AsString:=dj5;
          FieldByName('������ǰ���ȼ�').AsString:=dj6;
          FieldByName('������Զ�ȼ�').AsString:=dj7;
          FieldByName('���������ȼ�').AsString:=dj8;
          Post;
        end;
      With DataModule1.Dstugreadinfo.DataSet do                    //����ɼ��ύ
        begin
          Append;
          FieldByName('ѧ�����').AsString:=edit1.Text;
          FieldByName('50���ܳɼ�').AsString:=inttostr(cg1);
          FieldByName('800���ܳɼ�').AsString:=inttostr(cg2);
          FieldByName('1000���ܳɼ�').AsString:=inttostr(cg3);
          FieldByName('��������ָ���ɼ�').AsString:=inttostr(cg4);
          FieldByName('�λ�������ָ���ɼ�').AsString:=inttostr(cg5);
          FieldByName('������ǰ���ɼ�').AsString:=inttostr(cg6);
          FieldByName('������Զ�ɼ�').AsString:=inttostr(cg7);
          FieldByName('���������ɼ�').AsString:=inttostr(cg8);
          FieldByName('������سɼ�').AsString:=inttostr(cg9);
          Post;
        end;
      Application.MessageBox('������ȫ���ύ�ɹ���','��ʾ');
    end
    else
      Application.MessageBox('���ȶ����ݽ��л��ܲ�����'+#13+'�ж��Ƿ��и�ѧ����Ŵ��ڣ�'+#13+'�����Ѿ����ڸ�ѧ���ɼ�','��ʾ');
    BitBtn2.Enabled:=false;
    BitBtn3.Enabled:=false;
    BitBtn5.Click;
end;

procedure Tchengjiform.BitBtn3Click(Sender: TObject);
begin
if DataModule1.dstugread.DataSet.RecordCount<>0 then
  begin
    if (edit1.Text<>'')and(edit12.Text<>'') then
      begin
        with DataModule1.dstugread.DataSet do
          begin
           if Locate('ѧ�����',edit1.Text,[])=true then
             begin
             Edit;
             FieldByName('ѧ�����').AsString:=edit1.Text;
             if edit2.Text<>''then
             FieldByName('���').AsString:=edit2.Text
             else FieldByName('���').AsString:='��';
             if edit3.Text<>'' then
             FieldByName('����').AsString:=edit3.Text
             else FieldByName('����').AsString:='��';
             if edit4.Text<>'' then
             FieldByName('50����').AsString:=edit4.Text
             else  FieldByName('50����').AsString:='��';
             if edit5.Text<>'' then
             FieldByName('800����').AsString:=edit5.Text
             else FieldByName('800����').AsString:='��';
             if edit6.Text<>'' then
             FieldByName('1000����').AsString:=edit6.Text
             else FieldByName('1000����').AsString:='��';
             if edit7.Text<>'' then
             begin
             FieldByName('��������').AsString:=edit7.Text;
             FieldByName('��������ָ��').AsString:=woli;
             end
             else  begin
                   FieldByName('��������').AsString:='��';
                   FieldByName('��������ָ��').AsString:='��';
             end;
             if edit8.Text<>''then
             begin
             FieldByName('�λ�������').AsString:=edit8.Text;
             FieldByName('�λ�������ָ��').AsString:=feihuoliang;
             end
             else  begin
                   FieldByName('�λ�������').AsString:='��';
                   FieldByName('�λ�������ָ��').AsString:='��';
             end;
             if edit9.Text<>'' then
             FieldByName('������ǰ��').AsString:=edit9.Text
             else  FieldByName('������ǰ��').AsString:='��';
             if edit10.Text<>'' then
             FieldByName('������Զ').AsString:=edit10.Text
             else FieldByName('������Զ').AsString:='��';
             if edit11.Text<>'' then
             FieldByName('��������').AsString:=edit11.Text
             else FieldByName('��������').AsString:='��';
             FieldByName('�ܳɼ�').AsString:=edit12.Text;
             case  StrToInt(edit12.Text) of
               0..59:  FieldByName('�ȼ�����').AsString:='������';
               60..75: FieldByName('�ȼ�����').AsString:='����';
               76..90: FieldByName('�ȼ�����').AsString:='��';
               91..100:FieldByName('�ȼ�����').AsString:='��';
             end;
             Post;
           end
        else
          begin
            Application.MessageBox('û���ҵ���ѧ���ĳɼ���Ϣ��','��ʾ');
            abort;    //�жϱ��β���
          end;
        end;
      with  DataModule1.Ddengji.DataSet do
          begin
            if Locate('ѧ�����',edit1.Text,[])=true then
              begin
                Edit;
                FieldByName('ѧ�����').AsString:=edit1.Text;
                FieldByName('50���ܵȼ�').AsString:=dj1;
                FieldByName('800���ܵȼ�').AsString:=dj2;
                FieldByName('1000���ܵȼ�').AsString:=dj3;
                FieldByName('��������ָ���ȼ�').AsString:=dj4;
                FieldByName('�λ�������ָ���ȼ�').AsString:=dj5;
                FieldByName('������ǰ���ȼ�').AsString:=dj6;
                FieldByName('������Զ�ȼ�').AsString:=dj7;
                FieldByName('���������ȼ�').AsString:=dj8;
                Post;
              end;
          end;
      with DataModule1.Dstugreadinfo.DataSet do
        begin
          if Locate('ѧ�����',edit1.Text,[])=true then
            begin
              Edit;
              FieldByName('ѧ�����').AsString:=edit1.Text;
              FieldByName('50���ܳɼ�').AsString:=inttostr(cg1);
              FieldByName('800���ܳɼ�').AsString:=inttostr(cg2);
              FieldByName('1000���ܳɼ�').AsString:=inttostr(cg3);
              FieldByName('��������ָ���ɼ�').AsString:=inttostr(cg4);
              FieldByName('�λ�������ָ���ɼ�').AsString:=inttostr(cg5);
              FieldByName('������ǰ���ɼ�').AsString:=inttostr(cg6);
              FieldByName('������Զ�ɼ�').AsString:=inttostr(cg7);
              FieldByName('���������ɼ�').AsString:=inttostr(cg8);
              FieldByName('������سɼ�').AsString:=inttostr(cg9);
              Post;
            end;
        end;
      Application.MessageBox('��ɶ����ݵ��޸ģ�','��ʾ');
      BitBtn3.Enabled:=false;
      BitBtn2.Enabled:=false;
  end
    else
      Application.MessageBox('ѧ�����Ϊ�գ�','��ʾ');
  end
else
  Application.MessageBox('ѧ���ɼ���ϢΪ�գ������ѧ���ɼ���Ϣ��','��ʾ');
end;



procedure Tchengjiform.BitBtn6Click(Sender: TObject);
begin
  chengjiform.Hide;
  printform.ShowModal;
  chengjiform.Close;
end;

procedure Tchengjiform.ComboBox2Enter(Sender: TObject);
begin
if DataModule1.xibie.RecordCount<>0 then
  ComboBox2.Clear;
  DataModule1.xibie.First;
  while DataModule1.xibie.Eof<>true do
    begin
      ComboBox2.Items.Add(DataModule1.xibie.FieldValues['Ժϵ����']);
      DataModule1.xibie.Next;
    end;
  DataModule1.xibie.First;
end;

procedure Tchengjiform.ComboBox2Change(Sender: TObject);
begin
BitBtn5.Click;
ComboBox1.Text:='';
DBGrid1.DataSource:=DataModule1.Dnull;
end;


procedure tchengjiform.wmgetminmaxinfo(var msg :TWMGetMinMaxInfo);
begin
    with msg.minmaxinfo^ do

    begin
      ptMinTrackSize:=point(812,483);//  �޶���С
      ptMaxTrackSize:=point(812,483); // �޶���С
    end;
end;



end.
