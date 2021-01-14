unit JpegSave2DataBaseUnit1;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   Db, ExtCtrls, Grids, Variants, DBGrids, DBTables, StdCtrls, DBCtrls, Mask;

type
   TForm1 = class(TForm)
      Table1: TTable;
      DataSource1: TDataSource;
      Table1Description: TMemoField;
      Table1Picture: TGraphicField;
      OpenDialog1: TOpenDialog;
      Panel2: TPanel;
      LoadJPEG_b: TButton;
      DBGrid1: TDBGrid;
      Panel3: TPanel;
      Image1: TImage;
      DBMemo1: TDBMemo;
      Panel4: TPanel;
      Splitter1: TSplitter;
      Table1Filename: TStringField;
      Table1Folder: TStringField;
      Edit1: TEdit;
      procedure Table1AfterScroll(DataSet: TDataSet);
      procedure LoadJPEG_bClick(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
         DataCol: Integer; Column: TColumn; State: TGridDrawState);
   private
      procedure LoadFileToDB(const FilePath: string);
      { Private declarations }
   public
      { Public declarations }
   end;

var
   Form1: TForm1;

implementation

uses JPEG;

{$R *.DFM}

procedure TForm1.Table1AfterScroll(DataSet: TDataSet);
var
   MS: TMemoryStream;
   J1: TJPEGImage;
begin
   Screen.Cursor := crHourglass;
   try {Finall}
      Edit1.Text := Table1Folder.AsString + '\' + Table1Filename.AsString;
      if Table1Picture.IsNull then
         Image1.Picture.Assign(nil)
      else
         begin
            J1 := TJPEGImage.Create;
            MS := TMemoryStream.Create;
            try
               Table1Picture.SaveToStream(MS);
               MS.Seek(0, soFromBeginning);
               with J1 do
                  begin
                     PixelFormat := jf24Bit;
                     Scale := jsFullSize;
                     Grayscale := False;
                     Performance := jpBestQuality;
                     ProgressiveDisplay := True;
                     ProgressiveEncoding := True;
                     LoadFromStream(MS);
                  end;
               Image1.Picture.Assign(J1);
            finally
               J1.Free;
               MS.Free;
            end;
         end;
   finally
      Screen.Cursor := crDefault;
   end;
end;

procedure TForm1.LoadFileToDB(const FilePath: string);
//��ȡ�����ݿ���
var
   FileName, Folder: string;
   MS: TMemoryStream;
   J1: TJPEGImage;
begin
   MS := TMemoryStream.Create;
   J1 := TJPEGImage.Create;
   try {Finally}
      Filename := ExtractFilename(FilePath);
      //��ȡ�ļ���
      Folder := ExtractFileDir(FilePath);
      //�ļ�·��
      if Table1.Locate('Filename;Folder', VarArrayOf([Filename, Folder]), [])
         then
         Table1.Edit
            //��ʼ���в������
      else
         begin
            Table1.Append;
            //���뵽ĩβ
            Table1Filename.AsString := Filename;
            //���뵽FileName�ֶ�
            Table1Folder.AsString := Folder;
            //���뵽Folder�ֶ�
         end;
      try {Except}

         Image1.Picture.LoadFromFile(FilePath);
         J1.Assign(Image1.Picture);
         //����jpgͼƬ
         J1.SaveToStream(MS);
         //��ȡ������
         Table1Picture.LoadFromStream(MS);
         //��ȡ��ͼƬ�ֶ�
         Table1.Post;
         //�ύ
      except
         on e: Exception do
            begin
               //�쳣����
               ShowMessage
                  (e.Message + ^M + 'while trying to load ' + FilePath);
               with Table1 do
                  if not (State in [dsInactive, dsBrowse]) then
                     Cancel;
            end;
      end {Except}
   finally
      MS.Free; //�ͷ���Դ
      J1.Free;
   end {Finally};
end;

procedure TForm1.LoadJPEG_bClick(Sender: TObject);
var
   i: integer;
begin
   with OpenDialog1 do
      if Execute then
         for i := 0 to Files.Count - 1 do
            begin
               LoadFileToDB
                  (Files[i]);
            end;
   //����ѡ����ͼƬ//����ȫ��ѡ���ͼƬ
end;

procedure TForm1.FormShow(Sender: TObject);
begin
   Table1.Open;
   //�����ݿ�
   Table1.FieldByName('filename').DisplayLabel := '�ļ���';
   //��ʾ�ֶε���������
   Table1.FieldByName('folder').DisplayLabel := 'ͼƬ·��';
end;

procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
   DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
   i: integer;
begin
   if gdSelected in State then
      Exit;

   //�����ͷ������ͱ�����ɫ��
   for i := 0 to (Sender as TDBGrid).Columns.Count - 1 do
      begin
         (Sender as TDBGrid).Columns[i].Title.Font.Name := '����';
         //����
         (Sender as TDBGrid).Columns[i].Title.Font.Size := 9;
         //�����С
         (Sender as TDBGrid).Columns[i].Title.Font.Color := $000000FF;
         //������ɫ(��ɫ)
         (Sender as TDBGrid).Columns[i].Title.Color := $0000FF00;
         //����ɫ(��ɫ)
      end;

   //���иı����񱳾�ɫ��
   if Self.table1.RecordCount mod 2 = 0 then
      (Sender as TDBGrid).Canvas.Brush.Color := clInfoBk
         //���屳����ɫ
   else
      (Sender as TDBGrid).Canvas.Brush.Color := RGB(191, 255, 223);
   //���屳����ɫ

//���������ߵ���ɫ��
   DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
   with (Sender as TDBGrid).Canvas do
      //�� cell �ı߿�
      begin
         Pen.Color := $00FF0000;
         //���廭����ɫ(��ɫ)
         MoveTo(Rect.Left, Rect.Bottom);
         //���ʶ�λ
         LineTo(Rect.Right, Rect.Bottom);
         //����ɫ�ĺ���
         Pen.Color := $0000FF00;
         //���廭����ɫ(��ɫ)
         MoveTo(Rect.Right, Rect.Top);
         //���ʶ�λ
         LineTo(Rect.Right, Rect.Bottom);
         //����ɫ������
      end;
end;

end.

