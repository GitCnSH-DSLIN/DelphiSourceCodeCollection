unit BFHFUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AAFont, AACtrls, TFlatButtonUnit, StdCtrls, FileCtrl, ComCtrls,IdGlobal;

type
  TBFHFForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    FlatButton1: TFlatButton;
    AALabel1: TAALabel;
    Edit4: TEdit;
    FlatButton2: TFlatButton;
    FlatButton3: TFlatButton;
    OpenDialog1: TOpenDialog;
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure DirectoryListBox1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BFHFForm: TBFHFForm;

implementation

uses DMUnit;

{$R *.dfm}

procedure TBFHFForm.FlatButton1Click(Sender: TObject);
var
  Source:String;
  Destination:string;
  NewFileName: string;
  Msg: string;
  NewFile: TFileStream;
  OldFile: TFileStream;
begin
   DM.Conn.Connected:=False;
  if Edit2.Text='' then Exit;
  Source:=ExtractFileDir(Application.ExeName)+'\DATA\ChangHai.mdb';
  Destination:=Edit1.Text+'\'+Edit2.Text+Edit3.Text;
  NewFileName:=Destination;
  Msg := Format('�������ݿ⵽ %s?', [NewFileName]);
  if MessageDlg(Msg, mtConfirmation, mbOKCancel, 0) = mrOK then
  begin
    if  not CopyFileTo(Source,Destination) then
    begin
      if MessageDlg('�����ļ��Ѵ��ڣ��Ƿ񸲸ǣ�'#13#13'��� ��OK�� ���ǣ���� ��Cancel��'
         +' �˳�',mtConfirmation, mbOKCancel, 0) = mrOK then
      begin
        try
          OldFile := TFileStream.Create(Source, fmOpenRead or fmShareDenyWrite);
          try
            NewFile := TFileStream.Create(NewFileName, fmCreate or fmShareDenyRead);
            NewFile.CopyFrom(OldFile, OldFile.Size);
            showmessage('�ɹ��������ݿ⣡');
          finally
            FreeAndNil(NewFile);
          end;
        finally
          FreeAndNil(OldFile);
        end;
      end;
    end
    else
      showmessage('�ɹ��������ݿ⣡');
  end;
  DM.Conn.Connected:=True;
end;

procedure TBFHFForm.FlatButton3Click(Sender: TObject);
var
  Source:String;
  Destination:string;
  NewFileName: string;
  NewFile: TFileStream;
  OldFile: TFileStream;
begin
  DM.Conn.Connected:=False;
  if Edit4.Text='' then Exit;
  Source:=Edit4.Text;
  Destination:=ExtractFileDir(Application.ExeName)+'\DATA\ChangHai.mdb';
  NewFileName:=Destination;
  if MessageDlg('Ҫ��ԭ���ݿ���'#13'��� ��OK�� ȷ�ϣ���� ��Cancel�� �˳�',
     mtConfirmation, mbOKCancel, 0) = mrOK then
  begin
    try
      OldFile := TFileStream.Create(Source, fmOpenRead or fmShareDenyWrite);
      try
        NewFile := TFileStream.Create(NewFileName, fmCreate or fmShareDenyRead);
        NewFile.CopyFrom(OldFile, OldFile.Size);
        showmessage('�ɹ���ԭ���ݿ�');
      finally
        FreeAndNil(NewFile);
      end;
    finally
      FreeAndNil(OldFile);
    end;
  end;
  DM.Conn.Connected:=True;
end;
procedure TBFHFForm.FlatButton2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
      Edit4.Text:=OpenDialog1.FileName;
end;

procedure TBFHFForm.DirectoryListBox1Change(Sender: TObject);
begin
  Edit1.Text:=self.DirectoryListBox1.Directory;
end;

procedure TBFHFForm.FormShow(Sender: TObject);
begin
  Edit1.Text:=self.DirectoryListBox1.Directory;
end;

end.
