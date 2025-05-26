BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON


update config set id_sagra = '00000' 
where configkey='ip'
and id_sagra='001'

delete  config 
where configkey='ip'
and id_sagra <>'00000'

update config set id_sagra = '00000' 
where configSection='Inishared'
and id_sagra='001'

delete  config 
where configSection='Inishared'
and id_sagra <>'00000'