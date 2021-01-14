unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, HtGrids, StdCtrls, ExtCtrls, Grids,zyPrint;

type
  TForm1 = class(TForm)
    Grid: TStringGrid;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    adoconn: TADOConnection;
    Grid1: TStringGrid;
    Memo1: TMemo;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    procedure myPrint(pState:DllPrintState);
    //ֻ�������������Ϳ��Դ�ӡ
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation


{$R *.dfm}
procedure TForm1.myPrint(pState:DllPrintState);
begin
    CallDllPrint('zyPrintcrt.dll',Application,nil,Grid,Grid1,nil,nil,nil,nil,nil,Self.Caption,pState);
    //CallDllPrint�����뿴zyprint.pas��ĸ�ʽ˵��
end;

procedure TForm1.FormCreate(Sender: TObject);
var
    i,j,k:Integer;
begin
    k:=0;
    grid.Cells[0,0]:='���';
    grid.Cells[1,0]:='����';
    grid.Cells[2,0]:='����';
    grid.Cells[3,0]:='����';
    grid.Cells[4,0]:='���';
    grid.Cells[5,0]:='�ۼ�';
    grid.Cells[6,0]:='��ע';
    grid.Cells[7,0]:='��������';
    for i:=1 to grid.RowCount-1 do
    begin
       grid.Cells[0,i]:=inttostr(i);
       grid.cells[2,i]:=inttostr(Random(100));
       grid.cells[3,i]:=inttostr(Random(100));
       grid.cells[4,i]:=inttostr(Random(100));
       grid.cells[5,i]:=inttostr(Random(100));
       grid.cells[6,i]:=inttostr(Random(100));
       grid.cells[7,i]:=FormatDateTime('yyyy-MM-dd',Now);
    end;
    for i:=1 to 12 do
    begin
        for j:=2 to 5 do
            K:=K+strtoint(Grid.Cells[j,i]);
        Grid.Cells[6,i]:=IntToStr(k);
        k:=0;
    end;
    Grid1.Cells[0,0]:='���ֿ�';
    Grid1.Cells[1,0]:='�Ƶ���';
    Grid1.Cells[2,0]:='�����';
    Grid1.Cells[3,0]:='��Ӧ��';
    Grid1.Cells[4,0]:='Ӣ��1';
    Grid1.Cells[5,0]:='��ѧ1';
    Grid1.Cells[6,0]:='�ܳɼ�1';
    Grid1.Cells[7,0]:='���ݺ�';
    for i:=1 to grid.RowCount-1 do
    begin
       Grid1.Cells[0,i]:='�ֿ�'+inttostr(i);
       Grid1.cells[2,i]:='�Ƶ���'+inttostr(Random(900));
       Grid1.cells[3,i]:=inttostr(Random(900));
       Grid1.cells[4,i]:=inttostr(Random(900));
       Grid1.cells[5,i]:=inttostr(Random(900));
       Grid1.cells[6,i]:=inttostr(Random(900));
       Grid1.cells[7,i]:='0809-000001';
    end;
end;
procedure TForm1.Button1Click(Sender: TObject);
begin
    myPrint(hpsDesign);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    myPrint(hpsPreview);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    myPrint(hpsPrint);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
    myPrint(hpsPrintNoDialog);
end;

end.
