unit DBCalendar;

interface

uses
  SysUtils, Classes, Controls, Grids, SampleCalendar,DB,DBCtrls,StdCtrls,Windows;

type
  TDBCalendar = class(TSampleCalendar)
  private
    { Private declarations }
    FReadOnly: Boolean;                              {�ڲ��洢����}
    FUpdating: Boolean;                             {�ڲ�ʹ�õı�־}
    FDataLink: TFieldDataLink;

    procedure UpdateData(Sender: TObject);
    procedure CMExit(var Message: TCMExit ); message CM_EXIT;

    function GetDataSource:TDataSource;
    procedure SetDataSource(value:TDataSource);
    Function GetDataField:String;
    procedure SetDataField(Value:String);

 //   FDataSource : TDataSource ;
 //   FFieldName : TD

    procedure Datachange(Sender:TObject);
  protected
    { Protected declarations }
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);
      override;

    procedure KeyDown(var Key: Word; Shift: TShiftState);
      override;

   procedure Change; override;

   procedure Notification(AComponent:TComponent;Operation:Toperation);override;
      //��ĳһ�ؼ���FORM������ʱDELPHI��IDE���ø÷���֪ͨ�����ؼ�


  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;     {��������������Ĭ��ֵ}
    procedure UpdateCalendar; override;                {��סoverrideָʾ}
    destructor Destroy; override;
    function SelectCell(ACol, ARow: Longint): Boolean;override;
  published
    { Published declarations }
    property ReadOnly: Boolean read FReadOnly write FReadOnly default True;

    property DataSource:TDataSource read GetDataSource write SetDataSource;//�����ݿ����ӵ�����Դ����
    property DataField:String read GetDataField write SetDataField;  //�����ݿ����ӵ��ֶ�����
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TDBCalendar]);
end;

constructor TDBCalendar.Create(AOwner: TComponent);
begin

  FDataLink := TFieldDataLink.Create;          {����DataLink����}
  inherited Create(AOwner);                           {������ü̳еĹ��췽����}
  //FDataLink.Control := self;                   {ʹDataLink֪����������}
  FDataLink.OnDataChange:=DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FReadOnly := False;                                 {����Ĭ��ֵ}
end;

function TDBCalendar.SelectCell(ACol, ARow: Longint): Boolean;
begin
  if (not FUpdating) and FReadOnly then Result := False   {�������ʱ����ѡ��}
  else Result := inherited SelectCell(ACol, ARow);        {����ʹ�ü̳еķ���}
end;

procedure TDBCalendar.UpdateCalendar;
begin
  FUpdating := True;                                {����������µı�־}
  try
    inherited UpdateCalendar;                         {��ƽ��һ������}
  finally
    FUpdating := False;                               {һ��Ҫ�����־}
  end;
end;

destructor TDBCalendar.Destroy;
begin
  FDataLink.OnUpdateData := nil;
  FDataLink.OnDataChange:=nil;
  FDataLink.Free;                           {������������ӵ�еĶ���}
  inherited Destroy;                          {Ȼ����ü̳е���������}
end;

procedure TDBCalendar.DataChange(Sender:TObject);
begin
  if FDataLink.Field = nil then
    CalendarDate := 0
  else
    CalendarDate := FDataLink.Field.AsDateTime ;
end;

procedure TDBCalendar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  MyMouseDown: TMouseEvent;
begin
  if not ReadOnly and FDataLink.Edit then
    inherited MouseDown(Button, Shift, X, Y)
  else
  begin
    MyMouseDown := OnMouseDown;
    if Assigned(MyMouseDown) then MyMouseDown(Self, Button, Shift, X, Y);
  end;
end;

procedure TDBCalendar.KeyDown(var Key: Word; Shift: TShiftState);
var
  MyKeyDown: TKeyEvent;
begin
  if not ReadOnly and (Key in [VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT, VK_END,
    VK_HOME, VK_PRIOR, VK_NEXT]) and FDataLink.Edit then
    inherited KeyDown(Key, Shift)
  else
  begin
    MyKeyDown := OnKeyDown;
    if Assigned(MyKeyDown) then MyKeyDown(Self, Key, Shift);
  end;
end;

procedure TDBCalendar.UpdateData(Sender: TObject);
begin
  FDataLink.Field.AsDateTime := CalendarDate;        {�����ֶ����ӵ���������}
end;

procedure TDBCalendar.Change;
begin
  FDataLink.Modified;                  {����Modified����}
  inherited Change;                    {���ü̳е�Change����}
end;

procedure TDBCalendar.CMExit(var Message: TCMExit );
begin
  try
    FDataLink.UpdateRecord;                    {����DataLink�������ݿ�}
  except
    on Exception do SetFocus;                    {���ʧ�ܣ����������뿪}
 end;
  inherited;
end;

function TDBCalendar.GetdataSource:TdataSource;
begin
  result:=FDataLink.DataSource;
end;

Procedure TDBCalendar.SetDataSource(Value:TDataSource);
begin
  FDataLink.DataSource:=Value;
end;

function TDBCalendar.GetDatafield:String;
begin
  result:=FDataLink.FieldName;
end;

procedure TDBCalendar.SetDataField(value:String);
begin
  FDataLink.FieldName:=value;
end;

procedure TDBCalendar.Notification(AComponent:TComponent;Operation:TOperation);
begin
  inherited Notification(Acomponent,Operation);
  //����ؼ�������TdataSource��ɾ��ʱ���ؼ���DataSource������Ϊ��
  if (Operation=opRemove) and (FDataLink = nil)  and (AComponent=Datasource) then
      DataSource:=nil;
end;

end.
