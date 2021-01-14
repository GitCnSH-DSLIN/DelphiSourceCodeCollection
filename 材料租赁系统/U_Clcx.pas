unit U_Clcx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, FR_Dock, Grids, DBGridEh, Buttons,
  DB, ADODB,Mask;

type
  TfrmClcx = class(TForm)
    Panel1: TPanel;
    frTBPanel1: TfrTBPanel;
    Shape1: TShape;
    dtEnd: TDateTimePicker;
    dtStar: TDateTimePicker;
    DBGridEh1: TDBGridEh;
    frTBPanel2: TfrTBPanel;
    btnClose: TSpeedButton;
    btnQuery: TSpeedButton;
    btnPrint: TSpeedButton;
    frTBPanel3: TfrTBPanel;
    qytmp: TADOQuery;
    DataSource1: TDataSource;
    Label1: TLabel;
    cmbCl: TComboBox;
    cmbBm: TComboBox;
    Label3: TLabel;
    pShwomessage: TPanel;
    ADOCLCX: TADOQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1ColWidthsChanged(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
  FilterControlList: TStringList;
    { Public declarations }
  end;

var
  frmClcx: TfrmClcx;
  sSQL:string;
  const IndicatorWidth=11;
implementation
      USES MAIN,U_DM,u_public,common,utLeasehold,Repclcx, U_clffd, U_clhsd;
{$R *.dfm}
//������
procedure cacalfc(const TableName:string;ado,qytmp:TADOQuery); //������
var
  Ffcsl,
  Fshsl,
  Ssl,
  Ffczj,
  Fshzj,
  Djczj,Djcsl:Double;
  fSfno,nSfno:string;
  ynsf:boolean;
begin
  sSql:=' SELECT sfno, fcsl, fczj, shsl, shzj, jcsl, jczj, djzy, ynsf, dj, sfrq, bmname, spmc, jldw2, jldw,ggxh';
  sSql:=sSql+' FROM ' +  TableName +' order by sfrq';    //�ӱ��в������Ҫ������
  with qytmp do
  begin
    close;
    sql.Clear ;
    sql.Add(sSql);
    Prepared ;
    open;
    first;
    if RecordCount >0 then
    begin
       fSfno:=trim(FieldByName('sfno').AsString);
       Ffcsl:=Fieldbyname('fcsl').AsFloat ;
       Fshsl:=Fieldbyname('shsl').AsFloat ;
       Ffczj:=FieldByName('fczj').AsFloat  ;
       Fshzj:=FieldByName('shzj').AsFloat  ;
       ynsf:=Fieldbyname('ynsf').AsBoolean ;
     end;
     if not ynsf then
     begin
       Djcsl:=Ffcsl;
       Djczj:=Ffczj;
     end
     else
     begin
       Djcsl:=-1*Fshsl;
       Djczj:=-1*Fshzj;
     end;
       sSql:='UPDATE '+ TableName+' SET jcsl =:@jcsl,jczj=:@jczj  WHERE SFNO =:sfno';
       with ado do
       begin
         close;
         sql.Clear ;
         sql.Add(sSql);
         Parameters.ParamByName('@jcsl').Value :=Djcsl;
         Parameters.ParamByName('@jczj').Value :=Djczj;
         Parameters.ParamByName('sfno').Value :=fSfno;
         Prepared;
         ExecSQL ;
       end;
      MoveBy(1);
    while not Eof do
    begin
       nSfno:=trim(FieldByName('sfno').AsString);
       Ffcsl:=Fieldbyname('fcsl').AsFloat ;
       Fshsl:=Fieldbyname('shsl').AsFloat ;
       Ffczj:=FieldByName('fczj').AsFloat  ;
       Fshzj:=FieldByName('shzj').AsFloat  ;
       ynsf:=Fieldbyname('ynsf').AsBoolean ;
       if not ynsf then
       begin
          Djcsl:=Djcsl+Ffcsl;
          Djczj:=Djczj+Ffczj;
       end
       else begin
          Djcsl:=Djcsl-Fshsl;
          Djczj:=Djczj-Fshzj;
       end;
       //���½��
       sSql:='UPDATE '+ TableName+' SET jcsl =:@jcsl,jczj=:@jczj  WHERE SFNO =:sfno';
       with ado do
       begin
         close;
         sql.Clear ;
         sql.Add(sSql);
         Parameters.ParamByName('@jcsl').Value :=Djcsl;
         Parameters.ParamByName('@jczj').Value :=Djczj;
         Parameters.ParamByName('sfno').Value :=nSfno;
         Prepared;
         ExecSQL ;
       end;
       fSfno:=nSfno;
    next;
    end;
  end;
 qytmp.Close ;
 ado.Close ;
end;
///
procedure TfrmClcx.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := cafree;
  frmclcx:= nil;
end;

procedure TfrmClcx.btnCloseClick(Sender: TObject);
begin
close;
end;

procedure TfrmClcx.FormCreate(Sender: TObject);
begin
DBGridEh1.Align :=alclient;
dtStar.Date :=DATE;
DTEND.Date :=DATE;
end;

procedure TfrmClcx.btnPrintClick(Sender: TObject);
var
  qRepclcx:TqRepclcx;
  sBm:string;
begin
  sBm:=trim(cmbbm.Text);
  sBm:=returnint(']',sBm,0,false);
qRepclcx:=tqRepclcx.Create(self);
qRepclcx.lblBm.Caption  := qRepclcx.lblBm.Caption+sBm;
qRepclcx.lblPrintDate.Caption :='ʱ��:�� '+datetostr(dtstar.Date)+'-->'+datetostr(dtend.Date);
qRepclcx.lblDwname.Caption :=qRepclcx.lblDwname.Caption +CurrentParam.name;
qRepclcx.PreviewModal ;
qRepclcx.Free ;
end;

procedure TfrmClcx.btnQueryClick(Sender: TObject);
var
  sCl,sBm:string;
  Djcsl,Djczj:double;
begin
  sCl:=trim(cmbcl.Text);
  sBm:=trim(cmbbm.Text);
  sCl:=returnint(']',sCl,2,true);
  sBm:=returnint(']',sBm,2,true);

if sCl='' then
begin
Application.MessageBox('�������Ʋ�Ϊ��!������������', '��ʾ��Ϣ', mb_iconInformation + mb_defbutton1);
exit;
end;
screen.Cursor := crHourGlass;
pShwomessage.Caption :='���ڲ�ѯ���ݣ����Ժ�......' ;
pShwomessage.Visible :=true;
pShwomessage.Update ;
try
//������ʱ��clcx��sltclcx
if CheckTable('clcx',frmmain.adoqytmp) then
   repairTable('clcx',frmmain.adoqytmp) ;
if CheckTable('sltclcx',frmmain.adoqytmp) then
   repairTable('sltclcx',frmmain.adoqytmp) ;
sSQL:='SELECT sfno, fcsl, fczj, shsl, shzj, jcsl, jczj, djzy, ynsf, dj, sfrq, bmname, spmc, jldw2, jldw,ggxh';
sSQL:=sSQL+' INTO CLCX FROM vw_sfdj';
sSQL:=sSQL+' WHERE spbh=('+''''+sCl+''')';
if sBm<>'' then
sSQL:=sSQL+' AND bmbh=('+''''+sBm+''')';
sSQL:=sSQL+' ORDER BY sfrq';
ExecuteSQL(sSQL,frmmain.adoqytmp,true);
  cacalfc('clcx',QYTMP,frmmain.adoqytmp); //������
