unit common;

interface
  uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, DBGrids, DBClient, DB, Registry, winsock,ADODB,variants,
  comobj,excel97,excel2000,QuickRpt,math, DBGridEh;


 //��������
   function SmallToBig(Small:Real):string;
   function ConnectLocalDB(const adocon:TadoConnection;const dbname,computername,username,Password:string):boolean;
   function returnint(const para,s:string;i:integer;trun:boolean):string;//���ض�������
   function  CheckTable(const tmptable:string;ado:TADOQuery):boolean;//  //�����ʱ��
//******************************���ù���ֵ******************************************
//�����Ĺ���:
   procedure MoveSelect(list:TcustomListbox;Items:Tstrings);
   procedure MoveaLL(list:TcustomListbox;Items:Tstrings);
   procedure ExportDataToExecel(dbgrid: TDBGrid;const sTitle,UserName,printDate:string);
//   procedure ExportDataToExecel(dbgrid: TDBGridEh;const sTitle,UserName,printDate:string);
   procedure DbGridSort(dbgrid: TDBGrid; Column: TColumn);
   procedure repairTable(const tmptable:string;ado:TADOQuery);
   procedure DbGridEhSort(dbgrid: TDBGridEh; Column: TColumnEh);
var
  strsql,s_value:string;
  psIndexName: string;
  plAscend:Boolean;
implementation
//DBGridEh***����
procedure DbGridEhSort(dbgrid: TDBGridEh; Column:TColumnEh);
var
//��ģ��ʹ�õ���psIndexName, plAscend�����������϶���
  mode: char; //��¼�ǡ����򡱻��ǡ�����
  ColName: string; //��¼��ǰ�ֶ���
  iCol: Integer; //��¼��ǰ�к�
begin
  with dbgrid.DataSource.DataSet as Tclientdataset do //Table0
  begin
//��⵱ǰ�������Ƿ��Ѵ�
    if not Active
      then begin
      Application.MessageBox('��������δ�򿪣�', 'ֹͣ', MB_OK + MB_ICONSTOP);
      Abort
    end;
//��⵱ǰ�ֶ��Ƿ������򡱡������ֶ����Ͳ�������
    case Column.Field.DataType of
      ftBoolean,
        ftBytes,
        ftBlob, //Binary
        ftMemo,
        ftGraphic,
        ftFmtMemo, //Formatted memo
        ftParadoxOle: //OLE
        begin
          Abort
        end;
    end; //case
    mode := '0';
    iCol := Column.Field.FieldNo - 1;
    try
      ColName := Column.fieldname;
      if psIndexName = Column.fieldname then
      begin //��ԭ��ͬ��
        if plAscend //����
          then begin
          mode := '2';
          IndexName := ColName + '2'; //Ӧ������
        end
        else begin
          mode := '1';
          IndexName := ColName + '1'; //Ӧ������
        end;
        plAscend := not plAscend;
      end
      else begin //����
        IndexName := ColName + '2';
      //  IndexName := ColName ;
        plAscend := false;
        psIndexName := ColName;
      end;
    except
      on EDatabaseError do //��δ�������������½���
      begin
//�����½�����
        IndexName := '';
        if mode = '1'
          then AddIndex(ColName + '1', ColName, [], '', '', 0) //
        else //����'0'
          AddIndex(ColName + '2', ColName, [ixDescending], '', '', 0);
        try //try 1
          if mode <> '1'
            then begin
            mode := '2'; //ת��
            plAscend := false;
          end
          else plAscend := true;
          IndexName := ColName + mode;
          psIndexName := ColName;
        except
          IndexName := '';
        end //try 2
      end
    end;
    first;
  end; //with
  dbgrid.SelectedIndex := iCol;
end;
//ɾ����ʱ��
procedure repairTable(const tmptable:string;ado:TADOQuery);
begin
strsql:='drop table '+tmptable;
with ado do
begin
  close;
  sql.Clear ;
  sql.Add(strsql);
  prepared;
  execsql; 
