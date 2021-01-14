unit main;
//Download by http://www.codefans.net
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, ExtCtrls,COMOBJ;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    Timer2: TTimer;
    ado: TADOConnection;
    qmext1: TADOQuery;
    qssr: TADOQuery;
    qssu: TADOQuery;
    qtextu: TADOQuery;
    qtextu2: TADOQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    a,b,c,d,e,f : integer;
    sessionid : string;
    rever : string;  //���պ�
    textt : string;  //������Ϣ����
    textp : string;  //֪ͨ״̬
    textc : integer; //֪ͨ����
    RootObj : olevariant;
    id : integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  timer1.Enabled := true;
  timer2.Enabled := true;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  timer1.Enabled := false;
  timer2.Enabled := false;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i : integer;
begin
//��ȡ�跢����Ϣ
with qmext1 do
begin
  close;
  sql.Clear;
  sql.Add('select * from ҵ�����ѱ� where ֪ͨ���� =0 and �رձ�ʶ =:param1');
  Parameters[0].Value := '0';
  try
    begin
      open;
      if recordcount > 0 then
      begin
        for i := 0 to recordcount -1 do
        begin
          id :=    fieldbyname('id').AsInteger;
          rever := fieldbyname('֪ͨ��').AsString;
          textt := fieldbyname('֪ͨ����').AsString;
          //��ȡsessionid
          with qssr do
          begin
            close;
            sql.Clear;
            sql.Add('select * from session������');
            try
              begin
                open;
                a := fieldbyname('session1').AsInteger;
                b := fieldbyname('session2').AsInteger;
                c := fieldbyname('session3').AsInteger;
                d := fieldbyname('session4').AsInteger;
                e := fieldbyname('session5').AsInteger;
                f := fieldbyname('session6').AsInteger;
                if f = 99999999 then
                begin
                if e = 9999 then
                begin
                  if d = 9999 then
                  begin
                    if c = 9999 then
                    begin
                      if b = 9999 then
                      begin
                        a := a + 1;
                      end
                      else
                      begin
                        b := b + 1 ;
                      end;
                    end
                    else
                    begin
                      c := c + 1;
                    end;
                  end
                  else
                  begin
                    d := d + 1;
                  end;
                end
                else
                begin
                  e := e + 1;
                end;
                end
                else
                begin
                  f := f + 1;
                end;
            end;
          except
            begin
              Application.MessageBox('���ݿ�����ʧ�ܣ�����ϵͳ����Ա��ϵ��','ϵͳ��ʾ',mb_ok+mb_iconstop+mb_systemmodal);
              exit;
            end;
          end;
        end;
        sessionid := '{'+inttostr(a)+'-'+inttostr(b)+'-'+inttostr(c)+'-'+inttostr(d)+'-'+inttostr(e)+inttostr(f)+'}';
        //������Ϣ

        RootObj:= CreateoleObject('RTXSAPIRootObj.RTXSAPIRootObj');
        rootobj.sendim('9091','1111',trim(rever),textt,sessionid);
        //����sessionid
        with qssu do
        begin
          close;
          sql.Clear;
          sql.Add('update session������ set session1 =:param1,session2 =:param2,session3 =:param3,session4 =:param4,session5 =:param5,session6 =:param6');
          Parameters[0].Value := a;
          Parameters[1].Value := b;
          Parameters[2].Value := c;
          Parameters[3].Value := d;
          Parameters[4].Value := e;
          Parameters[5].Value := f;
          execsql;
        end;
        //����ҵ�����ѱ�
        with qtextu do
        begin
          close;
          sql.Clear;
          sql.Add('update ҵ�����ѱ� set ֪ͨ���� =:param1 where id =:param2');
          Parameters[0].Value := '1';
          Parameters[1].Value := id;
          execsql;
        end;            
        next;
      end;
    end;
  end;
  except
    begin
      Application.MessageBox('���ݿ�����ʧ�ܣ�����ϵͳ����Ա��ϵ��','ϵͳ��ʾ',mb_ok+mb_iconstop+mb_systemmodal);
      exit;
    end;
  end;         
