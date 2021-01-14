unit uFM_5070;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, Spin, Mask, ToolEdit, Db, DBTables;

type
  TFM_5070 = class(TForm)
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
  FM_5070: TFM_5070;

implementation

Uses utilities;

{$R *.DFM}

//Ӧ����ת
Procedure TFM_5070.GetIncome(sCNo,sYear:string);
var
  iPTax,iPRecTotal,iPBTax,iPBRecTotal: real;
begin
   //���Ͻ��϶�ͳ��
  iPTax := 0;
  iPRecTotal := 0;
  QryExec(Qry1,'select F04,Sum(F08) as PTaxtotal,Sum(F10) as PRectotal from T2060 where F13=''��'' and F03='''+sCNo+''' and F12='''+sYear+'''' +' group by F04' );
  Qry1.First;
  while not Qry1.Eof do
  begin
    //���ұ�ͳ��
    QryExec(Qry2,'select F02 from T1100 Where F01='''+Qry1.fieldbyName('F04').asstring+'''');
    iPTax := iPTax + Qry1.fieldbyName('PTaxTotal').asFloat * Qry2.FieldbyName('F02').Asfloat;
    iPRecTotal := iPRecTotal + Qry1.fieldbyName('PRecTotal').asFloat * Qry2.FieldbyName('F02').AsFloat;
    Qry1.next;
  end;

  //�������϶�ͳ��
  iPBTax := 0;
  iPBRecTotal := 0;
  QryExec(Qry1,'select F04,Sum(F08) as PTaxtotal,Sum(F10) as PRectotal from T2060 where F13=''��'' and F03='''+sCNo+''' and F12='''+sYear+'''' +' group by F04' );
  Qry1.First;
  while not Qry1.Eof do
  begin
    //���ұ�ͳ��
    QryExec(Qry2,'select F02 from T1100 Where F01='''+Qry1.fieldbyName('F04').asstring+'''');
    iPBTax := iPBTax + Qry1.fieldbyName('PTaxTotal').asFloat * Qry2.FieldbyName('F02').Asfloat;
    iPBRecTotal := iPBRecTotal + Qry1.fieldbyName('PRecTotal').asFloat * Qry2.FieldbyName('F02').AsFloat;
    Qry1.next;
  end;

  //���������������ʴ���
  With Qry1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into T5060(F01,F02,F03,F04,F05,F14) Values(:F01,:F02,:F03,:F04,:F05,:F14)') ;
    Params[0].asstring := sYear;
    Params[1].asstring := sCNo;
    Params[2].asfloat := iPRecTotal;
    Params[3].AsFloat := iPBRecTotal;
    Params[4].asfloat := iPTax-iPBTax;
    Params[5].asfloat := iPTax-iPBTax;
  end;
  Qry1.ExecSQL;
end;


procedure TFM_5070.BitBtn1Click(Sender: TObject);
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
      QryExec(Qry2,'delete from T5060 Where F01='''+sYear+'''',false);
      QryExec(Qry2,'delete from T5060A Where F01='''+sYear+'''',false);
      //ѡ�����г���
      QryExec(Qry3,'select F01 from T5010');
      Qry3.First;
      while not Qry3.eof do
      begin
        //�������н��׵ĳ���
        QryExec(Qry2,'select sum(F10) from T2060 Where F03='''+Qry3.FieldByName('F01').AsString+''' and F12='''+sYear+'''');
        if (Qry2.Fields[0].asfloat <> 0) then
          GetIncome(Qry3.FieldByName('F01').AsString,sYear); //��ת��Ӧ����
        Qry3.Next;
      end;
    end
    else
    begin
      //ɾ���Ѵ��ڵĳ�������
      QryExec(Qry2,'delete from T5060 Where F02='''+ComboEdit1.Text+''' and F01='''+sYear+'''',false);
      QryExec(Qry2,'delete from T5060A Where F02='''+ComboEdit1.Text+''' and F01='''+sYear+'''',false);
      GetIncome(ComboEdit1.Text,sYear); //��ת��Ӧ����
    end;
    R_OKMessage(['��ת�ɹ�']);

  except
    R_OKMessage(['��תʧ��']);
  end;
end;

procedure TFM_5070.FormCreate(Sender: TObject);
begin
  Top := 100; Left := 156; Width := 296; Height := 190;
  SpinEdit1.Text := formatdatetime('yyyy',date);
  ComboBox1.ItemIndex := strtoint(formatdatetime('mm',date))-1;

end;

procedure TFM_5070.SB6Click(Sender: TObject);
begin
  close;
end;

procedure TFM_5070.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFM_5070.ComboEdit1ButtonClick(Sender: TObject);
var
  xS : TStringList;
begin
  xs := select_text('ԭ�Ϲ�Ӧ�̵�ѡ����','Select distinct A.F03 AS ���̱��, T1.F02 AS ���̼�� '
                                  +' From T2060 AS A'
                                  +' Left Join T5010 as T1 on A.F03=T1.F01 ','STK0311',[0,1],[]);
// +' union Select distinct A.F03 AS ���̱��, T2.F02 AS ���̼��'
// +' From T2060 as A '
// +' Left Join T1020 as T2 on A.F03=T2.F01'
  if Assigned(xS) then
  try
    ComboEdit1.Text := xs.strings[0];
    Edit1.Text := xs.Strings[1];
  finally
    xs.free;
  end;

end;

end.
