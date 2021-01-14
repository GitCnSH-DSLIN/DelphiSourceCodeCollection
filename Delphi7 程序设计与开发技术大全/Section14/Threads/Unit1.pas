unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TSortForm = class(TForm)
    StarBtn: TButton;
    BubbleSortBox: TPaintBox;
    SelectionSortBox: TPaintBox;
    QuickSortBox: TPaintBox;
    Label1: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    procedure BubbleSortBoxPaint(Sender: TObject);
    procedure SelectionSortBoxPaint(Sender: TObject);
    procedure QuickSortBoxPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StarBtnClick(Sender: TObject);
  private
    ThreadsRunning: Integer;
    procedure RandomizeArrays;
    procedure ThreadDone(Sender: TObject);
  public
    procedure PaintArray(Box: TPaintBox; const A: array of Integer);
  end;

var
  SortForm: TSortForm;

implementation

uses
  Unit2;

{$R *.dfm}

type
  PSortArray = ^TSortArray;
  TSortArray =  array[0..114] of Integer;

var
  ArraysRandom: Boolean;
  BubbleSortArray, SelectionSortArray, QuickSortArray: TSortArray;

{ TThreadSortForm }

procedure TSortForm.PaintArray(Box: TPaintBox; const A: array of Integer);
//��������ֵ����PaintBox����ϻ����߶�
var
  I: Integer;
begin
  with Box do
  begin
    Canvas.Pen.Color := clRed;
    for I := Low(A) to High(A) do PaintLine(Canvas, I, A[I]);  //��λ��I����һ������ΪA[I]���߶�
  end;
end;

procedure TSortForm.BubbleSortBoxPaint(Sender: TObject);
begin
  PaintArray(BubbleSortBox, BubbleSortArray);
end;

procedure TSortForm.SelectionSortBoxPaint(Sender: TObject);
begin
  PaintArray(SelectionSortBox, SelectionSortArray);
end;

procedure TSortForm.QuickSortBoxPaint(Sender: TObject);
begin
  PaintArray(QuickSortBox, QuickSortArray);
end;

procedure TSortForm.FormCreate(Sender: TObject);
begin
  RandomizeArrays;          //�����������
end;

procedure TSortForm.StarBtnClick(Sender: TObject);
begin
  RandomizeArrays;          //�����������
  ThreadsRunning := 3;
  //����3�������߳��߳�
  with TBubbleSort.Create(BubbleSortBox, BubbleSortArray) do
    OnTerminate := ThreadDone;
  with TSelectionSort.Create(SelectionSortBox, SelectionSortArray) do
    OnTerminate := ThreadDone;
  with TQuickSort.Create(QuickSortBox, QuickSortArray) do
    OnTerminate := ThreadDone;
  StarBtn.Enabled := False;
end;

procedure TSortForm.RandomizeArrays;
var
  I: Integer;
begin
  if not ArraysRandom then
  begin
    Randomize;
    for I := Low(BubbleSortArray) to High(BubbleSortArray) do
      BubbleSortArray[I] := Random(170);       //���������
    SelectionSortArray := BubbleSortArray;
    QuickSortArray := BubbleSortArray;
    ArraysRandom := True;
    Repaint;
  end;
end;

procedure TSortForm.ThreadDone(Sender: TObject);
//�߳̽���������
begin
  Dec(ThreadsRunning);
  if ThreadsRunning = 0 then    //�����Ƿ�3���̶߳��Ѿ�����
  begin
    StarBtn.Enabled := True;
    ArraysRandom := False;
  end;
end;

end.
