//==============================================================================
//��-��˾����: IN-NET Cor.
//��-��Ԫ����: ClsWmaOpter.pas
//��-��Ԫ����: wma�ļ��Ĳ�����.������ȡ,д���
//��-��������: Viking.Liu
//��-ע������:
//==============================================================================
unit ClsWmaOpter;

interface
Uses
   Classes, SysUtils;


Const
   //wma�ļ�ͷ:  30 26 B2 75 8E 66 CF 11 A6 D9 00 AA 00 62 CE 6C
   WAM_LBL_BUF: Array[0..15] of char = (
      Chr($30), Chr($26), Chr($B2), Chr($75), Chr($8E), Chr($66), Chr($CF),
      Chr($11), Chr($A6), Chr($D9), Chr($00), Chr($AA), Chr($00), Chr($62),
      Chr($CE), Chr($6C));
      
   //��׼tag��־:33 26 B2 75 8E 66 CF 11 A6 D9 00 AA 00 62 CE 6C
   NORMALTAG_LBL_BUF: Array[0..15] of char = (
      Chr($33), Chr($26), Chr($B2), Chr($75), Chr($8E), Chr($66), Chr($CF),
      Chr($11), Chr($A6), Chr($D9), Chr($00), Chr($AA), Chr($00), Chr($62),
      Chr($CE), Chr($6C));

   //��չtag��־:40 A4 D0 D2 07 E3 D2 11 97 F0 00 A0 C9 5E A8 50
   EXTENDTAG_LBL_BUF: Array[0..15] of char = (
      Chr($40), Chr($A4), Chr($D0), Chr($D2), Chr($07), Chr($E3), Chr($D2),
      Chr($11), Chr($97), Chr($F0), Chr($00), Chr($A0), Chr($C9), Chr($5E),
      Chr($A8), Chr($50));

   //ϵͳtag��־:A1 DC AB 8C 47 A9 CF 11 8E E4 00 C0 0C 20 53 65
   SYSTEM_LBL_BUF: Array[0..15] of char = (
      Chr($A1), Chr($DC), Chr($AB), Chr($8C), Chr($47), Chr($A9), Chr($CF),
      Chr($11), Chr($8E), Chr($E4), Chr($00), Chr($C0), Chr($0C), Chr($20),
      Chr($53), Chr($65));



