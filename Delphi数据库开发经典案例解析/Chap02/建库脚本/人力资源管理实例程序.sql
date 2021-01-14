if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_���ʷ�����ʷ��_ְԱ������Ϣ��]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���ʷ�����ʷ��] DROP CONSTRAINT FK_���ʷ�����ʷ��_ְԱ������Ϣ��
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_�¹���ͳ�Ʊ�_ְԱ������Ϣ��]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[�¹���ͳ�Ʊ�] DROP CONSTRAINT FK_�¹���ͳ�Ʊ�_ְԱ������Ϣ��
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ְԱ�ͷ���_ְԱ������Ϣ��]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ְԱ�ͷ���] DROP CONSTRAINT FK_ְԱ�ͷ���_ְԱ������Ϣ��
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ְԱ������_ְԱ������Ϣ��]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ְԱ������] DROP CONSTRAINT FK_ְԱ������_ְԱ������Ϣ��
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�û��嵥]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�û��嵥]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��֯���������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��֯���������]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ְԱ������Ϣ��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ְԱ������Ϣ��]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�¹���ͳ�Ʊ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�¹���ͳ�Ʊ�]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������˰��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��������˰��]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���ʷ�����ʷ��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���ʷ�����ʷ��]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ְԱ������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ְԱ������]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ְԱ�ͷ���]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ְԱ�ͷ���]
GO

