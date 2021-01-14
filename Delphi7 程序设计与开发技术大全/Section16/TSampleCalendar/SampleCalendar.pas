unit SampleCalendar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Grids,
  StdCtrls;

type
  TSampleCalendar = class(TCustomGrid)
  private
    { Private declarations }
    FDate: TDateTime;
    FMonthOffset: Integer;                           {�洢�µ�ƫ��}
    FOnChange: TNotifyEvent;

    procedure SetCalendarDate(Value: TDateTime);
    function GetDateElement(Index: Integer): Integer;         {ע��Index����}
    procedure SetDateElement(Index: Integer; Value: Integer);
    function DayNum(ACol, ARow: Integer): Integer;

  protected
    { Protected declarations }
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
      override;

    procedure UpdateCalendar; virtual;                 {����ƫ�Ƶķ���}
    procedure Click; override;
    procedure Change; dynamic;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure NextMonth;
    procedure PrevMonth;
    procedure NextYear;
    procedure PrevYear;
    function SelectCell(ACol, ARow: Longint): Boolean; override;

    property CalendarDate: TDateTime read FDate write SetCalendarDate;
    property Day: Integer index 3 read GetDateElement write SetDateElement;
    property Month: Integer index 2 read GetDateElement write SetDateElement;
    property Year: Integer index 1 read GetDateElement write SetDateElement;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;

  published
    { Published declarations }
    property Align;                           {��������}
    property BorderStyle;
    property Color;
    property Font;
    property GridLineWidth;
    property ParentColor;
    property ParentFont;
    property OnClick;                         {�����¼�}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TSampleCalendar]);
end;

constructor TSampleCalendar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);                                  {���ü̳еĹ��췽��}
  ColCount := 7;                                           {ÿ��һ����7��}
  RowCount := 7;                                          {���Ͽ�ͷ��һ����6��}

  FixedCols := 0;                                           {û���б�ǩ}
  FixedRows := 1;                                          {������һ��}
  ScrollBars := ssNone;                                     {����Ҫ������}
  Options := Options - [goRangeSelect] + [goDrawFocusSelected];  {������ѡ��}
  FDate := Date;                       {��RTL�õ���ǰ����}
  UpdateCalendar;                                  {������ȷ��ƫ��}
end;

procedure TSampleCalendar.WMSize(var Message: TWMSize);
var
  GridLines: Integer;                                   {��ʱ�ֲ�����}
begin
  GridLines := 6 * GridLineWidth;                        {���������еĴ�С}
  DefaultColWidth := (Message.Width - GridLines) div 7;     {�����µ�Ĭ��cell���}
  DefaultRowHeight := (Message.Height - GridLines) div 7;    {�����µ�Ĭ��cell�߶�}
end;

procedure TSampleCalendar.DrawCell(ACol, ARow: Longint; ARect: TRect;
  AState: TGridDrawState);
var
  TheText: string;
  TempDay: Integer;
begin
  if ARow = 0 then                                   {������Ǳ�ͷ}
    TheText := ShortDayNames[ACol + 1]               {ֻ�������ڵ�����}
  else begin
    TheText := '';                                     {Ĭ��Ϊ��}
    TempDay := DayNum(ACol, ARow);                 {�õ����cell����ֵ}
    if TempDay <> -1 then TheText := IntToStr(TempDay);   {�����Ч�����}
  end;
  with ARect, Canvas do
    TextRect(ARect, Left + (Right - Left - TextWidth(TheText)) div 2,
      Top + (Bottom - Top - TextHeight(TheText)) div 2, TheText); 
end;

procedure TSampleCalendar.SetCalendarDate(Value: TDateTime);
begin
  FDate := Value;                      {�����µ�����ֵ}
  UpdateCalendar;                                   {��ԭ���ǵ���Refresh}
  Change;                                        {����Ψһ�������}
end;

function TSampleCalendar.GetDateElement(Index: Integer): Integer;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);               {���������ڷֽ�ΪԪ��}
  case Index of
    1: Result := AYear;
    2: Result := AMonth;
    3: Result := ADay;
    else Result := -1;
  end;
end;

procedure TSampleCalendar.SetDateElement(Index: Integer; Value: Integer);
var
  AYear, AMonth, ADay: Word;
begin
  if Value > 0 then                                      {����Ԫ�ر���������}
  begin
    DecodeDate(FDate, AYear, AMonth, ADay);          {��õ�ǰ����Ԫ��}
    case Index of                                   {�������������µ�Ԫ��}
      1: AYear := Value;
      2: AMonth := Value;
      3: ADay := Value;
      else Exit;
    end;
    FDate := EncodeDate(AYear, AMonth, ADay);         {�����޸ĵ�����}
    FDate := EncodeDate(AYear, AMonth, ADay);          {�����޸ĵ�����}
    UpdateCalendar;                                  {��ԭ���ǵ���Refresh}
    Change;                                      {���������}
  end;
end;

procedure TSampleCalendar.UpdateCalendar;
var
  AYear, AMonth, ADay: Word;
  FirstDate: TDateTime;                             {�µĵ�һ�������}
begin
  if FDate <> 0 then                                {���������Чֻ����ƫ��}
  begin
    DecodeDate(FDate, AYear, AMonth, ADay);         {�õ�����Ԫ��}
    FirstDate := EncodeDate(AYear, AMonth, 1);         {��һ�������}
    FMonthOffset := 2 - DayOfWeek(FirstDate);         {�ڱ���в���ƫ��}
    Row := (ADay - FMonthOffset) div 7 + 1;
    Col := (ADay - FMonthOffset) mod 7;
  end;
  Refresh;                                        {�ػ��ؼ�}
end;

function TSampleCalendar.DayNum(ACol, ARow: Integer): Integer;
begin
  Result := FMonthOffset + ACol + (ARow - 1) * 7;         {�������cell������}
  if (Result < 1) or (Result > MonthDays[IsLeapYear(Year), Month]) then
    Result := -1;                                     {�����Ч���أ�1}
end;

procedure TSampleCalendar.NextMonth;
begin
  CalendarDate := IncMonth(CalendarDate, 1);
end;

procedure TSampleCalendar.PrevMonth;
begin
  CalendarDate := IncMonth(CalendarDate, -1);
end;

procedure TSampleCalendar.NextYear;
begin
  CalendarDate := IncMonth(CalendarDate, 12);
end;

procedure TSampleCalendar.PrevYear;
begin
  CalendarDate := IncMonth(CalendarDate, -12);
end;

procedure TSampleCalendar.Click;
var
  TempDay: Integer;
begin
  TempDay := DayNum(Col, Row);               {��ñ����cell����������}
  if TempDay <> -1 then Day := TempDay;         {�����Ч���ı�����}
  inherited Click;                              {��ס���ü̳з�����}
end;

procedure TSampleCalendar.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TSampleCalendar.SelectCell(ACol, ARow: Longint): Boolean;
begin
  if DayNum(ACol, ARow) = -1 then Result := False           {-1ָ��ֵ��Ч}
  else Result := inherited SelectCell(ACol, ARow);            {����ʹ�ü̳е�ֵ}
end;



end.