type
   TFrameBase = class;
   TNormalTagFrame = class;
   TContainer = class;
   TExtendTagSection = class;
   TExtendTagFrame = class;
   TSystemTagFrame = class;
   

   //����wma�ļ�������
   TWma = class(TObject)
   private
      FRootList: TContainer;

      function getNormalTag(): TNormalTagFrame;
      function getExtendTag(): TExtendTagFrame;
      function getSystemTag(): TSystemTagFrame;
   public
      constructor Create();
      destructor Destroy(); override;

      procedure loadFromStream(const fstream: TFileStream);
      procedure loadFromFile(const strFileName: string);
      procedure saveToFile(const strFileName: string);

      procedure setTitle(strTitle: string);
      procedure setArtist(strArtist: string);
      procedure setCopyRight(strCopyRight: string);
      procedure setComment(strComment: string);

      procedure clearExtendTag();
      procedure modifyExtendTag(strInfo: string);
      function  isWmaFile(): Boolean;
   published
      property NormalTag: TNormalTagFrame read getNormalTag;
      property ExtendTag: TExtendTagFrame read getExtendTag;
      property SystemTag: TSystemTagFrame read getSystemTag;

      property RootList: TContainer read FRootList;
   end;


   //������
   TContainer = class(TObject)
   private
      FIsWmaFile: Boolean;
      FFileHead: Array[0..15] of Char;
      FHeadSize: Int64;
      FHeadComment: Array[0..5] of Char;

      FList: TList;
   public
      constructor Create();
      destructor Destroy(); override;

      procedure parseFileStream(fstream: TFileStream);
      function  saveToStream(mmStream: TMemoryStream): Integer;

      function getNormalTag(): TNormalTagFrame;
      function getExtendTag(): TExtendTagFrame;
      function getSystemTag(): TSystemTagFrame;

      procedure setTitle(strTitle: string);
      procedure setArtist(strArtist: string);
      procedure setCopyRight(strCopyRight: string);
      procedure setComment(strComment: string);

      procedure clearExtendTag();
      procedure ModifyExtendTag(strInfo: string);

   published
      property isWmaFile: Boolean read FIsWmaFile;
   end;


   //wma�����Ļ���
   TFrameBase = class(TObject)
   private
      FFrameHead: Array[0..15] of Char;
      FFrameSize: Int64;
      FFrameCount: Word;
      FDataBuf: Array of Char;   //��������

      FType: Integer;   //0:��׼tag 1:��չtag 2:ϵͳtag 3:����tag
   public
      constructor Create();
      destructor Destroy(); override;

      procedure parseData(fstream: TFileStream); virtual; abstract;
      function  saveToStream(mmStream: TMemoryStream): Integer; virtual; abstract;

      property FrameType: Integer read FType write FType;
      property FrameSize: Int64 read FFrameSize write FFrameSize;
   end;


   //��׼tag֡����
   TNormalTagFrame = class(TFrameBase)
   private
      FTitleSize: Word;                //title�ĳߴ�
      FArtistSize: Word;               //artist�ĳߴ�
      FCopyRightSize: Word;            //copyright�ĳߴ�
      FCommentSize: Word;              //comment�ĳߴ�
      FDescbSize: Word;                //descb�ĳߴ�

      FTitle: string;                  //title����Ϣ
      FArtist: string;                 //artist����Ϣ
      FCopyRight: string;              //copyright����Ϣ
      FComment: string;                //comment����Ϣ
      FDescb: string;                  //descb����Ϣ
   public
      constructor Create();
      destructor Destroy(); override;

      procedure parseData(fstream: TFileStream); override;
      function  saveToStream(mmStream: TMemoryStream): Integer; override;
   published
      property TitleSize: Word read FTitleSize write FTitleSize;
      property ArtistSize: Word read FArtistSize write FArtistSize;
      property CopyRightSize: Word read FCopyRightSize write FCopyRightSize;
      property CommentSize: Word read FCommentSize write FCommentSize;
      property DescbSize: Word read FDescbSize write FDescbSize;

      property Title: string read FTitle write FTitle;
      property Artist: string read FArtist write FArtist;
      property CopyRight: string read FCopyRight write FCopyRight;
      property Comment: string read FComment write FComment;
      property Descb: string read FDescb write FDescb;
   end;


   //��չtag֡����
   TExtendTagFrame = class(TFrameBase)
   private
      FList: TList;  //����section������
   public
      constructor Create();
      destructor Destroy(); override;

      procedure parseData(fstream: TFileStream); override;
      function  saveToStream(mmStream: TMemoryStream): Integer; override;

      function getWMFSDKVersion: string;
      function getWMFSDKNeeded: string;
      function getIsVBR: string;
      function getWMAlbumTitle: string;
      function getWMAlbumArtist: string;
      function getWMYear: string;
      function getWMPromotionURL: string;
      function getWMGenreID: string;
      function getWMGenre: string;
      function getWMComposer: string;
      function getWMOriginalArtist: string;
      function getWMURL: string;
      function getWMUserWebURL: string;
      function getWMEncodedBy: string;
      function getWMCodedBy: string;
      function getWMTrackNumber: string;
      function getWMTrack: string;
      function getID: string;
      function getID3: string;
      function getWMLyrics: string;
      function getWMPicture: string;
   published
      property SectionList: TList read FList;

      property WMFSDKVersion: string read getWMFSDKVersion;
      property WMFSDKNeeded: string read getWMFSDKNeeded;
      property IsVBR: string read getIsVBR;
      property WMAlbumTitle: string read getWMAlbumTitle;
      property WMAlbumArtist: string read getWMAlbumArtist;
      property WMYear: string read getWMYear;
      property WMPromotionURL: string read getWMPromotionURL;
      property WMGenreID: string read getWMGenreID;
      property WMGenre: string read getWMGenre;
      property WMComposer: string read getWMComposer;
      property WMOriginalArtist: string read getWMOriginalArtist;
      property WMURL: string read getWMURL;
      property WMUserWebURL: string read getWMUserWebURL;
      property WMEncodedBy: string read getWMEncodedBy;
      property WMCodedBy: string read getWMCodedBy;
      property WMTrackNumber: string read getWMTrackNumber;
      property WMTrack: string read getWMTrack;
      property ID: string read getID;
      property ID3: string read getID3;
      property WMLyrics: string read getWMLyrics;
      property WMPicture: string read getWMPicture;
   end;


   //wma�ļ�ϵͳ��Ϣ��
   TSystemTagFrame = class(TFrameBase)
   private
      FOtherBuf: Array[0..15] of Char;
      FFileSize: Int64;                //wma�ļ��ĳߴ�
      FData: Array of Char;
   public
      constructor Create();
      destructor Destroy(); override;

      procedure parseData(fstream: TFileStream); override;
      function  saveToStream(mmStream: TMemoryStream): Integer; override;
   published
      property FileSize: Int64 read FFileSize write FFileSize;
   end;


   //����tag��Ϣ��
   TOtherFrame = class(TFrameBase)
   private
   public
      constructor Create();
      destructor Destroy(); override;

      procedure parseData(fstream: TFileStream); override;
      function  saveToStream(mmStream: TMemoryStream): Integer; override;
   end;


   //��չtag�ĵ�Ԫ(section)��
   TExtendTagSection = class(TObject)
   private
      FSNameSize: Word;                //��Ԫ���ֵĳߴ�
      FValueSize: Word;                //��Ԫֵ�ĳߴ�
      FSectionName: string;            //��Ԫ���ֵ�ֵ
      FFlag: Word;                     //��Ԫ��flag
      FSectionValue: string;           //��Ԫ��ֵ

      
   public
      constructor Create(fstream: TFileStream);
      function  saveToStream(mstream: TMemoryStream): Integer;

      property SNameSize: Word Read FSNameSize Write FSNameSize;
      property Flag: Word Read FFlag Write FFlag;
      property ValueSize: Word Read FValueSize Write FValueSize;
      property SectionName: string Read FSectionName Write FSectionName;
      property SectionValue: string Read FSectionValue Write FSectionValue;
   end;

