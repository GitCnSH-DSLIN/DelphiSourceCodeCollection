unit formquery6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, Buttons, Grids, DBGrids;

type
  Tformquery_6 = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Query1: TQuery;
    DataSource1: TDataSource;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formquery_6: Tformquery_6;

implementation

{$R *.dfm}

procedure Tformquery_6.BitBtn1Click(Sender: TObject);
begin
query1.close;
query1.SQL.Clear;
query1.SQL.add('select * from �������õǼǱ�');
query1.SQL.add('where ����="'+edit1.text+'" or ����="'+edit2.text+'" or ����="'+edit3.text+'" or ������="'+edit4.text+'" or ���÷�ʽ="'+combobox1.text+'" or �Ƿ���˾��="'+combobox2.text+'" or �ͻ��Ƿ����="'+combobox3.text+'"');
query1.Open;
end;

procedure Tformquery_6.BitBtn2Click(Sender: TObject);
begin
Close; 
end;

procedure Tformquery_6.FormShow(Sender: TObject);
begin
query1.Open;
end;

procedure Tformquery_6.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
query1.close;
action:=cafree;

end;

end.
