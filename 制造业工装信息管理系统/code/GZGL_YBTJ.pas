unit GZGL_YBTJ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Grids, DBGrids, jpeg, ExtCtrls, Mask,
  DBCtrls, dbcgrids, ComCtrls;

type
  TFrmGZGL_YBTJ = class(TForm)
    Panel1: TPanel;
    Label16: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Panel2: TPanel;
    Memo1: TMemo;
    Panel7: TPanel;
    Label17: TLabel;
    Btn_tj: TSpeedButton;
    btn_exit: TSpeedButton;
    EDT_Y: TEdit;
    Label2: TLabel;
    EDT_M: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Panel3: TPanel;
    Pag1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    TabSheet3: TTabSheet;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    procedure Btn_tjClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EDT_YKeyPress(Sender: TObject; var Key: Char);
    procedure EDT_YExit(Sender: TObject);
    procedure EDT_MKeyPress(Sender: TObject; var Key: Char);
    procedure EDT_MExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmGZGL_YBTJ: TFrmGZGL_YBTJ;

implementation

uses GZGL_DModule, Umyfunction, GZGL_Main;

{$R *.dfm}

procedure TFrmGZGL_YBTJ.FormShow(Sender: TObject);
begin
  with dmd do begin
    tbl_yzjh.open;
  end;
  Image1.Picture:=FRMGZGL_Main.IMG_LOGO.Picture;
end;

procedure TFrmGZGL_YBTJ.FormCreate(Sender: TObject);
begin
  ClearEDT(SELF);
end;
procedure TFrmGZGL_YBTJ.Btn_tjClick(Sender: TObject);
var
  s,tj:string;
  gshj,czhj,dh,wg,yz:integer;
begin
  memo1.clear;
  tj:=edt_Y.text+'-'+edt_M.text;

  //��ʱ�ϼ�, ��ֵ�ϼ�
  with dmd.qry_temp do begin
    close;
    sql.clear;
    s:='select sum(gs)as ��ʱ�ϼ�,sum(cz) as ��ֵ�ϼ� from ��װ where WGRQ like "'+tj+'%"';
    sql.Add(s);
    try
      open;
    except
      execsql;
    end;
    gshj:=FieldByName('��ʱ�ϼ�').asinteger;
    czhj:=fieldbyname('��ֵ�ϼ�').asinteger;
  end;
  //����
  with dmd.qry_gz do begin
    close;
    sql.clear;
    s:='select * from ��װ where DHRQ like "'+tj+'%" ';
    sql.Add(s);
    try
      open;
    except
      execsql;
    end;
    DH:=recordcount;
  end;
  //�깤
  with dmd.qry_gz1 do begin
    close;
    sql.clear;
    s:='select * from ��װ where WGRQ like "'+tj+'%" ';
    sql.Add(s);
    try
      open;
    except
      execsql;
    end;
    WG:=recordcount;
  end;
  //��֤
  with dmd.qry_gz2 do begin
    close;
    sql.clear;
    s:='select * from ��װ where YZRQ like "'+tj+'%" ';
    sql.Add(s);
    try
      open;
    except
      execsql;
    end;
    YZ:=recordcount;
  end;
  memo1.Lines.add('ͳ��ʱ�䣺'+datetostr(now));
  memo1.Lines.add('ͳ��Ŀ�꣺�±�����');
  memo1.Lines.add('ͳ�ƽ�������¶�����'+inttostr(DH)+' �ף�'+'�깤��'+inttostr(WG)+' �ף�'+'��֤�ϸ�'+inttostr(YZ)+' ��');
  memo1.Lines.add('          �����깤��ʱ�ϼƣ�'+inttostr(GSHJ)+' Сʱ');
  memo1.Lines.add('          �����깤��ֵ�ϼƣ�'+inttostr(CZHJ)+' Ԫ');
end;

procedure TFrmGZGL_YBTJ.btn_exitClick(Sender: TObject);
begin
  close;
end;



procedure TFrmGZGL_YBTJ.EDT_YKeyPress(Sender: TObject; var Key: Char);
var
  s:string;
begin
  s:=edt_y.Text;
  if (key=#13) then begin
    edt_m.SetFocus;
    edt_m.SelectAll;
  end;
end;

procedure TFrmGZGL_YBTJ.EDT_YExit(Sender: TObject);
var
  s:string;
begin
  s:=edt_y.Text;
  if strlen(pchar(s))<4 then edt_y.SetFocus;
end;



procedure TFrmGZGL_YBTJ.EDT_MKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    Btn_tjClick(Sender);
  end;
end;

procedure TFrmGZGL_YBTJ.EDT_MExit(Sender: TObject);
var
  s:string;
begin
  s:=edt_m.Text;
  if strlen(pchar(s))<2 then edt_m.SetFocus;

end;

end.