implementation



{ TWma }

//==============================================================================
//����-��������: TWma��Ĺ��������
//����-��������:
//����-����˵��:
//����-ע������:
//==============================================================================
constructor TWma.Create;
begin
   FRootList := TContainer.Create;
end;

destructor TWma.Destroy;
begin
   FreeAndNil(FRootList);

   inherited;
end;

//��������ȡ���������չtag֡����
function TWma.getExtendTag: TExtendTagFrame;
begin
   Result := nil;
   if (Assigned(FRootList)) then
   begin
      Result := FRootList.getExtendTag();
   end;
end;


//��������ȡ������ı�׼tag֡����
function TWma.getNormalTag: TNormalTagFrame;
begin
   Result := nil;
   if (Assigned(FRootList)) then
   begin
      Result := FRootList.getNormalTag();
   end;
end;


//��������ȡ�������ϵͳtag֡����
function TWma.getSystemTag: TSystemTagFrame;
begin
   Result := nil;
   if (Assigned(FRootList)) then
   begin
      Result := FRootList.getSystemTag();
   end;
end;


//���ļ��ж�ȡ��¼
procedure TWma.loadFromFile(const strFileName: string);
var
   fstream: TFileStream;
begin
   if (FileExists(strFileName)) then
   begin
      fstream := TFileStream.Create(strFileName, fmOpenReadWrite +
         fmShareDenyNone);

      if (Assigned(fstream)) then
      begin
         loadFromStream(fstream);
      end;

      FreeAndNil(fstream);
   end;
end;


//���ļ����ж�ȡ��¼���ֽ�
procedure TWma.loadFromStream(const fstream: TFileStream);
begin
   if (Assigned(FRootList) and Assigned(fstream)) then
   begin
      FRootList.parseFileStream(fstream);
   end;
end;

//����ǰ���ݱ��浽�ļ�
procedure TWma.saveToFile(const strFileName: string);
var
   mmstream: TMemoryStream;
   nRet: Integer;
begin
   if (Assigned(FRootList)) then
   begin
      mmstream := TMemoryStream.Create;
      nRet := FRootList.saveToStream(mmstream);

      if (nRet > 0) then
      begin
         mmstream.SaveToFile(strFileName);
      end;

      FreeAndNil(mmstream);
   end;
end;


//����title
procedure TWma.setTitle(strTitle: string);
begin
   if (Assigned(FRootList)) then
      FRootList.setTitle(strTitle);
end;


procedure TWma.setArtist(strArtist: string);
begin
   if (Assigned(FRootList)) then
      FRootList.setArtist(strArtist);
end;

procedure TWma.setCopyRight(strCopyRight: string);
begin
   if (Assigned(FRootList)) then
      FRootList.setCopyRight(strCopyRight);
end;

procedure TWma.setComment(strComment: string);
begin
   if (Assigned(FRootList)) then
      FRootList.setComment(strComment);
end;

procedure TWma.clearExtendTag;
begin
   if (Assigned(FRootList)) then
      FRootList.clearExtendTag();
end;


procedure TWma.modifyExtendTag(strInfo: string);
begin
   if (Assigned(FRootList)) then
      FRootList.ModifyExtendTag(strInfo);
end;



function TWma.isWmaFile: Boolean;
begin
   Result := true;
   if (Assigned(FRootList)) then
   begin
      Result := FRootList.isWmaFile;
   end;
end;




{ TContainer }

//==============================================================================
//����-��������: TContainer.Create
//����-��������: ������Ĺ����������
//����-����˵��:
//����-ע������:
//==============================================================================
constructor TContainer.Create;
begin
   FIsWmaFile := true;
   FillChar(FFileHead, SizeOf(FFileHead), 0);
   FHeadSize := 0;
   FillChar(FHeadComment, SizeOf(FHeadComment), 0);

   FList := TList.Create;
end;

destructor TContainer.Destroy;
var
   i: Integer;
   obj: TFrameBase;
begin
   if (Assigned(FList)) then
   begin
      //�ͷ������еĶ���
      for i := 0 to FList.Count - 1 do
      begin
         obj := TFrameBase(FList.Items[i]);
         obj.Free;
      end;

      FreeAndNil(FList);
   end;

   inherited;
end;



procedure TContainer.parseFileStream(fstream: TFileStream);
var
   chrBuf: Array[0..15] of Char;
   obj: TFrameBase;
