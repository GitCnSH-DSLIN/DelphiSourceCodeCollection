unit u_names;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, ComCtrls, DB,
  DBTables;

type
  Tfrm_names = class(TForm)
    StatusBar1: TStatusBar;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel2: TPanel;
    SB1: TBitBtn;
    SB2: TBitBtn;
    bb3: TBitBtn;
    bb4: TBitBtn;
    bb6: TBitBtn;
    BB7: TBitBtn;
    GroupBox1: TGroupBox;
    RB1: TRadioButton;
    RB2: TRadioButton;
    RB3: TRadioButton;
    RB4: TRadioButton;
    RB5: TRadioButton;
    RB6: TRadioButton;
    DBGrid1: TDBGrid;
    Query1: TQuery;
    DataSource1: TDataSource;
    rb7: TRadioButton;
    rb8: TRadioButton;
    gb1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    code: TEdit;
    note: TEdit;
    names: TEdit;
    rb9: TRadioButton;
    rb10: TRadioButton;
    rb11: TRadioButton;
    rb12: TRadioButton;
    Splitter1: TSplitter;
    rb13: TRadioButton;
    rb14: TRadioButton;
    rb15: TRadioButton;
    procedure SB1Click(Sender: TObject);
    procedure SB2Click(Sender: TObject);
    procedure bb3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RB1Click(Sender: TObject);
    procedure BB7Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure bb4Click(Sender: TObject);
    procedure codeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
   
   rbwidth,tablename:string;
   rbcaption:string;
   procedure rbtrue();
    { Private declarations }
  public
    signid:string;
    signtrue:boolean;
    { Public declarations }
  end;

var
  frm_names: Tfrm_names;

implementation

{$R *.dfm}
procedure Tfrm_names.rbtrue ()  ;
begin
  if rb1.Checked  then
  begin
     rbwidth:='gg';   //���
     rbcaption:=rb1.Caption ;
  end
  else if rb2.Checked then
  begin
     rbwidth:='pp' ; //Ʒ��
     rbcaption:=rb2.Caption ;
  end
  else if rb3.Checked then
  begin
     rbwidth:='dw'; //��λ
     rbcaption:=rb3.Caption ;
  end
  else if rb4.Checked then
  begin
     rbwidth:='ys'; //��ɫ
     rbcaption:=rb4.Caption ;
  end
  else if rb5.Checked then
  begin
     rbwidth:='jg';  //�ṹ
     rbcaption:=rb5.Caption ;
  end
  else if rb6.Checked then
  begin
     rbwidth:='lb'; //���
     rbcaption:=rb6.Caption ;
  end
  else if rb7.Checked then
  begin
     rbwidth:='fkfs'; //���ʽ
     rbcaption:=rb7.Caption ;
  end
  else if rb8.Checked then
  begin
     rbwidth:='bm'; //����
     rbcaption:=rb8.Caption ;
  end
  else if rb9.Checked then
  begin
     rbwidth:='xm';  //��Ŀ����
     rbcaption:=rb9.Caption ;
  end
  else if rb10.Checked then
  begin
     rbwidth:='zc'; //ְ��
     rbcaption:=rb10.caption;
  end
  else if rb11.Checked then
  begin
     rbwidth:='gw';  //��λ
     rbcaption:=rb11.caption;
  end
  else if rb12.Checked then
  begin
     rbwidth:='fz'; //����
     rbcaption:=rb12.caption;
  end
  else if rb13.Checked then
  begin
     rbwidth:='gclb';   //�������
     rbcaption:=rb12.caption;
  end
  else if rb14.Checked then
  begin
     rbwidth:='1lm'; //һ������
     rbcaption:=rb12.caption;
  end
  else if rb15.Checked then
  begin
     rbwidth:='2lm'; //��������
     rbcaption:=rb12.caption;
  end
  else
     rbwidth:='' ;

   gb1.Caption :='������'+rbcaption+'����';
   Label1.Caption :=rbcaption+'����:';
   Label2.Caption := rbcaption+'����:';
end;

