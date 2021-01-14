unit LeftPas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, DBCtrls, Mask, ComCtrls, Grids, DBGrids, ExtCtrls,
  Variants, QRPrntr, Qrctrls, QuickRpt;

type
  TLeftForm = class(TForm)
    P1: TQuery;
    P2: TQuery;
    P3: TQuery;
    P1s: TDataSource;
    P2s: TDataSource;
    P3s: TDataSource;
    SBar: TStatusBar;
    Timer1: TTimer;
    QuickRep1: TQuickRep;
    PageHeaderBand1: TQRBand;
    QRLabel1: TQRLabel;
    DetailBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRLabel21: TQRLabel;
    QRDBText14: TQRDBText;
    QRLabel22: TQRLabel;
    QRDBText15: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRBand1: TQRBand;
    QRExpr2: TQRExpr;
    ChildBand1: TQRChildBand;
    QRBand2: TQRBand;
    QRDBText13: TQRDBText;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    QRDBText12: TQRDBText;
    QRExpr1: TQRExpr;
    QRBand3: TQRBand;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRBand4: TQRBand;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    ChildBand2: TQRChildBand;
    UpdateSQL1: TUpdateSQL;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRDBText9: TQRDBText;
    QRDBText16: TQRDBText;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Label3: TLabel;
    Edit3: TDBEdit;
    Edit10: TDBEdit;
    Edit2: TEdit;
    Edit9: TDBLookupComboBox;
    Edit4: TDBEdit;
    Panel1: TPanel;
    Button1: TButton;
    Button3: TButton;
    Memo1: TMemo;
    Edit1: TComboBox;
    Button2: TButton;
    QRLabel16: TQRLabel;
    Image1: TImage;
    procedure Calculate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure PrintOut(Sender: TObject);
    procedure QuickRep1Preview(Sender: TObject);
    procedure PrintBall02(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure P1AfterPost(DataSet: TDataSet);
    procedure Edit1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure Button2Click(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LeftForm: TLeftForm;
  LKey: Word;

implementation

uses PPreview, Data, XedUser, Printers;

var
  T: array[0..4] of TDateTime; //ʱ���
  P: array[1..3] of Real; //���۱�
  PPart2, PPart3: Boolean;
  LTime: TDateTime;
{$R *.DFM}

procedure TLeftForm.Edit1Click(Sender: TObject);
var
  Sort: Word;
  I: Word;
  Results: Variant;
const
  LStr = '����;ʱ��1;ʱ��2;ʱ��3;����1;����2;����3';
begin
  if Edit1.ItemIndex = -1 then Begin
    Edit2.Text := '';
    Exit;
  End;
  Button2.Enabled := False;
  P1.Locate('��ˮ��', Edit1.Text, []);
  Memo1.Text := '����ʱ��ηֲ����';
  if varisNull(P1['����ʱ��']) then
    LTime := Now
  else
    LTime := P1['����ʱ��'];
  Edit3.Text := FormatDateTime(' hh"��" nn"��" ss"��"', P1['��ʼʱ��']);
  Edit4.Text := FormatDateTime(' hh"��" nn"��" ss"��"', LTime);

  LKey := StrToInt(Edit1.Text);
  Sort := P1.FieldByName('�������').AsInteger;
  Results := DM.Ball00.Lookup('�������', Sort, LStr);
  Edit2.Text := Results[0];
  T[4] := 0;
  for I := 1 to 3 do begin
    T[I] := Results[I];
    P[I] := Results[I + 3];
  end;

  P2.SQL.Text := Format(
    'Select * From Ball02 Where ��ˮ��="%d"', [LKey]);
  P2.Open;
  PPart2 := not P2.Eof;

  P3.SQL.Text := Format(
    'Select * From Ball03 Where ��ˮ��="%d"', [LKey]);
  P3.Open;
  PPart3 := not P3.Eof;
end;

procedure TLeftForm.Calculate(Sender: TObject);
var
  I, Toff: Word;
  Sum1, Sum2, Temp: Real;
//  Sum1: �������� + ���Ľ��
//  Sum2: ��ˮ���, Sum1: ���ӽ��
  Tim1, Tim2: TDateTime;
  LDate: TDate;
  Adde: Boolean;
  HCost: array[0..3] of Real;

begin
  if Edit1.Text = '' then Exit;
  if Trim(Edit9.Text) = '' then Toff := 100
  else Toff := DM.Rate['�ۿ۱���'];

  Sum2 := 0;
  if PPart2 then begin
    SBar.SimpleText := '���ڼ����ˮ���....';
    P2.First;
    repeat
      Sum2 := Sum2 + P2['���'];
      P2.Next;
    until P2.Eof;
  end;

  if PPart3 then begin
    SBar.SimpleText := '���ڼ�����ӽ��....';
    P3.First;
    repeat
      Tim1 := Frac(P3['��ʼʱ��']);
      Tim2 := Frac(P3['����ʱ��']);
      Temp := 0;
      for I := 1 to 3 do begin
        if Tim1 < 9 / 24 then Tim1 := Tim1 + 1;
        if Tim2 < 9 / 24 then Tim2 := Tim2 + 1;
        Temp := Temp + P[I] * Cost(Tim1, Tim2, T[I], T[I + 1]);
      end;
      Temp := Round(Temp);
      P3.Edit;
      P3['���'] := Temp;
      P3.Post;
      P3.Next;
    until P3.Eof;
  end;

  Tim1 := Frac(P1['��ʼʱ��']);
  Tim2 := Frac(P1['����ʱ��']);
  LDate := Date; // ��û�й���ҹ
  if Tim2 < 9 / 24 then LDate := Date - 1;
  if Tim1 < 9 / 24 then Tim1 := Tim1 + 1;
  if Tim2 < 9 / 24 then Tim2 := Tim2 + 1;
//  Showmessage(Datetimetostr(Tim1)+'-'+Datetimetostr(Tim2));
  Adde := (Tim2 - Tim1) * 24 < 1;

  Sum1 := 0;

  if Tim1 < 9 / 24 then Tim1 := Tim1 + 1;
  if Tim2 < 9 / 24 then Tim2 := Tim2 + 1;
  if Adde then Tim2 := Tim1 + 1 / 24;
  SBar.SimpleText := '���ڼ����������....';
  HCost[0] := 0;
  for I := 1 to 3 do begin
    HCost[I] := Cost(Tim1, Tim2, T[I], T[I + 1]);
    HCost[0] := HCost[0] + HCost[I];
    Sum1 := Sum1 + P[I] * HCost[I];
  end;
  Sum1 := Round(Sum1 * TOff / 100);
  Memo1.Text := Format('��ʱ�����ѷֲ����(����):'
    + '%4.0f,%4.0f,%4.0f  �ϼ�:%4.0f ���� = %0.4f Сʱ',
    [HCost[1] * 60, HCost[2] * 60, HCost[3] * 60, HCost[0] * 60, HCost[0]]);

  P1.Edit;
  if Adde then begin
    P1['��ע'] := P1['����ʱ��'];
    P1['����ʱ��'] := P1['��ʼʱ��'] + 1 / 24;
  end;
  P1['���ֽ��'] := Sum1;
  P1['��ˮ���'] := Sum2;
  P1['�ۿ۱���'] := Toff;
  P1['ʵ�ս��'] := Sum1 + Sum2 + P1['���Ľ��'];
  P1['����'] := LDate;
  P1.Post;
end;

procedure TLeftForm.FormCreate(Sender: TObject);
begin
  Self.BorderStyle := bsSizeable;
  QuickRep1.Hide;
  Edit4.Readonly := not Systemor;
  DM.BALL00.OPEN;
  DM.WATER.OPEN;
  DM.RATE.OPEN;
  P1.SQL.Text :=
    'Select �������, ����, B.*, 24*(����ʱ��-��ʼʱ��) ' +
    'as ����ʱ�� from ball00 A, ball01 B where A.�������' +
    '=B.������� and not B.���ʱ�־ = TRUE';
  P1.Open;
  while not P1.Eof do begin
    Edit1.Items.Add(P1['��ˮ��']);
    P1.Next;
  end;
  Edit4.Text := FormatDateTime(' hh"��" nn"��" ss"��"', LTime);
end;

procedure TLeftForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.BALL00.Close;
  DM.WATER.Close;
  DM.RATE.Close;
end;

procedure TLeftForm.FormActivate(Sender: TObject);
begin
  LTime := Now;
end;

procedure TLeftForm.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TLeftForm.Button1Click(Sender: TObject);
var
  T: TDateTime;
  S: string;
begin
  if Edit1.ItemIndex = -1 then Exit;
  if VarIsNull(P1['����ʱ��']) then begin
    P1.Edit;
    P1['����ʱ��'] := LTime;
    P1.Post;
    if PPart3 then begin //  ���������Ӽ�¼
      P3.Last;
      while P3['��ˮ��'] <> LKey do P3.Prior;
      T := P3['����ʱ��'];
      P3.Append;
      P3['��ˮ��'] := LKey;
      P3['��ʼʱ��'] := T;
      P3['����ʱ��'] := LTime;
      P3.Post;
    end;
    Edit4.Text := FormatDateTime(' hh"��" nn"��" ss"��"', LTime);
  end;

  CalCulate(Self);
  S := P1.Text;
  P1.SQL.Text := format('%s and ��ˮ��=%d',[S, LKey]);
  P1.Open;
  Printout(Self);
  P1.SQL.Text := S;
  P1.Open;
  Edit1Click(nil);
  Button2.Enabled := True;
end;

procedure TLeftForm.Timer1Timer(Sender: TObject);
begin
  Showtime(Image1);
  LTime := Now;
end;

procedure TLeftForm.PrintOut(Sender: TObject);
begin
  Enabled := False;
  QuickRep1.Prepare;
  Showmessage(inttostr(QuickRep1.QRPrinter.PageCount));
  QuickRep1.Preview;
  Enabled := True;
end;

procedure TLeftForm.QuickRep1Preview(Sender: TObject);
begin
  Application.CreateForm(TPreview, Preview);
  Preview.QRPreview1.QRPrinter := TQRPrinter(Sender);
  Preview.Show;
end;

procedure TLeftForm.PrintBall02(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := PPart2;
end;

procedure TLeftForm.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand := PPart3;
end;

procedure TLeftForm.P1AfterPost(DataSet: TDataSet);
begin
  if DataSet = P1 then P1.ApplyUpdates;
  TQuery(DataSet).FlushBuffers;
end;

procedure TLeftForm.Edit1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  if odSelected in State then Begin
    Edit1.Canvas.Brush.Color := clBlue;
  End;
  Edit1.Canvas.FillRect(Rect);
  Edit1.Canvas.TextOut(Rect.Left + 20, Rect.Top + 1, '��ˮ�ţ�' + Edit1.Items[Index]);
end;

procedure TLeftForm.Button2Click(Sender: TObject);
begin
  if Edit1.ItemIndex = -1 then Exit;
  if not P1.Locate('��ˮ��', Edit1.Text, []) then Exit;
//  Edit1.ItemIndex := -1;
  Edit1Click(nil);
  P1.Edit;
  P1['���ʱ�־'] := True;
  P1.Post;
  Edit1.DeleteSelected;
end;

procedure TLeftForm.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  NewHeight := 441;
end;

end.