begin
   if (not Assigned(fstream)) then
      Exit;
   fstream.Position := 0;

   //��ȡ�ļ�ͷ��
   fstream.Read(FFileHead, 16);
   if (CompareMem(@FFileHead, @WAM_LBL_BUF, SizeOf(WAM_LBL_BUF))) then
   begin
      //��ȡ�ļ�ͷsize
      fstream.Read(FHeadSize, 8);
      
      //��ȡ�ļ�ͷ�����6�ֽڶ���
      fstream.Read(FHeadComment, 6);

      //ѭ����ȡ��֡
      while (fstream.Position < fstream.Size) do
      begin
         fstream.Read(chrBuf, 16);
         fstream.Position := fstream.Position - 16;

         if (CompareMem(@chrBuf, @NORMALTAG_LBL_BUF, SizeOf(NORMALTAG_LBL_BUF))) then
         begin
            obj := TNormalTagFrame.Create();
            obj.parseData(fstream);
            FList.Add(obj);
         end
         else if (CompareMem(@chrBuf, @EXTENDTAG_LBL_BUF, SizeOf(EXTENDTAG_LBL_BUF))) then
         begin
            obj := TExtendTagFrame.Create();
            obj.parseData(fstream);
            FList.Add(obj);
         end
         else if (CompareMem(@chrBuf, @SYSTEM_LBL_BUF, SizeOf(SYSTEM_LBL_BUF))) then
         begin
            obj := TSystemTagFrame.Create();
            obj.parseData(fstream);
            FList.Add(obj);
         end 
         else
         begin
            obj := TOtherFrame.Create();
            obj.parseData(fstream);

            FList.Add(obj);
         end;
      end;
   end
   else
   begin
      FIsWmaFile := false;
   end;
end;


//�������ڵ�����֡ת�浽�ڴ�����
function TContainer.saveToStream(mmStream: TMemoryStream): Integer;
var
   mstream: TMemoryStream;
   obj: TFrameBase;
   i, nRet: Integer;
   chrBuf: Array of Char;
begin
   Result := 0;

   if (Assigned(FList) and Assigned(mmStream)) then
      try
         mmStream.Position := 0;

         //д���ļ�ͷ
         mmStream.Write(FFileHead, 16);
         //д��ͷ��size
         mmStream.Write(FHeadSize, 8);
         //д�����岻�����6���ֽ�.
         mmStream.Write(FHeadComment, 6);

         //���б��ж�ȡ���������֡
         for i := 0 to FList.Count - 1 do
         begin
            obj := TFrameBase(FList.Items[i]);
            if (Assigned(obj)) then
            begin
               mstream := TMemoryStream.Create;
               nRet := obj.saveToStream(mStream);
               if (nRet > 0) then
               begin
                  //��֡��Ϣ��ȡ������
                  mstream.Position := 0;
                  SetLength(chrBuf, mstream.Size);
                  mstream.Read(chrBuf[0], mstream.Size);

                  //���������Ϣ���浽��
                  mmStream.Write(chrBuf[0], mstream.Size);
               end;
            
               FreeAndNil(mstream);
            end;
         end;

         Result := mmStream.Size;
      except
      end;
end;


//��ȡ��׼tag��Ϣ
function TContainer.getNormalTag: TNormalTagFrame;
var
   i: Integer;
   obj: TFrameBase;
begin
   Result := nil;

   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         obj := TFrameBase(FList.Items[i]);
         if (Assigned(obj)) then
         begin
            if (obj.FrameType = 0) then
            begin
               Result := TNormalTagFrame(obj);
               Break;
            end;
         end;
      end;
   end;
end;


//��ȡ��չtag����Ϣ
function TContainer.getExtendTag: TExtendTagFrame;
var
   i: Integer;
   obj: TFrameBase;
begin
   Result := nil;

   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         obj := TFrameBase(FList.Items[i]);
         if (Assigned(obj)) then
         begin
            if (obj.FrameType = 1) then
            begin
               Result := TExtendTagFrame(obj);
               Break;
            end;
         end;
      end;
   end;
end;

//��ȡϵͳtag����Ϣ
function TContainer.getSystemTag: TSystemTagFrame;
var
   i: Integer;
   obj: TFrameBase;
begin
   Result := nil;

   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         obj := TFrameBase(FList.Items[i]);
         if (Assigned(obj)) then
         begin
            if (obj.FrameType = 2) then
            begin
               Result := TSystemTagFrame(obj);
               Break;
            end;
         end;
      end;
   end;
end;


//����title
procedure TContainer.setTitle(strTitle: string);
var
   ntag: TNormalTagFrame;
   nLen, nLenMore: Integer;
   stag: TSystemTagFrame;
