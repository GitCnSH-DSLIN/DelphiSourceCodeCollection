if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�ɹ�����_������_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[�ɹ�����] DROP CONSTRAINT �ɹ�����_������_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�ɹ�������ʷ_������_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[�ɹ�������ʷ] DROP CONSTRAINT �ɹ�������ʷ_������_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�ɹ���ͬ_������_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[�ɹ���ͬ] DROP CONSTRAINT �ɹ���ͬ_������_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������_������_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[������] DROP CONSTRAINT ������_������_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������ʷ_������_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��������ʷ] DROP CONSTRAINT ��������ʷ_������_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Ӧ����_������_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Ӧ����] DROP CONSTRAINT Ӧ����_������_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Ԥ����_������_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Ԥ����] DROP CONSTRAINT Ԥ����_������_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Ԥ�տ�_������_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Ԥ�տ�] DROP CONSTRAINT Ԥ�տ�_������_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[������] DROP CONSTRAINT ������_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������ʷ_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��������ʷ] DROP CONSTRAINT ��������ʷ_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�ɹ�������ϸ_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[�ɹ�������ϸ] DROP CONSTRAINT �ɹ�������ϸ_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�ɹ�������ϸ��ʷ_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[�ɹ�������ϸ��ʷ] DROP CONSTRAINT �ɹ�������ϸ��ʷ_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�ɹ���ͬ_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[�ɹ���ͬ] DROP CONSTRAINT �ɹ���ͬ_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[������] DROP CONSTRAINT ������_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������ʷ_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��������ʷ] DROP CONSTRAINT ��������ʷ_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��������] DROP CONSTRAINT ��������_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������ϸ_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��������ϸ] DROP CONSTRAINT ��������ϸ_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������ϸ��ʷ_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��������ϸ��ʷ] DROP CONSTRAINT ��������ϸ��ʷ_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������ܱ�_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��������ܱ�] DROP CONSTRAINT ��������ܱ�_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[����_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[����] DROP CONSTRAINT ����_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�̵㵥_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[�̵㵥] DROP CONSTRAINT �̵㵥_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�̵㵥��ʷ_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[�̵㵥��ʷ] DROP CONSTRAINT �̵㵥��ʷ_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�����޶��ձ�_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[�����޶��ձ�] DROP CONSTRAINT �����޶��ձ�_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���۵���ϸ_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���۵���ϸ] DROP CONSTRAINT ���۵���ϸ_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���۵���ϸ��ʷ_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���۵���ϸ��ʷ] DROP CONSTRAINT ���۵���ϸ��ʷ_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���۶�����ϸ_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���۶�����ϸ] DROP CONSTRAINT ���۶�����ϸ_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���۶�����ϸ��ʷ_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���۶�����ϸ��ʷ] DROP CONSTRAINT ���۶�����ϸ��ʷ_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���ۺ�ͬ_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���ۺ�ͬ] DROP CONSTRAINT ���ۺ�ͬ_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�����ձ�_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[�����ձ�] DROP CONSTRAINT �����ձ�_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���˻���_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���˻���] DROP CONSTRAINT ���˻���_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���˻�����ʷ_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���˻�����ʷ] DROP CONSTRAINT ���˻�����ʷ_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Ӧ����_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Ӧ����] DROP CONSTRAINT Ӧ����_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Ӧ�տ�_����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Ӧ�տ�] DROP CONSTRAINT Ӧ�տ�_����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���۵�_�ͻ����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���۵�] DROP CONSTRAINT ���۵�_�ͻ����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���۵���ʷ_�ͻ����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���۵���ʷ] DROP CONSTRAINT ���۵���ʷ_�ͻ����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���۶���_�ͻ����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���۶���] DROP CONSTRAINT ���۶���_�ͻ����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���۶�����ʷ_�ͻ����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���۶�����ʷ] DROP CONSTRAINT ���۶�����ʷ_�ͻ����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���ۺ�ͬ_�ͻ����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���ۺ�ͬ] DROP CONSTRAINT ���ۺ�ͬ_�ͻ����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Ӧ�տ�_�ͻ����_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Ӧ�տ�] DROP CONSTRAINT Ӧ�տ�_�ͻ����_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_��������ϸ_������]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��������ϸ] DROP CONSTRAINT FK_��������ϸ_������
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_�ɹ�������ϸ_�ɹ�����]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[�ɹ�������ϸ] DROP CONSTRAINT FK_�ɹ�������ϸ_�ɹ�����
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_���۵���ϸ_���۵�]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���۵���ϸ] DROP CONSTRAINT FK_���۵���ϸ_���۵�
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_���۶�����ϸ_���۶���]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���۶�����ϸ] DROP CONSTRAINT FK_���۶�����ϸ_���۶���
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�����޶��ձ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�����޶��ձ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ҵ��Ա�嵥]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ҵ��Ա�嵥]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�ֿ��嵥]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�ֿ��嵥]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�������嵥]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�������嵥]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��Ʒ�嵥]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��Ʒ�嵥]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�ͻ��嵥]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�ͻ��嵥]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[����]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[����]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Ӧ����]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Ӧ����]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Ӧ�տ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Ӧ�տ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[������]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������ʷ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��������ʷ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Ȩ���嵥]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Ȩ���嵥]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ÿ�½������ڱ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ÿ�½������ڱ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�û��嵥]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�û��嵥]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�̵㵥]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�̵㵥]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�̵㵥��ʷ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�̵㵥��ʷ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������ʷ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[������ʷ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[������]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������ʷ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��������ʷ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��������]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���۵�����]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���۵�����]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[������]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������ʷ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��������ʷ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������ϸ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��������ϸ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������ϸ��ʷ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��������ϸ��ʷ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������ܱ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��������ܱ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�ɹ���ͬ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�ɹ���ͬ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�ɹ�����]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�ɹ�����]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�ɹ�������ʷ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�ɹ�������ʷ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�ɹ�������ϸ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�ɹ�������ϸ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�ɹ�������ϸ��ʷ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�ɹ�������ϸ��ʷ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���۵�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���۵�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���۵���ʷ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���۵���ʷ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���۵���ϸ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���۵���ϸ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���۵���ϸ��ʷ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���۵���ϸ��ʷ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���ۺ�ͬ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���ۺ�ͬ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�����ձ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�����ձ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���۶���]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���۶���]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���۶�����ʷ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���۶�����ʷ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���۶�����ϸ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���۶�����ϸ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���۶�����ϸ��ʷ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���۶�����ϸ��ʷ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���˻���]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���˻���]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���˻�����ʷ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���˻�����ʷ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Ԥ����]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Ԥ����]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Ԥ�տ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Ԥ�տ�]
GO



