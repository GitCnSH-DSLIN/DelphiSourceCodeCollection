{-----------------------------------------------------------------------------
 Unit Name: pppp
 Author:    ˮʯ������ 
 Purpose:
 History:
-----------------------------------------------------------------------------}
unit GZGL_print_YBB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   DBGrids, StdCtrls, ComCtrls, Buttons, ExtCtrls, Grids
  ;

type
  TFrmGZGL_Print_YBB = class(TForm)
    Panel4: TPanel;
    Label16: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    pag1: TPageControl;
    Tab1: TTabSheet;
    Pnl_lst: TPanel;
    Lst1: TListBox;
    lst2: TListBox;
    Pnl_contralBar: TPanel;
    btn_del1: TSpeedButton;
    btn_add1: TSpeedButton;
    btn_delALL: TSpeedButton;
    btn_addALL: TSpeedButton;
    Panel8: TPanel;
    btn_next1: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Tab2: TTabSheet;
    Panel5: TPanel;
    DBGrid2: TDBGrid;
    Tab3: TTabSheet;
    btn_preview: TSpeedButton;
    btn_print: TSpeedButton;
    Panel10: TPanel;
    SpeedButton9: TSpeedButton;
    btn_back3: TSpeedButton;
    Btn_exit: TSpeedButton;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EDT_Y: TEdit;
    EDT_M: TEdit;
    Panel6: TPanel;
    btn_next2: TSpeedButton;
    btn_back2: TSpeedButton;
    btn_fixdata: TSpeedButton;
    lab_info: TLabel;
    lab_start: TLabel;
    lab_over: TLabel;
    btn_getdata: TSpeedButton;
    procedure lst2DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_del1Click(Sender: TObject);
    procedure btn_add1Click(Sender: TObject);
    procedure btn_delALLClick(Sender: TObject);
    procedure btn_addALLClick(Sender: TObject);
    procedure Lst1DblClick(Sender: TObject);
    procedure btn_previewClick(Sender: TObject);
    procedure btn_fixdataClick(Sender: TObject);
    procedure btn_next2Click(Sender: TObject);
    procedure Tab1Show(Sender: TObject);
    procedure EDT_YKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pag1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure btn_back2Click(Sender: TObject);
    procedure btn_back3Click(Sender: TObject);
    procedure btn_getdataClick(Sender: TObject);
    procedure btn_next1Click(Sender: TObject);
    procedure btn_printClick(Sender: TObject);
    procedure Btn_exitClick(Sender: TObject);
  private
    procedure emptyTbl;
    procedure GetBaseData;
    procedure FixGetedData;
    procedure CountGetedData;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmGZGL_Print_YBB: TFrmGZGL_Print_YBB;

implementation

uses GZGL_DModule, GZGL_Main, GZGL_reports;

{$R *.dfm}

procedure TFrmGZGL_Print_YBB.FormShow(Sender: TObject);
var
  s:string;
begin
  pag1.ActivePageIndex:=0;
  with dmd do begin
    if not Tbl_GZ.Active then Tbl_gz.Open;
    if not Tbl_lb.Active then Tbl_lB.Open;
    if not Tbl_YBB.Active then Tbl_YBB.Open;
  end;
  //��ӳ����б�
  with dmd.TbL_lb do begin
    first;
    while not eof do begin
      s:=fieldbyname('lbmc').AsString;
      if s<>'' then begin
        lst1.Items.Add(s);
      end;
      next
    end;
  end;
  Image1.Picture:=FRMGZGL_Main.IMG_LOGO.Picture;

  EmptyTbl;
end;

{-----------------------------------------------------------------------------
  ��ʼ�����б��
-----------------------------------------------------------------------------}
//��ӵ���
procedure TFrmGZGL_Print_YBB.btn_add1Click(Sender: TObject);
var
  i,id:integer;
  s:string;
