// this is create by ww
//it used to record the common procedurces or function
//create at 2000-07-30

unit common;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Menus, Registry, DB, Printers, DBTables;

procedure SetPaperSize(X, Y: Integer);
// ��δ�����Կ��á���λ��0.1mm
// A4ʱ Printer.Pagewidth:=1440��  A5ʱ Printer.Pagewidth:=1049��
// B5ʱ Printer.Pagewidth:=1290��  16Kʱ Printer.Pagewidth:=1035��
// lq1600���д�ӡ�����ֵ������Ϊ42cm����, ���ȴ�Լ2m��

//���ܣ���֤MDI ChildformΨһ
procedure OpenForm(FormClass: TFormClass; var fm; AOwner: TComponent);
//���ܣ����ַ�+1
function plusone(tmp: string): string;

//�����ڱ�ʾΪ���ĸ�ʽ:XXXX��XX��XX��
function DateToChinese(ADate: TDate): string;
//ȡ����������
function GetComputerName: string;
//ȡ������ǰ�û���
function GetCurrentUser: string;
//�Զ���TDATALIK����Ҫ�������ݱ仯ʱ��Button.or ����
type
  TwDataLink = class(TDataLink)
  private
    FOnStateChange: TNotifyEvent;
    FOnEditing: TNotifyEvent;
    constructor Create;
    procedure DataSetChanged; override;
    procedure EditingChanged; override;
  public
  published
    property OnStateChange: TNotifyEvent read FOnStateChange write FOnStateChange;
    property OnEditing: TNotifyEvent read FOnEditing write FOnEditing;
  end;
implementation


procedure SetPaperSize(X, Y: Integer);
// ��δ�����Կ��á���λ��0.1mm
// A4ʱ Printer.Pagewidth:=1440��  A5ʱ Printer.Pagewidth:=1049��
// B5ʱ Printer.Pagewidth:=1290��  16Kʱ Printer.Pagewidth:=1035��
// lq1600���д�ӡ�����ֵ������Ϊ42cm����, ���ȴ�Լ2m��
{Question:
How can I change the papersize of my print job?
Answer:
One way to change printer settings at the start
of a print job is to change the printer's devicemode
structure.
See: TDEVMODE in the Delphi 1.02 help file or DEVMODE
in the Delphi 2.01 help file for other settings you can
change (providing the print driver supports the change).
The following example, contains code to change the papersize and
the paper bin that is uses:}
var
  Device: array[0..cchDeviceName - 1] of char;
  Driver: array[0..Max_Path - 1] of char;
  Port: array[0..32] of char;
  hDMode: THandle;
  PDMode: PDEVMODE;
begin
  Printer.PrinterIndex := Printer.PrinterIndex;
  Printer.GetPrinter(Device, Driver, Port, hDMode);
  if hDMode <> 0 then
    begin
      pDMode := GlobalLock(hDMode);
      if pDMode <> nil then
        begin
          if (x = 0) or (y = 0) then
            begin
              {Set to legal}
              pDMode^.dmFields := pDMode^.dmFields or dm_PaperSize;
              {pDMode^.dmPaperSize := DMPAPER_LEGAL; changed by wulianmin}
              pDMode^.dmPaperSize := DMPAPER_FANFOLD_US;
            end
          else
            begin
              {Set to custom size}//Ҫ���޸���������
              pDMode^.dmFields := pDMode^.dmFields or
                DM_PAPERSIZE or
                DM_PAPERWIDTH or
                DM_PAPERLENGTH;
              pDMode^.dmPaperSize := DMPAPER_USER;
              pDMode^.dmPaperWidth := x {SomeValueInTenthsOfAMillimeter};
              pDMode^.dmPaperLength := y {SomeValueInTenthsOfAMillimeter};
            end;
          {Set the bin to use}
          pDMode^.dmFields := pDMode^.dmFields or DMBIN_MANUAL;
          pDMode^.dmDefaultSource := DMBIN_MANUAL;

          GlobalUnlock(hDMode);
        end;
    end;
  Printer.PrinterIndex := Printer.PrinterIndex;
  //���¿�ʼ��ӡ
end;


procedure OpenForm(FormClass: TFormClass; var fm; AOwner: TComponent);
var
  i: integer;
  Child: TForm;
begin
  for i := 0 to Screen.FormCount - 1 do
    if Screen.Forms[i].ClassType = FormClass then
      begin
        Child := Screen.Forms[i];
        if Child.WindowState = wsMinimized then
          ShowWindow(Child.handle, SW_SHOWNORMAL)
        else
          ShowWindow(Child.handle, SW_SHOWNA);
        if (not Child.Visible) then Child.Visible := True;
        Child.BringToFront;
        Child.Setfocus;
        TForm(fm) := Child;
        exit;
      end;
  Child := TForm(FormClass.NewInstance);
  TForm(fm) := Child;
  Child.Create(AOwner);
end;

function DateToChinese(ADate: TDate): string;
begin
  Result := FormatDateTime('yyyy"��"m"��"d"��"', ADate);
end;

function GetComputerName: string;
var
  PComputeName: array[0..MAX_COMPUTERNAME_LENGTH] of Char;
  Length: DWord;
begin
  Length := SizeOf(PComputeName);
  if Windows.GetComputerName(PComputeName, Length) then
    Result := StrPas(PComputeName)
  else
    Result := '';
end;

function GetCurrentUser: string;
var pCurrentUser: array[0..MAX_COMPUTERNAME_LENGTH] of Char;
  Length: DWord;
begin
  Length := SizeOf(PCurrentUser);
  if Windows.GetUserName(pCurrentUser, Length) then
    Result := StrPas(pCurrentUser)
  else
    Result := '';
end;


constructor TwDataLink.Create;
begin
  inherited Create;
  VisualControl := True;
end;


procedure TwDataLink.DataSetChanged;
begin
  inherited;
  if Assigned(FOnStateChange) then FOnStateChange(Self);
end;

procedure TwDataLink.EditingChanged;
begin
  inherited;
  if Assigned(FOnEditing) then FOnEditing(Self);
end;

//���ܣ����ַ�+1

function plusone(tmp: string): string;
var sb, st: string;
begin
  sb := copy(tmp, 0, length(tmp) - 4);
  st := copy(tmp, length(tmp) - 4 + 1, 4);
  if sb = '9999' then result := '-1'
  else result := sb + format('%4.4d', [strtoint(st) + 1]);
end;



end.
