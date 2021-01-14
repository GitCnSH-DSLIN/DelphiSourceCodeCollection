unit func;

interface
uses
  Windows,DB,SysUtils,dbtables,Dialogs,registry,menus,Forms,jpeg,SConnect,ObjBrkr,
  graphics,classes,DBGrids,StdCtrls, GD_Chain_Server_TLB,variants,ComCtrls,ExtCtrls,DBClient,Grids;

Function WriteRegFile(menth:integer;keyname:String;Regkey:variant):variant;
Function ReadRegFile(menth:integer;keyname:String):variant;
Function ExistsRegKey(keyname:string):boolean;
Function DeleteRegKey(keyname:string):boolean;
Function GetFontStyle(FontNo:integer):TFontStyles;
Function Encrypt(EncryptStr,EncryptKey:string):string;
Function Decrypt(DecryptStr,EncryptKey:string):string;
Function Small2Big(SourceMoney:Currency):string;
procedure setnull(f_from:TForm);
procedure createinter;  //�����ӿ�  wg
procedure detroy;   //�ͷŽӿ�;       wg
function Cmd_Check_Filsh(no:string):boolean;  //�������Ƿ������� wg
function setCode(sql:string;maks:string):string; //auto id; wg
function selectpy( values:string):string; //ƴ��ת��; wg
procedure ckbEdit(ckb:TCheckBox;edt:TEdit);///
procedure ckbEdits(ckb:TCheckBox;edt1,edt2:TEdit); //
procedure ckbCmb(ckb:TCheckBox;cmb:TComboBox);//
procedure ckbDtps(ckb:TCheckBox;dtp1,dtp2:TDateTimePicker);//����
///2004-4-9 add ���ڴӷ�����ȡ�ñ�������Ա��
procedure GetDataToComBoX(cmbman:TcomboBox;tempsql:string;XsFieldName:string);
procedure loadborlanced(cdsname:TClientDataSet);  //���ؾ���
function simpe(sockets:TSocketConnection;simpename:TSimpleObjectBroker):boolean;
procedure savefromdata(cdsname:TClientDataSet;dataname:string);//�洢����
function GetKeyFieldValue(sortField:string;clientdb:TClientDataSet): OleVariant;
//procedure DeleteRow(Row:Integer);
procedure getlock(m:string;index,count:integer);
function SetPass(List_No:string):boolean; //����ֻ�ܳ���һ�Σ�
function SetPassed(List_No:string):boolean;
procedure SortGrid(filedbynames:string;CdsTable:Tclientdataset;GridBase:tdbgrid;column: TColumn);  //����

procedure GetValuesData(Mcmb:tcombobox);  //������ݣ�
procedure SetValuesData (Mcmb:tcombobox); //ȡ����;
procedure SetDbgrid( grid:tdbgrid;index:integer); //����DBGRID�Ĺ̶���
function DelRow(var StrGrid:TStringGrid;Arow:integer):boolean;
function clearGrid(var Grid:TStringGrid):boolean;
procedure RefreshOrd(var Grid:TStringGrid);
function GetDataPrint(recipient,GETclient:tClientdataset):boolean;
procedure GetCopyGrid(souce,client:tstringgrid);