CREATE TABLE [dbo].[�û��嵥] (
	[�û����] [char] (6) NOT NULL ,
	[����] [char] (20) NOT NULL ,
	[����] [char] (10) NOT NULL ,
	[�Ա�] [char] (2) NOT NULL ,
	[����] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��֯���������] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[���] [varchar] (100) NULL ,
	[AbsIndex] [int] NULL ,
	[ItemIndex] [int] NULL ,
	[ItemLevel] [int] NULL ,
	[ParentIndex] [int] NULL ,
	[����] [char] (10) NULL ,
	[��λ���] [varchar] (20) NOT NULL PRIMARY KEY,
	[��λ����] [varchar] (100) NULL ,
	[ƴ������] [varchar] (50) NULL ,
	[��λ��ַ] [varchar] (100) NULL ,
	[��λ�绰����] [varchar] (50) NULL ,
	[��������] [varchar] (100) NULL ,
	[�ʺ�] [varchar] (50) NULL ,
	[����ȫ��] [varchar] (100) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ְԱ������Ϣ��] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL PRIMARY KEY,
	[����] [varchar] (20) NOT NULL ,
	[��������] [varchar] (10) NULL ,
	[�Ա�] [varchar] (2) NULL ,
	[��������] [int] NULL ,
	[����] [int] NULL ,
	[����] [varchar] (50) NULL ,
	[����] [varchar] (20) NULL ,
	[�Ļ��̶�] [char] (50) NULL ,
	[��ҵѧУ] [char] (100) NULL ,
	[����״��] [varchar] (50) NULL ,
	[����״��] [varchar] (10) NULL ,
	[���֤����] [varchar] (18) NULL ,
	[��ͥ�绰] [varchar] (50) NULL ,
	[�칫�绰] [varchar] (50) NULL ,
	[�ֻ�] [varchar] (50) NULL ,
	[�����ʼ���ַ] [varchar] (50) NULL ,
	[ְ���˺�] [varchar] (20) NULL ,
	[��λ���] [varchar] (20) NULL, 
	[��ע] [varchar] (100) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�¹���ͳ�Ʊ�] (
	[����] [int] NULL ,
	[ְԱ���] [varchar] (30) Not NULL PRIMARY KEY,
	[��������] [float] NULL DEFAULT (0) ,
	[��������] [decimal](26, 2) NULL DEFAULT (0) ,
	[��ͬ��] [decimal](26, 2) NULL DEFAULT (0) ,
	[������] [decimal](26, 2) NULL DEFAULT (0) ,
	[����] [decimal](26, 2) NULL DEFAULT (0) ,
	[��ʱ��] [decimal](26, 2) NULL DEFAULT (0) ,
	[ְ����] [decimal](26, 2) NULL DEFAULT (0) ,
	[���乤��] [decimal](26, 2) NULL DEFAULT (0) ,
	[���˹���] [decimal](26, 2) NULL DEFAULT (0) ,
	[����] [decimal](26, 2) NULL DEFAULT (0) ,
	[Ӧ�����ϼ�] [decimal](26, 2) NULL DEFAULT (0) ,
	[����] [decimal](26, 2) NULL DEFAULT (0) ,
	[ˮ���] [decimal](26, 2) NULL DEFAULT (0) ,
	[��ٿ۳�] [decimal](26, 2) NULL DEFAULT (0) ,
	[���ڿ۳�] [decimal](26, 2) NULL DEFAULT (0) ,
	[����] [decimal](26, 2) NULL DEFAULT (0) ,
	[ס��������] [decimal](26, 2) NULL DEFAULT (0) ,
	[ҽ�Ʊ���] [decimal](26, 2) NULL DEFAULT (0) ,
	[���ϱ���] [decimal](26, 2) NULL DEFAULT (0) ,
	[ʧҵ����] [decimal](26, 2) NULL DEFAULT (0) ,
	[��������] [decimal](26, 2) NULL DEFAULT (0) ,
	[���˱���] [decimal](26, 2) NULL DEFAULT (0) ,
	[Ӧ�۽��ϼ�] [decimal](26, 2) NULL DEFAULT (0) ,
	[���ʺϼ�] [decimal](26, 2) NULL DEFAULT (0) ,
	[��������˰] [decimal](26, 2) NULL DEFAULT (0) ,
	[ʵ�����] [decimal](26, 2) NULL DEFAULT (0) ,
	[���ŷ�] [char] (10) NULL ,
	[�·�] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��������˰��] (
	[���] [int] NOT NULL PRIMARY KEY,
	[����] [char] (2) NOT NULL ,
	[����˰����] [decimal](26, 2) NOT NULL DEFAULT (800),
	[��������] [decimal](26, 2) NOT NULL DEFAULT (0),
	[��������] [decimal](26, 2) NOT NULL DEFAULT (0),
	[��������˰��] [decimal](26, 2) NOT NULL DEFAULT (0),
	[����۳���] [decimal](26, 2) NOT NULL DEFAULT (0),
	[��ע] [varchar] (50) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[���ʷ�����ʷ��] (
	[����] [int] NULL ,
	[ְԱ���] [varchar] (30) NULL ,
	[��������] [float] NULL ,
	[��������] [decimal](26, 2) NULL ,
	[��ͬ��] [decimal](26, 2) NULL ,
	[������] [decimal](26, 2) NULL ,
	[����] [decimal](26, 2) NULL ,
	[��ʱ��] [decimal](26, 2) NULL ,
	[ְ����] [decimal](26, 2) NULL ,
	[���乤��] [decimal](26, 2) NULL ,
	[���˹���] [decimal](26, 2) NULL ,
	[����] [decimal](26, 2) NULL ,
	[Ӧ�����ϼ�] [decimal](26, 2) NULL ,
	[����] [decimal](26, 2) NULL ,
	[ˮ���] [decimal](26, 2) NULL ,
	[��ٿ۳�] [decimal](26, 2) NULL ,
	[���ڿ۳�] [decimal](26, 2) NULL ,
	[����] [decimal](26, 2) NULL ,
	[ס��������] [decimal](26, 2) NULL ,
	[ҽ�Ʊ���] [decimal](26, 2) NULL ,
	[���ϱ���] [decimal](26, 2) NULL ,
	[ʧҵ����] [decimal](26, 2) NULL ,
	[��������] [decimal](26, 2) NULL ,
	[���˱���] [decimal](26, 2) NULL ,
	[Ӧ�۽��ϼ�] [decimal](26, 2) NULL ,
	[���ʺϼ�] [decimal](26, 2) NULL ,
	[��������˰] [decimal](26, 2) NULL ,
	[ʵ�����] [decimal](26, 2) NULL ,
	[���ŷ�] [char] (10) NULL ,
	[�·�] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ְԱ������] (
	[���] [int] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[��������] [varchar] (20) NULL ,
	[�������] [float] NULL DEFAULT (0),
	[�Ƿ���빤��] [char] (10) NULL DEFAULT ('��'),
	[����ԭ��] [varchar] (50) NULL ,
	[�������] [varchar] (100) NULL ,
	[��������] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ְԱ�ͷ���] (
	[���] [int] IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[�ͷ�����] [varchar] (20) NULL ,
	[�ͷ����] [float] NULL DEFAULT (0) ,
	[�Ƿ���빤��] [char] (10) NULL DEFAULT ('��'),
	[�ͷ�ԭ��] [varchar] (50) NULL ,
	[�������] [varchar] (100) NULL ,
	[�ͷ�����] [int] NULL
) ON [PRIMARY]
GO

-- ��������ֶ�
ALTER TABLE [dbo].[�¹���ͳ�Ʊ�] ADD 
	CONSTRAINT [FK_�¹���ͳ�Ʊ�_ְԱ������Ϣ��] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[���ʷ�����ʷ��] ADD 
	CONSTRAINT [FK_���ʷ�����ʷ��_ְԱ������Ϣ��] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[ְԱ������] ADD 
	CONSTRAINT [FK_ְԱ������_ְԱ������Ϣ��] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[ְԱ�ͷ���] ADD 
	CONSTRAINT [FK_ְԱ�ͷ���_ְԱ������Ϣ��] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

-- �洢����
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sf_��������0]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sf_��������0]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sf_�γ��¹���ͳ�Ʊ�]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sf_�γ��¹���ͳ�Ʊ�]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sf_���¹���ͳ��]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sf_���¹���ͳ��]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sf_���¹��ʷ���]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sf_���¹��ʷ���]
GO
-----------------------
create procedure sf_��������0
as
begin transaction
	update �¹���ͳ�Ʊ� set ��������=0 where �������� is null
	update �¹���ͳ�Ʊ� set ְ����=0 where ְ���� is null
	update �¹���ͳ�Ʊ� set ���乤��=0 where ���乤�� is null
	update �¹���ͳ�Ʊ� set ���˹���=0 where ���˹��� is null
	update �¹���ͳ�Ʊ� set ����=0 where ���� is null
	update �¹���ͳ�Ʊ� set Ӧ�����ϼ�=0 where Ӧ�����ϼ� is null
	update �¹���ͳ�Ʊ� set ����=0 where ���� is null
	update �¹���ͳ�Ʊ� set ˮ���=0 where ˮ��� is null
	update �¹���ͳ�Ʊ� set ��ٿ۳�=0 where ��ٿ۳� is null
	update �¹���ͳ�Ʊ� set ����=0 where ���� is null
	update �¹���ͳ�Ʊ� set ���ڿ۳�=0 where ���ڿ۳� is null
	update �¹���ͳ�Ʊ� set ס��������=0 where ס�������� is null
	update �¹���ͳ�Ʊ� set ҽ�Ʊ���=0 where ҽ�Ʊ��� is null
	update �¹���ͳ�Ʊ� set ���ϱ���=0 where ���ϱ��� is null
	update �¹���ͳ�Ʊ� set Ӧ�۽��ϼ�=0 where Ӧ�۽��ϼ� is null
	update �¹���ͳ�Ʊ� set ʧҵ����=0 where ʧҵ���� is null
	update �¹���ͳ�Ʊ� set ��������˰=0 where ��������˰ is null
	update �¹���ͳ�Ʊ� set ���ʺϼ�=0 where ���ʺϼ� is null
	update �¹���ͳ�Ʊ� set ʵ�����=0 where ʵ����� is null
	update ��������˰�� set ��������˰��=0 where ��������˰�� is null