begin
   ntag := getNormalTag();
   nLen := Length(WideString(strTitle)) * 2;

   if (Assigned(ntag)) then
   begin
      if (ntag.TitleSize >= nLen) then
         nTag.Title := strTitle
      else
      begin
         nLenMore := nLen - ntag.TitleSize + 2;

         //�����ļ�ͷsize
         FHeadSize := FHeadSize + nLenMore;

         //�����ļ��ܳ�size
         stag := getSystemTag();
         if (Assigned(stag)) then
         begin
            stag.FileSize := stag.FileSize + nLenMore;
         end;

         //���ñ���size
         nTag.FrameSize := nTag.FrameSize + nLenMore;
         nTag.TitleSize := nTag.TitleSize + nLenMore;
         nTag.Title := strTitle;
      end;
   end;
end;


//����
procedure TContainer.setArtist(strArtist: string);
var
   ntag: TNormalTagFrame;
   nLen, nLenMore: Integer;
   stag: TSystemTagFrame;
begin
   ntag := getNormalTag();
   nLen := Length(WideString(strArtist)) * 2;

   if (Assigned(ntag)) then
   begin
      if (ntag.ArtistSize >= nLen) then
         nTag.Artist := strArtist
      else
      begin
         nLenMore := nLen - ntag.ArtistSize + 2;

         //�����ļ�ͷsize
         FHeadSize := FHeadSize + nLenMore;

         //�����ļ��ܳ�size
         stag := getSystemTag();
         if (Assigned(stag)) then
         begin
            stag.FileSize := stag.FileSize + nLenMore;
         end;

         //���ñ���size
         nTag.FrameSize := nTag.FrameSize + nLenMore;
         nTag.ArtistSize := nTag.ArtistSize + nLenMore;
         nTag.Artist := strArtist;
      end;
   end;
end;


procedure TContainer.setCopyRight(strCopyRight: string);
var
   ntag: TNormalTagFrame;
   nLen, nLenMore: Integer;
   stag: TSystemTagFrame;
begin
   ntag := getNormalTag();
   nLen := Length(WideString(strCopyRight)) * 2;

   if (Assigned(ntag)) then
   begin
      if (ntag.CopyRightSize >= nLen) then
         nTag.CopyRight := strCopyRight
      else
      begin
         nLenMore := nLen - ntag.CopyRightSize + 2;

         //�����ļ�ͷsize
         FHeadSize := FHeadSize + nLenMore;

         //�����ļ��ܳ�size
         stag := getSystemTag();
         if (Assigned(stag)) then
         begin
            stag.FileSize := stag.FileSize + nLenMore;
         end;

         //���ñ���size
         nTag.FrameSize := nTag.FrameSize + nLenMore;
         nTag.CopyRightSize := nTag.CopyRightSize + nLenMore;
         nTag.CopyRight := strCopyRight;
      end;
   end;
end;


//����comment
procedure TContainer.setComment(strComment: string);
var
   ntag: TNormalTagFrame;
   nLen, nLenMore: Integer;
   stag: TSystemTagFrame;
begin
   ntag := getNormalTag();
   nLen := Length(WideString(strComment)) * 2;

   if (Assigned(ntag)) then
   begin
      if (ntag.CommentSize >= nLen) then
         nTag.Comment := strComment
      else
      begin
         nLenMore := nLen - ntag.CommentSize;

         //�����ļ�ͷsize
         FHeadSize := FHeadSize + nLenMore;

         //�����ļ��ܳ�size
         stag := getSystemTag();
         if (Assigned(stag)) then
         begin
            stag.FileSize := stag.FileSize + nLenMore;
         end;

         //���ñ���size
         nTag.FrameSize := nTag.FrameSize + nLenMore;
         nTag.CommentSize := nTag.CommentSize + nLenMore;
         nTag.Comment := strComment;
      end;
   end;
end;


//�����չtag�е���Ϣ.������������ɳ���
procedure TContainer.clearExtendTag();
var
   ntag: TExtendTagFrame;
   Item: TExtendTagSection;
   i: Integer;
begin
   ntag := getExtendTag();

   if (Assigned(ntag) and Assigned(ntag.FList)) then
   begin
      for i := 0 to ntag.FList.Count - 1 do
      begin
         Item := TExtendTagSection(ntag.FList.Items[i]);
         if (Item.SectionName <> 'WMFSDKVersion') and
            (Item.SectionName <> 'WMFSDKNeeded') and
            (Item.SectionName <> 'WM/Year') and
            (Item.SectionName <> 'WM/GenreID') and
            (Item.SectionName <> 'WM/Genre') and
            (Item.SectionName <> 'WM/TrackNumber') and
            (Item.SectionName <> 'WM/Track') and
            (Item.SectionName <> 'WMFSDKVersion') then
         begin
            Item.SectionValue := '';
         end;
      end;
   end;
end;


procedure TContainer.ModifyExtendTag(strInfo: string);
var
   etag: TExtendTagFrame;
   stag: TSystemTagFrame;
   Item: TExtendTagSection;
   i, nLen, nLenMore: Integer;
