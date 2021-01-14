unit Chain_Data;

interface

uses
  SysUtils, Classes, Provider, DB, ADODB,Registry,windows,forms;

type
  Tfrm_Chain_Data = class(TDataModule)
    ADO_Connection: TADOConnection;
    ADOConnMaster: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    //function CheckRecord(strSql: string):Boolean;  //����Ƿ��з��������ļ�¼
    //function GetFieldValue(strSql: string):Variant;  //����sql�����ֶ�ֵ��һ����
    //function IsModify(DeltaDS: TClientDataSet; strFieldName: string): boolean;
    //function GetCurValue(DeltaDS: TClientDataSet; strFieldName: string): Variant;
    //function GetValue(DeltaDS: TClientDataSet; strFieldName: string;
    //GetValueType: TGetValueType): string;
    //procedure SetJQJ(strHPID: string; SL, DJ: double; Kind: string);
    protected
    //class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    //procedure SetFilter(Filter: OleVariant); safecall;
  public
    { Public declarations }
  end;

var
  frm_Chain_Data: Tfrm_Chain_Data;

implementation

uses  func, Unitzc, Unitpubsub;

{$R *.dfm}

procedure Tfrm_Chain_Data.DataModuleCreate(Sender: TObject);
var
  reg:treginifile;
  fwqm,yhm,mm,sjkm,ms:string;
begin
  reg:=treginifile.Create;
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  fwqm:=reg.ReadString('\software\manager_sales','��������','');                                  //;User ID='+trim(yhm)+';password='+trim(mm)+'
  yhm:=reg.ReadString('\software\manager_sales','�û�����','');
  mm:=reg.ReadString('\software\manager_sales','�û�����','');
  sjkm:=reg.ReadString('\software\manager_sales','���ݿ�����','');
  ms:= reg.ReadString('\software\manager_sales','����ģʽ','');
  ADOconnmaster.DefaultDatabase:=sjkm;
  if trim(ms)='2' then
  begin
    ADOconnmaster.ConnectionString:='Provider=SQLOLEDB.1;Persist Security Info=False;User ID='+trim(yhm)+';password='+trim(mm)+';Initial Catalog='+trim(sjkm)+';Data Source='+trim(fwqm);
  end;
  if trim(ms)='1' then
  begin
    ADOconnmaster.ConnectionString:='Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog='+trim(sjkm)+';Data Source='+trim(fwqm);
  end;
  try
  ADOconnmaster.Connected:=true;
  SERVERNAME:=FWQM;
  except
    Application.MessageBox('���ݿ����Ӵ���,������ע��!','����',mb_iconwarning);
    Application.CreateForm(TFormzc, Formzc);
    formzc.ShowModal;
  end;
  reg.Free;
  reg:=treginifile.Create;
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  sjkm:=reg.ReadString('\software\manager_DB','���ݿ�����','');
  ms:= reg.ReadString('\software\manager_DB','����ģʽ','');
  ADO_Connection.DefaultDatabase:=sjkm;
  if trim(ms)='2' then
  begin
    ADO_Connection.ConnectionString:='Provider=SQLOLEDB.1;Persist Security Info=False;User ID='+trim(yhm)+';password='+trim(mm)+';Initial Catalog='+trim(sjkm)+';Data Source='+trim(fwqm);
  end;
  if trim(ms)='1' then
  begin
    ADO_Connection.ConnectionString:='Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog='+trim(sjkm)+';Data Source='+trim(fwqm);
  end;
  try
  ADO_Connection.Connected:=true;
  servername:=trim(fwqm);
  except
  end;
  reg.Free;
end;

end.
