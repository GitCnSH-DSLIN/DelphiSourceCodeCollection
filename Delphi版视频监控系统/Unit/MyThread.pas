Unit MyThread;

Interface

Uses
  Classes, SysUtils;

Type
  TFileManagerThread = Class(TThread)
  Private
    FStrings: TStrings;
  Public
    Constructor Create(CreateSuspended: Boolean; Strings: TStrings); Overload;
    Destructor Destroy; Override;
  Protected
    Procedure FindDir(Path: String; Var List: TStrings);
    Procedure Execute; Override;
  End;

Implementation

Uses
  Global;

Procedure TFileManagerThread.FindDir(Path: String; Var List: TStrings);
Var
  FindResult: Integer;
  FSearchrec: TSearchRec;
Begin
  FindResult := FindFirst(Path + '*.*', faDirectory, FSearchrec);
  Try
    While FindResult = 0 Do
    Begin
      If ((FSearchrec.Attr And faDirectory) = faDirectory)
        And (FSearchrec.Name <> '.') And (FSearchrec.Name <> '..') Then
        List.Add(Path + FSearchrec.Name);
      FindResult := FindNext(FSearchrec);
    End;
  Finally
    FindClose(FSearchrec);
  End;
End;

Procedure TFileManagerThread.Execute;
Var
  I, J: Integer;
  C: Char;
  S, Str, OldPath: String;
  cDay, OldDate: TDateTime;
  DirList: TStrings;
  NoClean: Boolean;
Begin
  NoClean := False;
  OldDate := Date;
  DirList := TStringList.Create;
  Try
    For I := 0 To FStrings.Count - 1 Do
    Begin
      C := FStrings[I][1];              //�����һ��������һ���ռ䣬����������
      If GetDiskFree(Ord(C)) > MinDiskSize + 600 Then
      Begin
        NoClean := True;
        Break;
      End;
      FindDir(FStrings[I], DirList);
    End;

    If NoClean = False Then
      If DirList.Count > 0 Then
      Begin
        For I := 0 To DirList.Count - 1 Do
        Begin
          Str := DirList[I];
          If Length(Str) > 8 Then
          Begin
            S := Copy(Str, Length(Str) - 7, 8);
            If (Length(S) = 8) And TryStrToInt(S, J) Then
            Begin                       //20080402 ��鳤���Ƿ�ϸ� �Ƿ���������
              Insert('-', S, 7);
              Insert('-', S, 5);
              If TryStrToDate(S, cDay) Then //����ļ������Ƿ����ڸ�ʽ
                If cDay < OldDate Then
                Begin                   //ȡ���б���������ڵ�Ŀ¼
                  OldDate := cDay;      //�����������
                  OldPath := Str;       //����������ڵ�·��
                End;
            End;
          End;
        End;
        If OldDate <> Date Then
        Begin
          Deltree(OldPath, True, False); //ɾ���������Ŀ¼
          S := FormatDateTime('yyyymmdd', OldDate);
          For I := 0 To DirList.Count - 1 Do //�ٱ�������¼��Ŀ¼�뵱ǰ������ڵ�Ŀ¼�Ƚ�
            If Pos(S, DirList[I]) > 0 Then //�������������ڵ�Ŀ¼��ɾ��
              Deltree(DirList[I], True, False);
        End;
      End;
  Finally
    DirList.Free;
  End;
End;

Constructor TFileManagerThread.Create(CreateSuspended: Boolean; Strings: TStrings);
Begin
  Inherited Create(CreateSuspended);
  FreeOnTerminate := True;
  FStrings := TStringList.Create;
  FStrings.Assign(Strings);
End;

Destructor TFileManagerThread.Destroy;
Begin
  FStrings.Free;
  Inherited;
End;
End.