sSql:='SELECT jcsl,jczj from clcx WHERE SFRQ<:@SFRQ ORDER BY SFRQ DESC'; //��ѯ���Ľ����
with qytmp do
  begin
    close;
    sql.Clear ;
    sql.Add(sSql);
    Parameters.ParamByName('@sfrq').Value :=dtstar.Date ;
    Prepared ;
    open;
    first;
    Djcsl:=fields[0].AsFloat ;
    Djczj:=fields[1].AsFloat ;
end;
//������ʱ��SLTCLCX
Ssql:='SELECT *  INTO sltclcx FROM CLCX WHERE SFRQ BETWEEN :@STAR AND :@END ';
with qytmp do
  begin
    close;
    sql.Clear ;
    sql.Add(sSql);
    Parameters.ParamByName('@STAR').Value :=dtstar.Date ;
    Parameters.ParamByName('@END').Value :=dtEND.Date ;
    Prepared ;
    ExecSQL ;
end;
//�������ڽ����
sSQL:='INSERT INTO sltclcx(JCSL,JCZJ,djzy)';
sSQL:=sSQL+' VALUES(:@JCSL,:@JCZJ,:@djzy)';
with qytmp do
  begin
    close;
    sql.Clear ;
    sql.Add(sSql);
    Parameters.ParamByName('@JCSL').Value :=DJCSL ;
    Parameters.ParamByName('@JCZJ').Value :=DJCZJ ;
    Parameters.ParamByName('@DJZY').Value :='���ڽ����:' ;
    Prepared ;
    ExecSQL ;
