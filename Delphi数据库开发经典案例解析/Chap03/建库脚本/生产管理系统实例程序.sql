if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[mrp�����������_���ϱ��_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[mrp�����������] DROP CONSTRAINT mrp�����������_���ϱ��_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[mrp�������������_���ϱ��_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[mrp�������������] DROP CONSTRAINT mrp�������������_���ϱ��_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[mrp����������ʷ_���ϱ��_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[mrp����������ʷ] DROP CONSTRAINT mrp����������ʷ_���ϱ��_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�����嵥_���ϱ��_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[�����嵥] DROP CONSTRAINT �����嵥_���ϱ��_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�������ƻ�_���ϱ��_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[�������ƻ�] DROP CONSTRAINT �������ƻ�_���ϱ��_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�������ƻ���ʷ_���ϱ��_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[�������ƻ���ʷ] DROP CONSTRAINT �������ƻ���ʷ_���ϱ��_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������ƻ�_���ϱ��_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[������ƻ�] DROP CONSTRAINT ������ƻ�_���ϱ��_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������ƻ���ʷ_���ϱ��_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[������ƻ���ʷ] DROP CONSTRAINT ������ƻ���ʷ_���ϱ��_fk
GO
-------------------------------------------------------
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�������ļ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�������ļ�]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�����嵥]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�����嵥]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��������]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������ƻ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[������ƻ�]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������ƻ���ʷ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[������ƻ���ʷ]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�������ƻ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�������ƻ�]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�������ƻ���ʷ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�������ƻ���ʷ]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[mrp�����������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[mrp�����������]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[mrp�������������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[mrp�������������]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[mrp����������ʷ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[mrp����������ʷ]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[����״̬���]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[����״̬���]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���ϼƻ����]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���ϼƻ����]
GO

-------------------------------------------
CREATE TABLE [dbo].[�������ļ�] (
	[���ϱ��] [char] (14) NOT NULL ,
	[����] [char] (14) NULL ,
	[��������] [varchar] (50) NOT NULL ,
	[ƴ������] [char] (10) NULL ,
	[������λ] [char] (10) NOT NULL ,
	[����ͺ�] [char] (20) NULL ,
	[�ƻ����] [char] (5) NULL ,
	[״̬���] [char] (5) NULL ,
	[�������] [char] (5) NULL ,
	[��ֵ���] [char] (1) NULL ,
	[��������a] [varchar] (40) NULL ,
	[��������b] [varchar] (40) NULL ,
	[��������c] [varchar] (40) NULL ,
	[��������d] [varchar] (40) NULL ,
	[��] [decimal](18, 3) NULL ,
	[��] [decimal](18, 3) NULL ,
	[��] [decimal](18, 3) NULL ,
	[����] [decimal](18, 3) NULL ,
	[Ʒ��] [char] (10) NULL ,
	[��ɫ] [char] (10) NULL ,
	[�ȼ�] [char] (10) NULL ,
	[������ǰ��] [int]  NULL ,
	[׼������] [int]  NULL ,
	[��������] [int]  NULL ,
	[��С��װ��] [decimal](18, 3) NULL ,
	[���������] [decimal](18, 3) NULL ,
	[����] [decimal](18, 4) NULL ,
	[��߿��] [decimal](18, 3) NULL ,
	[��Ϳ��] [decimal](18, 3) NULL ,
	[�������] [int] NULL ,
	[¼����] [char] (8) NULL ,
	[¼������] [int] NULL ,
	[�Ͳ���] [int] NULL ,
	[ָ��������] [char] (10) NULL ,
	[��������] [char] (10) NULL ,
	[��������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�����嵥] (
	[������] [char] (14) NOT NULL ,
	[���ϱ��] [char] (14) NOT NULL ,
	[��Ҫ����] [decimal](18, 4) NOT NULL ,
	[���ϳ���] [char] (10) NULL ,
	[���Ͽⷿ] [char] (10) NULL ,
	[�����] [decimal](5, 4) NULL ,
	[bom״̬] [char] (1) NULL ,
	[bom��Ϣ״̬] [char] (1) NULL ,
	[�����] [char] (8) NULL ,
	[�������] [int] NULL ,
	[��������] [text] NULL ,
	[�Ͳ���] [int] NULL ,
	[չ�����] [bit] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[��������] (
	[���] [int] NOT NULL ,
	[�ƻ���] [int] NOT NULL ,
	[��ʼ����] [int] NOT NULL ,
	[��������] [int] NOT NULL ,
	[��ע] [varchar] (255) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[������ƻ�] (
	[���] [char] (14) NULL ,
	[���ϱ��] [char] (14) NOT NULL ,
	[���] [int] NOT NULL ,
	[�ƻ���] [int] NOT NULL ,
	[��ʼ����] [int] NULL ,
	[��������] [int] NULL ,
	[��������] [decimal] (15,2) NOT NULL ,
	[������] [varchar] (10) NULL ,
	[�޸�����] [int] NULL ,
	[״̬] [char] (10) NULL default '��Ч',
	[��ע] [varchar] (40) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[������ƻ���ʷ] (
	[���] [char] (14) NULL ,
	[���ϱ��] [char] (14) NOT NULL ,
	[���] [int] NOT NULL ,
	[�ƻ���] [int] NOT NULL ,
	[��ʼ����] [int] NULL ,
	[��������] [int] NULL ,
	[��������] [decimal] (15,2) NULL ,
	[������] [varchar] (10) NULL ,
	[�޸�����] [int] NULL ,
	[״̬] [char] (10) NULL ,
	[��ע] [varchar] (40) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�������ƻ�] (
	[���ϱ��] [char] (14) NOT NULL ,
	[���] [char] (14) NULL ,
	[���] [int] NOT NULL ,
	[�ƻ���] [int] NOT NULL ,
	[��ʼ����] [int] NULL ,
	[��������] [int] NULL ,
	[�ڳ����] [decimal] (15,2) NULL ,
	[��������] [decimal] (15,2) NULL ,
	[MPS����] [decimal] (15,2) NOT NULL ,
	[����������] [decimal] (15,2) NULL ,
	[Ԥ�ƿ��] [decimal] (15,2) NULL ,
	[������] [varchar] (10) NULL ,
	[�޸�����] [int] NULL ,
	[�����] [varchar] (10) NULL ,
	[�������] [int] NULL ,
	[״̬] [char] (10) NULL default '��Ч',
	[��ע] [varchar] (40) NULL 
) ON [PRIMARY]
GO

-- ���������ƻ����б��
CREATE trigger INSERT_�������ƻ�
	on 	�������ƻ�
	for	INSERT
AS
	declare @bh1 varchar(16)
	declare @bh2 varchar(16)
	select @bh1 = isnull(max(���),'MPS0000000000') from �������ƻ�
	select @bh2 = isnull(max(���),'MPS0000000000') from �������ƻ���ʷ
	if(@bh2>@bh1) select @bh1 = @bh2
	declare @no varchar(10)
	select @no = substring(@bh1,4,10)
	select @no = convert(char(10),convert(int,@no)+1)
	select @no = REPLICATE('0',10-LEN(@no))+@no
	update �������ƻ� set ���='MPS' + @no where ��� is null
GO

CREATE TABLE [dbo].[�������ƻ���ʷ] (
	[���ϱ��] [char] (14) NOT NULL ,
	[���] [char] (14) NULL ,
	[���] [int] NOT NULL ,
	[�ƻ���] [int] NOT NULL ,
	[��ʼ����] [int] NULL ,
	[��������] [int] NULL ,
	[�ڳ����] [decimal] (15,2) NULL ,
	[��������] [decimal] (15,2) NULL ,
	[MPS����] [decimal] (15,2) NULL ,
	[����������] [decimal] (15,2) NULL ,
	[Ԥ�ƿ��] [decimal] (15,2) NULL ,
	[������] [varchar] (10) NULL ,
	[�޸�����] [int] NULL ,
	[�����] [varchar] (10) NULL ,
	[�������] [int] NULL ,
	[״̬] [char] (10) NULL ,
	[��ע] [varchar] (40) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[mrp�����������] (
	[���ϱ��] [char] (14) NOT NULL ,
	[���] [int] NOT NULL ,
	[�ƻ���] [int] NOT NULL ,
	[�ڳ����] [decimal](18, 4) NULL ,
	[ë����] [decimal](18, 4) NULL ,
	[Ԥ�����] [decimal](18, 4) NULL ,
	[Ԥ�Ƴ���] [decimal](18, 4) NULL ,
	[Ԥ�ƿ��] [decimal](18, 4) NULL ,
	[������] [decimal](18, 4) NULL ,
	[�ƻ�����] [decimal](18, 4) NULL ,
	[�ƻ�Ͷ��] [decimal](18, 4) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[mrp����������ʷ] (
	[�������] [char] (20) NULL ,
	[����ʱ��] [datetime] NULL ,
	[���ϱ��] [char] (14) NOT NULL ,
	[���] [int] NOT NULL ,
	[�ƻ���] [int] NOT NULL ,
	[�ڳ����] [decimal](18, 4) NULL ,
	[ë����] [decimal](18, 4) NULL ,
	[Ԥ�����] [decimal](18, 4) NULL ,
	[Ԥ�Ƴ���] [char] (10) NULL ,
	[Ԥ�ƿ��] [decimal](18, 4) NULL ,
	[������] [decimal](18, 4) NULL ,
	[�ƻ�����] [decimal](18, 4) NULL ,
	[�ƻ�Ͷ��] [decimal](18, 4) NULL 
) ON [PRIMARY]
GO

--- �����ͼ��Ϊ�˲�ѯʱ��ʾ�������ƿ�����table�ؼ�,������ʹ��query�ؼ�
if exists (select * from sysobjects where id = object_id(N'[dbo].[vmrp����������ʷ]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vmrp����������ʷ]
GO
create view vmrp����������ʷ
as
select a.*, b.�������� from mrp����������ʷ as a,
	�������ļ� as b where a.���ϱ��=b.���ϱ��
go

CREATE TABLE [dbo].[����״̬���] (
	[������] [char] (5) NOT NULL Primary key,
	[״̬����] [char] (20) NOT NULL ,
	[˵��] [varchar] (50) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[���ϼƻ����] (
	[������] [char] (5) NOT NULL Primary key,
	[�������] [char] (20) NOT NULL 
) ON [PRIMARY]
GO
-----------------------------------------
ALTER TABLE [dbo].[�������ļ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__�������ļ�__������ǰ��__160F4887] DEFAULT (0) FOR [������ǰ��],
	CONSTRAINT [DF__�������ļ�__׼������__17036CC0] DEFAULT (0) FOR [׼������],
	CONSTRAINT [DF__�������ļ�__��������__17F790F9] DEFAULT (0) FOR [��������],
	CONSTRAINT [PK__�������ļ�__151B244E] PRIMARY KEY  CLUSTERED 
	(
		[���ϱ��]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[�����嵥] WITH NOCHECK ADD 
	CONSTRAINT [DF_�����嵥_չ�����] DEFAULT (0) FOR [չ�����],
	CONSTRAINT [PK_�����嵥] PRIMARY KEY  CLUSTERED 
	(
		[������],
		[���ϱ��]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[��������] WITH NOCHECK ADD 
	CONSTRAINT [PK__��������__1F98B2C1] PRIMARY KEY  CLUSTERED 
	(
		[���],
		[�ƻ���]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[������ƻ�] WITH NOCHECK ADD 
	CONSTRAINT [PK_������ƻ�] PRIMARY KEY  CLUSTERED 
	(
		[���ϱ��],
		[���],
		[�ƻ���]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[������ƻ���ʷ] WITH NOCHECK ADD 
	CONSTRAINT [PK_������ƻ���ʷ] PRIMARY KEY  CLUSTERED 
	(
		[���ϱ��],
		[���],
		[�ƻ���]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[�������ƻ�] WITH NOCHECK ADD 
	CONSTRAINT [PK_�������ƻ�] PRIMARY KEY  CLUSTERED 
	(
		[���],
		[�ƻ���],
		[���ϱ��]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[�������ƻ���ʷ] WITH NOCHECK ADD 
	CONSTRAINT [PK_�������ƻ���ʷ] PRIMARY KEY  CLUSTERED 
	(
		[���],
		[�ƻ���],
		[���ϱ��]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[mrp�����������] WITH NOCHECK ADD 
	CONSTRAINT [PK_mrp�����������] PRIMARY KEY  CLUSTERED 
	(
		[���ϱ��],
		[���],
		[�ƻ���]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[mrp����������ʷ] WITH NOCHECK ADD 
	CONSTRAINT [PK_mrp����������ʷ] PRIMARY KEY  CLUSTERED 
	(
		[���ϱ��],
		[���],
		[�ƻ���]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[mrp����������ʷ] ADD 
	CONSTRAINT [mrp����������ʷ_���ϱ��_fk] FOREIGN KEY 
	(
		[���ϱ��]
	) REFERENCES [dbo].[�������ļ�] (
		[���ϱ��]
	)
GO

ALTER TABLE [dbo].[mrp�����������] ADD 
	CONSTRAINT [mrp�����������_���ϱ��_fk] FOREIGN KEY 
	(
		[���ϱ��]
	) REFERENCES [dbo].[�������ļ�] (
		[���ϱ��]
	)
GO

ALTER TABLE [dbo].[mrp�������������] ADD 
	CONSTRAINT [mrp�������������_���ϱ��_fk] FOREIGN KEY 
	(
		[���ϱ��]
	) REFERENCES [dbo].[�������ļ�] (
		[���ϱ��]
	)
GO

ALTER TABLE [dbo].[�������ƻ�] ADD 
	CONSTRAINT [�������ƻ�_���ϱ��_fk] FOREIGN KEY 
	(
		[���ϱ��]
	) REFERENCES [dbo].[�������ļ�] (
		[���ϱ��]
	)
GO

ALTER TABLE [dbo].[�������ƻ���ʷ] ADD 
	CONSTRAINT [�������ƻ���ʷ_���ϱ��_fk] FOREIGN KEY 
	(
		[���ϱ��]
	) REFERENCES [dbo].[�������ļ�] (
		[���ϱ��]
	)
GO

ALTER TABLE [dbo].[������ƻ�] ADD 
	CONSTRAINT [������ƻ�_���ϱ��_fk] FOREIGN KEY 
	(
		[���ϱ��]
	) REFERENCES [dbo].[�������ļ�] (
		[���ϱ��]
	)
GO

ALTER TABLE [dbo].[������ƻ���ʷ] ADD 
	CONSTRAINT [������ƻ���ʷ_���ϱ��_fk] FOREIGN KEY 
	(
		[���ϱ��]
	) REFERENCES [dbo].[�������ļ�] (
		[���ϱ��]
	)
GO

ALTER TABLE [dbo].[�����嵥] ADD 
	CONSTRAINT [�����嵥_���ϱ��_fk] FOREIGN KEY 
	(
		[���ϱ��]
	) REFERENCES [dbo].[�������ļ�] (
		[���ϱ��]
	)
GO

---------------------�����Ǽ��ʹ�õ����ݱ�
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[����]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[����]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�ɹ�����]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�ɹ�����]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��������]
GO
CREATE TABLE [dbo].[����] (
	[����] [char] (14) NOT NULL ,
	[����] [varchar] (20) NOT NULL ,
	[����] [varchar] (20) NOT NULL ,
	[���] [varchar] (20) NOT NULL ,
	[��λ] [varchar] (20) NULL ,
	[�������] [decimal] (15,2) NOT NULL ,
	[�����] [decimal] (15,2) NOT NULL ,
	[��浥��] [decimal] (15,2) NOT NULL ,
	[���½���] [decimal] (15,2) NULL ,
	[����] [decimal] (15,2) NULL 
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[�ɹ�����] (
	[���] [char] (14) NOT NULL primary key,
	[��ͬ���] [char] (14) NULL ,
	[���ݺ�] [char] (14) NULL ,
	[������] [char] (14) NULL ,
	[�����̺�] [char] (10) NULL ,
	[���ϱ��] [char] (14) NULL ,
	[��������] [decimal](24, 4) NULL ,
	[����] [money] NULL ,
	[����˰��] [money] NULL ,
	[˰��] [decimal](5, 4) NULL ,
	[˰��] [money] NULL ,
	[˰�ۺϼ�] [money] NULL ,
	[������ʽ] [varchar] (20) NULL ,
	[��������] [int] NULL ,
	[���] [int] NULL ,
	[�ƻ���] [int] NULL ,
	[�����ص�] [varchar] (20) NULL ,
	[������] [char] (8) NULL ,
	[�ͻ�����] [int] NULL ,
	[�ͻ�����] [real] NULL ,
	[ʣ������] [decimal](18, 4) NULL ,
	[��Ч����] [int] NULL ,
	[��Чֹ��] [int] NULL ,
	[��������] [int] NULL ,
	[������] [char] (8) NULL ,
	[����] [char] (8) NULL ,
	[���ϱ��] [char] (1) NULL ,
	[��ӡ���] [char] (1) NULL ,
	[����״̬] [char] (6) NULL ,
	[����˵��] [varchar] (40) NULL 
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[��������] (
	[MPS���] [char] (14) NULL ,
	[���] [char] (14) Not NULL Primary key,
	[���ݺ�] [char] (14) NULL ,
	[��������] [char] (20) NULL ,
	[���ϱ��] [char] (14) NULL ,
	[���] [int] NULL ,
	[�ƻ���] [int] NULL ,
	[����] [decimal] (15,2) NULL ,
	[��������] [char] (10) NULL ,
	[�´�����] [int] NULL ,
	[Ҫ���������] [int] NULL ,
	[�������] [decimal] (15,2) NULL ,
	[ʣ������] [decimal] (15,2) NULL ,
	[������] [varchar] (10) NULL ,
	[��������] [int] NULL ,
	[�����] [varchar] (10) NULL ,
	[�������] [int] NULL ,
	[״̬] [char] (10) NULL ,
	[��ע] [varchar] (40) NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[����] WITH NOCHECK ADD 
	CONSTRAINT [DF__����__�������__6C43F744] DEFAULT (0) FOR [�������],
	CONSTRAINT [DF__����__�����__6D381B7D] DEFAULT (0) FOR [�����],
	CONSTRAINT [DF__����__��浥��__6E2C3FB6] DEFAULT (0) FOR [��浥��],
	CONSTRAINT [����_���Ų������_FK] PRIMARY KEY  CLUSTERED 
	(
		[����],
		[����],
		[����],
		[���]
	)  ON [PRIMARY] 
GO
ALTER TABLE [dbo].[��������] WITH NOCHECK ADD 
	CONSTRAINT [DF_��������_�������] DEFAULT (0) FOR [�������],
	CONSTRAINT [DF_��������_ʣ������] DEFAULT (0) FOR [ʣ������]
GO

ALTER TABLE [dbo].[��������] ADD 
	CONSTRAINT [��������_���ϱ��_fk] FOREIGN KEY 
	(
		[���ϱ��]
	) REFERENCES [dbo].[�������ļ�] (
		[���ϱ��]
	)
GO

ALTER TABLE [dbo].[�ɹ�����] ADD 
	CONSTRAINT [�ɹ�����_���ϱ��_fk] FOREIGN KEY 
	(
		[���ϱ��]
	) REFERENCES [dbo].[�������ļ�] (
		[���ϱ��]
	)
GO

-------------------------�洢����
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sf_mrp�������]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sf_mrp�������]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sf_mrp����]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sf_mrp����]
GO

--------mrp����洢����
CREATE PROCEDURE sf_mrp���� ( @���ǿ���  bit=1, 
	@������ǰ�� bit=1, @������� bit=1)
AS
begin tran
	--���
	delete from mrp�����������
	-- ���������嵥�ײ���,����ʱʹ��
	update �����嵥 set �Ͳ��� = 0 where ������ = 0
	-- ѭ��10��,�������,����Ĭ��bom���ϵĲ㼶������10��
	declare @i int
	select @i = 1
	while (@i<=10)
	begin 
		update �����嵥 set �Ͳ��� = b.�Ͳ���+1 from �����嵥 as a,
			(select * from �����嵥) as b 
			where a.������ = b.���ϱ��
		select @i = @i + 1
	end
	--��������������������,������ë����
	-- �Ͳ���������ϵĲ㼶,ʹ������ѭ��
	insert into mrp�����������(���ϱ��,���,�ƻ���,ë����)
		select ���ϱ��,���,�ƻ���,sum(MPS����)
		FROM �������ƻ� group by ���ϱ��,���,�ƻ���
	select @i = 1
	while (@i<=10)
	begin 
		-- û�е��Ȳ����¼,��Ϊһ�����Ͽ��Զ�Ӧ�������
		insert into mrp�����������(���ϱ��,���,�ƻ���,ë����)
			select distinct b.���ϱ��,���,�ƻ���,0
			FROM mrp����������� as a, �����嵥 as b
			where rtrim(b.���ϱ��)+convert(char(4),���)+
			convert(char(2),�ƻ���)	not in(select rtrim(���ϱ��)+
			convert(char(4),���)+convert(char(2),�ƻ���) 
			from mrp�����������)
			and b.������=a.���ϱ�� and b.�Ͳ���=@i
		-- ����ë����
		-- ע�⿼����ĵ����
		update mrp����������� set ë���� = c.ë���� + d.����
			from mrp����������� as c, 
				(select b.���ϱ��,���,�ƻ���,
				sum((a.ë����*b.��Ҫ����)/(1-(case when @�������=1 then 
				isnull(�����,0) else 0 end))) as ����
				FROM mrp����������� as a, �����嵥 as b
				where b.������=a.���ϱ�� and b.�Ͳ���=@i
				group by b.���ϱ��,a.���,a.�ƻ���
			) as d
			where c.���ϱ��=d.���ϱ�� and c.���=d.��� and c.�ƻ���=d.�ƻ���

		select @i = @i + 1
	end
	--------------- ��������ǰ�ڵ�ë����������
	-- ������ǰ��,������ǰ��
	--if (@������ǰ��=1) 
	--begin
		-- ���ﲻ�ڼ���,������㷽��Ϊ����ǰ�ƻ��ڵ������Ƶ���ǰ��
		-- ע�����ȼƻ��ڵ�
	--end

	if (@���ǿ���=1)      
	begin   
		-- ��һ�μ���,�����ڳ����
		-- ����ͳһ����������Ϊ100
		-- ʵ��ϵͳӦ�úͿ��⼰����������
		update mrp����������� set �ڳ����=100 

		update mrp����������� set Ԥ����� = isnull(Ԥ�����,0) + 
			���� from mrp����������� as a, (select sum(ʣ������) as ����, 
				���ϱ��,���,�ƻ��� from �ɹ����� 
				group by ���ϱ��,���,�ƻ���) as b, �������ļ� as c
			where a.���ϱ��=b.���ϱ�� and a.���=b.��� 
			and a.�ƻ���=b.�ƻ��� and a.���ϱ�� = c.���ϱ�� 
			and c.�ƻ����='wg'    -- �⹺��Ʒ
  
		update mrp����������� set Ԥ����� = isnull(Ԥ�����,0) + 
			���� from mrp����������� as a, (select sum(ʣ������) as ����, 
				���ϱ��,���,�ƻ��� from �������� 
				group by ���ϱ��,���,�ƻ���) as b, �������ļ� as c
			where a.���ϱ��=b.���ϱ�� and a.���=b.��� 
			and a.�ƻ���=b.�ƻ��� and a.���ϱ�� = c.���ϱ�� 
			and c.�ƻ����='bcp'    -- ���Ʒ
		
		-- �������Ԥ�Ƴ�������   
		update mrp����������� set Ԥ�Ƴ��� = isnull(Ԥ�Ƴ���,0)
   	end

	-- ���ռƻ���ѭ����������ƻ��ڵ���������
	declare @��� int, @�ƻ��� int
	declare mycur cursor for select ���,�ƻ��� from mrp�����������
		order by ���,�ƻ���
	open mycur
	fetch next from mycur into @���, @�ƻ���
	WHILE (@@FETCH_STATUS = 0 )
	BEGIN
		-- ���������С�ļƻ���, �����ڳ����
		-- ע�����ȵļ���,�����Ȳ�����
		update mrp����������� set �ڳ����=b.Ԥ�ƿ�� from 
			mrp�����������  as a, (select * from mrp�����������) 
				as b where a.���=@��� and a.�ƻ���=@�ƻ���
				and a.���=b.��� and a.�ƻ���=b.�ƻ���+1
		
		-- ���㾻����
		update mrp����������� set Ԥ�ƿ�� = isnull(�ڳ����,0) - 
			isnull(ë����,0) + isnull(Ԥ�����,0) - isnull(Ԥ�Ƴ���,0)
			where ���=@��� and �ƻ���=@�ƻ���
		update mrp����������� set ������=0  where ���=@��� and �ƻ���=@�ƻ���
		-- Ԥ��(��ĩ���)С��0�Ĵ��ھ�����
		update mrp����������� set ������=-Ԥ�ƿ��, Ԥ�ƿ��=0 
			where ���=@��� and �ƻ���=@�ƻ��� and Ԥ�ƿ��<0
		fetch next from mycur into @���, @�ƻ���
	END
	close mycur
	deallocate mycur
commit
GO

CREATE PROCEDURE sf_mrp�������
AS
begin tran
	insert into mrp����������ʷ(����ʱ��, ���ϱ��, ���, �ƻ���,
		�ڳ����, ë����, Ԥ�����, Ԥ�Ƴ���, Ԥ�ƿ��, ������, 
		�ƻ�����, �ƻ�Ͷ��) select getdate(), ���ϱ��, 
		���, �ƻ���, �ڳ����, ë����, Ԥ�����, Ԥ�Ƴ���, Ԥ�ƿ��, 
		������, �ƻ�����, �ƻ�Ͷ�� from mrp�����������
	delete from mrp�����������
	insert into �������ƻ���ʷ select * from �������ƻ�
	delete from �������ƻ�
commit
GO



