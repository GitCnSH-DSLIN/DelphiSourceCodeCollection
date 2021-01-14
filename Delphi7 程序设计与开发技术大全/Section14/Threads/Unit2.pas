unit Unit2;

interface

uses
  Classes, Graphics, ExtCtrls;

type

{ TSortThread }

  PSortArray = ^TSortArray;
  TSortArray = array[0..MaxInt div SizeOf(Integer) - 1] of Integer;
  TSortThread = class(TThread)      //�����߳�
  private
    FBox: TPaintBox;
    FSortArray: PSortArray;
    FSize: Integer;
    FA, FB, FI, FJ: Integer;
    procedure DoVisualSwap;
  protected
    procedure Execute; override;
    procedure VisualSwap(A, B, I, J: Integer);
    procedure Sort(var A: array of Integer); virtual; abstract;      //ִ������ĳ�����
  public
    constructor Create(Box: TPaintBox; var SortArray: array of Integer);
  end;

{ TBubbleSort }

  TBubbleSort = class(TSortThread)        //ð�������߳�
  protected
    procedure Sort(var A: array of Integer); override;
  end;

{ TSelectionSort }

  TSelectionSort = class(TSortThread)    //ѡ�������߳�
  protected
    procedure Sort(var A: array of Integer); override;
  end;

{ TQuickSort }

  TQuickSort = class(TSortThread)        //���������߳�
  protected
    procedure Sort(var A: array of Integer); override;
  end;

procedure PaintLine(Canvas: TCanvas; I, Len: Integer);

implementation

procedure PaintLine(Canvas: TCanvas; I, Len: Integer);
//�����߶Σ�I��־�߶ε�λ�ã�Len��־�߶εĳ���
begin
  Canvas.PolyLine([Point(0, I * 2 + 1), Point(Len, I * 2 + 1)]);
end;

{ TSortThread }

constructor TSortThread.Create(Box: TPaintBox; var SortArray: array of Integer);
//�̵߳Ĺ��캯����ִ�г�ʼ������
begin
  FBox := Box;
  FSortArray := @SortArray;
  FSize := High(SortArray) - Low(SortArray) + 1;
  FreeOnTerminate := True;
  inherited Create(False);
end;

procedure TSortThread.DoVisualSwap;
//���ǽ���ǰ���߶�
begin
  with FBox do
  begin
    Canvas.Pen.Color := clBtnFace;
    PaintLine(Canvas, FI, FA);
    PaintLine(Canvas, FJ, FB);
    //���»��ƽ�������߶�
    Canvas.Pen.Color := clRed;
    PaintLine(Canvas, FI, FB);
    PaintLine(Canvas, FJ, FA);
  end;
end;

procedure TSortThread.VisualSwap(A, B, I, J: Integer);
//�ػ��ƽ�������߶�
begin
  FA := A;
  FB := B;
  FI := I;
  FJ := J;
  Synchronize(DoVisualSwap);    //ͨ��Synchronize��ɶ�VCL�ķ���
end;

procedure TSortThread.Execute;
begin
  Sort(Slice(FSortArray^, FSize));    //ִ������
end;

{ TBubbleSort }
procedure TBubbleSort.Sort(var A: array of Integer);
//ѡ������
var
  I, J, T: Integer;
begin
  for I := High(A) downto Low(A) do
    for J := Low(A) to High(A) - 1 do
      if A[J] > A[J + 1] then
      begin
        VisualSwap(A[J], A[J + 1], J, J + 1);    //���»��ƽ�������߶�
        T := A[J];
        A[J] := A[J + 1];
        A[J + 1] := T;
        if Terminated then Exit;
      end;
end;

{ TSelectionSort }
procedure TSelectionSort.Sort(var A: array of Integer);
//ѡ������
var
  I, J, T: Integer;
begin
  for I := Low(A) to High(A) - 1 do
    for J := High(A) downto I + 1 do
      if A[I] > A[J] then
      begin
        VisualSwap(A[I], A[J], I, J);          //���»��ƽ�������߶�
        T := A[I];
        A[I] := A[J];
        A[J] := T;
        if Terminated then Exit;
      end;
end;

{ TQuickSort }
procedure TQuickSort.Sort(var A: array of Integer);
//��������
  procedure QuickSort(var A: array of Integer; iLo, iHi: Integer);
  var
    Lo, Hi, Mid, T: Integer;
  begin
    Lo := iLo;
    Hi := iHi;
    Mid := A[(Lo + Hi) div 2];
    repeat
      while A[Lo] < Mid do Inc(Lo);
      while A[Hi] > Mid do Dec(Hi);
      if Lo <= Hi then
      begin
        VisualSwap(A[Lo], A[Hi], Lo, Hi);        //���»��ƽ�������߶�
        T := A[Lo];
        A[Lo] := A[Hi];
        A[Hi] := T;
        Inc(Lo);
        Dec(Hi);
      end;
    until Lo > Hi;
    if Hi > iLo then QuickSort(A, iLo, Hi);
    if Lo < iHi then QuickSort(A, Lo, iHi);
    if Terminated then Exit;
  end;

begin
  QuickSort(A, Low(A), High(A));
end;

end.