procedure Tfrm_names.SB1Click(Sender: TObject);
var strchar,msql:string;
begin
  with query1 do
  begin
    if (code.text='') then
    begin
       showmessage('�ͻ����벻��Ϊ��');
       exit;
    end;
    close;
    sql.Clear ;
    sql.Add('select code from '+tablename+' where class1='''+rbwidth+''' and code='''+code.Text +''' ' ) ;
    Try
      open;
      if isempty then
      begin
        close;
        sql.Clear ;
        strchar:=format('��ȷ��Ҫ���桾%s���롿Ϊ%s�ļ�¼��?',[rbCaption ,code.Text]);
        if Application.MessageBox(pchar(strchar),'��ʾ��Ϣ',mb_yesno+mb_iconinformation)=idno then exit;
        sql.Add('insert into '+tablename+'(code,names,note,class1) '+
                 'values('''+code.Text+''','''+names.Text+''','''+note.Text+''','''+rbwidth+''')') ;
        try
          execsql;
        except
            showmessage('SQL���Դ���');
            exit;
        end;
        end
        else
          begin
            close;
            sql.Clear ;
            strchar:=format('��ȷ��Ҫ�޸ġ�%s���롿Ϊ%s�ļ�¼��?',[rbcaption,code.Text ]);
            if Application.MessageBox(pchar(strchar),'��ʾ��Ϣ',mb_yesno+mb_iconinformation)=idno then exit;
            msql:='';
            msql:=msql+'names='''+names.Text+''',';
            msql:=msql+'note='''+note.Text+''' ';
            sql.Add('update '+tablename+' set '+msql+' where code='''+code.Text +''' and class1='''+rbwidth+''' ') ;
            try
              execsql;
            except
             showmessage('SQL���Դ���');
             exit;
            end;
          end;
        except
             showmessage('SQL���Դ���');
             exit;
        end;
    end;
    bb4.Click ;
    bb3.Click ;
    CODE.SetFocus ;
end;


procedure Tfrm_names.SB2Click(Sender: TObject);
var strchar:string;
begin
  if (code.text='') then
  begin
    showmessage('�ͻ����벻��Ϊ��');
    exit;
  end;
  with query1 do
  begin
    close;
    sql.Clear ;
    sql.Add('select code from '+tablename+' where class1='''+rbwidth+''' ')  ;
    open;
    if not isempty then
    begin
      close;                         //����
      sql.Clear ;
      strchar:=format('��ȷ��Ҫɾ����%s���롿Ϊ%s�ļ�¼��?',[rbcaption,code.Text ]);
      if Application.MessageBox(pchar(strchar),'��ʾ��Ϣ',mb_yesno+mb_iconinformation)=idno then exit;
      sql.Add('delete '+tablename+' where code='''+code.Text +''' and class1='''+rbwidth+'''');
      try
        execsql;
      except
        showmessage('SQL���Դ���');
        exit;
      end;
    end
    else
    begin
      showmessage('�˼�¼������,����ɾ��');
      exit;
    end;
  end;
  bb4.click;
  bb3.click;
end;

procedure Tfrm_names.bb3Click(Sender: TObject);
var condition:string;
begin
  if code.Text <>'' then condition:=' and code='''+code.Text +''' ';
   with query1 do
   begin
     close ;
     sql.Clear ;
     sql.Add('select code,names,note from '+tablename+ ' where class1='''+rbwidth+''' '+condition+' order by code' )    ;
     try
       open;
     except
        showmessage('SQL���Դ���');
        exit;
     end;
   end;
end;

procedure Tfrm_names.FormShow(Sender: TObject);
begin
   tablename:='t_code';

   if signid='1' then //���
     rb1.Checked :=true
   else if signid='2' then  //Ʒ��
     rb2.Checked :=true
   else if signid='3' then //��λ
     rb3.Checked :=true
   else if signid='4' then //��ɫ
     rb4.Checked :=true
   else if signid='5' then //�ṹ
     rb5.Checked :=true
   else if signid='6' then  //���
     rb6.Checked :=true
   else if signid='7' then  //���ʽ
     rb7.Checked :=true
   else if signid='8' then //����
     rb8.Checked :=true
   else if signid='9' then //��Ŀ(�ͻ�)����
     rb9.Checked :=true
   else if signid='10' then //ְ��(ְ��)
     rb10.Checked :=true
   else if signid='11' then //��λ
     rb11.Checked :=true
   else if signid='12' then//����
     rb12.Checked :=true
   else if signid='13' then//�������
     rb13.Checked :=true
   else if signid='14' then// һ������
     rb14.Checked :=true
   else if signid='15' then//��������
     rb15.Checked :=true
   else
     rb1.Checked :=true;
   bb4.Click ;
   rbtrue();
   bb3.click;
   code.SetFocus ;
end;

procedure Tfrm_names.RB1Click(Sender: TObject);
begin
   bb4.Click ;
   rbtrue();
   bb3.Click ;
end;

procedure Tfrm_names.BB7Click(Sender: TObject);
begin
  close;
end;

procedure Tfrm_names.DBGrid1DblClick(Sender: TObject);
begin
  if signtrue then
  begin
    close;
  end
  else
  with query1 do
  begin
    code.text:=fields[0].AsString ;
    names.Text :=fields[1].AsString ;
    note.Text :=fields[2].AsString ;
  end;
end;

procedure Tfrm_names.bb4Click(Sender: TObject);
begin
  code.Clear ;
  names.Clear;
  note.Clear ;
end;

procedure Tfrm_names.codeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then SelectNext(ActiveControl,True,True);
  IF key=vk_escape then BB7.Click ;
  if key=VK_F9 then sb1.Click ;
  if key=VK_F11 then sb2.Click ;
  if key=VK_F12 then BB3.Click ;
  if key=VK_F5 then bb6.Click ;
  if key=VK_F4 then BB4.Click ;
  if key=VK_F2 then rb1.Checked :=true;

end;

end.
