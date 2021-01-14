unit lujingUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, bsSkinCtrls, bsSkinBoxCtrls, bsfilectrl, StdCtrls,
  BusinessSkinForm;

type
  Tlujingform = class(TForm)
    bsSkinPanel1: TbsSkinPanel;
    divbox: TbsSkinDriveComboBox;
    Label1: TLabel;
    dirlist: TbsSkinDirectoryListBox;
    bsSkinButton1: TbsSkinButton;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    procedure bsSkinButton1Click(Sender: TObject);
  private
    procedure wmgetminmaxinfo(var msg :TWMGetMinMaxInfo);message wm_getminmaxinfo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  lujingform: Tlujingform;

implementation
uses mainunit,toexcelunit;

{$R *.dfm}

procedure Tlujingform.bsSkinButton1Click(Sender: TObject);
begin
if dirlist.ItemIndex<>0 then
  begin
    toexcel.Edit2.Text:=dirlist.Directory;
    close;
  end
else
  Application.MessageBox('��ѡ��һ��Ŀ¼��','��ʾ');

end;



procedure tlujingform.wmgetminmaxinfo(var msg :TWMGetMinMaxInfo);
begin
    with msg.minmaxinfo^ do
   
    begin
      ptMinTrackSize:=point(375,289);//  �޶���С
      ptMaxTrackSize:=point(375,289); // �޶���С
    end;
end;


end.