------------����
CREATE TABLE [dbo].[��Ʒ�嵥] (
	[����] [char] (14) NOT NULL Primary Key,
	[����] [char] (14) NULL ,
	[ƴ������] [char] (40) NULL ,
	[Ʒ��] [varchar] (80) NULL ,
	[���] [varchar] (40) NULL ,
	[��λ] [char] (6) NOT NULL ,
	[����] [varchar] (50) NULL ,
	[���] [char] (20) NULL ,
	[������] [decimal] (28,6) NULL default(0),
	[���ۼ�1] [decimal] (28,6) NULL default(0),
	[���ۼ�2] [decimal] (28,6) NULL default(0),
	[����ۼ�] [decimal] (28,6) NULL default(0)
)
GO

CREATE TABLE [dbo].[�������嵥] (
	[�����̺�] [char] (10) NOT NULL Primary Key,
	[ƴ������] [char] (40) NOT NULL ,
	[���] [varchar] (80) NULL ,
	[����] [varchar] (80) NULL ,
	[��ַ] [varchar] (80) NULL ,
	[�ʱ�] [char] (6) NULL ,
	[����] [char] (6) NULL ,
	[����] [varchar] (12) NULL ,
	[����] [char] (10) NULL ,
	[�绰] [varchar] (20) NULL ,
	[����] [varchar] (20) NULL ,
	[�籨] [varchar] (20) NULL ,
	[������] [varchar] (40) NULL ,
	[�������ʱ�] [char] (6) NULL ,
	[�����ʺ�] [varchar] (20) NULL ,
	[˰��] [varchar] (20) NULL ,
	[�ⷿ��ַ] [varchar] (40) NULL ,
	[�ⷿ�绰] [varchar] (20) NULL ,
	[ҵ��Ա] [char] (10) NULL ,
	[ҵ����] [varchar] (20) NULL ,
)
GO

CREATE TABLE [dbo].[�ͻ��嵥] (
	[�ͻ����] [char] (10) NOT NULL Primary Key,
	[ƴ������] [char] (20) NOT NULL ,
	[���] [varchar] (80) NULL ,
	[����] [varchar] (80) NULL ,
	[��ϵ��] [varchar] (30) NULL ,
	[��ַ] [varchar] (80) NULL ,
	[�ʱ�] [char] (6) NULL ,
	[����] [char] (6) NULL ,
	[����] [varchar] (12) NULL ,
	[�绰] [varchar] (20) NULL ,
	[����] [varchar] (20) NULL ,
	[�籨] [varchar] (20) NULL ,
	[������] [varchar] (40) NULL ,
	[�������ʱ�] [char] (6) NULL ,
	[�����ʺ�] [varchar] (20) NULL ,
	[˰��] [varchar] (20) NULL ,
	[����] [varchar] (10) NULL ,
	[ҵ��Ա] [char] (10) NULL ,
	[ҵ����] [varchar] (20) NULL ,
	[���Ŷ��] [decimal] (28,6)  NULL 
)
GO


CREATE TABLE [dbo].[ҵ��Ա�嵥] (
	[ҵ��Ա��] [char] (14) NOT NULL Primary Key,
	[����] [char] (10) NULL ,
	[�Ա�] [char] (2) NULL ,
	[�绰] [varchar] (20) NULL ,
	[�ֻ�] [char] (14) NULL ,
	[��ַ] [varchar] (80) NULL ,
	[�ʱ�] [char] (6) NULL ,
	[���֤��] [char] (16) NULL ,
	[���] [char] (16) NULL
)
GO

CREATE TABLE [dbo].[�ֿ��嵥] (
	[�ֿ��] [char] (14) NOT NULL Primary Key,
	[�ֿ���] [varchar] (30) NULL ,
	[���] [char] (16) NULL ,
	[��ע] [varchar] (40) NULL 
)
GO

