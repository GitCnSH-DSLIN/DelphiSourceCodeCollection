unit Ugjt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons;

type
  TFGJT = class(TForm)
    pb1: TProgressBar;
    lbl1: TLabel;
    dtp1: TDateTimePicker;
    lbl3: TLabel;
    btn1: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FGJT: TFGJT;

implementation
uses UDM;
{$R *.dfm}

procedure TFGJT.FormShow(Sender: TObject);
begin
  dtp1.Date:=Date;
  DM.qrybbdate.Open;
  dm.qrydatereport.Open;
  dm.qrykr.Open;
  dm.ADOq1.Open;
end;

procedure TFGJT.btn1Click(Sender: TObject);
begin
  pb1.Position:=10;
 if not dm.qrydatereport.Locate('rq;lx',VarArrayOf([dtp1.DateTime,'����']),[]) then
 begin
   //���˱���������ϸ
  pb1.Position:=30;
    with dm.qrykr do
    begin
      Close;
      sql.Clear;
      sql.Add('select * from tableforpeople');
      sql.Add('where lx=''0''');
      Prepared;
      Open;
    end;
    pb1.Position:=50;
    if dm.qrykr.Locate('lx','0',[]) then
    begin
       dm.spjsgzr.Close;
       dm.spjsgzr.Parameters.ParamByName('@rq').Value:=dtp1.Date;
       dm.spjsgzr.ExecProc;
    end;
     while not dm.qrykr.Eof do
     begin
       dm.qrykr.Edit;
       dm.qrykrlx.Value:='1';
       DM.qrykr.Post;
       dm.qrykr.Next
     end;
     pb1.Position:=60;
   ShowMessage('���˱�������');
 end
 else
 MessageBox(Handle,'���˱����Ѿ����ɣ�','ϵͳ��ʾ',MB_ICONINFORMATION+MB_OKCANCEL);
 pb1.Position:=70;
 if not dm.qrydatereport.Locate('rq;lx',VarArrayOf([dtp1.DateTime,'����']),[]) then
 begin
   //���ű�������
    with dm.ADOq1 do
    begin
      Close;
      SQL.Clear;
      sql.Add('select * from center');
      sql.Add('where lx=''0''');
      Prepared;
      Open;
    end;
  pb1.Position:=80;
    if dm.ADOq1.Locate('lx','0',[]) then
    begin
     dm.spjsbmgz.Close;
     dm.spjsbmgz.Parameters.ParamByName('@bmrq').Value:=dtp1.Date;
     dm.spjsbmgz.ExecProc;
    end;
    while not dm.ADOq1.Eof do
    begin
       DM.ADOq1.Edit;
       dm.ADOq1lx.Value:='1';
       dm.ADOq1.Post;
       dm.ADOq1.Next;
    end;
   ShowMessage('���ű�������');
   pb1.Position:=90;
 end
 else
 MessageBox(Handle,'���ű����Ѿ����ɣ�','ϵͳ��ʾ',MB_ICONINFORMATION+MB_OKCANCEL);
 pb1.Position:=100;
 dm.ADOq1.Close;
 dm.qrykr.Close;
 Self.Close;
end;

end.