end;
//��sltclcx���ѯ����
sSQL:='SELECT * FROM sltclcx ORDER BY  SFRQ' ;
with ADOCLCX do
  begin
    close;
    sql.Clear ;
    sql.Add(sSql);
    Prepared ;
    open;
  end;

except
Application.MessageBox('�����ύ����,��������Ӧ�ó���!', '����', mb_iconInformation + mb_defbutton1);
end;
pShwomessage.Visible :=false;
screen.Cursor := crDefault;
end;

procedure TfrmClcx.FormShow(Sender: TObject);
var
s_value:string;
begin
 //ȡ�����ϱ����ֵ
 dm.ADO_SPBMK.Active :=true;
 cmbcl.Clear ;
 dm.ADO_SPBMK.First ;
 while not dm.ADO_SPBMK.Eof do
 begin
   s_value:='['+trim(dm.ADO_SPBMK.Fieldbyname('spbh').AsString)+']';
   s_value:=s_value+trim(dm.ADO_SPBMK.Fieldbyname('spmc').AsString);
   cmbcl.Items.Add(s_value);
   dm.ADO_SPBMK.Next;
 end;
 dm.ADO_SPBMK.Close;
dm.ADO_BMBMK.Active :=true;
cmbbm.Clear ;
dm.ADO_BMBMK.First ;
while not dm.ADO_BMBMK.Eof do
begin
    s_value:='['+trim(dm.ADO_BMBMK.Fieldbyname('bmbh').AsString)+']';
    s_value:=s_value+trim(dm.ADO_BMBMK.Fieldbyname('bmname').AsString);
    cmbbm.Items.Add(s_value);
  dm.ADO_BMBMK.Next ;
end;
dm.ADO_BMBMK.Close ;

end;

procedure TfrmClcx.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if CheckTable('clcx',frmmain.adoqytmp) then
   repairTable('clcx',frmmain.adoqytmp) ;
if CheckTable('sltclcx',frmmain.adoqytmp) then
   repairTable('sltclcx',frmmain.adoqytmp) ;
end;

procedure TfrmClcx.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
if TRIM(ADOCLCX.FieldByName('DJZY').AsString)='���ڽ����:' then
begin
  DBGridEh1.Canvas.Font.Color :=clFuchsia;
  DBGridEh1.Canvas.Brush.Color :=clYellow;
  DBGridEh1.DefaultDrawColumnCell(rect,datacol,column,state) ; 
end;
end;

procedure TfrmClcx.DBGridEh1ColWidthsChanged(Sender: TObject);
var Indent,i,k:Integer;
    control:TControl;
begin
    if not Assigned(FilterControlList) then Exit;
    Indent := IndicatorWidth+2;

    for i := 0 to DBGridEh1.Columns.Count-1 do
    begin
      k := FilterControlList.IndexOf(DBGridEh1.Columns.Items[i].FieldName);
      if (k <> -1) then
      begin
        control := (TControl(FilterControlList.Objects[k]));
        control.Left := Indent+1;
        control.Width := DBGridEh1.Columns.Items[i].Width-1;
      end;
      Indent := Indent+DBGridEh1.Columns.Items[i].Width+1;
    end;

end;

procedure TfrmClcx.DBGridEh1DblClick(Sender: TObject);
var
 sSfno:string;
 dje:double;
begin
CurrentParam.blnADD :=true;
CurrentParam.N_E :=1;
sSfno:=trim(DBGridEh1.Fields[1].AsString);
dje:=DBGridEh1.Fields[5].AsFloat ;
//dsl:=DBGridEh1.Fields[6].AsFloat ;
CurrentParam.tmpCode :=sSfno;
if application.MessageBox('�Ƿ�Ҫ�˵���?��','��������ϵͳ!',MB_YESNO)=IDNO then
  EXIT;
//���뵥�ݱ�
if dje<>0 then
ShowModalForm(TfrmClffd)
else
ShowModalForm(Tfrmclhsd);
CurrentParam.blnADD :=false;
//btnQuery.Click ;
end;

end.