begin
   nLen := Length(WideString(strInfo)) * 2;
   etag := getExtendTag();

   if (Assigned(etag) and Assigned(etag.FList)) then
   begin
      for i := 0 to etag.FList.Count - 1 do
      begin
         Item := TExtendTagSection(etag.FList.Items[i]);
         if (Item.SectionName <> 'WM/Year') and
            (Item.SectionName <> 'WM/GenreID') and
            (Item.SectionName <> 'WM/Genre') and
            (Item.SectionName <> 'WM/TrackNumber') and
            (Item.SectionName <> 'WM/Track') and
            (Item.SectionName <> 'WM/Lyrics') then
         begin
            if (Item.Flag = 0) then
            begin
               if (Item.ValueSize >= nLen) then
                  Item.SectionValue := strInfo
               else
               begin
                  nLenMore := nLen - Item.ValueSize + 2;

                  //�����ļ�ͷsize
                  FHeadSize := FHeadSize + nLenMore;

                  //�����ļ��ܳ�size
                  stag := getSystemTag();
                  if (Assigned(stag)) then
                  begin
                     stag.FileSize := stag.FileSize + nLenMore;
                  end;

                  //������չtag��size����
                  etag.FrameSize := etag.FrameSize + nLenMore;

                  //���ñ���size
                  Item.ValueSize := Item.ValueSize + nLenMore;
                  Item.SectionValue := strInfo;
               end;
            end;
         end;
      end;
   end;
end;




{ TFrameBase }

constructor TFrameBase.Create();
begin
   FFrameSize := 0;
   FFrameCount := 0;

   //FFatherContainer := AOwner;
end;

destructor TFrameBase.Destroy;
begin
   //FFatherContainer := nil;

   //debug
   inherited;
end;



{ TNormalTagFrame }


//==============================================================================
//����-��������: TNormalTagFrame
//����-��������: ��׼tag�ĺ���
//����-����˵��:
//����-ע������:
//==============================================================================
constructor TNormalTagFrame.Create();
begin
   FFrameCount := 0;
   FrameType := 0;

   inherited Create();
end;

destructor TNormalTagFrame.Destroy;
begin
   //FFatherContainer := nil;

   inherited Destroy;
end;



//������׼tag������
procedure TNormalTagFrame.parseData(fstream: TFileStream);
var
   wstrTemp: WideString;
begin
   //��ȡ֡ͷ
   fstream.Read(FFrameHead, 16);

   //��ȡ֡��
   fstream.Read(FFrameSize, 8);

   //�����ֶε�size
   fstream.Read(FTitleSize, 2);
   fstream.Read(FArtistSize, 2);
   fstream.Read(FCopyRightSize, 2);
   fstream.Read(FCommentSize, 2);
   fstream.Read(FDescbSize, 2);

   //��ȡtitle
   SetLength(wstrTemp, FTitleSize div 2);
   fstream.Read(wstrTemp[1], FTitleSize);
   FTitle := PWideChar(wstrTemp);

   //��ȡartist
   SetLength(wstrTemp, FArtistSize div 2);
   fstream.Read(wstrTemp[1], FArtistSize);
   FArtist := PWideChar(wstrTemp);

   //��ȡCopyRight
   SetLength(wstrTemp, FCopyRightSize div 2);
   fstream.Read(wstrTemp[1], FCopyRightSize);
   FCopyRight := PWideChar(wstrTemp);

   //��ȡComment
   SetLength(wstrTemp, FCommentSize div 2);
   fstream.Read(wstrTemp[1], FCommentSize);
   FComment := PWideChar(wstrTemp);

   //��ȡDescb
   SetLength(wstrTemp, FDescbSize div 2);
   fstream.Read(wstrTemp[1], FDescbSize);
   FDescb := PWideChar(wstrTemp);

   inherited;
end;



//==============================================================================
//����-��������: saveToBuf
//����-��������: ����֡����Ϣ���浽buf��
//����-����˵��:
//����-ע������:
//==============================================================================
function TNormalTagFrame.saveToStream(mmStream: TMemoryStream): Integer;
var
   chrBuf: Array of Char;
begin
   Result := 0;

   if (Assigned(mmStream)) then
      try
         mmStream.Position := 0;

         mmStream.Write(FFrameHead, 16);
         mmStream.Write(FFrameSize, 8);
         mmStream.Write(FTitleSize, 2);
         mmStream.Write(FArtistSize, 2);
         mmStream.Write(FCopyRightSize, 2);
         mmStream.Write(FCommentSize, 2);
         mmStream.Write(FDescbSize, 2);

         //debug
         SetLength(chrBuf, FTitleSize + FArtistSize + FCopyRightSize + FCommentSize + FDescbSize);
         FillChar(chrBuf[0], FTitleSize + FArtistSize + FCopyRightSize + FCommentSize + FDescbSize, 0);
         mmStream.Write(chrBuf[0], FTitleSize + FArtistSize + FCopyRightSize + FCommentSize + FDescbSize);
         mmStream.Position := mmStream.Position - (FTitleSize + FArtistSize + FCopyRightSize + FCommentSize + FDescbSize);

         mmStream.Write(PWideChar(WideString(FTitle))^, FTitleSize);
         mmStream.Write(PWideChar(WideString(FArtist))^, FArtistSize);
         mmStream.Write(PWideChar(WideString(FCopyRight))^, FCopyRightSize);
         mmStream.Write(PWideChar(WideString(FComment))^, FCommentSize);
         mmStream.Write(PWideChar(WideString(FDescb))^, FDescbSize);

         Result := mmStream.Size;
      except
      end;
