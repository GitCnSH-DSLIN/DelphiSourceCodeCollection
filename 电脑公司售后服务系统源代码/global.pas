{********************************************************
*                                                       *
*   unit Name:Global                                    *
*   ��;��1��������access���ݵ��޸���ѹ��               *
*                                                       *
*                                                       *
*********************************************************}
unit global;

interface
  uses DB,ADODB,Sysutils,ComObj,Dialogs,variants;

var CheckReg: integer = 0 ;    //���������Ƿ�ע�����Ϣ.0��ʾδע��״̬ 1��ʾע��״̬
    Tempinc,tempRegCode:string;  //��������ע�ṫ˾���� �� ע����� 

  function DaoActive(var DaoObject:OleVariant):Boolean;  //���� DaoObject
  function DaoCompactDB(const FileName:string):Boolean;  //ѹ�����ݿ�
  function DaoRepairDB(const FileName:string):Boolean;   //�޸����ݿ�

implementation

//���� DaoObject
function DaoActive(var DaoObject:OleVariant):Boolean;
begin
  Result:=False;
{  try
    DaoObject:=GetActiveOleObject('DAO.DBEngine.36');
    Result:=True;
  except
    try    }
      DaoObject:=CreateOleObject('DAO.DBEngine.36');
      Result:=True;
{    except
      DaoObject:=Null;
    end;
  end; }
end;

//ѹ��Access���ݿ�  �����ݽ�û��
function DaoCompactDB(const FileName:string):Boolean;
var
  db:OleVariant;
  TempFile:string;
begin
   Result:=False;
   try
     if not DaoActive(db) then Exit;
     try
       TempFile:=ExtractFilePath(FileName)+'msaTemp.mdb';
       db.CompactDatabase(FileName,TempFile);
       DeleteFile(FileName);
       RenameFile(TempFile,FileName);
       Result:=True;
     except
       on E:EOleException do ShowMessage(E.Message);
     end
   finally
     db:=Unassigned;
   end;
end;

//�޸�Access���ݿ�     //���汾��û��ʹ�ñ�����
function DaoRepairDB(const FileName:string):Boolean;
var
  db:OleVariant;
begin
  Result:=False;
  try
    if not DaoActive(db) then Exit;
    try
     db.RepairDatabase(FileName);
     Result:=True;
    except
      on E:EOleException do ShowMessage(E.Message);
    end
  finally
    db:=Unassigned;
  end;   
end;

end.
 