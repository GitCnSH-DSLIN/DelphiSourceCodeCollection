unit uFM_3020;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ToolEdit, Spin, Db, DBTables;

type
  TFM_3020 = class(TForm)
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    ComboBox1: TComboBox;
    ComboEdit1: TComboEdit;
    Edit1: TEdit;
    Label3: TLabel;
    Label2: TLabel;
    SB6: TSpeedButton;
    BitBtn1: TBitBtn;
    Qry1: TQuery;
    Qry2: TQuery;
    Qry3: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
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
  FM_3020: TFM_3020;
  sCNo : String;

implementation

uses utilities;

{$R *.DFM}

//Ӧ�ս�ת
Procedure TFM_3020.GetIncome(sCNo,sYear:string);
var
  iTax,iDelTotal,iBTax,iBDelTotal: real;
begin
  //ѡ��ĳһ�ͻ�ĳһ�·�˰�����,���������
  iTax := 0;
  iDelTotal := 0;
  QryExec(Qry1,'select F04,Sum(F08) as Taxtotal,Sum(F10) as Deltotal from T2160 where F03='''+sCNo+''' and F13=''��'' and F12='''+sYear+'''' +' group by F04' );
  Qry1.First;
  while not Qry1.Eof do
  begin
    QryExec(Qry2,'select F02 from T1100 Where F01='''+Qry1.fieldbyName('F04').asstring+'''');
    iTax := iTax + Qry1.fieldbyName('TaxTotal').asFloat * Qry2.FieldbyName('F02').AsFloat;
    iDelTotal := iDelTotal + Qry1.fieldbyName('DelTotal').asFloat * Qry2.FieldbyName('F02').AsFloat;
    Qry1.Next;
  end;

  //ѡ��ĳһ�ͻ�ĳһ�·��˻�˰�����,�˻������
  iBTax := 0;
  iBDelTotal := 0;
  QryExec(Qry1,'select F04,Sum(F08) as Taxtotal,Sum(F10) as Deltotal from T2160 where F03='''+sCNo+''' and F13=''��'' and F12='''+sYear+'''' +' group by F04' );
  Qry1.First;
  while not Qry1.Eof do
  begin
    QryExec(Qry2,'select F02 from T1100 Where F01='''+Qry1.fieldbyName('F04').asstring+'''');
    iBTax := iBTax + Qry1.fieldbyName('TaxTotal').asFloat * Qry2.FieldbyName('F02').Asfloat;
    iBDelTotal := iBDelTotal + Qry1.fieldbyName('DelTotal').asFloat * Qry2.FieldbyName('F02').AsFloat;
    Qry1.next;
  end;

  //���������������ʴ���
  With Qry1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into T3020(F01,F02,F03,F04,F05,F14) Values(:F01,:F02,:F03,:F04,:F05,:F14)') ;
    Params[0].asstring := sYear;
    Params[1].asstring := sCNo;
    Params[2].asfloat := iDelTotal;
    Params[3].asfloat := iBDelTotal;
    Params[4].asfloat := iTax-iBTax;
    Params[5].asfloat := iTax-iBTax;
end;
  Qry1.ExecSQL;
end;

procedure TFM_3020.FormCreate(Sender: TObject);
begin
  width := 300;
  height := 200;
  left := 156;
  top := 100;
  SpinEdit1.Text := formatdatetime('yyyy',date);
  ComboBox1.ItemIndex := strtoint(formatdatetime('mm',date))-1;
end;

procedure TFM_3020.BitBtn1Click(Sender: TObject);
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
    if comboEdit1.Text='' then //δѡ�ͻ�
    begin
      //ɾ���Ѵ��ڵĳ�������
      QryExec(Qry2,'delete from T3020 Where F01='''+sYear+'''',false);
      QryExec(Qry2,'delete from T3020A Where F01='''+sYear+'''',false);
      QryExec(Qry3,'select distinct F03 from T2160 where F12='''+sYear+'''');
      Qry3.First;
      while not Qry3.eof do
      begin
        GetIncome(Qry3.FieldByName('F03').AsString,sYear); //��ת��Ӧ����
        Qry3.Next;
      end;
    end
    
    else
    begin
      //ɾ���Ѵ��ڵĳ�������
      QryExec(Qry2,'delete from T3020 Where F02='''+ComboEdit1.Text+''' and F01='''+sYear+'''',false);
      QryExec(Qry2,'delete from T3020A Where F02='''+ComboEdit1.Text+''' and F01='''+sYear+'''',false);
      GetIncome(ComboEdit1.Text,sYear);
    end;
    R_OKMessage(['��ת�ɹ�']); //��ת��Ӧ����
  except
    Raise;
    R_OKMessage(['��תʧ��']);
  end;
end;

procedure TFM_3020.SB6Click(Sender: TObject);
begin
  close;
end;

procedure TFM_3020.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFM_3020.ComboEdit1ButtonClick(Sender: TObject);
var
  xS : TStringList;
begin
  xs := select_text('�ͻ���ѡ����','Select distinct A.F03 AS �ͻ����, T1.F02 AS �ͻ���� '
                                  +' From T2160 AS A'
                                  +' Left Join T1010 as T1 on A.F03=T1.F01 ','STK0311',[0,1],[]);
  if Assigned(xS) then
  try
    ComboEdit1.Text := xs.strings[0];
    Edit1.Text := xs.Strings[1];
  finally
    xs.free;
  end;

end;

end.