end;




{ TExtendTagFrame }

constructor TExtendTagFrame.Create();
begin
   FrameType := 1;
   FList := TList.Create;

   inherited Create();
end;

destructor TExtendTagFrame.Destroy;
var
   i: Integer;
   Item: TExtendTagSection;
begin
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         Item := TExtendTagSection(FList.Items[i]);
         Item.Free;
      end;
   end;
   FreeAndNil(FList);

   inherited Destroy;
end;



//==============================================================================
//����-��������: parseData
//����-��������: ������չtag���ֵ�����
//����-����˵��:
//����-ע������:
//==============================================================================
procedure TExtendTagFrame.parseData(fstream: TFileStream);
var
   i: Integer;
   sect: TExtendTagSection;
begin
   if (not Assigned(FList)) then
      FList := TList.Create;

   //��ȡ֡ͷ
   fstream.Read(FFrameHead, 16);

   //��ȡ֡��
   fstream.Read(FFrameSize, 8);

   //��ȡ��Ԫ(section)����
   fstream.Read(FFrameCount, 2);

   //ѭ����ȡ��Ԫ
   for i := 0 to FFrameCount - 1 do
   begin
      sect := TExtendTagSection.Create(fstream);
      if (Assigned(sect)) then
         FList.Add(sect);
   end;

   inherited;
end;



//����չ���ֵ����ݺϳ�Ϊһ���ڴ���
function TExtendTagFrame.saveToStream(mmStream: TMemoryStream): Integer;
var
   sectObj: TExtendTagSection;
   sectStream: TMemoryStream;
   i, nRet: Integer;
   chrBuf: Array of Char;
begin
   Result := 0;
   
   if (Assigned(mmStream)) then
   begin
      mmStream.Position := 0;

      //д��ͷ
      mmStream.Write(FFrameHead, 16);
      //д��֡size
      mmStream.Write(FFrameSize, 8);
      //д�뵥Ԫ����
      mmStream.Write(FFrameCount, 2);

      //ѭ��д�����Ԫ
      for i := 0 to FList.Count - 1 do
      begin
         sectObj := TExtendTagSection(FList.Items[i]);
         if (Assigned(sectObj)) then
         begin
            //������ʱ��Ԫ�ڴ���
            sectStream := TMemoryStream.Create;
            nRet := sectObj.saveToStream(sectStream);

            if (nRet > 0) then
            begin
               //����ʱ��Ԫ�ڴ����ж�ȡ��Ϣ
               sectStream.Position := 0;
               SetLength(chrBuf, sectStream.Size);
               sectStream.Read(chrBuf[0], sectStream.Size);

               //д�뱾����
               mmStream.Write(chrBuf[0], sectStream.Size);
            end;

            //�ͷ���ʱ��Ԫ�ڴ���
            FreeAndNil(sectStream);
         end;
      end;

      Result := mmStream.Size;
   end;
end;




function TExtendTagFrame.getWMFSDKVersion: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'WMFSDKVersion') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;


function TExtendTagFrame.getWMFSDKNeeded: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'WMFSDKNeeded') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;


function TExtendTagFrame.getIsVBR: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'IsVBR') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;


function TExtendTagFrame.getWMAlbumTitle: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'WM/AlbumTitle') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;


function TExtendTagFrame.getWMAlbumArtist: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'WM/AlbumArtist') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;


function TExtendTagFrame.getWMYear: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'WM/Year') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;

function TExtendTagFrame.getWMPromotionURL: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'WM/PromotionURL') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;

function TExtendTagFrame.getWMGenreID: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'WM/GenreID') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;


function TExtendTagFrame.getWMGenre: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'WM/Genre') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;


function TExtendTagFrame.getWMComposer: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'WM/Composer') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;


function TExtendTagFrame.getWMOriginalArtist: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'WM/OriginalArtist') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;

function TExtendTagFrame.getWMURL: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'WM/URL') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;


function TExtendTagFrame.getWMUserWebURL: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'WM/UserWebURL') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;


function TExtendTagFrame.getWMEncodedBy: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'WM/EncodedBy') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;


function TExtendTagFrame.getWMCodedBy: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'WM/CodedBy') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;

function TExtendTagFrame.getWMTrackNumber: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'WM/TrackNumber') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;

function TExtendTagFrame.getWMTrack: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'WM/Track') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;


function TExtendTagFrame.getID: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'ID') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;

function TExtendTagFrame.getID3: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'ID3') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;

function TExtendTagFrame.getWMLyrics: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'WM/Lyrics') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;


function TExtendTagFrame.getWMPicture: string;
var
   i: Integer;
   sect: TExtendTagSection;
