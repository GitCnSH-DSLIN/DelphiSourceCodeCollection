{-----------------------------------------------------------------------------
 Unit Name: pppp
 Author:    ˮʯ������ 
 Purpose:
 History:
-----------------------------------------------------------------------------}
unit GZGL_print_NBB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Grids, DBGrids, StdCtrls, ComCtrls,  Buttons, ExtCtrls
  ;

type
  TFrmGZGL_Print_NBB = class(TForm)
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
    Tab3: TTabSheet;
    btn_preview: TSpeedButton;
    btn_print: TSpeedButton;
    Btn_exit: TSpeedButton;
    Panel10: TPanel;
    SpeedButton9: TSpeedButton;
    btn_back3: TSpeedButton;
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
    procedure EDT_YKeyPress(Sender: TObject; var Key: Char);
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
  FrmGZGL_Print_NBB: TFrmGZGL_Print_NBB;

implementation

uses GZGL_DModule, GZGL_Main, GZGL_reports;

{$R *.dfm}

procedure TFrmGZGL_Print_NBB.FormShow(Sender: TObject);
var
  s:string;
begin
  pag1.ActivePageIndex:=0;
  with dmd do begin
    if not Tbl_GZ.Active then Tbl_gz.Open;
    if not Tbl_lb.Active then Tbl_lB.Open;
    if not Tbl_NBB.Active then Tbl_NBB.Open;
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

  emptyTbl;
end;

{-----------------------------------------------------------------------------
  ��ʼ�����б��
-----------------------------------------------------------------------------}
//��ӵ���
procedure TFrmGZGL_Print_NBB.btn_add1Click(Sender: TObject);
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
procedure TFrmGZGL_Print_NBB.btn_del1Click(Sender: TObject);
var
  i:integer;
begin
  i:=lst2.ItemIndex;
  if i>=0 then
    lst2.Items.Delete(I)
end;
//�������
procedure TFrmGZGL_Print_NBB.btn_addALLClick(Sender: TObject);
begin
  lst2.Items:=lst1.items;
end;
procedure TFrmGZGL_Print_NBB.btn_delALLClick(Sender: TObject);
begin
  lst2.Clear;
end;
procedure TFrmGZGL_Print_NBB.lst1DblClick(Sender: TObject);
begin
  btn_add1Click(Sender);
end;
procedure TFrmGZGL_Print_NBB.Lst2DblClick(Sender: TObject);
begin
  btn_DEL1Click(Sender);
end;
{-----------------------------------------------------------------------------
  ���������б��
-----------------------------------------------------------------------------}
procedure TFrmGZGL_Print_NBB.btn_getdataClick(Sender: TObject);
var
  s:string;
begin
  if lst2.Count<1 then begin
    s:='ι��ι���������ǣ������Ͷ�û�б�ʲô��';
    pag1.ActivePageIndex:=0;
    MessageBox(application.handle,pchar(s),'����',mb_ICONerror+mb_ok);
    exit;
  end;
  if (strlen(pchar(edt_y.Text))<>4) then begin
    s:='��ƣ��������乻4λ���ڣ�';
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

procedure TFrmGZGL_Print_NBB.btn_previewClick(Sender: TObject);
begin
  with frmGZGL_Reports do begin
    Lab_N.Caption:=EDT_Y.text+'��';
    Lab_N2.Caption:=Lab_N.Caption;
  end;
  try
    FrmGZGL_Reports.QR_NBB.Preview;
  except
    //QRListForm.close;
  end;
end;

procedure TFrmGZGL_Print_NBB.btn_printClick(Sender: TObject);
begin
  try
    //FrmGZGL_Reports.QR_NBB.print;
  except
    //QRListForm.close;
  end;
end;

procedure TFrmGZGL_Print_NBB.btn_fixdataClick(Sender: TObject);
begin
  FixGetedData;
end;

procedure TFrmGZGL_Print_NBB.emptyTbl;
var
  s:string;
begin
  if dmd.Tbl_NBB.RecordCount<1 then exit;
  with dmd.qry_temp do begin
    s:='delete from ���ձ��� ';
    if active then close;
    sql.Clear;
    sql.Add(s);
    execsql;
    dmd.Tbl_NBB.close;
    dmd.Tbl_NBB.open;
  end;
