unit Quality_Check;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, Buttons, XPMenu;

type
  Tfrm_Quality_Check = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Cmd_Cancel: TSpeedButton;
    Panel3: TPanel;
    Edit1: TLabeledEdit;
    GroupBox1: TGroupBox;
    SpeedButton5: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Edit4: TLabeledEdit;
    Edit_Storage_Name: TLabeledEdit;
    Edit6: TLabeledEdit;
    Edit7: TLabeledEdit;
    Edit8: TLabeledEdit;
    Edit9: TLabeledEdit;
    Edit10: TLabeledEdit;
    Edit2: TLabeledEdit;
    Edit3: TLabeledEdit;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel8: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Panel9: TPanel;
    Panel10: TPanel;
    Cmd_Delete: TSpeedButton;
    Cmd_Add: TSpeedButton;
    Edit11: TLabeledEdit;
    Cmd_LHDJ: TSpeedButton;
    Edit5: TLabeledEdit;
    StringGrid1: TStringGrid;
    Label1: TLabel;
    procedure Cmd_CancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Cmd_AddClick(Sender: TObject);
    procedure Cmd_DeleteClick(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure Edit1DblClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit8KeyPress(Sender: TObject; var Key: Char);
    procedure Edit8DblClick(Sender: TObject);
    procedure Cmd_LHDJClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
    iColcount,Total_Count:integer;
    ss,tempstr:string;
    pcol,prow:integer;
    PROCEDURE INIT;
  public
    { Public declarations }
  end;

var
  frm_Quality_Check: Tfrm_Quality_Check;
implementation

uses Data, func,  Public_Don, Stock_Write_Check, Supply_Monad,
  Storage_Select, Login_Man, ChildShop_Select, untdatadm, UntgoodCodeSelStr,
  Unt_PubStrGrid, Unitreportxf;

{$R *.dfm}
PROCEDURE TFRM_QUALITY_CHECK.INIT;
var
  temp,make:string;
BEGIN
  InitialStrGrid(stringgrid1,'��������');
  stringgrid1.ColCount:=stringgrid1.ColCount+1; //��Ԥ����Ʒʱ��¼Ԥ������ţ�
  stringgrid1.ColWidths[stringgrid1.ColCount-1]:=-1;
  Edit1.Text:=formatdateTime('yyyy''-''mm''-''dd',date);
  Edit8.Text:=Handle_Man;
  temp:='select max(right(stock_no,4)) from Quality_Check where copy_date='+''''+formatdatetime('yyyy''-''mm''-''dd',date)+'''';
  make:='ZLYS-'+trim(Handle_Part)+trim(handle_no); //�ò��ű��
  edit2.Text:=setcode(temp,make);
END;
procedure Tfrm_Quality_Check.Cmd_CancelClick(Sender: TObject);
var
    i,j,icol:integer;
    Check_Flag:string;
    sqlsub:widestring;
begin
    frm_Public_Don:=Tfrm_Public_Don.Create(self);
    frm_Public_Don.no:=trim(edit2.Text);
    frm_Public_Don.ShowModal;
    //����ݸ�
    if Public_Do='Stock_0007' then
    begin
        if Public_Do_Result='01' then
        begin
            with frm_data.ClientDataSet2 do
            begin
//                Close;
//                CommandText:='';
//                Commandtext:='Select * from [V_Stock_Quality_View] where Receipt_No='''+Trim(Edit2.Text)+'''';
                sqlsub:='Select * from [V_Stock_Quality_View] where Receipt_No='''+Trim(Edit2.Text)+'''';
                dmmain.CDSexecsql.Close;
                dmmain.CDSexecsql.Data:=ADISP.execSql(sqlsub);
                dmmain.CDSexecsql.Open;
                Check_Flag:=dmmain.CDSexecsql.FieldValues['Check_Result'];
                if Check_Flag='0' then
                begin
                    Application.MessageBox('���ݻ�û����ȫ��ˣ����ܹ���',pchar(application.Title),mb_iconwarning);
                    Exit;
                end;
                if Check_Flag='1' then
                begin                                     
                    try
                        with frm_data.ClientDataSet_Add do
                        begin
//                            Close;
//                            Commandtext:='';
//                            Commandtext:='Update [Quality_Check] set Gather_Name='''+Trim(Edit4.Text)+''',Storage_NO='''+Trim(Edit5.Text)+''',Transactor='''+Trim(Edit6.Text)+''',Shop_NO='''+Trim(Edit7.Text)+''',Proposer='''+Trim(Edit8.Text)+''',Condense='''+Trim(Edit9.Text)+''',Quality_Remark='''+Trim(Edit10.Text)+''',Contract_No='''+Trim(Edit11.Text)+''' where Stock_No='''+Trim(Edit2.Text)+'''';
                            sqlsub:='select * from [Quality_Check] where Stock_No='''+Trim(Edit2.Text)+'''';
                            dmmain.CDSexecsql.Close;
                            dmmain.CDSexecsql.Data:=frm_data.Socket_Connection.AppServer.execSql(sqlsub);
                            dmmain.CDSexecsql.Open;
                            for i:=1 to dmmain.CDSexecsql.RecordCount do
                            begin
                                dmmain.CDSexecsql.Edit;
                                dmmain.CDSexecsql.FieldByName('wldw').AsString:=Trim(Edit4.Text);
                                dmmain.CDSexecsql.FieldByName('wldw_no').AsString:=Trim(wldwno);//////
                                dmmain.CDSexecsql.FieldByName('Storage_NO').AsString:=Trim(Edit5.Text);
                                dmmain.CDSexecsql.FieldByName('Transactor').AsString:=Trim(Edit6.Text);
                                dmmain.CDSexecsql.FieldByName('Shop_NO').AsString:=Trim(Edit7.Text);
                                dmmain.CDSexecsql.FieldByName('Proposer').AsString:=Trim(Edit8.Text);
                                dmmain.CDSexecsql.FieldByName('Condense').AsString:=Trim(Edit9.Text);
                                dmmain.CDSexecsql.FieldByName('Quality_Remark').AsString:=Trim(Edit10.Text);
                                dmmain.CDSexecsql.FieldByName('Contract_No').AsString:=Trim(Edit11.Text);
                                dmmain.CDSexecsql.Post;
                                dmmain.CDSexecsql.Next;
                            end;
                            try
                                dmmain.CDSexecsql.ApplyUpdates(-1);
                            except
                                Application.MessageBox('����[�������յ�]ʱ���ӷ��������ݿ�ʧ��,�������������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                                Exit;
                            end;
                            for i:=1 to stringgrid1.RowCount-1 do
                            begin
                                with frm_data.ClientDataSet_Add do
                                begin
                                    Close;
                                    CommandText:='';
                                    CommandText:='update [Quality_Check_detail] set Total_Amount='''+Trim(StringGrid1.Cells[3,i])+''',Regular_Amount='''+Trim(StringGrid1.Cells[4,i])+''',Un_Regular_Amount='''+Trim(StringGrid1.Cells[5,i])+''',Check_Remark='''+Trim(StringGrid1.Cells[6,i])+''' where Stock_NO='''+Trim(Edit2.Text)+''' and Goods_NO='''+Trim(StringGrid1.Cells[1,i])+'''';
                                    try
                                        Execute;
                                    except
                                        Application.MessageBox('����[�������յ���ϸ]ʱ���ӷ��������ݿ�ʧ��,�������������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                                        Exit;
                                    end;
                                end;
                            end;
                            with frm_data.ClientDataSet_Add do
                            begin
                                sqlsub:='select * from [Receipt] where Receipt_No='''+Trim(Edit2.Text)+'''';
                                dmmain.CDSexecsql.Close;
                                dmmain.CDSexecsql.Data:=frm_data.Socket_Connection.AppServer.execSql(sqlsub);
                                dmmain.CDSexecsql.Open;
                                for i:=1 to dmmain.CDSexecsql.RecordCount do
                                begin
                                    dmmain.CDSexecsql.Edit;
                                    dmmain.CDSexecsql.FieldByName('Flag_sign').AsString:='����';
                                    dmmain.CDSexecsql.Post;
                                    dmmain.CDSexecsql.Next;
                                end;
                                try
                                    dmmain.CDSexecsql.ApplyUpdates(-1);
                                except
                                    Application.MessageBox('����[�������յ���˱�]ʱ���ӷ��������ݿ�ʧ��,�������������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                                    Exit;
                                end;
                            end;
                            Application.MessageBox('[�������յ�]���ݹ�����ϣ�,��ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                        end;
                    except
                        Application.MessageBox('����[�������յ�]ʱʧ��,�������������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                        Exit;
                    end;
                end;
            end;
        end;
        //����Ϊ�ݸ�
        if Public_Do_Result='02' then
        begin
            try
                if Trim(Edit1.Text)='' then
                begin
                    Application.MessageBox('��������,��¼�����ڡ�����Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                    Edit1.SetFocus;
                    Exit;
                end;
                if Trim(Edit2.Text)='' then
                begin
                    Application.MessageBox('��������,�����ݱ�š�����Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                    Edit2.SetFocus;
                    Exit;
                end;
                if Trim(Edit3.Text)='' then
                begin
                    Application.MessageBox('��������,�������ǼǺš�����Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                    Edit3.SetFocus;
                    Exit;
                end;
                if Trim(Edit4.Text)='' then
                begin
                    Application.MessageBox('��������,��������λ������Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                    Edit4.SetFocus;
                    Exit;
                end;
                if Trim(Edit5.Text)='' then
                begin
                    Application.MessageBox('��������,������ֿ⡿����Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                    Edit5.SetFocus;
                    Exit;
                end;
                if Trim(Edit6.Text)='' then
                begin
                    Application.MessageBox('��������,�������ˡ�����Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                    Edit6.SetFocus;
                    Exit;
                end;
                if Trim(Edit8.Text)='' then
                begin
                    Application.MessageBox('��������,���Ƶ��ˡ�����Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                    Edit8.SetFocus;
                    Exit;
                end;
                for i:=1 to StringGrid1.RowCount-1 do
                begin
                    if StringGrid1.Cells[1,i]='' then
                    begin
                        Application.MessageBox('��������,����Ʒ��š�����Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                        Exit;
                    end;
                    if StringGrid1.Cells[3,i]='' then
                    begin
                        Application.MessageBox('��������,���ܼ�����������Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                        Exit;
                    end;
                    if StringGrid1.Cells[4,i]='' then
                    begin
                        Application.MessageBox('��������,���ϸ�����������Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                        Exit;
                    end;
                    if StringGrid1.Cells[5,i]='' then
                    begin
                        Application.MessageBox('��������,�����ϸ�����������Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                        Exit;
                    end;
                end;
                try
                  sqlsub:='SELECT * FROM [Quality_Check] where Copy_Date='+''''+Trim(Edit1.Text)+''''+' and Stock_NO='+''''+Trim(Edit2.Text)+'''';
                  dmmain.CDSquery.Close;
                  dmmain.CDSquery.Data:=adisp.GetRecord(sqlsub);
                  dmmain.CDSquery.Open;
                  //Open;
                  if dmmain.CDSquery.RecordCount>0 then
                  begin
                      Application.MessageBox('�á��������ա������Ѿ������ˣ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                      Exit;
                  end ;
                  dmmain.cdsQuality_Check.Close;
                  dmmain.cdsQuality_Check.Open;
                  dmmain.cdsQuality_Check.Append;
                  dmmain.cdsQuality_Check.FieldByName('Copy_Date').AsString:=Trim(Edit1.Text);
                  dmmain.cdsQuality_Check.FieldByName('Stock_NO').AsString:=Trim(Edit2.Text);
                  dmmain.cdsQuality_Check.FieldByName('Stock_Write_NO').AsString:=Trim(Edit3.Text);
                  dmmain.cdsQuality_Check.FieldByName('wldw').AsString:=Trim(Edit4.Text);
                  dmmain.cdsQuality_Check.FieldByName('wldw_no').AsString:=Trim(wldwno);////////////////
                  dmmain.cdsQuality_Check.FieldByName('Storage_NO').AsString:=Trim(Edit5.Text);
                  dmmain.cdsQuality_Check.FieldByName('Transactor').AsString:=Trim(Edit6.Text);
                  dmmain.cdsQuality_Check.FieldByName('Shop_NO').AsString:=Trim(Edit7.Text);
                  dmmain.cdsQuality_Check.FieldByName('Proposer').AsString:=Trim(Edit8.Text);
                  dmmain.cdsQuality_Check.FieldByName('Condense').AsString:=Trim(Edit9.Text);
                  dmmain.cdsQuality_Check.FieldByName('Quality_Remark').AsString:=Trim(Edit10.Text);
                  dmmain.cdsQuality_Check.FieldByName('Contract_NO').AsString:=Trim(Edit11.Text);
                  dmmain.cdsQuality_Check.Post;
                  dmmain.cdsReceipt.Close;
                  dmmain.cdsReceipt.Open;
                  dmmain.cdsReceipt.Append;
                  dmmain.cdsReceipt.FieldByName('Receipt_NO').AsString:=Trim(Edit2.Text);
                  dmmain.cdsReceipt.FieldByName('Receipt_Name').AsString:='�������յ�';
                  dmmain.cdsReceipt.FieldByName('Copy_Date').AsString:=Trim(Edit1.Text);
                  dmmain.cdsReceipt.FieldByName('Proposer').AsString:=Trim(Edit8.Text);
                  dmmain.cdsReceipt.FieldByName('Condense').AsString:=Trim(Edit9.Text);
                  dmmain.cdsReceipt.FieldByName('Check_Result').Asinteger:=0;
                  dmmain.cdsReceipt.FieldByName('Flag_Sign').AsString:='�ݸ�';
                  dmmain.cdsReceipt.FieldByName('Re_part').AsString:=trim(Handle_Part);
                  dmmain.cdsReceipt.Post;
                  dmmain.cdsQuality_Check_detail.Close;
                  dmmain.cdsQuality_Check_detail.Open;
                  for i:=1 to stringgrid1.RowCount-1 do
                  begin
                    dmmain.cdsQuality_Check_detail.Append;
                    dmmain.cdsQuality_Check_detail.FieldByName('Stock_NO').AsString:=Trim(Edit2.Text);
                    dmmain.cdsQuality_Check_detail.FieldByName('Goods_NO').AsString:=Trim(StringGrid1.Cells[1,i]);
                    dmmain.cdsQuality_Check_detail.FieldByName('Total_Amount').AsString:=Trim(StringGrid1.Cells[3,i]);
                    dmmain.cdsQuality_Check_detail.FieldByName('Regular_Amount').AsString:=Trim(StringGrid1.Cells[4,i]);
                    dmmain.cdsQuality_Check_detail.FieldByName('Un_Regular_Amount').AsString:=Trim(StringGrid1.Cells[5,i]);
                    dmmain.cdsQuality_Check_detail.FieldByName('Check_Remark').AsString:=Trim(StringGrid1.Cells[6,i]);
                    dmmain.cdsQuality_Check_detail.FieldByName('orders').AsString:=Trim(StringGrid1.Cells[StringGrid1.ColCount-1,i]);
                    dmmain.cdsQuality_Check_detail.FieldByName('GoodsMemo').AsString:=Trim(StringGrid1.Cells[StringGrid1.ColCount-2,i]);
                    dmmain.cdsQuality_Check_detail.Post;
                  end;
                  try
                     dmmain.cdsReceipt.ApplyUpdates(-1);
                     dmmain.cdsQuality_Check.ApplyUpdates(-1);
                     dmmain.cdsQuality_Check_detail.ApplyUpdates(-1);
                     if trim(edit3.Text)<>'' then
                      setpass(edit3.Text);
                     setnull(frm_Quality_Check);
                     init;
                  except
                      Application.MessageBox('�������������ϣ�',pchar(application.Title),mb_iconwarning);
                      Exit;
                  end;
                except
                    Application.MessageBox('��������ʱʧ��,�������������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                    Exit;
                end;
            except
                Application.MessageBox('�Ƿ�����������ϵͳ������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                Exit;
            end;
        end;
        //�����˳�
        if Public_Do_Result='03' then
        begin
            Close;
        end;
    end;
    //�ݸ����
    if Public_Do='Business_Draft_0006' then
    begin
        //����Ϊ����
        if Public_Do_Result='01' then
        begin
            with frm_data.ClientDataSet2 do
            begin
//                Close;
//                CommandText:='';
//                Commandtext:='Select * from [V_Stock_Quality_View] where Receipt_No='''+Trim(Edit2.Text)+'''';
                sqlsub:='Select * from [V_Stock_Quality_View] where Receipt_No='''+Trim(Edit2.Text)+'''';
                dmmain.CDSexecsql.Close;
                dmmain.CDSexecsql.Data:=adisp.execSql(sqlsub);
                dmmain.CDSexecsql.Open;
                Check_Flag:=dmmain.CDSexecsql.FieldValues['Check_Result'];
                if Check_Flag='0' then
                begin
                    Application.MessageBox('���ݻ�û����ȫ��ˣ����ܹ���',pchar(application.Title),mb_iconwarning);
                    Exit;
                end;
                if Check_Flag='1' then
                begin
                    try
                        with frm_data.ClientDataSet_Add do
                        begin
//                            Close;
//                            Commandtext:='';
//                            Commandtext:='Update [Quality_Check] set Gather_Name='''+Trim(Edit4.Text)+''',Storage_NO='''+Trim(Edit5.Text)+''',Transactor='''+Trim(Edit6.Text)+''',Shop_NO='''+Trim(Edit7.Text)+''',Proposer='''+Trim(Edit8.Text)+''',Condense='''+Trim(Edit9.Text)+''',Quality_Remark='''+Trim(Edit10.Text)+''',Contract_No='''+Trim(Edit11.Text)+''' where Stock_No='''+Trim(List_NO)+'''';
                            sqlsub:='select * from [Quality_Check] where Stock_No='''+Trim(List_NO)+'''';
                            dmmain.CDSexecsql.Close;
                            dmmain.CDSexecsql.Data:=frm_data.Socket_Connection.AppServer.execSql(sqlsub);
                            dmmain.CDSexecsql.Open;
                            for i:=1 to dmmain.CDSexecsql.RecordCount do
                            begin
                                dmmain.CDSexecsql.Edit;
                                dmmain.CDSexecsql.FieldByName('wldw').AsString:=Trim(Edit4.Text);
                                dmmain.CDSexecsql.FieldByName('Storage_NO').AsString:=Trim(Edit5.Text);
                                dmmain.CDSexecsql.FieldByName('Transactor').AsString:=Trim(Edit6.Text);
                                dmmain.CDSexecsql.FieldByName('Shop_NO').AsString:=Trim(Edit7.Text);
                                dmmain.CDSexecsql.FieldByName('Proposer').AsString:=Trim(Edit8.Text);
                                dmmain.CDSexecsql.FieldByName('Condense').AsString:=Trim(Edit9.Text);
                                dmmain.CDSexecsql.FieldByName('Quality_Remark').AsString:=Trim(Edit10.Text);
                                dmmain.CDSexecsql.FieldByName('Contract_No').AsString:=Trim(Edit11.Text);
                                dmmain.CDSexecsql.Post;
                                dmmain.CDSexecsql.Next;
                            end;
                            try
                                dmmain.CDSexecsql.ApplyUpdates(-1);
                            except
                                Application.MessageBox('����[�������յ�]ʱ���ӷ��������ݿ�ʧ��,�������������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                                Exit;
                            end;
                            try
                                for i:=1 to Total_Count do
                                begin
                                    with frm_data.ClientDataSet_Add do
                                    begin
                                        Close;
                                        CommandText:='';
                                        CommandText:='update [Quality_Check_detail] set Total_Amount='''+Trim(StringGrid1.Cells[3,i])+''',Regular_Amount='''+Trim(StringGrid1.Cells[4,i])+''',Un_Regular_Amount='''+Trim(StringGrid1.Cells[5,i])+''',Check_Remark='''+Trim(StringGrid1.Cells[6,i])+''' where Stock_NO='''+Trim(edit2.text)+''' and Goods_NO='''+Trim(StringGrid1.Cells[1,i])+'''';
                                        try
                                            Execute;
                                        except
                                            Application.MessageBox('����[����������ϸ��]ʱ���ӷ��������ݿ�ʧ��,�������������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                                            Exit;
                                        end;
                                    end;
                                end;
                                with frm_data.ClientDataSet_Add do
                                begin
//                                    Close;
//                                    Commandtext:='';
//                                    Commandtext:='Update [Receipt] set Flag_sign=''����'' where Receipt_No='''+Trim(List_NO)+'''';
                                    sqlsub:='select * from [Receipt] where Receipt_No='''+Trim(List_NO)+'''';
                                    dmmain.CDSexecsql.Close;
                                    dmmain.CDSexecsql.Data:=frm_data.Socket_Connection.AppServer.execSql(sqlsub);
                                    dmmain.CDSexecsql.Open;
                                    for i:=1 to dmmain.CDSexecsql.RecordCount do
                                    begin
                                        dmmain.CDSexecsql.Edit;
                                        dmmain.CDSexecsql.FieldByName('Flag_sign').AsString:='����';
                                        dmmain.CDSexecsql.Post;
                                        dmmain.CDSexecsql.Next;
                                    end;
                                    try
                                        dmmain.CDSexecsql.ApplyUpdates(-1);
                                        Application.MessageBox('���ݹ�����ϣ�',pchar(application.Title),mb_iconwarning);
                                    except
                                        Application.MessageBox('���ݹ���ʱ����[����������˱�]ʱ���ӷ��������ݿ�ʧ��,�������������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                                        Exit;
                                    end;
                                end;
                            except
                                Application.MessageBox('����[����������ϸ��]ʱѭ��ʧ��,�������������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                                Exit;
                            end;
                        end;
                    except
                        Application.MessageBox('ϵͳ����,�������������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                        Exit;
                    end;
                end;
            end;
        end;
        //�޸Ĳݸ嵥��
        if Public_Do_Result='02' then
        begin
            try
                with frm_data.ClientDataSet_Add do
                begin
                  if not bedit then
                  begin
                    if trim(Handle_Man)<>trim(edit8.Text) then
                    begin
                      Application.MessageBox('�����޸����ݣ�',pchar(application.Title),mb_iconinformation);
                      exit;
                    end;
                  end;
                    sqlsub:='select * from [Quality_Check] where Stock_No='''+Trim(List_NO)+'''';
                    dmmain.CDSexecsql.Close;
                    dmmain.CDSexecsql.Data:=frm_data.Socket_Connection.AppServer.execSql(sqlsub);
                    dmmain.CDSexecsql.Open;
                    for i:=1 to dmmain.CDSexecsql.RecordCount do
                    begin
                        dmmain.CDSexecsql.Edit;
                        dmmain.CDSexecsql.FieldByName('wldw').AsString:=Trim(Edit4.Text);
                        dmmain.CDSexecsql.FieldByName('wldw_no').AsString:=Trim(wldwno);
                        dmmain.CDSexecsql.FieldByName('Storage_NO').AsString:=Trim(Edit5.Text);
                        dmmain.CDSexecsql.FieldByName('Transactor').AsString:=Trim(Edit6.Text);
                        dmmain.CDSexecsql.FieldByName('Shop_NO').AsString:=Trim(Edit7.Text);
                        dmmain.CDSexecsql.FieldByName('Proposer').AsString:=Trim(Edit8.Text);
                        dmmain.CDSexecsql.FieldByName('Condense').AsString:=Trim(Edit9.Text);
                        dmmain.CDSexecsql.FieldByName('Quality_Remark').AsString:=Trim(Edit10.Text);
                        dmmain.CDSexecsql.FieldByName('Contract_No').AsString:=Trim(Edit11.Text);
                        dmmain.CDSexecsql.Post;
                        dmmain.CDSexecsql.Next;
                    end;
                    try
                        dmmain.CDSexecsql.ApplyUpdates(-1);
                    except
                        Application.MessageBox('����[�������յ�]ʱ�����������ݿ�ʧ��,�������������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                        Exit;
                    end;
                    try
                        for i:=1 to stringgrid1.RowCount-1 do
                        begin
                            with frm_data.ClientDataSet_Add do
                            begin
                                Close;
                                frm_data.ClientDataSet_Add.CommandText:='';
                                CommandText:='update [Quality_Check_detail] set Total_Amount='''+Trim(StringGrid1.Cells[3,i])+''',Regular_Amount='''+Trim(StringGrid1.Cells[4,i])+''',Un_Regular_Amount='''+Trim(StringGrid1.Cells[5,i])+''',Check_Remark='''+Trim(StringGrid1.Cells[6,i])+''' where Stock_NO='''+Trim(List_NO)+''' and Goods_NO='''+Trim(StringGrid1.Cells[1,i])+'''';
                                try
                                    Execute;
                                except
                                    Application.MessageBox('����[����������ϸ]ʱ�����������ݿ�ʧ��,�������������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                                    Exit;
                                end;
                            end;
                        end;
                        Application.MessageBox('���ݱ���Ϊ�ݸ���ϣ�',pchar(application.Title),mb_iconwarning);
                    except
                        Application.MessageBox('����[����������ϸ]ʱѭ��ʧ��,�������������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                        Exit;
                    end;
                end;
            except
                Application.MessageBox('���浥����ϸʱʧ��,�������������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                Exit;
            end;
        end;
        if Public_Do_Result='03' then
        begin
            frm_data.ClientDataSet_Add.Active:=False;
            frm_data.ClientDataSet_Add.Close;
            frm_data.ClientDataSet2.Active:=False;
            frm_data.ClientDataSet2.Close;
            Close;
        end;
    end;
    frm_Public_Don.Free;
end;

procedure Tfrm_Quality_Check.FormShow(Sender: TObject);
var
    i,icount,k:integer;
    tt,yy,temppos:integer;
    FWidth:integer;
    sqlsub:widestring;
begin
    StringGrid1.RowCount:=2;//��ʼ����
    iColcount:=StringGrid1.ColCount-1; //��Ҫ��������ݵ������������
    Total_Count:=StringGrid1.RowCount;
    INIT;
    //�����к�
    for i:=1 to StringGrid1.RowCount-1 do
    begin
        StringGrid1.Cells[0,i]:=IntTostr(i); //��ʾ��0�е�i��
    end;
    if (Public_Do='Business_Draft_0006') then
    begin
            sqlsub:='Select * from Quality_Check AS A,Quality_Check_detail as b,goods_code as c where a.stock_no=b.stock_no and b.goods_no=c.goods_no AND a.STOCK_No='''+List_No+'''';
            dmmain.CDSexecsql.Close;
            dmmain.CDSexecsql.Data:=frm_data.Socket_Connection.AppServer.execSql(sqlsub);
            dmmain.CDSexecsql.Open;
            StringGrid1.RowCount:=dmmain.CDSexecsql.RecordCount+1;
            //�Զ�����STRINGGRID������
            for K:=1 to dmmain.CDSexecsql.RecordCount+1 do
            begin
                StringGrid1.Cells[0,K]:=IntTostr(k); //��ʾ��0�е�i�е�����
            end;
            //******************
            Edit1.Text:=dmmain.CDSexecsql.FieldByName('Copy_Date').AsString;
            Edit2.Text:=dmmain.CDSexecsql.FieldByName('stock_No').AsString;
            //Edit3.Text:=dmmain.CDSexecsql.FieldByName('Stock_Write_NO').AsString;
            Edit4.Text:=dmmain.CDSexecsql.FieldByName('WLDW').AsString;
            Edit5.Text:=dmmain.CDSexecsql.FieldByName('Storage_No').AsString;
            Edit6.Text:=dmmain.CDSexecsql.FieldByName('Transactor').AsString;
            Edit7.Text:=dmmain.CDSexecsql.FieldByName('Shop_NO').AsString;
            Edit8.Text:=dmmain.CDSexecsql.FieldByName('proposer').AsString;
            Edit9.Text:=dmmain.CDSexecsql.FieldByName('Condense').AsString;
            Edit10.Text:=dmmain.CDSexecsql.FieldByName('Quality_Remark').AsString;
            Edit11.Text:=dmmain.CDSexecsql.FieldByName('stock_write_NO').AsString;
            wldwno:=dmmain.CDSexecsql.FieldByName('WLDW_no').AsString;
            dmmain.CDSexecsql.First;
            for k:=1 to dmmain.CDSexecsql.RecordCount do
            begin
              StringGrid1.Cells[1,k]:=trim(dmmain.CDSexecsql.FieldByName('Goods_NO').AsString);//��Ʒ���
              StringGrid1.Cells[2,k]:=trim(dmmain.CDSexecsql.FieldByName('Goods_Name').AsString);//��Ʒ����
              StringGrid1.Cells[3,k]:=trim(dmmain.CDSexecsql.FieldByName('Total_Amount').AsString);//��Ʒ���
              StringGrid1.Cells[4,k]:=trim(dmmain.CDSexecsql.FieldByName('Regular_Amount').AsString);//��Ʒ����
              StringGrid1.Cells[5,k]:=trim(dmmain.CDSexecsql.FieldByName('Un_Regular_Amount').AsString);//����
              StringGrid1.Cells[7,k]:=trim(dmmain.CDSexecsql.FieldByName('type').AsString);//����
              StringGrid1.Cells[6,k]:=trim(dmmain.CDSexecsql.FieldByName('Check_Remark').AsString); //�������
              StringGrid1.Cells[StringGrid1.ColCount-1,k]:=trim(dmmain.CDSexecsql.FieldByName('ORDERS').AsString); //�������
              StringGrid1.Cells[StringGrid1.ColCount-2,k]:=trim(dmmain.CDSexecsql.FieldByName('GoodsMemo').AsString); //�������
              dmmain.CDSexecsql.Next;
            end;
            GetDataPrint(dmmain.cdsprintmaster,dmmain.CDsexecsql);
        end;
end;

procedure Tfrm_Quality_Check.Cmd_AddClick(Sender: TObject);
var
    i:integer;
begin
    StringGrid1.RowCount:=StringGrid1.RowCount+1;
    Total_Count:=StringGrid1.RowCount;
    for i:=1 to StringGrid1.RowCount-1 do
    begin
        StringGrid1.Cells[0,i]:=IntTostr(i); //��ʾ��0�е�i��
    end;
end;

procedure Tfrm_Quality_Check.Cmd_DeleteClick(Sender: TObject);
var
    i:integer;
begin
    if StringGrid1.RowCount=2 then
    begin
        Exit;
    end;
    StringGrid1.RowCount:=StringGrid1.RowCount-1;
    Total_Count:=StringGrid1.RowCount;//��ʾ����
    for i:=1 to StringGrid1.RowCount-1 do
    begin
        StringGrid1.Cells[0,i]:=IntTostr(i); //��ʾ��0�е�i��
    end;
end;

procedure Tfrm_Quality_Check.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  s:string;
  r:TRect;
begin
//ydy add ������ʾ��ɫ
 with Sender as Tstringgrid do
        begin
        if gdSelected in State then
        Canvas.Brush.Color:= clTeal;  //clBlue; //clyellow;//clRed;
        Canvas.TextRect(Rect,Rect.Left,Rect.Top,' '+Cells[ACol,ARow]);
        if gdFocused in State then
        Canvas.DrawFocusRect(Rect);
        end;

//����ˮƽ���У�����ֱ����
with Sender as Tstringgrid do
    begin
      Canvas.FillRect(Rect);
      s:=Cells[ACol,ARow];
      r:=Rect;
      DrawText(Canvas.Handle,PChar(s),Length(s),r,DT_CENTER or DT_SINGLELINE or DT_VCENTER);
    end;
    with sender as TStringGrid do
    begin
        if (GDFocused in state) then
        begin
            Pcol:=Acol;
            Prow:=ARow;
            func.String_Col:=ARow;
        end;
    end;
end;

procedure Tfrm_Quality_Check.StringGrid1DblClick(Sender: TObject);
var
    openstr:string;
    S1,s2,s3:string;
    sqlsub:widestring;
  I:INTEGER;
begin
  if pcol = 4 then  //��������
  begin
   for i := prow+1 to STRINGGRID1.rowcount -1 do
   begin
   STRINGGRID1.cells[4,i]:= STRINGGRID1.cells[4,prow];
   STRINGGRID1.cells[5,i]:=INTTOSTR(STRTOINT(STRINGGRID1.cells[3,i])-STRTOINT(STRINGGRID1.cells[4,i]));
   //ͬʱҪ������
   END;
  END;
end;


procedure Tfrm_Quality_Check.Edit1DblClick(Sender: TObject);
begin
    Edit1.Text:=ForMatDateTime('yyyy''-''mm''-''dd',now);
end;

procedure Tfrm_Quality_Check.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
    if Key=#13 then
        Edit1.Text:=ForMatDateTime('yyyy''-''mm''-''dd',now);
end;

procedure Tfrm_Quality_Check.Edit8KeyPress(Sender: TObject; var Key: Char);
begin
    if Key=#13 then
        Edit8.Text:=Handle_Man;
end;

procedure Tfrm_Quality_Check.Edit8DblClick(Sender: TObject);
begin
    Edit8.Text:=Handle_Man;
end;
procedure Tfrm_Quality_Check.Cmd_LHDJClick(Sender: TObject);
var
    sqlsub:widestring;
    i:integer;
begin
    LHXZ_Str:='';
    LHXZ_Str:='Quality_Check_001';
    LHXZ_Str_List_NO:='';
    LHXZ_Str_Result:='';
    frm_Stock_Write_Check:=Tfrm_Stock_Write_Check.Create(self);
    frm_Stock_Write_Check.ShowModal;
    frm_Stock_Write_Check.Free;
    edit3.Text:=LHXZ_Str_List_NO;
    if stringgrid1.RowCount<2 then
    begin
      stringgrid1.RowCount:=2;
      stringgrid1.FixedRows:=1;
    end;  
end;

procedure Tfrm_Quality_Check.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DMMAIN.CDSquery2.Close;
  dmmain.CDSquery2.Data:=null;
  DMMAIN.CDSexecsql.Close;
  dmmain.CDSexecsql.Data:=null;
  dmmain.cdsprintmaster.Close;
  dmmain.cdsprintmaster.Data:=null;
  dmmain.cdsQuality_Check.Close;
  dmmain.cdsQuality_Check.Data:=null;
  dmmain.cdsQuality_Check_detail.Close;
  dmmain.cdsQuality_Check_detail.Data:=null;
  Action:=cafree;
end;

procedure Tfrm_Quality_Check.SpeedButton5Click(Sender: TObject);
begin
    Check_Storage:='';Check_Storage_Result:='';
    Check_Storage:='Quality_Checkstr';
    frm_Storage_Select:=Tfrm_Storage_Select.Create(self);
    frm_Storage_Select.ShowModal;
    Edit5.Text:=Trim(Check_Storage_Result_NO);
    Edit_Storage_Name.Text:=Trim(Check_Storage_Result);
    frm_Storage_Select.Free;
end;

procedure Tfrm_Quality_Check.SpeedButton9Click(Sender: TObject);
begin
    Employe_Check:='';
    Employe_Check:='Quality_Checkstr';
    Employe_Check_Result:='';
    frm_Login_Man:=Tfrm_Login_Man.Create(self);
    frm_Login_Man.Caption:='������ѡ��';
    frm_Login_Man.ShowModal;
    Edit6.Text:=Employe_Check_Result;
    frm_Login_Man.Free;
end;

procedure Tfrm_Quality_Check.SpeedButton8Click(Sender: TObject);
begin
    ChildShop_Str:='';
    ChildShop_Result_NO:='';
    ChildShop_Result_Name:='';
    ChildShop_Str:='Quality_Check_str';
    frm_ChildShop_Select:=Tfrm_ChildShop_Select.Create(self);
    frm_ChildShop_Select.ShowModal;
    Edit7.Text:=ChildShop_Result_NO;
    frm_ChildShop_Select.Free;
end;

procedure Tfrm_Quality_Check.SpeedButton7Click(Sender: TObject);
begin
    frm_Login_Man:=Tfrm_Login_Man.Create(self);
    frm_Login_Man.Caption:='�Ƶ���ѡ��';
    frm_Login_Man.ShowModal;
    Edit8.Text:=Employe_Check_Result;
    frm_Login_Man.Free;
end;

procedure Tfrm_Quality_Check.SpeedButton2Click(Sender: TObject);
var
  user,tablename:widestring;
  flag:olevariant;
begin
  if trim(stringgrid1.Cells[1,1])='' then exit;
  no:=trim(edit2.Text);
  typed:='�������յ�';
  user:=trim(Handle_No);
  flag:=adisp.receipted(no,typed,user,1,Handle_Part);
  tablename:='select a.storage_no,b.goods_no,b.stock_no,b.Regular_Amount as amount from Quality_Check as a ,Quality_Check_detail as b where a.stock_no=b.stock_no and a.stock_no='+''''+trim(No)+'''';
  flag:=inttostr(adisp.UpdateOrder(tablename));
  if flag='1' then
  begin
    application.MessageBox('��˳ɹ���',pchar(application.Title),mb_iconinformation);
    close;
    exit;
  end;
  if flag='2' then
  begin
    application.MessageBox('��Ȩ���н������',pchar(application.Title),mb_iconinformation);
    close;
    exit;
  end;
  if flag='3' then
  begin
    application.MessageBox('�����ϣ�',pchar(application.Title),mb_iconinformation);
    close;
    exit;
  end;
  if flag='4' then
  begin
    application.MessageBox('�������ϣ�',pchar(application.Title),mb_iconinformation);
    exit;
  end;
  if flag='5' then
  begin
    application.MessageBox('����˳ɹ���',pchar(application.Title),mb_iconinformation);
    exit;
  end;
  if flag='6' then
  begin
    application.MessageBox('���ݹ��ʺ󣬲��ܽ�����˻���ˣ�',pchar(application.Title),mb_iconinformation);
    exit;
  end;
end;

procedure Tfrm_Quality_Check.Edit3Change(Sender: TObject);
  var
  sql:widestring;
  i:integer;
begin
  if Public_Do='Business_Draft_0006' then exit;
  if trim(edit3.Text)<>'' then
  begin
    sql:='SELECT a.*,b.*,c.* FROM [Stock_Write_detail] as a,Goods_CODE as b,Stock_Write as c where a.goods_no=b.goods_no and a.stock_no=c.stock_no and a.stock_no='+''''+trim(edit3.Text)+'''';
    dmmain.CDSquery2.Close;
    dmmain.CDSquery2.Data:=adisp.resultrecord(sql);
    dmmain.CDSquery2.Open;
    edit4.Text:= dmmain.CDSquery2.fieldbyname('wldw').AsString;
    edit5.Text:= dmmain.CDSquery2.fieldbyname('storage_no').AsString;
    edit7.Text:= dmmain.CDSquery2.fieldbyname('shop_no').AsString;
    edit9.Text:= dmmain.CDSquery2.fieldbyname('condense').AsString;
    edit10.Text:= dmmain.CDSquery2.fieldbyname('remark').AsString;
    wldwno:=dmmain.CDSquery2.FieldByName('wldw_no').AsString;
    i:=1;
    StringGrid1.RowCount:=dmmain.CDSquery2.RecordCount+1;
    while not dmmain.CDSquery2.Eof do
    begin
      StringGrid1.Cells[0,i]:=inttostr(i);
      StringGrid1.Cells[1,i]:=trim(dmmain.CDSquery2.FieldByName('Goods_NO').AsString);//��Ʒ���
      StringGrid1.Cells[2,i]:=trim(dmmain.CDSquery2.FieldByName('Goods_Name').AsString);//��Ʒ����
      StringGrid1.Cells[3,i]:=trim(dmmain.CDSquery2.FieldByName('write_Amount').AsString);//��Ʒ���
      StringGrid1.Cells[7,i]:=trim(dmmain.CDSquery2.FieldByName('TYPE').AsString); //�������
      StringGrid1.Cells[StringGrid1.ColCount-2,i]:=trim(dmmain.CDSquery2.FieldByName('write_remark').AsString); //�������
      StringGrid1.Cells[StringGrid1.ColCount-1,i]:=trim(dmmain.CDSquery2.FieldByName('ORDERS').AsString); //�������
      dmmain.CDSquery2.Next;
      inc(i);
    end;
  end;
end;

procedure Tfrm_Quality_Check.StringGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
   if trim(StringGrid1.Cells[1,1])='' then exit;
  if pcol = 4 then
  begin
    if not (key in ['0'..'9',#8,'.']) then
    begin
      key:=#0;
    end else
    begin
      if key<>#8 then
      begin
        if pcol=4 then
        begin
          if StringGrid1.Cells[4,prow]<>'0' then
          begin
            StringGrid1.Cells[4,prow]:=StringGrid1.Cells[4,prow]+key;
          end else
          begin
            StringGrid1.Cells[4,prow]:=key;
          end;
          StringGrid1.Cells[5,prow]:=inttostr(strtoint(StringGrid1.Cells[3,prow])-strtoint(StringGrid1.Cells[4,prow]));
        end;
      end else
      begin
        if pcol=4 then
        begin
          StringGrid1.Cells[4,prow]:=copy(StringGrid1.Cells[4,prow],1,length(StringGrid1.Cells[4,prow])-1);   //��ȥ�������
          if  StringGrid1.Cells[4,prow]='' then
          begin
            StringGrid1.Cells[4,prow]:='0';
          end;
          StringGrid1.Cells[5,prow]:=inttostr(strtoint(StringGrid1.Cells[3,prow])-strtoint(StringGrid1.Cells[4,prow]));
        end;
      end;
    end;
  end ;
  if pcol=6 then
  begin
    stringgrid1.Options:=stringgrid1.Options+[goediting];
  end else
  begin
    stringgrid1.Options:=stringgrid1.Options-[goediting];
  end;
end;

procedure Tfrm_Quality_Check.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  pcol:=acol;
  prow:=arow;
end;

procedure Tfrm_Quality_Check.SpeedButton3Click(Sender: TObject);
begin
  if dmmain.cdsprintmaster.IsEmpty then exit;
  fastrepxf:=tfastrepxf.Create(self);
  fastrepxf.filenames:='Quality.ini';
  fastrepxf.ShowModal;
  fastrepxf.Free;
end;

end.