var
  dbgCur:TDBGrid; //����
  no,typed:widestring; //wg edit ; �����ź��������
  Font_Style:array[0..4] of TFontStyles;
  //***�������************
  tempselect:string;
  man_Select:String;//�����Ա
  man_no:string;//����˱��;
  Man_Public_Code:string; //��˴���('SH_01,SH_02,SH_03,SH_04,SH_05)
  LevelType{��������},LevelCount{��˼���},ExamineMan{�����Ա}:String;
  LevelSeries:string;//��������
  //***�������************
  //��Ʒ���ѡ��
  CheckDo:String;//������Ϣ������ѡ���������
  Do_Result:String;//������Ϣ������ѡ���������ѡ������
  Public_Do:String;
  Public_Do_Result:String;
  String_Col:Integer;  //Stringrid  �ĵڼ���
  Check_Mond,check_Mond_Result:String;
  Check_Storage,Check_Storage_Result,Check_Storage_Result_NO:String;
  Employe_Check,Employe_Check_Result,Employe_type:String;
  //*********��Ʒ������Ϣ����Ĺ�����������********************
  Subject_Str:string;//��������
  Subject_No:string; //ѡ����
  Subject_Name:string; //ѡ����
  Subject_Back:string; //ѡ����
  Subject_Facility:string; //ѡ����
  //*****************************
  G_Modal,G_Cards,G_Brand:String;
  //************************���****************************
  Collate_Str,Collate_Result:String;
  SH_Level:Integer;//��˼���
  ExamineMan1,ExamineMan2,ExamineMan3,ExamineMan4,ExamineMan5:String;//�����
  ee1,ee2,ee3,ee4,ee5:string;//����˱���
  LevelName1,LevelName2,LevelName3,LevelName4,LevelName5:String;//�������
  Flag1,Flag2,Flag3,Flag4,Flag5:Integer;

  List_NO:string;//���ݱ��
  Goods_No_Str,Goods_Name_Str:String;//��Ʒ��� \��Ʒ����
  Goods_Check_str:String;//��Ʒѡ��
  /////////////////////////////////////////////
  Handle_Man:String;//����Ա����
  Handle_No:String;//����Ա���
  Handle_Part:String;//����Ա����
  shopid:widestring;//���Ŷ�Ӧ�ֿ���
  tablename:string;
  //////////////////////////////////////
  wldwno,officeid:string;//������λ���,�������벿�ű��,�������ű��;
  ////////////////////////////////////////
  LHXZ_Str,LHXZ_Str_Result,LHXZ_Str_List_NO:String;//����ѡ��
  ZLXZ_Str,ZLXZ_Str_Result,ZLXZ_Str_List_NO:String;//����ѡ��
  Contract_Check_Str,Contract_Check_Result_Str:String;//��ͬѡ��
  ChildShop_Str,ChildShop_Result_NO,ChildShop_Result_Name:String;//����ѡ��
  Stock_Contract_Str,Stock_Contract_NO:String; //�ɹ���ͬ
  Storage_No_Str,Storage_Name_Str,Stock_States_Detail_str:String;//���״��
  Sign_Search_str,Sign_Search_Result_str:String;//��Ʒ��ѯ
  Storage_Up_Limit,Storage_Down_Limit:String;//�������������
  Storage_Warn_Limit_Set:string;//����ϡ���������
  CK_MC,SP_MC:String;//�ֿ����ơ���Ʒ���ƣ�
  Str_KD,Str_KS,Str_JS:String;//�仯���ȣ���ʼ��������������
  BH_Count:integer;//�仯����
  Str_NO:String;//��Ʒ����༭����
  Str_Part_No,Str_part_Name,Str_Part_Code:String;//���Ŵ��룬�������ƣ�
  //***************���Ԥ���򵼹���
  Storage_Guide_Name,Storage_Guide_NO,Storage_Guide_Type,Storage_Guide_Str:String;
  //***************
  //���������
  begin_build_str:string;
  adisp:IEasy_Dcom_ServerDisp;//�ӿ�������̬�����ӿ� ;
  ipubtemp:IPublicServerDisp;
  p_name:tstringlist; //���ű�ż�
  partname,Fpartname:tstringlist;//�������Ƽ������ಿ�����Ƽ�
  stockinput:string;  //��ⵥ���
  /////////////////////
  /////ϵͳ����//////
  len:integer; //���ݱ�ų���;
  loginlock: array [0..250] of integer;
  Skinid:integer;//Ƥ����ţ�
  ///////////////////////////////
  Mstorage:tstringlist;
  LocalB:boolean;//�Ƿ�Ϊ�ֿܲ⣻
  qx,qxstr:string;//Ȩ���ַ���;
  ReCheck:integer;//��¼�������յ�ǰ��״̬����

  ShowLimit,Color:integer;  //ϵͳ����;
  BEdit:boolean;//�Ƶ��޸�״̬
  //////////////////////
  implementation

uses  main, Data, untdatadm;
procedure loadborlanced(cdsname:TClientDataSet);  //���ؾ���
begin
  try
    cdsname.ApplyUpdates(-1);
  except
    simpe(dmmain.socketpublic,frm_data.Simple);
  end;
end;
function Cmd_Check_Filsh(no:string):boolean;
var
  sqlquery:widestring;
