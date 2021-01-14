unit WrapMemo;

interface

uses
  SysUtils, Classes, Controls, StdCtrls;

type
  TWrapMemo = class(TMemo)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;  {�����������һ����}
  published
    { Published declarations }
    property WordWrap default False;
  end;

procedure Register;

implementation

constructor TWrapMemo.Create(AOwner: TComponent);    {����ڵ�Ԫ��implementation����}
begin
  inherited Create(AOwner);                           {�����ڵ�һ����䣡}
  WordWrap := False;                                 {�����µ�ֵ}
end;


procedure Register;
begin
  RegisterComponents('Samples', [TWrapMemo]);
end;

end.
