unit uConstant;

interface

const
  rKeyViol = 9729; //��ֵ�ظ�
  rMinValErr = 9730;//С���λ��Сֵ����
  rMaxValErr = 9731;//�����λ���ֵ����
  rRequiredField = 9732;//��������ֵ����λ,�����ǿյ�
  rForeignKey = 9733;//�Ҳ���һ�Զ�����������ϱ�
  rDetailExist = 9734;//�����޸Ļ�ɾ��һ�Զ�����������ϱ��¼
  rLookupTableErr = 9736;//��λֵ����LOOKUP��Χ


resourcestring

//for database error message
rValue_IsnotNull = '������"%s"��λֵ';
rValue_OverThanZero = '"%s"�����춻��ǵ�� 0';
rValue_InvalidKey = '"%s"�ļ�¼�Ѵ������ϱ���, ����������������ͬ������';
rValue_NotFind = '�Բ���! �Ҳ�������Ҫ������';



var
  sCompanyName : String;  //��˾����
  sCompanyTel  : String;  //��˾�绰
  sCompanyFax  : String;  //��˾����
  sCompanyAddr : String;  //��˾��ַ
  sAliasName   : String;  //���Ͽ����
  sComPanySName: string;  //��˾���

implementation

end.