end;


procedure TFrmGZGL_Print_NBB.GetBaseData;
var
  s,s1:string; //sql���ǰ�Σ����
  BBRQ,lbdh,lbmc:string; //�������ڣ������ţ��������
  gshj,czhj,xj:integer;//��ʱ�ϼƣ���ֵ�ϼ�
  n,i:integer;//����lst2ѭ��������ok����ѭ��
  ok:array[1..36]of integer;//ͳ�ƺõĸ��ֶ�ֵ
begin
  bbrq:=edt_y.Text;
  for n:=0 to lst2.count-1 do begin
    application.ProcessMessages;
    lbmc:=lst2.Items[n];
    lab_info.Caption:='���ڴ���'+lbmc;
    dmd.tbl_lb.Locate('lbmc',lbmc,[]);
    lbdh:=dmd.tbl_lb.fieldbyname('lbdh').AsString;
    for i:=1 to 36 do begin
      application.ProcessMessages;
      s1:='select gzbh from ��װ where lb="'+lbdh+'" ';
      case i of
        1 :s:=' and DHRQ like "'+bbrq+'-01-%"';
        2 :s:=' and DHRQ like "'+bbrq+'-02-%"';
        3 :s:=' and DHRQ like "'+bbrq+'-03-%"';
        4 :s:=' and DHRQ like "'+bbrq+'-04-%"';
        5 :s:=' and DHRQ like "'+bbrq+'-05-%"';
        6 :s:=' and DHRQ like "'+bbrq+'-06-%"';
        7 :s:=' and DHRQ like "'+bbrq+'-07-%"';
        8 :s:=' and DHRQ like "'+bbrq+'-08-%"';
        9 :s:=' and DHRQ like "'+bbrq+'-09-%"';
        10:s:=' and DHRQ like "'+bbrq+'-10-%"';
        11:s:=' and DHRQ like "'+bbrq+'-11-%"';
        12:s:=' and DHRQ like "'+bbrq+'-12-%"';

        13:s:=' and WGRQ like "'+bbrq+'-01-%"';
        14:s:=' and WGRQ like "'+bbrq+'-02-%"';
        15:s:=' and WGRQ like "'+bbrq+'-03-%"';
        16:s:=' and WGRQ like "'+bbrq+'-04-%"';
        17:s:=' and WGRQ like "'+bbrq+'-05-%"';
        18:s:=' and WGRQ like "'+bbrq+'-06-%"';
        19:s:=' and WGRQ like "'+bbrq+'-07-%"';
        20:s:=' and WGRQ like "'+bbrq+'-08-%"';
        21:s:=' and WGRQ like "'+bbrq+'-09-%"';
        22:s:=' and WGRQ like "'+bbrq+'-10-%"';
        23:s:=' and WGRQ like "'+bbrq+'-11-%"';
        24:s:=' and WGRQ like "'+bbrq+'-12-%"';

        25:s:=' and YZRQ like "'+bbrq+'-01-%"';
        26:s:=' and YZRQ like "'+bbrq+'-02-%"';
        27:s:=' and YZRQ like "'+bbrq+'-03-%"';
        28:s:=' and YZRQ like "'+bbrq+'-04-%"';
        29:s:=' and YZRQ like "'+bbrq+'-05-%"';
        30:s:=' and YZRQ like "'+bbrq+'-06-%"';
        31:s:=' and YZRQ like "'+bbrq+'-07-%"';
        32:s:=' and YZRQ like "'+bbrq+'-08-%"';
        33:s:=' and YZRQ like "'+bbrq+'-09-%"';
        34:s:=' and YZRQ like "'+bbrq+'-10-%"';
        35:s:=' and YZRQ like "'+bbrq+'-11-%"';
        36:s:=' and YZRQ like "'+bbrq+'-12-%"';
      end;
      s:=s1+s; //�ϳ�SQL���
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
    with dmd.Tbl_NBB do begin
      Append;
      FieldByName('����').Asstring:=lbmc;
      FieldByName('һ�¶���').Asinteger:=ok[1];
      FieldByName('���¶���').Asinteger:=ok[2];
      FieldByName('���¶���').Asinteger:=ok[3];
      FieldByName('���¶���').Asinteger:=ok[4];
      FieldByName('���¶���').Asinteger:=ok[5];
      FieldByName('���¶���').Asinteger:=ok[6];
      FieldByName('���¶���').Asinteger:=ok[7];
      FieldByName('���¶���').Asinteger:=ok[8];
      FieldByName('���¶���').Asinteger:=ok[9];
      FieldByName('ʮ�¶���').Asinteger:=ok[10];
      FieldByName('ʮһ�¶���').Asinteger:=ok[11];
      FieldByName('ʮ���¶���').Asinteger:=ok[12];

      FieldByName('һ���깤').Asinteger:=ok[13];
      FieldByName('�����깤').Asinteger:=ok[14];
      FieldByName('�����깤').Asinteger:=ok[15];
      FieldByName('�����깤').Asinteger:=ok[16];
      FieldByName('�����깤').Asinteger:=ok[17];
      FieldByName('�����깤').Asinteger:=ok[18];
      FieldByName('�����깤').Asinteger:=ok[19];
      FieldByName('�����깤').Asinteger:=ok[20];
      FieldByName('�����깤').Asinteger:=ok[21];
      FieldByName('ʮ���깤').Asinteger:=ok[22];
      FieldByName('ʮһ���깤').Asinteger:=ok[23];
      FieldByName('ʮ�����깤').Asinteger:=ok[24];

      FieldByName('һ����֤').Asinteger:=ok[25];
      FieldByName('������֤').Asinteger:=ok[26];
      FieldByName('������֤').Asinteger:=ok[27];
      FieldByName('������֤').Asinteger:=ok[28];
      FieldByName('������֤').Asinteger:=ok[29];
      FieldByName('������֤').Asinteger:=ok[30];
      FieldByName('������֤').Asinteger:=ok[31];
      FieldByName('������֤').Asinteger:=ok[32];
      FieldByName('������֤').Asinteger:=ok[33];
      FieldByName('ʮ����֤').Asinteger:=ok[34];
      FieldByName('ʮһ����֤').Asinteger:=ok[35];
      FieldByName('ʮ������֤').Asinteger:=ok[36];

      xj:=0;
      for i:=1 to 12 do
        xj:=xj+ok[i];
      FieldByName('����С��').Asinteger:=xj;

      xj:=0;
      for i:=13 to 24 do
        xj:=xj+ok[i];
      FieldByName('�깤С��').Asinteger:=xj;

      xj:=0;
      for i:=25 to 36 do
        xj:=xj+ok[i];
      FieldByName('��֤С��').Asinteger:=xj;

      FieldByName('��ʱС��').Asinteger:=gshj;
      FieldByName('��ֵС��').Asinteger:=czhj;
      post;
    end;
  end;{for n}
