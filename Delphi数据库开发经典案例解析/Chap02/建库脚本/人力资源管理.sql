if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ͬ�䶯�Ӽ�_�Ͷ���ͬ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��ͬ�䶯�Ӽ�] DROP CONSTRAINT ��ͬ�䶯�Ӽ�_�Ͷ���ͬ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ͬ�����Ӽ�_�Ͷ���ͬ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��ͬ�����Ӽ�] DROP CONSTRAINT ��ͬ�����Ӽ�_�Ͷ���ͬ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ͬ����Ӽ�_�Ͷ���ͬ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��ͬ����Ӽ�] DROP CONSTRAINT ��ͬ����Ӽ�_�Ͷ���ͬ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ͬ��ǩ�Ӽ�_�Ͷ���ͬ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��ͬ��ǩ�Ӽ�] DROP CONSTRAINT ��ͬ��ǩ�Ӽ�_�Ͷ���ͬ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ͬ��ֹ�Ӽ�_�Ͷ���ͬ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��ͬ��ֹ�Ӽ�] DROP CONSTRAINT ��ͬ��ֹ�Ӽ�_�Ͷ���ͬ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�Ͷ������Ӽ�_�Ͷ���ͬ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[�Ͷ������Ӽ�] DROP CONSTRAINT �Ͷ������Ӽ�_�Ͷ���ͬ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�ɲ������뽻���Ӽ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[�ɲ������뽻���Ӽ�] DROP CONSTRAINT �ɲ������뽻���Ӽ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���˼����Ӽ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���˼����Ӽ�] DROP CONSTRAINT ���˼����Ӽ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������Ȼ���̨���Ӽ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[������Ȼ���̨���Ӽ�] DROP CONSTRAINT ������Ȼ���̨���Ӽ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ͬ�����Ӽ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��ͬ�����Ӽ�] DROP CONSTRAINT ��ͬ�����Ӽ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[����ְ���Ӽ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[����ְ���Ӽ�] DROP CONSTRAINT ����ְ���Ӽ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ת�ɲ��Ӽ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��ת�ɲ��Ӽ�] DROP CONSTRAINT ��ת�ɲ��Ӽ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���������Ӽ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���������Ӽ�] DROP CONSTRAINT ���������Ӽ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ᱣ���Ӽ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��ᱣ���Ӽ�] DROP CONSTRAINT ��ᱣ���Ӽ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[����������Ϣ�Ӽ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[����������Ϣ�Ӽ�] DROP CONSTRAINT ����������Ϣ�Ӽ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ʧҵ������Ϣ�Ӽ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ʧҵ������Ϣ�Ӽ�] DROP CONSTRAINT ʧҵ������Ϣ�Ӽ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������ְ���Ӽ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��������ְ���Ӽ�] DROP CONSTRAINT ��������ְ���Ӽ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���������ڳͷ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���������ڳͷ�] DROP CONSTRAINT ���������ڳͷ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���������ڽ���_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���������ڽ���] DROP CONSTRAINT ���������ڽ���_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ѧ����ѧλ�Ӽ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ѧ����ѧλ�Ӽ�] DROP CONSTRAINT ѧ����ѧλ�Ӽ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���ϱ�����Ϣ�Ӽ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[���ϱ�����Ϣ�Ӽ�] DROP CONSTRAINT ���ϱ�����Ϣ�Ӽ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ҽ�Ʊ����Ӽ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ҽ�Ʊ����Ӽ�] DROP CONSTRAINT ҽ�Ʊ����Ӽ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������ò���������_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[������ò���������] DROP CONSTRAINT ������ò���������_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ְ��������Ϣ�Ӽ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ְ��������Ϣ�Ӽ�] DROP CONSTRAINT ְ��������Ϣ�Ӽ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ְԱ��ְ�ǼǱ�_ְԱ������Ϣ��]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ְԱ��ְ�ǼǱ�] DROP CONSTRAINT FK_ְԱ��ְ�ǼǱ�_ְԱ������Ϣ��
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ְԱ��Ҫ��ϵ����Ϣ��_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ְԱ��Ҫ��ϵ����Ϣ��] DROP CONSTRAINT ְԱ��Ҫ��ϵ����Ϣ��_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��Ҫ���������Ӽ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[��Ҫ���������Ӽ�] DROP CONSTRAINT ��Ҫ���������Ӽ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ס���������Ӽ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ס���������Ӽ�] DROP CONSTRAINT ס���������Ӽ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[רҵ����ְ���Ӽ�_ְԱ���_fk]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[רҵ����ְ���Ӽ�] DROP CONSTRAINT רҵ����ְ���Ӽ�_ְԱ���_fk
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���깤��ͳ��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���깤��ͳ��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[רҵ����ְ���Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[רҵ����ְ���Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������Ȼ���̨���Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[������Ȼ���̨���Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������˰��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��������˰��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���˼����Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���˼����Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��Ҫ���������Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��Ҫ���������Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���±����ʷ��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���±����ʷ��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ס���������Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ס���������Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���ϱ�����Ϣ�Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���ϱ�����Ϣ�Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[����ְ���Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[����ְ���Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ת�ɲ��Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��ת�ɲ��Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ˢ����¼��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ˢ����¼��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�Ӱ���ʷ��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�Ӱ���ʷ��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�Ͷ������Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�Ͷ������Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ҽ�Ʊ����Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ҽ�Ʊ����Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��λ��Ա�����ṹ�Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��λ��Ա�����ṹ�Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��λ��Ա�����Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��λ��Ա�����Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��λ��ͳ��Ϣ�Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��λ��ͳ��Ϣ�Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��λ�¶Ȼ���̨���Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��λ�¶Ȼ���̨���Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��λ��������Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��λ��������Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��λ����������Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��λ����������Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��λְ��ṹ�Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��λְ��ṹ�Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ͬ�䶯�Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��ͬ�䶯�Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ͬ�����Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��ͬ�����Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ͬ��ֹ�Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��ͬ��ֹ�Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ͬ��ǩ�Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��ͬ��ǩ�Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ͬ�����Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��ͬ�����Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ͬ����Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��ͬ����Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�̶��۽���Ŀ������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�̶��۽���Ŀ������]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�������ϱ��շ��б�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�������ϱ��շ��б�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[����ҽ�Ʊ��շ��б�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[����ҽ�Ʊ��շ��б�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�������ʵ�����]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�������ʵ�����]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ʧҵ������Ϣ�Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ʧҵ������Ϣ�Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ʧҵ���շ��б�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ʧҵ���շ��б�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ѧ����ѧλ�Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ѧ����ѧλ�Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��λ����Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��λ����Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������Ϣ�Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[������Ϣ�Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[����ͳ����ʷ��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[����ͳ����ʷ��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���乤�ʵ�����]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���乤�ʵ�����]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�ɲ������뽻���Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�ɲ������뽻���Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ӦƸ��Ա��������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ӦƸ��Ա��������]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ӦƸ��Ա¼�ñ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ӦƸ��Ա¼�ñ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ӦƸ��Ա�ǼǱ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ӦƸ��Ա�ǼǱ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���¼Ӱ���б�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���¼Ӱ���б�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���½����б�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���½����б�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���¿۽���Ŀ�б�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���¿۽���Ŀ�б�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���¸����б�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���¸����б�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���¿��˹����б�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���¿��˹����б�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��Ƹ��ѡ��ʷ��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��Ƹ��ѡ��ʷ��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��Ƹ��ѡ������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��Ƹ��ѡ������]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��Ƹ������ʷ��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��Ƹ������ʷ��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��Ƹ�����]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��Ƹ�����]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��Ƹ�ƻ���]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��Ƹ�ƻ���]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������ò���������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[������ò���������]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������֤���б�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��������֤���б�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�¹���ͳ�Ʊ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�¹���ͳ�Ʊ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�¿��ڻ��ܱ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�¿��ڻ��ܱ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�������ñ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�������ñ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�����б�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�����б�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������ǼǱ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��������ǼǱ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������ѯ��ʷ��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[������ѯ��ʷ��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������ѯ�����]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[������ѯ�����]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[����ת����]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[����ת����]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��������������]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[����������Ϣ�Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[����������Ϣ�Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�û��嵥]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�û��嵥]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��ᱣ���Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��ᱣ���Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���������Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���������Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��֯���������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��֯���������]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���ò�����ͬ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���ò�����ͬ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��Ч���˱�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��Ч���˱�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ְ���ʵ�����]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ְ���ʵ�����]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ְԱ��Ҫ��ϵ����Ϣ��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ְԱ��Ҫ��ϵ����Ϣ��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ְԱ������Ϣ��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ְԱ������Ϣ��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ְԱ������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ְԱ������]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ְԱ������Ŀ��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ְԱ������Ŀ��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ְԱ�ͷ���]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ְԱ�ͷ���]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ְԱ��ְ�ǼǱ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ְԱ��ְ�ǼǱ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ְԱ������Ϣ��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ְԱ������Ϣ��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ְ��������Ϣ�Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ְ��������Ϣ�Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Ƹ�κ�ͬ�б�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Ƹ�κ�ͬ�б�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������ְ���Ӽ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��������ְ���Ӽ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���������ڽ���]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���������ڽ���]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[���������ڳͷ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[���������ڳͷ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[֤���ǼǱ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[֤���ǼǱ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[�����ʷ��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[�����ʷ��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[��������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[��������]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ת����ʽԱ���ǼǱ�]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ת����ʽԱ���ǼǱ�]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[������ʷ��]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[������ʷ��]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[����������]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[����������]
GO

CREATE TABLE [dbo].[���깤��ͳ��] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[���] [int] NULL ,
	[��һ����ƽ������] [decimal](26, 2) NULL ,
	[����ְ��ƽ������] [decimal](26, 2) NULL ,
	[��ᱣ�ջ���] [decimal](26, 2) NULL ,
	[��������] [decimal](26, 2) NULL ,
	[��������] [decimal](26, 2) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[רҵ����ְ���Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[רҵ�����ʸ�����] [varchar] (100) NULL ,
	[ȡ���ʸ�;��] [varchar] (50) NULL ,
	[ȡ���ʸ�ʱ��] [int] NULL ,
	[Ƹ��רҵ����ְ������] [varchar] (100) NULL ,
	[Ƹ����ʼʱ��] [int] NULL ,
	[Ƹ����ֹʱ��] [int] NULL ,
	[Ƹ�ε�λ] [varchar] (100) NULL ,
	[Ƹ�����] [varchar] (100) NULL ,
	[�к���ר��] [varchar] (100) NULL ,
	[�ʸ�������λ] [varchar] (100) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[������Ȼ���̨���Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[���] [int] NULL ,
	[�����ո��˽ɷѶ�] [decimal](26, 2) NULL ,
	[��������ҵ�ɷѶ�] [decimal](26, 2) NULL ,
	[��������ҵ�����] [decimal](26, 2) NULL ,
	[ҽ���ո��˽ɷѶ�] [decimal](26, 2) NULL ,
	[ҽ������ҵ�ɷѶ�] [decimal](26, 2) NULL ,
	[ҽ������ҵ�����] [decimal](26, 2) NULL ,
	[ʧҵ�ո��˽ɷѶ�] [decimal](26, 2) NULL ,
	[ʧҵ����ҵ�ɷѶ�] [decimal](26, 2) NULL ,
	[��������ҵ�ɷѶ�] [decimal](26, 2) NULL ,
	[��������ҵ�ɷѶ�] [decimal](26, 2) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��������˰��] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[����] [char] (2) NOT NULL ,
	[����˰����] [decimal](26, 2) NOT NULL ,
	[��������] [decimal](26, 2) NOT NULL ,
	[��������] [decimal](26, 2) NOT NULL ,
	[��������˰��] [decimal](26, 2) NOT NULL ,
	[����۳���] [decimal](26, 2) NOT NULL ,
	[��ע] [varchar] (50) NULL ,
	[����Ա] [varchar] (10) NULL ,
	[�޸ı��] [char] (1) NOT NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[���˼����Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[��ʼʱ��] [int] NULL ,
	[��ֹʱ��] [int] NULL ,
	[���ڵ�λ] [varchar] (100) NULL ,
	[���¹�������ְ��] [varchar] (100) NULL ,
	[֤����] [varchar] (30) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��Ҫ���������Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[����ʱ��] [int] NULL ,
	[������������] [varchar] (100) NULL ,
	[����ѧ��רҵ���] [varchar] (20) NULL ,
	[�������������] [varchar] (100) NULL ,
	[��ע] [varchar] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[���±����ʷ��] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[ְ���������] [int] NULL ,
	[����ǰ���ű��] [char] (10) NOT NULL ,
	[����ǰ��������] [varchar] (100) NULL ,
	[����ǰְ����] [char] (10) NOT NULL ,
	[����ǰְ������] [varchar] (100) NULL ,
	[�������ű��] [char] (10) NOT NULL ,
	[������������] [varchar] (100) NULL ,
	[������ְ����] [char] (10) NOT NULL ,
	[������ְ������] [varchar] (100) NULL ,
	[����ԭ��] [varchar] (50) NULL ,
	[��������] [varchar] (20) NULL ,
	[���²������] [varchar] (200) NULL ,
	[�������] [varchar] (20) NULL ,
	[�������] [char] (10) NULL ,
	[����������] [char] (10) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ס���������Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[�������㷽ʽ] [varchar] (50) NULL ,
	[�ɷѻ���] [decimal](26, 2) NULL ,
	[����֧������] [decimal](26, 2) NULL ,
	[���˽ɷѶ�] [decimal](26, 2) NULL ,
	[��ҵ֧������] [decimal](26, 2) NULL ,
	[��ҵ�ɷѶ�] [decimal](26, 2) NULL ,
	[��ʼ�ɷ�����] [int] NULL ,
	[�ۼƽɷ�ʱ��] [int] NULL ,
	[�ɷ��ж�ʱ��] [int] NULL ,
	[�ɷ��ж�ԭ��] [varchar] (100) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[���ϱ�����Ϣ�Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[��ʼ�ɷ�ʱ��] [int] NULL ,
	[��ͬ�ɷ�����] [decimal](26, 2) NULL ,
	[ְ���½ɷѻ���] [decimal](26, 2) NULL ,
	[�ɷѼ�¼] [varchar] (1) NULL ,
	[����] [varchar] (2) NULL ,
	[����ԭ��] [varchar] (50) NULL ,
	[��Ա���] [varchar] (50) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[����ְ���Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[��ְ���] [varchar] (20) NULL ,
	[����ְ������] [varchar] (100) NULL ,
	[��ְʱ��] [int] NULL ,
	[��ְ��λ] [varchar] (100) NULL ,
	[��ְ��ʽ] [varchar] (20) NULL ,
	[��ְԭ��] [varchar] (50) NULL ,
	[��ְ�ĺ�] [varchar] (30) NULL ,
	[��ְ��׼��λ] [varchar] (100) NULL ,
	[��ְ���ܻ���¹���] [varchar] (100) NULL ,
	[��ְ��Чʱ��] [int] NULL ,
	[��ȥ��ְ��ʱ��] [int] NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL ,
	[��ע] [char] (100) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��ת�ɲ��Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[�����] [varchar] (100) NULL ,
	[����ʱ��] [int] NULL ,
	[��׼��תʱ��] [int] NULL ,
	[��׼��ת��λ] [varchar] (100) NULL ,
	[��תǰְ��] [varchar] (100) NULL ,
	[תҵǰ�ھ��Ӿ���] [varchar] (50) NULL ,
	[��תǰ����] [varchar] (50) NULL ,
	[תҵǰרҵ�����ȼ�] [varchar] (50) NULL ,
	[��תǰ���ʵȼ�] [varchar] (50) NULL ,
	[Ԥ���۵Ǽ����] [varchar] (100) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ˢ����¼��] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[����] [float] NULL ,
	[ְԱ���] [char] (10) NULL ,
	[ˢ��ʱ��] [float] NULL ,
	[�������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�Ӱ���ʷ��] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [char] (10) NOT NULL ,
	[�Ӱ�����] [varchar] (20) NULL ,
	[�Ӱ�����] [int] NOT NULL ,
	[�Ӱ࿪ʼʱ��] [int] NOT NULL ,
	[�Ӱ����ʱ��] [int] NOT NULL ,
	[�Ӱ�ʱ��] [varchar] (20) NULL ,
	[�Ӱ�ԭ��] [varchar] (200) NULL ,
	[�������] [varchar] (20) NULL ,
	[�������] [char] (10) NULL ,
	[����������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�Ͷ������Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NULL ,
	[��ͬ���] [varchar] (60) NULL ,
	[�Ͷ����������] [varchar] (20) NULL ,
	[�Ͷ�����ԭ��] [varchar] (50) NULL ,
	[�Ͷ������������] [varchar] (100) NULL ,
	[�Ͷ����鿪ʼʱ��] [int] NULL ,
	[�Ͷ��������ʱ��] [int] NULL ,
	[�Ͷ����鴦����] [varchar] (100) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ҽ�Ʊ����Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[��������] [varchar] (100) NULL ,
	[�ɷ���ʼʱ��] [int] NULL ,
	[�ɷ��ж�ʱ��] [int] NULL ,
	[�жϿ�ʼʱ��] [int] NULL ,
	[�ɷ���ֹʱ��] [int] NULL ,
	[����ҽ�ƻ���1] [varchar] (100) NULL ,
	[����ҽ�ƻ���2] [varchar] (100) NULL ,
	[����ҽ�ƻ���3] [varchar] (100) NULL ,
	[����ҽ�ƻ���4] [varchar] (100) NULL ,
	[����ҽ�ƻ���5] [varchar] (100) NULL ,
	[��ذ�������] [int] NULL ,
	[ȫ��] [varchar] (100) NULL ,
	[��ַ] [varchar] (100) NULL ,
	[��������] [varchar] (6) NULL ,
	[��ϵ�绰] [varchar] (20) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��λ��Ա�����ṹ�Ӽ�] (
	[��λ���] [varchar] (20) NULL ,
	[��ĩְ������] [int] NULL ,
	[ְ��ƽ������] [int] NULL ,
	[�̶�ְ������] [int] NULL ,
	[��ͬ��ְ������] [int] NULL ,
	[��ʱְ������] [int] NULL ,
	[������ҵ����] [int] NULL ,
	[�ɲ�����] [int] NULL ,
	[��������] [int] NULL ,
	[����������Ա��] [int] NULL ,
	[רҵ������Ա��] [int] NULL ,
	[Ƹ���Ƹɲ���] [int] NULL ,
	[���ڲ�����Ա] [int] NULL ,
	[������ѧϰһ��������Ա] [int] NULL ,
	[��������Ա] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��λ��Ա�����Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[��λ���] [varchar] (20) NOT NULL ,
	[��������] [int] NULL ,
	[ʵ����] [int] NULL ,
	[ȱ������] [int] NULL ,
	[��������] [int] NULL ,
	[����������] [int] NULL ,
	[��ҵ������] [int] NULL ,
	[��ҵ������] [int] NULL ,
	[���ű�����] [int] NULL ,
	[��λ�쵼ְ��] [int] NULL ,
	[��λ���쵼ְ��] [int] NULL ,
	[��������쵼ְ��] [int] NULL ,
	[����������쵼ְ��] [int] NULL ,
	[ҵ����Ա������] [int] NULL ,
	[������Ա������] [int] NULL ,
	[ʹ��ȫ�������] [int] NULL ,
	[ʹ�ò�������] [int] NULL ,
	[ʹ���Գ��ʽ�����] [int] NULL ,
	[����Ա] [varchar] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��λ��ͳ��Ϣ�Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[��λ���] [varchar] (20) NOT NULL ,
	[�μӱ�������] [varchar] (100) NULL ,
	[�α�ʱ��] [int] NULL ,
	[�ɷ����] [int] NULL ,
	[�������㷽ʽ] [varchar] (50) NULL ,
	[�����ٷֱ�] [decimal](26, 2) NULL ,
	[�ɷѻ���] [decimal](26, 2) NULL ,
	[�ɷѱ���] [decimal](26, 2) NULL ,
	[��ҵ֧������] [decimal](26, 2) NULL ,
	[����֧������] [decimal](26, 2) NULL ,
	[��ְ����] [int] NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��λ�¶Ȼ���̨���Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[��λ���] [varchar] (20) NOT NULL ,
	[���·�] [int] NULL ,
	[��ҵ�ɷѻ���] [decimal](26, 2) NULL ,
	[��������ҵ�ɷѶ�] [decimal](26, 2) NULL ,
	[��������ҵ�����] [decimal](26, 2) NULL ,
	[ҽ������ҵ�ɷѶ�] [decimal](26, 2) NULL ,
	[ҽ������ҵ�����] [decimal](26, 2) NULL ,
	[ʧҵ����ҵ�ɷѶ�] [decimal](26, 2) NULL ,
	[��������ҵ�ɷѶ�] [decimal](26, 2) NULL ,
	[��������ҵ�ɷѶ�] [decimal](26, 2) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��λ��������Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[��λ���] [varchar] (20) NOT NULL ,
	[��׼����ʱ��] [int] NULL ,
	[��׼�����ĺ�] [varchar] (24) NULL ,
	[��׼����ʱ��] [int] NULL ,
	[��׼�����ĺ�] [varchar] (24) NULL ,
	[��׼���Ƶ�λ] [varchar] (70) NULL ,
	[���������] [int] NULL ,
	[�����������] [varchar] (40) NULL ,
	[�����������] [varchar] (2) NULL ,
	[����ʱ��] [int] NULL ,
	[��׼�����ĺ�] [varchar] (24) NULL ,
	[������׼��λ] [varchar] (70) NULL ,
	[������ʽ] [varchar] (1) NULL ,
	[����Ա] [varchar] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��λ����������Ӽ�] (
	[��λ���] [varchar] (20) NULL ,
	[��������] [int] NULL ,
	[��������] [int] NULL ,
	[��ȡ��������ѵ���ְ��Ա] [int] NULL ,
	[���ݷ�����ͱ�׼������] [int] NULL ,
	[���ݷ�����ͱ�׼������] [int] NULL ,
	[���������������] [int] NULL ,
	[��ע] [varchar] (100) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��λְ��ṹ�Ӽ�] (
	[��λ���] [varchar] (20) NULL ,
	[ʡ�������൱������] [int] NULL ,
	[��ʡ�������൱������] [int] NULL ,
	[˾�ּ����൱������] [int] NULL ,
	[��˾�ּ����൱������] [int] NULL ,
	[�������൱������] [int] NULL ,
	[���������൱������] [int] NULL ,
	[�Ƽ����൱������] [int] NULL ,
	[���Ƽ����൱������] [int] NULL ,
	[��Ա����Ա����������] [int] NULL ,
	[�߼�רҵ����ְ������] [int] NULL ,
	[�м�רҵ����ְ������] [int] NULL ,
	[����רҵ����ְ������] [int] NULL ,
	[δ��Ƹרҵ����ְ����Ա��] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��ͬ�䶯�Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NULL ,
	[��ͬ���] [varchar] (60) NULL ,
	[���ò�����] [decimal](26, 2) NULL ,
	[����ΥԼ��] [decimal](26, 2) NULL ,
	[��ͬ�䶯�����] [varchar] (100) NULL ,
	[��ͬ�䶯����] [int] NULL ,
	[��ͬ�䶯���] [varchar] (100) NULL ,
	[��ͬ�䶯��Ч����] [int] NULL ,
	[��ͬ�䶯ԭ��] [varchar] (100) NULL ,
	[��ͬ�䶯����] [varchar] (20) NULL ,
	[��ͬ�䶯����] [varchar] (200) NULL ,
	[�º�ͬ���] [varchar] (60) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��ͬ�����Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[��ͬ����] [varchar] (100) NULL ,
	[��ͬ���] [varchar] (60) NOT NULL ,
	[��ͬ������] [varchar] (20) NULL ,
	[��ͬ����] [int] NULL ,
	[�Ͷ���ͬ��ʼ����] [int] NULL ,
	[�Ͷ���ͬ��ֹ����] [int] NULL ,
	[�Ͷ���ͬǩ������] [int] NULL ,
	[�Ͷ���ͬЭ������] [varchar] (200) NULL ,
	[�Ͷ���ͬ��н�ʴ���] [decimal](26, 2) NULL ,
	[����������] [int] NULL ,
	[��������ʼ����] [int] NULL ,
	[��������ֹ����] [int] NULL ,
	[������н�ʴ���] [decimal](26, 2) NULL ,
	[���ú�ͬǩ������] [int] NULL ,
	[ѧͽ������] [int] NULL ,
	[ѧͽ����ʼ����] [int] NULL ,
	[ѧͽ����ֹ����] [int] NULL ,
	[ѧͽ��н�ʴ���] [decimal](26, 2) NULL ,
	[ѧͽ�ں�ͬǩ������] [int] NULL ,
	[��ϰ������] [int] NULL ,
	[��ϰ����ʼ����] [int] NULL ,
	[��ϰ����ֹ����] [int] NULL ,
	[��ϰ��н�ʴ���] [int] NULL ,
	[��ϰ�ں�ͬǩ������] [int] NULL ,
	[���ܺ�ͬǩ������] [int] NULL ,
	[���ܺ�ͬ���] [varchar] (60) NULL ,
	[���ܺ�ͬ�ر�Լ��] [varchar] (200) NULL ,
	[��ѵЭ��ǩ������] [int] NULL ,
	[��ѵЭ��Э������] [varchar] (200) NULL ,
	[��ѵ����] [varchar] (200) NULL ,
	[��ѵ����] [varchar] (20) NULL ,
	[���쵥λ] [varchar] (200) NULL ,
	[��������] [int] NULL ,
	[��ҵ����] [int] NULL ,
	[��ʱ] [int] NULL ,
	[��ѵ����] [decimal](26, 2) NULL ,
	[������] [int] NULL ,
	[�����⳥��ʽ] [varchar] (50) NULL ,
	[��λЭ��ǩ������] [int] NULL ,
	[��λЭ����] [varchar] (60) NULL ,
	[��λЭ���ر�Լ��] [varchar] (200) NULL ,
	[��ͬ��������] [int] NULL ,
	[������λ] [varchar] (100) NULL ,
	[��ͬ����] [varchar] (20) NULL ,
	[��ͬ�䶯����] [int] NULL ,
	[��ͬ״̬] [varchar] (20) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��ͬ��ֹ�Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NULL ,
	[��ͬ���] [varchar] (60) NULL ,
	[��ͬ��ֹʱ��] [int] NULL ,
	[��������ʱ��] [int] NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��ͬ��ǩ�Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NULL ,
	[��ͬ���] [varchar] (60) NULL ,
	[��ǩ��ͬ����] [varchar] (30) NULL ,
	[��ͬ��ǩ����] [int] NULL ,
	[��ͬ��ǩ����] [int] NULL ,
	[��ǩ��ͬ��ʼ����] [int] NULL ,
	[��ǩ��ͬ��ֹ����] [int] NULL ,
	[�º�ͬ���] [varchar] (60) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��ͬ�����Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NULL ,
	[��ͬ���] [varchar] (60) NULL ,
	[��ͬ���������] [varchar] (10) NULL ,
	[��ͬ��������] [int] NULL ,
	[��ͬ������Ч����] [int] NULL ,
	[��ͬ����ԭ��] [varchar] (100) NULL ,
	[��ͬ��������] [varchar] (200) NULL ,
	[�º�ͬ���] [varchar] (60) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��ͬ����Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NULL ,
	[��ͬ���] [varchar] (60) NULL ,
	[��ͬ��������] [varchar] (100) NULL ,
	[��ͬ���ʱ��] [int] NULL ,
	[��ͬ���ԭ��] [varchar] (100) NULL ,
	[��ͬ�����Ч����] [int] NULL ,
	[������] [varchar] (100) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�̶��۽���Ŀ������] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[�̶��۽���Ŀ����] [varchar] (50) NOT NULL ,
	[��������] [float] NOT NULL ,
	[����ԭ��] [varchar] (100) NULL ,
	[��������] [int] NULL ,
	[�������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�������ϱ��շ��б�] (
	[ְ�����] [char] (10) NOT NULL ,
	[�������ϱ��շ�] [float] NULL ,
	[��ҵ֧������] [float] NULL ,
	[����֧������] [float] NULL ,
	[�ϼƱ���] [float] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[����ҽ�Ʊ��շ��б�] (
	[ְ�����] [char] (10) NOT NULL ,
	[����ҽ�Ʊ��շ�] [float] NULL ,
	[��ҵ֧������] [float] NULL ,
	[����֧������] [float] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�������ʵ�����] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[��������] [float] NOT NULL ,
	[����ԭ��] [varchar] (100) NULL ,
	[��������] [int] NULL ,
	[�������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ʧҵ������Ϣ�Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[���˽ɷ���ʼʱ��] [int] NULL ,
	[��Ա���] [varchar] (50) NULL ,
	[�ۼƽɷ�ʱ��] [decimal](26, 2) NULL ,
	[�ɷ��ж�ʱ��] [int] NULL ,
	[�ɷ��ж�ԭ��] [varchar] (100) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ʧҵ���շ��б�] (
	[ְ�����] [char] (10) NOT NULL ,
	[ʧҵ���շ�] [float] NULL ,
	[��ҵ֧������] [float] NULL ,
	[����֧������] [float] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ѧ����ѧλ�Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[ѧ��] [varchar] (20) NULL ,
	[��ѧרҵ] [varchar] (40) NULL ,
	[��ѧʱ��] [int] NULL ,
	[ѧϰ��ʽ] [varchar] (20) NULL ,
	[ѧ��] [decimal](26, 2) NULL ,
	[����ҵʱ��] [int] NULL ,
	[����ҵѧУ����λ] [varchar] (40) NULL ,
	[ѧλ] [varchar] (20) NULL ,
	[ѧλ����ʱ��] [int] NULL ,
	[ѧλ������ҵ���] [varchar] (40) NULL ,
	[ѧλ���赥λ] [varchar] (70) NULL ,
	[��ע] [varchar] (100) NULL ,
	[�������] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��λ����Ӽ�] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[ְ���������] [int] NULL ,
	[����ǰ���ű��] [char] (20) NOT NULL ,
	[����ǰ��������] [varchar] (100) NULL ,
	[����ǰְ������] [varchar] (100) NULL ,
	[�������ű��] [char] (20) NOT NULL ,
	[������������] [varchar] (100) NULL ,
	[������ְ������] [varchar] (100) NULL ,
	[����ԭ��] [varchar] (50) NULL ,
	[��������] [varchar] (20) NULL ,
	[���²������] [varchar] (200) NULL ,
	[�������] [varchar] (20) NULL ,
	[�������] [char] (10) NULL ,
	[����������] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[������Ϣ�Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[����֤��] [varchar] (30) NULL ,
	[��֤����] [int] NULL ,
	[��֤��λ] [varchar] (100) NULL ,
	[�¹�ʱ��] [int] NULL ,
	[�¹����] [varchar] (50) NULL ,
	[�Ͷ��������] [varchar] (30) NULL ,
	[�����϶�������] [varchar] (30) NULL ,
	[���˴����������] [varchar] (30) NULL ,
	[�˺���λ] [varchar] (100) NULL ,
	[�˺��̶�] [varchar] (100) NULL ,
	[�˲еȼ�] [varchar] (100) NULL ,
	[�Ӵ��к�����ʱ��] [int] NULL ,
	[ְҵ������] [varchar] (100) NULL ,
	[���������ȼ�] [varchar] (100) NULL ,
	[����ԭ�򾭹�] [varchar] (100) NULL ,
	[��Ա���] [varchar] (50) NULL ,
	[����ʱ��] [int] NULL ,
	[����ʱ��] [int] NULL ,
	[����ԭ��] [varchar] (50) NULL ,
	[�Ƿ���ְ��] [varchar] (2) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[����ͳ����ʷ��] (
	[���] [int] NULL ,
	[����] [int] NULL ,
	[ְԱ���] [varchar] (30) NULL ,
	[��������] [float] NULL ,
	[��������] [decimal](26, 2) NULL ,
	[��ͬ��] [decimal](26, 2) NULL ,
	[������] [decimal](26, 2) NULL ,
	[ϴ���] [decimal](26, 2) NULL ,
	[���ͷ�] [decimal](26, 2) NULL ,
	[ˮ��ú��] [decimal](26, 2) NULL ,
	[�鱨��] [decimal](26, 2) NULL ,
	[����] [decimal](26, 2) NULL ,
	[��Ϣ] [decimal](26, 2) NULL ,
	[��ʱ��] [decimal](26, 2) NULL ,
	[ְ����] [decimal](26, 2) NULL ,
	[���乤��] [decimal](26, 2) NULL ,
	[���˹���] [decimal](26, 2) NULL ,
	[�Ӱ��] [decimal](26, 2) NULL ,
	[��۽���] [decimal](26, 2) NULL ,
	[��ͨ����] [decimal](26, 2) NULL ,
	[��ʳ����] [decimal](26, 2) NULL ,
	[ҽ�Ʋ���] [decimal](26, 2) NULL ,
	[���½���] [decimal](26, 2) NULL ,
	[����] [decimal](26, 2) NULL ,
	[����] [decimal](26, 2) NULL ,
	[��ְ��] [decimal](26, 2) NULL ,
	[���Ӳ�] [decimal](26, 2) NULL ,
	[��] [decimal](26, 2) NULL ,
	[�绰��] [decimal](26, 2) NULL ,
	[Ӧ�����ϼ�] [decimal](26, 2) NULL ,
	[����] [decimal](26, 2) NULL ,
	[ˮ���] [decimal](26, 2) NULL ,
	[��ٿ۳�] [decimal](26, 2) NULL ,
	[���ڿ۳�] [decimal](26, 2) NULL ,
	[����] [decimal](26, 2) NULL ,
	[�����] [decimal](26, 2) NULL ,
	[ס��������] [decimal](26, 2) NULL ,
	[ҽ�Ʊ���] [decimal](26, 2) NULL ,
	[���ϱ���] [decimal](26, 2) NULL ,
	[ʧҵ����] [decimal](26, 2) NULL ,
	[��������] [decimal](26, 2) NULL ,
	[���˱���] [decimal](26, 2) NULL ,
	[��Ϣ˰] [decimal](26, 2) NULL ,
	[��ʱ��] [decimal](26, 2) NULL ,
	[Ӧ�۽��ϼ�] [decimal](26, 2) NULL ,
	[���ʺϼ�] [decimal](26, 2) NULL ,
	[��������˰] [decimal](26, 2) NULL ,
	[ʵ�����] [decimal](26, 2) NULL ,
	[ְ���˺�] [varchar] (20) NULL ,
	[���ŷ�] [char] (10) NULL ,
	[�������] [char] (10) NULL ,
	[��������] [varchar] (50) NULL ,
	[�·�] [int] NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[���乤�ʵ�����] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[��������] [float] NOT NULL ,
	[����ԭ��] [varchar] (100) NULL ,
	[��������] [int] NULL ,
	[�������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�ɲ������뽻���Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[�����뽻�����] [varchar] (40) NULL ,
	[�����������] [varchar] (50) NULL ,
	[����������ʼʱ��] [int] NULL ,
	[������������ʱ��] [int] NULL ,
	[����ְ��] [varchar] (100) NULL ,
	[��ְ���] [varchar] (100) NULL ,
	[��ע] [varchar] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ӦƸ��Ա��������] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[���] [varchar] (100) NULL ,
	[AbsIndex] [int] NULL ,
	[ItemIndex] [int] NULL ,
	[ItemLevel] [int] NULL ,
	[ParentIndex] [int] NULL ,
	[����] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ӦƸ��Ա¼�ñ�] (
	[ӦƸ�˱��] [varchar] (10) NOT NULL ,
	[���Է���] [varchar] (50) NULL ,
	[���Գɼ�] [varchar] (50) NULL ,
	[�ۺϿ���] [varchar] (50) NULL ,
	[ְԱ���] [varchar] (30) NULL ,
	[��ʼƸ������] [int] NULL ,
	[������] [int] NULL ,
	[�Ƿ�ת��ְԱ��] [char] (10) NULL ,
	[�������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ӦƸ��Ա�ǼǱ�] (
	[ӦƸ�˱��] [varchar] (10) NOT NULL ,
	[ӦƸ������] [char] (10) NOT NULL ,
	[��������] [char] (10) NULL ,
	[ӦƸְ����] [char] (100) NOT NULL ,
	[ӦƸ���ű��] [char] (10) NOT NULL ,
	[��������] [int] NULL ,
	[������] [varchar] (100) NULL ,
	[�Ա�] [char] (10) NULL ,
	[����״��] [char] (10) NULL ,
	[�������] [varchar] (50) NULL ,
	[������ò] [char] (20) NULL ,
	[��ͥ�绰] [varchar] (30) NULL ,
	[�ֻ�] [varchar] (30) NULL ,
	[Ѱ����] [varchar] (30) NULL ,
	[�������ڵ�] [varchar] (50) NULL ,
	[��ͥ��ַ] [varchar] (100) NULL ,
	[�����ʼ���ַ] [varchar] (50) NULL ,
	[�ʱ�] [varchar] (20) NULL ,
	[���֤����] [varchar] (20) NULL ,
	[�Ļ��̶�] [char] (10) NULL ,
	[����ˮƽ] [varchar] (50) NULL ,
	[�����ļ�] [varchar] (50) NULL ,
	[��Ƭ�ļ�] [varchar] (50) NULL ,
	[�����س�] [varchar] (200) NULL ,
	[����Ƹְ��ع���ְ������] [varchar] (200) NULL ,
	[ϣ������] [varchar] (50) NULL ,
	[��ע] [varchar] (100) NULL ,
	[�������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[���¼Ӱ���б�] (
	[ְԱ���] [varchar] (30) NOT NULL ,
	[����] [int] NULL ,
	[�Ӱ�ʱ��] [float] NULL ,
	[�Ӱ�ѽ��] [float] NULL ,
	[�������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[���½����б�] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[����] [int] NULL ,
	[��������] [varchar] (20) NULL ,
	[������] [float] NULL ,
	[�������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[���¿۽���Ŀ�б�] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[����] [int] NULL ,
	[�۽���Ŀ����] [varchar] (20) NULL ,
	[�۽���Ŀ���] [float] NULL ,
	[�������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[���¸����б�] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[����] [int] NULL ,
	[��������] [varchar] (20) NULL ,
	[�������] [float] NULL ,
	[�������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[���¿��˹����б�] (
	[ְԱ���] [varchar] (30) NOT NULL ,
	[����] [int] NULL ,
	[���˷���] [int] NULL ,
	[���˹���] [float] NULL ,
	[�������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��Ƹ��ѡ��ʷ��] (
	[ӦƸ�˱��] [varchar] (10) NOT NULL ,
	[��ȥ����] [varchar] (254) NULL ,
	[���������] [varchar] (50) NULL ,
	[ҵ������] [varchar] (50) NULL ,
	[����ˮƽ] [varchar] (50) NULL ,
	[�ۺ�����] [varchar] (50) NULL ,
	[��ѡ״̬] [varchar] (20) NULL ,
	[�������] [char] (10) NULL ,
	[����������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��Ƹ��ѡ������] (
	[ӦƸ�˱��] [varchar] (10) NOT NULL ,
	[��ȥ����] [varchar] (254) NULL ,
	[���������] [varchar] (50) NULL ,
	[ҵ������] [varchar] (50) NULL ,
	[����ˮƽ] [varchar] (50) NULL ,
	[�ۺ�����] [varchar] (50) NULL ,
	[��ѡ״̬] [varchar] (20) NULL ,
	[�������] [char] (10) NULL ,
	[����������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��Ƹ������ʷ��] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[�����˱��] [char] (10) NOT NULL ,
	[���ű��] [char] (10) NOT NULL ,
	[����Ƹ����] [int] NULL ,
	[��������] [varchar] (100) NULL ,
	[��Ƹ����] [int] NULL ,
	[��Ƹ��Ա��������] [varchar] (100) NULL ,
	[��Ƹ����] [varchar] (100) NULL ,
	[��Ƹ��ʽ] [varchar] (20) NULL ,
	[�������] [varchar] (20) NULL ,
	[�������] [char] (10) NULL ,
	[����������] [char] (10) NULL ,
	[���뵥��] [char] (14) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��Ƹ�����] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[�����˱��] [char] (10) NOT NULL ,
	[���ű��] [char] (10) NOT NULL ,
	[����Ƹ����] [int] NULL ,
	[��������] [varchar] (100) NULL ,
	[��Ƹ����] [int] NULL ,
	[��Ƹ��Ա��������] [varchar] (100) NULL ,
	[��Ƹ����] [varchar] (100) NULL ,
	[��Ƹ��ʽ] [varchar] (20) NULL ,
	[�������] [varchar] (20) NULL ,
	[�������] [char] (10) NULL ,
	[����������] [char] (10) NULL ,
	[���뵥��] [char] (14) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��Ƹ�ƻ���] (
	[��Ƹ�ƻ����] [int] IDENTITY (1, 1) NOT NULL ,
	[�����˱��] [char] (10) NOT NULL ,
	[���ű��] [char] (10) NOT NULL ,
	[����Ƹ����] [int] NULL ,
	[��������] [varchar] (100) NULL ,
	[��Ƹ����] [int] NULL ,
	[��Ƹ��Ա��������] [varchar] (100) NULL ,
	[��Ƹ����] [varchar] (100) NULL ,
	[��Ƹ��ʽ] [varchar] (20) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[������ò���������] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[������ò] [varchar] (20) NULL ,
	[�μӵ���ʱ��] [int] NULL ,
	[�μӵ���ʱ���ڵ�λ] [varchar] (100) NULL ,
	[������] [varchar] (30) NULL ,
	[ת��ʱ��] [int] NULL ,
	[�쳣���] [char] (40) NULL ,
	[�쳣ԭ��] [char] (100) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��������֤���б�] (
	[ְԱ���] [varchar] (30) NOT NULL ,
	[ѧ��֤����] [varchar] (20) NULL ,
	[ѧ��֤�鸴ӡ�����λ��] [varchar] (100) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�¹���ͳ�Ʊ�] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[����] [int] NULL ,
	[ְԱ���] [varchar] (30) NULL ,
	[��������] [float] NULL ,
	[��������] [decimal](26, 2) NULL ,
	[��ͬ��] [decimal](26, 2) NULL ,
	[������] [decimal](26, 2) NULL ,
	[ϴ���] [decimal](26, 2) NULL ,
	[���ͷ�] [decimal](26, 2) NULL ,
	[ˮ��ú��] [decimal](26, 2) NULL ,
	[�鱨��] [decimal](26, 2) NULL ,
	[����] [decimal](26, 2) NULL ,
	[��Ϣ] [decimal](26, 2) NULL ,
	[��ʱ��] [decimal](26, 2) NULL ,
	[ְ����] [decimal](26, 2) NULL ,
	[���乤��] [decimal](26, 2) NULL ,
	[���˹���] [decimal](26, 2) NULL ,
	[�Ӱ��] [decimal](26, 2) NULL ,
	[��۽���] [decimal](26, 2) NULL ,
	[��ͨ����] [decimal](26, 2) NULL ,
	[��ʳ����] [decimal](26, 2) NULL ,
	[ҽ�Ʋ���] [decimal](26, 2) NULL ,
	[���½���] [decimal](26, 2) NULL ,
	[����] [decimal](26, 2) NULL ,
	[����] [decimal](26, 2) NULL ,
	[��ְ��] [decimal](26, 2) NULL ,
	[���Ӳ�] [decimal](26, 2) NULL ,
	[��] [decimal](26, 2) NULL ,
	[�绰��] [decimal](26, 2) NULL ,
	[Ӧ�����ϼ�] [decimal](26, 2) NULL ,
	[����] [decimal](26, 2) NULL ,
	[ˮ���] [decimal](26, 2) NULL ,
	[��ٿ۳�] [decimal](26, 2) NULL ,
	[���ڿ۳�] [decimal](26, 2) NULL ,
	[����] [decimal](26, 2) NULL ,
	[�����] [decimal](26, 2) NULL ,
	[ס��������] [decimal](26, 2) NULL ,
	[ҽ�Ʊ���] [decimal](26, 2) NULL ,
	[���ϱ���] [decimal](26, 2) NULL ,
	[ʧҵ����] [decimal](26, 2) NULL ,
	[��������] [decimal](26, 2) NULL ,
	[���˱���] [decimal](26, 2) NULL ,
	[��Ϣ˰] [decimal](26, 2) NULL ,
	[��ʱ��] [decimal](26, 2) NULL ,
	[Ӧ�۽��ϼ�] [decimal](26, 2) NULL ,
	[���ʺϼ�] [decimal](26, 2) NULL ,
	[��������˰] [decimal](26, 2) NULL ,
	[ʵ�����] [decimal](26, 2) NULL ,
	[ְ���˺�] [varchar] (20) NULL ,
	[���ŷ�] [char] (10) NULL ,
	[�������] [char] (10) NULL ,
	[��������] [varchar] (50) NULL ,
	[�·�] [int] NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�¿��ڻ��ܱ�] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[����] [int] NULL ,
	[ְԱ���] [char] (10) NOT NULL ,
	[�ٵ�����] [int] NULL ,
	[���˴���] [int] NULL ,
	[�󹤴���] [int] NULL ,
	[��ٴ���] [int] NULL ,
	[�Ӱ�ʱ��] [float] NULL ,
	[�������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�������ñ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[�������] [char] (10) NOT NULL ,
	[��������] [char] (10) NOT NULL ,
	[��������] [int] NULL ,
	[ԴĿ�ĵ�λ] [varchar] (100) NULL ,
	[��������] [varchar] (200) NULL ,
	[������] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�����б�] (
	[�������] [char] (10) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[��������] [varchar] (50) NULL ,
	[����״̬] [varchar] (20) NULL ,
	[�������λ��] [varchar] (50) NOT NULL ,
	[���������Ŀ] [varchar] (50) NOT NULL ,
	[������������] [int] NULL ,
	[����ת������] [int] NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��������ǼǱ�] (
	[�������] [char] (10) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[��������] [varchar] (50) NULL ,
	[�������λ��] [varchar] (100) NULL ,
	[���������Ŀ] [varchar] (100) NULL ,
	[������������] [int] NULL ,
	[�������] [char] (10) NOT NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[������ѯ��ʷ��] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[��ѯ������] [char] (10) NOT NULL ,
	[��ѯ�����֤��] [varchar] (20) NOT NULL ,
	[�������] [char] (10) NOT NULL ,
	[��ѯ����] [varchar] (200) NULL ,
	[��ѯ����] [int] NULL ,
	[�������] [char] (10) NULL ,
	[�������] [varchar] (20) NULL ,
	[����������] [char] (10) NULL ,
	[��ע] [varchar] (200) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[������ѯ�����] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[��ѯ������] [char] (10) NOT NULL ,
	[��ѯ�����֤��] [varchar] (20) NOT NULL ,
	[�������] [char] (10) NOT NULL ,
	[��ѯ����] [varchar] (200) NULL ,
	[��ѯ����] [int] NULL ,
	[�������] [varchar] (20) NULL ,
	[�������] [char] (10) NULL ,
	[����������] [char] (10) NULL ,
	[��ע] [varchar] (200) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[����ת����] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[�������] [char] (10) NOT NULL ,
	[ת������] [int] NULL ,
	[ת��Ŀ�ĵ�] [varchar] (200) NULL ,
	[ת������] [varchar] (200) NULL ,
	[�������] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��������������] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[������������] [varchar] (50) NOT NULL ,
	[��������] [float] NOT NULL ,
	[����ԭ��] [varchar] (100) NULL ,
	[��������] [int] NULL ,
	[�������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[����������Ϣ�Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[����ʱ��] [int] NULL ,
	[�������ս�֧��] [decimal](26, 2) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�û��嵥] (
	[�û����] [char] (6) NOT NULL ,
	[����] [char] (20) NOT NULL ,
	[����] [char] (10) NOT NULL ,
	[�Ա�] [char] (2) NOT NULL ,
	[����] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��ᱣ���Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[�ɷ�����] [int] NULL ,
	[�ɷѻ���] [decimal](26, 2) NOT NULL ,
	[�����ո��˽ɷѱ���] [decimal](26, 2) NOT NULL ,
	[�����ո��˽ɷѶ�] [decimal](26, 2) NOT NULL ,
	[ҽ���ո��˽ɷѱ���] [decimal](26, 2) NOT NULL ,
	[ҽ���ո��˽ɷѶ�] [decimal](26, 2) NOT NULL ,
	[����ҽ���ո��˽ɷѶ�] [decimal](26, 2) NOT NULL ,
	[ʧҵ�ո��˽ɷѱ���] [decimal](26, 2) NOT NULL ,
	[ʧҵ�ո��˽ɷѶ�] [decimal](26, 2) NOT NULL ,
	[�����ո��˽ɷѱ���] [decimal](26, 2) NOT NULL ,
	[�����ո��˽ɷѶ�] [decimal](26, 2) NOT NULL ,
	[�����ո��˽ɷѱ���] [decimal](26, 2) NOT NULL ,
	[�����ո��˽ɷѶ�] [decimal](26, 2) NOT NULL ,
	[��������ҵ�ɷѱ���] [decimal](26, 2) NOT NULL ,
	[��������ҵ�ɷѶ�] [decimal](26, 2) NOT NULL ,
	[��������ҵ�������] [decimal](26, 2) NOT NULL ,
	[��������ҵ�����] [decimal](26, 2) NOT NULL ,
	[ҽ������ҵ�ɷѱ���] [decimal](26, 2) NOT NULL ,
	[ҽ������ҵ�ɷѶ�] [decimal](26, 2) NOT NULL ,
	[ҽ������ҵ�������] [decimal](26, 2) NOT NULL ,
	[ҽ������ҵ�����] [decimal](26, 2) NOT NULL ,
	[����ҽ������ҵ�ɷѱ���] [decimal](26, 2) NOT NULL ,
	[����ҽ������ҵ�ɷѶ�] [decimal](26, 2) NOT NULL ,
	[ʧҵ����ҵ�ɷѱ���] [decimal](26, 2) NOT NULL ,
	[ʧҵ����ҵ�ɷѶ�] [decimal](26, 2) NOT NULL ,
	[��������ҵ�ɷѱ���] [decimal](26, 2) NOT NULL ,
	[��������ҵ�ɷѶ�] [decimal](26, 2) NOT NULL ,
	[��������ҵ�ɷѱ���] [decimal](26, 2) NOT NULL ,
	[��������ҵ�ɷѶ�] [decimal](26, 2) NOT NULL ,
	[������ɷѻ���] [decimal](26, 2) NOT NULL ,
	[��������˽ɷѱ���] [decimal](26, 2) NOT NULL ,
	[��������˽ɷѶ�] [decimal](26, 2) NOT NULL ,
	[��������ҵ�ɷѱ���] [decimal](26, 2) NOT NULL ,
	[��������ҵ�ɷѶ�] [decimal](26, 2) NOT NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[���������Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[�������] [varchar] (20) NULL ,
	[������ʱ��] [int] NULL ,
	[�����ݺ����ܼ���] [varchar] (50) NULL ,
	[�����ݷ�֧����λ] [varchar] (100) NULL ,
	[�����ݺ����λ] [varchar] (100) NULL ,
	[��ذ���] [varchar] (50) NULL ,
	[��Ƹ���] [varchar] (50) NULL ,
	[��ذ���ʱ��] [int] NULL ,
	[�μӸ���] [varchar] (50) NULL ,
	[����������ʱ��] [int] NULL ,
	[�����ݷ�] [decimal](28, 2) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
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
	[��λ���] [varchar] (20) NOT NULL ,
	[��λ����] [varchar] (100) NULL ,
	[ƴ������] [varchar] (50) NULL ,
	[��������] [varchar] (6) NULL ,
	[��λ��ַ] [varchar] (100) NULL ,
	[��λ�绰����] [varchar] (50) NULL ,
	[��λ�����] [varchar] (50) NULL ,
	[��λ�籨��] [varchar] (10) NULL ,
	[��λ���ڵ�] [varchar] (50) NULL ,
	[������ϵ] [varchar] (50) NULL ,
	[��λ����] [varchar] (50) NULL ,
	[���ܵ�λ����] [varchar] (100) NULL ,
	[��λ����] [varchar] (50) NULL ,
	[��������] [varchar] (50) NULL ,
	[������ҵ] [varchar] (50) NULL ,
	[��ҵ����] [varchar] (20) NULL ,
	[��λ������] [varchar] (30) NULL ,
	[������ϵ] [varchar] (50) NULL ,
	[��������] [varchar] (50) NULL ,
	[��λ���ڹ���] [varchar] (50) NULL ,
	[��ҵ����] [varchar] (50) NULL ,
	[��λ����] [varchar] (30) NULL ,
	[��λ���] [varchar] (50) NULL ,
	[���ƴ��] [varchar] (25) NULL ,
	[��������] [varchar] (50) NULL ,
	[��������] [varchar] (100) NULL ,
	[�ʺ�] [varchar] (50) NULL ,
	[����ȫ��] [varchar] (100) NULL ,
	[��ϵ��] [varchar] (50) NULL ,
	[�Ǽ�ע������] [varchar] (50) NULL ,
	[��ᱣ�յǼ�֤��] [varchar] (50) NULL ,
	[ʧҵ���սɷ���ʼʱ��] [int] NULL ,
	[�ɷ���ֹʱ��] [int] NULL ,
	[��ע] [varchar] (100) NULL ,
	[xx] [varchar] (50) NULL ,
	[����Ա] [varchar] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[���ò�����ͬ] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[��ͬ���] [varchar] (60) NULL ,
	[��ְǰ����] [varchar] (100) NULL ,
	[��ְǰְ��] [varchar] (100) NULL ,
	[��ְ����] [int] NULL ,
	[��ְԭ��] [varchar] (200) NULL ,
	[�����] [varchar] (100) NULL ,
	[��������] [decimal](26, 2) NULL ,
	[ÿ����] [decimal](26, 2) NULL ,
	[�ܽ��] [decimal](26, 2) NULL ,
	[��������] [varchar] (200) NULL ,
	[�������] [varchar] (200) NULL ,
	[������] [char] (10) NULL ,
	[������] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��Ч���˱�] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [char] (10) NOT NULL ,
	[��������] [varchar] (20) NULL ,
	[���˿�ʼ����] [int] NULL ,
	[���˽�������] [int] NULL ,
	[����Ʒ��] [int] NULL ,
	[��������] [int] NULL ,
	[����֪ʶ] [int] NULL ,
	[������] [int] NULL ,
	[����] [int] NULL ,
	[������] [int] NULL ,
	[ѧϰ����] [int] NULL ,
	[����] [int] NULL ,
	[�ۺ�����] [int] NULL ,
	[���˷ֵȼ�] [int] NULL ,
	[�����쵼���] [varchar] (50) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ְ���ʵ�����] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[��������] [float] NOT NULL ,
	[����ԭ��] [varchar] (100) NULL ,
	[��������] [int] NULL ,
	[�������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ְԱ��Ҫ��ϵ����Ϣ��] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[��ϵ������] [varchar] (20) NOT NULL ,
	[��ϵ����] [varchar] (20) NOT NULL ,
	[��Ա��������] [int] NULL ,
	[������λ��ְ��] [varchar] (100) NULL ,
	[��Ա������ò] [varchar] (20) NULL ,
	[��Ա�Ļ��̶�] [varchar] (20) NULL ,
	[��ϵ������] [varchar] (100) NULL ,
	[�칫�绰] [varchar] (50) NULL ,
	[�ֻ�] [varchar] (50) NULL ,
	[�����ʼ���ַ] [varchar] (50) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ְԱ������Ϣ��] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[����] [varchar] (20) NOT NULL ,
	[��������] [varchar] (10) NULL ,
	[������] [varchar] (30) NULL ,
	[�Ա�] [varchar] (2) NULL ,
	[��������] [int] NULL ,
	[����] [varchar] (50) NULL ,
	[������] [varchar] (100) NULL ,
	[����] [varchar] (20) NULL ,
	[�Ļ��̶�] [char] (50) NULL ,
	[��ҵѧУ] [char] (100) NULL ,
	[����״��] [varchar] (50) NULL ,
	[����״��] [varchar] (10) NULL ,
	[ְԱ����] [varchar] (30) NULL ,
	[����ְ����] [char] (100) NULL ,
	[ְ��] [char] (50) NULL ,
	[���˳ɷ�] [varchar] (20) NULL ,
	[�μӹ���ʱ��] [int] NULL ,
	[���뱾ϵͳ����ʱ��] [int] NULL ,
	[�������ʼʱ��] [int] NULL ,
	[��������] [int] NULL ,
	[�ù���ʽ] [varchar] (20) NULL ,
	[�ù�����] [varchar] (20) NULL ,
	[������ò] [varchar] (20) NULL ,
	[�μӵ���ʱ��] [int] NULL ,
	[ְҵ���] [varchar] (40) NULL ,
	[�ִ���רҵ] [varchar] (40) NULL ,
	[���ܴ�������] [varchar] (40) NULL ,
	[�������ڵ�] [varchar] (50) NULL ,
	[��������] [varchar] (10) NULL ,
	[���֤����] [varchar] (18) NULL ,
	[�۰�̨������ʶ] [varchar] (20) NULL ,
	[�ɲ�¼Ƹ����Դ] [varchar] (20) NULL ,
	[�ɲ�ѡƸ������λ] [varchar] (50) NULL ,
	[�ɲ�¼Ƹʱ��] [int] NULL ,
	[��Ա��ʽ] [varchar] (20) NULL ,
	[��Աʱ��] [int] NULL ,
	[����Ա¼����Դ] [varchar] (40) NULL ,
	[����Ա���⿼�Ա�ʶ] [varchar] (20) NULL ,
	[���������ʶ] [varchar] (20) NULL ,
	[����Ա¼��ʱ��] [int] NULL ,
	[�������ű��] [char] (10) NOT NULL ,
	[����] [int] NULL ,
	[��ְ��ʽ] [varchar] (30) NULL ,
	[Ƹ������] [int] NULL ,
	[ת��ʱ��] [int] NULL ,
	[������λ] [varchar] (50) NULL ,
	[��ᱣ�Ϻ���] [varchar] (30) NULL ,
	[�����ļ�] [varchar] (50) NULL ,
	[��Ƭ�ļ�] [varchar] (50) NULL ,
	[��ͥ��ַ] [varchar] (100) NULL ,
	[�ʱ�] [varchar] (20) NULL ,
	[��ͥ�绰] [varchar] (50) NULL ,
	[�칫�绰] [varchar] (50) NULL ,
	[�ֻ�] [varchar] (50) NULL ,
	[Ѱ����] [varchar] (50) NULL ,
	[�����ʼ���ַ] [varchar] (50) NULL ,
	[��������] [varchar] (200) NULL ,
	[����֤������] [varchar] (20) NULL ,
	[ְ���˺�] [varchar] (20) NULL ,
	[��λ���] [varchar] (20) NULL, 
	[��ע] [varchar] (100) NULL ,
	[�Ƿ�ִҵҩʦ] [char] (10) NULL ,
	[�������] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ְԱ������] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[��������] [varchar] (20) NULL ,
	[�������] [float] NULL ,
	[�Ƿ���빤��] [char] (10) NULL ,
	[����ԭ��] [varchar] (50) NULL ,
	[�������] [varchar] (100) NULL ,
	[��������] [int] NULL ,
	[�������] [char] (10) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ְԱ������Ŀ��] (
	[ְԱ���] [varchar] (30) NOT NULL ,
	[��������] [float] NULL ,
	[ְ����] [float] NULL ,
	[���乤��] [float] NULL ,
	[���˹���] [float] NULL ,
	[�Ӱ��] [float] NULL ,
	[��۽���] [float] NULL ,
	[��ͨ����] [float] NULL ,
	[��ʳ����] [float] NULL ,
	[ҽ�Ʋ���] [float] NULL ,
	[���½���] [float] NULL ,
	[����] [float] NULL ,
	[����] [float] NULL ,
	[Ӧ�����ϼ�] [float] NULL ,
	[����] [float] NULL ,
	[ˮ���] [float] NULL ,
	[��ٿ۳�] [float] NULL ,
	[���ڿ۳�] [float] NULL ,
	[����] [float] NULL ,
	[�����] [float] NULL ,
	[ס��������] [float] NULL ,
	[ҽ�Ʊ���] [float] NULL ,
	[���ϱ���] [float] NULL ,
	[ʧҵ����] [float] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ְԱ�ͷ���] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[�ͷ�����] [varchar] (20) NULL ,
	[�ͷ����] [float] NULL ,
	[�Ƿ���빤��] [char] (10) NULL ,
	[�ͷ�ԭ��] [varchar] (50) NULL ,
	[�������] [varchar] (100) NULL ,
	[�ͷ�����] [int] NULL ,
	[�������] [char] (10) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ְԱ��ְ�ǼǱ�] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[��ְǰ����] [varchar] (100) NULL ,
	[��ְǰְ��] [varchar] (100) NULL ,
	[��ְ����] [int] NULL ,
	[��ְԭ��] [varchar] (200) NULL ,
	[��ְ��������] [varchar] (50) NULL ,
	[�����������] [varchar] (200) NULL ,
	[�������] [varchar] (20) NULL ,
	[�������] [char] (10) NULL ,
	[����������] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ְԱ������Ϣ��] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[����] [int] NULL ,
	[ְԱ���] [char] (10) NOT NULL ,
	[�ϰ�ˢ��ʱ��] [datetime] NULL ,
	[�°�ˢ��ʱ��] [datetime] NULL ,
	[��������] [char] (10) NULL ,
	[�Ƿ�ٵ�] [char] (10) NULL ,
	[�Ƿ�����] [char] (10) NULL ,
	[�Ƿ��] [char] (10) NULL ,
	[�ٵ�ʱ��] [int] NULL ,
	[����ʱ��] [int] NULL ,
	[�Ӱ�ʱ��] [int] NULL ,
	[�������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ְ��������Ϣ�Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[�μӱ�������] [varchar] (100) NULL ,
	[�������㷽ʽ] [varchar] (50) NULL ,
	[�ɷѻ���] [decimal](26, 2) NULL ,
	[����֧������] [decimal](26, 2) NULL ,
	[���˽ɷѶ�] [decimal](26, 2) NULL ,
	[��ҵ֧������] [decimal](26, 2) NULL ,
	[��ҵ�ɷѶ�] [decimal](26, 2) NULL ,
	[��ʼ�ɷ�����] [int] NULL ,
	[�ۼƽɷ�ʱ��] [int] NULL ,
	[�ɷ��ж�ʱ��] [int] NULL ,
	[�ɷ��ж�ԭ��] [varchar] (100) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Ƹ�κ�ͬ�б�] (
	[Ƹ�κ�ͬ���] [char] (10) NOT NULL ,
	[Ƹ�κ�ͬ���λ��] [varchar] (50) NULL ,
	[Ƹ�κ�ͬ��Ч����] [int] NULL ,
	[Ƹ�κ�ͬ��������] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��������ְ���Ӽ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[���] [varchar] (14) NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[ְ����] [varchar] (10) NULL ,
	[ְ�����] [varchar] (10) NULL ,
	[ְ������] [varchar] (100) NOT NULL ,
	[��ְʱ��] [int] NULL ,
	[��ְ��λ] [varchar] (100) NOT NULL ,
	[��ְ��ʽ] [varchar] (20) NULL ,
	[��ְԭ��] [varchar] (40) NULL ,
	[��ְ�ĺ�] [varchar] (24) NULL ,
	[ְ�񼶱�] [varchar] (20) NULL ,
	[ְλ����] [varchar] (40) NULL ,
	[��ְ��׼��λ] [varchar] (70) NULL ,
	[ְ��䶯���] [varchar] (20) NULL ,
	[��ǰ��ְ״��] [varchar] (20) NULL ,
	[���ܻ���¹���] [varchar] (40) NULL ,
	[��ְʱ��] [int] NULL ,
	[��ְ��ʽ] [varchar] (20) NULL ,
	[��ְԭ��] [varchar] (40) NULL ,
	[��ְ�ĺ�] [varchar] (24) NULL ,
	[��ְ��׼��λ] [varchar] (100) NULL ,
	[ְ����Чʱ��] [int] NULL ,
	[��ְԭ��] [varchar] (40) NULL ,
	[����һ����ְ����] [varchar] (40) NULL ,
	[ְ������] [varchar] (20) NULL ,
	[ְԱ�ȼ�] [varchar] (20) NULL ,
	[��ע] [varchar] (100) NULL ,
	[�������] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[���������ڽ���] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[�������] [varchar] (20) NULL ,
	[��������] [varchar] (100) NULL ,
	[����ԭ��] [varchar] (100) NULL ,
	[����ʱ��] [int] NULL ,
	[������׼��λ] [varchar] (100) NULL ,
	[�����ƺ�����] [varchar] (100) NULL ,
	[�����ƺ����赥λ] [varchar] (100) NULL ,
	[����ȡ�����] [varchar] (100) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[���������ڳͷ�] (
	[�ڲ����] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[�������] [varchar] (20) NULL ,
	[��������] [varchar] (100) NULL ,
	[����ԭ��] [varchar] (100) NULL ,
	[�ܴ���ʱ��] [int] NULL ,
	[�ܴ��ָ��赥λ] [varchar] (100) NULL ,
	[��������ʱ��] [int] NULL ,
	[������ֱ�Ӹ����־] [varchar] (20) NULL ,
	[�ͷ�ȡ�����] [varchar] (100) NULL ,
	[��ע] [char] (100) NULL ,
	[����Ա] [char] (10) NULL ,
	[�޸ı��] [char] (1) NULL ,
	[�޸�����] [int] NULL ,
	[���յǼ�] [binary] (30) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[֤���ǼǱ�] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [varchar] (30) NOT NULL ,
	[֤������] [varchar] (20) NOT NULL ,
	[֤�����] [char] (10) NOT NULL ,
	[��֤ʱ��] [int] NULL ,
	[֤����Ч��] [int] NULL ,
	[�������ڼ��] [int] NULL ,
	[�����������] [int] NULL ,
	[�������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[�����ʷ��] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [char] (10) NOT NULL ,
	[�������] [varchar] (20) NULL ,
	[�������] [int] NULL ,
	[��ٿ�ʼʱ��] [int] NULL ,
	[��ٽ���ʱ��] [int] NULL ,
	[���ʱ��] [varchar] (20) NULL ,
	[���ԭ��] [varchar] (200) NULL ,
	[�������] [varchar] (20) NULL ,
	[�������] [char] (10) NULL ,
	[����������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[��������] (
	[���] [int] IDENTITY (1, 1) NOT NULL ,
	[ְԱ���] [char] (10) NOT NULL ,
	[�������] [varchar] (20) NULL ,
	[�������] [int] NULL ,
	[��ٿ�ʼʱ��] [int] NULL ,
	[��ٽ���ʱ��] [int] NULL ,
	[���ʱ��] [varchar] (20) NULL ,
	[���ԭ��] [varchar] (200) NULL ,
	[�������] [varchar] (20) NULL ,
	[�������] [char] (10) NULL ,
	[����������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ת����ʽԱ���ǼǱ�] (
	[ӦƸ�˱��] [varchar] (10) NOT NULL ,
	[ְԱ���] [varchar] (30) NULL ,
	[֤������] [varchar] (50) NULL ,
	[ְ���˺�] [varchar] (20) NULL ,
	[Ƹ������] [int] NULL ,
	[�����绰] [varchar] (50) NULL ,
	[Ƹ�κ�ͬ���] [varchar] (60) NULL ,
	[�Ƿ�תΪ��ʽԱ��] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[������ʷ��] (
	[ӦƸ�˱��] [varchar] (10) NOT NULL ,
	[��ѡ����] [varchar] (50) NULL ,
	[�������] [varchar] (50) NULL ,
	[����״��] [varchar] (50) NULL ,
	[����Ӧ����] [varchar] (50) NULL ,
	[�����ְ���˽�̶�] [varchar] (50) NULL ,
	[�侭���뱾��˾��ϳ̶�] [varchar] (50) NULL ,
	[��������] [varchar] (50) NULL ,
	[�ۺ�����] [varchar] (50) NULL ,
	[¼�����] [char] (10) NULL ,
	[���Եص�] [varchar] (50) NULL ,
	[������] [char] (10) NULL ,
	[��������] [int] NULL ,
	[�������] [char] (10) NULL ,
	[����������] [char] (10) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[����������] (
	[ӦƸ�˱��] [varchar] (10) NOT NULL ,
	[��ѡ����] [varchar] (50) NULL ,
	[�������] [varchar] (50) NULL ,
	[����״��] [varchar] (50) NULL ,
	[����Ӧ����] [varchar] (50) NULL ,
	[�����ְ���˽�̶�] [varchar] (50) NULL ,
	[�侭���뱾��˾��ϳ̶�] [varchar] (50) NULL ,
	[��������] [varchar] (50) NULL ,
	[�ۺ�����] [varchar] (50) NULL ,
	[¼�����] [char] (10) NULL ,
	[���Եص�] [varchar] (50) NULL ,
	[������] [char] (10) NULL ,
	[��������] [int] NULL ,
	[�������] [char] (10) NULL ,
	[����������] [char] (10) NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[רҵ����ְ���Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__רҵ����ְ���Ӽ�__�޸ı��__26509D48] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__רҵ����ְ���Ӽ�__���յǼ�__2744C181] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[������Ȼ���̨���Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__������Ȼ���̨���Ӽ�__�޸ı��__0915401C] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__������Ȼ���̨���Ӽ�__���յǼ�__0A096455] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[��������˰��] WITH NOCHECK ADD 
	CONSTRAINT [DF_��������˰��_����˰����] DEFAULT (800) FOR [����˰����],
	CONSTRAINT [DF_��������˰��_����˰��͹���] DEFAULT (0) FOR [��������],
	CONSTRAINT [DF__��������˰��__���¹���__640DD89F] DEFAULT (0) FOR [��������],
	CONSTRAINT [DF__��������˰��__��������˰��__6501FCD8] DEFAULT (0) FOR [��������˰��],
	CONSTRAINT [DF_��������˰��_����۳���] DEFAULT (0) FOR [����۳���],
	CONSTRAINT [DF_��������˰��_�޸ı��] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF_��������˰��_���յǼ�] DEFAULT (0) FOR [���յǼ�],
	CONSTRAINT [PK_��������˰��] PRIMARY KEY  CLUSTERED 
	(
		[�ڲ����]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[���˼����Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__���˼����Ӽ�__�޸ı��__7C5A637C] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__���˼����Ӽ�__���յǼ�__7D4E87B5] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[��Ҫ���������Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__��Ҫ���������Ӽ�__�޸ı��__48A5B54C] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__��Ҫ���������Ӽ�__���յǼ�__4999D985] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[���±����ʷ��] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[���]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ס���������Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__ס���������Ӽ�__�޸ı��__71FCD09A] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__ס���������Ӽ�__���յǼ�__72F0F4D3] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[���ϱ�����Ϣ�Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__���ϱ�����Ϣ�Ӽ�__�޸ı��__7DA38D70] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__���ϱ�����Ϣ�Ӽ�__���յǼ�__7E97B1A9] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[����ְ���Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__����ְ���Ӽ�__�޸ı��__1CC7330E] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__����ְ���Ӽ�__���յǼ�__1DBB5747] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[��ת�ɲ��Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__��ת�ɲ��Ӽ�__�޸ı��__5046D714] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__��ת�ɲ��Ӽ�__���յǼ�__513AFB4D] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[�Ͷ������Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__�Ͷ������Ӽ�__�޸ı��__33FF9E21] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__�Ͷ������Ӽ�__���յǼ�__34F3C25A] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[ҽ�Ʊ����Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__ҽ�Ʊ����Ӽ�__�޸ı��__76026BA8] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__ҽ�Ʊ����Ӽ�__���յǼ�__76F68FE1] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[��λ��Ա�����Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__��λ��Ա�����Ӽ�__�޸ı��__1372D2FE] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__��λ��Ա�����Ӽ�__���յǼ�__1466F737] DEFAULT (0) FOR [���յǼ�],
	 PRIMARY KEY  CLUSTERED 
	(
		[��λ���]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[��λ��ͳ��Ϣ�Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__��λ��ͳ��Ϣ�Ӽ�__�޸ı��__4BD727B2] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__��λ��ͳ��Ϣ�Ӽ�__���յǼ�__4CCB4BEB] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[��λ�¶Ȼ���̨���Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__��λ�¶Ȼ���̨���Ӽ�__�޸ı��__10B661E4] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__��λ�¶Ȼ���̨���Ӽ�__���յǼ�__11AA861D] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[��λ��������Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__��λ��������Ӽ�__�޸ı��__0DB9F9A8] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__��λ��������Ӽ�__���յǼ�__0EAE1DE1] DEFAULT (0) FOR [���յǼ�],
	 PRIMARY KEY  CLUSTERED 
	(
		[��λ���]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[��ͬ�䶯�Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__��ͬ�䶯�Ӽ�__�޸ı��__1D1C38C9] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__��ͬ�䶯�Ӽ�__���յǼ�__1E105D02] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[��ͬ�����Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__��ͬ�����Ӽ�__�޸ı��__157B1701] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__��ͬ�����Ӽ�__���յǼ�__166F3B3A] DEFAULT (0) FOR [���յǼ�],
	 PRIMARY KEY  CLUSTERED 
	(
		[��ͬ���]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[��ͬ��ֹ�Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__��ͬ��ֹ�Ӽ�__�޸ı��__288DEB75] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__��ͬ��ֹ�Ӽ�__���յǼ�__29820FAE] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[��ͬ��ǩ�Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__��ͬ��ǩ�Ӽ�__�޸ı��__20ECC9AD] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__��ͬ��ǩ�Ӽ�__���յǼ�__21E0EDE6] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[��ͬ�����Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__��ͬ�����Ӽ�__�޸ı��__194BA7E5] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__��ͬ�����Ӽ�__���յǼ�__1A3FCC1E] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[��ͬ����Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__��ͬ����Ӽ�__�޸ı��__24BD5A91] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__��ͬ����Ӽ�__���յǼ�__25B17ECA] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[�������ϱ��շ��б�] WITH NOCHECK ADD 
	CONSTRAINT [PK_�������ϱ��շ��б�] PRIMARY KEY  CLUSTERED 
	(
		[ְ�����]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[����ҽ�Ʊ��շ��б�] WITH NOCHECK ADD 
	CONSTRAINT [PK_����ҽ�Ʊ��շ��б�] PRIMARY KEY  CLUSTERED 
	(
		[ְ�����]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ʧҵ������Ϣ�Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__ʧҵ������Ϣ�Ӽ�__�޸ı��__302F0D3D] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__ʧҵ������Ϣ�Ӽ�__���յǼ�__31233176] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[ʧҵ���շ��б�] WITH NOCHECK ADD 
	CONSTRAINT [PK_ʧҵ���շ��б�] PRIMARY KEY  CLUSTERED 
	(
		[ְ�����]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ѧ����ѧλ�Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__ѧ����ѧλ�Ӽ�__���յǼ�__6E0C4425] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[��λ����Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__��λ����Ӽ�__�޸ı��__69C77D4C] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__��λ����Ӽ�__���յǼ�__6ABBA185] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[����ͳ����ʷ��] WITH NOCHECK ADD 
	CONSTRAINT [DF__����ͳ����ʷ��__�޸ı��__3C5FD9F8] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__����ͳ����ʷ��__���յǼ�__3D53FE31] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[�ɲ������뽻���Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__�ɲ������뽻���Ӽ�__�޸ı��__18F6A22A] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__�ɲ������뽻���Ӽ�__���յǼ�__19EAC663] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[ӦƸ��Ա¼�ñ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__ӦƸ��Ա¼�ñ�__�Ƿ�ת��ְԱ��__2AA05119] DEFAULT ('��') FOR [�Ƿ�ת��ְԱ��],
	CONSTRAINT [PK_ӦƸ��Ա¼�ñ�] PRIMARY KEY  CLUSTERED 
	(
		[ӦƸ�˱��]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ӦƸ��Ա�ǼǱ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__ӦƸ��Ա�ǼǱ�__�Ա�__2C88998B] DEFAULT ('��') FOR [�Ա�],
	CONSTRAINT [DF__ӦƸ��Ա�ǼǱ�__����״��__2D7CBDC4] DEFAULT ('δ��') FOR [����״��],
	CONSTRAINT [PK_ӦƸ��Ա�ǼǱ�] PRIMARY KEY  CLUSTERED 
	(
		[ӦƸ�˱��]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[���¼Ӱ���б�] WITH NOCHECK ADD 
	CONSTRAINT [PK_���¼Ӱ���б�] PRIMARY KEY  CLUSTERED 
	(
		[ְԱ���]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[���¿��˹����б�] WITH NOCHECK ADD 
	CONSTRAINT [PK_���¿��˹����б�] PRIMARY KEY  CLUSTERED 
	(
		[ְԱ���]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[��Ƹ��ѡ������] WITH NOCHECK ADD 
	CONSTRAINT [DF__��Ƹ��ѡ������__��ѡ״̬__351DDF8C] DEFAULT ('δѡ') FOR [��ѡ״̬],
	CONSTRAINT [PK_��Ƹ��ѡ������] PRIMARY KEY  CLUSTERED 
	(
		[ӦƸ�˱��]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[��Ƹ�����] WITH NOCHECK ADD 
	CONSTRAINT [DF_��Ƹ�����_���յǼ�] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[��Ƹ�ƻ���] WITH NOCHECK ADD 
	CONSTRAINT [DF__��Ƹ�ƻ���__����Ƹ����__3AD6B8E2] DEFAULT (0) FOR [����Ƹ����],
	CONSTRAINT [PK_��Ƹ�ƻ���] PRIMARY KEY  CLUSTERED 
	(
		[��Ƹ�ƻ����]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[������ò���������] WITH NOCHECK ADD 
	CONSTRAINT [DF__������ò���������__�޸ı��__33AA9866] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__������ò���������__���յǼ�__349EBC9F] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[��������֤���б�] WITH NOCHECK ADD 
	CONSTRAINT [PK_��������֤���б�] PRIMARY KEY  CLUSTERED 
	(
		[ְԱ���]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[�¹���ͳ�Ʊ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__�¹���ͳ�Ʊ�__�޸ı��__39836D4D] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__�¹���ͳ�Ʊ�__���յǼ�__3A779186] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[�¿��ڻ��ܱ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__�¿��ڻ��ܱ�__�ٵ�����__7F80E8EA] DEFAULT (0) FOR [�ٵ�����],
	CONSTRAINT [DF__�¿��ڻ��ܱ�__���˴���__00750D23] DEFAULT (0) FOR [���˴���],
	CONSTRAINT [DF__�¿��ڻ��ܱ�__�󹤴���__0169315C] DEFAULT (0) FOR [�󹤴���],
	CONSTRAINT [DF__�¿��ڻ��ܱ�__��ٴ���__025D5595] DEFAULT (0) FOR [��ٴ���],
	CONSTRAINT [DF__�¿��ڻ��ܱ�__�Ӱ�ʱ��__035179CE] DEFAULT (0) FOR [�Ӱ�ʱ��]
GO

ALTER TABLE [dbo].[�������ñ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__�������ñ�__�޸ı��__749A117A] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__�������ñ�__���յǼ�__758E35B3] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[�����б�] WITH NOCHECK ADD 
	CONSTRAINT [DF__�����б�__�޸ı��__786AA25E] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__�����б�__���յǼ�__795EC697] DEFAULT (0) FOR [���յǼ�],
	 PRIMARY KEY  CLUSTERED 
	(
		[�������]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[��������ǼǱ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__��������ǼǱ�__�޸ı��__542D41E8] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__��������ǼǱ�__���յǼ�__55216621] DEFAULT (0) FOR [���յǼ�],
	 PRIMARY KEY  CLUSTERED 
	(
		[�������]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[������ѯ�����] WITH NOCHECK ADD 
	CONSTRAINT [DF__������ѯ�����__�������__5C37ACAD] DEFAULT ('δ��') FOR [�������]
GO

ALTER TABLE [dbo].[����ת����] WITH NOCHECK ADD 
	CONSTRAINT [DF__����ת����__�޸ı��__71BDA4CF] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__����ת����__���յǼ�__72B1C908] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[����������Ϣ�Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__����������Ϣ�Ӽ�__�޸ı��__01741E54] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__����������Ϣ�Ӽ�__���յǼ�__0268428D] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[�û��嵥] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[�û����]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[��ᱣ���Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF_��ᱣ���Ӽ�_�ɷѻ���] DEFAULT (0) FOR [�ɷѻ���],
	CONSTRAINT [DF_��ᱣ���Ӽ�_�����ո��˽ɷѱ���] DEFAULT (0) FOR [�����ո��˽ɷѱ���],
	CONSTRAINT [DF_��ᱣ���Ӽ�_�����ո��˽ɷѶ�] DEFAULT (0) FOR [�����ո��˽ɷѶ�],
	CONSTRAINT [DF_��ᱣ���Ӽ�_ҽ���ո��˽ɷѱ���] DEFAULT (0) FOR [ҽ���ո��˽ɷѱ���],
	CONSTRAINT [DF_��ᱣ���Ӽ�_ҽ���ո��˽ɷѶ�] DEFAULT (0) FOR [ҽ���ո��˽ɷѶ�],
	CONSTRAINT [DF_��ᱣ���Ӽ�_����ҽ���ո��˽ɷѶ�] DEFAULT (0) FOR [����ҽ���ո��˽ɷѶ�],
	CONSTRAINT [DF_��ᱣ���Ӽ�_ʧҵ�ո��˽ɷѱ���] DEFAULT (0) FOR [ʧҵ�ո��˽ɷѱ���],
	CONSTRAINT [DF_��ᱣ���Ӽ�_ʧҵ�ո��˽ɷѶ�] DEFAULT (0) FOR [ʧҵ�ո��˽ɷѶ�],
	CONSTRAINT [DF_��ᱣ���Ӽ�_�����ո��˽ɷѱ���] DEFAULT (0) FOR [�����ո��˽ɷѱ���],
	CONSTRAINT [DF_��ᱣ���Ӽ�_�����ո��˽ɷѶ�] DEFAULT (0) FOR [�����ո��˽ɷѶ�],
	CONSTRAINT [DF_��ᱣ���Ӽ�_�����ո��˽ɷѱ���] DEFAULT (0) FOR [�����ո��˽ɷѱ���],
	CONSTRAINT [DF_��ᱣ���Ӽ�_�����ո��˽ɷѶ�] DEFAULT (0) FOR [�����ո��˽ɷѶ�],
	CONSTRAINT [DF_��ᱣ���Ӽ�_��������ҵ�ɷѱ���] DEFAULT (0) FOR [��������ҵ�ɷѱ���],
	CONSTRAINT [DF_��ᱣ���Ӽ�_��������ҵ�ɷѶ�] DEFAULT (0) FOR [��������ҵ�ɷѶ�],
	CONSTRAINT [DF_��ᱣ���Ӽ�_��������ҵ�������] DEFAULT (0) FOR [��������ҵ�������],
	CONSTRAINT [DF_��ᱣ���Ӽ�_��������ҵ�����] DEFAULT (0) FOR [��������ҵ�����],
	CONSTRAINT [DF_��ᱣ���Ӽ�_ҽ������ҵ�ɷѱ���] DEFAULT (0) FOR [ҽ������ҵ�ɷѱ���],
	CONSTRAINT [DF_��ᱣ���Ӽ�_ҽ������ҵ�ɷѶ�] DEFAULT (0) FOR [ҽ������ҵ�ɷѶ�],
	CONSTRAINT [DF_��ᱣ���Ӽ�_ҽ������ҵ�������] DEFAULT (0) FOR [ҽ������ҵ�������],
	CONSTRAINT [DF_��ᱣ���Ӽ�_ҽ������ҵ�����] DEFAULT (0) FOR [ҽ������ҵ�����],
	CONSTRAINT [DF_��ᱣ���Ӽ�_����ҽ������ҵ�ɷѱ���] DEFAULT (0) FOR [����ҽ������ҵ�ɷѱ���],
	CONSTRAINT [DF_��ᱣ���Ӽ�_����ҽ������ҵ�ɷѶ�] DEFAULT (0) FOR [����ҽ������ҵ�ɷѶ�],
	CONSTRAINT [DF_��ᱣ���Ӽ�_ʧҵ����ҵ�ɷѱ���] DEFAULT (0) FOR [ʧҵ����ҵ�ɷѱ���],
	CONSTRAINT [DF_��ᱣ���Ӽ�_ʧҵ����ҵ�ɷѶ�] DEFAULT (0) FOR [ʧҵ����ҵ�ɷѶ�],
	CONSTRAINT [DF_��ᱣ���Ӽ�_��������ҵ�ɷѱ���] DEFAULT (0) FOR [��������ҵ�ɷѱ���],
	CONSTRAINT [DF_��ᱣ���Ӽ�_��������ҵ�ɷѶ�] DEFAULT (0) FOR [��������ҵ�ɷѶ�],
	CONSTRAINT [DF_��ᱣ���Ӽ�_��������ҵ�ɷѱ���] DEFAULT (0) FOR [��������ҵ�ɷѱ���],
	CONSTRAINT [DF_��ᱣ���Ӽ�_��������ҵ�ɷѶ�] DEFAULT (0) FOR [��������ҵ�ɷѶ�],
	CONSTRAINT [DF_��ᱣ���Ӽ�_������ɷѻ���] DEFAULT (0) FOR [������ɷѻ���],
	CONSTRAINT [DF_��ᱣ���Ӽ�_��������˽ɷѱ���] DEFAULT (0) FOR [��������˽ɷѱ���],
	CONSTRAINT [DF_��ᱣ���Ӽ�_��������˽ɷѶ�] DEFAULT (0) FOR [��������˽ɷѶ�],
	CONSTRAINT [DF_��ᱣ���Ӽ�_��������ҵ�ɷѱ���] DEFAULT (0) FOR [��������ҵ�ɷѱ���],
	CONSTRAINT [DF_��ᱣ���Ӽ�_��������ҵ�ɷѶ�] DEFAULT (0) FOR [��������ҵ�ɷѶ�],
	CONSTRAINT [DF__��ᱣ���Ӽ�__�޸ı��__4AADF94F] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__��ᱣ���Ӽ�__���յǼ�__4BA21D88] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[���������Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__���������Ӽ�__�޸ı��__541767F8] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__���������Ӽ�__���յǼ�__550B8C31] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[��֯���������] WITH NOCHECK ADD 
	CONSTRAINT [DF__��֯���������__�޸ı��__75CD617E] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__��֯���������__���յǼ�__76C185B7] DEFAULT (0) FOR [���յǼ�],
	CONSTRAINT [PK_��֯���������] PRIMARY KEY  CLUSTERED 
	(
		[��λ���]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[���ò�����ͬ] WITH NOCHECK ADD 
	CONSTRAINT [DF__���ò�����ͬ__�޸ı��__6CF8EFB2] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__���ò�����ͬ__���յǼ�__6DED13EB] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[ְԱ��Ҫ��ϵ����Ϣ��] WITH NOCHECK ADD 
	CONSTRAINT [DF__ְԱ��Ҫ��ϵ����Ϣ��__�޸ı��__05E3CDB6] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__ְԱ��Ҫ��ϵ����Ϣ��__���յǼ�__06D7F1EF] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[ְԱ������Ϣ��] WITH NOCHECK ADD 
	CONSTRAINT [DF_ְԱ������Ϣ��_�Ƿ�ִҵҩʦ] DEFAULT ('��') FOR [�Ƿ�ִҵҩʦ],
	CONSTRAINT [DF__ְԱ������Ϣ��__�޸ı��__23A93AC7] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__ְԱ������Ϣ��__���յǼ�__249D5F00] DEFAULT (0) FOR [���յǼ�],
	CONSTRAINT [PK__ְԱ������Ϣ��__22B5168E] PRIMARY KEY  CLUSTERED 
	(
		[ְԱ���]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ְԱ������] WITH NOCHECK ADD 
	CONSTRAINT [DF__ְԱ������__�������__75035A77] DEFAULT (0) FOR [�������],
	CONSTRAINT [DF__ְԱ������__�Ƿ���빤��__75F77EB0] DEFAULT ('��') FOR [�Ƿ���빤��]
