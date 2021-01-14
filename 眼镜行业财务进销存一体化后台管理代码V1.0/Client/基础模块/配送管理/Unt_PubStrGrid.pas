unit Unt_PubStrGrid;

///****ר��ΪSTRINGGRID������һ�����ú�����   ydy create 2004-4-25***/

interface
  uses Windows, SysUtils, Messages,Classes, Controls,grids,inifiles,forms;

///2004-4-20 ��д����STRINGGRID�ĺ���
procedure StrGridDeleteRow(sgorder:Tstringgrid;Row: Integer);
procedure StrGridClear(sgorder:Tstringgrid);
procedure StrGridAddRow(sgorder:Tstringgrid);


procedure InitialStrGrid(sgorder:TStringGrid;billtype:string);  ///��ʼ�����ݸ�ʽ

procedure addgridrows(sgorder:TStringGrid); //������
procedure deletegridrows(sgorder:TStringGrid;prow:integer); // ɾ�������У�


implementation

procedure StrGridAddRow(sgorder:Tstringgrid);
var
  rows:integer;
begin
    rows:=sgorder.RowCount-1;
//    if (trim(sgorder.Cells[1,rows])<>'') and (trim(sgorder.Cells[4,rows])<>'') then
//    begin
      sgorder.RowCount:=sgorder.RowCount+1;
      sgorder.Rows[sgorder.RowCount-1].Text:='';
//    end;
//  end;
end;

procedure StrGridDeleteRow(sgorder:Tstringgrid;Row: Integer);
var
  i : integer;
begin
//���һ��ֱ��ɾ��
 if (Row = sgorder.RowCount-1) and (row >1)  then
    Sgorder.RowCount := Sgorder.RowCount - 1;
//�Զ�����
  if (Row < Sgorder.RowCount) and (Row > Sgorder.FixedRows-1) then
  begin
    if Row < Sgorder.RowCount - 1 then
    begin
      for i := Row to Sgorder.RowCount-1 do
        Sgorder.Rows[i] := Sgorder.Rows[i+1];
      Sgorder.RowCount := Sgorder.RowCount - 1;
    end;
  end;
end;

procedure StrGridClear(sgorder:Tstringgrid);
var
  i,j:integer;
begin
   ///////////ydy add to clear the stringgrid
   with sgorder do
   begin
      for i:=1 to colCount do
         for j:=1 to rowCount do
            cells[i,j]:='';
   end;
   sgorder.RowCount := 2;
end;

procedure addgridrows(sgorder:TStringGrid); //������
begin
  sgorder.RowCount:=sgorder.RowCount+1;
  sgorder.Cells[0,sgorder.RowCount-1]:=inttostr(sgorder.RowCount-1); //��ʾ���;
end;
procedure deletegridrows(sgorder:TStringGrid;prow:integer); // ɾ�������У�
var
  i,j:integer;                               
begin
  if prow>0 then
  begin
    sgorder.Rows[prow].Clear;
    j:=prow;
    i:=prow+1;
    while i<= sgorder.RowCount-1 do
    begin
      sgorder.Rows[j]:=sgorder.Rows[i];
      sgorder.Cells[0,j]:=inttostr(j);
      sgorder.Rows[i].Clear;
      inc(i);
      inc(j);
    end;
    if sgorder.RowCount>2 then
    begin
      sgorder.RowCount:=sgorder.RowCount-1;
    end;
  end;

end;

///////2004-4-23 add ydy
procedure InitialStrGrid(sgorder:TStringGrid;billtype:string);
/////�ӹ���
     ///��Ž���Ϊ����������
     procedure AddCol(no:integer;name:string;width:integer;IsVisible:boolean);
      begin
       sgorder.Cells[sgorder.colcount-1,0]:=name;  ///'��Ʒ����';
       if Isvisible then
        sgorder.ColWidths[sgorder.colcount-1] := width
       else
       sgorder.ColWidths[sgorder.colcount-1] := -1;   //���ɼ�
       sgorder.colcount := sgorder.colcount + 1;
      end;

var
  fl:tinifile;
  count,i,j,size:integer;
  flag:boolean;
  fieldname,item:string;