CREATE TABLE [dbo].[�û��嵥] (
	[�û����] [char] (6) NOT NULL Primary key,
	[����] [char] (20) NOT NULL ,
	[����] [char] (10) NOT NULL ,
	[�Ա�] [char] (2) NOT NULL ,
	[����] [char] (10) NULL
) 

CREATE TABLE [dbo].[Ȩ���嵥] (
	[Ȩ�����] [int] IDENTITY (1, 1) NOT NULL ,
	[�û����] [char] (6) NULL ,
	[����] [char] (20) NULL ,
	[Ȩ������] [char] (30) NOT NULL 
)
GO

CREATE TABLE [dbo].[�ɹ���ͬ] (
	[�����̺�] [char] (10) NOT NULL ,
	[����] [char] (14) NOT NULL ,
	[����] [decimal] (28,6) null default 0 ,
	[���ʽ] [varchar] (20) NULL ,
	[����] [int] NULL ,
	[ǩ������] [int] NULL ,
	[��ͬ����] [int] NULL
)
GO

CREATE TABLE [dbo].[���ۺ�ͬ] (
	[�ͻ����] [char] (10) NOT NULL ,
	[����] [char] (14) NOT NULL ,
	[�ۼ�] [decimal] (28,6) null default 0 ,
	[���ʽ] [varchar] (20) NULL ,
	[����] [int] NULL ,
	[ǩ������] [int] NULL ,
	[��ͬ����] [int] NULL
)
GO

CREATE TABLE [dbo].[�ɹ�����] (
	[���] [char] (14) Not NULL Primary key,
	[�����̺�] [char] (10) NOT NULL ,
	[��������] [datetime] NULL,
	[��Ч����] [datetime] NULL ,
	[��Чֹ��] [datetime] NULL ,
	[ҵ��Ա]   [char] (10) NULL ,
	[�Ƶ���]   [char] (10) NULL ,
	[˰�ۺϼ�] [decimal] (28,6) NULL ,
	[����˰��] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL 
)
GO

CREATE TABLE [dbo].[�ɹ�������ϸ] (
	[���] [char] (14) Not NULL Primary key,
	[������] [char] (14) Not NULL,
	[����] [char] (14) NOT NULL ,
	[��������] [decimal] (28,6) NOT NULL ,
	[����] [decimal] (28,6) NULL ,
	[˰�ۺϼ�] [decimal] (28,6) NULL ,
	[����] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL ,
	[����˰��] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL 
)
GO

CREATE TABLE [dbo].[�ɹ�������ʷ] (
	[���] [char] (14) Not NULL Primary key,
	[�����̺�] [char] (10) NOT NULL ,
	[��������] [datetime] NULL,
	[��Ч����] [datetime] NULL ,
	[��Чֹ��] [datetime] NULL ,
	[ҵ��Ա]   [char] (10) NULL ,
	[�Ƶ���]   [char] (10) NULL ,
	[˰�ۺϼ�] [decimal] (28,6) NULL ,
	[����˰��] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL 
)
GO

CREATE TABLE [dbo].[�ɹ�������ϸ��ʷ] (
	[���] [char] (14) Not NULL Primary key,
	[������] [char] (14) Not NULL,
	[����] [char] (14) NOT NULL ,
	[��������] [decimal] (28,6) NOT NULL ,
	[����] [decimal] (28,6) NULL ,
	[˰�ۺϼ�] [decimal] (28,6) NULL ,
	[����] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL ,
	[����˰��] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL 
)
GO

CREATE TABLE [dbo].[������] (
	[���] [char] (14) Not NULL Primary key,
	[�����̺�] [char] (10) NOT NULL ,
	[��������] [datetime] NULL,
	[ҵ��Ա]   [char] (10) NULL ,
	[�Ƶ���]   [char] (10) NULL ,
	[����Ա] [char] (10) NULL ,
	[����Ա] [char] (10) NULL ,
	[˰�ۺϼ�] [decimal] (28,6) NULL ,
	[����˰��] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL, 
	[������] [char] (14) NULL
)
GO

CREATE TABLE [dbo].[��������ϸ] (
	[���] [char] (14) Not NULL Primary key,
	[��������] [char] (14) Not NULL ,
	[����] [char] (14) NOT NULL ,
	[��������] [decimal] (28,6) NOT NULL ,
	[����] [decimal] (28,6) NULL ,
	[˰�ۺϼ�] [decimal] (28,6) NULL ,
	[����] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL ,
	[����˰��] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL ,
	[�ֿ�] [char] (20) NULL ,
	[��������] [varchar] (50) NULL 
)
GO

CREATE TABLE [dbo].[��������ʷ] (
	[���] [char] (14) Not NULL Primary key,
	[�����̺�] [char] (10) NOT NULL ,
	[��������] [datetime] NULL,
	[ҵ��Ա]   [char] (10) NULL ,
	[�Ƶ���]   [char] (10) NULL ,
	[����Ա] [char] (10) NULL ,
	[����Ա] [char] (10) NULL ,
	[˰�ۺϼ�] [decimal] (28,6) NULL ,
	[����˰��] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL , 
	[������] [char] (14) NULL
)
GO