GO

ALTER TABLE [dbo].[ְԱ������Ŀ��] WITH NOCHECK ADD 
	CONSTRAINT [PK_ְԱ������Ŀ��] PRIMARY KEY  CLUSTERED 
	(
		[ְԱ���]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ְԱ�ͷ���] WITH NOCHECK ADD 
	CONSTRAINT [DF__ְԱ�ͷ���__�ͷ����__78D3EB5B] DEFAULT (0) FOR [�ͷ����],
	CONSTRAINT [DF__ְԱ�ͷ���__�Ƿ���빤��__79C80F94] DEFAULT ('��') FOR [�Ƿ���빤��]
GO

ALTER TABLE [dbo].[ְԱ��ְ�ǼǱ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__ְԱ��ְ�ǼǱ�__�޸ı��__5F49EED9] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__ְԱ��ְ�ǼǱ�__���յǼ�__603E1312] DEFAULT (0) FOR [���յǼ�],
	CONSTRAINT [PK_ְԱ��ְ�ǼǱ�] PRIMARY KEY  CLUSTERED 
	(
		[ְԱ���]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ְ��������Ϣ�Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__ְ��������Ϣ�Ӽ�__�޸ı��__5EB4F1FC] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__ְ��������Ϣ�Ӽ�__���յǼ�__5FA91635] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[Ƹ�κ�ͬ�б�] WITH NOCHECK ADD 
	CONSTRAINT [PK_Ƹ�κ�ͬ�б�] PRIMARY KEY  CLUSTERED 
	(
		[Ƹ�κ�ͬ���]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[��������ְ���Ӽ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__��������ְ���Ӽ�__�޸ı��__0D84EF7E] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__��������ְ���Ӽ�__���յǼ�__0E7913B7] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[���������ڽ���] WITH NOCHECK ADD 
	CONSTRAINT [DF__���������ڽ���__�޸ı��__41049384] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__���������ڽ���__���յǼ�__41F8B7BD] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[���������ڳͷ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__���������ڳͷ�__�޸ı��__44D52468] DEFAULT ('1') FOR [�޸ı��],
	CONSTRAINT [DF__���������ڳͷ�__���յǼ�__45C948A1] DEFAULT (0) FOR [���յǼ�]
