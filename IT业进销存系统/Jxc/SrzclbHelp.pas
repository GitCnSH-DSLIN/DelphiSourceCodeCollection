unit SrzclbHelp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComHelp, ComCtrls, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls;

type
  TfrmSrzclbHelp = class(TfrmComHelp)
    Label3: TLabel;
    Edit3: TEdit;
    procedure LoadEditForm(Para1: string);override;
    function GetFilter: string;override;
    procedure btnDelClick(Sender: TObject);override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSrzclbHelp: TfrmSrzclbHelp;

implementation

uses SrzclbEdit, Dm;

{$R *.DFM}

{ TfrmKhHelp }

function TfrmSrzclbHelp.GetFilter: string;
begin
  if Caption = 'ѡ����֧���' then
    Result := ''
  else
  begin
    if Caption = 'ѡ����֧��� - ֧����' then
      Result := 'SRL = False'
    else
      Result := 'SRL = True';
  end;
end;

procedure TfrmSrzclbHelp.LoadEditForm(Para1: string);
begin
  frmEdit := TfrmSrzclbEdit.Create(Application);
  inherited;
end;

procedure TfrmSrzclbHelp.btnDelClick(Sender: TObject);
begin
  strDetailTables := 'FYKZZB; QTSRZB';
  strDetailWheres := 'SFKFSID = [ID]';
  inherited;
end;

end.