begin
  id:=lst1.ItemIndex;
  if id>=0 then begin
    s:=lst1.items[id];
    for i:=0 to lst2.Count-1 do begin
      if s=lst2.Items[i] then begin
        exit;
      end;
    end;
    lst2.Items.Add(lst1.items[id]);
  end;
end;
//ɾ����ӵ���
procedure TFrmGZGL_Print_YBB.btn_del1Click(Sender: TObject);
var
  i:integer;
begin
  i:=lst2.ItemIndex;
  if i>=0 then
    lst2.Items.Delete(I)
end;
//�������
procedure TFrmGZGL_Print_YBB.btn_addALLClick(Sender: TObject);
begin
  lst2.Items:=lst1.items;
end;
procedure TFrmGZGL_Print_YBB.btn_delALLClick(Sender: TObject);
begin
  lst2.Clear;
end;
procedure TFrmGZGL_Print_YBB.lst1DblClick(Sender: TObject);
begin
  btn_add1Click(Sender);
end;
procedure TFrmGZGL_Print_YBB.Lst2DblClick(Sender: TObject);
begin
  btn_DEL1Click(Sender);
end;
{-----------------------------------------------------------------------------
  ���������б��
-----------------------------------------------------------------------------}

procedure TFrmGZGL_Print_YBB.btn_getdataClick(Sender: TObject);
var
  s:string;
begin
  if lst2.Count<1 then begin
    s:='ι��ι���������ǣ������Ͷ�û�б�ʲô��';
    pag1.ActivePageIndex:=0;
    MessageBox(application.handle,pchar(s),'����',mb_ICONerror+mb_ok);
    exit;
  end;
  if (strlen(pchar(edt_y.Text))<>4)or(strlen(pchar(edt_m.Text))<>2) then begin
    s:='��ƣ��������乻4λ���ں�2λ�·ݣ�';
    MessageBox(application.handle,pchar(s),'����',mb_ICONerror+mb_ok);
    pag1.ActivePageIndex:=0;
    exit;
  end;
  pag1.ActivePageIndex:=1;
  lab_start.Caption:='��ʼ�ڣ�'+timetostr(now);
  lab_over.Caption:='�����ڣ�';
  lab_info.Caption:='���ڴ�������......';
  self.Refresh;
  lab_info.Caption:='��ʼ������......';
  emptyTbl;
  lab_info.Caption:='��ȡ��������......';
  GetBaseData;
  lab_info.Caption:='����������......';
  CountGetedData;

  lab_over.Caption:='�����ڣ�'+timetostr(now);
  lab_info.Caption:='���ݴ������';
end;
//
procedure TFrmGZGL_Print_YBB.btn_previewClick(Sender: TObject);
begin
  with frmGZGL_Reports do begin
    Lab_Y.Caption:=EDT_Y.text+'��'+edt_m.text+'��';
    Lab_Y2.Caption:=Lab_Y.Caption;
  end;
  try
    FrmGZGL_Reports.QR_YBB.Preview;
  except

  end;
end;
//
procedure TFrmGZGL_Print_YBB.btn_printClick(Sender: TObject);
begin
  try
    //FrmGZGL_Reports.QR_YBB.print;
  except

  end;
end;
//
procedure TFrmGZGL_Print_YBB.btn_fixdataClick(Sender: TObject);
begin
  FixGetedData;
end;
//
procedure TFrmGZGL_Print_YBB.emptyTbl;
var
  s:string;
begin
  if dmd.Tbl_YBB.RecordCount<1 then exit;
  with dmd.qry_temp do begin
    s:='delete from ��ĩ���� ';
    if active then close;
    sql.Clear;
    sql.Add(s);
    execsql;
    dmd.Tbl_YBB.close;
    dmd.Tbl_YBB.open;
  end;
end;


