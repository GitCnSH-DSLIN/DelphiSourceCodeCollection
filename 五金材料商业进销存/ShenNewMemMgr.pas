unit ShenNewMemMgr;

interface

var
  GetMemCount: Integer = 0;
  FreeMemCount: Integer = 0;
  ReallocMemCount: Integer = 0;

  mmPopupMsgDlg: Boolean = False;
  mmShowObjectInfo: Boolean = False;
  mmSaveToLogFile: Boolean = True;
  mmErrLogFile: string = '';

procedure SnapToFile(Filename: string);

implementation

uses
  Windows,
  SysUtils,
  TypInfo;

const
  MaxCount = High(Word);

var
  OldMemMgr: TMemoryManager;
  ObjList: array[0..MaxCount] of Pointer;
  FreeInList: Integer = 0;

procedure AddToList(P: Pointer);
begin
  if FreeInList > High(ObjList) then
  begin
    MessageBox(0, '�ڴ���������ָ���б�������������б�������',
      '�ڴ���������', mb_ok + mb_iconError);
    Exit;
  end;
  ObjList[FreeInList] := P;
  Inc(FreeInList);
end;

procedure RemoveFromList(P: Pointer);
var
  I: Integer;
begin
  //for I := 0 to FreeInList - 1 do
  for I := Pred(FreeInList) downto 0 do
    if ObjList[I] = P then
    begin
      Dec(FreeInList);
      Move(ObjList[I + 1], ObjList[I], (FreeInList - I) * SizeOf(Pointer));
      Exit;
    end;
end;

procedure SnapToFile(Filename: string);
var
  OutFile: TextFile;
  I,
    CurrFree,
    BlockSize: Integer;
  HeapStatus: THeapStatus;
  Item: TObject;
  ptd: PTypeData;
  ppi: PPropInfo;