commit
GO
-------------------------------------
create procedure sf_���¹���ͳ��
as
begin transaction
	declare @month int
	select @month = ���� from �¹���ͳ�Ʊ�
	-- ���㽱��
	update �¹���ͳ�Ʊ� set ���� = 
		(select sum(�������) from ְԱ������ as i where i.�Ƿ���빤��='��' and 
		i.��������>@month*100 and i.��������<(@month+1)*100 
		group by i.ְԱ��� having i.ְԱ���=�¹���ͳ�Ʊ�.ְԱ���)
	update �¹���ͳ�Ʊ� set ����=0 where ���� is null
	-- ����ͷ�
	update �¹���ͳ�Ʊ� set ���� = 
		(select sum(�ͷ����) from ְԱ�ͷ��� as i where i.�Ƿ���빤��='��' and 
		i.�ͷ�����>@month*100 and i.�ͷ�����<(@month+1)*100 
		group by i.ְԱ��� having i.ְԱ���=�¹���ͳ�Ʊ�.ְԱ���)
	update �¹���ͳ�Ʊ� set ����=0 where ���� is null
	-- ����������0
	exec sf_��������0
	-- ����Ӧ��/Ӧ��/���ʺϼ�
	update �¹���ͳ�Ʊ�
		set Ӧ�۽��ϼ� = ����+ˮ���+��ٿ۳�+����+���ڿ۳�+ס��������+ҽ�Ʊ���
			+���ϱ���+ʧҵ����
	update �¹���ͳ�Ʊ�
		set Ӧ�����ϼ�=��������+��������+��ͬ��+������+����+��ʱ��
			+ְ����+���乤��+ ���˹���+ ����
	update �¹���ͳ�Ʊ�
		set ���ʺϼ� = Ӧ�����ϼ� - Ӧ�۽��ϼ�
	-- �����������˰
	declare @gzhj numeric(20,4), @zybh varchar(20), @grsds numeric(20,4),@sl float, 
		@gzxx numeric(20,4),@gzsx numeric(20,4)
	declare mycur cursor for select ְԱ���,���ʺϼ� from �¹���ͳ�Ʊ�
	open mycur
	fetch next from mycur into @zybh,@gzhj
	WHILE (@@FETCH_STATUS = 0 )
	BEGIN
		-- �۳�����˰����
		select @gzhj = @gzhj - (select top 1 ����˰���� from ��������˰�� order by ����)
		select @grsds = 0
		declare mycur1 cursor for select ��������,��������,case when 
			��������˰��>1 then ��������˰��/100 else ��������˰�� end 
			from ��������˰�� where �������� <= @gzhj order by ��������  
		open mycur1
		fetch next from mycur1 into @gzxx, @gzsx,@sl
		WHILE (@@FETCH_STATUS = 0 )
		BEGIN
			select @grsds = @grsds + (@gzsx-@gzxx)*@sl
			fetch next from mycur1 into @gzxx, @gzsx,@sl
		END
		close mycur1
		deallocate mycur1
		select @sl = case when ��������˰��>1 then ��������˰��/100 else 
			��������˰�� end , @gzxx = �������� from ��������˰�� 
			where ��������=@gzsx
		select @grsds = @grsds + (@gzhj-@gzxx)*@sl

		update �¹���ͳ�Ʊ� set ��������˰ = @grsds where current of mycur
		fetch next from mycur into @zybh,@gzhj
	END
	close mycur
	deallocate mycur
	-- ����ʵ������
	update �¹���ͳ�Ʊ� set ʵ����� = ���ʺϼ�-��������˰