end;
end;
//
procedure DbGridSort(dbgrid: TDBGrid; Column:TColumn);
var
//��ģ��ʹ�õ���psIndexName, plAscend�����������϶���
  mode: char; //��¼�ǡ����򡱻��ǡ�����
  ColName: string; //��¼��ǰ�ֶ���
  iCol: Integer; //��¼��ǰ�к�
begin
  with dbgrid.DataSource.DataSet as Tclientdataset do //Table0
  begin
//��⵱ǰ�������Ƿ��Ѵ�
    if not Active
      then begin
      Application.MessageBox('��������δ�򿪣�', 'ֹͣ', MB_OK + MB_ICONSTOP);
      Abort
    end;
//��⵱ǰ�ֶ��Ƿ������򡱡������ֶ����Ͳ�������
    case Column.Field.DataType of
      ftBoolean,
        ftBytes,
        ftBlob, //Binary
        ftMemo,
        ftGraphic,
        ftFmtMemo, //Formatted memo
        ftParadoxOle: //OLE
        begin
          Abort
        end;
    end; //case
    mode := '0';
    iCol := Column.Field.FieldNo - 1;
    try
      ColName := Column.fieldname;
      if psIndexName = Column.fieldname then
      begin //��ԭ��ͬ��
        if plAscend //����
          then begin
          mode := '2';
          IndexName := ColName + '2'; //Ӧ������
        end
        else begin
          mode := '1';
          IndexName := ColName + '1'; //Ӧ������
        end;
        plAscend := not plAscend;
      end
      else begin //����
        IndexName := ColName + '2';
        plAscend := false;
        psIndexName := ColName;
      end;
    except
      on EDatabaseError do //��δ�������������½���
      begin
//�����½�����
        IndexName := '';
        if mode = '1'
          then AddIndex(ColName + '1', ColName, [], '', '', 0) //
        else //����'0'
          AddIndex(ColName + '2', ColName, [ixDescending], '', '', 0);
        try //try 1
          if mode <> '1'
            then begin
            mode := '2'; //ת��
            plAscend := false;
          end
          else plAscend := true;
          IndexName := ColName + mode;
          psIndexName := ColName;
        except
          IndexName := '';
        end //try 2
      end
    end;
    first;
  end; //with
  dbgrid.SelectedIndex := iCol;
end;