begin
  sqlquery:=' select Check_Result from receipt where Check_Result=5 and Receipt_No='+''''+trim(no)+'''';
  dmmain.CDSquery2.Close;
  dmmain.CDSquery2.Data:=adisp.resultrecord(sqlquery);
  dmmain.CDSquery2.Open;
  if dmmain.CDSquery2.IsEmpty then
  begin
    result:=false;
  end else
  begin
    result:=true;
  end;
end;

procedure savefromdata(cdsname:TClientDataSet;dataname:string);
begin
  cdsname.SaveToFile(ExtractFilePath(application.ExeName)+trim(dataname),dfxml);
end;

function simpe(sockets:TSocketConnection;simpename:TSimpleObjectBroker):boolean;
begin
  sockets.Close;
  //simpename.SetConnectStatus(sockets.Address,false);
  sockets.Address:=simpename.GetComputerForProgID(sockets.host);
  try
    sockets.Open;
    result:=true;
  except
    result:=false
  end;
end;
Function GetCurImage(CurStr:string):integer;
var
    len:integer;
    tempstr:string;
begin
    tempstr:=trim(CurStr);
    len:=length(tempstr);
    if (len mod 2)=0 then
    begin
        tempstr:=copy(tempstr,length(tempstr)-1,2);
    end
    else
    begin
        tempstr:=copy(tempstr,length(tempstr),1);
        Result:=strtoint(tempstr);
    end;
end;

Function strtohex(instr:string):string;
var
   i:integer;
   asc:integer;
   hexstr:string;
begin
    Result:='';
    for i:=1 to length(instr) do
    begin
        asc:=ord(instr[i]);
        hexstr:=inttohex(asc,2);
        Result:=Result+hexstr;
    end;
end;

Function hexstrtodecstr(instr:string):string;
var
    hexstr1,hexstr2:string;
    decint,i:integer;
begin
    try
    Result:='';
    i:=1;
    while not (i>length(instr)) do
    begin
        hexstr1:=copy(instr,i,1);
        if hexstr1='A' then hexstr1:='10';
        if hexstr1='B' then hexstr1:='11';
        if hexstr1='C' then hexstr1:='12';
        if hexstr1='D' then hexstr1:='13';
        if hexstr1='E' then hexstr1:='14';
        if hexstr1='F' then hexstr1:='15';

        hexstr2:=copy(instr,i+1,1);
        if hexstr2='A' then hexstr2:='10';
        if hexstr2='B' then hexstr2:='11';
        if hexstr2='C' then hexstr2:='12';
        if hexstr2='D' then hexstr2:='13';
        if hexstr2='E' then hexstr2:='14';
        if hexstr2='F' then hexstr2:='15';

        decint:=strtoint(hexstr1)*16+strtoint(hexstr2);
        Result:=Result+chr(decint);
        i:=i+2;
    end;
    except
        Result:='False';
    end;
end;

Function Encrypt(EncryptStr,EncryptKey:string):string;
var
    i,j,icount:integer;
    s1,s2,tempstr:string;
    asc1,asc2,asc3:integer;
begin
    Result:='';
    s1:=EncryptStr;
    s2:=EncryptKey;
    icount:=length(s1) div 3;
    j:=1;

    for i:=1 to icount do
    begin
        tempstr:=copy(s1,(i-1)*3+1,3);
        asc1:=strtoint(tempstr);
        asc2:=ord(s2[j]);
        j:=j+1;
        if j>length(s2) then
        j:=1;

        asc3:=asc1 xor asc2;
        Result:=Result+chr(asc3);
    end;
end;

Function Decrypt(DecryptStr,EncryptKey:string):string;
var
    i,j:integer;
    str:char;
    s1,s2:string;
    asc1,asc2,asc3:integer;
begin
    Result:='';
    s1:=DecryptStr;
    s2:=EncryptKey;
    j:=1;

    for i:=1 to length(s1) do
    begin
        str:=s1[i];
        asc1:=ord(str);
        asc2:=ord(s2[j]);
        j:=j+1;
        if j>length(s2) then
            j:=1;
        asc3:=asc1 xor asc2;
        Result:=Result+formatfloat('000',asc3);
    end;
    Result:=trim(Result);
end;

