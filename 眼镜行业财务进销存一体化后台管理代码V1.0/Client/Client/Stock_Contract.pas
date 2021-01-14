unit Stock_Contract;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, ComCtrls, Mask, StdCtrls, Buttons, XPMenu;

type
  Tfrm_Stock_Contract = class(TForm)
    Panel1: TPanel;
    Panel8: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Panel2: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Panel3: TPanel;
    Edit1: TLabeledEdit;
    GroupBox1: TGroupBox;
    Cmd_DW: TSpeedButton;
    Cmd_JSR: TSpeedButton;
    Cmd_ZDR: TSpeedButton;
    Edit4: TLabeledEdit;
    Edit5: TLabeledEdit;
    Edit7: TLabeledEdit;
    Edit8: TLabeledEdit;
    Edit9: TLabeledEdit;
    Edit2: TLabeledEdit;
    DateTimePicker1: TDateTimePicker;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel9: TPanel;
    Cmd_Delete: TSpeedButton;
    Cmd_Add: TSpeedButton;
    StringGrid1: TStringGrid;
    lbzj: TLabel;
    lbgs: TLabel;
    SpeedButton3: TSpeedButton;
    Label4: TLabel;
    Edit3: TDateTimePicker;
    Label1: TLabel;
    spbyd: TSpeedButton;
    Cmd_Print: TSpeedButton;
    procedure SpeedButton4Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Cmd_DWClick(Sender: TObject);
    procedure Cmd_JSRClick(Sender: TObject);
    procedure Cmd_ZDRClick(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Cmd_DeleteClick(Sender: TObject);
    procedure Cmd_AddClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SpeedButton2Click(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Cmd_PrintClick(Sender: TObject);
    procedure spbydClick(Sender: TObject);
  private
    { Private declarations }
    iColcount,Total_Count:integer;
    ss,tempstr:string;
    pcol,prow:integer;
    ZDFlag:boolean;
    procedure init;
    procedure DeleteRow(Row:Integer);
  public
    { Public declarations }
  end;

var
  frm_Stock_Contract: Tfrm_Stock_Contract;
implementation

uses Public_Don, Data, Main, Supply_Monad, Login_Man, func,
   untdatadm,
  UntgoodCodeSelStr, UntgoodscodeRe, Unt_PubStrGrid, UntMsgGoods,
  Unitreportxf;

{$R *.dfm}
procedure tfrm_stock_contract.init;
VAR
  TEMP,MAKE:STRING;
begin
  InitialStrGrid(stringgrid1,'�ɹ���ͬ');
  stringgrid1.ColCount:=stringgrid1.ColCount+1; //��Ԥ����Ʒʱ��¼Ԥ������ţ�
  stringgrid1.ColWidths[stringgrid1.ColCount-1]:=-1;
  if Public_Do='Business_Draft_0002' then exit;
  edit7.Text:=trim(Handle_Man);
  edit3.Date:=date+1;
  edit1.Text:=formatdatetime('yyyy''-''mm''-''dd',date);
  temp:='select max(right(Contract_No,4)) from STOCK_CONTRACT where copy_date='+''''+formatdatetime('yyyy''-''mm''-''dd',date)+'''';
  make:='CGHT-'+trim(Handle_Part)+trim(handle_no);//�ò��ű��
  edit2.Text:=setcode(temp,make);
end;

procedure Tfrm_Stock_Contract.DeleteRow(Row:Integer);
var
    i : integer;
begin
    //���һ��ֱ��ɾ��
    if (Row = StringGrid1.RowCount-1) and (row >1) then
        StringGrid1.RowCount := StringGrid1.RowCount - 1;
    //�Զ�����
    if (Row < StringGrid1.RowCount) and (Row > StringGrid1.FixedRows-1) then
    begin
        if Row < StringGrid1.RowCount - 1 then
        begin
            for i := Row to StringGrid1.RowCount-1 do
            StringGrid1.Rows[i] := StringGrid1.Rows[i+1];
            StringGrid1.RowCount :=StringGrid1.RowCount - 1;
        end;
    end;
end;
procedure Tfrm_Stock_Contract.SpeedButton4Click(Sender: TObject);
var
    i,j,icol:integer;
    Check_Flag:string;
    sqlpub:widestring;
begin
    frm_Public_Don:=Tfrm_Public_Don.Create(self);
    frm_Public_Don.no:=trim(edit2.Text);
    frm_Public_Don.ShowModal;
    //ֱ�Ӳ���
    if Public_Do='Stock_0002' then
    begin
        //����Ϊ�ݸ嵥��
        if Public_Do_Result='02' then //����Ϊ�ݸ嵥��
        begin
            try
                for i:=1 to StringGrid1.RowCount-1 do
                begin
                  if StringGrid1.Cells[1,i]='' then
                  begin
                      Application.MessageBox('��������,����Ʒ��š�����Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                      Exit;
                  end;
                end;
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
                if Trim(Edit4.Text)='' then
                begin
                    Application.MessageBox('��������,��������λ������Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                    Edit4.SetFocus;
                    Exit;
                end;
                if Trim(Edit5.Text)='' then
                begin
                    Application.MessageBox('��������,�������ˡ�����Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                    Edit5.SetFocus;
                    Exit;
                end;
                if Trim(Edit7.Text)='' then
                begin
                    Application.MessageBox('��������,���Ƶ��ˡ�����Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                    Edit7.SetFocus;
                    Exit;
                end;
                for i:=1 to stringgrid1.RowCount-1 do
                begin
                    if StringGrid1.Cells[3,i]='' then
                    begin
                        Application.MessageBox('��������,�����ۡ�����Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                        Exit;
                    end;
                    if StringGrid1.Cells[4,i]='' then
                    begin
                        Application.MessageBox('��������,������������Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                        Exit;
                    end;
                    if StringGrid1.Cells[5,i]='' then
                    begin
                        Application.MessageBox('��������,��������Ϊ�գ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                        Exit;
                    end;
                end;

                with frm_data.ClientDataSet_Add do
                begin
                    sqlpub:='Select * from [Stock_contract] where Copy_Date='''+Trim(Edit1.Text)+''' and Contract_No='''+Trim(Edit2.Text)+'''';
                    dmmain.CDSquery.Close;
                    dmmain.CDSquery.Data:=frm_data.Socket_Connection.AppServer.GetRecord(sqlpub);
                    dmmain.CDSquery.Open;
                    try
                        //open;
                        if dmmain.CDSquery.RecordCount>0 then
                        begin
                            Application.MessageBox('����ʧ��,�á��ɹ���ͬ����¼�����ݿ����Ѿ����ڣ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                            Exit;
                        end
                        else
                        begin
                          ///////////���桾�ɹ���ͬ�����ݱ�
                          dmmain.cdsStock_contract.Open;
                          dmmain.cdsStock_contract.Append;
                          dmmain.cdsStock_contract.FieldByName('copy_date').AsString:=trim(edit1.Text);
                          dmmain.cdsStock_contract.FieldByName('Contract_No').AsString:=trim(edit2.Text);
                          dmmain.cdsStock_contract.FieldByName('Arrive_Date').AsString:=formatdatetime('yyyy''-''mm''-''dd',edit3.Date);
                          dmmain.cdsStock_contract.FieldByName('wldw').AsString:=trim(edit4.Text);
                          dmmain.cdsStock_contract.FieldByName('transactor').AsString:=trim(edit5.Text);
                          dmmain.cdsStock_contract.FieldByName('proposer').AsString:=trim(edit7.Text);
                          dmmain.cdsStock_contract.FieldByName('resume').AsString:=trim(edit8.Text);
                          dmmain.cdsStock_contract.FieldByName('remark').AsString:=trim(edit9.Text);
                          dmmain.cdsStock_contract.FieldByName('wldw_no').AsString:=trim(wldwno);
                          dmmain.cdsStock_contract.Post;


                          dmmain.cdsReceipt.Open;
                          dmmain.cdsReceipt.Append;
                          dmmain.cdsReceipt.FieldByName('Receipt_NO').AsString:=trim(edit2.Text);
                          dmmain.cdsReceipt.FieldByName('Receipt_Name').AsString:='�ɹ���ͬ';
                          dmmain.cdsReceipt.FieldByName('Copy_Date').AsString:=trim(edit1.Text);
                          dmmain.cdsReceipt.FieldByName('Proposer').AsString:=trim(edit7.Text);
                          dmmain.cdsReceipt.FieldByName('Condense').AsString:=trim(edit9.Text);
                          dmmain.cdsReceipt.FieldByName('Check_Result').Asinteger:=0;
                          dmmain.cdsReceipt.FieldByName('Flag_Sign').AsString:='�ݸ�';
                          dmmain.cdsReceipt.FieldByName('Re_part').AsString:=trim(Handle_Part);
                          dmmain.cdsReceipt.Post;
                          dmmain.cdsStock_contract_detail.Open;
                          ////////////���桾�ɹ���ͬ��ϸ��
                          for i:=1 to stringgrid1.RowCount-1 do
                          begin
                            dmmain.cdsStock_contract_detail.Append;
                            dmmain.cdsStock_contract_detail.FieldByName('Contract_No').AsString:=trim(edit2.Text);
                            dmmain.cdsStock_contract_detail.FieldByName('Goods_NO').AsString:=trim(stringgrid1.Cells[1,i]);
                            dmmain.cdsStock_contract_detail.FieldByName('Price').AsString:=trim(stringgrid1.Cells[3,i]);
                            dmmain.cdsStock_contract_detail.FieldByName('Goods_amount').AsString:=trim(stringgrid1.Cells[4,i]);
                            dmmain.cdsStock_contract_detail.FieldByName('Money').AsString:=trim(stringgrid1.Cells[5,i]);
                            dmmain.cdsStock_contract_detail.FieldByName('remark').AsString:=trim(stringgrid1.Cells[8,i]);
                            dmmain.cdsStock_contract_detail.FieldByName('Orders').AsString:=trim(stringgrid1.Cells[9,i]);
                            dmmain.cdsStock_contract_detail.Post;
                          end;
                          try
                            dmmain.cdsStock_contract.ApplyUpdates(-1);
                            dmmain.cdsReceipt.ApplyUpdates(-1);
                            dmmain.cdsStock_contract_detail.ApplyUpdates(-1);
                          except
                            Application.MessageBox('�������ݱ�ʱ����'+#13#10+'����Զ�̷����������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                            Exit;
                          end;
//                          Application.MessageBox('��ϲ�㣡���ɹ���ͬ������Ϊ�ݸ�����ɹ�����ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                          edit1.Text:='';
                          edit2.Text:='';
                          edit3.Date:=date-1;
                          edit4.Text:='';
                          edit5.Text:='';
                          edit7.Text:='';
                          edit8.Text:='';
                          edit9.Text:='';
                          for i:=1 to stringgrid1.RowCount-1 do   //������񣬲���ֻ��ȥ�У������´��½�ʱ�����ظ�����
                            stringgrid1.Rows[i].Clear;
                          stringgrid1.RowCount:=2;
                          init;
                        end;
                    except
                        Application.MessageBox('ϵͳ����,�ڴ򿪡��ɹ���ͬ�����ݱ�ʱ����'+#13#10+'����Զ�̷����������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                        Exit;
                    end;
                end;
            except
                Application.MessageBox('��Ӳ���ʧ�ܣ��������������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                Exit;
            end;
        end;
        frm_Main.Panel_Title.Caption:='[��������ϵͳ]->[�ɹ���Ϣ����]';
        if Public_Do_Result='03' then
        begin
            dmmain.cdsStock_contract.Close;
            dmmain.cdsReceipt.Close;
            dmmain.cdsStock_contract_detail.Close;
            Close;
        end;
    end;
    //�����ݸ�
    if Public_Do='Business_Draft_0002' then
    begin
        //�ݸ����תΪ����
        if Public_Do_Result='01' then //����Ϊ����
        begin
            with frm_data.ClientDataSet2 do
            begin
                SQLPUB:= 'Select * from [V_Goods_Stock_Contract_View] where Receipt_No='''+Trim(List_NO)+'''';
                dmmain.CDSquery.Close;
                dmmain.CDSquery.Data:=frm_data.Socket_Connection.AppServer.GetRecord(sqlpub);
                dmmain.CDSquery.Open;
                try
                    //Open;
                   // Check_Flag:=frm_data.ClientDataSet2.FieldValues['Check_Result'];
                    Check_Flag:=dmmain.CDSquery.FieldValues['Check_Result'];
                    if Check_Flag='0' then
                    begin
                        Application.MessageBox('���Ųݸ嵥�ݻ�û����ȫ��ˣ����ܹ��ʣ���ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                        Exit;
                    end;
                    if Check_Flag='1' then
                    begin
                        with frm_data.ClientDataSet_Add do
                        begin
                        //    Close;      //��Ϊ������ģʽ
                        //    Commandtext:='';
                            //Commandtext:='update [Stock_contract] set Arrive_Date='''+Trim(Edit3.Text)+''',wldw='''+Trim(Edit4.Text)+''',resume='''+Trim(Edit8.Text)+''',remark='''+Trim(Edit9.Text)+''' where Contract_No='''+Trim(List_No)+'''';
                            sqlpub:='select * from Stock_contract where Contract_No='+''''+Trim(List_No)+'''';
                            dmmain.CDSexecsql.Close;
                            dmmain.CDSexecsql.Data:=frm_data.Socket_Connection.AppServer.execSql(sqlpub);
                            dmmain.CDSexecsql.Open;
                            dmmain.CDSexecsql.Edit;
                            dmmain.CDSexecsql.FieldByName('Arrive_Date').AsString:=formatdatetime('yyyy''-''mm''-''dd',edit3.Date);
                            dmmain.CDSexecsql.FieldByName('wldw').AsString:=Trim(Edit4.Text);
                            dmmain.CDSexecsql.FieldByName('resume').AsString:=Trim(Edit8.Text);
                            dmmain.CDSexecsql.FieldByName('remark').AsString:=Trim(Edit9.Text);
                            dmmain.CDSexecsql.FieldByName('wldw_no').AsString:=Trim(wldwno);  //������λ
                            dmmain.CDSexecsql.Post;
                            try
                              dmmain.CDSexecsql.ApplyUpdates(-1);
                            except
                              Application.MessageBox('�������ݱ�ʱ����'+#13#10+'����Զ�̷����������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                              Exit;
                            end;
                            try
//                                Execute;
                                //�޸���ϸ�������



                                sqlpub:='select * from  [Stock_contract_detail] where Contract_No='+''''+Trim(List_NO)+'''';
                                dmmain.CDSexecsql.Close;
                                dmmain.CDSexecsql.Data:=frm_data.Socket_Connection.AppServer.execsql(sqlpub);
                                dmmain.CDSexecsql.Open;
                                dmmain.CDSexecsql.First;
                                //dmmain.CDSexecsql.IsEmpty
                                for i:=1 to Total_Count-1 do
                                begin
                                    //try
                                        with frm_data.ClientDataSet_Add do
                                        begin
//                                            Close;
//                                            frm_data.ClientDataSet_Add.CommandText:='';
//                                            CommandText:='update [Stock_contract_detail] set Price='''+Trim(StringGrid1.Cells[3,i])+''',Goods_amount='''+Trim(StringGrid1.Cells[4,i])+''',Money='''+Trim(StringGrid1.Cells[5,i])+''' where Contract_No='''+Trim(List_NO)+''' and Goods_NO='''+Trim(StringGrid1.Cells[1,i])+'''';
                                               dmmain.CDSexecsql.Edit;
                                               dmmain.CDSexecsql.FieldByName('Price').AsString:=trim(stringgrid1.Cells[3,i]);
                                               dmmain.CDSexecsql.FieldByName('Goods_amount').AsString:=trim(stringgrid1.Cells[4,i]);
                                               dmmain.CDSexecsql.FieldByName('Money').AsString:=trim(stringgrid1.Cells[5,i]);
                                               dmmain.CDSexecsql.FieldByName('remark').AsString:=Trim(stringgrid1.Cells[8,i]);
                                               dmmain.CDSexecsql.Post;
                                               dmmain.CDSexecsql.Next;
{                                            try
                                                Execute;
                                            except
                                                Application.MessageBox('ϵͳ�������޸ġ��ɹ���ͬ��ϸ�����ݱ�ʱ����'+#13#10+'����Զ�̷����������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                                                Exit;
                                            end;   }
                                        end;
                                    //except
                                        //Application.MessageBox('ϵͳ�������޸ġ��ɹ���ͬ��ϸ�����ݱ�ѭ��ʱ����'+#13#10+'����Զ�̷����������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                                        //Exit;
                                    //end;
                                end;
                                try
                                  dmmain.cdsStock_contract_detail.ApplyUpdates(-1);
                                except
                                  Application.MessageBox('ϵͳ�������޸ġ��ɹ���ͬ��ϸ�����ݳ���'+#13#10+'����Զ�̷����������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                                  Exit;
                                end;
                                //�޸Ĳݸ�ı�־λ
                                with frm_data.ClientDataSet_Add do
                                begin      //��Ϊ������ģʽ
                                    Close;
                                    Commandtext:='';
                                    Commandtext:='Update [Receipt] set Flag_sign=''����'' where Receipt_No='''+Trim(List_NO)+'''';
                                    try
                                        Execute;
                                        Application.MessageBox('��ϲ�㣡���ɹ���ͬ���ݸ嵥�ݹ�����ϣ�',pchar(application.Title),mb_iconwarning);
                                    except
                                        Application.MessageBox('ϵͳ�������޸ġ��ɹ���ͬ��˱����ݱ��־λʱ����'+#13#10+'����Զ�̷����������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                                        Exit;
                                    end;
                                end;
                            except
                                Application.MessageBox('ϵͳ�������޸ġ��ɹ���ͬ�����ݱ�ʱ����'+#13#10+'����Զ�̷����������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                                Exit;
                            end;
                        end;
                    end;
                except
                    Application.MessageBox('ϵͳ�����ڴ򿪡��ɹ���ͬ��ͼ�����ݱ�ʱ����'+#13#10+'����Զ�̷����������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                    Exit;
                end;
            end;
        end;
        //�޸Ĳݸ嵥��
        if Public_Do_Result='02' then //�޸Ĳݸ嵥��
        begin
            with frm_data.ClientDataSet_Add do
            begin
              if not bedit then
              begin
                if trim(Handle_Man)<>trim(edit7.Text) then
                begin
                  Application.MessageBox('�����޸����ݣ�',pchar(application.Title),mb_iconinformation);
                  exit;
                end;
              end;
                sqlpub:='select * from [Stock_contract] where Contract_No='+''''+Trim(List_No)+'''';
                dmmain.CDSexecsql.Close;
                dmmain.CDSexecsql.Data:=frm_data.Socket_Connection.AppServer.execSql(sqlpub);
                dmmain.CDSexecsql.Open;
                dmmain.CDSexecsql.Edit;
                dmmain.CDSexecsql.FieldByName('Arrive_Date').AsString:=formatdatetime('yyyy''-''mm''-''dd',edit3.Date);
                dmmain.CDSexecsql.FieldByName('wldw').AsString:=Trim(Edit4.Text);
                dmmain.CDSexecsql.FieldByName('wldw_no').AsString:=Trim(wldwno);
                dmmain.CDSexecsql.FieldByName('resume').AsString:=Trim(Edit8.Text);
                dmmain.CDSexecsql.FieldByName('remark').AsString:=Trim(Edit9.Text);
                dmmain.CDSexecsql.Post;
                try
                  dmmain.CDSexecsql.ApplyUpdates(-1);
                except
                  Application.MessageBox('ϵͳ�����ڲɹ����ɹ���ͬ�����ݱ�ʱ����'+#13#10+'����Զ�̷����������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                  Exit;
                end;
                    //�޸���ϸ�������
                    //wy edit 3-14
                  sqlpub:='select * from  [Stock_contract_detail] where Contract_No='+''''+Trim(List_NO)+'''';
                  dmmain.CDSexecsql.Close;
                  dmmain.CDSexecsql.Data:=frm_data.Socket_Connection.AppServer.execsql(sqlpub);
                  dmmain.CDSexecsql.Open;
                  dmmain.CDSexecsql.First;
                  for i:=1 to stringgrid1.RowCount-1  do //wy edit 3-14
                  begin
                      try
                          dmmain.CDSexecsql.Edit;
                          dmmain.CDSexecsql.FieldByName('Price').AsString:=trim(stringgrid1.Cells[3,i]);
                          dmmain.CDSexecsql.FieldByName('Goods_amount').AsString:=trim(stringgrid1.Cells[4,i]);
                          dmmain.CDSexecsql.FieldByName('Money').AsString:=trim(stringgrid1.Cells[5,i]);
                          dmmain.CDSexecsql.Post;
                          dmmain.CDSexecsql.Next;
                      except
                          Application.MessageBox('ϵͳ�������޸ġ��ɹ���ͬ��ϸ�����ݱ�ѭ��ʱ����'+#13#10+'����Զ�̷����������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                          Exit;
                      end;
                  end;
                  try
                    dmmain.CDSexecsql.ApplyUpdates(-1);
                  except
                    Application.MessageBox('ϵͳ�������޸ġ��ɹ���ͬ��ϸ�����ݱ�ѭ��ʱ����'+#13#10+'����Զ�̷����������Ƿ���������ȷ�ϣ�',pchar(application.Title),mb_iconwarning);
                    Exit;
                  end;
            end;
        end;
        if func.Public_Do_Result='03' then
        begin
            frm_data.ClientDataSet_Add.Close;
            frm_data.ClientDataSet_Add.Active:=False;
            Close;
        end;
    end;
    frm_Public_Don.Free;
end;


procedure Tfrm_Stock_Contract.Edit1Click(Sender: TObject);
begin
    Edit1.Text:=ForMatDatetime('yyyy''-''mm''-''dd',now);
end;

procedure Tfrm_Stock_Contract.Cmd_DWClick(Sender: TObject);
begin
    Check_Mond:='';
    wldwno:='';
    Check_Mond:='DW-0001';
    frm_Supply_Monad:=Tfrm_Supply_Monad.Create(self);
    frm_Supply_Monad.Caption:='��������λ��';
    frm_Supply_Monad.ShowModal;
    Edit4.Text:=check_Mond_Result;
    frm_Supply_Monad.Free;
end;

procedure Tfrm_Stock_Contract.Cmd_JSRClick(Sender: TObject);
begin
    Employe_Check:='';
    Employe_Check:='JSR-0001';
    Employe_Check_Result:='';
    frm_Login_Man:=Tfrm_Login_Man.Create(self);
    frm_Login_Man.Caption:='������ѡ��';
    frm_Login_Man.ShowModal;
    Edit5.Text:=Employe_Check_Result;
    frm_Login_Man.Free;
end;

procedure Tfrm_Stock_Contract.Cmd_ZDRClick(Sender: TObject);
begin
//    Edit7.Text:=Handle_Man;
    frm_Login_Man:=Tfrm_Login_Man.Create(self);
    frm_Login_Man.Caption:='�Ƶ���ѡ��';
    frm_Login_Man.ShowModal;
    Edit7.Text:=Employe_Check_Result;
    frm_Login_Man.Free;
end;

procedure Tfrm_Stock_Contract.StringGrid1DblClick(Sender: TObject);
var
  i:integer;
begin
  if Trim(Edit2.Text)='' then
  begin
      Application.MessageBox('����ʧ�ܣ������ݱ�š�����Ϊ�գ�',pchar(application.Title),mb_iconwarning);
      Edit2.SetFocus;
      Exit;
  end;
  if Trim(Edit4.Text)='' then
  begin
      Application.MessageBox('����ʧ�ܣ���������λ������Ϊ�գ�',pchar(application.Title),mb_iconwarning);
      Edit4.SetFocus;
      Exit;
  end;
  if Trim(Edit5.Text)='' then
  begin
      Application.MessageBox('����ʧ�ܣ��������ˡ�����Ϊ�գ�',pchar(application.Title),mb_iconwarning);
      Edit5.SetFocus;
      Exit;
  end;
    if pcol in [1,2] then
    begin
     fmgoodCodeSelStr:= TfmgoodCodeSelStr.Create(self);
     try
     fmgoodcodeselStr.show_mode:='5';
     fmgoodcodeselStr.ShowModal;
     finally
     fmgoodcodeselStr.Free;
     end;
    end;
  if pcol = 4 then  //��������
  begin
   for i := prow+1 to STRINGGRID1.rowcount -1 do
   begin
   STRINGGRID1.cells[4,i]:= STRINGGRID1.cells[4,prow];
   //ͬʱҪ������                                       
   end;
  end;
end;


procedure Tfrm_Stock_Contract.StringGrid1DrawCell(Sender: TObject; ACol,
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
end;

procedure Tfrm_Stock_Contract.StringGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
var
    tempstr:string;
    i:integer;
begin
    if ((StringGrid1.Cells[3,ARow]<>'') and  (StringGrid1.Cells[4,ARow]<>'' ))then
    try
     StringGrid1.Cells[5,ARow]:=FloatTostr(StrToFloat(StringGrid1.Cells[3,ARow])*StrToFloat(StringGrid1.Cells[4,ARow]));
    except
      showmessage('������������������������룡');
    end;
end;
procedure Tfrm_Stock_Contract.FormShow(Sender: TObject);
var
    i,icount,k:integer;
    tt,yy,temppos:integer;
    tempstr:widestring;
begin
    zdflag:=false;
   init;
    //�����к�
    for i:=1 to StringGrid1.RowCount-1 do
    begin
        StringGrid1.Cells[0,i]:=IntTostr(i); //��ʾ��0�е�i��
    end;
    if (Public_Do='Business_Draft_0002') then
    begin
      tempstr:='Select a.*,b.*,c.* from Stock_Contract as a ,Stock_Contract_detail as b, goods_code as c where c.goods_no=b.goods_no and a.Contract_No=b.Contract_No and a.Contract_No='+''''+trim(List_No)+'''';
      dmmain.CDSquery2.Data:=null;
      dmmain.CDSquery2.Close;
       //wy edit 3-14   begin
      dmmain.CDSquery2.Data:=adisp.resultrecord(tempstr);
      if not dmmain.CDSquery2.IsEmpty then       //���ؼ�¼��Ϊ��ʱ��������Ҫ����Wy
      begin
          dmmain.CDSquery2.Open;
          k:=dmmain.CDSquery2.RecordCount;
          StringGrid1.RowCount:=k+1;
          //�Զ�����STRINGGRID������

          //******************
          speedbutton3.Enabled:=false;//�޸�ʱ�������ٴ�ת��
          spbyd.Enabled:=false;
          ////////////////////////
          Edit1.Text:=ForMatDateTime('yyyy''-''mm''-''dd',dmmain.CDSquery2.FieldValues['Copy_Date']);
          Edit2.Text:=dmmain.CDSquery2.FieldValues['Contract_No'];
          Edit3.Date :=dmmain.CDSquery2.fieldbyname('Arrive_Date').AsDateTime;
          Edit4.Text:=dmmain.CDSquery2.FieldValues['wldw'];
          Edit5.Text:=dmmain.CDSquery2.FieldValues['transactor'];
          Edit7.Text:=dmmain.CDSquery2.FieldValues['Proposer'];
          Edit8.Text:=dmmain.CDSquery2.FieldValues['resume'];
          Edit9.Text:=dmmain.CDSquery2.FieldValues['Remark'];
          wldwno:=dmmain.CDSquery2.Fieldbyname('wldw_no').AsString;
          for k:=1 to dmmain.CDSquery2.RecordCount  do //wy edit;
          begin
            StringGrid1.Cells[0,K]:=IntTostr(k); //��ʾ��0�е�i�е�����
            StringGrid1.Cells[1,k]:=trim(dmmain.CDSquery2.FieldValues['Goods_NO']);//��Ʒ���
            StringGrid1.Cells[2,k]:=trim(dmmain.CDSquery2.FieldValues['Goods_Name']);//��Ʒ����
            StringGrid1.Cells[3,k]:=trim(dmmain.CDSquery2.FieldValues['Price']);//����   // wg and wy edit;
            StringGrid1.Cells[4,k]:=trim(dmmain.CDSquery2.FieldValues['Goods_amount']);//����
            StringGrid1.Cells[5,k]:=trim(dmmain.CDSquery2.FieldValues['Money']);//���
            StringGrid1.Cells[6,k]:=trim(dmmain.CDSquery2.FieldValues['type']); //�������
            StringGrid1.Cells[7,k]:=trim(dmmain.CDSquery2.FIELDBYNAME('PROVIDER').AsString); //��������
            StringGrid1.Cells[8,k]:=trim(dmmain.CDSquery2.FieldValues['remark']); //��ע˵��
            StringGrid1.Cells[9,k]:=trim(dmmain.CDSquery2.FieldValues['Orders']); //Ԥ��������˵��
            dmmain.CDSquery2.Next;
          end;
          GetDataPrint(dmmain.cdsprintmaster,dmmain.CDSquery2);
      end else
      begin
          application.MessageBox('�˺�ͬ�Ѳ����ڣ���˶Ժ������',pchar(application.Title),mb_iconinformation);
      end;
  end;      //end;
end;


procedure Tfrm_Stock_Contract.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   DMMAIN.CDSquery2.Close;
  dmmain.CDSquery2.Data:=null;
   DMMAIN.CDSexecsql.Close;
  dmmain.CDSexecsql.Data:=null;
  dmmain.cdsprintmaster.Close;
  dmmain.cdsprintmaster.Data:=null;
  dmmain.cdsStock_contract_detail.Close;
  dmmain.cdsStock_contract_detail.Data:=null;
  dmmain.cdsStock_contract.Close;
  dmmain.cdsStock_contract.Data:=null;
    Action:=cafree;
end;

procedure Tfrm_Stock_Contract.Cmd_DeleteClick(Sender: TObject);
begin
  deletegridrows(stringgrid1,prow);
end;


procedure Tfrm_Stock_Contract.Cmd_AddClick(Sender: TObject);
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

procedure Tfrm_Stock_Contract.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  pcol:=acol;
  prow:=arow;
end;

procedure Tfrm_Stock_Contract.SpeedButton2Click(Sender: TObject);
var
  user:widestring;
  flag:olevariant;
begin
  if trim(stringgrid1.Cells[1,1])='' then exit;
  no:=trim(edit2.Text);
  typed:='�ɹ���ͬ';
  user:=trim(Handle_No);
  flag:=adisp.receipted(no,typed,user,1,Handle_Part);
  if flag='1' then
  begin
    application.MessageBox('��˳ɹ���',pchar(application.Title),mb_iconinformation);
    close;
    exit;
  end;
  if flag='2' then
  begin
    application.MessageBox('��Ȩ���н������',pchar(application.Title),mb_iconinformation);
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

procedure Tfrm_Stock_Contract.StringGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if trim(StringGrid1.Cells[1,StringGrid1.Row])='' then exit;
  if pcol in [3,4,8] then
  begin
    if not (key in ['0'..'9',#8,'.']) then
    begin
      key:=#0;
    end else
    begin
      if key<>#8 then
      begin
        IF PCOL=3 THEN
        begin
          if StringGrid1.Cells[3,prow]<>'0' then
          begin
            StringGrid1.Cells[3,prow]:=StringGrid1.Cells[3,prow]+key;
          end else
          begin
            StringGrid1.Cells[3,prow]:=key;
          end;
        end;
        if pcol=4 then
        begin
          if StringGrid1.Cells[4,prow]<>'0' then
          begin
            StringGrid1.Cells[4,prow]:=StringGrid1.Cells[4,prow]+key;
          end else
          begin
            StringGrid1.Cells[4,prow]:=key;
          end;
        end;
        StringGrid1.Cells[5,prow]:=floattostr(strtofloat(StringGrid1.Cells[3,prow])*strtofloat(StringGrid1.Cells[4,prow]));
      end else
      begin
        if pcol=3 then
        begin
          StringGrid1.Cells[3,prow]:=copy(StringGrid1.Cells[3,prow],1,length(StringGrid1.Cells[3,prow])-1);   //��ȥ�������
          if  StringGrid1.Cells[3,prow]='' then
          begin
            StringGrid1.Cells[3,prow]:='0';
          end;
          StringGrid1.Cells[5,prow]:=floattostr(strtofloat(StringGrid1.Cells[3,prow])*strtofloat(StringGrid1.Cells[4,prow]));
        end;
        if pcol=4 then
        begin
          StringGrid1.Cells[4,prow]:=copy(StringGrid1.Cells[4,prow],1,length(StringGrid1.Cells[4,prow])-1);   //��ȥ�������
          if  StringGrid1.Cells[4,prow]='' then
          begin
            StringGrid1.Cells[4,prow]:='0';
          end;
          if trim(StringGrid1.Cells[4,prow])='0' then
          begin
            StringGrid1.Cells[5,prow]:='0';
          end else
          begin
            StringGrid1.Cells[5,prow]:=floattostr(strtofloat(StringGrid1.Cells[3,prow])*strtofloat(StringGrid1.Cells[4,prow]));
          end;
        end;
      end;
    end;
  end else
  begin
    application.MessageBox('ֻ��������Ʒ����,������˵����',pchar(application.Title),mb_iconinformation);
    exit;
  end;
end;

procedure Tfrm_Stock_Contract.StringGrid1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  gs,i:integer;
  zjmoney:double;
begin
  gs:=0;
  zjmoney:=0.00;
  if trim(stringgrid1.Cells[1,1])='' then exit;
  for i:=1 to stringgrid1.RowCount -1 do
  begin
    if (trim(stringgrid1.Cells[4,i])<>'') then
    begin
      gs:=gs+strtoint(stringgrid1.Cells[4,i]);
    end;
    if (trim(stringgrid1.Cells[5,i])<>'') then
    begin
      zjmoney:=zjmoney+strtofloat(stringgrid1.Cells[5,i]);
    end;
  end;
  lbgs.Caption:=format('%11d',[gs]);
  lbzj.Caption :=format('%11.'+inttostr(len)+'f',[zjmoney]);
end;

procedure Tfrm_Stock_Contract.SpeedButton3Click(Sender: TObject);
begin
  zdflag:=true;
 dlgmsggoods:=tdlgmsggoods.Create(self);
 dlgmsggoods.model:=0;
 dlgmsggoods.ShowModal;
 dlgmsggoods.Free;
end;

procedure Tfrm_Stock_Contract.Cmd_PrintClick(Sender: TObject);
begin
  if dmmain.cdsprintmaster.IsEmpty then exit;
  fastrepxf:=tfastrepxf.Create(self);
  fastrepxf.filenames:='Contract.ini';
  fastrepxf.ShowModal;
  fastrepxf.Free;
end;

procedure Tfrm_Stock_Contract.spbydClick(Sender: TObject);
begin
  dlgmsggoods:=tdlgmsggoods.Create(self);
  dlgmsggoods.model:=2;
  dlgmsggoods.ShowModal;
  dlgmsggoods.Free;
end;

end.