GO

ALTER TABLE [dbo].[ת����ʽԱ���ǼǱ�] WITH NOCHECK ADD 
	CONSTRAINT [DF__ת����ʽԱ���ǼǱ�__�Ƿ�תΪ��__0CDAE408] DEFAULT ('��') FOR [�Ƿ�תΪ��ʽԱ��],
	CONSTRAINT [PK_ת����ʽԱ���ǼǱ�] PRIMARY KEY  CLUSTERED 
	(
		[ӦƸ�˱��]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[������ʷ��] WITH NOCHECK ADD 
	CONSTRAINT [PK_������ʷ��] PRIMARY KEY  CLUSTERED 
	(
		[ӦƸ�˱��]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[����������] WITH NOCHECK ADD 
	CONSTRAINT [DF__����������__¼�����__16644E42] DEFAULT ('δ��') FOR [¼�����]
GO

ALTER TABLE [dbo].[רҵ����ְ���Ӽ�] ADD 
	CONSTRAINT [רҵ����ְ���Ӽ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[������Ȼ���̨���Ӽ�] ADD 
	CONSTRAINT [������Ȼ���̨���Ӽ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[���˼����Ӽ�] ADD 
	CONSTRAINT [���˼����Ӽ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[��Ҫ���������Ӽ�] ADD 
	CONSTRAINT [��Ҫ���������Ӽ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[ס���������Ӽ�] ADD 
	CONSTRAINT [ס���������Ӽ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[���ϱ�����Ϣ�Ӽ�] ADD 
	CONSTRAINT [���ϱ�����Ϣ�Ӽ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[����ְ���Ӽ�] ADD 
	CONSTRAINT [����ְ���Ӽ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[��ת�ɲ��Ӽ�] ADD 
	CONSTRAINT [��ת�ɲ��Ӽ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[�Ͷ������Ӽ�] ADD 
	CONSTRAINT [�Ͷ������Ӽ�_�Ͷ���ͬ���_fk] FOREIGN KEY 
	(
		[��ͬ���]
	) REFERENCES [dbo].[��ͬ�����Ӽ�] (
		[��ͬ���]
	)
GO

ALTER TABLE [dbo].[ҽ�Ʊ����Ӽ�] ADD 
	CONSTRAINT [ҽ�Ʊ����Ӽ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[��ͬ�䶯�Ӽ�] ADD 
	CONSTRAINT [��ͬ�䶯�Ӽ�_�Ͷ���ͬ���_fk] FOREIGN KEY 
	(
		[��ͬ���]
	) REFERENCES [dbo].[��ͬ�����Ӽ�] (
		[��ͬ���]
	)
GO

ALTER TABLE [dbo].[��ͬ�����Ӽ�] ADD 
	CONSTRAINT [��ͬ�����Ӽ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[��ͬ��ֹ�Ӽ�] ADD 
	CONSTRAINT [��ͬ��ֹ�Ӽ�_�Ͷ���ͬ���_fk] FOREIGN KEY 
	(
		[��ͬ���]
	) REFERENCES [dbo].[��ͬ�����Ӽ�] (
		[��ͬ���]
	)
GO

ALTER TABLE [dbo].[��ͬ��ǩ�Ӽ�] ADD 
	CONSTRAINT [��ͬ��ǩ�Ӽ�_�Ͷ���ͬ���_fk] FOREIGN KEY 
	(
		[��ͬ���]
	) REFERENCES [dbo].[��ͬ�����Ӽ�] (
		[��ͬ���]
	)
GO

ALTER TABLE [dbo].[��ͬ�����Ӽ�] ADD 
	CONSTRAINT [��ͬ�����Ӽ�_�Ͷ���ͬ���_fk] FOREIGN KEY 
	(
		[��ͬ���]
	) REFERENCES [dbo].[��ͬ�����Ӽ�] (
		[��ͬ���]
	)
GO

ALTER TABLE [dbo].[��ͬ����Ӽ�] ADD 
	CONSTRAINT [��ͬ����Ӽ�_�Ͷ���ͬ���_fk] FOREIGN KEY 
	(
		[��ͬ���]
	) REFERENCES [dbo].[��ͬ�����Ӽ�] (
		[��ͬ���]
	)
GO

ALTER TABLE [dbo].[ʧҵ������Ϣ�Ӽ�] ADD 
	CONSTRAINT [ʧҵ������Ϣ�Ӽ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[ѧ����ѧλ�Ӽ�] ADD 
	CONSTRAINT [ѧ����ѧλ�Ӽ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[�ɲ������뽻���Ӽ�] ADD 
	CONSTRAINT [�ɲ������뽻���Ӽ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[������ò���������] ADD 
	CONSTRAINT [������ò���������_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[����������Ϣ�Ӽ�] ADD 
	CONSTRAINT [����������Ϣ�Ӽ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[��ᱣ���Ӽ�] ADD 
	CONSTRAINT [��ᱣ���Ӽ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[���������Ӽ�] ADD 
	CONSTRAINT [���������Ӽ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[ְԱ��Ҫ��ϵ����Ϣ��] ADD 
	CONSTRAINT [ְԱ��Ҫ��ϵ����Ϣ��_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[ְԱ��ְ�ǼǱ�] ADD 
	CONSTRAINT [FK_ְԱ��ְ�ǼǱ�_ְԱ������Ϣ��] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[ְ��������Ϣ�Ӽ�] ADD 
	CONSTRAINT [ְ��������Ϣ�Ӽ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[��������ְ���Ӽ�] ADD 
	CONSTRAINT [��������ְ���Ӽ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[���������ڽ���] ADD 
	CONSTRAINT [���������ڽ���_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO

ALTER TABLE [dbo].[���������ڳͷ�] ADD 
	CONSTRAINT [���������ڳͷ�_ְԱ���_fk] FOREIGN KEY 
	(
		[ְԱ���]
	) REFERENCES [dbo].[ְԱ������Ϣ��] (
		[ְԱ���]
	)
GO


--- ��ʼ������
insert into �û��嵥 values('1','ϵͳ����','sys','M','sys')
insert into �û��嵥 values('zs','�ɹ���','����','M','sys')
insert into �û��嵥 values('ls','���۲�','����','M','sys')
insert into �û��嵥 values('ww','����','����','M','sys')
go