function GetFontStyle(FontNo:Integer):TFontStyles;
begin
    Result:=[];
    case FontNo of
        3: Result:=[fsBold,fsItalic];
        2: Result:=[fsItalic];
        1: Result:=[fsBold];
        else Result:=[];
    end;
end;


Function writeselfdog(var selfstr:string;port:integer):integer;
type
    TDataProc=Function(num: Integer; data: Pchar):integer;cdecl;//stdcall;
var
    re      :integer;
    hLib      :Thandle;
    DataProc  :TDataProc;
begin
    hLib:=LoadLibrary('Dec.dll');
    if hLib<32 then
    begin
        result:=-2;
        exit;
    end;
    DataProc:=TDataProc(GetProcAddress(hLib,'SetData'));
    re:=DataProc(port,@selfstr[1]);
    FreeLibrary(hLib);
    result:=re;
end;

Function WriteRegFile(menth:integer;keyname:String;Regkey:variant):variant;
var
    tempkey :string;
    tempregkey :Tregistry;
begin
    tempregkey:=TRegistry.create;
    try
        tempkey:='\SOFTWARE\minipacs';
        tempregkey.RootKey := HKEY_LOCAL_MACHINE;
        tempregkey.OpenKey(tempkey,TRUE);

        case menth of
            1:
            begin
                tempregkey.WriteInteger(keyname,Regkey);
                result :=tempregkey.ReadInteger(keyname);
            end;
            2:
            begin
                tempregkey.WriteString(keyname,Regkey);
                result:=tempregkey.ReadString(keyname);
            end;
            3:
            begin
                tempregkey.WriteBool(keyname,Regkey);
                result:= tempregkey.ReadBool(keyname);
            end;
        end;
    finally
        tempregkey.closekey;
        tempregkey.destroy;
    end;
end;

Function ReadRegFile(menth:integer;keyname:String):variant;
var
    tempkey :string;
    tempregkey :Tregistry;
begin
    tempregkey:=TRegistry.create;
    try
        tempkey:='\SOFTWARE\minipacs';
        tempregkey.RootKey := HKEY_LOCAL_MACHINE;
        tempregkey.OpenKey(tempkey,TRUE);
        case menth of
            1:Result:=tempregkey.ReadInteger(keyname);
            2:Result:=tempregkey.ReadString(keyname);
            3:Result:=tempregkey.ReadBool(keyname);
        end;
    finally
        tempregkey.closekey;
        tempregkey.destroy;
    end;
end;

Function ExistsRegKey(keyname:string):boolean;
var
    tempkey       :string;
    tempregkey    :Tregistry;
begin
    tempregkey:=TRegistry.create;
    try
        tempkey:='\SOFTWARE\minipacs';
        tempregkey.RootKey := HKEY_LOCAL_MACHINE;
        tempregkey.OpenKey(tempkey,TRUE);
        if tempregkey.valueexists(keyname) then
            result:= true
        else
            result:= false;
    finally
        tempregkey.closekey;
        tempregkey.destroy;
    end;
end;

Function DeleteRegKey(keyname:string):boolean;
var
    tempkey:string;
    tempregkey:Tregistry;
begin
    tempregkey:=TRegistry.create;
    try
        tempkey:='\SOFTWARE\minipacs';
        tempregkey.RootKey := HKEY_LOCAL_MACHINE;
        tempregkey.OpenKey(tempkey,TRUE);
        if tempregkey.valueexists(keyname) then
        begin
            tempregkey.DeleteKey(keyname);
            result:= true
        end
        else
            result:= false;
    finally
        tempregkey.closekey;
        tempregkey.destroy;
    end;
end;

Procedure Change_Bmp_To_Jpeg(var bmpfile,jpgFile:String; compressquality:integer);
var
    jpegimg :Tjpegimage;
    bmpimg:TBitMap;
begin
    jpegimg:=nil;
    bmpimg:=nil;
    try
        try
            jpegimg :=Tjpegimage.create;
            bmpimg  :=TBitMap.create;
            bmpimg.loadfromfile(bmpfile);
            Jpegimg.compressionQuality:=compressquality;
            Jpegimg.Assign(bmpimg);
            Jpegimg.Compress ;
            Jpegimg.SaveToFile(jpgFile);
            deletefile(bmpfile);
        except
            MessageBeep(0);
            Application.MessageBox('��ǰͼ��ת������!','����!',0);
            exit;
        end;
    finally
        if jpegimg<>nil then
            jpegimg.free;
        if bmpimg<>nil then
            bmpimg.free;
    end;
