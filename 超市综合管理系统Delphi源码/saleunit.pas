unit saleunit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, DBGrids, ExtCtrls, DB, ADODB, StdCtrls, Menus;

type
  TSale_Form = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    StatusBar1: TStatusBar;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    ADOQuery1id: TAutoIncField;
    ADOQuery1p_id: TSmallintField;
    ADOQuery1p_name: TWideStringField;
    ADOQuery1p_price: TBCDField;
    ADOQuery1p_unit: TWideStringField;
    ADOQuery1p_type: TSmallintField;
    ADOQuery1p_store: TSmallintField;
    ADOQuery1p_time: TDateTimeField;
    ADOQuery1p_sale: TSmallintField;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    ADOQuery2: TADOQuery;
    Button2: TButton;
    RichEdit1: TRichEdit;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    ADOTable1: TADOTable;
    N2: TMenuItem;
    N3: TMenuItem;
    Button3: TButton;
    Label2: TLabel;
    Edit2: TEdit;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Button4: TButton;
    Edit4: TEdit;
    Edit3: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button5: TButton;
    Button6: TButton;
    N4: TMenuItem;
    Timer1: TTimer;
    N5: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure N5Click(Sender: TObject);
  private
    { Private declarations }
    count:double;
  public
    { Public declarations }
  end;

var
  Sale_Form: TSale_Form;

implementation

uses datamodule, UseLogin, help;

{$R *.dfm}