CREATE TABLE [dbo].[��������ϸ��ʷ] (
	[���] [char] (14) Not NULL Primary key,
	[��������] [char] (14) Not NULL ,
	[����] [char] (14) NOT NULL ,
	[��������] [decimal] (28,6) NOT NULL ,
	[����] [decimal] (28,6) NULL ,
	[˰�ۺϼ�] [decimal] (28,6) NULL ,
	[����] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL ,
	[����˰��] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL ,
	[�ֿ�] [char] (20) NULL ,
	[��������] [varchar] (50) NULL 
)
GO

CREATE TABLE [dbo].[���۵�����] (
	[�ڲ����] [int] Identity(1,1) NOt NULL primary key,
	[���] [char] (14) NOT NULL ,
	[��������] [decimal] (28,6) NULL,
	[ԭ����] [decimal] (28,6) NOT NULL ,
	[�½���] [decimal] (28,6) NOT NULL ,
	[��������] [int] NOT NULL ,
	[�Ƶ���] [char] (10) NOT NULL
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[���۶���] (
	[���] [char] (14) Not NULL Primary key,
	[�ͻ����] [char] (10) NOT NULL ,
	[��������] [datetime] NULL,
	[��Ч����] [datetime] NULL ,
	[��Чֹ��] [datetime] NULL ,
	[ҵ��Ա]   [char] (10) NULL ,
	[�Ƶ���]   [char] (10) NULL ,
	[˰�ۺϼ�] [decimal] (28,6) NULL ,
	[����˰��] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL 
)
GO

CREATE TABLE [dbo].[���۶�����ϸ] (
	[���] [char] (14) Not NULL Primary key,
	[������] [char] (14) Not NULL,
	[����] [char] (14) NOT NULL ,
	[��������] [decimal] (28,6) NOT NULL ,
	[���ۼ�] [decimal] (28,6) NULL ,
	[˰�ۺϼ�] [decimal] (28,6) NULL ,
	[����] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL ,
	[����˰��] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL 
)
GO

CREATE TABLE [dbo].[���۶�����ʷ] (
	[���] [char] (14) Not NULL Primary key,
	[�ͻ����] [char] (10) NOT NULL ,
	[��������] [datetime] NULL,
	[��Ч����] [datetime] NULL ,
	[��Чֹ��] [datetime] NULL ,
	[ҵ��Ա]   [char] (10) NULL ,
	[�Ƶ���]   [char] (10) NULL ,
	[˰�ۺϼ�] [decimal] (28,6) NULL ,
	[����˰��] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL 
)
GO

CREATE TABLE [dbo].[���۶�����ϸ��ʷ] 
(
	[���] [char] (14) Not NULL Primary key,
	[������] [char] (14) Not NULL,
	[����] [char] (14) NOT NULL ,
	[��������] [decimal] (28,6) NOT NULL ,
	[���ۼ�] [decimal] (28,6) NULL ,
	[˰�ۺϼ�] [decimal] (28,6) NULL ,
	[����] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL ,
	[����˰��] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL 
)
GO

CREATE TABLE [dbo].[���۵�] (
	[���] [char] (14) Not NULL Primary key,
	[�ͻ����] [char] (10) NOT NULL ,
	[��������] [datetime] NULL,
	[ҵ��Ա]   [char] (10) NULL ,
	[�Ƶ���]   [char] (10) NULL ,
	[����Ա] [char] (10) NULL ,
	[˰�ۺϼ�] [decimal] (28,6) NULL ,
	[����˰��] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL, 
	[������] [char] (14) Not NULL
)
GO

CREATE TABLE [dbo].[���۵���ϸ] (
	[���] [char] (14) Not NULL Primary key,
	[���۵���] [char] (14) Not NULL ,
	[����] [char] (14) NOT NULL ,
	[��������] [decimal] (28,6) NOT NULL ,
	[���ۼ�] [decimal] (28,6) NULL ,
	[˰�ۺϼ�] [decimal] (28,6) NULL ,
	[����] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL ,
	[����˰��] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL ,
	[�ֿ�] [char] (20) NULL 
)
GO

CREATE TABLE [dbo].[���۵���ʷ] (
	[���] [char] (14) Not NULL Primary key,
	[�ͻ����] [char] (10) NOT NULL ,
	[��������] [datetime] NULL,
	[ҵ��Ա]   [char] (10) NULL ,
	[�Ƶ���]   [char] (10) NULL ,
	[����Ա] [char] (10) NULL ,
	[˰�ۺϼ�] [decimal] (28,6) NULL ,
	[����˰��] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL, 
	[������] [char] (14) Not NULL
)
GO

CREATE TABLE [dbo].[���۵���ϸ��ʷ] (
	[���] [char] (14) Not NULL Primary key,
	[���۵���] [char] (14) Not NULL ,
	[����] [char] (14) NOT NULL ,
	[��������] [decimal] (28,6) NOT NULL ,
	[���ۼ�] [decimal] (28,6) NULL ,
	[˰�ۺϼ�] [decimal] (28,6) NULL ,
	[����] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL ,
	[����˰��] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL ,
	[�ֿ�] [char] (20) NULL 
)
GO

CREATE TABLE [dbo].[���˻���] (
	[���] [char] (14) Not NULL Primary key,
	[���۵����] [char] (14) Not NULL ,
	[����] [char] (14) NOT NULL ,
	[�˻�����] [decimal] (28,6) NOT NULL ,
	[���ۼ�] [decimal] (28,6) NULL ,
	[˰�ۺϼ�] [decimal] (28,6) NULL ,
	[����] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL ,
	[����˰��] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL ,
	[�ֿ�] [char] (20) NULL 
)
GO

CREATE TABLE [dbo].[���˻�����ʷ] (
	[���] [char] (14) Not NULL Primary key,
	[���۵����] [char] (14) Not NULL ,
	[����] [char] (14) NOT NULL ,
	[�˻�����] [decimal] (28,6) NOT NULL ,
	[���ۼ�] [decimal] (28,6) NULL ,
	[˰�ۺϼ�] [decimal] (28,6) NULL ,
	[����] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL ,
	[����˰��] [decimal] (28,6) NULL ,
	[˰��] [decimal] (28,6) NULL ,
	[�ֿ�] [char] (20) NULL 
)
GO

CREATE TABLE [dbo].[������] (
	[���] [char] (14) NOT NULL primary key,
	[Դ����] [varchar] (20) NULL ,
	[Ŀ�Ĳ���] [varchar] (20) NULL ,
	[����] [char] (14) NOT NULL ,
	[����] [decimal] (28,6) NOT NULL ,
	[����] [decimal] (28,6) NOT NULL ,
	[�ϼƽ��] [decimal] (28,6) NULL ,
	[��������] [int] NULL ,
	[�Ƶ���] [char] (10) NULL ,
	[����ԭ��] [varchar] (20) NULL
)
GO


CREATE TABLE [dbo].[��������ʷ] (
	[���] [char] (14) NOT NULL primary key,
	[Դ����] [varchar] (20) NULL ,
	[Ŀ�Ĳ���] [varchar] (20) NULL ,
	[����] [char] (14) NOT NULL ,
	[����] [decimal] (28,6) NOT NULL ,
	[����] [decimal] (28,6) NOT NULL ,
	[�ϼƽ��] [decimal] (28,6) NULL ,
	[��������] [int] NULL ,
	[�Ƶ���] [char] (10) NULL ,
	[����ԭ��] [varchar] (20) NULL
)
GO


CREATE TABLE [dbo].[������] (
	[���] [char] (14) NOT NULL primary key,
	[����] [char] (14) NOT NULL ,
	[�ֿ�] [varchar] (20) NOT NULL ,
	[����] [decimal] (28,6) NULL ,
	[��浥��] [decimal] (28,6) NULL ,
	[���] [decimal] (28,6) NULL ,
	[����] [int] NULL ,
	[������] [char] (10) NULL ,
	[�Ƶ���] [char] (10) NULL
)
GO

CREATE TABLE [dbo].[��������ʷ] (
	[���] [char] (14) NOT NULL primary key,
	[����] [char] (14) NOT NULL ,
	[�ֿ�] [varchar] (20) NOT NULL ,
	[����] [decimal] (28,6) NULL ,
	[��浥��] [decimal] (28,6) NULL ,
	[���] [decimal] (28,6) NULL ,
	[����] [int] NULL ,
	[������] [char] (10) NULL ,
	[�Ƶ���] [char] (10) NULL
)
GO

CREATE TABLE [dbo].[�����޶��ձ�] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[�ֿ��] [char] (6) NOT NULL ,
	[����] [char] (14) NOT NULL ,
	[����] [decimal] (28,6) NULL ,
	[����] [decimal] (28,6) NULL ,
	[��Ѵ���] [decimal] (28,6) NULL ,
	[��ע] [varchar] (50) NULL
)
GO