begin
   Result := '';
   
   if (Assigned(FList)) then
   begin
      for i := 0 to FList.Count - 1 do
      begin
         sect := TExtendTagSection(FList.Items[i]);

         if (Assigned(sect)) then
         begin
            if (sect.SectionName = 'WM/Picture') then
            begin
               Result := sect.SectionValue;
               Break;
            end;
         end;
      end;
   end;
end;



{ TSystemTagFrame }

constructor TSystemTagFrame.Create();
begin
   FrameType := 2;
   //inherited Create(AOwner);
end;

destructor TSystemTagFrame.Destroy;
begin

   inherited Destroy;
end;



//==============================================================================
//����-��������: parseData
//����-��������: ����ϵͳ֡
//����-����˵��:
//����-ע������:
//==============================================================================
procedure TSystemTagFrame.parseData;
var
   nLen: Integer;
begin
   //��ȡ֡ͷ
   FillChar(FFrameHead, SizeOf(FFrameHead), 0);
   fstream.Read(FFrameHead, 16);

   //��ȡ֡��
   fstream.Read(FFrameSize, 8);

   //��ȡfilesize��head
   FillChar(FOtherBuf, SizeOf(FOtherBuf), 0);
   fstream.Read(FOtherBuf, 16);

   //��ȡ�����ļ���size
   fstream.Read(FFileSize, 8);

   //��ȡ��������
   nLen := FFrameSize - 16 - 8 - 16 - 8;
   SetLength(FData, nLen);
   FillChar(FData[0], nLen, 0);
   fstream.Read(FData[0], nLen);

   inherited;
end;



//��ϵͳtag����Ϣת�浽�ڴ���
function TSystemTagFrame.saveToStream(mmStream: TMemoryStream): Integer;
begin
   Result := 0;

   if (Assigned(mmStream)) then
      try
         mmStream.Position := 0;

         mmStream.Write(FFrameHead, 16);
         mmStream.Write(FFrameSize, 8);
         mmStream.Write(FOtherBuf, 16);
         mmStream.Write(FFileSize, 8);
         mmStream.Write(FData[0], FFrameSize - 16 - 8 - 16 -8);

         Result := mmStream.Size;
      except
      end;
end;




{ TOtherFrame }

constructor TOtherFrame.Create();
begin
   FrameType := 3;

   //inherited Create();
end;

destructor TOtherFrame.Destroy;
begin                  

   inherited;
end;

//��������
procedure TOtherFrame.parseData;
begin
   //��ȡ֡ͷ
   fstream.Read(FFrameHead, 16);

   //��ȡ֡��
   fstream.Read(FFrameSize, 8);

   //��ȡ����
   SetLength(FDataBuf, FFrameSize - 16 - 8);
   //bug
   //FillChar(FDataBuf[0], 16, 0);
   fstream.Read(FDataBuf[0], FFrameSize - 16 - 8);

   inherited;
end;


//����Ϣת�浽�ڴ�����
function TOtherFrame.saveToStream(mmStream: TMemoryStream): Integer;
begin
   Result := 0;

   if (Assigned(mmStream)) then
      try
         mmStream.Position := 0;

         mmStream.Write(FFrameHead, 16);
         mmStream.Write(FFrameSize, 8);
         mmStream.Write(FDataBuf[0], FFrameSize - 16 - 8);

         Result := mmStream.Size;
      except
      end;
end;



{ TExtendTagSection }

//==============================================================================
//����-��������: parseSection
//����-��������:
//����-����˵��:
//����-ע������:
//==============================================================================
constructor TExtendTagSection.Create(fstream: TFileStream);
var
   wstrTemp: WideString;
begin
   if (Assigned(fstream)) then
   begin
      //��ȡsection.name��size
      fstream.Read(FSNameSize, 2);

      //��ȡsection.name
      SetLength(wstrTemp, FSNameSize div 2);
      fstream.Read(wstrTemp[1], FSNameSize);
      FSectionName := PWideChar(wstrTemp);

      //��ȡflag
      fstream.Read(FFlag, 2);

      //��ȡsection.value��size
      fstream.Read(FValueSize, 2);

      //��ȡsection.value
      SetLength(wstrTemp, FValueSize div 2);
      fstream.Read(wstrTemp[1], FValueSize);
      FSectionValue := PWideChar(wstrTemp);
   end;
end;


//����չtag�ĵ�Ԫ�ϳ�Ϊ�ڴ���
function TExtendTagSection.saveToStream(mstream: TMemoryStream): Integer;
begin
   Result := 0;

   if (Assigned(mstream)) then
      try
         mstream.Position := 0;

         mstream.Write(SNameSize, 2);
         mstream.Write(PWideChar(WideString(SectionName))^, SNameSize);
         mstream.Write(Flag, 2);
         mstream.Write(ValueSize, 2);
         mstream.Write(PWideChar(WideString(SectionValue))^, ValueSize);

         Result := mstream.Size;
      except
      end;
end;






end.