begin
  AssignFile(OutFile, Filename);
  try
    if FileExists(Filename) then
      Append(OutFile)
    else
      Rewrite(OutFile);
    CurrFree := FreeInList;
    // �ֲ���״̬
    HeapStatus := GetHeapStatus;
    with HeapStatus do
    begin
      writeln(OutFile, ':::::::::::::::::::::::::::::::::::::::::::::::::::::');
      writeln(OutFile, DateTimeToStr(Now));
      writeln(OutFile);
      write(OutFile, '���õ�ַ�ռ� : ');
      write(OutFile, TotalAddrSpace div 1024);
      writeln(OutFile, ' ǧ�ֽ�');
      write(OutFile, 'δ�ύ���� : ');
      write(OutFile, TotalUncommitted div 1024);
      writeln(OutFile, ' ǧ�ֽ�');
      write(OutFile, '���ύ���� : ');
      write(OutFile, TotalCommitted div 1024);
      writeln(OutFile, ' ǧ�ֽ�');
      write(OutFile, '���в��� : ');
      write(OutFile, TotalFree div 1024);
      writeln(OutFile, ' ǧ�ֽ�');
      write(OutFile, '�ѷ��䲿�� : ');
      write(OutFile, TotalAllocated div 1024);
      writeln(OutFile, ' ǧ�ֽ�');
      write(OutFile, '��ַ�ռ����� : ');
      write(OutFile, TotalAllocated div (TotalAddrSpace div 100));
      writeln(OutFile, '%');
      write(OutFile, 'ȫ��С�����ڴ�� : ');
      write(OutFile, FreeSmall div 1024);
      writeln(OutFile, ' ǧ�ֽ�');
      write(OutFile, 'ȫ��������ڴ�� : ');
      write(OutFile, FreeBig div 1024);
      writeln(OutFile, ' ǧ�ֽ�');
      write(OutFile, '����δ���ڴ�� : ');
      write(OutFile, Unused div 1024);
      writeln(OutFile, ' ǧ�ֽ�');
      write(OutFile, '�ڴ���������� : ');
      write(OutFile, Overhead div 1024);
      writeln(OutFile, ' ǧ�ֽ�');
    end;
    writeln(OutFile);
    write(OutFile, '�ڴ������Ŀ : ');
    write(OutFile, CurrFree);
    if mmShowObjectInfo then
    begin
      if CurrFree = 0 then
      begin
        Write(OutFile, '��û���ڴ�й©��');
        writeln(OutFile);
      end
      else
      begin
        writeln(OutFile);
        for I := 0 to CurrFree - 1 do
        begin
          write(OutFile, (I + 1): 4);
          write(OutFile, ') ');
          write(OutFile, IntToHex(Cardinal(ObjList[I]), 16));
          write(OutFile, ' - ');
          BlockSize := PDWORD(DWORD(ObjList[I]) - 4)^;
          write(OutFile, BlockSize: 4);
          write(OutFile, '($' + IntToHex(BlockSize, 4) + ')�ֽ�');
          write(OutFile, ' - ');
          try
            Item := TObject(ObjList[I]);
            // type info technique
            if PTypeInfo(Item.ClassInfo).Kind <> tkClass then
              write(OutFile, '���Ƕ���')
            else
            begin
              ptd := GetTypeData(PTypeInfo(Item.ClassInfo));
              // name, �����TComponent
              ppi := GetPropInfo(PTypeInfo(Item.ClassInfo), 'Name');
              if ppi <> nil then
              begin
                write(OutFile, GetStrProp(Item, ppi));
                write(OutFile, ' : ');
              end
              else
                write(OutFile, '(δ����): ');
              write(OutFile, PTypeInfo(Item.ClassInfo).Name);
              write(OutFile, ' (');
              write(OutFile, ptd.ClassType.InstanceSize);
              write(OutFile, ' �ֽ�) - In ');
              write(OutFile, ptd.UnitName);
              write(OutFile, '.pas');
            end;
          except
            on Exception do
              write(OutFile, '���Ƕ���');
          end;
          writeln(OutFile);
        end;
      end; //end if CurrFree
    end;
  finally
    CloseFile(OutFile);
  end;
end;

function NewGetMem(Size: Integer): Pointer;
begin
  Inc(GetMemCount);
  Result := OldMemMgr.GetMem(Size);
  AddToList(Result);
end;

function NewFreeMem(P: Pointer): Integer;
begin
  Inc(FreeMemCount);
  Result := OldMemMgr.FreeMem(P);
  RemoveFromList(P);
end;

function NewReallocMem(P: Pointer; Size: Integer): Pointer;
begin
  Inc(ReallocMemCount);
  Result := OldMemMgr.ReallocMem(P, Size);
  RemoveFromList(P);
  AddToList(Result);
end;

const
  NewMemMgr: TMemoryManager = (
    GetMem: NewGetMem;
    FreeMem: NewFreeMem;
    ReallocMem: NewReallocMem);

initialization
  GetMemoryManager(OldMemMgr);
  SetMemoryManager(NewMemMgr);

finalization
  SetMemoryManager(OldMemMgr);
  if (GetMemCount - FreeMemCount) <> 0 then
  begin
    if mmPopupMsgDlg then
      MessageBox(0, PChar(Format('����%d���ڴ�©��: ',
        [GetMemCount - FreeMemCount])), '�ڴ���������', MB_OK)
    else
      OutputDebugString(PChar(Format('����%d���ڴ�©��: ', [GetMemCount -
        FreeMemCount])));
  end;
  OutputDebugString(PChar(Format('Get = %d  Free = %d  Realloc = %d',
    [GetMemCount,
    FreeMemCount, ReallocMemCount])));
  if mmErrLogFile = '' then
    mmErrLogFile := ExtractFileDir(ParamStr(0)) + '\Memory.Log';
  if mmSaveToLogFile then
    SnapToFile(mmErrLogFile);

end.