CREATE TABLE [dbo].[Ԥ����] (
	[�����̺�] [char] (10) NOT NULL primary key,
	[Ԥ�����ܶ�] [decimal] (28,6) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Ӧ����] (
	[���] [char] (14) NOT NULL primary key,
	[��Ʊ��] [char] (14) NULL ,	
	[��Ʊ����] [int] NULL,
	[��������] [char] (14) NULL ,
	[����] [char] (14) NOT NULL ,
	[�����̺�] [char] (10) NOT NULL ,
	[����] [decimal] (28,6) NOT NULL ,
	[��������] [decimal] (28,6) NULL ,
	[���] [decimal] (28,6) NULL ,
	[��������] [int] NULL ,
	[��ϸ˵��] [varchar] (100) NULL ,
	[��������] [datetime] NULL,
	[״̬] [char] (6) NULL,
	[��Ԥ��] [char] (2) NULL 
)
GO

CREATE TABLE [dbo].[Ԥ�տ�] (
	[�����̺�] [char] (10) NOT NULL primary key,
	[Ԥ�տ��ܶ�] [decimal] (28,6) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Ӧ�տ�] (
	[���] [char] (14) NOT NULL primary key,
	[��Ʊ��] [char] (14) NULL ,	
	[��Ʊ����] [int] NULL,
	[���۵���] [char] (14) NULL ,
	[����] [char] (14) NOT NULL ,
	[�ͻ����] [char] (10) NOT NULL ,
	[����] [decimal] (28,6) NOT NULL ,
	[���ۼ�] [decimal] (28,6) NULL ,
	[���] [decimal] (28,6) NULL ,
	[�տ�����] [int] NULL ,
	[��ϸ˵��] [varchar] (100) NULL ,
	[��������] [datetime] NULL,
	[״̬] [char] (6) NULL,
	[��Ԥ��] [char] (2) NULL 
)
GO

