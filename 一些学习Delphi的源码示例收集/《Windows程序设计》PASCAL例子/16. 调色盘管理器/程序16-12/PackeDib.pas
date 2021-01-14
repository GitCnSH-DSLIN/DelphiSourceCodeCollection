unit PackeDib;

interface

uses
  Windows, Math;

  // װ��DIB
function PackedDibLoad(szFileName: PChar): PBitmapInfo;
  // DIB���
function PackedDibGetWidth(pPackedDib: PBitmapInfo): Integer;
  // DIB�߶�
function PackedDibGetHeight(pPackedDib: PBitmapInfo): Integer;
  // ÿͼ��λ��
function PackedDibGetBitCount(pPackedDib: PBitmapInfo): Integer;
  // ÿ���ֽ���
function PackedDibGetRowLength(pPackedDib: PBitmapInfo): Integer;
  // ͷ�ṹ����
function PackedDibGetInfoHeaderSize(pPackedDib: PBitmapInfo): Integer;
  // ɫ�ʶ��ձ���Ŀ��
function PackedDibGetColorsUsed(pPackedDib: PBitmapInfo): Integer;
  // ɫ�ʶ��ձ���Ŀ��
function PackedDibGetNumColors(pPackedDib: PBitmapInfo): Integer;
  // ɫ�ʶ��ձ�ߴ�
function PackedDibGetColorTableSize(pPackedDib: PBitmapInfo): Integer;
  // ɫ�ʶ��ձ��ַ
function PackedDibGetColorTablePtr(pPackedDib: PBitmapInfo): PRGBQuad;
  // ɫ�ʶ��ձ���Ŀ��ַ
function PackedDibGetColorTableEntry(pPackedDib: PBitmapInfo; i: Integer): PRGBQuad;
  // ͼ�����ݵ�ַ
function PackedDibGetBitsPtr(pPackedDib: PBitmapInfo): PByte;
  // ͼ�����ݳߴ�
function PackedDibGetBitsSize(pPackedDib: PBitmapInfo): Integer;
  // ��DIB������ɫ��
function PackedDibCreatePalette(pPackedDib: PBitmapInfo): HPALETTE;

implementation  

  // װ��DIB
function PackedDibLoad(szFileName: PChar): PBitmapInfo;
var
  bmfh: TBitmapFileHeader;
  bSuccess: Boolean;
  dwPackedDibSize, dwBytesRead: DWORD;
  hFile: THandle;
begin
  Result := nil;
  
 // ���ļ�
  hFile := CreateFile(szFileName, GENERIC_READ, FILE_SHARE_READ, nil,
    OPEN_EXISTING, FILE_FLAG_SEQUENTIAL_SCAN, 0);
  if (hFile = INVALID_HANDLE_VALUE) then Exit;

 // �����ļ�ͷ
  bSuccess := ReadFile(hFile, bmfh, SizeOf(TBitmapFileHeader), dwBytesRead, nil);
  if (not bSuccess) or
     (dwBytesRead <> SizeOf(TBitmapFileHeader)) or
     (bmfh.bfType <> PWORD(PChar('BM'))^) then
  begin
    CloseHandle(hFile);
    Exit;
  end;

 // �����ڴ�
  dwPackedDibSize := bmfh.bfSize - SizeOf(TBitmapFileHeader);
  GetMem(Result, dwPackedDibSize);

 // �����ڴ� 
  bSuccess := ReadFile(hFile, Result^, dwPackedDibSize, dwBytesRead, nil);
  CloseHandle(hFile);   
  if (not bSuccess) or (dwBytesRead <> dwPackedDibSize) then
  begin
    FreeMem(Result);
    Result := nil;
  end
end;

  // DIB���
function PackedDibGetWidth(pPackedDib: PBitmapInfo): Integer;
begin
  if (pPackedDib.bmiHeader.biSize = SizeOf(TBitmapCoreHeader)) then
    Result := PBitmapCoreInfo(pPackedDib).bmciHeader.bcWidth
  else
    Result := pPackedDib.bmiHeader.biWidth;
end;

  // DIB�߶�
function PackedDibGetHeight(pPackedDib: PBitmapInfo): Integer;
begin
  if (pPackedDib.bmiHeader.biSize = SizeOf(TBitmapCoreHeader)) then
    Result := PBitmapCoreInfo(pPackedDib).bmciHeader.bcHeight
  else
    Result := Abs(pPackedDib.bmiHeader.biHeight);
end;

  // ÿͼ��λ��
function PackedDibGetBitCount(pPackedDib: PBitmapInfo): Integer;
begin
  if (pPackedDib.bmiHeader.biSize = SizeOf(TBitmapCoreHeader)) then
    Result := PBitmapCoreInfo(pPackedDib).bmciHeader.bcBitCount
  else
    Result := pPackedDib.bmiHeader.biBitCount;
end;

  // ÿ���ֽ���??
function PackedDibGetRowLength(pPackedDib: PBitmapInfo): Integer;
begin
  Result :=
    (
      (
      PackedDibGetWidth(pPackedDib) * PackedDibGetBitCount(pPackedDib) + 31
      )
      and not 31
    )
    shr 3;
