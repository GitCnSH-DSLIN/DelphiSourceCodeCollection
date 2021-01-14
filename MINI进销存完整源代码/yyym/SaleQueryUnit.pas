unit SaleQueryUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, ExtCtrls, StdCtrls,salequeryrepunit,
  Buttons;

type
  TSaleQuery = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Query1: TQuery;
    DataSource1: TDataSource;
    Bevel1: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Button3: TButton;
    Button4: TButton;
    Query2: TQuery;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SaleQuery: TSaleQuery;

implementation

{$R *.dfm}

uses SaleListUnit;

procedure TSaleQuery.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action:=caFree;
end;

procedure TSaleQuery.Button1Click(Sender: TObject);

begin

  if SaleListUnit.SaleList.ListBox1.Selected[0] then
    begin
     salequery.Caption:='���۵��ݲ�ѯ';
     if combobox1.Text='���ݱ��' then
     begin
       Query1.Sql.Clear;
       Query1.SQL.Add('Select * from ���۵��� where ���ݱ��=:FormNo');
       Query1.Close;
       Query1.Params[0].AsString:=Edit1.Text;
       Query1.Active:=True;
       Query1.open;
       DBGrid1.Repaint;
      end
     else if combobox1.Text='¼������'  then
       begin
       Query1.Sql.Clear;
       Query1.SQL.Add('Select * from ���۵��� where ¼������=:FormDate');
       Query1.Close;
       Query1.Params[0].DataType:=ftdate;
       Query1.Params[0].ParamType:=ptInput;
       Query1.Params[0].Value:=strToDate(Edit1.Text);
       Query1.Active:=True;
       Query1.open;
       DBGrid1.Repaint;
        end
     else if combobox1.Text='�ͻ�' then
       begin
            Query1.Sql.Clear;
       Query1.SQL.Add('Select * from ���۵��� where �ͻ�=:Customer');
       Query1.Close;
       Query1.Params[0].DataType:=ftstring;
       Query1.Params[0].ParamType:=ptInput;
       Query1.Params[0].Value:=Edit1.Text;
       Query1.Active:=True;
       Query1.open;
       DBGrid1.Repaint;
        end
     else if combobox1.Text='������' then
      begin
         Query1.Sql.Clear;
       Query1.SQL.Add('Select * from ���۵��� where ������=:doer');
       Query1.Close;
       Query1.Params[0].DataType:=ftstring;
       Query1.Params[0].ParamType:=ptInput;
       Query1.Params[0].Value:=Edit1.Text;
       Query1.Active:=True;
       Query1.open;
       DBGrid1.Repaint;

      end
    else if combobox1.Text='��ע'     then
      begin
        Query1.Sql.Clear;
       Query1.SQL.Add('Select * from ���۵��� where ��ע=:FormDate');
       Query1.Close;
       Query1.Params[0].DataType:=ftstring;
       Query1.Params[0].ParamType:=ptInput;
       Query1.Params[0].Value:=Edit1.Text;
       Query1.Active:=True;
       Query1.open;
       DBGrid1.Repaint;

      end;
    end
   else if  SaleListUnit.SaleList.ListBox1.Selected[1] then
   begin
      salequery.Caption:='�����տ�ݲ�ѯ';
     if combobox1.Text='���ݱ��' then
     begin
       Query1.Sql.Clear;
       Query1.SQL.Add('Select * from �����տ� where ���ݱ��=:FormNo');
       Query1.Close;
       Query1.Params[0].AsString:=Edit1.Text;
       Query1.Active:=True;
       Query1.open;
       DBGrid1.Repaint;
      end
     else if combobox1.Text='¼���տ�'  then
       begin
       Query1.Sql.Clear;
       Query1.SQL.Add('Select * from ���۵��� where ¼������=:FormDate');
       Query1.Close;
       Query1.Params[0].DataType:=ftdate;
       Query1.Params[0].ParamType:=ptInput;
       Query1.Params[0].Value:=strToDate(Edit1.Text);
       Query1.Active:=True;
       Query1.open;
       DBGrid1.Repaint;
        end
     else if combobox1.Text='�ͻ�' then
       begin
            Query1.Sql.Clear;
       Query1.SQL.Add('Select * from �����տ� where �ͻ�=:Customer');
       Query1.Close;
       Query1.Params[0].DataType:=ftstring;
       Query1.Params[0].ParamType:=ptInput;
       Query1.Params[0].Value:=Edit1.Text;
       Query1.Active:=True;
       Query1.open;
       DBGrid1.Repaint;
        end
     else if combobox1.Text='������' then
      begin
         Query1.Sql.Clear;
       Query1.SQL.Add('Select * from �����տ� where ������=:doer');
       Query1.Close;
       Query1.Params[0].DataType:=ftstring;
       Query1.Params[0].ParamType:=ptInput;
       Query1.Params[0].Value:=Edit1.Text;
       Query1.Active:=True;
       Query1.open;
       DBGrid1.Repaint;

      end
    else if combobox1.Text='��ע'     then
      begin
        Query1.Sql.Clear;
       Query1.SQL.Add('Select * from �����տ� where ��ע=:FormDate');
       Query1.Close;
       Query1.Params[0].DataType:=ftstring;
       Query1.Params[0].ParamType:=ptInput;
       Query1.Params[0].Value:=Edit1.Text;
       Query1.Active:=True;
       Query1.open;
       DBGrid1.Repaint;

      end;
        end
      Else if    SaleListUnit.SaleList.ListBox1.Selected[2] then
      begin
            SaleQuery.Caption:='�����˻����ݲ�ѯ' ;
          if combobox1.Text='���ݱ��' then
     begin
       Query1.Sql.Clear;
       Query1.SQL.Add('Select * from �����˻� where ���ݱ��=:FormNo');
       Query1.Close;
       Query1.Params[0].AsString:=Edit1.Text;
       Query1.Active:=True;
       Query1.open;
       DBGrid1.Repaint;
      end
     else if combobox1.Text='¼������'  then
       begin
       Query1.Sql.Clear;
       Query1.SQL.Add('Select * from �����˻� where ¼������=:FormDate');
       Query1.Close;
       Query1.Params[0].DataType:=ftdate;
       Query1.Params[0].ParamType:=ptInput;
       Query1.Params[0].Value:=strToDate(Edit1.Text);
       Query1.Active:=True;
       Query1.open;
       DBGrid1.Repaint;
        end
     else if combobox1.Text='�ͻ�' then
       begin
            Query1.Sql.Clear;
       Query1.SQL.Add('Select * from �����˻� where �ͻ�=:Customer');
       Query1.Close;
       Query1.Params[0].DataType:=ftstring;
       Query1.Params[0].ParamType:=ptInput;
       Query1.Params[0].Value:=Edit1.Text;
       Query1.Active:=True;
       Query1.open;
       DBGrid1.Repaint;
        end
     else if combobox1.Text='������' then
      begin
         Query1.Sql.Clear;
       Query1.SQL.Add('Select * from �����˻� where ������=:doer');
       Query1.Close;
       Query1.Params[0].DataType:=ftstring;
       Query1.Params[0].ParamType:=ptInput;
       Query1.Params[0].Value:=Edit1.Text;
       Query1.Active:=True;
       Query1.open;
       DBGrid1.Repaint;

      end
    else if combobox1.Text='��ע'     then
      begin
        Query1.Sql.Clear;
       Query1.SQL.Add('Select * from �����˻� where ��ע=:FormDate');
       Query1.Close;
       Query1.Params[0].DataType:=ftstring;
       Query1.Params[0].ParamType:=ptInput;
       Query1.Params[0].Value:=Edit1.Text;
       Query1.Active:=True;
       Query1.open;
       DBGrid1.Repaint;

      end;
      end