CREATE TABLE [dbo].[ÿ�½������ڱ�] (
	[�·�] [int] not null primary key,
	[ȫ��] [char] (4),
	[��������] [int] not null default 25        -- Ĭ��ÿ��25�Ž���
)
GO

CREATE TABLE ������ʷ (
	���ʱ�� CHAR(14),
	�������� CHAR(10),
	�������� INT,
	���ν��� char(2) DEFAULT '��',
	��ע CHAR(40)
)
GO

CREATE TABLE ��������ܱ� (
	���ʱ�� CHAR(14),
	���� int,
	���� CHAR(14),
	���ڽ������� decimal(28,6) DEFAULT 0,
	���ڽ��ʽ�� numeric(30,2) DEFAULT 0,
	�跽���� decimal(28,6) DEFAULT 0,
	�跽��� numeric(30,2) DEFAULT 0,
	�������� decimal(28,6) DEFAULT 0,
	������� numeric(30,2) DEFAULT 0,
	���ڽ������ decimal(28,6) DEFAULT 0,
	���ڽ���� numeric(30,2) DEFAULT 0,
	��ע char(20)
)
GO


CREATE TABLE [dbo].[�����ձ�] (
	[����] [int] NOT NULL ,
	[����] [varchar] (20) NOT NULL ,
	[���] [varchar] (20) NOT NULL ,
	[�տ����] [char] (4) NOT NULL ,
	[����] [char] (14) NOT NULL ,
	[���] [char] (8) NOT NULL ,
	[��������] [decimal] (28,6) NULL ,
	[Ӧ�ս��] [decimal] (28,6) NULL ,
	[ʵ�ս��] [decimal] (28,6) NULL ,
	[��浥��] [decimal] (28,6) NULL 
)
GO


