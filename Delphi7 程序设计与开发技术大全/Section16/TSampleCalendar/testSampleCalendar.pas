unit testSampleCalendar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, SampleCalendar, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    SampleCalendar1: TSampleCalendar;
    DateTimePicker1: TDateTimePicker;
    Button5: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure SampleCalendar1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    procedure refreshLabel;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses DateUtils;

{$R *.dfm}

procedure TForm1.Button3Click(Sender: TObject);
begin
  SampleCalendar1.PrevYear ;
  refreshLabel ;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  SampleCalendar1.PrevMonth ;
  refreshLabel ;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  SampleCalendar1.NextMonth ;
  refreshLabel ;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  SampleCalendar1.NextYear ;
  refreshLabel ;
end;

procedure TForm1.refreshLabel;
begin
   Label1.Caption := '��ǰ����Ϊ' + IntToStr(SampleCalendar1.Year) + '��'
    + IntToStr(SampleCalendar1.Month ) + '��' + IntToStr(SampleCalendar1.Day) + '��';  
end;

procedure TForm1.SampleCalendar1Click(Sender: TObject);
begin
  inherited;
  refreshLabel ;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  refreshLabel ;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  SampleCalendar1.Year := YearOf(DateTimePicker1.DateTime);
  SampleCalendar1.Month := MonthOf(DateTimePicker1.DateTime );
  SampleCalendar1.Day := DayOf(DateTimePicker1.DateTime );     
end;

end.
