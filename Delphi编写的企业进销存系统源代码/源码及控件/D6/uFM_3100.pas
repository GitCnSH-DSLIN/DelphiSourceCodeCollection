unit uFM_3100;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, Spin, Mask, ToolEdit, Db, DBTables;

type
  TFM_3100 = class(TForm)
    Edit1: TEdit;
    ComboEdit1: TComboEdit;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    ComboBox1: TComboBox;
    BitBtn1: TBitBtn;
    SB6: TSpeedButton;
    Qry1: TQuery;
    Qry2: TQuery;
    Qry3: TQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SB6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboEdit1ButtonClick(Sender: TObject);
  private
  Procedure GetIncome(sCNo,sYear:string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FM_3100: TFM_3100;

implementation

Uses utilities;

{$R *.DFM}

//Ӧ����ת
Procedure TFM_3100.GetIncome(sCNo,sYear:string);
var
  iSTax,iSRecTotal,iPTax,iPRecTotal: real;
begin
  //ѡ��ĳһ����ĳһ�·ݰ��Ʒ˰�����,���Ʒ�������
  iSTax := 0;
  iSRecTotal := 0;
  QryExec(Qry1,'select F04,Sum(F08) as STaxtotal,Sum(F10) as SRectotal from T2150 where F03='''+sCNo+''' and F12='''+sYear+'''' +' group by F04' );
  Qry1.First;
  while not Qry1.Eof do
  begin
    //���ұ�ͳ��
    QryExec(Qry2,'select F02 from T1100 Where F01='''+Qry1.fieldbyName('F04').asstring+'''');
    iSTax := iSTax + Qry1.fieldbyName('STaxTotal').asFloat * Qry2.FieldbyName('F02').AsFloat;
    iSRecTotal := iSRecTotal + Qry1.fieldbyName('SRecTotal').asFloat * Qry2.FieldbyName('F02').AsFloat;
    Qry1.Next;
  end;

  //ѡ��ĳһ�ͻ�ĳһ�·��˻�˰�����,�˻������
  iPTax := 0;
  iPRecTotal := 0;
  QryExec(Qry1,'select F04,Sum(F08) as PTaxtotal,Sum(F10) as PRectotal from T2151 where F03='''+sCNo+''' and F12='''+sYear+'''' +' group by F04' );
  Qry1.First;
  while not Qry1.Eof do
  begin
    QryExec(Qry2,'select F02 from T1100 Where F01='''+Qry1.fieldbyName('F04').asstring+'''');
    iPTax := iPTax + Qry1.fieldbyName('PTaxTotal').asFloat * Qry2.FieldbyName('F02').Asfloat;
    iPRecTotal := iPRecTotal + Qry1.fieldbyName('PRecTotal').asFloat * Qry2.FieldbyName('F02').AsFloat;
    Qry1.next;
  end;
  



  //���������������ʴ���
  With Qry1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into T3110(F01,F02,F03,F05,F14) Values(:F01,:F02,:F03,:F05,:F14)') ;
    Params[0].asstring := sYear;
    Params[1].asstring := sCNo;
    Params[2].asfloat := iSRecTotal+iPRecTotal;
    Params[3].asfloat := iSTax+iPTax;
    Params[4].asfloat := iSTax+iPTax;

end;
  Qry1.ExecSQL;
end;


procedure TFM_3100.BitBtn1Click(Sender: TObject);
var
  sYear : string;
begin
  if (SpinEdit1.Text='') or (Combobox1.Text='') then
  begin
    R_OKMessage(['�������ʿ�����']);
    Abort;
  end;
  //ȡ���ʿ�����
  sYear := copy(SpinEdit1.Text,3,2)+Combobox1.Text;
  Try
    if comboEdit1.Text='' then //δѡ����
    begin
      //ɾ���Ѵ��ڵĳ�������
      QryExec(Qry2,'delete from T3110 Where F01='''+sYear+'''',false);
      QryExec(Qry2,'delete from T3110A Where F01='''+sYear+'''',false);
      //ѡ�����пͻ�
      QryExec(Qry3,'select F01 from T1030');
      Qry3.First;
      while not Qry3.eof do
      begin
        //�������н��׵Ŀͻ�
        QryExec(Qry1,'select sum(F10) from T2150 Where F03='''+Qry3.FieldByName('F01').AsString+''' and F12='''+sYear+'''');
        QryExec(Qry2,'select sum(F10) from T2151 Where F03='''+Qry3.FieldByName('F01').AsString+''' and F12='''+sYear+'''');
        if (Qry1.Fields[0].asfloat <> 0) or (Qry2.Fields[0].AsFloat <> 0) then
          GetIncome(Qry3.FieldByName('F01').AsString,sYear); //��ת��Ӧ����
        Qry3.Next;
      end;
    end
    else
    begin
      //ɾ���Ѵ��ڵĳ�������
      QryExec(Qry2,'delete from T3110 Where F02='''+ComboEdit1.Text+''' and F01='''+sYear+'''',false);
      QryExec(Qry2,'delete from T3110A Where F02='''+ComboEdit1.Text+''' and F01='''+sYear+'''',false);
      GetIncome(ComboEdit1.Text,sYear); //��ת��Ӧ����
    end;
    R_OKMessage(['��ת�ɹ�'])
  except
    R_OKMessage(['��תʧ��']);
  end;
end;

procedure TFM_3100.FormCreate(Sender: TObject);
begin
  width := 300;
  height := 200;
  left := 156;
  top := 100;
  SpinEdit1.Text := formatdatetime('yyyy',date);
  ComboBox1.ItemIndex := strtoint(formatdatetime('mm',date))-1;
end;

procedure TFM_3100.SB6Click(Sender: TObject);
begin
  close;
end;

procedure TFM_3100.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFM_3100.ComboEdit1ButtonClick(Sender: TObject);
var
  xS : TStringList;
begin
  xs := select_text('�ͻ���ѡ����','Select distinct A.F03 AS ���⳧�̱��, T1.F02 AS ���̼��'
                                  +' From T2150 AS A'
                                  +' Left Join T1030 as T1 on A.F03=T1.F01  '
                                  +' union Select distinct A.F03 AS ί�⳧�̱��, T2.F02 AS ���̼��'
                                  +' From T2151 as A '
                                  +' Left Join T1030 as T2 on A.F03=T2.F01','STK0311',[0,1],[]);
  if Assigned(xS) then
  try
    ComboEdit1.Text := xs.strings[0];
    Edit1.Text := xs.Strings[1];
  finally
    xs.free;
  end;

end;

end.