begin
  fl:=Tinifile.Create(ExtractFilePath(application.ExeName)+'SetCols.ini');    //�ֶ�����
  sgorder.Options:=sgorder.Options+[goColSizing];
  if billtype = 'Ԥ����Ʒ���͵�' then
  begin
    item:='503';
    sgorder.colCount := 1;
    Addcol(0,'���',28,true);
    Addcol(1,'��Ʒ���',100,true);
    Addcol(2,'��Ʒ����',140,true);
    Addcol(3,'��Ʒ����',200,true);
    Addcol(4,'�˻��ֿ�',28,false);
    Addcol(5,'���ղֿ�',28,false);
    Addcol(6,'��λ',60,true);
    Addcol(7,'����',60,true);
    Addcol(8,'�˻���',60,false);
    Addcol(9,'���ϼ�',70,false);
    Addcol(10,'����',28,false);
    Addcol(11,'�ɱ���',28,false);
    Addcol(12,'�ɱ��ϼ�',28,false);
    Addcol(13,'˰��',28,false);
    Addcol(14,'˰��',28,false);
    Addcol(15,'˰�ۺϼ�',28,false);
    Addcol(16,'��λ����',28,false);
    Addcol(17,'Ԥ����Ʒ˵��',200,true);
    Addcol(18,'���ղֿ���',28,false);
    Addcol(19,'��Ʒϵͳ���',28,false);
    Addcol(20,'��ǰ��λ',28,false);
    Addcol(21,'��ǰ��������',28,false);
  end;
 if billtype = '�����˻���' then
  begin
    item:='202';
    sgorder.colCount := 1;
    Addcol(0,'���',28,true);
    Addcol(1,'��Ʒ���',100,true);
    Addcol(2,'��Ʒ����',140,true);
    Addcol(3,'��Ʒ����',200,true);
    Addcol(4,'�˻��ֿ�',28,false);
    Addcol(5,'���ղֿ�',28,false);
    Addcol(6,'��λ',60,true);
    Addcol(7,'����',60,true);
    Addcol(8,'�˻���',60,false);
    Addcol(9,'���ϼ�',70,false);
    Addcol(10,'����',28,false);
    Addcol(11,'�ɱ���',28,false);
    Addcol(12,'�ɱ��ϼ�',28,false);
    Addcol(13,'˰��',28,false);
    Addcol(14,'˰��',28,false);
    Addcol(15,'˰�ۺϼ�',28,false);
    Addcol(16,'��λ����',28,false);
    Addcol(17,'���Ͳֿ���',28,false);
    Addcol(18,'���ղֿ���',28,false);
    Addcol(19,'��Ʒϵͳ���',28,false);
    Addcol(20,'��ǰ��λ',28,false);
    Addcol(21,'��ǰ��������',28,false);
  end;

  if billtype = '�ŵ���������' then
  begin
    item:='202';
    sgorder.colCount := 1;
    Addcol(0,'���',28,true);
    Addcol(1,'��Ʒ���',100,true);
    Addcol(2,'��Ʒ����',140,true);
    Addcol(3,'��Ʒ����',200,true);
    Addcol(4,'��λ',60,true);
    Addcol(5,'Ҫ������',70,true);
    Addcol(6,'��������',70,false);
    Addcol(7,'���״̬',70,true);
    Addcol(8,'��ǰ�е�λ',28,false);
    Addcol(9,'��Ʒϵͳ���',28,false);
    Addcol(10,'�Ƿ����� ',28,false);
    Addcol(11,'��λ����',28,false);
    Addcol(12,'���ݵ�λ',28,false);
  end;

  if billtype = '�����ջ���' then
  begin
    item:='202';
    sgorder.colCount := 1;
    Addcol(0,'���',28,true);
    Addcol(1,'��Ʒ���',100,true);
    Addcol(2,'��Ʒ����',140,true);
    Addcol(3,'��Ʒ����',200,true);
    Addcol(4,'���Ͳֿ�',28,false);
    Addcol(5,'���ղֿ�',28,false);
    Addcol(6,'��λ',60,true);
    Addcol(7,'����',60,true);
    Addcol(8,'���ͼ�',60,false);
    Addcol(9,'���ϼ�',70,false);
    Addcol(10,'����',28,false);
    Addcol(11,'�ɱ���',28,false);
    Addcol(12,'�ɱ��ϼ�',28,false);
    Addcol(13,'˰��',28,false);
    Addcol(14,'˰��',28,false);
    Addcol(15,'˰�ۺϼ�',28,false);
    Addcol(16,'��λ����',28,false);
    Addcol(17,'���Ͳֿ���',28,false);
    Addcol(18,'���ղֿ���',28,false);
    Addcol(19,'��Ʒϵͳ���',28,false);
    Addcol(20,'��ǰ��λ',28,false);
    Addcol(21,'�������',28,false);
  end;

  if billtype = '�ŵ������˻����뵥' then
  begin
    item:='201';
    sgorder.colCount := 1;
    Addcol(0,'���',28,true);
    Addcol(1,'��Ʒ���',100,true);
    Addcol(2,'��Ʒ����',140,true);
    Addcol(3,'��Ʒ����',200,true);
    Addcol(4,'��λ',60,true);
    Addcol(5,'�˻�����',70,true);
    Addcol(6,'�������',70,true);
    Addcol(7,'���״̬',70,true);
    Addcol(8,'��ǰ�е�λ',28,false);
    Addcol(9,'��Ʒϵͳ���',28,false);
    Addcol(10,'�Ƿ����� ',28,false);
    Addcol(11,'��λ����',28,false);
    Addcol(12,'���ݵ�λ',28,false);

  end;
  if billtype='���Ԥ��' then
  begin
    item:='200';
    sgorder.colCount :=2;
    addcol(1,'����',70,true);
    addcol(2,'���',70,true);
    sgorder.colCount:=sgorder.colCount-1;
  end;
  if billtype='��Ӫҵ�Գ���' then
  begin
    item:='7';
    sgorder.colCount := 1;
  end;
   if billtype='���Ͷ���' then
  begin
    item:='303';
    sgorder.colCount := 1;
    addcol(0,'�к�',30,true);
    addcol(1,'��Ʒ���',150,true);
    addcol(2,'��Ʒ����',200,true);
    addcol(3,'���ͱ���',60,true);
    addcol(4,'�������',80,true);
    addcol(5,'��������',80,true);
  end;
  if billtype='��Ӫҵ�����' then
  begin
    item:='8';
    sgorder.colCount := 1;

  end;
  if billtype='�ɹ����' then
  begin
    item:='5';
    sgorder.colCount := 1;

  end;
  if billtype='�ײͶ���1' then
  begin
    item:='100';
    sgorder.colCount := 1;
    addcol(0,'�к�',30,true);
    addcol(1,'��Ʒ���',150,true);
    addcol(2,'��Ʒ����',200,true);
    addcol(3,'����',60,false);
    addcol(4,'����',60,true);
    addcol(5,'���',60,true);
    addcol(6,'����',80,true);
    addcol(7,'��������',80,true);
    addcol(8,'��ע˵��',150,true);
  end;
  if billtype='�ײͶ���2' then
  begin
    item:='101';
     sgorder.colCount := 1;
    addcol(0,'�к�',30,true);
    addcol(1,'��Ʒ���',150,true);
    addcol(2,'��Ʒ����',200,true);
    addcol(3,'����',60,false);
    addcol(4,'����',60,true);
    addcol(5,'���',60,true);
    addcol(6,'����',80,true);
    addcol(7,'��������',80,true);
    addcol(8,'��ע˵��',150,true);
  end;
  if billtype='�����Ǽ�' then
  begin
    item:='2';
    sgorder.colCount := 1;
  end;
  if billtype='��������' then
  begin
    item:='3';
    sgorder.colCount := 1;
  end;
  if billtype='�ɹ���ͬ' then
  begin
    sgorder.colCount := 1;
    item:='1';
  end;
  if billtype='�ɹ��˻�' then
  begin
    item:='4';
    sgorder.colCount := 1;
  end;
  if billtype='����˻�' then
  begin
    item:='14';
    sgorder.colCount := 1;
  end;
  if billtype='�����˻�' then
  begin
    item:='15';
    sgorder.colCount := 1;
  end;
  if billtype='�������' then
  begin
    item:='6';
    sgorder.colCount := 1;
  end;
  if billtype='��Ʒ����' then
  begin
    item:='0';
    sgorder.colCount := 1;
  END;
  if billtype='�µ��̻�' then
  begin
    item:='13';
    sgorder.colCount := 1;
  END;
  count:=fl.ReadInteger(item,'ColSum',0);
  for i:=1 to count do
  begin
    fieldname:=fl.ReadString(item,'ColName'+inttostr(i),'');
    j:=fl.ReadInteger(item,'ViewFlag'+inttostr(i),2);
    size:=fl.ReadInteger(item,'ColSize'+inttostr(i),0);
    if j=1 then
    begin
      flag:=true;
    end else
    begin
      flag:=false;
    end;
    addcol(i-1,fieldname,size,flag);
  end;
  fl.free;
  fl:=nil;
  sgorder.colCount:=sgorder.colCount-1;
end;
end.