end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var
  j : integer;
begin
 //��ȡ�跢����Ϣ
with qmext1 do
begin
  close;
  sql.Clear;
  sql.Add('select * from ҵ�����ѱ� where �رձ�ʶ =:param1');
  Parameters[0].Value := '0';
  try
    begin
      open;
      if recordcount > 0 then
      begin
        for j := 0 to recordcount -1 do
        begin
          id :=    fieldbyname('id').AsInteger;
          rever := fieldbyname('֪ͨ��').AsString;
          textt := fieldbyname('֪ͨ����').AsString;
          textp := fieldbyname('֪ͨ״̬').AsString;
          textc := fieldbyname('֪ͨ����').AsInteger;
          //��ȡsessionid
          with qssr do
          begin
            close;
            sql.Clear;
            sql.Add('select * from session������');
            try
              begin
                open;
                a := fieldbyname('session1').AsInteger;
                b := fieldbyname('session2').AsInteger;
                c := fieldbyname('session3').AsInteger;
                d := fieldbyname('session4').AsInteger;
                e := fieldbyname('session5').AsInteger;
                f := fieldbyname('session6').AsInteger;
                if f = 99999999 then
                begin
                if e = 9999 then
                begin
                  if d = 9999 then
                  begin
                    if c = 9999 then
                    begin
                      if b = 9999 then
                      begin
                        a := a + 1;
                      end
                      else
                      begin
                        b := b + 1 ;
                      end;
                    end
                    else
                    begin
                      c := c + 1;
                    end;
                  end
                  else
                  begin
                    d := d + 1;
                  end;
                end
                else
                begin
                  e := e + 1;
                end;
                end
                else
                begin
                  f := f + 1;
                end;
            end;
          except
            begin
              Application.MessageBox('���ݿ�����ʧ�ܣ�����ϵͳ����Ա��ϵ��','ϵͳ��ʾ',mb_ok+mb_iconstop+mb_systemmodal);
              exit;
            end;
          end;
        end;
        sessionid := '{'+inttostr(a)+'-'+inttostr(b)+'-'+inttostr(c)+'-'+inttostr(d)+'-'+inttostr(e)+inttostr(f)+'}';
        //������Ϣ

        RootObj:= CreateoleObject('RTXSAPIRootObj.RTXSAPIRootObj');
        rootobj.sendim('9091','1111',trim(rever),textt,sessionid);
        //����sessionid
        with qssu do
        begin
          close;
          sql.Clear;
          sql.Add('update session������ set session1 =:param1,session2 =:param2,session3 =:param3,session4 =:param4,session5 =:param5,session6 =:param6');
          Parameters[0].Value := a;
          Parameters[1].Value := b;
          Parameters[2].Value := c;
          Parameters[3].Value := d;
          Parameters[4].Value := e;
          Parameters[5].Value := f;
          execsql;
        end;
        //����ҵ�����ѱ�
        textc := textc + 1;
        with qtextu do
        begin
          close;
          sql.Clear;
          sql.Add('update ҵ�����ѱ� set ֪ͨ���� =:param1 where id =:param2');
          Parameters[0].Value := textc;
          Parameters[1].Value := id;
          execsql;
        end;
        if textp = '��ȫ����' then
        begin
          with qtextu2 do
          begin
            close;
            sql.Clear;
            sql.Add('update ҵ�����ѱ� set �رձ�ʶ =:param1 where id =:param2');
            Parameters[0].Value := '1';
            Parameters[1].Value := id;
            execsql;
          end;
        end;
        next;
      end;
    end;
  end;
  except
    begin
      Application.MessageBox('���ݿ�����ʧ�ܣ�����ϵͳ����Ա��ϵ��','ϵͳ��ʾ',mb_ok+mb_iconstop+mb_systemmodal);
      exit;
    end;
  end;         
end;
end;

end.
