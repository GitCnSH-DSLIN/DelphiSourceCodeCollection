unit untPubQueryDB;
///////////���� ����Զ�����ݿ��Ӧ�ó���ydy 2004-4-22 create


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, Buttons, DB;

type
  TFm_RemoteDb = class(TForm)
    Label1: TLabel;
    DBGrid1: TDBGrid;
    EdtTable: TEdit;
    Label2: TLabel;
    BtnSelect: TButton;
    edtRecNo: TEdit;
    Label3: TLabel;
    ComboBox1: TComboBox;
    BtnDo: TButton;
    Memo1: TMemo;
    Label4: TLabel;
    btnpagedown: TBitBtn;
    DataSource1: TDataSource;
    BitBtn1: TBitBtn;
    procedure BtnSelectClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnDoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fm_RemoteDb: TFm_RemoteDb;

implementation

uses  Data, func, untdatadm;

{$R *.dfm}

procedure TFm_RemoteDb.BtnSelectClick(Sender: TObject);
var
  t_sql:string;
   quedata:olevariant;
  //2004-2-10Ϊ���Ż���������   �ٶ�����ߵ�52��
begin
    screen.Cursor := crhourglass;
   //�ص���DBGRID �Ļ���
   dmmain.dsquery.DisableControls;
   quedata:=null;
   if dmmain.dsquery.active then dmmain.dsquery.close;

    t_sql:='select top ' + ComboBox1.Text+MEMO1.Text;

  try
    ipubtemp.ty_query(t_sql,quedata);
    if not varisnull(quedata) then
    begin                                                     
     if dmmain.dsquery.Active then dmmain.dsquery.Close;
      dmmain.dsquery.Data:=quedata;
      dmmain.dsquery.Open;
       dmmain.dsquery.Last;
       edtRecNo.Text := '��ǰ������: '+inttostr(dmmain.dsquery.recordcount)+'��';
      dmmain.dsquery.EnableControls;
    end else
    begin
       //����������
        dmmain.dsquery.EnableControls;        //ydy  ����Ҫ
       screen.Cursor :=  crdefault;
      exit;
    end;
  except
  end;
  dbgrid1.Refresh;
  dmmain.dsquery.EnableControls;   //ydy add 2004-4-13
  screen.Cursor :=  crdefault;

end;

procedure TFm_RemoteDb.FormShow(Sender: TObject);
begin
 if dmmain.dsquery.active then dmmain.dsquery.close;
 dmmain.dsquery.Data:=null;
end;

procedure TFm_RemoteDb.BtnDoClick(Sender: TObject);
var
  t_sql:string;
   quedata:olevariant;
begin
  screen.Cursor := crhourglass;
  try
   t_sql := trim(memo1.Text);
   ipubtemp.scrapsate(t_sql);
  except
  end;
  screen.Cursor :=  crdefault;
end;

end.