end;

Function Get_Part_Path(filename :string):string;
var
    len,i :integer;
begin
    len :=length(filename);
    for i:=len downto 1 do
    begin
        if filename[i]='\' then
            break;
    end;
    result :=copy(filename,1,i-1)
end;
//ת����д���
function Small2Big(SourceMoney:Currency):string;
var
    //strSourceMoney����δת����Сд�ַ�����strSourceMoney������ת���Ĵ�д�ַ���
    strSourceMoney,strObjectMoney:string;
    //ThisWeiΪ��ǰλ�Ĵ�д��ThisPosΪ��ǰλ������ҵ�λ
    ThisWei,ThisPos:string[2];
    //iWeiΪ��ǰλ��,posPointΪС�����λ��
    iWei,posPoint:integer;
begin
    strSourceMoney :=formatfloat('0.00',SourceMoney);//��������ת����ָ����ʽ�ַ���
    posPoint:= pos('.', strSourceMoney);    // С�����λ��
    //ѭ��Сд���ҵ�ÿһλ����Сд���ұ�λ�õ����
    for iWei :=length(strSourceMoney) downto 1 do
    begin
        case strSourceMoney[iWei] of      //ת����ǰ����
            '.':Continue;					//�����С���㣬�򲻽���ת������
            '1':ThisWei:='Ҽ'; '2': ThisWei:='��';
            '3': ThisWei:='��'; '4': ThisWei:='��';
            '5': ThisWei:='��'; '6': ThisWei:='½';
            '7': ThisWei:='��'; '8': ThisWei:='��';
            '9': ThisWei:='��'; '0': ThisWei:='��';
        end;
        case PosPoint-iWei of              //��õ�ǰ����ҵ�λ
            -3:ThisPos:='��';-2:ThisPos:='��';
            -1:ThisPos:='��';1 :ThisPos:='Ԫ';
            2 :ThisPos:='ʰ';3 :ThisPos:='��';
            4 :ThisPos:='ǧ';5 :ThisPos:='��';
            6 :ThisPos:='ʰ';7:ThisPos:='��';
            8 :ThisPos:='ǧ';9 :ThisPos:='��';
            10 :ThisPos:='ʮ';11:ThisPos:='��';
            12:ThisPos:='ǧ';
        end;
    strObjectMoney :=ThisWei+ThisPos+strObjectMoney;//��ϳɴ�д���
    end;
Small2Big:=strObjectMoney;      //
end;
//
Procedure InitFontArray;
begin
  Font_Style[0] :=[fsBold];
  Font_Style[1] :=[fsBold];
  Font_Style[2] :=[fsItalic];
  Font_Style[3] :=[fsUnderline];
  Font_Style[4] :=[fsStrikeOut];
end;
procedure setnull(f_from:TForm);  //���EDIT������ݣ�
var
  i,j:integer;
begin
  for i:=0 to f_from.ComponentCount-1 do
  begin
  if (f_from.Components[i] Is TCustomEdit) then
    (f_from.Components[i] as TCustomEdit).Clear;
  if (f_from.Components[i] Is TStringGrid) then
  begin
    for j:=1 to (f_from.Components[i] as TStringGrid).RowCount-1 do   //������񣬲���ֻ��ȥ�У������´��½�ʱ�����ظ�����
      (f_from.Components[i] as TStringGrid).Rows[j].Clear;
    (f_from.Components[i] as TStringGrid).RowCount:=2;
  end;  


end;
end;

procedure createinter;  //�����ӿ�
begin
  adisp:=IEasy_Dcom_Serverdisp(Idispatch(frm_data.Socket_Connection.appserver));
  ipubtemp:=IPublicServerDisp(idispatch(dmmain.socketpublic.appserver));
  if MSTorage=nil then
  Mstorage:=tstringlist.Create;
end;
procedure detroy;   //�ͷŽӿ�;
begin
  adisp:=nil;
  ipubtemp:=nil;
  Mstorage.Free;
  Mstorage:=nil;
end;