end;

procedure TSaleQuery.Button4Click(Sender: TObject);
begin
  CLose;
  salelistunit.SaleList.Release;
end;

procedure TSaleQuery.BitBtn1Click(Sender: TObject);
begin
   application.CreateForm(Tsalequeryrep,salequeryrep);

    SaleQueryUnit.SaleQuery.Query1.Active:=true;


     if SaleListUnit.SaleList.ListBox1.Selected[0] then
  saleQueryrep.QRlabel1.Caption:='���۵���ѯ����'
     else if SaleListUnit.SaleList.ListBox1.Selected[1] then
  saleQueryrep.Qrlabel1.Caption:='���۸����ѯ����'
  else if SaleListUnit.SaleList.ListBox1.Selected[2] then
  saleQueryrep.qrlabel1.Caption:='�����˻�����ѯ����';


   saleQueryrep.qrdbtext1.DataField:='���ݱ��';
   saleQueryrep.qrdbtext2.DataField:='¼������';
   saleQueryrep.qrdbtext3.DataField:='�ͻ�';
   saleQueryrep.qrdbtext4.DataField:='������';
   saleQueryrep.qrdbtext5.DataField:='��ע';

    salequeryrepunit.salequeryrep.QuickRep1.Preview;

end;

procedure TSaleQuery.BitBtn2Click(Sender: TObject);
begin
  close;
  SaleListUnit.SaleList.Show;
end;

end.

