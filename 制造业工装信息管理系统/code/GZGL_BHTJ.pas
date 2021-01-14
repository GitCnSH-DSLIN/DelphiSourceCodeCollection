unit GZGL_BHTJ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, jpeg, ExtCtrls, Buttons;

type
  TFrmGZGL_BHTJ = class(TForm)
    Panel1: TPanel;
    Label16: TLabel;
    Image1: TImage;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Memo1: TMemo;
    Panel7: TPanel;
    Btn_tj: TSpeedButton;
    btn_exit: TSpeedButton;
    Label4: TLabel;
    edt_tj: TEdit;
    Label2: TLabel;
    procedure Btn_tjClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edt_tjKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmGZGL_BHTJ: TFrmGZGL_BHTJ;

implementation

uses GZGL_DModule, GZGL_Main;

{$R *.dfm}
procedure TFrmGZGL_BHTJ.FormCreate(Sender: TObject);
begin
  memo1.clear;
  Image1.Picture:=FRMGZGL_Main.IMG_LOGO.Picture;
end;


procedure TFrmGZGL_BHTJ.Btn_tjClick(Sender: TObject);
var
  s,tj:string;
  gshj,czhj:integer;
begin
  memo1.clear;
  tj:=edt_tj.text;
  with dmd.qry_gz do begin
    close;
    sql.clear;
    s:='select sum(gs)as ��ʱ�ϼ�,sum(cz) as ��ֵ�ϼ� from ��װ where gzbh like "'+tj+'%"';
    sql.Add(s);
    try
      open;
    except
      execsql;
    end;
    gshj:=FieldByName('��ʱ�ϼ�').asinteger;
    czhj:=fieldbyname('��ֵ�ϼ�').asinteger;
    close;
    sql.clear;
    s:='select * from ��װ where gzbh like "'+tj+'%"';
    sql.Add(s);
    try
      open;
    except
      execsql;
    end;
    memo1.Lines.add('ͳ��ʱ�䣺'+datetostr(now));
    memo1.Lines.add('ͳ��Ŀ�꣺�����'+edt_tj.text+'��ͷ�Ĺ�װ���');
    memo1.Lines.add('ͳ�ƽ������ '+inttostr(recordcount)+' ��');
    memo1.Lines.add('          ��ʱ�ϼƣ�'+inttostr(gshj)+' Сʱ');
    memo1.Lines.add('          ��ֵ�ϼƣ�'+inttostr(czhj)+' Ԫ');
  end;
end;

procedure TFrmGZGL_BHTJ.btn_exitClick(Sender: TObject);
begin
  close;
end;

procedure TFrmGZGL_BHTJ.edt_tjKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin
    Btn_tjClick(Sender);
  end;

end;

end.