procedure TSale_Form.Button1Click(Sender: TObject); //�ύ��Ʒ�Ĳ���
var
sqls:string;
Parami:tparameter;
count1:double;
left:integer;
begin
count1:=0;
if (edit1.text='') and (edit2.text='') then
showmessage('�������������������Ʒ������^_^')
else
 begin
   with adoquery1 do    //�ӿ���в����ύ����Ʒ�Ƿ����
        begin
           close;
           sql.clear;
           sqls:='select * from produce_t where 1=1';
           if edit2.Text<>'' then
              sqls:=sqls+'and p_name='''+edit2.Text+'''';
           if edit1.Text<>'' then
              begin
                sqls:=sqls+'and p_id=:id';
                Parameters.Clear;
                Parami:=Parameters.ADDParameter; //��������1
                Parami.Name:='id';
                Parami.Value:=strtoint(edit1.text);
               end;
            sql.add(sqls);
            Prepared;
            open;
            if recordcount=0 then
            showmessage('�Բ��𣬸���Ʒ������')
            else          //�����Ʒ���ھͽ���д��sell_t���б���
            begin
             if not adoquery2.active then
             adoquery2.open;
             adoquery2.insert;
             adoquery2.fields.fields[0]:=fields.fields[1];   //������
             adoquery2.fields.fields[1]:=fields.fields[2];   //��Ʒ��
             adoquery2.fields.fields[2]:=fields.fields[3];   //��Ʒ�۸�
             adoquery2.fields.fields[3]:=fields.fields[4];   //��Ʒ������λ
               with datamodule1.adocommand1 do               //�޸�produce_t��sale_p��ֵ
                 begin
                 commandtext:='update produce_t set p_sale=p_sale+1 where p_id=:i';
                 parameters.ParamValues['i']:=adoquery2.fields[0].AsInteger;
                 execute;
                 end;
             left:=fields.fields[6].asinteger-fields.fields[8].asinteger;
             adoquery2.fields.fields[4].asinteger:=left; //�õ���ʱ�Ŀ����
             if left<=0 then
               begin
                 showmessage('ȷ����');
                 adoquery2.Cancel;
               end
               else
               begin
                adoquery2.post;
                count1:=fields.Fields[3].AsFloat;  //��ǰ��ƷӦ�����
                end;
            end;
        end;
        count:=count+count1;    //����ܵ�Ӧ�����
        richedit1.text:='������ƣ�'+floattostr(count)+'Ԫ����'; //��ʾӦ�������
  end;
end;

procedure TSale_Form.Button2Click(Sender: TObject);
begin
if count=0 then        //��û����Ʒ����ʱ�������Ϊ�������
   showmessage('�������')
else
begin
  edit3.Text:=floattostr(count);      //Ӧ�����
  panel2.Visible:=true;
end;
end;

procedure TSale_Form.Button3Click(Sender: TObject);
begin
if count>0 then  //�����Ƚ��㷽���뿪
showmessage('������û���㣬���������뿪�ɣ���')
else
begin
adoquery1.close;
adoquery2.close;
adotable1.close;
close;
end;
end;

procedure TSale_Form.Button4Click(Sender: TObject);
var
money:double;
ret:integer;
begin
if edit4.text='' then
 showmessage('��������ĸ�����')
else
begin
 money:=strtofloat(edit4.Text)-count;
 if money<0 then
     showmessage('����')
 else
   begin
     ret:=messagebox(0,pchar('���㣺'+floattostr(money)),'����ȷ��',1);
     if ret=2 then
       begin
         with adoquery2 do
          begin
           first;
           while not eof do
             begin
               with datamodule1.adocommand1 do               //�޸�produce_t��sale_p��ֵ
                 begin
                  commandtext:='update produce_t set p_sale=p_sale-1 where p_id=:i';
                  parameters.ParamValues['i']:=adoquery2.fields[0].AsInteger;
                  execute;
                 end;
                next;
            end;
          end;
         richedit1.text:='�ϴ�'+richedit1.text+'  ���ױ�ȡ��������';
        end
        else
         begin
          with adoquery2 do//������Ʒ���п����
           begin
           first;
            begin
            while not eof do
             begin
               with adotable1 do   //������Խ��׾ͽ�sell_t�е����ݱ��浽sell_back_t��
                   begin
                   insert;
                   fields.fields[1]:=adoquery2.fields[0];
                   fields.fields[2]:=adoquery2.fields[1];
                   fields.fields[3]:=adoquery2.fields[2];
                   fields.fields[4].asinteger:=1;
                   fields.fields[5].asdatetime:=now;
                   fields.fields[6].asboolean:=true;
                   post;
                   end;
               next;
             end;
            richedit1.text:='�ϴ�'+richedit1.text+'ʵ�գ�'+edit4.text+'Ԫ��'+'  ���㣺'+floattostr(money)+'Ԫ�������׳ɹ�^_^'+'����ʱ��:'+datetimetostr(now);
            edit1.clear;
            edit2.clear;
            edit3.clear;
            edit4.clear;
            end;   //һ�γɹ��������
          end;
         end;
       with datamodule1.adocommand1 do    //ɾ��sell_t�е�����
        begin
        commandtext:='delete from sell_t';
        execute;
        adoquery2.close;
        panel2.visible:=false;
        count:=0;
        end;
   end;
 end;

end;

procedure TSale_Form.FormActivate(Sender: TObject);
begin
  if not adoquery1.active then
  adoquery1.open;
   if not adoquery2.active then
  adoquery2.open;
    if not adotable1.active then
  adotable1.open;
end;

procedure TSale_Form.Button5Click(Sender: TObject); //ȡ�����ν���
var
money:double;
begin
if edit4.text='' then
edit4.text:='0';
 money:=strtofloat(edit4.Text)-count;
 with adoquery2 do
  begin
   first;
   while not eof do
    begin
     with datamodule1.adocommand1 do               //�ָ�produce_t��sale_p��ֵ
      begin
       commandtext:='update produce_t set p_sale=p_sale-1 where p_id=:i';
       parameters.ParamValues['i']:=adoquery2.fields[0].AsInteger;
       execute;
      end;
     next;
    end;
   end;                                     //���sell_t�е�����
   with datamodule1.adocommand1 do
    begin
     commandtext:='delete from sell_t';
      execute;
      adoquery2.close;
      panel2.visible:=false;
      count:=0;
      if money<0 then
        richedit1.text:='�ϴ�'+richedit1.text+'  ��������㱻ȡ��������'
      else
          richedit1.text:='�ϴ�'+richedit1.text+'  ���ױ���ȡ��������' ;
      end;
end;

procedure TSale_Form.Button6Click(Sender: TObject);
begin
  with adoquery2 do
  begin
   first;
   while not eof do
    begin
     with datamodule1.adocommand1 do               //�ָ�produce_t��sale_p��ֵ
      begin
       commandtext:='update produce_t set p_sale=p_sale-1 where p_id=:i';
       parameters.ParamValues['i']:=adoquery2.fields[0].AsInteger;
       execute;
      end;
     next;
    end;
   end;                                     //���sell_t�е�����
   with datamodule1.adocommand1 do
    begin
     commandtext:='delete from sell_t';
      execute;
      adoquery2.close;
      panel2.visible:=false;
      count:=0;
     richedit1.text:='�ϴ�'+richedit1.text+'  ���м�¼��ǿ��ɾ��' ;
      end;
end;

procedure TSale_Form.Timer1Timer(Sender: TObject);
begin
statusbar1.panels[6].text:='ϵͳʱ��:'+DateTimeToStr(now);
statusbar1.panels[0].text:='����Ա: '+Login_Form.UseName;
end;

procedure TSale_Form.N5Click(Sender: TObject);
begin
help_form.show;
end;

end.