procedure TFrmGZGL_Print_YBB.GetBaseData;
var
  s,s1:string; //sql���ǰ�Σ����
  BBRQ,lbdh,lbmc:string; //�������ڣ������ţ��������
  gshj,czhj:integer;//��ʱ�ϼƣ���ֵ�ϼ�
  n,i:integer;//����lst2ѭ��������ok����ѭ��
  ok:array[1..15]of integer;//ͳ�ƺõĸ��ֶ�ֵ
begin
  bbrq:=edt_y.Text+'-'+edt_m.Text;
  for n:=0 to lst2.count-1 do begin
    application.ProcessMessages;
    lbmc:=lst2.Items[n];
    lab_info.Caption:='��ȡ��������'+lbmc;
    dmd.tbl_lb.Locate('lbmc',lbmc,[]);
    lbdh:=dmd.tbl_lb.fieldbyname('lbdh').AsString;
    for i:=1 to 15 do begin
      application.ProcessMessages;
      s1:='select gzbh from ��װ where lb="'+lbdh+'" ';
      case i of
        1 :s:=' and gzbh like "__[0][8]%" and DHRQ like "'+bbrq+'%"';//���� 0
        2 :s:=' and gzbh like "__[0][8]%" and WGRQ like "'+bbrq+'%"';
        3 :s:=' and gzbh like "__[0][8]%" and YZRQ like "'+bbrq+'%"';
        4 :s:=' and gzbh like "__[1]%" and DHRQ like "'+bbrq+'%"';//ģ�� 1
        5 :s:=' and gzbh like "__[1]%" and WGRQ like "'+bbrq+'%"';
        6 :s:=' and gzbh like "__[1]%" and YZRQ like "'+bbrq+'%"';
        7 :s:=' and gzbh like "__[268]%" and DHRQ like "'+bbrq+'%"';//������ 2 6 8
        8 :s:=' and gzbh like "__[268]%" and WGRQ like "'+bbrq+'%"';
        9 :s:=' and gzbh like "__[268]%" and YZRQ like "'+bbrq+'%"';
        10:s:=' and gzbh like "__[7]%" and DHRQ like "'+bbrq+'%"';//�о� 7
        11:s:=' and gzbh like "__[7]%" and WGRQ like "'+bbrq+'%"';
        12:s:=' and gzbh like "__[7]%" and YZRQ like "'+bbrq+'%"';
        13:
        begin
          s:=' and gzbh like "__[0][0-79]%" and DHRQ like "'+bbrq+'%"';//���� [0][^8]
          s:=' and gzbh like "__[3459]%" and DHRQ like "'+bbrq+'%"';//���� [3459]
        end;
        14:
        begin
          s:=' and gzbh like "__[0][0-79]%" and WGRQ like "'+bbrq+'%"';//���� [0][^8]
          s:=' and gzbh like "__[3459]%" and WGRQ like "'+bbrq+'%"';//���� [3459]
        end;
        15:
        begin
          s:=' and gzbh like "__[0][0-79]%" and YZRQ like "'+bbrq+'%"';//���� [0][^8]
          s:=' and gzbh like "__[3459]%" and YZRQ like "'+bbrq+'%"';//���� [3459]
        end;
      end;
      s:=s1+s;
      with dmd.Qry_temp do begin
        close;
        sql.Clear;
        sql.Add(s);
        try
          open;
        except
          execsql;
        end;
        ok[i]:=recordcount; //һ��ֻΪ��һ��....
      end;
    end;{for i}
    //��ʱ�ϼ�,��ֵ�ϼ�
    with dmd.qry_temp do begin
      close;
      sql.clear;
      s1:='select sum(gs) as ��ʱ�ϼ�,sum(cz) as ��ֵ�ϼ� from ��װ where lb="'+lbdh+'" ';
      s:=' and WGRQ like "'+bbrq+'%"';
      sql.Add(s1+s);
      try
        open;
      except
        execsql;
      end;
      gshj:=FieldByName('��ʱ�ϼ�').asinteger;
      czhj:=fieldbyname('��ֵ�ϼ�').asinteger;
    end;
    with dmd.Tbl_YBB do begin
      Append;
      FieldByName('����').Asstring:=lbmc;
      FieldByName('���߶���').Asinteger:=ok[1];
      FieldByName('�����깤').Asinteger:=ok[2];
      FieldByName('������֤').Asinteger:=ok[3];

      FieldByName('ģ�߶���').Asinteger:=ok[4];
      FieldByName('ģ���깤').Asinteger:=ok[5];
      FieldByName('ģ����֤').Asinteger:=ok[6];

      FieldByName('����������').Asinteger:=ok[7];
      FieldByName('�������깤').Asinteger:=ok[8];
      FieldByName('��������֤').Asinteger:=ok[9];

      FieldByName('�о߶���').Asinteger:=ok[10];
      FieldByName('�о��깤').Asinteger:=ok[11];
      FieldByName('�о���֤').Asinteger:=ok[12];

      FieldByName('��������').Asinteger:=ok[13];
      FieldByName('�����깤').Asinteger:=ok[14];
      FieldByName('������֤').Asinteger:=ok[15];

      FieldByName('����С��').Asinteger:=ok[1]+ok[4]+ok[7]+ok[10]+ok[13];
      FieldByName('�깤С��').Asinteger:=ok[2]+ok[5]+ok[8]+ok[11]+ok[14];
      FieldByName('��֤С��').Asinteger:=ok[3]+ok[6]+ok[9]+ok[12]+ok[15];

      FieldByName('��ʱС��').Asinteger:=gshj;
      FieldByName('��ֵС��').Asinteger:=czhj;
      post;
    end;
  end;{for n}
