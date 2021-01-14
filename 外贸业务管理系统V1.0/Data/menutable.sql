/*ϵͳ�˵�*/
if exists(select name from sysobjects where name='t_SysMenu')
   drop table t_SysMenu
create table t_SysMenu
(
 menucode char(8) primary key,
 menuname varchar(26),
 menuclass char(2),
 menuID bit default 0,
 menuOrder char(5) default '00000')

--�����һ���˵���menuclass��Ϊ'2',���˵���Ϊ'1',���menuID��Ϊ'0',��ʾû�еڶ������Ӳ�ѯ(����,�޸�,ɾ��,��ѯ,���),
--����Ǳ�ʾ�еڶ���,���Ҷ��еĻ�����menuIDΪ'1',��ֻ������,����menuorderΪ'10000',���еĻ���menuorderΪ'11111'
go
--ϵͳ����
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('010000','ϵͳ����','1','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('010100','�û�������','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('010200','��¼','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('010300','������','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('010500','Ȩ�޹���','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('010600','���ݱ���','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('010700','���ݻָ�','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('010800','�����޸�','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('010900','������ݿ�','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('010400','�˳�','2','0','00000')

--���۹���
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('020000','���۹���','1','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('020100','�ͻ���Ϣ¼��','2','1','11110')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('021400','���ʦ����','2','1','11110')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('020200','�ͻ�ԤԼ','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('020300','CAD ���','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('020400','���۵�','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('020500','��ͬ����','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('020600','�µ�������','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('020700','��װ����','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('020800','��Ʒ����̨�ʲ�ѯ','2','0','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('020900','�ͻ�����','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('021000','�����տ����','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('021100','��ư���','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('021200','�����տ����','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('021300','��Ƶ�ȷ��','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('022000','�����տ','2','1','11110')

--���۹���
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('030000','���۹���','1','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('030100','���̲��ϲ�ѯ','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('030200','���̱��۵�','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('030300','��Ա����','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('030400','�Զ��幤�̱���','2','0','00000')

insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('030600','ְ�ƶ�λ��׼','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('030700','Ա����λ���','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('030800','����������','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('031000','��ɲ�������','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('032000','���۹���ͳ��','2','0','00000')

--�ɹ�����
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('050000','�ɹ�����','1','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('050200','�ɹ�������-ԭ��','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('050100','�ɹ��ƻ���-ԭ��','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('050300','Ԥ�����뵥-ԭ��','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('050400','�ɹ�������-ԭ��','2','1','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('051100','�ɹ�������-����','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('051200','�ɹ��ƻ���-����','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('051300','Ԥ�����뵥-����','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('051400','�ɹ�������-����','2','1','00000')

--ԭ�Ϲ���
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('060000','ԭ�Ϲ���','1','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('060100','ԭ�����','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('060200','����->��Ӧ��','2','1','11110')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('060300','ԭ������','2','1','10010')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('060400','�˿�->�ֿ�','2','1','11110')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('060500','ԭ�Ͽ�����','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('060600','ԭ�ϸ���������-ԭ��','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('060700','ԭ��Ӧ����-ԭ��','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('060800','ԭ��Ӧ�������-ԭ��','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('060900','�����ϸ-ԭ��','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('061000','���ͳ��-ԭ��','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('061100','��澯��-ԭ��','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('061200','��������-ԭ��','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('061500','ԭ�ϱ���-ԭ��','2','1','11110')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('069900','��Ӧ�̵���-ԭ��','2','1','11110')

--���̹���
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('100000','���̹���','1','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('100100','��ⵥ','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('100200','���ϵ�->��Ӧ��','2','1','11110')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('100300','���ϵ�','2','1','10010')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('100400','�˿ⵥ->�ֿ�','2','1','11110')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('100500','ԭ�Ͽ�����','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('100600','ԭ�ϸ���������-����','2','1','11111')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('100700','ԭ��Ӧ����-����','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('100800','ԭ��Ӧ�������-����','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('100900','�����ϸ-����','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('101000','����嵥-����','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('101100','��澯��-����','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('101200','��������-����','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('101500','ԭ�ϱ���-����','2','1','11110')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('101600','������Ŀ¼��','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('109900','��Ӧ�̵���-����','2','1','11110')

--��������
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('970000','��������','1','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('970100','���Ƶ���','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('970200','��Ʒ����','2','1','11110')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('970300','Ա������','2','1','11110')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('970400','��Ӧ��ԭ�ϵ���','2','1','11110')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('970500','CAD ���','2','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('970600','������Ŀ����','2','1','11110')

--����
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('990000','����','1','0','00000')
insert into t_sysmenu(menucode,menuname,menuclass,menuID,menuorder) values('990100','����','2','0','00000')

go
/*ϵͳȨ�޹���*/
if exists(select name from sysobjects where name='t_Sysright')
   drop table t_Sysright
create table t_Sysright
(
 workcode varchar(24),
 menucode char(8),
 menuadd bit default 0,
 menudelete bit default 0,
 menumodify bit default 0,
 menuquery bit default 0,
 menush bit default 0 )
/*ɾ����ı��¼*/
if exists(select name from sysobjects where name='t_cleartable')
   drop table t_cleartable
create table t_cleartable
(
 tablecode char(8),
 menucode char(6) primary key,
 tablename varchar(20),
 identify bit default 0 )
go
insert into t_cleartable(menucode,tablename,identify) values('010100','t_user',0)

insert into t_cleartable(menucode,tablename,identify) values('020100','t_client',1)--��IDENTIFY����־�Ƿ���ϸ��
insert into t_cleartable(menucode,tablename,identify) values('020200','t_Reserve',0)
insert into t_cleartable(menucode,tablename,identify) values('020300','t_design',0)
insert into t_cleartable(menucode,tablename,identify) values('020400','t_saidprice',1)
insert into t_cleartable(menucode,tablename,identify) values('020500','t_writing',1)
insert into t_cleartable(menucode,tablename,identify) values('020600','t_xdsh',1)
insert into t_cleartable(menucode,tablename,identify) values('020700','t_prasical',1)
--insert into t_cleartable(menucode,tablename,identify) values('020900','t_moneyed',1)
insert into t_cleartable(menucode,tablename,identify) values('020900','t_clientwlz',1)
insert into t_cleartable(menucode,tablename,identify) values('021200','t_xsysk',1)
insert into t_cleartable(menucode,tablename,identify) values('021100','t_arrange',0)
insert into t_cleartable(menucode,tablename,identify) values('021300','t_designsure',0)

insert into t_cleartable(menucode,tablename,identify) values('970100','t_code',0)
insert into t_cleartable(menucode,tablename,identify) values('970200','t_goods',0)
insert into t_cleartable(menucode,tablename,identify) values('970300','T_SupplierGoods',0)

insert into t_cleartable(menucode,tablename,identify) values('069900','T_Supplier',0)
insert into t_cleartable(menucode,tablename,identify) values('050200','T_Order',1)
insert into t_cleartable(menucode,tablename,identify) values('050100','T_PurchasePlan',1)
insert into t_cleartable(menucode,tablename,identify) values('050300','T_ImprestApply',1)

insert into t_cleartable(menucode,tablename,identify) values('060100','T_PIStore_G',1)
insert into t_cleartable(menucode,tablename,identify) values('060200','T_GRStore_G',1)
insert into t_cleartable(menucode,tablename,identify) values('060300','T_CGSingle_G',1)
insert into t_cleartable(menucode,tablename,identify) values('060400','T_RSSingle_G',1)
insert into t_cleartable(menucode,tablename,identify) values('060500','T_GoodsStore_G',0)
insert into t_cleartable(menucode,tablename,identify) values('060600','T_GoodsCode_G',0)
insert into t_cleartable(menucode,tablename,identify) values('069900','T_Supplier_G',0)

insert into t_cleartable(menucode,tablename,identify) values('100100','T_PIStore',1)
insert into t_cleartable(menucode,tablename,identify) values('100200','T_GRStore',1)
insert into t_cleartable(menucode,tablename,identify) values('100300','T_CGSingle',1)
insert into t_cleartable(menucode,tablename,identify) values('100400','T_RSSingle',1)
insert into t_cleartable(menucode,tablename,identify) values('100500','T_GoodsStore',0)
insert into t_cleartable(menucode,tablename,identify) values('101500','T_GoodsCode',0)
insert into t_cleartable(menucode,tablename,identify) values('109900','T_Supplier',0)
insert into t_cleartable(menucode,tablename,identify) values('101600','T_ProjectItem',1)

insert into t_cleartable(menucode,tablename,identify) values('999900','T_GoodsPrice',0)


