unit uFunction;

interface

uses Forms, Sysutils,comctrls,db,dbtables,uDM,utilities,uConstant;

//=================================================================
//IfHaveRight ���ܣ��ж��Ƿ���ĳһȨ�ޣ�
//            ������Qry--ִ�е�TQuery��InUser--����ϵͳ���û�(GlobalUser)��
//                  FormHint--�򿪴����Hint����,Ҫ��Ȩ�����ϱ��еĶ�Ӧ��λ��ͬ
//                  MyF--�������������ɾ�����޸ģ���ӡ����������Ӧ��Ȩ����λ����ָȨ�����ϱ� ��
//��ӡ�����Ȩ�޴���취���ô˺����ж��Ƿ��� ��ӡ������Ȩ�ޣ���Form Creat �趨��Ӧenabled,visible���ԣ�
//           ������Fm_2030;
function IfHaveRight(Qry:TQuery;InUser,FormHint,MyF : string) : boolean;
//IfDo ���ܣ�  ��� ������ɾ�����޸ĵ�Ȩ�޳�ʽ
//     ������   D����ʾ��Ϣ�磺������ɾ�����޸� ����������ͬ IfHaveRight��������
//     �÷���  ������ȷ�������˾�ŵ� ������ɾ�����޸� ǰ �¼����磺IfDo('����',Qry1,GlobalUser,Hint,'F02');
//         ������Fm_2030;
procedure IfDo(D : string;Qry:TQuery;InUser,FormHint,MyF : string);// MyF �� �����������������ɾ�����޸�����Ӧ��Ȩ�� ��D������-ɾ��-�޸�



//���¿��(���Ʒ,��Ʒ,�ͻ�����)
procedure UpdateStock(EQry: TQuery; TbNm,kind,QtyFdNm: string;  QtyFd, AutoNoFd: TField);

procedure UpdateDatumStock(EQry: TQuery; TbNm,kind,QtyFdNm: string;  QtyFd, NoFd: TField);
procedure DatumNoValidate(xQry: TQuery; TbNm: string; Sender: TField);
Procedure InforSave(xTb: TDataSet);// �ѽ�����,�޸���,����ʱ��,�޸�ʱ��������ϱ�;
Procedure InforDisplay(T: TDataSet; S: string);

//���������������
procedure UpdateRelQty(EQry: TQuery; RelTbNm,kind,QtyFdNm: string;RelNoFd,ORelNoFd,QtyFd,AutoNoFd: TField);

//���Ʒ�������ϵ�(���ʱ����)
procedure UpdateSTakeQty(EQry: TQuery; kind: string;QtyFd,RelNoFd,SemiNoFd: TField);

//ԭ�ϸ������ϵ�(���ʱ����)
procedure UpdateMTakeQty(EQry: TQuery; kind: string;QtyFd,RelNoFd,MaterNoFd: TField);
implementation

function IfHaveRight(Qry:TQuery;InUser,FormHint,MyF : string) : boolean; //MyF �� �����������������ɾ�����޸�����Ӧ��Ȩ�� ��
begin
  result := false;
  QryExec(Qry, Format('select %s as F from TUserRight where NM=''%s'' and K_SN=''%s''',
     [MyF,InUser,formHint]), False);
  qry.Open;
  if Qry.RecordCount >= 1 then
     if Qry.FieldByName('F').asboolean = true then
        result := true
     else
        result := false;
end;

procedure IfDo(D : string;Qry:TQuery;InUser,FormHint,MyF : string);// MyF �� �����������������ɾ�����޸�����Ӧ��Ȩ�� ��D������-ɾ��-�޸�
begin
  if IfHaveRight(Qry,InUser,FormHint,MyF)=false then begin
     R_OkMessage(['�Բ���,��û��'+D+'Ȩ��!'],'');
     abort;
  end;
end;

//�������ϱ��������޸ĵ���Ա�ͼ����ڵ�main��StatusBar�ϵĺ���,
//ʹ�÷��� :   InforDisplay(DataSet,'��������');
//eg :         InforDisplay(DataSet,'��������ϸ��')
Procedure InforDisplay(T: TDataSet; S: string);
begin
  Try
    TStatusBar(Application.MainForm.FindComponent('StatusBar1')).Panels[1].Text :=S + ' --> ������¼ : ' + T.FieldByName('BUser').AsString + ' - ' +T.FieldByName('Btime').AsString + ' , ' + ' ����޸ļ�¼ : ' + T.FieldByName('EUser').AsString + ' - ' + T.FieldByName('Etime').AsString;
  except
    // ���� Main Form ���Ҳ��� StatusBar1 ��������
  end;
end;