end;

procedure TFrmGZGL_Print_YBB.FixGetedData;
var
  s:string;
begin
  with dmd.qry_temp do begin
    s:='delete from ��ĩ���� where ����<>"�ϼ�" and ';
    s:=s+'���߶���+ģ�߶���+�о߶���+����������+��������+';
    s:=s+'�����깤+ģ���깤+�о��깤+�������깤+�����깤+';
    s:=s+'������֤+ģ����֤+�о���֤+��������֤+������֤=0';
    if active then close;
    sql.Clear;
    sql.Add(s);
    execsql;
    dmd.Tbl_YBB.close;
    dmd.Tbl_YBB.open;
  end;
end;

procedure TFrmGZGL_Print_YBB.CountGetedData;
var
  s:string;
begin
  //���㡢��Ӻϼ�
  with dmd.qry_temp do begin
    close;
    sql.clear;
    s:='select ';
    s:=s+' sum(����С��)as dhxj,sum(���߶���)as hjdh,sum(ģ�߶���)as mjdh,sum(�о߶���)as qjdh,sum(����������)as dfldh,sum(��������)as qtdh,';
    s:=s+' sum(�깤С��)as wgxj,sum(�����깤)as hjwg,sum(ģ���깤)as mjwg,sum(�о��깤)as qjwg,sum(�������깤)as dflwg,sum(�����깤)as qtwg,';
    s:=s+' sum(��֤С��)as yzxj,sum(������֤)as hjyz,sum(ģ����֤)as mjyz,sum(�о���֤)as qjyz,sum(��������֤)as dflyz,sum(������֤)as qtyz,';
    s:=s+' sum(��ʱС��)as gsxj,sum(��ֵС��)as czxj  from ��ĩ����';
    sql.Add(s);
    try
      open;
    except
      execsql;
    end;
  end;
  with dmd.Tbl_YBB do begin
    Append;
    FieldByName('����').Asstring:='�ϼ�';
    FieldByName('���߶���').Asinteger:=dmd.Qry_temp.fieldbyname('hjdh').AsInteger;
    FieldByName('�����깤').Asinteger:=dmd.Qry_temp.fieldbyname('hjwg').AsInteger;
    FieldByName('������֤').Asinteger:=dmd.Qry_temp.fieldbyname('hjyz').AsInteger;

    FieldByName('ģ�߶���').Asinteger:=dmd.Qry_temp.fieldbyname('mjdh').AsInteger;
    FieldByName('ģ���깤').Asinteger:=dmd.Qry_temp.fieldbyname('mjwg').AsInteger;
    FieldByName('ģ����֤').Asinteger:=dmd.Qry_temp.fieldbyname('mjyz').AsInteger;

    FieldByName('����������').Asinteger:=dmd.Qry_temp.fieldbyname('dfldh').AsInteger;
    FieldByName('�������깤').Asinteger:=dmd.Qry_temp.fieldbyname('dflwg').AsInteger;
    FieldByName('��������֤').Asinteger:=dmd.Qry_temp.fieldbyname('dflyz').AsInteger;

    FieldByName('�о߶���').Asinteger:=dmd.Qry_temp.fieldbyname('qjdh').AsInteger;
    FieldByName('�о��깤').Asinteger:=dmd.Qry_temp.fieldbyname('qjwg').AsInteger;
    FieldByName('�о���֤').Asinteger:=dmd.Qry_temp.fieldbyname('qjyz').AsInteger;

    FieldByName('��������').Asinteger:=dmd.Qry_temp.fieldbyname('qtdh').AsInteger;
    FieldByName('�����깤').Asinteger:=dmd.Qry_temp.fieldbyname('qtwg').AsInteger;
    FieldByName('������֤').Asinteger:=dmd.Qry_temp.fieldbyname('qtyz').AsInteger;

    FieldByName('����С��').Asinteger:=dmd.Qry_temp.fieldbyname('dhxj').AsInteger;
    FieldByName('�깤С��').Asinteger:=dmd.Qry_temp.fieldbyname('wgxj').AsInteger;
    FieldByName('��֤С��').Asinteger:=dmd.Qry_temp.fieldbyname('yzxj').AsInteger;

    FieldByName('��ʱС��').Asinteger:=dmd.Qry_temp.fieldbyname('gsxj').AsInteger;
    FieldByName('��ֵС��').Asinteger:=dmd.Qry_temp.fieldbyname('czxj').AsInteger;
    post;
  end;
