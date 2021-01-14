unit data;

interface

uses
  SysUtils,
  Classes,
  DB,
  Wwdatsrc,
  ADODB,
  Wwintl,
  Dialogs,
  Controls,
  ADOConEd,
  DBTables,
  Wwquery;

type
  TDM = class(TDataModule)
    DB: TADOConnection;
    wwIntl1: TwwIntl;
    tabEmp: TADOTable;
    dsEmp: TwwDataSource;
    qryOwner: TADOQuery;
    dsOwner: TwwDataSource;
    tabCust: TADOQuery;
    dsCust: TwwDataSource;
    tabSupp: TADOQuery;
    dsSupp: TwwDataSource;
    tabType: TADOQuery;
    tabGoods: TADODataSet;
    dsGoods: TwwDataSource;
    dsType: TwwDataSource;
    dsOut: TwwDataSource;
    dsOutItems: TwwDataSource;
    tabFirstStore: TADOTable;
    dsFirstStore: TwwDataSource;
    tabFirstStoregdsid: TWideStringField;
    tabFirstStorestoreid: TWideStringField;
    tabStore: TADOTable;
    tabFirstStorestorename: TStringField;
    tabFirstStoregdsName: TStringField;
    tabFirstStoreamo: TBCDField;
    tabFirstStorequa: TFloatField;
    tabNextId: TADOTable;
    tabOut: TADOTable;
    tabOutItems: TADOTable;
    tabOutItemsautoid: TAutoIncField;
    tabOutItemsSheetID: TWideStringField;
    tabOutItemsGdsID: TWideStringField;
    tabOutItemsUnit: TWideStringField;
    tabOutItemsQua: TFloatField;
    tabOutItemsPrice: TBCDField;
    tabOutItemsbigPrice: TBCDField;
    tabOutItemsstoreid: TStringField;
    tabOutItemsNotes: TMemoField;
    tabOutItemsstorename: TStringField;
    tabOutItemsgdsname: TStringField;
    tabOutItemsamo: TCurrencyField;
    tabOutItemsbigAmo: TCurrencyField;
    dsOutPrice: TwwDataSource;
    qryOutPrice: TADOQuery;
    qryUnit: TADOQuery;
    tabOutcustname: TStringField;
    tabOutempname: TStringField;
    tabOutType: TStringField;
    tabOutStatus: TWordField;
    tabOutIsBack: TBooleanField;
    tabOutSheetID: TWideStringField;
    tabOutCustID: TWideStringField;
    tabOutDate: TDateTimeField;
    tabOutEmpId: TStringField;
    tabOutOrderID: TWideStringField;
    tabOutDiscount: TFloatField;
    tabOutAmo: TBCDField;
    tabOutPayAmo: TBCDField;
    tabOutdefaultStoreId: TStringField;
    tabOutNotes: TMemoField;
    tabOutStatusDate: TDateTimeField;
    dsIn: TwwDataSource;
    dsInItems: TwwDataSource;
    tabIn: TADOTable;
    StringField2: TStringField;
    WordField1: TWordField;
    BooleanField1: TBooleanField;
    WideStringField1: TWideStringField;
    DateTimeField1: TDateTimeField;
    StringField4: TStringField;
    WideStringField3: TWideStringField;
    BCDField1: TBCDField;
    BCDField2: TBCDField;
    StringField5: TStringField;
    MemoField1: TMemoField;
    DateTimeField2: TDateTimeField;
    tabInItems: TADODataSet;
    tabInItemsGdsId: TWideStringField;
    StringField6: TStringField;
    WideStringField5: TWideStringField;
    FloatField2: TFloatField;
    BCDField3: TBCDField;
    CurrencyField1: TCurrencyField;
    MemoField2: TMemoField;
    WideStringField6: TWideStringField;
    StringField7: TStringField;
    AutoIncField1: TAutoIncField;
    StringField8: TStringField;
    dsInprice: TwwDataSource;
    qryInPrice: TADOQuery;
    tabInSuppID: TWideStringField;
    tabInType: TStringField;
    tabGoodsgdsid: TStringField;
    tabGoodsgdsname: TStringField;
    tabGoodsunit: TStringField;
    tabGoodsmaxres: TFloatField;
    tabGoodsminres: TFloatField;
    tabGoodsinprice: TBCDField;
    tabGoodsoutprice1: TBCDField;
    tabGoodsoutprice2: TBCDField;
    tabGoodsoutprice3: TBCDField;
    tabGoodsoutprice4: TBCDField;
    tabGoodsgdstypeid: TStringField;
    tabGoodsinUse: TBooleanField;
    tabGoodsnotes: TMemoField;
    tabGoodsgdstypename: TStringField;
    procedure tabCustAfterOpen(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure tabBeforeDelete(DataSet: TDataSet);
    procedure tabEmpBeforeDelete(DataSet: TDataSet);
    procedure tabPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure tabGoodsAfterOpen(DataSet: TDataSet);
    procedure tabOutNewRecord(DataSet: TDataSet);
    procedure tabOutItemsNewRecord(DataSet: TDataSet);
    procedure tabOutItemsCalcFields(DataSet: TDataSet);
    procedure tabOutItemsGdsIDChange(Sender: TField);
    procedure tabInNewRecord(DataSet: TDataSet);
    procedure tabInItemsBeforePost(DataSet: TDataSet);
    procedure tabInItemsCalcFields(DataSet: TDataSet);
    procedure tabInItemsNewRecord(DataSet: TDataSet);
    procedure tabInItemsGdsIdChange(Sender: TField);
    procedure tabOutBeforePost(DataSet: TDataSet);
    procedure tabInBeforePost(DataSet: TDataSet);
    procedure tabOutItemsBeforePost(DataSet: TDataSet);
    procedure tabGoodsAfterPost(DataSet: TDataSet);
    procedure tabGoodsNewRecord(DataSet: TDataSet);
  private
    CurrentEmpID, CurrentUser: string;
    CurrentComputer: string;
    procedure ShowADOErrors;
    function Is_Valid_unit(gdsid: string; unitname: string): boolean; //��鵥λ�Ƿ�ϸ�
    procedure updateouthistory(); //ȫ��sql���Ļ�����һ��ѡ�ܶ�����ʱ�����ǻ����鷳 :(
    procedure updateInHistory();

  public
    SL: TStringList;
    tmpgdstypeid   : string   ;
    function DateNextValue(tmpStr: string): string;
    //�����ڲ�����һ���Զ������2000009010001
    function GetCurrentEmpId: string;
    function SetCurrentEmpId(const tmp: string): boolean;
    function GetCurrentUser: string;
    function SetCurrentUser(const tmp: string): boolean;
    function GetCurrentComputer: string;
    function SetCurrentComputer(const tmp: string): boolean;
    function ConfigDB(): boolean;

    { Public declarations }
  end;

var
  DM: TDM;
  FileName: string;

const
  {Declare constants we're interested in}
  eKeyViol = 9729;
  eRequiredFieldMissing = 9732;
  eForeignKey = 9733;
  eDetailsExist = 9734;
  AdoeKeyViol = 2627; //-2147217873;
  eAdoequiredFieldMissing = 515;

implementation

uses common;

{$R *.dfm}

function Tdm.DateNextValue(tmpStr: string): string;
//�����ڲ�����һ���Զ������2000009010001
var
  tmps, tmpbegin, tmpend: string;
  reset: boolean; //�����ж��Ƿ�����ֵ
begin
  reset := false;
  with tabNextId do
    begin
      if not active then
        open;
      db.BeginTrans; //��ʼ����
      try

        if not Locate('tablename', tmpStr, [loPartialKey]) then
          //����Ҳ������������      find
          begin
            append;
            fieldbyname('tablename').asstring := tmpStr;
            fieldbyname('nextvalue').asstring := FormatDateTime('yyyymmdd', now)
              + '0002';
            post;
            result := FormatDateTime('yyyymmdd', now) + '0001';
          end
        else //����ҵ������ж��Ƿ���죬�Ǽ���1�����ǣ���������0001��ʼ���Ҹ�����һ��ֵ
          begin
            tmps := fieldbyname('nextvalue').asstring;
            tmpbegin := copy(tmps, 0, 8);
            tmpend := copy(tmps, 9, 4);
            if tmpbegin = FormatDateTime('yyyymmdd', now) then //�ǽ����ֵ
              begin
                result := fieldbyname('nextvalue').asstring;
                edit;
                fieldbyname('nextvalue').asstring := tmpbegin + format('%4.4d',
                  [strtoint(tmpend) + 1]);
                post;
              end
            else //���ǽ����ֵ
              begin
                edit;
                fieldbyname('tablename').asstring := tmpStr;
                fieldbyname('nextvalue').asstring := FormatDateTime('yyyymmdd',
                  now) + '0002';
                post;
                result := FormatDateTime('yyyymmdd', now) + '0001';
              end; //end of else
          end; //end of else of if if not gotokey then
      finally
        if db.Errors.Count > 0 then
          begin
            db.RollbackTrans;
            showmessage('�Զ����ɱ�����������������ʵ�û����� ��');
          end
        else
          db.CommitTrans;
      end; //end of try
    end; //end of with
end; //end of function

function Tdm.GetCurrentUser: string;
begin
  Result := CurrentUser;
end;

function Tdm.SetCurrentUser(const tmp: string): boolean;
begin
  CurrentUser := tmp;
  Result := true;
end;

function Tdm.GetCurrentEmpID: string;
begin
  Result := CurrentEmpID;
end;

function Tdm.SetCurrentEmpID(const tmp: string): boolean;
begin
  CurrentEmpID := tmp;
  Result := true;
end;

function Tdm.GetCurrentComputer: string;
begin
  Result := CurrentComputer;
end;

function Tdm.SetCurrentComputer(const tmp: string): boolean;
begin
  CurrentComputer := tmp;
  Result := true;
end;

procedure TDM.tabCustAfterOpen(DataSet: TDataSet);
begin
  with tabCust do
    begin
      if not active then
        open;
      Findfield('CustID').DisplayLabel := '�ͻ����';
      Findfield('CustName').DisplayLabel := '�ͻ�����';
      Findfield('LocationID').displaylabel := '�ص���';
      Findfield('Amo').displaylabel := 'Ӧ����';
      Findfield('Credit').displaylabel := '���ö�';
      Findfield('Discount').displaylabel := '�ۿ�';
      Findfield('Tel').displaylabel := '�绰';
      Findfield('Fax').displaylabel := '����';
      Findfield('Email').displaylabel := '�����ʼ�';
      Findfield('PostCode').displaylabel := '��������';
      Findfield('Address').displaylabel := '��ַ';
      Findfield('Bank').displaylabel := '��������';
      Findfield('BankNo').displaylabel := '�����˺�';
      Findfield('Notes').displaylabel := '��ע';
    end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
var
  Con: string;
begin
  LongDateFormat := 'yyyy-mm-dd';
  ShortDateFormat := 'yyyy-mm-dd';
  DateSeparator := '-';
  SetCurrentUser(GetCurrentUser);
  SetCurrentComputer(GetComputerName);

  {fileName := ExtractFilePath(ParamStr(0)) + 'ConStr.ini';
  if FileExists(FileName) then
  begin
    SL := TStringList.Create;
    SL.LoadFromFile(FileName);
    Con := SL.Text;
    try
      db.Connected := false;
      db.ConnectionString := Con;
      db.Connected := true;
    except
      showmessage('���ݿ��ʼ�������޷��ҵ����ݿ�' + #13 + Con);
    end;
  end;
}
end;

procedure TDM.tabBeforeDelete(DataSet: TDataSet);
begin
  if MessageDlg('���Ҫɾ��������¼��?',
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    begin
      abort;
    end;
end;

procedure TDM.tabEmpBeforeDelete(DataSet: TDataSet);
begin
  {    if 6=application.messagebox('�������ɾ����Ա����������?','',4+32) then begin
          userlog.ShowModal;
          if not login(userlog.pass_user,userlog.pass,true) then abort
          else if not pubboss then begin
             application.MessageBox('Ȩ�޲���,����ɾ��!','',48);
             abort;
          end;
          end
      else
         abort;
  }
end;

procedure TDM.tabPostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
var
  Adoerrors: error;
begin
  Adoerrors := db.Errors.item[0];
  case Adoerrors.NativeError of
    AdoeKeyViol:
      begin
        MessageDlg('�������Ѿ�����,������һ����ţ�', mtWarning, [mbOK], 0);
        Abort;
      end;

    eAdoequiredFieldMissing:
      begin
        MessageDlg('��Щλ�ò���Ϊ�գ�', mtWarning, [mbOK], 0);
        Abort;
      end;

  end; //end of case
end;

procedure TDM.ShowADOErrors;
var
  adoErrors: Errors;
  adoError: Error;
  iCount: Integer;
  str: string;
begin
  adoErrors := db.Errors;

  for iCount := 0 to adoErrors.Count - 1 do // Iterate
    begin
      adoError := adoErrors.Item[iCount];

      str := 'Error Number : ' + IntToStr(adoError.Number) + '   ' +
        'Error Source : ' + adoError.Source + '   ' +
        'Error Description : ' + adoError.Description + '   ' +
        'Error HelpFile : ' + adoError.HelpFile + '   ' +
        'Error SQLState : ' + adoError.SQLState + '   ' +
        'Error NativeError : ' + IntToStr(adoError.NativeError);
      showmessage(str);
    end; // for
end;

procedure TDM.tabGoodsAfterOpen(DataSet: TDataSet);
begin
  with tabGoods do
    begin
      if not active then
        open;
      Findfield('GdsID').DisplayLabel := '��Ʒ���';
      Findfield('gdstypeID').DisplayLabel := '���ͱ��';
      Findfield('GdsName').DisplayLabel := '��Ʒ����';
      Findfield('unit').DisplayLabel := '��λ';
      Findfield('maxres').DisplayLabel := '�������';
      Findfield('minres').DisplayLabel := '�������';
      Findfield('inprice').DisplayLabel := '�����';
      Findfield('outprice1').DisplayLabel := '������1';
      Findfield('outprice2').DisplayLabel := '������2';
      Findfield('outprice3').DisplayLabel := '������3';
      Findfield('outprice4').DisplayLabel := '������4';
      Findfield('notes').DisplayLabel := '��ע';
      Findfield('inuse').DisplayLabel := 'ʹ����';
    end; //end of with tabgoods
end;

procedure TDM.tabOutNewRecord(DataSet: TDataSet);
begin
  with DataSet do
    begin
      fieldbyname('sheetid').asstring := DateNextValue('tabSale');
      fieldbyname('date').value := strtodate(datetostr(now));
      fieldbyname('EmpId').value := CurrentEmpID;
      fieldbyname('defaultstoreid').value := 0;
      fieldbyname('type').value := '�վ�';
      fieldbyname('status').value := 0; //����״̬ ��0 �ݸ�     1 ������ȷ
      //           2 ������   3 ĩ����
    end;
end;

function TDM.ConfigDB(): boolean; //config the database source
begin
  EditConnectionString(DM.db);
  SL.Text := db.ConnectionString;
  SL.SaveToFile(Filename);
end;

procedure TDM.tabOutItemsNewRecord(DataSet: TDataSet);
begin
  with dm.taboutitems do
    begin
      FieldByName('sheetId').value := dm.tabout.FieldByName('sheetId').value;
      FieldByName('storeid').value := dm.tabout.FieldByName('defaultstoreid').value;
    end;
end;

procedure TDM.tabOutItemsCalcFields(DataSet: TDataSet);
begin
  with dm.tabOutItems do
    begin
      Fieldbyname('amo').AsFloat := Fieldbyname('price').AsFloat *
        Fieldbyname('qua').AsFloat;
      Fieldbyname('bigamo').AsFloat := Fieldbyname('bigprice').AsFloat *
        Fieldbyname('qua').AsFloat;
    end;
end;

procedure TDM.tabOutItemsGdsIDChange(Sender: TField);
var
  SavePlace: TBookmark;
begin
  with dm.tabOutItems do //��Ʒ�ĳ����� ����λ
    begin
      if not dm.tabgoods.active then dm.tabgoods.open;
      SavePlace := dm.tabgoods.GetBookmark;
      dm.tabgoods.First;
      if dm.tabgoods.Locate('gdsid', fieldbyname('gdsId').Asstring, []) then
        begin
          edit;
          fieldbyname('unit').value := dm.tabgoods.fieldbyname('unit').value;
          fieldbyname('gdsName').value := dm.tabgoods.fieldbyname('gdsname').value;
          FieldByName('Price').value := dm.tabgoods.fieldbyname('outprice1').value;
          FieldByName('BigPrice').value := dm.tabgoods.fieldbyname('outprice1').value;
        end;
      dm.tabgoods.GotoBookmark(SavePlace);
      dm.tabgoods.FreeBookmark(SavePlace);
    end;

  //  qryPset.fieldbyname('outPriceHist').asBoolean and
  if tabOut.fieldbyname('CustId').value <> '0' then //�������ۣ���Ҫ�ٲ�����ʷ��
    with qryOutPrice do
      begin
        close;
        sql.clear;
        Prepared := false;
        sql.Add('select * from outPriceHistory');
        sql.add('where (custid = :tmpCustID)');
        sql.add('and (gdsId =:tmpGdsID)');

        Parameters.ParamByName('tmpcustid').value := tabOut.fieldbyname('CustId').value;
        Parameters.ParamByName('tmpGdsID').value := tabOutItems.fieldbyname('gdsId').value;
        Prepared := true;
        open;
        if recordcount > 0 then //����ʷ�ۼ�¼
          begin
            tabOutItems.edit;
            taboutItems.FieldByName('Price').value := fieldbyname('price').value;
            taboutItems.FieldByName('BigPrice').value := fieldbyname('bigprice').value;
          end;
      end;
end;

procedure TDM.updateouthistory(); //ȫ��sql���Ļ�����һ��ѡ�ܶ�����ʱ�����ǻ����鷳 :(
//�����޸�Ϊ�ò������ˡ�
begin
   if tabOutItems.fieldbyname('price').value <= 0 then exit;

  if tabOut.fieldbyname('CustId').value <> '0' then //�������۵Ļ�
    // �޸���ʷ�ۼ�¼��û�еĻ�����������¼�¼
    with qryOutPrice do
      begin
        close;
        sql.clear;
        sql.Add('select * from outPriceHistory');
        sql.add('where (custid = :tmpCustID)');
        sql.add('and (GdsID =:tmpGdsID)');
        Parameters.ParamByName('tmpcustid').value := tabOut.fieldbyname('CustId').value;
        Parameters.ParamByName('tmpGdsID').value := tabOutItems.fieldbyname('gdsId').value;
        open;
        if recordcount > 0 then //����ʷ�ۼ�¼
          begin
            if tabOutItems.fieldbyname('price').value <> fieldbyname('price').value then //����ڼ�¼�����޸�
              begin
                if
                  MessageDlg(format('���ڼ�(%s , %s)���ϴ���ʷ��(%s ,  %s)��ͬ���Ժ������ڵļ�λ������?',
                  [tabOutItems.fieldbyname('price').asstring, tabOutItems.fieldbyname('bigprice').asstring,
                  fieldbyname('price').asstring, fieldbyname('bigprice').asstring]),
                    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;
                edit;
                fieldbyname('price').value := tabOutItems.fieldbyname('price').value;
                fieldbyname('bigPrice').value := tabOutItems.fieldbyname('bigprice').value;
                post;
              end; //end of if <>
          end
        else //û����ʷ�۵Ļ���insert new;
         begin
            append;
            fieldbyname('gdsid').value := tabOutItems.fieldbyname('gdsid').value;
            fieldbyname('custid').value := tabOut.fieldbyname('custid').value;
            fieldbyname('price').value := tabOutItems.fieldbyname('price').value;
            fieldbyname('bigPrice').value := tabOutItems.fieldbyname('bigprice').value;
            post;
          end;
     end; //end of with
 end; //end of procedure



procedure TDM.updateInHistory(); //ȫ��sql���Ļ�����һ��ѡ�ܶ�����ʱ�����ǻ����鷳 :(
//�����޸�Ϊ�ò������ˡ�
begin
  if tabInItems.fieldbyname('price').value <= 0 then exit;

  // �޸���ʷ�ۼ�¼��û�еĻ�����������¼�¼
  with qryInPrice do
    begin
      close;
      sql.clear;
      sql.Add('select * from InPriceHistory');
      sql.add('where (suppid = :tmpsuppID)');
      sql.add('and (GdsID =:tmpGdsID)');
      Parameters.ParamByName('tmpsuppID').value := tabIn.fieldbyname('SuppId').value;
      Parameters.ParamByName('tmpGdsID').value := tabInItems.fieldbyname('gdsId').value;
      open;
      if recordcount > 0 then //����ʷ�ۼ�¼
        begin
          if tabInItems.fieldbyname('price').value <> fieldbyname('price').value then //����ڼ�¼�����޸�
            begin
              if
                MessageDlg(format('���ڼ�(%s)���ϴ���ʷ��(%s)��ͬ���Ժ������ڵļ�λ������?',
                [tabInItems.fieldbyname('price').asstring, fieldbyname('price').asstring]),
                mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;
              edit;
              fieldbyname('price').value := tabInItems.fieldbyname('price').value;
              post;
            end; //end of if <>
        end
      else //û����ʷ�۵Ļ���insert new;
        begin
          append;
          fieldbyname('gdsid').value := tabInItems.fieldbyname('gdsid').value;
          fieldbyname('suppid').value := tabIn.fieldbyname('suppid').value;
          fieldbyname('price').value := tabInItems.fieldbyname('price').value;
          post;
        end;
    end; //end of with
end; //end of procedure


function TDM.Is_Valid_unit(gdsid: string; unitname: string): boolean; //��鵥λ�Ƿ�ϸ� ,���ϸ񣬿�������
var
  bFind: boolean;
  tmp, s: string;
  qry: tadoquery;
begin
  bFind := false;
  with qryunit do
    begin
      close;
      Parameters.ParamByName('GdsID').value := gdsId;
      open;
      while (not bfind) and (not eof) do
        begin
          if (unitname = FieldByName('baseunit').value) or //���ֵ���ڻ���ֵ��ȼ�ֵ����������
          (unitname = FieldByName('unit').value) then
            bfind := true
          else
            next;
        end;

      s := format('��ʽ��%s =       %s', [unitname, FieldByName('baseunit').asstring]);
      if (not bfind) and (MessageDlg('û�������λ����Ҫ������', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
        begin
          if (InputQuery(format('��Ʒ��� %s ������λ', [gdsid]), s, tmp)) and (tmp <> '') then
            begin
              qry := tadoquery.Create(self);
              qry.Connection := dm.DB;
              sql.Clear;
              sql.Add('insert unit values (:unit,:gdsid,:equal)');
              Parameters.ParamByName('GdsID').value := gdsid;
              Parameters.ParamByName('unit').value := unitname;
              Parameters.ParamByName('equal').value := strtofloat(tmp);
              ExecSQL;
              bfind := true;
            end; //end of if inputquwry
        end; //end of if not bfind
    end; //end of with
  result := bfind;
end;


procedure TDM.tabInNewRecord(DataSet: TDataSet);
begin
  with DataSet do
    begin
      fieldbyname('sheetid').asstring := DateNextValue(DataSet.Name);
      fieldbyname('date').value := strtodate(datetostr(now));
      fieldbyname('EmpId').value := CurrentEmpID;
      fieldbyname('defaultstoreid').value := 0;
      fieldbyname('type').value := '�վ�';
      fieldbyname('status').value := 0; //����״̬ ��0 �ݸ�     1 ������ȷ
      //       ��payamo��amo��֪�տ����    2 ������   3 ĩ����
    end;
end;

procedure TDM.tabInItemsCalcFields(DataSet: TDataSet);
begin
  with DataSet do
    begin
      Fieldbyname('amo').AsFloat := Fieldbyname('price').AsFloat *
        Fieldbyname('qua').AsFloat;
    end;
end;

procedure TDM.tabInItemsNewRecord(DataSet: TDataSet);
begin
 with DataSet do
    begin
      FieldByName('sheetId').value := dm.tabIn.FieldByName('sheetId').value;
      FieldByName('storeid').value := dm.tabIn.FieldByName('defaultstoreid').value;
    end;
end;

procedure TDM.tabInItemsGdsIdChange(Sender: TField);
var
  SavePlace: TBookmark;
begin
  with dm.tabInItems do //��Ʒ�ĳ����� ����λ
    begin
      if not dm.tabgoods.active then dm.tabgoods.open;
      SavePlace := dm.tabgoods.GetBookmark;
      dm.tabgoods.First;
      if dm.tabgoods.Locate('gdsid', fieldbyname('gdsId').Asstring, []) then
        begin
          edit;
          fieldbyname('unit').value := dm.tabgoods.fieldbyname('unit').value;
          fieldbyname('gdsName').value := dm.tabgoods.fieldbyname('gdsname').value;
          FieldByName('Price').value := dm.tabgoods.fieldbyname('InPrice').value;
        end;
      dm.tabgoods.GotoBookmark(SavePlace);
      dm.tabgoods.FreeBookmark(SavePlace);
    end;

  //  qryPset.fieldbyname('outPriceHist').asBoolean and
  with qryInPrice do
    begin
      close;
      sql.clear;
      Prepared := false;
      sql.Add('select * from InPriceHistory');
      sql.add('where (suppid = :tmpsuppID)');
      sql.add('and (gdsId =:tmpGdsID)');

      Parameters.ParamByName('tmpsuppID').value := tabIn.fieldbyname('suppID').value;
      Parameters.ParamByName('tmpGdsID').value := tabInItems.fieldbyname('gdsId').value;
      Prepared := true;
      open;
      if recordcount > 0 then //����ʷ�ۼ�¼
        begin
          tabInItems.edit;
          tabInItems.FieldByName('Price').value := fieldbyname('price').value;
        end;
    end;
end;

procedure TDM.tabOutBeforePost(DataSet: TDataSet);
begin
  {  if tabout.FieldByName('status').value > 0 then
      begin
        Showmessage('�����Ѿ���˹����������޸�');
        Dataset.Cancel;
        abort;
      end;
}end;

procedure TDM.tabInBeforePost(DataSet: TDataSet);
begin
  {  if tabIn.FieldByName('status').value > 0 then
      begin
        Showmessage('�����Ѿ���˹����������޸�');
        Dataset.Cancel;
        abort;
      end;
}end;

procedure TDM.tabOutItemsBeforePost(DataSet: TDataSet);
begin
  if tabOut.FieldByName('status').value > 0 then
    begin
      Showmessage('�����Ѿ���˹����������޸�');
      Dataset.Cancel;
      abort;
{    end
  else
    with dm.tabOutItems do
      begin
        if Fieldbyname('bigprice').Value < Fieldbyname('price').Value then
        begin
          edit ;
          Fieldbyname('bigprice').Value := Fieldbyname('price').Value;
        end;
 //      updateouthistory(); //�����������ۣ�����û�б�Ҫ�޸��� :(
 }     end;
end;

procedure TDM.tabInItemsBeforePost(DataSet: TDataSet);
begin
  if tabIn.FieldByName('status').value > 0 then
    begin
      Showmessage('�����Ѿ���˹����������޸�');
      Dataset.Cancel;
      abort;
    end   ;
 // else
 //   updateInHistory(); //�����������ۣ�����û�б�Ҫ�޸��� :(
end;  

procedure TDM.tabGoodsAfterPost(DataSet: TDataSet);
begin
   tmpgdstypeid := tabgoods.Fieldbyname('gdstypeid').Value ;
//   tabgoods.Refresh ;
end;

procedure TDM.tabGoodsNewRecord(DataSet: TDataSet);
begin
     showmessage(tmpgdstypeid);
     tabgoods.Fieldbyname('gdstypeid').Value := tmpgdstypeid;
end;

end.