CREATE TABLE [dbo].[��������] (
	[���] [char] (14) Not NULL Primary key,
	[����] [varchar] (20) NULL ,
	[���] [varchar] (20) NULL ,
	[����] [char] (14) NOT NULL ,
	[����] [decimal] (28,6) NULL ,
	[����] [int] NULL ,
	[������] [char] (10) NULL ,
	[����˵��] [varchar] (100) NULL ,
	[�ظ�] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[����] (
	[����] [char] (14) NOT NULL ,
	[�ֿ�] [varchar] (20) NOT NULL ,
	[�������] [decimal] (28,6) NOT NULL ,
	[�����] [decimal] (28,6) NOT NULL ,
	[��浥��] [decimal] (28,6) NOT NULL ,
	[���½���] [decimal] (28,6) NULL 
)
GO

CREATE TABLE [dbo].[�̵㵥] (
	[���] [int] NOT NULL primary key,
	[����] [char] (14) NOT NULL ,
	[�ֿ�] [varchar] (20) NOT NULL ,
	[ԭ�����] [decimal] (28,6) NULL ,
	[ԭ�����] [decimal] (28,6) NULL ,
	[ԭ��浥��] [decimal] (28,6) NULL ,
	[�¿������] [decimal] (28,6) NULL ,
	[�¿����] [decimal] (28,6) NULL ,
	[�¿�浥��] [decimal] (28,6) NULL ,
	[�Ƶ���] [char] (10) NULL ,
	[��������] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�̵㵥��ʷ] (
	[���] [int] NOT NULL primary key,
	[����] [char] (14) NOT NULL ,
	[�ֿ�] [varchar] (20) NOT NULL ,
	[ԭ�����] [decimal] (28,6) NULL ,
	[ԭ�����] [decimal] (28,6) NULL ,
	[ԭ��浥��] [decimal] (28,6) NULL ,
	[�¿������] [decimal] (28,6) NULL ,
	[�¿����] [decimal] (28,6) NULL ,
	[�¿�浥��] [decimal] (28,6) NULL ,
	[�Ƶ���] [char] (10) NULL ,
	[��������] [int] NULL 
) ON [PRIMARY]
GO



--���
ALTER TABLE [dbo].[�����޶��ձ�] ADD 
	CONSTRAINT [�����޶��ձ�_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[����] ADD 
	CONSTRAINT [����_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[Ӧ����] ADD 
	CONSTRAINT [Ӧ����_������_fk] FOREIGN KEY 
	(
		[�����̺�]
	) REFERENCES [dbo].[�������嵥] (
		[�����̺�]
	),
	CONSTRAINT [Ӧ����_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[Ӧ�տ�] ADD 
	CONSTRAINT [Ӧ�տ�_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	),
	CONSTRAINT [Ӧ�տ�_�ͻ����_fk] FOREIGN KEY 
	(
		[�ͻ����]
	) REFERENCES [dbo].[�ͻ��嵥] (
		[�ͻ����]
	)
GO

ALTER TABLE [dbo].[������] ADD 
	CONSTRAINT [������_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[��������ʷ] ADD 
	CONSTRAINT [��������ʷ_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[�̵㵥] ADD 
	CONSTRAINT [�̵㵥_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[�̵㵥��ʷ] ADD 
	CONSTRAINT [�̵㵥��ʷ_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[������] ADD 
	CONSTRAINT [������_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[��������ʷ] ADD 
	CONSTRAINT [��������ʷ_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[��������] ADD 
	CONSTRAINT [��������_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[������] ADD 
	CONSTRAINT [������_������_fk] FOREIGN KEY 
	(
		[�����̺�]
	) REFERENCES [dbo].[�������嵥] (
		[�����̺�]
	)
GO

ALTER TABLE [dbo].[��������ʷ] ADD 
	CONSTRAINT [��������ʷ_������_fk] FOREIGN KEY 
	(
		[�����̺�]
	) REFERENCES [dbo].[�������嵥] (
		[�����̺�]
	)
GO

ALTER TABLE [dbo].[��������ϸ] ADD 
	CONSTRAINT [FK_��������ϸ_������] FOREIGN KEY 
	(
		[��������]
	) REFERENCES [dbo].[������] (
		[���]
	),
	CONSTRAINT [��������ϸ_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[��������ϸ��ʷ] ADD 
	CONSTRAINT [��������ϸ��ʷ_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[��������ܱ�] ADD 
	CONSTRAINT [��������ܱ�_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[�ɹ���ͬ] ADD 
	CONSTRAINT [�ɹ���ͬ_������_fk] FOREIGN KEY 
	(
		[�����̺�]
	) REFERENCES [dbo].[�������嵥] (
		[�����̺�]
	),
	CONSTRAINT [�ɹ���ͬ_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[�ɹ�����] ADD 
	CONSTRAINT [�ɹ�����_������_fk] FOREIGN KEY 
	(
		[�����̺�]
	) REFERENCES [dbo].[�������嵥] (
		[�����̺�]
	)
GO

ALTER TABLE [dbo].[�ɹ�������ʷ] ADD 
	CONSTRAINT [�ɹ�������ʷ_������_fk] FOREIGN KEY 
	(
		[�����̺�]
	) REFERENCES [dbo].[�������嵥] (
		[�����̺�]
	)
GO

ALTER TABLE [dbo].[�ɹ�������ϸ] ADD 
	CONSTRAINT [FK_�ɹ�������ϸ_�ɹ�����] FOREIGN KEY 
	(
		[������]
	) REFERENCES [dbo].[�ɹ�����] (
		[���]
	),
	CONSTRAINT [�ɹ�������ϸ_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[�ɹ�������ϸ��ʷ] ADD 
	CONSTRAINT [�ɹ�������ϸ��ʷ_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[���۵�] ADD 
	CONSTRAINT [���۵�_�ͻ����_fk] FOREIGN KEY 
	(
		[�ͻ����]
	) REFERENCES [dbo].[�ͻ��嵥] (
		[�ͻ����]
	)
GO

ALTER TABLE [dbo].[���۵���ʷ] ADD 
	CONSTRAINT [���۵���ʷ_�ͻ����_fk] FOREIGN KEY 
	(
		[�ͻ����]
	) REFERENCES [dbo].[�ͻ��嵥] (
		[�ͻ����]
	)
GO

ALTER TABLE [dbo].[���۵���ϸ] ADD 
	CONSTRAINT [FK_���۵���ϸ_���۵�] FOREIGN KEY 
	(
		[���۵���]
	) REFERENCES [dbo].[���۵�] (
		[���]
	),
	CONSTRAINT [���۵���ϸ_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[���۵���ϸ��ʷ] ADD 
	CONSTRAINT [���۵���ϸ��ʷ_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[���ۺ�ͬ] ADD 
	CONSTRAINT [���ۺ�ͬ_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	),
	CONSTRAINT [���ۺ�ͬ_�ͻ����_fk] FOREIGN KEY 
	(
		[�ͻ����]
	) REFERENCES [dbo].[�ͻ��嵥] (
		[�ͻ����]
	)
GO

ALTER TABLE [dbo].[�����ձ�] ADD 
	CONSTRAINT [�����ձ�_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[���۶���] ADD 
	CONSTRAINT [���۶���_�ͻ����_fk] FOREIGN KEY 
	(
		[�ͻ����]
	) REFERENCES [dbo].[�ͻ��嵥] (
		[�ͻ����]
	)
GO

ALTER TABLE [dbo].[���۶�����ʷ] ADD 
	CONSTRAINT [���۶�����ʷ_�ͻ����_fk] FOREIGN KEY 
	(
		[�ͻ����]
	) REFERENCES [dbo].[�ͻ��嵥] (
		[�ͻ����]
	)
GO

ALTER TABLE [dbo].[���۶�����ϸ] ADD 
	CONSTRAINT [FK_���۶�����ϸ_���۶���] FOREIGN KEY 
	(
		[������]
	) REFERENCES [dbo].[���۶���] (
		[���]
	),
	CONSTRAINT [���۶�����ϸ_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[���۶�����ϸ��ʷ] ADD 
	CONSTRAINT [���۶�����ϸ��ʷ_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[���˻���] ADD 
	CONSTRAINT [���˻���_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[���˻�����ʷ] ADD 
	CONSTRAINT [���˻�����ʷ_����_fk] FOREIGN KEY 
	(
		[����]
	) REFERENCES [dbo].[��Ʒ�嵥] (
		[����]
	)
GO

ALTER TABLE [dbo].[Ԥ����] ADD 
	CONSTRAINT [Ԥ����_������_fk] FOREIGN KEY 
	(
		[�����̺�]
	) REFERENCES [dbo].[�������嵥] (
		[�����̺�]
	)
GO

ALTER TABLE [dbo].[Ԥ�տ�] ADD 
	CONSTRAINT [Ԥ�տ�_������_fk] FOREIGN KEY 
	(
		[�����̺�]
	) REFERENCES [dbo].[�������嵥] (
		[�����̺�]
	)
GO




--- �����Ǵ洢����

CREATE PROCEDURE sf_������
AS
begin transaction
	-- ������û��,���Ӽ�¼
	INSERT INTO ����(����,�ֿ�,�������,�����,��浥��) SELECT DISTINCT j.����, j.�ֿ�, 0,0,0
			FROM ��������ϸ AS J left join ���� as k on ( j.�ֿ�=k.�ֿ� and j.����=k.���� )
			where k.���� is null
	-- �޸Ŀ����Ϣ
	UPDATE ���� SET ��浥��=case when �������<=0 or (�������+����ALL)<=0 then ����
					else (�����+˰�ۺϼ�ALL)/(�������+����ALL) end ,
			�������=�������+����ALL,
			�����=case when �������<=0 or (�������+����ALL)<=0 
				then ����*(�������+����ALL) else (�����+˰�ۺϼ�ALL) end ,
			���½���=����
		FROM 
		(SELECT �ֿ�,����,'����ALL'=sum(��������), '����' = sum(˰�ۺϼ�)/sum(��������), 
			'˰�ۺϼ�ALL'=sum(˰�ۺϼ�) FROM ��������ϸ GROUP BY �ֿ�,����) AS LSJ
		WHERE  ����.�ֿ�=LSj.�ֿ� AND ����.����=LSj.����
	-- ����Ӧ����
	INSERT INTO Ӧ����(���, ��������, ����, �����̺�, ����, ��������, ���, ��������, ״̬)
		SELECT 	'��'+a.���,b.���,a.����,b.�����̺�,��������,����,a.˰�ۺϼ�,��������,'Ӧ��' 
		FROM ��������ϸ as a, ������ as b
		where a.��������=b.��� 
	-- ������ʷ
	insert into ��������ʷ select * from ������
	insert into ��������ϸ��ʷ select * from ��������ϸ
	-- ���������
	delete from ��������ϸ
	delete from ������
commit
go

CREATE PROCEDURE sf_���۵�
AS
begin transaction
	-- �޸Ŀ����Ϣ
	UPDATE ���� SET �������=�������-����ALL, �����=��浥��*(�������-����ALL)
		FROM (SELECT �ֿ�,����,'����ALL'=sum(��������) FROM ���۵���ϸ 
		GROUP BY �ֿ�,����) AS LSJ
		WHERE  ����.�ֿ�=LSj.�ֿ� AND ����.����=LSj.����
	-- ����Ӧ�տ�
	INSERT INTO Ӧ�տ�(���, ���۵���, ����, �ͻ����, ����, ���ۼ�, ���, ��������, ״̬)
		SELECT 	'��'+a.���,b.���,a.����,b.�ͻ����,��������,���ۼ�,a.˰�ۺϼ�,��������,'Ӧ��' 
		FROM ���۵���ϸ as a, ���۵� as b
		where a.���۵���=b.��� 
	-- ������ʷ
	insert into ���۵���ʷ select * from ���۵�
	insert into ���۵���ϸ��ʷ select * from ���۵���ϸ
	-- ������۵�
	delete from ���۵���ϸ
	delete from ���۵�
commit
go


--- ��ʼ������
insert into �û��嵥 values('1','ϵͳ����','sys','M','sys')
insert into �û��嵥 values('zs','�ɹ���','����','M','sys')
insert into �û��嵥 values('ls','���۲�','����','M','sys')
insert into �û��嵥 values('ww','����','����','M','sys')
go
insert into �ֿ��嵥(�ֿ��,�ֿ���) values('1','1��')
insert into �ֿ��嵥(�ֿ��,�ֿ���) values('2','2��')
insert into �ֿ��嵥(�ֿ��,�ֿ���) values('3','3��')
insert into �ֿ��嵥(�ֿ��,�ֿ���) values('4','4��')
insert into �ֿ��嵥(�ֿ��,�ֿ���) values('5','5��')
go
insert into ҵ��Ա�嵥(ҵ��Ա��,����,�Ա�) values('zs','����','M')
insert into ҵ��Ա�嵥(ҵ��Ա��,����,�Ա�)  values('ls','����','M')
insert into ҵ��Ա�嵥(ҵ��Ա��,����,�Ա�)  values('ww','����','M')
go