end;

procedure TFrmGZGL_Print_YBB.btn_next2Click(Sender: TObject);
begin
  pag1.ActivePageIndex:=2;
end;

procedure TFrmGZGL_Print_YBB.Tab1Show(Sender: TObject);
begin
  edt_y.SetFocus;
  edt_y.SelectAll;
end;

procedure TFrmGZGL_Print_YBB.EDT_YKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if strlen(pchar(edt_y.Text))=4 then begin
    edt_m.SetFocus;
    edt_m.SelectAll;
  end;

end;

procedure TFrmGZGL_Print_YBB.pag1Changing(Sender: TObject; var AllowChange: Boolean);
begin
  if (pag1.ActivePageIndex=0)and((lst2.Count<1)or(strlen(pchar(edt_y.Text))<>4)or(strlen(pchar(edt_m.Text))<>2)) then
    AllowChange:=false;
end;

procedure TFrmGZGL_Print_YBB.btn_back2Click(Sender: TObject);
begin
  pag1.ActivePageIndex:=0;
end;

procedure TFrmGZGL_Print_YBB.btn_back3Click(Sender: TObject);
begin
  pag1.ActivePageIndex:=1;
end;


procedure TFrmGZGL_Print_YBB.btn_next1Click(Sender: TObject);
begin
  if (pag1.ActivePageIndex=0)and((lst2.Count<1)or(strlen(pchar(edt_y.Text))<>4)or(strlen(pchar(edt_m.Text))<>2)) then
  else begin
    pag1.ActivePageIndex:=1;
    btn_getdataClick(Sender)
  end;  
end;

procedure TFrmGZGL_Print_YBB.Btn_exitClick(Sender: TObject);
begin
  close;
end;

end.