//����EXECL
procedure ExportDataToExecel(dbgrid: TDBGrid;CONST sTitle,UserName,printDate:string);
var
varexcel:variant;//�������
range:variant;
i,j,k:integer;
xxxl:string;
xr:string;
begin
 try
 screen.Cursor :=crHourGlass;
    try
    //����Excel����
      varexcel:=CreateOleObject('Excel.Application');
      if not varisempty(varexcel) then
      begin
        //��ӹ�����
        varexcel.workbooks.add;
        varexcel.workbooks[1].worksheets[1].name:='���ݿ���Ϣ';
      end;
    except
      Application.messagebox('��ȷ���Ƿ�װExcel����', '��ʾ��Ϣ', mb_iconinformation + mb_defbutton1);
      exit;
    end;

  if not dbgrid.DataSource.DataSet.Active then
  begin
     Screen.Cursor := crDefault;
     Exit;
  end;

   begin
      range:=varexcel.workbooks[1].worksheets[1].columns;
      for i:=0 to dbgrid.Columns.Count - 1  do begin
          varexcel.workbooks[1].worksheets[1].cells[2,i+1].value:=dbgrid.Columns[I].Title.Caption;
          varexcel.workbooks[1].worksheets[1].cells[2,i+1].font.bold:=true;
          range.columns[i+1].columnwidth:=int(dbgrid.Columns[I].Width/5) ;
          range.columns[i+1].HorizontalAlignment:=xlCenter;
      end;

      try
      try
        //ѭ��д�����ݵ�EXCEL��
         dbgrid.DataSource.DataSet.first;
         j:=3;
         while not dbgrid.DataSource.DataSet.Eof  do
         begin
            for i:=0 to  dbgrid.Columns.Count - 1  do
              begin
              if  dbgrid.Columns.Items[i].Field.Value = null then
                xr:=' '//+dbgrid.Columns.Items[i].Field.Value
              else
                xr:=dbgrid.Columns.Items[i].Field.AsString;
                varexcel.workbooks[1].worksheets[1].cells[j,i+1].value:=xr;
              end;
              dbgrid.DataSource.DataSet.Next;
              j:=j+1;
         end;


         varexcel.workbooks[1].worksheets[1].cells[j+1,2].value:='�Ʊ�'+UserName;
         varexcel.workbooks[1].worksheets[1].cells[j+1,5].value:='���ڣ�'+printDate ;

         except
         end;
       finally
        //    frmMain.StatusBar1.panels[0].text:='';
            k:=i-1+ord('A');
            xxxl:=chr(k);
            xxxl:='a2:'+xxxl+inttostr(j-1);
            //�����ݱ����
          range:=varexcel.workbooks[1].worksheets[1].range[xxxl];
          range.borders.linestyle:=xlcontinuous;
          range.FONT.NAME:='����';
          range.font.size:='10';
            k:=i-1+ord('A');
            xxxl:=chr(k);
            xxxl:='a1:'+xxxl+'1';
           //���ݱ����о���
           range:=varexcel.workbooks[1].worksheets[1].range[xxxl];
           range.HorizontalAlignment:=xlCenter;
           range.VerticalAlignment:=xlCenter;

           range.MergeCells:=true;

           //��������������
           varexcel.workbooks[1].worksheets[1].range['a1:a1']:= sTitle;
           varexcel.workbooks[1].worksheets[1].range['A1:A1'].FONT.NAME:='����';
           varexcel.workbooks[1].worksheets[1].range['A1:A1'].font.size:='12';
           varexcel.workbooks[1].worksheets[1].range['A1:A1'].font.fontstyle:='bold';
           varexcel.visible:=true
         end;
        end;

 finally
 screen.Cursor :=crarrow;
 varexcel.DisplayAlerts := True
 end;
end;
//******************************���ú���ֵ****************************************** ******************//
//�����ʱ��
function  CheckTable(const tmptable:string;ado:TADOQuery):boolean;//  //�����ʱ��
var
  dt:Tdatetime;

begin

 strsql:='SELECT NAME,CRDATE FROM sysobjects WHERE (NAME =:name) ORDER BY CRDATE';
 with  ADO do
 begin
   close;
   sql.Clear ;
   sql.Add(strsql);
   Parameters.ParamByName('name').Value :=tmptable;  
   prepared;
   open;
 end;
  if ado.RecordCount >0 then
    result:=true
  else
    result:=false;   
end;
//
function ConnectLocalDB(const adocon:TadoConnection;const dbname,computername,username,Password:string):boolean;
begin
 with adocon do
 begin
  Close;
  LoginPrompt:=false;    //�����ݿⲻ����ʱ�������жϡ�����������
  ConnectionString:='Provider=SQLOLEDB.1;'+
                   'Password='+Password+';'+
                   'Persist Security Info=True;'+
                   'User ID='+username+';Initial Catalog='+dbname+';'+
                   'Data Source='+ComputerName;
  try
    KeepConnection:=true;
    Connected:=true;
    Open;
    ConnectLocalDB:=true;
   except
     ConnectLocalDB:=false;
   end;
   end;
end;
//
function returnint(const para,s:string;i:integer;trun:boolean):string;//���ض�������
var
  SelPos: Integer;
  s_value:string;
begin
   selPos:=Pos(para,s);
if  selPos>0 then
begin
//   s_value:=copy(s,selPos+1,length(s)-selPos);
  if not trun then
    s_value:=copy(s,selPos+1,length(s)-selPos) 
  else
    s_value:=copy(s,i,selPos-i) ;
result:=trim(s_value);
end;
end;

//
function SmallToBig(Small:Real):string;
Var Str:String;
  DotPos:Integer;
  i:Integer;
  bStart:Boolean;
  sResult:WideString;
  SmallDit:Double;