function setCode(sql:string;maks:string):string; //������ţ�����
var
  s_NewDate:String;
  sqls,make:wideString;
  s_Date:String;
  s_Code:olevariant;
begin
  s_Date:=FormatDateTime('yymmdd',now());
  if trim(maks)>'' then
  begin
    make:=maks+s_date;
  end;
  sqls:=sql;
  try
  ipubtemp.autoid(sqls,make,s_code); //���ýӿڷ�������
  except
  application.MessageBox('��������ֹ����',pchar(application.Title),mb_iconwarning);
  exit;
  end;
  result:=trim(vartostr(s_Code));
end;

function selectpy( values:string):string; //ƴ��ת��;
var
  i,j:integer;
  s1,s2:string;
begin
  s1:=trim(values);
  i:=1;
  j:=length(s1);

  while i<=length(s1) do
  begin
  case WORD(s1[i]) shl 8 + WORD(s1[i+1]) of
    $B0A1..$B0C4 : s2 :=s2+ 'A';
    $B0C5..$B2C0 : s2 :=s2+ 'B';
    $B2C1..$B4ED : s2 :=s2+ 'C';
    $B4EE..$B6E9 : s2 :=s2+ 'D';
    $B6EA..$B7A1 : s2 :=s2+ 'E';
    $B7A2..$B8C0 : s2 :=s2+ 'F';
    $B8C1..$B9FD : s2 :=s2+ 'G';
    $B9FE..$BBF6 : s2 :=s2+ 'H';
    $BBF7..$BFA5 : s2 :=s2+ 'J';
    $BFA6..$C0AB : s2 :=s2+ 'K';
    $C0AC..$C2E7 : s2 :=s2+ 'L';
    $C2E8..$C4C2 : s2 :=s2+ 'M';
    $C4C3..$C5B5 : s2 :=s2+ 'N';
    $C5B6..$C5BD : s2 :=s2+ 'O';
    $C5BE..$C6D9 : s2 :=s2+ 'P';
    $C6DA..$C8BA : s2 :=s2+ 'Q';
    $C8BB..$C8F5 : s2 :=s2+ 'R';
    $C8F6..$CBF9 : s2 :=s2+ 'S';
    $CBFA..$CDD9 : s2 :=s2+ 'T';
    $CDDA..$CEF3 : s2 :=s2+ 'W';
    $CEF4..$D188 : s2 :=s2+ 'X';
    $D1B9..$D4D0 : s2 :=s2+ 'Y';
    $D4D1..$D7F9 : s2 :=s2+ 'Z';
    end;
    i:=i+2;
  end;
  result:=s2;
end;

procedure ckbEdit(ckb:TCheckBox;edt:TEdit);
begin
  if ckb.Checked then
  with edt do
  begin
    ReadOnly:=false;
    Color:=clCream;
    SetFocus;
  end;
  if ckb.Checked=false  then
  with edt do
  begin
    ReadOnly:=true;
    Color:=cl3DLight;
    Text:='';
  end;
end;
procedure ckbEdits(ckb:TCheckBox;edt1,edt2:TEdit);
begin
   if ckb.Checked then
  begin
    edt1.ReadOnly:=false;
    edt1.Color:=clCream;
    edt1.SetFocus;
    edt2.ReadOnly:=false;
    edt2.Color:=clCream;
  end;
  if ckb.Checked=false then
  begin
    edt1.ReadOnly:=true;
    edt1.Color:=cl3DLight;
    edt1.Text:='';
    edt2.ReadOnly:=true;
    edt2.Color:=cl3DLight;
    edt2.Text:='';
  end;
end;
procedure ckbCmb(ckb:TCheckBox;cmb:TComboBox);
begin
  if ckb.Checked then
  with cmb do
  begin
    ItemIndex:=0;
    Color:=clCream;
    SetFocus;
  end;
  if ckb.Checked=false  then
  with cmb do
  begin
    ItemIndex:=-1;
    Color:=cl3DLight;
    Text:='';
  end;
end;
procedure ckbDtps(ckb:TCheckBox;dtp1,dtp2:TDateTimePicker);
begin
  if ckb.Checked then
  begin
    dtp1.Color:=clCream;
    dtp1.SetFocus;
    dtp2.Color:=clCream;
  end;
  if ckb.Checked=false then
  begin
    dtp1.Color:=cl3DLight;
    dtp2.Color:=cl3DLight;
  end;
