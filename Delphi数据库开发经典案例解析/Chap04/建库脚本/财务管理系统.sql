if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��¼��_ƾ֤���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��¼��] DROP CONSTRAINT ��¼��_ƾ֤���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��¼��_��Ŀ����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��¼��] DROP CONSTRAINT ��¼��_��Ŀ����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������ʲ�_��Ŀ����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��������ʲ�] DROP CONSTRAINT ��������ʲ�_��Ŀ����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������ϸ�ʲ�_��Ŀ����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[������ϸ�ʲ�] DROP CONSTRAINT ������ϸ�ʲ�_��Ŀ����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���ڷ����ʲ�_��Ŀ����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���ڷ����ʲ�] DROP CONSTRAINT ���ڷ����ʲ�_��Ŀ����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������ϸ�ʲ�_��Ŀ����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[������ϸ�ʲ�] DROP CONSTRAINT ������ϸ�ʲ�_��Ŀ����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��¼��temp_��Ŀ����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��¼��temp] DROP CONSTRAINT ��¼��temp_��Ŀ����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��¼����ʷ_��Ŀ����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��¼����ʷ] DROP CONSTRAINT ��¼����ʷ_��Ŀ����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��Ŀ����_��Ŀ����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��Ŀ����] DROP CONSTRAINT ��Ŀ����_��Ŀ����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ʷ�����ʲ�_��Ŀ����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��ʷ�����ʲ�] DROP CONSTRAINT ��ʷ�����ʲ�_��Ŀ����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ʷ��ϸ�ʲ�_��Ŀ����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��ʷ��ϸ�ʲ�] DROP CONSTRAINT ��ʷ��ϸ�ʲ�_��Ŀ����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��Ŀ��Ŀ���ձ�_��Ŀ����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��Ŀ��Ŀ���ձ�] DROP CONSTRAINT ��Ŀ��Ŀ���ձ�_��Ŀ����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sf_pzƾ֤ɾ����]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sf_pzƾ֤ɾ����]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sf_pzƾ֤¼��]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sf_pzƾ֤¼��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sf_pzƾ֤����]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sf_pzƾ֤����]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sf_pz����ƾ֤��]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sf_pz����ƾ֤��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ƾ֤��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ƾ֤��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ƾ֤��temp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ƾ֤��temp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ƾ֤����ʷ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ƾ֤����ʷ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��¼��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��¼��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��¼��temp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��¼��temp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��¼����ʷ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��¼����ʷ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[����ģ��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[����ģ��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ʷ�����ʲ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��ʷ�����ʲ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ʷ��ϸ�ʲ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��ʷ��ϸ�ʲ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�����嵥]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�����嵥]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������Ŀ�嵥]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[������Ŀ�嵥]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�����]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�����]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������ʲ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��������ʲ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������ϸ�ʲ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[������ϸ�ʲ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���ڷ����ʲ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���ڷ����ʲ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������ϸ�ʲ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[������ϸ�ʲ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Ȩ�޵Ǽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Ȩ�޵Ǽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[״̬��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[״̬��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��Ŀ����]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��Ŀ����]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��Ŀ��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��Ŀ��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[����嵥]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[����嵥]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ְ���嵥]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ְ���嵥]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�����嵥]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�����嵥]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��Ŀ��Ŀ���ձ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��Ŀ��Ŀ���ձ�]
GO