end;             

  // ͷ�ṹ����
function PackedDibGetInfoHeaderSize(pPackedDib: PBitmapInfo): Integer;
begin
  if (pPackedDib.bmiHeader.biSize = SizeOf(TBitmapCoreHeader)) then
    Result := PBitmapCoreInfo(pPackedDib).bmciHeader.bcSize
  else
    if (pPackedDib.bmiHeader.biSize = SizeOf(TBitmapInfoHeader)) then
      Result := Integer(pPackedDib.bmiHeader.biSize) +
        IfThen(pPackedDib.bmiHeader.biCompression = BI_BITFIELDS, 12, 0)
    else
      Result := pPackedDib.bmiHeader.biSize;
end;

  // ɫ�ʶ��ձ���Ŀ��
function PackedDibGetColorsUsed(pPackedDib: PBitmapInfo): Integer;
begin
  if (pPackedDib.bmiHeader.biSize = SizeOf(TBitmapCoreHeader)) then
    Result := 0
  else
    Result := pPackedDib.bmiHeader.biClrUsed;
end;

  // ɫ�ʶ��ձ���Ŀ��
function PackedDibGetNumColors(pPackedDib: PBitmapInfo): Integer;
begin
  Result := PackedDibGetColorsUsed(pPackedDib);
  if (Result = 0) and (PackedDibGetBitCount(pPackedDib) < 16) then
    Result := 1 shl PackedDibGetBitCount(pPackedDib);
end;

  // ɫ�ʶ��ձ�ߴ�
function PackedDibGetColorTableSize(pPackedDib: PBitmapInfo): Integer;
begin
  if (pPackedDib.bmiHeader.biSize = SizeOf(TBitmapCoreHeader)) then
    Result := PackedDibGetNumColors(pPackedDib) * SizeOf(TRGBTriple)
  else
    Result := PackedDibGetNumColors(pPackedDib) * SizeOf(TRGBQuad);
end;

  // ɫ�ʶ��ձ��ַ
function PackedDibGetColorTablePtr(pPackedDib: PBitmapInfo): PRGBQuad;
begin
  if (PackedDibGetNumColors(pPackedDib) = 0) then
    Result := nil
  else
    Result := PRGBQuad(Integer(pPackedDib) + PackedDibGetInfoHeaderSize(pPackedDib));
end;

  // ɫ�ʶ��ձ���Ŀ��ַ
function PackedDibGetColorTableEntry(pPackedDib: PBitmapInfo; i: Integer): PRGBQuad;
begin
  if (PackedDibGetNumColors(pPackedDib) = 0) then Result := nil
  else
  begin
    if (pPackedDib.bmiHeader.biSize = SizeOf(TBitmapCoreHeader)) then
      Result := PRGBQuad(Integer(PackedDibGetColorTablePtr(pPackedDib)) +
        SizeOf(TRGBTriple) * i)
    else
      Result := PRGBQuad(Integer(PackedDibGetColorTablePtr(pPackedDib)) +
        SizeOf(TRGBQuad) * i);
  end;      
end;

  // ͼ�����ݵ�ַ
function PackedDibGetBitsPtr(pPackedDib: PBitmapInfo): PByte;
begin
  Result := PByte( Integer(pPackedDib) + PackedDibGetInfoHeaderSize(pPackedDib) +
    PackedDibGetColorTableSize(pPackedDib) );
end;

  // ͼ�����ݳߴ�
function PackedDibGetBitsSize(pPackedDib: PBitmapInfo): Integer;
begin
  if (pPackedDib.bmiHeader.biSize <> SizeOf(TBitmapCoreHeader)) and
     (pPackedDib.bmiHeader.biSizeImage <> 0) then
    Result := pPackedDib.bmiHeader.biSizeImage
  else
    Result := PackedDibGetHeight(pPackedDib) * PackedDibGetRowLength(pPackedDib);
end; 

  // ��DIB������ɫ��
function PackedDibCreatePalette(pPackedDib: PBitmapInfo): HPALETTE;
var
  i, iNumColors: Integer;
  plp: PLogPalette;
  prgb: PRGBQuad;
begin
  iNumColors := PackedDibGetNumColors(pPackedDib);
  if (iNumColors = 0) then Result := 0
  else begin
    GetMem(plp, SizeOf(TLogPalette) * (iNumColors - 1) * SizeOf(TPaletteEntry));
    plp.palVersion := $0300;
    plp.palNumEntries := iNumColors;
    for i := 0 to iNumColors - 1 do
    begin
      prgb := PackedDibGetColorTableEntry(pPackedDib, i);
      plp.palPalEntry[i].peRed := prgb.rgbRed;
      plp.palPalEntry[i].peGreen := prgb.rgbGreen;
      plp.palPalEntry[i].peBlue := prgb.rgbBlue;
      plp.palPalEntry[i].peFlags := 0 ;
    end;
    Result := CreatePalette(plp^);
    FreeMem(plp);
  end;
end;

end.
