unit uFM_SEM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  US_FM, Db, DBTables, StdCtrls, Grids, DBGrids, Buttons, ExtCtrls;

type
  TFM_SEM = class(TS_Form)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    ComboBox1: TComboBox;
    Query1: TQuery;
    DataSource1: TDataSource;
    Query1F01: TStringField;
    Query1F02: TStringField;
    Query1F03: TStringField;
    Query1F04: TFloatField;
    Query1F05: TFloatField;
    Query1F06: TStringField;
    Query1F07: TFloatField;
    Query1F08: TStringField;
    Qry: TQuery;
    Query1F12: TFloatField;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Query1AfterScroll(DataSet: TDataSet);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
  private
    { Private declarations }
  public
   iF01,iF02,iF03,iF07: string;
   iF04,iF05,iF06 : real;

    { Public declarations }
  end;

var
  FM_SEM: TFM_SEM;
  iPNo: string;
function selectMaterialProd(var iout: string):boolean;

implementation
uses utilities, uDM;
{$R *.DFM}
function selectMaterialProd(var iout: string):boolean;
var
 xFM : TFM_SEM;
begin
 result  := False;
 xFM := TFM_SEM.Create(Application);
 try
  if xFM.ShowModal = mrOk then
   begin
    iout := iPNo;
    Result := True;
   end;
 finally
  xFM.Free;
 end;

end;

procedure TFM_SEM.BitBtn1Click(Sender: TObject);
begin
  inherited;
  if (Edit1.Text = '') or (Edit2.Text = '') or (Edit4.Text = '') or (Edit5.Text = '') or (Edit6.Text = '') then
  begin
   R_OkMessage(['<���>,<Ʒ��>,<�������>,<��ȫ����>,<�ο�����>��������!']);
   Edit1.SetFocus;
   ModalResult := mrNone;
   Exit;
  end;

 QryExec(Qry,'Select F01 from T1050 where F01='''+Edit1.text+'''');
 if Qry.RecordCount > 0 then
 begin
  R_OkMessage(['��ԭ�ϱ���Ѵ���,������������!']);
  ModalResult := mrNone;
  Exit;
 end;
 //�����������ԭ�ϲ��뵽ԭ�ϲ�
 With Qry do
 begin
  Qry.close;
  Qry.SQL.Clear;
  Qry.SQL.Add('Insert into T1050(F01,F02,F03,F04,F05,F06,F07,F12) values (:F01,:F02,:F03,:F04,:F05,:F06,:F07,:F12)');
  Qry.Params[0].AsString := Edit1.Text;
  Qry.Params[1].AsString := Edit2.Text;
  Qry.Params[2].AsString := Edit3.Text;
  Qry.Params[3].AsFloat := strtofloat(Edit4.text);
  Qry.Params[4].AsFloat := Strtofloat(Edit5.text);
  Qry.Params[5].AsString := ComboBox1.Text;
  Qry.Params[6].AsFloat := strtofloat(Edit6.text);
  Qry.Params[7].asfloat := strtofloat(edit4.text);
  Qry.ExecSQL;
 end;
 //Query1.Locate('F01','Edit1.text' []);
 iPNo := Edit1.text;
 DM.Q_T1050.Close;
 DM.Q_T1050.Open;
 Query1.Close;
 Query1.Open;






end;

procedure TFM_SEM.FormCreate(Sender: TObject);
begin
  inherited;
  Width:=730; Height:=530;
end;

procedure TFM_SEM.Query1AfterScroll(DataSet: TDataSet);
begin
  inherited;      
{  Edit1.Text := Query1.Fields[0].AsString;
  Edit2.Text := Query1.Fields[1].AsString;
  Edit3.Text := Query1.Fields[2].AsString;
  Edit4.Text := Query1.Fields[3].AsString;
  Edit5.Text := Query1.Fields[4].AsString;
  Edit6.Text := Query1.Fields[6].AsString;    
  Combobox1.Text := Query1.Fields[5].AsString; }
  iPNo := Query1.fields[0].AsString;           
end;

procedure TFM_SEM.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  BitBtn2.Click;
end;

procedure TFM_SEM.Edit1Exit(Sender: TObject);
begin
  inherited;
  With Query1 do
  begin
    Close;
    if TEdit(Sender).Text='' then
      ParamByName('sF0'+IntToStr(TEdit(Sender).Tag)).AsString := '%'
    else
      ParamByName('sF0'+IntToStr(TEdit(Sender).Tag)).AsString := TEdit(Sender).Text;
    Open;
  end;
end;

end.