CREATE TABLE [dbo].[ƾ֤��] (
	[�ڲ����] [int] NULL ,
	[ƾ֤״̬] [char] (10) NULL ,
	[����ڼ�] [int] NULL ,
	[ƾ֤�ֺ�] [char] (4) NULL ,
	[ƾ֤���] [int] NOT NULL ,
	[˳���] [int] NULL ,
	[����] [char] (10) NULL ,
	[������] [int] NULL ,
	[���] [char] (20) NULL ,
	[����] [char] (20) NULL ,
	[�Ƶ�] [char] (20) NULL ,
	[�跽�ϼ�] [money] NULL ,
	[�����ϼ�] [money] NULL ,
	[����״̬] [char] (4) NULL ,
	[˳�����] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ƾ֤��temp] (
	[�ڲ����] [int] NULL ,
	[ƾ֤״̬] [char] (10) NULL ,
	[����ڼ�] [int] NULL ,
	[ƾ֤�ֺ�] [char] (4) NULL ,
	[ƾ֤���] [int] NULL ,
	[˳���] [int] NULL ,
	[����] [char] (10) NULL ,
	[������] [int] NULL ,
	[���] [char] (20) NULL ,
	[����] [char] (20) NULL ,
	[�Ƶ�] [char] (20) NULL ,
	[�跽�ϼ�] [money] NULL ,
	[�����ϼ�] [money] NULL ,
	[˳�����] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ƾ֤����ʷ] (
	[�ڲ����] [int] NULL ,
	[ƾ֤״̬] [char] (10) NULL ,
	[����ڼ�] [int] NULL ,
	[ƾ֤�ֺ�] [char] (4) NULL ,
	[ƾ֤���] [int] NULL ,
	[˳���] [int] NULL ,
	[����] [char] (10) NULL ,
	[������] [int] NULL ,
	[���] [char] (20) NULL ,
	[����] [char] (20) NULL ,
	[�Ƶ�] [char] (20) NULL ,
	[�跽�ϼ�] [money] NULL ,
	[�����ϼ�] [money] NULL ,
	[����״̬] [char] (4) NULL ,
	[˳�����] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��¼��] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[��¼���] [int] NULL ,
	[����ڼ�] [int] NULL ,
	[ƾ֤�ֺ�] [char] (4) NULL ,
	[ƾ֤���] [int] NOT NULL ,
	[ժҪ] [char] (40) NULL ,
	[��Ŀ����] [char] (20) NULL ,
	[�跽] [money] NULL ,
	[����] [money] NULL ,
	[����] [int] NULL ,
	[����] [money] NULL ,
	[���㷽ʽ] [char] (10) NULL ,
	[�����] [int] NULL ,
	[��������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��¼��temp] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[��¼���] [int] NULL ,
	[����ڼ�] [int] NULL ,
	[ƾ֤�ֺ�] [char] (4) NULL ,
	[ƾ֤���] [int] NULL ,
	[ժҪ] [char] (40) NULL ,
	[��Ŀ����] [char] (20) NULL ,
	[�跽] [money] NULL ,
	[����] [money] NULL ,
	[����] [int] NULL ,
	[����] [money] NULL ,
	[���㷽ʽ] [char] (10) NULL ,
	[�����] [int] NULL ,
	[��������] [char] (10) NULL ,
	[������] [int] NULL ,
	[˳�����] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��¼����ʷ] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[��¼���] [int] NULL ,
	[����ڼ�] [int] NULL ,
	[ƾ֤�ֺ�] [char] (4) NULL ,
	[ƾ֤���] [int] NULL ,
	[ժҪ] [char] (40) NULL ,
	[��Ŀ����] [char] (20) NULL ,
	[�跽] [money] NULL ,
	[����] [money] NULL ,
	[����] [int] NULL ,
	[����] [money] NULL ,
	[���㷽ʽ] [char] (10) NULL ,
	[�����] [int] NULL ,
	[��������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[����ģ��] (
	[ģ����] [char] (50) NOT NULL ,
	[���] [char] (20) NOT NULL ,
	[ģ��] [char] (20) NOT NULL ,
	[����] [varchar] (100) NULL ,
	[ģ������] [int] NOT NULL ,
	[�����ļ�] [varchar] (100) NULL ,
	[�˵��ļ�] [varchar] (100) NULL ,
	[��ӡ�ļ�] [varchar] (100) NULL ,
	[���ʲ���] [varchar] (250) NULL ,
	[��ӡ����] [varchar] (250) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��ʷ�����ʲ�] (
	[��Ŀ����] [char] (20) NULL ,
	[�ڳ����] [char] (1) NULL ,
	[���ڽ跽�ϼ�] [money] NULL ,
	[���ڴ����ϼ�] [money] NULL ,
	[����跽�ۼ�] [money] NULL ,
	[��������ۼ�] [money] NULL ,
	[���] [char] (1) NULL ,
	[ժҪ] [char] (40) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��ʷ��ϸ�ʲ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[��¼���] [int] NULL ,
	[����ڼ�] [int] NULL ,
	[ƾ֤�ֺ�] [char] (4) NULL ,
	[ƾ֤���] [int] NULL ,
	[ժҪ] [char] (40) NULL ,
	[��Ŀ����] [char] (20) NULL ,
	[�跽] [money] NULL ,
	[����] [money] NULL ,
	[����] [int] NULL ,
	[����] [money] NULL ,
	[���㷽ʽ] [char] (10) NULL ,
	[�����] [int] NULL ,
	[��������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�����嵥] (
	[������] [int] NULL ,
	[��������] [char] (40) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[������Ŀ�嵥] (
	[������] [int] NULL ,
	[��������] [char] (40) NULL ,
	[��Ŀ����] [int] NULL ,
	[��Ŀ����] [char] (40) NULL ,
	[�к�] [int] NULL ,
	[���㷽��] [char] (10) NULL ,
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�����] (
	[��Ŀ] [char] (40) NULL ,
	[�к�] [int] NULL ,
	[������] [money] NULL ,
	[�����ۼ���] [money] NULL ,
	[���] [datetime] NULL ,
	[����ڼ�] [int] NULL ,
	[����������] [datetime] NULL ,
	[�ڲ����] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��������ʲ�] (
	[��Ŀ����] [char] (20) NULL ,
	[�ڳ����] [char] (1) NULL ,
	[���ڽ跽�ϼ�] [money] NULL ,
	[���ڴ����ϼ�] [money] NULL ,
	[����跽�ۼ�] [money] NULL ,
	[��������ۼ�] [money] NULL ,
	[���] [char] (1) NULL ,
	[ժҪ] [char] (40) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[������ϸ�ʲ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[��¼���] [int] NULL ,
	[����ڼ�] [int] NULL ,
	[ƾ֤�ֺ�] [char] (4) NULL ,
	[ƾ֤���] [int] NULL ,
	[ժҪ] [char] (40) NULL ,
	[��Ŀ����] [char] (20) NULL ,
	[�跽] [money] NULL ,
	[����] [money] NULL ,
	[����] [int] NULL ,
	[����] [money] NULL ,
	[���㷽ʽ] [char] (10) NULL ,
	[�����] [int] NULL ,
	[��������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[���ڷ����ʲ�] (
	[��Ŀ����] [char] (20) NULL ,
	[�ڳ����] [char] (1) NULL ,
	[���ڽ跽�ϼ�] [money] NULL ,
	[���ڴ����ϼ�] [money] NULL ,
	[����跽�ۼ�] [money] NULL ,
	[��������ۼ�] [money] NULL ,
	[���] [char] (1) NULL ,
	[ժҪ] [char] (40) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[������ϸ�ʲ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[��¼���] [int] NULL ,
	[����ڼ�] [int] NULL ,
	[ƾ֤�ֺ�] [char] (4) NULL ,
	[ƾ֤���] [int] NULL ,
	[ժҪ] [char] (40) NULL ,
	[��Ŀ����] [char] (20) NULL ,
	[�跽] [money] NULL ,
	[����] [money] NULL ,
	[����] [char] (4) NULL ,
	[���] [money] NULL ,
	[����] [int] NULL ,
	[����] [money] NULL ,
	[���㷽ʽ] [char] (10) NULL ,
	[�����] [int] NULL ,
	[��������] [char] (10) NULL ,
	[�����] [char] (4) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Ȩ�޵Ǽ�] (
	[Ȩ�����] [int] NOT NULL ,
	[���] [char] (6) NOT NULL ,
	[�������] [int] NOT NULL ,
	[ģ����] [char] (10) NOT NULL ,
	[ѡ�б��] [char] (1) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[״̬��] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[����ڼ�] [int] NULL ,
	[ƾ֤�ֺ�] [char] (4) NULL ,
	[���] [int] NULL ,
	[˳���] [int] NULL ,
	[��¼���] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��Ŀ����] (
	[��Ŀ����] [char] (20) NULL ,
	[�ڳ��跽���] [money] NULL ,
	[�ڳ��������] [money] NULL ,
	[���ڽ跽������] [money] NULL ,
	[���ڴ���������] [money] NULL ,
	[����跽�ۼƷ�����] [money] NULL ,
	[��������ۼƷ�����] [money] NULL ,
	[���ڽ跽���] [money] NULL ,
	[���ڴ������] [money] NULL ,
	[�������¼] [int] NULL ,
	[����ڼ�] [int] NULL ,
	[����] [char] (4) NULL ,
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��Ŀ��] (
	[��Ŀ����] [char] (20) NOT NULL ,
	[��Ŀ����] [char] (20) NULL ,
	[������] [char] (20) NULL ,
	[��Ŀ���] [char] (20) NULL ,
	[�Ƿ�����Ŀ] [char] (10) NULL ,
	[����] [char] (4) NULL ,
	[������λ] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[����嵥] (
	[�����] [char] (6) NOT NULL ,
	[���ű��] [char] (6) NOT NULL ,
	[�������] [varchar] (50) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ְ���嵥] (
	[ְ�����] [char] (6) NOT NULL ,
	[�����] [char] (6) NOT NULL ,
	[����] [char] (10) NOT NULL ,
	[�Ա�] [char] (2) NOT NULL ,
	[ְ��] [char] (10) NULL ,
	[����] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�����嵥] (
	[���ű��] [char] (6) NOT NULL ,
	[��������] [char] (30) NOT NULL ,
	[��������] [int] NOT NULL ,
	[Զ���û���] [int] NULL ,
	[�û���] [char] (15) NULL ,
	[����] [char] (10) NULL ,
	[����] [char] (15) NULL ,
	[��������] [char] (15) NULL ,
	[���ݿ����] [char] (15) NULL ,
	[�����ļ�] [char] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��Ŀ��Ŀ���ձ�] (
	[��Ŀ����] [char] (40) NULL ,
	[��Ŀ����] [int] NULL ,
	[��Ŀ����] [char] (20) NULL ,
	[��Ŀ����] [int] NULL ,
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ƾ֤��] ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[ƾ֤���]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[��¼��] ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[�ڲ����]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[��Ŀ��] ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[��Ŀ����]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[��¼��] ADD 
	CONSTRAINT [��¼��_ƾ֤���_fk] FOREIGN KEY 
	(
		[ƾ֤���]
	) REFERENCES [dbo].[ƾ֤��] (
		[ƾ֤���]
	)
GO

ALTER TABLE [dbo].[��¼��] ADD 
	CONSTRAINT [��¼��_��Ŀ����_fk] FOREIGN KEY 
	(
		[��Ŀ����]
	) REFERENCES [dbo].[��Ŀ��] (
		[��Ŀ����]
	)
GO

ALTER TABLE [dbo].[��¼��temp] ADD 
	CONSTRAINT [��¼��temp_��Ŀ����_fk] FOREIGN KEY 
	(
		[��Ŀ����]
	) REFERENCES [dbo].[��Ŀ��] (
		[��Ŀ����]
	)
GO

ALTER TABLE [dbo].[��¼����ʷ] ADD 
	CONSTRAINT [��¼����ʷ_��Ŀ����_fk] FOREIGN KEY 
	(
		[��Ŀ����]
	) REFERENCES [dbo].[��Ŀ��] (
		[��Ŀ����]
	)
GO

ALTER TABLE [dbo].[��ʷ�����ʲ�] ADD 
	CONSTRAINT [��ʷ�����ʲ�_��Ŀ����_fk] FOREIGN KEY 
	(
		[��Ŀ����]
	) REFERENCES [dbo].[��Ŀ��] (
		[��Ŀ����]
	)
GO

ALTER TABLE [dbo].[��ʷ��ϸ�ʲ�] ADD 
	CONSTRAINT [��ʷ��ϸ�ʲ�_��Ŀ����_fk] FOREIGN KEY 
	(
		[��Ŀ����]
	) REFERENCES [dbo].[��Ŀ��] (
		[��Ŀ����]
	)
GO

ALTER TABLE [dbo].[��������ʲ�] ADD 
	CONSTRAINT [��������ʲ�_��Ŀ����_fk] FOREIGN KEY 
	(
		[��Ŀ����]
	) REFERENCES [dbo].[��Ŀ��] (
		[��Ŀ����]
	)
GO

ALTER TABLE [dbo].[������ϸ�ʲ�] ADD 
	CONSTRAINT [������ϸ�ʲ�_��Ŀ����_fk] FOREIGN KEY 
	(
		[��Ŀ����]
	) REFERENCES [dbo].[��Ŀ��] (
		[��Ŀ����]
	)
GO

ALTER TABLE [dbo].[���ڷ����ʲ�] ADD 
	CONSTRAINT [���ڷ����ʲ�_��Ŀ����_fk] FOREIGN KEY 
	(
		[��Ŀ����]
	) REFERENCES [dbo].[��Ŀ��] (
		[��Ŀ����]
	)
GO

ALTER TABLE [dbo].[������ϸ�ʲ�] ADD 
	CONSTRAINT [������ϸ�ʲ�_��Ŀ����_fk] FOREIGN KEY 
	(
		[��Ŀ����]
	) REFERENCES [dbo].[��Ŀ��] (
		[��Ŀ����]
	)
GO

ALTER TABLE [dbo].[��Ŀ����] ADD 
	CONSTRAINT [��Ŀ����_��Ŀ����_fk] FOREIGN KEY 
	(
		[��Ŀ����]
	) REFERENCES [dbo].[��Ŀ��] (
		[��Ŀ����]
	)
GO

ALTER TABLE [dbo].[��Ŀ��Ŀ���ձ�] ADD 
	CONSTRAINT [��Ŀ��Ŀ���ձ�_��Ŀ����_fk] FOREIGN KEY 
	(
		[��Ŀ����]
	) REFERENCES [dbo].[��Ŀ��] (
		[��Ŀ����]
	)
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create proc sf_pzƾ֤ɾ����
as
begin tran
delete from ƾ֤��temp
delete from ��¼��temp

commit


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE proc sf_pzƾ֤¼�� @����Ա char(20)
as
begin transaction
	--declare @����Ա char(20) 
	--select @����Ա='wy'
	declare @maxid int
	select @maxid=max(��¼���) from ״̬�� with (tablockx)
	select @maxid = case when @maxid is null then 0 else @maxid end


	declare mycursor cursor for select ��¼��� from ��¼��temp
	open mycursor
	declare @a int
	declare @i int
	select @i=@maxid

	fetch next from mycursor into @a
while (@@fetch_status=0)
begin	
update ��¼��temp
	set ��¼���=@i+1
	where current of mycursor
	select @i=@i+1
	fetch next from mycursor into @a
end 

close mycursor
deallocate mycursor

update ״̬��
	set ��¼���=@i					--��ǰ���ֵ



insert into ��¼��(��¼���,����ڼ�,ƾ֤�ֺ�,ƾ֤���,ժҪ,��Ŀ����,�跽,����,����,����,���㷽ʽ,�����,��������)
	select a.��¼���,a.����ڼ�,a.ƾ֤�ֺ�,a.ƾ֤���,a.ժҪ,a.��Ŀ����,a.�跽,a.����,a.����,a.����,a.���㷽ʽ,a.�����,a.�������� 
	from ��¼��temp as a,ƾ֤��temp as b 
	where a.ƾ֤�ֺ�=b.ƾ֤�ֺ� and a.ƾ֤���=b.ƾ֤��� and a.����ڼ�=b.����ڼ� and b.�Ƶ�=@����Ա


	
update ƾ֤��temp
	set �跽�ϼ�=e.m,�����ϼ�=e.n from
	ƾ֤��temp as b,(select sum(�跽) as m,sum(����) as n,ƾ֤�ֺ�,ƾ֤���,����ڼ� from ��¼��temp group by ƾ֤�ֺ�,ƾ֤���,����ڼ�) as e
	where e.ƾ֤�ֺ�=b.ƾ֤�ֺ� and e.ƾ֤���=b.ƾ֤��� and e.����ڼ�=b.����ڼ�



insert into ƾ֤��(�ڲ����,����ڼ�,ƾ֤�ֺ�,ƾ֤���,˳���,����,������,���,����,�Ƶ�,�跽�ϼ�,�����ϼ�)
	select �ڲ����,����ڼ�,ƾ֤�ֺ�,ƾ֤���,˳���,����,������,���,����,�Ƶ�,�跽�ϼ�,�����ϼ� from ƾ֤��temp where �Ƶ�=@����Ա

update ƾ֤��
	set ƾ֤״̬='����',����״̬='��'

declare @maxnum int
select @maxnum=max(˳�����) from ƾ֤��temp
if @maxnum is not null
begin
update ״̬��
	set ˳���=a.˳���+1 from			--��ǰ���ֵ+1,��ǰ����
	״̬�� as b,(select ˳��� from ƾ֤��temp where ˳�����=@maxnum) as a
	
	
update ״̬��
	set ���=a.ƾ֤���+1 from			--��ǰ���ֵ+1,��ǰ����
	״̬�� as b,(select ƾ֤���,ƾ֤�ֺ� from ƾ֤��temp where ˳�����=@maxnum) as a
	where a.ƾ֤�ֺ�=b.ƾ֤�ֺ�

end



delete from ��¼��temp
	where ��¼��temp.ƾ֤�ֺ�+cast(��¼��temp.ƾ֤��� as char)+cast(��¼��temp.����ڼ� as char) in (select ƾ֤�ֺ�+cast(ƾ֤��� as char)+cast(����ڼ� as char) from ƾ֤��temp)


delete from ƾ֤��temp
	where �Ƶ�=@����Ա




commit


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE proc sf_pzƾ֤���� @����Ա char(20)
as
begin transaction
insert into ������ϸ�ʲ�(��¼���, ����ڼ�, ƾ֤�ֺ�, ƾ֤���, ժҪ, ��Ŀ����, �跽, ����, ����, ����, ���㷽ʽ, �����, ��������)
	select ��¼���, a.����ڼ�, a.ƾ֤�ֺ�, a.ƾ֤���, ժҪ, ��Ŀ����, �跽, ����, ����, ����, ���㷽ʽ, �����, �������� from ��¼�� as a,ƾ֤�� as b 
		where a.����ڼ�=b.����ڼ� and a.ƾ֤�ֺ�= b.ƾ֤�ֺ� and a.ƾ֤���=b.ƾ֤��� and b.ƾ֤״̬='ͨ��' and b.����״̬='��'

update ƾ֤��
	set ����״̬='��',����=@����Ա
	where ƾ֤״̬='ͨ��' and ����״̬='��'

update ƾ֤��
	set ����=@����Ա
	where ƾ֤״̬='��ͨ��'

insert into ��¼����ʷ(��¼���, ����ڼ�, ƾ֤�ֺ�, ƾ֤���, ժҪ, ��Ŀ����, �跽, ����, ����, ����, ���㷽ʽ, �����, ��������)
	select ��¼���, a.����ڼ�, a.ƾ֤�ֺ�, a.ƾ֤���, ժҪ, ��Ŀ����, �跽, ����, ����, ����, ���㷽ʽ, �����, �������� from ��¼�� as a,ƾ֤�� as b 
		where a.����ڼ�=b.����ڼ� and a.ƾ֤�ֺ�= b.ƾ֤�ֺ� and a.ƾ֤���=b.ƾ֤��� and (b.����״̬='��' or b.ƾ֤״̬='��ͨ��')

insert into ƾ֤����ʷ(�ڲ����, ƾ֤״̬, ����ڼ�, ƾ֤�ֺ�, ƾ֤���, ˳���, ����, ������, ���, ����, �Ƶ�, �跽�ϼ�, �����ϼ�, ����״̬)
	select �ڲ����, ƾ֤״̬, ����ڼ�, ƾ֤�ֺ�, ƾ֤���, ˳���, ����, ������, ���, ����, �Ƶ�, �跽�ϼ�, �����ϼ�, ����״̬ from ƾ֤��
	where ����״̬='��' or ƾ֤״̬='��ͨ��'

delete from ��¼��
	from (��¼�� as a join ƾ֤�� as b on a.����ڼ�=b.����ڼ� and a.ƾ֤�ֺ� =b.ƾ֤�ֺ� and a.ƾ֤���=b.ƾ֤���)
	where  b.����״̬='��' or b.ƾ֤״̬='��ͨ��'

delete from ƾ֤��
	where ����״̬='��' or ƾ֤״̬='��ͨ��'


--�������
--update null to 0
update ������ϸ�ʲ�
	set �跽=(case when �跽 is null then 0 else �跽 end), ����=(case when ���� is null then 0 else ���� end)
	where ����� is null or ����� <>'��'
--update ����
update ������ϸ�ʲ�
	set ����=a.����
	from (select ��Ŀ����,���� from ��Ŀ����) as a
	where ������ϸ�ʲ�.��Ŀ����=a.��Ŀ���� and (����� is null or ����� <>'��')
--update ��Ŀ����;������ϸ�ʲ�--���
declare mycursor cursor for select ��¼���,����ڼ�,��Ŀ����,�跽,����,����,���,����� from ������ϸ�ʲ� where ����� is null or �����<>'��'
open mycursor
declare @bh int,@qj int,@dm char(20),@jf money,@df money,@fx char(2),@ye money,@bj char(4)
fetch next from mycursor into @bh,@qj,@dm,@jf,@df,@fx,@ye,@bj
	
--select @bh,@qj,@dm,@jf,@df,@fx,@ye,@bj

while (@@fetch_status=0)
begin
	update ��Ŀ����
		set ���ڽ跽������=(case when ���ڽ跽������ is null then @jf else ���ڽ跽������+@jf end),
		    ���ڴ���������=(case when ���ڴ��������� is null then @df else ���ڴ���������+@df end),
		    ����跽�ۼƷ�����=(case when ����跽�ۼƷ����� is null then @jf else ����跽�ۼƷ�����+@jf end),
		    ��������ۼƷ�����=(case when ��������ۼƷ����� is null then @df else ��������ۼƷ�����+@df end),
		    ���ڽ跽���=(case when @fx='��' then (case when ���ڽ跽��� is null then @jf-@df else ���ڽ跽���+@jf-@df end) else 0 end),
		    ���ڴ������=(case when @fx='��' then (case when ���ڴ������ is null then @df-@jf else ���ڴ������+@df-@jf end) else 0 end),
		    �������¼=@bh,
		    ����ڼ�=@qj
		where ��Ŀ����=@dm and ����ڼ�=@qj

select ��Ŀ����,@fx,����ڼ�,���ڽ跽���,���ڴ������ from ��Ŀ����  where ��Ŀ����=@dm and ����ڼ�=@qj

	update ������ϸ�ʲ�
		set ���=case when @fx='��' 
                             then  (select ���ڽ跽��� from ��Ŀ���� where ��Ŀ����=@dm and ����ڼ�=@qj)
                              else (select ���ڴ������ from ��Ŀ���� where ��Ŀ����=@dm and ����ڼ�=@qj)
                        end,     --a.���ڽ跽���
		�����='��'
--	from    ������ϸ�ʲ� as b
	where current of mycursor
 
--(select ��Ŀ����,����ڼ�,���ڽ跽���,���ڴ������ from ��Ŀ���� where ��Ŀ����=@dm and ����ڼ�=@qj) as a
select * from ������ϸ�ʲ�
--select * from ��Ŀ���� where ���ڽ跽������ is not null


	fetch next from mycursor into @bh,@qj,@dm,@jf,@df,@fx,@ye,@bj

end
close mycursor
deallocate mycursor

	






commit




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE proc sf_pz����ƾ֤��
as
begin transaction

declare @maxnum int
	select @maxnum=max(˳�����) from ƾ֤��temp 
	delete ƾ֤��temp
	where ˳�����>(select min(˳�����) from ƾ֤��temp as a,(select ƾ֤�ֺ�,ƾ֤���,����ڼ� from ƾ֤��temp where ˳�����=@Maxnum) as b where a.ƾ֤���=b.ƾ֤��� and a.ƾ֤�ֺ�=b.ƾ֤�ֺ� and a.����ڼ�=b.����ڼ�)


update ��¼��temp
	set ˳�����=a.˳�����	from
	(select '˳�����'=min(˳�����) from ƾ֤��temp) as a

commit

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