end;

procedure TFrmGZGL_Print_NBB.FixGetedData;
var
  s:string;
begin
  with dmd.qry_temp do begin
    s:='delete from ���ձ��� where ����<>"�ϼ�" and ';
    s:=s+'����С��+�깤С��+��֤С��=0';
    if active then close;
    sql.Clear;
    sql.Add(s);
    execsql;
    dmd.Tbl_NBB.close;
    dmd.Tbl_NBB.open;
  end;
end;

procedure TFrmGZGL_Print_NBB.CountGetedData;
var
  s:string;
begin
  //���㡢��Ӻϼ�
  with dmd.qry_temp do begin
    close;
    sql.clear;
    s:='select ';
    s:=s+' sum(һ�¶���)  as dh1, sum(һ���깤)  as wg1, sum(һ����֤)  as yz1,';
    s:=s+' sum(���¶���)  as dh2, sum(�����깤)  as wg2, sum(������֤)  as yz2,';
    s:=s+' sum(���¶���)  as dh3, sum(�����깤)  as wg3, sum(������֤)  as yz3,';
    s:=s+' sum(���¶���)  as dh4, sum(�����깤)  as wg4, sum(������֤)  as yz4,';
    s:=s+' sum(���¶���)  as dh5, sum(�����깤)  as wg5, sum(������֤)  as yz5,';
    s:=s+' sum(���¶���)  as dh6, sum(�����깤)  as wg6, sum(������֤)  as yz6,';
    s:=s+' sum(���¶���)  as dh7, sum(�����깤)  as wg7, sum(������֤)  as yz7,';
    s:=s+' sum(���¶���)  as dh8, sum(�����깤)  as wg8, sum(������֤)  as yz8,';
    s:=s+' sum(���¶���)  as dh9, sum(�����깤)  as wg9, sum(������֤)  as yz9,';
    s:=s+' sum(ʮ�¶���)  as dh10,sum(ʮ���깤)  as wg10,sum(ʮ����֤)  as yz10,';
    s:=s+' sum(ʮһ�¶���)as dh11,sum(ʮһ���깤)as wg11,sum(ʮһ����֤)as yz11,';
    s:=s+' sum(ʮ���¶���)as dh12,sum(ʮ�����깤)as wg12,sum(ʮ������֤)as yz12,';
    s:=s+' sum(����С��)  as dh13,sum(�깤С��)  as wg13,sum(��֤С��)  as yz13,';
    s:=s+' sum(��ʱС��)  as gsxj,sum(��ֵС��)as czxj from ���ձ���';
   sql.Add(s);
    try
      open;
    except
      execsql;
    end;
  end;
  with dmd.Tbl_NBB do begin
    Append;
    FieldByName('����').Asstring:='�ϼ�';
    FieldByName('һ�¶���').Asinteger:= dmd.Qry_temp.fieldbyname('dh1').AsInteger;
    FieldByName('���¶���').Asinteger:= dmd.Qry_temp.fieldbyname('dh2').AsInteger;
    FieldByName('���¶���').Asinteger:= dmd.Qry_temp.fieldbyname('dh3').AsInteger;
    FieldByName('���¶���').Asinteger:= dmd.Qry_temp.fieldbyname('dh4').AsInteger;
    FieldByName('���¶���').Asinteger:= dmd.Qry_temp.fieldbyname('dh5').AsInteger;
    FieldByName('���¶���').Asinteger:= dmd.Qry_temp.fieldbyname('dh6').AsInteger;
    FieldByName('���¶���').Asinteger:= dmd.Qry_temp.fieldbyname('dh7').AsInteger;
    FieldByName('���¶���').Asinteger:= dmd.Qry_temp.fieldbyname('dh8').AsInteger;
    FieldByName('���¶���').Asinteger:= dmd.Qry_temp.fieldbyname('dh9').AsInteger;
    FieldByName('ʮ�¶���').Asinteger:=dmd.Qry_temp.fieldbyname('dh10').AsInteger;
    FieldByName('ʮһ�¶���').Asinteger:=dmd.Qry_temp.fieldbyname('dh11').AsInteger;
    FieldByName('ʮ���¶���').Asinteger:=dmd.Qry_temp.fieldbyname('dh12').AsInteger;
    FieldByName('����С��').Asinteger:=dmd.Qry_temp.fieldbyname('dh13').AsInteger;

    FieldByName('һ���깤').Asinteger:= dmd.Qry_temp.fieldbyname('wg1').AsInteger;
    FieldByName('�����깤').Asinteger:= dmd.Qry_temp.fieldbyname('wg2').AsInteger;
    FieldByName('�����깤').Asinteger:= dmd.Qry_temp.fieldbyname('wg3').AsInteger;
    FieldByName('�����깤').Asinteger:= dmd.Qry_temp.fieldbyname('wg4').AsInteger;
    FieldByName('�����깤').Asinteger:= dmd.Qry_temp.fieldbyname('wg5').AsInteger;
    FieldByName('�����깤').Asinteger:= dmd.Qry_temp.fieldbyname('wg6').AsInteger;
    FieldByName('�����깤').Asinteger:= dmd.Qry_temp.fieldbyname('wg7').AsInteger;
    FieldByName('�����깤').Asinteger:= dmd.Qry_temp.fieldbyname('wg8').AsInteger;
    FieldByName('�����깤').Asinteger:= dmd.Qry_temp.fieldbyname('wg9').AsInteger;
    FieldByName('ʮ���깤').Asinteger:=dmd.Qry_temp.fieldbyname('wg10').AsInteger;
    FieldByName('ʮһ���깤').Asinteger:=dmd.Qry_temp.fieldbyname('wg11').AsInteger;
    FieldByName('ʮ�����깤').Asinteger:=dmd.Qry_temp.fieldbyname('wg12').AsInteger;
    FieldByName('�깤С��').Asinteger:=dmd.Qry_temp.fieldbyname('wg13').AsInteger;

    FieldByName('һ����֤').Asinteger:= dmd.Qry_temp.fieldbyname('yz1').AsInteger;
    FieldByName('������֤').Asinteger:= dmd.Qry_temp.fieldbyname('yz2').AsInteger;
    FieldByName('������֤').Asinteger:= dmd.Qry_temp.fieldbyname('yz3').AsInteger;
    FieldByName('������֤').Asinteger:= dmd.Qry_temp.fieldbyname('yz4').AsInteger;
    FieldByName('������֤').Asinteger:= dmd.Qry_temp.fieldbyname('yz5').AsInteger;
    FieldByName('������֤').Asinteger:= dmd.Qry_temp.fieldbyname('yz6').AsInteger;
    FieldByName('������֤').Asinteger:= dmd.Qry_temp.fieldbyname('yz7').AsInteger;
    FieldByName('������֤').Asinteger:= dmd.Qry_temp.fieldbyname('yz8').AsInteger;
    FieldByName('������֤').Asinteger:= dmd.Qry_temp.fieldbyname('yz9').AsInteger;
    FieldByName('ʮ����֤').Asinteger:=dmd.Qry_temp.fieldbyname('yz10').AsInteger;
    FieldByName('ʮһ����֤').Asinteger:=dmd.Qry_temp.fieldbyname('yz11').AsInteger;
    FieldByName('ʮ������֤').Asinteger:=dmd.Qry_temp.fieldbyname('yz12').AsInteger;
    FieldByName('��֤С��').Asinteger:=dmd.Qry_temp.fieldbyname('yz13').AsInteger;

    FieldByName('��ʱС��').Asinteger:=dmd.Qry_temp.fieldbyname('gsxj').AsInteger;
    FieldByName('��ֵС��').Asinteger:=dmd.Qry_temp.fieldbyname('czxj').AsInteger;
    post;
  end;