begin
  Result:='��Բ��';
  SmallDit:=Round((Small-INT(Small))*100)/100;
  Small:=INT(Small)+SmallDit;
  IF  Small=0 THEN
  //if SmallDit<0.01 then
    Exit;
  Str:=FormatFloat('#.##',Small);
  DotPos:=Pos('.',Str);
  if DotPos=0 then
    DotPos:=length(Str)+1;
  bStart:=False;
  For i:=DotPos-1 downto 1 do
  begin
    if (Str[i]<>'0') and (not bStart) then
      bStart:=True;
    if ABS(i-DotPos) MOD 4=1 then
    begin
      if (Str[i]='0') and (DotPos-i<>1) then
        sResult:='��'+sResult;
      Case DotPos-i of
        1:sResult:='Բ'+sResult;
        5:sResult:='��'+sResult;
        9:sResult:='��'+sResult;
        13:sResult:='��'+sResult;
      end;
      bStart:=False;
    end;
    if (Str[i]<>'0') then
    begin
      Case ABS(i-DotPos) MOD 4 of
        0:sResult:='Ǫ'+sResult;
        2:sResult:='ʰ'+sResult;
        3:sResult:='��'+sResult;
      end;
    end;
    if i=3 then
      Application.ProcessMessages;
    Case Str[i] of
      '0':if bStart and (sResult[1]<>'��') then
          begin
            sResult:='��'+sResult;
            bStart:=False;
          end;
      '1':sResult:='Ҽ'+sResult;
      '2':sResult:='��'+sResult;
      '3':sResult:='��'+sResult;
      '4':sResult:='��'+sResult;
      '5':sResult:='��'+sResult;
      '6':sResult:='½'+sResult;
      '7':sResult:='��'+sResult;
      '8':sResult:='��'+sResult;
      '9':sResult:='��'+sResult;
    end;
    if Str[i]<>'0' then
      bStart:=True;
  end;
  Delete(Str,1,DotPos);
  if Length(Str)>0 then
  begin
    Case Str[1] of
      '0':if sResult<>'' then
            sResult:=sResult+'��';
      '1':sResult:=sResult+'Ҽ';
      '2':sResult:=sResult+'��';
      '3':sResult:=sResult+'��';
      '4':sResult:=sResult+'��';
      '5':sResult:=sResult+'��';
      '6':sResult:=sResult+'½';
      '7':sResult:=sResult+'��';
      '8':sResult:=sResult+'��';
      '9':sResult:=sResult+'��';
    end;
    if Str[1]<>'0' then
      sResult:=sResult+'��';
    if Length(Str)>1 then
    begin
      Case Str[2] of
        '1':sResult:=sResult+'Ҽ';
        '2':sResult:=sResult+'��';
        '3':sResult:=sResult+'��';
        '4':sResult:=sResult+'��';
        '5':sResult:=sResult+'��';
        '6':sResult:=sResult+'½';
        '7':sResult:=sResult+'��';
        '8':sResult:=sResult+'��';
        '9':sResult:=sResult+'��';
      end;
      if Str[2]<>'0' then
        sResult:=sResult+'��';
    end else
      sResult:=sResult+'��';
  end else
    sResult:=sResult+'��';
  Result:=sResult;
end;
//

//
procedure MoveALL(list:TcustomListbox;Items:Tstrings);
var
  i:integer;
begin
SCREEN.Cursor :=crHourGlass;
for i:=list.Items.Count - 1 downto 0 do
  BEGIN
    Items.AddObject(List.Items[i],list.Items.Objects[i]);
         list.Items.Delete(i);
  END;
SCREEN.Cursor :=crDefault;
end;
//
procedure MoveSelect(list:TcustomListbox;Items:Tstrings);
var
  i:integer;
begin
SCREEN.Cursor :=crHourGlass;
for i:=list.Items.Count - 1 downto 0 do
  if list.Selected[i] then
  BEGIN
    Items.AddObject(List.Items[i],list.Items.Objects[i]);
         list.Items.Delete(i);
  END;
SCREEN.Cursor :=crDefault;  
end;

end.
