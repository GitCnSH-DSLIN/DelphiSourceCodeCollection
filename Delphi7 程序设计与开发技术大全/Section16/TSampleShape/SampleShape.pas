unit SampleShape;

interface

uses
  SysUtils, Classes, Controls,Graphics;

type
  TSampleShapeType = (sstRectangle, sstSquare, sstRoundRect, sstRoundSquare,
    sstEllipse, sstCircle); 
  TSampleShape = class(TGraphicControl)
  private
    { Private declarations }

    FPen: TPen;      {pen������}
    FBrush: TBrush;  {brush������}
    FShape: TSampleShapeType;  {��������ֵ���� }

    procedure SetBrush(Value: TBrush);
    procedure SetPen(Value: TPen);


    procedure SetShape(Value: TSampleShapeType);

  protected
    { Protected declarations }
    procedure Paint; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;   {��סoverrideָ��}
    destructor Destroy; override;                   {��סoverrideָ��}
  published
    { Published declarations }

    procedure StyleChanged(Sender: TObject);


    property Brush: TBrush read FBrush write SetBrush;
    property Pen: TPen read FPen write SetPen;


    property Height default 65;
    property Width default 65;

    property Shape: TSampleShapeType read FShape write SetShape;

    property DragCursor;                 {�Ϸ�����}
    property DragMode;
    property OnDragDrop;                {�Ϸ��¼�}
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;              {����¼�}
    property OnMouseMove;
    property OnMouseUp;                  

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TSampleShape]);
end;

constructor TSampleShape.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);  {�������ȵ��ü̳еĹ��췽��}
  Width := 65;
  Height := 65;
  FPen := TPen.Create;                          {����Pen}
  FPen.OnChange := StyleChanged;                    {ָ��OnChange�¼��ķ���}
  FBrush := TBrush.Create;                           {����Brush}
  FBrush.OnChange := StyleChanged;                  {ָ��OnChange�¼��ķ���}
end;


procedure TSampleShape.SetShape(Value: TSampleShapeType);
begin
  if FShape <> Value then                           {������������}
  begin
    FShape := Value;                               {�洢��ֵ}
    Invalidate;                                    {ǿ�����»�����״}
  end;
end;

procedure TSampleShape.SetBrush(Value: TBrush);
begin
  FBrush.Assign(Value);                         {ʹ�ò����滻�ִ��Brush}
end;

procedure TSampleShape.SetPen(Value: TPen);
begin
  FPen.Assign(Value);                           {ʹ�ò����滻�ִ��Pen}
end;

destructor TSampleShape.Destroy;
begin
  FPen.Free;                                    {����Pen����}
  FBrush.Free;                                  {����Brush����}
  inherited Destroy;                              {������ü̳е���������}
end;

procedure TSampleShape.StyleChanged(Sender: TObject);
begin
  Invalidate;                                       {ɾ�����ػ����}
end;

procedure TSampleShape.Paint;
var
  X, Y, W, H, S: Integer;
begin
  with Canvas do
  begin
    Pen := FPen;                                    {���������Pen }
    Brush := FBrush;                                {���������Brush }
    W := Width;                                    {ʹ��������}
    H := Height;                                    {ʹ������߶�}

    if W < H then S := W else S := H;                   {������̵ı�}
    case FShape of                                  {�����߶ȡ���Ⱥ�λ��}
      sstRectangle, sstRoundRect, sstEllipse:
        begin
          X := 0;                                   {ԭʼλ����ͼ������}
          Y := 0;
        end;
      sstSquare, sstRoundSquare, sstCircle:
        begin
          X := (W - S) div 2;                         {ˮƽ����������}
          Y := (H - S) div 2;                         {Ȼ���Ǵ�ֱ����}
          W := S;                                  {���ʹ����Сֵ}
          H := S;                                   {�߶�Ҳ��}
        end;
    end;
    case FShape of
      sstRectangle, sstSquare:
        Rectangle(X, Y, X + W, Y + H);
      sstRoundRect, sstRoundSquare:
        RoundRect(X, Y, X + W, Y + H, S div 4, S div 4);
      sstCircle, sstEllipse:
        Ellipse(X, Y, X + W, Y + H);
    end;
  end;  
end; 

end.