procedure UpdateStock(EQry: TQuery; TbNm,kind,QtyFdNm: string;QtyFd, AutoNoFd: TField);
begin
  if not DM.DB.InTransaction then
    DM.DB.StartTransaction;
  try
    QryExec(EQry, Format('UPDATE %s SET %s = %s %s %f WHERE AutoNo = %d',
            [TbNm, QtyFdNm, QtyFdNm,kind, QtyFd.AsFloat, AutoNoFd.AsInteger]), False);
  except
    R_OkMessage(['�ڲ���������,����������һ��!'],'');
    raise;
  end;
end;

// *************  ԭ���Լ����Ͽ����³�ʽ  ************************************//
//���÷��� :
//   UpdateDatumStock(Qry1,'ԭ.or.�����','+','���������λ', ��(��)����,��Ʒ���)
//eg:UpdateDatumStock(Qry1,'T1050','+','F04',Table2F03,Table2F02)
procedure UpdateDatumStock(EQry: TQuery; TbNm,kind,QtyFdNm: string;QtyFd, NoFd: TField);
begin
  if not DM.DB.InTransaction then
    DM.DB.StartTransaction;
  try
    QryExec(EQry, Format('UPDATE %s SET %s = %s %s%f WHERE F01 = ''%s''',
            [TbNm,QtyFdNm,QtyFdNm,kind,QtyFd.AsFloat,NoFd.AsString]), False);
  except
    R_OkMessage(['�ڲ���������,����������һ��!'],'');
    raise;
  end;
end;


// *********************  �ж���Ʒ����Ƿ����  ***************************************
procedure DatumNoValidate(xQry: TQuery; TbNm: string; Sender: TField);
begin
  if (Sender.AsString='') or Sender.IsNull then
  begin
    R_OkMessage([Sender.DisplayName],rValue_isnotnull);
    abort;
  end
  else
  begin
    // �ж������ <ԭ�� .or. ���ϱ��> �Ƿ���ȷ
    QryExec(xQry, format('Select F01 as iCnt From %s Where F01=''%s''',[TbNm,Sender.AsString]));
    if (xQry.RecordCount = 0) then
    begin
      R_OkMessage(['�ñ�Ų�����, ������������ȷ����Ʒ���!']);
      abort;
    end;
  end;
end;

//�ѽ�����,�޸���,����ʱ��,�޸�ʱ��������ϱ�,��Table��BeforPost����;
Procedure InforSave(xTb:TDataSet);
begin
 if xTb.State = dsInsert then
  begin
    xTb.FieldByName('BUser').AsString :=GlobalUser;
    xTb.FieldByName('BTime').AsDateTime :=Now;
  end;
  xTb.FieldByName('EUser').AsString :=GlobalUser;
  xTb.FieldByName('ETime').AsDateTime :=Now;
end;


procedure UpdateRelQty(EQry: TQuery; RelTbNm,kind,QtyFdNm: string;RelNoFd,ORelNoFd,QtyFd,AutoNoFd: TField);
begin
  if not DM.DB.InTransaction then
    DM.DB.StartTransaction;
  try
    QryExec(EQry, Format('UPDATE %s SET %s = %s %s %f WHERE F01 =''%s'' and F06=''%S'' and F02=%d',
            [RelTbNm, QtyFdNm, QtyFdNm,kind, QtyFd.AsFloat,RelNoFd.asstring,ORelNoFd.asstring,AutoNoFd.AsInteger]), False);
  except
    R_OkMessage(['�ڲ���������,����������һ��!'],'');
    raise;
  end;
end;


//���Ʒ�������ϵ�
procedure UpdateSTakeQty(EQry: TQuery; kind: string;QtyFd,RelNoFd,SemiNoFd: TField);
begin
  if not DM.DB.InTransaction then
    DM.DB.StartTransaction;
  try
    QryExec(EQry, Format('UPDATE T2140A SET F04 = F04 %s %f WHERE F01 =''%s'' and F02=%d',
            [kind, QtyFd.AsFloat,RelNoFd.asstring,SemiNoFd.AsInteger]), False);
  except
    R_OkMessage(['�ڲ���������,����������һ��!'],'');
    raise;
  end;
end;


//ԭ�ϸ������ϵ�
procedure UpdateMTakeQty(EQry: TQuery; kind: string;QtyFd,RelNoFd,MaterNoFd: TField);
begin
  if not DM.DB.InTransaction then
    DM.DB.StartTransaction;
  try
    QryExec(EQry, Format('UPDATE T2130A SET F04 = F04 %s %f WHERE F01 =''%s'' and F02=''%s''',
            [kind, QtyFd.AsFloat,RelNoFd.asstring,MaterNoFd.AsString]), False);
  except
    R_OkMessage(['�ڲ���������,����������һ��!'],'');
    raise;
  end;
end;



end.
