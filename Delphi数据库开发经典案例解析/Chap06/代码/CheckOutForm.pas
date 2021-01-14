unit CheckOutForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ParentForm, ADODB, DB, ImgList, Grids, DBGrids, ComCtrls,
  ToolWin, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls;

type
  TCheckOut = class(TParent)
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    ADOTable2: TADOTable;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DBEdit1: TDBEdit;
    ComboBox1: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    ADOCommand1: TADOCommand;
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure DataSource2DataChange(Sender: TObject; Field: TField);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CheckOut: TCheckOut;

implementation

{$R *.dfm}

//-----------������ס�����Ⱥ���ʾ�����ʵ�-----------------
procedure TCheckOut.DataSource1DataChange(Sender: TObject; Field: TField);
var
strFilter:string;
i:integer;
begin
  inherited;
  //���������ϸ�ʵ�������ʾ��ǰָ�����ס�����������ʵ�
  strFilter:='��ס����='''+trim(dbgrid1.Fields[0].Text)+'''';
  adotable2.Filter:=strFilter;
  adotable2.Filtered:=true;
  //������ס������
  dbgrid1.Columns[0].Width:=120;
  for i:=1 to 11 do
   dbgrid1.Columns[i].Width:=64;
end;

//-----------�����ʵ���ϸ����-----------------
procedure TCheckOut.DataSource2DataChange(Sender: TObject; Field: TField);
begin
  inherited;
  dbgrid2.Columns[0].Width:=64;
  dbgrid2.Columns[1].Width:=120;
  dbgrid2.Columns[2].Width:=120;
  dbgrid2.Columns[3].Width:=64;
  dbgrid2.Columns[4].Width:=64;
  dbgrid2.Columns[5].Width:=200;
end;

//-----------���ô�����̣�����Ӧ���˿�-----------------
procedure TCheckOut.BitBtn2Click(Sender: TObject);
begin
  inherited;
  adocommand1.CommandText:='exec sf_����Ӧ���ʿ� '''+trim(dbgrid1.Fields[0].Text)+'''';
  adocommand1.Execute;
  //ˢ������
  adotable1.Active:=false;
  adotable1.Active:=true;
  adotable2.Active:=false;
  adotable2.Active:=true;
end;

//-----------���ô�����̣������˷�-----------------
procedure TCheckOut.BitBtn3Click(Sender: TObject);
begin
  inherited;
  adocommand1.CommandText:='exec sf_�����˷� '''+trim(dbgrid1.Fields[0].Text)+''','''+combobox1.SelText+'''';
  adocommand1.Execute;
  //ˢ������
  adotable1.Active:=false;
  adotable1.Active:=true;
  adotable2.Active:=false;
  adotable2.Active:=true;
end;

end.