end;

procedure GetDataToComBoX(cmbman:TcomboBox;tempsql:string;XsFieldName:string);
var
  fh_rs:OleVariant;
  TempTbl:TClientDataset;
begin
  cmbman.Clear;
  ipubtemp.ty_query(tempsql,fh_rs);
  if not  varisnull(fh_rs) then
  begin
    TempTbl := TClientDataset.Create(nil);
    try
    with TempTbl do
    begin
        Data := fh_rs;
        Open;
        first;
        while not  Eof   do
        begin
        cmbMan.AddItem(fieldbyname(XsFieldName).AsString,Nil);
        Next;
        end;
        Close;
    end;
    finally
    TempTbl.Free;
    end;
    cmbMan.ItemIndex := 0;
 end;
end;

function GetKeyFieldValue(sortField:string;clientdb:TClientDataSet): OleVariant;
var
  aCDS : TClientDataSet;
begin
  aCDS:=TClientDataSet.Create(nil);
  try
   try
     if not varisnull(clientdb.Data) then
  begin
  ///������°�����������󣬴˴����ܲ����� ����ydy
  aCDS.Data:=clientdb.Data;  //ClientDataSet1.Data;
  //ydy 2004-2-18 add
      WITH acds do begin
          IndexName := '';
          IndexDefs.Update;
      end;
      with aCDs.IndexDefs.AddIndexDef do
          begin
            Fields := sortField;  //��ͬ��˴���ͬ'sg_id'; //AFields;
            Options := [];
          end;
  aCDs.IndexDefs.Update;
  ///////////

  aCDS.Last;
  //Result:=aCDS.FieldByName('SG_id').Value;
  Result:=aCDS.FieldByName(sortfield).Value;
  end;
  finally // wrap up
  aCDS.Free ;
  end; // try/finally
  except
  on e: Exception do
  raise;
  end; // try/except
end;

procedure getlock(m:string;index,count:integer);
var
  i,j:integer;
begin
  case index of
 1: begin
      if pos('CG',m)<>0 then
      begin
        qxstr:=qxstr+copy(m,pos('CG',m)+2,(Count));
      end;
    end;
  2:begin
      if pos('ST',m)<>0 then
      begin
        qxstr:=qxstr+copy(m,pos('ST',m)+2,(Count));
      end;
  end;
  3:begin
      if pos('PS',m)<>0 then
      begin
        qxstr:=qxstr+copy(m,pos('PS',m)+2,(Count));
      end;
   end;
  4:begin
      if pos('BASE',m)<>0 then
      begin
        qxstr:=qxstr+copy(m,pos('BASE',m)+4,(Count));
      end;
    end;
  5:begin
      if pos('Sys',m)<>0 then
      begin
        qxstr:=qxstr+copy(m,pos('Sys',m)+3,(Count));
      end;
    end;
  6:begin
      if pos('Mon',m)<>0 then
      begin
        qxstr:=qxstr+copy(m,pos('Mon',m)+3,(Count));
      end;
    end;
  7:begin
      if pos('Cw',m)<>0 then
      begin
        qxstr:=qxstr+copy(m,pos('Cw',m)+2,(Count));
      end;
    end;
  end;
  for i:=1 to 250 do
  begin
     if i>length(qxstr) then  loginlock[i-1]:=0
     else
    loginlock[i-1]:=strtoint(copy(qxstr,i,1));
  end;
end;

function SetPass(List_No:string):boolean; //����ֻ�ܳ���һ�Σ�
var
  sqlpub:widestring;
begin
  result:=false;
  try
  sqlpub:='update receipt set check_result=7 where receipt_no='+''''+trim(list_no)+'''';
  ipubtemp.scrapsate(sqlpub);
  result:=true;
  except
  end;
end;
function SetPassed(List_No:string):boolean;
var
  sqlpub:widestring;
begin
  result:=false;
  try
  sqlpub:='update receipt set check_result=8 where receipt_no='+''''+trim(list_no)+'''';
  ipubtemp.scrapsate(sqlpub);
  result:=true;
  except
  end;
