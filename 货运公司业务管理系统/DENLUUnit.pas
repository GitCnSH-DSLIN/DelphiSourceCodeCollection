unit DENLUUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, TFlatMaskEditUnit, TFlatComboBoxUnit,
  TFlatButtonUnit, AAFont, AACtrls;

type
  TDENLUForm = class(TForm)
    AALabel1: TAALabel;
    AALabel2: TAALabel;
    FlatButton1: TFlatButton;
    FlatButton2: TFlatButton;
    FlatComboBox1: TFlatComboBox;
    FlatMaskEdit1: TFlatMaskEdit;
    procedure FlatButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatComboBox1Change(Sender: TObject);
    procedure FlatComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FlatMaskEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
  int:Integer; //�жϵ�½����
    { Public declarations }
  end;

var
  DENLUForm: TDENLUForm;

implementation

uses DMUnit, MainUnit;

{$R *.dfm}

procedure TDENLUForm.FlatButton2Click(Sender: TObject);
begin
  If Application.MessageBox('�Ƿ��˳��������˹���ϵͳ?','ϵͳ��ʾ',mb_okcancel)=Mrok then
    Application.Terminate;
end;

procedure TDENLUForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=CaFree;
end;

procedure TDENLUForm.FormCreate(Sender: TObject);
begin
   int:=0;
    DM.UseNameQuery.Active:=False;
    DM.UseNameQuery.Active:=True;
    DM.UseNameQuery.First;
    While not DM.UseNameQuery.Eof do
    begin
      FlatComBoBox1.Items.Add(DM.UseNameQuery.FieldByName('NAME').AsString);
      DM.UseNameQuery.Next;
    end;
end;

procedure TDENLUForm.FlatButton1Click(Sender: TObject);
var
Str,Str1,jj:string;
begin
  If int<3 Then
    If FlatComBoBox1.Text='' then
      begin
        inc(int);
        ShowMessage('�Բ���,��ѡ���û���,�û���Ϊ��!');
        Exit;
      end;
      Str:=FlatComBoBox1.Text;
      DM.UseNameQuery.Close;
      DM.UseNameQuery.SQL.Clear;
      DM.UseNameQuery.SQL.Add('select PASS from UseName where NAME='+''''+Str+'''');
      DM.UseNameQuery.Open;
      Str1:=DM.UseNameQuery.FieldByName('PASS').AsString;
      If Trim(Str1)=Trim(FlatMaskEdit1.Text) Then
        begin
          DM.UseNameQuery.Close;
          DM.UseNameQuery.SQL.Clear;
          DM.UseNameQuery.SQL.Add('select POPEDOM from UseName Where NAME='+''''+Str+'''');
          DM.UseNameQuery.Open;
          jj:=DM.UseNameQuery.FieldByName('POPEDOM').AsString;
          If Trim(jj)='����Ա' Then
            MainForm.QuanXian:=1
            else
            MainForm.QuanXian:=2;
            close;
        end
      else
       begin
         inc(int);
         If int=3 Then
           begin
             ShowMessage('�޷���½,ϵͳ���˳�!');
             Application.Terminate;
           end;
           ShowMessage('���벻��ȷ,����'+inttostr(3-int)+'�λ���!');
           FlatMaskEdit1.Text:='';
           FlatMaskEdit1.SetFocus;
           Exit;
       end;
end;
procedure TDENLUForm.FlatComboBox1Change(Sender: TObject);
begin
  MainForm.FName:=FlatComBoBox1.Text;
end;

procedure TDENLUForm.FlatComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=13 then
    FlatButton1.Click;
end;

procedure TDENLUForm.FlatMaskEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=13 then
    FlatButton1.Click;
end;

end.