commit
GO
-------------------------------------
create procedure sf_�γ��¹���ͳ�Ʊ� @���빤���·� int, @ͳ�ƹ����·� int
as
begin transaction
	delete from �¹���ͳ�Ʊ�    -- ɾ����������
	if exists (select * from ���ʷ�����ʷ�� where ����=@���빤���·�)
	begin
		-- ����ʷ����
		insert into �¹���ͳ�Ʊ�
			(����, ְԱ���, ��������, ��������, ��ͬ��, ������, ����, ��ʱ��, 
			ְ����, ���乤��, ���˹���, ����, Ӧ�����ϼ�, ����, ˮ���,
			��ٿ۳�, ���ڿ۳�, ����, ס��������, ҽ�Ʊ���, ���ϱ���, ʧҵ����, 
			��������, ���˱���, Ӧ�۽��ϼ�, ���ʺϼ�, ��������˰, ʵ�����,
			���ŷ�, �·�)
			select @ͳ�ƹ����·�, ְԱ���, ��������, ��������, ��ͬ��, ������, 
			����, ��ʱ��, ְ����, ���乤��, ���˹���, ����, 
			Ӧ�����ϼ�, ����, ˮ���, ��ٿ۳�, ���ڿ۳�, ����,
			ס��������, ҽ�Ʊ���, ���ϱ���, ʧҵ����, ��������, 
			���˱���, Ӧ�۽��ϼ�, ���ʺϼ�, ��������˰, ʵ�����,
			���ŷ�, �·�
			from ���ʷ�����ʷ�� as h where h.����=@���빤���·� 
	end
	-- �µ�Ա��,��ʷû�м�¼,���ɼ�¼
	insert into �¹���ͳ�Ʊ�	(ְԱ���,����) select ְԱ���,@ͳ�ƹ����·� 
		from ְԱ������Ϣ�� as h where h.ְԱ��� not in 
		(select ְԱ��� from  �¹���ͳ�Ʊ�)
	-- ����������0
	exec sf_��������0
	-- �Զ����㹤��
	exec sf_���¹���ͳ��
commit
GO
--------------------- ����ָ��ְԱ�Ĺ���
create procedure sf_���¹��ʷ��� @ְԱ��� char(10)
as
begin transaction
	update �¹���ͳ�Ʊ� set ���ŷ�='��' from �¹���ͳ�Ʊ� 
		where ְԱ���=@ְԱ���
	insert into ���ʷ�����ʷ��
		select * from �¹���ͳ�Ʊ� 
		where ְԱ���=@ְԱ���
	delete �¹���ͳ�Ʊ� where ְԱ���=@ְԱ���
commit
GO

--- ��ʼ������
insert into �û��嵥 values('1','ϵͳ����','sys','M','sys')
insert into �û��嵥 values('zs','�ɹ���','����','M','sys')
insert into �û��嵥 values('ls','���۲�','����','M','sys')
insert into �û��嵥 values('ww','����','����','M','sys')
go