end;
procedure SortGrid(filedbynames:string;CdsTable:Tclientdataset;GridBase:tdbgrid;column: TColumn);  //����
var
  i,j,p:integer;
begin
  if not GridBase.DataSource.DataSet.Active then exit;
  j:=GridBase.Columns.Count-1;
  for i:=0 to j do
  begin
    p:=pos('��',trim(GridBase.Columns.Items[i].Title.Caption));
    if p>0 then
     GridBase.Columns.Items[i].Title.Caption:=copy(GridBase.Columns.Items[i].Title.Caption,1,p-1);
  end;
   WITH CdsTable do
   begin
    IndexName := '';
    IndexDefs.Update;
   end;
   CdsTable.AddIndex(filedbynames,filedbynames,[],'',filedbynames); //��������
   CdsTable.IndexName:=filedbynames;
   CdsTable.IndexDefs.Update;
  column.Title.Caption:=column.Title.Caption+'��';
  gridbase.Refresh;
end;

procedure GetValuesData(Mcmb:tcombobox);  //������ݣ�
var
  i:integer;
begin
  for i:=0 to mstorage.Count-1 do
  begin
    Mcmb.Items.Add(trim(Mstorage.Strings[i]));
  end;
end;
procedure SetValuesData (Mcmb:tcombobox); //ȡ����;
var
  i:integer;
begin
   for i:=0 to mcmb.Items.Count-1 do
  begin
    Mstorage.Add(trim(mcmb.Items.Strings[i]));
  end;
end;

procedure SetDbgrid( grid:tdbgrid;index:integer); //����DBGRID�Ĺ̶���
begin
  tstringgrid(grid).FixedCols:=index;
end;

function clearGrid(var Grid:TStringGrid):boolean;
var i:integer;
begin
   for i:=1 to Grid.RowCount-1 do
      Grid.Rows[i].Clear;
   RefreshOrd(Grid);
   Result:=true;
end;
//ɾ����
function DelRow(var StrGrid:TStringGrid;Arow:integer):boolean;
var
  i,n,Acol:integer;
begin
  Result := True;
  if Arow=0 then
  begin
    Result := False;
    Exit;
  end;
  Try
    n := Arow;
    Acol := StrGrid.ColCount-1;
    while n<StrGrid.RowCount do
    begin
      for i:=1 to Acol do
        StrGrid.Cells[i,n] := StrGrid.Cells[i,n+1];
      inc(n);
    end;
    if StrGrid.RowCount>2 then StrGrid.RowCount:=StrGrid.RowCount-1;
  Except
    Result := False;
  End;
end;

procedure RefreshOrd(var Grid:TStringGrid);
var i:integer;
begin
  for i:=1 to Grid.RowCount-1 do
    begin
     Grid.Cells[0,i]:=inttostr(i);
    end;
end;


function GetDataPrint(recipient,GETclient:tClientdataset):boolean;
begin
  result:=false;
  recipient.Close;
  recipient.Data:=null;
  recipient.data:=getclient.Data;
  recipient.Open;
  if not varisnull(recipient.Data) then
  begin
    getclient.Close;
    getclient.Data:=null;
  end;
  result:=true;
end;


procedure GetCopyGrid(souce,client:tstringgrid);
var
  i,j,t,b:integer;
  s:string;
begin
  souce.RowCount:=client.RowCount;
  souce.ColCount:=1 ;
  for i:=0 to client.ColCount-1 do
  begin
    if client.ColWidths[i]>0 then
    begin
      souce.ColWidths[souce.ColCount-1]:= client.ColWidths[i];
      souce.ColCount :=souce.ColCount+1 ;
    end;
    for j:=0 to client.RowCount-1 do
    begin
      //souce.Rows[j].Clear;
      if client.ColWidths[i]>0 then
      begin
        souce.cells[souce.ColCount-1,j]:=client.cells[i,j];
      end;
    end;
  end;
  j:=0;
  for i:=0 to souce.ColCount-1 do
  begin
    if trim(souce.Cells[i,0])='' then
    begin
      inc(j);
    end;
  end;
  if j>0 then
  begin
    for i:=0 to souce.ColCount-1 do
    begin
      souce.Cols[i]:=souce.Cols[i+1];
    end;
  end;
  souce.ColCount:=souce.ColCount-j+1;
end;

end.