end;

procedure TFrmGZGL_Print_NBB.btn_next2Click(Sender: TObject);
begin
  pag1.ActivePageIndex:=2;
end;

procedure TFrmGZGL_Print_NBB.Tab1Show(Sender: TObject);
begin
  edt_y.SetFocus;
  edt_y.SelectAll;
end;

procedure TFrmGZGL_Print_NBB.EDT_YKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //if strlen(pchar(edt_y.Text))=4 then begin
  //  edt_m.SetFocus;
  //  edt_m.SelectAll;
  //end;

end;

procedure TFrmGZGL_Print_NBB.pag1Changing(Sender: TObject; var AllowChange: Boolean);
begin
  if (pag1.ActivePageIndex=0)and((lst2.Count<1)or(strlen(pchar(edt_y.Text))<>4)) then
    AllowChange:=false;
end;

procedure TFrmGZGL_Print_NBB.btn_back2Click(Sender: TObject);
begin
  pag1.ActivePageIndex:=0;
end;

procedure TFrmGZGL_Print_NBB.btn_back3Click(Sender: TObject);
begin
  pag1.ActivePageIndex:=1;
end;


procedure TFrmGZGL_Print_NBB.btn_next1Click(Sender: TObject);
begin
  if (pag1.ActivePageIndex=0)and((lst2.Count<1)or(strlen(pchar(edt_y.Text))<>4)) then
  else begin
    pag1.ActivePageIndex:=1;
    btn_getdataClick(Sender)
  end;  
end;


procedure TFrmGZGL_Print_NBB.Btn_exitClick(Sender: TObject);
begin
  close;
end;

procedure TFrmGZGL_Print_NBB.EDT_YKeyPress(Sender: TObject; var Key: Char);
begin
  if strlen(pchar(EDT_Y.Text))<>4 then EDT_Y.SetFocus;
end;

end.

