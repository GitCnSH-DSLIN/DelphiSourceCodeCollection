unit Log;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComJbzl, Menus, StdCtrls, DBCtrls, ExtCtrls, ComCtrls, ToolWin, Grids,
  DBGrids, ActnList, Spin;

type
  TfrmLog = class(TfrmComJbzl)
    pnlDel: TPanel;
    Panel3: TPanel;
    btnDelOk: TButton;
    btnDelCalcel: TButton;
    dtpRqa: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    procedure aDelExecute(Sender: TObject);override;
    procedure btnDelOkClick(Sender: TObject);
    procedure btnDelCalcelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLog: TfrmLog;

implementation

uses Dm;
{$R *.DFM}

procedure TfrmLog.aDelExecute(Sender: TObject);
begin
  pnlDel.Top := (self.Height - pnlDel.Height) div 2;
  pnlDel.Left := (self.Width - pnlDel.Width) div 2;
  pnlDel.Visible := true;
  dtpRqa.SetFocus;
end;

procedure TfrmLog.btnDelOkClick(Sender: TObject);
begin
  screen.Cursor := crHourGlass;
  with Data.Tmp do
  begin
    Close;
    CommandText := 'delete From AppLog where RQ <= #' + DateToStr(dtpRqa.Date) + '#';
    Execute;
  end;
  dsJbzl.Refresh;
  Application.MessageBox(PChar('��ɾ�� ' + DateToStr(dtpRqa.Date) + ' ��֮ǰ����־����!'), '����ɾ��', MB_OK + MB_ICONINFORMATION);
  screen.Cursor := crDefault;
  pnlDel.Visible := false;
end;

procedure TfrmLog.btnDelCalcelClick(Sender: TObject);
begin
  pnlDel.Visible := false;
end;

end.
